
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.android.support:support-annotations', 'https://developer.android.com/topic/libraries/support-library/revisions.html', now(), now());


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DELETE FROM android_libraries;
