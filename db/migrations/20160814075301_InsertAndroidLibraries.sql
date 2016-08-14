
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('org.assertj:assertj-core', 'http://joel-costigliola.github.io/assertj/assertj-core-news.html',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('junit:junit', 'https://github.com/junit-team/junit4/wiki',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('org.robolectric:robolectric', 'https://github.com/robolectric/robolectric/releases',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('org.robolectric:robolectric-gradle-plugin', 'https://github.com/robolectric/robolectric/releases',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.android.support:support-v4', 'https://developer.android.com/topic/libraries/support-library/revisions.html',  now(), now());

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DELETE FROM android_libraries WHERE package in ('org.assertj:assertj-core', 'junit:junit', 'org.robolectric:robolectric', 'org.robolectric:robolectric-gradle-plugin', 'com.android.support:support-v4');
