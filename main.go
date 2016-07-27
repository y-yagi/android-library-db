package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
	"strings"

	"github.com/buaazp/fasthttprouter"
	"github.com/jmoiron/sqlx"
	_ "github.com/lib/pq"
	"github.com/valyala/fasthttp"
)

var (
	db *sqlx.DB
)

func Index(ctx *fasthttp.RequestCtx, _ fasthttprouter.Params) {
}

func ReleaseNotes(ctx *fasthttp.RequestCtx, ps fasthttprouter.Params) {
	var pkgs string
	var url string
	var androidLibrary AndroidLibrary
	var releaseNotes []ReleaseNote

	pkgs = string(ctx.QueryArgs().Peek("packages"))
	if len(pkgs) == 0 {
		return
	}

	db, _ := sqlx.Connect("postgres", os.Getenv("DATABASE_URL"))

	for _, pkg := range strings.Split(pkgs, ",") {
		url = ""
		_ = db.Get(&androidLibrary, "SELECT * FROM android_libraries WHERE package = $1", pkg)
		if pkg == androidLibrary.Package {
			url = androidLibrary.Release_note_url
		}
		releaseNotes = append(releaseNotes, ReleaseNote{Package: pkg, Url: url})
	}

	b, err := json.Marshal(releaseNotes)
	if err != nil {
		fmt.Println(err)
		return
	}

	fmt.Fprintf(ctx, "%s", b)
}

func main() {
	_, err := sqlx.Connect("postgres", os.Getenv("DATABASE_URL"))
	if err != nil {
		log.Fatalln(err)
	}

	router := fasthttprouter.New()
	router.GET("/", Index)
	router.GET("/release_notes", ReleaseNotes)

	log.Fatal(fasthttp.ListenAndServe(":8080", router.Handler))
}
