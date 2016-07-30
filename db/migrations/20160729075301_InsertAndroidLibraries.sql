
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.android.support:appcompat-v4', 'https://developer.android.com/topic/libraries/support-library/revisions.html', now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.android.support:appcompat-v7', 'https://developer.android.com/topic/libraries/support-library/revisions.html', now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.android.support:appcompat-v13', 'https://developer.android.com/topic/libraries/support-library/revisions.html', now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.android.support:design', 'https://developer.android.com/topic/libraries/support-library/revisions.html', now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.android.support:support-annotations', 'https://developer.android.com/topic/libraries/support-library/revisions.html', now(), now());


INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.google.android.gms:play-services-location', 'https://developer.android.com/topic/libraries/support-library/revisions.html',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.google.android.gms:play-services-maps', 'https://developer.android.com/topic/libraries/support-library/revisions.html',  now(), now());


INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.squareup.retrofit2:retrofit', 'https://github.com/square/retrofit/blob/master/CHANGELOG.md',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.squareup.retrofit2:converter-gson', 'https://github.com/square/retrofit/blob/master/CHANGELOG.md',  now(), now());

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DELETE FROM android_libraries;
