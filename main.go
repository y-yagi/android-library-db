package main

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"

	goji "goji.io"
	"goji.io/pat"

	"golang.org/x/oauth2"

	raven "github.com/getsentry/raven-go"
	"github.com/google/go-github/github"
	"github.com/jmoiron/sqlx"
	_ "github.com/lib/pq"
)

var (
	db                *sqlx.DB
	githubAccessToken = os.Getenv("GITHUB_ACCESS_TOKEN")
)

func createIssueToGithub(unknownPkgs string) {
	var userName = "y-yagi"
	var repositoryName = "android-library-db"
	title := "detect unknown packages"

	ts := oauth2.StaticTokenSource(
		&oauth2.Token{AccessToken: githubAccessToken},
	)
	tc := oauth2.NewClient(oauth2.NoContext, ts)
	client := github.NewClient(tc)

	issueRequest := &github.IssueRequest{Title: &title, Body: &unknownPkgs}
	_, _, err := client.Issues.Create(userName, repositoryName, issueRequest)

	if err != nil {
		fmt.Printf("create issue error: %v\n", err)
	}
}

func useSentry() bool {
	sentryAPIKey := os.Getenv("SENTRY_API_KEY")
	if len(sentryAPIKey) > 0 {
		return true
	}
	return false
}

func notifyToIssue(unknownPkgs string) {
	if useSentry() {
		context := map[string]string{"pkgs": unknownPkgs}
		raven.CaptureErrorAndWait(errors.New("detect unknown packages"), context)
	}
}

func index(w http.ResponseWriter, r *http.Request) {
}

func releaseNotes(w http.ResponseWriter, r *http.Request) {
	var pkgs string
	var readOnly string
	var url string
	var androidLibrary AndroidLibrary
	var releaseNotes []ReleaseNote
	var unknownPkgs string

	pkgs = r.URL.Query().Get("packages")
	if len(pkgs) == 0 {
		http.Error(w, http.StatusText(400), 400)
		fmt.Println("`packages` parameter not found")
		return
	}

	readOnly = r.URL.Query().Get("read")

	for _, pkg := range strings.Split(pkgs, ",") {
		url = ""
		err := db.Get(&androidLibrary, "SELECT * FROM android_libraries WHERE package = $1", pkg)

		if err != nil {
			if err != sql.ErrNoRows {
				fmt.Printf("select error %s\n", err)
			}

			unknownPkgs += pkg + "\n"
		} else {
			if pkg == androidLibrary.Package {
				url = androidLibrary.ReleaseNoteURL
			}
		}
		releaseNotes = append(releaseNotes, ReleaseNote{Package: pkg, URL: url})
	}

	b, err := json.Marshal(releaseNotes)
	if err != nil {
		http.Error(w, http.StatusText(400), 400)
		fmt.Println(err)
		return
	}

	if len(unknownPkgs) > 0 && !(readOnly == "true") {
		notifyToIssue(unknownPkgs)
	}

	fmt.Fprintf(w, "%s", b)
}

func route(mux *goji.Mux) {
	mux.HandleFunc(pat.Get("/"), index)
	mux.HandleFunc(pat.Get("/release_notes"), releaseNotes)
}

func init() {
	if useSentry() {
		raven.SetDSN(os.Getenv("SENTRY_API_KEY"))
	}
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

	mux := goji.NewMux()
	route(mux)

	err = http.ListenAndServe(":"+port, mux)
	if err != nil {
		log.Fatalln(err)
	}
}
