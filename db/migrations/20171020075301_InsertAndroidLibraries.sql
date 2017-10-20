-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('org.mockito:mockito-core', 'https://github.com/mockito/mockito/blob/release/2.x/doc/release-notes/official.md',  now(), now());

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DELETE FROM android_libraries WHERE package in ('org.mockito:mockito-core');
