
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.google.firebase:firebase-crash', 'https://firebase.google.com/support/releases', now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.google.firebase:firebase-messaging', 'https://firebase.google.com/support/releases', now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.google.firebase:firebase-core', 'https://firebase.google.com/support/releases', now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.google.android.gms:play-services-places', 'https://developer.android.com/topic/libraries/support-library/revisions.html',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.afollestad.material-dialogs:core', 'https://github.com/afollestad/material-dialogs/releases', now(), now());

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DELETE FROM android_libraries WHERE package in ('com.google.firebase:firebase-crash', 'com.google.firebase:firebase-messaging', 'com.google.firebase:firebase-core', 'com.google.android.gms:play-services-places', 'com.afollestad.material-dialogs:core');
