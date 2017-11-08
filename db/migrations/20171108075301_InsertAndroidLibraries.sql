-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.android.support.test.espresso:espresso-core', 'https://developer.android.com/topic/libraries/testing-support-library/release-notes.html',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.android.support.test:runner', 'https://developer.android.com/topic/libraries/testing-support-library/release-notes.html',  now(), now());

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DELETE FROM android_libraries WHERE package in ('com.android.support.test.espresso:espresso-core');
DELETE FROM android_libraries WHERE package in ('com.android.support.test:runner');
