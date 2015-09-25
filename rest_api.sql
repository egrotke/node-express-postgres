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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: egrotke; Tablespace: 
--

CREATE TABLE accounts (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    nickname character varying(128) NOT NULL,
    acct_no character varying(32) NOT NULL,
    account_type character varying(128) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    is_internal boolean NOT NULL,
    balance numeric(64,2) NOT NULL,
    available_balance numeric(64,2) NOT NULL,
    apy numeric(32,2) NOT NULL,
    interest_rate numeric(32,2) NOT NULL,
    swift_code character varying(32) NOT NULL,
    odloc_account smallint NOT NULL,
    ytd_interest numeric(32,2) NOT NULL,
    accrued_interest numeric(32,2) NOT NULL,
    lastyear_interest numeric(32,2) NOT NULL,
    routing_string character varying(256) NOT NULL,
    routing_number integer NOT NULL,
    shortname character varying(64) NOT NULL,
    account_type_long character varying(128) NOT NULL,
    principal_balance numeric(64,2) NOT NULL,
    available_credit numeric(32,2) NOT NULL,
    issue_date timestamp without time zone NOT NULL,
    maturity_date timestamp without time zone NOT NULL,
    as_of timestamp without time zone NOT NULL,
    issue_amount numeric(32,2) NOT NULL,
    renewal_date timestamp without time zone NOT NULL,
    term character varying(32) NOT NULL,
    bills integer[],
    transfers integer[],
    deposits integer[],
    transactions integer[],
    second_user integer
);


ALTER TABLE accounts OWNER TO egrotke;

--
-- Name: accounttypes; Type: TABLE; Schema: public; Owner: egrotke; Tablespace: 
--

CREATE TABLE accounttypes (
    id smallint NOT NULL,
    name character varying(128) NOT NULL,
    token character varying(128) NOT NULL,
    balance_meta character varying(128) NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    accounts_from_type integer[]
);


ALTER TABLE accounttypes OWNER TO egrotke;

--
-- Name: billers; Type: TABLE; Schema: public; Owner: egrotke; Tablespace: 
--

CREATE TABLE billers (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    ebill smallint NOT NULL,
    user_id integer NOT NULL,
    lastamount numeric(32,0) NOT NULL,
    lastdate timestamp without time zone NOT NULL
);


ALTER TABLE billers OWNER TO egrotke;

--
-- Name: bills; Type: TABLE; Schema: public; Owner: egrotke; Tablespace: 
--

CREATE TABLE bills (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    number integer NOT NULL,
    amount numeric(10,0) NOT NULL,
    pay_date timestamp without time zone NOT NULL,
    scheduled smallint NOT NULL,
    user_id integer NOT NULL,
    account integer NOT NULL,
    biller integer NOT NULL,
    ebill integer NOT NULL
);


ALTER TABLE bills OWNER TO egrotke;

--
-- Name: deposits; Type: TABLE; Schema: public; Owner: egrotke; Tablespace: 
--

CREATE TABLE deposits (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    amount numeric(10,0) NOT NULL,
    name character varying(128) NOT NULL,
    meta character varying(128) NOT NULL,
    account integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE deposits OWNER TO egrotke;

--
-- Name: recipients; Type: TABLE; Schema: public; Owner: egrotke; Tablespace: 
--

CREATE TABLE recipients (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    phone_no character varying(32) NOT NULL,
    email character varying(64) NOT NULL,
    user_id integer NOT NULL,
    lastdate timestamp without time zone NOT NULL,
    lastamount numeric(10,0) NOT NULL
);


ALTER TABLE recipients OWNER TO egrotke;

--
-- Name: transactions; Type: TABLE; Schema: public; Owner: egrotke; Tablespace: 
--

CREATE TABLE transactions (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    description character varying(256) NOT NULL,
    amount numeric(64,2) NOT NULL,
    balance numeric(64,2) NOT NULL,
    category character varying(64) NOT NULL,
    account_id integer NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    transaction_type character varying(128) NOT NULL,
    name character varying(128) NOT NULL,
    location character varying(128) NOT NULL,
    age integer NOT NULL,
    transaction_age integer NOT NULL,
    hascheck smallint NOT NULL
);


ALTER TABLE transactions OWNER TO egrotke;

--
-- Name: transfers; Type: TABLE; Schema: public; Owner: egrotke; Tablespace: 
--

CREATE TABLE transfers (
    id integer NOT NULL,
    user_id integer NOT NULL,
    account integer NOT NULL,
    recipient character varying(64) NOT NULL,
    location character varying(128) NOT NULL,
    amount numeric(10,0) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    transaction_type character varying(64) NOT NULL,
    favorited smallint NOT NULL,
    scheduled smallint NOT NULL,
    is_personal smallint NOT NULL,
    is_internal smallint NOT NULL,
    recurrence character varying(64)
);


ALTER TABLE transfers OWNER TO egrotke;

--
-- Name: users; Type: TABLE; Schema: public; Owner: egrotke; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    lastname character varying(255) DEFAULT NULL::character varying,
    email character varying(255) DEFAULT NULL::character varying,
    password character varying(255) DEFAULT NULL::character varying,
    firstname character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    accounts integer[],
    accounttypes integer[],
    billers integer[],
    bills integer[],
    transfers integer[],
    deposits integer[],
    recipients integer[],
    username character varying(255)
);


ALTER TABLE users OWNER TO egrotke;

--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: egrotke
--

