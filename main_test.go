package main

import (
	"bufio"
	"bytes"
	"encoding/json"
	"io/ioutil"
	"net"
	"net/http"
	"os"
	"strings"
	"testing"
	"time"

	"github.com/buaazp/fasthttprouter"
	"github.com/jmoiron/sqlx"
	"github.com/valyala/fasthttp"
)

type readWriter struct {
	net.Conn
	r bytes.Buffer
	w bytes.Buffer
}

func parseResponse(res *http.Response) (string, int) {
	defer res.Body.Close()
	contents, err := ioutil.ReadAll(res.Body)
	if err != nil {
		panic(err)
	}
	return string(contents), res.StatusCode
}

func generateTestData(db *sqlx.DB) {
	tx := db.MustBegin()
	tx.MustExec("DELETE FROM android_libraries")
	tx.MustExec("INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.android.support:appcompat-v4', 'https://developer.android.com/topic/libraries/support-library/revisions.html', now(), now())")
	tx.MustExec("INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.squareup.retrofit2:retrofit', 'https://github.com/square/retrofit/blob/master/CHANGELOG.md',  now(), now())")
	tx.Commit()
}

func TestMain(m *testing.M) {
	os.Setenv("DATABASE_URL", "dbname=android-library-db_test  sslmode=disable")
	db, _ := sqlx.Connect("postgres", "dbname=android-library-db_test  sslmode=disable")
	defer db.Close()
	generateTestData(db)
	code := m.Run()
	defer os.Exit(code)
}

func Test_SearchPages(t *testing.T) {
	router := fasthttprouter.New()
	Route(router)

	s := &fasthttp.Server{
		Handler: router.Handler,
	}

	rw := &readWriter{}
	rw.r.WriteString("GET //release_notes?packages=com.android.support:support-appcompat-v4,com.squareup.retrofit2:retrofit,aaa HTTP/1.1\r\n\r\n")

	ch := make(chan error)
	go func() {
		ch <- s.ServeConn(rw)
	}()

	select {
	case err := <-ch:
		if err != nil {
			t.Fatalf("return error %s", err)
		}
	case <-time.After(100 * time.Millisecond):
		t.Fatalf("timeout")
	}

	br := bufio.NewReader(&rw.w)
	var resp fasthttp.Response
	resp.Read(br)

	dec := json.NewDecoder(strings.NewReader(string(resp.Body())))
	var releaseNotes []ReleaseNote
	dec.Decode(&releaseNotes)

	if len(releaseNotes) != 3 {
		t.Error("invalid response: ")
	}

	if releaseNotes[0].Package != "com.android.support:appcompat-v4" {
		t.Error("invalid Package: ", releaseNotes[0].Package)
	}

	if releaseNotes[0].Url != "https://developer.android.com/topic/libraries/support-library/revisions.html" {
		t.Error("invalid Url: ", releaseNotes[0].Url)
	}

}
