--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.3

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: coach; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coach (
    id character varying(3) NOT NULL,
    name character varying(25),
    nation character varying(25)
);


ALTER TABLE public.coach OWNER TO postgres;

--
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedbacks (
    id integer NOT NULL,
    fname character varying,
    message character varying,
    date_feedback timestamp without time zone,
    sentiment character varying
);


ALTER TABLE public.feedbacks OWNER TO postgres;

--
-- Name: feedbacks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feedbacks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedbacks_id_seq OWNER TO postgres;

--
-- Name: feedbacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feedbacks_id_seq OWNED BY public.feedbacks.id;


--
-- Name: friend_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friend_request (
    id integer NOT NULL,
    user_id1 integer NOT NULL,
    user_id2 integer NOT NULL
);


ALTER TABLE public.friend_request OWNER TO postgres;

--
-- Name: friend_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.friend_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friend_request_id_seq OWNER TO postgres;

--
-- Name: friend_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.friend_request_id_seq OWNED BY public.friend_request.id;


--
-- Name: friendrequest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friendrequest (
    id integer NOT NULL,
    friend_date timestamp without time zone,
    user_id1 integer,
    user_id2 integer
);


ALTER TABLE public.friendrequest OWNER TO postgres;

--
-- Name: friendrequest_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.friendrequest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendrequest_id_seq OWNER TO postgres;

--
-- Name: friendrequest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.friendrequest_id_seq OWNED BY public.friendrequest.id;


--
-- Name: friends; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friends (
    id integer NOT NULL,
    friend_date timestamp without time zone,
    user_id1 integer,
    user_id2 integer
);


ALTER TABLE public.friends OWNER TO postgres;

--
-- Name: friends_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.friends_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friends_id_seq OWNER TO postgres;

--
-- Name: friends_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.friends_id_seq OWNED BY public.friends.id;