COPY accounts (id, name, nickname, acct_no, account_type, created_at, updated_at, is_internal, balance, available_balance, apy, interest_rate, swift_code, odloc_account, ytd_interest, accrued_interest, lastyear_interest, routing_string, routing_number, shortname, account_type_long, principal_balance, available_credit, issue_date, maturity_date, as_of, issue_amount, renewal_date, term, bills, transfers, deposits, transactions, second_user) FROM stdin;
10	C RILEY IRA ROLL - H3L 12345	C RIley IRA ROLL - H3L 12345	#8857	Investment	2010-02-06 00:00:00	2015-05-06 10:15:00	f	2600351.64	2600351.64	0.00	0.00		0	0.00	0.00	0.00		0		false	0.00	0.00	2015-04-29 00:00:00	2015-04-29 00:00:00	2015-04-29 00:00:00	0.00	2015-04-29 00:00:00		{}	{}	{}	{}	\N
4	Self Directed - H3L015225	Wells Fargo — Brokerage	#6112	Investment	2010-02-06 00:00:00	2015-05-06 10:15:00	t	850650.21	850650.21	0.00	0.00		0	0.00	0.00	0.00		0		false	0.00	0.00	2015-04-29 00:00:00	2015-04-29 00:00:00	2015-04-29 00:00:00	0.00	2015-04-29 00:00:00		{}	{}	{}	{}	\N
0	DDA Account	Family Checking	#1234	Checking	2015-02-06 00:00:00	2015-05-06 00:00:00	t	160058.34	160032.52	0.00	0.00	FRBBUS6S	0	0.00	0.00	0.00	Check West Coast 321081669 |Check Connecticut and Massachusetts 211475000 |East Coast  026013220 |ACH 321081669 | Wire 321081669 | International  Wire SWIFT Code: FRBBUS6S	321081669	shortname	ATM Rebate Checking	0.00	0.00	2015-04-29 00:00:00	2015-04-29 00:00:00	2015-04-29 00:00:00	0.00	2015-04-29 00:00:00	x months	{0,1,2,3,4,5,6,7}	{0,1,2,3,4,5}	{0,1}	{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51}	\N
1	SAV Account	College Fund	#2211	Savings	2015-02-06 00:00:00	2015-05-06 10:15:00	t	37708.01	37708.01	0.09	0.08	FRBBUS6S	0	4.80	10.87	57.76	Check West Coast 1081669 |Check Connecticut and Massachusetts 211475000 |East Coast  026013220 |ACH 321081669 | Wire 321081669 | International  Wire SWIFT Code: FRBBUS6S	1081669		false	0.00	0.00	2015-04-29 00:00:00	2015-04-29 00:00:00	2015-04-29 00:00:00	0.00	2015-04-29 00:00:00	x months	{}	{}	{}	{52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95}	\N
2	CD Account	CD Account	#9012	Certificate of Deposit	2015-02-06 00:00:00	2015-05-06 10:15:00	t	558760.25	558760.25	2.50	2.47		0	3392.62	1547.34	10.56	Check West Coast 1081669 |Check Connecticut and Massachusetts 211475000 |East Coast  026013220 |ACH 321081669 | Wire 321081669 | International  Wire SWIFT Code: FRBBUS6S	1081669		false	0.00	0.00	2015-04-29 00:00:00	2015-04-29 00:00:00	2015-04-29 00:00:00	0.00	2015-04-29 00:00:00	x months	{}	{}	{}	{96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114}	\N
12	SAV Account 3	Wells Fargo - Chris & Pat Hostler Account	#3456	Savings	2015-02-06 00:00:00	2015-05-06 10:15:00	f	385721.08	385721.08	0.09	0.08		0	4.80	10.87	57.76		26013220	Wells Fargo	false	0.00	0.00	2015-04-29 00:00:00	2015-04-29 00:00:00	2015-04-29 00:00:00	0.00	2015-04-29 00:00:00		{}	{}	{}	{}	\N
11	SAV Account 2	Vacation	#6002	Savings	2015-02-06 00:00:00	2015-05-06 10:15:00	t	1598002.84	1598002.84	0.09	0.08		0	4.80	10.87	57.76		211475000		true	0.00	0.00	2015-04-29 00:00:00	2015-04-29 00:00:00	2015-04-29 00:00:00	0.00	2015-04-29 00:00:00		{}	{}	{}	{}	\N
13	DDA Account 2	Tahoe House	#7598	Checking	2010-02-06 00:00:00	2015-05-06 10:15:00	t	569206.22	569206.22	0.00	0.00		0	0.00	0.00	0.00		123456789		false	0.00	0.00	2015-04-29 00:00:00	2015-04-29 00:00:00	2015-04-29 00:00:00	0.00	2015-04-29 00:00:00	x months	{}	{}	{}	\N	\N
9	CREDITCARD	Chase Credit Card	#4326	Credit Card	2010-02-06 00:00:00	2015-05-06 10:15:00	t	1000.00	1000.00	3.26	3.25		0	9050.85	1547.34	46281.42		0	Chase Bank	false	0.00	0.00	2015-04-29 00:00:00	2015-04-29 00:00:00	2015-04-29 00:00:00	0.00	2015-04-29 00:00:00		{}	{}	{}	{161,162,163,164}	\N
3	DDA Account 2	Tahoe House	#7598	Checking	2010-02-06 00:00:00	2015-05-06 10:15:00	t	569206.22	569206.22	0.00	0.00		0	0.00	0.00	0.00		123456789		false	0.00	0.00	2015-04-29 00:00:00	2015-04-29 00:00:00	2015-04-29 00:00:00	0.00	2015-04-29 00:00:00	x months	{}	{}	{}	{165,166,167,168,169,170,171,172,173}	1
5	ETrade — Brokerage	E*Trade — Brokerage	#9837	Investment	2010-02-06 00:00:00	2015-05-06 10:15:00	t	16090.20	16090.20	0.00	0.00		0	0.00	0.00	0.00		0	E*Trade	false	0.00	0.00	2015-04-29 00:00:00	2015-04-29 00:00:00	2015-04-29 00:00:00	0.00	2015-04-29 00:00:00		{}	{}	{}	{}	1
8	ODLOC	ODLOC	#0112	Overdraft Line of Credit	2010-02-06 00:00:00	2015-02-06 10:15:00	t	4024.52	0.00	3.26	3.25		0	9050.85	1547.34	46281.42		0		false	4024.52	0.00	2015-04-29 00:00:00	2015-04-29 00:00:00	2015-04-29 00:00:00	0.00	2015-04-29 00:00:00		{}	{}	{}	{174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194}	\N
6	Mortgage Loan	Tahoe House	#0132	Mortgage Loan	2010-02-06 00:00:00	2015-02-06 10:15:00	t	1183999.39	1183999.39	3.75	3.65		0	14466.15	1547.34	46281.42		0		false	1183999.39	0.00	2015-04-29 00:00:00	2015-04-29 00:00:00	2015-04-29 00:00:00	0.00	2015-04-29 00:00:00	xx months	{}	{}	{}	{115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134}	1
7	Home Equity	Tahoe House LOC	#3210	Home Equity	2010-02-06 00:00:00	2015-02-06 10:15:00	t	625417.06	174582.94	3.26	3.25		0	9050.85	1547.34	46281.42		0		false	625417.06	0.00	2015-04-29 00:00:00	2015-04-29 00:00:00	2015-04-29 00:00:00	0.00	2015-04-29 00:00:00	xx months	{}	{}	{}	{135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156}	\N
\.


--
-- Data for Name: accounttypes; Type: TABLE DATA; Schema: public; Owner: egrotke
--

COPY accounttypes (id, name, token, balance_meta, user_id, created_at, updated_at, accounts_from_type) FROM stdin;
1	Loans	Loans	owed	0	2015-01-06 00:00:00	2015-03-06 00:00:00	{6,7,8}
0	Checking, Savings & CDs	CheckingSavingsCDs	available	0	2015-01-06 00:00:00	2015-03-06 00:00:00	{0,3}
3	Credit Cards	CreditCards	owed	0	2015-01-06 00:00:00	2015-03-06 00:00:00	{9}
5	Loans	Loans	owed	1	2015-01-06 00:00:00	2015-01-06 00:00:00	{6}
6	Investment	Investents	''	1	2015-01-06 00:00:00	2015-01-06 00:00:00	{5}
2	Investments	Investments		0	2015-01-06 00:00:00	2015-03-06 00:00:00	{10,4,5}
4	Checking, Savings & CDs	CheckingSavingsCDs	available	1	2015-01-06 00:00:00	2015-01-06 00:00:00	{0,3}
\.


