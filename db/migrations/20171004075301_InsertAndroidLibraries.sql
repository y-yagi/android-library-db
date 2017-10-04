-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('io.dropwizard:dropwizard-core', 'https://github.com/dropwizard/dropwizard/releases',  now(), now());

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DELETE FROM android_libraries WHERE package in ('io.dropwizard:dropwizard-core');