--
-- Name: group_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_members (
    id integer NOT NULL,
    member integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.group_members OWNER TO postgres;

--
-- Name: group_members_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.group_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group_members_id_seq OWNER TO postgres;

--
-- Name: group_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.group_members_id_seq OWNED BY public.group_members.id;


--
-- Name: group_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_messages (
    id integer NOT NULL,
    message_date timestamp without time zone NOT NULL,
    content text NOT NULL,
    start integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.group_messages OWNER TO postgres;

--
-- Name: group_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.group_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group_messages_id_seq OWNER TO postgres;

--
-- Name: group_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.group_messages_id_seq OWNED BY public.group_messages.id;


--
-- Name: groupmembers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groupmembers (
    id integer NOT NULL,
    member integer,
    group_id integer
);


ALTER TABLE public.groupmembers OWNER TO postgres;

--
-- Name: groupmembers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.groupmembers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groupmembers_id_seq OWNER TO postgres;

--
-- Name: groupmembers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.groupmembers_id_seq OWNED BY public.groupmembers.id;


--
-- Name: groupmessages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groupmessages (
    id integer NOT NULL,
    message_date timestamp without time zone,
    content character varying,
    start integer,
    group_id integer
);


ALTER TABLE public.groupmessages OWNER TO postgres;

--
-- Name: groupmessages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.groupmessages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groupmessages_id_seq OWNER TO postgres;

--
-- Name: groupmessages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.groupmessages_id_seq OWNED BY public.groupmessages.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    id integer NOT NULL,
    group_date timestamp without time zone,
    name character varying,
    admin integer
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- Name: league; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.league (
    name character varying(25) NOT NULL,
    country character varying(25)
);


ALTER TABLE public.league OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    message_date timestamp without time zone,
    content character varying,
    start integer,
    read integer,
    friend_id integer
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: nationality; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nationality (
    name character varying(25) NOT NULL,
    continent character varying(25)
);


ALTER TABLE public.nationality OWNER TO postgres;

--
-- Name: player; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player (
    id character varying(3) NOT NULL,
    fname character varying(15),
    lname character varying(15),
    team_name character varying(25),
    nation character varying(25),
    "position" character varying(2)
);


ALTER TABLE public.player OWNER TO postgres;

--
-- Name: position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."position" (
    id character varying(2) NOT NULL,
    name character varying(25)
);


ALTER TABLE public."position" OWNER TO postgres;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    title character varying(100),
    date_posted timestamp without time zone,
    content character varying,
    user_id integer
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_id_seq OWNER TO postgres;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: statistics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.statistics (
    player_id character varying(3) NOT NULL,
    year integer NOT NULL,
    goals integer,
    assists integer,
    clean_sheets integer,
    appearances integer,
    yellow_cards integer,
    red_cards integer,
    saves integer
);


ALTER TABLE public.statistics OWNER TO postgres;

--
-- Name: team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team (
    name character varying(25) NOT NULL,
    league_name character varying(25),
    coach_id character varying(3),
    league_position integer,
    stadium character varying(25),
    city character varying(25),
    founded integer
);


ALTER TABLE public.team OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(20),
    email character varying(120),
    image_file character varying(20),
    password character varying(60)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: feedbacks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks ALTER COLUMN id SET DEFAULT nextval('public.feedbacks_id_seq'::regclass);


--
-- Name: friend_request id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friend_request ALTER COLUMN id SET DEFAULT nextval('public.friend_request_id_seq'::regclass);


--
-- Name: friendrequest id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendrequest ALTER COLUMN id SET DEFAULT nextval('public.friendrequest_id_seq'::regclass);


--
-- Name: friends id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friends ALTER COLUMN id SET DEFAULT nextval('public.friends_id_seq'::regclass);


--
-- Name: group_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members ALTER COLUMN id SET DEFAULT nextval('public.group_members_id_seq'::regclass);


--
-- Name: group_messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_messages ALTER COLUMN id SET DEFAULT nextval('public.group_messages_id_seq'::regclass);


--
-- Name: groupmembers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupmembers ALTER COLUMN id SET DEFAULT nextval('public.groupmembers_id_seq'::regclass);


--
-- Name: groupmessages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupmessages ALTER COLUMN id SET DEFAULT nextval('public.groupmessages_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: coach; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coach (id, name, nation) FROM stdin;
001	Maurizio Sarri	Italy
002	Ole Solskjaer	Norway
003	Pep Guardiola	Spain
004	Jurgen Klopp	Germany
011	Valverade	Spain
012	Diego Simeone	Argentina
013	Zinedine  Zidane	France
014	Joaquin	Spain
021	Lucien Favre	Switzerland
022	Niko Kovac	Croatia
023	Ralf Rangnick	Germany
024	Dieter Hecking	Germany
\.


--
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedbacks (id, fname, message, date_feedback, sentiment) FROM stdin;
2	Clyson	Amazing thing u did there	2020-07-24 10:51:35.337574	Positive
3	Pestie	Didnt like it at all	2020-07-24 10:51:50.711973	Negative
4	Pestie	U should improve it	2020-07-24 10:52:06.134236	Positive
\.


--
-- Data for Name: friend_request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.friend_request (id, user_id1, user_id2) FROM stdin;
2	6	2
7	3	6
\.


--
-- Data for Name: friendrequest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.friendrequest (id, friend_date, user_id1, user_id2) FROM stdin;
\.


--
-- Data for Name: friends; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.friends (id, friend_date, user_id1, user_id2) FROM stdin;
1	2020-07-14 00:00:01	1	2
2	2020-07-14 12:00:01	3	1
3	2020-07-15 13:21:59.833786	3	2
4	2020-07-16 10:29:09.882604	2	4
5	2020-07-16 10:31:01.439017	4	3
6	2020-07-24 07:10:40.339619	4	1
7	2020-07-25 16:55:19.870261	4	6
8	2020-07-25 16:59:00.605333	2	6
\.


--
-- Data for Name: group_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_members (id, member, group_id) FROM stdin;
1	4	123
\.


--
-- Data for Name: group_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_messages (id, message_date, content, start, group_id) FROM stdin;
\.


--
-- Data for Name: groupmembers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groupmembers (id, member, group_id) FROM stdin;
\.


--
-- Data for Name: groupmessages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groupmessages (id, message_date, content, start, group_id) FROM stdin;
\.


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups (id, group_date, name, admin) FROM stdin;
123	2020-07-25 07:15:36.63311	123	2
\.


--
-- Data for Name: league; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.league (name, country) FROM stdin;
Premier League	England
La Liga	Spain
Bundesliga	Germany
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, message_date, content, start, read, friend_id) FROM stdin;
1	2020-07-24 19:07:36.189314	hello	2	0	1
3	2020-07-24 19:11:00.874092	hiya	3	1	5
4	2020-07-24 19:21:53.682518	hello	4	1	5
2	2020-07-24 19:08:00.726853	hi	2	1	4
5	2020-07-24 19:53:54.788425	Yooo	4	1	4
6	2020-07-24 19:53:58.582752	whatsupp	4	1	4
7	2020-07-24 19:54:04.932335	Hows life brother	4	1	4
8	2020-07-25 16:52:42.89215	Good bro	2	1	4
9	2020-07-25 16:52:47.192729	what about you	2	1	4
10	2020-07-26 11:34:44.559486	Vamos	2	1	8
11	2020-07-26 12:00:21.107977	a	2	1	8
12	2020-07-26 12:00:22.825071	b	2	1	8
13	2020-07-26 12:00:24.802151	c	2	1	8
14	2020-07-26 12:00:25.371593	d	2	1	8
15	2020-07-26 12:00:25.814647	e	2	1	8
16	2020-07-26 12:00:26.769751	f	2	1	8
17	2020-07-26 12:00:27.165028	g	2	1	8
18	2020-07-26 12:00:27.533667	h	2	1	8
19	2020-07-26 12:00:28.198182	i	2	1	8
20	2020-07-26 12:00:28.575799	j	2	1	8
21	2020-07-26 12:00:28.894074	k	2	1	8
22	2020-07-26 12:00:29.191846	l	2	1	8
23	2020-07-26 12:00:30.094949	m	2	1	8
24	2020-07-26 12:00:30.454025	n	2	1	8
25	2020-07-26 12:00:30.874294	o	2	1	8
26	2020-07-26 12:00:31.355039	p	2	1	8
27	2020-07-26 12:00:32.035819	q	2	1	8
28	2020-07-26 12:00:32.43807	r	2	1	8
29	2020-07-26 12:00:32.764078	s	2	1	8
30	2020-07-26 12:00:33.430882	t	2	1	8
31	2020-07-26 12:00:34.129603	u	2	1	8
32	2020-07-26 12:00:34.726614	v	2	1	8
33	2020-07-26 12:00:35.562958	w	2	1	8
34	2020-07-26 12:00:36.114818	x	2	1	8
35	2020-07-26 12:00:36.65854	y	2	1	8
36	2020-07-26 12:00:37.261114	z	2	1	8
\.


--
-- Data for Name: nationality; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nationality (name, continent) FROM stdin;
England	Europe
Spain	Europe
Germany	Europe
France	Europe
Brazil	South America
Belgium	Europe
Portugal	Europe
Argentina	South America
Italy	Europe
Wales	Europe
Chile	South America
Ireland	Europe
Netherlands	Europe
Japan	Asia
South Korea	Asia
Sweden	Europe
Norway	Europe
Switzerland	Europe
Croatia	Europe
Serbia	Croatia
Cameroon	Africa
Scotland	Europe
Egypt	Africa
Senegal	Africa
Ukraine	Europe
Uruguay	South America
Slovakia	Europe
Czech Republic	Europe
Denmark	Europe
Poland	Europe
Colombia	South America
Austria	Europe
USA	North America
Turkey	Europe
Hungary	Europe
\.


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player (id, fname, lname, team_name, nation, "position") FROM stdin;
100	David	de Gea	Manchester United	Spain	GK
101	Ashley	Young	Manchester United	England	RB
102	Chris	Smalling	Manchester United	England	CB
103	Victor	Lindelof	Manchester United	Sweden	CB
104	Luke	Shaw	Manchester United	England	LB
106	Ander	Herrera	Manchester United	Spain	CM
107	Paul	Pogba	Manchester United	France	CM
108	Jesse	Lingard	Manchester United	England	RW
109	Romelu	Lukaku	Manchester United	Belgium	ST
110	Marcus	Rashford	Manchester United	England	LW
120	Kepa	Arrizabalaga	Chelsea	Spain	GK
121	Cesar	Azpilicueta	Chelsea	Spain	RB
122	David	Luiz	Chelsea	Brazil	CB
123	Antonio	Rudiger	Chelsea	Germany	CB
124	Marcos	Alonso	Chelsea	Spain	LB
125	Jorge	Luiz	Chelsea	Italy	CM
126	Ngolo	Kante	Chelsea	France	CM
127	Ross	Barkley	Chelsea	England	CM
128	Pedro	Rodriguez	Chelsea	Spain	RW
129	Gonzalo	Higuain	Chelsea	Argentina	ST
130	Eden	Hazard	Chelsea	Belgium	LW
140	Alisson	Becker	Liverpool	Brazil	GK
141	Alexander	Arnold	Liverpool	England	RB
142	Virgil	van Dijk	Liverpool	Netherlands	CB
143	Joel	Matip	Liverpool	Cameroon	CB
144	Andrew	Robertson	Liverpool	Scotland	LB
145	Jordan	Henderson	Liverpool	England	CM
146	Georginio	Wijnaldum	Liverpool	Netherlands	CM
147	James	Milner	Liverpool	England	CM
148	Mohamed	Salah	Liverpool	Egypt	LW
149	Roberto	Firmino	Liverpool	Brazil	ST
150	Sadio	Mane	Liverpool	Senegal	LW
160	Ederson	Moraes	Manchester City	Brazil	GK
161	Kyle	Walker	Manchester City	England	RB
162	John	Stones	Manchester City	England	CB
163	Vincent	Kompany	Manchester City	Belgium	CB
164	Oleksandr	Zinchenko	Manchester City	Ukraine	LB
165	Fernando	Luiz	Manchester City	Brazil	CM
166	David	Silva	Manchester City	Spain	CM
167	Kevin	de Bruyne	Manchester City	Belgium	CM
168	Raheem	Sterling	Manchester City	England	RW
169	Sergio	Aguero	Manchester City	Argentina	ST
170	Leroy	Sane	Manchester City	Germany	LW
201	Karim	Benzema	Real Madrid	France	ST
202	Gareth	Bale	Real Madrid	Wales	RW
203	Sergio	Ramos	Real Madrid	Spain	CB
204	Luka	Modric	Real Madrid	Croatia	CM
205	Carlos	Casemiro	Real Madrid	Brazil	CM
206	Dani	Carvajal	Real Madrid	Spain	RB
207	Marcelo	Junior	Real Madrid	Brazil	LB
208	Isco	Suarez	Real Madrid	Spain	RM
209	Thibaut	Courtois	Real Madrid	Belgium	GK
210	Raphael	Varane	Real Madrid	France	CB
211	Toni	Kroos	Real Madrid	Germany	CM
212	Lionel	Messi	Barcelona	Argentina	RW
213	Luis	Suarez	Barcelona	Uruguay	ST
214	Ousmane	Dembele	Barcelona	France	LW
215	Ivan	Rakitic	Barcelona	Croatia	CM
216	Sergio	Busquets	Barcelona	Spain	CM
217	Gerard	Pique	Barcelona	Spain	CB
218	Samuel	Umtiti	Barcelona	France	CB
219	Marc-Andre	ter Stegen	Barcelona	Germany	GK
220	Nelson	Semedo	Barcelona	Portugal	RB
221	Jordi	Alba	Barcelona	Spain	LB
222	Philippe	Coutinho	Barcelona	Brazil	LW
223	Antoine	Griezmann	Atletico Madrid	France	ST
224	Saul	Niguez	Atletico Madrid	Spain	CM
225	Diego	God¡n	Atletico Madrid	Uruguay	CB
226	Koke	Merodio	Atletico Madrid	Spain	CM
227	Filipe	Luis	Atletico Madrid	Brazil	LB
228	Jan	Oblak	Atletico Madrid	Slovakia	GK
229	Jose	Gimenez	Atletico Madrid	Uruguay	CB
230	Juanfran	Torres	Atletico Madrid	Spain	RB
231	Diego	Costa	Atletico Madrid	Spain	ST
232	Thomas	Lemar	Atletico Madrid	France	LM
233	Angel	Correa	Atletico Madrid	Argentina	RM
234	Wissam	Ben Yedder	Sevilla	France	ST
235	Pablo	Sarabia	Sevilla	Spain	RM
236	Andre	Silva	Sevilla	Portugal	ST
237	Ever	Banega	Sevilla	Argentina	CM
238	Jesus	Navas	Sevilla	Spain	RB
239	Tomas	Vaclik	Sevilla	Czech Republic	GK
240	Quincy	Promes	Sevilla	Netherlands	LW
241	Simon	Kjaer	Sevilla	Denmark	CB
242	Sergi	Gomez	Sevilla	Spain	CB
243	Roque	Mesa	Sevilla	Spain	CM
244	Sergio	Escudero	Sevilla	Spain	LB
301	Manuel	Neuer	Bayern Munich	Germany	GK
302	Robert	Lewandowski	Bayern Munich	Poland	ST
303	Thomas	Muller	Bayern Munich	Germany	ST
304	Corentin	Tolisso	Bayern Munich	France	CM
305	Franck	Ribery	Bayern Munich	France	LW
306	James	Rodriguez	Bayern Munich	Colombia	CM
307	Thiago	Alcantra	Bayern Munich	Spain	CM
308	Mats	Hummels	Bayern Munich	Germany	CB
309	Jerome	Boateng	Bayern Munich	Germany	CB
310	David	Alaba	Bayern Munich	Austria	LB
311	Joshua	Kimmich	Bayern Munich	Germany	RB
312	Marco	Reus	Borussia Dortmund	Germany	LW
313	Paco	Alcacer	Borussia Dortmund	Spain	ST
314	Raphael	Guerreiro	Borussia Dortmund	Portugal	LB
315	Christian	Pulisic	Borussia Dortmund	USA	RW
316	Mario	Gotze	Borussia Dortmund	Germany	CM
317	Abdou	Diallo	Borussia Dortmund	France	CB
318	Lukasz	Piszczek	Borussia Dortmund	Poland	RB
319	Roman	Burki	Borussia Dortmund	Germany	GK
320	Jadon	Sancho	Borussia Dortmund	England	RW
321	Mahmoud	Dahoud	Borussia Dortmund	Germany	CM
322	Omer	Toprak	Borussia Dortmund	Turkey	CB
323	Oscar	Wendt	Borussia Monchengladbach	Sweden	LB
324	Yann	Sommer	Borussia Monchengladbach	Switzerland	GK
325	Nico	Elvedi	Borussia Monchengladbach	Switzerland	CB
326	Jonas	Hofmann	Borussia Monchengladbach	Germany	LM
327	Florian	Neuhaus	Borussia Monchengladbach	Germany	CM
328	Thorgan	Hazard	Borussia Monchengladbach	Belgium	RW
329	Alassane	Plea	Borussia Monchengladbach	France	LW
330	Lars	Stindl	Borussia Monchengladbach	Germany	ST
331	Denis	Zakaria	Borussia Monchengladbach	Switzerland	CM
332	Matthias	Ginter	Borussia Monchengladbach	Germany	CB
333	Fabian	Johnson	Borussia Monchengladbach	USA	RB
334	Emil	Forsberg	RB Leipzig	Sweden	LM
335	Timo	Werner	RB Leipzig	Germany	ST
336	Peter	Gulacsi	RB Leipzig	Hungary	GK
337	Ibrahima	Konate	RB Leipzig	France	CB
338	Lukas	Klostermann	RB Leipzig	Germany	RB
339	Marcel	Sabitzer	RB Leipzig	Austria	CM
340	Diego	Demme	RB Leipzig	Germany	CM
341	Konrad	Laimer	RB Leipzig	Austria	RB
342	Yussuf	Poulsen	RB Leipzig	Denmark	ST
343	Kevin	Kampl	RB Leipzig	Slovakia	CM
344	Willi	Orban	RB Leipzig	Hungary	CB
105	Nemanja	MatiC	Manchester United	Serbia	CM
\.


--
-- Data for Name: position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."position" (id, name) FROM stdin;
GK	Goalkeeper
CM	Midfielder
LB	Left Back
RB	Right Back
CB	Centre Back
LM	Left Midfielder
RM	Right Midfielder
LW	Left Winger
RW	Right Winger
ST	Striker
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, title, date_posted, content, user_id) FROM stdin;
1	First	2020-07-04 08:16:16.531019	First Article	1
2	Second	2020-07-04 08:16:32.29352	Second Article	1
3	My First	2020-07-04 08:17:36.902284	First Article for me!!!!	2
4	Liverpool Champions	2020-07-06 07:04:57.386476	Been a long time since we won it.\r\nProud of the team.\r\nMore to come 	3
5	POTY	2020-07-07 10:34:36.849339	In my view, I feel that Van Djik should be the player of the year.\r\nHes been immense for us. He's sorted that defence quite well!!! 	3
6	Chelsea win against Norwich	2020-07-15 07:25:49.029943	1-0 \r\nIt was a close game.\r\nBut we finally won the game.\r\nSo proud of the guys!!!!	3
8	Man U 2-2 Southampton	2020-07-15 11:29:56.67327	Getting in top top 4 is pretty tensed.\r\nStill believe we can do so.	4
9	Arsenal beat Mancity 2-0	2020-07-19 07:01:47.957437	I didnit expect this to happen gg arsenal\r\n#whatacomeback	2
10	Chelsea 3-5 liverpool	2020-07-24 07:11:40.122142	Damn believed in a comeback.\r\nUnfortunately it couldn't happen. Liverpool continue their unbeaten run.	4
11	Last Day of Premier League	2020-07-25 14:03:29.32281	Tmrw is gonna be a rock and roll game!!!\r\nso Excited!!!!	6
\.


--
-- Data for Name: statistics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.statistics (player_id, year, goals, assists, clean_sheets, appearances, yellow_cards, red_cards, saves) FROM stdin;
100	2017	0	0	14	38	2	0	127
101	2017	1	4	12	35	5	1	0
102	2017	3	1	11	36	8	0	0
103	2017	2	0	9	33	6	1	0
104	2017	3	6	14	35	2	1	0
105	2017	5	4	10	33	3	0	0
106	2017	8	3	7	28	5	0	0
107	2017	6	10	5	30	6	0	0
108	2017	13	4	4	37	2	0	0
109	2017	11	3	5	34	2	0	0
110	2017	17	5	5	32	2	0	0
120	2017	0	0	13	38	2	0	140
121	2017	1	1	11	37	3	2	0
122	2017	2	0	10	36	7	1	0
123	2017	3	2	8	37	6	0	0
124	2017	1	3	9	32	4	1	0
125	2017	4	3	7	36	3	0	0
126	2017	5	7	6	32	1	1	0
127	2017	5	6	6	29	7	0	0
128	2017	10	8	4	38	4	1	0
129	2017	20	2	3	36	4	0	0
130	2017	8	8	5	35	3	0	0
140	2017	0	0	15	38	8	0	135
141	2017	2	1	11	36	6	1	0
142	2017	5	1	10	36	6	0	0
143	2017	4	0	9	38	8	0	0
144	2017	1	4	11	37	7	0	0
145	2017	4	6	7	35	5	1	0
146	2017	5	5	8	33	3	0	0
147	2017	6	7	5	34	4	1	0
148	2017	10	8	8	31	1	1	0
149	2017	12	9	7	32	3	1	0
150	2017	11	12	4	33	3	0	0
160	2017	0	0	12	38	1	0	149
161	2017	2	0	11	38	0	0	0
162	2017	3	1	10	36	4	1	0
163	2017	4	3	9	34	5	1	0
164	2017	1	2	10	33	9	0	0
165	2017	5	4	7	38	2	0	0
166	2017	4	5	8	37	4	0	0
167	2017	7	7	9	36	5	0	0
168	2017	10	4	6	29	6	1	0
169	2017	13	5	7	31	3	1	0
170	2017	19	2	3	30	2	0	0
301	2017	0	0	14	38	2	0	127
302	2017	1	4	12	35	5	1	0
303	2017	2	0	10	36	7	1	0
304	2017	2	0	9	33	6	1	0
305	2017	3	6	14	35	2	1	0
306	2017	5	4	10	33	3	0	0
307	2017	8	3	7	28	5	0	0
308	2017	6	10	5	30	6	0	0
309	2017	13	4	4	37	2	0	0
310	2017	11	3	5	34	2	0	0
311	2017	17	5	5	32	2	0	0
312	2017	0	0	13	38	2	0	139
313	2017	5	1	10	38	4	0	0
314	2017	3	3	11	38	2	0	0
315	2017	2	2	12	38	3	0	0
316	2017	1	6	10	38	6	0	0
317	2017	4	9	7	30	6	0	0
318	2017	6	5	8	32	6	1	0
319	2017	8	7	9	34	6	0	0
320	2017	10	3	5	35	2	0	0
321	2017	12	3	6	36	3	0	0
322	2017	14	3	4	37	4	0	0
323	2017	0	0	15	38	8	0	135
324	2017	2	1	11	36	6	1	0
325	2017	5	1	10	36	6	0	0
326	2017	4	0	9	38	8	0	0
327	2017	1	4	11	37	7	0	0
328	2017	4	6	7	35	5	1	0
329	2017	5	5	8	33	3	0	0
330	2017	6	7	5	34	4	1	0
331	2017	10	8	8	31	1	1	0
332	2017	12	9	7	32	3	1	0
333	2017	11	12	4	33	3	0	0
334	2017	0	0	16	38	1	0	159
335	2017	0	1	15	25	2	0	0
336	2017	7	0	14	38	4	0	0
337	2017	1	0	13	38	4	0	0
338	2017	0	3	15	30	0	0	0
339	2017	7	5	11	32	5	0	0
340	2017	8	5	10	36	6	0	0
341	2017	9	5	12	35	3	0	0
342	2017	20	6	7	38	8	0	0
343	2017	20	6	7	38	8	0	0
344	2017	19	0	9	38	1	0	0
201	2017	19	7	14	34	4	0	0
202	2017	15	6	12	30	4	2	0
203	2017	9	3	16	35	7	2	0
204	2017	7	13	17	37	5	0	0
205	2017	4	1	16	35	5	2	0
206	2017	3	5	17	37	7	0	0
207	2017	5	7	16	36	6	1	0
208	2017	9	4	13	32	3	0	0
209	2017	0	0	17	38	2	0	90
210	2017	4	0	17	37	4	1	0
211	2017	4	14	16	36	5	1	0
212	2017	38	17	17	35	4	0	0
213	2017	25	10	16	35	7	1	0
214	2017	8	4	15	33	4	0	0
215	2017	7	10	19	37	3	1	0
216	2017	0	3	18	36	5	1	0
217	2017	7	3	17	35	6	2	0
218	2017	5	1	19	37	5	1	0
219	2017	0	0	19	38	1	0	100
220	2017	2	5	14	30	3	2	0
221	2017	3	12	16	34	4	1	0
222	2017	14	8	15	32	2	0	0
223	2017	25	10	21	37	2	1	0
224	2017	8	4	21	36	4	0	0
225	2017	4	2	20	34	6	2	0
226	2017	6	10	20	35	3	0	0
227	2017	3	4	19	32	2	2	0
228	2017	0	0	21	38	1	0	120
229	2017	2	0	20	36	3	1	0
230	2017	0	3	15	30	4	0	0
231	2017	17	5	15	31	5	3	0
232	2017	5	4	16	33	4	0	0
233	2017	7	6	17	34	3	1	0
234	2017	24	8	7	37	2	1	0
235	2017	14	9	7	36	3	1	0
236	2017	15	3	7	34	4	0	0
237	2017	5	6	7	36	4	1	0
238	2017	6	9	6	35	6	0	0
239	2017	0	0	8	38	0	0	110
240	2017	6	4	6	33	4	0	0
241	2017	3	0	5	34	4	2	0
242	2017	0	1	7	35	6	1	0
243	2017	2	3	7	36	2	1	0
244	2017	0	2	4	32	3	2	0
100	2018	0	0	17	36	3	1	167
101	2018	0	2	11	37	2	0	0
102	2018	1	3	17	38	6	0	0
103	2018	2	5	16	38	6	0	0
104	2018	1	2	13	32	4	0	0
105	2018	4	7	10	30	3	0	0
106	2018	9	9	8	30	5	0	0
107	2018	10	3	9	35	6	1	0
108	2018	7	4	11	33	1	0	0
109	2018	13	2	10	26	0	0	0
110	2018	15	1	10	28	2	0	0
120	2018	0	0	13	38	2	0	139
121	2018	5	1	10	38	4	0	0
122	2018	3	3	11	38	2	0	0
123	2018	2	2	12	38	3	0	0
124	2018	1	6	10	38	6	0	0
125	2018	4	9	7	30	6	0	0
126	2018	6	5	8	32	6	1	0
127	2018	8	7	9	34	6	0	0
128	2018	10	3	5	35	2	0	0
129	2018	12	3	6	36	3	0	0
130	2018	14	3	4	37	4	0	0
140	2018	0	0	14	38	0	0	150
141	2018	3	1	13	38	1	0	0
142	2018	1	0	12	38	2	0	0
143	2018	1	0	11	38	3	0	0
144	2018	2	4	12	37	4	0	0
145	2018	10	3	6	31	2	0	0
146	2018	8	4	7	32	7	2	0
147	2018	9	7	8	33	5	0	0
148	2018	16	0	8	38	6	0	0
149	2018	15	0	7	38	0	0	0
150	2018	5	10	6	30	0	0	0
160	2018	0	0	16	38	1	0	159
161	2018	0	1	15	25	2	0	0
162	2018	7	0	14	38	4	0	0
163	2018	1	0	13	38	4	0	0
164	2018	0	3	15	30	0	0	0
165	2018	7	5	11	32	5	0	0
166	2018	8	5	10	36	6	0	0
167	2018	9	5	12	35	3	0	0
168	2018	20	6	7	38	8	0	0
169	2018	6	4	8	38	4	0	0
170	2018	19	0	9	38	1	0	0
201	2018	13	4	10	28	4	0	0
202	2018	10	4	10	22	0	0	0
203	2018	6	1	10	26	5	1	0
204	2018	4	8	10	27	5	0	0
205	2018	3	0	10	23	4	1	0
206	2018	1	3	8	17	6	0	0
207	2018	3	4	8	15	4	0	0
208	2018	6	3	7	17	1	0	0
209	2018	0	0	10	24	2	0	50
210	2018	2	0	8	24	0	1	0
211	2018	2	9	7	21	1	0	0
212	2018	29	12	9	26	3	0	0
213	2018	18	6	9	27	4	1	0
214	2018	8	4	9	24	2	0	0
215	2018	4	6	10	27	0	1	0
216	2018	0	1	10	27	4	0	0
217	2018	4	2	10	28	3	0	0
218	2018	0	1	3	9	0	0	0
219	2018	0	0	10	28	0	0	65
220	2018	1	4	9	19	2	1	0
221	2018	2	7	13	27	2	0	0
222	2018	9	4	13	26	1	0	0
223	2018	16	7	13	28	1	0	0
224	2018	3	1	12	24	2	0	0
225	2018	2	1	11	21	1	0	0
226	2018	4	2	10	20	0	0	0
227	2018	2	2	8	17	1	0	0
228	2018	0	0	13	28	0	0	70
229	2018	1	0	2	17	3	1	0
230	2018	0	1	2	14	2	0	0
231	2018	7	2	2	14	3	0	0
232	2018	4	3	6	24	2	0	0
233	2018	2	4	7	26	1	2	0
234	2018	16	6	7	25	1	0	0
235	2018	9	9	7	26	4	0	0
236	2018	9	0	7	26	3	1	0
237	2018	3	2	7	26	2	1	0
238	2018	3	5	6	23	4	0	0
239	2018	0	0	8	26	0	0	80
240	2018	1	3	6	25	3	0	0
241	2018	1	0	5	21	2	1	0
242	2018	0	0	7	26	1	0	0
243	2018	1	2	7	23	2	0	0
244	2018	0	1	4	15	0	0	0
301	2018	0	0	13	28	1	0	80
302	2018	22	5	12	24	3	0	0
303	2018	13	6	12	23	3	1	0
304	2018	3	4	8	17	3	1	0
305	2018	10	7	12	23	5	0	0
306	2018	6	10	10	22	3	1	0
307	2018	2	2	6	16	2	0	0
308	2018	2	0	12	27	4	1	0
309	2018	0	0	13	26	5	1	0
310	2018	3	5	12	25	0	0	0
311	2018	5	6	13	26	1	1	0
312	2018	17	10	12	26	1	0	0
313	2018	15	7	9	20	2	0	0
314	2018	3	2	8	18	3	0	0
315	2018	4	3	9	19	0	0	0
316	2018	2	4	10	22	3	1	0
317	2018	2	0	10	28	4	2	0
318	2018	0	3	7	19	2	0	0
319	2018	0	0	12	28	0	0	75
320	2018	10	6	11	24	0	0	0
321	2018	2	1	6	16	1	0	0
322	2018	0	0	8	18	3	1	0
323	2018	1	3	12	27	2	0	0
324	2018	0	0	12	28	0	0	90
325	2018	0	0	11	26	3	2	0
326	2018	8	4	10	24	1	0	0
327	2018	1	1	9	21	2	1	0
328	2018	13	8	12	28	1	0	0
329	2018	9	6	11	25	0	0	0
330	2018	10	4	12	26	1	0	0
331	2018	0	1	12	27	4	1	0
332	2018	2	0	10	22	5	0	0
333	2018	0	2	9	20	3	1	0
334	2018	6	9	9	26	1	0	0
335	2018	15	7	10	28	2	0	0
336	2018	0	0	10	27	0	0	60
337	2018	1	0	9	26	4	2	0
338	2018	0	2	5	20	2	0	0
339	2018	0	1	7	22	3	1	0
340	2018	1	2	9	26	2	1	0
341	2018	1	1	10	27	3	0	0
342	2018	9	5	10	26	1	0	0
343	2018	3	1	6	20	3	1	0
344	2018	2	0	4	15	2	1	0
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team (name, league_name, coach_id, league_position, stadium, city, founded) FROM stdin;
Chelsea	Premier League	001	4	Stamford Bridge	London	1905
Manchester United	Premier League	002	2	Old Trafford	Manchester	1878
Manchester City	Premier League	003	1	City of Manchester	Manchester	1880
Liverpool	Premier League	004	3	Anfield	Liverpool	1892
Barcelona	La Liga	011	1	Camp Nou	Barcelona	1899
Atletico Madrid	La Liga	012	3	Santiago Bernabeu	Madrid	1902
Real Madrid	La Liga	013	2	Wanda Metropolitano	Madrid	1903
Sevilla	La Liga	014	4	Ramon Sanchez Pizjuan	Seville	1890
Borussia Dortmund	Bundesliga	021	2	Allianz Arena	Dortmund	1900
Bayern Munich	Bundesliga	022	1	Westfalenstadion	Munich	1909
RB Leipzig	Bundesliga	023	3	Red Bull Arena	Leipzig	2009
Borussia Monchengladbach	Bundesliga	024	4	Borussia-Park	Monchengladbach	1900
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, image_file, password) FROM stdin;
1	Jeeva	Jeeva@gmail.com	default.jpg	$2b$12$fGfgoXRdgAJ0rto2/5rntOBq6GMkgO2jtLDOxt411k2jL9D1UPtcu
3	Bhima	buisnessdsouza@gmail.com	a6fa8a4bebd4d1fb.png	$2b$12$/9lPk/ILKy1wK/yRkhyhcuvU2J8XrsPLJdQwI3jl5vN8yAOKDWbbG
4	Max	clyson1@hotmail.com	281d65ca4677883e.jpg	$2b$12$s356FLYIlpRfNZaBsQ7wDe3QJsL8fpj5DVZTBm.SA3i7nnb0/q9wq
2	Admin	clysondsouza1@gmail.com	9b1c5e7fc2318499.jpg	$2b$12$3FTjUj3HQPQzzHPvyhraW.IA69kLMWti9Ig8zEs3n/bTJ21GcTfIe
6	Ramos	ramos@gmail.com	1f5fa6ef2a9bce41.jpg	$2b$12$C3zEUratnf2llIHwNqa8ouf1jlptczgGEoJVj4VZVbmONpbKO9Ppu
\.