--
-- Data for Name: billers; Type: TABLE DATA; Schema: public; Owner: egrotke
--

COPY billers (id, name, ebill, user_id, lastamount, lastdate) FROM stdin;
0	AT&T Wireless	0	0	120	2015-03-13 00:00:00
1	Bob's Donuts	1	0	320	2015-03-17 00:00:00
2	Comcast	1	0	170	2015-03-03 00:00:00
3	Randall Electric, Inc.	0	0	320	2015-02-23 00:00:00
4	AT&T Uverse	0	0	150	2015-03-23 00:00:00
5	Tahoe House Mortgage	1	0	2120	2015-03-22 00:00:00
6	PG&E	0	0	60	2015-03-17 00:00:00
7	Freddy's Firewood	0	0	20	2015-03-24 00:00:00
8	Bob's Landscaping	0	1	320	2015-01-13 00:00:00
\.


--
-- Data for Name: bills; Type: TABLE DATA; Schema: public; Owner: egrotke
--

COPY bills (id, name, number, amount, pay_date, scheduled, user_id, account, biller, ebill) FROM stdin;
0	AT&T Wireless	456	65	2015-06-13 00:00:00	1	0	0	0	0
1	Bobs Donuts	457	13	2015-06-12 00:00:00	0	0	0	0	0
2	Comcast	458	53	2015-05-30 00:00:00	0	0	0	0	0
3	Randall Electric, Inc.	6458	73	2015-05-30 00:00:00	0	0	0	0	0
4	AT&T Uverse	1458	113	2015-04-20 00:00:00	0	0	0	0	1
5	Tahoe House Mortgage	2458	1113	2015-05-25 00:00:00	0	0	0	0	1
6	PG&E	5458	63	2015-05-15 00:00:00	0	0	0	0	0
7	Freddy's Firewood	1458	23	2015-06-21 00:00:00	0	0	0	0	0
8	Silver Crest Donuts	233	120	2015-06-21 00:00:00	1	1	1	1	0
\.


--
-- Data for Name: deposits; Type: TABLE DATA; Schema: public; Owner: egrotke
--

COPY deposits (id, created_at, amount, name, meta, account, user_id) FROM stdin;
0	2015-04-25 00:00:00	5000	Family Checking	Checking #1234	0	0
1	2015-04-15 00:00:00	5000	Tahoe House	Checking #7589	3	0
2	2015-04-05 00:00:00	230	Tahoe House	Savings #7598	3	0
3	2015-03-25 00:00:00	1500	Family Checking	Checking #1234	0	0
4	2015-03-23 00:00:00	7234	Tahoe House	Checking #7589	3	0
\.


--
-- Data for Name: recipients; Type: TABLE DATA; Schema: public; Owner: egrotke
--

COPY recipients (id, name, phone_no, email, user_id, lastdate, lastamount) FROM stdin;
0	Aaron Jacobsen	415-234-1256	ajacobsen@gmail.com	0	2015-01-13 00:00:00	50
1	Allen Jeffries	415-234-1256	ajeffries@gmail.com	0	2015-03-23 00:00:00	520
2	Angela Daugherty	555-234-9876	aDaugherty@yahoo.com	0	2015-03-15 00:00:00	1120
3	Ashley Jacobs	555-234-9876	aJacobs@hotmail.com	0	2015-02-13 00:00:00	120
4	Anna Vandervan	510-234-9876	avandervan@hotmail.com	1	2015-02-13 00:00:00	60
5	Amanda Warner	510-234-9876	awarner@gmail.com	1	2015-02-23 00:00:00	40
6	Anthony Hintz	555-234-9876	ahintz@gmail.com	1	2015-03-23 00:00:00	130
7	Ari Bigsby	555-234-9876	abigsby@gmail.com	1	2015-05-11 00:00:00	56
8	Jill Jankowski	415-234-2344	jjankowski@gmail.com	1	2015-06-08 00:00:00	88
9	Lawrence Oliosh	415-234-7655	loliosh@gmail.com	1	2015-01-13 00:00:00	3000
10	Rishi Chandar	415-234-2344	rchandar@gmail.com	1	2015-06-13 00:00:00	1000
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: egrotke
--

