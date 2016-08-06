
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.google.android.gms:play-services-drive', 'https://developer.android.com/topic/libraries/support-library/revisions.html',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('io.realm:realm-android-library', 'https://github.com/realm/realm-java/blob/master/CHANGELOG.md',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('io.realm:realm-annotations', 'https://github.com/realm/realm-java/blob/master/CHANGELOG.md',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('io.realm:realm-annotations-processor', 'https://github.com/realm/realm-java/blob/master/CHANGELOG.md',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('io.realm:realm-gradle-plugin', 'https://github.com/realm/realm-java/blob/master/CHANGELOG.md',  now(), now());

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DELETE FROM android_libraries WHERE package in ('com.google.android.gms:play-services-drive', 'io.realm:realm-android-library', 'io.realm:realm-annotations', 'io.realm:realm-annotations-processor', 'io.realm:realm-gradle-plugin');
