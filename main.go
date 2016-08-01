package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"

	"github.com/jmoiron/sqlx"
	"github.com/labstack/echo"
	"github.com/labstack/echo/engine/standard"
	_ "github.com/lib/pq"
)

var (
	db *sqlx.DB
)

func index(context echo.Context) error {
	return nil
}

func releaseNotes(context echo.Context) error {
	var pkgs string
	var url string
	var androidLibrary AndroidLibrary
	var releaseNotes []ReleaseNote

	pkgs = context.QueryParam("packages")
	if len(pkgs) == 0 {
		context.String(http.StatusBadRequest, http.StatusText(http.StatusBadRequest))
		fmt.Println("`packages` parameter not found")
		return nil
	}

	for _, pkg := range strings.Split(pkgs, ",") {
		url = ""
		err := db.Get(&androidLibrary, "SELECT * FROM android_libraries WHERE package = $1", pkg)

		if err != nil {
			fmt.Printf("select error %s\n", err)
		} else {
			if pkg == androidLibrary.Package {
				url = androidLibrary.Release_note_url
			}
		}
		releaseNotes = append(releaseNotes, ReleaseNote{Package: pkg, Url: url})
	}

	b, err := json.Marshal(releaseNotes)
	if err != nil {
		context.String(http.StatusBadRequest, http.StatusText(http.StatusBadRequest))
		fmt.Println(err)
		return err
	}

	context.String(http.StatusOK, string(b))
	return nil
}

func Route(echo *echo.Echo) {
	echo.Get("/", index)
	echo.Get("/release_notes", releaseNotes)
}

func main() {
	var err error
	db, err = sqlx.Connect("postgres", os.Getenv("DATABASE_URL"))
	if err != nil {
		log.Fatalln(err)
	}

	port := os.Getenv("PORT")
	if len(port) == 0 {
		port = "8080"
	}

	e := echo.New()
	Route(e)

	e.Run(standard.New(":" + port))
}