COPY transactions (id, created_at, description, amount, balance, category, account_id, updated_at, transaction_type, name, location, age, transaction_age, hascheck) FROM stdin;
12	2015-06-01 00:00:00	ATM WITHDRAWAL #9004 620 WEST FIELD RD SAN FRANCISCOCA	-301.50	162811.50	ATM/Cash Withdrawals	0	2015-04-29 00:00:00				0	0	0
8	2015-06-04 00:00:00	CHECK # 5134 CHECK WITHDRAWAL	-825.00	155770.60	ATM/Cash Withdrawals	0	2015-04-29 00:00:00				0	0	0
84	2010-12-31 00:00:00	Interest Deposit	14.51	12185.88	Deposit	1	2015-04-29 00:00:00				0	0	0
89	2010-06-30 00:00:00	Interest Deposit	49.89	25140.39	Interest	1	2015-04-29 00:00:00				0	0	0
68	2013-03-01 00:00:00	Deposit - On-Us Items & Multiple Checks	50000.00	67621.38	Deposit	1	2015-04-29 00:00:00				0	0	0
77	2011-12-31 00:00:00	Interest Deposit	7.31	32551.72	Deposit	1	2015-04-29 00:00:00				0	0	0
76	2012-02-03 00:00:00	Deposit - On-Us Items & Multiple Checks	40000.00	72551.72	Deposit	1	2015-04-29 00:00:00				0	0	0
79	2011-09-19 00:00:00	Transfer Deposit - Existing Account	2280.70	32519.02	Deposit	1	2015-04-29 00:00:00				0	0	0
72	2012-07-16 00:00:00	Withdrawal - Partial DDA only	-35000.00	27614.66	Withdrawal	1	2015-04-29 00:00:00				0	0	0
73	2012-06-29 00:00:00	Interest Deposit	45.53	62614.66	Deposit	1	2015-04-29 00:00:00				0	0	0
88	2010-07-15 00:00:00	Withdrawal - Partial DDA only	-8000.00	17140.39	Withdrawal	1	2015-04-29 00:00:00				0	0	0
85	2010-11-17 00:00:00	Withdrawal - Partial DDA only	-3000.00	12171.37	Withdrawal	1	2015-04-29 00:00:00				0	0	0
66	2013-03-29 00:00:00	Interest Deposit	0.93	47622.31	Deposit	1	2015-04-29 00:00:00				0	0	0
94	2009-09-16 00:00:00	Deposit - On-Us Items & Multiple Checks	2400.00	10017.67	Deposit	1	2015-04-29 00:00:00				0	0	0
63	2013-10-29 00:00:00	Withdrawal - Partial DDA only	-15000.00	32640.32	Withdrawal	1	2015-04-29 00:00:00				0	0	0
96	2015-03-16 00:00:00	Interest Deposit - Accrued	3392.62	558760.25	Interest	2	2015-04-29 00:00:00				0	0	0
65	2013-06-29 00:00:00	Interest Deposit	6.00	47628.31	Deposit	1	2015-04-29 00:00:00				0	0	0
83	2011-03-11 00:00:00	Deposit - On-Us Items & Multiple Checks	23000.00	35185.88	Deposit	1	2015-04-29 00:00:00				0	0	0
50	2015-05-11 00:00:00	DEPOSIT - BRANCH	1890.00	151187.45	Deposits	0	2015-04-29 00:00:00				0	0	0
24	2015-05-28 00:00:00	DEBIT CARD #9004 05/27 PEET S #02202 SAN FRANCISCOCA	-6.85	164079.10	Entertainment	0	2015-04-29 00:00:00				0	0	0
31	2015-05-22 00:00:00	DEBIT CARD #9004 05/21 THE HALF DAY CAF KENTFIELD CA	-13.85	154450.22	Entertainment	0	2015-04-29 00:00:00				0	0	0
33	2015-05-20 00:00:00	ACH DEBIT WELLS FARGO CC -ONLINE PMT	-1204.83	154461.70	Healthcare/Medical	0	2015-04-29 00:00:00				0	0	0
67	2013-03-04 00:00:00	Withdrawal - Partial DDA only	-20000.00	47621.38	Withdrawal	1	2015-04-29 00:00:00				0	0	0
56	2014-12-31 00:00:00	Interest Deposit	4.75	37703.21	Deposit	1	2015-04-29 00:00:00				0	0	0
69	2012-12-29 00:00:00	Interest Deposit	0.61	17621.38	Deposit	1	2015-04-29 00:00:00				0	0	0
110	2011-09-16 00:00:00	Interest Deposit - Accrued	3180.70	512503.36	Interest	2	2015-04-29 00:00:00				0	0	0
82	2011-03-31 00:00:00	Interest Deposit	17.32	35203.20	Deposit	1	2015-04-29 00:00:00				0	0	0
61	2014-02-07 00:00:00	Deposit - On-Us Items & Multiple Checks	50000.00	82645.45	Deposit	1	2015-04-29 00:00:00				0	0	0
100	2014-03-17 00:00:00	Interest Deposit - Accrued	3309.85	545128.37	Interest	2	2015-04-29 00:00:00				0	0	0
87	2010-09-25 00:00:00	Withdrawal - Partial DDA only	-2000.00	15140.39	Withdrawal	1	2015-04-29 00:00:00				0	0	0
59	2014-06-30 00:00:00	Interest Deposit	20.61	82679.72	Deposit	1	2015-04-29 00:00:00				0	0	0
58	2014-09-19 00:00:00	Withdrawal - Partial DDA only	-45000.00	37698.46	Withdrawal	1	2015-04-29 00:00:00				0	0	0
95	2009-09-15 00:00:00	Deposit - On-Us Items & Multiple Checks	7617.67	7617.67	Deposit	1	2015-04-29 00:00:00				0	0	0
34	2015-05-20 00:00:00	ACH DEBIT CARDMEMBER SVC -ONLINE PMT	-62.00	155665.90	General Merchandise	0	2015-04-29 00:00:00				0	0	0
35	2015-05-20 00:00:00	DEBIT CARD #9004 05/20 THE HALF DAY CAF KENTFIELD CA	-13.85	155727.90	Entertainment	0	2015-04-29 00:00:00				0	0	0
45	2015-05-14 00:00:00	DEBIT CARD #9004 05/14 CAFE MADELEINE - SAN FRANCISCOCA	-13.49	150936.58	Entertainment	0	2015-04-29 00:00:00				0	0	0
44	2015-05-14 00:00:00	DEBIT CARD #9004 05/14 FOCACCIA CAFE SA SAN FRANCISCOCA	-10.90	150925.68	Entertainment	0	2015-04-29 00:00:00				0	0	0
47	2015-05-14 00:00:00	DEBIT CARD #9004 05/13 THE PLANT CAFE D SAN FRANCISCOCA	-14.78	150956.67	Entertainment	0	2015-04-29 00:00:00				0	0	0
46	2015-05-14 00:00:00	DEBIT CARD #9004 05/13 PEET S #02202 SAN FRANCISCOCA	-6.60	150950.70	Entertainment	0	2015-04-29 00:00:00				0	0	0
53	2015-03-15 00:00:00	Withdrawal - Partial DDA only	-40000.00	37703.21	Withdrawal	1	2015-04-29 00:00:00				0	0	0
22	2015-05-29 00:00:00	DEBIT CARD #9004 05/28 PEET S #02202 SAN FRANCISCOCA	-6.85	164056.59	Entertainment	0	2015-04-29 00:00:00				0	0	0
20	2015-05-29 00:00:00	DEBIT CARD #9004 05/28 JAMBA JUICE 0070 GREENBRAE CA	-6.94	164042.15	Entertainment	0	2015-04-29 00:00:00				0	0	0
18	2015-05-29 00:00:00	H DEBIT OLD NAVY DUAL CD-ONLINE PMT	-864.99	163172.27	General Merchandise	0	2015-04-29 00:00:00				0	0	0
26	2015-05-27 00:00:00	MOBILE CHECK DEPOSIT	5000.00	164267.20	Deposits	0	2015-04-29 00:00:00				0	0	0
38	2015-05-19 00:00:00	MOBILE CHECK DEPOSIT	5000.00	155652.65	Deposits	0	2015-04-29 00:00:00				0	0	0
107	2012-06-16 00:00:00	Interest Deposit - Accrued	3240.22	522094.47	Interest	2	2015-04-29 00:00:00				0	0	0
111	2011-06-17 00:00:00	Interest Deposit - Accrued	3160.96	509322.66	Interest	2	2015-04-29 00:00:00				0	0	0
98	2014-09-14 00:00:00	Interest Deposit - Accrued	3425.57	551958.25	Interest	2	2015-04-29 00:00:00				0	0	0
158	2015-02-07 00:00:00	Advance	-3000.00	674610.70	Advance	8	2015-04-29 00:00:00				0	0	0
157	2015-02-18 00:00:00	Advance	-5000.00	679610.70	Advance	8	2015-04-29 00:00:00				0	0	0
161	2015-01-29 00:00:00	Advance	-19000.00	665610.70	Advance	9	2015-04-29 00:00:00				0	0	0
162	2015-01-29 00:00:00	Advance	-19000.00	665610.70	Advance	9	2015-04-29 00:00:00				0	0	0
104	2013-03-16 00:00:00	Interest Deposit - Accrued	3229.10	531829.08	Interest	2	2015-04-29 00:00:00				0	0	0
105	2012-12-16 00:00:00	Interest Deposit - Accrued	3245.05	528599.98	Interest	2	2015-04-29 00:00:00				0	0	0
101	2013-12-16 00:00:00	Interest Deposit - Accrued	3326.20	541818.52	Interest	2	2015-04-29 00:00:00				0	0	0
152	2015-02-19 00:00:00	Advance	-7000.00	686610.70	Advance	7	2015-04-29 00:00:00				0	0	0
106	2012-09-17 00:00:00	Interest Deposit - Accrued	3260.46	525354.93	Interest	2	2015-04-29 00:00:00				0	0	0
97	2014-12-16 00:00:00	Interest Deposit - Accrued	3409.38	555367.63	Interest	2	2015-04-29 00:00:00				0	0	0
54	0003-06-15 00:00:00	Withdrawal - Partial DDA only	-10000.00	77703.21	Withdrawal	1	2015-04-29 00:00:00				0	0	0
55	0003-06-15 00:00:00	Deposit - On-Us Items & Multiple Checks	50000.00	87703.21	Deposit	1	2015-04-29 00:00:00				0	0	0
57	2014-09-30 00:00:00	Interest Deposit	18.74	37698.46	Deposit	1	2015-04-29 00:00:00				0	0	0
86	2010-09-30 00:00:00	Interest Deposit	30.98	15171.37	Deposit	1	2015-04-29 00:00:00				0	0	0
92	2009-12-31 00:00:00	Interest Deposit	27.57	10049.81	Interest	1	2015-04-29 00:00:00				0	0	0
60	2014-03-31 00:00:00	Interest Deposit	13.66	82659.11	Deposit	1	2015-04-29 00:00:00				0	0	0
74	2012-03-29 00:00:00	Interest Deposit	17.41	62569.13	Deposit	1	2015-04-29 00:00:00				0	0	0
52	2015-03-31 00:00:00	Interest Deposit	4.80	37708.01	Deposit	1	2015-04-29 00:00:00				0	0	0
28	2015-05-27 00:00:00	DEBIT CARD #9004 05/27 PEET S #02202 SAN FRANCISCOCA	-6.85	159287.64	Entertainment	0	2015-04-29 00:00:00				0	0	0
29	2015-05-25 00:00:00	DEBIT CARD #9004 05/25 THE HALF DAY CAF KENTFIELD CA	-16.80	159287.64	Entertainment	0	2015-04-29 00:00:00				0	0	0
39	2015-05-19 00:00:00	DEBIT CARD #9004 05/17 PEET S #01902 GREENBRAE CA	-8.50	150652.65	Entertainment	0	2015-04-29 00:00:00				0	0	0
36	2015-05-19 00:00:00	DEBIT CARD #9004 05/19 THE HALF DAY CAF KENTFIELD CA	-10.90	155741.75	Entertainment	0	2015-04-29 00:00:00				0	0	0
37	2015-05-19 00:00:00	MOBILE CHECK DEPOSIT	100.00	155752.65	Deposits	0	2015-04-29 00:00:00				0	0	0
40	2015-05-19 00:00:00	DEBIT CARD #9004 05/18 THE HALF DAY CAF KENTFIELD CA	-13.85	150661.15	Entertainment	0	2015-04-29 00:00:00				0	0	0
41	2015-05-15 00:00:00	DEBIT CARD #9004 05/15 THE HALF DAY CAF KENTFIELD CA	-22.30	150675.00	Entertainment	0	2015-04-29 00:00:00				0	0	0
43	2015-05-15 00:00:00	DEBIT CARD #9004 05/14 PEET S #02202 SAN FRANCISCOCA	-6.60	150950.70	Entertainment	0	2015-04-29 00:00:00				0	0	0
42	2015-05-15 00:00:00	DEBIT CARD #9004 GREENBRAE MOLLI GREENBRAE CA	-221.78	150697.30	Groceries	0	2015-04-29 00:00:00				0	0	0
148	2015-03-05 00:00:00	Advance	-12000.00	709610.70	Advance	7	2015-04-29 00:00:00				0	0	0
147	2015-03-05 00:00:00	Advance	-21000.00	730610.70	Advance	7	2015-04-29 00:00:00				0	0	0
91	2010-02-12 00:00:00	Deposit - On-Us Items & Multiple Checks	15000.00	25049.81	Deposit	1	2015-04-29 00:00:00				0	0	0
103	2013-06-17 00:00:00	Interest Deposit - Accrued	3321.25	535150.33	Interest	2	2015-04-29 00:00:00				0	0	0
113	2010-12-17 00:00:00	Interest Deposit - Accrued	3088.44	503088.44	Interest	2	2015-04-29 00:00:00				0	0	0
112	2011-03-16 00:00:00	Interest Deposit - Accrued	3073.26	506161.70	Interest	2	2015-04-29 00:00:00				0	0	0
114	2010-09-16 00:00:00	Deposit - On-Us Items & Multiple Checks	500000.00	500000.00	Deposit	2	2015-04-29 00:00:00				0	0	0
108	2012-03-16 00:00:00	Interest Deposit - Accrued	3185.22	518854.25	Interest	2	2015-04-29 00:00:00				0	0	0
102	2013-09-16 00:00:00	Interest Deposit - Accrued	3341.99	538492.32	Interest	2	2015-04-29 00:00:00				0	0	0
99	2014-06-16 00:00:00	Interest Deposit - Accrued	3404.31	548532.68	Interest	2	2015-04-29 00:00:00				0	0	0
163	2015-01-29 00:00:00	Advance	-19000.00	665610.70	Advance	9	2015-04-29 00:00:00				0	0	0
164	2015-01-29 00:00:00	Advance	-19000.00	665610.70	Advance	9	2015-04-29 00:00:00				0	0	0
159	2015-02-05 00:00:00	Advance	-6000.00	671610.70	Advance	8	2015-04-29 00:00:00				0	0	0
143	2015-03-24 00:00:00	Advance	-3000.00	775610.70	Advance	7	2015-04-29 00:00:00				0	0	0
144	2015-03-17 00:00:00	Advance	-10000.00	772610.70	Advance	7	2015-04-29 00:00:00				0	0	0
156	2015-01-30 00:00:00	Advance	-19000.00	665610.70	Advance	7	2015-04-29 00:00:00				0	0	0
151	2015-02-26 00:00:00	Regular Payment	1742.97	686610.70	Payment	7	2015-04-29 00:00:00				0	0	0
150	2015-02-28 00:00:00	Advance	-1000.00	687610.70	Advance	7	2015-04-29 00:00:00				0	0	0
139	2015-03-31 00:00:00	Advance	-12000.00	799610.70	Advance	7	2015-04-29 00:00:00				0	0	0
142	2015-03-26 00:00:00	Regular Payment	1689.48	775610.70	Payment	7	2015-04-29 00:00:00				0	0	0
131	2014-09-02 00:00:00	Principal Only Payment	-2000.00	1230593.85	Payment	6	2015-04-29 00:00:00				0	0	0
132	2014-09-02 00:00:00	Regular Payment	-3650.00	1234243.85	Payment	6	2015-04-29 00:00:00				0	0	0
140	2015-03-26 00:00:00	Advance	-11000.00	787610.70	Advance	7	2015-04-29 00:00:00				0	0	0
141	2015-03-26 00:00:00	Advance	-1000.00	776610.70	Advance	7	2015-04-29 00:00:00				0	0	0
173	2015-01-10 00:00:00	DEBIT CARD #9004 03/08 JAMBA JUICE 0070 GREENBRAE CA	-6.94	577274.87	Payment	3	2015-04-29 00:00:00				0	0	0
153	2015-02-18 00:00:00	Advance	-5000.00	679610.70	Advance	7	2015-04-29 00:00:00				0	0	0
193	2014-06-29 00:00:00	Interest Charge	17.35	9732.91	Interest	8	2015-04-29 00:00:00				0	0	0
195	2014-04-29 00:00:00	Advance	9.00	9215.56	Advance	8	2015-04-29 00:00:00				0	0	0
183	2014-11-29 00:00:00	Advance	973.96	1216.16	Advance	8	2015-04-29 00:00:00				0	0	0
194	2014-05-29 00:00:00	Advance	500.00	9715.56	Advance	8	2015-04-29 00:00:00				0	0	0
182	2014-12-29 00:00:00	Advance	4462.60	5678.76	Advance	8	2015-04-29 00:00:00				0	0	0
93	2009-09-30 00:00:00	Interest Deposit	4.57	10022.24	Interest	1	2015-04-29 00:00:00				0	0	0
90	2010-03-31 00:00:00	Interest Deposit	40.69	25090.50	Interest	1	2015-04-29 00:00:00				0	0	0
64	2013-09-29 00:00:00	Interest Deposit	12.01	47640.32	Deposit	1	2015-04-29 00:00:00				0	0	0
80	2011-07-29 00:00:00	Withdrawal - Partial DDA only	-5000.00	30238.32	Withdrawal	1	2015-04-29 00:00:00				0	0	0
62	2013-12-29 00:00:00	Interest Deposit	5.13	32645.45	Deposit	1	2015-04-29 00:00:00				0	0	0
109	2011-12-16 00:00:00	Interest Deposit - Accrued	3165.67	515669.03	Interest	2	2015-04-29 00:00:00				0	0	0
175	2015-02-15 00:00:00	Interest Charge	1.87	4024.52	Interest	8	2015-04-29 00:00:00				0	0	0
170	2015-01-16 00:00:00	DEBIT CARD #9004 03/09 PEET S #02202 SAN FRANCISCOCA	-6.85	576398.05	Payment	3	2015-04-29 00:00:00				0	0	0
171	2015-01-16 00:00:00	ACH DEBIT OLD NAVY DUAL CD-ONLINE PMT	-864.99	577263.04	Payment	3	2015-04-29 00:00:00				0	0	0
169	2015-01-20 00:00:00	DEBIT CARD #9004 03/10 CAFE MADELEINE - SAN FRANCISCOCA	-13.59	576384.46	Payment	3	2015-04-29 00:00:00				0	0	0
166	2015-01-29 00:00:00	ATM WITHDRAWAL #9004 620 WEST FIELD RD SAN FRANCISCOCA	-301.50	576058.81	Payment	3	2015-04-29 00:00:00				0	0	0
160	2015-01-29 00:00:00	Advance	-19000.00	665610.70	Advance	8	2015-04-29 00:00:00				0	0	0
15	2015-06-01 00:00:00	DEBIT CARD #9004 06/01 PEET S #02202 SAN FRANCISCOCA	-7.35	163144.48	Entertainment	0	2015-04-29 00:00:00				0	0	0
6	2015-06-05 00:00:00	ACH DEBIT THE BAY CLUB CO -ONLINE PMT	-500.00	160116.35	Healthcare/Medical	0	2015-04-29 00:00:00				0	0	0
7	2015-06-05 00:00:00	ACH CREDIT AA TECH CO -PAYROLL	4846.29	160616.35	Deposits	0	2015-04-29 00:00:00				0	0	0
9	2015-06-04 00:00:00	ACH CREDIT AA TECH CO -PYMT011415	650.00	156595.60	Deposits	0	2015-04-29 00:00:00				0	0	0
168	2015-01-24 00:00:00	DEBIT CARD #9004 03/10 PEET S #02202 SAN FRANCISCOCA	-7.35	576377.11	Payment	3	2015-04-29 00:00:00				0	0	0
172	2015-01-15 00:00:00	DEBIT CARD #9004 03/08 CANADA CAFE - SAN FRANCISCOCA	-4.89	577267.93	Payment	3	2015-04-29 00:00:00				0	0	0
1	2015-06-09 00:00:00	PEETS #02202 SAN FRANCISCO POS DEBIT	-6.85	160051.64	Food	0	2015-04-29 00:00:00				0	0	0
51	2015-05-11 00:00:00	INTERNET TRANSFER FROM DDA#9929998888 ON 05/11 AT 10.04	50000.00	149297.45	Transfers	0	2015-04-29 00:00:00				0	0	0
23	2015-05-28 00:00:00	DEBIT CARD #9004 05/27 THE PLANT CAFE D SAN FRANCISCOCA	-15.66	164063.44	Entertainment	0	2015-04-29 00:00:00				0	0	0
48	2015-05-14 00:00:00	DEBIT CARD #9004 05/13 CAFE ROSS ROSS CA	-13.00	150971.45	Entertainment	0	2015-04-29 00:00:00				0	0	0
49	2015-05-14 00:00:00	ATM WITHDRAWAL #9004 1115 MAGNOLIA AVE LARKSPUR CA	-203.00	150984.45	ATM/Cash Withdrawals	0	2015-04-29 00:00:00				0	0	0
17	2015-05-29 00:00:00	DEBIT CARD #9004 05/31 PEET S #02202 SAN FRANCISCOCA	-6.85	163165.42	Entertainment	0	2015-04-29 00:00:00				0	0	0
19	2015-05-29 00:00:00	DEBIT CARD #9004 05/29 CANADA CAFE - SAN SAN FRANCISCOCA	-4.89	164037.26	Entertainment	0	2015-04-29 00:00:00				0	0	0
146	2015-03-05 00:00:00	Advance	-22000.00	752610.70	Advance	7	2015-04-29 00:00:00				0	0	0
184	2014-09-11 00:00:00	Advance	175.00	242.20	Advance	8	2015-04-29 00:00:00				0	0	0
185	2014-09-08 00:00:00	Advance	67.20	67.20	Advance	8	2015-04-29 00:00:00				0	0	0
137	2015-04-07 00:00:00	Advance	-30000.00	629610.70	Advance	7	2015-04-29 00:00:00				0	0	0
136	2015-05-06 00:00:00	Regular Payment	2096.82	627513.88	Payment	7	2015-04-29 00:00:00				0	0	0
135	2015-06-06 00:00:00	Regular Payment	2096.82	625417.60	Payment	7	2015-04-29 00:00:00				0	0	0
145	2015-03-12 00:00:00	Advance	-10000.00	762610.70	Advance	7	2015-04-29 00:00:00				0	0	0
190	2014-08-07 00:00:00	Advance	478.00	2124.76	Advance	8	2015-04-29 00:00:00				0	0	0
189	2014-08-09 00:00:00	Advance	290.00	2414.76	Advance	8	2015-04-29 00:00:00				0	0	0
155	2015-02-05 00:00:00	Advance	-6000.00	671610.70	Advance	7	2015-04-29 00:00:00				0	0	0
149	2015-03-04 00:00:00	Advance	-10000.00	697610.70	Advance	7	2015-04-29 00:00:00				0	0	0
122	2015-02-02 00:00:00	Regular Payment	-3619.58	1204435.12	Payment	6	2015-04-29 00:00:00				0	0	0
10	2015-06-03 00:00:00	DEBIT CARD #9004 06/03 THE HALF DAY CAF KENTFIELD CA	-13.85	155945.60	Entertainment	0	2015-04-29 00:00:00				0	0	0
3	2015-06-07 00:00:00	DEBIT CARD #9004 INT*DOODLEBUG/64 SAN ANSELMO CA	-15.11	160083.40	General Merchandise	0	2015-04-29 00:00:00				0	0	0
192	2014-07-29 00:00:00	Loan Payment	-9732.91	0.00	Payment	8	2015-04-29 00:00:00				0	0	0
187	2014-08-19 00:00:00	Interest Charge	11.62	2765.13	Interest	8	2015-04-29 00:00:00				0	0	0
124	2015-01-02 00:00:00	Regular Payment	-3625.66	1211680.36	Payment	6	2015-04-29 00:00:00				0	0	0
128	2014-11-03 00:00:00	Regular Payment	-3637.83	1222949.94	Payment	6	2015-04-29 00:00:00				0	0	0
118	2015-04-02 00:00:00	Regular Payment	-3607.41	1193214.21	Payment	6	2015-04-29 00:00:00				0	0	0
115	2015-06-02 00:00:00	Regular Payment	-3607.41	1183999.39	Payment	6	2015-04-29 00:00:00				0	0	0
127	2014-11-03 00:00:00	Principal Only Payment	-2000.00	1219312.11	Payment	6	2015-04-29 00:00:00				0	0	0
117	2015-04-02 00:00:00	Principal Only Payment	-2000.00	1191214.21	Payment	6	2015-04-29 00:00:00				0	0	0
121	2015-02-02 00:00:00	Principal Only Payment	-2000.00	1202435.12	Payment	6	2015-04-29 00:00:00				0	0	0
125	2014-12-02 00:00:00	Principal Only Payment	-2000.00	1213680.36	Payment	6	2015-04-29 00:00:00				0	0	0
180	2015-01-29 00:00:00	Loan Payment	-5682.28	0.00	Payment	8	2015-04-29 00:00:00				0	0	0
123	2015-01-02 00:00:00	Principal Only Payment	-2000.00	1208054.70	Payment	6	2015-04-29 00:00:00				0	0	0
186	2014-08-29 00:00:00	Loan Payment	-2765.13	0.00	Payment	8	2015-04-29 00:00:00				0	0	0
181	2015-01-24 00:00:00	Interest Charge	3.52	5682.28	Interest	8	2015-04-29 00:00:00				0	0	0
177	2015-02-10 00:00:00	Loan Payment	-6546.98	0.00	Payment	8	2015-04-29 00:00:00				0	0	0
70	2012-11-29 00:00:00	Withdrawal - Partial DDA only	-10000.00	17620.77	Withdrawal	1	2015-04-29 00:00:00				0	0	0
75	2012-02-28 00:00:00	Withdrawal - Partial DDA only	-10000.00	62551.72	Withdrawal	1	2015-04-29 00:00:00				0	0	0
81	2011-06-30 00:00:00	Interest Deposit	35.12	35238.32	Deposit	1	2015-04-29 00:00:00				0	0	0
126	2014-12-02 00:00:00	Regular Payment	-3631.75	1217312.11	Payment	6	2015-04-29 00:00:00				0	0	0
78	2011-09-29 00:00:00	Interest Deposit	25.39	32544.41	Deposit	1	2015-04-29 00:00:00				0	0	0
71	2012-09-29 00:00:00	Interest Deposit	6.11	27620.77	Deposit	1	2015-04-29 00:00:00				0	0	0
167	2015-01-27 00:00:00	DEBIT CARD #9004 03/22 THE HALF DAY CAF KENTFIELD CA	-16.80	576360.31	Payment	3	2015-04-29 00:00:00				0	0	0
176	2015-02-15 00:00:00	Advance	4022.65	4022.65	Advance	8	2015-04-29 00:00:00				0	0	0
165	2015-01-29 00:00:00	ACH DEBIT AMERICAN EXPRESS-ONLINE PMT	-6852.59	569206.22	Payment	3	2015-04-29 00:00:00				0	0	0
174	2015-02-16 00:00:00	Loan Payment	-4024.52	0.00	Payment	8	2015-04-29 00:00:00				0	0	0
119	2015-03-02 00:00:00	Principal Only Payment	-2000.00	1196821.62	Payment	6	2015-04-29 00:00:00				0	0	0
120	2015-03-02 00:00:00	Regular Payment	-3613.50	1198821.62	Payment	6	2015-04-29 00:00:00				0	0	0
2	2015-06-07 00:00:00	DEBIT CARD #9004 06/08 THE HALF DAY CAF KENTFIELD CA	-24.70	160058.34	Entertainment	0	2015-04-29 00:00:00				0	0	0
30	2015-05-22 00:00:00	ACH CREDIT AA TECH CO -PAYROLL	4854.22	159304.44	Deposits	0	2015-04-29 00:00:00				0	0	0
32	2015-05-20 00:00:00	CREDIT - ATM REBATE	3.00	154464.70	Deposits	0	2015-04-29 00:00:00				0	0	0
21	2015-05-29 00:00:00	DEBIT CARD #9004 05/28 EMPORIO RULLI LARKSPUR CA	-7.50	164049.90	Entertainment	0	2015-04-29 00:00:00				0	0	0
27	2015-05-27 00:00:00	DEBIT CARD #9004 05/27 CAFE MADELEINE - SAN FRANCISCOCA	-13.59	159280.79	Entertainment	0	2015-04-29 00:00:00				0	0	0
25	2015-05-27 00:00:00	ACH DEBIT AT&T UVERSE -ONLINE PMT	-181.25	164085.95	General Merchandise	0	2015-04-29 00:00:00				0	0	0
188	2014-08-11 00:00:00	Advance	338.75	2753.51	Advance	8	2015-04-29 00:00:00				0	0	0
178	2015-02-08 00:00:00	Advance	5000.00	6540.19	Advance	8	2015-04-29 00:00:00				0	0	0
4	2015-06-06 00:00:00	DEBIT CARD #9004 06/07 CHEZ FAYALA LLC SAN FRANCISCOCA	-11.95	160098.15	Entertainment	0	2015-04-29 00:00:00				0	0	0
5	2015-06-06 00:00:00	DEBIT CARD #9004 06/07 PEET S #02202 SAN FRANCISCOCA	-6.25	160110.10	Entertainment	0	2015-04-29 00:00:00				0	0	0
11	2015-06-01 00:00:00	ACH DEBIT AMERICAN EXPRESS-ONLINE PMT	-6852.59	155958.91	General Merchandise	0	2015-04-29 00:00:00				0	0	0
16	2015-06-01 00:00:00	DEBIT CARD #9004 05/31 CAFE MADELEINE - SAN FRANCISCOCA	-13.59	163151.83	Entertainment	0	2015-04-29 00:00:00				0	0	0
14	2015-06-01 00:00:00	DEBIT CARD #9004 06/01 THE HALF DAY CAF KENTFIELD CA	-16.80	163133.00	Entertainment	0	2015-04-29 00:00:00				0	0	0
13	2015-06-01 00:00:00	DEBIT CARD #9004 06/01 THE PLANT CAFE D SAN FRANCISCOCA	-14.68	163113.00	Entertainment	0	2015-04-29 00:00:00				0	0	0
0	2015-06-09 00:00:00	CAFE MADELEINE - SAN FRANCISCO CA POS DEBIT	-18.97	160031.34	Food	0	2015-04-29 00:00:00				0	0	0
154	2015-02-07 00:00:00	Advance	-3000.00	674610.70	Advance	7	2015-04-29 00:00:00				0	0	0
179	2015-02-07 00:00:00	Advance	1540.19	1540.19	Advance	8	2015-04-29 00:00:00				0	0	0
191	2014-08-04 00:00:00	Advance	1646.76	1646.76	Advance	8	2015-04-29 00:00:00				0	0	0
138	2015-04-06 00:00:00	Principal Payment	200000.00	599610.70	Payment	7	2015-04-29 00:00:00				0	0	0
134	2014-08-04 00:00:00	Regular Payment	-3656.80	1239900.65	Payment	6	2015-04-29 00:00:00				0	0	0
116	2015-05-02 00:00:00	Regular Payment	-3607.41	1187606.80	Payment	6	2015-04-29 00:00:00				0	0	0
133	2014-08-04 00:00:00	Principal Only Payment	-2000.00	1236243.85	Payment	6	2015-04-29 00:00:00				0	0	0
129	2014-10-02 00:00:00	Principal Only Payment	-2000.00	1224949.94	Payment	6	2015-04-29 00:00:00				0	0	0
130	2014-10-02 00:00:00	Regular Payment	-3643.91	1228593.85	Payment	6	2015-04-29 00:00:00				0	0	0
\.


