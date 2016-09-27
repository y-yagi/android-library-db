-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
DELETE FROM android_libraries WHERE package in ('com.google.android.gms:play-services-location', 'com.google.android.gms:play-services-maps', 'com.google.android.gms:play-services-places', 'com.google.android.gms:play-services-drive', 'com.google.firebase:firebase-crash', 'com.google.firebase:firebase-messaging', 'com.google.firebase:firebase-core');

INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.google.android.gms:play-services-location', 'https://developers.google.com/android/guides/releases',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.google.android.gms:play-services-maps', 'https://developers.google.com/android/guides/releases',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.google.android.gms:play-services-places', 'https://developers.google.com/android/guides/releases',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.google.android.gms:play-services-drive', 'https://developers.google.com/android/guides/releases',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.google.firebase:firebase-crash', 'https://firebase.google.com/support/release-notes/android', now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.google.firebase:firebase-messaging', 'https://firebase.google.com/support/release-notes/android', now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.google.firebase:firebase-core', 'https://firebase.google.com/support/release-notes/android', now(), now());


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
