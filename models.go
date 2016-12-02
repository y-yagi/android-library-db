package main

import "time"

// AndroidLibrary is library info
type AndroidLibrary struct {
	ID             int
	Package        string
	ReleaseNoteURL string    `db:"release_note_url"`
	CreatedAt      time.Time `db:"created_at"`
	UpdatedAt      time.Time `db:"updated_at"`
}

// ReleaseNote is library release note info
type ReleaseNote struct {
	Package string `json:"package"`
	URL     string `json:"url"`
}
