-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('org.antlr:stringtemplate', 'https://github.com/antlr/stringtemplate4/releases',  now(), now());

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DELETE FROM android_libraries WHERE package in ('org.antlr:stringtemplate');