--
-- Data for Name: transfers; Type: TABLE DATA; Schema: public; Owner: egrotke
--

COPY transfers (id, user_id, account, recipient, location, amount, created_at, transaction_type, favorited, scheduled, is_personal, is_internal, recurrence) FROM stdin;
0	0	0	Jill Jankowski	First Republic	50	2015-01-19 00:00:00	presonal	0	0	1	0	\N
1	0	0	Corbin Graeme - Ally Bank	Pop Money	5500	2015-01-23 00:00:00	personal	0	0	1	0	\N
2	0	0	Ted - Chase Bank	Pop Money	65	2015-01-23 00:00:00	personal	1	0	1	0	\N
3	0	0	Family Checking	First Republic	120	2015-01-28 00:00:00	internal	0	0	1	0	\N
5	0	0	Brokerage	First Republic	125	2015-05-13 00:00:00	internal	0	0	0	1	\N
6	0	0	Chase Bank	Pop Money	5500	2015-01-23 00:00:00	personal	0	1	1	0	\N
7	0	0	Rishi Chandar	Pop money	187	2015-06-11 00:00:00	personal	0	1	1	0	\N
8	0	0	Lawrence Oliosh	Pop money	3345	2015-06-30 00:00:00	internal	0	1	1	0	\N
9	0	0	California State	Wire	5000	2015-06-29 00:00:00	wire	0	1	0	0	\N
4	0	0	College Fund	First Republic	6000	2015-06-11 00:00:00	Between accounts transfer	0	1	0	1	Monthly
10	1	1	Clarice Lispector	First Republic	1111	2015-06-29 00:00:00	personal	0	1	1	1	One Time
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: egrotke
--