--
-- Name: feedbacks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feedbacks_id_seq', 4, true);


--
-- Name: friend_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.friend_request_id_seq', 7, true);


--
-- Name: friendrequest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.friendrequest_id_seq', 1, false);


--
-- Name: friends_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.friends_id_seq', 8, true);


--
-- Name: group_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.group_members_id_seq', 1, true);


--
-- Name: group_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.group_messages_id_seq', 1, false);


--
-- Name: groupmembers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groupmembers_id_seq', 1, false);


--
-- Name: groupmessages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.groupmessages_id_seq', 1, false);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_seq', 36, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_id_seq', 11, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- Name: coach coach_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach
    ADD CONSTRAINT coach_pkey PRIMARY KEY (id);


--
-- Name: feedbacks feedbacks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT feedbacks_pkey PRIMARY KEY (id);


--
-- Name: friend_request friend_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friend_request
    ADD CONSTRAINT friend_request_pkey PRIMARY KEY (id);


--
-- Name: friendrequest friendrequest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendrequest
    ADD CONSTRAINT friendrequest_pkey PRIMARY KEY (id);


--
-- Name: friends friends_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_pkey PRIMARY KEY (id);


--
-- Name: group_members group_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT group_members_pkey PRIMARY KEY (id);


--
-- Name: group_messages group_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_messages
    ADD CONSTRAINT group_messages_pkey PRIMARY KEY (id);


