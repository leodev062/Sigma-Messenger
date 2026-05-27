--
-- PostgreSQL database dump
--

\restrict ce1fhmm6sDbR7DnM2dpl6XAKZyuyIbx6zKaX7CHiLeVK4mkpH8fgkAAdT6kZYD2

-- Dumped from database version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: chat_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.chat_type AS ENUM (
    'individual',
    'group',
    'channel',
    'bot'
);


ALTER TYPE public.chat_type OWNER TO postgres;

--
-- Name: recipient_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.recipient_type AS ENUM (
    'individual',
    'group',
    'channel',
    'bot'
);


ALTER TYPE public.recipient_type OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bot_conversation_states; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bot_conversation_states (
    user_id uuid NOT NULL,
    bot_id uuid NOT NULL,
    step character varying(50),
    metadata text,
    updated_at timestamp with time zone
);


ALTER TABLE public.bot_conversation_states OWNER TO postgres;

--
-- Name: memberships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.memberships (
    recipient_id uuid NOT NULL,
    user_id uuid NOT NULL,
    role character varying(20) DEFAULT 'member'::character varying,
    joined_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_muted boolean DEFAULT false
);


ALTER TABLE public.memberships OWNER TO postgres;

--
-- Name: messages_queue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages_queue (
    id integer NOT NULL,
    content text NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    chat_id uuid,
    sender_id uuid,
    receiver_id uuid
);


ALTER TABLE public.messages_queue OWNER TO postgres;

--
-- Name: messages_queue_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_queue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messages_queue_id_seq OWNER TO postgres;

--
-- Name: messages_queue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_queue_id_seq OWNED BY public.messages_queue.id;


--
-- Name: pending_envelopes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pending_envelopes (
    id integer NOT NULL,
    envelope jsonb NOT NULL,
    "timestamp" bigint NOT NULL,
    expires_at timestamp without time zone DEFAULT (now() + '7 days'::interval),
    destination_id uuid,
    message_id uuid
);


ALTER TABLE public.pending_envelopes OWNER TO postgres;

--
-- Name: pending_envelopes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pending_envelopes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pending_envelopes_id_seq OWNER TO postgres;

--
-- Name: pending_envelopes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pending_envelopes_id_seq OWNED BY public.pending_envelopes.id;


--
-- Name: recipients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recipients (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    type public.recipient_type NOT NULL,
    phone text,
    email character varying(255),
    firebase_uid character varying(255),
    username character varying(50),
    display_name character varying(100),
    avatar_url text,
    bio text,
    country character varying(100),
    relative_name character varying(255),
    relative_id uuid,
    is_online boolean DEFAULT false,
    last_seen timestamp without time zone,
    fcm_token text,
    verification_type text DEFAULT 'none'::text,
    owner_id uuid,
    bot_token character varying(255),
    participant_count integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    identity_key bytea,
    signed_pre_key bytea,
    signed_pre_key_public bytea,
    signed_pre_key_signature bytea,
    registration_id bigint
);

CREATE TABLE public.pre_keys (
    id integer NOT NULL,
    recipient_id uuid NOT NULL,
    key_id integer NOT NULL,
    public_key bytea NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE public.pre_keys OWNER TO postgres;

CREATE SEQUENCE public.pre_keys_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE ONLY public.pre_keys ALTER COLUMN id SET DEFAULT nextval('public.pre_keys_id_seq'::regclass);

ALTER SEQUENCE public.pre_keys_id_seq OWNER TO postgres;

ALTER TABLE ONLY public.pre_keys ADD CONSTRAINT pre_keys_pkey PRIMARY KEY (id);

CREATE TABLE public.key_bundles (
    id integer NOT NULL,
    account_id uuid NOT NULL,
    payload bytea NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE public.key_bundles OWNER TO postgres;

CREATE SEQUENCE public.key_bundles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE ONLY public.key_bundles ALTER COLUMN id SET DEFAULT nextval('public.key_bundles_id_seq'::regclass);

ALTER SEQUENCE public.key_bundles_id_seq OWNER TO postgres;

ALTER TABLE ONLY public.key_bundles ADD CONSTRAINT key_bundles_pkey PRIMARY KEY (id);

ALTER TABLE public.recipients OWNER TO postgres;

--
-- Name: messages_queue id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages_queue ALTER COLUMN id SET DEFAULT nextval('public.messages_queue_id_seq'::regclass);


--
-- Name: pending_envelopes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_envelopes ALTER COLUMN id SET DEFAULT nextval('public.pending_envelopes_id_seq'::regclass);


--
-- Name: bot_conversation_states bot_conversation_states_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bot_conversation_states
    ADD CONSTRAINT bot_conversation_states_pkey PRIMARY KEY (user_id, bot_id);


--
-- Name: memberships memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT memberships_pkey PRIMARY KEY (recipient_id, user_id);


--
-- Name: messages_queue messages_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages_queue
    ADD CONSTRAINT messages_queue_pkey PRIMARY KEY (id);


--
-- Name: pending_envelopes pending_envelopes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pending_envelopes
    ADD CONSTRAINT pending_envelopes_pkey PRIMARY KEY (id);


--
-- Name: recipients recipients_bot_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipients
    ADD CONSTRAINT recipients_bot_token_key UNIQUE (bot_token);


--
-- Name: recipients recipients_firebase_uid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipients
    ADD CONSTRAINT recipients_firebase_uid_key UNIQUE (firebase_uid);


--
-- Name: recipients recipients_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipients
    ADD CONSTRAINT recipients_phone_key UNIQUE (phone);


--
-- Name: recipients recipients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipients
    ADD CONSTRAINT recipients_pkey PRIMARY KEY (id);


--
-- Name: memberships memberships_recipient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT memberships_recipient_id_fkey FOREIGN KEY (recipient_id) REFERENCES public.recipients(id) ON DELETE CASCADE;


--
-- Name: memberships memberships_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT memberships_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.recipients(id) ON DELETE CASCADE;


--
-- Name: recipients recipients_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipients
    ADD CONSTRAINT recipients_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES public.recipients(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict ce1fhmm6sDbR7DnM2dpl6XAKZyuyIbx6zKaX7CHiLeVK4mkpH8fgkAAdT6kZYD2

