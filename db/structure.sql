--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: colours; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE colours (
    id integer NOT NULL,
    description_id integer NOT NULL,
    "position" integer,
    hue double precision NOT NULL,
    saturation double precision NOT NULL,
    luminosity double precision NOT NULL,
    rgb integer NOT NULL,
    name_id integer
);


--
-- Name: colours_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE colours_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: colours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE colours_id_seq OWNED BY colours.id;


--
-- Name: descriptions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE descriptions (
    id integer NOT NULL,
    type character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    archived timestamp without time zone,
    "unique" boolean DEFAULT false NOT NULL,
    shop_sec_account smallint,
    shop_sec_sku integer,
    part_count integer DEFAULT 1 NOT NULL,
    acc_price_cents integer,
    acc_price_currency character varying,
    target_price_cents integer,
    target_price_currency character varying,
    properties jsonb DEFAULT '{}'::jsonb NOT NULL,
    packaged_size_x integer,
    packaged_size_y integer,
    packaged_size_z integer,
    royal_mail_large_letter boolean DEFAULT false NOT NULL,
    gift_boxed boolean DEFAULT false NOT NULL,
    weight_net integer,
    weight_gross integer,
    title character varying,
    notes character varying,
    summary character varying,
    history jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: ingredients; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ingredients (
    id integer NOT NULL,
    description_id integer NOT NULL,
    material_id integer NOT NULL,
    "position" integer,
    significance smallint DEFAULT 0 NOT NULL,
    genuine boolean DEFAULT true NOT NULL,
    adjective character varying,
    text character varying
);


--
-- Name: ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ingredients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ingredients_id_seq OWNED BY ingredients.id;


--
-- Name: material_hierarchies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE material_hierarchies (
    ancestor_id integer NOT NULL,
    descendant_id integer NOT NULL,
    generations integer NOT NULL
);


--
-- Name: materials; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE materials (
    id integer NOT NULL,
    type character varying NOT NULL,
    parent_id integer,
    selectable boolean DEFAULT true NOT NULL,
    names jsonb DEFAULT '{}'::jsonb NOT NULL,
    aliases jsonb DEFAULT '{}'::jsonb,
    inherit_display_name boolean DEFAULT false NOT NULL,
    description text,
    notes text,
    properties jsonb DEFAULT '{}'::jsonb NOT NULL,
    archived timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: uid_7_digit_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE uid_7_digit_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: uid_9_digit_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE uid_9_digit_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    admin boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    username character varying NOT NULL,
    email character varying NOT NULL,
    authentication_token character varying NOT NULL,
    encrypted_password character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    preferences jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY colours ALTER COLUMN id SET DEFAULT nextval('colours_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ingredients ALTER COLUMN id SET DEFAULT nextval('ingredients_id_seq'::regclass);


--
-- Name: colours_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY colours
    ADD CONSTRAINT colours_pkey PRIMARY KEY (id);


--
-- Name: descriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY descriptions
    ADD CONSTRAINT descriptions_pkey PRIMARY KEY (id);


--
-- Name: ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (id);


--
-- Name: materials_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_colours_on_hue; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_colours_on_hue ON colours USING btree (hue);


--
-- Name: index_colours_on_luminosity; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_colours_on_luminosity ON colours USING btree (luminosity);


--
-- Name: index_colours_on_rgb; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_colours_on_rgb ON colours USING btree (rgb);


--
-- Name: index_colours_on_saturation; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_colours_on_saturation ON colours USING btree (saturation);


--
-- Name: index_ingredients_on_description_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ingredients_on_description_id ON ingredients USING btree (description_id);


--
-- Name: index_ingredients_on_material_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ingredients_on_material_id ON ingredients USING btree (material_id);


--
-- Name: index_users_on_authentication_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_authentication_token ON users USING btree (authentication_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_preferences; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_preferences ON users USING gin (preferences);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_username ON users USING btree (username);


--
-- Name: material_anc_desc_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX material_anc_desc_idx ON material_hierarchies USING btree (ancestor_id, descendant_id, generations);


--
-- Name: material_desc_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX material_desc_idx ON material_hierarchies USING btree (descendant_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20150914215124');

INSERT INTO schema_migrations (version) VALUES ('20150915011714');

INSERT INTO schema_migrations (version) VALUES ('20150921194501');

INSERT INTO schema_migrations (version) VALUES ('20150923190028');

INSERT INTO schema_migrations (version) VALUES ('20150925100450');

INSERT INTO schema_migrations (version) VALUES ('20150928105423');

INSERT INTO schema_migrations (version) VALUES ('20151005125603');

INSERT INTO schema_migrations (version) VALUES ('20151108224209');