--
-- Name: groupmembers groupmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupmembers
    ADD CONSTRAINT groupmembers_pkey PRIMARY KEY (id);


--
-- Name: groupmessages groupmessages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupmessages
    ADD CONSTRAINT groupmessages_pkey PRIMARY KEY (id);


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: league league_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.league
    ADD CONSTRAINT league_pkey PRIMARY KEY (name);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: nationality nationality_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nationality
    ADD CONSTRAINT nationality_pkey PRIMARY KEY (name);


--
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pkey PRIMARY KEY (id);


--
-- Name: position position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."position"
    ADD CONSTRAINT position_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: statistics statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statistics
    ADD CONSTRAINT statistics_pkey PRIMARY KEY (player_id, year);


--
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (name);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: coach coach_nation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach
    ADD CONSTRAINT coach_nation_fkey FOREIGN KEY (nation) REFERENCES public.nationality(name);


--
-- Name: friend_request friend_request_user_id1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friend_request
    ADD CONSTRAINT friend_request_user_id1_fkey FOREIGN KEY (user_id1) REFERENCES public.users(id);


--
-- Name: friend_request friend_request_user_id2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friend_request
    ADD CONSTRAINT friend_request_user_id2_fkey FOREIGN KEY (user_id2) REFERENCES public.users(id);


