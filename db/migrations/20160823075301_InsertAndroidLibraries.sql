
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.android.support:cardview-v7', 'https://developer.android.com/topic/libraries/support-library/revisions.html',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.android.tools.build:gradle', 'https://developer.android.com/studio/releases/gradle-plugin.html#revisions',  now(), now());

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DELETE FROM android_libraries WHERE package in ('com.android.support:cardview-v7', 'com.android.tools.build:gradle');
