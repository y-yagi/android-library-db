-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.microsoft.azure:applicationinsights-core', 'https://github.com/Microsoft/ApplicationInsights-Java/blob/master/CHANGELOG.md',  now(), now());
INSERT INTO android_libraries (package, release_note_url, created_at, updated_at) VALUES ('com.microsoft.azure:applicationinsights-logging-log4j2', 'https://github.com/Microsoft/ApplicationInsights-Java/blob/master/CHANGELOG.md',  now(), now());

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DELETE FROM android_libraries WHERE package in ('com.microsoft.azure:applicationinsights-core');
DELETE FROM android_libraries WHERE package in ('com.microsoft.azure:applicationinsights-logging-log4j2');
