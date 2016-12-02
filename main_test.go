package main

import (
	"encoding/json"
	"io/ioutil"
	"net/http"
	"net/http/httptest"
	"os"
	"strings"
	"testing"

	"github.com/jmoiron/sqlx"

	"goji.io"
)

func startServer() *httptest.Server {
	mux := goji.NewMux()
	route(mux)
	ts := httptest.NewServer(mux)
	return ts
}

func parseResponse(res *http.Response) (string, int) {
	defer res.Body.Close()
	contents, err := ioutil.ReadAll(res.Body)
	if err != nil {
		panic(err)
	}
	return string(contents), res.StatusCode
}

func generateTestData() {
	tx := db.MustBegin()
	tx.MustExec("DELETE FROM android_libraries")
	tx.MustExec("INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.android.support:appcompat-v4', 'https://developer.android.com/topic/libraries/support-library/revisions.html', now(), now())")
	tx.MustExec("INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.squareup.retrofit2:retrofit', 'https://github.com/square/retrofit/blob/master/CHANGELOG.md',  now(), now())")
	tx.Commit()
}

func TestMain(m *testing.M) {
	db, _ = sqlx.Connect("postgres", "dbname=android-library-db_test sslmode=disable")
	defer db.Close()
	generateTestData()
	code := m.Run()
	defer os.Exit(code)
}

func Test_ReleaseNotes(t *testing.T) {
	ts := startServer()
	defer ts.Close()

	res, err := http.Get(ts.URL + "/release_notes?packages=com.android.support:appcompat-v4,com.squareup.retrofit2:retrofit,aaa&read=true")
	if err != nil {
		t.Error("unexpected", err)
	}

	c, s := parseResponse(res)
	if s != http.StatusOK {
		t.Error("invalid status code", s)
	}

	dec := json.NewDecoder(strings.NewReader(c))
	var releaseNotes []ReleaseNote
	dec.Decode(&releaseNotes)

	if len(releaseNotes) != 3 {
		t.Error("invalid response: ", c)
	}

	if releaseNotes[0].Package != "com.android.support:appcompat-v4" {
		t.Error("invalid package: ", releaseNotes[0].Package)
	}
	if releaseNotes[0].URL != "https://developer.android.com/topic/libraries/support-library/revisions.html" {
		t.Error("invalid url: ", releaseNotes[0].URL)
	}

	if releaseNotes[1].Package != "com.squareup.retrofit2:retrofit" {
		t.Error("invalid package: ", releaseNotes[1].Package)
	}
	if releaseNotes[1].URL != "https://github.com/square/retrofit/blob/master/CHANGELOG.md" {
		t.Error("invalid url: ", releaseNotes[1].URL)
	}

	if releaseNotes[2].Package != "aaa" {
		t.Error("invalid package: ", releaseNotes[2].Package)
	}
	if releaseNotes[2].URL != "" {
		t.Error("invalid url: ", releaseNotes[2].URL)
	}
}
