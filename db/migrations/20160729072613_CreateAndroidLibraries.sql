
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE android_libraries (
    id integer NOT NULL,
    package character varying,
    release_note_url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: android_libraries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE android_libraries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: android_libraries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE android_libraries_id_seq OWNED BY android_libraries.id;

ALTER TABLE ONLY android_libraries ALTER COLUMN id SET DEFAULT nextval('android_libraries_id_seq'::regclass);

ALTER TABLE ONLY android_libraries ADD CONSTRAINT android_libraries_pkey PRIMARY KEY (id);

CREATE UNIQUE INDEX index_android_libraries_on_package ON android_libraries USING btree (package);


-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE android_libraries;
