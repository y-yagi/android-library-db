
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.crashlytics.sdk.android:crashlytics', 'https://docs.fabric.io/android/changelog.html#crashlytics',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.mikepenz:materialdrawer', 'https://github.com/mikepenz/MaterialDrawer/releases',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.twitter.sdk.android:twitter', 'https://docs.fabric.io/android/changelog.html#twitter',  now(), now());

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DELETE FROM android_libraries WHERE package in ('com.crashlytics.sdk.android:crashlytics', 'com.mikepenz:materialdrawer', 'com.twitter.sdk.android:twitter');
