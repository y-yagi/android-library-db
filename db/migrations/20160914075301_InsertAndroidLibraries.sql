-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.facebook.stetho:stetho', 'https://github.com/facebook/stetho/blob/master/CHANGELOG.md',  now(), now());

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DELETE FROM android_libraries WHERE package in ('com.facebook.stetho:stetho');
