--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

ALTER TABLE ONLY public.star DROP CONSTRAINT star_galaxy_id_fkey;
ALTER TABLE ONLY public.planet DROP CONSTRAINT planet_star_id_fkey;
ALTER TABLE ONLY public.moon DROP CONSTRAINT moon_planet_id_fkey;
ALTER TABLE ONLY public.type DROP CONSTRAINT type_typ_key;
ALTER TABLE ONLY public.type DROP CONSTRAINT type_pkey;
ALTER TABLE ONLY public.star DROP CONSTRAINT star_pkey;
ALTER TABLE ONLY public.star DROP CONSTRAINT star_name_key;
ALTER TABLE ONLY public.planet DROP CONSTRAINT planet_pkey;
ALTER TABLE ONLY public.planet DROP CONSTRAINT planet_name_key;
ALTER TABLE ONLY public.moon DROP CONSTRAINT moon_pkey;
ALTER TABLE ONLY public.moon DROP CONSTRAINT moon_name_key;
ALTER TABLE ONLY public.galaxy DROP CONSTRAINT galaxy_pkey;
ALTER TABLE ONLY public.galaxy DROP CONSTRAINT galaxy_name_key;
ALTER TABLE public.type ALTER COLUMN type_id DROP DEFAULT;
ALTER TABLE public.star ALTER COLUMN star_id DROP DEFAULT;
ALTER TABLE public.planet ALTER COLUMN planet_id DROP DEFAULT;
ALTER TABLE public.moon ALTER COLUMN moon_id DROP DEFAULT;
ALTER TABLE public.galaxy ALTER COLUMN galaxy_id DROP DEFAULT;
DROP SEQUENCE public.type_type_id_seq;
DROP TABLE public.type;
DROP SEQUENCE public.star_star_id_seq;
DROP TABLE public.star;
DROP SEQUENCE public.planet_planet_id_seq;
DROP TABLE public.planet;
DROP SEQUENCE public.moon_moon_id_seq;
DROP TABLE public.moon;
DROP SEQUENCE public.galaxy_galaxy_id_seq;
DROP TABLE public.galaxy;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text,
    distance_from_earth_in_million_ly integer,
    diameter_in_thousand_ly integer
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    planet_id integer,
    description text,
    diameter_in_thousand_km integer
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    star_id integer,
    has_live boolean,
    is_spherical boolean,
    description text
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    galaxy_id integer,
    description text,
    age_in_million_years integer,
    distance_from_earth_in_ly integer,
    diameter_in_km numeric(10,2)
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.type (
    type_id integer NOT NULL,
    name character varying(20) NOT NULL,
    description text
);


ALTER TABLE public.type OWNER TO freecodecamp;

--
-- Name: type_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.type_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.type_type_id_seq OWNER TO freecodecamp;

--
-- Name: type_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.type_type_id_seq OWNED BY public.type.type_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Name: type type_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.type ALTER COLUMN type_id SET DEFAULT nextval('public.type_type_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milkyway', 'our home galaxy', 0, 87);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'galaxy', 3, 152);
INSERT INTO public.galaxy VALUES (3, 'Andromeda 1', 'galaxy', 3, 6);
INSERT INTO public.galaxy VALUES (4, 'Andromeda 2', 'galaxy', 2, 7);
INSERT INTO public.galaxy VALUES (5, 'Andromeda 3', 'galaxy', 2, 3);
INSERT INTO public.galaxy VALUES (6, 'Andromeda 10', 'galaxy', 3, NULL);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'm1', 1, NULL, NULL);
INSERT INTO public.moon VALUES (2, 'm2', 1, NULL, NULL);
INSERT INTO public.moon VALUES (3, 'm3', 1, NULL, NULL);
INSERT INTO public.moon VALUES (4, 'm4', 1, NULL, NULL);
INSERT INTO public.moon VALUES (5, 'm5', 2, NULL, NULL);
INSERT INTO public.moon VALUES (6, 'm6', 2, NULL, NULL);
INSERT INTO public.moon VALUES (7, 'm7', 2, NULL, NULL);
INSERT INTO public.moon VALUES (8, 'm8', 3, NULL, NULL);
INSERT INTO public.moon VALUES (9, 'm9', 4, NULL, NULL);
INSERT INTO public.moon VALUES (10, 'm10', 4, NULL, NULL);
INSERT INTO public.moon VALUES (11, 'm11', 5, NULL, NULL);
INSERT INTO public.moon VALUES (12, 'm12', 6, NULL, NULL);
INSERT INTO public.moon VALUES (13, 'm13', 7, NULL, NULL);
INSERT INTO public.moon VALUES (14, 'm14', 7, NULL, NULL);
INSERT INTO public.moon VALUES (15, 'm15', 8, NULL, NULL);
INSERT INTO public.moon VALUES (16, 'm16', 8, NULL, NULL);
INSERT INTO public.moon VALUES (17, 'm17', 9, NULL, NULL);
INSERT INTO public.moon VALUES (18, 'm18', 10, NULL, NULL);
INSERT INTO public.moon VALUES (19, 'm19', 11, NULL, NULL);
INSERT INTO public.moon VALUES (20, 'm20', 12, NULL, NULL);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'p1', 1, NULL, NULL, NULL);
INSERT INTO public.planet VALUES (2, 'p2', 2, NULL, NULL, NULL);
INSERT INTO public.planet VALUES (3, 'p3', 3, NULL, NULL, NULL);
INSERT INTO public.planet VALUES (4, 'p4', 4, NULL, NULL, NULL);
INSERT INTO public.planet VALUES (5, 'p5', 5, NULL, NULL, NULL);
INSERT INTO public.planet VALUES (6, 'p6', 6, NULL, NULL, NULL);
INSERT INTO public.planet VALUES (7, 'p7', 1, NULL, NULL, NULL);
INSERT INTO public.planet VALUES (8, 'p8', 2, NULL, NULL, NULL);
INSERT INTO public.planet VALUES (9, 'p9', 3, NULL, NULL, NULL);
INSERT INTO public.planet VALUES (10, 'p10', 4, NULL, NULL, NULL);
INSERT INTO public.planet VALUES (11, 'p11', 5, NULL, NULL, NULL);
INSERT INTO public.planet VALUES (12, 'p12', 6, NULL, NULL, NULL);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 's1', 1, 'star', 1, 1, 1.00);
INSERT INTO public.star VALUES (2, 's2', 2, 'star', 2, 2, 2.00);
INSERT INTO public.star VALUES (3, 's3', 3, 'star', 3, 3, 3.00);
INSERT INTO public.star VALUES (4, 's4', 4, 'star', 4, 4, 4.00);
INSERT INTO public.star VALUES (5, 's5', 5, 'star', 5, 5, 5.00);
INSERT INTO public.star VALUES (6, 's6', 6, 'star', 6, 6, 6.00);


--
-- Data for Name: type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.type VALUES (1, 'SOLID', 'solid Core');
INSERT INTO public.type VALUES (2, 'GAS', 'gas Core');
INSERT INTO public.type VALUES (3, 'HYBRID', 'mix of solid and gas Core');


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 1, false);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 1, false);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 1, false);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 1, false);


--
-- Name: type_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.type_type_id_seq', 1, false);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: type type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.type
    ADD CONSTRAINT type_pkey PRIMARY KEY (type_id);


--
-- Name: type type_typ_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.type
    ADD CONSTRAINT type_typ_key UNIQUE (name);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