COPY users (id, lastname, email, password, firstname, created_at, updated_at, accounts, accounttypes, billers, bills, transfers, deposits, recipients, username) FROM stdin;
0	Riley	criley@gmail.com	\N	Chris	2015-09-02 14:19:31	2015-09-02 14:26:23	{0,3,6,7,8}	{0,1,2,3}	{0,1,2,3,4,5,6,7}	{0,1,2,3,4,5,6,7}	{0,1,2,3,4,5}	{0,1,2,3,4}	{0,1,2,3}	criley
1	Riley	priley@gmail.com	admin	Pat	2015-09-02 14:19:31	2015-09-02 14:26:23	{0,3,5,6}	{4,5,6}	{8}	{8}	{10}	{}	{4,5,6,7,8,9,10}	priley
\.


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: egrotke; Tablespace: 
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: accounttypes_pkey; Type: CONSTRAINT; Schema: public; Owner: egrotke; Tablespace: 
--

ALTER TABLE ONLY accounttypes
    ADD CONSTRAINT accounttypes_pkey PRIMARY KEY (id);


--
-- Name: billers_pkey; Type: CONSTRAINT; Schema: public; Owner: egrotke; Tablespace: 
--

ALTER TABLE ONLY billers
    ADD CONSTRAINT billers_pkey PRIMARY KEY (id);


--
-- Name: bills_pkey; Type: CONSTRAINT; Schema: public; Owner: egrotke; Tablespace: 
--

ALTER TABLE ONLY bills
    ADD CONSTRAINT bills_pkey PRIMARY KEY (id);


--
-- Name: deposits_pkey; Type: CONSTRAINT; Schema: public; Owner: egrotke; Tablespace: 
--

ALTER TABLE ONLY deposits
    ADD CONSTRAINT deposits_pkey PRIMARY KEY (id);


--
-- Name: recipients_pkey; Type: CONSTRAINT; Schema: public; Owner: egrotke; Tablespace: 
--

ALTER TABLE ONLY recipients
    ADD CONSTRAINT recipients_pkey PRIMARY KEY (id);


--
-- Name: transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: egrotke; Tablespace: 
--

ALTER TABLE ONLY transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: transfers_pkey; Type: CONSTRAINT; Schema: public; Owner: egrotke; Tablespace: 
--

ALTER TABLE ONLY transfers
    ADD CONSTRAINT transfers_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: egrotke; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: egrotke
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM egrotke;
GRANT ALL ON SCHEMA public TO egrotke;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