--
-- Name: friendrequest friendrequest_user_id1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendrequest
    ADD CONSTRAINT friendrequest_user_id1_fkey FOREIGN KEY (user_id1) REFERENCES public.users(id);


--
-- Name: friendrequest friendrequest_user_id2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friendrequest
    ADD CONSTRAINT friendrequest_user_id2_fkey FOREIGN KEY (user_id2) REFERENCES public.users(id);


--
-- Name: friends friends_user_id1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_user_id1_fkey FOREIGN KEY (user_id1) REFERENCES public.users(id);


--
-- Name: friends friends_user_id2_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_user_id2_fkey FOREIGN KEY (user_id2) REFERENCES public.users(id);


--
-- Name: group_members group_members_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT group_members_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- Name: group_members group_members_member_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_members
    ADD CONSTRAINT group_members_member_fkey FOREIGN KEY (member) REFERENCES public.users(id);


--
-- Name: group_messages group_messages_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_messages
    ADD CONSTRAINT group_messages_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- Name: groupmembers groupmembers_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupmembers
    ADD CONSTRAINT groupmembers_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- Name: groupmembers groupmembers_member_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupmembers
    ADD CONSTRAINT groupmembers_member_fkey FOREIGN KEY (member) REFERENCES public.users(id);


--
-- Name: groupmessages groupmessages_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groupmessages
    ADD CONSTRAINT groupmessages_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id);


--
-- Name: groups groups_admin_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_admin_fkey FOREIGN KEY (admin) REFERENCES public.users(id);


--
-- Name: messages messages_friend_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_friend_id_fkey FOREIGN KEY (friend_id) REFERENCES public.friends(id);


--
-- Name: player player_nation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_nation_fkey FOREIGN KEY (nation) REFERENCES public.nationality(name);


--
-- Name: player player_position_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_position_fkey FOREIGN KEY ("position") REFERENCES public."position"(id);


--
-- Name: player player_team_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_team_name_fkey FOREIGN KEY (team_name) REFERENCES public.team(name);


--
-- Name: posts posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: statistics statistics_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statistics
    ADD CONSTRAINT statistics_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(id);


--
-- Name: team team_coach_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_coach_id_fkey FOREIGN KEY (coach_id) REFERENCES public.coach(id);


--
-- Name: team team_league_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_league_name_fkey FOREIGN KEY (league_name) REFERENCES public.league(name);


--
-- PostgreSQL database dump complete
--

