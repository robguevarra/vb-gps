--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 17.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: tenants; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.tenants (id, name, external_id, jwt_secret, max_concurrent_users, inserted_at, updated_at, max_events_per_second, postgres_cdc_default, max_bytes_per_second, max_channels_per_client, max_joins_per_second, suspend, jwt_jwks, notify_private_alpha, private_only) FROM stdin;
ba0dca44-a00f-468d-86a8-a33e84a063ba	realtime-dev	realtime-dev	iNjicxc4+llvc9wovDvqymwfnj9teWMlyOIbJ8Fh6j2WNU8CIJ2ZgjR6MUIKqSmeDmvpsKLsZ9jgXJmQPpwL8w==	200	2025-02-21 06:03:51	2025-02-21 06:03:51	100	postgres_cdc_rls	100000	100	100	f	{"keys": [{"k": "c3VwZXItc2VjcmV0LWp3dC10b2tlbi13aXRoLWF0LWxlYXN0LTMyLWNoYXJhY3RlcnMtbG9uZw", "kty": "oct"}]}	f	f
\.


--
-- Data for Name: extensions; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.extensions (id, type, settings, tenant_external_id, inserted_at, updated_at) FROM stdin;
e6deb592-3a68-4dbb-a72b-610c74b63c63	postgres_cdc_rls	{"region": "us-east-1", "db_host": "/G2fyyoVhPOZqtMQmAXKEXq0VDDR7092ObD++o4IEmI=", "db_name": "sWBpZNdjggEPTQVlI52Zfw==", "db_port": "+enMDFi1J/3IrrquHHwUmA==", "db_user": "uxbEq/zz8DXVD53TOI1zmw==", "slot_name": "supabase_realtime_replication_slot", "db_password": "sWBpZNdjggEPTQVlI52Zfw==", "publication": "supabase_realtime", "ssl_enforced": false, "poll_interval_ms": 100, "poll_max_changes": 100, "poll_max_record_bytes": 1048576}	realtime-dev	2025-02-21 06:03:51	2025-02-21 06:03:51
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.schema_migrations (version, inserted_at) FROM stdin;
20210706140551	2025-02-04 04:08:13
20220329161857	2025-02-04 04:08:13
20220410212326	2025-02-04 04:08:13
20220506102948	2025-02-04 04:08:13
20220527210857	2025-02-04 04:08:13
20220815211129	2025-02-04 04:08:13
20220815215024	2025-02-04 04:08:13
20220818141501	2025-02-04 04:08:13
20221018173709	2025-02-04 04:08:13
20221102172703	2025-02-04 04:08:13
20221223010058	2025-02-04 04:08:13
20230110180046	2025-02-04 04:08:13
20230810220907	2025-02-04 04:08:13
20230810220924	2025-02-04 04:08:13
20231024094642	2025-02-04 04:08:13
20240306114423	2025-02-04 04:08:13
20240418082835	2025-02-04 04:08:13
20240625211759	2025-02-04 04:08:13
20240704172020	2025-02-04 04:08:13
20240902173232	2025-02-04 04:08:13
20241106103258	2025-02-04 04:08:13
\.


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	ae07b3ab-3f2e-498b-b72f-37b1573dca82	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"robneil@gmail.com","user_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","user_phone":""}}	2025-02-04 04:10:22.350606+00	
00000000-0000-0000-0000-000000000000	5f7e95d1-6b90-4989-9c5b-94780c19a725	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-04 04:12:58.409122+00	
00000000-0000-0000-0000-000000000000	e795032b-28cb-4424-9a6b-5daeef0f59a4	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-04 04:17:45.067998+00	
00000000-0000-0000-0000-000000000000	71525aa3-e99d-4f6b-a672-3009c2481b70	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-04 04:17:46.260506+00	
00000000-0000-0000-0000-000000000000	19ec5182-2d6b-40f3-b394-c5755d70f94c	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-04 05:13:02.319823+00	
00000000-0000-0000-0000-000000000000	f7bf150c-fc97-49b0-8941-c75ab6215c14	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-04 05:13:03.85634+00	
00000000-0000-0000-0000-000000000000	260064d2-3fa5-4139-9234-f35d2a1d4663	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-04 05:15:44.789995+00	
00000000-0000-0000-0000-000000000000	2a2e47d3-a2c4-4c55-99f7-2dc7db395944	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-04 05:16:04.407767+00	
00000000-0000-0000-0000-000000000000	d32fd748-9320-492f-ac04-50584c805ad5	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-04 05:28:13.567892+00	
00000000-0000-0000-0000-000000000000	2f375ab8-c373-4eb8-9f5a-cd71fa5c5832	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-04 05:28:15.257793+00	
00000000-0000-0000-0000-000000000000	f1c05cc7-92c9-4891-996f-c684624f278b	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-04 14:14:12.564585+00	
00000000-0000-0000-0000-000000000000	42c199ae-0361-4352-b033-caafba314f35	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-04 14:14:12.566053+00	
00000000-0000-0000-0000-000000000000	a5a69a82-8608-4d77-a7f3-998e1c506c9b	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-04 15:14:18.000479+00	
00000000-0000-0000-0000-000000000000	5a3f7c85-87b5-4909-bcd7-028a101895b8	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-04 15:14:18.001496+00	
00000000-0000-0000-0000-000000000000	81dbf9ff-82bb-4da5-9058-9746893c2fce	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-06 01:50:23.551274+00	
00000000-0000-0000-0000-000000000000	5d98709b-ff74-4b45-a45f-f4e8adc26cec	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-06 01:50:23.553138+00	
00000000-0000-0000-0000-000000000000	869e46b8-e59b-4f0e-a127-ba68c2bdc5da	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-06 01:59:10.401184+00	
00000000-0000-0000-0000-000000000000	a6b899ff-a3cd-4ada-bd22-eb61c9cdcc5f	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-06 01:59:13.538576+00	
00000000-0000-0000-0000-000000000000	889447d1-87f7-446e-a8ca-e81d1df363a4	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-06 02:01:19.146805+00	
00000000-0000-0000-0000-000000000000	eeb6cd95-b373-40c7-a2eb-18e4183080a7	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-06 02:01:21.221912+00	
00000000-0000-0000-0000-000000000000	ae002922-e958-4f86-8552-d06c831bb7f3	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-06 02:01:22.393986+00	
00000000-0000-0000-0000-000000000000	87062398-3bb2-43b0-8e2f-3b432869944f	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-06 02:02:22.548642+00	
00000000-0000-0000-0000-000000000000	1b20332c-536a-4f78-b4b7-afcb19f8d9ee	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-06 02:04:17.995802+00	
00000000-0000-0000-0000-000000000000	f63cf225-ac9c-4cd0-adee-5cfcca91a366	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-06 02:24:24.24955+00	
00000000-0000-0000-0000-000000000000	307a8cf5-48d7-4034-8898-22d2f7069c60	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-06 02:24:25.544424+00	
00000000-0000-0000-0000-000000000000	441d22fc-cacd-4383-a79c-1257e8f0eb66	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-06 03:14:56.117583+00	
00000000-0000-0000-0000-000000000000	cf8784b4-3dcf-4a59-acf1-f12196dc04b1	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-06 03:15:06.699288+00	
00000000-0000-0000-0000-000000000000	4a329c72-abae-4336-b5b9-b91b4c13d08f	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-06 03:57:47.247899+00	
00000000-0000-0000-0000-000000000000	7ff22e94-4580-4dbb-b41c-345c79318198	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-06 03:57:50.41587+00	
00000000-0000-0000-0000-000000000000	a35f1726-c2aa-4a1c-ade6-61a322b869be	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-07 05:11:29.977487+00	
00000000-0000-0000-0000-000000000000	dec74687-9c65-4b34-9de6-f6cc3b31b0df	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-07 05:11:29.979052+00	
00000000-0000-0000-0000-000000000000	7cacc969-e16e-44c0-831e-3dd7a6a832eb	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-07 06:09:50.199842+00	
00000000-0000-0000-0000-000000000000	ada84fc9-725d-4b6c-a3f3-45e4fea53016	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-07 06:09:50.200667+00	
00000000-0000-0000-0000-000000000000	7a792cff-b10c-4532-b5ef-1a6a512a53dc	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-07 07:07:59.052328+00	
00000000-0000-0000-0000-000000000000	0ae92f8d-d960-41fd-b5b1-36a21ed016a4	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-07 07:07:59.053309+00	
00000000-0000-0000-0000-000000000000	c8650391-ae3c-4be7-ba0e-81c00446baff	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-07 08:06:00.447604+00	
00000000-0000-0000-0000-000000000000	0eaa5434-cd4d-4c2c-a1a3-61fa6c033122	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-07 08:06:00.448148+00	
00000000-0000-0000-0000-000000000000	72d0036f-970e-47bf-8ae7-c6b48aa32523	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-07 09:09:38.872435+00	
00000000-0000-0000-0000-000000000000	883edc50-d7b1-46f9-8571-4d03599d7e5f	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-07 09:09:38.873194+00	
00000000-0000-0000-0000-000000000000	d7f56b8a-d576-4ca9-9627-9623fc8e9178	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-07 09:09:38.887252+00	
00000000-0000-0000-0000-000000000000	d3586440-f438-4441-8e4d-a6d8dfda5e2b	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 03:21:40.368562+00	
00000000-0000-0000-0000-000000000000	c83b42ba-13a3-439b-98d7-3ae7f78174de	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 03:21:40.370363+00	
00000000-0000-0000-0000-000000000000	d31aae7d-d3ff-40dc-b4a9-0c8bbe7dc225	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 04:23:36.351708+00	
00000000-0000-0000-0000-000000000000	ec4ac94a-3fbc-4225-bff8-67873d9f150c	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 04:23:36.353071+00	
00000000-0000-0000-0000-000000000000	eb09f721-a3bc-4b60-81b3-53880ef9dc20	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 05:21:54.134604+00	
00000000-0000-0000-0000-000000000000	869ddbfc-2c5b-4b43-908b-7a9ac85f4a05	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 05:21:54.135857+00	
00000000-0000-0000-0000-000000000000	c0d6d7bc-7845-4243-b894-6e27a4171ca2	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 06:20:23.750534+00	
00000000-0000-0000-0000-000000000000	1c326e1f-0ebd-41fe-99a4-44ef457e8d6f	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 06:20:23.751812+00	
00000000-0000-0000-0000-000000000000	9edfedd2-3ffd-449b-bd07-7aae112e4822	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 07:18:43.311356+00	
00000000-0000-0000-0000-000000000000	673c566d-bcb4-4d4f-8368-e0230529d89a	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 07:18:43.312449+00	
00000000-0000-0000-0000-000000000000	8aec4a5d-49be-4f83-adf7-aed192864ec7	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-08 08:10:22.558807+00	
00000000-0000-0000-0000-000000000000	68821362-1178-4a6b-950d-9b1123e2298a	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-08 08:10:24.886624+00	
00000000-0000-0000-0000-000000000000	10ad4803-ece6-4233-b737-935cfc42ede6	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 10:11:57.7174+00	
00000000-0000-0000-0000-000000000000	c38770c1-af50-40a6-97f1-98c9d7911b11	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 10:11:57.718778+00	
00000000-0000-0000-0000-000000000000	c7a339b7-a438-4102-ab78-8b92b4bb17a5	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 11:12:03.44274+00	
00000000-0000-0000-0000-000000000000	9f5db5a3-cb5f-4035-82ce-070530b25140	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 11:12:03.443742+00	
00000000-0000-0000-0000-000000000000	ad7ee231-77ea-4f78-a8a1-161fe5fa786f	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 12:12:12.446619+00	
00000000-0000-0000-0000-000000000000	3276aa3a-a662-4524-a36b-bc2940ed11f6	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 12:12:12.447251+00	
00000000-0000-0000-0000-000000000000	f29285e8-4b9f-4283-b16d-d2fe159f9a85	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 13:10:20.265063+00	
00000000-0000-0000-0000-000000000000	354ef0ce-bb14-4724-a2d1-99982bf7d3f2	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 13:10:20.2661+00	
00000000-0000-0000-0000-000000000000	176cabd6-9759-4a7e-8a17-0c56d35a5f63	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 14:08:22.683896+00	
00000000-0000-0000-0000-000000000000	8d336b9a-3774-4647-bf7f-6faefe0dfbf4	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 14:08:22.685279+00	
00000000-0000-0000-0000-000000000000	2ce4cb1d-c148-406d-b917-e93689696805	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 15:06:38.406443+00	
00000000-0000-0000-0000-000000000000	2a4ef89c-60c9-422a-8ac4-1e2363b9e4d5	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-08 15:06:38.407686+00	
00000000-0000-0000-0000-000000000000	fa55f143-6dd0-4c11-a78a-e883a9e3f957	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-08 15:20:45.825946+00	
00000000-0000-0000-0000-000000000000	eee58989-4770-4625-976d-fdbf2b6ce5db	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-11 02:38:38.244734+00	
00000000-0000-0000-0000-000000000000	3e0f64f0-7405-4a93-a1a9-daef1d8b3620	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 03:39:03.336502+00	
00000000-0000-0000-0000-000000000000	a66c9390-ef4c-4258-9bac-8bacc5c5f3f5	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 03:39:03.338294+00	
00000000-0000-0000-0000-000000000000	68056336-c1ce-44e6-8cf0-4af8ac60c67e	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 04:39:08.324769+00	
00000000-0000-0000-0000-000000000000	5974aa83-588a-4299-9e74-fb779cb13281	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 04:39:08.325394+00	
00000000-0000-0000-0000-000000000000	484ee774-da12-4ba4-8ba5-f8b7b9845166	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 05:39:25.320874+00	
00000000-0000-0000-0000-000000000000	785f1556-f1a5-4576-8e27-9c770939a0ed	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 05:39:25.321379+00	
00000000-0000-0000-0000-000000000000	5c6b818a-063b-414f-aa0d-851f71d21ac8	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 06:40:47.320491+00	
00000000-0000-0000-0000-000000000000	5afb59cf-778a-43a4-8de9-ed6e086e4217	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 06:40:47.320992+00	
00000000-0000-0000-0000-000000000000	6d4ffe7c-8fbb-468b-9ffd-9aff838d9173	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 07:41:14.331095+00	
00000000-0000-0000-0000-000000000000	5071ae47-2553-4eb2-b9eb-0083be989162	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 07:41:14.331705+00	
00000000-0000-0000-0000-000000000000	3f05b124-988f-40e5-aee2-3adebde39957	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 08:42:38.325232+00	
00000000-0000-0000-0000-000000000000	0fceb99e-c961-4734-ad75-047d723b697c	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 08:42:38.32583+00	
00000000-0000-0000-0000-000000000000	10f8e25f-3125-4264-ad53-9d139d85cc8b	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 09:43:41.332277+00	
00000000-0000-0000-0000-000000000000	4910847b-a5d5-492d-911a-beb9806586dd	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 09:43:41.332838+00	
00000000-0000-0000-0000-000000000000	1522a220-9775-4eda-a8eb-3abe19a0db1a	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 10:43:53.326714+00	
00000000-0000-0000-0000-000000000000	d4ce6101-40fe-43c8-8dcf-e925074869cf	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 10:43:53.327294+00	
00000000-0000-0000-0000-000000000000	c15068df-b5ba-4f09-8683-5d3c45b1220c	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 11:44:10.322477+00	
00000000-0000-0000-0000-000000000000	92bf32ea-4ab2-4027-8148-e8e8af521d8d	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 11:44:10.323043+00	
00000000-0000-0000-0000-000000000000	3626de11-af7e-428d-9aea-2575d0852655	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 12:44:26.33121+00	
00000000-0000-0000-0000-000000000000	36e9bf8f-bdd2-445f-b5b9-33749e4dad9d	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 12:44:26.331726+00	
00000000-0000-0000-0000-000000000000	13520a8b-0c51-41f2-9f56-a9dde8182029	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 13:44:50.321848+00	
00000000-0000-0000-0000-000000000000	6e934534-94f3-47bf-ab9d-ae1a38947e90	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 13:44:50.322481+00	
00000000-0000-0000-0000-000000000000	67172a6f-6787-4182-8a8a-346b8314be12	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 14:45:14.323684+00	
00000000-0000-0000-0000-000000000000	ce90492f-9d33-44c6-9b27-ba5d61c2a3d1	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 14:45:14.324194+00	
00000000-0000-0000-0000-000000000000	10576896-9ed4-4d07-8264-1450cd00f638	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 15:45:32.319605+00	
00000000-0000-0000-0000-000000000000	0a8c1408-ff94-4498-8e75-e3c3736f0b05	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-11 15:45:32.320192+00	
00000000-0000-0000-0000-000000000000	681c70d5-22e5-47b0-ac01-ec6ad75aa365	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 04:30:18.342356+00	
00000000-0000-0000-0000-000000000000	33850f38-083d-4b98-90ec-2145fcddda02	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 04:30:18.345278+00	
00000000-0000-0000-0000-000000000000	ce1f7619-a26b-4bca-a64c-ddad121cf489	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 05:28:22.559776+00	
00000000-0000-0000-0000-000000000000	cd42759f-a0ed-4c04-b1f0-ff3358edf684	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 05:28:22.561086+00	
00000000-0000-0000-0000-000000000000	b53a944e-aedf-407d-b6a9-ebd68008ce9f	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 06:29:02.807128+00	
00000000-0000-0000-0000-000000000000	5363ce8c-7980-4313-8152-e6a420645cda	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 06:29:02.807701+00	
00000000-0000-0000-0000-000000000000	b718e6d7-aa02-4aaa-b84c-4d054b67a739	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 07:27:15.989635+00	
00000000-0000-0000-0000-000000000000	ed69f860-e0bf-45e5-9005-28006655241f	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 07:27:15.990298+00	
00000000-0000-0000-0000-000000000000	3a409c29-0e0e-484f-ac10-0c49d5db3cc1	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 08:25:37.971421+00	
00000000-0000-0000-0000-000000000000	6dd25838-e83a-4194-9d2b-d6c7fb777e9d	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 08:25:37.973396+00	
00000000-0000-0000-0000-000000000000	ff786226-2a89-4149-8d4d-5d43b72d8e14	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-12 08:58:40.747904+00	
00000000-0000-0000-0000-000000000000	03c2c7d1-d0db-4edc-8001-4a938de73a54	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-12 08:58:42.994107+00	
00000000-0000-0000-0000-000000000000	783cf1ba-5602-4f97-956a-593bc2346647	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 09:56:43.344926+00	
00000000-0000-0000-0000-000000000000	c3ff4f0a-5f80-49ff-bb8f-ba9f6a53a721	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 09:56:43.346544+00	
00000000-0000-0000-0000-000000000000	e5586adb-7907-49f9-be87-ab413e339c68	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 10:56:53.806802+00	
00000000-0000-0000-0000-000000000000	b40cf56b-e228-4401-823f-f1d1b22287ea	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 10:56:53.807932+00	
00000000-0000-0000-0000-000000000000	1da951ab-bde6-4467-9eef-650742ed60db	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 11:58:26.801664+00	
00000000-0000-0000-0000-000000000000	8c19abf2-30b5-4c8a-9a31-f4e30d54a509	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 11:58:26.802657+00	
00000000-0000-0000-0000-000000000000	471f5259-ed29-4dd6-87c1-c4deabff1d29	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 12:58:29.800348+00	
00000000-0000-0000-0000-000000000000	bafab4fe-09e6-4244-bef6-23ae3113f622	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 12:58:29.801072+00	
00000000-0000-0000-0000-000000000000	71ec2dd5-033b-4c75-af94-006575ca963c	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 13:59:26.809999+00	
00000000-0000-0000-0000-000000000000	7ef3d32e-44c4-4724-a6a8-a0b6ef69147b	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 13:59:26.810659+00	
00000000-0000-0000-0000-000000000000	ff0878ff-3f58-4c56-95ea-2bd10d1c3840	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 14:59:59.803281+00	
00000000-0000-0000-0000-000000000000	f21eb2db-3060-4203-9d94-37daba60c149	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 14:59:59.803912+00	
00000000-0000-0000-0000-000000000000	8fac936a-c80b-41b6-913f-5ccec74f7c7e	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 15:58:23.690832+00	
00000000-0000-0000-0000-000000000000	6468e36c-79ff-4d84-a03e-f710633fe73a	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 15:58:23.691876+00	
00000000-0000-0000-0000-000000000000	c7e978df-b069-457b-876a-cedc5045264f	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-17 07:05:06.427512+00	
00000000-0000-0000-0000-000000000000	831799ed-90cd-4538-a545-67a296ad2be9	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 08:03:35.484827+00	
00000000-0000-0000-0000-000000000000	17ff73e8-4fcd-4721-9e2c-113dfd2934da	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 08:03:35.486274+00	
00000000-0000-0000-0000-000000000000	8000d3db-d625-4535-b86e-c85bf43f3315	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 09:01:41.829649+00	
00000000-0000-0000-0000-000000000000	f8c53710-49ca-4198-84c6-e395d411592d	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 09:01:41.830347+00	
00000000-0000-0000-0000-000000000000	dbb9fbae-3443-4d89-93d0-2b6a9282798c	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 09:59:50.508416+00	
00000000-0000-0000-0000-000000000000	dc6fd107-d02e-455a-82ac-1ce1b919e3bf	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 09:59:50.509549+00	
00000000-0000-0000-0000-000000000000	734cbbca-eaa0-442f-baa0-30020b9c18d8	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 10:57:57.206807+00	
00000000-0000-0000-0000-000000000000	e88ddfc7-548f-4632-b537-87c75d56f1e0	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 10:57:57.20802+00	
00000000-0000-0000-0000-000000000000	0750a147-f5e7-4908-8c2c-92e10031f4fa	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 11:58:25.571549+00	
00000000-0000-0000-0000-000000000000	07b31fd9-5d5e-4514-907d-158d3080e379	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 11:58:25.572866+00	
00000000-0000-0000-0000-000000000000	347896a0-c87e-447b-85b3-0196a22c7c23	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 12:59:28.557364+00	
00000000-0000-0000-0000-000000000000	0985ce13-d608-491c-ac4a-2dad32da706e	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 12:59:28.558211+00	
00000000-0000-0000-0000-000000000000	d90dcf7e-250a-4fe1-bd82-8983c634a0c4	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 13:59:43.555921+00	
00000000-0000-0000-0000-000000000000	dd9f72a0-4cf9-49a4-b2b5-712856a7dec7	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 13:59:43.556712+00	
00000000-0000-0000-0000-000000000000	cc5e3676-59b6-48b0-a36a-ebcedea96fd6	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 14:57:50.865475+00	
00000000-0000-0000-0000-000000000000	4a654464-70c1-4393-8f40-4f891e61ca69	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 14:57:50.867099+00	
00000000-0000-0000-0000-000000000000	17c11bb5-5bd8-47ea-a485-cef6bf2d1da0	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 15:59:19.555123+00	
00000000-0000-0000-0000-000000000000	5e23c557-cc8b-4352-914f-070b9e5c748f	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 15:59:19.556522+00	
00000000-0000-0000-0000-000000000000	5caeb80e-2649-43ad-a433-6d4cbb55fb9b	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-18 01:04:07.612205+00	
00000000-0000-0000-0000-000000000000	d0252d13-bebb-4050-9542-052d8d299ec3	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-18 01:04:07.615242+00	
00000000-0000-0000-0000-000000000000	f57e35c2-4841-489e-943f-cabc86892914	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-18 02:02:07.771148+00	
00000000-0000-0000-0000-000000000000	8c88bd47-2e78-4e19-92ed-de45a6cab8b8	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-18 02:02:07.77267+00	
00000000-0000-0000-0000-000000000000	8618243e-534b-43db-b2c5-78e33f4e6a95	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-18 03:00:09.675675+00	
00000000-0000-0000-0000-000000000000	a739b986-7990-401f-8409-2b8c2a6e5727	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-18 03:00:09.677228+00	
00000000-0000-0000-0000-000000000000	9d09be77-6e30-40b3-83b6-372316ece9ab	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-18 04:52:47.349702+00	
00000000-0000-0000-0000-000000000000	bcc89970-8c8f-4d87-9220-28928e7fd6c9	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-18 04:52:47.351441+00	
00000000-0000-0000-0000-000000000000	84f700de-e4c5-43bd-a43c-1910ce1e1c4f	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-18 16:18:59.395588+00	
00000000-0000-0000-0000-000000000000	900d855e-87bb-4c8f-8b94-53b3869177dd	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-18 16:18:59.397889+00	
00000000-0000-0000-0000-000000000000	184d1c19-e738-467b-9635-712c5fa49384	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 02:06:32.922566+00	
00000000-0000-0000-0000-000000000000	660a887e-e8bf-4ec7-958d-39ceec241b23	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 02:06:32.924261+00	
00000000-0000-0000-0000-000000000000	c09175ce-d1a9-45d5-a233-79df619af4ab	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"rob.guevarra@gmail.com","user_id":"3795175a-52aa-495b-81c8-01e2d7ae99de","user_phone":""}}	2025-02-19 02:17:04.33737+00	
00000000-0000-0000-0000-000000000000	9b4ddf63-8589-4fb9-86fe-9b1f97208ff2	{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"rob.guevarra2@gmail.com","user_id":"3795175a-52aa-495b-81c8-01e2d7ae99de","user_phone":""}}	2025-02-19 02:19:40.319761+00	
00000000-0000-0000-0000-000000000000	b3dab551-beaf-427b-9679-5f92816740cb	{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"rob.guevarra@gmail.com","user_id":"3795175a-52aa-495b-81c8-01e2d7ae99de","user_phone":""}}	2025-02-19 02:19:53.510319+00	
00000000-0000-0000-0000-000000000000	91df62a4-0065-4517-8aab-42cf13a21b2d	{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"rob.guevarra2@gmail.com","user_id":"3795175a-52aa-495b-81c8-01e2d7ae99de","user_phone":""}}	2025-02-19 02:28:01.912047+00	
00000000-0000-0000-0000-000000000000	4ca87db3-9ff7-418e-95ce-b07916d4be92	{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"rob.guevarra@gmail.com","user_id":"3795175a-52aa-495b-81c8-01e2d7ae99de","user_phone":""}}	2025-02-19 02:28:16.413137+00	
00000000-0000-0000-0000-000000000000	eddb7638-a211-424d-aaf5-2d54be0ce752	{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"rob.guevarra22@gmail.com","user_id":"3795175a-52aa-495b-81c8-01e2d7ae99de","user_phone":""}}	2025-02-19 02:32:47.398371+00	
00000000-0000-0000-0000-000000000000	d7f80bf6-c104-4bd3-80e2-fdef6a4d8a51	{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"rob.guevarra@gmail.com","user_id":"3795175a-52aa-495b-81c8-01e2d7ae99de","user_phone":""}}	2025-02-19 02:33:39.63451+00	
00000000-0000-0000-0000-000000000000	2b161c90-fcbf-4b8a-bc53-27c3c4038890	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 03:10:28.147417+00	
00000000-0000-0000-0000-000000000000	4113a16e-69da-44e2-a326-c71cde11fa3a	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 03:10:28.14805+00	
00000000-0000-0000-0000-000000000000	5bfbdf58-f5d9-4b50-9232-034454532147	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 04:14:31.306779+00	
00000000-0000-0000-0000-000000000000	291f6ad6-f587-4e55-a90a-73039014fb6f	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 04:14:31.307394+00	
00000000-0000-0000-0000-000000000000	32cc9143-ba6e-4463-9b9d-1ccd86de45f2	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 05:12:46.776372+00	
00000000-0000-0000-0000-000000000000	d9aa377c-8715-47e9-b42e-6ecb059d6e7c	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 05:12:46.777492+00	
00000000-0000-0000-0000-000000000000	d37ab197-d64a-42c6-8baa-8b722825e577	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 06:11:09.971922+00	
00000000-0000-0000-0000-000000000000	53044091-a660-40b0-9aec-f8720cb02e03	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 06:11:09.97288+00	
00000000-0000-0000-0000-000000000000	ad733c5c-f784-4e12-a068-bf8dbb37fb2d	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 07:09:33.131423+00	
00000000-0000-0000-0000-000000000000	11369aed-db00-4c64-974b-a3f4d05e29e1	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 07:09:33.132741+00	
00000000-0000-0000-0000-000000000000	e36ded04-721a-43e3-87e5-c616c17a4646	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 08:45:41.167354+00	
00000000-0000-0000-0000-000000000000	569437a2-ad5a-4ba2-af68-628d4caa1ee7	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 08:45:41.168672+00	
00000000-0000-0000-0000-000000000000	4e08a988-94c7-4df9-8c43-b7c0c35df366	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 09:43:58.233266+00	
00000000-0000-0000-0000-000000000000	5a693066-3ecb-4b75-884b-27fe1aad1df3	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 09:43:58.234788+00	
00000000-0000-0000-0000-000000000000	4a8296c1-6998-4e88-8614-67fd0cbbfc03	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 10:43:45.447478+00	
00000000-0000-0000-0000-000000000000	dfe31d24-fefb-409d-83ee-728cc1a4f5e1	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 10:43:45.448561+00	
00000000-0000-0000-0000-000000000000	b99ed8c5-f6cc-42e8-8741-b93246f4a612	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 12:12:32.423465+00	
00000000-0000-0000-0000-000000000000	ba559d95-bb39-42c4-bfa3-c0dc79410e20	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 12:12:32.424675+00	
00000000-0000-0000-0000-000000000000	21ca40cc-025d-4d25-a3b9-7fa8988a84f8	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"zoebguevarra@gmail.com","user_id":"b188f631-2561-457a-9be6-f556043dfc94","user_phone":""}}	2025-02-19 12:19:24.265569+00	
00000000-0000-0000-0000-000000000000	c37f2eed-ab36-4055-b6f8-86c7c0c8bdff	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"xionguevarra@gmail.com","user_id":"bba4e5c1-2eb0-46bd-8f09-cd331ceab351","user_phone":""}}	2025-02-19 12:22:37.699609+00	
00000000-0000-0000-0000-000000000000	cfefed1c-822e-4151-a202-b927e26b6081	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"gracebguevarra@gmail.com","user_id":"bdebd3ea-5c80-4dff-a03c-a7d0a08947ef","user_phone":""}}	2025-02-19 12:24:33.055776+00	
00000000-0000-0000-0000-000000000000	ec3928d1-bb0b-4278-a46b-bdc155595090	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"yoshiii@gmail.com","user_id":"dc34a52e-aed8-4354-abb6-7b49085ac24e","user_phone":""}}	2025-02-19 12:38:02.882347+00	
00000000-0000-0000-0000-000000000000	5d42c4a7-40c2-4a69-b39e-e5a4cc8482d5	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"yosxxx@gmail.com","user_id":"047a2a75-cb6a-46b6-a039-2958efb1af2b","user_phone":""}}	2025-02-19 12:38:31.379962+00	
00000000-0000-0000-0000-000000000000	60c603f0-6bde-45c0-a76a-d52376a922a7	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"jeje@gmail.com","user_id":"3573c57b-43e2-4947-9f9b-38d9bd01ee7f","user_phone":""}}	2025-02-19 12:40:19.187935+00	
00000000-0000-0000-0000-000000000000	55b8427c-9640-4a7c-be36-4d5df538024a	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"jejehaa@gmail.com","user_id":"bc9fc16c-f1f9-4c2f-ba95-51bd5a0594f3","user_phone":""}}	2025-02-19 12:40:30.356096+00	
00000000-0000-0000-0000-000000000000	fa1c4b9a-3f39-4526-9207-83b23517c9b8	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"reverx@gmail.com","user_id":"94f2d973-d8df-435e-8b43-98e7b44fe45b","user_phone":""}}	2025-02-19 12:44:47.231166+00	
00000000-0000-0000-0000-000000000000	26167b96-6433-4f84-a653-0f499652dc6b	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 13:12:47.181217+00	
00000000-0000-0000-0000-000000000000	6524caaf-de58-491d-881e-9673da3246a6	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-19 13:12:47.181763+00	
00000000-0000-0000-0000-000000000000	65cfdf40-9110-4c06-8027-1580db182c23	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:26:38.446145+00	
00000000-0000-0000-0000-000000000000	975666cb-92f9-41b4-a53e-45fb2c3eb3c6	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:27:08.301131+00	
00000000-0000-0000-0000-000000000000	76da7744-e357-4ed1-a09e-ff8813dd4011	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:28:22.034147+00	
00000000-0000-0000-0000-000000000000	2e603207-2c74-4712-940f-efd2b859d91b	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:28:23.434206+00	
00000000-0000-0000-0000-000000000000	e2332945-da1f-4252-bf29-fc949224bd3f	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:28:48.052086+00	
00000000-0000-0000-0000-000000000000	c974421f-9526-4a4c-99bb-9051727a43c4	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:28:49.694344+00	
00000000-0000-0000-0000-000000000000	83ce9766-0148-4adb-a108-9bc608ab8d44	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"finance@gmail.com","user_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","user_phone":""}}	2025-02-19 13:29:47.97751+00	
00000000-0000-0000-0000-000000000000	d1ce47a3-22f2-4321-9e7a-5f841d7cb8b0	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"pastor@gmail.com","user_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","user_phone":""}}	2025-02-19 13:30:03.494071+00	
00000000-0000-0000-0000-000000000000	cb7b0eaa-c726-425e-8b3c-b87956dcf478	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:30:29.701737+00	
00000000-0000-0000-0000-000000000000	dbdaa862-5bcd-456a-8698-ba4319855a3b	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:30:40.324731+00	
00000000-0000-0000-0000-000000000000	68b583b6-dad4-4508-83f1-6b44873063cb	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:31:03.102401+00	
00000000-0000-0000-0000-000000000000	6c4550b3-3d5c-4767-8d22-e61691f7ac19	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:31:14.111816+00	
00000000-0000-0000-0000-000000000000	8a0e98bf-b4dd-4d53-81c4-2981c44db529	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:31:41.063355+00	
00000000-0000-0000-0000-000000000000	e97201ba-e47e-45d7-8ce3-6eea8c6b7e71	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:31:42.976241+00	
00000000-0000-0000-0000-000000000000	31aa19bd-7cc7-4fa0-bc18-1a6685d69b88	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:32:58.970933+00	
00000000-0000-0000-0000-000000000000	7a47a6e2-ce6e-4e4b-870a-4da78bd5989f	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:33:06.752279+00	
00000000-0000-0000-0000-000000000000	aca44591-1396-48d7-9e0b-3528e6b98d8f	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:35:26.094042+00	
00000000-0000-0000-0000-000000000000	3f3531c2-853f-45d6-a353-7e3b6de7b437	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:35:28.93569+00	
00000000-0000-0000-0000-000000000000	16004efc-cd22-4edb-8292-d87f55cb9ebf	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:38:23.302469+00	
00000000-0000-0000-0000-000000000000	9863cab0-49f7-48bc-98ba-1775f91ef532	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:38:24.525608+00	
00000000-0000-0000-0000-000000000000	f1cf01bd-79c8-4952-926e-16354c2fdac8	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:38:48.54199+00	
00000000-0000-0000-0000-000000000000	6f5c581e-01c3-41eb-8b05-75d9462c1686	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:38:58.596755+00	
00000000-0000-0000-0000-000000000000	6ee859b6-84ea-4523-8d3b-8b242f83f63c	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:42:07.64211+00	
00000000-0000-0000-0000-000000000000	05afeb22-8420-4f0a-b31e-68a1a7febcda	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:42:08.91628+00	
00000000-0000-0000-0000-000000000000	e0cbc00e-9dc1-431a-84ca-3ee3ed120ac4	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:45:42.151172+00	
00000000-0000-0000-0000-000000000000	c9c4e356-6c6d-4691-9517-fbdcc940d75c	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:45:43.435218+00	
00000000-0000-0000-0000-000000000000	cc86a3c7-95ec-4bbf-b1f9-70483112bba4	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:47:55.17663+00	
00000000-0000-0000-0000-000000000000	c8c75d85-df14-4b91-94ca-006a9acc6a97	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:47:57.303508+00	
00000000-0000-0000-0000-000000000000	fd0fc27f-ab66-4c7d-a9f5-45cff9fea779	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:54:52.408564+00	
00000000-0000-0000-0000-000000000000	26703612-b1bb-4fd6-b81c-5725e85b5a11	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:54:54.11069+00	
00000000-0000-0000-0000-000000000000	ac1a42b0-5fb0-4005-a3cc-d96c4dac7cc5	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:55:08.627027+00	
00000000-0000-0000-0000-000000000000	2466e347-1d0b-4728-97a7-3b470e9c004e	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:55:11.859782+00	
00000000-0000-0000-0000-000000000000	b5b7de48-eec3-450f-95f7-c4d1d6388e79	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:55:28.115053+00	
00000000-0000-0000-0000-000000000000	6bf7edc4-1716-468f-98cb-e3f7cb0707bd	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:55:34.92053+00	
00000000-0000-0000-0000-000000000000	3961682c-c76d-4a16-aa45-f608329e29a9	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:55:38.80941+00	
00000000-0000-0000-0000-000000000000	3ef2c4d9-56f9-4b38-93ca-e9f757e14404	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"missionary@gmail.com","user_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","user_phone":""}}	2025-02-19 13:56:14.839045+00	
00000000-0000-0000-0000-000000000000	423fe53d-4075-42bf-a35f-b5c380c2452a	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"cd@gmail.com","user_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","user_phone":""}}	2025-02-19 13:56:36.949565+00	
00000000-0000-0000-0000-000000000000	f58a98f7-ad0a-44f0-8c1b-e9a0251a1a8b	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:56:41.185852+00	
00000000-0000-0000-0000-000000000000	da801848-986d-4ff4-8bd6-3a3140ebe112	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:56:48.996984+00	
00000000-0000-0000-0000-000000000000	6752510b-c79a-423e-88b6-23d649eebe1d	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 13:58:44.548913+00	
00000000-0000-0000-0000-000000000000	ad5d7c5a-fdcc-4ccc-aa03-4d00decf66f6	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 13:58:47.539436+00	
00000000-0000-0000-0000-000000000000	580bc24d-d1fb-4f82-9138-237992977fac	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:00:24.507575+00	
00000000-0000-0000-0000-000000000000	eba79dad-60d1-4c00-be33-d2b30acd01c5	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:00:28.961513+00	
00000000-0000-0000-0000-000000000000	c3dc10cf-5c44-4022-9fbe-7ed5aa21d9b4	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:01:12.495384+00	
00000000-0000-0000-0000-000000000000	fb6e6403-5801-4d11-aeec-42e09e36ec31	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:01:20.583148+00	
00000000-0000-0000-0000-000000000000	bcf947b5-1c75-4a98-9627-69f69b92e3f7	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:09:25.324706+00	
00000000-0000-0000-0000-000000000000	ab0a6d9a-4ed8-44a5-9300-7edda6b75786	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:09:26.721456+00	
00000000-0000-0000-0000-000000000000	e0ba506e-7450-433e-bb1b-e9718151ca53	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:23:54.495322+00	
00000000-0000-0000-0000-000000000000	d1693935-ad5c-41a4-b173-861ab223ce24	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:24:00.52623+00	
00000000-0000-0000-0000-000000000000	9a86fc06-8d1d-4c48-b0e0-e9e796cb4599	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:24:13.108433+00	
00000000-0000-0000-0000-000000000000	b14e9f61-9117-4206-9549-b8e35ae60f37	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:24:16.735937+00	
00000000-0000-0000-0000-000000000000	a915386a-e07d-4f6a-9bb4-3a937cec0bf2	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:29:49.333307+00	
00000000-0000-0000-0000-000000000000	bbe4a9d0-f3d4-4be2-8339-25fa3d48b006	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:33:04.560417+00	
00000000-0000-0000-0000-000000000000	4d04ae0a-a15d-4b42-bc1b-f1f178bd3c0a	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:35:43.138381+00	
00000000-0000-0000-0000-000000000000	fe612bcd-adc5-4199-8b38-8c9fbdc5493f	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:35:44.525021+00	
00000000-0000-0000-0000-000000000000	8800f496-daf5-4c73-bbd0-00977ddf69e2	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:12:42.239406+00	
00000000-0000-0000-0000-000000000000	1b2eadb1-fd81-4798-b741-7aa69b01c79b	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:12:43.286443+00	
00000000-0000-0000-0000-000000000000	81281728-b675-4cf5-8cf9-cf5782c5360c	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:13:48.017912+00	
00000000-0000-0000-0000-000000000000	a86aa1d8-ba04-47d2-b7a2-3157930ee257	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:14:06.942418+00	
00000000-0000-0000-0000-000000000000	f8e5867e-908d-4b2a-aa47-6373b32d6ba4	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:15:04.717133+00	
00000000-0000-0000-0000-000000000000	37a273ac-e2ed-466d-a62a-ad5a5848df54	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:15:05.808563+00	
00000000-0000-0000-0000-000000000000	d0b0d1f4-cfff-4d57-9e87-35164f513d24	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:15:28.544738+00	
00000000-0000-0000-0000-000000000000	484f54c6-d817-48a0-9338-20a4b0b761f6	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:15:29.671052+00	
00000000-0000-0000-0000-000000000000	7fe127c5-378c-4d00-b82f-3a8cb57ad99b	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:23:43.203675+00	
00000000-0000-0000-0000-000000000000	d9526f58-d45e-49c4-b86f-d2d24a050873	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:23:46.50939+00	
00000000-0000-0000-0000-000000000000	34fe10f5-a8e6-4c37-a63b-7dd0f2b41847	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:24:41.179675+00	
00000000-0000-0000-0000-000000000000	dfde75ec-91a1-42c5-a933-38606981c910	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:24:43.156631+00	
00000000-0000-0000-0000-000000000000	e42bcd7f-b8b3-467e-acfc-7c4c058330ff	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:25:26.821488+00	
00000000-0000-0000-0000-000000000000	30d8c594-bfba-4e46-9cbb-0eaa05febe70	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:27:54.991574+00	
00000000-0000-0000-0000-000000000000	b693e4e7-74e5-4565-95d7-cdd978bdfaad	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:28:56.845741+00	
00000000-0000-0000-0000-000000000000	516800e6-6b25-40a4-9ef0-bf3ef4f5c770	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:29:03.123362+00	
00000000-0000-0000-0000-000000000000	c918363c-33fe-4842-8723-0f28b727e657	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:29:23.144719+00	
00000000-0000-0000-0000-000000000000	cde3d9d6-58fc-4460-9d4f-7cd52df0102d	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:36:04.767207+00	
00000000-0000-0000-0000-000000000000	58ed9d32-cca6-4891-8ff0-887728747f76	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:36:07.835809+00	
00000000-0000-0000-0000-000000000000	0fef40bb-b742-44e3-89fc-ee17bd65639d	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:37:39.753524+00	
00000000-0000-0000-0000-000000000000	a18d7a7f-f082-478f-b30d-525063e277c8	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:40:15.172702+00	
00000000-0000-0000-0000-000000000000	7ba21e45-fd35-4e52-bf1f-1262333ed599	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:40:17.187631+00	
00000000-0000-0000-0000-000000000000	5c52bfd7-fe23-403f-a935-dff43ead2cfb	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:42:03.532801+00	
00000000-0000-0000-0000-000000000000	7ce443ac-d98a-444b-8b03-f04032ea0499	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:42:08.204224+00	
00000000-0000-0000-0000-000000000000	bd5e0847-d925-4b30-94bd-297eb55c3646	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:47:43.015662+00	
00000000-0000-0000-0000-000000000000	65b0b9af-2767-45cb-98fa-ba600ce37f1e	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:47:44.292269+00	
00000000-0000-0000-0000-000000000000	314c0dcd-92e8-4251-812c-430fb7928183	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:47:52.26355+00	
00000000-0000-0000-0000-000000000000	1324b42f-5746-4c6b-8e83-2205b9d35cd6	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:47:54.80059+00	
00000000-0000-0000-0000-000000000000	a073582c-0dc0-4ebd-8445-fd85c59c2206	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:55:04.000253+00	
00000000-0000-0000-0000-000000000000	663e65d1-e431-4ce7-a1fb-173a414ee59e	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:55:06.176227+00	
00000000-0000-0000-0000-000000000000	0c5ffac1-00c5-4f64-832a-f75e6234b9e8	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:55:09.797814+00	
00000000-0000-0000-0000-000000000000	4637ef0a-021a-4c5d-957a-702cdd46699c	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:55:12.515457+00	
00000000-0000-0000-0000-000000000000	78ee1ac8-97fb-490f-90ff-1765683a4df0	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:57:00.470106+00	
00000000-0000-0000-0000-000000000000	93a04f99-fec5-4219-904b-a403178f9465	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:57:04.012822+00	
00000000-0000-0000-0000-000000000000	791bf5b4-d389-48f0-b48b-78689f1d268d	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 14:57:11.643409+00	
00000000-0000-0000-0000-000000000000	cb0f3e1d-9409-45a6-bf8c-28b9eb4eed1a	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 14:57:14.361374+00	
00000000-0000-0000-0000-000000000000	6002146a-28dc-4d00-b6f2-ae1f19d0f6ca	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:14:07.558404+00	
00000000-0000-0000-0000-000000000000	f45e90b9-0ef9-4541-8ae7-7524d17b1a54	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:14:10.332962+00	
00000000-0000-0000-0000-000000000000	25371d2e-2ca6-40f0-ac3a-f7b827b3455b	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:14:15.747157+00	
00000000-0000-0000-0000-000000000000	bbe47265-2946-438e-a92e-9e803f3af16b	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:14:18.65812+00	
00000000-0000-0000-0000-000000000000	9a8dc934-92fb-470e-9b04-873ebbd01d8e	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:14:23.640507+00	
00000000-0000-0000-0000-000000000000	b25e119d-ebdb-40bd-ba25-5f6006b97d54	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:14:32.96072+00	
00000000-0000-0000-0000-000000000000	31efd925-7399-461a-a736-8f3d47f0d2e2	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:14:55.350597+00	
00000000-0000-0000-0000-000000000000	77411308-6079-44da-88eb-a0f127caa565	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:14:57.69456+00	
00000000-0000-0000-0000-000000000000	b325d2e5-791f-4b57-bacc-afb82c3e9ab1	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:15:01.506512+00	
00000000-0000-0000-0000-000000000000	3a28da50-4918-4177-b3e7-185d7c3fcc47	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:15:35.277783+00	
00000000-0000-0000-0000-000000000000	5c1004fe-cc72-4137-a5a1-dfe21d4aa104	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:15:36.482658+00	
00000000-0000-0000-0000-000000000000	e5dbc5e5-7eea-4d53-bbde-a8ae403d9f7c	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:15:42.122156+00	
00000000-0000-0000-0000-000000000000	1ec61b0a-fe2b-4bcc-b469-d802dc85f785	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:15:44.687274+00	
00000000-0000-0000-0000-000000000000	cba9cd70-a2bf-40fe-9533-66b589df65f4	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:15:49.463825+00	
00000000-0000-0000-0000-000000000000	28a02a19-5e63-46cc-b076-925808f4e12e	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:16:15.51934+00	
00000000-0000-0000-0000-000000000000	e4cb1e91-821f-4496-9d2d-50dc2840f0c9	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:16:22.761158+00	
00000000-0000-0000-0000-000000000000	7de50e09-4c46-4fa9-b2a2-f2fc84335991	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:16:24.637574+00	
00000000-0000-0000-0000-000000000000	081fe089-08fd-4c6f-be0f-4926f7a4f2cf	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:18:06.217348+00	
00000000-0000-0000-0000-000000000000	7ded0683-6b27-4be6-9312-709cd90040b2	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:18:07.291946+00	
00000000-0000-0000-0000-000000000000	2d37b5fa-9f6a-43d5-ac20-8cac7c2fb8ed	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:18:39.586883+00	
00000000-0000-0000-0000-000000000000	bf629f82-d3af-428b-8a07-b79c9d5a3f4f	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:18:41.639833+00	
00000000-0000-0000-0000-000000000000	86364d63-3b7d-4c4a-a32c-9fbcb4431346	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:18:45.968611+00	
00000000-0000-0000-0000-000000000000	74f8fae8-f461-4694-b253-9e03823651f4	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:18:55.26799+00	
00000000-0000-0000-0000-000000000000	ca3db744-95b8-4076-a623-2791616573e1	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:24:00.336149+00	
00000000-0000-0000-0000-000000000000	a1846819-3ccb-41b8-89a1-446a0bb33bd4	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:24:01.394892+00	
00000000-0000-0000-0000-000000000000	7b60f573-fe1c-4b7a-b401-bbd9989c7ea9	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:26:51.2483+00	
00000000-0000-0000-0000-000000000000	e3ace780-9e41-4630-92f6-4608c549f750	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:26:52.54105+00	
00000000-0000-0000-0000-000000000000	5c0b2835-42ff-416a-a22b-ade1d29821a8	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:44:25.734717+00	
00000000-0000-0000-0000-000000000000	d1e86c16-2f88-47ef-b0ec-f4a9353f5b36	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:44:28.431354+00	
00000000-0000-0000-0000-000000000000	0d188e28-3943-4e41-8fe6-3f2fa9f46828	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:44:31.961643+00	
00000000-0000-0000-0000-000000000000	6d62ef41-e4fe-48c3-b4a8-1e760c5ee7db	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:44:38.818063+00	
00000000-0000-0000-0000-000000000000	975d1f3e-37f8-43c0-9ec6-5b4ecdcef842	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:54:47.23713+00	
00000000-0000-0000-0000-000000000000	dafffd86-e8c6-4834-8e5e-518ea0d715e1	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:54:50.169208+00	
00000000-0000-0000-0000-000000000000	fd77ed09-c076-49b9-9b94-2f451aabf1a1	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:58:01.050449+00	
00000000-0000-0000-0000-000000000000	360e01f1-56c3-4691-96d3-f2f00631cdd9	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:58:03.342486+00	
00000000-0000-0000-0000-000000000000	c5ba485c-b956-4d7e-b1e2-783a04514f8c	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:59:30.104186+00	
00000000-0000-0000-0000-000000000000	9b9b94d9-8339-47ed-8e05-02e96e6cf765	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:59:34.543443+00	
00000000-0000-0000-0000-000000000000	a6d4c625-8085-4eb4-81e3-7821268a8238	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:44:50.655567+00	
00000000-0000-0000-0000-000000000000	d3637fcd-68ac-418c-8274-3c41fee72fce	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:45:11.530188+00	
00000000-0000-0000-0000-000000000000	5898624b-3b00-4351-b993-9206af1bc6c3	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:46:18.803745+00	
00000000-0000-0000-0000-000000000000	9a109383-fef3-4b7d-a132-0aa974f98a85	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:46:21.670724+00	
00000000-0000-0000-0000-000000000000	60f79e86-a372-4155-b84d-cdc154127570	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:50:05.584636+00	
00000000-0000-0000-0000-000000000000	112cc36f-a821-43a0-920f-785e4f312f8c	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:50:10.290341+00	
00000000-0000-0000-0000-000000000000	cb0f6083-5f67-414b-afee-c22975131021	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:52:23.031786+00	
00000000-0000-0000-0000-000000000000	6d0bf201-25a3-4f5a-b5d6-efc0465db8ba	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:52:29.139653+00	
00000000-0000-0000-0000-000000000000	925cfd1f-6f7a-4949-b0a9-5399c189ac53	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:54:16.361135+00	
00000000-0000-0000-0000-000000000000	c906a311-9823-409b-a0b6-70710bf0b621	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:54:23.860845+00	
00000000-0000-0000-0000-000000000000	c28de00b-0fe3-4b7b-b2cc-e5378a5092ff	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:54:26.656415+00	
00000000-0000-0000-0000-000000000000	b42417aa-4593-44a6-8f0b-75a1a4e0d6ca	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:54:28.337872+00	
00000000-0000-0000-0000-000000000000	8db4b17b-7f9c-4b9e-b12a-2549f9d48864	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:56:52.442403+00	
00000000-0000-0000-0000-000000000000	b7f501d6-f707-4386-a799-a4a286766b83	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:56:54.984798+00	
00000000-0000-0000-0000-000000000000	a124e928-20b0-4441-97d8-55f1c3763c1c	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:58:20.361746+00	
00000000-0000-0000-0000-000000000000	507ea25b-e723-478c-9cc8-0c185bd48f37	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-19 15:58:40.258297+00	
00000000-0000-0000-0000-000000000000	30111575-7b23-439b-92d1-608f909be2b7	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-19 15:59:40.862185+00	
00000000-0000-0000-0000-000000000000	ad24b11f-086b-40c8-be5e-11a2b57862ec	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-20 00:53:07.079693+00	
00000000-0000-0000-0000-000000000000	acff855c-62fa-4db8-8db7-303a8f06a71e	{"action":"token_refreshed","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-20 01:51:31.565634+00	
00000000-0000-0000-0000-000000000000	75697710-ed54-4d25-846f-7aba66d38d82	{"action":"token_revoked","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-20 01:51:31.567647+00	
00000000-0000-0000-0000-000000000000	c4ece005-44f9-4e2a-a0e1-0a2e3c476a5d	{"action":"token_refreshed","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-20 02:49:49.480183+00	
00000000-0000-0000-0000-000000000000	acba0a10-821b-485c-8f34-1bffe8faf941	{"action":"token_revoked","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-20 02:49:49.481387+00	
00000000-0000-0000-0000-000000000000	1a1eca0b-00af-4bf1-8429-fafca62c3928	{"action":"token_refreshed","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-20 03:48:06.382027+00	
00000000-0000-0000-0000-000000000000	c17f7825-a979-42b7-be7a-964e2a4d0d43	{"action":"token_revoked","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-20 03:48:06.383146+00	
00000000-0000-0000-0000-000000000000	4e0c0239-ba74-4d04-a4ca-60d8bc0b9368	{"action":"token_refreshed","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-20 04:53:44.86351+00	
00000000-0000-0000-0000-000000000000	5c1e40a9-fbb0-440b-8df7-fdc215509ca8	{"action":"token_revoked","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-20 04:53:44.864362+00	
00000000-0000-0000-0000-000000000000	d74dee33-806a-4844-97af-efcda0055b36	{"action":"token_refreshed","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-20 06:44:21.030681+00	
00000000-0000-0000-0000-000000000000	2738e86d-20ea-49e8-9789-c5533060e955	{"action":"token_revoked","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-20 06:44:21.03243+00	
00000000-0000-0000-0000-000000000000	2f662e7b-aca1-4413-8d02-ac26273edba2	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-20 06:47:33.464329+00	
00000000-0000-0000-0000-000000000000	20f9b543-10ed-492a-a87d-e48a0b5d8824	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-20 06:47:36.433037+00	
00000000-0000-0000-0000-000000000000	b170bb2c-7d86-4c2e-b87c-12716704857e	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-20 06:49:03.050113+00	
00000000-0000-0000-0000-000000000000	aedce8e3-867a-4025-83c0-78d1a1a245b6	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-20 06:49:06.230052+00	
00000000-0000-0000-0000-000000000000	63aec465-9607-425b-ba57-2b1701ea6e8b	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-20 06:49:22.67387+00	
00000000-0000-0000-0000-000000000000	daaa59dd-b5d9-4453-a08f-e4d5be0f2197	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-20 06:49:25.23049+00	
00000000-0000-0000-0000-000000000000	60561279-fdd8-46d5-850a-d0995aabcf3d	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-20 07:07:38.180354+00	
00000000-0000-0000-0000-000000000000	145efa5a-0d4c-4890-a094-d0698e29650b	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-20 07:07:41.877775+00	
00000000-0000-0000-0000-000000000000	64a1baa7-3a93-40bd-8997-a08806f7f45c	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-20 07:51:32.837501+00	
00000000-0000-0000-0000-000000000000	c45e21a8-e408-4159-8707-4b45f7aba692	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-20 07:51:34.390097+00	
00000000-0000-0000-0000-000000000000	f1f6ebca-b4a0-4fc9-95b5-d36a9d0c069b	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-20 06:51:40.732826+00	
00000000-0000-0000-0000-000000000000	1e372f92-ebb9-4c48-8333-3eb437e21084	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-20 06:51:42.303751+00	
00000000-0000-0000-0000-000000000000	ba998c97-2664-4fff-9865-616f1f3d2ddf	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-20 06:52:27.757591+00	
00000000-0000-0000-0000-000000000000	b2de6d0e-7ed6-470d-abb3-9b653e7ae55f	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-20 06:52:28.945332+00	
00000000-0000-0000-0000-000000000000	36da675c-3b74-405f-aeda-03cea464c859	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-20 07:42:47.164394+00	
00000000-0000-0000-0000-000000000000	40758bf8-bc52-4e3d-bfcc-a6d3621ceaea	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-20 07:42:48.207545+00	
00000000-0000-0000-0000-000000000000	bd6e3286-19ce-4116-b152-f02a0528a0fd	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-20 07:54:35.986532+00	
00000000-0000-0000-0000-000000000000	dc67078f-50a9-4ac5-8a06-2269eb622b5a	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-20 07:54:37.076023+00	
00000000-0000-0000-0000-000000000000	8c5a9f44-b276-4ce5-97eb-cb078ce63c7e	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-20 07:56:14.579558+00	
00000000-0000-0000-0000-000000000000	79b986af-3d85-4ef2-9500-bb0abe27480b	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-20 07:56:15.678708+00	
00000000-0000-0000-0000-000000000000	cf927604-4b32-4d0c-a639-698627810252	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-20 08:12:09.912112+00	
00000000-0000-0000-0000-000000000000	a1b1ca97-92e7-4f87-87c0-d1c8b53ad6f9	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-20 08:12:12.569719+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\N	b794e95a-97f4-4c05-aa2d-3c13c4155841	\N	\N	mar.loyd.quinto@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	b1f5db31-bfc8-409c-8925-0d21f1c780e6	\N	\N	paul.ryan.pasia@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	\N	\N	john.ian.susi@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	\N	\N	jhomar.carlo.salazar@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	dd35da46-4416-412a-8a22-f3f39491bb7b	\N	\N	dan.joash.bagadiong@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	a83848ba-0779-4fac-98ee-f5f459b2742b	\N	\N	cielo.marie.angeles@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	51072377-1472-46cb-b180-8542677f5eb2	\N	\N	sarah.grace.de.peralta@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	9255fabc-799b-4cc7-8797-5f2470f6adf6	\N	\N	dahlia.delos.reyes@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	6833f990-6a38-4f28-aa18-e31697fa7dc9	\N	\N	caroll.jane.perez@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	6ac1e176-e710-4b5e-9453-95765db20ba3	\N	\N	ma..jirah.joy.rivera@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	463737cc-950b-4a41-8d73-a3daf931fee5	\N	\N	emmanuel.victoria@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	8088628d-f77a-430d-b228-cc3649b8a3e1	\N	\N	mary.florenz.krizza.anzures@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	da6ac18e-72e9-484a-ad75-d044260789cc	\N	\N	a-j.de.guzman@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	a602c1a3-89cf-44a4-b419-f6827ad3701b	\N	\N	ariane.lingat@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	\N	\N	genriel.santiago@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	fd99f59b-fcc6-42ef-a407-207f110f2d7b	\N	\N	desimae.vhiel.susi@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	dde964d6-6ffa-4b25-97b6-128969afe47c	\N	\N	princess.blessie.ventic@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	dbbbe49c-e100-4576-b406-320908c8873e	\N	\N	emily.dionisio@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	5432f125-2d5e-42ab-849a-29add2cf0a74	\N	\N	ma..bernadette.sheyne.mariano@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	bd38508e-8797-4220-ae2e-dd7883b41f17	\N	\N	ronald.carlo.bechayda@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	fc7c7272-6d55-49a3-88d7-fc37133a103f	\N	\N	ben-joe.ryell.prada@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	\N	\N	rose.ann.solo@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	cff64755-2065-4e58-866f-f092cbd9e73b	\N	\N	jemica.dela.cruz@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	ee522e07-1315-4463-8a9b-f890b601c047	\N	\N	laira.santos@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	77e168c1-05e0-4314-8a24-5e838350a3d8	\N	\N	christine.joy.velasco@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	\N	\N	roberto.del.rosario.jr.@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	387d98f7-ccf9-4077-8f79-f0be51c40d05	\N	\N	michael.macale@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	\N	\N	wendy.cainong@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	1934abf8-eca9-41d8-bc5f-9c649285b76b	\N	\N	diana.camaso@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	5bf27593-0c3d-489f-bed4-c80dc2936fdf	\N	\N	christian.reyes@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
\N	584a1909-5797-4297-88d3-06bf5dc3922a	\N	\N	mary.anne.ma├▒osa@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ab8dc40a-9c9b-4391-823b-8578ab506e5e	\N	\N	erick@victory.ph	$2a$06$uItYcsOBm8eBgt7QVONaF.FOMfMH1uOTIbc/bqyGu.atszZDHAdRS	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "Erick Fernandez"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ec874457-5ac3-48c2-90dd-9ea0b8166635	\N	\N	red@victory.ph	$2a$06$F5Jeg/omusrLqDKzZFIsG.9ctGGX0UWe1zBeJ2NMl9VyJFlyg9A.m	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "Red Pondang"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	48d301bd-fea6-4d85-92c0-bf066aa23ae8	\N	\N	king@victory.ph	$2a$06$EyNZ3392zU21Lccs8gQOau/sy/bKsaXkeK9HJbxMHmuy0vAr0py2y	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "King Borlongan"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a3a1e735-b662-49ab-8ccc-a23686553bc3	\N	\N	loyd@victory.ph	$2a$06$uX30zKgwacDmXdQitLVPsO.T15tHd.xEbwOAPwlxB2WFzmp1RkS/W	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "Loyd Janobas"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	326aada0-3dcc-4566-84cc-2541c0e134e2	\N	\N	moss@victory.ph	$2a$06$19KvkzA0VRY0Roam91kaR.icF/K5RVDQVAH/798xz8yG72N1UeHSe	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "Moss Manalaysay"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6f9579a9-4f08-4ab5-8fd2-b7c3d2ee87e2	\N	\N	anthony@victory.ph	$2a$06$IoLlM4tFiZx3TY8r9b8Om.UoQlZe/tHfC7doVnim3r8bnqvHQRexu	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "Anthony Licud"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	910ef066-fdcb-4f99-aac4-458aaacc7a5b	\N	\N	rouie@victory.ph	$2a$06$Es.rUCzV.4RfnuhakTPefua1Rpg57bpFFX0QS9rLEhWcs8lr4yTke	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "Rouie Gutierrez"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	712b5dd0-cd8d-4293-8e66-640624002f2b	\N	\N	robert@victory.ph	$2a$06$N671sRr.I7CHarEpX3kHQO3HhiI8RX1akDmbqdVagLSn8xGNz58Ra	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "Robert Guevarra"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	3795175a-52aa-495b-81c8-01e2d7ae99de	authenticated	authenticated	rob.guevarra@gmail.com	$2a$10$BC3kgPAaleXzuALMTqGv2.iDF7IQgDgWR/Gksr/od0guIjECp6dLe	2025-02-19 02:17:04.338282+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 02:17:04.333903+00	2025-02-19 02:33:39.634178+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	authenticated	authenticated	robneil@gmail.com	$2a$10$wE3mczoBf3hHpZkp2jzRIun1BjDERCfP2eLLfohe8YJugtBS0.8D2	2025-02-04 04:10:22.352101+00	\N		\N		\N			\N	2025-02-20 06:52:28.945987+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-04 04:10:22.347235+00	2025-02-20 06:52:28.947544+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	b188f631-2561-457a-9be6-f556043dfc94	authenticated	authenticated	zoebguevarra@gmail.com	$2a$10$bQHdaPyK1mdXGgQg9o7vq.69b5aB3wbEsZknKCuY8gylTeGxY35eq	2025-02-19 12:19:24.266501+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:19:24.26075+00	2025-02-19 12:19:24.267059+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	bba4e5c1-2eb0-46bd-8f09-cd331ceab351	authenticated	authenticated	xionguevarra@gmail.com	$2a$10$uuySj6hE0NPYCJ/9hY7eY.GQoHA5JVNKiNe.233sCB17XzJQmCRAS	2025-02-19 12:22:37.70027+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:22:37.698012+00	2025-02-19 12:22:37.700734+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	bdebd3ea-5c80-4dff-a03c-a7d0a08947ef	authenticated	authenticated	gracebguevarra@gmail.com	$2a$10$tKIxwleZhiOphLhMGDgkDOd5pu.xBB6ooHQaKkiRG9ly778P8MCc.	2025-02-19 12:24:33.056454+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:24:33.054346+00	2025-02-19 12:24:33.056864+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	authenticated	authenticated	finance@gmail.com	$2a$10$Lzy8Zvwn31AF8ZODI3d0WOF2qRecqIZaYe5Ct/vH.bUftt8tckDfq	2025-02-19 13:29:47.97838+00	\N		\N		\N			\N	2025-02-20 07:56:15.679268+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 13:29:47.975428+00	2025-02-20 07:56:15.680531+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	authenticated	authenticated	cd@gmail.com	$2a$10$dKkU/wN4mOLpL.K852iaGeHZG8MyDfLvcyV/.hOsd/MgEEoTKbjBK	2025-02-19 13:56:36.950301+00	\N		\N		\N			\N	2025-02-20 08:12:12.570241+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 13:56:36.947999+00	2025-02-20 08:12:12.571649+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	dc34a52e-aed8-4354-abb6-7b49085ac24e	authenticated	authenticated	yoshiii@gmail.com	$2a$10$UxqGBuoqgsO/sv1kE9/ZTe76jtRU.pKUW7NHCSeUDbNiAXIv4oMp.	2025-02-19 12:38:02.883063+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:38:02.880649+00	2025-02-19 12:38:02.883441+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	047a2a75-cb6a-46b6-a039-2958efb1af2b	authenticated	authenticated	yosxxx@gmail.com	$2a$10$Paeli66jhVZyj66x8jbGDeCYOV55pbWdvLxIIqJCyZhjeXIthzGQS	2025-02-19 12:38:31.38067+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:38:31.378627+00	2025-02-19 12:38:31.381196+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	3573c57b-43e2-4947-9f9b-38d9bd01ee7f	authenticated	authenticated	jeje@gmail.com	$2a$10$kpZ/v2HbAslAxY0OFPTf8ewfBOuWpX9dabxUnTnQfuiP.sQNG5G.6	2025-02-19 12:40:19.188704+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:40:19.186283+00	2025-02-19 12:40:19.189136+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	bc9fc16c-f1f9-4c2f-ba95-51bd5a0594f3	authenticated	authenticated	jejehaa@gmail.com	$2a$10$jjvya720DEl2VoXs5Fq51ea/jLjYKWtof.G0CO8sqIll.9eKbs2Fe	2025-02-19 12:40:30.356781+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:40:30.354803+00	2025-02-19 12:40:30.357201+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	94f2d973-d8df-435e-8b43-98e7b44fe45b	authenticated	authenticated	reverx@gmail.com	$2a$10$ECtO3fAXDaZVBSTj5Uo2de/jch7UkvX7V7P/OBhWjU695VzHmoWmu	2025-02-19 12:44:47.231916+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:44:47.229524+00	2025-02-19 12:44:47.232275+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6d5b86c5-2939-4003-bb6f-6b177a60038e	authenticated	authenticated	pastor@gmail.com	$2a$10$lafH4rkirV1Xu0/wTSW4LO6UqzinPdhBdGjhrERdOiRzVAqT0cAFG	2025-02-19 13:30:03.49485+00	\N		\N		\N			\N	2025-02-20 06:49:06.230677+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 13:30:03.492587+00	2025-02-20 06:49:06.232576+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	aefe15fe-4937-4f55-a6cb-fb8d739c5905	authenticated	authenticated	missionary@gmail.com	$2a$10$NgRI2rXLmcWMDCbeiBdYp.hlbTwNJpLauzflbj5MpSH6SnFgwszAO	2025-02-19 13:56:14.839908+00	\N		\N		\N			\N	2025-02-19 15:56:54.985571+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 13:56:14.836832+00	2025-02-19 15:56:54.98675+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
aebdeee3-427f-4d5b-832d-8c4ebaecdddc	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	{"sub": "aebdeee3-427f-4d5b-832d-8c4ebaecdddc", "email": "robneil@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-02-04 04:10:22.34949+00	2025-02-04 04:10:22.349524+00	2025-02-04 04:10:22.349524+00	4d958e0f-6574-460b-9cb2-ce8ccf685d1c
3795175a-52aa-495b-81c8-01e2d7ae99de	3795175a-52aa-495b-81c8-01e2d7ae99de	{"sub": "3795175a-52aa-495b-81c8-01e2d7ae99de", "email": "rob.guevarra@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-02-19 02:17:04.336428+00	2025-02-19 02:17:04.336457+00	2025-02-19 02:17:04.336457+00	c3ef17ee-19dc-46c6-98ef-257f12093b4c
b188f631-2561-457a-9be6-f556043dfc94	b188f631-2561-457a-9be6-f556043dfc94	{"sub": "b188f631-2561-457a-9be6-f556043dfc94", "email": "zoebguevarra@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-02-19 12:19:24.264563+00	2025-02-19 12:19:24.264602+00	2025-02-19 12:19:24.264602+00	caefc411-b1ea-4334-93a0-753153dbd611
bba4e5c1-2eb0-46bd-8f09-cd331ceab351	bba4e5c1-2eb0-46bd-8f09-cd331ceab351	{"sub": "bba4e5c1-2eb0-46bd-8f09-cd331ceab351", "email": "xionguevarra@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-02-19 12:22:37.699021+00	2025-02-19 12:22:37.699052+00	2025-02-19 12:22:37.699052+00	3a26755a-eadf-469c-b268-b623685f7cb3
bdebd3ea-5c80-4dff-a03c-a7d0a08947ef	bdebd3ea-5c80-4dff-a03c-a7d0a08947ef	{"sub": "bdebd3ea-5c80-4dff-a03c-a7d0a08947ef", "email": "gracebguevarra@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-02-19 12:24:33.055194+00	2025-02-19 12:24:33.055221+00	2025-02-19 12:24:33.055221+00	fca02ae0-0c91-4ee1-b193-45ec48a80d8f
dc34a52e-aed8-4354-abb6-7b49085ac24e	dc34a52e-aed8-4354-abb6-7b49085ac24e	{"sub": "dc34a52e-aed8-4354-abb6-7b49085ac24e", "email": "yoshiii@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-02-19 12:38:02.88173+00	2025-02-19 12:38:02.881758+00	2025-02-19 12:38:02.881758+00	91076c97-a00a-4720-a485-f7add7e04aad
047a2a75-cb6a-46b6-a039-2958efb1af2b	047a2a75-cb6a-46b6-a039-2958efb1af2b	{"sub": "047a2a75-cb6a-46b6-a039-2958efb1af2b", "email": "yosxxx@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-02-19 12:38:31.379426+00	2025-02-19 12:38:31.379452+00	2025-02-19 12:38:31.379452+00	0d15c7f6-b222-44ef-b724-329db1f4d89f
3573c57b-43e2-4947-9f9b-38d9bd01ee7f	3573c57b-43e2-4947-9f9b-38d9bd01ee7f	{"sub": "3573c57b-43e2-4947-9f9b-38d9bd01ee7f", "email": "jeje@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-02-19 12:40:19.187279+00	2025-02-19 12:40:19.187308+00	2025-02-19 12:40:19.187308+00	6cbb660c-28be-4e48-9fa2-2d6d5542e8d6
bc9fc16c-f1f9-4c2f-ba95-51bd5a0594f3	bc9fc16c-f1f9-4c2f-ba95-51bd5a0594f3	{"sub": "bc9fc16c-f1f9-4c2f-ba95-51bd5a0594f3", "email": "jejehaa@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-02-19 12:40:30.35558+00	2025-02-19 12:40:30.355606+00	2025-02-19 12:40:30.355606+00	a21c4001-2011-4b0c-a232-1ece14f8f4f8
94f2d973-d8df-435e-8b43-98e7b44fe45b	94f2d973-d8df-435e-8b43-98e7b44fe45b	{"sub": "94f2d973-d8df-435e-8b43-98e7b44fe45b", "email": "reverx@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-02-19 12:44:47.230583+00	2025-02-19 12:44:47.230608+00	2025-02-19 12:44:47.230608+00	d60c87d9-9884-4952-ad59-7e1f42b10d38
f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	{"sub": "f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4", "email": "finance@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-02-19 13:29:47.976711+00	2025-02-19 13:29:47.976746+00	2025-02-19 13:29:47.976746+00	ca7781c3-e309-4382-88db-477c954fcb3e
6d5b86c5-2939-4003-bb6f-6b177a60038e	6d5b86c5-2939-4003-bb6f-6b177a60038e	{"sub": "6d5b86c5-2939-4003-bb6f-6b177a60038e", "email": "pastor@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-02-19 13:30:03.49344+00	2025-02-19 13:30:03.493466+00	2025-02-19 13:30:03.493466+00	fa1b4a82-6325-4976-b3f5-0485a3cdea2f
aefe15fe-4937-4f55-a6cb-fb8d739c5905	aefe15fe-4937-4f55-a6cb-fb8d739c5905	{"sub": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "email": "missionary@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-02-19 13:56:14.837967+00	2025-02-19 13:56:14.838001+00	2025-02-19 13:56:14.838001+00	0a7d3769-83a1-4d33-b479-d6712374d902
94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	{"sub": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "email": "cd@gmail.com", "email_verified": false, "phone_verified": false}	email	2025-02-19 13:56:36.948921+00	2025-02-19 13:56:36.948944+00	2025-02-19 13:56:36.948944+00	049c5da4-920f-4244-976e-15b576804363
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
6f18439e-56a6-411e-a797-e84f234b1200	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	2025-02-20 08:12:12.570292+00	2025-02-20 08:12:12.570292+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	172.18.0.1	\N
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
6f18439e-56a6-411e-a797-e84f234b1200	2025-02-20 08:12:12.571835+00	2025-02-20 08:12:12.571835+00	password	4ad7f138-822d-4993-8051-cc8730354292
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	269	PR1EQR4X9xuoFSso9s06wA	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	f	2025-02-20 08:12:12.570847+00	2025-02-20 08:12:12.570847+00	\N	6f18439e-56a6-411e-a797-e84f234b1200
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: key; Type: TABLE DATA; Schema: pgsodium; Owner: supabase_admin
--

COPY pgsodium.key (id, status, created, expires, key_type, key_id, key_context, name, associated_data, raw_key, raw_key_nonce, parent_key, comment, user_data) FROM stdin;
\.


--
-- Data for Name: districts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.districts (id, name, province_id) FROM stdin;
\.


--
-- Data for Name: donors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.donors (id, name, email, phone, created_at) FROM stdin;
1	Donor 1	donor1@example.com	0911234567	2025-02-04 04:08:51.060317+00
2	Donor 2	donor2@example.com	0921234567	2025-02-04 04:08:51.060317+00
3	Donor 3	donor3@example.com	0931234567	2025-02-04 04:08:51.060317+00
4	Donor 4	donor4@example.com	0941234567	2025-02-04 04:08:51.060317+00
5	Donor 5	donor5@example.com	0951234567	2025-02-04 04:08:51.060317+00
6	Donor 6	donor6@example.com	0961234567	2025-02-04 04:08:51.060317+00
7	Donor 7	donor7@example.com	0971234567	2025-02-04 04:08:51.060317+00
8	Donor 8	donor8@example.com	0981234567	2025-02-04 04:08:51.060317+00
9	Donor 9	donor9@example.com	0991234567	2025-02-04 04:08:51.060317+00
10	Donor 10	donor10@example.com	09101234567	2025-02-04 04:08:51.060317+00
11	Donor 11	donor11@example.com	09111234567	2025-02-04 04:08:51.060317+00
12	Donor 12	donor12@example.com	09121234567	2025-02-04 04:08:51.060317+00
13	Donor 13	donor13@example.com	09131234567	2025-02-04 04:08:51.060317+00
14	Donor 14	donor14@example.com	09141234567	2025-02-04 04:08:51.060317+00
15	Donor 15	donor15@example.com	09151234567	2025-02-04 04:08:51.060317+00
16	Donor 16	donor16@example.com	09161234567	2025-02-04 04:08:51.060317+00
17	Donor 17	donor17@example.com	09171234567	2025-02-04 04:08:51.060317+00
18	Donor 18	donor18@example.com	09181234567	2025-02-04 04:08:51.060317+00
19	Donor 19	donor19@example.com	09191234567	2025-02-04 04:08:51.060317+00
20	Donor 20	donor20@example.com	09201234567	2025-02-04 04:08:51.060317+00
21	Donor 21	donor21@example.com	09211234567	2025-02-04 04:08:51.060317+00
22	Donor 22	donor22@example.com	09221234567	2025-02-04 04:08:51.060317+00
23	Donor 23	donor23@example.com	09231234567	2025-02-04 04:08:51.060317+00
24	Donor 24	donor24@example.com	09241234567	2025-02-04 04:08:51.060317+00
25	Donor 25	donor25@example.com	09251234567	2025-02-04 04:08:51.060317+00
26	Donor 26	donor26@example.com	09261234567	2025-02-04 04:08:51.060317+00
27	Donor 27	donor27@example.com	09271234567	2025-02-04 04:08:51.060317+00
28	Donor 28	donor28@example.com	09281234567	2025-02-04 04:08:51.060317+00
29	Donor 29	donor29@example.com	09291234567	2025-02-04 04:08:51.060317+00
30	Donor 30	donor30@example.com	09301234567	2025-02-04 04:08:51.060317+00
31	Donor 31	donor31@example.com	09311234567	2025-02-04 04:08:51.060317+00
32	Donor 32	donor32@example.com	09321234567	2025-02-04 04:08:51.060317+00
33	Donor 33	donor33@example.com	09331234567	2025-02-04 04:08:51.060317+00
34	Donor 34	donor34@example.com	09341234567	2025-02-04 04:08:51.060317+00
35	Donor 35	donor35@example.com	09351234567	2025-02-04 04:08:51.060317+00
36	Donor 36	donor36@example.com	09361234567	2025-02-04 04:08:51.060317+00
37	Donor 37	donor37@example.com	09371234567	2025-02-04 04:08:51.060317+00
38	Donor 38	donor38@example.com	09381234567	2025-02-04 04:08:51.060317+00
39	Donor 39	donor39@example.com	09391234567	2025-02-04 04:08:51.060317+00
40	Donor 40	donor40@example.com	09401234567	2025-02-04 04:08:51.060317+00
41	Donor 41	donor41@example.com	09411234567	2025-02-04 04:08:51.060317+00
42	Donor 42	donor42@example.com	09421234567	2025-02-04 04:08:51.060317+00
43	Donor 43	donor43@example.com	09431234567	2025-02-04 04:08:51.060317+00
44	Donor 44	donor44@example.com	09441234567	2025-02-04 04:08:51.060317+00
45	Donor 45	donor45@example.com	09451234567	2025-02-04 04:08:51.060317+00
46	Donor 46	donor46@example.com	09461234567	2025-02-04 04:08:51.060317+00
47	Donor 47	donor47@example.com	09471234567	2025-02-04 04:08:51.060317+00
48	Donor 48	donor48@example.com	09481234567	2025-02-04 04:08:51.060317+00
49	Donor 49	donor49@example.com	09491234567	2025-02-04 04:08:51.060317+00
50	Donor 50	donor50@example.com	09501234567	2025-02-04 04:08:51.060317+00
51	Donor 51	donor51@example.com	09511234567	2025-02-04 04:08:51.060317+00
52	Donor 52	donor52@example.com	09521234567	2025-02-04 04:08:51.060317+00
53	Donor 53	donor53@example.com	09531234567	2025-02-04 04:08:51.060317+00
54	Donor 54	donor54@example.com	09541234567	2025-02-04 04:08:51.060317+00
55	Donor 55	donor55@example.com	09551234567	2025-02-04 04:08:51.060317+00
56	Donor 56	donor56@example.com	09561234567	2025-02-04 04:08:51.060317+00
57	Donor 57	donor57@example.com	09571234567	2025-02-04 04:08:51.060317+00
58	Donor 58	donor58@example.com	09581234567	2025-02-04 04:08:51.060317+00
59	Donor 59	donor59@example.com	09591234567	2025-02-04 04:08:51.060317+00
60	Donor 60	donor60@example.com	09601234567	2025-02-04 04:08:51.060317+00
61	Donor 61	donor61@example.com	09611234567	2025-02-04 04:08:51.060317+00
62	Donor 62	donor62@example.com	09621234567	2025-02-04 04:08:51.060317+00
63	Donor 63	donor63@example.com	09631234567	2025-02-04 04:08:51.060317+00
64	Donor 64	donor64@example.com	09641234567	2025-02-04 04:08:51.060317+00
65	Donor 65	donor65@example.com	09651234567	2025-02-04 04:08:51.060317+00
66	Donor 66	donor66@example.com	09661234567	2025-02-04 04:08:51.060317+00
67	Donor 67	donor67@example.com	09671234567	2025-02-04 04:08:51.060317+00
68	Donor 68	donor68@example.com	09681234567	2025-02-04 04:08:51.060317+00
69	Donor 69	donor69@example.com	09691234567	2025-02-04 04:08:51.060317+00
70	Donor 70	donor70@example.com	09701234567	2025-02-04 04:08:51.060317+00
71	Donor 71	donor71@example.com	09711234567	2025-02-04 04:08:51.060317+00
72	Donor 72	donor72@example.com	09721234567	2025-02-04 04:08:51.060317+00
73	Donor 73	donor73@example.com	09731234567	2025-02-04 04:08:51.060317+00
74	Donor 74	donor74@example.com	09741234567	2025-02-04 04:08:51.060317+00
75	Donor 75	donor75@example.com	09751234567	2025-02-04 04:08:51.060317+00
76	Donor 76	donor76@example.com	09761234567	2025-02-04 04:08:51.060317+00
77	Donor 77	donor77@example.com	09771234567	2025-02-04 04:08:51.060317+00
78	Donor 78	donor78@example.com	09781234567	2025-02-04 04:08:51.060317+00
79	Donor 79	donor79@example.com	09791234567	2025-02-04 04:08:51.060317+00
80	Donor 80	donor80@example.com	09801234567	2025-02-04 04:08:51.060317+00
81	Donor 81	donor81@example.com	09811234567	2025-02-04 04:08:51.060317+00
82	Donor 82	donor82@example.com	09821234567	2025-02-04 04:08:51.060317+00
83	Donor 83	donor83@example.com	09831234567	2025-02-04 04:08:51.060317+00
84	Donor 84	donor84@example.com	09841234567	2025-02-04 04:08:51.060317+00
85	Donor 85	donor85@example.com	09851234567	2025-02-04 04:08:51.060317+00
86	Donor 86	donor86@example.com	09861234567	2025-02-04 04:08:51.060317+00
87	Donor 87	donor87@example.com	09871234567	2025-02-04 04:08:51.060317+00
88	Donor 88	donor88@example.com	09881234567	2025-02-04 04:08:51.060317+00
89	Donor 89	donor89@example.com	09891234567	2025-02-04 04:08:51.060317+00
90	Donor 90	donor90@example.com	09901234567	2025-02-04 04:08:51.060317+00
91	Donor 91	donor91@example.com	09911234567	2025-02-04 04:08:51.060317+00
92	Donor 92	donor92@example.com	09921234567	2025-02-04 04:08:51.060317+00
93	Donor 93	donor93@example.com	09931234567	2025-02-04 04:08:51.060317+00
94	Donor 94	donor94@example.com	09941234567	2025-02-04 04:08:51.060317+00
95	Donor 95	donor95@example.com	09951234567	2025-02-04 04:08:51.060317+00
96	Donor 96	donor96@example.com	09961234567	2025-02-04 04:08:51.060317+00
97	Donor 97	donor97@example.com	09971234567	2025-02-04 04:08:51.060317+00
98	Donor 98	donor98@example.com	09981234567	2025-02-04 04:08:51.060317+00
99	Donor 99	donor99@example.com	09991234567	2025-02-04 04:08:51.060317+00
100	Donor 100	donor100@example.com	091001234567	2025-02-04 04:08:51.060317+00
101	Donor 101	donor101@example.com	091011234567	2025-02-04 04:08:51.060317+00
102	Donor 102	donor102@example.com	091021234567	2025-02-04 04:08:51.060317+00
103	Donor 103	donor103@example.com	091031234567	2025-02-04 04:08:51.060317+00
104	Donor 104	donor104@example.com	091041234567	2025-02-04 04:08:51.060317+00
105	Donor 105	donor105@example.com	091051234567	2025-02-04 04:08:51.060317+00
106	Donor 106	donor106@example.com	091061234567	2025-02-04 04:08:51.060317+00
107	Donor 107	donor107@example.com	091071234567	2025-02-04 04:08:51.060317+00
108	Donor 108	donor108@example.com	091081234567	2025-02-04 04:08:51.060317+00
109	Donor 109	donor109@example.com	091091234567	2025-02-04 04:08:51.060317+00
110	Donor 110	donor110@example.com	091101234567	2025-02-04 04:08:51.060317+00
111	Donor 111	donor111@example.com	091111234567	2025-02-04 04:08:51.060317+00
112	Donor 112	donor112@example.com	091121234567	2025-02-04 04:08:51.060317+00
113	Donor 113	donor113@example.com	091131234567	2025-02-04 04:08:51.060317+00
114	Donor 114	donor114@example.com	091141234567	2025-02-04 04:08:51.060317+00
115	Donor 115	donor115@example.com	091151234567	2025-02-04 04:08:51.060317+00
116	Donor 116	donor116@example.com	091161234567	2025-02-04 04:08:51.060317+00
117	Donor 117	donor117@example.com	091171234567	2025-02-04 04:08:51.060317+00
118	Donor 118	donor118@example.com	091181234567	2025-02-04 04:08:51.060317+00
119	Donor 119	donor119@example.com	091191234567	2025-02-04 04:08:51.060317+00
120	Donor 120	donor120@example.com	091201234567	2025-02-04 04:08:51.060317+00
121	Donor 121	donor121@example.com	091211234567	2025-02-04 04:08:51.060317+00
122	Donor 122	donor122@example.com	091221234567	2025-02-04 04:08:51.060317+00
123	Donor 123	donor123@example.com	091231234567	2025-02-04 04:08:51.060317+00
124	Donor 124	donor124@example.com	091241234567	2025-02-04 04:08:51.060317+00
125	Donor 125	donor125@example.com	091251234567	2025-02-04 04:08:51.060317+00
126	Donor 126	donor126@example.com	091261234567	2025-02-04 04:08:51.060317+00
127	Donor 127	donor127@example.com	091271234567	2025-02-04 04:08:51.060317+00
128	Donor 128	donor128@example.com	091281234567	2025-02-04 04:08:51.060317+00
129	Donor 129	donor129@example.com	091291234567	2025-02-04 04:08:51.060317+00
130	Donor 130	donor130@example.com	091301234567	2025-02-04 04:08:51.060317+00
131	Donor 131	donor131@example.com	091311234567	2025-02-04 04:08:51.060317+00
132	Donor 132	donor132@example.com	091321234567	2025-02-04 04:08:51.060317+00
133	Donor 133	donor133@example.com	091331234567	2025-02-04 04:08:51.060317+00
134	Donor 134	donor134@example.com	091341234567	2025-02-04 04:08:51.060317+00
135	Donor 135	donor135@example.com	091351234567	2025-02-04 04:08:51.060317+00
136	Donor 136	donor136@example.com	091361234567	2025-02-04 04:08:51.060317+00
137	Donor 137	donor137@example.com	091371234567	2025-02-04 04:08:51.060317+00
138	Donor 138	donor138@example.com	091381234567	2025-02-04 04:08:51.060317+00
139	Donor 139	donor139@example.com	091391234567	2025-02-04 04:08:51.060317+00
140	Donor 140	donor140@example.com	091401234567	2025-02-04 04:08:51.060317+00
141	Donor 141	donor141@example.com	091411234567	2025-02-04 04:08:51.060317+00
142	Donor 142	donor142@example.com	091421234567	2025-02-04 04:08:51.060317+00
143	Donor 143	donor143@example.com	091431234567	2025-02-04 04:08:51.060317+00
144	Donor 144	donor144@example.com	091441234567	2025-02-04 04:08:51.060317+00
145	Donor 145	donor145@example.com	091451234567	2025-02-04 04:08:51.060317+00
146	Donor 146	donor146@example.com	091461234567	2025-02-04 04:08:51.060317+00
147	Donor 147	donor147@example.com	091471234567	2025-02-04 04:08:51.060317+00
148	Donor 148	donor148@example.com	091481234567	2025-02-04 04:08:51.060317+00
149	Donor 149	donor149@example.com	091491234567	2025-02-04 04:08:51.060317+00
150	Donor 150	donor150@example.com	091501234567	2025-02-04 04:08:51.060317+00
151	Donor 151	donor151@example.com	091511234567	2025-02-04 04:08:51.060317+00
152	Donor 152	donor152@example.com	091521234567	2025-02-04 04:08:51.060317+00
153	Donor 153	donor153@example.com	091531234567	2025-02-04 04:08:51.060317+00
154	Donor 154	donor154@example.com	091541234567	2025-02-04 04:08:51.060317+00
155	Donor 155	donor155@example.com	091551234567	2025-02-04 04:08:51.060317+00
156	Donor 156	donor156@example.com	091561234567	2025-02-04 04:08:51.060317+00
157	Donor 157	donor157@example.com	091571234567	2025-02-04 04:08:51.060317+00
158	Donor 158	donor158@example.com	091581234567	2025-02-04 04:08:51.060317+00
159	Donor 159	donor159@example.com	091591234567	2025-02-04 04:08:51.060317+00
160	Donor 160	donor160@example.com	091601234567	2025-02-04 04:08:51.060317+00
161	Donor 161	donor161@example.com	091611234567	2025-02-04 04:08:51.060317+00
162	Donor 162	donor162@example.com	091621234567	2025-02-04 04:08:51.060317+00
163	Donor 163	donor163@example.com	091631234567	2025-02-04 04:08:51.060317+00
164	Donor 164	donor164@example.com	091641234567	2025-02-04 04:08:51.060317+00
165	Donor 165	donor165@example.com	091651234567	2025-02-04 04:08:51.060317+00
166	Donor 166	donor166@example.com	091661234567	2025-02-04 04:08:51.060317+00
167	Donor 167	donor167@example.com	091671234567	2025-02-04 04:08:51.060317+00
168	Donor 168	donor168@example.com	091681234567	2025-02-04 04:08:51.060317+00
169	Donor 169	donor169@example.com	091691234567	2025-02-04 04:08:51.060317+00
170	Donor 170	donor170@example.com	091701234567	2025-02-04 04:08:51.060317+00
171	Donor 171	donor171@example.com	091711234567	2025-02-04 04:08:51.060317+00
172	Donor 172	donor172@example.com	091721234567	2025-02-04 04:08:51.060317+00
173	Donor 173	donor173@example.com	091731234567	2025-02-04 04:08:51.060317+00
174	Donor 174	donor174@example.com	091741234567	2025-02-04 04:08:51.060317+00
175	Donor 175	donor175@example.com	091751234567	2025-02-04 04:08:51.060317+00
176	Donor 176	donor176@example.com	091761234567	2025-02-04 04:08:51.060317+00
177	Donor 177	donor177@example.com	091771234567	2025-02-04 04:08:51.060317+00
178	Donor 178	donor178@example.com	091781234567	2025-02-04 04:08:51.060317+00
179	Donor 179	donor179@example.com	091791234567	2025-02-04 04:08:51.060317+00
180	Donor 180	donor180@example.com	091801234567	2025-02-04 04:08:51.060317+00
181	Donor 181	donor181@example.com	091811234567	2025-02-04 04:08:51.060317+00
182	Donor 182	donor182@example.com	091821234567	2025-02-04 04:08:51.060317+00
183	Donor 183	donor183@example.com	091831234567	2025-02-04 04:08:51.060317+00
184	Donor 184	donor184@example.com	091841234567	2025-02-04 04:08:51.060317+00
185	Donor 185	donor185@example.com	091851234567	2025-02-04 04:08:51.060317+00
186	Donor 186	donor186@example.com	091861234567	2025-02-04 04:08:51.060317+00
187	Donor 187	donor187@example.com	091871234567	2025-02-04 04:08:51.060317+00
188	Donor 188	donor188@example.com	091881234567	2025-02-04 04:08:51.060317+00
189	Donor 189	donor189@example.com	091891234567	2025-02-04 04:08:51.060317+00
190	Donor 190	donor190@example.com	091901234567	2025-02-04 04:08:51.060317+00
191	Donor 191	donor191@example.com	091911234567	2025-02-04 04:08:51.060317+00
192	Donor 192	donor192@example.com	091921234567	2025-02-04 04:08:51.060317+00
193	Donor 193	donor193@example.com	091931234567	2025-02-04 04:08:51.060317+00
194	Donor 194	donor194@example.com	091941234567	2025-02-04 04:08:51.060317+00
195	Donor 195	donor195@example.com	091951234567	2025-02-04 04:08:51.060317+00
196	Donor 196	donor196@example.com	091961234567	2025-02-04 04:08:51.060317+00
197	Donor 197	donor197@example.com	091971234567	2025-02-04 04:08:51.060317+00
198	Donor 198	donor198@example.com	091981234567	2025-02-04 04:08:51.060317+00
199	Donor 199	donor199@example.com	091991234567	2025-02-04 04:08:51.060317+00
200	Donor 200	donor200@example.com	092001234567	2025-02-04 04:08:51.060317+00
201	Donor 201	donor201@example.com	092011234567	2025-02-04 04:08:51.060317+00
202	Donor 202	donor202@example.com	092021234567	2025-02-04 04:08:51.060317+00
203	Donor 203	donor203@example.com	092031234567	2025-02-04 04:08:51.060317+00
204	Donor 204	donor204@example.com	092041234567	2025-02-04 04:08:51.060317+00
205	Donor 205	donor205@example.com	092051234567	2025-02-04 04:08:51.060317+00
206	Donor 206	donor206@example.com	092061234567	2025-02-04 04:08:51.060317+00
207	Donor 207	donor207@example.com	092071234567	2025-02-04 04:08:51.060317+00
208	Donor 208	donor208@example.com	092081234567	2025-02-04 04:08:51.060317+00
209	Donor 209	donor209@example.com	092091234567	2025-02-04 04:08:51.060317+00
210	Donor 210	donor210@example.com	092101234567	2025-02-04 04:08:51.060317+00
211	Donor 211	donor211@example.com	092111234567	2025-02-04 04:08:51.060317+00
212	Donor 212	donor212@example.com	092121234567	2025-02-04 04:08:51.060317+00
213	Donor 213	donor213@example.com	092131234567	2025-02-04 04:08:51.060317+00
214	Donor 214	donor214@example.com	092141234567	2025-02-04 04:08:51.060317+00
215	Donor 215	donor215@example.com	092151234567	2025-02-04 04:08:51.060317+00
216	Donor 216	donor216@example.com	092161234567	2025-02-04 04:08:51.060317+00
217	Donor 217	donor217@example.com	092171234567	2025-02-04 04:08:51.060317+00
218	Donor 218	donor218@example.com	092181234567	2025-02-04 04:08:51.060317+00
219	Donor 219	donor219@example.com	092191234567	2025-02-04 04:08:51.060317+00
220	Donor 220	donor220@example.com	092201234567	2025-02-04 04:08:51.060317+00
221	Donor 221	donor221@example.com	092211234567	2025-02-04 04:08:51.060317+00
222	Donor 222	donor222@example.com	092221234567	2025-02-04 04:08:51.060317+00
223	Donor 223	donor223@example.com	092231234567	2025-02-04 04:08:51.060317+00
224	Donor 224	donor224@example.com	092241234567	2025-02-04 04:08:51.060317+00
225	Donor 225	donor225@example.com	092251234567	2025-02-04 04:08:51.060317+00
226	Donor 226	donor226@example.com	092261234567	2025-02-04 04:08:51.060317+00
227	Donor 227	donor227@example.com	092271234567	2025-02-04 04:08:51.060317+00
228	Donor 228	donor228@example.com	092281234567	2025-02-04 04:08:51.060317+00
229	Donor 229	donor229@example.com	092291234567	2025-02-04 04:08:51.060317+00
230	Donor 230	donor230@example.com	092301234567	2025-02-04 04:08:51.060317+00
231	Donor 231	donor231@example.com	092311234567	2025-02-04 04:08:51.060317+00
232	Donor 232	donor232@example.com	092321234567	2025-02-04 04:08:51.060317+00
233	Donor 233	donor233@example.com	092331234567	2025-02-04 04:08:51.060317+00
234	Donor 234	donor234@example.com	092341234567	2025-02-04 04:08:51.060317+00
235	Donor 235	donor235@example.com	092351234567	2025-02-04 04:08:51.060317+00
236	Donor 236	donor236@example.com	092361234567	2025-02-04 04:08:51.060317+00
237	Donor 237	donor237@example.com	092371234567	2025-02-04 04:08:51.060317+00
238	Donor 238	donor238@example.com	092381234567	2025-02-04 04:08:51.060317+00
239	Donor 239	donor239@example.com	092391234567	2025-02-04 04:08:51.060317+00
240	Donor 240	donor240@example.com	092401234567	2025-02-04 04:08:51.060317+00
241	Donor 241	donor241@example.com	092411234567	2025-02-04 04:08:51.060317+00
242	Donor 242	donor242@example.com	092421234567	2025-02-04 04:08:51.060317+00
243	Donor 243	donor243@example.com	092431234567	2025-02-04 04:08:51.060317+00
244	Donor 244	donor244@example.com	092441234567	2025-02-04 04:08:51.060317+00
245	Donor 245	donor245@example.com	092451234567	2025-02-04 04:08:51.060317+00
246	Donor 246	donor246@example.com	092461234567	2025-02-04 04:08:51.060317+00
247	Donor 247	donor247@example.com	092471234567	2025-02-04 04:08:51.060317+00
248	Donor 248	donor248@example.com	092481234567	2025-02-04 04:08:51.060317+00
249	Donor 249	donor249@example.com	092491234567	2025-02-04 04:08:51.060317+00
250	Donor 250	donor250@example.com	092501234567	2025-02-04 04:08:51.060317+00
251	Donor 251	donor251@example.com	092511234567	2025-02-04 04:08:51.060317+00
252	Donor 252	donor252@example.com	092521234567	2025-02-04 04:08:51.060317+00
253	Donor 253	donor253@example.com	092531234567	2025-02-04 04:08:51.060317+00
254	Donor 254	donor254@example.com	092541234567	2025-02-04 04:08:51.060317+00
255	Donor 255	donor255@example.com	092551234567	2025-02-04 04:08:51.060317+00
256	Donor 256	donor256@example.com	092561234567	2025-02-04 04:08:51.060317+00
257	Donor 257	donor257@example.com	092571234567	2025-02-04 04:08:51.060317+00
258	Donor 258	donor258@example.com	092581234567	2025-02-04 04:08:51.060317+00
259	Donor 259	donor259@example.com	092591234567	2025-02-04 04:08:51.060317+00
260	Donor 260	donor260@example.com	092601234567	2025-02-04 04:08:51.060317+00
261	Donor 261	donor261@example.com	092611234567	2025-02-04 04:08:51.060317+00
262	Donor 262	donor262@example.com	092621234567	2025-02-04 04:08:51.060317+00
263	Donor 263	donor263@example.com	092631234567	2025-02-04 04:08:51.060317+00
264	Donor 264	donor264@example.com	092641234567	2025-02-04 04:08:51.060317+00
265	Donor 265	donor265@example.com	092651234567	2025-02-04 04:08:51.060317+00
266	Donor 266	donor266@example.com	092661234567	2025-02-04 04:08:51.060317+00
267	Donor 267	donor267@example.com	092671234567	2025-02-04 04:08:51.060317+00
268	Donor 268	donor268@example.com	092681234567	2025-02-04 04:08:51.060317+00
269	Donor 269	donor269@example.com	092691234567	2025-02-04 04:08:51.060317+00
270	Donor 270	donor270@example.com	092701234567	2025-02-04 04:08:51.060317+00
271	Donor 271	donor271@example.com	092711234567	2025-02-04 04:08:51.060317+00
272	Donor 272	donor272@example.com	092721234567	2025-02-04 04:08:51.060317+00
273	Donor 273	donor273@example.com	092731234567	2025-02-04 04:08:51.060317+00
274	Donor 274	donor274@example.com	092741234567	2025-02-04 04:08:51.060317+00
275	Donor 275	donor275@example.com	092751234567	2025-02-04 04:08:51.060317+00
276	Donor 276	donor276@example.com	092761234567	2025-02-04 04:08:51.060317+00
277	Donor 277	donor277@example.com	092771234567	2025-02-04 04:08:51.060317+00
278	Donor 278	donor278@example.com	092781234567	2025-02-04 04:08:51.060317+00
279	Donor 279	donor279@example.com	092791234567	2025-02-04 04:08:51.060317+00
280	Donor 280	donor280@example.com	092801234567	2025-02-04 04:08:51.060317+00
281	Donor 281	donor281@example.com	092811234567	2025-02-04 04:08:51.060317+00
282	Donor 282	donor282@example.com	092821234567	2025-02-04 04:08:51.060317+00
283	Donor 283	donor283@example.com	092831234567	2025-02-04 04:08:51.060317+00
284	Donor 284	donor284@example.com	092841234567	2025-02-04 04:08:51.060317+00
285	Donor 285	donor285@example.com	092851234567	2025-02-04 04:08:51.060317+00
286	Donor 286	donor286@example.com	092861234567	2025-02-04 04:08:51.060317+00
287	Donor 287	donor287@example.com	092871234567	2025-02-04 04:08:51.060317+00
288	Donor 288	donor288@example.com	092881234567	2025-02-04 04:08:51.060317+00
289	Donor 289	donor289@example.com	092891234567	2025-02-04 04:08:51.060317+00
290	Donor 290	donor290@example.com	092901234567	2025-02-04 04:08:51.060317+00
291	Donor 291	donor291@example.com	092911234567	2025-02-04 04:08:51.060317+00
292	Donor 292	donor292@example.com	092921234567	2025-02-04 04:08:51.060317+00
293	Donor 293	donor293@example.com	092931234567	2025-02-04 04:08:51.060317+00
294	Donor 294	donor294@example.com	092941234567	2025-02-04 04:08:51.060317+00
295	Donor 295	donor295@example.com	092951234567	2025-02-04 04:08:51.060317+00
296	Donor 296	donor296@example.com	092961234567	2025-02-04 04:08:51.060317+00
297	Donor 297	donor297@example.com	092971234567	2025-02-04 04:08:51.060317+00
298	Donor 298	donor298@example.com	092981234567	2025-02-04 04:08:51.060317+00
299	Donor 299	donor299@example.com	092991234567	2025-02-04 04:08:51.060317+00
300	Donor 300	donor300@example.com	093001234567	2025-02-04 04:08:51.060317+00
301	Donor 301	donor301@example.com	093011234567	2025-02-04 04:08:51.060317+00
302	Donor 302	donor302@example.com	093021234567	2025-02-04 04:08:51.060317+00
303	Donor 303	donor303@example.com	093031234567	2025-02-04 04:08:51.060317+00
304	Donor 304	donor304@example.com	093041234567	2025-02-04 04:08:51.060317+00
305	Donor 305	donor305@example.com	093051234567	2025-02-04 04:08:51.060317+00
306	Donor 306	donor306@example.com	093061234567	2025-02-04 04:08:51.060317+00
307	Donor 307	donor307@example.com	093071234567	2025-02-04 04:08:51.060317+00
308	Donor 308	donor308@example.com	093081234567	2025-02-04 04:08:51.060317+00
309	Donor 309	donor309@example.com	093091234567	2025-02-04 04:08:51.060317+00
310	Donor 310	donor310@example.com	093101234567	2025-02-04 04:08:51.060317+00
311	Donor 311	donor311@example.com	093111234567	2025-02-04 04:08:51.060317+00
312	Donor 312	donor312@example.com	093121234567	2025-02-04 04:08:51.060317+00
313	Donor 313	donor313@example.com	093131234567	2025-02-04 04:08:51.060317+00
314	Donor 314	donor314@example.com	093141234567	2025-02-04 04:08:51.060317+00
315	Donor 315	donor315@example.com	093151234567	2025-02-04 04:08:51.060317+00
316	Donor 316	donor316@example.com	093161234567	2025-02-04 04:08:51.060317+00
317	Donor 317	donor317@example.com	093171234567	2025-02-04 04:08:51.060317+00
318	Donor 318	donor318@example.com	093181234567	2025-02-04 04:08:51.060317+00
319	Donor 319	donor319@example.com	093191234567	2025-02-04 04:08:51.060317+00
320	Donor 320	donor320@example.com	093201234567	2025-02-04 04:08:51.060317+00
321	Donor 321	donor321@example.com	093211234567	2025-02-04 04:08:51.060317+00
322	Donor 322	donor322@example.com	093221234567	2025-02-04 04:08:51.060317+00
323	Donor 323	donor323@example.com	093231234567	2025-02-04 04:08:51.060317+00
324	Donor 324	donor324@example.com	093241234567	2025-02-04 04:08:51.060317+00
325	Donor 325	donor325@example.com	093251234567	2025-02-04 04:08:51.060317+00
326	Donor 326	donor326@example.com	093261234567	2025-02-04 04:08:51.060317+00
327	Donor 327	donor327@example.com	093271234567	2025-02-04 04:08:51.060317+00
328	Donor 328	donor328@example.com	093281234567	2025-02-04 04:08:51.060317+00
329	Donor 329	donor329@example.com	093291234567	2025-02-04 04:08:51.060317+00
330	Donor 330	donor330@example.com	093301234567	2025-02-04 04:08:51.060317+00
331	Donor 331	donor331@example.com	093311234567	2025-02-04 04:08:51.060317+00
332	Donor 332	donor332@example.com	093321234567	2025-02-04 04:08:51.060317+00
333	Donor 333	donor333@example.com	093331234567	2025-02-04 04:08:51.060317+00
334	Donor 334	donor334@example.com	093341234567	2025-02-04 04:08:51.060317+00
335	Donor 335	donor335@example.com	093351234567	2025-02-04 04:08:51.060317+00
336	Donor 336	donor336@example.com	093361234567	2025-02-04 04:08:51.060317+00
337	Donor 337	donor337@example.com	093371234567	2025-02-04 04:08:51.060317+00
338	Donor 338	donor338@example.com	093381234567	2025-02-04 04:08:51.060317+00
339	Donor 339	donor339@example.com	093391234567	2025-02-04 04:08:51.060317+00
340	Donor 340	donor340@example.com	093401234567	2025-02-04 04:08:51.060317+00
341	Donor 341	donor341@example.com	093411234567	2025-02-04 04:08:51.060317+00
342	Donor 342	donor342@example.com	093421234567	2025-02-04 04:08:51.060317+00
343	Donor 343	donor343@example.com	093431234567	2025-02-04 04:08:51.060317+00
344	Donor 344	donor344@example.com	093441234567	2025-02-04 04:08:51.060317+00
345	Donor 345	donor345@example.com	093451234567	2025-02-04 04:08:51.060317+00
346	Donor 346	donor346@example.com	093461234567	2025-02-04 04:08:51.060317+00
347	Donor 347	donor347@example.com	093471234567	2025-02-04 04:08:51.060317+00
348	Donor 348	donor348@example.com	093481234567	2025-02-04 04:08:51.060317+00
349	Donor 349	donor349@example.com	093491234567	2025-02-04 04:08:51.060317+00
350	Donor 350	donor350@example.com	093501234567	2025-02-04 04:08:51.060317+00
351	Donor 351	donor351@example.com	093511234567	2025-02-04 04:08:51.060317+00
352	Donor 352	donor352@example.com	093521234567	2025-02-04 04:08:51.060317+00
353	Donor 353	donor353@example.com	093531234567	2025-02-04 04:08:51.060317+00
354	Donor 354	donor354@example.com	093541234567	2025-02-04 04:08:51.060317+00
355	Donor 355	donor355@example.com	093551234567	2025-02-04 04:08:51.060317+00
356	Donor 356	donor356@example.com	093561234567	2025-02-04 04:08:51.060317+00
357	Donor 357	donor357@example.com	093571234567	2025-02-04 04:08:51.060317+00
358	Donor 358	donor358@example.com	093581234567	2025-02-04 04:08:51.060317+00
359	Donor 359	donor359@example.com	093591234567	2025-02-04 04:08:51.060317+00
360	Donor 360	donor360@example.com	093601234567	2025-02-04 04:08:51.060317+00
361	Donor 361	donor361@example.com	093611234567	2025-02-04 04:08:51.060317+00
362	Donor 362	donor362@example.com	093621234567	2025-02-04 04:08:51.060317+00
363	Donor 363	donor363@example.com	093631234567	2025-02-04 04:08:51.060317+00
364	Donor 364	donor364@example.com	093641234567	2025-02-04 04:08:51.060317+00
365	Donor 365	donor365@example.com	093651234567	2025-02-04 04:08:51.060317+00
366	Donor 366	donor366@example.com	093661234567	2025-02-04 04:08:51.060317+00
367	Donor 367	donor367@example.com	093671234567	2025-02-04 04:08:51.060317+00
368	Donor 368	donor368@example.com	093681234567	2025-02-04 04:08:51.060317+00
369	Donor 369	donor369@example.com	093691234567	2025-02-04 04:08:51.060317+00
370	Donor 370	donor370@example.com	093701234567	2025-02-04 04:08:51.060317+00
371	Donor 371	donor371@example.com	093711234567	2025-02-04 04:08:51.060317+00
372	Donor 372	donor372@example.com	093721234567	2025-02-04 04:08:51.060317+00
373	Donor 373	donor373@example.com	093731234567	2025-02-04 04:08:51.060317+00
374	Donor 374	donor374@example.com	093741234567	2025-02-04 04:08:51.060317+00
375	Donor 375	donor375@example.com	093751234567	2025-02-04 04:08:51.060317+00
376	Donor 376	donor376@example.com	093761234567	2025-02-04 04:08:51.060317+00
377	Donor 377	donor377@example.com	093771234567	2025-02-04 04:08:51.060317+00
378	Donor 378	donor378@example.com	093781234567	2025-02-04 04:08:51.060317+00
379	Donor 379	donor379@example.com	093791234567	2025-02-04 04:08:51.060317+00
380	Donor 380	donor380@example.com	093801234567	2025-02-04 04:08:51.060317+00
381	Donor 381	donor381@example.com	093811234567	2025-02-04 04:08:51.060317+00
382	Donor 382	donor382@example.com	093821234567	2025-02-04 04:08:51.060317+00
383	Donor 383	donor383@example.com	093831234567	2025-02-04 04:08:51.060317+00
384	Donor 384	donor384@example.com	093841234567	2025-02-04 04:08:51.060317+00
385	Donor 385	donor385@example.com	093851234567	2025-02-04 04:08:51.060317+00
386	Donor 386	donor386@example.com	093861234567	2025-02-04 04:08:51.060317+00
387	Donor 387	donor387@example.com	093871234567	2025-02-04 04:08:51.060317+00
388	Donor 388	donor388@example.com	093881234567	2025-02-04 04:08:51.060317+00
389	Donor 389	donor389@example.com	093891234567	2025-02-04 04:08:51.060317+00
390	Donor 390	donor390@example.com	093901234567	2025-02-04 04:08:51.060317+00
391	Donor 391	donor391@example.com	093911234567	2025-02-04 04:08:51.060317+00
392	Donor 392	donor392@example.com	093921234567	2025-02-04 04:08:51.060317+00
393	Donor 393	donor393@example.com	093931234567	2025-02-04 04:08:51.060317+00
394	Donor 394	donor394@example.com	093941234567	2025-02-04 04:08:51.060317+00
395	Donor 395	donor395@example.com	093951234567	2025-02-04 04:08:51.060317+00
396	Donor 396	donor396@example.com	093961234567	2025-02-04 04:08:51.060317+00
397	Donor 397	donor397@example.com	093971234567	2025-02-04 04:08:51.060317+00
398	Donor 398	donor398@example.com	093981234567	2025-02-04 04:08:51.060317+00
399	Donor 399	donor399@example.com	093991234567	2025-02-04 04:08:51.060317+00
400	Donor 400	donor400@example.com	094001234567	2025-02-04 04:08:51.060317+00
401	Donor 401	donor401@example.com	094011234567	2025-02-04 04:08:51.060317+00
402	Donor 402	donor402@example.com	094021234567	2025-02-04 04:08:51.060317+00
403	Donor 403	donor403@example.com	094031234567	2025-02-04 04:08:51.060317+00
404	Donor 404	donor404@example.com	094041234567	2025-02-04 04:08:51.060317+00
405	Donor 405	donor405@example.com	094051234567	2025-02-04 04:08:51.060317+00
406	Donor 406	donor406@example.com	094061234567	2025-02-04 04:08:51.060317+00
407	Donor 407	donor407@example.com	094071234567	2025-02-04 04:08:51.060317+00
408	Donor 408	donor408@example.com	094081234567	2025-02-04 04:08:51.060317+00
409	Donor 409	donor409@example.com	094091234567	2025-02-04 04:08:51.060317+00
410	Donor 410	donor410@example.com	094101234567	2025-02-04 04:08:51.060317+00
411	Donor 411	donor411@example.com	094111234567	2025-02-04 04:08:51.060317+00
412	Donor 412	donor412@example.com	094121234567	2025-02-04 04:08:51.060317+00
413	Donor 413	donor413@example.com	094131234567	2025-02-04 04:08:51.060317+00
414	Donor 414	donor414@example.com	094141234567	2025-02-04 04:08:51.060317+00
415	Donor 415	donor415@example.com	094151234567	2025-02-04 04:08:51.060317+00
416	Donor 416	donor416@example.com	094161234567	2025-02-04 04:08:51.060317+00
417	Donor 417	donor417@example.com	094171234567	2025-02-04 04:08:51.060317+00
418	Donor 418	donor418@example.com	094181234567	2025-02-04 04:08:51.060317+00
419	Donor 419	donor419@example.com	094191234567	2025-02-04 04:08:51.060317+00
420	Donor 420	donor420@example.com	094201234567	2025-02-04 04:08:51.060317+00
421	Donor 421	donor421@example.com	094211234567	2025-02-04 04:08:51.060317+00
422	Donor 422	donor422@example.com	094221234567	2025-02-04 04:08:51.060317+00
423	Donor 423	donor423@example.com	094231234567	2025-02-04 04:08:51.060317+00
424	Donor 424	donor424@example.com	094241234567	2025-02-04 04:08:51.060317+00
425	Donor 425	donor425@example.com	094251234567	2025-02-04 04:08:51.060317+00
426	Donor 426	donor426@example.com	094261234567	2025-02-04 04:08:51.060317+00
427	Donor 427	donor427@example.com	094271234567	2025-02-04 04:08:51.060317+00
428	Donor 428	donor428@example.com	094281234567	2025-02-04 04:08:51.060317+00
429	Donor 429	donor429@example.com	094291234567	2025-02-04 04:08:51.060317+00
430	Donor 430	donor430@example.com	094301234567	2025-02-04 04:08:51.060317+00
431	Donor 431	donor431@example.com	094311234567	2025-02-04 04:08:51.060317+00
432	Donor 432	donor432@example.com	094321234567	2025-02-04 04:08:51.060317+00
433	Donor 433	donor433@example.com	094331234567	2025-02-04 04:08:51.060317+00
434	Donor 434	donor434@example.com	094341234567	2025-02-04 04:08:51.060317+00
435	Donor 435	donor435@example.com	094351234567	2025-02-04 04:08:51.060317+00
436	Donor 436	donor436@example.com	094361234567	2025-02-04 04:08:51.060317+00
437	Donor 437	donor437@example.com	094371234567	2025-02-04 04:08:51.060317+00
438	Donor 438	donor438@example.com	094381234567	2025-02-04 04:08:51.060317+00
439	Donor 439	donor439@example.com	094391234567	2025-02-04 04:08:51.060317+00
440	Donor 440	donor440@example.com	094401234567	2025-02-04 04:08:51.060317+00
441	Donor 441	donor441@example.com	094411234567	2025-02-04 04:08:51.060317+00
442	Donor 442	donor442@example.com	094421234567	2025-02-04 04:08:51.060317+00
443	Donor 443	donor443@example.com	094431234567	2025-02-04 04:08:51.060317+00
444	Donor 444	donor444@example.com	094441234567	2025-02-04 04:08:51.060317+00
445	Donor 445	donor445@example.com	094451234567	2025-02-04 04:08:51.060317+00
446	Donor 446	donor446@example.com	094461234567	2025-02-04 04:08:51.060317+00
447	Donor 447	donor447@example.com	094471234567	2025-02-04 04:08:51.060317+00
448	Donor 448	donor448@example.com	094481234567	2025-02-04 04:08:51.060317+00
449	Donor 449	donor449@example.com	094491234567	2025-02-04 04:08:51.060317+00
450	Donor 450	donor450@example.com	094501234567	2025-02-04 04:08:51.060317+00
451	Donor 451	donor451@example.com	094511234567	2025-02-04 04:08:51.060317+00
452	Donor 452	donor452@example.com	094521234567	2025-02-04 04:08:51.060317+00
453	Donor 453	donor453@example.com	094531234567	2025-02-04 04:08:51.060317+00
454	Donor 454	donor454@example.com	094541234567	2025-02-04 04:08:51.060317+00
455	Donor 455	donor455@example.com	094551234567	2025-02-04 04:08:51.060317+00
456	Donor 456	donor456@example.com	094561234567	2025-02-04 04:08:51.060317+00
457	Donor 457	donor457@example.com	094571234567	2025-02-04 04:08:51.060317+00
458	Donor 458	donor458@example.com	094581234567	2025-02-04 04:08:51.060317+00
459	Donor 459	donor459@example.com	094591234567	2025-02-04 04:08:51.060317+00
460	Donor 460	donor460@example.com	094601234567	2025-02-04 04:08:51.060317+00
461	Donor 461	donor461@example.com	094611234567	2025-02-04 04:08:51.060317+00
462	Donor 462	donor462@example.com	094621234567	2025-02-04 04:08:51.060317+00
463	Donor 463	donor463@example.com	094631234567	2025-02-04 04:08:51.060317+00
464	Donor 464	donor464@example.com	094641234567	2025-02-04 04:08:51.060317+00
465	Donor 465	donor465@example.com	094651234567	2025-02-04 04:08:51.060317+00
466	Donor 466	donor466@example.com	094661234567	2025-02-04 04:08:51.060317+00
467	Donor 467	donor467@example.com	094671234567	2025-02-04 04:08:51.060317+00
468	Donor 468	donor468@example.com	094681234567	2025-02-04 04:08:51.060317+00
469	Donor 469	donor469@example.com	094691234567	2025-02-04 04:08:51.060317+00
470	Donor 470	donor470@example.com	094701234567	2025-02-04 04:08:51.060317+00
471	Donor 471	donor471@example.com	094711234567	2025-02-04 04:08:51.060317+00
472	Donor 472	donor472@example.com	094721234567	2025-02-04 04:08:51.060317+00
473	Donor 473	donor473@example.com	094731234567	2025-02-04 04:08:51.060317+00
474	Donor 474	donor474@example.com	094741234567	2025-02-04 04:08:51.060317+00
475	Donor 475	donor475@example.com	094751234567	2025-02-04 04:08:51.060317+00
476	Donor 476	donor476@example.com	094761234567	2025-02-04 04:08:51.060317+00
477	Donor 477	donor477@example.com	094771234567	2025-02-04 04:08:51.060317+00
478	Donor 478	donor478@example.com	094781234567	2025-02-04 04:08:51.060317+00
479	Donor 479	donor479@example.com	094791234567	2025-02-04 04:08:51.060317+00
480	Donor 480	donor480@example.com	094801234567	2025-02-04 04:08:51.060317+00
481	Donor 481	donor481@example.com	094811234567	2025-02-04 04:08:51.060317+00
482	Donor 482	donor482@example.com	094821234567	2025-02-04 04:08:51.060317+00
483	Donor 483	donor483@example.com	094831234567	2025-02-04 04:08:51.060317+00
484	Donor 484	donor484@example.com	094841234567	2025-02-04 04:08:51.060317+00
485	Donor 485	donor485@example.com	094851234567	2025-02-04 04:08:51.060317+00
486	Donor 486	donor486@example.com	094861234567	2025-02-04 04:08:51.060317+00
487	Donor 487	donor487@example.com	094871234567	2025-02-04 04:08:51.060317+00
488	Donor 488	donor488@example.com	094881234567	2025-02-04 04:08:51.060317+00
489	Donor 489	donor489@example.com	094891234567	2025-02-04 04:08:51.060317+00
490	Donor 490	donor490@example.com	094901234567	2025-02-04 04:08:51.060317+00
491	Donor 491	donor491@example.com	094911234567	2025-02-04 04:08:51.060317+00
492	Donor 492	donor492@example.com	094921234567	2025-02-04 04:08:51.060317+00
493	Donor 493	donor493@example.com	094931234567	2025-02-04 04:08:51.060317+00
494	Donor 494	donor494@example.com	094941234567	2025-02-04 04:08:51.060317+00
495	Donor 495	donor495@example.com	094951234567	2025-02-04 04:08:51.060317+00
496	Donor 496	donor496@example.com	094961234567	2025-02-04 04:08:51.060317+00
497	Donor 497	donor497@example.com	094971234567	2025-02-04 04:08:51.060317+00
498	Donor 498	donor498@example.com	094981234567	2025-02-04 04:08:51.060317+00
499	Donor 499	donor499@example.com	094991234567	2025-02-04 04:08:51.060317+00
500	Donor 500	donor500@example.com	095001234567	2025-02-04 04:08:51.060317+00
501	Donor 501	donor501@example.com	095011234567	2025-02-04 04:08:51.060317+00
502	Donor 502	donor502@example.com	095021234567	2025-02-04 04:08:51.060317+00
503	Donor 503	donor503@example.com	095031234567	2025-02-04 04:08:51.060317+00
504	Donor 504	donor504@example.com	095041234567	2025-02-04 04:08:51.060317+00
505	Donor 505	donor505@example.com	095051234567	2025-02-04 04:08:51.060317+00
506	Donor 506	donor506@example.com	095061234567	2025-02-04 04:08:51.060317+00
507	Donor 507	donor507@example.com	095071234567	2025-02-04 04:08:51.060317+00
508	Donor 508	donor508@example.com	095081234567	2025-02-04 04:08:51.060317+00
509	Donor 509	donor509@example.com	095091234567	2025-02-04 04:08:51.060317+00
510	Donor 510	donor510@example.com	095101234567	2025-02-04 04:08:51.060317+00
511	Donor 511	donor511@example.com	095111234567	2025-02-04 04:08:51.060317+00
512	Donor 512	donor512@example.com	095121234567	2025-02-04 04:08:51.060317+00
513	Donor 513	donor513@example.com	095131234567	2025-02-04 04:08:51.060317+00
514	Donor 514	donor514@example.com	095141234567	2025-02-04 04:08:51.060317+00
515	Donor 515	donor515@example.com	095151234567	2025-02-04 04:08:51.060317+00
516	Donor 516	donor516@example.com	095161234567	2025-02-04 04:08:51.060317+00
517	Donor 517	donor517@example.com	095171234567	2025-02-04 04:08:51.060317+00
518	Donor 518	donor518@example.com	095181234567	2025-02-04 04:08:51.060317+00
519	Donor 519	donor519@example.com	095191234567	2025-02-04 04:08:51.060317+00
520	Donor 520	donor520@example.com	095201234567	2025-02-04 04:08:51.060317+00
521	Donor 521	donor521@example.com	095211234567	2025-02-04 04:08:51.060317+00
522	Donor 522	donor522@example.com	095221234567	2025-02-04 04:08:51.060317+00
523	Donor 523	donor523@example.com	095231234567	2025-02-04 04:08:51.060317+00
524	Donor 524	donor524@example.com	095241234567	2025-02-04 04:08:51.060317+00
525	Donor 525	donor525@example.com	095251234567	2025-02-04 04:08:51.060317+00
526	Donor 526	donor526@example.com	095261234567	2025-02-04 04:08:51.060317+00
527	Donor 527	donor527@example.com	095271234567	2025-02-04 04:08:51.060317+00
528	Donor 528	donor528@example.com	095281234567	2025-02-04 04:08:51.060317+00
529	Donor 529	donor529@example.com	095291234567	2025-02-04 04:08:51.060317+00
530	Donor 530	donor530@example.com	095301234567	2025-02-04 04:08:51.060317+00
531	Donor 531	donor531@example.com	095311234567	2025-02-04 04:08:51.060317+00
532	Donor 532	donor532@example.com	095321234567	2025-02-04 04:08:51.060317+00
533	Donor 533	donor533@example.com	095331234567	2025-02-04 04:08:51.060317+00
534	Donor 534	donor534@example.com	095341234567	2025-02-04 04:08:51.060317+00
535	Donor 535	donor535@example.com	095351234567	2025-02-04 04:08:51.060317+00
536	Donor 536	donor536@example.com	095361234567	2025-02-04 04:08:51.060317+00
537	Donor 537	donor537@example.com	095371234567	2025-02-04 04:08:51.060317+00
538	Donor 538	donor538@example.com	095381234567	2025-02-04 04:08:51.060317+00
539	Donor 539	donor539@example.com	095391234567	2025-02-04 04:08:51.060317+00
540	Donor 540	donor540@example.com	095401234567	2025-02-04 04:08:51.060317+00
541	Donor 541	donor541@example.com	095411234567	2025-02-04 04:08:51.060317+00
542	Donor 542	donor542@example.com	095421234567	2025-02-04 04:08:51.060317+00
543	Donor 543	donor543@example.com	095431234567	2025-02-04 04:08:51.060317+00
544	Donor 544	donor544@example.com	095441234567	2025-02-04 04:08:51.060317+00
545	Donor 545	donor545@example.com	095451234567	2025-02-04 04:08:51.060317+00
546	Donor 546	donor546@example.com	095461234567	2025-02-04 04:08:51.060317+00
547	Donor 547	donor547@example.com	095471234567	2025-02-04 04:08:51.060317+00
548	Donor 548	donor548@example.com	095481234567	2025-02-04 04:08:51.060317+00
549	Donor 549	donor549@example.com	095491234567	2025-02-04 04:08:51.060317+00
550	Donor 550	donor550@example.com	095501234567	2025-02-04 04:08:51.060317+00
551	Donor 551	donor551@example.com	095511234567	2025-02-04 04:08:51.060317+00
552	Donor 552	donor552@example.com	095521234567	2025-02-04 04:08:51.060317+00
553	Donor 553	donor553@example.com	095531234567	2025-02-04 04:08:51.060317+00
554	Donor 554	donor554@example.com	095541234567	2025-02-04 04:08:51.060317+00
555	Donor 555	donor555@example.com	095551234567	2025-02-04 04:08:51.060317+00
556	Donor 556	donor556@example.com	095561234567	2025-02-04 04:08:51.060317+00
557	Donor 557	donor557@example.com	095571234567	2025-02-04 04:08:51.060317+00
558	Donor 558	donor558@example.com	095581234567	2025-02-04 04:08:51.060317+00
559	Donor 559	donor559@example.com	095591234567	2025-02-04 04:08:51.060317+00
560	Donor 560	donor560@example.com	095601234567	2025-02-04 04:08:51.060317+00
561	Donor 561	donor561@example.com	095611234567	2025-02-04 04:08:51.060317+00
562	Donor 562	donor562@example.com	095621234567	2025-02-04 04:08:51.060317+00
563	Donor 563	donor563@example.com	095631234567	2025-02-04 04:08:51.060317+00
564	Donor 564	donor564@example.com	095641234567	2025-02-04 04:08:51.060317+00
565	Donor 565	donor565@example.com	095651234567	2025-02-04 04:08:51.060317+00
566	Donor 566	donor566@example.com	095661234567	2025-02-04 04:08:51.060317+00
567	Donor 567	donor567@example.com	095671234567	2025-02-04 04:08:51.060317+00
568	Donor 568	donor568@example.com	095681234567	2025-02-04 04:08:51.060317+00
569	Donor 569	donor569@example.com	095691234567	2025-02-04 04:08:51.060317+00
570	Donor 570	donor570@example.com	095701234567	2025-02-04 04:08:51.060317+00
571	Donor 571	donor571@example.com	095711234567	2025-02-04 04:08:51.060317+00
572	Donor 572	donor572@example.com	095721234567	2025-02-04 04:08:51.060317+00
573	Donor 573	donor573@example.com	095731234567	2025-02-04 04:08:51.060317+00
574	Donor 574	donor574@example.com	095741234567	2025-02-04 04:08:51.060317+00
575	Donor 575	donor575@example.com	095751234567	2025-02-04 04:08:51.060317+00
576	Donor 576	donor576@example.com	095761234567	2025-02-04 04:08:51.060317+00
577	Donor 577	donor577@example.com	095771234567	2025-02-04 04:08:51.060317+00
578	Donor 578	donor578@example.com	095781234567	2025-02-04 04:08:51.060317+00
579	Donor 579	donor579@example.com	095791234567	2025-02-04 04:08:51.060317+00
580	Donor 580	donor580@example.com	095801234567	2025-02-04 04:08:51.060317+00
581	Donor 581	donor581@example.com	095811234567	2025-02-04 04:08:51.060317+00
582	Donor 582	donor582@example.com	095821234567	2025-02-04 04:08:51.060317+00
583	Donor 583	donor583@example.com	095831234567	2025-02-04 04:08:51.060317+00
584	Donor 584	donor584@example.com	095841234567	2025-02-04 04:08:51.060317+00
585	Donor 585	donor585@example.com	095851234567	2025-02-04 04:08:51.060317+00
586	Donor 586	donor586@example.com	095861234567	2025-02-04 04:08:51.060317+00
587	Donor 587	donor587@example.com	095871234567	2025-02-04 04:08:51.060317+00
588	Donor 588	donor588@example.com	095881234567	2025-02-04 04:08:51.060317+00
589	Donor 589	donor589@example.com	095891234567	2025-02-04 04:08:51.060317+00
590	Donor 590	donor590@example.com	095901234567	2025-02-04 04:08:51.060317+00
591	Donor 591	donor591@example.com	095911234567	2025-02-04 04:08:51.060317+00
592	Donor 592	donor592@example.com	095921234567	2025-02-04 04:08:51.060317+00
593	Donor 593	donor593@example.com	095931234567	2025-02-04 04:08:51.060317+00
594	Donor 594	donor594@example.com	095941234567	2025-02-04 04:08:51.060317+00
595	Donor 595	donor595@example.com	095951234567	2025-02-04 04:08:51.060317+00
596	Donor 596	donor596@example.com	095961234567	2025-02-04 04:08:51.060317+00
597	Donor 597	donor597@example.com	095971234567	2025-02-04 04:08:51.060317+00
598	Donor 598	donor598@example.com	095981234567	2025-02-04 04:08:51.060317+00
599	Donor 599	donor599@example.com	095991234567	2025-02-04 04:08:51.060317+00
600	Donor 600	donor600@example.com	096001234567	2025-02-04 04:08:51.060317+00
601	Donor 20101	\N	\N	2025-02-08 12:47:01.038684+00
603	Robert Guevarra	\N	\N	2025-02-08 12:57:51.667747+00
604	Reb Guevarra	\N	\N	2025-02-08 13:23:45.906356+00
612	Jexter	\N	\N	2025-02-12 16:10:48.046461+00
605	Yosh Guevarra	yoshl@gmail.com	9999 9999	2025-02-08 13:44:37.48128+00
602	Rob Guevarra	robneil@gmail.com		2025-02-08 12:54:16.276223+00
606	Robish	\N	\N	2025-02-12 15:34:28.353508+00
607	Yoshizaurus Guevarra	\N	\N	2025-02-12 15:46:58.538949+00
608	Yoshizaurus	\N	\N	2025-02-12 15:47:05.434824+00
609	Joji	\N	\N	2025-02-12 15:56:52.945968+00
610	Jexter Dorris	\N	\N	2025-02-12 16:08:47.681208+00
613	joxko	\N	\N	2025-02-12 16:14:15.606943+00
614	jeexxx	\N	\N	2025-02-12 16:20:01.791795+00
615	ffaaff	\N	\N	2025-02-12 16:34:15.569797+00
648	Robex	\N	\N	2025-02-17 09:12:07.223001+00
649	Paul Guevarra	\N	\N	2025-02-17 09:14:03.374961+00
650	Rexar Beastmaster	\N	\N	2025-02-20 07:13:49.77077+00
651	Rexar Rylai	rylai@gmail.com	919911911	2025-02-20 07:20:46.686112+00
652	Jesus Loves me	\N	\N	2025-02-20 08:13:06.487698+00
\.


--
-- Data for Name: local_churches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.local_churches (id, name, district_id, lead_pastor_id) FROM stdin;
4	Victory Baliuag	\N	a3a1e735-b662-49ab-8ccc-a23686553bc3
5	Victory San Rafael	\N	326aada0-3dcc-4566-84cc-2541c0e134e2
6	Victory San Miguel	\N	6f9579a9-4f08-4ab5-8fd2-b7c3d2ee87e2
7	Victory Meycauayan	\N	910ef066-fdcb-4f99-aac4-458aaacc7a5b
8	Victory Marilao	\N	910ef066-fdcb-4f99-aac4-458aaacc7a5b
9	Victory Plaridel	\N	a3a1e735-b662-49ab-8ccc-a23686553bc3
11	Victory Sta Maria	\N	ec874457-5ac3-48c2-90dd-9ea0b8166635
2	Victory Angat	\N	ec874457-5ac3-48c2-90dd-9ea0b8166635
3	Victory Balagtas	\N	48d301bd-fea6-4d85-92c0-bf066aa23ae8
10	Victory Pulilan	\N	6d5b86c5-2939-4003-bb6f-6b177a60038e
1	Victory Malolos	\N	6d5b86c5-2939-4003-bb6f-6b177a60038e
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, full_name, role, local_church_id, campus_director_id, monthly_goal, surplus_balance, created_at, updated_at) FROM stdin;
dd35da46-4416-412a-8a22-f3f39491bb7b	Dan Joash Bagadiong	missionary	11	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	32690.30	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
a83848ba-0779-4fac-98ee-f5f459b2742b	Cielo Marie Angeles	missionary	1	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	41515.26	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
51072377-1472-46cb-b180-8542677f5eb2	Sarah Grace De Peralta	missionary	11	b1f5db31-bfc8-409c-8925-0d21f1c780e6	34257.17	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
9255fabc-799b-4cc7-8797-5f2470f6adf6	Dahlia Delos Reyes	missionary	2	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	31634.27	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
6833f990-6a38-4f28-aa18-e31697fa7dc9	Caroll Jane Perez	missionary	4	b1f5db31-bfc8-409c-8925-0d21f1c780e6	32779.50	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
6ac1e176-e710-4b5e-9453-95765db20ba3	Ma. Jirah Joy Rivera	missionary	3	b1f5db31-bfc8-409c-8925-0d21f1c780e6	38026.95	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
8088628d-f77a-430d-b228-cc3649b8a3e1	Mary Florenz Krizza Anzures	missionary	9	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	36932.63	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
da6ac18e-72e9-484a-ad75-d044260789cc	A-J De Guzman	missionary	4	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	33013.02	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
a602c1a3-89cf-44a4-b419-f6827ad3701b	Ariane Lingat	missionary	11	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	37285.81	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	Genriel Santiago	missionary	10	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	33638.40	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
fd99f59b-fcc6-42ef-a407-207f110f2d7b	Desimae Vhiel Susi	missionary	9	b794e95a-97f4-4c05-aa2d-3c13c4155841	41217.59	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
dde964d6-6ffa-4b25-97b6-128969afe47c	Princess Blessie Ventic	missionary	1	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	30513.70	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
dbbbe49c-e100-4576-b406-320908c8873e	Emily Dionisio	missionary	2	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	32541.89	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
5432f125-2d5e-42ab-849a-29add2cf0a74	Ma. Bernadette Sheyne Mariano	missionary	1	b1f5db31-bfc8-409c-8925-0d21f1c780e6	20053.73	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
fc7c7272-6d55-49a3-88d7-fc37133a103f	Ben-joe Ryell Prada	missionary	5	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	27599.72	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
e4bfe294-e6e5-4626-9f2a-969f2aa938c3	Rose Ann Solo	missionary	4	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	40784.93	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
cff64755-2065-4e58-866f-f092cbd9e73b	Jemica Dela Cruz	missionary	4	b1f5db31-bfc8-409c-8925-0d21f1c780e6	34518.47	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
ee522e07-1315-4463-8a9b-f890b601c047	Laira Santos	missionary	10	b1f5db31-bfc8-409c-8925-0d21f1c780e6	48012.41	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
77e168c1-05e0-4314-8a24-5e838350a3d8	Christine Joy Velasco	missionary	3	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	32856.58	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	Roberto Del Rosario Jr.	missionary	5	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	24994.00	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
387d98f7-ccf9-4077-8f79-f0be51c40d05	Michael Macale	missionary	1	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	41118.15	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
ad0b7e41-18fc-4945-8aa9-6793788b0e7c	Wendy Cainong	missionary	4	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	43691.74	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
1934abf8-eca9-41d8-bc5f-9c649285b76b	Diana Camaso	missionary	3	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	38860.96	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
5bf27593-0c3d-489f-bed4-c80dc2936fdf	Christian Reyes	missionary	7	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	23667.53	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
584a1909-5797-4297-88d3-06bf5dc3922a	Mary Anne Ma├▒osa	missionary	1	b794e95a-97f4-4c05-aa2d-3c13c4155841	34087.12	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	Campus Director	campus_director	10	\N	\N	0.00	2025-02-19 13:56:36.956417+00	2025-02-19 13:56:36.956417+00
aefe15fe-4937-4f55-a6cb-fb8d739c5905	Missionary	missionary	10	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	222222.00	0.00	2025-02-19 13:56:14.848085+00	2025-02-19 13:56:14.848085+00
463737cc-950b-4a41-8d73-a3daf931fee5	Emmanuel Victoria	missionary	1	b1f5db31-bfc8-409c-8925-0d21f1c780e6	44529.34	12121212.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
aebdeee3-427f-4d5b-832d-8c4ebaecdddc	Rob Guevarra	superadmin	10	\N	999999.00	999999.00	2025-02-04 04:10:52.406153+00	2025-02-04 04:10:52.406153+00
b1f5db31-bfc8-409c-8925-0d21f1c780e6	Paul Ryan Pasia	campus_director	6	\N	30000.00	1212121.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
b794e95a-97f4-4c05-aa2d-3c13c4155841	Mar Loyd Quinto	campus_director	7	\N	44000.00	121212.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	John Ian Susi	campus_director	5	\N	55000.00	12121.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
bd38508e-8797-4220-ae2e-dd7883b41f17	Ronald Carlo Bechayda	missionary	1	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	32445.68	12211.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	Jhomar Carlo Salazar	campus_director	10	\N	66000.00	1222111.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
ab8dc40a-9c9b-4391-823b-8578ab506e5e	Erick Fernandez	lead_pastor	1	\N	0.00	0.00	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00
ec874457-5ac3-48c2-90dd-9ea0b8166635	Red Pondang	lead_pastor	2	\N	0.00	0.00	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00
48d301bd-fea6-4d85-92c0-bf066aa23ae8	King Borlongan	lead_pastor	3	\N	0.00	0.00	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00
a3a1e735-b662-49ab-8ccc-a23686553bc3	Loyd Janobas	lead_pastor	4	\N	0.00	0.00	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00
326aada0-3dcc-4566-84cc-2541c0e134e2	Moss Manalaysay	lead_pastor	5	\N	0.00	0.00	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00
6f9579a9-4f08-4ab5-8fd2-b7c3d2ee87e2	Anthony Licud	lead_pastor	6	\N	0.00	0.00	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00
910ef066-fdcb-4f99-aac4-458aaacc7a5b	Rouie Gutierrez	lead_pastor	7	\N	0.00	0.00	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00
712b5dd0-cd8d-4293-8e66-640624002f2b	Robert Guevarra	lead_pastor	10	\N	0.00	0.00	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00
f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	FinanceGuy	finance_officer	10	\N	\N	0.00	2025-02-19 13:29:47.991804+00	2025-02-19 13:29:47.991804+00
6d5b86c5-2939-4003-bb6f-6b177a60038e	PastorGuy	lead_pastor	10	\N	\N	0.00	2025-02-19 13:30:03.50151+00	2025-02-19 13:30:03.50151+00
\.


--
-- Data for Name: donor_donations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.donor_donations (id, donor_id, missionary_id, amount, date, source, status, notes, recorded_by) FROM stdin;
1	1	1934abf8-eca9-41d8-bc5f-9c649285b76b	2745.98	2023-01-01 00:00:00+00	online	completed	\N	\N
2	1	1934abf8-eca9-41d8-bc5f-9c649285b76b	3498.31	2023-02-01 00:00:00+00	online	completed	\N	\N
3	1	1934abf8-eca9-41d8-bc5f-9c649285b76b	3900.31	2023-03-01 00:00:00+00	online	completed	\N	\N
4	2	fd99f59b-fcc6-42ef-a407-207f110f2d7b	1345.83	2023-01-01 00:00:00+00	online	completed	\N	\N
5	2	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4622.55	2023-02-01 00:00:00+00	online	completed	\N	\N
6	2	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4358.52	2023-03-01 00:00:00+00	online	completed	\N	\N
7	3	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2298.18	2023-01-01 00:00:00+00	online	completed	\N	\N
8	3	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4308.26	2023-02-01 00:00:00+00	online	completed	\N	\N
9	3	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4809.44	2023-03-01 00:00:00+00	online	completed	\N	\N
10	4	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1763.71	2023-01-01 00:00:00+00	online	completed	\N	\N
11	4	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2349.47	2023-02-01 00:00:00+00	online	completed	\N	\N
12	4	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3088.56	2023-03-01 00:00:00+00	online	completed	\N	\N
13	5	a83848ba-0779-4fac-98ee-f5f459b2742b	2867.62	2023-01-01 00:00:00+00	online	completed	\N	\N
14	5	a83848ba-0779-4fac-98ee-f5f459b2742b	3166.93	2023-02-01 00:00:00+00	online	completed	\N	\N
15	5	a83848ba-0779-4fac-98ee-f5f459b2742b	5886.78	2023-03-01 00:00:00+00	online	completed	\N	\N
16	6	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5000.87	2023-01-01 00:00:00+00	online	completed	\N	\N
17	6	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5814.49	2023-02-01 00:00:00+00	online	completed	\N	\N
18	6	b1f5db31-bfc8-409c-8925-0d21f1c780e6	4042.92	2023-03-01 00:00:00+00	online	completed	\N	\N
19	7	5432f125-2d5e-42ab-849a-29add2cf0a74	1236.21	2023-01-01 00:00:00+00	online	completed	\N	\N
20	7	5432f125-2d5e-42ab-849a-29add2cf0a74	1563.23	2023-02-01 00:00:00+00	online	completed	\N	\N
21	7	5432f125-2d5e-42ab-849a-29add2cf0a74	3765.52	2023-03-01 00:00:00+00	online	completed	\N	\N
22	8	463737cc-950b-4a41-8d73-a3daf931fee5	3924.57	2023-01-01 00:00:00+00	online	completed	\N	\N
23	8	463737cc-950b-4a41-8d73-a3daf931fee5	2270.78	2023-02-01 00:00:00+00	online	completed	\N	\N
24	8	463737cc-950b-4a41-8d73-a3daf931fee5	2890.73	2023-03-01 00:00:00+00	online	completed	\N	\N
25	9	6833f990-6a38-4f28-aa18-e31697fa7dc9	3357.86	2023-01-01 00:00:00+00	online	completed	\N	\N
26	9	6833f990-6a38-4f28-aa18-e31697fa7dc9	3014.16	2023-02-01 00:00:00+00	online	completed	\N	\N
27	9	6833f990-6a38-4f28-aa18-e31697fa7dc9	4829.87	2023-03-01 00:00:00+00	online	completed	\N	\N
28	10	b794e95a-97f4-4c05-aa2d-3c13c4155841	5573.82	2023-01-01 00:00:00+00	online	completed	\N	\N
29	10	b794e95a-97f4-4c05-aa2d-3c13c4155841	5833.32	2023-02-01 00:00:00+00	online	completed	\N	\N
30	10	b794e95a-97f4-4c05-aa2d-3c13c4155841	5356.31	2023-03-01 00:00:00+00	online	completed	\N	\N
31	11	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2651.81	2023-01-01 00:00:00+00	online	completed	\N	\N
32	11	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1465.20	2023-02-01 00:00:00+00	online	completed	\N	\N
33	11	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	4527.96	2023-03-01 00:00:00+00	online	completed	\N	\N
34	12	b794e95a-97f4-4c05-aa2d-3c13c4155841	2944.31	2023-01-01 00:00:00+00	online	completed	\N	\N
35	12	b794e95a-97f4-4c05-aa2d-3c13c4155841	3457.56	2023-02-01 00:00:00+00	online	completed	\N	\N
36	12	b794e95a-97f4-4c05-aa2d-3c13c4155841	1526.39	2023-03-01 00:00:00+00	online	completed	\N	\N
37	13	51072377-1472-46cb-b180-8542677f5eb2	5828.76	2023-01-01 00:00:00+00	online	completed	\N	\N
38	13	51072377-1472-46cb-b180-8542677f5eb2	4714.00	2023-02-01 00:00:00+00	online	completed	\N	\N
39	13	51072377-1472-46cb-b180-8542677f5eb2	1161.93	2023-03-01 00:00:00+00	online	completed	\N	\N
40	14	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2397.78	2023-01-01 00:00:00+00	online	completed	\N	\N
41	14	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5906.44	2023-02-01 00:00:00+00	online	completed	\N	\N
42	14	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2925.86	2023-03-01 00:00:00+00	online	completed	\N	\N
43	15	1934abf8-eca9-41d8-bc5f-9c649285b76b	3956.16	2023-01-01 00:00:00+00	online	completed	\N	\N
44	15	1934abf8-eca9-41d8-bc5f-9c649285b76b	1821.61	2023-02-01 00:00:00+00	online	completed	\N	\N
45	15	1934abf8-eca9-41d8-bc5f-9c649285b76b	5853.27	2023-03-01 00:00:00+00	online	completed	\N	\N
46	16	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5731.68	2023-01-01 00:00:00+00	online	completed	\N	\N
47	16	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5616.58	2023-02-01 00:00:00+00	online	completed	\N	\N
48	16	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3746.50	2023-03-01 00:00:00+00	online	completed	\N	\N
49	17	51072377-1472-46cb-b180-8542677f5eb2	2409.20	2023-01-01 00:00:00+00	online	completed	\N	\N
50	17	51072377-1472-46cb-b180-8542677f5eb2	4332.57	2023-02-01 00:00:00+00	online	completed	\N	\N
51	17	51072377-1472-46cb-b180-8542677f5eb2	4653.16	2023-03-01 00:00:00+00	online	completed	\N	\N
52	18	387d98f7-ccf9-4077-8f79-f0be51c40d05	4196.57	2023-01-01 00:00:00+00	online	completed	\N	\N
53	18	387d98f7-ccf9-4077-8f79-f0be51c40d05	2477.88	2023-02-01 00:00:00+00	online	completed	\N	\N
54	18	387d98f7-ccf9-4077-8f79-f0be51c40d05	2734.42	2023-03-01 00:00:00+00	online	completed	\N	\N
55	19	a83848ba-0779-4fac-98ee-f5f459b2742b	1971.81	2023-01-01 00:00:00+00	online	completed	\N	\N
56	19	a83848ba-0779-4fac-98ee-f5f459b2742b	1135.93	2023-02-01 00:00:00+00	online	completed	\N	\N
57	19	a83848ba-0779-4fac-98ee-f5f459b2742b	3788.49	2023-03-01 00:00:00+00	online	completed	\N	\N
58	20	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2260.15	2023-01-01 00:00:00+00	online	completed	\N	\N
59	20	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2664.50	2023-02-01 00:00:00+00	online	completed	\N	\N
60	20	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1527.12	2023-03-01 00:00:00+00	online	completed	\N	\N
61	21	77e168c1-05e0-4314-8a24-5e838350a3d8	4403.08	2023-01-01 00:00:00+00	online	completed	\N	\N
62	21	77e168c1-05e0-4314-8a24-5e838350a3d8	2305.33	2023-02-01 00:00:00+00	online	completed	\N	\N
63	21	77e168c1-05e0-4314-8a24-5e838350a3d8	1047.38	2023-03-01 00:00:00+00	online	completed	\N	\N
64	22	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1333.19	2023-01-01 00:00:00+00	online	completed	\N	\N
65	22	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2475.11	2023-02-01 00:00:00+00	online	completed	\N	\N
66	22	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2547.01	2023-03-01 00:00:00+00	online	completed	\N	\N
67	23	dbbbe49c-e100-4576-b406-320908c8873e	4560.68	2023-01-01 00:00:00+00	online	completed	\N	\N
68	23	dbbbe49c-e100-4576-b406-320908c8873e	3915.46	2023-02-01 00:00:00+00	online	completed	\N	\N
69	23	dbbbe49c-e100-4576-b406-320908c8873e	3451.48	2023-03-01 00:00:00+00	online	completed	\N	\N
70	24	ee522e07-1315-4463-8a9b-f890b601c047	5918.97	2023-01-01 00:00:00+00	online	completed	\N	\N
71	24	ee522e07-1315-4463-8a9b-f890b601c047	1293.59	2023-02-01 00:00:00+00	online	completed	\N	\N
72	24	ee522e07-1315-4463-8a9b-f890b601c047	5949.87	2023-03-01 00:00:00+00	online	completed	\N	\N
73	25	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2646.47	2023-01-01 00:00:00+00	online	completed	\N	\N
74	25	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5461.17	2023-02-01 00:00:00+00	online	completed	\N	\N
75	25	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4735.61	2023-03-01 00:00:00+00	online	completed	\N	\N
76	26	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1241.68	2023-01-01 00:00:00+00	online	completed	\N	\N
77	26	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1924.54	2023-02-01 00:00:00+00	online	completed	\N	\N
78	26	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5428.92	2023-03-01 00:00:00+00	online	completed	\N	\N
79	27	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1242.36	2023-01-01 00:00:00+00	online	completed	\N	\N
80	27	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1324.11	2023-02-01 00:00:00+00	online	completed	\N	\N
81	27	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4028.91	2023-03-01 00:00:00+00	online	completed	\N	\N
82	28	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4381.00	2023-01-01 00:00:00+00	online	completed	\N	\N
83	28	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	5692.30	2023-02-01 00:00:00+00	online	completed	\N	\N
84	28	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3677.49	2023-03-01 00:00:00+00	online	completed	\N	\N
85	29	fc7c7272-6d55-49a3-88d7-fc37133a103f	4722.42	2023-01-01 00:00:00+00	online	completed	\N	\N
86	29	fc7c7272-6d55-49a3-88d7-fc37133a103f	5529.95	2023-02-01 00:00:00+00	online	completed	\N	\N
87	29	fc7c7272-6d55-49a3-88d7-fc37133a103f	4193.56	2023-03-01 00:00:00+00	online	completed	\N	\N
88	30	bd38508e-8797-4220-ae2e-dd7883b41f17	3526.31	2023-01-01 00:00:00+00	online	completed	\N	\N
89	30	bd38508e-8797-4220-ae2e-dd7883b41f17	4305.45	2023-02-01 00:00:00+00	online	completed	\N	\N
90	30	bd38508e-8797-4220-ae2e-dd7883b41f17	1918.22	2023-03-01 00:00:00+00	online	completed	\N	\N
91	31	ee522e07-1315-4463-8a9b-f890b601c047	2197.05	2023-01-01 00:00:00+00	online	completed	\N	\N
92	31	ee522e07-1315-4463-8a9b-f890b601c047	2264.19	2023-02-01 00:00:00+00	online	completed	\N	\N
93	31	ee522e07-1315-4463-8a9b-f890b601c047	4904.59	2023-03-01 00:00:00+00	online	completed	\N	\N
94	32	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3765.12	2023-01-01 00:00:00+00	online	completed	\N	\N
95	32	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2949.25	2023-02-01 00:00:00+00	online	completed	\N	\N
96	32	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3112.56	2023-03-01 00:00:00+00	online	completed	\N	\N
97	33	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2553.59	2023-01-01 00:00:00+00	online	completed	\N	\N
98	33	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4195.09	2023-02-01 00:00:00+00	online	completed	\N	\N
99	33	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2816.57	2023-03-01 00:00:00+00	online	completed	\N	\N
100	34	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1249.16	2023-01-01 00:00:00+00	online	completed	\N	\N
101	34	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5377.90	2023-02-01 00:00:00+00	online	completed	\N	\N
102	34	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2240.03	2023-03-01 00:00:00+00	online	completed	\N	\N
103	35	b794e95a-97f4-4c05-aa2d-3c13c4155841	4185.86	2023-01-01 00:00:00+00	online	completed	\N	\N
104	35	b794e95a-97f4-4c05-aa2d-3c13c4155841	3818.78	2023-02-01 00:00:00+00	online	completed	\N	\N
105	35	b794e95a-97f4-4c05-aa2d-3c13c4155841	4981.75	2023-03-01 00:00:00+00	online	completed	\N	\N
106	36	ee522e07-1315-4463-8a9b-f890b601c047	3320.89	2023-01-01 00:00:00+00	online	completed	\N	\N
107	36	ee522e07-1315-4463-8a9b-f890b601c047	5988.04	2023-02-01 00:00:00+00	online	completed	\N	\N
108	36	ee522e07-1315-4463-8a9b-f890b601c047	3008.11	2023-03-01 00:00:00+00	online	completed	\N	\N
109	37	8088628d-f77a-430d-b228-cc3649b8a3e1	1062.91	2023-01-01 00:00:00+00	online	completed	\N	\N
110	37	8088628d-f77a-430d-b228-cc3649b8a3e1	4542.94	2023-02-01 00:00:00+00	online	completed	\N	\N
111	37	8088628d-f77a-430d-b228-cc3649b8a3e1	2453.10	2023-03-01 00:00:00+00	online	completed	\N	\N
112	38	463737cc-950b-4a41-8d73-a3daf931fee5	1632.26	2023-01-01 00:00:00+00	online	completed	\N	\N
113	38	463737cc-950b-4a41-8d73-a3daf931fee5	5264.66	2023-02-01 00:00:00+00	online	completed	\N	\N
114	38	463737cc-950b-4a41-8d73-a3daf931fee5	4839.83	2023-03-01 00:00:00+00	online	completed	\N	\N
115	39	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3979.17	2023-01-01 00:00:00+00	online	completed	\N	\N
116	39	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4589.62	2023-02-01 00:00:00+00	online	completed	\N	\N
117	39	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3377.08	2023-03-01 00:00:00+00	online	completed	\N	\N
118	40	cff64755-2065-4e58-866f-f092cbd9e73b	4372.70	2023-01-01 00:00:00+00	online	completed	\N	\N
119	40	cff64755-2065-4e58-866f-f092cbd9e73b	1235.11	2023-02-01 00:00:00+00	online	completed	\N	\N
120	40	cff64755-2065-4e58-866f-f092cbd9e73b	5722.05	2023-03-01 00:00:00+00	online	completed	\N	\N
121	41	dbbbe49c-e100-4576-b406-320908c8873e	5862.31	2023-01-01 00:00:00+00	online	completed	\N	\N
122	41	dbbbe49c-e100-4576-b406-320908c8873e	3715.41	2023-02-01 00:00:00+00	online	completed	\N	\N
123	41	dbbbe49c-e100-4576-b406-320908c8873e	2867.55	2023-03-01 00:00:00+00	online	completed	\N	\N
124	42	ee522e07-1315-4463-8a9b-f890b601c047	3230.31	2023-01-01 00:00:00+00	online	completed	\N	\N
125	42	ee522e07-1315-4463-8a9b-f890b601c047	3804.92	2023-02-01 00:00:00+00	online	completed	\N	\N
126	42	ee522e07-1315-4463-8a9b-f890b601c047	3584.23	2023-03-01 00:00:00+00	online	completed	\N	\N
127	43	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3042.87	2023-01-01 00:00:00+00	online	completed	\N	\N
128	43	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5595.28	2023-02-01 00:00:00+00	online	completed	\N	\N
129	43	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5161.63	2023-03-01 00:00:00+00	online	completed	\N	\N
130	44	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3406.62	2023-01-01 00:00:00+00	online	completed	\N	\N
131	44	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2813.21	2023-02-01 00:00:00+00	online	completed	\N	\N
132	44	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4181.33	2023-03-01 00:00:00+00	online	completed	\N	\N
133	45	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2575.51	2023-01-01 00:00:00+00	online	completed	\N	\N
134	45	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2922.81	2023-02-01 00:00:00+00	online	completed	\N	\N
135	45	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2353.51	2023-03-01 00:00:00+00	online	completed	\N	\N
136	46	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3661.49	2023-01-01 00:00:00+00	online	completed	\N	\N
137	46	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2387.02	2023-02-01 00:00:00+00	online	completed	\N	\N
138	46	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3165.24	2023-03-01 00:00:00+00	online	completed	\N	\N
139	47	cff64755-2065-4e58-866f-f092cbd9e73b	5809.21	2023-01-01 00:00:00+00	online	completed	\N	\N
140	47	cff64755-2065-4e58-866f-f092cbd9e73b	2305.55	2023-02-01 00:00:00+00	online	completed	\N	\N
141	47	cff64755-2065-4e58-866f-f092cbd9e73b	5483.76	2023-03-01 00:00:00+00	online	completed	\N	\N
142	48	dd35da46-4416-412a-8a22-f3f39491bb7b	5113.03	2023-01-01 00:00:00+00	online	completed	\N	\N
143	48	dd35da46-4416-412a-8a22-f3f39491bb7b	5995.51	2023-02-01 00:00:00+00	online	completed	\N	\N
144	48	dd35da46-4416-412a-8a22-f3f39491bb7b	5000.68	2023-03-01 00:00:00+00	online	completed	\N	\N
145	49	5432f125-2d5e-42ab-849a-29add2cf0a74	3578.93	2023-01-01 00:00:00+00	online	completed	\N	\N
146	49	5432f125-2d5e-42ab-849a-29add2cf0a74	1495.86	2023-02-01 00:00:00+00	online	completed	\N	\N
147	49	5432f125-2d5e-42ab-849a-29add2cf0a74	5275.19	2023-03-01 00:00:00+00	online	completed	\N	\N
148	50	9255fabc-799b-4cc7-8797-5f2470f6adf6	4216.51	2023-01-01 00:00:00+00	online	completed	\N	\N
149	50	9255fabc-799b-4cc7-8797-5f2470f6adf6	3699.28	2023-02-01 00:00:00+00	online	completed	\N	\N
150	50	9255fabc-799b-4cc7-8797-5f2470f6adf6	3280.41	2023-03-01 00:00:00+00	online	completed	\N	\N
151	51	584a1909-5797-4297-88d3-06bf5dc3922a	3952.75	2023-01-01 00:00:00+00	online	completed	\N	\N
152	51	584a1909-5797-4297-88d3-06bf5dc3922a	5360.33	2023-02-01 00:00:00+00	online	completed	\N	\N
153	51	584a1909-5797-4297-88d3-06bf5dc3922a	3597.23	2023-03-01 00:00:00+00	online	completed	\N	\N
154	52	584a1909-5797-4297-88d3-06bf5dc3922a	4609.56	2023-01-01 00:00:00+00	online	completed	\N	\N
155	52	584a1909-5797-4297-88d3-06bf5dc3922a	4009.61	2023-02-01 00:00:00+00	online	completed	\N	\N
156	52	584a1909-5797-4297-88d3-06bf5dc3922a	1450.95	2023-03-01 00:00:00+00	online	completed	\N	\N
157	53	a83848ba-0779-4fac-98ee-f5f459b2742b	2958.21	2023-01-01 00:00:00+00	online	completed	\N	\N
158	53	a83848ba-0779-4fac-98ee-f5f459b2742b	2561.80	2023-02-01 00:00:00+00	online	completed	\N	\N
159	53	a83848ba-0779-4fac-98ee-f5f459b2742b	1157.15	2023-03-01 00:00:00+00	online	completed	\N	\N
160	54	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3561.82	2023-01-01 00:00:00+00	online	completed	\N	\N
161	54	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2451.07	2023-02-01 00:00:00+00	online	completed	\N	\N
162	54	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	1739.18	2023-03-01 00:00:00+00	online	completed	\N	\N
163	55	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2240.40	2023-01-01 00:00:00+00	online	completed	\N	\N
164	55	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4672.24	2023-02-01 00:00:00+00	online	completed	\N	\N
165	55	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5655.04	2023-03-01 00:00:00+00	online	completed	\N	\N
166	56	da6ac18e-72e9-484a-ad75-d044260789cc	2204.60	2023-01-01 00:00:00+00	online	completed	\N	\N
167	56	da6ac18e-72e9-484a-ad75-d044260789cc	5005.40	2023-02-01 00:00:00+00	online	completed	\N	\N
168	56	da6ac18e-72e9-484a-ad75-d044260789cc	1282.20	2023-03-01 00:00:00+00	online	completed	\N	\N
169	57	387d98f7-ccf9-4077-8f79-f0be51c40d05	1540.31	2023-01-01 00:00:00+00	online	completed	\N	\N
170	57	387d98f7-ccf9-4077-8f79-f0be51c40d05	5234.32	2023-02-01 00:00:00+00	online	completed	\N	\N
171	57	387d98f7-ccf9-4077-8f79-f0be51c40d05	3491.07	2023-03-01 00:00:00+00	online	completed	\N	\N
172	58	51072377-1472-46cb-b180-8542677f5eb2	1962.64	2023-01-01 00:00:00+00	online	completed	\N	\N
173	58	51072377-1472-46cb-b180-8542677f5eb2	5810.91	2023-02-01 00:00:00+00	online	completed	\N	\N
174	58	51072377-1472-46cb-b180-8542677f5eb2	2910.72	2023-03-01 00:00:00+00	online	completed	\N	\N
175	59	dde964d6-6ffa-4b25-97b6-128969afe47c	2899.98	2023-01-01 00:00:00+00	online	completed	\N	\N
176	59	dde964d6-6ffa-4b25-97b6-128969afe47c	1138.08	2023-02-01 00:00:00+00	online	completed	\N	\N
177	59	dde964d6-6ffa-4b25-97b6-128969afe47c	1984.26	2023-03-01 00:00:00+00	online	completed	\N	\N
178	60	463737cc-950b-4a41-8d73-a3daf931fee5	4458.13	2023-01-01 00:00:00+00	online	completed	\N	\N
179	60	463737cc-950b-4a41-8d73-a3daf931fee5	4162.13	2023-02-01 00:00:00+00	online	completed	\N	\N
180	60	463737cc-950b-4a41-8d73-a3daf931fee5	5125.50	2023-03-01 00:00:00+00	online	completed	\N	\N
181	61	dde964d6-6ffa-4b25-97b6-128969afe47c	5199.53	2023-01-01 00:00:00+00	online	completed	\N	\N
182	61	dde964d6-6ffa-4b25-97b6-128969afe47c	4916.18	2023-02-01 00:00:00+00	online	completed	\N	\N
183	61	dde964d6-6ffa-4b25-97b6-128969afe47c	5318.23	2023-03-01 00:00:00+00	online	completed	\N	\N
184	62	1934abf8-eca9-41d8-bc5f-9c649285b76b	5496.89	2023-01-01 00:00:00+00	online	completed	\N	\N
185	62	1934abf8-eca9-41d8-bc5f-9c649285b76b	3100.58	2023-02-01 00:00:00+00	online	completed	\N	\N
186	62	1934abf8-eca9-41d8-bc5f-9c649285b76b	4156.54	2023-03-01 00:00:00+00	online	completed	\N	\N
187	63	bd38508e-8797-4220-ae2e-dd7883b41f17	1080.70	2023-01-01 00:00:00+00	online	completed	\N	\N
188	63	bd38508e-8797-4220-ae2e-dd7883b41f17	4900.02	2023-02-01 00:00:00+00	online	completed	\N	\N
189	63	bd38508e-8797-4220-ae2e-dd7883b41f17	3183.23	2023-03-01 00:00:00+00	online	completed	\N	\N
190	64	a602c1a3-89cf-44a4-b419-f6827ad3701b	3937.27	2023-01-01 00:00:00+00	online	completed	\N	\N
191	64	a602c1a3-89cf-44a4-b419-f6827ad3701b	5038.00	2023-02-01 00:00:00+00	online	completed	\N	\N
192	64	a602c1a3-89cf-44a4-b419-f6827ad3701b	1635.22	2023-03-01 00:00:00+00	online	completed	\N	\N
193	65	dbbbe49c-e100-4576-b406-320908c8873e	2005.07	2023-01-01 00:00:00+00	online	completed	\N	\N
194	65	dbbbe49c-e100-4576-b406-320908c8873e	3274.52	2023-02-01 00:00:00+00	online	completed	\N	\N
195	65	dbbbe49c-e100-4576-b406-320908c8873e	3023.27	2023-03-01 00:00:00+00	online	completed	\N	\N
196	66	dbbbe49c-e100-4576-b406-320908c8873e	2538.06	2023-01-01 00:00:00+00	online	completed	\N	\N
197	66	dbbbe49c-e100-4576-b406-320908c8873e	1725.79	2023-02-01 00:00:00+00	online	completed	\N	\N
198	66	dbbbe49c-e100-4576-b406-320908c8873e	3623.19	2023-03-01 00:00:00+00	online	completed	\N	\N
199	67	1934abf8-eca9-41d8-bc5f-9c649285b76b	5983.87	2023-01-01 00:00:00+00	online	completed	\N	\N
200	67	1934abf8-eca9-41d8-bc5f-9c649285b76b	2923.06	2023-02-01 00:00:00+00	online	completed	\N	\N
201	67	1934abf8-eca9-41d8-bc5f-9c649285b76b	1506.17	2023-03-01 00:00:00+00	online	completed	\N	\N
202	68	9255fabc-799b-4cc7-8797-5f2470f6adf6	4422.66	2023-01-01 00:00:00+00	online	completed	\N	\N
203	68	9255fabc-799b-4cc7-8797-5f2470f6adf6	2229.30	2023-02-01 00:00:00+00	online	completed	\N	\N
204	68	9255fabc-799b-4cc7-8797-5f2470f6adf6	1234.42	2023-03-01 00:00:00+00	online	completed	\N	\N
205	69	77e168c1-05e0-4314-8a24-5e838350a3d8	4452.89	2023-01-01 00:00:00+00	online	completed	\N	\N
206	69	77e168c1-05e0-4314-8a24-5e838350a3d8	4257.04	2023-02-01 00:00:00+00	online	completed	\N	\N
207	69	77e168c1-05e0-4314-8a24-5e838350a3d8	3154.28	2023-03-01 00:00:00+00	online	completed	\N	\N
208	70	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5450.88	2023-01-01 00:00:00+00	online	completed	\N	\N
209	70	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2036.66	2023-02-01 00:00:00+00	online	completed	\N	\N
210	70	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5308.15	2023-03-01 00:00:00+00	online	completed	\N	\N
211	71	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2815.02	2023-01-01 00:00:00+00	online	completed	\N	\N
212	71	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3780.57	2023-02-01 00:00:00+00	online	completed	\N	\N
213	71	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3803.50	2023-03-01 00:00:00+00	online	completed	\N	\N
214	72	fd99f59b-fcc6-42ef-a407-207f110f2d7b	1876.81	2023-01-01 00:00:00+00	online	completed	\N	\N
215	72	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4741.77	2023-02-01 00:00:00+00	online	completed	\N	\N
216	72	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4609.28	2023-03-01 00:00:00+00	online	completed	\N	\N
217	73	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3848.87	2023-01-01 00:00:00+00	online	completed	\N	\N
218	73	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3501.38	2023-02-01 00:00:00+00	online	completed	\N	\N
219	73	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3184.30	2023-03-01 00:00:00+00	online	completed	\N	\N
220	74	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5625.10	2023-01-01 00:00:00+00	online	completed	\N	\N
221	74	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5816.58	2023-02-01 00:00:00+00	online	completed	\N	\N
222	74	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	4716.41	2023-03-01 00:00:00+00	online	completed	\N	\N
223	75	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3586.27	2023-01-01 00:00:00+00	online	completed	\N	\N
224	75	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5104.71	2023-02-01 00:00:00+00	online	completed	\N	\N
225	75	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5140.82	2023-03-01 00:00:00+00	online	completed	\N	\N
226	76	dde964d6-6ffa-4b25-97b6-128969afe47c	2189.09	2023-01-01 00:00:00+00	online	completed	\N	\N
227	76	dde964d6-6ffa-4b25-97b6-128969afe47c	2188.64	2023-02-01 00:00:00+00	online	completed	\N	\N
228	76	dde964d6-6ffa-4b25-97b6-128969afe47c	3566.67	2023-03-01 00:00:00+00	online	completed	\N	\N
229	77	bd38508e-8797-4220-ae2e-dd7883b41f17	3457.01	2023-01-01 00:00:00+00	online	completed	\N	\N
230	77	bd38508e-8797-4220-ae2e-dd7883b41f17	5913.47	2023-02-01 00:00:00+00	online	completed	\N	\N
231	77	bd38508e-8797-4220-ae2e-dd7883b41f17	2659.23	2023-03-01 00:00:00+00	online	completed	\N	\N
232	78	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	5036.64	2023-01-01 00:00:00+00	online	completed	\N	\N
233	78	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2139.12	2023-02-01 00:00:00+00	online	completed	\N	\N
234	78	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3289.91	2023-03-01 00:00:00+00	online	completed	\N	\N
235	79	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1784.41	2023-01-01 00:00:00+00	online	completed	\N	\N
236	79	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1072.36	2023-02-01 00:00:00+00	online	completed	\N	\N
237	79	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2047.22	2023-03-01 00:00:00+00	online	completed	\N	\N
238	80	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4379.90	2023-01-01 00:00:00+00	online	completed	\N	\N
239	80	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2566.35	2023-02-01 00:00:00+00	online	completed	\N	\N
240	80	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1801.55	2023-03-01 00:00:00+00	online	completed	\N	\N
241	81	1934abf8-eca9-41d8-bc5f-9c649285b76b	4784.42	2023-01-01 00:00:00+00	online	completed	\N	\N
242	81	1934abf8-eca9-41d8-bc5f-9c649285b76b	3668.33	2023-02-01 00:00:00+00	online	completed	\N	\N
243	81	1934abf8-eca9-41d8-bc5f-9c649285b76b	2673.21	2023-03-01 00:00:00+00	online	completed	\N	\N
244	82	da6ac18e-72e9-484a-ad75-d044260789cc	2914.77	2023-01-01 00:00:00+00	online	completed	\N	\N
245	82	da6ac18e-72e9-484a-ad75-d044260789cc	4814.67	2023-02-01 00:00:00+00	online	completed	\N	\N
246	82	da6ac18e-72e9-484a-ad75-d044260789cc	1047.50	2023-03-01 00:00:00+00	online	completed	\N	\N
247	83	6833f990-6a38-4f28-aa18-e31697fa7dc9	5528.33	2023-01-01 00:00:00+00	online	completed	\N	\N
248	83	6833f990-6a38-4f28-aa18-e31697fa7dc9	4737.43	2023-02-01 00:00:00+00	online	completed	\N	\N
249	83	6833f990-6a38-4f28-aa18-e31697fa7dc9	4092.61	2023-03-01 00:00:00+00	online	completed	\N	\N
250	84	cff64755-2065-4e58-866f-f092cbd9e73b	2187.64	2023-01-01 00:00:00+00	online	completed	\N	\N
251	84	cff64755-2065-4e58-866f-f092cbd9e73b	5567.57	2023-02-01 00:00:00+00	online	completed	\N	\N
252	84	cff64755-2065-4e58-866f-f092cbd9e73b	2437.37	2023-03-01 00:00:00+00	online	completed	\N	\N
253	85	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4152.95	2023-01-01 00:00:00+00	online	completed	\N	\N
254	85	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3352.48	2023-02-01 00:00:00+00	online	completed	\N	\N
255	85	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3730.24	2023-03-01 00:00:00+00	online	completed	\N	\N
256	86	387d98f7-ccf9-4077-8f79-f0be51c40d05	2393.98	2023-01-01 00:00:00+00	online	completed	\N	\N
257	86	387d98f7-ccf9-4077-8f79-f0be51c40d05	5727.80	2023-02-01 00:00:00+00	online	completed	\N	\N
258	86	387d98f7-ccf9-4077-8f79-f0be51c40d05	5355.78	2023-03-01 00:00:00+00	online	completed	\N	\N
259	87	ee522e07-1315-4463-8a9b-f890b601c047	3093.55	2023-01-01 00:00:00+00	online	completed	\N	\N
260	87	ee522e07-1315-4463-8a9b-f890b601c047	1560.28	2023-02-01 00:00:00+00	online	completed	\N	\N
261	87	ee522e07-1315-4463-8a9b-f890b601c047	5589.44	2023-03-01 00:00:00+00	online	completed	\N	\N
262	88	dd35da46-4416-412a-8a22-f3f39491bb7b	5330.44	2023-01-01 00:00:00+00	online	completed	\N	\N
263	88	dd35da46-4416-412a-8a22-f3f39491bb7b	4447.81	2023-02-01 00:00:00+00	online	completed	\N	\N
264	88	dd35da46-4416-412a-8a22-f3f39491bb7b	1480.69	2023-03-01 00:00:00+00	online	completed	\N	\N
265	89	387d98f7-ccf9-4077-8f79-f0be51c40d05	1490.41	2023-01-01 00:00:00+00	online	completed	\N	\N
266	89	387d98f7-ccf9-4077-8f79-f0be51c40d05	3694.01	2023-02-01 00:00:00+00	online	completed	\N	\N
267	89	387d98f7-ccf9-4077-8f79-f0be51c40d05	4240.60	2023-03-01 00:00:00+00	online	completed	\N	\N
268	90	dbbbe49c-e100-4576-b406-320908c8873e	2598.04	2023-01-01 00:00:00+00	online	completed	\N	\N
269	90	dbbbe49c-e100-4576-b406-320908c8873e	4348.15	2023-02-01 00:00:00+00	online	completed	\N	\N
270	90	dbbbe49c-e100-4576-b406-320908c8873e	1200.73	2023-03-01 00:00:00+00	online	completed	\N	\N
271	91	dbbbe49c-e100-4576-b406-320908c8873e	2349.83	2023-01-01 00:00:00+00	online	completed	\N	\N
272	91	dbbbe49c-e100-4576-b406-320908c8873e	5076.81	2023-02-01 00:00:00+00	online	completed	\N	\N
273	91	dbbbe49c-e100-4576-b406-320908c8873e	4502.30	2023-03-01 00:00:00+00	online	completed	\N	\N
274	92	1934abf8-eca9-41d8-bc5f-9c649285b76b	4317.84	2023-01-01 00:00:00+00	online	completed	\N	\N
275	92	1934abf8-eca9-41d8-bc5f-9c649285b76b	3880.26	2023-02-01 00:00:00+00	online	completed	\N	\N
276	92	1934abf8-eca9-41d8-bc5f-9c649285b76b	3544.24	2023-03-01 00:00:00+00	online	completed	\N	\N
277	93	51072377-1472-46cb-b180-8542677f5eb2	2042.43	2023-01-01 00:00:00+00	online	completed	\N	\N
278	93	51072377-1472-46cb-b180-8542677f5eb2	3645.67	2023-02-01 00:00:00+00	online	completed	\N	\N
279	93	51072377-1472-46cb-b180-8542677f5eb2	5125.39	2023-03-01 00:00:00+00	online	completed	\N	\N
280	94	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3667.14	2023-01-01 00:00:00+00	online	completed	\N	\N
281	94	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3765.09	2023-02-01 00:00:00+00	online	completed	\N	\N
282	94	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1053.12	2023-03-01 00:00:00+00	online	completed	\N	\N
283	95	9255fabc-799b-4cc7-8797-5f2470f6adf6	4422.97	2023-01-01 00:00:00+00	online	completed	\N	\N
284	95	9255fabc-799b-4cc7-8797-5f2470f6adf6	2837.03	2023-02-01 00:00:00+00	online	completed	\N	\N
285	95	9255fabc-799b-4cc7-8797-5f2470f6adf6	4393.97	2023-03-01 00:00:00+00	online	completed	\N	\N
286	96	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1450.57	2023-01-01 00:00:00+00	online	completed	\N	\N
287	96	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1099.20	2023-02-01 00:00:00+00	online	completed	\N	\N
288	96	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4302.10	2023-03-01 00:00:00+00	online	completed	\N	\N
289	97	fc7c7272-6d55-49a3-88d7-fc37133a103f	2798.97	2023-01-01 00:00:00+00	online	completed	\N	\N
290	97	fc7c7272-6d55-49a3-88d7-fc37133a103f	3837.21	2023-02-01 00:00:00+00	online	completed	\N	\N
291	97	fc7c7272-6d55-49a3-88d7-fc37133a103f	5327.53	2023-03-01 00:00:00+00	online	completed	\N	\N
292	98	ee522e07-1315-4463-8a9b-f890b601c047	5122.90	2023-01-01 00:00:00+00	online	completed	\N	\N
293	98	ee522e07-1315-4463-8a9b-f890b601c047	2119.32	2023-02-01 00:00:00+00	online	completed	\N	\N
294	98	ee522e07-1315-4463-8a9b-f890b601c047	5176.56	2023-03-01 00:00:00+00	online	completed	\N	\N
295	99	fc7c7272-6d55-49a3-88d7-fc37133a103f	5991.69	2023-01-01 00:00:00+00	online	completed	\N	\N
296	99	fc7c7272-6d55-49a3-88d7-fc37133a103f	5229.56	2023-02-01 00:00:00+00	online	completed	\N	\N
297	99	fc7c7272-6d55-49a3-88d7-fc37133a103f	3017.66	2023-03-01 00:00:00+00	online	completed	\N	\N
298	100	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2969.27	2023-01-01 00:00:00+00	online	completed	\N	\N
299	100	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4819.70	2023-02-01 00:00:00+00	online	completed	\N	\N
300	100	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2838.66	2023-03-01 00:00:00+00	online	completed	\N	\N
301	101	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2602.12	2023-01-01 00:00:00+00	online	completed	\N	\N
302	101	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3334.93	2023-02-01 00:00:00+00	online	completed	\N	\N
303	101	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2687.34	2023-03-01 00:00:00+00	online	completed	\N	\N
304	102	a602c1a3-89cf-44a4-b419-f6827ad3701b	5997.61	2023-01-01 00:00:00+00	online	completed	\N	\N
305	102	a602c1a3-89cf-44a4-b419-f6827ad3701b	4395.15	2023-02-01 00:00:00+00	online	completed	\N	\N
306	102	a602c1a3-89cf-44a4-b419-f6827ad3701b	5333.96	2023-03-01 00:00:00+00	online	completed	\N	\N
307	103	6833f990-6a38-4f28-aa18-e31697fa7dc9	3428.70	2023-01-01 00:00:00+00	online	completed	\N	\N
308	103	6833f990-6a38-4f28-aa18-e31697fa7dc9	3563.75	2023-02-01 00:00:00+00	online	completed	\N	\N
309	103	6833f990-6a38-4f28-aa18-e31697fa7dc9	3625.89	2023-03-01 00:00:00+00	online	completed	\N	\N
310	104	463737cc-950b-4a41-8d73-a3daf931fee5	4189.82	2023-01-01 00:00:00+00	online	completed	\N	\N
311	104	463737cc-950b-4a41-8d73-a3daf931fee5	2751.41	2023-02-01 00:00:00+00	online	completed	\N	\N
312	104	463737cc-950b-4a41-8d73-a3daf931fee5	1803.43	2023-03-01 00:00:00+00	online	completed	\N	\N
313	105	cff64755-2065-4e58-866f-f092cbd9e73b	2198.63	2023-01-01 00:00:00+00	online	completed	\N	\N
314	105	cff64755-2065-4e58-866f-f092cbd9e73b	4750.64	2023-02-01 00:00:00+00	online	completed	\N	\N
315	105	cff64755-2065-4e58-866f-f092cbd9e73b	3099.80	2023-03-01 00:00:00+00	online	completed	\N	\N
316	106	a83848ba-0779-4fac-98ee-f5f459b2742b	4790.82	2023-01-01 00:00:00+00	online	completed	\N	\N
317	106	a83848ba-0779-4fac-98ee-f5f459b2742b	1934.85	2023-02-01 00:00:00+00	online	completed	\N	\N
318	106	a83848ba-0779-4fac-98ee-f5f459b2742b	1722.37	2023-03-01 00:00:00+00	online	completed	\N	\N
319	107	b794e95a-97f4-4c05-aa2d-3c13c4155841	3297.00	2023-01-01 00:00:00+00	online	completed	\N	\N
320	107	b794e95a-97f4-4c05-aa2d-3c13c4155841	3350.75	2023-02-01 00:00:00+00	online	completed	\N	\N
321	107	b794e95a-97f4-4c05-aa2d-3c13c4155841	2473.59	2023-03-01 00:00:00+00	online	completed	\N	\N
322	108	a83848ba-0779-4fac-98ee-f5f459b2742b	1184.99	2023-01-01 00:00:00+00	online	completed	\N	\N
323	108	a83848ba-0779-4fac-98ee-f5f459b2742b	5097.58	2023-02-01 00:00:00+00	online	completed	\N	\N
324	108	a83848ba-0779-4fac-98ee-f5f459b2742b	5612.98	2023-03-01 00:00:00+00	online	completed	\N	\N
325	109	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4263.23	2023-01-01 00:00:00+00	online	completed	\N	\N
326	109	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1923.05	2023-02-01 00:00:00+00	online	completed	\N	\N
327	109	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1789.27	2023-03-01 00:00:00+00	online	completed	\N	\N
328	110	463737cc-950b-4a41-8d73-a3daf931fee5	3153.65	2023-01-01 00:00:00+00	online	completed	\N	\N
329	110	463737cc-950b-4a41-8d73-a3daf931fee5	1646.81	2023-02-01 00:00:00+00	online	completed	\N	\N
330	110	463737cc-950b-4a41-8d73-a3daf931fee5	5250.38	2023-03-01 00:00:00+00	online	completed	\N	\N
331	111	463737cc-950b-4a41-8d73-a3daf931fee5	5157.04	2023-01-01 00:00:00+00	online	completed	\N	\N
332	111	463737cc-950b-4a41-8d73-a3daf931fee5	2140.17	2023-02-01 00:00:00+00	online	completed	\N	\N
333	111	463737cc-950b-4a41-8d73-a3daf931fee5	3007.43	2023-03-01 00:00:00+00	online	completed	\N	\N
334	112	77e168c1-05e0-4314-8a24-5e838350a3d8	4159.29	2023-01-01 00:00:00+00	online	completed	\N	\N
335	112	77e168c1-05e0-4314-8a24-5e838350a3d8	2498.62	2023-02-01 00:00:00+00	online	completed	\N	\N
336	112	77e168c1-05e0-4314-8a24-5e838350a3d8	4361.77	2023-03-01 00:00:00+00	online	completed	\N	\N
337	113	584a1909-5797-4297-88d3-06bf5dc3922a	1439.89	2023-01-01 00:00:00+00	online	completed	\N	\N
338	113	584a1909-5797-4297-88d3-06bf5dc3922a	1609.24	2023-02-01 00:00:00+00	online	completed	\N	\N
339	113	584a1909-5797-4297-88d3-06bf5dc3922a	3903.51	2023-03-01 00:00:00+00	online	completed	\N	\N
340	114	da6ac18e-72e9-484a-ad75-d044260789cc	4471.88	2023-01-01 00:00:00+00	online	completed	\N	\N
341	114	da6ac18e-72e9-484a-ad75-d044260789cc	3117.62	2023-02-01 00:00:00+00	online	completed	\N	\N
342	114	da6ac18e-72e9-484a-ad75-d044260789cc	1291.52	2023-03-01 00:00:00+00	online	completed	\N	\N
343	115	387d98f7-ccf9-4077-8f79-f0be51c40d05	3463.94	2023-01-01 00:00:00+00	online	completed	\N	\N
344	115	387d98f7-ccf9-4077-8f79-f0be51c40d05	2233.47	2023-02-01 00:00:00+00	online	completed	\N	\N
345	115	387d98f7-ccf9-4077-8f79-f0be51c40d05	3853.44	2023-03-01 00:00:00+00	online	completed	\N	\N
346	116	6ac1e176-e710-4b5e-9453-95765db20ba3	1657.67	2023-01-01 00:00:00+00	online	completed	\N	\N
347	116	6ac1e176-e710-4b5e-9453-95765db20ba3	2697.18	2023-02-01 00:00:00+00	online	completed	\N	\N
348	116	6ac1e176-e710-4b5e-9453-95765db20ba3	2432.08	2023-03-01 00:00:00+00	online	completed	\N	\N
349	117	5bf27593-0c3d-489f-bed4-c80dc2936fdf	3017.22	2023-01-01 00:00:00+00	online	completed	\N	\N
350	117	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1139.87	2023-02-01 00:00:00+00	online	completed	\N	\N
351	117	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2423.15	2023-03-01 00:00:00+00	online	completed	\N	\N
352	118	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	1883.29	2023-01-01 00:00:00+00	online	completed	\N	\N
353	118	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	5838.48	2023-02-01 00:00:00+00	online	completed	\N	\N
354	118	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	4378.91	2023-03-01 00:00:00+00	online	completed	\N	\N
355	119	6ac1e176-e710-4b5e-9453-95765db20ba3	3976.36	2023-01-01 00:00:00+00	online	completed	\N	\N
356	119	6ac1e176-e710-4b5e-9453-95765db20ba3	4658.14	2023-02-01 00:00:00+00	online	completed	\N	\N
357	119	6ac1e176-e710-4b5e-9453-95765db20ba3	3154.04	2023-03-01 00:00:00+00	online	completed	\N	\N
358	120	6833f990-6a38-4f28-aa18-e31697fa7dc9	4849.99	2023-01-01 00:00:00+00	online	completed	\N	\N
359	120	6833f990-6a38-4f28-aa18-e31697fa7dc9	5088.92	2023-02-01 00:00:00+00	online	completed	\N	\N
360	120	6833f990-6a38-4f28-aa18-e31697fa7dc9	1368.25	2023-03-01 00:00:00+00	online	completed	\N	\N
361	121	fc7c7272-6d55-49a3-88d7-fc37133a103f	2997.46	2023-01-01 00:00:00+00	online	completed	\N	\N
362	121	fc7c7272-6d55-49a3-88d7-fc37133a103f	4407.09	2023-02-01 00:00:00+00	online	completed	\N	\N
363	121	fc7c7272-6d55-49a3-88d7-fc37133a103f	4722.64	2023-03-01 00:00:00+00	online	completed	\N	\N
364	122	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2673.68	2023-01-01 00:00:00+00	online	completed	\N	\N
365	122	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4120.48	2023-02-01 00:00:00+00	online	completed	\N	\N
366	122	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1715.34	2023-03-01 00:00:00+00	online	completed	\N	\N
367	123	6833f990-6a38-4f28-aa18-e31697fa7dc9	5671.99	2023-01-01 00:00:00+00	online	completed	\N	\N
368	123	6833f990-6a38-4f28-aa18-e31697fa7dc9	5386.59	2023-02-01 00:00:00+00	online	completed	\N	\N
369	123	6833f990-6a38-4f28-aa18-e31697fa7dc9	1969.27	2023-03-01 00:00:00+00	online	completed	\N	\N
370	124	77e168c1-05e0-4314-8a24-5e838350a3d8	2692.87	2023-01-01 00:00:00+00	online	completed	\N	\N
371	124	77e168c1-05e0-4314-8a24-5e838350a3d8	4270.69	2023-02-01 00:00:00+00	online	completed	\N	\N
372	124	77e168c1-05e0-4314-8a24-5e838350a3d8	2890.65	2023-03-01 00:00:00+00	online	completed	\N	\N
373	125	a602c1a3-89cf-44a4-b419-f6827ad3701b	1616.00	2023-01-01 00:00:00+00	online	completed	\N	\N
374	125	a602c1a3-89cf-44a4-b419-f6827ad3701b	2044.05	2023-02-01 00:00:00+00	online	completed	\N	\N
375	125	a602c1a3-89cf-44a4-b419-f6827ad3701b	4848.99	2023-03-01 00:00:00+00	online	completed	\N	\N
376	126	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	1510.55	2023-01-01 00:00:00+00	online	completed	\N	\N
377	126	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4967.45	2023-02-01 00:00:00+00	online	completed	\N	\N
378	126	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2593.84	2023-03-01 00:00:00+00	online	completed	\N	\N
379	127	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3812.40	2023-01-01 00:00:00+00	online	completed	\N	\N
380	127	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2044.32	2023-02-01 00:00:00+00	online	completed	\N	\N
381	127	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4115.93	2023-03-01 00:00:00+00	online	completed	\N	\N
382	128	584a1909-5797-4297-88d3-06bf5dc3922a	3476.17	2023-01-01 00:00:00+00	online	completed	\N	\N
383	128	584a1909-5797-4297-88d3-06bf5dc3922a	1465.42	2023-02-01 00:00:00+00	online	completed	\N	\N
384	128	584a1909-5797-4297-88d3-06bf5dc3922a	4879.59	2023-03-01 00:00:00+00	online	completed	\N	\N
385	129	dde964d6-6ffa-4b25-97b6-128969afe47c	2153.44	2023-01-01 00:00:00+00	online	completed	\N	\N
386	129	dde964d6-6ffa-4b25-97b6-128969afe47c	1781.06	2023-02-01 00:00:00+00	online	completed	\N	\N
387	129	dde964d6-6ffa-4b25-97b6-128969afe47c	4172.44	2023-03-01 00:00:00+00	online	completed	\N	\N
388	130	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4699.98	2023-01-01 00:00:00+00	online	completed	\N	\N
389	130	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4271.42	2023-02-01 00:00:00+00	online	completed	\N	\N
390	130	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	5776.05	2023-03-01 00:00:00+00	online	completed	\N	\N
391	131	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1507.73	2023-01-01 00:00:00+00	online	completed	\N	\N
392	131	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1817.64	2023-02-01 00:00:00+00	online	completed	\N	\N
393	131	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1308.92	2023-03-01 00:00:00+00	online	completed	\N	\N
394	132	51072377-1472-46cb-b180-8542677f5eb2	4525.17	2023-01-01 00:00:00+00	online	completed	\N	\N
395	132	51072377-1472-46cb-b180-8542677f5eb2	1885.21	2023-02-01 00:00:00+00	online	completed	\N	\N
396	132	51072377-1472-46cb-b180-8542677f5eb2	3041.04	2023-03-01 00:00:00+00	online	completed	\N	\N
397	133	fc7c7272-6d55-49a3-88d7-fc37133a103f	3857.07	2023-01-01 00:00:00+00	online	completed	\N	\N
398	133	fc7c7272-6d55-49a3-88d7-fc37133a103f	3941.71	2023-02-01 00:00:00+00	online	completed	\N	\N
399	133	fc7c7272-6d55-49a3-88d7-fc37133a103f	4676.11	2023-03-01 00:00:00+00	online	completed	\N	\N
400	134	da6ac18e-72e9-484a-ad75-d044260789cc	5574.59	2023-01-01 00:00:00+00	online	completed	\N	\N
401	134	da6ac18e-72e9-484a-ad75-d044260789cc	1817.96	2023-02-01 00:00:00+00	online	completed	\N	\N
402	134	da6ac18e-72e9-484a-ad75-d044260789cc	2939.74	2023-03-01 00:00:00+00	online	completed	\N	\N
403	135	77e168c1-05e0-4314-8a24-5e838350a3d8	1849.30	2023-01-01 00:00:00+00	online	completed	\N	\N
404	135	77e168c1-05e0-4314-8a24-5e838350a3d8	4678.64	2023-02-01 00:00:00+00	online	completed	\N	\N
405	135	77e168c1-05e0-4314-8a24-5e838350a3d8	4617.64	2023-03-01 00:00:00+00	online	completed	\N	\N
406	136	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2933.03	2023-01-01 00:00:00+00	online	completed	\N	\N
407	136	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5148.85	2023-02-01 00:00:00+00	online	completed	\N	\N
408	136	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4835.25	2023-03-01 00:00:00+00	online	completed	\N	\N
409	137	a83848ba-0779-4fac-98ee-f5f459b2742b	4942.69	2023-01-01 00:00:00+00	online	completed	\N	\N
410	137	a83848ba-0779-4fac-98ee-f5f459b2742b	3495.40	2023-02-01 00:00:00+00	online	completed	\N	\N
411	137	a83848ba-0779-4fac-98ee-f5f459b2742b	1106.96	2023-03-01 00:00:00+00	online	completed	\N	\N
412	138	5bf27593-0c3d-489f-bed4-c80dc2936fdf	3917.03	2023-01-01 00:00:00+00	online	completed	\N	\N
413	138	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1229.73	2023-02-01 00:00:00+00	online	completed	\N	\N
414	138	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1764.70	2023-03-01 00:00:00+00	online	completed	\N	\N
415	139	b794e95a-97f4-4c05-aa2d-3c13c4155841	1644.46	2023-01-01 00:00:00+00	online	completed	\N	\N
416	139	b794e95a-97f4-4c05-aa2d-3c13c4155841	5995.00	2023-02-01 00:00:00+00	online	completed	\N	\N
417	139	b794e95a-97f4-4c05-aa2d-3c13c4155841	5529.00	2023-03-01 00:00:00+00	online	completed	\N	\N
418	140	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5102.87	2023-01-01 00:00:00+00	online	completed	\N	\N
419	140	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2959.17	2023-02-01 00:00:00+00	online	completed	\N	\N
420	140	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5729.36	2023-03-01 00:00:00+00	online	completed	\N	\N
421	141	cff64755-2065-4e58-866f-f092cbd9e73b	5311.78	2023-01-01 00:00:00+00	online	completed	\N	\N
422	141	cff64755-2065-4e58-866f-f092cbd9e73b	3428.52	2023-02-01 00:00:00+00	online	completed	\N	\N
423	141	cff64755-2065-4e58-866f-f092cbd9e73b	5054.85	2023-03-01 00:00:00+00	online	completed	\N	\N
424	142	cff64755-2065-4e58-866f-f092cbd9e73b	5439.42	2023-01-01 00:00:00+00	online	completed	\N	\N
425	142	cff64755-2065-4e58-866f-f092cbd9e73b	3423.85	2023-02-01 00:00:00+00	online	completed	\N	\N
426	142	cff64755-2065-4e58-866f-f092cbd9e73b	1016.65	2023-03-01 00:00:00+00	online	completed	\N	\N
427	143	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	1173.11	2023-01-01 00:00:00+00	online	completed	\N	\N
428	143	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4250.30	2023-02-01 00:00:00+00	online	completed	\N	\N
429	143	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3275.25	2023-03-01 00:00:00+00	online	completed	\N	\N
430	144	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	5488.05	2023-01-01 00:00:00+00	online	completed	\N	\N
431	144	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2406.28	2023-02-01 00:00:00+00	online	completed	\N	\N
432	144	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	1030.97	2023-03-01 00:00:00+00	online	completed	\N	\N
433	145	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1328.94	2023-01-01 00:00:00+00	online	completed	\N	\N
434	145	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4498.87	2023-02-01 00:00:00+00	online	completed	\N	\N
435	145	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4075.51	2023-03-01 00:00:00+00	online	completed	\N	\N
436	146	bd38508e-8797-4220-ae2e-dd7883b41f17	1749.48	2023-01-01 00:00:00+00	online	completed	\N	\N
437	146	bd38508e-8797-4220-ae2e-dd7883b41f17	5545.52	2023-02-01 00:00:00+00	online	completed	\N	\N
438	146	bd38508e-8797-4220-ae2e-dd7883b41f17	3008.70	2023-03-01 00:00:00+00	online	completed	\N	\N
439	147	584a1909-5797-4297-88d3-06bf5dc3922a	4110.57	2023-01-01 00:00:00+00	online	completed	\N	\N
440	147	584a1909-5797-4297-88d3-06bf5dc3922a	4342.05	2023-02-01 00:00:00+00	online	completed	\N	\N
441	147	584a1909-5797-4297-88d3-06bf5dc3922a	5695.02	2023-03-01 00:00:00+00	online	completed	\N	\N
442	148	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1123.69	2023-01-01 00:00:00+00	online	completed	\N	\N
443	148	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3911.00	2023-02-01 00:00:00+00	online	completed	\N	\N
444	148	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5328.77	2023-03-01 00:00:00+00	online	completed	\N	\N
445	149	1934abf8-eca9-41d8-bc5f-9c649285b76b	4812.10	2023-01-01 00:00:00+00	online	completed	\N	\N
446	149	1934abf8-eca9-41d8-bc5f-9c649285b76b	1094.52	2023-02-01 00:00:00+00	online	completed	\N	\N
447	149	1934abf8-eca9-41d8-bc5f-9c649285b76b	3293.90	2023-03-01 00:00:00+00	online	completed	\N	\N
448	150	da6ac18e-72e9-484a-ad75-d044260789cc	3943.47	2023-01-01 00:00:00+00	online	completed	\N	\N
449	150	da6ac18e-72e9-484a-ad75-d044260789cc	4872.00	2023-02-01 00:00:00+00	online	completed	\N	\N
450	150	da6ac18e-72e9-484a-ad75-d044260789cc	5205.25	2023-03-01 00:00:00+00	online	completed	\N	\N
451	151	dde964d6-6ffa-4b25-97b6-128969afe47c	4428.66	2023-01-01 00:00:00+00	online	completed	\N	\N
452	151	dde964d6-6ffa-4b25-97b6-128969afe47c	5133.32	2023-02-01 00:00:00+00	online	completed	\N	\N
453	151	dde964d6-6ffa-4b25-97b6-128969afe47c	5745.66	2023-03-01 00:00:00+00	online	completed	\N	\N
454	152	bd38508e-8797-4220-ae2e-dd7883b41f17	2760.91	2023-01-01 00:00:00+00	online	completed	\N	\N
455	152	bd38508e-8797-4220-ae2e-dd7883b41f17	3300.73	2023-02-01 00:00:00+00	online	completed	\N	\N
456	152	bd38508e-8797-4220-ae2e-dd7883b41f17	1667.13	2023-03-01 00:00:00+00	online	completed	\N	\N
457	153	cff64755-2065-4e58-866f-f092cbd9e73b	1677.51	2023-01-01 00:00:00+00	online	completed	\N	\N
458	153	cff64755-2065-4e58-866f-f092cbd9e73b	3372.37	2023-02-01 00:00:00+00	online	completed	\N	\N
459	153	cff64755-2065-4e58-866f-f092cbd9e73b	5818.36	2023-03-01 00:00:00+00	online	completed	\N	\N
460	154	bd38508e-8797-4220-ae2e-dd7883b41f17	4291.07	2023-01-01 00:00:00+00	online	completed	\N	\N
461	154	bd38508e-8797-4220-ae2e-dd7883b41f17	3792.86	2023-02-01 00:00:00+00	online	completed	\N	\N
462	154	bd38508e-8797-4220-ae2e-dd7883b41f17	5293.48	2023-03-01 00:00:00+00	online	completed	\N	\N
463	155	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5223.77	2023-01-01 00:00:00+00	online	completed	\N	\N
464	155	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1268.26	2023-02-01 00:00:00+00	online	completed	\N	\N
465	155	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5249.06	2023-03-01 00:00:00+00	online	completed	\N	\N
466	156	584a1909-5797-4297-88d3-06bf5dc3922a	5289.44	2023-01-01 00:00:00+00	online	completed	\N	\N
467	156	584a1909-5797-4297-88d3-06bf5dc3922a	4427.88	2023-02-01 00:00:00+00	online	completed	\N	\N
468	156	584a1909-5797-4297-88d3-06bf5dc3922a	1082.38	2023-03-01 00:00:00+00	online	completed	\N	\N
469	157	6ac1e176-e710-4b5e-9453-95765db20ba3	3050.85	2023-01-01 00:00:00+00	online	completed	\N	\N
470	157	6ac1e176-e710-4b5e-9453-95765db20ba3	3746.02	2023-02-01 00:00:00+00	online	completed	\N	\N
471	157	6ac1e176-e710-4b5e-9453-95765db20ba3	4604.44	2023-03-01 00:00:00+00	online	completed	\N	\N
472	158	9255fabc-799b-4cc7-8797-5f2470f6adf6	3287.39	2023-01-01 00:00:00+00	online	completed	\N	\N
473	158	9255fabc-799b-4cc7-8797-5f2470f6adf6	4850.95	2023-02-01 00:00:00+00	online	completed	\N	\N
474	158	9255fabc-799b-4cc7-8797-5f2470f6adf6	1106.59	2023-03-01 00:00:00+00	online	completed	\N	\N
475	159	a602c1a3-89cf-44a4-b419-f6827ad3701b	3151.99	2023-01-01 00:00:00+00	online	completed	\N	\N
476	159	a602c1a3-89cf-44a4-b419-f6827ad3701b	2672.77	2023-02-01 00:00:00+00	online	completed	\N	\N
477	159	a602c1a3-89cf-44a4-b419-f6827ad3701b	3358.41	2023-03-01 00:00:00+00	online	completed	\N	\N
478	160	a83848ba-0779-4fac-98ee-f5f459b2742b	1309.83	2023-01-01 00:00:00+00	online	completed	\N	\N
479	160	a83848ba-0779-4fac-98ee-f5f459b2742b	4585.42	2023-02-01 00:00:00+00	online	completed	\N	\N
480	160	a83848ba-0779-4fac-98ee-f5f459b2742b	4486.42	2023-03-01 00:00:00+00	online	completed	\N	\N
481	161	8088628d-f77a-430d-b228-cc3649b8a3e1	3201.91	2023-01-01 00:00:00+00	online	completed	\N	\N
482	161	8088628d-f77a-430d-b228-cc3649b8a3e1	3246.32	2023-02-01 00:00:00+00	online	completed	\N	\N
483	161	8088628d-f77a-430d-b228-cc3649b8a3e1	3252.54	2023-03-01 00:00:00+00	online	completed	\N	\N
484	162	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1007.58	2023-01-01 00:00:00+00	online	completed	\N	\N
485	162	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3334.71	2023-02-01 00:00:00+00	online	completed	\N	\N
486	162	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3611.02	2023-03-01 00:00:00+00	online	completed	\N	\N
487	163	1934abf8-eca9-41d8-bc5f-9c649285b76b	5812.19	2023-01-01 00:00:00+00	online	completed	\N	\N
488	163	1934abf8-eca9-41d8-bc5f-9c649285b76b	3600.74	2023-02-01 00:00:00+00	online	completed	\N	\N
489	163	1934abf8-eca9-41d8-bc5f-9c649285b76b	5261.48	2023-03-01 00:00:00+00	online	completed	\N	\N
490	164	fd99f59b-fcc6-42ef-a407-207f110f2d7b	1728.62	2023-01-01 00:00:00+00	online	completed	\N	\N
491	164	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2320.88	2023-02-01 00:00:00+00	online	completed	\N	\N
492	164	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2102.81	2023-03-01 00:00:00+00	online	completed	\N	\N
493	165	dde964d6-6ffa-4b25-97b6-128969afe47c	1507.48	2023-01-01 00:00:00+00	online	completed	\N	\N
494	165	dde964d6-6ffa-4b25-97b6-128969afe47c	1596.68	2023-02-01 00:00:00+00	online	completed	\N	\N
495	165	dde964d6-6ffa-4b25-97b6-128969afe47c	3945.02	2023-03-01 00:00:00+00	online	completed	\N	\N
496	166	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4510.91	2023-01-01 00:00:00+00	online	completed	\N	\N
497	166	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3764.52	2023-02-01 00:00:00+00	online	completed	\N	\N
498	166	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3693.43	2023-03-01 00:00:00+00	online	completed	\N	\N
499	167	51072377-1472-46cb-b180-8542677f5eb2	1801.38	2023-01-01 00:00:00+00	online	completed	\N	\N
500	167	51072377-1472-46cb-b180-8542677f5eb2	2403.21	2023-02-01 00:00:00+00	online	completed	\N	\N
501	167	51072377-1472-46cb-b180-8542677f5eb2	3749.12	2023-03-01 00:00:00+00	online	completed	\N	\N
502	168	cff64755-2065-4e58-866f-f092cbd9e73b	3203.76	2023-01-01 00:00:00+00	online	completed	\N	\N
503	168	cff64755-2065-4e58-866f-f092cbd9e73b	4895.90	2023-02-01 00:00:00+00	online	completed	\N	\N
504	168	cff64755-2065-4e58-866f-f092cbd9e73b	3884.78	2023-03-01 00:00:00+00	online	completed	\N	\N
505	169	cff64755-2065-4e58-866f-f092cbd9e73b	1527.78	2023-01-01 00:00:00+00	online	completed	\N	\N
506	169	cff64755-2065-4e58-866f-f092cbd9e73b	3361.05	2023-02-01 00:00:00+00	online	completed	\N	\N
507	169	cff64755-2065-4e58-866f-f092cbd9e73b	4607.42	2023-03-01 00:00:00+00	online	completed	\N	\N
508	170	5432f125-2d5e-42ab-849a-29add2cf0a74	1533.14	2023-01-01 00:00:00+00	online	completed	\N	\N
509	170	5432f125-2d5e-42ab-849a-29add2cf0a74	5593.58	2023-02-01 00:00:00+00	online	completed	\N	\N
510	170	5432f125-2d5e-42ab-849a-29add2cf0a74	2631.83	2023-03-01 00:00:00+00	online	completed	\N	\N
511	171	b794e95a-97f4-4c05-aa2d-3c13c4155841	2823.98	2023-01-01 00:00:00+00	online	completed	\N	\N
512	171	b794e95a-97f4-4c05-aa2d-3c13c4155841	4748.55	2023-02-01 00:00:00+00	online	completed	\N	\N
513	171	b794e95a-97f4-4c05-aa2d-3c13c4155841	5857.42	2023-03-01 00:00:00+00	online	completed	\N	\N
514	172	77e168c1-05e0-4314-8a24-5e838350a3d8	2273.89	2023-01-01 00:00:00+00	online	completed	\N	\N
515	172	77e168c1-05e0-4314-8a24-5e838350a3d8	2054.39	2023-02-01 00:00:00+00	online	completed	\N	\N
516	172	77e168c1-05e0-4314-8a24-5e838350a3d8	4722.70	2023-03-01 00:00:00+00	online	completed	\N	\N
517	173	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1014.29	2023-01-01 00:00:00+00	online	completed	\N	\N
518	173	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2742.79	2023-02-01 00:00:00+00	online	completed	\N	\N
519	173	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3245.06	2023-03-01 00:00:00+00	online	completed	\N	\N
520	174	77e168c1-05e0-4314-8a24-5e838350a3d8	3207.63	2023-01-01 00:00:00+00	online	completed	\N	\N
521	174	77e168c1-05e0-4314-8a24-5e838350a3d8	3315.04	2023-02-01 00:00:00+00	online	completed	\N	\N
522	174	77e168c1-05e0-4314-8a24-5e838350a3d8	5982.71	2023-03-01 00:00:00+00	online	completed	\N	\N
523	175	6833f990-6a38-4f28-aa18-e31697fa7dc9	3966.24	2023-01-01 00:00:00+00	online	completed	\N	\N
524	175	6833f990-6a38-4f28-aa18-e31697fa7dc9	3313.77	2023-02-01 00:00:00+00	online	completed	\N	\N
525	175	6833f990-6a38-4f28-aa18-e31697fa7dc9	1636.78	2023-03-01 00:00:00+00	online	completed	\N	\N
526	176	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	4437.24	2023-01-01 00:00:00+00	online	completed	\N	\N
527	176	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5060.52	2023-02-01 00:00:00+00	online	completed	\N	\N
528	176	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3737.36	2023-03-01 00:00:00+00	online	completed	\N	\N
529	177	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5213.93	2023-01-01 00:00:00+00	online	completed	\N	\N
530	177	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2111.83	2023-02-01 00:00:00+00	online	completed	\N	\N
531	177	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3223.69	2023-03-01 00:00:00+00	online	completed	\N	\N
532	178	cff64755-2065-4e58-866f-f092cbd9e73b	1101.40	2023-01-01 00:00:00+00	online	completed	\N	\N
533	178	cff64755-2065-4e58-866f-f092cbd9e73b	3718.82	2023-02-01 00:00:00+00	online	completed	\N	\N
534	178	cff64755-2065-4e58-866f-f092cbd9e73b	5668.57	2023-03-01 00:00:00+00	online	completed	\N	\N
535	179	5432f125-2d5e-42ab-849a-29add2cf0a74	5320.18	2023-01-01 00:00:00+00	online	completed	\N	\N
536	179	5432f125-2d5e-42ab-849a-29add2cf0a74	5096.80	2023-02-01 00:00:00+00	online	completed	\N	\N
537	179	5432f125-2d5e-42ab-849a-29add2cf0a74	2145.52	2023-03-01 00:00:00+00	online	completed	\N	\N
538	180	584a1909-5797-4297-88d3-06bf5dc3922a	3736.26	2023-01-01 00:00:00+00	online	completed	\N	\N
539	180	584a1909-5797-4297-88d3-06bf5dc3922a	3283.30	2023-02-01 00:00:00+00	online	completed	\N	\N
540	180	584a1909-5797-4297-88d3-06bf5dc3922a	5335.26	2023-03-01 00:00:00+00	online	completed	\N	\N
541	181	77e168c1-05e0-4314-8a24-5e838350a3d8	1196.06	2023-01-01 00:00:00+00	online	completed	\N	\N
542	181	77e168c1-05e0-4314-8a24-5e838350a3d8	4750.12	2023-02-01 00:00:00+00	online	completed	\N	\N
543	181	77e168c1-05e0-4314-8a24-5e838350a3d8	1550.84	2023-03-01 00:00:00+00	online	completed	\N	\N
544	182	cff64755-2065-4e58-866f-f092cbd9e73b	3486.56	2023-01-01 00:00:00+00	online	completed	\N	\N
545	182	cff64755-2065-4e58-866f-f092cbd9e73b	3852.06	2023-02-01 00:00:00+00	online	completed	\N	\N
546	182	cff64755-2065-4e58-866f-f092cbd9e73b	3491.72	2023-03-01 00:00:00+00	online	completed	\N	\N
547	183	dde964d6-6ffa-4b25-97b6-128969afe47c	2307.98	2023-01-01 00:00:00+00	online	completed	\N	\N
548	183	dde964d6-6ffa-4b25-97b6-128969afe47c	2286.11	2023-02-01 00:00:00+00	online	completed	\N	\N
549	183	dde964d6-6ffa-4b25-97b6-128969afe47c	2361.18	2023-03-01 00:00:00+00	online	completed	\N	\N
550	184	a83848ba-0779-4fac-98ee-f5f459b2742b	4337.33	2023-01-01 00:00:00+00	online	completed	\N	\N
551	184	a83848ba-0779-4fac-98ee-f5f459b2742b	1945.47	2023-02-01 00:00:00+00	online	completed	\N	\N
552	184	a83848ba-0779-4fac-98ee-f5f459b2742b	1053.03	2023-03-01 00:00:00+00	online	completed	\N	\N
553	185	dd35da46-4416-412a-8a22-f3f39491bb7b	1657.65	2023-01-01 00:00:00+00	online	completed	\N	\N
554	185	dd35da46-4416-412a-8a22-f3f39491bb7b	4128.61	2023-02-01 00:00:00+00	online	completed	\N	\N
555	185	dd35da46-4416-412a-8a22-f3f39491bb7b	1057.74	2023-03-01 00:00:00+00	online	completed	\N	\N
556	186	584a1909-5797-4297-88d3-06bf5dc3922a	5655.17	2023-01-01 00:00:00+00	online	completed	\N	\N
557	186	584a1909-5797-4297-88d3-06bf5dc3922a	2454.70	2023-02-01 00:00:00+00	online	completed	\N	\N
558	186	584a1909-5797-4297-88d3-06bf5dc3922a	5240.92	2023-03-01 00:00:00+00	online	completed	\N	\N
559	187	da6ac18e-72e9-484a-ad75-d044260789cc	1780.33	2023-01-01 00:00:00+00	online	completed	\N	\N
560	187	da6ac18e-72e9-484a-ad75-d044260789cc	5906.12	2023-02-01 00:00:00+00	online	completed	\N	\N
561	187	da6ac18e-72e9-484a-ad75-d044260789cc	5364.43	2023-03-01 00:00:00+00	online	completed	\N	\N
562	188	9255fabc-799b-4cc7-8797-5f2470f6adf6	4806.41	2023-01-01 00:00:00+00	online	completed	\N	\N
563	188	9255fabc-799b-4cc7-8797-5f2470f6adf6	1729.79	2023-02-01 00:00:00+00	online	completed	\N	\N
564	188	9255fabc-799b-4cc7-8797-5f2470f6adf6	3781.30	2023-03-01 00:00:00+00	online	completed	\N	\N
565	189	a602c1a3-89cf-44a4-b419-f6827ad3701b	1199.11	2023-01-01 00:00:00+00	online	completed	\N	\N
566	189	a602c1a3-89cf-44a4-b419-f6827ad3701b	3434.76	2023-02-01 00:00:00+00	online	completed	\N	\N
567	189	a602c1a3-89cf-44a4-b419-f6827ad3701b	5538.80	2023-03-01 00:00:00+00	online	completed	\N	\N
568	190	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4101.48	2023-01-01 00:00:00+00	online	completed	\N	\N
569	190	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4515.32	2023-02-01 00:00:00+00	online	completed	\N	\N
570	190	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4736.08	2023-03-01 00:00:00+00	online	completed	\N	\N
571	191	8088628d-f77a-430d-b228-cc3649b8a3e1	1087.02	2023-01-01 00:00:00+00	online	completed	\N	\N
572	191	8088628d-f77a-430d-b228-cc3649b8a3e1	3806.15	2023-02-01 00:00:00+00	online	completed	\N	\N
573	191	8088628d-f77a-430d-b228-cc3649b8a3e1	2253.90	2023-03-01 00:00:00+00	online	completed	\N	\N
574	192	387d98f7-ccf9-4077-8f79-f0be51c40d05	3475.83	2023-01-01 00:00:00+00	online	completed	\N	\N
575	192	387d98f7-ccf9-4077-8f79-f0be51c40d05	3951.71	2023-02-01 00:00:00+00	online	completed	\N	\N
576	192	387d98f7-ccf9-4077-8f79-f0be51c40d05	4670.14	2023-03-01 00:00:00+00	online	completed	\N	\N
577	193	77e168c1-05e0-4314-8a24-5e838350a3d8	1573.34	2023-01-01 00:00:00+00	online	completed	\N	\N
578	193	77e168c1-05e0-4314-8a24-5e838350a3d8	1319.23	2023-02-01 00:00:00+00	online	completed	\N	\N
579	193	77e168c1-05e0-4314-8a24-5e838350a3d8	3769.65	2023-03-01 00:00:00+00	online	completed	\N	\N
580	194	cff64755-2065-4e58-866f-f092cbd9e73b	2473.34	2023-01-01 00:00:00+00	online	completed	\N	\N
581	194	cff64755-2065-4e58-866f-f092cbd9e73b	2660.56	2023-02-01 00:00:00+00	online	completed	\N	\N
582	194	cff64755-2065-4e58-866f-f092cbd9e73b	5821.60	2023-03-01 00:00:00+00	online	completed	\N	\N
583	195	9255fabc-799b-4cc7-8797-5f2470f6adf6	5183.36	2023-01-01 00:00:00+00	online	completed	\N	\N
584	195	9255fabc-799b-4cc7-8797-5f2470f6adf6	1865.40	2023-02-01 00:00:00+00	online	completed	\N	\N
585	195	9255fabc-799b-4cc7-8797-5f2470f6adf6	2971.30	2023-03-01 00:00:00+00	online	completed	\N	\N
586	196	ee522e07-1315-4463-8a9b-f890b601c047	5967.88	2023-01-01 00:00:00+00	online	completed	\N	\N
587	196	ee522e07-1315-4463-8a9b-f890b601c047	3394.28	2023-02-01 00:00:00+00	online	completed	\N	\N
588	196	ee522e07-1315-4463-8a9b-f890b601c047	2076.90	2023-03-01 00:00:00+00	online	completed	\N	\N
589	197	6ac1e176-e710-4b5e-9453-95765db20ba3	4467.89	2023-01-01 00:00:00+00	online	completed	\N	\N
590	197	6ac1e176-e710-4b5e-9453-95765db20ba3	1474.05	2023-02-01 00:00:00+00	online	completed	\N	\N
591	197	6ac1e176-e710-4b5e-9453-95765db20ba3	4496.45	2023-03-01 00:00:00+00	online	completed	\N	\N
592	198	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2559.70	2023-01-01 00:00:00+00	online	completed	\N	\N
593	198	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3222.72	2023-02-01 00:00:00+00	online	completed	\N	\N
594	198	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1440.55	2023-03-01 00:00:00+00	online	completed	\N	\N
595	199	463737cc-950b-4a41-8d73-a3daf931fee5	3260.03	2023-01-01 00:00:00+00	online	completed	\N	\N
596	199	463737cc-950b-4a41-8d73-a3daf931fee5	5947.36	2023-02-01 00:00:00+00	online	completed	\N	\N
597	199	463737cc-950b-4a41-8d73-a3daf931fee5	3086.59	2023-03-01 00:00:00+00	online	completed	\N	\N
598	200	dbbbe49c-e100-4576-b406-320908c8873e	2987.73	2023-01-01 00:00:00+00	online	completed	\N	\N
599	200	dbbbe49c-e100-4576-b406-320908c8873e	4508.11	2023-02-01 00:00:00+00	online	completed	\N	\N
600	200	dbbbe49c-e100-4576-b406-320908c8873e	3052.06	2023-03-01 00:00:00+00	online	completed	\N	\N
601	201	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4309.77	2023-01-01 00:00:00+00	online	completed	\N	\N
602	201	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2491.58	2023-02-01 00:00:00+00	online	completed	\N	\N
603	201	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4047.99	2023-03-01 00:00:00+00	online	completed	\N	\N
604	202	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	4012.01	2023-01-01 00:00:00+00	online	completed	\N	\N
605	202	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2692.12	2023-02-01 00:00:00+00	online	completed	\N	\N
606	202	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1807.48	2023-03-01 00:00:00+00	online	completed	\N	\N
607	203	6833f990-6a38-4f28-aa18-e31697fa7dc9	3379.28	2023-01-01 00:00:00+00	online	completed	\N	\N
608	203	6833f990-6a38-4f28-aa18-e31697fa7dc9	3263.38	2023-02-01 00:00:00+00	online	completed	\N	\N
609	203	6833f990-6a38-4f28-aa18-e31697fa7dc9	1579.74	2023-03-01 00:00:00+00	online	completed	\N	\N
610	204	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2164.19	2023-01-01 00:00:00+00	online	completed	\N	\N
611	204	5bf27593-0c3d-489f-bed4-c80dc2936fdf	3184.45	2023-02-01 00:00:00+00	online	completed	\N	\N
612	204	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2916.08	2023-03-01 00:00:00+00	online	completed	\N	\N
613	205	5432f125-2d5e-42ab-849a-29add2cf0a74	5587.03	2023-01-01 00:00:00+00	online	completed	\N	\N
614	205	5432f125-2d5e-42ab-849a-29add2cf0a74	1431.86	2023-02-01 00:00:00+00	online	completed	\N	\N
615	205	5432f125-2d5e-42ab-849a-29add2cf0a74	1626.39	2023-03-01 00:00:00+00	online	completed	\N	\N
616	206	6ac1e176-e710-4b5e-9453-95765db20ba3	2468.94	2023-01-01 00:00:00+00	online	completed	\N	\N
617	206	6ac1e176-e710-4b5e-9453-95765db20ba3	2302.82	2023-02-01 00:00:00+00	online	completed	\N	\N
618	206	6ac1e176-e710-4b5e-9453-95765db20ba3	3092.90	2023-03-01 00:00:00+00	online	completed	\N	\N
619	207	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2484.99	2023-01-01 00:00:00+00	online	completed	\N	\N
620	207	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2463.15	2023-02-01 00:00:00+00	online	completed	\N	\N
621	207	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1168.02	2023-03-01 00:00:00+00	online	completed	\N	\N
622	208	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1095.63	2023-01-01 00:00:00+00	online	completed	\N	\N
623	208	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2741.98	2023-02-01 00:00:00+00	online	completed	\N	\N
624	208	b1f5db31-bfc8-409c-8925-0d21f1c780e6	4424.71	2023-03-01 00:00:00+00	online	completed	\N	\N
625	209	9255fabc-799b-4cc7-8797-5f2470f6adf6	5517.16	2023-01-01 00:00:00+00	online	completed	\N	\N
626	209	9255fabc-799b-4cc7-8797-5f2470f6adf6	2642.92	2023-02-01 00:00:00+00	online	completed	\N	\N
627	209	9255fabc-799b-4cc7-8797-5f2470f6adf6	3867.02	2023-03-01 00:00:00+00	online	completed	\N	\N
628	210	463737cc-950b-4a41-8d73-a3daf931fee5	2546.24	2023-01-01 00:00:00+00	online	completed	\N	\N
629	210	463737cc-950b-4a41-8d73-a3daf931fee5	5526.48	2023-02-01 00:00:00+00	online	completed	\N	\N
630	210	463737cc-950b-4a41-8d73-a3daf931fee5	1331.63	2023-03-01 00:00:00+00	online	completed	\N	\N
631	211	dbbbe49c-e100-4576-b406-320908c8873e	1936.72	2023-01-01 00:00:00+00	online	completed	\N	\N
632	211	dbbbe49c-e100-4576-b406-320908c8873e	4829.15	2023-02-01 00:00:00+00	online	completed	\N	\N
633	211	dbbbe49c-e100-4576-b406-320908c8873e	1435.12	2023-03-01 00:00:00+00	online	completed	\N	\N
634	212	6833f990-6a38-4f28-aa18-e31697fa7dc9	2374.66	2023-01-01 00:00:00+00	online	completed	\N	\N
635	212	6833f990-6a38-4f28-aa18-e31697fa7dc9	4203.80	2023-02-01 00:00:00+00	online	completed	\N	\N
636	212	6833f990-6a38-4f28-aa18-e31697fa7dc9	5648.02	2023-03-01 00:00:00+00	online	completed	\N	\N
637	213	fc7c7272-6d55-49a3-88d7-fc37133a103f	2900.50	2023-01-01 00:00:00+00	online	completed	\N	\N
638	213	fc7c7272-6d55-49a3-88d7-fc37133a103f	5912.82	2023-02-01 00:00:00+00	online	completed	\N	\N
639	213	fc7c7272-6d55-49a3-88d7-fc37133a103f	3642.85	2023-03-01 00:00:00+00	online	completed	\N	\N
640	214	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4347.52	2023-01-01 00:00:00+00	online	completed	\N	\N
641	214	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	5824.89	2023-02-01 00:00:00+00	online	completed	\N	\N
642	214	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3983.79	2023-03-01 00:00:00+00	online	completed	\N	\N
643	215	77e168c1-05e0-4314-8a24-5e838350a3d8	2853.58	2023-01-01 00:00:00+00	online	completed	\N	\N
644	215	77e168c1-05e0-4314-8a24-5e838350a3d8	3588.15	2023-02-01 00:00:00+00	online	completed	\N	\N
645	215	77e168c1-05e0-4314-8a24-5e838350a3d8	1074.82	2023-03-01 00:00:00+00	online	completed	\N	\N
646	216	463737cc-950b-4a41-8d73-a3daf931fee5	1106.15	2023-01-01 00:00:00+00	online	completed	\N	\N
647	216	463737cc-950b-4a41-8d73-a3daf931fee5	1656.67	2023-02-01 00:00:00+00	online	completed	\N	\N
648	216	463737cc-950b-4a41-8d73-a3daf931fee5	4308.42	2023-03-01 00:00:00+00	online	completed	\N	\N
649	217	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5100.27	2023-01-01 00:00:00+00	online	completed	\N	\N
650	217	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5622.60	2023-02-01 00:00:00+00	online	completed	\N	\N
651	217	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5577.41	2023-03-01 00:00:00+00	online	completed	\N	\N
652	218	fc7c7272-6d55-49a3-88d7-fc37133a103f	1308.54	2023-01-01 00:00:00+00	online	completed	\N	\N
653	218	fc7c7272-6d55-49a3-88d7-fc37133a103f	1435.76	2023-02-01 00:00:00+00	online	completed	\N	\N
654	218	fc7c7272-6d55-49a3-88d7-fc37133a103f	5250.34	2023-03-01 00:00:00+00	online	completed	\N	\N
655	219	da6ac18e-72e9-484a-ad75-d044260789cc	1566.90	2023-01-01 00:00:00+00	online	completed	\N	\N
656	219	da6ac18e-72e9-484a-ad75-d044260789cc	1296.43	2023-02-01 00:00:00+00	online	completed	\N	\N
657	219	da6ac18e-72e9-484a-ad75-d044260789cc	2858.15	2023-03-01 00:00:00+00	online	completed	\N	\N
658	220	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2065.73	2023-01-01 00:00:00+00	online	completed	\N	\N
659	220	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4048.80	2023-02-01 00:00:00+00	online	completed	\N	\N
660	220	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1918.63	2023-03-01 00:00:00+00	online	completed	\N	\N
661	221	a602c1a3-89cf-44a4-b419-f6827ad3701b	3165.77	2023-01-01 00:00:00+00	online	completed	\N	\N
662	221	a602c1a3-89cf-44a4-b419-f6827ad3701b	1450.67	2023-02-01 00:00:00+00	online	completed	\N	\N
663	221	a602c1a3-89cf-44a4-b419-f6827ad3701b	3711.59	2023-03-01 00:00:00+00	online	completed	\N	\N
664	222	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	4115.03	2023-01-01 00:00:00+00	online	completed	\N	\N
665	222	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1852.11	2023-02-01 00:00:00+00	online	completed	\N	\N
666	222	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2926.51	2023-03-01 00:00:00+00	online	completed	\N	\N
667	223	da6ac18e-72e9-484a-ad75-d044260789cc	5407.67	2023-01-01 00:00:00+00	online	completed	\N	\N
668	223	da6ac18e-72e9-484a-ad75-d044260789cc	2894.29	2023-02-01 00:00:00+00	online	completed	\N	\N
669	223	da6ac18e-72e9-484a-ad75-d044260789cc	3729.36	2023-03-01 00:00:00+00	online	completed	\N	\N
670	224	bd38508e-8797-4220-ae2e-dd7883b41f17	4713.04	2023-01-01 00:00:00+00	online	completed	\N	\N
671	224	bd38508e-8797-4220-ae2e-dd7883b41f17	4833.77	2023-02-01 00:00:00+00	online	completed	\N	\N
672	224	bd38508e-8797-4220-ae2e-dd7883b41f17	4344.29	2023-03-01 00:00:00+00	online	completed	\N	\N
673	225	a602c1a3-89cf-44a4-b419-f6827ad3701b	2794.31	2023-01-01 00:00:00+00	online	completed	\N	\N
674	225	a602c1a3-89cf-44a4-b419-f6827ad3701b	5426.01	2023-02-01 00:00:00+00	online	completed	\N	\N
675	225	a602c1a3-89cf-44a4-b419-f6827ad3701b	2199.17	2023-03-01 00:00:00+00	online	completed	\N	\N
676	226	da6ac18e-72e9-484a-ad75-d044260789cc	5267.90	2023-01-01 00:00:00+00	online	completed	\N	\N
677	226	da6ac18e-72e9-484a-ad75-d044260789cc	2141.06	2023-02-01 00:00:00+00	online	completed	\N	\N
678	226	da6ac18e-72e9-484a-ad75-d044260789cc	3967.59	2023-03-01 00:00:00+00	online	completed	\N	\N
679	227	51072377-1472-46cb-b180-8542677f5eb2	3103.20	2023-01-01 00:00:00+00	online	completed	\N	\N
680	227	51072377-1472-46cb-b180-8542677f5eb2	3175.07	2023-02-01 00:00:00+00	online	completed	\N	\N
681	227	51072377-1472-46cb-b180-8542677f5eb2	2288.00	2023-03-01 00:00:00+00	online	completed	\N	\N
682	228	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2735.22	2023-01-01 00:00:00+00	online	completed	\N	\N
683	228	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3890.33	2023-02-01 00:00:00+00	online	completed	\N	\N
684	228	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2713.13	2023-03-01 00:00:00+00	online	completed	\N	\N
685	229	584a1909-5797-4297-88d3-06bf5dc3922a	3514.56	2023-01-01 00:00:00+00	online	completed	\N	\N
686	229	584a1909-5797-4297-88d3-06bf5dc3922a	5462.32	2023-02-01 00:00:00+00	online	completed	\N	\N
687	229	584a1909-5797-4297-88d3-06bf5dc3922a	1885.54	2023-03-01 00:00:00+00	online	completed	\N	\N
688	230	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2428.41	2023-01-01 00:00:00+00	online	completed	\N	\N
689	230	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1535.56	2023-02-01 00:00:00+00	online	completed	\N	\N
690	230	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5325.67	2023-03-01 00:00:00+00	online	completed	\N	\N
691	231	463737cc-950b-4a41-8d73-a3daf931fee5	3503.71	2023-01-01 00:00:00+00	online	completed	\N	\N
692	231	463737cc-950b-4a41-8d73-a3daf931fee5	3172.04	2023-02-01 00:00:00+00	online	completed	\N	\N
693	231	463737cc-950b-4a41-8d73-a3daf931fee5	5657.63	2023-03-01 00:00:00+00	online	completed	\N	\N
694	232	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3621.83	2023-01-01 00:00:00+00	online	completed	\N	\N
695	232	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5326.62	2023-02-01 00:00:00+00	online	completed	\N	\N
696	232	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2562.89	2023-03-01 00:00:00+00	online	completed	\N	\N
697	233	1934abf8-eca9-41d8-bc5f-9c649285b76b	3800.92	2023-01-01 00:00:00+00	online	completed	\N	\N
698	233	1934abf8-eca9-41d8-bc5f-9c649285b76b	2510.66	2023-02-01 00:00:00+00	online	completed	\N	\N
699	233	1934abf8-eca9-41d8-bc5f-9c649285b76b	1917.93	2023-03-01 00:00:00+00	online	completed	\N	\N
700	234	51072377-1472-46cb-b180-8542677f5eb2	3749.56	2023-01-01 00:00:00+00	online	completed	\N	\N
701	234	51072377-1472-46cb-b180-8542677f5eb2	5199.20	2023-02-01 00:00:00+00	online	completed	\N	\N
702	234	51072377-1472-46cb-b180-8542677f5eb2	2766.33	2023-03-01 00:00:00+00	online	completed	\N	\N
703	235	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2150.70	2023-01-01 00:00:00+00	online	completed	\N	\N
704	235	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1706.21	2023-02-01 00:00:00+00	online	completed	\N	\N
705	235	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1347.98	2023-03-01 00:00:00+00	online	completed	\N	\N
706	236	dde964d6-6ffa-4b25-97b6-128969afe47c	2900.05	2023-01-01 00:00:00+00	online	completed	\N	\N
707	236	dde964d6-6ffa-4b25-97b6-128969afe47c	5394.82	2023-02-01 00:00:00+00	online	completed	\N	\N
708	236	dde964d6-6ffa-4b25-97b6-128969afe47c	2486.66	2023-03-01 00:00:00+00	online	completed	\N	\N
709	237	5432f125-2d5e-42ab-849a-29add2cf0a74	3861.21	2023-01-01 00:00:00+00	online	completed	\N	\N
710	237	5432f125-2d5e-42ab-849a-29add2cf0a74	1053.82	2023-02-01 00:00:00+00	online	completed	\N	\N
711	237	5432f125-2d5e-42ab-849a-29add2cf0a74	3702.88	2023-03-01 00:00:00+00	online	completed	\N	\N
712	238	5432f125-2d5e-42ab-849a-29add2cf0a74	3672.97	2023-01-01 00:00:00+00	online	completed	\N	\N
713	238	5432f125-2d5e-42ab-849a-29add2cf0a74	1868.81	2023-02-01 00:00:00+00	online	completed	\N	\N
714	238	5432f125-2d5e-42ab-849a-29add2cf0a74	5830.64	2023-03-01 00:00:00+00	online	completed	\N	\N
715	239	a602c1a3-89cf-44a4-b419-f6827ad3701b	4219.47	2023-01-01 00:00:00+00	online	completed	\N	\N
716	239	a602c1a3-89cf-44a4-b419-f6827ad3701b	2803.90	2023-02-01 00:00:00+00	online	completed	\N	\N
717	239	a602c1a3-89cf-44a4-b419-f6827ad3701b	5543.26	2023-03-01 00:00:00+00	online	completed	\N	\N
718	240	ee522e07-1315-4463-8a9b-f890b601c047	3485.43	2023-01-01 00:00:00+00	online	completed	\N	\N
719	240	ee522e07-1315-4463-8a9b-f890b601c047	2474.12	2023-02-01 00:00:00+00	online	completed	\N	\N
720	240	ee522e07-1315-4463-8a9b-f890b601c047	3925.55	2023-03-01 00:00:00+00	online	completed	\N	\N
721	241	1934abf8-eca9-41d8-bc5f-9c649285b76b	4925.47	2023-01-01 00:00:00+00	online	completed	\N	\N
722	241	1934abf8-eca9-41d8-bc5f-9c649285b76b	1100.80	2023-02-01 00:00:00+00	online	completed	\N	\N
723	241	1934abf8-eca9-41d8-bc5f-9c649285b76b	3923.26	2023-03-01 00:00:00+00	online	completed	\N	\N
724	242	6ac1e176-e710-4b5e-9453-95765db20ba3	4029.72	2023-01-01 00:00:00+00	online	completed	\N	\N
725	242	6ac1e176-e710-4b5e-9453-95765db20ba3	1474.30	2023-02-01 00:00:00+00	online	completed	\N	\N
726	242	6ac1e176-e710-4b5e-9453-95765db20ba3	1900.58	2023-03-01 00:00:00+00	online	completed	\N	\N
727	243	51072377-1472-46cb-b180-8542677f5eb2	1728.31	2023-01-01 00:00:00+00	online	completed	\N	\N
728	243	51072377-1472-46cb-b180-8542677f5eb2	2216.35	2023-02-01 00:00:00+00	online	completed	\N	\N
729	243	51072377-1472-46cb-b180-8542677f5eb2	2713.20	2023-03-01 00:00:00+00	online	completed	\N	\N
730	244	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2576.56	2023-01-01 00:00:00+00	online	completed	\N	\N
731	244	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1900.10	2023-02-01 00:00:00+00	online	completed	\N	\N
732	244	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1926.82	2023-03-01 00:00:00+00	online	completed	\N	\N
733	245	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4574.04	2023-01-01 00:00:00+00	online	completed	\N	\N
734	245	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1848.76	2023-02-01 00:00:00+00	online	completed	\N	\N
735	245	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2205.40	2023-03-01 00:00:00+00	online	completed	\N	\N
736	246	6ac1e176-e710-4b5e-9453-95765db20ba3	1314.56	2023-01-01 00:00:00+00	online	completed	\N	\N
737	246	6ac1e176-e710-4b5e-9453-95765db20ba3	2226.56	2023-02-01 00:00:00+00	online	completed	\N	\N
738	246	6ac1e176-e710-4b5e-9453-95765db20ba3	5510.83	2023-03-01 00:00:00+00	online	completed	\N	\N
739	247	bd38508e-8797-4220-ae2e-dd7883b41f17	1672.16	2023-01-01 00:00:00+00	online	completed	\N	\N
740	247	bd38508e-8797-4220-ae2e-dd7883b41f17	2227.16	2023-02-01 00:00:00+00	online	completed	\N	\N
741	247	bd38508e-8797-4220-ae2e-dd7883b41f17	1900.12	2023-03-01 00:00:00+00	online	completed	\N	\N
742	248	77e168c1-05e0-4314-8a24-5e838350a3d8	1537.28	2023-01-01 00:00:00+00	online	completed	\N	\N
743	248	77e168c1-05e0-4314-8a24-5e838350a3d8	2087.43	2023-02-01 00:00:00+00	online	completed	\N	\N
744	248	77e168c1-05e0-4314-8a24-5e838350a3d8	4226.11	2023-03-01 00:00:00+00	online	completed	\N	\N
745	249	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2835.56	2023-01-01 00:00:00+00	online	completed	\N	\N
746	249	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3845.25	2023-02-01 00:00:00+00	online	completed	\N	\N
747	249	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2880.87	2023-03-01 00:00:00+00	online	completed	\N	\N
748	250	51072377-1472-46cb-b180-8542677f5eb2	5917.24	2023-01-01 00:00:00+00	online	completed	\N	\N
749	250	51072377-1472-46cb-b180-8542677f5eb2	4208.54	2023-02-01 00:00:00+00	online	completed	\N	\N
750	250	51072377-1472-46cb-b180-8542677f5eb2	4815.48	2023-03-01 00:00:00+00	online	completed	\N	\N
751	251	77e168c1-05e0-4314-8a24-5e838350a3d8	1883.76	2023-01-01 00:00:00+00	online	completed	\N	\N
752	251	77e168c1-05e0-4314-8a24-5e838350a3d8	3347.16	2023-02-01 00:00:00+00	online	completed	\N	\N
753	251	77e168c1-05e0-4314-8a24-5e838350a3d8	3349.61	2023-03-01 00:00:00+00	online	completed	\N	\N
754	252	1934abf8-eca9-41d8-bc5f-9c649285b76b	5935.35	2023-01-01 00:00:00+00	online	completed	\N	\N
755	252	1934abf8-eca9-41d8-bc5f-9c649285b76b	5864.59	2023-02-01 00:00:00+00	online	completed	\N	\N
756	252	1934abf8-eca9-41d8-bc5f-9c649285b76b	2945.70	2023-03-01 00:00:00+00	online	completed	\N	\N
757	253	8088628d-f77a-430d-b228-cc3649b8a3e1	5596.91	2023-01-01 00:00:00+00	online	completed	\N	\N
758	253	8088628d-f77a-430d-b228-cc3649b8a3e1	2991.64	2023-02-01 00:00:00+00	online	completed	\N	\N
759	253	8088628d-f77a-430d-b228-cc3649b8a3e1	2462.84	2023-03-01 00:00:00+00	online	completed	\N	\N
760	254	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3400.23	2023-01-01 00:00:00+00	online	completed	\N	\N
761	254	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4380.02	2023-02-01 00:00:00+00	online	completed	\N	\N
762	254	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2997.22	2023-03-01 00:00:00+00	online	completed	\N	\N
763	255	dd35da46-4416-412a-8a22-f3f39491bb7b	4677.65	2023-01-01 00:00:00+00	online	completed	\N	\N
764	255	dd35da46-4416-412a-8a22-f3f39491bb7b	5906.59	2023-02-01 00:00:00+00	online	completed	\N	\N
765	255	dd35da46-4416-412a-8a22-f3f39491bb7b	1955.88	2023-03-01 00:00:00+00	online	completed	\N	\N
766	256	cff64755-2065-4e58-866f-f092cbd9e73b	4555.35	2023-01-01 00:00:00+00	online	completed	\N	\N
767	256	cff64755-2065-4e58-866f-f092cbd9e73b	4605.41	2023-02-01 00:00:00+00	online	completed	\N	\N
768	256	cff64755-2065-4e58-866f-f092cbd9e73b	3076.85	2023-03-01 00:00:00+00	online	completed	\N	\N
769	257	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3875.88	2023-01-01 00:00:00+00	online	completed	\N	\N
770	257	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1338.69	2023-02-01 00:00:00+00	online	completed	\N	\N
771	257	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1516.07	2023-03-01 00:00:00+00	online	completed	\N	\N
772	258	8088628d-f77a-430d-b228-cc3649b8a3e1	5452.98	2023-01-01 00:00:00+00	online	completed	\N	\N
773	258	8088628d-f77a-430d-b228-cc3649b8a3e1	3276.23	2023-02-01 00:00:00+00	online	completed	\N	\N
774	258	8088628d-f77a-430d-b228-cc3649b8a3e1	2621.38	2023-03-01 00:00:00+00	online	completed	\N	\N
775	259	51072377-1472-46cb-b180-8542677f5eb2	3060.55	2023-01-01 00:00:00+00	online	completed	\N	\N
776	259	51072377-1472-46cb-b180-8542677f5eb2	5926.01	2023-02-01 00:00:00+00	online	completed	\N	\N
777	259	51072377-1472-46cb-b180-8542677f5eb2	3019.28	2023-03-01 00:00:00+00	online	completed	\N	\N
778	260	77e168c1-05e0-4314-8a24-5e838350a3d8	4608.34	2023-01-01 00:00:00+00	online	completed	\N	\N
779	260	77e168c1-05e0-4314-8a24-5e838350a3d8	1718.91	2023-02-01 00:00:00+00	online	completed	\N	\N
780	260	77e168c1-05e0-4314-8a24-5e838350a3d8	5693.65	2023-03-01 00:00:00+00	online	completed	\N	\N
781	261	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2376.80	2023-01-01 00:00:00+00	online	completed	\N	\N
782	261	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4374.15	2023-02-01 00:00:00+00	online	completed	\N	\N
783	261	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1129.09	2023-03-01 00:00:00+00	online	completed	\N	\N
784	262	5432f125-2d5e-42ab-849a-29add2cf0a74	3898.66	2023-01-01 00:00:00+00	online	completed	\N	\N
785	262	5432f125-2d5e-42ab-849a-29add2cf0a74	3006.34	2023-02-01 00:00:00+00	online	completed	\N	\N
786	262	5432f125-2d5e-42ab-849a-29add2cf0a74	1040.47	2023-03-01 00:00:00+00	online	completed	\N	\N
787	263	ee522e07-1315-4463-8a9b-f890b601c047	4915.79	2023-01-01 00:00:00+00	online	completed	\N	\N
788	263	ee522e07-1315-4463-8a9b-f890b601c047	4127.40	2023-02-01 00:00:00+00	online	completed	\N	\N
789	263	ee522e07-1315-4463-8a9b-f890b601c047	2064.05	2023-03-01 00:00:00+00	online	completed	\N	\N
790	264	b794e95a-97f4-4c05-aa2d-3c13c4155841	5797.23	2023-01-01 00:00:00+00	online	completed	\N	\N
791	264	b794e95a-97f4-4c05-aa2d-3c13c4155841	5936.49	2023-02-01 00:00:00+00	online	completed	\N	\N
792	264	b794e95a-97f4-4c05-aa2d-3c13c4155841	1600.08	2023-03-01 00:00:00+00	online	completed	\N	\N
793	265	584a1909-5797-4297-88d3-06bf5dc3922a	4288.03	2023-01-01 00:00:00+00	online	completed	\N	\N
794	265	584a1909-5797-4297-88d3-06bf5dc3922a	4531.48	2023-02-01 00:00:00+00	online	completed	\N	\N
795	265	584a1909-5797-4297-88d3-06bf5dc3922a	4192.27	2023-03-01 00:00:00+00	online	completed	\N	\N
796	266	5432f125-2d5e-42ab-849a-29add2cf0a74	2681.58	2023-01-01 00:00:00+00	online	completed	\N	\N
797	266	5432f125-2d5e-42ab-849a-29add2cf0a74	3334.62	2023-02-01 00:00:00+00	online	completed	\N	\N
798	266	5432f125-2d5e-42ab-849a-29add2cf0a74	3688.01	2023-03-01 00:00:00+00	online	completed	\N	\N
799	267	ee522e07-1315-4463-8a9b-f890b601c047	2352.04	2023-01-01 00:00:00+00	online	completed	\N	\N
800	267	ee522e07-1315-4463-8a9b-f890b601c047	2547.61	2023-02-01 00:00:00+00	online	completed	\N	\N
801	267	ee522e07-1315-4463-8a9b-f890b601c047	1286.51	2023-03-01 00:00:00+00	online	completed	\N	\N
802	268	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3067.44	2023-01-01 00:00:00+00	online	completed	\N	\N
803	268	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	1034.69	2023-02-01 00:00:00+00	online	completed	\N	\N
804	268	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3261.89	2023-03-01 00:00:00+00	online	completed	\N	\N
805	269	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4479.36	2023-01-01 00:00:00+00	online	completed	\N	\N
806	269	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3890.76	2023-02-01 00:00:00+00	online	completed	\N	\N
807	269	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4784.04	2023-03-01 00:00:00+00	online	completed	\N	\N
808	270	77e168c1-05e0-4314-8a24-5e838350a3d8	2651.55	2023-01-01 00:00:00+00	online	completed	\N	\N
809	270	77e168c1-05e0-4314-8a24-5e838350a3d8	1606.84	2023-02-01 00:00:00+00	online	completed	\N	\N
810	270	77e168c1-05e0-4314-8a24-5e838350a3d8	1624.83	2023-03-01 00:00:00+00	online	completed	\N	\N
811	271	dde964d6-6ffa-4b25-97b6-128969afe47c	4693.86	2023-01-01 00:00:00+00	online	completed	\N	\N
812	271	dde964d6-6ffa-4b25-97b6-128969afe47c	4992.46	2023-02-01 00:00:00+00	online	completed	\N	\N
813	271	dde964d6-6ffa-4b25-97b6-128969afe47c	5080.45	2023-03-01 00:00:00+00	online	completed	\N	\N
814	272	5432f125-2d5e-42ab-849a-29add2cf0a74	2191.77	2023-01-01 00:00:00+00	online	completed	\N	\N
815	272	5432f125-2d5e-42ab-849a-29add2cf0a74	2411.03	2023-02-01 00:00:00+00	online	completed	\N	\N
816	272	5432f125-2d5e-42ab-849a-29add2cf0a74	2870.03	2023-03-01 00:00:00+00	online	completed	\N	\N
817	273	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5463.37	2023-01-01 00:00:00+00	online	completed	\N	\N
818	273	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4143.92	2023-02-01 00:00:00+00	online	completed	\N	\N
819	273	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4844.72	2023-03-01 00:00:00+00	online	completed	\N	\N
820	274	463737cc-950b-4a41-8d73-a3daf931fee5	4002.04	2023-01-01 00:00:00+00	online	completed	\N	\N
821	274	463737cc-950b-4a41-8d73-a3daf931fee5	1073.30	2023-02-01 00:00:00+00	online	completed	\N	\N
822	274	463737cc-950b-4a41-8d73-a3daf931fee5	3146.54	2023-03-01 00:00:00+00	online	completed	\N	\N
823	275	463737cc-950b-4a41-8d73-a3daf931fee5	5452.98	2023-01-01 00:00:00+00	online	completed	\N	\N
824	275	463737cc-950b-4a41-8d73-a3daf931fee5	3285.27	2023-02-01 00:00:00+00	online	completed	\N	\N
825	275	463737cc-950b-4a41-8d73-a3daf931fee5	1330.22	2023-03-01 00:00:00+00	online	completed	\N	\N
826	276	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4394.05	2023-01-01 00:00:00+00	online	completed	\N	\N
827	276	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3210.83	2023-02-01 00:00:00+00	online	completed	\N	\N
828	276	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4295.86	2023-03-01 00:00:00+00	online	completed	\N	\N
829	277	5432f125-2d5e-42ab-849a-29add2cf0a74	3444.63	2023-01-01 00:00:00+00	online	completed	\N	\N
830	277	5432f125-2d5e-42ab-849a-29add2cf0a74	5140.15	2023-02-01 00:00:00+00	online	completed	\N	\N
831	277	5432f125-2d5e-42ab-849a-29add2cf0a74	3615.49	2023-03-01 00:00:00+00	online	completed	\N	\N
832	278	9255fabc-799b-4cc7-8797-5f2470f6adf6	1441.08	2023-01-01 00:00:00+00	online	completed	\N	\N
833	278	9255fabc-799b-4cc7-8797-5f2470f6adf6	5445.44	2023-02-01 00:00:00+00	online	completed	\N	\N
834	278	9255fabc-799b-4cc7-8797-5f2470f6adf6	1702.59	2023-03-01 00:00:00+00	online	completed	\N	\N
835	279	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4454.23	2023-01-01 00:00:00+00	online	completed	\N	\N
836	279	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2276.53	2023-02-01 00:00:00+00	online	completed	\N	\N
837	279	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4567.70	2023-03-01 00:00:00+00	online	completed	\N	\N
838	280	da6ac18e-72e9-484a-ad75-d044260789cc	4709.72	2023-01-01 00:00:00+00	online	completed	\N	\N
839	280	da6ac18e-72e9-484a-ad75-d044260789cc	5319.80	2023-02-01 00:00:00+00	online	completed	\N	\N
840	280	da6ac18e-72e9-484a-ad75-d044260789cc	5962.09	2023-03-01 00:00:00+00	online	completed	\N	\N
841	281	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5045.28	2023-01-01 00:00:00+00	online	completed	\N	\N
842	281	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5350.95	2023-02-01 00:00:00+00	online	completed	\N	\N
843	281	5bf27593-0c3d-489f-bed4-c80dc2936fdf	3057.08	2023-03-01 00:00:00+00	online	completed	\N	\N
844	282	a602c1a3-89cf-44a4-b419-f6827ad3701b	4497.58	2023-01-01 00:00:00+00	online	completed	\N	\N
845	282	a602c1a3-89cf-44a4-b419-f6827ad3701b	1519.91	2023-02-01 00:00:00+00	online	completed	\N	\N
846	282	a602c1a3-89cf-44a4-b419-f6827ad3701b	4938.46	2023-03-01 00:00:00+00	online	completed	\N	\N
847	283	ee522e07-1315-4463-8a9b-f890b601c047	5921.58	2023-01-01 00:00:00+00	online	completed	\N	\N
848	283	ee522e07-1315-4463-8a9b-f890b601c047	2432.82	2023-02-01 00:00:00+00	online	completed	\N	\N
849	283	ee522e07-1315-4463-8a9b-f890b601c047	3022.49	2023-03-01 00:00:00+00	online	completed	\N	\N
850	284	dbbbe49c-e100-4576-b406-320908c8873e	3430.00	2023-01-01 00:00:00+00	online	completed	\N	\N
851	284	dbbbe49c-e100-4576-b406-320908c8873e	1112.38	2023-02-01 00:00:00+00	online	completed	\N	\N
852	284	dbbbe49c-e100-4576-b406-320908c8873e	3701.09	2023-03-01 00:00:00+00	online	completed	\N	\N
853	285	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3595.01	2023-01-01 00:00:00+00	online	completed	\N	\N
854	285	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	5315.62	2023-02-01 00:00:00+00	online	completed	\N	\N
855	285	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	5484.70	2023-03-01 00:00:00+00	online	completed	\N	\N
856	286	a602c1a3-89cf-44a4-b419-f6827ad3701b	1923.56	2023-01-01 00:00:00+00	online	completed	\N	\N
857	286	a602c1a3-89cf-44a4-b419-f6827ad3701b	3641.61	2023-02-01 00:00:00+00	online	completed	\N	\N
858	286	a602c1a3-89cf-44a4-b419-f6827ad3701b	3940.58	2023-03-01 00:00:00+00	online	completed	\N	\N
859	287	6833f990-6a38-4f28-aa18-e31697fa7dc9	5937.04	2023-01-01 00:00:00+00	online	completed	\N	\N
860	287	6833f990-6a38-4f28-aa18-e31697fa7dc9	4237.15	2023-02-01 00:00:00+00	online	completed	\N	\N
861	287	6833f990-6a38-4f28-aa18-e31697fa7dc9	4494.01	2023-03-01 00:00:00+00	online	completed	\N	\N
862	288	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3946.72	2023-01-01 00:00:00+00	online	completed	\N	\N
863	288	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	4399.22	2023-02-01 00:00:00+00	online	completed	\N	\N
864	288	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3341.64	2023-03-01 00:00:00+00	online	completed	\N	\N
865	289	ee522e07-1315-4463-8a9b-f890b601c047	4469.24	2023-01-01 00:00:00+00	online	completed	\N	\N
866	289	ee522e07-1315-4463-8a9b-f890b601c047	4515.09	2023-02-01 00:00:00+00	online	completed	\N	\N
867	289	ee522e07-1315-4463-8a9b-f890b601c047	1618.55	2023-03-01 00:00:00+00	online	completed	\N	\N
868	290	bd38508e-8797-4220-ae2e-dd7883b41f17	2624.36	2023-01-01 00:00:00+00	online	completed	\N	\N
869	290	bd38508e-8797-4220-ae2e-dd7883b41f17	4579.92	2023-02-01 00:00:00+00	online	completed	\N	\N
870	290	bd38508e-8797-4220-ae2e-dd7883b41f17	5557.13	2023-03-01 00:00:00+00	online	completed	\N	\N
871	291	8088628d-f77a-430d-b228-cc3649b8a3e1	1070.47	2023-01-01 00:00:00+00	online	completed	\N	\N
872	291	8088628d-f77a-430d-b228-cc3649b8a3e1	5845.98	2023-02-01 00:00:00+00	online	completed	\N	\N
873	291	8088628d-f77a-430d-b228-cc3649b8a3e1	3278.65	2023-03-01 00:00:00+00	online	completed	\N	\N
874	292	b794e95a-97f4-4c05-aa2d-3c13c4155841	3596.67	2023-01-01 00:00:00+00	online	completed	\N	\N
875	292	b794e95a-97f4-4c05-aa2d-3c13c4155841	1382.19	2023-02-01 00:00:00+00	online	completed	\N	\N
876	292	b794e95a-97f4-4c05-aa2d-3c13c4155841	3440.05	2023-03-01 00:00:00+00	online	completed	\N	\N
877	293	77e168c1-05e0-4314-8a24-5e838350a3d8	3922.64	2023-01-01 00:00:00+00	online	completed	\N	\N
878	293	77e168c1-05e0-4314-8a24-5e838350a3d8	3459.38	2023-02-01 00:00:00+00	online	completed	\N	\N
879	293	77e168c1-05e0-4314-8a24-5e838350a3d8	3636.08	2023-03-01 00:00:00+00	online	completed	\N	\N
880	294	51072377-1472-46cb-b180-8542677f5eb2	5311.91	2023-01-01 00:00:00+00	online	completed	\N	\N
881	294	51072377-1472-46cb-b180-8542677f5eb2	2705.80	2023-02-01 00:00:00+00	online	completed	\N	\N
882	294	51072377-1472-46cb-b180-8542677f5eb2	3025.57	2023-03-01 00:00:00+00	online	completed	\N	\N
883	295	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3493.65	2023-01-01 00:00:00+00	online	completed	\N	\N
884	295	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4491.20	2023-02-01 00:00:00+00	online	completed	\N	\N
885	295	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4286.05	2023-03-01 00:00:00+00	online	completed	\N	\N
886	296	51072377-1472-46cb-b180-8542677f5eb2	2834.76	2023-01-01 00:00:00+00	online	completed	\N	\N
887	296	51072377-1472-46cb-b180-8542677f5eb2	1504.43	2023-02-01 00:00:00+00	online	completed	\N	\N
888	296	51072377-1472-46cb-b180-8542677f5eb2	3428.61	2023-03-01 00:00:00+00	online	completed	\N	\N
889	297	6833f990-6a38-4f28-aa18-e31697fa7dc9	4343.90	2023-01-01 00:00:00+00	online	completed	\N	\N
890	297	6833f990-6a38-4f28-aa18-e31697fa7dc9	1628.69	2023-02-01 00:00:00+00	online	completed	\N	\N
891	297	6833f990-6a38-4f28-aa18-e31697fa7dc9	4832.12	2023-03-01 00:00:00+00	online	completed	\N	\N
892	298	a602c1a3-89cf-44a4-b419-f6827ad3701b	2280.20	2023-01-01 00:00:00+00	online	completed	\N	\N
893	298	a602c1a3-89cf-44a4-b419-f6827ad3701b	3125.10	2023-02-01 00:00:00+00	online	completed	\N	\N
894	298	a602c1a3-89cf-44a4-b419-f6827ad3701b	2709.91	2023-03-01 00:00:00+00	online	completed	\N	\N
895	299	cff64755-2065-4e58-866f-f092cbd9e73b	4416.02	2023-01-01 00:00:00+00	online	completed	\N	\N
896	299	cff64755-2065-4e58-866f-f092cbd9e73b	4885.03	2023-02-01 00:00:00+00	online	completed	\N	\N
897	299	cff64755-2065-4e58-866f-f092cbd9e73b	1848.32	2023-03-01 00:00:00+00	online	completed	\N	\N
898	300	9255fabc-799b-4cc7-8797-5f2470f6adf6	2980.70	2023-01-01 00:00:00+00	online	completed	\N	\N
899	300	9255fabc-799b-4cc7-8797-5f2470f6adf6	1377.85	2023-02-01 00:00:00+00	online	completed	\N	\N
900	300	9255fabc-799b-4cc7-8797-5f2470f6adf6	1740.74	2023-03-01 00:00:00+00	online	completed	\N	\N
901	301	a83848ba-0779-4fac-98ee-f5f459b2742b	4952.92	2023-01-01 00:00:00+00	online	completed	\N	\N
902	301	a83848ba-0779-4fac-98ee-f5f459b2742b	5555.38	2023-02-01 00:00:00+00	online	completed	\N	\N
903	301	a83848ba-0779-4fac-98ee-f5f459b2742b	3102.67	2023-03-01 00:00:00+00	online	completed	\N	\N
904	302	77e168c1-05e0-4314-8a24-5e838350a3d8	1888.76	2023-01-01 00:00:00+00	online	completed	\N	\N
905	302	77e168c1-05e0-4314-8a24-5e838350a3d8	5602.58	2023-02-01 00:00:00+00	online	completed	\N	\N
906	302	77e168c1-05e0-4314-8a24-5e838350a3d8	2864.69	2023-03-01 00:00:00+00	online	completed	\N	\N
907	303	77e168c1-05e0-4314-8a24-5e838350a3d8	2573.77	2023-01-01 00:00:00+00	online	completed	\N	\N
908	303	77e168c1-05e0-4314-8a24-5e838350a3d8	5540.07	2023-02-01 00:00:00+00	online	completed	\N	\N
909	303	77e168c1-05e0-4314-8a24-5e838350a3d8	4311.84	2023-03-01 00:00:00+00	online	completed	\N	\N
910	304	584a1909-5797-4297-88d3-06bf5dc3922a	1266.05	2023-01-01 00:00:00+00	online	completed	\N	\N
911	304	584a1909-5797-4297-88d3-06bf5dc3922a	1628.92	2023-02-01 00:00:00+00	online	completed	\N	\N
912	304	584a1909-5797-4297-88d3-06bf5dc3922a	1882.70	2023-03-01 00:00:00+00	online	completed	\N	\N
913	305	77e168c1-05e0-4314-8a24-5e838350a3d8	3681.23	2023-01-01 00:00:00+00	online	completed	\N	\N
914	305	77e168c1-05e0-4314-8a24-5e838350a3d8	5619.56	2023-02-01 00:00:00+00	online	completed	\N	\N
915	305	77e168c1-05e0-4314-8a24-5e838350a3d8	4765.51	2023-03-01 00:00:00+00	online	completed	\N	\N
916	306	9255fabc-799b-4cc7-8797-5f2470f6adf6	5467.87	2023-01-01 00:00:00+00	online	completed	\N	\N
917	306	9255fabc-799b-4cc7-8797-5f2470f6adf6	2447.71	2023-02-01 00:00:00+00	online	completed	\N	\N
918	306	9255fabc-799b-4cc7-8797-5f2470f6adf6	4641.97	2023-03-01 00:00:00+00	online	completed	\N	\N
919	307	6ac1e176-e710-4b5e-9453-95765db20ba3	4146.04	2023-01-01 00:00:00+00	online	completed	\N	\N
920	307	6ac1e176-e710-4b5e-9453-95765db20ba3	4104.19	2023-02-01 00:00:00+00	online	completed	\N	\N
921	307	6ac1e176-e710-4b5e-9453-95765db20ba3	4517.68	2023-03-01 00:00:00+00	online	completed	\N	\N
922	308	bd38508e-8797-4220-ae2e-dd7883b41f17	3224.35	2023-01-01 00:00:00+00	online	completed	\N	\N
923	308	bd38508e-8797-4220-ae2e-dd7883b41f17	2315.16	2023-02-01 00:00:00+00	online	completed	\N	\N
924	308	bd38508e-8797-4220-ae2e-dd7883b41f17	1858.70	2023-03-01 00:00:00+00	online	completed	\N	\N
925	309	da6ac18e-72e9-484a-ad75-d044260789cc	4671.07	2023-01-01 00:00:00+00	online	completed	\N	\N
926	309	da6ac18e-72e9-484a-ad75-d044260789cc	1158.35	2023-02-01 00:00:00+00	online	completed	\N	\N
927	309	da6ac18e-72e9-484a-ad75-d044260789cc	3487.87	2023-03-01 00:00:00+00	online	completed	\N	\N
928	310	77e168c1-05e0-4314-8a24-5e838350a3d8	5291.32	2023-01-01 00:00:00+00	online	completed	\N	\N
929	310	77e168c1-05e0-4314-8a24-5e838350a3d8	3836.27	2023-02-01 00:00:00+00	online	completed	\N	\N
930	310	77e168c1-05e0-4314-8a24-5e838350a3d8	2445.59	2023-03-01 00:00:00+00	online	completed	\N	\N
931	311	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4215.39	2023-01-01 00:00:00+00	online	completed	\N	\N
932	311	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3542.09	2023-02-01 00:00:00+00	online	completed	\N	\N
933	311	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4479.76	2023-03-01 00:00:00+00	online	completed	\N	\N
934	312	51072377-1472-46cb-b180-8542677f5eb2	3599.91	2023-01-01 00:00:00+00	online	completed	\N	\N
935	312	51072377-1472-46cb-b180-8542677f5eb2	3018.74	2023-02-01 00:00:00+00	online	completed	\N	\N
936	312	51072377-1472-46cb-b180-8542677f5eb2	3490.81	2023-03-01 00:00:00+00	online	completed	\N	\N
937	313	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2173.65	2023-01-01 00:00:00+00	online	completed	\N	\N
938	313	5bf27593-0c3d-489f-bed4-c80dc2936fdf	3362.42	2023-02-01 00:00:00+00	online	completed	\N	\N
939	313	5bf27593-0c3d-489f-bed4-c80dc2936fdf	3459.16	2023-03-01 00:00:00+00	online	completed	\N	\N
940	314	584a1909-5797-4297-88d3-06bf5dc3922a	5204.20	2023-01-01 00:00:00+00	online	completed	\N	\N
941	314	584a1909-5797-4297-88d3-06bf5dc3922a	4684.16	2023-02-01 00:00:00+00	online	completed	\N	\N
942	314	584a1909-5797-4297-88d3-06bf5dc3922a	1961.33	2023-03-01 00:00:00+00	online	completed	\N	\N
943	315	9255fabc-799b-4cc7-8797-5f2470f6adf6	5127.95	2023-01-01 00:00:00+00	online	completed	\N	\N
944	315	9255fabc-799b-4cc7-8797-5f2470f6adf6	2432.72	2023-02-01 00:00:00+00	online	completed	\N	\N
945	315	9255fabc-799b-4cc7-8797-5f2470f6adf6	4992.83	2023-03-01 00:00:00+00	online	completed	\N	\N
946	316	6ac1e176-e710-4b5e-9453-95765db20ba3	1326.15	2023-01-01 00:00:00+00	online	completed	\N	\N
947	316	6ac1e176-e710-4b5e-9453-95765db20ba3	5869.12	2023-02-01 00:00:00+00	online	completed	\N	\N
948	316	6ac1e176-e710-4b5e-9453-95765db20ba3	4423.59	2023-03-01 00:00:00+00	online	completed	\N	\N
949	317	dde964d6-6ffa-4b25-97b6-128969afe47c	5051.01	2023-01-01 00:00:00+00	online	completed	\N	\N
950	317	dde964d6-6ffa-4b25-97b6-128969afe47c	3585.37	2023-02-01 00:00:00+00	online	completed	\N	\N
951	317	dde964d6-6ffa-4b25-97b6-128969afe47c	3661.29	2023-03-01 00:00:00+00	online	completed	\N	\N
952	318	b794e95a-97f4-4c05-aa2d-3c13c4155841	5947.86	2023-01-01 00:00:00+00	online	completed	\N	\N
953	318	b794e95a-97f4-4c05-aa2d-3c13c4155841	4454.70	2023-02-01 00:00:00+00	online	completed	\N	\N
954	318	b794e95a-97f4-4c05-aa2d-3c13c4155841	2796.76	2023-03-01 00:00:00+00	online	completed	\N	\N
955	319	51072377-1472-46cb-b180-8542677f5eb2	3340.54	2023-01-01 00:00:00+00	online	completed	\N	\N
956	319	51072377-1472-46cb-b180-8542677f5eb2	3162.70	2023-02-01 00:00:00+00	online	completed	\N	\N
957	319	51072377-1472-46cb-b180-8542677f5eb2	4541.68	2023-03-01 00:00:00+00	online	completed	\N	\N
958	320	bd38508e-8797-4220-ae2e-dd7883b41f17	4691.16	2023-01-01 00:00:00+00	online	completed	\N	\N
959	320	bd38508e-8797-4220-ae2e-dd7883b41f17	4652.70	2023-02-01 00:00:00+00	online	completed	\N	\N
960	320	bd38508e-8797-4220-ae2e-dd7883b41f17	4487.47	2023-03-01 00:00:00+00	online	completed	\N	\N
961	321	9255fabc-799b-4cc7-8797-5f2470f6adf6	2334.64	2023-01-01 00:00:00+00	online	completed	\N	\N
962	321	9255fabc-799b-4cc7-8797-5f2470f6adf6	5156.18	2023-02-01 00:00:00+00	online	completed	\N	\N
963	321	9255fabc-799b-4cc7-8797-5f2470f6adf6	1391.56	2023-03-01 00:00:00+00	online	completed	\N	\N
964	322	77e168c1-05e0-4314-8a24-5e838350a3d8	3252.53	2023-01-01 00:00:00+00	online	completed	\N	\N
965	322	77e168c1-05e0-4314-8a24-5e838350a3d8	4302.95	2023-02-01 00:00:00+00	online	completed	\N	\N
966	322	77e168c1-05e0-4314-8a24-5e838350a3d8	2899.56	2023-03-01 00:00:00+00	online	completed	\N	\N
967	323	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2839.98	2023-01-01 00:00:00+00	online	completed	\N	\N
968	323	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1047.26	2023-02-01 00:00:00+00	online	completed	\N	\N
969	323	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4000.19	2023-03-01 00:00:00+00	online	completed	\N	\N
970	324	cff64755-2065-4e58-866f-f092cbd9e73b	5212.83	2023-01-01 00:00:00+00	online	completed	\N	\N
971	324	cff64755-2065-4e58-866f-f092cbd9e73b	4429.19	2023-02-01 00:00:00+00	online	completed	\N	\N
972	324	cff64755-2065-4e58-866f-f092cbd9e73b	3362.62	2023-03-01 00:00:00+00	online	completed	\N	\N
973	325	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5070.38	2023-01-01 00:00:00+00	online	completed	\N	\N
974	325	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3291.25	2023-02-01 00:00:00+00	online	completed	\N	\N
975	325	fd99f59b-fcc6-42ef-a407-207f110f2d7b	1889.91	2023-03-01 00:00:00+00	online	completed	\N	\N
976	326	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2299.36	2023-01-01 00:00:00+00	online	completed	\N	\N
977	326	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3028.65	2023-02-01 00:00:00+00	online	completed	\N	\N
978	326	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5455.17	2023-03-01 00:00:00+00	online	completed	\N	\N
979	327	584a1909-5797-4297-88d3-06bf5dc3922a	2276.90	2023-01-01 00:00:00+00	online	completed	\N	\N
980	327	584a1909-5797-4297-88d3-06bf5dc3922a	3935.79	2023-02-01 00:00:00+00	online	completed	\N	\N
981	327	584a1909-5797-4297-88d3-06bf5dc3922a	3844.42	2023-03-01 00:00:00+00	online	completed	\N	\N
982	328	dd35da46-4416-412a-8a22-f3f39491bb7b	4864.55	2023-01-01 00:00:00+00	online	completed	\N	\N
983	328	dd35da46-4416-412a-8a22-f3f39491bb7b	1179.72	2023-02-01 00:00:00+00	online	completed	\N	\N
984	328	dd35da46-4416-412a-8a22-f3f39491bb7b	2868.12	2023-03-01 00:00:00+00	online	completed	\N	\N
985	329	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1600.19	2023-01-01 00:00:00+00	online	completed	\N	\N
986	329	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3333.13	2023-02-01 00:00:00+00	online	completed	\N	\N
987	329	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5001.74	2023-03-01 00:00:00+00	online	completed	\N	\N
988	330	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3057.79	2023-01-01 00:00:00+00	online	completed	\N	\N
989	330	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2837.33	2023-02-01 00:00:00+00	online	completed	\N	\N
990	330	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2145.57	2023-03-01 00:00:00+00	online	completed	\N	\N
991	331	a602c1a3-89cf-44a4-b419-f6827ad3701b	4338.62	2023-01-01 00:00:00+00	online	completed	\N	\N
992	331	a602c1a3-89cf-44a4-b419-f6827ad3701b	3720.57	2023-02-01 00:00:00+00	online	completed	\N	\N
993	331	a602c1a3-89cf-44a4-b419-f6827ad3701b	2446.14	2023-03-01 00:00:00+00	online	completed	\N	\N
994	332	51072377-1472-46cb-b180-8542677f5eb2	5378.37	2023-01-01 00:00:00+00	online	completed	\N	\N
995	332	51072377-1472-46cb-b180-8542677f5eb2	1690.21	2023-02-01 00:00:00+00	online	completed	\N	\N
996	332	51072377-1472-46cb-b180-8542677f5eb2	2664.67	2023-03-01 00:00:00+00	online	completed	\N	\N
997	333	dbbbe49c-e100-4576-b406-320908c8873e	5567.21	2023-01-01 00:00:00+00	online	completed	\N	\N
998	333	dbbbe49c-e100-4576-b406-320908c8873e	1089.48	2023-02-01 00:00:00+00	online	completed	\N	\N
999	333	dbbbe49c-e100-4576-b406-320908c8873e	5130.19	2023-03-01 00:00:00+00	online	completed	\N	\N
1000	334	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1116.91	2023-01-01 00:00:00+00	online	completed	\N	\N
1001	334	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2123.02	2023-02-01 00:00:00+00	online	completed	\N	\N
1002	334	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5988.33	2023-03-01 00:00:00+00	online	completed	\N	\N
1003	335	b794e95a-97f4-4c05-aa2d-3c13c4155841	1233.11	2023-01-01 00:00:00+00	online	completed	\N	\N
1004	335	b794e95a-97f4-4c05-aa2d-3c13c4155841	1355.36	2023-02-01 00:00:00+00	online	completed	\N	\N
1005	335	b794e95a-97f4-4c05-aa2d-3c13c4155841	4283.42	2023-03-01 00:00:00+00	online	completed	\N	\N
1006	336	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2464.79	2023-01-01 00:00:00+00	online	completed	\N	\N
1007	336	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4043.32	2023-02-01 00:00:00+00	online	completed	\N	\N
1008	336	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2095.23	2023-03-01 00:00:00+00	online	completed	\N	\N
1009	337	a602c1a3-89cf-44a4-b419-f6827ad3701b	3184.38	2023-01-01 00:00:00+00	online	completed	\N	\N
1010	337	a602c1a3-89cf-44a4-b419-f6827ad3701b	2084.73	2023-02-01 00:00:00+00	online	completed	\N	\N
1011	337	a602c1a3-89cf-44a4-b419-f6827ad3701b	3207.01	2023-03-01 00:00:00+00	online	completed	\N	\N
1012	338	387d98f7-ccf9-4077-8f79-f0be51c40d05	4417.18	2023-01-01 00:00:00+00	online	completed	\N	\N
1013	338	387d98f7-ccf9-4077-8f79-f0be51c40d05	4831.98	2023-02-01 00:00:00+00	online	completed	\N	\N
1014	338	387d98f7-ccf9-4077-8f79-f0be51c40d05	4785.46	2023-03-01 00:00:00+00	online	completed	\N	\N
1015	339	8088628d-f77a-430d-b228-cc3649b8a3e1	5931.99	2023-01-01 00:00:00+00	online	completed	\N	\N
1016	339	8088628d-f77a-430d-b228-cc3649b8a3e1	3786.73	2023-02-01 00:00:00+00	online	completed	\N	\N
1017	339	8088628d-f77a-430d-b228-cc3649b8a3e1	2753.57	2023-03-01 00:00:00+00	online	completed	\N	\N
1018	340	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2569.79	2023-01-01 00:00:00+00	online	completed	\N	\N
1019	340	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3006.79	2023-02-01 00:00:00+00	online	completed	\N	\N
1020	340	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2682.63	2023-03-01 00:00:00+00	online	completed	\N	\N
1021	341	387d98f7-ccf9-4077-8f79-f0be51c40d05	4485.08	2023-01-01 00:00:00+00	online	completed	\N	\N
1022	341	387d98f7-ccf9-4077-8f79-f0be51c40d05	3146.47	2023-02-01 00:00:00+00	online	completed	\N	\N
1023	341	387d98f7-ccf9-4077-8f79-f0be51c40d05	4172.19	2023-03-01 00:00:00+00	online	completed	\N	\N
1024	342	387d98f7-ccf9-4077-8f79-f0be51c40d05	1313.74	2023-01-01 00:00:00+00	online	completed	\N	\N
1025	342	387d98f7-ccf9-4077-8f79-f0be51c40d05	1290.96	2023-02-01 00:00:00+00	online	completed	\N	\N
1026	342	387d98f7-ccf9-4077-8f79-f0be51c40d05	2606.40	2023-03-01 00:00:00+00	online	completed	\N	\N
1027	343	a602c1a3-89cf-44a4-b419-f6827ad3701b	1577.36	2023-01-01 00:00:00+00	online	completed	\N	\N
1028	343	a602c1a3-89cf-44a4-b419-f6827ad3701b	5120.14	2023-02-01 00:00:00+00	online	completed	\N	\N
1029	343	a602c1a3-89cf-44a4-b419-f6827ad3701b	3883.82	2023-03-01 00:00:00+00	online	completed	\N	\N
1030	344	77e168c1-05e0-4314-8a24-5e838350a3d8	4768.81	2023-01-01 00:00:00+00	online	completed	\N	\N
1031	344	77e168c1-05e0-4314-8a24-5e838350a3d8	3141.60	2023-02-01 00:00:00+00	online	completed	\N	\N
1032	344	77e168c1-05e0-4314-8a24-5e838350a3d8	2059.95	2023-03-01 00:00:00+00	online	completed	\N	\N
1033	345	b1f5db31-bfc8-409c-8925-0d21f1c780e6	4406.98	2023-01-01 00:00:00+00	online	completed	\N	\N
1034	345	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3087.34	2023-02-01 00:00:00+00	online	completed	\N	\N
1035	345	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3030.19	2023-03-01 00:00:00+00	online	completed	\N	\N
1036	346	bd38508e-8797-4220-ae2e-dd7883b41f17	3961.89	2023-01-01 00:00:00+00	online	completed	\N	\N
1037	346	bd38508e-8797-4220-ae2e-dd7883b41f17	1590.61	2023-02-01 00:00:00+00	online	completed	\N	\N
1038	346	bd38508e-8797-4220-ae2e-dd7883b41f17	2200.04	2023-03-01 00:00:00+00	online	completed	\N	\N
1039	347	cff64755-2065-4e58-866f-f092cbd9e73b	3438.33	2023-01-01 00:00:00+00	online	completed	\N	\N
1040	347	cff64755-2065-4e58-866f-f092cbd9e73b	4891.20	2023-02-01 00:00:00+00	online	completed	\N	\N
1041	347	cff64755-2065-4e58-866f-f092cbd9e73b	5982.79	2023-03-01 00:00:00+00	online	completed	\N	\N
1042	348	dde964d6-6ffa-4b25-97b6-128969afe47c	4396.44	2023-01-01 00:00:00+00	online	completed	\N	\N
1043	348	dde964d6-6ffa-4b25-97b6-128969afe47c	5532.29	2023-02-01 00:00:00+00	online	completed	\N	\N
1044	348	dde964d6-6ffa-4b25-97b6-128969afe47c	4349.31	2023-03-01 00:00:00+00	online	completed	\N	\N
1045	349	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4368.75	2023-01-01 00:00:00+00	online	completed	\N	\N
1046	349	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4422.05	2023-02-01 00:00:00+00	online	completed	\N	\N
1047	349	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2006.57	2023-03-01 00:00:00+00	online	completed	\N	\N
1048	350	6ac1e176-e710-4b5e-9453-95765db20ba3	5057.59	2023-01-01 00:00:00+00	online	completed	\N	\N
1049	350	6ac1e176-e710-4b5e-9453-95765db20ba3	5188.93	2023-02-01 00:00:00+00	online	completed	\N	\N
1050	350	6ac1e176-e710-4b5e-9453-95765db20ba3	4901.93	2023-03-01 00:00:00+00	online	completed	\N	\N
1051	351	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4324.16	2023-01-01 00:00:00+00	online	completed	\N	\N
1052	351	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	1914.16	2023-02-01 00:00:00+00	online	completed	\N	\N
1053	351	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	5192.26	2023-03-01 00:00:00+00	online	completed	\N	\N
1054	352	ee522e07-1315-4463-8a9b-f890b601c047	1485.45	2023-01-01 00:00:00+00	online	completed	\N	\N
1055	352	ee522e07-1315-4463-8a9b-f890b601c047	1613.43	2023-02-01 00:00:00+00	online	completed	\N	\N
1056	352	ee522e07-1315-4463-8a9b-f890b601c047	2492.79	2023-03-01 00:00:00+00	online	completed	\N	\N
1057	353	463737cc-950b-4a41-8d73-a3daf931fee5	3808.93	2023-01-01 00:00:00+00	online	completed	\N	\N
1058	353	463737cc-950b-4a41-8d73-a3daf931fee5	2882.45	2023-02-01 00:00:00+00	online	completed	\N	\N
1059	353	463737cc-950b-4a41-8d73-a3daf931fee5	4830.57	2023-03-01 00:00:00+00	online	completed	\N	\N
1060	354	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5365.07	2023-01-01 00:00:00+00	online	completed	\N	\N
1061	354	5bf27593-0c3d-489f-bed4-c80dc2936fdf	3885.57	2023-02-01 00:00:00+00	online	completed	\N	\N
1062	354	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1126.96	2023-03-01 00:00:00+00	online	completed	\N	\N
1063	355	fc7c7272-6d55-49a3-88d7-fc37133a103f	5398.74	2023-01-01 00:00:00+00	online	completed	\N	\N
1064	355	fc7c7272-6d55-49a3-88d7-fc37133a103f	1974.10	2023-02-01 00:00:00+00	online	completed	\N	\N
1065	355	fc7c7272-6d55-49a3-88d7-fc37133a103f	3994.66	2023-03-01 00:00:00+00	online	completed	\N	\N
1066	356	1934abf8-eca9-41d8-bc5f-9c649285b76b	2821.36	2023-01-01 00:00:00+00	online	completed	\N	\N
1067	356	1934abf8-eca9-41d8-bc5f-9c649285b76b	4133.69	2023-02-01 00:00:00+00	online	completed	\N	\N
1068	356	1934abf8-eca9-41d8-bc5f-9c649285b76b	3857.08	2023-03-01 00:00:00+00	online	completed	\N	\N
1069	357	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3021.10	2023-01-01 00:00:00+00	online	completed	\N	\N
1070	357	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4430.04	2023-02-01 00:00:00+00	online	completed	\N	\N
1071	357	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4146.68	2023-03-01 00:00:00+00	online	completed	\N	\N
1072	358	584a1909-5797-4297-88d3-06bf5dc3922a	3926.00	2023-01-01 00:00:00+00	online	completed	\N	\N
1073	358	584a1909-5797-4297-88d3-06bf5dc3922a	5150.11	2023-02-01 00:00:00+00	online	completed	\N	\N
1074	358	584a1909-5797-4297-88d3-06bf5dc3922a	1190.61	2023-03-01 00:00:00+00	online	completed	\N	\N
1075	359	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3393.40	2023-01-01 00:00:00+00	online	completed	\N	\N
1076	359	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3201.05	2023-02-01 00:00:00+00	online	completed	\N	\N
1077	359	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2936.25	2023-03-01 00:00:00+00	online	completed	\N	\N
1078	360	dde964d6-6ffa-4b25-97b6-128969afe47c	1537.66	2023-01-01 00:00:00+00	online	completed	\N	\N
1079	360	dde964d6-6ffa-4b25-97b6-128969afe47c	4432.54	2023-02-01 00:00:00+00	online	completed	\N	\N
1080	360	dde964d6-6ffa-4b25-97b6-128969afe47c	2070.74	2023-03-01 00:00:00+00	online	completed	\N	\N
1081	361	dbbbe49c-e100-4576-b406-320908c8873e	1581.91	2023-01-01 00:00:00+00	online	completed	\N	\N
1082	361	dbbbe49c-e100-4576-b406-320908c8873e	2962.57	2023-02-01 00:00:00+00	online	completed	\N	\N
1083	361	dbbbe49c-e100-4576-b406-320908c8873e	3750.24	2023-03-01 00:00:00+00	online	completed	\N	\N
1084	362	fc7c7272-6d55-49a3-88d7-fc37133a103f	4966.40	2023-01-01 00:00:00+00	online	completed	\N	\N
1085	362	fc7c7272-6d55-49a3-88d7-fc37133a103f	2181.42	2023-02-01 00:00:00+00	online	completed	\N	\N
1086	362	fc7c7272-6d55-49a3-88d7-fc37133a103f	5643.91	2023-03-01 00:00:00+00	online	completed	\N	\N
1087	363	5432f125-2d5e-42ab-849a-29add2cf0a74	4593.37	2023-01-01 00:00:00+00	online	completed	\N	\N
1088	363	5432f125-2d5e-42ab-849a-29add2cf0a74	3896.49	2023-02-01 00:00:00+00	online	completed	\N	\N
1089	363	5432f125-2d5e-42ab-849a-29add2cf0a74	4327.75	2023-03-01 00:00:00+00	online	completed	\N	\N
1090	364	a602c1a3-89cf-44a4-b419-f6827ad3701b	1900.09	2023-01-01 00:00:00+00	online	completed	\N	\N
1091	364	a602c1a3-89cf-44a4-b419-f6827ad3701b	3752.94	2023-02-01 00:00:00+00	online	completed	\N	\N
1092	364	a602c1a3-89cf-44a4-b419-f6827ad3701b	2758.05	2023-03-01 00:00:00+00	online	completed	\N	\N
1093	365	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	5127.59	2023-01-01 00:00:00+00	online	completed	\N	\N
1094	365	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4287.54	2023-02-01 00:00:00+00	online	completed	\N	\N
1095	365	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	1560.40	2023-03-01 00:00:00+00	online	completed	\N	\N
1096	366	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5762.26	2023-01-01 00:00:00+00	online	completed	\N	\N
1097	366	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2421.19	2023-02-01 00:00:00+00	online	completed	\N	\N
1098	366	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3043.46	2023-03-01 00:00:00+00	online	completed	\N	\N
1099	367	77e168c1-05e0-4314-8a24-5e838350a3d8	3142.71	2023-01-01 00:00:00+00	online	completed	\N	\N
1100	367	77e168c1-05e0-4314-8a24-5e838350a3d8	5019.74	2023-02-01 00:00:00+00	online	completed	\N	\N
1101	367	77e168c1-05e0-4314-8a24-5e838350a3d8	1177.82	2023-03-01 00:00:00+00	online	completed	\N	\N
1102	368	cff64755-2065-4e58-866f-f092cbd9e73b	5231.94	2023-01-01 00:00:00+00	online	completed	\N	\N
1103	368	cff64755-2065-4e58-866f-f092cbd9e73b	3546.33	2023-02-01 00:00:00+00	online	completed	\N	\N
1104	368	cff64755-2065-4e58-866f-f092cbd9e73b	1819.68	2023-03-01 00:00:00+00	online	completed	\N	\N
1105	369	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	5318.96	2023-01-01 00:00:00+00	online	completed	\N	\N
1106	369	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2232.39	2023-02-01 00:00:00+00	online	completed	\N	\N
1107	369	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2231.70	2023-03-01 00:00:00+00	online	completed	\N	\N
1108	370	a83848ba-0779-4fac-98ee-f5f459b2742b	2646.79	2023-01-01 00:00:00+00	online	completed	\N	\N
1109	370	a83848ba-0779-4fac-98ee-f5f459b2742b	5897.89	2023-02-01 00:00:00+00	online	completed	\N	\N
1110	370	a83848ba-0779-4fac-98ee-f5f459b2742b	5294.97	2023-03-01 00:00:00+00	online	completed	\N	\N
1111	371	51072377-1472-46cb-b180-8542677f5eb2	3099.76	2023-01-01 00:00:00+00	online	completed	\N	\N
1112	371	51072377-1472-46cb-b180-8542677f5eb2	2046.59	2023-02-01 00:00:00+00	online	completed	\N	\N
1113	371	51072377-1472-46cb-b180-8542677f5eb2	1891.38	2023-03-01 00:00:00+00	online	completed	\N	\N
1114	372	ee522e07-1315-4463-8a9b-f890b601c047	4636.33	2023-01-01 00:00:00+00	online	completed	\N	\N
1115	372	ee522e07-1315-4463-8a9b-f890b601c047	4349.24	2023-02-01 00:00:00+00	online	completed	\N	\N
1116	372	ee522e07-1315-4463-8a9b-f890b601c047	2683.78	2023-03-01 00:00:00+00	online	completed	\N	\N
1117	373	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	1365.37	2023-01-01 00:00:00+00	online	completed	\N	\N
1118	373	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	1663.36	2023-02-01 00:00:00+00	online	completed	\N	\N
1119	373	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2107.33	2023-03-01 00:00:00+00	online	completed	\N	\N
1120	374	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	5000.33	2023-01-01 00:00:00+00	online	completed	\N	\N
1121	374	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2186.47	2023-02-01 00:00:00+00	online	completed	\N	\N
1122	374	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3989.39	2023-03-01 00:00:00+00	online	completed	\N	\N
1123	375	584a1909-5797-4297-88d3-06bf5dc3922a	3482.26	2023-01-01 00:00:00+00	online	completed	\N	\N
1124	375	584a1909-5797-4297-88d3-06bf5dc3922a	5149.29	2023-02-01 00:00:00+00	online	completed	\N	\N
1125	375	584a1909-5797-4297-88d3-06bf5dc3922a	1878.28	2023-03-01 00:00:00+00	online	completed	\N	\N
1126	376	dd35da46-4416-412a-8a22-f3f39491bb7b	3916.60	2023-01-01 00:00:00+00	online	completed	\N	\N
1127	376	dd35da46-4416-412a-8a22-f3f39491bb7b	2077.19	2023-02-01 00:00:00+00	online	completed	\N	\N
1128	376	dd35da46-4416-412a-8a22-f3f39491bb7b	3968.70	2023-03-01 00:00:00+00	online	completed	\N	\N
1129	377	ee522e07-1315-4463-8a9b-f890b601c047	5569.40	2023-01-01 00:00:00+00	online	completed	\N	\N
1130	377	ee522e07-1315-4463-8a9b-f890b601c047	2063.96	2023-02-01 00:00:00+00	online	completed	\N	\N
1131	377	ee522e07-1315-4463-8a9b-f890b601c047	1416.02	2023-03-01 00:00:00+00	online	completed	\N	\N
1132	378	dbbbe49c-e100-4576-b406-320908c8873e	1604.62	2023-01-01 00:00:00+00	online	completed	\N	\N
1133	378	dbbbe49c-e100-4576-b406-320908c8873e	4940.57	2023-02-01 00:00:00+00	online	completed	\N	\N
1134	378	dbbbe49c-e100-4576-b406-320908c8873e	3897.70	2023-03-01 00:00:00+00	online	completed	\N	\N
1135	379	584a1909-5797-4297-88d3-06bf5dc3922a	3710.93	2023-01-01 00:00:00+00	online	completed	\N	\N
1136	379	584a1909-5797-4297-88d3-06bf5dc3922a	1069.38	2023-02-01 00:00:00+00	online	completed	\N	\N
1137	379	584a1909-5797-4297-88d3-06bf5dc3922a	3709.56	2023-03-01 00:00:00+00	online	completed	\N	\N
1138	380	b794e95a-97f4-4c05-aa2d-3c13c4155841	4954.28	2023-01-01 00:00:00+00	online	completed	\N	\N
1139	380	b794e95a-97f4-4c05-aa2d-3c13c4155841	5715.01	2023-02-01 00:00:00+00	online	completed	\N	\N
1140	380	b794e95a-97f4-4c05-aa2d-3c13c4155841	3994.00	2023-03-01 00:00:00+00	online	completed	\N	\N
1141	381	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5297.40	2023-01-01 00:00:00+00	online	completed	\N	\N
1142	381	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2371.81	2023-02-01 00:00:00+00	online	completed	\N	\N
1143	381	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3658.55	2023-03-01 00:00:00+00	online	completed	\N	\N
1144	382	9255fabc-799b-4cc7-8797-5f2470f6adf6	5050.42	2023-01-01 00:00:00+00	online	completed	\N	\N
1145	382	9255fabc-799b-4cc7-8797-5f2470f6adf6	5666.61	2023-02-01 00:00:00+00	online	completed	\N	\N
1146	382	9255fabc-799b-4cc7-8797-5f2470f6adf6	2395.81	2023-03-01 00:00:00+00	online	completed	\N	\N
1147	383	387d98f7-ccf9-4077-8f79-f0be51c40d05	3942.84	2023-01-01 00:00:00+00	online	completed	\N	\N
1148	383	387d98f7-ccf9-4077-8f79-f0be51c40d05	1256.55	2023-02-01 00:00:00+00	online	completed	\N	\N
1149	383	387d98f7-ccf9-4077-8f79-f0be51c40d05	3466.81	2023-03-01 00:00:00+00	online	completed	\N	\N
1150	384	bd38508e-8797-4220-ae2e-dd7883b41f17	1704.66	2023-01-01 00:00:00+00	online	completed	\N	\N
1151	384	bd38508e-8797-4220-ae2e-dd7883b41f17	5647.76	2023-02-01 00:00:00+00	online	completed	\N	\N
1152	384	bd38508e-8797-4220-ae2e-dd7883b41f17	1902.66	2023-03-01 00:00:00+00	online	completed	\N	\N
1153	385	a83848ba-0779-4fac-98ee-f5f459b2742b	2075.90	2023-01-01 00:00:00+00	online	completed	\N	\N
1154	385	a83848ba-0779-4fac-98ee-f5f459b2742b	3060.17	2023-02-01 00:00:00+00	online	completed	\N	\N
1155	385	a83848ba-0779-4fac-98ee-f5f459b2742b	3507.69	2023-03-01 00:00:00+00	online	completed	\N	\N
1156	386	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4159.91	2023-01-01 00:00:00+00	online	completed	\N	\N
1157	386	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3774.36	2023-02-01 00:00:00+00	online	completed	\N	\N
1158	386	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	5129.51	2023-03-01 00:00:00+00	online	completed	\N	\N
1159	387	9255fabc-799b-4cc7-8797-5f2470f6adf6	5085.71	2023-01-01 00:00:00+00	online	completed	\N	\N
1160	387	9255fabc-799b-4cc7-8797-5f2470f6adf6	2238.95	2023-02-01 00:00:00+00	online	completed	\N	\N
1161	387	9255fabc-799b-4cc7-8797-5f2470f6adf6	1930.77	2023-03-01 00:00:00+00	online	completed	\N	\N
1162	388	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2280.71	2023-01-01 00:00:00+00	online	completed	\N	\N
1163	388	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2177.25	2023-02-01 00:00:00+00	online	completed	\N	\N
1164	388	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1700.04	2023-03-01 00:00:00+00	online	completed	\N	\N
1165	389	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2903.57	2023-01-01 00:00:00+00	online	completed	\N	\N
1166	389	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	5672.73	2023-02-01 00:00:00+00	online	completed	\N	\N
1167	389	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2406.98	2023-03-01 00:00:00+00	online	completed	\N	\N
1168	390	da6ac18e-72e9-484a-ad75-d044260789cc	2091.49	2023-01-01 00:00:00+00	online	completed	\N	\N
1169	390	da6ac18e-72e9-484a-ad75-d044260789cc	3431.17	2023-02-01 00:00:00+00	online	completed	\N	\N
1170	390	da6ac18e-72e9-484a-ad75-d044260789cc	4478.81	2023-03-01 00:00:00+00	online	completed	\N	\N
1171	391	5432f125-2d5e-42ab-849a-29add2cf0a74	4098.88	2023-01-01 00:00:00+00	online	completed	\N	\N
1172	391	5432f125-2d5e-42ab-849a-29add2cf0a74	2967.87	2023-02-01 00:00:00+00	online	completed	\N	\N
1173	391	5432f125-2d5e-42ab-849a-29add2cf0a74	2225.72	2023-03-01 00:00:00+00	online	completed	\N	\N
1174	392	9255fabc-799b-4cc7-8797-5f2470f6adf6	3223.14	2023-01-01 00:00:00+00	online	completed	\N	\N
1175	392	9255fabc-799b-4cc7-8797-5f2470f6adf6	1239.48	2023-02-01 00:00:00+00	online	completed	\N	\N
1176	392	9255fabc-799b-4cc7-8797-5f2470f6adf6	4284.30	2023-03-01 00:00:00+00	online	completed	\N	\N
1177	393	a602c1a3-89cf-44a4-b419-f6827ad3701b	5008.14	2023-01-01 00:00:00+00	online	completed	\N	\N
1178	393	a602c1a3-89cf-44a4-b419-f6827ad3701b	4230.19	2023-02-01 00:00:00+00	online	completed	\N	\N
1179	393	a602c1a3-89cf-44a4-b419-f6827ad3701b	2317.41	2023-03-01 00:00:00+00	online	completed	\N	\N
1180	394	6833f990-6a38-4f28-aa18-e31697fa7dc9	3751.41	2023-01-01 00:00:00+00	online	completed	\N	\N
1181	394	6833f990-6a38-4f28-aa18-e31697fa7dc9	2429.66	2023-02-01 00:00:00+00	online	completed	\N	\N
1182	394	6833f990-6a38-4f28-aa18-e31697fa7dc9	2577.15	2023-03-01 00:00:00+00	online	completed	\N	\N
1183	395	cff64755-2065-4e58-866f-f092cbd9e73b	5980.21	2023-01-01 00:00:00+00	online	completed	\N	\N
1184	395	cff64755-2065-4e58-866f-f092cbd9e73b	3279.65	2023-02-01 00:00:00+00	online	completed	\N	\N
1185	395	cff64755-2065-4e58-866f-f092cbd9e73b	1148.11	2023-03-01 00:00:00+00	online	completed	\N	\N
1186	396	387d98f7-ccf9-4077-8f79-f0be51c40d05	2686.97	2023-01-01 00:00:00+00	online	completed	\N	\N
1187	396	387d98f7-ccf9-4077-8f79-f0be51c40d05	5972.82	2023-02-01 00:00:00+00	online	completed	\N	\N
1188	396	387d98f7-ccf9-4077-8f79-f0be51c40d05	3833.52	2023-03-01 00:00:00+00	online	completed	\N	\N
1189	397	463737cc-950b-4a41-8d73-a3daf931fee5	2602.17	2023-01-01 00:00:00+00	online	completed	\N	\N
1190	397	463737cc-950b-4a41-8d73-a3daf931fee5	2119.67	2023-02-01 00:00:00+00	online	completed	\N	\N
1191	397	463737cc-950b-4a41-8d73-a3daf931fee5	1025.79	2023-03-01 00:00:00+00	online	completed	\N	\N
1192	398	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2258.05	2023-01-01 00:00:00+00	online	completed	\N	\N
1193	398	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3156.85	2023-02-01 00:00:00+00	online	completed	\N	\N
1194	398	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2966.50	2023-03-01 00:00:00+00	online	completed	\N	\N
1195	399	ee522e07-1315-4463-8a9b-f890b601c047	2066.80	2023-01-01 00:00:00+00	online	completed	\N	\N
1196	399	ee522e07-1315-4463-8a9b-f890b601c047	1045.50	2023-02-01 00:00:00+00	online	completed	\N	\N
1197	399	ee522e07-1315-4463-8a9b-f890b601c047	5850.67	2023-03-01 00:00:00+00	online	completed	\N	\N
1198	400	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3958.21	2023-01-01 00:00:00+00	online	completed	\N	\N
1199	400	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	4815.84	2023-02-01 00:00:00+00	online	completed	\N	\N
1200	400	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	1827.42	2023-03-01 00:00:00+00	online	completed	\N	\N
1201	401	a602c1a3-89cf-44a4-b419-f6827ad3701b	5465.68	2023-01-01 00:00:00+00	online	completed	\N	\N
1202	401	a602c1a3-89cf-44a4-b419-f6827ad3701b	1107.15	2023-02-01 00:00:00+00	online	completed	\N	\N
1203	401	a602c1a3-89cf-44a4-b419-f6827ad3701b	5537.49	2023-03-01 00:00:00+00	online	completed	\N	\N
1204	402	b794e95a-97f4-4c05-aa2d-3c13c4155841	2938.37	2023-01-01 00:00:00+00	online	completed	\N	\N
1205	402	b794e95a-97f4-4c05-aa2d-3c13c4155841	4290.14	2023-02-01 00:00:00+00	online	completed	\N	\N
1206	402	b794e95a-97f4-4c05-aa2d-3c13c4155841	5485.98	2023-03-01 00:00:00+00	online	completed	\N	\N
1207	403	dbbbe49c-e100-4576-b406-320908c8873e	4035.56	2023-01-01 00:00:00+00	online	completed	\N	\N
1208	403	dbbbe49c-e100-4576-b406-320908c8873e	5656.94	2023-02-01 00:00:00+00	online	completed	\N	\N
1209	403	dbbbe49c-e100-4576-b406-320908c8873e	3737.92	2023-03-01 00:00:00+00	online	completed	\N	\N
1210	404	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2958.65	2023-01-01 00:00:00+00	online	completed	\N	\N
1211	404	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1304.41	2023-02-01 00:00:00+00	online	completed	\N	\N
1212	404	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5320.58	2023-03-01 00:00:00+00	online	completed	\N	\N
1213	405	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3153.27	2023-01-01 00:00:00+00	online	completed	\N	\N
1214	405	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3676.28	2023-02-01 00:00:00+00	online	completed	\N	\N
1215	405	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3667.60	2023-03-01 00:00:00+00	online	completed	\N	\N
1216	406	584a1909-5797-4297-88d3-06bf5dc3922a	1869.97	2023-01-01 00:00:00+00	online	completed	\N	\N
1217	406	584a1909-5797-4297-88d3-06bf5dc3922a	5354.56	2023-02-01 00:00:00+00	online	completed	\N	\N
1218	406	584a1909-5797-4297-88d3-06bf5dc3922a	4698.06	2023-03-01 00:00:00+00	online	completed	\N	\N
1219	407	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2583.12	2023-01-01 00:00:00+00	online	completed	\N	\N
1220	407	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1194.25	2023-02-01 00:00:00+00	online	completed	\N	\N
1221	407	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1299.75	2023-03-01 00:00:00+00	online	completed	\N	\N
1222	408	387d98f7-ccf9-4077-8f79-f0be51c40d05	2980.03	2023-01-01 00:00:00+00	online	completed	\N	\N
1223	408	387d98f7-ccf9-4077-8f79-f0be51c40d05	2304.30	2023-02-01 00:00:00+00	online	completed	\N	\N
1224	408	387d98f7-ccf9-4077-8f79-f0be51c40d05	1410.36	2023-03-01 00:00:00+00	online	completed	\N	\N
1225	409	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3744.27	2023-01-01 00:00:00+00	online	completed	\N	\N
1226	409	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2863.10	2023-02-01 00:00:00+00	online	completed	\N	\N
1227	409	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5765.07	2023-03-01 00:00:00+00	online	completed	\N	\N
1228	410	b794e95a-97f4-4c05-aa2d-3c13c4155841	4030.43	2023-01-01 00:00:00+00	online	completed	\N	\N
1229	410	b794e95a-97f4-4c05-aa2d-3c13c4155841	4061.02	2023-02-01 00:00:00+00	online	completed	\N	\N
1230	410	b794e95a-97f4-4c05-aa2d-3c13c4155841	5755.83	2023-03-01 00:00:00+00	online	completed	\N	\N
1231	411	dbbbe49c-e100-4576-b406-320908c8873e	2734.90	2023-01-01 00:00:00+00	online	completed	\N	\N
1232	411	dbbbe49c-e100-4576-b406-320908c8873e	4616.74	2023-02-01 00:00:00+00	online	completed	\N	\N
1233	411	dbbbe49c-e100-4576-b406-320908c8873e	3481.81	2023-03-01 00:00:00+00	online	completed	\N	\N
1234	412	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2368.61	2023-01-01 00:00:00+00	online	completed	\N	\N
1235	412	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1152.19	2023-02-01 00:00:00+00	online	completed	\N	\N
1236	412	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4882.32	2023-03-01 00:00:00+00	online	completed	\N	\N
1237	413	77e168c1-05e0-4314-8a24-5e838350a3d8	2207.61	2023-01-01 00:00:00+00	online	completed	\N	\N
1238	413	77e168c1-05e0-4314-8a24-5e838350a3d8	3031.80	2023-02-01 00:00:00+00	online	completed	\N	\N
1239	413	77e168c1-05e0-4314-8a24-5e838350a3d8	4802.08	2023-03-01 00:00:00+00	online	completed	\N	\N
1240	414	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1429.66	2023-01-01 00:00:00+00	online	completed	\N	\N
1241	414	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3809.03	2023-02-01 00:00:00+00	online	completed	\N	\N
1242	414	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1809.01	2023-03-01 00:00:00+00	online	completed	\N	\N
1243	415	dbbbe49c-e100-4576-b406-320908c8873e	1396.06	2023-01-01 00:00:00+00	online	completed	\N	\N
1244	415	dbbbe49c-e100-4576-b406-320908c8873e	3813.77	2023-02-01 00:00:00+00	online	completed	\N	\N
1245	415	dbbbe49c-e100-4576-b406-320908c8873e	2880.42	2023-03-01 00:00:00+00	online	completed	\N	\N
1246	416	b794e95a-97f4-4c05-aa2d-3c13c4155841	2089.08	2023-01-01 00:00:00+00	online	completed	\N	\N
1247	416	b794e95a-97f4-4c05-aa2d-3c13c4155841	4311.76	2023-02-01 00:00:00+00	online	completed	\N	\N
1248	416	b794e95a-97f4-4c05-aa2d-3c13c4155841	3106.73	2023-03-01 00:00:00+00	online	completed	\N	\N
1249	417	a602c1a3-89cf-44a4-b419-f6827ad3701b	2512.25	2023-01-01 00:00:00+00	online	completed	\N	\N
1250	417	a602c1a3-89cf-44a4-b419-f6827ad3701b	4942.24	2023-02-01 00:00:00+00	online	completed	\N	\N
1251	417	a602c1a3-89cf-44a4-b419-f6827ad3701b	4464.58	2023-03-01 00:00:00+00	online	completed	\N	\N
1252	418	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4031.28	2023-01-01 00:00:00+00	online	completed	\N	\N
1253	418	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4742.19	2023-02-01 00:00:00+00	online	completed	\N	\N
1254	418	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4069.22	2023-03-01 00:00:00+00	online	completed	\N	\N
1255	419	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5251.93	2023-01-01 00:00:00+00	online	completed	\N	\N
1256	419	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5503.33	2023-02-01 00:00:00+00	online	completed	\N	\N
1257	419	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5430.86	2023-03-01 00:00:00+00	online	completed	\N	\N
1258	420	8088628d-f77a-430d-b228-cc3649b8a3e1	2643.10	2023-01-01 00:00:00+00	online	completed	\N	\N
1259	420	8088628d-f77a-430d-b228-cc3649b8a3e1	3733.77	2023-02-01 00:00:00+00	online	completed	\N	\N
1260	420	8088628d-f77a-430d-b228-cc3649b8a3e1	1152.49	2023-03-01 00:00:00+00	online	completed	\N	\N
1261	421	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4338.46	2023-01-01 00:00:00+00	online	completed	\N	\N
1262	421	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4191.51	2023-02-01 00:00:00+00	online	completed	\N	\N
1263	421	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1536.53	2023-03-01 00:00:00+00	online	completed	\N	\N
1264	422	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4075.74	2023-01-01 00:00:00+00	online	completed	\N	\N
1265	422	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3741.34	2023-02-01 00:00:00+00	online	completed	\N	\N
1266	422	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4451.14	2023-03-01 00:00:00+00	online	completed	\N	\N
1267	423	6ac1e176-e710-4b5e-9453-95765db20ba3	5027.17	2023-01-01 00:00:00+00	online	completed	\N	\N
1268	423	6ac1e176-e710-4b5e-9453-95765db20ba3	1417.74	2023-02-01 00:00:00+00	online	completed	\N	\N
1269	423	6ac1e176-e710-4b5e-9453-95765db20ba3	1917.31	2023-03-01 00:00:00+00	online	completed	\N	\N
1270	424	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2362.25	2023-01-01 00:00:00+00	online	completed	\N	\N
1271	424	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2507.40	2023-02-01 00:00:00+00	online	completed	\N	\N
1272	424	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3573.59	2023-03-01 00:00:00+00	online	completed	\N	\N
1273	425	584a1909-5797-4297-88d3-06bf5dc3922a	1998.21	2023-01-01 00:00:00+00	online	completed	\N	\N
1274	425	584a1909-5797-4297-88d3-06bf5dc3922a	2958.57	2023-02-01 00:00:00+00	online	completed	\N	\N
1275	425	584a1909-5797-4297-88d3-06bf5dc3922a	2133.22	2023-03-01 00:00:00+00	online	completed	\N	\N
1276	426	b794e95a-97f4-4c05-aa2d-3c13c4155841	5291.73	2023-01-01 00:00:00+00	online	completed	\N	\N
1277	426	b794e95a-97f4-4c05-aa2d-3c13c4155841	4311.47	2023-02-01 00:00:00+00	online	completed	\N	\N
1278	426	b794e95a-97f4-4c05-aa2d-3c13c4155841	4482.11	2023-03-01 00:00:00+00	online	completed	\N	\N
1279	427	a83848ba-0779-4fac-98ee-f5f459b2742b	1990.75	2023-01-01 00:00:00+00	online	completed	\N	\N
1280	427	a83848ba-0779-4fac-98ee-f5f459b2742b	3829.11	2023-02-01 00:00:00+00	online	completed	\N	\N
1281	427	a83848ba-0779-4fac-98ee-f5f459b2742b	4459.67	2023-03-01 00:00:00+00	online	completed	\N	\N
1282	428	fc7c7272-6d55-49a3-88d7-fc37133a103f	5018.25	2023-01-01 00:00:00+00	online	completed	\N	\N
1283	428	fc7c7272-6d55-49a3-88d7-fc37133a103f	4068.84	2023-02-01 00:00:00+00	online	completed	\N	\N
1284	428	fc7c7272-6d55-49a3-88d7-fc37133a103f	5930.63	2023-03-01 00:00:00+00	online	completed	\N	\N
1285	429	8088628d-f77a-430d-b228-cc3649b8a3e1	2706.81	2023-01-01 00:00:00+00	online	completed	\N	\N
1286	429	8088628d-f77a-430d-b228-cc3649b8a3e1	5250.75	2023-02-01 00:00:00+00	online	completed	\N	\N
1287	429	8088628d-f77a-430d-b228-cc3649b8a3e1	4734.36	2023-03-01 00:00:00+00	online	completed	\N	\N
1288	430	dde964d6-6ffa-4b25-97b6-128969afe47c	4587.75	2023-01-01 00:00:00+00	online	completed	\N	\N
1289	430	dde964d6-6ffa-4b25-97b6-128969afe47c	2160.73	2023-02-01 00:00:00+00	online	completed	\N	\N
1290	430	dde964d6-6ffa-4b25-97b6-128969afe47c	4365.08	2023-03-01 00:00:00+00	online	completed	\N	\N
1291	431	da6ac18e-72e9-484a-ad75-d044260789cc	3094.46	2023-01-01 00:00:00+00	online	completed	\N	\N
1292	431	da6ac18e-72e9-484a-ad75-d044260789cc	3090.85	2023-02-01 00:00:00+00	online	completed	\N	\N
1293	431	da6ac18e-72e9-484a-ad75-d044260789cc	5147.20	2023-03-01 00:00:00+00	online	completed	\N	\N
1294	432	da6ac18e-72e9-484a-ad75-d044260789cc	3082.77	2023-01-01 00:00:00+00	online	completed	\N	\N
1295	432	da6ac18e-72e9-484a-ad75-d044260789cc	3738.96	2023-02-01 00:00:00+00	online	completed	\N	\N
1296	432	da6ac18e-72e9-484a-ad75-d044260789cc	1893.50	2023-03-01 00:00:00+00	online	completed	\N	\N
1297	433	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2741.41	2023-01-01 00:00:00+00	online	completed	\N	\N
1298	433	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3090.01	2023-02-01 00:00:00+00	online	completed	\N	\N
1299	433	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1497.97	2023-03-01 00:00:00+00	online	completed	\N	\N
1300	434	fc7c7272-6d55-49a3-88d7-fc37133a103f	5806.62	2023-01-01 00:00:00+00	online	completed	\N	\N
1301	434	fc7c7272-6d55-49a3-88d7-fc37133a103f	3580.07	2023-02-01 00:00:00+00	online	completed	\N	\N
1302	434	fc7c7272-6d55-49a3-88d7-fc37133a103f	4867.53	2023-03-01 00:00:00+00	online	completed	\N	\N
1303	435	5432f125-2d5e-42ab-849a-29add2cf0a74	5692.67	2023-01-01 00:00:00+00	online	completed	\N	\N
1304	435	5432f125-2d5e-42ab-849a-29add2cf0a74	2931.69	2023-02-01 00:00:00+00	online	completed	\N	\N
1305	435	5432f125-2d5e-42ab-849a-29add2cf0a74	2640.24	2023-03-01 00:00:00+00	online	completed	\N	\N
1306	436	463737cc-950b-4a41-8d73-a3daf931fee5	1847.97	2023-01-01 00:00:00+00	online	completed	\N	\N
1307	436	463737cc-950b-4a41-8d73-a3daf931fee5	4111.80	2023-02-01 00:00:00+00	online	completed	\N	\N
1308	436	463737cc-950b-4a41-8d73-a3daf931fee5	4222.09	2023-03-01 00:00:00+00	online	completed	\N	\N
1309	437	9255fabc-799b-4cc7-8797-5f2470f6adf6	2129.84	2023-01-01 00:00:00+00	online	completed	\N	\N
1310	437	9255fabc-799b-4cc7-8797-5f2470f6adf6	2822.02	2023-02-01 00:00:00+00	online	completed	\N	\N
1311	437	9255fabc-799b-4cc7-8797-5f2470f6adf6	2104.49	2023-03-01 00:00:00+00	online	completed	\N	\N
1312	438	bd38508e-8797-4220-ae2e-dd7883b41f17	1312.32	2023-01-01 00:00:00+00	online	completed	\N	\N
1313	438	bd38508e-8797-4220-ae2e-dd7883b41f17	2978.15	2023-02-01 00:00:00+00	online	completed	\N	\N
1314	438	bd38508e-8797-4220-ae2e-dd7883b41f17	2197.42	2023-03-01 00:00:00+00	online	completed	\N	\N
1315	439	6833f990-6a38-4f28-aa18-e31697fa7dc9	1857.75	2023-01-01 00:00:00+00	online	completed	\N	\N
1316	439	6833f990-6a38-4f28-aa18-e31697fa7dc9	1140.62	2023-02-01 00:00:00+00	online	completed	\N	\N
1317	439	6833f990-6a38-4f28-aa18-e31697fa7dc9	3448.85	2023-03-01 00:00:00+00	online	completed	\N	\N
1318	440	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2758.82	2023-01-01 00:00:00+00	online	completed	\N	\N
1319	440	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2090.90	2023-02-01 00:00:00+00	online	completed	\N	\N
1320	440	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1592.56	2023-03-01 00:00:00+00	online	completed	\N	\N
1321	441	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2049.42	2023-01-01 00:00:00+00	online	completed	\N	\N
1322	441	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2476.99	2023-02-01 00:00:00+00	online	completed	\N	\N
1323	441	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5173.42	2023-03-01 00:00:00+00	online	completed	\N	\N
1324	442	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3563.38	2023-01-01 00:00:00+00	online	completed	\N	\N
1325	442	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1150.42	2023-02-01 00:00:00+00	online	completed	\N	\N
1326	442	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5273.49	2023-03-01 00:00:00+00	online	completed	\N	\N
1327	443	dde964d6-6ffa-4b25-97b6-128969afe47c	3080.81	2023-01-01 00:00:00+00	online	completed	\N	\N
1328	443	dde964d6-6ffa-4b25-97b6-128969afe47c	4851.78	2023-02-01 00:00:00+00	online	completed	\N	\N
1329	443	dde964d6-6ffa-4b25-97b6-128969afe47c	3725.90	2023-03-01 00:00:00+00	online	completed	\N	\N
1330	444	6ac1e176-e710-4b5e-9453-95765db20ba3	5413.71	2023-01-01 00:00:00+00	online	completed	\N	\N
1331	444	6ac1e176-e710-4b5e-9453-95765db20ba3	3987.23	2023-02-01 00:00:00+00	online	completed	\N	\N
1332	444	6ac1e176-e710-4b5e-9453-95765db20ba3	4111.53	2023-03-01 00:00:00+00	online	completed	\N	\N
1333	445	1934abf8-eca9-41d8-bc5f-9c649285b76b	1782.13	2023-01-01 00:00:00+00	online	completed	\N	\N
1334	445	1934abf8-eca9-41d8-bc5f-9c649285b76b	4576.94	2023-02-01 00:00:00+00	online	completed	\N	\N
1335	445	1934abf8-eca9-41d8-bc5f-9c649285b76b	2331.89	2023-03-01 00:00:00+00	online	completed	\N	\N
1336	446	ee522e07-1315-4463-8a9b-f890b601c047	1293.88	2023-01-01 00:00:00+00	online	completed	\N	\N
1337	446	ee522e07-1315-4463-8a9b-f890b601c047	1466.34	2023-02-01 00:00:00+00	online	completed	\N	\N
1338	446	ee522e07-1315-4463-8a9b-f890b601c047	3234.76	2023-03-01 00:00:00+00	online	completed	\N	\N
1339	447	dbbbe49c-e100-4576-b406-320908c8873e	5336.34	2023-01-01 00:00:00+00	online	completed	\N	\N
1340	447	dbbbe49c-e100-4576-b406-320908c8873e	4196.24	2023-02-01 00:00:00+00	online	completed	\N	\N
1341	447	dbbbe49c-e100-4576-b406-320908c8873e	5758.89	2023-03-01 00:00:00+00	online	completed	\N	\N
1342	448	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2080.13	2023-01-01 00:00:00+00	online	completed	\N	\N
1343	448	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1541.87	2023-02-01 00:00:00+00	online	completed	\N	\N
1344	448	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4857.22	2023-03-01 00:00:00+00	online	completed	\N	\N
1345	449	584a1909-5797-4297-88d3-06bf5dc3922a	3293.83	2023-01-01 00:00:00+00	online	completed	\N	\N
1346	449	584a1909-5797-4297-88d3-06bf5dc3922a	2540.78	2023-02-01 00:00:00+00	online	completed	\N	\N
1347	449	584a1909-5797-4297-88d3-06bf5dc3922a	1123.93	2023-03-01 00:00:00+00	online	completed	\N	\N
1348	450	a83848ba-0779-4fac-98ee-f5f459b2742b	5650.23	2023-01-01 00:00:00+00	online	completed	\N	\N
1349	450	a83848ba-0779-4fac-98ee-f5f459b2742b	2916.90	2023-02-01 00:00:00+00	online	completed	\N	\N
1350	450	a83848ba-0779-4fac-98ee-f5f459b2742b	1806.71	2023-03-01 00:00:00+00	online	completed	\N	\N
1351	451	5432f125-2d5e-42ab-849a-29add2cf0a74	3999.57	2023-01-01 00:00:00+00	online	completed	\N	\N
1352	451	5432f125-2d5e-42ab-849a-29add2cf0a74	4005.39	2023-02-01 00:00:00+00	online	completed	\N	\N
1353	451	5432f125-2d5e-42ab-849a-29add2cf0a74	5104.56	2023-03-01 00:00:00+00	online	completed	\N	\N
1354	452	9255fabc-799b-4cc7-8797-5f2470f6adf6	4961.38	2023-01-01 00:00:00+00	online	completed	\N	\N
1355	452	9255fabc-799b-4cc7-8797-5f2470f6adf6	3607.58	2023-02-01 00:00:00+00	online	completed	\N	\N
1356	452	9255fabc-799b-4cc7-8797-5f2470f6adf6	4515.92	2023-03-01 00:00:00+00	online	completed	\N	\N
1357	453	a602c1a3-89cf-44a4-b419-f6827ad3701b	5507.75	2023-01-01 00:00:00+00	online	completed	\N	\N
1358	453	a602c1a3-89cf-44a4-b419-f6827ad3701b	2062.43	2023-02-01 00:00:00+00	online	completed	\N	\N
1359	453	a602c1a3-89cf-44a4-b419-f6827ad3701b	3457.82	2023-03-01 00:00:00+00	online	completed	\N	\N
1360	454	387d98f7-ccf9-4077-8f79-f0be51c40d05	1055.01	2023-01-01 00:00:00+00	online	completed	\N	\N
1361	454	387d98f7-ccf9-4077-8f79-f0be51c40d05	5345.70	2023-02-01 00:00:00+00	online	completed	\N	\N
1362	454	387d98f7-ccf9-4077-8f79-f0be51c40d05	3459.47	2023-03-01 00:00:00+00	online	completed	\N	\N
1363	455	dbbbe49c-e100-4576-b406-320908c8873e	5707.29	2023-01-01 00:00:00+00	online	completed	\N	\N
1364	455	dbbbe49c-e100-4576-b406-320908c8873e	1675.01	2023-02-01 00:00:00+00	online	completed	\N	\N
1365	455	dbbbe49c-e100-4576-b406-320908c8873e	3784.86	2023-03-01 00:00:00+00	online	completed	\N	\N
1366	456	b794e95a-97f4-4c05-aa2d-3c13c4155841	2923.00	2023-01-01 00:00:00+00	online	completed	\N	\N
1367	456	b794e95a-97f4-4c05-aa2d-3c13c4155841	1168.68	2023-02-01 00:00:00+00	online	completed	\N	\N
1368	456	b794e95a-97f4-4c05-aa2d-3c13c4155841	1294.56	2023-03-01 00:00:00+00	online	completed	\N	\N
1369	457	dde964d6-6ffa-4b25-97b6-128969afe47c	5428.14	2023-01-01 00:00:00+00	online	completed	\N	\N
1370	457	dde964d6-6ffa-4b25-97b6-128969afe47c	1206.60	2023-02-01 00:00:00+00	online	completed	\N	\N
1371	457	dde964d6-6ffa-4b25-97b6-128969afe47c	4228.09	2023-03-01 00:00:00+00	online	completed	\N	\N
1372	458	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2319.35	2023-01-01 00:00:00+00	online	completed	\N	\N
1373	458	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4835.18	2023-02-01 00:00:00+00	online	completed	\N	\N
1374	458	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2783.44	2023-03-01 00:00:00+00	online	completed	\N	\N
1375	459	6ac1e176-e710-4b5e-9453-95765db20ba3	4114.18	2023-01-01 00:00:00+00	online	completed	\N	\N
1376	459	6ac1e176-e710-4b5e-9453-95765db20ba3	3871.55	2023-02-01 00:00:00+00	online	completed	\N	\N
1377	459	6ac1e176-e710-4b5e-9453-95765db20ba3	4968.38	2023-03-01 00:00:00+00	online	completed	\N	\N
1378	460	51072377-1472-46cb-b180-8542677f5eb2	3460.40	2023-01-01 00:00:00+00	online	completed	\N	\N
1379	460	51072377-1472-46cb-b180-8542677f5eb2	1799.23	2023-02-01 00:00:00+00	online	completed	\N	\N
1380	460	51072377-1472-46cb-b180-8542677f5eb2	3643.87	2023-03-01 00:00:00+00	online	completed	\N	\N
1381	461	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3456.90	2023-01-01 00:00:00+00	online	completed	\N	\N
1382	461	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4390.24	2023-02-01 00:00:00+00	online	completed	\N	\N
1383	461	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4235.69	2023-03-01 00:00:00+00	online	completed	\N	\N
1384	462	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2270.40	2023-01-01 00:00:00+00	online	completed	\N	\N
1385	462	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5465.16	2023-02-01 00:00:00+00	online	completed	\N	\N
1386	462	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2828.70	2023-03-01 00:00:00+00	online	completed	\N	\N
1387	463	5432f125-2d5e-42ab-849a-29add2cf0a74	1805.79	2023-01-01 00:00:00+00	online	completed	\N	\N
1388	463	5432f125-2d5e-42ab-849a-29add2cf0a74	1990.82	2023-02-01 00:00:00+00	online	completed	\N	\N
1389	463	5432f125-2d5e-42ab-849a-29add2cf0a74	5453.33	2023-03-01 00:00:00+00	online	completed	\N	\N
1390	464	cff64755-2065-4e58-866f-f092cbd9e73b	1331.51	2023-01-01 00:00:00+00	online	completed	\N	\N
1391	464	cff64755-2065-4e58-866f-f092cbd9e73b	1517.94	2023-02-01 00:00:00+00	online	completed	\N	\N
1392	464	cff64755-2065-4e58-866f-f092cbd9e73b	5636.33	2023-03-01 00:00:00+00	online	completed	\N	\N
1393	465	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2950.70	2023-01-01 00:00:00+00	online	completed	\N	\N
1394	465	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	5002.97	2023-02-01 00:00:00+00	online	completed	\N	\N
1395	465	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	5992.11	2023-03-01 00:00:00+00	online	completed	\N	\N
1396	466	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	1303.74	2023-01-01 00:00:00+00	online	completed	\N	\N
1397	466	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2068.02	2023-02-01 00:00:00+00	online	completed	\N	\N
1398	466	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2998.77	2023-03-01 00:00:00+00	online	completed	\N	\N
1399	467	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2804.36	2023-01-01 00:00:00+00	online	completed	\N	\N
1400	467	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3529.36	2023-02-01 00:00:00+00	online	completed	\N	\N
1401	467	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	5322.92	2023-03-01 00:00:00+00	online	completed	\N	\N
1402	468	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	5490.37	2023-01-01 00:00:00+00	online	completed	\N	\N
1403	468	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2408.51	2023-02-01 00:00:00+00	online	completed	\N	\N
1404	468	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3009.34	2023-03-01 00:00:00+00	online	completed	\N	\N
1405	469	a602c1a3-89cf-44a4-b419-f6827ad3701b	2753.61	2023-01-01 00:00:00+00	online	completed	\N	\N
1406	469	a602c1a3-89cf-44a4-b419-f6827ad3701b	2014.98	2023-02-01 00:00:00+00	online	completed	\N	\N
1407	469	a602c1a3-89cf-44a4-b419-f6827ad3701b	4151.74	2023-03-01 00:00:00+00	online	completed	\N	\N
1408	470	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5004.22	2023-01-01 00:00:00+00	online	completed	\N	\N
1409	470	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4888.22	2023-02-01 00:00:00+00	online	completed	\N	\N
1410	470	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2349.66	2023-03-01 00:00:00+00	online	completed	\N	\N
1411	471	584a1909-5797-4297-88d3-06bf5dc3922a	3417.04	2023-01-01 00:00:00+00	online	completed	\N	\N
1412	471	584a1909-5797-4297-88d3-06bf5dc3922a	2240.06	2023-02-01 00:00:00+00	online	completed	\N	\N
1413	471	584a1909-5797-4297-88d3-06bf5dc3922a	5814.84	2023-03-01 00:00:00+00	online	completed	\N	\N
1414	472	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2344.96	2023-01-01 00:00:00+00	online	completed	\N	\N
1415	472	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5344.18	2023-02-01 00:00:00+00	online	completed	\N	\N
1416	472	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5750.85	2023-03-01 00:00:00+00	online	completed	\N	\N
1417	473	584a1909-5797-4297-88d3-06bf5dc3922a	1794.67	2023-01-01 00:00:00+00	online	completed	\N	\N
1418	473	584a1909-5797-4297-88d3-06bf5dc3922a	5792.69	2023-02-01 00:00:00+00	online	completed	\N	\N
1419	473	584a1909-5797-4297-88d3-06bf5dc3922a	3861.84	2023-03-01 00:00:00+00	online	completed	\N	\N
1420	474	fc7c7272-6d55-49a3-88d7-fc37133a103f	2041.28	2023-01-01 00:00:00+00	online	completed	\N	\N
1421	474	fc7c7272-6d55-49a3-88d7-fc37133a103f	5350.39	2023-02-01 00:00:00+00	online	completed	\N	\N
1422	474	fc7c7272-6d55-49a3-88d7-fc37133a103f	1042.12	2023-03-01 00:00:00+00	online	completed	\N	\N
1423	475	fc7c7272-6d55-49a3-88d7-fc37133a103f	4024.46	2023-01-01 00:00:00+00	online	completed	\N	\N
1424	475	fc7c7272-6d55-49a3-88d7-fc37133a103f	2768.26	2023-02-01 00:00:00+00	online	completed	\N	\N
1425	475	fc7c7272-6d55-49a3-88d7-fc37133a103f	2763.35	2023-03-01 00:00:00+00	online	completed	\N	\N
1426	476	6ac1e176-e710-4b5e-9453-95765db20ba3	5346.42	2023-01-01 00:00:00+00	online	completed	\N	\N
1427	476	6ac1e176-e710-4b5e-9453-95765db20ba3	4283.53	2023-02-01 00:00:00+00	online	completed	\N	\N
1428	476	6ac1e176-e710-4b5e-9453-95765db20ba3	3149.93	2023-03-01 00:00:00+00	online	completed	\N	\N
1429	477	cff64755-2065-4e58-866f-f092cbd9e73b	5307.88	2023-01-01 00:00:00+00	online	completed	\N	\N
1430	477	cff64755-2065-4e58-866f-f092cbd9e73b	4218.10	2023-02-01 00:00:00+00	online	completed	\N	\N
1431	477	cff64755-2065-4e58-866f-f092cbd9e73b	4785.87	2023-03-01 00:00:00+00	online	completed	\N	\N
1432	478	1934abf8-eca9-41d8-bc5f-9c649285b76b	5739.61	2023-01-01 00:00:00+00	online	completed	\N	\N
1433	478	1934abf8-eca9-41d8-bc5f-9c649285b76b	4177.30	2023-02-01 00:00:00+00	online	completed	\N	\N
1434	478	1934abf8-eca9-41d8-bc5f-9c649285b76b	5531.55	2023-03-01 00:00:00+00	online	completed	\N	\N
1435	479	ee522e07-1315-4463-8a9b-f890b601c047	5202.22	2023-01-01 00:00:00+00	online	completed	\N	\N
1436	479	ee522e07-1315-4463-8a9b-f890b601c047	5782.01	2023-02-01 00:00:00+00	online	completed	\N	\N
1437	479	ee522e07-1315-4463-8a9b-f890b601c047	1748.38	2023-03-01 00:00:00+00	online	completed	\N	\N
1438	480	dbbbe49c-e100-4576-b406-320908c8873e	1280.88	2023-01-01 00:00:00+00	online	completed	\N	\N
1439	480	dbbbe49c-e100-4576-b406-320908c8873e	5879.17	2023-02-01 00:00:00+00	online	completed	\N	\N
1440	480	dbbbe49c-e100-4576-b406-320908c8873e	2667.57	2023-03-01 00:00:00+00	online	completed	\N	\N
1441	481	1934abf8-eca9-41d8-bc5f-9c649285b76b	1600.06	2023-01-01 00:00:00+00	online	completed	\N	\N
1442	481	1934abf8-eca9-41d8-bc5f-9c649285b76b	2583.62	2023-02-01 00:00:00+00	online	completed	\N	\N
1443	481	1934abf8-eca9-41d8-bc5f-9c649285b76b	1070.11	2023-03-01 00:00:00+00	online	completed	\N	\N
1444	482	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4705.47	2023-01-01 00:00:00+00	online	completed	\N	\N
1445	482	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4178.84	2023-02-01 00:00:00+00	online	completed	\N	\N
1446	482	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2023.72	2023-03-01 00:00:00+00	online	completed	\N	\N
1447	483	a602c1a3-89cf-44a4-b419-f6827ad3701b	3926.70	2023-01-01 00:00:00+00	online	completed	\N	\N
1448	483	a602c1a3-89cf-44a4-b419-f6827ad3701b	4764.92	2023-02-01 00:00:00+00	online	completed	\N	\N
1449	483	a602c1a3-89cf-44a4-b419-f6827ad3701b	4548.95	2023-03-01 00:00:00+00	online	completed	\N	\N
1450	484	1934abf8-eca9-41d8-bc5f-9c649285b76b	3956.96	2023-01-01 00:00:00+00	online	completed	\N	\N
1451	484	1934abf8-eca9-41d8-bc5f-9c649285b76b	4912.60	2023-02-01 00:00:00+00	online	completed	\N	\N
1452	484	1934abf8-eca9-41d8-bc5f-9c649285b76b	2796.80	2023-03-01 00:00:00+00	online	completed	\N	\N
1453	485	51072377-1472-46cb-b180-8542677f5eb2	3286.40	2023-01-01 00:00:00+00	online	completed	\N	\N
1454	485	51072377-1472-46cb-b180-8542677f5eb2	2843.52	2023-02-01 00:00:00+00	online	completed	\N	\N
1455	485	51072377-1472-46cb-b180-8542677f5eb2	2711.79	2023-03-01 00:00:00+00	online	completed	\N	\N
1456	486	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1584.26	2023-01-01 00:00:00+00	online	completed	\N	\N
1457	486	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3669.44	2023-02-01 00:00:00+00	online	completed	\N	\N
1458	486	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1397.78	2023-03-01 00:00:00+00	online	completed	\N	\N
1459	487	6ac1e176-e710-4b5e-9453-95765db20ba3	3338.23	2023-01-01 00:00:00+00	online	completed	\N	\N
1460	487	6ac1e176-e710-4b5e-9453-95765db20ba3	5692.82	2023-02-01 00:00:00+00	online	completed	\N	\N
1461	487	6ac1e176-e710-4b5e-9453-95765db20ba3	3119.74	2023-03-01 00:00:00+00	online	completed	\N	\N
1462	488	ee522e07-1315-4463-8a9b-f890b601c047	1747.48	2023-01-01 00:00:00+00	online	completed	\N	\N
1463	488	ee522e07-1315-4463-8a9b-f890b601c047	3215.40	2023-02-01 00:00:00+00	online	completed	\N	\N
1464	488	ee522e07-1315-4463-8a9b-f890b601c047	2014.81	2023-03-01 00:00:00+00	online	completed	\N	\N
1465	489	dde964d6-6ffa-4b25-97b6-128969afe47c	2212.49	2023-01-01 00:00:00+00	online	completed	\N	\N
1466	489	dde964d6-6ffa-4b25-97b6-128969afe47c	1676.54	2023-02-01 00:00:00+00	online	completed	\N	\N
1467	489	dde964d6-6ffa-4b25-97b6-128969afe47c	1028.25	2023-03-01 00:00:00+00	online	completed	\N	\N
1468	490	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2218.16	2023-01-01 00:00:00+00	online	completed	\N	\N
1469	490	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	5237.79	2023-02-01 00:00:00+00	online	completed	\N	\N
1470	490	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2717.98	2023-03-01 00:00:00+00	online	completed	\N	\N
1471	491	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3455.76	2023-01-01 00:00:00+00	online	completed	\N	\N
1472	491	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2030.80	2023-02-01 00:00:00+00	online	completed	\N	\N
1473	491	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5570.01	2023-03-01 00:00:00+00	online	completed	\N	\N
1474	492	77e168c1-05e0-4314-8a24-5e838350a3d8	1539.69	2023-01-01 00:00:00+00	online	completed	\N	\N
1475	492	77e168c1-05e0-4314-8a24-5e838350a3d8	2511.43	2023-02-01 00:00:00+00	online	completed	\N	\N
1476	492	77e168c1-05e0-4314-8a24-5e838350a3d8	4723.41	2023-03-01 00:00:00+00	online	completed	\N	\N
1477	493	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2465.28	2023-01-01 00:00:00+00	online	completed	\N	\N
1478	493	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3610.72	2023-02-01 00:00:00+00	online	completed	\N	\N
1479	493	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3843.72	2023-03-01 00:00:00+00	online	completed	\N	\N
1480	494	fc7c7272-6d55-49a3-88d7-fc37133a103f	3064.44	2023-01-01 00:00:00+00	online	completed	\N	\N
1481	494	fc7c7272-6d55-49a3-88d7-fc37133a103f	4041.37	2023-02-01 00:00:00+00	online	completed	\N	\N
1482	494	fc7c7272-6d55-49a3-88d7-fc37133a103f	5122.53	2023-03-01 00:00:00+00	online	completed	\N	\N
1483	495	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5712.36	2023-01-01 00:00:00+00	online	completed	\N	\N
1484	495	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5360.97	2023-02-01 00:00:00+00	online	completed	\N	\N
1485	495	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3064.59	2023-03-01 00:00:00+00	online	completed	\N	\N
1486	496	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1260.28	2023-01-01 00:00:00+00	online	completed	\N	\N
1487	496	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2637.12	2023-02-01 00:00:00+00	online	completed	\N	\N
1488	496	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3475.02	2023-03-01 00:00:00+00	online	completed	\N	\N
1489	497	a602c1a3-89cf-44a4-b419-f6827ad3701b	4741.44	2023-01-01 00:00:00+00	online	completed	\N	\N
1490	497	a602c1a3-89cf-44a4-b419-f6827ad3701b	4040.96	2023-02-01 00:00:00+00	online	completed	\N	\N
1491	497	a602c1a3-89cf-44a4-b419-f6827ad3701b	5359.86	2023-03-01 00:00:00+00	online	completed	\N	\N
1492	498	5432f125-2d5e-42ab-849a-29add2cf0a74	2676.00	2023-01-01 00:00:00+00	online	completed	\N	\N
1493	498	5432f125-2d5e-42ab-849a-29add2cf0a74	5729.61	2023-02-01 00:00:00+00	online	completed	\N	\N
1494	498	5432f125-2d5e-42ab-849a-29add2cf0a74	3955.66	2023-03-01 00:00:00+00	online	completed	\N	\N
1495	499	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1448.23	2023-01-01 00:00:00+00	online	completed	\N	\N
1496	499	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5007.76	2023-02-01 00:00:00+00	online	completed	\N	\N
1497	499	b1f5db31-bfc8-409c-8925-0d21f1c780e6	4591.54	2023-03-01 00:00:00+00	online	completed	\N	\N
1498	500	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	4813.50	2023-01-01 00:00:00+00	online	completed	\N	\N
1499	500	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3990.31	2023-02-01 00:00:00+00	online	completed	\N	\N
1500	500	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2252.83	2023-03-01 00:00:00+00	online	completed	\N	\N
1501	501	51072377-1472-46cb-b180-8542677f5eb2	4199.28	2023-01-01 00:00:00+00	online	completed	\N	\N
1502	501	51072377-1472-46cb-b180-8542677f5eb2	1536.61	2023-02-01 00:00:00+00	online	completed	\N	\N
1503	501	51072377-1472-46cb-b180-8542677f5eb2	5799.04	2023-03-01 00:00:00+00	online	completed	\N	\N
1504	502	6ac1e176-e710-4b5e-9453-95765db20ba3	4055.81	2023-01-01 00:00:00+00	online	completed	\N	\N
1505	502	6ac1e176-e710-4b5e-9453-95765db20ba3	4652.65	2023-02-01 00:00:00+00	online	completed	\N	\N
1506	502	6ac1e176-e710-4b5e-9453-95765db20ba3	3688.35	2023-03-01 00:00:00+00	online	completed	\N	\N
1507	503	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3003.60	2023-01-01 00:00:00+00	online	completed	\N	\N
1508	503	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3140.47	2023-02-01 00:00:00+00	online	completed	\N	\N
1509	503	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2205.22	2023-03-01 00:00:00+00	online	completed	\N	\N
1510	504	9255fabc-799b-4cc7-8797-5f2470f6adf6	3035.23	2023-01-01 00:00:00+00	online	completed	\N	\N
1511	504	9255fabc-799b-4cc7-8797-5f2470f6adf6	2787.62	2023-02-01 00:00:00+00	online	completed	\N	\N
1512	504	9255fabc-799b-4cc7-8797-5f2470f6adf6	2047.17	2023-03-01 00:00:00+00	online	completed	\N	\N
1513	505	dd35da46-4416-412a-8a22-f3f39491bb7b	5473.25	2023-01-01 00:00:00+00	online	completed	\N	\N
1514	505	dd35da46-4416-412a-8a22-f3f39491bb7b	2043.73	2023-02-01 00:00:00+00	online	completed	\N	\N
1515	505	dd35da46-4416-412a-8a22-f3f39491bb7b	4569.88	2023-03-01 00:00:00+00	online	completed	\N	\N
1516	506	51072377-1472-46cb-b180-8542677f5eb2	4049.31	2023-01-01 00:00:00+00	online	completed	\N	\N
1517	506	51072377-1472-46cb-b180-8542677f5eb2	5461.96	2023-02-01 00:00:00+00	online	completed	\N	\N
1518	506	51072377-1472-46cb-b180-8542677f5eb2	1333.59	2023-03-01 00:00:00+00	online	completed	\N	\N
1519	507	5432f125-2d5e-42ab-849a-29add2cf0a74	5704.79	2023-01-01 00:00:00+00	online	completed	\N	\N
1520	507	5432f125-2d5e-42ab-849a-29add2cf0a74	4305.68	2023-02-01 00:00:00+00	online	completed	\N	\N
1521	507	5432f125-2d5e-42ab-849a-29add2cf0a74	5813.90	2023-03-01 00:00:00+00	online	completed	\N	\N
1522	508	a602c1a3-89cf-44a4-b419-f6827ad3701b	5464.34	2023-01-01 00:00:00+00	online	completed	\N	\N
1523	508	a602c1a3-89cf-44a4-b419-f6827ad3701b	4321.17	2023-02-01 00:00:00+00	online	completed	\N	\N
1524	508	a602c1a3-89cf-44a4-b419-f6827ad3701b	5969.21	2023-03-01 00:00:00+00	online	completed	\N	\N
1525	509	51072377-1472-46cb-b180-8542677f5eb2	1411.61	2023-01-01 00:00:00+00	online	completed	\N	\N
1526	509	51072377-1472-46cb-b180-8542677f5eb2	3984.10	2023-02-01 00:00:00+00	online	completed	\N	\N
1527	509	51072377-1472-46cb-b180-8542677f5eb2	2029.86	2023-03-01 00:00:00+00	online	completed	\N	\N
1528	510	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2066.88	2023-01-01 00:00:00+00	online	completed	\N	\N
1529	510	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3254.97	2023-02-01 00:00:00+00	online	completed	\N	\N
1530	510	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1219.83	2023-03-01 00:00:00+00	online	completed	\N	\N
1531	511	77e168c1-05e0-4314-8a24-5e838350a3d8	3513.61	2023-01-01 00:00:00+00	online	completed	\N	\N
1532	511	77e168c1-05e0-4314-8a24-5e838350a3d8	3938.73	2023-02-01 00:00:00+00	online	completed	\N	\N
1533	511	77e168c1-05e0-4314-8a24-5e838350a3d8	4482.93	2023-03-01 00:00:00+00	online	completed	\N	\N
1534	512	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5094.73	2023-01-01 00:00:00+00	online	completed	\N	\N
1535	512	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4043.15	2023-02-01 00:00:00+00	online	completed	\N	\N
1536	512	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3858.11	2023-03-01 00:00:00+00	online	completed	\N	\N
1537	513	dbbbe49c-e100-4576-b406-320908c8873e	5465.47	2023-01-01 00:00:00+00	online	completed	\N	\N
1538	513	dbbbe49c-e100-4576-b406-320908c8873e	4196.52	2023-02-01 00:00:00+00	online	completed	\N	\N
1539	513	dbbbe49c-e100-4576-b406-320908c8873e	5104.44	2023-03-01 00:00:00+00	online	completed	\N	\N
1540	514	a602c1a3-89cf-44a4-b419-f6827ad3701b	3072.77	2023-01-01 00:00:00+00	online	completed	\N	\N
1541	514	a602c1a3-89cf-44a4-b419-f6827ad3701b	1560.73	2023-02-01 00:00:00+00	online	completed	\N	\N
1542	514	a602c1a3-89cf-44a4-b419-f6827ad3701b	4001.06	2023-03-01 00:00:00+00	online	completed	\N	\N
1543	515	8088628d-f77a-430d-b228-cc3649b8a3e1	3560.67	2023-01-01 00:00:00+00	online	completed	\N	\N
1544	515	8088628d-f77a-430d-b228-cc3649b8a3e1	3318.94	2023-02-01 00:00:00+00	online	completed	\N	\N
1545	515	8088628d-f77a-430d-b228-cc3649b8a3e1	5931.60	2023-03-01 00:00:00+00	online	completed	\N	\N
1546	516	8088628d-f77a-430d-b228-cc3649b8a3e1	3633.15	2023-01-01 00:00:00+00	online	completed	\N	\N
1547	516	8088628d-f77a-430d-b228-cc3649b8a3e1	2193.84	2023-02-01 00:00:00+00	online	completed	\N	\N
1548	516	8088628d-f77a-430d-b228-cc3649b8a3e1	5645.69	2023-03-01 00:00:00+00	online	completed	\N	\N
1549	517	dbbbe49c-e100-4576-b406-320908c8873e	1802.36	2023-01-01 00:00:00+00	online	completed	\N	\N
1550	517	dbbbe49c-e100-4576-b406-320908c8873e	3429.94	2023-02-01 00:00:00+00	online	completed	\N	\N
1551	517	dbbbe49c-e100-4576-b406-320908c8873e	3771.00	2023-03-01 00:00:00+00	online	completed	\N	\N
1552	518	dde964d6-6ffa-4b25-97b6-128969afe47c	4958.17	2023-01-01 00:00:00+00	online	completed	\N	\N
1553	518	dde964d6-6ffa-4b25-97b6-128969afe47c	5534.00	2023-02-01 00:00:00+00	online	completed	\N	\N
1554	518	dde964d6-6ffa-4b25-97b6-128969afe47c	5736.23	2023-03-01 00:00:00+00	online	completed	\N	\N
1555	519	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1314.37	2023-01-01 00:00:00+00	online	completed	\N	\N
1556	519	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2989.91	2023-02-01 00:00:00+00	online	completed	\N	\N
1557	519	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5027.53	2023-03-01 00:00:00+00	online	completed	\N	\N
1558	520	9255fabc-799b-4cc7-8797-5f2470f6adf6	1267.22	2023-01-01 00:00:00+00	online	completed	\N	\N
1559	520	9255fabc-799b-4cc7-8797-5f2470f6adf6	4653.93	2023-02-01 00:00:00+00	online	completed	\N	\N
1560	520	9255fabc-799b-4cc7-8797-5f2470f6adf6	4153.08	2023-03-01 00:00:00+00	online	completed	\N	\N
1561	521	a602c1a3-89cf-44a4-b419-f6827ad3701b	1017.52	2023-01-01 00:00:00+00	online	completed	\N	\N
1562	521	a602c1a3-89cf-44a4-b419-f6827ad3701b	1657.21	2023-02-01 00:00:00+00	online	completed	\N	\N
1563	521	a602c1a3-89cf-44a4-b419-f6827ad3701b	1234.83	2023-03-01 00:00:00+00	online	completed	\N	\N
1564	522	a602c1a3-89cf-44a4-b419-f6827ad3701b	1761.66	2023-01-01 00:00:00+00	online	completed	\N	\N
1565	522	a602c1a3-89cf-44a4-b419-f6827ad3701b	3618.45	2023-02-01 00:00:00+00	online	completed	\N	\N
1566	522	a602c1a3-89cf-44a4-b419-f6827ad3701b	2547.31	2023-03-01 00:00:00+00	online	completed	\N	\N
1567	523	9255fabc-799b-4cc7-8797-5f2470f6adf6	2564.06	2023-01-01 00:00:00+00	online	completed	\N	\N
1568	523	9255fabc-799b-4cc7-8797-5f2470f6adf6	4237.56	2023-02-01 00:00:00+00	online	completed	\N	\N
1569	523	9255fabc-799b-4cc7-8797-5f2470f6adf6	4410.16	2023-03-01 00:00:00+00	online	completed	\N	\N
1570	524	5432f125-2d5e-42ab-849a-29add2cf0a74	5664.03	2023-01-01 00:00:00+00	online	completed	\N	\N
1571	524	5432f125-2d5e-42ab-849a-29add2cf0a74	3666.56	2023-02-01 00:00:00+00	online	completed	\N	\N
1572	524	5432f125-2d5e-42ab-849a-29add2cf0a74	2169.06	2023-03-01 00:00:00+00	online	completed	\N	\N
1573	525	77e168c1-05e0-4314-8a24-5e838350a3d8	5241.07	2023-01-01 00:00:00+00	online	completed	\N	\N
1574	525	77e168c1-05e0-4314-8a24-5e838350a3d8	1270.57	2023-02-01 00:00:00+00	online	completed	\N	\N
1575	525	77e168c1-05e0-4314-8a24-5e838350a3d8	3610.21	2023-03-01 00:00:00+00	online	completed	\N	\N
1576	526	584a1909-5797-4297-88d3-06bf5dc3922a	1669.09	2023-01-01 00:00:00+00	online	completed	\N	\N
1577	526	584a1909-5797-4297-88d3-06bf5dc3922a	4658.84	2023-02-01 00:00:00+00	online	completed	\N	\N
1578	526	584a1909-5797-4297-88d3-06bf5dc3922a	2229.19	2023-03-01 00:00:00+00	online	completed	\N	\N
1579	527	a602c1a3-89cf-44a4-b419-f6827ad3701b	4317.73	2023-01-01 00:00:00+00	online	completed	\N	\N
1580	527	a602c1a3-89cf-44a4-b419-f6827ad3701b	5690.77	2023-02-01 00:00:00+00	online	completed	\N	\N
1581	527	a602c1a3-89cf-44a4-b419-f6827ad3701b	5477.38	2023-03-01 00:00:00+00	online	completed	\N	\N
1582	528	463737cc-950b-4a41-8d73-a3daf931fee5	4081.42	2023-01-01 00:00:00+00	online	completed	\N	\N
1583	528	463737cc-950b-4a41-8d73-a3daf931fee5	1904.83	2023-02-01 00:00:00+00	online	completed	\N	\N
1584	528	463737cc-950b-4a41-8d73-a3daf931fee5	2001.53	2023-03-01 00:00:00+00	online	completed	\N	\N
1585	529	6ac1e176-e710-4b5e-9453-95765db20ba3	3737.89	2023-01-01 00:00:00+00	online	completed	\N	\N
1586	529	6ac1e176-e710-4b5e-9453-95765db20ba3	1555.55	2023-02-01 00:00:00+00	online	completed	\N	\N
1587	529	6ac1e176-e710-4b5e-9453-95765db20ba3	1090.31	2023-03-01 00:00:00+00	online	completed	\N	\N
1588	530	ee522e07-1315-4463-8a9b-f890b601c047	5766.63	2023-01-01 00:00:00+00	online	completed	\N	\N
1589	530	ee522e07-1315-4463-8a9b-f890b601c047	2160.48	2023-02-01 00:00:00+00	online	completed	\N	\N
1590	530	ee522e07-1315-4463-8a9b-f890b601c047	1039.47	2023-03-01 00:00:00+00	online	completed	\N	\N
1591	531	a83848ba-0779-4fac-98ee-f5f459b2742b	2533.71	2023-01-01 00:00:00+00	online	completed	\N	\N
1592	531	a83848ba-0779-4fac-98ee-f5f459b2742b	4011.24	2023-02-01 00:00:00+00	online	completed	\N	\N
1593	531	a83848ba-0779-4fac-98ee-f5f459b2742b	4323.07	2023-03-01 00:00:00+00	online	completed	\N	\N
1594	532	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4171.59	2023-01-01 00:00:00+00	online	completed	\N	\N
1595	532	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5911.07	2023-02-01 00:00:00+00	online	completed	\N	\N
1596	532	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3592.62	2023-03-01 00:00:00+00	online	completed	\N	\N
1597	533	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5998.29	2023-01-01 00:00:00+00	online	completed	\N	\N
1598	533	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5774.85	2023-02-01 00:00:00+00	online	completed	\N	\N
1599	533	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1795.23	2023-03-01 00:00:00+00	online	completed	\N	\N
1600	534	8088628d-f77a-430d-b228-cc3649b8a3e1	3047.84	2023-01-01 00:00:00+00	online	completed	\N	\N
1601	534	8088628d-f77a-430d-b228-cc3649b8a3e1	5550.78	2023-02-01 00:00:00+00	online	completed	\N	\N
1602	534	8088628d-f77a-430d-b228-cc3649b8a3e1	1144.81	2023-03-01 00:00:00+00	online	completed	\N	\N
1603	535	dd35da46-4416-412a-8a22-f3f39491bb7b	1478.55	2023-01-01 00:00:00+00	online	completed	\N	\N
1604	535	dd35da46-4416-412a-8a22-f3f39491bb7b	5947.51	2023-02-01 00:00:00+00	online	completed	\N	\N
1605	535	dd35da46-4416-412a-8a22-f3f39491bb7b	4618.76	2023-03-01 00:00:00+00	online	completed	\N	\N
1606	536	a602c1a3-89cf-44a4-b419-f6827ad3701b	5275.74	2023-01-01 00:00:00+00	online	completed	\N	\N
1607	536	a602c1a3-89cf-44a4-b419-f6827ad3701b	5674.44	2023-02-01 00:00:00+00	online	completed	\N	\N
1608	536	a602c1a3-89cf-44a4-b419-f6827ad3701b	3198.55	2023-03-01 00:00:00+00	online	completed	\N	\N
1609	537	ee522e07-1315-4463-8a9b-f890b601c047	2734.02	2023-01-01 00:00:00+00	online	completed	\N	\N
1610	537	ee522e07-1315-4463-8a9b-f890b601c047	2715.61	2023-02-01 00:00:00+00	online	completed	\N	\N
1611	537	ee522e07-1315-4463-8a9b-f890b601c047	2547.97	2023-03-01 00:00:00+00	online	completed	\N	\N
1612	538	dde964d6-6ffa-4b25-97b6-128969afe47c	1046.93	2023-01-01 00:00:00+00	online	completed	\N	\N
1613	538	dde964d6-6ffa-4b25-97b6-128969afe47c	3661.80	2023-02-01 00:00:00+00	online	completed	\N	\N
1614	538	dde964d6-6ffa-4b25-97b6-128969afe47c	3116.78	2023-03-01 00:00:00+00	online	completed	\N	\N
1615	539	dde964d6-6ffa-4b25-97b6-128969afe47c	3672.36	2023-01-01 00:00:00+00	online	completed	\N	\N
1616	539	dde964d6-6ffa-4b25-97b6-128969afe47c	5890.94	2023-02-01 00:00:00+00	online	completed	\N	\N
1617	539	dde964d6-6ffa-4b25-97b6-128969afe47c	2376.13	2023-03-01 00:00:00+00	online	completed	\N	\N
1618	540	9255fabc-799b-4cc7-8797-5f2470f6adf6	1267.82	2023-01-01 00:00:00+00	online	completed	\N	\N
1619	540	9255fabc-799b-4cc7-8797-5f2470f6adf6	1140.48	2023-02-01 00:00:00+00	online	completed	\N	\N
1620	540	9255fabc-799b-4cc7-8797-5f2470f6adf6	3934.45	2023-03-01 00:00:00+00	online	completed	\N	\N
1621	541	a602c1a3-89cf-44a4-b419-f6827ad3701b	5340.46	2023-01-01 00:00:00+00	online	completed	\N	\N
1622	541	a602c1a3-89cf-44a4-b419-f6827ad3701b	1425.86	2023-02-01 00:00:00+00	online	completed	\N	\N
1623	541	a602c1a3-89cf-44a4-b419-f6827ad3701b	1678.20	2023-03-01 00:00:00+00	online	completed	\N	\N
1624	542	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	4131.84	2023-01-01 00:00:00+00	online	completed	\N	\N
1625	542	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	4253.89	2023-02-01 00:00:00+00	online	completed	\N	\N
1626	542	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3513.93	2023-03-01 00:00:00+00	online	completed	\N	\N
1627	543	cff64755-2065-4e58-866f-f092cbd9e73b	1405.24	2023-01-01 00:00:00+00	online	completed	\N	\N
1628	543	cff64755-2065-4e58-866f-f092cbd9e73b	1542.19	2023-02-01 00:00:00+00	online	completed	\N	\N
1629	543	cff64755-2065-4e58-866f-f092cbd9e73b	5302.94	2023-03-01 00:00:00+00	online	completed	\N	\N
1630	544	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5345.76	2023-01-01 00:00:00+00	online	completed	\N	\N
1631	544	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2561.16	2023-02-01 00:00:00+00	online	completed	\N	\N
1632	544	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5900.66	2023-03-01 00:00:00+00	online	completed	\N	\N
1633	545	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2490.82	2023-01-01 00:00:00+00	online	completed	\N	\N
1634	545	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	4425.03	2023-02-01 00:00:00+00	online	completed	\N	\N
1635	545	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2450.24	2023-03-01 00:00:00+00	online	completed	\N	\N
1636	546	dbbbe49c-e100-4576-b406-320908c8873e	1908.95	2023-01-01 00:00:00+00	online	completed	\N	\N
1637	546	dbbbe49c-e100-4576-b406-320908c8873e	4287.77	2023-02-01 00:00:00+00	online	completed	\N	\N
1638	546	dbbbe49c-e100-4576-b406-320908c8873e	1937.28	2023-03-01 00:00:00+00	online	completed	\N	\N
1639	547	463737cc-950b-4a41-8d73-a3daf931fee5	1162.43	2023-01-01 00:00:00+00	online	completed	\N	\N
1640	547	463737cc-950b-4a41-8d73-a3daf931fee5	4526.89	2023-02-01 00:00:00+00	online	completed	\N	\N
1641	547	463737cc-950b-4a41-8d73-a3daf931fee5	2942.16	2023-03-01 00:00:00+00	online	completed	\N	\N
1642	548	dd35da46-4416-412a-8a22-f3f39491bb7b	5736.93	2023-01-01 00:00:00+00	online	completed	\N	\N
1643	548	dd35da46-4416-412a-8a22-f3f39491bb7b	2454.52	2023-02-01 00:00:00+00	online	completed	\N	\N
1644	548	dd35da46-4416-412a-8a22-f3f39491bb7b	4386.99	2023-03-01 00:00:00+00	online	completed	\N	\N
1645	549	dd35da46-4416-412a-8a22-f3f39491bb7b	5722.70	2023-01-01 00:00:00+00	online	completed	\N	\N
1646	549	dd35da46-4416-412a-8a22-f3f39491bb7b	5471.61	2023-02-01 00:00:00+00	online	completed	\N	\N
1647	549	dd35da46-4416-412a-8a22-f3f39491bb7b	2212.59	2023-03-01 00:00:00+00	online	completed	\N	\N
1648	550	51072377-1472-46cb-b180-8542677f5eb2	2890.70	2023-01-01 00:00:00+00	online	completed	\N	\N
1649	550	51072377-1472-46cb-b180-8542677f5eb2	2450.10	2023-02-01 00:00:00+00	online	completed	\N	\N
1650	550	51072377-1472-46cb-b180-8542677f5eb2	4458.10	2023-03-01 00:00:00+00	online	completed	\N	\N
1651	551	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3123.54	2023-01-01 00:00:00+00	online	completed	\N	\N
1652	551	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	5401.80	2023-02-01 00:00:00+00	online	completed	\N	\N
1653	551	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2756.38	2023-03-01 00:00:00+00	online	completed	\N	\N
1654	552	a83848ba-0779-4fac-98ee-f5f459b2742b	5091.40	2023-01-01 00:00:00+00	online	completed	\N	\N
1655	552	a83848ba-0779-4fac-98ee-f5f459b2742b	5048.38	2023-02-01 00:00:00+00	online	completed	\N	\N
1656	552	a83848ba-0779-4fac-98ee-f5f459b2742b	3793.73	2023-03-01 00:00:00+00	online	completed	\N	\N
1657	553	1934abf8-eca9-41d8-bc5f-9c649285b76b	5695.25	2023-01-01 00:00:00+00	online	completed	\N	\N
1658	553	1934abf8-eca9-41d8-bc5f-9c649285b76b	2094.71	2023-02-01 00:00:00+00	online	completed	\N	\N
1659	553	1934abf8-eca9-41d8-bc5f-9c649285b76b	1360.50	2023-03-01 00:00:00+00	online	completed	\N	\N
1660	554	dd35da46-4416-412a-8a22-f3f39491bb7b	2076.94	2023-01-01 00:00:00+00	online	completed	\N	\N
1661	554	dd35da46-4416-412a-8a22-f3f39491bb7b	3590.81	2023-02-01 00:00:00+00	online	completed	\N	\N
1662	554	dd35da46-4416-412a-8a22-f3f39491bb7b	2368.23	2023-03-01 00:00:00+00	online	completed	\N	\N
1663	555	cff64755-2065-4e58-866f-f092cbd9e73b	2468.02	2023-01-01 00:00:00+00	online	completed	\N	\N
1664	555	cff64755-2065-4e58-866f-f092cbd9e73b	2122.93	2023-02-01 00:00:00+00	online	completed	\N	\N
1665	555	cff64755-2065-4e58-866f-f092cbd9e73b	2698.07	2023-03-01 00:00:00+00	online	completed	\N	\N
1666	556	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5346.83	2023-01-01 00:00:00+00	online	completed	\N	\N
1667	556	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2352.68	2023-02-01 00:00:00+00	online	completed	\N	\N
1668	556	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1079.30	2023-03-01 00:00:00+00	online	completed	\N	\N
1669	557	da6ac18e-72e9-484a-ad75-d044260789cc	3657.44	2023-01-01 00:00:00+00	online	completed	\N	\N
1670	557	da6ac18e-72e9-484a-ad75-d044260789cc	4634.07	2023-02-01 00:00:00+00	online	completed	\N	\N
1671	557	da6ac18e-72e9-484a-ad75-d044260789cc	4634.67	2023-03-01 00:00:00+00	online	completed	\N	\N
1672	558	6833f990-6a38-4f28-aa18-e31697fa7dc9	2884.94	2023-01-01 00:00:00+00	online	completed	\N	\N
1673	558	6833f990-6a38-4f28-aa18-e31697fa7dc9	5479.94	2023-02-01 00:00:00+00	online	completed	\N	\N
1674	558	6833f990-6a38-4f28-aa18-e31697fa7dc9	4455.63	2023-03-01 00:00:00+00	online	completed	\N	\N
1675	559	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2482.70	2023-01-01 00:00:00+00	online	completed	\N	\N
1676	559	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1880.69	2023-02-01 00:00:00+00	online	completed	\N	\N
1677	559	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3974.74	2023-03-01 00:00:00+00	online	completed	\N	\N
1678	560	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1080.95	2023-01-01 00:00:00+00	online	completed	\N	\N
1679	560	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2818.54	2023-02-01 00:00:00+00	online	completed	\N	\N
1680	560	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3993.09	2023-03-01 00:00:00+00	online	completed	\N	\N
1681	561	da6ac18e-72e9-484a-ad75-d044260789cc	2810.74	2023-01-01 00:00:00+00	online	completed	\N	\N
1682	561	da6ac18e-72e9-484a-ad75-d044260789cc	2062.58	2023-02-01 00:00:00+00	online	completed	\N	\N
1683	561	da6ac18e-72e9-484a-ad75-d044260789cc	2679.38	2023-03-01 00:00:00+00	online	completed	\N	\N
1684	562	51072377-1472-46cb-b180-8542677f5eb2	1399.21	2023-01-01 00:00:00+00	online	completed	\N	\N
1685	562	51072377-1472-46cb-b180-8542677f5eb2	5385.05	2023-02-01 00:00:00+00	online	completed	\N	\N
1686	562	51072377-1472-46cb-b180-8542677f5eb2	4932.06	2023-03-01 00:00:00+00	online	completed	\N	\N
1687	563	6833f990-6a38-4f28-aa18-e31697fa7dc9	2021.69	2023-01-01 00:00:00+00	online	completed	\N	\N
1688	563	6833f990-6a38-4f28-aa18-e31697fa7dc9	4605.61	2023-02-01 00:00:00+00	online	completed	\N	\N
1689	563	6833f990-6a38-4f28-aa18-e31697fa7dc9	4488.62	2023-03-01 00:00:00+00	online	completed	\N	\N
1690	564	dd35da46-4416-412a-8a22-f3f39491bb7b	2248.25	2023-01-01 00:00:00+00	online	completed	\N	\N
1691	564	dd35da46-4416-412a-8a22-f3f39491bb7b	1361.36	2023-02-01 00:00:00+00	online	completed	\N	\N
1692	564	dd35da46-4416-412a-8a22-f3f39491bb7b	3924.33	2023-03-01 00:00:00+00	online	completed	\N	\N
1693	565	6833f990-6a38-4f28-aa18-e31697fa7dc9	4283.32	2023-01-01 00:00:00+00	online	completed	\N	\N
1694	565	6833f990-6a38-4f28-aa18-e31697fa7dc9	2544.62	2023-02-01 00:00:00+00	online	completed	\N	\N
1695	565	6833f990-6a38-4f28-aa18-e31697fa7dc9	4560.25	2023-03-01 00:00:00+00	online	completed	\N	\N
1696	566	ee522e07-1315-4463-8a9b-f890b601c047	4498.11	2023-01-01 00:00:00+00	online	completed	\N	\N
1697	566	ee522e07-1315-4463-8a9b-f890b601c047	3806.56	2023-02-01 00:00:00+00	online	completed	\N	\N
1698	566	ee522e07-1315-4463-8a9b-f890b601c047	4553.09	2023-03-01 00:00:00+00	online	completed	\N	\N
1699	567	1934abf8-eca9-41d8-bc5f-9c649285b76b	2557.85	2023-01-01 00:00:00+00	online	completed	\N	\N
1700	567	1934abf8-eca9-41d8-bc5f-9c649285b76b	1154.05	2023-02-01 00:00:00+00	online	completed	\N	\N
1701	567	1934abf8-eca9-41d8-bc5f-9c649285b76b	2436.09	2023-03-01 00:00:00+00	online	completed	\N	\N
1702	568	a602c1a3-89cf-44a4-b419-f6827ad3701b	1492.71	2023-01-01 00:00:00+00	online	completed	\N	\N
1703	568	a602c1a3-89cf-44a4-b419-f6827ad3701b	2917.62	2023-02-01 00:00:00+00	online	completed	\N	\N
1704	568	a602c1a3-89cf-44a4-b419-f6827ad3701b	3100.57	2023-03-01 00:00:00+00	online	completed	\N	\N
1705	569	b794e95a-97f4-4c05-aa2d-3c13c4155841	4731.76	2023-01-01 00:00:00+00	online	completed	\N	\N
1706	569	b794e95a-97f4-4c05-aa2d-3c13c4155841	5739.08	2023-02-01 00:00:00+00	online	completed	\N	\N
1707	569	b794e95a-97f4-4c05-aa2d-3c13c4155841	5376.49	2023-03-01 00:00:00+00	online	completed	\N	\N
1708	570	9255fabc-799b-4cc7-8797-5f2470f6adf6	3217.01	2023-01-01 00:00:00+00	online	completed	\N	\N
1709	570	9255fabc-799b-4cc7-8797-5f2470f6adf6	5570.85	2023-02-01 00:00:00+00	online	completed	\N	\N
1710	570	9255fabc-799b-4cc7-8797-5f2470f6adf6	2526.62	2023-03-01 00:00:00+00	online	completed	\N	\N
1711	571	463737cc-950b-4a41-8d73-a3daf931fee5	4300.36	2023-01-01 00:00:00+00	online	completed	\N	\N
1712	571	463737cc-950b-4a41-8d73-a3daf931fee5	4361.86	2023-02-01 00:00:00+00	online	completed	\N	\N
1713	571	463737cc-950b-4a41-8d73-a3daf931fee5	4121.91	2023-03-01 00:00:00+00	online	completed	\N	\N
1714	572	387d98f7-ccf9-4077-8f79-f0be51c40d05	3177.58	2023-01-01 00:00:00+00	online	completed	\N	\N
1715	572	387d98f7-ccf9-4077-8f79-f0be51c40d05	4320.15	2023-02-01 00:00:00+00	online	completed	\N	\N
1716	572	387d98f7-ccf9-4077-8f79-f0be51c40d05	5825.04	2023-03-01 00:00:00+00	online	completed	\N	\N
1717	573	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5224.51	2023-01-01 00:00:00+00	online	completed	\N	\N
1718	573	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1910.44	2023-02-01 00:00:00+00	online	completed	\N	\N
1719	573	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1188.49	2023-03-01 00:00:00+00	online	completed	\N	\N
1720	574	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4304.27	2023-01-01 00:00:00+00	online	completed	\N	\N
1721	574	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5248.85	2023-02-01 00:00:00+00	online	completed	\N	\N
1722	574	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1741.20	2023-03-01 00:00:00+00	online	completed	\N	\N
1723	575	ee522e07-1315-4463-8a9b-f890b601c047	5477.03	2023-01-01 00:00:00+00	online	completed	\N	\N
1724	575	ee522e07-1315-4463-8a9b-f890b601c047	1100.03	2023-02-01 00:00:00+00	online	completed	\N	\N
1725	575	ee522e07-1315-4463-8a9b-f890b601c047	2506.24	2023-03-01 00:00:00+00	online	completed	\N	\N
1726	576	a83848ba-0779-4fac-98ee-f5f459b2742b	1763.15	2023-01-01 00:00:00+00	online	completed	\N	\N
1727	576	a83848ba-0779-4fac-98ee-f5f459b2742b	5409.82	2023-02-01 00:00:00+00	online	completed	\N	\N
1728	576	a83848ba-0779-4fac-98ee-f5f459b2742b	5853.62	2023-03-01 00:00:00+00	online	completed	\N	\N
1729	577	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3684.98	2023-01-01 00:00:00+00	online	completed	\N	\N
1730	577	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3611.40	2023-02-01 00:00:00+00	online	completed	\N	\N
1731	577	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5621.30	2023-03-01 00:00:00+00	online	completed	\N	\N
1732	578	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5228.33	2023-01-01 00:00:00+00	online	completed	\N	\N
1733	578	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5239.01	2023-02-01 00:00:00+00	online	completed	\N	\N
1734	578	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3421.30	2023-03-01 00:00:00+00	online	completed	\N	\N
1735	579	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2030.85	2023-01-01 00:00:00+00	online	completed	\N	\N
1736	579	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5886.71	2023-02-01 00:00:00+00	online	completed	\N	\N
1737	579	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4591.76	2023-03-01 00:00:00+00	online	completed	\N	\N
1738	580	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4360.59	2023-01-01 00:00:00+00	online	completed	\N	\N
1739	580	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3811.16	2023-02-01 00:00:00+00	online	completed	\N	\N
1740	580	fd99f59b-fcc6-42ef-a407-207f110f2d7b	1234.72	2023-03-01 00:00:00+00	online	completed	\N	\N
1741	581	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5411.65	2023-01-01 00:00:00+00	online	completed	\N	\N
1742	581	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5031.75	2023-02-01 00:00:00+00	online	completed	\N	\N
1743	581	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3063.57	2023-03-01 00:00:00+00	online	completed	\N	\N
1744	582	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5801.03	2023-01-01 00:00:00+00	online	completed	\N	\N
1745	582	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5427.31	2023-02-01 00:00:00+00	online	completed	\N	\N
1746	582	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3317.81	2023-03-01 00:00:00+00	online	completed	\N	\N
1747	583	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3645.22	2023-01-01 00:00:00+00	online	completed	\N	\N
1748	583	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2773.95	2023-02-01 00:00:00+00	online	completed	\N	\N
1749	583	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2516.37	2023-03-01 00:00:00+00	online	completed	\N	\N
1750	584	a83848ba-0779-4fac-98ee-f5f459b2742b	3815.74	2023-01-01 00:00:00+00	online	completed	\N	\N
1751	584	a83848ba-0779-4fac-98ee-f5f459b2742b	5692.72	2023-02-01 00:00:00+00	online	completed	\N	\N
1752	584	a83848ba-0779-4fac-98ee-f5f459b2742b	1597.51	2023-03-01 00:00:00+00	online	completed	\N	\N
1753	585	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2462.91	2023-01-01 00:00:00+00	online	completed	\N	\N
1754	585	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3351.10	2023-02-01 00:00:00+00	online	completed	\N	\N
1755	585	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2805.86	2023-03-01 00:00:00+00	online	completed	\N	\N
1756	586	51072377-1472-46cb-b180-8542677f5eb2	5404.77	2023-01-01 00:00:00+00	online	completed	\N	\N
1757	586	51072377-1472-46cb-b180-8542677f5eb2	1420.99	2023-02-01 00:00:00+00	online	completed	\N	\N
1758	586	51072377-1472-46cb-b180-8542677f5eb2	3735.40	2023-03-01 00:00:00+00	online	completed	\N	\N
1759	587	9255fabc-799b-4cc7-8797-5f2470f6adf6	3111.82	2023-01-01 00:00:00+00	online	completed	\N	\N
1760	587	9255fabc-799b-4cc7-8797-5f2470f6adf6	3214.45	2023-02-01 00:00:00+00	online	completed	\N	\N
1761	587	9255fabc-799b-4cc7-8797-5f2470f6adf6	5748.84	2023-03-01 00:00:00+00	online	completed	\N	\N
1762	588	dd35da46-4416-412a-8a22-f3f39491bb7b	5698.35	2023-01-01 00:00:00+00	online	completed	\N	\N
1763	588	dd35da46-4416-412a-8a22-f3f39491bb7b	2632.64	2023-02-01 00:00:00+00	online	completed	\N	\N
1764	588	dd35da46-4416-412a-8a22-f3f39491bb7b	3758.02	2023-03-01 00:00:00+00	online	completed	\N	\N
1765	589	dbbbe49c-e100-4576-b406-320908c8873e	4888.46	2023-01-01 00:00:00+00	online	completed	\N	\N
1766	589	dbbbe49c-e100-4576-b406-320908c8873e	1989.91	2023-02-01 00:00:00+00	online	completed	\N	\N
1767	589	dbbbe49c-e100-4576-b406-320908c8873e	5099.28	2023-03-01 00:00:00+00	online	completed	\N	\N
1768	590	a602c1a3-89cf-44a4-b419-f6827ad3701b	5659.64	2023-01-01 00:00:00+00	online	completed	\N	\N
1769	590	a602c1a3-89cf-44a4-b419-f6827ad3701b	5884.23	2023-02-01 00:00:00+00	online	completed	\N	\N
1770	590	a602c1a3-89cf-44a4-b419-f6827ad3701b	3159.66	2023-03-01 00:00:00+00	online	completed	\N	\N
1771	591	dd35da46-4416-412a-8a22-f3f39491bb7b	5203.67	2023-01-01 00:00:00+00	online	completed	\N	\N
1772	591	dd35da46-4416-412a-8a22-f3f39491bb7b	5807.02	2023-02-01 00:00:00+00	online	completed	\N	\N
1773	591	dd35da46-4416-412a-8a22-f3f39491bb7b	2282.70	2023-03-01 00:00:00+00	online	completed	\N	\N
1774	592	da6ac18e-72e9-484a-ad75-d044260789cc	5776.66	2023-01-01 00:00:00+00	online	completed	\N	\N
1775	592	da6ac18e-72e9-484a-ad75-d044260789cc	1887.87	2023-02-01 00:00:00+00	online	completed	\N	\N
1776	592	da6ac18e-72e9-484a-ad75-d044260789cc	1249.13	2023-03-01 00:00:00+00	online	completed	\N	\N
1777	593	dbbbe49c-e100-4576-b406-320908c8873e	2229.97	2023-01-01 00:00:00+00	online	completed	\N	\N
1778	593	dbbbe49c-e100-4576-b406-320908c8873e	1806.13	2023-02-01 00:00:00+00	online	completed	\N	\N
1779	593	dbbbe49c-e100-4576-b406-320908c8873e	3171.84	2023-03-01 00:00:00+00	online	completed	\N	\N
1780	594	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1316.04	2023-01-01 00:00:00+00	online	completed	\N	\N
1781	594	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5749.76	2023-02-01 00:00:00+00	online	completed	\N	\N
1782	594	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4304.05	2023-03-01 00:00:00+00	online	completed	\N	\N
1783	595	584a1909-5797-4297-88d3-06bf5dc3922a	4130.52	2023-01-01 00:00:00+00	online	completed	\N	\N
1784	595	584a1909-5797-4297-88d3-06bf5dc3922a	5686.49	2023-02-01 00:00:00+00	online	completed	\N	\N
1785	595	584a1909-5797-4297-88d3-06bf5dc3922a	2783.71	2023-03-01 00:00:00+00	online	completed	\N	\N
1786	596	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3929.55	2023-01-01 00:00:00+00	online	completed	\N	\N
1787	596	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5155.96	2023-02-01 00:00:00+00	online	completed	\N	\N
1788	596	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5265.50	2023-03-01 00:00:00+00	online	completed	\N	\N
1789	597	463737cc-950b-4a41-8d73-a3daf931fee5	3533.60	2023-01-01 00:00:00+00	online	completed	\N	\N
1790	597	463737cc-950b-4a41-8d73-a3daf931fee5	4232.75	2023-02-01 00:00:00+00	online	completed	\N	\N
1791	597	463737cc-950b-4a41-8d73-a3daf931fee5	3700.51	2023-03-01 00:00:00+00	online	completed	\N	\N
1792	598	fc7c7272-6d55-49a3-88d7-fc37133a103f	1298.63	2023-01-01 00:00:00+00	online	completed	\N	\N
1793	598	fc7c7272-6d55-49a3-88d7-fc37133a103f	1590.68	2023-02-01 00:00:00+00	online	completed	\N	\N
1794	598	fc7c7272-6d55-49a3-88d7-fc37133a103f	5801.70	2023-03-01 00:00:00+00	online	completed	\N	\N
1795	599	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5580.29	2023-01-01 00:00:00+00	online	completed	\N	\N
1796	599	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5320.74	2023-02-01 00:00:00+00	online	completed	\N	\N
1797	599	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3464.73	2023-03-01 00:00:00+00	online	completed	\N	\N
1798	600	a602c1a3-89cf-44a4-b419-f6827ad3701b	5582.50	2023-01-01 00:00:00+00	online	completed	\N	\N
1799	600	a602c1a3-89cf-44a4-b419-f6827ad3701b	3516.53	2023-02-01 00:00:00+00	online	completed	\N	\N
1800	600	a602c1a3-89cf-44a4-b419-f6827ad3701b	1222.28	2023-03-01 00:00:00+00	online	completed	\N	\N
1801	601	a83848ba-0779-4fac-98ee-f5f459b2742b	2111.00	2025-02-06 00:00:00+00	offline	completed	\N	\N
1802	602	51072377-1472-46cb-b180-8542677f5eb2	20102.00	2025-02-05 00:00:00+00	offline	completed	\N	\N
1803	603	dd35da46-4416-412a-8a22-f3f39491bb7b	1999.00	2025-02-06 00:00:00+00	offline	completed	\N	\N
1804	550	dd35da46-4416-412a-8a22-f3f39491bb7b	2011.00	2025-02-09 00:00:00+00	offline	completed	\N	\N
1805	604	dd35da46-4416-412a-8a22-f3f39491bb7b	9191.00	2025-02-04 00:00:00+00	offline	completed	\N	\N
1806	602	dd35da46-4416-412a-8a22-f3f39491bb7b	29191.00	2025-02-06 00:00:00+00	offline	completed	\N	\N
1807	603	dd35da46-4416-412a-8a22-f3f39491bb7b	2211.00	2025-02-12 00:00:00+00	offline	completed	\N	\N
1808	605	dd35da46-4416-412a-8a22-f3f39491bb7b	2919.00	2025-02-08 00:00:00+00	offline	completed	\N	\N
1809	605	dd35da46-4416-412a-8a22-f3f39491bb7b	22111.00	2025-02-08 00:00:00+00	offline	completed	faafafaa	\N
1810	605	dd35da46-4416-412a-8a22-f3f39491bb7b	22112.00	2025-02-09 00:00:00+00	offline	completed	JEJE BONEL	\N
1811	605	dd35da46-4416-412a-8a22-f3f39491bb7b	22211.00	2025-02-08 00:00:00+00	offline	completed	yeboa	\N
1812	605	dd35da46-4416-412a-8a22-f3f39491bb7b	91911.00	2025-02-07 00:00:00+00	offline	completed	fafafafafffff	\N
1813	605	dd35da46-4416-412a-8a22-f3f39491bb7b	29112.00	2025-02-07 00:00:00+00	offline	completed	faffa llkk	\N
1814	605	dd35da46-4416-412a-8a22-f3f39491bb7b	1288.00	2025-02-08 00:00:00+00	offline	completed	kkeee	\N
1815	605	dd35da46-4416-412a-8a22-f3f39491bb7b	22112.00	2025-02-08 00:00:00+00	offline	completed	aaaaaaa	\N
1816	605	dd35da46-4416-412a-8a22-f3f39491bb7b	1122.00	2025-02-08 00:00:00+00	offline	completed	ffaaaffffff	\N
1817	605	dd35da46-4416-412a-8a22-f3f39491bb7b	9999.00	2025-02-08 00:00:00+00	offline	completed	fafffffffaaxxx	\N
1818	605	dd35da46-4416-412a-8a22-f3f39491bb7b	3333.00	2025-02-05 00:00:00+00	offline	completed	faffaaa	\N
1819	605	dd35da46-4416-412a-8a22-f3f39491bb7b	55555.00	2025-02-08 00:00:00+00	offline	completed	fa44114141	\N
1820	605	dd35da46-4416-412a-8a22-f3f39491bb7b	22114.00	2025-02-08 00:00:00+00	offline	completed	fafafaaff1212314	\N
1821	602	dd35da46-4416-412a-8a22-f3f39491bb7b	2477.00	2025-02-05 00:00:00+00	offline	completed	fafafff	\N
1822	603	dd35da46-4416-412a-8a22-f3f39491bb7b	2000.00	2025-02-12 10:01:31.167+00	offline	completed	\N	\N
1823	88	dd35da46-4416-412a-8a22-f3f39491bb7b	1000.00	2025-02-12 10:01:31.167+00	offline	completed	\N	\N
1824	185	dd35da46-4416-412a-8a22-f3f39491bb7b	6000.00	2025-02-12 10:01:31.167+00	offline	completed	\N	\N
1825	54	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2222.00	2025-02-12 15:47:22.146+00	offline	completed	\N	\N
1826	144	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	22222.00	2025-02-12 15:47:29.452+00	offline	completed	\N	\N
1827	118	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	22222.00	2025-02-12 15:48:20.289+00	offline	completed	\N	\N
1828	144	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	22222.00	2025-02-12 15:48:20.289+00	offline	completed	\N	\N
1829	118	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3131.00	2025-02-12 15:48:20.289+00	offline	completed	\N	\N
1830	144	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	22222.00	2025-02-12 15:48:50.844+00	offline	completed	\N	\N
1831	604	dd35da46-4416-412a-8a22-f3f39491bb7b	2000.00	2025-02-17 07:11:33.548+00	offline	completed	\N	\N
1832	604	dd35da46-4416-412a-8a22-f3f39491bb7b	2000.00	2025-02-17 07:12:21.911+00	offline	completed	\N	\N
1833	602	dd35da46-4416-412a-8a22-f3f39491bb7b	2000.00	2025-02-17 07:12:21.911+00	offline	completed	\N	\N
1834	605	dd35da46-4416-412a-8a22-f3f39491bb7b	5000.00	2025-02-17 07:12:21.911+00	offline	completed	\N	\N
1835	1	dd35da46-4416-412a-8a22-f3f39491bb7b	1000.00	2025-02-17 09:12:19.056+00	offline	completed	\N	\N
1836	648	dd35da46-4416-412a-8a22-f3f39491bb7b	1000.00	2025-02-17 09:12:19.056+00	offline	completed	\N	\N
1837	649	dd35da46-4416-412a-8a22-f3f39491bb7b	9000.00	2025-02-17 09:14:11.609+00	offline	completed	\N	\N
1838	649	dd35da46-4416-412a-8a22-f3f39491bb7b	2000.00	2025-02-17 09:18:28.271+00	offline	completed	\N	\N
1839	602	dd35da46-4416-412a-8a22-f3f39491bb7b	5000.00	2025-02-17 09:18:28.271+00	offline	completed	\N	\N
1840	605	dd35da46-4416-412a-8a22-f3f39491bb7b	3000.00	2025-02-17 09:18:28.271+00	offline	completed	\N	\N
1841	1	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	1000.00	2025-02-19 15:53:07.55+00	offline	completed	\N	\N
1842	602	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	4000.00	2025-02-19 15:53:07.55+00	offline	completed	\N	\N
1843	605	aefe15fe-4937-4f55-a6cb-fb8d739c5905	10000.00	2025-02-19 15:57:42.741+00	offline	completed	\N	\N
1874	605	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	20000.00	2025-02-20 00:00:00+00	offline	completed	Dami pera boss	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4
1875	602	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	15000.00	2025-02-20 00:00:00+00	offline	completed	yebah	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4
1876	605	aefe15fe-4937-4f55-a6cb-fb8d739c5905	13000.00	2025-02-20 00:00:00+00	offline	completed	bonus	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4
1877	605	aefe15fe-4937-4f55-a6cb-fb8d739c5905	10000.00	2025-02-27 00:00:00+00	offline	completed	benggbeng	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4
1878	605	aefe15fe-4937-4f55-a6cb-fb8d739c5905	5000.00	2025-02-20 00:00:00+00	offline	completed	fafaff	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4
1879	650	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	20000.00	2025-02-21 00:00:00+00	offline	completed	ghahhh	\N
1880	651	aefe15fe-4937-4f55-a6cb-fb8d739c5905	20000.00	2025-02-20 00:00:00+00	offline	completed	fga12234	\N
1886	605	ee522e07-1315-4463-8a9b-f890b601c047	31414.00	2025-02-20 00:00:00+00	offline	completed	fdfasdf	\N
1892	605	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2222.00	2025-02-20 00:00:00+00	offline	completed		\N
1893	2	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	241.00	2025-02-20 00:00:00+00	offline	completed		f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4
1894	21	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	21455.00	2025-02-20 00:00:00+00	offline	completed		f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4
1895	12	aefe15fe-4937-4f55-a6cb-fb8d739c5905	44114.00	2025-02-20 00:00:00+00	offline	completed	hhhhhh	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4
1897	651	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	5000.00	2025-02-20 08:14:21.416+00	offline	completed	\N	\N
1898	652	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	5000.00	2025-02-20 08:14:21.416+00	offline	completed	\N	\N
\.


--
-- Data for Name: leave_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leave_requests (id, requester_id, start_date, end_date, reason, status, campus_director_approval, lead_pastor_approval, created_at, updated_at, type, campus_director_notes, lead_pastor_notes) FROM stdin;
1	dd35da46-4416-412a-8a22-f3f39491bb7b	2025-02-19	2025-02-27	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
2	dd35da46-4416-412a-8a22-f3f39491bb7b	2025-02-05	2025-02-13	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
3	dd35da46-4416-412a-8a22-f3f39491bb7b	2025-02-22	2025-03-01	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
4	dd35da46-4416-412a-8a22-f3f39491bb7b	2025-02-04	2025-02-06	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
5	dd35da46-4416-412a-8a22-f3f39491bb7b	2025-02-13	2025-02-14	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
9	a83848ba-0779-4fac-98ee-f5f459b2742b	2025-02-26	2025-02-26	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
12	51072377-1472-46cb-b180-8542677f5eb2	2025-02-10	2025-02-19	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
13	51072377-1472-46cb-b180-8542677f5eb2	2025-02-05	2025-02-11	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
14	51072377-1472-46cb-b180-8542677f5eb2	2025-02-26	2025-03-01	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
15	51072377-1472-46cb-b180-8542677f5eb2	2025-02-06	2025-02-10	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
16	9255fabc-799b-4cc7-8797-5f2470f6adf6	2025-02-23	2025-03-05	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
17	9255fabc-799b-4cc7-8797-5f2470f6adf6	2025-02-18	2025-02-24	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
18	9255fabc-799b-4cc7-8797-5f2470f6adf6	2025-02-25	2025-03-07	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
19	9255fabc-799b-4cc7-8797-5f2470f6adf6	2025-03-02	2025-03-08	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
20	9255fabc-799b-4cc7-8797-5f2470f6adf6	2025-02-22	2025-02-24	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
21	6833f990-6a38-4f28-aa18-e31697fa7dc9	2025-02-20	2025-02-28	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
22	6833f990-6a38-4f28-aa18-e31697fa7dc9	2025-02-21	2025-02-28	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
23	6833f990-6a38-4f28-aa18-e31697fa7dc9	2025-02-15	2025-02-24	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
24	6833f990-6a38-4f28-aa18-e31697fa7dc9	2025-02-19	2025-02-23	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
25	6833f990-6a38-4f28-aa18-e31697fa7dc9	2025-02-15	2025-02-24	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
26	6ac1e176-e710-4b5e-9453-95765db20ba3	2025-02-18	2025-02-26	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
27	6ac1e176-e710-4b5e-9453-95765db20ba3	2025-03-01	2025-03-08	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
28	6ac1e176-e710-4b5e-9453-95765db20ba3	2025-02-08	2025-02-08	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
29	6ac1e176-e710-4b5e-9453-95765db20ba3	2025-02-15	2025-02-21	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
30	6ac1e176-e710-4b5e-9453-95765db20ba3	2025-03-04	2025-03-07	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
32	463737cc-950b-4a41-8d73-a3daf931fee5	2025-02-18	2025-02-24	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
36	8088628d-f77a-430d-b228-cc3649b8a3e1	2025-02-25	2025-02-27	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
37	8088628d-f77a-430d-b228-cc3649b8a3e1	2025-03-02	2025-03-08	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
38	8088628d-f77a-430d-b228-cc3649b8a3e1	2025-02-07	2025-02-12	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
39	8088628d-f77a-430d-b228-cc3649b8a3e1	2025-02-04	2025-02-11	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
40	8088628d-f77a-430d-b228-cc3649b8a3e1	2025-02-25	2025-03-02	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
46	a602c1a3-89cf-44a4-b419-f6827ad3701b	2025-03-02	2025-03-08	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
48	a602c1a3-89cf-44a4-b419-f6827ad3701b	2025-02-17	2025-02-25	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
51	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2025-03-04	2025-03-09	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
52	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2025-02-18	2025-02-24	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
53	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2025-02-05	2025-02-10	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
54	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2025-02-09	2025-02-16	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
55	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2025-03-06	2025-03-14	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
56	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2025-03-03	2025-03-06	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
58	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2025-02-12	2025-02-17	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
60	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2025-02-15	2025-02-24	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
61	dde964d6-6ffa-4b25-97b6-128969afe47c	2025-02-26	2025-02-28	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
41	da6ac18e-72e9-484a-ad75-d044260789cc	2025-02-23	2025-02-24	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	ok go	\N
42	da6ac18e-72e9-484a-ad75-d044260789cc	2025-02-18	2025-02-19	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
11	51072377-1472-46cb-b180-8542677f5eb2	2025-02-16	2025-02-26	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	ppeeoppp	\N
7	a83848ba-0779-4fac-98ee-f5f459b2742b	2025-03-03	2025-03-06	Leave for personal reasons	approved	approved	override-approved	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	YESSIR	Go ahead surely
34	463737cc-950b-4a41-8d73-a3daf931fee5	2025-02-12	2025-02-19	Leave for personal reasons	approved	none	approved	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	sige go langg
35	463737cc-950b-4a41-8d73-a3daf931fee5	2025-03-01	2025-03-04	Leave for personal reasons	approved	none	approved	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	Go lang brodie
33	463737cc-950b-4a41-8d73-a3daf931fee5	2025-02-26	2025-03-07	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	I TRUST U BRO
43	da6ac18e-72e9-484a-ad75-d044260789cc	2025-03-02	2025-03-04	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
44	da6ac18e-72e9-484a-ad75-d044260789cc	2025-02-13	2025-02-17	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
45	da6ac18e-72e9-484a-ad75-d044260789cc	2025-02-19	2025-02-21	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
47	a602c1a3-89cf-44a4-b419-f6827ad3701b	2025-02-10	2025-02-17	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
49	a602c1a3-89cf-44a4-b419-f6827ad3701b	2025-02-05	2025-02-07	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
50	a602c1a3-89cf-44a4-b419-f6827ad3701b	2025-02-16	2025-02-23	Leave for personal reasons	pending	rejected	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
57	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2025-02-27	2025-03-06	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
10	a83848ba-0779-4fac-98ee-f5f459b2742b	2025-02-19	2025-02-20	Leave for personal reasons	approved	approved	approved	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	sure sure ikaw pa	okidokidok
62	dde964d6-6ffa-4b25-97b6-128969afe47c	2025-02-25	2025-02-26	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
63	dde964d6-6ffa-4b25-97b6-128969afe47c	2025-02-28	2025-03-06	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
64	dde964d6-6ffa-4b25-97b6-128969afe47c	2025-02-21	2025-02-24	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
65	dde964d6-6ffa-4b25-97b6-128969afe47c	2025-02-22	2025-03-02	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
71	5432f125-2d5e-42ab-849a-29add2cf0a74	2025-02-10	2025-02-13	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
72	5432f125-2d5e-42ab-849a-29add2cf0a74	2025-02-10	2025-02-18	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
73	5432f125-2d5e-42ab-849a-29add2cf0a74	2025-02-12	2025-02-18	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
74	5432f125-2d5e-42ab-849a-29add2cf0a74	2025-02-23	2025-02-24	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
75	5432f125-2d5e-42ab-849a-29add2cf0a74	2025-02-21	2025-02-25	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
76	bd38508e-8797-4220-ae2e-dd7883b41f17	2025-02-24	2025-02-27	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
78	bd38508e-8797-4220-ae2e-dd7883b41f17	2025-02-14	2025-02-16	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
79	bd38508e-8797-4220-ae2e-dd7883b41f17	2025-02-16	2025-02-16	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
81	fc7c7272-6d55-49a3-88d7-fc37133a103f	2025-02-26	2025-03-07	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
82	fc7c7272-6d55-49a3-88d7-fc37133a103f	2025-02-27	2025-03-05	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
83	fc7c7272-6d55-49a3-88d7-fc37133a103f	2025-02-21	2025-02-28	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
84	fc7c7272-6d55-49a3-88d7-fc37133a103f	2025-02-09	2025-02-14	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
85	fc7c7272-6d55-49a3-88d7-fc37133a103f	2025-03-02	2025-03-11	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
86	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2025-02-14	2025-02-24	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
87	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2025-02-20	2025-02-24	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
89	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2025-03-03	2025-03-07	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
90	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2025-03-05	2025-03-13	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
91	cff64755-2065-4e58-866f-f092cbd9e73b	2025-03-05	2025-03-08	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
92	cff64755-2065-4e58-866f-f092cbd9e73b	2025-03-04	2025-03-12	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
93	cff64755-2065-4e58-866f-f092cbd9e73b	2025-02-16	2025-02-21	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
94	cff64755-2065-4e58-866f-f092cbd9e73b	2025-03-01	2025-03-08	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
95	cff64755-2065-4e58-866f-f092cbd9e73b	2025-02-08	2025-02-10	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
96	ee522e07-1315-4463-8a9b-f890b601c047	2025-02-19	2025-02-28	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
97	ee522e07-1315-4463-8a9b-f890b601c047	2025-02-04	2025-02-05	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
98	ee522e07-1315-4463-8a9b-f890b601c047	2025-02-05	2025-02-10	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
99	ee522e07-1315-4463-8a9b-f890b601c047	2025-02-12	2025-02-12	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
100	ee522e07-1315-4463-8a9b-f890b601c047	2025-02-25	2025-03-03	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
101	77e168c1-05e0-4314-8a24-5e838350a3d8	2025-02-23	2025-03-03	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
102	77e168c1-05e0-4314-8a24-5e838350a3d8	2025-02-10	2025-02-10	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
103	77e168c1-05e0-4314-8a24-5e838350a3d8	2025-02-15	2025-02-24	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
104	77e168c1-05e0-4314-8a24-5e838350a3d8	2025-02-12	2025-02-19	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
105	77e168c1-05e0-4314-8a24-5e838350a3d8	2025-02-25	2025-03-07	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
106	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2025-02-26	2025-03-06	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
107	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2025-02-22	2025-03-04	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
108	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2025-02-09	2025-02-16	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
109	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2025-03-03	2025-03-10	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
110	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2025-02-16	2025-02-19	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
111	387d98f7-ccf9-4077-8f79-f0be51c40d05	2025-02-22	2025-02-28	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
112	387d98f7-ccf9-4077-8f79-f0be51c40d05	2025-02-28	2025-03-07	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
113	387d98f7-ccf9-4077-8f79-f0be51c40d05	2025-02-04	2025-02-09	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
114	387d98f7-ccf9-4077-8f79-f0be51c40d05	2025-02-24	2025-03-05	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
115	387d98f7-ccf9-4077-8f79-f0be51c40d05	2025-02-12	2025-02-15	Leave for personal reasons	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
116	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2025-02-12	2025-02-15	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
117	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2025-02-18	2025-02-26	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
118	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2025-02-14	2025-02-14	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
119	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2025-02-24	2025-03-05	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
121	1934abf8-eca9-41d8-bc5f-9c649285b76b	2025-02-21	2025-02-23	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
67	dbbbe49c-e100-4576-b406-320908c8873e	2025-02-20	2025-02-25	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
68	dbbbe49c-e100-4576-b406-320908c8873e	2025-03-01	2025-03-03	Leave for personal reasons	pending	rejected	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
69	dbbbe49c-e100-4576-b406-320908c8873e	2025-02-13	2025-02-15	Leave for personal reasons	pending	rejected	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
70	dbbbe49c-e100-4576-b406-320908c8873e	2025-02-13	2025-02-15	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
77	bd38508e-8797-4220-ae2e-dd7883b41f17	2025-02-15	2025-02-20	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
88	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2025-02-09	2025-02-13	Leave for personal reasons	pending	rejected	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
120	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2025-02-23	2025-02-28	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
122	1934abf8-eca9-41d8-bc5f-9c649285b76b	2025-02-13	2025-02-18	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
123	1934abf8-eca9-41d8-bc5f-9c649285b76b	2025-03-02	2025-03-05	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
124	1934abf8-eca9-41d8-bc5f-9c649285b76b	2025-02-24	2025-02-27	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
125	1934abf8-eca9-41d8-bc5f-9c649285b76b	2025-02-20	2025-02-23	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
128	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2025-02-15	2025-02-16	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
130	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2025-03-02	2025-03-03	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
132	584a1909-5797-4297-88d3-06bf5dc3922a	2025-02-09	2025-02-13	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
134	584a1909-5797-4297-88d3-06bf5dc3922a	2025-02-08	2025-02-13	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
135	584a1909-5797-4297-88d3-06bf5dc3922a	2025-02-10	2025-02-19	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
136	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-05	2025-02-07	dnegue	pending	none	none	2025-02-04 04:33:46.688127+00	2025-02-04 04:33:46.688127+00	vacation	\N	\N
137	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-07	2025-02-17	HK trip	pending	none	none	2025-02-04 04:39:42.809774+00	2025-02-04 04:39:42.809774+00	sick	\N	\N
138	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-20	2025-02-28	jp[	pending	none	none	2025-02-04 04:53:16.091409+00	2025-02-04 04:53:16.091409+00	vacation	\N	\N
139	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-06	2025-02-07	lagnat	pending	none	none	2025-02-04 05:06:39.081808+00	2025-02-04 05:06:39.081808+00	sick	\N	\N
140	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-06	2025-02-08	hayaahay	pending	none	none	2025-02-04 05:07:41.78115+00	2025-02-04 05:07:41.78115+00	vacation	\N	\N
141	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-06	2025-02-13	aaa	pending	none	none	2025-02-04 05:10:37.673223+00	2025-02-04 05:10:37.673223+00	vacation	\N	\N
142	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-06	2025-02-08	hehe	pending	none	none	2025-02-04 05:12:53.901104+00	2025-02-04 05:12:53.901104+00	sick	\N	\N
143	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-05	2025-02-26	honeymoon	pending	none	none	2025-02-04 05:13:19.145183+00	2025-02-04 05:13:19.145183+00	vacation	\N	\N
144	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-05	2025-02-28	honeeey	pending	none	none	2025-02-04 05:15:37.215833+00	2025-02-04 05:15:37.215833+00	vacation	\N	\N
145	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-25	2025-02-28	paoulo	pending	none	none	2025-02-04 05:16:26.492791+00	2025-02-04 05:16:26.492791+00	vacation	\N	\N
146	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-06	2025-02-08	fasdfafffff	pending	none	none	2025-02-04 05:19:13.584381+00	2025-02-04 05:19:13.584381+00	vacation	\N	\N
147	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-06	2025-02-08	fasdfafffff	pending	none	none	2025-02-04 05:20:50.000028+00	2025-02-04 05:20:50.000028+00	vacation	\N	\N
148	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-06	2025-02-08	fasdfaffffffffaaa	pending	none	none	2025-02-04 05:20:53.747956+00	2025-02-04 05:20:53.747956+00	vacation	\N	\N
149	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-06	2025-02-13	pauloo	pending	none	none	2025-02-04 05:26:11.400382+00	2025-02-04 05:26:11.400382+00	vacation	\N	\N
150	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-05	2025-02-12	boto	pending	none	none	2025-02-04 05:28:06.695038+00	2025-02-04 05:28:06.695038+00	vacation	\N	\N
151	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-06	2025-02-07	aaaaaa	pending	none	none	2025-02-04 05:28:47.024115+00	2025-02-04 05:28:47.024115+00	sick	\N	\N
152	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-06	2025-02-08	faaaafff	pending	none	none	2025-02-04 05:33:01.153618+00	2025-02-04 05:33:01.153618+00	vacation	\N	\N
153	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-14	2025-02-27	afafaff	pending	none	none	2025-02-04 14:16:09.192975+00	2025-02-04 14:16:09.192975+00	sick	\N	\N
154	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-05	2025-02-06	111	pending	none	none	2025-02-04 14:17:41.869865+00	2025-02-04 14:17:41.869865+00	sick	\N	\N
155	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-05	2025-02-06	222	pending	none	none	2025-02-04 14:18:57.361428+00	2025-02-04 14:18:57.361428+00	vacation	\N	\N
156	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-05	2025-02-06	222222	pending	none	none	2025-02-04 14:25:55.309996+00	2025-02-04 14:25:55.309996+00	vacation	\N	\N
157	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2025-02-05	2025-02-08	aaaffffff	pending	none	none	2025-02-04 14:27:06.814087+00	2025-02-04 14:27:06.814087+00	vacation	\N	\N
158	dd35da46-4416-412a-8a22-f3f39491bb7b	2025-02-05	2025-02-19	fasdfasdfsafasdfasdfasdf	pending	none	none	2025-02-04 14:45:20.120914+00	2025-02-04 14:45:20.120914+00	vacation	\N	\N
159	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2025-02-05	2025-02-06	dasfasdfsaf	pending	none	none	2025-02-04 14:46:07.590469+00	2025-02-04 14:46:07.590469+00	vacation	\N	\N
160	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2025-02-05	2025-02-14	121212	pending	none	none	2025-02-04 14:49:34.162651+00	2025-02-04 14:49:34.162651+00	sick	\N	\N
161	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2025-02-06	2025-02-08	000	pending	none	none	2025-02-04 15:39:05.819024+00	2025-02-04 15:39:05.819024+00	sick	\N	\N
162	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2025-02-07	2025-02-13	faafff	pending	approved	none	2025-02-06 02:09:02.491889+00	2025-02-06 02:09:02.491889+00	vacation	go lang brodie	\N
129	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2025-02-04	2025-02-11	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
6	a83848ba-0779-4fac-98ee-f5f459b2742b	2025-02-08	2025-02-10	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	gowgogwogww	\N
163	a83848ba-0779-4fac-98ee-f5f459b2742b	2025-02-07	2025-02-08	pahinga	approved	approved	approved	2025-02-06 02:24:41.577132+00	2025-02-06 02:24:41.577132+00	vacation	go lungs	GEGEGE
31	463737cc-950b-4a41-8d73-a3daf931fee5	2025-03-05	2025-03-14	Leave for personal reasons	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	YES GO AHEAD
8	a83848ba-0779-4fac-98ee-f5f459b2742b	2025-02-15	2025-02-21	Leave for personal reasons	approved	approved	override-approved	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	ge lang braderrr	YESSSSIR
59	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2025-02-11	2025-02-12	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
164	a83848ba-0779-4fac-98ee-f5f459b2742b	2025-02-10	2025-02-13	hayahayah	approved	approved	approved	2025-02-08 04:24:43.503007+00	2025-02-08 04:24:43.503007+00	vacation	eh go sige. sabi mo eh.	sige brad
169	aefe15fe-4937-4f55-a6cb-fb8d739c5905	2025-02-21	2025-02-27	zeddx	pending	none	none	2025-02-19 15:54:39.950395+00	2025-02-19 15:54:39.950395+00	vacation	\N	\N
66	dbbbe49c-e100-4576-b406-320908c8873e	2025-03-05	2025-03-12	Leave for personal reasons	pending	rejected	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
80	bd38508e-8797-4220-ae2e-dd7883b41f17	2025-02-06	2025-02-14	Leave for personal reasons	pending	rejected	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
126	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2025-03-05	2025-03-06	Leave for personal reasons	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
127	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2025-02-13	2025-02-19	Leave for personal reasons	pending	rejected	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
131	584a1909-5797-4297-88d3-06bf5dc3922a	2025-02-13	2025-02-17	Leave for personal reasons	pending	rejected	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
133	584a1909-5797-4297-88d3-06bf5dc3922a	2025-02-15	2025-02-15	Leave for personal reasons	pending	rejected	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	sick	\N	\N
165	a83848ba-0779-4fac-98ee-f5f459b2742b	2025-02-14	2025-02-18	pp	rejected	approved	override-rejected	2025-02-08 04:29:08.905703+00	2025-02-08 04:29:08.905703+00	vacation	\N	NO GOOD dami mong leave uy
166	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2025-02-19	2025-03-01	gagagaaaa	pending	none	none	2025-02-08 06:35:09.053979+00	2025-02-08 06:35:09.053979+00	vacation	\N	\N
167	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2025-02-13	2025-02-14	bda	pending	none	none	2025-02-12 09:33:43.43426+00	2025-02-12 09:33:43.43426+00	vacation	\N	\N
168	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	2025-02-19	2025-02-21	fafaff	pending	none	none	2025-02-19 15:49:50.331131+00	2025-02-19 15:49:50.331131+00	sick	\N	\N
170	aefe15fe-4937-4f55-a6cb-fb8d739c5905	2025-02-19	2025-02-26	fag77	pending	none	none	2025-02-19 15:57:11.744618+00	2025-02-19 15:57:11.744618+00	sick	\N	\N
\.


--
-- Data for Name: surplus_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.surplus_requests (id, missionary_id, amount_requested, reason, status, campus_director_approval, lead_pastor_approval, created_at, updated_at, campus_director_notes, lead_pastor_notes) FROM stdin;
1	dd35da46-4416-412a-8a22-f3f39491bb7b	1256.65	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
2	dd35da46-4416-412a-8a22-f3f39491bb7b	3345.20	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
3	dd35da46-4416-412a-8a22-f3f39491bb7b	2678.00	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
4	dd35da46-4416-412a-8a22-f3f39491bb7b	2609.77	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
5	dd35da46-4416-412a-8a22-f3f39491bb7b	5488.88	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
8	a83848ba-0779-4fac-98ee-f5f459b2742b	1857.02	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
12	51072377-1472-46cb-b180-8542677f5eb2	4441.17	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
13	51072377-1472-46cb-b180-8542677f5eb2	1362.82	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
14	51072377-1472-46cb-b180-8542677f5eb2	2618.20	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
15	51072377-1472-46cb-b180-8542677f5eb2	4368.03	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
16	9255fabc-799b-4cc7-8797-5f2470f6adf6	5565.54	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
17	9255fabc-799b-4cc7-8797-5f2470f6adf6	2089.37	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
18	9255fabc-799b-4cc7-8797-5f2470f6adf6	5668.17	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
19	9255fabc-799b-4cc7-8797-5f2470f6adf6	3849.98	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
20	9255fabc-799b-4cc7-8797-5f2470f6adf6	4554.78	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
21	6833f990-6a38-4f28-aa18-e31697fa7dc9	1556.88	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
22	6833f990-6a38-4f28-aa18-e31697fa7dc9	5597.15	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
23	6833f990-6a38-4f28-aa18-e31697fa7dc9	4520.98	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
24	6833f990-6a38-4f28-aa18-e31697fa7dc9	4675.67	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
25	6833f990-6a38-4f28-aa18-e31697fa7dc9	4452.02	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
26	6ac1e176-e710-4b5e-9453-95765db20ba3	4531.37	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
27	6ac1e176-e710-4b5e-9453-95765db20ba3	3017.95	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
28	6ac1e176-e710-4b5e-9453-95765db20ba3	4294.26	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
29	6ac1e176-e710-4b5e-9453-95765db20ba3	2345.61	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
30	6ac1e176-e710-4b5e-9453-95765db20ba3	4958.52	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
32	463737cc-950b-4a41-8d73-a3daf931fee5	2104.13	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
33	463737cc-950b-4a41-8d73-a3daf931fee5	1234.57	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
34	463737cc-950b-4a41-8d73-a3daf931fee5	3288.41	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
35	463737cc-950b-4a41-8d73-a3daf931fee5	1273.36	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
36	8088628d-f77a-430d-b228-cc3649b8a3e1	5266.83	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
37	8088628d-f77a-430d-b228-cc3649b8a3e1	2045.96	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
38	8088628d-f77a-430d-b228-cc3649b8a3e1	2570.01	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
39	8088628d-f77a-430d-b228-cc3649b8a3e1	4902.36	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
40	8088628d-f77a-430d-b228-cc3649b8a3e1	2755.84	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
42	da6ac18e-72e9-484a-ad75-d044260789cc	4954.43	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
45	da6ac18e-72e9-484a-ad75-d044260789cc	1220.13	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
46	a602c1a3-89cf-44a4-b419-f6827ad3701b	3743.57	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
47	a602c1a3-89cf-44a4-b419-f6827ad3701b	3390.18	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
50	a602c1a3-89cf-44a4-b419-f6827ad3701b	3212.37	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
51	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5162.31	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
52	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3186.99	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
53	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2373.44	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
54	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2725.41	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
55	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5020.90	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
57	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3948.29	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
59	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2474.29	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
61	dde964d6-6ffa-4b25-97b6-128969afe47c	4287.96	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
62	dde964d6-6ffa-4b25-97b6-128969afe47c	2632.38	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
63	dde964d6-6ffa-4b25-97b6-128969afe47c	2219.13	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
64	dde964d6-6ffa-4b25-97b6-128969afe47c	1409.11	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
65	dde964d6-6ffa-4b25-97b6-128969afe47c	5960.15	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
41	da6ac18e-72e9-484a-ad75-d044260789cc	4897.04	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
10	a83848ba-0779-4fac-98ee-f5f459b2742b	2568.63	Request for surplus funds	approved	none	approved	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	ge lang brad
31	463737cc-950b-4a41-8d73-a3daf931fee5	5722.21	Request for surplus funds	approved	none	approved	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	pampakasal mo bro
43	da6ac18e-72e9-484a-ad75-d044260789cc	4042.99	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\n\n	\N
44	da6ac18e-72e9-484a-ad75-d044260789cc	3829.13	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
48	a602c1a3-89cf-44a4-b419-f6827ad3701b	1035.23	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
49	a602c1a3-89cf-44a4-b419-f6827ad3701b	1497.46	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
56	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3131.88	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
58	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4625.94	Request for surplus funds	pending	rejected	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
60	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2509.36	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
9	a83848ba-0779-4fac-98ee-f5f459b2742b	2175.01	Request for surplus funds	rejected	approved	override-rejected	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	oprat	wag daw
67	dbbbe49c-e100-4576-b406-320908c8873e	2312.06	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
69	dbbbe49c-e100-4576-b406-320908c8873e	2407.75	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
70	dbbbe49c-e100-4576-b406-320908c8873e	5716.21	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
71	5432f125-2d5e-42ab-849a-29add2cf0a74	1715.88	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
72	5432f125-2d5e-42ab-849a-29add2cf0a74	5755.63	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
73	5432f125-2d5e-42ab-849a-29add2cf0a74	1477.33	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
74	5432f125-2d5e-42ab-849a-29add2cf0a74	3636.07	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
75	5432f125-2d5e-42ab-849a-29add2cf0a74	2637.67	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
76	bd38508e-8797-4220-ae2e-dd7883b41f17	1522.57	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
77	bd38508e-8797-4220-ae2e-dd7883b41f17	3872.16	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
78	bd38508e-8797-4220-ae2e-dd7883b41f17	2391.02	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
81	fc7c7272-6d55-49a3-88d7-fc37133a103f	5060.61	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
82	fc7c7272-6d55-49a3-88d7-fc37133a103f	3622.82	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
83	fc7c7272-6d55-49a3-88d7-fc37133a103f	5139.99	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
84	fc7c7272-6d55-49a3-88d7-fc37133a103f	1034.09	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
85	fc7c7272-6d55-49a3-88d7-fc37133a103f	3227.06	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
86	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2132.80	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
89	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	5058.96	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
91	cff64755-2065-4e58-866f-f092cbd9e73b	1165.81	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
92	cff64755-2065-4e58-866f-f092cbd9e73b	5626.68	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
93	cff64755-2065-4e58-866f-f092cbd9e73b	4316.36	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
94	cff64755-2065-4e58-866f-f092cbd9e73b	1933.94	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
95	cff64755-2065-4e58-866f-f092cbd9e73b	2706.76	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
96	ee522e07-1315-4463-8a9b-f890b601c047	2324.38	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
97	ee522e07-1315-4463-8a9b-f890b601c047	5016.24	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
98	ee522e07-1315-4463-8a9b-f890b601c047	2447.97	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
99	ee522e07-1315-4463-8a9b-f890b601c047	1318.66	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
100	ee522e07-1315-4463-8a9b-f890b601c047	1860.29	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
101	77e168c1-05e0-4314-8a24-5e838350a3d8	1800.75	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
102	77e168c1-05e0-4314-8a24-5e838350a3d8	2302.22	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
103	77e168c1-05e0-4314-8a24-5e838350a3d8	4631.17	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
104	77e168c1-05e0-4314-8a24-5e838350a3d8	1701.58	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
105	77e168c1-05e0-4314-8a24-5e838350a3d8	3248.16	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
106	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5182.11	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
107	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2938.83	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
108	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2664.00	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
109	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1763.74	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
110	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2642.59	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
111	387d98f7-ccf9-4077-8f79-f0be51c40d05	4345.63	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
112	387d98f7-ccf9-4077-8f79-f0be51c40d05	4482.67	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
113	387d98f7-ccf9-4077-8f79-f0be51c40d05	5240.60	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
114	387d98f7-ccf9-4077-8f79-f0be51c40d05	2513.31	Request for surplus funds	pending	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
115	387d98f7-ccf9-4077-8f79-f0be51c40d05	2821.96	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
117	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3260.57	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
121	1934abf8-eca9-41d8-bc5f-9c649285b76b	5800.94	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
122	1934abf8-eca9-41d8-bc5f-9c649285b76b	5449.10	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
124	1934abf8-eca9-41d8-bc5f-9c649285b76b	2469.10	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
125	1934abf8-eca9-41d8-bc5f-9c649285b76b	2109.76	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
126	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2661.07	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
130	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5788.20	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
68	dbbbe49c-e100-4576-b406-320908c8873e	2685.99	Request for surplus funds	pending	rejected	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
80	bd38508e-8797-4220-ae2e-dd7883b41f17	4041.32	Request for surplus funds	approved	rejected	override-approved	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	gagag
87	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2381.78	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
88	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2517.71	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
127	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1519.76	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
116	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5967.00	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
120	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3243.31	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
123	1934abf8-eca9-41d8-bc5f-9c649285b76b	1030.35	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
129	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1137.38	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
90	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3402.17	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
118	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	4561.16	Request for surplus funds	pending	rejected	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
119	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3663.07	Request for surplus funds	pending	rejected	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
79	bd38508e-8797-4220-ae2e-dd7883b41f17	3592.94	Request for surplus funds	approved	rejected	override-approved	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	Pagbigyan na to
132	584a1909-5797-4297-88d3-06bf5dc3922a	5808.26	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
133	584a1909-5797-4297-88d3-06bf5dc3922a	4437.17	Request for surplus funds	approved	none	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
136	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	22111.00	dengue vax	pending	none	none	2025-02-04 04:35:00.134613+00	2025-02-04 04:35:00.134613+00	\N	\N
137	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2211.00	hehehe	pending	none	none	2025-02-04 04:38:14.797609+00	2025-02-04 04:38:14.797609+00	\N	\N
138	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2222.00	penge pera	pending	none	none	2025-02-04 04:39:33.548054+00	2025-02-04 04:39:33.548054+00	\N	\N
139	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	8989.00	jjkk	pending	none	none	2025-02-04 04:50:08.614761+00	2025-02-04 04:50:08.614761+00	\N	\N
140	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	8899.00	ppooopp	pending	none	none	2025-02-04 04:53:02.071154+00	2025-02-04 04:53:02.071154+00	\N	\N
141	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	2211.00	aghagagaaa	pending	none	none	2025-02-04 14:46:41.693149+00	2025-02-04 14:46:41.693149+00	\N	\N
142	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	112.00	asdfasdf	pending	none	none	2025-02-04 14:49:40.159537+00	2025-02-04 14:49:40.159537+00	\N	\N
6	a83848ba-0779-4fac-98ee-f5f459b2742b	2873.72	Request for surplus funds	approved	none	approved	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	YES GOO
7	a83848ba-0779-4fac-98ee-f5f459b2742b	3753.91	Request for surplus funds	approved	approved	approved	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	gegegeg	ok golang
66	dbbbe49c-e100-4576-b406-320908c8873e	4104.69	Request for surplus funds	pending	rejected	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
128	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5586.46	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	\N	\N
131	584a1909-5797-4297-88d3-06bf5dc3922a	2431.81	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	YOK ODITO AHAHA	\N
134	584a1909-5797-4297-88d3-06bf5dc3922a	4481.72	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	BOULAG	\N
135	584a1909-5797-4297-88d3-06bf5dc3922a	2458.09	Request for surplus funds	pending	rejected	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	WALA NA PERA PAR	\N
11	51072377-1472-46cb-b180-8542677f5eb2	2511.56	Request for surplus funds	pending	approved	none	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00	ppeeeppppp	\N
143	b1f5db31-bfc8-409c-8925-0d21f1c780e6	12211.00	asdfasffffaaaa	pending	none	none	2025-02-08 06:35:29.287003+00	2025-02-08 06:35:29.287003+00	\N	\N
144	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2222.00	aafafafa	pending	none	none	2025-02-08 06:35:32.922373+00	2025-02-08 06:35:32.922373+00	\N	\N
145	b1f5db31-bfc8-409c-8925-0d21f1c780e6	221.00	bdada	pending	none	none	2025-02-12 09:33:48.94799+00	2025-02-12 09:33:48.94799+00	\N	\N
\.


--
-- Data for Name: system_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.system_settings (id, surplus_allocation_percent, default_monthly_goal, leave_policies, updated_at) FROM stdin;
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (user_id, role, created_at, local_church_id) FROM stdin;
dd35da46-4416-412a-8a22-f3f39491bb7b	missionary	2025-02-20 04:55:49.916634+00	11
a83848ba-0779-4fac-98ee-f5f459b2742b	missionary	2025-02-20 04:55:49.916634+00	1
51072377-1472-46cb-b180-8542677f5eb2	missionary	2025-02-20 04:55:49.916634+00	11
9255fabc-799b-4cc7-8797-5f2470f6adf6	missionary	2025-02-20 04:55:49.916634+00	2
6833f990-6a38-4f28-aa18-e31697fa7dc9	missionary	2025-02-20 04:55:49.916634+00	4
6ac1e176-e710-4b5e-9453-95765db20ba3	missionary	2025-02-20 04:55:49.916634+00	3
8088628d-f77a-430d-b228-cc3649b8a3e1	missionary	2025-02-20 04:55:49.916634+00	9
da6ac18e-72e9-484a-ad75-d044260789cc	missionary	2025-02-20 04:55:49.916634+00	4
a602c1a3-89cf-44a4-b419-f6827ad3701b	missionary	2025-02-20 04:55:49.916634+00	11
1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	missionary	2025-02-20 04:55:49.916634+00	10
fd99f59b-fcc6-42ef-a407-207f110f2d7b	missionary	2025-02-20 04:55:49.916634+00	9
dde964d6-6ffa-4b25-97b6-128969afe47c	missionary	2025-02-20 04:55:49.916634+00	1
dbbbe49c-e100-4576-b406-320908c8873e	missionary	2025-02-20 04:55:49.916634+00	2
5432f125-2d5e-42ab-849a-29add2cf0a74	missionary	2025-02-20 04:55:49.916634+00	1
fc7c7272-6d55-49a3-88d7-fc37133a103f	missionary	2025-02-20 04:55:49.916634+00	5
e4bfe294-e6e5-4626-9f2a-969f2aa938c3	missionary	2025-02-20 04:55:49.916634+00	4
cff64755-2065-4e58-866f-f092cbd9e73b	missionary	2025-02-20 04:55:49.916634+00	4
ee522e07-1315-4463-8a9b-f890b601c047	missionary	2025-02-20 04:55:49.916634+00	10
77e168c1-05e0-4314-8a24-5e838350a3d8	missionary	2025-02-20 04:55:49.916634+00	3
ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	missionary	2025-02-20 04:55:49.916634+00	5
387d98f7-ccf9-4077-8f79-f0be51c40d05	missionary	2025-02-20 04:55:49.916634+00	1
ad0b7e41-18fc-4945-8aa9-6793788b0e7c	missionary	2025-02-20 04:55:49.916634+00	4
1934abf8-eca9-41d8-bc5f-9c649285b76b	missionary	2025-02-20 04:55:49.916634+00	3
5bf27593-0c3d-489f-bed4-c80dc2936fdf	missionary	2025-02-20 04:55:49.916634+00	7
584a1909-5797-4297-88d3-06bf5dc3922a	missionary	2025-02-20 04:55:49.916634+00	1
94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	campus_director	2025-02-20 04:55:49.916634+00	10
aefe15fe-4937-4f55-a6cb-fb8d739c5905	missionary	2025-02-20 04:55:49.916634+00	10
463737cc-950b-4a41-8d73-a3daf931fee5	missionary	2025-02-20 04:55:49.916634+00	1
aebdeee3-427f-4d5b-832d-8c4ebaecdddc	superadmin	2025-02-20 04:55:49.916634+00	10
b1f5db31-bfc8-409c-8925-0d21f1c780e6	campus_director	2025-02-20 04:55:49.916634+00	6
b794e95a-97f4-4c05-aa2d-3c13c4155841	campus_director	2025-02-20 04:55:49.916634+00	7
bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	campus_director	2025-02-20 04:55:49.916634+00	5
bd38508e-8797-4220-ae2e-dd7883b41f17	missionary	2025-02-20 04:55:49.916634+00	1
d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	campus_director	2025-02-20 04:55:49.916634+00	10
ab8dc40a-9c9b-4391-823b-8578ab506e5e	lead_pastor	2025-02-20 04:55:49.916634+00	1
ec874457-5ac3-48c2-90dd-9ea0b8166635	lead_pastor	2025-02-20 04:55:49.916634+00	2
48d301bd-fea6-4d85-92c0-bf066aa23ae8	lead_pastor	2025-02-20 04:55:49.916634+00	3
a3a1e735-b662-49ab-8ccc-a23686553bc3	lead_pastor	2025-02-20 04:55:49.916634+00	4
326aada0-3dcc-4566-84cc-2541c0e134e2	lead_pastor	2025-02-20 04:55:49.916634+00	5
6f9579a9-4f08-4ab5-8fd2-b7c3d2ee87e2	lead_pastor	2025-02-20 04:55:49.916634+00	6
910ef066-fdcb-4f99-aac4-458aaacc7a5b	lead_pastor	2025-02-20 04:55:49.916634+00	7
712b5dd0-cd8d-4293-8e66-640624002f2b	lead_pastor	2025-02-20 04:55:49.916634+00	10
f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	finance_officer	2025-02-20 04:55:49.916634+00	10
6d5b86c5-2939-4003-bb6f-6b177a60038e	lead_pastor	2025-02-20 04:55:49.916634+00	10
\.


--
-- Data for Name: messages_2025_02_16; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_02_16 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_02_17; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_02_17 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_02_18; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_02_18 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_02_19; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_02_19 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_02_20; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_02_20 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_02_21; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_02_21 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_02_22; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_02_22 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-02-04 04:08:15
20211116045059	2025-02-04 04:08:15
20211116050929	2025-02-04 04:08:15
20211116051442	2025-02-04 04:08:15
20211116212300	2025-02-04 04:08:15
20211116213355	2025-02-04 04:08:15
20211116213934	2025-02-04 04:08:15
20211116214523	2025-02-04 04:08:15
20211122062447	2025-02-04 04:08:15
20211124070109	2025-02-04 04:08:15
20211202204204	2025-02-04 04:08:15
20211202204605	2025-02-04 04:08:15
20211210212804	2025-02-04 04:08:15
20211228014915	2025-02-04 04:08:15
20220107221237	2025-02-04 04:08:15
20220228202821	2025-02-04 04:08:15
20220312004840	2025-02-04 04:08:15
20220603231003	2025-02-04 04:08:15
20220603232444	2025-02-04 04:08:15
20220615214548	2025-02-04 04:08:15
20220712093339	2025-02-04 04:08:15
20220908172859	2025-02-04 04:08:15
20220916233421	2025-02-04 04:08:15
20230119133233	2025-02-04 04:08:15
20230128025114	2025-02-04 04:08:15
20230128025212	2025-02-04 04:08:15
20230227211149	2025-02-04 04:08:15
20230228184745	2025-02-04 04:08:15
20230308225145	2025-02-04 04:08:15
20230328144023	2025-02-04 04:08:15
20231018144023	2025-02-04 04:08:15
20231204144023	2025-02-04 04:08:15
20231204144024	2025-02-04 04:08:15
20231204144025	2025-02-04 04:08:15
20240108234812	2025-02-04 04:08:15
20240109165339	2025-02-04 04:08:15
20240227174441	2025-02-04 04:08:15
20240311171622	2025-02-04 04:08:15
20240321100241	2025-02-04 04:08:15
20240401105812	2025-02-04 04:08:15
20240418121054	2025-02-04 04:08:15
20240523004032	2025-02-04 04:08:15
20240618124746	2025-02-04 04:08:15
20240801235015	2025-02-04 04:08:15
20240805133720	2025-02-04 04:08:15
20240827160934	2025-02-04 04:08:15
20240919163303	2025-02-04 04:08:15
20240919163305	2025-02-04 04:08:15
20241019105805	2025-02-04 04:08:15
20241030150047	2025-02-04 04:08:15
20241108114728	2025-02-04 04:08:15
20241121104152	2025-02-04 04:08:15
20241130184212	2025-02-04 04:08:15
20241220035512	2025-02-04 04:08:15
20241220123912	2025-02-04 04:08:15
20241224161212	2025-02-04 04:08:15
20250107150512	2025-02-04 04:08:15
20250110162412	2025-02-04 04:08:15
20250123174212	2025-02-04 04:08:15
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-02-04 04:08:17.050773
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-02-04 04:08:17.055204
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-02-04 04:08:17.058046
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-02-04 04:08:17.066846
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-02-04 04:08:17.088194
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-02-04 04:08:17.091093
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-02-04 04:08:17.094736
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-02-04 04:08:17.097955
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-02-04 04:08:17.101573
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-02-04 04:08:17.104848
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-02-04 04:08:17.108241
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-02-04 04:08:17.112113
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-02-04 04:08:17.117212
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-02-04 04:08:17.120224
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-02-04 04:08:17.12314
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-02-04 04:08:17.153874
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-02-04 04:08:17.15897
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-02-04 04:08:17.16168
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-02-04 04:08:17.166194
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-02-04 04:08:17.169977
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-02-04 04:08:17.173675
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-02-04 04:08:17.182562
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-02-04 04:08:17.207526
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-02-04 04:08:17.236663
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-02-04 04:08:17.242238
25	custom-metadata	67eb93b7e8d401cafcdc97f9ac779e71a79bfe03	2025-02-04 04:08:17.246213
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.hooks (id, hook_table_id, hook_name, created_at, request_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.migrations (version, inserted_at) FROM stdin;
initial	2025-02-04 04:08:04.652089+00
20210809183423_update_grants	2025-02-04 04:08:04.652089+00
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.schema_migrations (version, statements, name) FROM stdin;
20240101000001	{"-- Create tables\r\nCREATE TABLE local_churches (\r\n  id BIGSERIAL PRIMARY KEY,\r\n  name TEXT NOT NULL,\r\n  district_id BIGINT,\r\n  lead_pastor_id UUID\r\n)","CREATE TABLE districts (\r\n  id BIGSERIAL PRIMARY KEY,\r\n  name TEXT NOT NULL,\r\n  province_id BIGINT\r\n)","CREATE TABLE profiles (\r\n  id UUID PRIMARY KEY REFERENCES auth.users(id),\r\n  full_name TEXT NOT NULL,\r\n  role TEXT NOT NULL CHECK (role IN ('missionary', 'campus_director', 'lead_pastor', 'finance_officer', 'superadmin')),\r\n  local_church_id BIGINT NOT NULL REFERENCES local_churches(id),\r\n  campus_director_id UUID REFERENCES profiles(id),\r\n  monthly_goal NUMERIC(10,2) DEFAULT 0,\r\n  surplus_balance NUMERIC(10,2) DEFAULT 0,\r\n  created_at TIMESTAMPTZ DEFAULT NOW(),\r\n  updated_at TIMESTAMPTZ DEFAULT NOW()\r\n)","CREATE TABLE donations (\r\n  id BIGSERIAL PRIMARY KEY,\r\n  missionary_id UUID NOT NULL REFERENCES profiles(id),\r\n  donor_name TEXT,\r\n  amount NUMERIC(10,2) NOT NULL,\r\n  date TIMESTAMPTZ NOT NULL DEFAULT NOW(),\r\n  source TEXT NOT NULL CHECK (source IN ('online', 'offline')),\r\n  status TEXT NOT NULL CHECK (status IN ('completed', 'refunded', 'failed')),\r\n  created_by UUID REFERENCES profiles(id)\r\n)","CREATE TABLE surplus_requests (\r\n  id BIGSERIAL PRIMARY KEY,\r\n  missionary_id UUID NOT NULL REFERENCES profiles(id),\r\n  amount_requested NUMERIC(10,2) NOT NULL,\r\n  reason TEXT NOT NULL,\r\n  status TEXT NOT NULL CHECK (status IN ('pending', 'approved', 'rejected')),\r\n  campus_director_approval TEXT NOT NULL CHECK (campus_director_approval IN ('none', 'approved', 'rejected')) DEFAULT 'none',\r\n  lead_pastor_approval TEXT NOT NULL CHECK (lead_pastor_approval IN ('none', 'approved', 'rejected', 'override')) DEFAULT 'none',\r\n  created_at TIMESTAMPTZ DEFAULT NOW(),\r\n  updated_at TIMESTAMPTZ DEFAULT NOW()\r\n)","CREATE TABLE leave_requests (\r\n  id BIGSERIAL PRIMARY KEY,\r\n  requester_id UUID NOT NULL REFERENCES profiles(id),\r\n  start_date DATE NOT NULL,\r\n  end_date DATE NOT NULL,\r\n  reason TEXT NOT NULL,\r\n  status TEXT NOT NULL CHECK (status IN ('pending', 'approved', 'rejected')),\r\n  campus_director_approval TEXT NOT NULL CHECK (campus_director_approval IN ('none', 'approved', 'rejected')) DEFAULT 'none',\r\n  lead_pastor_approval TEXT NOT NULL CHECK (lead_pastor_approval IN ('none', 'approved', 'rejected', 'override')) DEFAULT 'none',\r\n  created_at TIMESTAMPTZ DEFAULT NOW(),\r\n  updated_at TIMESTAMPTZ DEFAULT NOW(),\r\n  type TEXT NOT NULL CHECK (type IN ('sick', 'vacation')) DEFAULT 'sick'\r\n)","CREATE TABLE donors (\r\n  id BIGSERIAL PRIMARY KEY,\r\n  name TEXT NOT NULL,\r\n  email TEXT,\r\n  phone TEXT,\r\n  created_at TIMESTAMPTZ DEFAULT NOW()\r\n)","CREATE TABLE donor_donations (\r\n  id BIGSERIAL PRIMARY KEY,\r\n  donor_id BIGINT NOT NULL REFERENCES donors(id),\r\n  missionary_id UUID NOT NULL REFERENCES profiles(id),\r\n  amount NUMERIC(10,2) NOT NULL,\r\n  date TIMESTAMPTZ NOT NULL DEFAULT NOW(),\r\n  source TEXT NOT NULL CHECK (source IN ('online', 'offline')),\r\n  status TEXT NOT NULL CHECK (status IN ('completed', 'refunded', 'failed'))\r\n)","-- Add foreign key constraints\r\nALTER TABLE profiles\r\nADD CONSTRAINT fk_local_church\r\nFOREIGN KEY (local_church_id)\r\nREFERENCES local_churches(id)","ALTER TABLE donations\r\nADD CONSTRAINT fk_missionary\r\nFOREIGN KEY (missionary_id)\r\nREFERENCES profiles(id)","-- Add indexes and security policies as needed\r\nALTER TABLE profiles ENABLE ROW LEVEL SECURITY","ALTER TABLE donations ENABLE ROW LEVEL SECURITY","-- Add indexes for optimization\r\nCREATE INDEX idx_missionary_id ON donations(missionary_id)","CREATE INDEX idx_local_church_id ON profiles(local_church_id)","CREATE INDEX idx_donor_id ON donor_donations(donor_id)","CREATE INDEX idx_missionary_id_donor_donations ON donor_donations(missionary_id)","-- Add row-level security policies\r\nALTER TABLE leave_requests ENABLE ROW LEVEL SECURITY","-- Example security policy (customize as needed)\r\nDROP POLICY IF EXISTS select_own_profile ON profiles","CREATE POLICY select_own_profile ON profiles\r\nFOR SELECT USING (\r\n  id = auth.uid() OR \r\n  auth.uid() = 'e3ecacd9-c6bc-4b9e-a632-acb4476a7337' -- Superadmin UUID\r\n)","CREATE POLICY select_own_donations ON donations\r\n  FOR SELECT\r\n  USING (missionary_id = auth.uid())","CREATE POLICY insert_own_leave_requests ON leave_requests\r\nFOR INSERT WITH CHECK (\r\n  requester_id = auth.uid()\r\n)","CREATE POLICY select_own_leave_requests ON leave_requests\r\nFOR SELECT USING (\r\n  requester_id = auth.uid()\r\n)","-- Add similar policies for surplus_requests\r\nCREATE POLICY insert_own_surplus_requests ON surplus_requests\r\nFOR INSERT WITH CHECK (\r\n  missionary_id = auth.uid()\r\n)","CREATE POLICY select_own_surplus_requests ON surplus_requests\r\nFOR SELECT USING (\r\n  missionary_id = auth.uid()\r\n)"}	initial_schema
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 269, true);


--
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('pgsodium.key_key_id_seq', 1, false);


--
-- Name: districts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.districts_id_seq', 1, false);


--
-- Name: donor_donations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.donor_donations_id_seq', 1928, true);


--
-- Name: donors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.donors_id_seq', 652, true);


--
-- Name: leave_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leave_requests_id_seq', 201, true);


--
-- Name: local_churches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.local_churches_id_seq', 1, false);


--
-- Name: surplus_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.surplus_requests_id_seq', 145, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('supabase_functions.hooks_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

