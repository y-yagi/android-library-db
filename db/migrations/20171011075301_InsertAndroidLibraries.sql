-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('io.sentry:sentry-logback', 'https://github.com/getsentry/sentry-java/blob/master/CHANGES',  now(), now());

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DELETE FROM android_libraries WHERE package in ('io.sentry:sentry-logback');
