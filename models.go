package main

import "time"

type AndroidLibrary struct {
	Id               int
	Package          string
	Release_note_url string
	Created_at       time.Time
	Updated_at       time.Time
}

type ReleaseNote struct {
	Package string `json:"package"`
	Url     string `json:"url"`
}
