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
-- Data for Name: extensions; Type: TABLE DATA; Schema: _realtime; Owner: postgres
--

COPY _realtime.extensions (id, type, settings, tenant_external_id, inserted_at, updated_at) FROM stdin;
8bbf4c46-7893-4864-ac74-b3f0fbf38d24	postgres_cdc_rls	{"region": "us-east-1", "db_host": "kJXKCTyBDOjzVqRzlL8bFKK3IQuQz/MySxNPWLAyhk8=", "db_name": "sWBpZNdjggEPTQVlI52Zfw==", "db_port": "+enMDFi1J/3IrrquHHwUmA==", "db_user": "uxbEq/zz8DXVD53TOI1zmw==", "slot_name": "supabase_realtime_replication_slot", "db_password": "sWBpZNdjggEPTQVlI52Zfw==", "publication": "supabase_realtime", "ssl_enforced": false, "poll_interval_ms": 100, "poll_max_changes": 100, "poll_max_record_bytes": 1048576}	realtime-dev	2025-02-28 01:09:52	2025-02-28 01:09:52
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: _realtime; Owner: postgres
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
-- Data for Name: tenants; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.tenants (id, name, external_id, jwt_secret, max_concurrent_users, inserted_at, updated_at, max_events_per_second, postgres_cdc_default, max_bytes_per_second, max_channels_per_client, max_joins_per_second, suspend, jwt_jwks, notify_private_alpha, private_only) FROM stdin;
981d873b-a5a1-412e-ab9e-ab4eb850f0e4	realtime-dev	realtime-dev	iNjicxc4+llvc9wovDvqymwfnj9teWMlyOIbJ8Fh6j2WNU8CIJ2ZgjR6MUIKqSmeDmvpsKLsZ9jgXJmQPpwL8w==	200	2025-02-28 01:09:52	2025-02-28 01:09:52	100	postgres_cdc_rls	100000	100	100	f	{"keys": [{"k": "c3VwZXItc2VjcmV0LWp3dC10b2tlbi13aXRoLWF0LWxlYXN0LTMyLWNoYXJhY3RlcnMtbG9uZw", "kty": "oct"}]}	f	f
\.


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	ec125e45-8fae-41a0-ac82-b5d462ba801c	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-21 15:54:25.650226+00	
00000000-0000-0000-0000-000000000000	1f7bf5fd-fdd3-43d9-a78d-39eb94affe58	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-21 15:55:23.628063+00	
00000000-0000-0000-0000-000000000000	9c87fee5-a15f-492f-983c-1367482e6d9c	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-21 15:55:25.534297+00	
00000000-0000-0000-0000-000000000000	f99d9c68-0f97-40ac-8952-2ef51cf8c4aa	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-21 15:56:51.706661+00	
00000000-0000-0000-0000-000000000000	0ab91aff-3196-4c41-be67-e58cf23aca75	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-21 15:57:08.078964+00	
00000000-0000-0000-0000-000000000000	7d49422a-039b-49dc-b84a-2f47f2c89038	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-21 15:57:14.629808+00	
00000000-0000-0000-0000-000000000000	f0168392-59d7-48e9-8894-dba6e9cdfa19	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-21 15:57:26.054698+00	
00000000-0000-0000-0000-000000000000	224a8a54-c2af-466a-8a05-282f08243af2	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-21 15:57:36.976021+00	
00000000-0000-0000-0000-000000000000	230e68bf-c52a-447a-8035-306e1673c581	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 05:34:22.199556+00	
00000000-0000-0000-0000-000000000000	16093e1f-7f97-4a65-a848-dacf49e0c5ed	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 06:08:24.289511+00	
00000000-0000-0000-0000-000000000000	2abe493f-3285-490d-8484-8239cbd40153	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 06:08:25.793095+00	
00000000-0000-0000-0000-000000000000	623275d0-893b-4a65-a545-1c710d12f319	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 06:08:28.634978+00	
00000000-0000-0000-0000-000000000000	8af9017d-b468-429c-af44-a193941b5cd0	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 06:08:29.819076+00	
00000000-0000-0000-0000-000000000000	295eab51-254a-494a-9f49-fac46261c974	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 06:08:33.269583+00	
00000000-0000-0000-0000-000000000000	13e58880-b7b7-48cd-97d6-e1fbb2aaaee9	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 06:08:51.543021+00	
00000000-0000-0000-0000-000000000000	a1e182cd-be40-44f8-94d5-b9c379ba724d	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 06:09:49.504757+00	
00000000-0000-0000-0000-000000000000	a8d483cb-d0f3-4779-b3a9-fa69d4883523	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 06:09:51.039963+00	
00000000-0000-0000-0000-000000000000	8f8c91eb-0a0f-4a88-9e54-80316e96a14e	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 06:11:19.466311+00	
00000000-0000-0000-0000-000000000000	5a4ee70a-17fa-4ffd-8625-cdb3358838f0	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 06:11:20.70089+00	
00000000-0000-0000-0000-000000000000	6f5691fd-b180-418a-9ff7-b4154eff35a8	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 06:18:36.361314+00	
00000000-0000-0000-0000-000000000000	5d8b566a-80cf-4d37-9cce-3e38d21c8a7c	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 06:18:40.91807+00	
00000000-0000-0000-0000-000000000000	e4b5d14f-66ef-477d-8eca-a0987150a1fd	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 06:34:20.924777+00	
00000000-0000-0000-0000-000000000000	24851250-9b78-41c5-a628-f14f0e36bf37	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 06:34:25.610718+00	
00000000-0000-0000-0000-000000000000	1cc2061b-1309-4f09-be2f-d7db2de73730	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 06:34:41.984032+00	
00000000-0000-0000-0000-000000000000	399ecbf0-4441-497f-afcc-5dd1ef2b9ae4	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 06:34:44.891674+00	
00000000-0000-0000-0000-000000000000	15b043ff-e078-4e53-b6bb-048944ce64fd	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 06:35:01.457737+00	
00000000-0000-0000-0000-000000000000	4060dc28-e0cd-40fb-af61-bd62f3f09d5c	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 06:35:05.043125+00	
00000000-0000-0000-0000-000000000000	52d6b857-8bf3-4353-88c1-0a404dda7d85	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 06:35:11.264759+00	
00000000-0000-0000-0000-000000000000	32b5f49e-309d-4c9a-ada6-2b6200136d49	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 06:39:09.152513+00	
00000000-0000-0000-0000-000000000000	4574dda1-76d4-4003-9bb8-f7d128878e9d	{"action":"token_refreshed","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 07:37:11.666987+00	
00000000-0000-0000-0000-000000000000	faad71a6-2146-4d2d-a6e3-8f38cc164da5	{"action":"token_revoked","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 07:37:11.668054+00	
00000000-0000-0000-0000-000000000000	e77531bd-c09a-40bb-b7ca-c3fd606b3c19	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 07:44:39.141229+00	
00000000-0000-0000-0000-000000000000	82815e1c-909e-4632-bab6-44b001153630	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 07:44:40.560002+00	
00000000-0000-0000-0000-000000000000	3ba8d421-8959-4aca-8e27-ad9863491ed6	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 07:51:42.633074+00	
00000000-0000-0000-0000-000000000000	00ae889c-01d6-44f5-a587-ca22340f8049	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 07:51:45.625802+00	
00000000-0000-0000-0000-000000000000	321762fb-e654-40a9-95b1-a564a47cd62f	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 08:31:09.454657+00	
00000000-0000-0000-0000-000000000000	05d8736f-e5d7-4018-b0ce-f4897ea9e431	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 08:31:12.37143+00	
00000000-0000-0000-0000-000000000000	605b7fc9-8319-46e7-9a43-579e0620dffc	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 09:18:18.234988+00	
00000000-0000-0000-0000-000000000000	8439e0e5-5546-4240-914c-6cc464cffb88	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 09:18:20.734752+00	
00000000-0000-0000-0000-000000000000	1688d8b9-cb91-4db4-b7bb-7462138102bd	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 09:18:36.995903+00	
00000000-0000-0000-0000-000000000000	de2a8081-51b0-4406-acfa-0211af219188	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 09:18:39.605646+00	
00000000-0000-0000-0000-000000000000	54100f1a-3d1b-467d-adf4-498dcaa07ca8	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 09:20:29.356924+00	
00000000-0000-0000-0000-000000000000	01e6a6e6-0464-46ec-b594-b01b5357e204	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 09:20:31.699713+00	
00000000-0000-0000-0000-000000000000	e1616fc7-99a6-4c93-9e22-92f9e5076d88	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 09:20:33.383622+00	
00000000-0000-0000-0000-000000000000	ec965f88-462c-4119-8231-a27440dbeede	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 09:20:38.728936+00	
00000000-0000-0000-0000-000000000000	cdebba60-c426-40f8-bbde-979343d607f2	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 12:39:04.71026+00	
00000000-0000-0000-0000-000000000000	a4d66cb4-c232-4d63-b169-d4b9cf077c76	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 12:39:04.711323+00	
00000000-0000-0000-0000-000000000000	f77ffbd8-3486-4d3c-a863-707d6a21a54d	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 13:37:32.156041+00	
00000000-0000-0000-0000-000000000000	2b3071b1-b61f-4b62-85cd-cfb1287bd89a	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 13:37:32.158252+00	
00000000-0000-0000-0000-000000000000	e93cf15c-baa8-4d5c-bead-7a7f5a0e4f2f	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 14:35:59.407991+00	
00000000-0000-0000-0000-000000000000	b6acf952-a571-4726-be08-75bb15c90699	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 14:35:59.40963+00	
00000000-0000-0000-0000-000000000000	f5feea34-e430-4680-b013-2bd0c9c11004	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 09:06:40.785456+00	
00000000-0000-0000-0000-000000000000	adceb443-c396-4420-a849-a2baeb304104	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 09:06:43.131958+00	
00000000-0000-0000-0000-000000000000	debc137a-2fac-47e8-b4c3-d95515cb9bc5	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 09:20:24.059074+00	
00000000-0000-0000-0000-000000000000	1cb532de-4eee-44dc-9ba7-501bc96a1552	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 09:20:27.807525+00	
00000000-0000-0000-0000-000000000000	3a36bb13-55e6-4c4b-917c-73759bf17c83	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 09:29:41.677945+00	
00000000-0000-0000-0000-000000000000	749140ff-3a93-4378-aebc-7e503dcfcceb	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 09:29:44.713756+00	
00000000-0000-0000-0000-000000000000	07419651-05cd-4f6d-9e06-49084b6c5ed5	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 09:59:05.742872+00	
00000000-0000-0000-0000-000000000000	92d87ad3-c4a6-448e-81f1-49f6d36efad4	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 09:59:07.630173+00	
00000000-0000-0000-0000-000000000000	6f63cf46-973a-453e-9270-e00bd6c9e02d	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 15:34:07.497808+00	
00000000-0000-0000-0000-000000000000	1b83d730-2e61-4ff2-8faa-6131cbee5059	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 15:34:07.499344+00	
00000000-0000-0000-0000-000000000000	7c18183a-9fd2-461f-92e3-82bf65d56c2d	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 15:48:15.040274+00	
00000000-0000-0000-0000-000000000000	0fa222f7-e659-419f-942e-f1e830b0551a	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 15:48:16.356849+00	
00000000-0000-0000-0000-000000000000	0908374e-9ff7-4852-b742-844e7e8aadc0	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 16:20:25.378012+00	
00000000-0000-0000-0000-000000000000	8da4b591-d6ce-47d7-aa58-e0293144aebd	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 16:20:30.005291+00	
00000000-0000-0000-0000-000000000000	d768fa3e-c01a-4220-bfa9-873ec8262ec6	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 16:24:08.299569+00	
00000000-0000-0000-0000-000000000000	f55f4a3a-8dba-4f7f-91c9-ad6ccace3a43	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 16:24:10.5446+00	
00000000-0000-0000-0000-000000000000	dc337e06-6c1b-47ce-ade1-8641ca6325b0	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 16:32:47.429921+00	
00000000-0000-0000-0000-000000000000	6eaef101-7efe-4abd-a21b-8d1298769c13	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 16:33:01.528173+00	
00000000-0000-0000-0000-000000000000	c5b3743e-f7c7-41c4-9b46-4b78c44ab9ab	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-25 16:33:47.999146+00	
00000000-0000-0000-0000-000000000000	07f4d641-61df-4241-b838-a41f56d03d96	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 16:33:51.151776+00	
00000000-0000-0000-0000-000000000000	7e4c6760-82e8-4164-9d30-bdc1ca268dfe	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 03:15:39.647687+00	
00000000-0000-0000-0000-000000000000	54f45549-a79b-452a-b903-b98fdac6552e	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 03:15:39.649602+00	
00000000-0000-0000-0000-000000000000	314dac09-3c8c-45c7-9b95-388208bb3c46	{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 06:17:38.473718+00	
00000000-0000-0000-0000-000000000000	050760b4-669c-4d0d-8f49-050bd00bd23a	{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 06:17:38.474638+00	
00000000-0000-0000-0000-000000000000	90efe266-eb04-4dd9-819d-bd91953f94e4	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:20:28.869625+00	
00000000-0000-0000-0000-000000000000	49331514-1f82-4ba6-be30-27bdb4216395	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:20:33.416542+00	
00000000-0000-0000-0000-000000000000	24b66424-3a73-4191-abed-67694f7a87cf	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:20:56.308978+00	
00000000-0000-0000-0000-000000000000	f99a5304-2986-4f54-ad2b-c5ad0e82f42d	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:20:59.321568+00	
00000000-0000-0000-0000-000000000000	02064edf-ce60-445b-a36f-8bc8c7452068	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:21:03.895148+00	
00000000-0000-0000-0000-000000000000	b2448ad5-7bba-4ee3-8f1f-5332a3b7d51a	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:21:08.612876+00	
00000000-0000-0000-0000-000000000000	eab213a0-637a-4310-bcfe-9112a4544d33	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:21:30.343418+00	
00000000-0000-0000-0000-000000000000	fe73dbc1-afeb-4463-be24-65ee9f10fdab	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:21:32.775938+00	
00000000-0000-0000-0000-000000000000	b9a02122-0027-44d6-a1c8-567cacf25980	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:23:48.846881+00	
00000000-0000-0000-0000-000000000000	4ad04b79-dc35-424b-a2a4-3c09249edcc4	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:23:50.482609+00	
00000000-0000-0000-0000-000000000000	ecc272fc-ef6a-4314-8b98-4e954405be81	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:23:54.017922+00	
00000000-0000-0000-0000-000000000000	dced42d2-5c92-48a3-93f3-0b0af15f0c23	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:23:56.519734+00	
00000000-0000-0000-0000-000000000000	28071076-d7ad-4045-8b4e-7974e86ad5ba	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:24:30.854184+00	
00000000-0000-0000-0000-000000000000	f6fd0a5e-daf7-47c9-86d3-b453dd570f51	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:24:33.089203+00	
00000000-0000-0000-0000-000000000000	b8a4dfd3-c763-4951-a214-24bb574b1296	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:34:50.183535+00	
00000000-0000-0000-0000-000000000000	a23a981e-c9e8-4e1b-bcc8-5fa7474e34cf	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:34:53.323031+00	
00000000-0000-0000-0000-000000000000	b72281c5-7e35-4995-83a2-9016723492ea	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:35:01.185772+00	
00000000-0000-0000-0000-000000000000	986ba13f-c268-4f04-8b59-431846b0a233	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:35:03.13364+00	
00000000-0000-0000-0000-000000000000	82b3f712-64cd-4b53-81f2-5cc8f5c7a8e0	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:35:05.098978+00	
00000000-0000-0000-0000-000000000000	3132eb8f-e295-487f-aa7f-6b37f7f5767f	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:35:19.507575+00	
00000000-0000-0000-0000-000000000000	c5ca147b-20c7-4689-bc76-0753f4df14cb	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:35:26.751675+00	
00000000-0000-0000-0000-000000000000	74afb69a-705d-45e3-ae45-7eb3e5c3615e	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:35:32.758498+00	
00000000-0000-0000-0000-000000000000	a3eb66d8-1238-4bfb-ad4c-708bb75edd83	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:35:37.283004+00	
00000000-0000-0000-0000-000000000000	282288aa-6276-43f9-afec-36ab51edc7e9	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:35:41.7865+00	
00000000-0000-0000-0000-000000000000	566a154d-70df-4ff5-9501-eacd66b96218	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:35:47.111501+00	
00000000-0000-0000-0000-000000000000	8034c4a0-bf7f-4e5c-b462-c02d6f026b25	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:41:46.104308+00	
00000000-0000-0000-0000-000000000000	5f9739a5-1293-4ff0-a846-89d61dae9fd7	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:41:47.205118+00	
00000000-0000-0000-0000-000000000000	023f4b8f-80bd-4857-9e43-5f9e4e61169f	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:43:01.826576+00	
00000000-0000-0000-0000-000000000000	9b39df37-2c7a-4fef-8102-2ed87a5247a7	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:43:12.531781+00	
00000000-0000-0000-0000-000000000000	1a241c36-1f2d-45c3-8b52-d0e83296bd6d	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:43:27.228002+00	
00000000-0000-0000-0000-000000000000	a75815ac-36e7-4c3a-80c0-627e64946c0e	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:43:29.324045+00	
00000000-0000-0000-0000-000000000000	8467ac93-95f8-4448-88db-20f860165f11	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:43:30.47816+00	
00000000-0000-0000-0000-000000000000	a26419a2-9279-4737-8add-5904d28b6f54	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:43:32.315785+00	
00000000-0000-0000-0000-000000000000	31459ec7-1165-4fe4-9a71-47db34250031	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:25:03.358695+00	
00000000-0000-0000-0000-000000000000	b34407aa-cd29-47ae-9d21-afb382028bdf	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:25:04.813842+00	
00000000-0000-0000-0000-000000000000	babaa6fc-7186-437b-a2e6-d2a88ef5ca9a	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:35:06.88883+00	
00000000-0000-0000-0000-000000000000	46af0dfa-004a-469e-84d2-a2132283631e	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:35:14.040767+00	
00000000-0000-0000-0000-000000000000	2a194366-f430-4f84-99f4-388238de5e07	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:35:17.106149+00	
00000000-0000-0000-0000-000000000000	0ffbe53c-2ed9-4579-a9f8-7016e490c982	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:35:18.119915+00	
00000000-0000-0000-0000-000000000000	fc62f68d-0157-4318-a1c6-4bf2890d1517	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:35:30.229789+00	
00000000-0000-0000-0000-000000000000	18e544ad-dd98-404d-b1c5-9d43a83933b2	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:35:31.313162+00	
00000000-0000-0000-0000-000000000000	7c96930c-28a7-4fdb-8bf3-53696f56bf6b	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:36:03.587295+00	
00000000-0000-0000-0000-000000000000	5dc96e58-72f4-430f-b54b-b163f5f46153	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:38:14.720917+00	
00000000-0000-0000-0000-000000000000	2f386e2d-9e02-4991-a8a0-0755f4fbeb77	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:41:48.981288+00	
00000000-0000-0000-0000-000000000000	96210080-ca94-4074-b398-4d0a05506fc4	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:41:49.912466+00	
00000000-0000-0000-0000-000000000000	199673d9-8663-482e-bf0f-5797cc175c02	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:42:09.464462+00	
00000000-0000-0000-0000-000000000000	2ae6649d-56da-4db3-ac62-eae2fcbfdf70	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:42:10.536446+00	
00000000-0000-0000-0000-000000000000	3bd125a8-27d5-4d47-866e-6e889e603699	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:42:54.179586+00	
00000000-0000-0000-0000-000000000000	63e04003-7684-4a6d-9086-44bbf73e6381	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:42:56.143535+00	
00000000-0000-0000-0000-000000000000	3ce08344-fb59-4c44-bdd4-2874bd66d7e7	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:42:57.502953+00	
00000000-0000-0000-0000-000000000000	bda0b7b4-2490-4729-8363-e897dc402164	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:43:00.450113+00	
00000000-0000-0000-0000-000000000000	a1eb9631-0e81-4635-8505-e3f8825e345a	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:43:14.089947+00	
00000000-0000-0000-0000-000000000000	28b9c550-6d29-453f-8b09-4678dde25f47	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:43:16.832367+00	
00000000-0000-0000-0000-000000000000	4ac2c1e7-746a-450e-ad20-1af33b2828b8	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:43:18.51145+00	
00000000-0000-0000-0000-000000000000	c4176ced-8a3a-458a-947d-4b064776e3c0	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:43:22.525576+00	
00000000-0000-0000-0000-000000000000	07c8833f-3faa-4bca-ac84-a4237562376f	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:43:24.554436+00	
00000000-0000-0000-0000-000000000000	2de0d230-39d7-402b-88df-2f15d492fdbf	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:43:25.427582+00	
00000000-0000-0000-0000-000000000000	3b495507-d237-4375-b0c6-d12bd1a2b5eb	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:43:43.49671+00	
00000000-0000-0000-0000-000000000000	6c898396-9f3f-4383-b67c-8368dce7f6bb	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:45:13.714249+00	
00000000-0000-0000-0000-000000000000	68f8268a-c3a3-485b-a56f-a7549f970d8d	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:45:24.128458+00	
00000000-0000-0000-0000-000000000000	c3504927-e3b2-4549-bc5c-d626843d33d8	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:45:25.178735+00	
00000000-0000-0000-0000-000000000000	eeec6ce3-06d4-4746-a7c4-9262a699b5e1	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:47:50.235057+00	
00000000-0000-0000-0000-000000000000	1ff35807-ac2e-4623-860e-a70d5a142bd3	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:47:51.623785+00	
00000000-0000-0000-0000-000000000000	43c07816-aa9c-486d-b0f9-1fe59e8b57d9	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:47:55.185921+00	
00000000-0000-0000-0000-000000000000	5d36c45f-46c0-481d-ba54-165c3245a535	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:47:58.686121+00	
00000000-0000-0000-0000-000000000000	73056075-fa9d-49ee-8413-a31a3d812808	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:48:41.523483+00	
00000000-0000-0000-0000-000000000000	0333ca2e-e584-4fa4-bd26-5b3c59b9ebe0	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:48:45.337246+00	
00000000-0000-0000-0000-000000000000	af76bf87-dc94-40a5-a006-44b3a29d733a	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:48:48.649964+00	
00000000-0000-0000-0000-000000000000	cbc411d2-bd7e-4d80-b830-10d24d161644	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:50:41.56946+00	
00000000-0000-0000-0000-000000000000	66c270ea-a1d2-4ff8-a81a-f5783695bdd4	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:50:44.048051+00	
00000000-0000-0000-0000-000000000000	938e106d-1578-49f9-83e5-502281dfb5bd	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:51:57.240244+00	
00000000-0000-0000-0000-000000000000	fff9fc82-b8cb-41b5-a410-f28604ea3eee	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:51:59.070281+00	
00000000-0000-0000-0000-000000000000	dd726109-6e99-450e-92bd-b9a6b38535c5	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:52:00.208379+00	
00000000-0000-0000-0000-000000000000	d09fc50e-a4bf-45a6-a588-c97956d4bf1d	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:52:02.097031+00	
00000000-0000-0000-0000-000000000000	12dbdcdf-4f33-4b30-b389-3ebfbd89d0dd	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:52:03.27179+00	
00000000-0000-0000-0000-000000000000	70613f6a-5a28-42ca-aca6-9aead5424961	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:52:05.072191+00	
00000000-0000-0000-0000-000000000000	f3420362-a697-4340-bc69-bba2a18a3374	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:52:06.154194+00	
00000000-0000-0000-0000-000000000000	85ad2249-b4f9-4258-8308-67b25f7af9ee	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:52:08.452715+00	
00000000-0000-0000-0000-000000000000	d39d7663-7ffc-4d6d-8788-7ac16cbb9621	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:53:55.13982+00	
00000000-0000-0000-0000-000000000000	d0492874-dca8-4365-a355-627c66b2f387	{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:53:56.738072+00	
00000000-0000-0000-0000-000000000000	c1a61e73-c9c9-4c1d-886e-a7efac538c90	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:54:24.141023+00	
00000000-0000-0000-0000-000000000000	1b7a4b9b-6424-4d68-b924-b6b772a036f0	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:56:02.800792+00	
00000000-0000-0000-0000-000000000000	ad7affa2-21a5-48f4-9696-85a3d6d6ba6f	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:56:04.488044+00	
00000000-0000-0000-0000-000000000000	bae3c8de-4d0f-4382-82d1-82e09df79f62	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:56:07.930181+00	
00000000-0000-0000-0000-000000000000	080b9ffe-97cb-4d8c-a498-aad8b47eaccc	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:56:09.006184+00	
00000000-0000-0000-0000-000000000000	895c3ca7-2360-4b17-a958-c25be3d7f791	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:00:34.434311+00	
00000000-0000-0000-0000-000000000000	c2db9e52-09d7-4c23-ab78-cb043ac363fa	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:01:35.541778+00	
00000000-0000-0000-0000-000000000000	9d6f7b52-402a-45d2-aecc-08d8955e47e7	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:01:37.593831+00	
00000000-0000-0000-0000-000000000000	5e31e805-710d-40ce-a127-9a5413e89668	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:01:38.920421+00	
00000000-0000-0000-0000-000000000000	443e2a10-a4a0-44e7-8d83-60e40a1a8146	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:01:41.493896+00	
00000000-0000-0000-0000-000000000000	8038533f-135b-4c37-87a2-84813a99f870	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:01:42.812589+00	
00000000-0000-0000-0000-000000000000	640725d6-9c79-4f43-aad6-386433bf9920	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:05:45.689076+00	
00000000-0000-0000-0000-000000000000	d1abfd1b-eaa6-4b2c-b75a-ccd51af0dbfd	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:05:47.73065+00	
00000000-0000-0000-0000-000000000000	bdb32a3a-9431-4816-abb0-768a6600aae8	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:08:22.039999+00	
00000000-0000-0000-0000-000000000000	d6bf2abe-38c2-46d4-a45a-d3598f8e8283	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:08:29.481101+00	
00000000-0000-0000-0000-000000000000	dda10903-0ebc-4984-8b11-c70a41cb6e32	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:08:31.38947+00	
00000000-0000-0000-0000-000000000000	8fdadb57-c015-4899-913f-105d3e070a43	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:08:35.504458+00	
00000000-0000-0000-0000-000000000000	da272cab-5454-4f3d-8829-e20b549d4424	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:08:38.34359+00	
00000000-0000-0000-0000-000000000000	e290b5df-97c3-4712-952b-570e45074fae	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:49:11.718012+00	
00000000-0000-0000-0000-000000000000	cd5f7925-7bd2-43f0-9ccd-1564af714e0f	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:49:23.907455+00	
00000000-0000-0000-0000-000000000000	20f5a53c-5169-432c-a277-161966565279	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:50:45.724785+00	
00000000-0000-0000-0000-000000000000	b4bb7479-45d1-48f4-af9c-716196d2423e	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:50:47.614983+00	
00000000-0000-0000-0000-000000000000	800256eb-df46-4a5e-b6c8-b99e0fcee326	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:50:49.899572+00	
00000000-0000-0000-0000-000000000000	bc60d6b5-f756-424a-9f4c-58ca3a1269be	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:50:53.103599+00	
00000000-0000-0000-0000-000000000000	ccc453db-aed8-4d1e-86e2-4a0205397d48	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:50:54.233619+00	
00000000-0000-0000-0000-000000000000	26fcf589-dd0d-455c-981b-c21155de2c20	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:51:55.254091+00	
00000000-0000-0000-0000-000000000000	090ce21e-f043-4bf1-9a8f-b97a2ddb6e9a	{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 06:54:19.829088+00	
00000000-0000-0000-0000-000000000000	15482cab-891e-4784-a0e3-d2b0cc46bcd4	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 06:54:22.655901+00	
00000000-0000-0000-0000-000000000000	2294b195-b922-4d4f-a0e2-e3470b032f3a	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:00:36.019891+00	
00000000-0000-0000-0000-000000000000	ef73e31c-645e-469b-ab40-48ef64f7d465	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:00:38.428325+00	
00000000-0000-0000-0000-000000000000	7ad53468-11d6-4945-9078-ecdec1053fe3	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:00:39.467203+00	
00000000-0000-0000-0000-000000000000	2ad20543-fd3f-438e-ad0a-bb590ab2379c	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:01:34.141312+00	
00000000-0000-0000-0000-000000000000	c810a62d-e291-40c8-a895-f855e3de8175	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:08:26.666249+00	
00000000-0000-0000-0000-000000000000	43336259-8551-4df0-93de-d96c964bd128	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:08:27.918314+00	
00000000-0000-0000-0000-000000000000	24154553-3561-4376-aaa1-ff8f8d94fec3	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:10:10.96468+00	
00000000-0000-0000-0000-000000000000	6911f5b0-d337-4aa0-a59e-70fe1168b47b	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:10:12.086795+00	
00000000-0000-0000-0000-000000000000	eef1f26a-0d3e-4b10-aa13-e94dbbfaa844	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:10:13.328915+00	
00000000-0000-0000-0000-000000000000	c7fa674b-cb0f-4d0e-b67b-ffb4db20a9c3	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:10:15.295329+00	
00000000-0000-0000-0000-000000000000	d3d8118e-ab06-454b-bea6-cd9e421b3630	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:10:16.361145+00	
00000000-0000-0000-0000-000000000000	f23f5134-f625-46fa-ac32-76a6ff1f31a7	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:10:19.203398+00	
00000000-0000-0000-0000-000000000000	1a872477-7e41-4138-9a26-d98b7123ca60	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:10:20.128346+00	
00000000-0000-0000-0000-000000000000	7c1ddbd6-58aa-4071-b830-d0e65be54804	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:10:43.681631+00	
00000000-0000-0000-0000-000000000000	a82eeebf-2c84-4eba-8850-637ca9e32fa3	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:10:44.831296+00	
00000000-0000-0000-0000-000000000000	22101257-c73e-474c-a13c-43ed0dda1ff8	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:11:15.427666+00	
00000000-0000-0000-0000-000000000000	fc2338ed-ce9b-44c1-ae4d-69f8cba05724	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:11:17.322187+00	
00000000-0000-0000-0000-000000000000	e220d77e-95f8-4956-903d-b993de8873dc	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:11:21.746699+00	
00000000-0000-0000-0000-000000000000	0cd38a00-086e-4309-b5a0-11e6d0d263b8	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:11:23.030796+00	
00000000-0000-0000-0000-000000000000	211bfdc1-3ef9-4f18-84d4-d69eba178221	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:11:30.938565+00	
00000000-0000-0000-0000-000000000000	2c48ecca-b570-41d0-b6b7-c474c3004aaf	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:11:33.158229+00	
00000000-0000-0000-0000-000000000000	c1486289-43eb-4164-9e90-8c9a6ca462de	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:11:35.560695+00	
00000000-0000-0000-0000-000000000000	07b72227-2282-41dd-82fa-c039ec86c800	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:11:37.066355+00	
00000000-0000-0000-0000-000000000000	968b940e-62a2-4509-9076-221227702cd9	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:11:40.850752+00	
00000000-0000-0000-0000-000000000000	b8a9e1eb-0c38-4037-80c6-d473ed2e5db7	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:11:43.219159+00	
00000000-0000-0000-0000-000000000000	955e1987-396b-4887-bf69-573255267050	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:11:47.010076+00	
00000000-0000-0000-0000-000000000000	730e53ac-9d0a-477b-bd27-4964072df0b1	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:11:51.08924+00	
00000000-0000-0000-0000-000000000000	1486585f-8123-442d-b793-dae77e3a649c	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:12:01.166436+00	
00000000-0000-0000-0000-000000000000	f04b44c9-50e5-4ce6-b2e3-2ad4f196c530	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:19:18.042209+00	
00000000-0000-0000-0000-000000000000	c0bd1379-568e-4cf2-b6e5-8d16fdecab73	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:19:20.469106+00	
00000000-0000-0000-0000-000000000000	c64b42b1-9ed7-4948-a05d-54f9b22dcc2d	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:20:54.504358+00	
00000000-0000-0000-0000-000000000000	a621f2a6-a2de-46de-a03c-5e9c4045ed42	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:20:56.749083+00	
00000000-0000-0000-0000-000000000000	45c43955-56d6-4281-9e4d-87e8fe1ee779	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:20:58.682517+00	
00000000-0000-0000-0000-000000000000	e91c9c41-55e9-47a2-93a5-6f0d6a596720	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:21:23.566355+00	
00000000-0000-0000-0000-000000000000	6fa4a812-92bc-47b6-aec8-8c8b0187b425	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:27:44.626589+00	
00000000-0000-0000-0000-000000000000	1f5b7bfd-bcfc-43ea-947c-b1fcc8ab44f6	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:27:46.304963+00	
00000000-0000-0000-0000-000000000000	93651196-d3b4-4516-83ce-d2963e7b0064	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:27:47.706575+00	
00000000-0000-0000-0000-000000000000	33848b9f-d894-46ac-94cb-6b957d3dd80d	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:27:54.200354+00	
00000000-0000-0000-0000-000000000000	ba352809-542d-45b9-a825-326c321440ff	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:27:55.695128+00	
00000000-0000-0000-0000-000000000000	f695242d-a93c-4eff-a7f3-34e5d03df42e	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:27:57.815561+00	
00000000-0000-0000-0000-000000000000	1bfcf92a-1713-4ec2-8fa5-e437206fa06b	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:01:57.430632+00	
00000000-0000-0000-0000-000000000000	8f07490e-7c8b-4a9f-8818-7d1ccef18c3b	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:01:58.655691+00	
00000000-0000-0000-0000-000000000000	5a7193bf-d98e-4dee-900f-485ffd3b3de6	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:05:05.667852+00	
00000000-0000-0000-0000-000000000000	99a98a51-6dc1-4b52-92e1-fb889324fd49	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:05:06.847237+00	
00000000-0000-0000-0000-000000000000	1dcbe3a7-6d1e-4214-bba6-50bc2ee034bd	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:07:34.036113+00	
00000000-0000-0000-0000-000000000000	cabf179d-d023-4975-ae7b-0e3ae9c786be	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:07:36.18091+00	
00000000-0000-0000-0000-000000000000	f538a6aa-329c-4506-a232-00612c4244a9	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:09:22.047776+00	
00000000-0000-0000-0000-000000000000	08c17c03-4e11-49bb-9484-ddecdcfcf573	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:09:24.203457+00	
00000000-0000-0000-0000-000000000000	3edfe72b-6d14-4f97-9e2d-e901d1825c92	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:12:18.648841+00	
00000000-0000-0000-0000-000000000000	0f3e3781-7656-4c36-a6e3-bd60e67a5f4d	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:12:20.071786+00	
00000000-0000-0000-0000-000000000000	0ab03458-8f5a-47e9-801c-fe326efee06a	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:15:05.917501+00	
00000000-0000-0000-0000-000000000000	05923ec0-2d26-4bd6-bd32-be360bad2cea	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:15:08.88038+00	
00000000-0000-0000-0000-000000000000	a287c1f7-5b03-448c-8d67-4c6d6365e1e7	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:56:36.970107+00	
00000000-0000-0000-0000-000000000000	55a3d14d-a4e3-4b2d-a5df-95c2e7a09cfe	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:56:38.592156+00	
00000000-0000-0000-0000-000000000000	c8a95012-fb3a-4373-8bdc-e951f5600563	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 09:11:06.244288+00	
00000000-0000-0000-0000-000000000000	a7dd6e02-36ce-46f0-b7f6-27c1746d39e1	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 09:11:08.23963+00	
00000000-0000-0000-0000-000000000000	bc0a149f-aaa3-4dc2-816a-3c8a5fa17fab	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 09:50:20.57527+00	
00000000-0000-0000-0000-000000000000	ba56c306-9c9c-44cc-90bf-a2aa93abe1b6	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 09:50:22.328353+00	
00000000-0000-0000-0000-000000000000	9e39f72c-326f-4a06-b0ff-898ef07d0185	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:27:58.864337+00	
00000000-0000-0000-0000-000000000000	12f4132c-d899-4817-a6a1-ea9ba6101d03	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:28:25.000785+00	
00000000-0000-0000-0000-000000000000	4af12461-9fa1-4c21-aa2c-fe06eceebf81	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 07:59:05.472669+00	
00000000-0000-0000-0000-000000000000	eb76813e-150d-42ed-94bc-bc6b2e4a1cd2	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 07:59:09.676294+00	
00000000-0000-0000-0000-000000000000	6ef5a823-5dd6-4e14-b929-4e93d19065c3	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:06:10.800879+00	
00000000-0000-0000-0000-000000000000	8f48c769-4da4-4cee-b474-244de89bba47	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:06:11.86834+00	
00000000-0000-0000-0000-000000000000	12e66433-72f4-4ff6-b641-1116317a1c67	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:07:37.849687+00	
00000000-0000-0000-0000-000000000000	c7793f20-ecd7-4f3b-9e1a-c81a86a54f32	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:07:39.745964+00	
00000000-0000-0000-0000-000000000000	94824818-9da3-406f-b27c-51dec6179a13	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:09:14.268081+00	
00000000-0000-0000-0000-000000000000	bbf3afe6-3575-4a8f-b8b0-5e2a4d8ab105	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:09:15.705347+00	
00000000-0000-0000-0000-000000000000	cb601e60-5f56-4cab-9be0-2bd240337fc4	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:10:32.541129+00	
00000000-0000-0000-0000-000000000000	d70e927e-b68e-43b4-afce-8b1a70894344	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:10:33.583882+00	
00000000-0000-0000-0000-000000000000	a7d95664-4450-4211-bec8-505744b219e8	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:12:22.197613+00	
00000000-0000-0000-0000-000000000000	2a88f177-2091-459c-a216-cfc59094f02f	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:12:25.596169+00	
00000000-0000-0000-0000-000000000000	13974ba6-cfb8-4ba6-9402-c5fdb7ffde9d	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:25:04.954289+00	
00000000-0000-0000-0000-000000000000	5b4a3c05-32b8-47f7-bcac-9b6efd842705	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:25:06.964565+00	
00000000-0000-0000-0000-000000000000	3dcf6d64-3c7d-40af-a712-0ca14a53fcca	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:25:45.789324+00	
00000000-0000-0000-0000-000000000000	2d322cc9-bd89-4901-8211-50f1efb42ee3	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:25:48.278008+00	
00000000-0000-0000-0000-000000000000	cfb7cd0a-28db-4d3e-b4a7-a714f820302f	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:57:06.744677+00	
00000000-0000-0000-0000-000000000000	a58e3feb-948c-4f8d-999b-fa0434d08836	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:57:08.150832+00	
00000000-0000-0000-0000-000000000000	d86ab4d9-31a5-4b5c-b353-b56d4701c14a	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 08:57:53.994451+00	
00000000-0000-0000-0000-000000000000	67aed1e4-ebde-4797-ba10-d483b60d9046	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 08:57:56.09109+00	
00000000-0000-0000-0000-000000000000	de35da23-9ee4-46c7-b08f-6e2d70126498	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 09:38:44.84999+00	
00000000-0000-0000-0000-000000000000	42f336e8-1dec-49b2-ba68-d8819a193328	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 09:38:47.029936+00	
00000000-0000-0000-0000-000000000000	76a98446-9068-404b-897b-fa7a29b9ded5	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 09:42:29.694014+00	
00000000-0000-0000-0000-000000000000	e844cb9b-edfc-4ef7-8931-c605c4b72efc	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 09:42:31.875502+00	
00000000-0000-0000-0000-000000000000	3448bf02-62e9-4752-86c0-58e7eeeef9ff	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 09:43:18.862781+00	
00000000-0000-0000-0000-000000000000	7f8a52d2-c4ce-4cfe-bef5-347d39f20ddf	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 09:43:21.027033+00	
00000000-0000-0000-0000-000000000000	34cf3f66-e5e8-4992-8c9c-ca9f5232d4f6	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 10:02:41.796136+00	
00000000-0000-0000-0000-000000000000	04b07daa-44c1-4352-b483-be2267dda24b	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 10:02:43.080436+00	
00000000-0000-0000-0000-000000000000	db5be854-b8b3-4d01-81e9-17249dc31b31	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 10:02:46.309507+00	
00000000-0000-0000-0000-000000000000	e6850b69-9074-4a94-9b3f-75253482a377	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 10:02:47.274032+00	
00000000-0000-0000-0000-000000000000	30633131-95f5-476d-a79b-2e64d79fb5f6	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 10:19:09.63743+00	
00000000-0000-0000-0000-000000000000	3d5fbe74-3a6b-4e0d-a41a-1e54dbc54b02	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 10:19:11.974121+00	
00000000-0000-0000-0000-000000000000	0430f1ae-4558-4aaa-95f6-58434d740a05	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 10:19:50.131958+00	
00000000-0000-0000-0000-000000000000	503b4966-780f-4ca1-b877-d139b71cb68c	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 10:19:53.103066+00	
00000000-0000-0000-0000-000000000000	0f243312-6acc-49b7-bb63-899c4f37f3a2	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 10:35:29.524283+00	
00000000-0000-0000-0000-000000000000	17b91915-f18b-4797-80c2-9037d3f84461	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 10:35:30.444612+00	
00000000-0000-0000-0000-000000000000	bb3462f3-35b8-41d2-8c06-c720742103c5	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 15:41:54.149416+00	
00000000-0000-0000-0000-000000000000	da90bd0d-894d-4117-9fad-877fadc920ea	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 15:41:56.550069+00	
00000000-0000-0000-0000-000000000000	5a9b42ce-535c-4db7-afe7-3ffbe16b4092	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 16:02:53.033379+00	
00000000-0000-0000-0000-000000000000	a5314dc3-2350-4578-82a7-d5c78044e0bf	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 16:02:55.18308+00	
00000000-0000-0000-0000-000000000000	66aab0ab-0455-4b39-9a05-89c2f0b4ad5c	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 16:16:58.021578+00	
00000000-0000-0000-0000-000000000000	cad5d9e5-4ef7-4fb1-9b98-135d7b3a12e8	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 16:17:00.430502+00	
00000000-0000-0000-0000-000000000000	f7bf9e3f-ded0-4658-8269-e2f98878f79f	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 16:17:24.411954+00	
00000000-0000-0000-0000-000000000000	086ace8a-e400-47f6-a20c-6569aa6371e4	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 16:17:26.634001+00	
00000000-0000-0000-0000-000000000000	85bef108-ca49-491e-a74f-c68c616170ef	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 16:27:10.974663+00	
00000000-0000-0000-0000-000000000000	1e8f7d51-b484-4671-a6f9-56c4fea5f06b	{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 16:27:13.674678+00	
00000000-0000-0000-0000-000000000000	f9f5e124-dc12-4f4d-becf-6f5e8b4dbf3f	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 16:27:49.304601+00	
00000000-0000-0000-0000-000000000000	00e1edd0-4432-42d1-9ac7-33129ee60317	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 16:27:51.863018+00	
00000000-0000-0000-0000-000000000000	aba84095-f7c9-41e6-b11d-e94665b2c403	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 16:28:11.752662+00	
00000000-0000-0000-0000-000000000000	ac69cb7e-465f-42b0-b6f7-f8501a10d942	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 10:34:22.379763+00	
00000000-0000-0000-0000-000000000000	200194b8-ee96-4212-ae9a-fdb29436faba	{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 10:34:23.786123+00	
00000000-0000-0000-0000-000000000000	957bc829-3b40-44b3-b43c-62384a5afe8c	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 10:36:35.620259+00	
00000000-0000-0000-0000-000000000000	e31d13eb-d412-42a5-a6c8-27cce7c271bd	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 10:36:37.892373+00	
00000000-0000-0000-0000-000000000000	7fb2f8d9-726c-43aa-a955-60c56ecf4e38	{"action":"token_refreshed","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 14:49:57.634029+00	
00000000-0000-0000-0000-000000000000	14275c5c-cdd9-437e-82c6-a4c66ba37c33	{"action":"token_revoked","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 14:49:57.635106+00	
00000000-0000-0000-0000-000000000000	53ac7973-a561-48d5-8944-8daffe377a6d	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 14:51:32.039749+00	
00000000-0000-0000-0000-000000000000	c05ad7c6-6f01-4313-802e-01f5314f971b	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 14:51:33.627448+00	
00000000-0000-0000-0000-000000000000	4c747c3e-6ff3-45b7-951c-6c780782e031	{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 15:07:14.855497+00	
00000000-0000-0000-0000-000000000000	9e8e7c57-7771-4bf7-a42b-6be32d97c09e	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 15:07:17.658322+00	
00000000-0000-0000-0000-000000000000	0d488402-04df-4f97-9124-97061b007e3a	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 16:02:37.897287+00	
00000000-0000-0000-0000-000000000000	b43fbbb1-ddc4-4068-ac7b-9d7082dd48dc	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 16:02:40.267673+00	
00000000-0000-0000-0000-000000000000	2c23f5ff-a3a3-4987-891a-8480a6b90b75	{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 16:26:15.415287+00	
00000000-0000-0000-0000-000000000000	3df2be71-70cc-443d-865e-8a2660914615	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 16:26:17.834749+00	
00000000-0000-0000-0000-000000000000	f9c9ad5b-b6d8-4240-b01c-11cce7bac250	{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-26 16:27:36.501499+00	
00000000-0000-0000-0000-000000000000	de8291ab-c3d0-47bd-846d-b9d2d281bd2c	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-26 16:27:40.278773+00	
00000000-0000-0000-0000-000000000000	d47bcd31-c869-4929-a55e-11c760b3ce9b	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-27 02:57:34.479829+00	
00000000-0000-0000-0000-000000000000	4ef86603-d927-450a-9542-62e9bdc18087	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-27 03:02:47.174966+00	
00000000-0000-0000-0000-000000000000	b3d97332-78cb-4f4c-9d50-9993c7a11d35	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-27 03:02:48.283419+00	
00000000-0000-0000-0000-000000000000	53b9091f-4649-45e0-aeab-f85ed23586fa	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 04:00:48.756872+00	
00000000-0000-0000-0000-000000000000	2ad73ffb-a8fb-4503-b349-328ddf385930	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 04:00:48.757949+00	
00000000-0000-0000-0000-000000000000	62b3df6b-6287-4fed-b127-5eaf830d954c	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 04:58:53.608527+00	
00000000-0000-0000-0000-000000000000	d6c1c9ec-b7e9-4869-81df-1ab12b612b1e	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 04:58:53.609708+00	
00000000-0000-0000-0000-000000000000	e99b106d-afe6-4692-b2b5-d515a0d404d0	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 07:54:32.869578+00	
00000000-0000-0000-0000-000000000000	69b25fd5-f348-4915-bd37-23150267f2de	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 07:54:32.871797+00	
00000000-0000-0000-0000-000000000000	27f79d64-67ac-4c26-8f7e-f0233323b48c	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"payment@victorybulacan.org","user_id":"fa5060a6-3996-46ea-ae5f-bd3fed7e251a","user_phone":""}}	2025-02-27 08:17:02.152796+00	
00000000-0000-0000-0000-000000000000	5cfb8150-deaf-476f-bc91-b9d5b6c8a30a	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 08:56:31.509896+00	
00000000-0000-0000-0000-000000000000	82fb22ec-7eea-4171-8a23-88106e1cb11e	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 08:56:31.510894+00	
00000000-0000-0000-0000-000000000000	0bc9b4bf-0248-4c6f-a5c2-9a9193ecad97	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-27 09:13:43.065636+00	
00000000-0000-0000-0000-000000000000	75e797a7-ab83-4d1a-94f0-ae8269708e96	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 09:54:43.204062+00	
00000000-0000-0000-0000-000000000000	9914588d-f171-4869-92eb-3a0a0e56ac6a	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 09:54:43.205227+00	
00000000-0000-0000-0000-000000000000	6cf5a891-66f8-4cb7-9e62-5d0cebe9e981	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 10:14:24.740347+00	
00000000-0000-0000-0000-000000000000	7f77bc1c-a7f0-449a-959f-5a0cc584cf7e	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 10:14:24.74092+00	
00000000-0000-0000-0000-000000000000	4846a66a-2fca-4384-b5e8-04c455fab1a5	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 10:52:43.211563+00	
00000000-0000-0000-0000-000000000000	a410b5f0-4df4-4047-8829-f656418daf07	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 10:52:43.21308+00	
00000000-0000-0000-0000-000000000000	18ba8ca1-37ad-4283-9d0e-73c1abf88808	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 15:15:48.075704+00	
00000000-0000-0000-0000-000000000000	da8fc3fb-d062-45b3-8642-0cf395f0fc4d	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 15:15:48.077359+00	
00000000-0000-0000-0000-000000000000	58bfd33d-12ec-4ed2-bdd7-f3f48b249eae	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-27 15:41:23.524683+00	
00000000-0000-0000-0000-000000000000	4b9b6aa5-0adc-428a-845e-4afb4e37d8bf	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 16:14:17.202905+00	
00000000-0000-0000-0000-000000000000	267b0a75-d3fd-4949-81ad-1f016fe980aa	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 16:14:17.20362+00	
00000000-0000-0000-0000-000000000000	bd824a55-3985-43a0-a3bb-d0a82ed2b614	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 16:39:38.429778+00	
00000000-0000-0000-0000-000000000000	397fc22c-5c45-4c7d-a60f-dc8a18506dd6	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 16:39:38.43039+00	
00000000-0000-0000-0000-000000000000	a6cfb398-be32-431b-bd98-cc8ff1b00282	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-27 16:56:14.569399+00	
00000000-0000-0000-0000-000000000000	e48e1b9a-90f9-4da3-ba66-b18ec4e70d58	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 17:45:51.788884+00	
00000000-0000-0000-0000-000000000000	2c75ca13-7746-4e3b-84a0-dd163622ed03	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 17:45:51.790262+00	
00000000-0000-0000-0000-000000000000	fc1ebca8-7269-4015-9d44-b9a62875b10e	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 17:54:23.231332+00	
00000000-0000-0000-0000-000000000000	a09ac44f-f228-4686-b6f0-ffc4dae892b8	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-27 17:54:23.232149+00	
00000000-0000-0000-0000-000000000000	080fbf55-fe3b-49d7-9e05-3488ce177319	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 01:17:34.051079+00	
00000000-0000-0000-0000-000000000000	e687c449-9149-4cfb-9d9f-94565ec68229	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 01:17:34.052727+00	
00000000-0000-0000-0000-000000000000	cbe524b2-f624-4f52-9ba9-477ed16c9f84	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 02:07:29.45167+00	
00000000-0000-0000-0000-000000000000	da4435a3-6750-41c0-a6e5-25b42ef0f853	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 02:17:57.976033+00	
00000000-0000-0000-0000-000000000000	bc112f27-fd3b-4cff-bf9a-e5e1473b7504	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 02:17:57.97664+00	
00000000-0000-0000-0000-000000000000	34b2e709-6d7f-466e-81c9-970e14f3e517	{"action":"token_refreshed","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 03:05:55.508774+00	
00000000-0000-0000-0000-000000000000	e66483ed-d596-489f-9e78-4a61e286976b	{"action":"token_revoked","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 03:05:55.509837+00	
00000000-0000-0000-0000-000000000000	c18a57be-296b-4c9a-92de-4cf2c31c64f2	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 03:18:04.539398+00	
00000000-0000-0000-0000-000000000000	46fdf136-8e55-4ba9-9c93-8706a6d27348	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 03:18:04.540186+00	
00000000-0000-0000-0000-000000000000	595f0f1e-2b27-419c-9d4d-c404b9a2a0b5	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 03:18:04.552452+00	
00000000-0000-0000-0000-000000000000	0583d596-3699-47f4-9e19-7e94da8e3748	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 03:18:04.577164+00	
00000000-0000-0000-0000-000000000000	1a2f706e-fae2-4159-b3e3-48d207aa0cba	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-28 03:59:41.509997+00	
00000000-0000-0000-0000-000000000000	ed69933e-ab7a-417f-af35-be8eaee7df72	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 03:59:42.56039+00	
00000000-0000-0000-0000-000000000000	429d8684-f6b8-45ef-a88b-0d9f6473cc12	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-28 04:12:43.201095+00	
00000000-0000-0000-0000-000000000000	4643bb6f-e908-4d45-b3b6-d64432660e40	{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 04:12:44.857191+00	
00000000-0000-0000-0000-000000000000	04b4f5ae-226a-4423-8eb7-302303e6bf3a	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 05:11:10.15072+00	
00000000-0000-0000-0000-000000000000	f8e6ece7-c7ff-45ea-88ff-f4ac200ebf07	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 05:11:10.152139+00	
00000000-0000-0000-0000-000000000000	da1c7d1c-eafb-4084-b8b4-12faab123d2d	{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 06:09:16.966305+00	
00000000-0000-0000-0000-000000000000	e351d6f2-b539-4d06-8b9e-4a83df555559	{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-02-28 06:09:16.967823+00	
00000000-0000-0000-0000-000000000000	5241b16a-dd54-4fe2-b37b-0e774316aa64	{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-02-28 06:57:29.635951+00	
00000000-0000-0000-0000-000000000000	c35f4b35-a523-4d8e-be0d-7324912d2ba0	{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-28 06:57:33.71737+00	
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
\N	584a1909-5797-4297-88d3-06bf5dc3922a	\N	\N	mary.anne.ma??????osa@example.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ab8dc40a-9c9b-4391-823b-8578ab506e5e	\N	\N	erick@victory.ph	$2a$06$uItYcsOBm8eBgt7QVONaF.FOMfMH1uOTIbc/bqyGu.atszZDHAdRS	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "Erick Fernandez"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	ec874457-5ac3-48c2-90dd-9ea0b8166635	\N	\N	red@victory.ph	$2a$06$F5Jeg/omusrLqDKzZFIsG.9ctGGX0UWe1zBeJ2NMl9VyJFlyg9A.m	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "Red Pondang"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	48d301bd-fea6-4d85-92c0-bf066aa23ae8	\N	\N	king@victory.ph	$2a$06$EyNZ3392zU21Lccs8gQOau/sy/bKsaXkeK9HJbxMHmuy0vAr0py2y	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "King Borlongan"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a3a1e735-b662-49ab-8ccc-a23686553bc3	\N	\N	loyd@victory.ph	$2a$06$uX30zKgwacDmXdQitLVPsO.T15tHd.xEbwOAPwlxB2WFzmp1RkS/W	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "Loyd Janobas"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	326aada0-3dcc-4566-84cc-2541c0e134e2	\N	\N	moss@victory.ph	$2a$06$19KvkzA0VRY0Roam91kaR.icF/K5RVDQVAH/798xz8yG72N1UeHSe	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "Moss Manalaysay"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6f9579a9-4f08-4ab5-8fd2-b7c3d2ee87e2	\N	\N	anthony@victory.ph	$2a$06$IoLlM4tFiZx3TY8r9b8Om.UoQlZe/tHfC7doVnim3r8bnqvHQRexu	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "Anthony Licud"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	910ef066-fdcb-4f99-aac4-458aaacc7a5b	\N	\N	rouie@victory.ph	$2a$06$Es.rUCzV.4RfnuhakTPefua1Rpg57bpFFX0QS9rLEhWcs8lr4yTke	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "Rouie Gutierrez"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	712b5dd0-cd8d-4293-8e66-640624002f2b	\N	\N	robert@victory.ph	$2a$06$N671sRr.I7CHarEpX3kHQO3HhiI8RX1akDmbqdVagLSn8xGNz58Ra	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00		2025-02-06 02:59:11.366863+00			2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	{"provider": "email", "providers": ["email"]}	{"full_name": "Robert Guevarra"}	f	2025-02-06 02:59:11.366863+00	2025-02-06 02:59:11.366863+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	3795175a-52aa-495b-81c8-01e2d7ae99de	authenticated	authenticated	rob.guevarra@gmail.com	$2a$10$BC3kgPAaleXzuALMTqGv2.iDF7IQgDgWR/Gksr/od0guIjECp6dLe	2025-02-19 02:17:04.338282+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 02:17:04.333903+00	2025-02-19 02:33:39.634178+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	b188f631-2561-457a-9be6-f556043dfc94	authenticated	authenticated	zoebguevarra@gmail.com	$2a$10$bQHdaPyK1mdXGgQg9o7vq.69b5aB3wbEsZknKCuY8gylTeGxY35eq	2025-02-19 12:19:24.266501+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:19:24.26075+00	2025-02-19 12:19:24.267059+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	bba4e5c1-2eb0-46bd-8f09-cd331ceab351	authenticated	authenticated	xionguevarra@gmail.com	$2a$10$uuySj6hE0NPYCJ/9hY7eY.GQoHA5JVNKiNe.233sCB17XzJQmCRAS	2025-02-19 12:22:37.70027+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:22:37.698012+00	2025-02-19 12:22:37.700734+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	bdebd3ea-5c80-4dff-a03c-a7d0a08947ef	authenticated	authenticated	gracebguevarra@gmail.com	$2a$10$tKIxwleZhiOphLhMGDgkDOd5pu.xBB6ooHQaKkiRG9ly778P8MCc.	2025-02-19 12:24:33.056454+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:24:33.054346+00	2025-02-19 12:24:33.056864+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	authenticated	authenticated	cd@gmail.com	$2a$10$dKkU/wN4mOLpL.K852iaGeHZG8MyDfLvcyV/.hOsd/MgEEoTKbjBK	2025-02-19 13:56:36.950301+00	\N		\N		\N			\N	2025-02-28 04:12:44.857785+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 13:56:36.947999+00	2025-02-28 06:09:16.970499+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	authenticated	authenticated	finance@gmail.com	$2a$10$Lzy8Zvwn31AF8ZODI3d0WOF2qRecqIZaYe5Ct/vH.bUftt8tckDfq	2025-02-19 13:29:47.97838+00	\N		\N		\N			\N	2025-02-26 16:17:26.635334+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 13:29:47.975428+00	2025-02-26 16:17:26.636787+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	dc34a52e-aed8-4354-abb6-7b49085ac24e	authenticated	authenticated	yoshiii@gmail.com	$2a$10$UxqGBuoqgsO/sv1kE9/ZTe76jtRU.pKUW7NHCSeUDbNiAXIv4oMp.	2025-02-19 12:38:02.883063+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:38:02.880649+00	2025-02-19 12:38:02.883441+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	047a2a75-cb6a-46b6-a039-2958efb1af2b	authenticated	authenticated	yosxxx@gmail.com	$2a$10$Paeli66jhVZyj66x8jbGDeCYOV55pbWdvLxIIqJCyZhjeXIthzGQS	2025-02-19 12:38:31.38067+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:38:31.378627+00	2025-02-19 12:38:31.381196+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	3573c57b-43e2-4947-9f9b-38d9bd01ee7f	authenticated	authenticated	jeje@gmail.com	$2a$10$kpZ/v2HbAslAxY0OFPTf8ewfBOuWpX9dabxUnTnQfuiP.sQNG5G.6	2025-02-19 12:40:19.188704+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:40:19.186283+00	2025-02-19 12:40:19.189136+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	bc9fc16c-f1f9-4c2f-ba95-51bd5a0594f3	authenticated	authenticated	jejehaa@gmail.com	$2a$10$jjvya720DEl2VoXs5Fq51ea/jLjYKWtof.G0CO8sqIll.9eKbs2Fe	2025-02-19 12:40:30.356781+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:40:30.354803+00	2025-02-19 12:40:30.357201+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	94f2d973-d8df-435e-8b43-98e7b44fe45b	authenticated	authenticated	reverx@gmail.com	$2a$10$ECtO3fAXDaZVBSTj5Uo2de/jch7UkvX7V7P/OBhWjU695VzHmoWmu	2025-02-19 12:44:47.231916+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 12:44:47.229524+00	2025-02-19 12:44:47.232275+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6d5b86c5-2939-4003-bb6f-6b177a60038e	authenticated	authenticated	pastor@gmail.com	$2a$10$lafH4rkirV1Xu0/wTSW4LO6UqzinPdhBdGjhrERdOiRzVAqT0cAFG	2025-02-19 13:30:03.49485+00	\N		\N		\N			\N	2025-02-26 16:27:13.675216+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 13:30:03.492587+00	2025-02-26 16:27:13.676371+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	authenticated	authenticated	payment@victorybulacan.org	$2a$10$QaQcIH9LGiqQdXFimIDRkue1tbC.c9G4awxDgKSSrYTBgDL7bTYhO	2025-02-27 08:17:02.153929+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-27 08:17:02.140358+00	2025-02-27 08:17:02.154624+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	aebdeee3-427f-4d5b-832d-8c4ebaecdddc	authenticated	authenticated	robneil@gmail.com	$2a$10$wE3mczoBf3hHpZkp2jzRIun1BjDERCfP2eLLfohe8YJugtBS0.8D2	2025-02-04 04:10:22.352101+00	\N		\N		\N			\N	2025-02-26 06:53:56.739017+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-04 04:10:22.347235+00	2025-02-26 06:53:56.740467+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	aefe15fe-4937-4f55-a6cb-fb8d739c5905	authenticated	authenticated	missionary@gmail.com	$2a$10$NgRI2rXLmcWMDCbeiBdYp.hlbTwNJpLauzflbj5MpSH6SnFgwszAO	2025-02-19 13:56:14.839908+00	\N		\N		\N			\N	2025-02-28 06:57:33.718054+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-02-19 13:56:14.836832+00	2025-02-28 06:57:33.720034+00	\N	\N			\N		0	\N		\N	f	\N	f
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
fa5060a6-3996-46ea-ae5f-bd3fed7e251a	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	{"sub": "fa5060a6-3996-46ea-ae5f-bd3fed7e251a", "email": "payment@victorybulacan.org", "email_verified": false, "phone_verified": false}	email	2025-02-27 08:17:02.14872+00	2025-02-27 08:17:02.148755+00	2025-02-27 08:17:02.148755+00	6c521fda-52d8-4f40-8db1-6912697b5bcd
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
d4f88361-ded1-4a95-8d43-79388b6c0f9e	aefe15fe-4937-4f55-a6cb-fb8d739c5905	2025-02-28 02:07:29.452951+00	2025-02-28 03:05:55.513161+00	\N	aal1	\N	2025-02-28 03:05:55.51313	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	172.18.0.1	\N
51329bf2-e86a-46c9-9ade-2b04d86095f3	aefe15fe-4937-4f55-a6cb-fb8d739c5905	2025-02-28 06:57:33.718161+00	2025-02-28 06:57:33.718161+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36	172.18.0.1	\N
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
d4f88361-ded1-4a95-8d43-79388b6c0f9e	2025-02-28 02:07:29.45735+00	2025-02-28 02:07:29.45735+00	password	e49b7c9c-493e-4f81-bd79-47f320e26836
51329bf2-e86a-46c9-9ade-2b04d86095f3	2025-02-28 06:57:33.720481+00	2025-02-28 06:57:33.720481+00	password	b4404031-979c-4eca-b13f-3dff9c1034cf
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
00000000-0000-0000-0000-000000000000	476	ZjRbi_7w8WuZv-qstnQMgg	aefe15fe-4937-4f55-a6cb-fb8d739c5905	t	2025-02-28 02:07:29.455566+00	2025-02-28 03:05:55.510312+00	\N	d4f88361-ded1-4a95-8d43-79388b6c0f9e
00000000-0000-0000-0000-000000000000	478	JC-q4SF4u0Lj7gitsStIoA	aefe15fe-4937-4f55-a6cb-fb8d739c5905	f	2025-02-28 03:05:55.510986+00	2025-02-28 03:05:55.510986+00	ZjRbi_7w8WuZv-qstnQMgg	d4f88361-ded1-4a95-8d43-79388b6c0f9e
00000000-0000-0000-0000-000000000000	484	mL5uWfnctzquukJ1EBLpjA	aefe15fe-4937-4f55-a6cb-fb8d739c5905	f	2025-02-28 06:57:33.719201+00	2025-02-28 06:57:33.719201+00	\N	51329bf2-e86a-46c9-9ade-2b04d86095f3
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
669	yost	\N	\N	2025-02-26 09:49:00.398716+00
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
670	jexxg	\N	\N	2025-02-26 09:55:03.003487+00
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
671	Rob	\N	\N	2025-02-26 10:00:00.988847+00
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
672	jpop	\N	\N	2025-02-26 10:00:11.499506+00
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
673	Rob G	\N	\N	2025-02-26 10:12:53.880468+00
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
658	JEx	\N	\N	2025-02-26 09:06:26.179+00
659	jepbuz	\N	\N	2025-02-26 09:06:40.972008+00
660	jepbuz	\N	\N	2025-02-26 09:06:52.561061+00
661	jepbuz	\N	\N	2025-02-26 09:06:53.173244+00
662	jepbuz	\N	\N	2025-02-26 09:06:53.937007+00
665	faefa	\N	\N	2025-02-26 09:15:24.083774+00
666	Jibong	\N	\N	2025-02-26 09:16:08.310369+00
667	Jpo11	\N	\N	2025-02-26 09:19:56.675674+00
668	Jekong	\N	\N	2025-02-26 09:23:56.075842+00
674	Yosheff	\N	\N	2025-02-26 10:30:35.591478+00
675	Jeppo	partner@victorybulacan.org	999999	2025-02-26 10:51:05.688476+00
676	pipoy	partner@victorybulacan.org	999 999 99	2025-02-26 14:50:59.535729+00
677	joker	partner@victorybulacan.org	451141144	2025-02-26 14:52:05.18499+00
678	jeiki	partner@victorybulacan.org	55511555	2025-02-26 14:52:20.100761+00
679	grace	partner@victorybulacan.org	21515511	2025-02-26 15:04:25.669029+00
680	jebus	\N	\N	2025-02-26 15:16:55.467295+00
681	jejegg	jfeogljaf	12912354018951	2025-02-26 15:23:49.332389+00
682	popoy	popoy@gmail.com	9109955111	2025-02-26 15:24:16.946401+00
683	android1	\N	\N	2025-02-26 15:27:08.969882+00
684	android2	android@lgala	899819181	2025-02-26 15:27:28.367635+00
685	muerta	\N	\N	2025-02-26 15:36:26.626417+00
686	puerta	\N	\N	2025-02-26 15:36:34.76394+00
687	jexpoden	\N	\N	2025-02-26 15:51:42.336288+00
688	cococrunch	\N	\N	2025-02-26 16:00:32.151151+00
689	hekhek	\N	\N	2025-02-26 16:16:05.098999+00
690	yeyeh	\N	\N	2025-02-26 16:24:45.896687+00
691	Test Donor	test@example.com	+123456789	2025-02-27 08:08:47.749493+00
692	keklow	\N	\N	2025-02-27 09:14:05.299412+00
693	Test Dxz	teszt@example.com	+123456789	2025-02-27 09:38:49.051076+00
694	Biboy Ching	chingchongt@example.com	+123456789	2025-02-27 15:16:20.070353+00
695	Biboeey Ching	chingchongeet@example.com	+123456789	2025-02-27 15:38:49.248875+00
696	Bulk Donation	bulk@example.com	\N	2025-02-27 15:54:20.337477+00
698	Rob G	robg@gmail.com	\N	2025-02-27 17:08:59.267195+00
699	Campus Director	cd@gmail.com	\N	2025-02-27 17:17:19.965668+00
700	Bebfey Ching	chingchongefet@example.com	+123456789	2025-02-28 01:18:26.616493+00
702	hing	cfet@example.com	+1234567829	2025-02-28 01:57:42.005025+00
703	Missionary	missionary@gmail.com	\N	2025-02-28 02:07:57.546076+00
705	Robx Guevarra	robneilx@gmail.com	\N	2025-02-28 05:05:04.389213+00
706	Miss	miss@gmail.com	\N	2025-02-28 05:09:26.5553+00
707	Michael	partner@gmail.com	\N	2025-02-28 05:11:57.198386+00
708	Steph	stephcurry@gmail.com	\N	2025-02-28 05:18:51.768581+00
709	Steph	steph@gmail.com	\N	2025-02-28 05:19:23.10264+00
710	Michell	mich@gmail.com	\N	2025-02-28 05:23:27.054088+00
711	juva	juva@mgial.com	\N	2025-02-28 05:27:50.035926+00
712	jfu	fu@gma.com	\N	2025-02-28 05:31:17.468664+00
713	faff	faff@fafaca.com	\N	2025-02-28 05:34:27.976442+00
714	ffefe	fefe@gmail.com	\N	2025-02-28 05:37:13.499574+00
715	fefef	feff@faff.net	\N	2025-02-28 05:37:33.671206+00
716	Rob Gff	fafa@fafa.faf	\N	2025-02-28 05:42:28.014934+00
717	faffa	fafa@fafaf.com	\N	2025-02-28 05:48:44.731445+00
718	ffafffae	fafae@gaafa.com	\N	2025-02-28 05:51:01.633973+00
719	ff141	f1234a@fafac.com	\N	2025-02-28 05:59:03.738305+00
720	4414	faf213@gmail.com	\N	2025-02-28 05:59:33.901717+00
721	rea	rea@gaafa.com	\N	2025-02-28 06:02:58.859927+00
722	ffae12	fae112@gacc.com	\N	2025-02-28 06:42:21.667407+00
723	jepoo	popp@gmai.com	\N	2025-02-28 06:43:18.610424+00
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
584a1909-5797-4297-88d3-06bf5dc3922a	Mary Anne Ma??????osa	missionary	1	b794e95a-97f4-4c05-aa2d-3c13c4155841	34087.12	0.00	2025-02-04 04:08:51.060317+00	2025-02-04 04:08:51.060317+00
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
94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	Campus Director	campus_director	10	\N	45000.00	0.00	2025-02-19 13:56:36.956417+00	2025-02-19 13:56:36.956417+00
fa5060a6-3996-46ea-ae5f-bd3fed7e251a	PaymentProcessor	finance_officer	10	\N	0.00	0.00	2025-02-27 08:19:36.289499+00	2025-02-27 08:19:36.289499+00
\.


--
-- Data for Name: donor_donations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.donor_donations (id, donor_id, missionary_id, amount, date, source, status, notes, recorded_by, payment_id, payment_status, payment_method, payment_channel, payment_details, invoice_id, invoice_url, fee_amount, payment_date) FROM stdin;
1	1	1934abf8-eca9-41d8-bc5f-9c649285b76b	2745.98	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2	1	1934abf8-eca9-41d8-bc5f-9c649285b76b	3498.31	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3	1	1934abf8-eca9-41d8-bc5f-9c649285b76b	3900.31	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4	2	fd99f59b-fcc6-42ef-a407-207f110f2d7b	1345.83	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5	2	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4622.55	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6	2	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4358.52	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7	3	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2298.18	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8	3	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4308.26	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9	3	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4809.44	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
10	4	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1763.71	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
11	4	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2349.47	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
12	4	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3088.56	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
13	5	a83848ba-0779-4fac-98ee-f5f459b2742b	2867.62	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
14	5	a83848ba-0779-4fac-98ee-f5f459b2742b	3166.93	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
15	5	a83848ba-0779-4fac-98ee-f5f459b2742b	5886.78	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
16	6	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5000.87	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
17	6	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5814.49	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
18	6	b1f5db31-bfc8-409c-8925-0d21f1c780e6	4042.92	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
19	7	5432f125-2d5e-42ab-849a-29add2cf0a74	1236.21	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
20	7	5432f125-2d5e-42ab-849a-29add2cf0a74	1563.23	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
21	7	5432f125-2d5e-42ab-849a-29add2cf0a74	3765.52	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
22	8	463737cc-950b-4a41-8d73-a3daf931fee5	3924.57	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
23	8	463737cc-950b-4a41-8d73-a3daf931fee5	2270.78	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
24	8	463737cc-950b-4a41-8d73-a3daf931fee5	2890.73	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
25	9	6833f990-6a38-4f28-aa18-e31697fa7dc9	3357.86	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
26	9	6833f990-6a38-4f28-aa18-e31697fa7dc9	3014.16	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
27	9	6833f990-6a38-4f28-aa18-e31697fa7dc9	4829.87	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
28	10	b794e95a-97f4-4c05-aa2d-3c13c4155841	5573.82	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
29	10	b794e95a-97f4-4c05-aa2d-3c13c4155841	5833.32	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
30	10	b794e95a-97f4-4c05-aa2d-3c13c4155841	5356.31	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
31	11	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2651.81	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
32	11	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1465.20	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
33	11	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	4527.96	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
34	12	b794e95a-97f4-4c05-aa2d-3c13c4155841	2944.31	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
35	12	b794e95a-97f4-4c05-aa2d-3c13c4155841	3457.56	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
36	12	b794e95a-97f4-4c05-aa2d-3c13c4155841	1526.39	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
37	13	51072377-1472-46cb-b180-8542677f5eb2	5828.76	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
38	13	51072377-1472-46cb-b180-8542677f5eb2	4714.00	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
39	13	51072377-1472-46cb-b180-8542677f5eb2	1161.93	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
40	14	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2397.78	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
41	14	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5906.44	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
42	14	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2925.86	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
43	15	1934abf8-eca9-41d8-bc5f-9c649285b76b	3956.16	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
44	15	1934abf8-eca9-41d8-bc5f-9c649285b76b	1821.61	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
45	15	1934abf8-eca9-41d8-bc5f-9c649285b76b	5853.27	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
46	16	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5731.68	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
47	16	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5616.58	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
48	16	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3746.50	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
49	17	51072377-1472-46cb-b180-8542677f5eb2	2409.20	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
50	17	51072377-1472-46cb-b180-8542677f5eb2	4332.57	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
51	17	51072377-1472-46cb-b180-8542677f5eb2	4653.16	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
52	18	387d98f7-ccf9-4077-8f79-f0be51c40d05	4196.57	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
53	18	387d98f7-ccf9-4077-8f79-f0be51c40d05	2477.88	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
54	18	387d98f7-ccf9-4077-8f79-f0be51c40d05	2734.42	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
55	19	a83848ba-0779-4fac-98ee-f5f459b2742b	1971.81	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
56	19	a83848ba-0779-4fac-98ee-f5f459b2742b	1135.93	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
57	19	a83848ba-0779-4fac-98ee-f5f459b2742b	3788.49	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
58	20	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2260.15	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
59	20	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2664.50	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
60	20	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1527.12	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
61	21	77e168c1-05e0-4314-8a24-5e838350a3d8	4403.08	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
62	21	77e168c1-05e0-4314-8a24-5e838350a3d8	2305.33	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
63	21	77e168c1-05e0-4314-8a24-5e838350a3d8	1047.38	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
64	22	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1333.19	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
65	22	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2475.11	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
66	22	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2547.01	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
67	23	dbbbe49c-e100-4576-b406-320908c8873e	4560.68	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
68	23	dbbbe49c-e100-4576-b406-320908c8873e	3915.46	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
69	23	dbbbe49c-e100-4576-b406-320908c8873e	3451.48	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
70	24	ee522e07-1315-4463-8a9b-f890b601c047	5918.97	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
71	24	ee522e07-1315-4463-8a9b-f890b601c047	1293.59	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
72	24	ee522e07-1315-4463-8a9b-f890b601c047	5949.87	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
73	25	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2646.47	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
74	25	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5461.17	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
75	25	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4735.61	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
76	26	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1241.68	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
77	26	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1924.54	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
78	26	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5428.92	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
79	27	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1242.36	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
80	27	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1324.11	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
81	27	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4028.91	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
82	28	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4381.00	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
83	28	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	5692.30	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
84	28	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3677.49	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
85	29	fc7c7272-6d55-49a3-88d7-fc37133a103f	4722.42	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
86	29	fc7c7272-6d55-49a3-88d7-fc37133a103f	5529.95	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
87	29	fc7c7272-6d55-49a3-88d7-fc37133a103f	4193.56	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
88	30	bd38508e-8797-4220-ae2e-dd7883b41f17	3526.31	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
89	30	bd38508e-8797-4220-ae2e-dd7883b41f17	4305.45	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
90	30	bd38508e-8797-4220-ae2e-dd7883b41f17	1918.22	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
91	31	ee522e07-1315-4463-8a9b-f890b601c047	2197.05	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
92	31	ee522e07-1315-4463-8a9b-f890b601c047	2264.19	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
93	31	ee522e07-1315-4463-8a9b-f890b601c047	4904.59	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
94	32	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3765.12	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
95	32	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2949.25	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
96	32	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3112.56	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
97	33	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2553.59	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
98	33	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4195.09	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
99	33	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2816.57	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
100	34	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1249.16	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
101	34	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5377.90	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
102	34	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2240.03	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
103	35	b794e95a-97f4-4c05-aa2d-3c13c4155841	4185.86	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
104	35	b794e95a-97f4-4c05-aa2d-3c13c4155841	3818.78	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
105	35	b794e95a-97f4-4c05-aa2d-3c13c4155841	4981.75	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
106	36	ee522e07-1315-4463-8a9b-f890b601c047	3320.89	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
107	36	ee522e07-1315-4463-8a9b-f890b601c047	5988.04	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
108	36	ee522e07-1315-4463-8a9b-f890b601c047	3008.11	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
109	37	8088628d-f77a-430d-b228-cc3649b8a3e1	1062.91	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
110	37	8088628d-f77a-430d-b228-cc3649b8a3e1	4542.94	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
111	37	8088628d-f77a-430d-b228-cc3649b8a3e1	2453.10	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
112	38	463737cc-950b-4a41-8d73-a3daf931fee5	1632.26	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
113	38	463737cc-950b-4a41-8d73-a3daf931fee5	5264.66	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
114	38	463737cc-950b-4a41-8d73-a3daf931fee5	4839.83	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
115	39	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3979.17	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
116	39	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4589.62	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
117	39	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3377.08	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
118	40	cff64755-2065-4e58-866f-f092cbd9e73b	4372.70	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
119	40	cff64755-2065-4e58-866f-f092cbd9e73b	1235.11	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
120	40	cff64755-2065-4e58-866f-f092cbd9e73b	5722.05	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
121	41	dbbbe49c-e100-4576-b406-320908c8873e	5862.31	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
122	41	dbbbe49c-e100-4576-b406-320908c8873e	3715.41	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
123	41	dbbbe49c-e100-4576-b406-320908c8873e	2867.55	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
124	42	ee522e07-1315-4463-8a9b-f890b601c047	3230.31	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
125	42	ee522e07-1315-4463-8a9b-f890b601c047	3804.92	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
126	42	ee522e07-1315-4463-8a9b-f890b601c047	3584.23	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
127	43	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3042.87	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
128	43	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5595.28	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
129	43	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5161.63	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
130	44	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3406.62	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
131	44	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2813.21	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
132	44	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4181.33	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
133	45	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2575.51	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
134	45	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2922.81	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
135	45	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2353.51	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
136	46	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3661.49	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
137	46	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2387.02	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
138	46	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3165.24	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
139	47	cff64755-2065-4e58-866f-f092cbd9e73b	5809.21	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
140	47	cff64755-2065-4e58-866f-f092cbd9e73b	2305.55	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
141	47	cff64755-2065-4e58-866f-f092cbd9e73b	5483.76	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
142	48	dd35da46-4416-412a-8a22-f3f39491bb7b	5113.03	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
143	48	dd35da46-4416-412a-8a22-f3f39491bb7b	5995.51	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
144	48	dd35da46-4416-412a-8a22-f3f39491bb7b	5000.68	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
145	49	5432f125-2d5e-42ab-849a-29add2cf0a74	3578.93	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
146	49	5432f125-2d5e-42ab-849a-29add2cf0a74	1495.86	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
147	49	5432f125-2d5e-42ab-849a-29add2cf0a74	5275.19	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
148	50	9255fabc-799b-4cc7-8797-5f2470f6adf6	4216.51	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
149	50	9255fabc-799b-4cc7-8797-5f2470f6adf6	3699.28	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
150	50	9255fabc-799b-4cc7-8797-5f2470f6adf6	3280.41	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
151	51	584a1909-5797-4297-88d3-06bf5dc3922a	3952.75	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
152	51	584a1909-5797-4297-88d3-06bf5dc3922a	5360.33	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
153	51	584a1909-5797-4297-88d3-06bf5dc3922a	3597.23	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
154	52	584a1909-5797-4297-88d3-06bf5dc3922a	4609.56	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
155	52	584a1909-5797-4297-88d3-06bf5dc3922a	4009.61	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
156	52	584a1909-5797-4297-88d3-06bf5dc3922a	1450.95	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
157	53	a83848ba-0779-4fac-98ee-f5f459b2742b	2958.21	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
158	53	a83848ba-0779-4fac-98ee-f5f459b2742b	2561.80	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
159	53	a83848ba-0779-4fac-98ee-f5f459b2742b	1157.15	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
160	54	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3561.82	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
161	54	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2451.07	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
162	54	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	1739.18	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
163	55	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2240.40	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
164	55	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4672.24	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
165	55	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5655.04	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
166	56	da6ac18e-72e9-484a-ad75-d044260789cc	2204.60	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
167	56	da6ac18e-72e9-484a-ad75-d044260789cc	5005.40	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
168	56	da6ac18e-72e9-484a-ad75-d044260789cc	1282.20	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
169	57	387d98f7-ccf9-4077-8f79-f0be51c40d05	1540.31	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
170	57	387d98f7-ccf9-4077-8f79-f0be51c40d05	5234.32	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
171	57	387d98f7-ccf9-4077-8f79-f0be51c40d05	3491.07	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
172	58	51072377-1472-46cb-b180-8542677f5eb2	1962.64	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
173	58	51072377-1472-46cb-b180-8542677f5eb2	5810.91	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
174	58	51072377-1472-46cb-b180-8542677f5eb2	2910.72	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
175	59	dde964d6-6ffa-4b25-97b6-128969afe47c	2899.98	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
176	59	dde964d6-6ffa-4b25-97b6-128969afe47c	1138.08	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
177	59	dde964d6-6ffa-4b25-97b6-128969afe47c	1984.26	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
178	60	463737cc-950b-4a41-8d73-a3daf931fee5	4458.13	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
179	60	463737cc-950b-4a41-8d73-a3daf931fee5	4162.13	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
180	60	463737cc-950b-4a41-8d73-a3daf931fee5	5125.50	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
181	61	dde964d6-6ffa-4b25-97b6-128969afe47c	5199.53	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
182	61	dde964d6-6ffa-4b25-97b6-128969afe47c	4916.18	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
183	61	dde964d6-6ffa-4b25-97b6-128969afe47c	5318.23	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
184	62	1934abf8-eca9-41d8-bc5f-9c649285b76b	5496.89	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
185	62	1934abf8-eca9-41d8-bc5f-9c649285b76b	3100.58	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
186	62	1934abf8-eca9-41d8-bc5f-9c649285b76b	4156.54	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
187	63	bd38508e-8797-4220-ae2e-dd7883b41f17	1080.70	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
188	63	bd38508e-8797-4220-ae2e-dd7883b41f17	4900.02	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
189	63	bd38508e-8797-4220-ae2e-dd7883b41f17	3183.23	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
190	64	a602c1a3-89cf-44a4-b419-f6827ad3701b	3937.27	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
191	64	a602c1a3-89cf-44a4-b419-f6827ad3701b	5038.00	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
192	64	a602c1a3-89cf-44a4-b419-f6827ad3701b	1635.22	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
193	65	dbbbe49c-e100-4576-b406-320908c8873e	2005.07	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
194	65	dbbbe49c-e100-4576-b406-320908c8873e	3274.52	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
195	65	dbbbe49c-e100-4576-b406-320908c8873e	3023.27	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
196	66	dbbbe49c-e100-4576-b406-320908c8873e	2538.06	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
197	66	dbbbe49c-e100-4576-b406-320908c8873e	1725.79	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
198	66	dbbbe49c-e100-4576-b406-320908c8873e	3623.19	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
199	67	1934abf8-eca9-41d8-bc5f-9c649285b76b	5983.87	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
200	67	1934abf8-eca9-41d8-bc5f-9c649285b76b	2923.06	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
201	67	1934abf8-eca9-41d8-bc5f-9c649285b76b	1506.17	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
202	68	9255fabc-799b-4cc7-8797-5f2470f6adf6	4422.66	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
203	68	9255fabc-799b-4cc7-8797-5f2470f6adf6	2229.30	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
204	68	9255fabc-799b-4cc7-8797-5f2470f6adf6	1234.42	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
205	69	77e168c1-05e0-4314-8a24-5e838350a3d8	4452.89	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
206	69	77e168c1-05e0-4314-8a24-5e838350a3d8	4257.04	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
207	69	77e168c1-05e0-4314-8a24-5e838350a3d8	3154.28	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
208	70	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5450.88	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
209	70	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2036.66	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
210	70	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5308.15	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
211	71	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2815.02	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
212	71	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3780.57	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
213	71	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3803.50	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
214	72	fd99f59b-fcc6-42ef-a407-207f110f2d7b	1876.81	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
215	72	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4741.77	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
216	72	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4609.28	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
217	73	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3848.87	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
218	73	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3501.38	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
219	73	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3184.30	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
220	74	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5625.10	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
221	74	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5816.58	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
222	74	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	4716.41	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
223	75	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3586.27	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
224	75	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5104.71	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
225	75	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5140.82	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
226	76	dde964d6-6ffa-4b25-97b6-128969afe47c	2189.09	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
227	76	dde964d6-6ffa-4b25-97b6-128969afe47c	2188.64	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
228	76	dde964d6-6ffa-4b25-97b6-128969afe47c	3566.67	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
229	77	bd38508e-8797-4220-ae2e-dd7883b41f17	3457.01	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
230	77	bd38508e-8797-4220-ae2e-dd7883b41f17	5913.47	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
231	77	bd38508e-8797-4220-ae2e-dd7883b41f17	2659.23	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
232	78	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	5036.64	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
233	78	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2139.12	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
234	78	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3289.91	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
235	79	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1784.41	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
236	79	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1072.36	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
237	79	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2047.22	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
238	80	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4379.90	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
239	80	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2566.35	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
240	80	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1801.55	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
241	81	1934abf8-eca9-41d8-bc5f-9c649285b76b	4784.42	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
242	81	1934abf8-eca9-41d8-bc5f-9c649285b76b	3668.33	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
243	81	1934abf8-eca9-41d8-bc5f-9c649285b76b	2673.21	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
244	82	da6ac18e-72e9-484a-ad75-d044260789cc	2914.77	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
245	82	da6ac18e-72e9-484a-ad75-d044260789cc	4814.67	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
246	82	da6ac18e-72e9-484a-ad75-d044260789cc	1047.50	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
247	83	6833f990-6a38-4f28-aa18-e31697fa7dc9	5528.33	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
248	83	6833f990-6a38-4f28-aa18-e31697fa7dc9	4737.43	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
249	83	6833f990-6a38-4f28-aa18-e31697fa7dc9	4092.61	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
250	84	cff64755-2065-4e58-866f-f092cbd9e73b	2187.64	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
251	84	cff64755-2065-4e58-866f-f092cbd9e73b	5567.57	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
252	84	cff64755-2065-4e58-866f-f092cbd9e73b	2437.37	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
253	85	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4152.95	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
254	85	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3352.48	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
255	85	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3730.24	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
256	86	387d98f7-ccf9-4077-8f79-f0be51c40d05	2393.98	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
257	86	387d98f7-ccf9-4077-8f79-f0be51c40d05	5727.80	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
258	86	387d98f7-ccf9-4077-8f79-f0be51c40d05	5355.78	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
259	87	ee522e07-1315-4463-8a9b-f890b601c047	3093.55	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
260	87	ee522e07-1315-4463-8a9b-f890b601c047	1560.28	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
261	87	ee522e07-1315-4463-8a9b-f890b601c047	5589.44	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
262	88	dd35da46-4416-412a-8a22-f3f39491bb7b	5330.44	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
263	88	dd35da46-4416-412a-8a22-f3f39491bb7b	4447.81	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
264	88	dd35da46-4416-412a-8a22-f3f39491bb7b	1480.69	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
265	89	387d98f7-ccf9-4077-8f79-f0be51c40d05	1490.41	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
266	89	387d98f7-ccf9-4077-8f79-f0be51c40d05	3694.01	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
267	89	387d98f7-ccf9-4077-8f79-f0be51c40d05	4240.60	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
268	90	dbbbe49c-e100-4576-b406-320908c8873e	2598.04	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
269	90	dbbbe49c-e100-4576-b406-320908c8873e	4348.15	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
270	90	dbbbe49c-e100-4576-b406-320908c8873e	1200.73	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
271	91	dbbbe49c-e100-4576-b406-320908c8873e	2349.83	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
272	91	dbbbe49c-e100-4576-b406-320908c8873e	5076.81	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
273	91	dbbbe49c-e100-4576-b406-320908c8873e	4502.30	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
274	92	1934abf8-eca9-41d8-bc5f-9c649285b76b	4317.84	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
275	92	1934abf8-eca9-41d8-bc5f-9c649285b76b	3880.26	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
276	92	1934abf8-eca9-41d8-bc5f-9c649285b76b	3544.24	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
277	93	51072377-1472-46cb-b180-8542677f5eb2	2042.43	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
278	93	51072377-1472-46cb-b180-8542677f5eb2	3645.67	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
279	93	51072377-1472-46cb-b180-8542677f5eb2	5125.39	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
280	94	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3667.14	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
281	94	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3765.09	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
282	94	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1053.12	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
283	95	9255fabc-799b-4cc7-8797-5f2470f6adf6	4422.97	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
284	95	9255fabc-799b-4cc7-8797-5f2470f6adf6	2837.03	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
285	95	9255fabc-799b-4cc7-8797-5f2470f6adf6	4393.97	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
286	96	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1450.57	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
287	96	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1099.20	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
288	96	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4302.10	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
289	97	fc7c7272-6d55-49a3-88d7-fc37133a103f	2798.97	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
290	97	fc7c7272-6d55-49a3-88d7-fc37133a103f	3837.21	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
291	97	fc7c7272-6d55-49a3-88d7-fc37133a103f	5327.53	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
292	98	ee522e07-1315-4463-8a9b-f890b601c047	5122.90	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
293	98	ee522e07-1315-4463-8a9b-f890b601c047	2119.32	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
294	98	ee522e07-1315-4463-8a9b-f890b601c047	5176.56	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
295	99	fc7c7272-6d55-49a3-88d7-fc37133a103f	5991.69	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
296	99	fc7c7272-6d55-49a3-88d7-fc37133a103f	5229.56	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
297	99	fc7c7272-6d55-49a3-88d7-fc37133a103f	3017.66	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
298	100	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2969.27	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
299	100	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4819.70	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
300	100	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2838.66	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
301	101	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2602.12	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
302	101	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3334.93	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
303	101	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2687.34	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
304	102	a602c1a3-89cf-44a4-b419-f6827ad3701b	5997.61	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
305	102	a602c1a3-89cf-44a4-b419-f6827ad3701b	4395.15	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
306	102	a602c1a3-89cf-44a4-b419-f6827ad3701b	5333.96	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
307	103	6833f990-6a38-4f28-aa18-e31697fa7dc9	3428.70	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
308	103	6833f990-6a38-4f28-aa18-e31697fa7dc9	3563.75	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
309	103	6833f990-6a38-4f28-aa18-e31697fa7dc9	3625.89	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
310	104	463737cc-950b-4a41-8d73-a3daf931fee5	4189.82	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
311	104	463737cc-950b-4a41-8d73-a3daf931fee5	2751.41	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
312	104	463737cc-950b-4a41-8d73-a3daf931fee5	1803.43	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
313	105	cff64755-2065-4e58-866f-f092cbd9e73b	2198.63	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
314	105	cff64755-2065-4e58-866f-f092cbd9e73b	4750.64	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
315	105	cff64755-2065-4e58-866f-f092cbd9e73b	3099.80	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
316	106	a83848ba-0779-4fac-98ee-f5f459b2742b	4790.82	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
317	106	a83848ba-0779-4fac-98ee-f5f459b2742b	1934.85	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
318	106	a83848ba-0779-4fac-98ee-f5f459b2742b	1722.37	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
319	107	b794e95a-97f4-4c05-aa2d-3c13c4155841	3297.00	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
320	107	b794e95a-97f4-4c05-aa2d-3c13c4155841	3350.75	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
321	107	b794e95a-97f4-4c05-aa2d-3c13c4155841	2473.59	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
322	108	a83848ba-0779-4fac-98ee-f5f459b2742b	1184.99	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
323	108	a83848ba-0779-4fac-98ee-f5f459b2742b	5097.58	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
324	108	a83848ba-0779-4fac-98ee-f5f459b2742b	5612.98	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
325	109	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4263.23	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
326	109	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1923.05	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
327	109	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1789.27	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
328	110	463737cc-950b-4a41-8d73-a3daf931fee5	3153.65	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
329	110	463737cc-950b-4a41-8d73-a3daf931fee5	1646.81	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
330	110	463737cc-950b-4a41-8d73-a3daf931fee5	5250.38	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
331	111	463737cc-950b-4a41-8d73-a3daf931fee5	5157.04	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
332	111	463737cc-950b-4a41-8d73-a3daf931fee5	2140.17	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
333	111	463737cc-950b-4a41-8d73-a3daf931fee5	3007.43	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
334	112	77e168c1-05e0-4314-8a24-5e838350a3d8	4159.29	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
335	112	77e168c1-05e0-4314-8a24-5e838350a3d8	2498.62	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
336	112	77e168c1-05e0-4314-8a24-5e838350a3d8	4361.77	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
337	113	584a1909-5797-4297-88d3-06bf5dc3922a	1439.89	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
338	113	584a1909-5797-4297-88d3-06bf5dc3922a	1609.24	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
339	113	584a1909-5797-4297-88d3-06bf5dc3922a	3903.51	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
340	114	da6ac18e-72e9-484a-ad75-d044260789cc	4471.88	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
341	114	da6ac18e-72e9-484a-ad75-d044260789cc	3117.62	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
342	114	da6ac18e-72e9-484a-ad75-d044260789cc	1291.52	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
343	115	387d98f7-ccf9-4077-8f79-f0be51c40d05	3463.94	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
344	115	387d98f7-ccf9-4077-8f79-f0be51c40d05	2233.47	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
345	115	387d98f7-ccf9-4077-8f79-f0be51c40d05	3853.44	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
346	116	6ac1e176-e710-4b5e-9453-95765db20ba3	1657.67	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
347	116	6ac1e176-e710-4b5e-9453-95765db20ba3	2697.18	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
348	116	6ac1e176-e710-4b5e-9453-95765db20ba3	2432.08	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
349	117	5bf27593-0c3d-489f-bed4-c80dc2936fdf	3017.22	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
350	117	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1139.87	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
351	117	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2423.15	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
352	118	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	1883.29	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
353	118	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	5838.48	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
354	118	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	4378.91	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
355	119	6ac1e176-e710-4b5e-9453-95765db20ba3	3976.36	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
356	119	6ac1e176-e710-4b5e-9453-95765db20ba3	4658.14	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
357	119	6ac1e176-e710-4b5e-9453-95765db20ba3	3154.04	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
358	120	6833f990-6a38-4f28-aa18-e31697fa7dc9	4849.99	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
359	120	6833f990-6a38-4f28-aa18-e31697fa7dc9	5088.92	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
360	120	6833f990-6a38-4f28-aa18-e31697fa7dc9	1368.25	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
361	121	fc7c7272-6d55-49a3-88d7-fc37133a103f	2997.46	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
362	121	fc7c7272-6d55-49a3-88d7-fc37133a103f	4407.09	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
363	121	fc7c7272-6d55-49a3-88d7-fc37133a103f	4722.64	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
364	122	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2673.68	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
365	122	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4120.48	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
366	122	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1715.34	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
367	123	6833f990-6a38-4f28-aa18-e31697fa7dc9	5671.99	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
368	123	6833f990-6a38-4f28-aa18-e31697fa7dc9	5386.59	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
369	123	6833f990-6a38-4f28-aa18-e31697fa7dc9	1969.27	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
370	124	77e168c1-05e0-4314-8a24-5e838350a3d8	2692.87	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
371	124	77e168c1-05e0-4314-8a24-5e838350a3d8	4270.69	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
372	124	77e168c1-05e0-4314-8a24-5e838350a3d8	2890.65	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
373	125	a602c1a3-89cf-44a4-b419-f6827ad3701b	1616.00	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
374	125	a602c1a3-89cf-44a4-b419-f6827ad3701b	2044.05	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
375	125	a602c1a3-89cf-44a4-b419-f6827ad3701b	4848.99	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
376	126	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	1510.55	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
377	126	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4967.45	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
378	126	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2593.84	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
379	127	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3812.40	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
380	127	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2044.32	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
381	127	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4115.93	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
382	128	584a1909-5797-4297-88d3-06bf5dc3922a	3476.17	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
383	128	584a1909-5797-4297-88d3-06bf5dc3922a	1465.42	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
384	128	584a1909-5797-4297-88d3-06bf5dc3922a	4879.59	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
385	129	dde964d6-6ffa-4b25-97b6-128969afe47c	2153.44	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
386	129	dde964d6-6ffa-4b25-97b6-128969afe47c	1781.06	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
387	129	dde964d6-6ffa-4b25-97b6-128969afe47c	4172.44	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
388	130	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4699.98	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
389	130	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4271.42	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
390	130	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	5776.05	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
391	131	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1507.73	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
392	131	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1817.64	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
393	131	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1308.92	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
394	132	51072377-1472-46cb-b180-8542677f5eb2	4525.17	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
395	132	51072377-1472-46cb-b180-8542677f5eb2	1885.21	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
396	132	51072377-1472-46cb-b180-8542677f5eb2	3041.04	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
397	133	fc7c7272-6d55-49a3-88d7-fc37133a103f	3857.07	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
398	133	fc7c7272-6d55-49a3-88d7-fc37133a103f	3941.71	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
399	133	fc7c7272-6d55-49a3-88d7-fc37133a103f	4676.11	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
400	134	da6ac18e-72e9-484a-ad75-d044260789cc	5574.59	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
401	134	da6ac18e-72e9-484a-ad75-d044260789cc	1817.96	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
402	134	da6ac18e-72e9-484a-ad75-d044260789cc	2939.74	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
403	135	77e168c1-05e0-4314-8a24-5e838350a3d8	1849.30	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
404	135	77e168c1-05e0-4314-8a24-5e838350a3d8	4678.64	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
405	135	77e168c1-05e0-4314-8a24-5e838350a3d8	4617.64	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
406	136	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2933.03	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
407	136	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5148.85	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
408	136	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4835.25	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
409	137	a83848ba-0779-4fac-98ee-f5f459b2742b	4942.69	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
410	137	a83848ba-0779-4fac-98ee-f5f459b2742b	3495.40	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
411	137	a83848ba-0779-4fac-98ee-f5f459b2742b	1106.96	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
412	138	5bf27593-0c3d-489f-bed4-c80dc2936fdf	3917.03	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
413	138	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1229.73	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
414	138	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1764.70	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
415	139	b794e95a-97f4-4c05-aa2d-3c13c4155841	1644.46	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
416	139	b794e95a-97f4-4c05-aa2d-3c13c4155841	5995.00	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
417	139	b794e95a-97f4-4c05-aa2d-3c13c4155841	5529.00	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
418	140	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5102.87	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
419	140	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2959.17	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
420	140	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5729.36	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
421	141	cff64755-2065-4e58-866f-f092cbd9e73b	5311.78	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
422	141	cff64755-2065-4e58-866f-f092cbd9e73b	3428.52	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
423	141	cff64755-2065-4e58-866f-f092cbd9e73b	5054.85	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
424	142	cff64755-2065-4e58-866f-f092cbd9e73b	5439.42	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
425	142	cff64755-2065-4e58-866f-f092cbd9e73b	3423.85	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
426	142	cff64755-2065-4e58-866f-f092cbd9e73b	1016.65	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
427	143	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	1173.11	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
428	143	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4250.30	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
429	143	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3275.25	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
430	144	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	5488.05	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
431	144	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2406.28	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
432	144	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	1030.97	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
433	145	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1328.94	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
434	145	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4498.87	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
435	145	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4075.51	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
436	146	bd38508e-8797-4220-ae2e-dd7883b41f17	1749.48	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
437	146	bd38508e-8797-4220-ae2e-dd7883b41f17	5545.52	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
438	146	bd38508e-8797-4220-ae2e-dd7883b41f17	3008.70	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
439	147	584a1909-5797-4297-88d3-06bf5dc3922a	4110.57	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
440	147	584a1909-5797-4297-88d3-06bf5dc3922a	4342.05	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
441	147	584a1909-5797-4297-88d3-06bf5dc3922a	5695.02	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
442	148	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1123.69	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
443	148	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3911.00	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
444	148	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5328.77	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
445	149	1934abf8-eca9-41d8-bc5f-9c649285b76b	4812.10	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
446	149	1934abf8-eca9-41d8-bc5f-9c649285b76b	1094.52	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
447	149	1934abf8-eca9-41d8-bc5f-9c649285b76b	3293.90	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
448	150	da6ac18e-72e9-484a-ad75-d044260789cc	3943.47	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
449	150	da6ac18e-72e9-484a-ad75-d044260789cc	4872.00	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
450	150	da6ac18e-72e9-484a-ad75-d044260789cc	5205.25	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
451	151	dde964d6-6ffa-4b25-97b6-128969afe47c	4428.66	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
452	151	dde964d6-6ffa-4b25-97b6-128969afe47c	5133.32	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
453	151	dde964d6-6ffa-4b25-97b6-128969afe47c	5745.66	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
454	152	bd38508e-8797-4220-ae2e-dd7883b41f17	2760.91	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
455	152	bd38508e-8797-4220-ae2e-dd7883b41f17	3300.73	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
456	152	bd38508e-8797-4220-ae2e-dd7883b41f17	1667.13	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
457	153	cff64755-2065-4e58-866f-f092cbd9e73b	1677.51	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
458	153	cff64755-2065-4e58-866f-f092cbd9e73b	3372.37	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
459	153	cff64755-2065-4e58-866f-f092cbd9e73b	5818.36	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
460	154	bd38508e-8797-4220-ae2e-dd7883b41f17	4291.07	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
461	154	bd38508e-8797-4220-ae2e-dd7883b41f17	3792.86	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
462	154	bd38508e-8797-4220-ae2e-dd7883b41f17	5293.48	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
463	155	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5223.77	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
464	155	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1268.26	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
465	155	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5249.06	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
466	156	584a1909-5797-4297-88d3-06bf5dc3922a	5289.44	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
467	156	584a1909-5797-4297-88d3-06bf5dc3922a	4427.88	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
468	156	584a1909-5797-4297-88d3-06bf5dc3922a	1082.38	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
469	157	6ac1e176-e710-4b5e-9453-95765db20ba3	3050.85	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
470	157	6ac1e176-e710-4b5e-9453-95765db20ba3	3746.02	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
471	157	6ac1e176-e710-4b5e-9453-95765db20ba3	4604.44	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
472	158	9255fabc-799b-4cc7-8797-5f2470f6adf6	3287.39	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
473	158	9255fabc-799b-4cc7-8797-5f2470f6adf6	4850.95	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
474	158	9255fabc-799b-4cc7-8797-5f2470f6adf6	1106.59	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
475	159	a602c1a3-89cf-44a4-b419-f6827ad3701b	3151.99	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
476	159	a602c1a3-89cf-44a4-b419-f6827ad3701b	2672.77	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
477	159	a602c1a3-89cf-44a4-b419-f6827ad3701b	3358.41	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
478	160	a83848ba-0779-4fac-98ee-f5f459b2742b	1309.83	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
479	160	a83848ba-0779-4fac-98ee-f5f459b2742b	4585.42	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
480	160	a83848ba-0779-4fac-98ee-f5f459b2742b	4486.42	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
481	161	8088628d-f77a-430d-b228-cc3649b8a3e1	3201.91	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
482	161	8088628d-f77a-430d-b228-cc3649b8a3e1	3246.32	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
483	161	8088628d-f77a-430d-b228-cc3649b8a3e1	3252.54	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
484	162	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1007.58	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
485	162	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3334.71	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
486	162	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3611.02	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
487	163	1934abf8-eca9-41d8-bc5f-9c649285b76b	5812.19	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
488	163	1934abf8-eca9-41d8-bc5f-9c649285b76b	3600.74	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
489	163	1934abf8-eca9-41d8-bc5f-9c649285b76b	5261.48	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
490	164	fd99f59b-fcc6-42ef-a407-207f110f2d7b	1728.62	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
491	164	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2320.88	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
492	164	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2102.81	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
493	165	dde964d6-6ffa-4b25-97b6-128969afe47c	1507.48	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
494	165	dde964d6-6ffa-4b25-97b6-128969afe47c	1596.68	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
495	165	dde964d6-6ffa-4b25-97b6-128969afe47c	3945.02	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
496	166	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4510.91	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
497	166	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3764.52	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
498	166	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3693.43	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
499	167	51072377-1472-46cb-b180-8542677f5eb2	1801.38	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
500	167	51072377-1472-46cb-b180-8542677f5eb2	2403.21	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
501	167	51072377-1472-46cb-b180-8542677f5eb2	3749.12	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
502	168	cff64755-2065-4e58-866f-f092cbd9e73b	3203.76	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
503	168	cff64755-2065-4e58-866f-f092cbd9e73b	4895.90	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
504	168	cff64755-2065-4e58-866f-f092cbd9e73b	3884.78	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
505	169	cff64755-2065-4e58-866f-f092cbd9e73b	1527.78	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
506	169	cff64755-2065-4e58-866f-f092cbd9e73b	3361.05	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
507	169	cff64755-2065-4e58-866f-f092cbd9e73b	4607.42	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
508	170	5432f125-2d5e-42ab-849a-29add2cf0a74	1533.14	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
509	170	5432f125-2d5e-42ab-849a-29add2cf0a74	5593.58	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
510	170	5432f125-2d5e-42ab-849a-29add2cf0a74	2631.83	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
511	171	b794e95a-97f4-4c05-aa2d-3c13c4155841	2823.98	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
512	171	b794e95a-97f4-4c05-aa2d-3c13c4155841	4748.55	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
513	171	b794e95a-97f4-4c05-aa2d-3c13c4155841	5857.42	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
514	172	77e168c1-05e0-4314-8a24-5e838350a3d8	2273.89	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
515	172	77e168c1-05e0-4314-8a24-5e838350a3d8	2054.39	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
516	172	77e168c1-05e0-4314-8a24-5e838350a3d8	4722.70	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
517	173	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1014.29	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
518	173	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2742.79	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
519	173	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3245.06	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
520	174	77e168c1-05e0-4314-8a24-5e838350a3d8	3207.63	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
521	174	77e168c1-05e0-4314-8a24-5e838350a3d8	3315.04	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
522	174	77e168c1-05e0-4314-8a24-5e838350a3d8	5982.71	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
523	175	6833f990-6a38-4f28-aa18-e31697fa7dc9	3966.24	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
524	175	6833f990-6a38-4f28-aa18-e31697fa7dc9	3313.77	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
525	175	6833f990-6a38-4f28-aa18-e31697fa7dc9	1636.78	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
526	176	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	4437.24	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
527	176	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5060.52	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
528	176	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3737.36	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
529	177	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5213.93	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
530	177	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2111.83	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
531	177	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3223.69	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
532	178	cff64755-2065-4e58-866f-f092cbd9e73b	1101.40	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
533	178	cff64755-2065-4e58-866f-f092cbd9e73b	3718.82	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
534	178	cff64755-2065-4e58-866f-f092cbd9e73b	5668.57	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
535	179	5432f125-2d5e-42ab-849a-29add2cf0a74	5320.18	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
536	179	5432f125-2d5e-42ab-849a-29add2cf0a74	5096.80	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
537	179	5432f125-2d5e-42ab-849a-29add2cf0a74	2145.52	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
538	180	584a1909-5797-4297-88d3-06bf5dc3922a	3736.26	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
539	180	584a1909-5797-4297-88d3-06bf5dc3922a	3283.30	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
540	180	584a1909-5797-4297-88d3-06bf5dc3922a	5335.26	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
541	181	77e168c1-05e0-4314-8a24-5e838350a3d8	1196.06	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
542	181	77e168c1-05e0-4314-8a24-5e838350a3d8	4750.12	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
543	181	77e168c1-05e0-4314-8a24-5e838350a3d8	1550.84	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
544	182	cff64755-2065-4e58-866f-f092cbd9e73b	3486.56	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
545	182	cff64755-2065-4e58-866f-f092cbd9e73b	3852.06	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
546	182	cff64755-2065-4e58-866f-f092cbd9e73b	3491.72	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
547	183	dde964d6-6ffa-4b25-97b6-128969afe47c	2307.98	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
548	183	dde964d6-6ffa-4b25-97b6-128969afe47c	2286.11	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
549	183	dde964d6-6ffa-4b25-97b6-128969afe47c	2361.18	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
550	184	a83848ba-0779-4fac-98ee-f5f459b2742b	4337.33	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
551	184	a83848ba-0779-4fac-98ee-f5f459b2742b	1945.47	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
552	184	a83848ba-0779-4fac-98ee-f5f459b2742b	1053.03	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
553	185	dd35da46-4416-412a-8a22-f3f39491bb7b	1657.65	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
554	185	dd35da46-4416-412a-8a22-f3f39491bb7b	4128.61	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
555	185	dd35da46-4416-412a-8a22-f3f39491bb7b	1057.74	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
556	186	584a1909-5797-4297-88d3-06bf5dc3922a	5655.17	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
557	186	584a1909-5797-4297-88d3-06bf5dc3922a	2454.70	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
558	186	584a1909-5797-4297-88d3-06bf5dc3922a	5240.92	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
559	187	da6ac18e-72e9-484a-ad75-d044260789cc	1780.33	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
560	187	da6ac18e-72e9-484a-ad75-d044260789cc	5906.12	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
561	187	da6ac18e-72e9-484a-ad75-d044260789cc	5364.43	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
562	188	9255fabc-799b-4cc7-8797-5f2470f6adf6	4806.41	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
563	188	9255fabc-799b-4cc7-8797-5f2470f6adf6	1729.79	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
564	188	9255fabc-799b-4cc7-8797-5f2470f6adf6	3781.30	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
565	189	a602c1a3-89cf-44a4-b419-f6827ad3701b	1199.11	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
566	189	a602c1a3-89cf-44a4-b419-f6827ad3701b	3434.76	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
567	189	a602c1a3-89cf-44a4-b419-f6827ad3701b	5538.80	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
568	190	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4101.48	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
569	190	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4515.32	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
570	190	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4736.08	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
571	191	8088628d-f77a-430d-b228-cc3649b8a3e1	1087.02	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
572	191	8088628d-f77a-430d-b228-cc3649b8a3e1	3806.15	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
573	191	8088628d-f77a-430d-b228-cc3649b8a3e1	2253.90	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
574	192	387d98f7-ccf9-4077-8f79-f0be51c40d05	3475.83	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
575	192	387d98f7-ccf9-4077-8f79-f0be51c40d05	3951.71	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
576	192	387d98f7-ccf9-4077-8f79-f0be51c40d05	4670.14	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
577	193	77e168c1-05e0-4314-8a24-5e838350a3d8	1573.34	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
578	193	77e168c1-05e0-4314-8a24-5e838350a3d8	1319.23	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
579	193	77e168c1-05e0-4314-8a24-5e838350a3d8	3769.65	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
580	194	cff64755-2065-4e58-866f-f092cbd9e73b	2473.34	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
581	194	cff64755-2065-4e58-866f-f092cbd9e73b	2660.56	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
582	194	cff64755-2065-4e58-866f-f092cbd9e73b	5821.60	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
583	195	9255fabc-799b-4cc7-8797-5f2470f6adf6	5183.36	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
584	195	9255fabc-799b-4cc7-8797-5f2470f6adf6	1865.40	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
585	195	9255fabc-799b-4cc7-8797-5f2470f6adf6	2971.30	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
586	196	ee522e07-1315-4463-8a9b-f890b601c047	5967.88	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
587	196	ee522e07-1315-4463-8a9b-f890b601c047	3394.28	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
588	196	ee522e07-1315-4463-8a9b-f890b601c047	2076.90	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
589	197	6ac1e176-e710-4b5e-9453-95765db20ba3	4467.89	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
590	197	6ac1e176-e710-4b5e-9453-95765db20ba3	1474.05	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
591	197	6ac1e176-e710-4b5e-9453-95765db20ba3	4496.45	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
592	198	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2559.70	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
593	198	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3222.72	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
594	198	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1440.55	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
595	199	463737cc-950b-4a41-8d73-a3daf931fee5	3260.03	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
596	199	463737cc-950b-4a41-8d73-a3daf931fee5	5947.36	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
597	199	463737cc-950b-4a41-8d73-a3daf931fee5	3086.59	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
598	200	dbbbe49c-e100-4576-b406-320908c8873e	2987.73	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
599	200	dbbbe49c-e100-4576-b406-320908c8873e	4508.11	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
600	200	dbbbe49c-e100-4576-b406-320908c8873e	3052.06	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
601	201	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4309.77	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
602	201	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2491.58	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
603	201	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4047.99	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
604	202	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	4012.01	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
605	202	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2692.12	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
606	202	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1807.48	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
607	203	6833f990-6a38-4f28-aa18-e31697fa7dc9	3379.28	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
608	203	6833f990-6a38-4f28-aa18-e31697fa7dc9	3263.38	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
609	203	6833f990-6a38-4f28-aa18-e31697fa7dc9	1579.74	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
610	204	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2164.19	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
611	204	5bf27593-0c3d-489f-bed4-c80dc2936fdf	3184.45	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
612	204	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2916.08	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
613	205	5432f125-2d5e-42ab-849a-29add2cf0a74	5587.03	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
614	205	5432f125-2d5e-42ab-849a-29add2cf0a74	1431.86	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
615	205	5432f125-2d5e-42ab-849a-29add2cf0a74	1626.39	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
616	206	6ac1e176-e710-4b5e-9453-95765db20ba3	2468.94	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
617	206	6ac1e176-e710-4b5e-9453-95765db20ba3	2302.82	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
618	206	6ac1e176-e710-4b5e-9453-95765db20ba3	3092.90	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
619	207	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2484.99	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
620	207	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2463.15	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
621	207	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1168.02	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
622	208	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1095.63	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
623	208	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2741.98	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
624	208	b1f5db31-bfc8-409c-8925-0d21f1c780e6	4424.71	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
625	209	9255fabc-799b-4cc7-8797-5f2470f6adf6	5517.16	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
626	209	9255fabc-799b-4cc7-8797-5f2470f6adf6	2642.92	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
627	209	9255fabc-799b-4cc7-8797-5f2470f6adf6	3867.02	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
628	210	463737cc-950b-4a41-8d73-a3daf931fee5	2546.24	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
629	210	463737cc-950b-4a41-8d73-a3daf931fee5	5526.48	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
630	210	463737cc-950b-4a41-8d73-a3daf931fee5	1331.63	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
631	211	dbbbe49c-e100-4576-b406-320908c8873e	1936.72	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
632	211	dbbbe49c-e100-4576-b406-320908c8873e	4829.15	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
633	211	dbbbe49c-e100-4576-b406-320908c8873e	1435.12	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
634	212	6833f990-6a38-4f28-aa18-e31697fa7dc9	2374.66	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
635	212	6833f990-6a38-4f28-aa18-e31697fa7dc9	4203.80	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
636	212	6833f990-6a38-4f28-aa18-e31697fa7dc9	5648.02	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
637	213	fc7c7272-6d55-49a3-88d7-fc37133a103f	2900.50	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
638	213	fc7c7272-6d55-49a3-88d7-fc37133a103f	5912.82	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
639	213	fc7c7272-6d55-49a3-88d7-fc37133a103f	3642.85	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
640	214	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4347.52	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
641	214	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	5824.89	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
642	214	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3983.79	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
643	215	77e168c1-05e0-4314-8a24-5e838350a3d8	2853.58	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
644	215	77e168c1-05e0-4314-8a24-5e838350a3d8	3588.15	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
645	215	77e168c1-05e0-4314-8a24-5e838350a3d8	1074.82	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
646	216	463737cc-950b-4a41-8d73-a3daf931fee5	1106.15	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
647	216	463737cc-950b-4a41-8d73-a3daf931fee5	1656.67	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
648	216	463737cc-950b-4a41-8d73-a3daf931fee5	4308.42	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
649	217	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5100.27	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
650	217	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5622.60	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
651	217	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5577.41	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
652	218	fc7c7272-6d55-49a3-88d7-fc37133a103f	1308.54	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
653	218	fc7c7272-6d55-49a3-88d7-fc37133a103f	1435.76	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
654	218	fc7c7272-6d55-49a3-88d7-fc37133a103f	5250.34	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
655	219	da6ac18e-72e9-484a-ad75-d044260789cc	1566.90	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
656	219	da6ac18e-72e9-484a-ad75-d044260789cc	1296.43	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
657	219	da6ac18e-72e9-484a-ad75-d044260789cc	2858.15	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
658	220	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2065.73	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
659	220	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4048.80	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
660	220	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1918.63	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
661	221	a602c1a3-89cf-44a4-b419-f6827ad3701b	3165.77	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
662	221	a602c1a3-89cf-44a4-b419-f6827ad3701b	1450.67	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
663	221	a602c1a3-89cf-44a4-b419-f6827ad3701b	3711.59	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
664	222	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	4115.03	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
665	222	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1852.11	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
666	222	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2926.51	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
667	223	da6ac18e-72e9-484a-ad75-d044260789cc	5407.67	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
668	223	da6ac18e-72e9-484a-ad75-d044260789cc	2894.29	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
669	223	da6ac18e-72e9-484a-ad75-d044260789cc	3729.36	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
670	224	bd38508e-8797-4220-ae2e-dd7883b41f17	4713.04	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
671	224	bd38508e-8797-4220-ae2e-dd7883b41f17	4833.77	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
672	224	bd38508e-8797-4220-ae2e-dd7883b41f17	4344.29	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
673	225	a602c1a3-89cf-44a4-b419-f6827ad3701b	2794.31	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
674	225	a602c1a3-89cf-44a4-b419-f6827ad3701b	5426.01	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
675	225	a602c1a3-89cf-44a4-b419-f6827ad3701b	2199.17	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
676	226	da6ac18e-72e9-484a-ad75-d044260789cc	5267.90	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
677	226	da6ac18e-72e9-484a-ad75-d044260789cc	2141.06	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
678	226	da6ac18e-72e9-484a-ad75-d044260789cc	3967.59	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
679	227	51072377-1472-46cb-b180-8542677f5eb2	3103.20	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
680	227	51072377-1472-46cb-b180-8542677f5eb2	3175.07	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
681	227	51072377-1472-46cb-b180-8542677f5eb2	2288.00	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
682	228	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2735.22	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
683	228	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3890.33	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
684	228	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2713.13	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
685	229	584a1909-5797-4297-88d3-06bf5dc3922a	3514.56	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
686	229	584a1909-5797-4297-88d3-06bf5dc3922a	5462.32	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
687	229	584a1909-5797-4297-88d3-06bf5dc3922a	1885.54	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
688	230	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2428.41	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
689	230	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1535.56	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
690	230	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5325.67	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
691	231	463737cc-950b-4a41-8d73-a3daf931fee5	3503.71	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
692	231	463737cc-950b-4a41-8d73-a3daf931fee5	3172.04	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
693	231	463737cc-950b-4a41-8d73-a3daf931fee5	5657.63	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
694	232	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3621.83	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
695	232	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5326.62	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
696	232	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2562.89	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
697	233	1934abf8-eca9-41d8-bc5f-9c649285b76b	3800.92	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
698	233	1934abf8-eca9-41d8-bc5f-9c649285b76b	2510.66	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
699	233	1934abf8-eca9-41d8-bc5f-9c649285b76b	1917.93	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
700	234	51072377-1472-46cb-b180-8542677f5eb2	3749.56	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
701	234	51072377-1472-46cb-b180-8542677f5eb2	5199.20	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
702	234	51072377-1472-46cb-b180-8542677f5eb2	2766.33	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
703	235	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2150.70	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
704	235	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1706.21	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
705	235	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1347.98	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
706	236	dde964d6-6ffa-4b25-97b6-128969afe47c	2900.05	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
707	236	dde964d6-6ffa-4b25-97b6-128969afe47c	5394.82	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
708	236	dde964d6-6ffa-4b25-97b6-128969afe47c	2486.66	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
709	237	5432f125-2d5e-42ab-849a-29add2cf0a74	3861.21	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
710	237	5432f125-2d5e-42ab-849a-29add2cf0a74	1053.82	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
711	237	5432f125-2d5e-42ab-849a-29add2cf0a74	3702.88	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
712	238	5432f125-2d5e-42ab-849a-29add2cf0a74	3672.97	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
713	238	5432f125-2d5e-42ab-849a-29add2cf0a74	1868.81	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
714	238	5432f125-2d5e-42ab-849a-29add2cf0a74	5830.64	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
715	239	a602c1a3-89cf-44a4-b419-f6827ad3701b	4219.47	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
716	239	a602c1a3-89cf-44a4-b419-f6827ad3701b	2803.90	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
717	239	a602c1a3-89cf-44a4-b419-f6827ad3701b	5543.26	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
718	240	ee522e07-1315-4463-8a9b-f890b601c047	3485.43	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
719	240	ee522e07-1315-4463-8a9b-f890b601c047	2474.12	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
720	240	ee522e07-1315-4463-8a9b-f890b601c047	3925.55	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
721	241	1934abf8-eca9-41d8-bc5f-9c649285b76b	4925.47	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
722	241	1934abf8-eca9-41d8-bc5f-9c649285b76b	1100.80	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
723	241	1934abf8-eca9-41d8-bc5f-9c649285b76b	3923.26	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
724	242	6ac1e176-e710-4b5e-9453-95765db20ba3	4029.72	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
725	242	6ac1e176-e710-4b5e-9453-95765db20ba3	1474.30	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
726	242	6ac1e176-e710-4b5e-9453-95765db20ba3	1900.58	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
727	243	51072377-1472-46cb-b180-8542677f5eb2	1728.31	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
728	243	51072377-1472-46cb-b180-8542677f5eb2	2216.35	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
729	243	51072377-1472-46cb-b180-8542677f5eb2	2713.20	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
730	244	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2576.56	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
731	244	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1900.10	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
732	244	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1926.82	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
733	245	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4574.04	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
734	245	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1848.76	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
735	245	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2205.40	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
736	246	6ac1e176-e710-4b5e-9453-95765db20ba3	1314.56	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
737	246	6ac1e176-e710-4b5e-9453-95765db20ba3	2226.56	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
738	246	6ac1e176-e710-4b5e-9453-95765db20ba3	5510.83	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
739	247	bd38508e-8797-4220-ae2e-dd7883b41f17	1672.16	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
740	247	bd38508e-8797-4220-ae2e-dd7883b41f17	2227.16	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
741	247	bd38508e-8797-4220-ae2e-dd7883b41f17	1900.12	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
742	248	77e168c1-05e0-4314-8a24-5e838350a3d8	1537.28	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
743	248	77e168c1-05e0-4314-8a24-5e838350a3d8	2087.43	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
744	248	77e168c1-05e0-4314-8a24-5e838350a3d8	4226.11	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
745	249	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2835.56	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
746	249	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3845.25	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
747	249	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2880.87	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
748	250	51072377-1472-46cb-b180-8542677f5eb2	5917.24	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
749	250	51072377-1472-46cb-b180-8542677f5eb2	4208.54	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
750	250	51072377-1472-46cb-b180-8542677f5eb2	4815.48	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
751	251	77e168c1-05e0-4314-8a24-5e838350a3d8	1883.76	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
752	251	77e168c1-05e0-4314-8a24-5e838350a3d8	3347.16	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
753	251	77e168c1-05e0-4314-8a24-5e838350a3d8	3349.61	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
754	252	1934abf8-eca9-41d8-bc5f-9c649285b76b	5935.35	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
755	252	1934abf8-eca9-41d8-bc5f-9c649285b76b	5864.59	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
756	252	1934abf8-eca9-41d8-bc5f-9c649285b76b	2945.70	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
757	253	8088628d-f77a-430d-b228-cc3649b8a3e1	5596.91	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
758	253	8088628d-f77a-430d-b228-cc3649b8a3e1	2991.64	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
759	253	8088628d-f77a-430d-b228-cc3649b8a3e1	2462.84	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
760	254	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3400.23	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
761	254	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4380.02	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
762	254	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2997.22	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
763	255	dd35da46-4416-412a-8a22-f3f39491bb7b	4677.65	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
764	255	dd35da46-4416-412a-8a22-f3f39491bb7b	5906.59	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
765	255	dd35da46-4416-412a-8a22-f3f39491bb7b	1955.88	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
766	256	cff64755-2065-4e58-866f-f092cbd9e73b	4555.35	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
767	256	cff64755-2065-4e58-866f-f092cbd9e73b	4605.41	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
768	256	cff64755-2065-4e58-866f-f092cbd9e73b	3076.85	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
769	257	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3875.88	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
770	257	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1338.69	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
771	257	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1516.07	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
772	258	8088628d-f77a-430d-b228-cc3649b8a3e1	5452.98	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
773	258	8088628d-f77a-430d-b228-cc3649b8a3e1	3276.23	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
774	258	8088628d-f77a-430d-b228-cc3649b8a3e1	2621.38	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
775	259	51072377-1472-46cb-b180-8542677f5eb2	3060.55	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
776	259	51072377-1472-46cb-b180-8542677f5eb2	5926.01	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
777	259	51072377-1472-46cb-b180-8542677f5eb2	3019.28	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
778	260	77e168c1-05e0-4314-8a24-5e838350a3d8	4608.34	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
779	260	77e168c1-05e0-4314-8a24-5e838350a3d8	1718.91	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
780	260	77e168c1-05e0-4314-8a24-5e838350a3d8	5693.65	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
781	261	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2376.80	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
782	261	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4374.15	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
783	261	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1129.09	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
784	262	5432f125-2d5e-42ab-849a-29add2cf0a74	3898.66	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
785	262	5432f125-2d5e-42ab-849a-29add2cf0a74	3006.34	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
786	262	5432f125-2d5e-42ab-849a-29add2cf0a74	1040.47	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
787	263	ee522e07-1315-4463-8a9b-f890b601c047	4915.79	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
788	263	ee522e07-1315-4463-8a9b-f890b601c047	4127.40	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
789	263	ee522e07-1315-4463-8a9b-f890b601c047	2064.05	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
790	264	b794e95a-97f4-4c05-aa2d-3c13c4155841	5797.23	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
791	264	b794e95a-97f4-4c05-aa2d-3c13c4155841	5936.49	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
792	264	b794e95a-97f4-4c05-aa2d-3c13c4155841	1600.08	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
793	265	584a1909-5797-4297-88d3-06bf5dc3922a	4288.03	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
794	265	584a1909-5797-4297-88d3-06bf5dc3922a	4531.48	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
795	265	584a1909-5797-4297-88d3-06bf5dc3922a	4192.27	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
796	266	5432f125-2d5e-42ab-849a-29add2cf0a74	2681.58	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
797	266	5432f125-2d5e-42ab-849a-29add2cf0a74	3334.62	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
798	266	5432f125-2d5e-42ab-849a-29add2cf0a74	3688.01	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
799	267	ee522e07-1315-4463-8a9b-f890b601c047	2352.04	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
800	267	ee522e07-1315-4463-8a9b-f890b601c047	2547.61	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
801	267	ee522e07-1315-4463-8a9b-f890b601c047	1286.51	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
802	268	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3067.44	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
803	268	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	1034.69	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
804	268	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3261.89	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
805	269	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4479.36	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
806	269	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3890.76	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
807	269	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4784.04	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
808	270	77e168c1-05e0-4314-8a24-5e838350a3d8	2651.55	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
809	270	77e168c1-05e0-4314-8a24-5e838350a3d8	1606.84	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
810	270	77e168c1-05e0-4314-8a24-5e838350a3d8	1624.83	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
811	271	dde964d6-6ffa-4b25-97b6-128969afe47c	4693.86	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
812	271	dde964d6-6ffa-4b25-97b6-128969afe47c	4992.46	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
813	271	dde964d6-6ffa-4b25-97b6-128969afe47c	5080.45	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
814	272	5432f125-2d5e-42ab-849a-29add2cf0a74	2191.77	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
815	272	5432f125-2d5e-42ab-849a-29add2cf0a74	2411.03	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
816	272	5432f125-2d5e-42ab-849a-29add2cf0a74	2870.03	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
817	273	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5463.37	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
818	273	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4143.92	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
819	273	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4844.72	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
820	274	463737cc-950b-4a41-8d73-a3daf931fee5	4002.04	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
821	274	463737cc-950b-4a41-8d73-a3daf931fee5	1073.30	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
822	274	463737cc-950b-4a41-8d73-a3daf931fee5	3146.54	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
823	275	463737cc-950b-4a41-8d73-a3daf931fee5	5452.98	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
824	275	463737cc-950b-4a41-8d73-a3daf931fee5	3285.27	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
825	275	463737cc-950b-4a41-8d73-a3daf931fee5	1330.22	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
826	276	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4394.05	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
827	276	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3210.83	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
828	276	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4295.86	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
829	277	5432f125-2d5e-42ab-849a-29add2cf0a74	3444.63	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
830	277	5432f125-2d5e-42ab-849a-29add2cf0a74	5140.15	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
831	277	5432f125-2d5e-42ab-849a-29add2cf0a74	3615.49	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
832	278	9255fabc-799b-4cc7-8797-5f2470f6adf6	1441.08	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
833	278	9255fabc-799b-4cc7-8797-5f2470f6adf6	5445.44	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
834	278	9255fabc-799b-4cc7-8797-5f2470f6adf6	1702.59	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
835	279	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4454.23	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
836	279	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2276.53	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
837	279	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4567.70	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
838	280	da6ac18e-72e9-484a-ad75-d044260789cc	4709.72	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
839	280	da6ac18e-72e9-484a-ad75-d044260789cc	5319.80	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
840	280	da6ac18e-72e9-484a-ad75-d044260789cc	5962.09	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
841	281	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5045.28	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
842	281	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5350.95	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
843	281	5bf27593-0c3d-489f-bed4-c80dc2936fdf	3057.08	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
844	282	a602c1a3-89cf-44a4-b419-f6827ad3701b	4497.58	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
845	282	a602c1a3-89cf-44a4-b419-f6827ad3701b	1519.91	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
846	282	a602c1a3-89cf-44a4-b419-f6827ad3701b	4938.46	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
847	283	ee522e07-1315-4463-8a9b-f890b601c047	5921.58	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
848	283	ee522e07-1315-4463-8a9b-f890b601c047	2432.82	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
849	283	ee522e07-1315-4463-8a9b-f890b601c047	3022.49	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
850	284	dbbbe49c-e100-4576-b406-320908c8873e	3430.00	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
851	284	dbbbe49c-e100-4576-b406-320908c8873e	1112.38	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
852	284	dbbbe49c-e100-4576-b406-320908c8873e	3701.09	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
853	285	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3595.01	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
854	285	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	5315.62	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
855	285	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	5484.70	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
856	286	a602c1a3-89cf-44a4-b419-f6827ad3701b	1923.56	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
857	286	a602c1a3-89cf-44a4-b419-f6827ad3701b	3641.61	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
858	286	a602c1a3-89cf-44a4-b419-f6827ad3701b	3940.58	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
859	287	6833f990-6a38-4f28-aa18-e31697fa7dc9	5937.04	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
860	287	6833f990-6a38-4f28-aa18-e31697fa7dc9	4237.15	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
861	287	6833f990-6a38-4f28-aa18-e31697fa7dc9	4494.01	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
862	288	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3946.72	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
863	288	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	4399.22	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
864	288	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3341.64	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
865	289	ee522e07-1315-4463-8a9b-f890b601c047	4469.24	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
866	289	ee522e07-1315-4463-8a9b-f890b601c047	4515.09	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
867	289	ee522e07-1315-4463-8a9b-f890b601c047	1618.55	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
868	290	bd38508e-8797-4220-ae2e-dd7883b41f17	2624.36	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
869	290	bd38508e-8797-4220-ae2e-dd7883b41f17	4579.92	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
870	290	bd38508e-8797-4220-ae2e-dd7883b41f17	5557.13	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
871	291	8088628d-f77a-430d-b228-cc3649b8a3e1	1070.47	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
872	291	8088628d-f77a-430d-b228-cc3649b8a3e1	5845.98	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
873	291	8088628d-f77a-430d-b228-cc3649b8a3e1	3278.65	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
874	292	b794e95a-97f4-4c05-aa2d-3c13c4155841	3596.67	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
875	292	b794e95a-97f4-4c05-aa2d-3c13c4155841	1382.19	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
876	292	b794e95a-97f4-4c05-aa2d-3c13c4155841	3440.05	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
877	293	77e168c1-05e0-4314-8a24-5e838350a3d8	3922.64	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
878	293	77e168c1-05e0-4314-8a24-5e838350a3d8	3459.38	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
879	293	77e168c1-05e0-4314-8a24-5e838350a3d8	3636.08	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
880	294	51072377-1472-46cb-b180-8542677f5eb2	5311.91	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
881	294	51072377-1472-46cb-b180-8542677f5eb2	2705.80	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
882	294	51072377-1472-46cb-b180-8542677f5eb2	3025.57	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
883	295	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3493.65	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
884	295	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4491.20	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
885	295	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4286.05	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
886	296	51072377-1472-46cb-b180-8542677f5eb2	2834.76	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
887	296	51072377-1472-46cb-b180-8542677f5eb2	1504.43	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
888	296	51072377-1472-46cb-b180-8542677f5eb2	3428.61	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
889	297	6833f990-6a38-4f28-aa18-e31697fa7dc9	4343.90	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
890	297	6833f990-6a38-4f28-aa18-e31697fa7dc9	1628.69	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
891	297	6833f990-6a38-4f28-aa18-e31697fa7dc9	4832.12	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
892	298	a602c1a3-89cf-44a4-b419-f6827ad3701b	2280.20	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
893	298	a602c1a3-89cf-44a4-b419-f6827ad3701b	3125.10	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
894	298	a602c1a3-89cf-44a4-b419-f6827ad3701b	2709.91	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
895	299	cff64755-2065-4e58-866f-f092cbd9e73b	4416.02	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
896	299	cff64755-2065-4e58-866f-f092cbd9e73b	4885.03	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
897	299	cff64755-2065-4e58-866f-f092cbd9e73b	1848.32	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
898	300	9255fabc-799b-4cc7-8797-5f2470f6adf6	2980.70	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
899	300	9255fabc-799b-4cc7-8797-5f2470f6adf6	1377.85	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
900	300	9255fabc-799b-4cc7-8797-5f2470f6adf6	1740.74	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
901	301	a83848ba-0779-4fac-98ee-f5f459b2742b	4952.92	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
902	301	a83848ba-0779-4fac-98ee-f5f459b2742b	5555.38	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
903	301	a83848ba-0779-4fac-98ee-f5f459b2742b	3102.67	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
904	302	77e168c1-05e0-4314-8a24-5e838350a3d8	1888.76	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
905	302	77e168c1-05e0-4314-8a24-5e838350a3d8	5602.58	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
906	302	77e168c1-05e0-4314-8a24-5e838350a3d8	2864.69	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
907	303	77e168c1-05e0-4314-8a24-5e838350a3d8	2573.77	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
908	303	77e168c1-05e0-4314-8a24-5e838350a3d8	5540.07	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
909	303	77e168c1-05e0-4314-8a24-5e838350a3d8	4311.84	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
910	304	584a1909-5797-4297-88d3-06bf5dc3922a	1266.05	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
911	304	584a1909-5797-4297-88d3-06bf5dc3922a	1628.92	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
912	304	584a1909-5797-4297-88d3-06bf5dc3922a	1882.70	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
913	305	77e168c1-05e0-4314-8a24-5e838350a3d8	3681.23	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
914	305	77e168c1-05e0-4314-8a24-5e838350a3d8	5619.56	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
915	305	77e168c1-05e0-4314-8a24-5e838350a3d8	4765.51	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
916	306	9255fabc-799b-4cc7-8797-5f2470f6adf6	5467.87	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
917	306	9255fabc-799b-4cc7-8797-5f2470f6adf6	2447.71	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
918	306	9255fabc-799b-4cc7-8797-5f2470f6adf6	4641.97	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
919	307	6ac1e176-e710-4b5e-9453-95765db20ba3	4146.04	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
920	307	6ac1e176-e710-4b5e-9453-95765db20ba3	4104.19	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
921	307	6ac1e176-e710-4b5e-9453-95765db20ba3	4517.68	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
922	308	bd38508e-8797-4220-ae2e-dd7883b41f17	3224.35	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
923	308	bd38508e-8797-4220-ae2e-dd7883b41f17	2315.16	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
924	308	bd38508e-8797-4220-ae2e-dd7883b41f17	1858.70	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
925	309	da6ac18e-72e9-484a-ad75-d044260789cc	4671.07	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
926	309	da6ac18e-72e9-484a-ad75-d044260789cc	1158.35	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
927	309	da6ac18e-72e9-484a-ad75-d044260789cc	3487.87	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
928	310	77e168c1-05e0-4314-8a24-5e838350a3d8	5291.32	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
929	310	77e168c1-05e0-4314-8a24-5e838350a3d8	3836.27	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
930	310	77e168c1-05e0-4314-8a24-5e838350a3d8	2445.59	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
931	311	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4215.39	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
932	311	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3542.09	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
933	311	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4479.76	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
934	312	51072377-1472-46cb-b180-8542677f5eb2	3599.91	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
935	312	51072377-1472-46cb-b180-8542677f5eb2	3018.74	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
936	312	51072377-1472-46cb-b180-8542677f5eb2	3490.81	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
937	313	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2173.65	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
938	313	5bf27593-0c3d-489f-bed4-c80dc2936fdf	3362.42	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
939	313	5bf27593-0c3d-489f-bed4-c80dc2936fdf	3459.16	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
940	314	584a1909-5797-4297-88d3-06bf5dc3922a	5204.20	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
941	314	584a1909-5797-4297-88d3-06bf5dc3922a	4684.16	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
942	314	584a1909-5797-4297-88d3-06bf5dc3922a	1961.33	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
943	315	9255fabc-799b-4cc7-8797-5f2470f6adf6	5127.95	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
944	315	9255fabc-799b-4cc7-8797-5f2470f6adf6	2432.72	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
945	315	9255fabc-799b-4cc7-8797-5f2470f6adf6	4992.83	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
946	316	6ac1e176-e710-4b5e-9453-95765db20ba3	1326.15	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
947	316	6ac1e176-e710-4b5e-9453-95765db20ba3	5869.12	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
948	316	6ac1e176-e710-4b5e-9453-95765db20ba3	4423.59	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
949	317	dde964d6-6ffa-4b25-97b6-128969afe47c	5051.01	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
950	317	dde964d6-6ffa-4b25-97b6-128969afe47c	3585.37	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
951	317	dde964d6-6ffa-4b25-97b6-128969afe47c	3661.29	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
952	318	b794e95a-97f4-4c05-aa2d-3c13c4155841	5947.86	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
953	318	b794e95a-97f4-4c05-aa2d-3c13c4155841	4454.70	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
954	318	b794e95a-97f4-4c05-aa2d-3c13c4155841	2796.76	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
955	319	51072377-1472-46cb-b180-8542677f5eb2	3340.54	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
956	319	51072377-1472-46cb-b180-8542677f5eb2	3162.70	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
957	319	51072377-1472-46cb-b180-8542677f5eb2	4541.68	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
958	320	bd38508e-8797-4220-ae2e-dd7883b41f17	4691.16	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
959	320	bd38508e-8797-4220-ae2e-dd7883b41f17	4652.70	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
960	320	bd38508e-8797-4220-ae2e-dd7883b41f17	4487.47	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
961	321	9255fabc-799b-4cc7-8797-5f2470f6adf6	2334.64	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
962	321	9255fabc-799b-4cc7-8797-5f2470f6adf6	5156.18	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
963	321	9255fabc-799b-4cc7-8797-5f2470f6adf6	1391.56	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
964	322	77e168c1-05e0-4314-8a24-5e838350a3d8	3252.53	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
965	322	77e168c1-05e0-4314-8a24-5e838350a3d8	4302.95	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
966	322	77e168c1-05e0-4314-8a24-5e838350a3d8	2899.56	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
967	323	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2839.98	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
968	323	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1047.26	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
969	323	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4000.19	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
970	324	cff64755-2065-4e58-866f-f092cbd9e73b	5212.83	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
971	324	cff64755-2065-4e58-866f-f092cbd9e73b	4429.19	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
972	324	cff64755-2065-4e58-866f-f092cbd9e73b	3362.62	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
973	325	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5070.38	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
974	325	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3291.25	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
975	325	fd99f59b-fcc6-42ef-a407-207f110f2d7b	1889.91	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
976	326	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2299.36	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
977	326	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3028.65	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
978	326	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5455.17	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
979	327	584a1909-5797-4297-88d3-06bf5dc3922a	2276.90	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
980	327	584a1909-5797-4297-88d3-06bf5dc3922a	3935.79	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
981	327	584a1909-5797-4297-88d3-06bf5dc3922a	3844.42	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
982	328	dd35da46-4416-412a-8a22-f3f39491bb7b	4864.55	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
983	328	dd35da46-4416-412a-8a22-f3f39491bb7b	1179.72	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
984	328	dd35da46-4416-412a-8a22-f3f39491bb7b	2868.12	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
985	329	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1600.19	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
986	329	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3333.13	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
987	329	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5001.74	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
988	330	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3057.79	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
989	330	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2837.33	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
990	330	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2145.57	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
991	331	a602c1a3-89cf-44a4-b419-f6827ad3701b	4338.62	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
992	331	a602c1a3-89cf-44a4-b419-f6827ad3701b	3720.57	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
993	331	a602c1a3-89cf-44a4-b419-f6827ad3701b	2446.14	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
994	332	51072377-1472-46cb-b180-8542677f5eb2	5378.37	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
995	332	51072377-1472-46cb-b180-8542677f5eb2	1690.21	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
996	332	51072377-1472-46cb-b180-8542677f5eb2	2664.67	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
997	333	dbbbe49c-e100-4576-b406-320908c8873e	5567.21	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
998	333	dbbbe49c-e100-4576-b406-320908c8873e	1089.48	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
999	333	dbbbe49c-e100-4576-b406-320908c8873e	5130.19	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1000	334	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1116.91	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1001	334	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2123.02	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1002	334	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5988.33	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1003	335	b794e95a-97f4-4c05-aa2d-3c13c4155841	1233.11	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1004	335	b794e95a-97f4-4c05-aa2d-3c13c4155841	1355.36	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1005	335	b794e95a-97f4-4c05-aa2d-3c13c4155841	4283.42	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1006	336	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2464.79	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1007	336	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4043.32	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1008	336	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2095.23	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1009	337	a602c1a3-89cf-44a4-b419-f6827ad3701b	3184.38	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1010	337	a602c1a3-89cf-44a4-b419-f6827ad3701b	2084.73	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1011	337	a602c1a3-89cf-44a4-b419-f6827ad3701b	3207.01	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1012	338	387d98f7-ccf9-4077-8f79-f0be51c40d05	4417.18	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1013	338	387d98f7-ccf9-4077-8f79-f0be51c40d05	4831.98	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1014	338	387d98f7-ccf9-4077-8f79-f0be51c40d05	4785.46	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1015	339	8088628d-f77a-430d-b228-cc3649b8a3e1	5931.99	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1016	339	8088628d-f77a-430d-b228-cc3649b8a3e1	3786.73	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1017	339	8088628d-f77a-430d-b228-cc3649b8a3e1	2753.57	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1018	340	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2569.79	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1019	340	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3006.79	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1020	340	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2682.63	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1021	341	387d98f7-ccf9-4077-8f79-f0be51c40d05	4485.08	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1022	341	387d98f7-ccf9-4077-8f79-f0be51c40d05	3146.47	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1023	341	387d98f7-ccf9-4077-8f79-f0be51c40d05	4172.19	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1024	342	387d98f7-ccf9-4077-8f79-f0be51c40d05	1313.74	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1025	342	387d98f7-ccf9-4077-8f79-f0be51c40d05	1290.96	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1026	342	387d98f7-ccf9-4077-8f79-f0be51c40d05	2606.40	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1027	343	a602c1a3-89cf-44a4-b419-f6827ad3701b	1577.36	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1028	343	a602c1a3-89cf-44a4-b419-f6827ad3701b	5120.14	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1029	343	a602c1a3-89cf-44a4-b419-f6827ad3701b	3883.82	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1030	344	77e168c1-05e0-4314-8a24-5e838350a3d8	4768.81	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1031	344	77e168c1-05e0-4314-8a24-5e838350a3d8	3141.60	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1032	344	77e168c1-05e0-4314-8a24-5e838350a3d8	2059.95	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1033	345	b1f5db31-bfc8-409c-8925-0d21f1c780e6	4406.98	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1034	345	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3087.34	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1035	345	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3030.19	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1036	346	bd38508e-8797-4220-ae2e-dd7883b41f17	3961.89	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1037	346	bd38508e-8797-4220-ae2e-dd7883b41f17	1590.61	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1038	346	bd38508e-8797-4220-ae2e-dd7883b41f17	2200.04	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1039	347	cff64755-2065-4e58-866f-f092cbd9e73b	3438.33	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1040	347	cff64755-2065-4e58-866f-f092cbd9e73b	4891.20	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1041	347	cff64755-2065-4e58-866f-f092cbd9e73b	5982.79	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1042	348	dde964d6-6ffa-4b25-97b6-128969afe47c	4396.44	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1043	348	dde964d6-6ffa-4b25-97b6-128969afe47c	5532.29	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1044	348	dde964d6-6ffa-4b25-97b6-128969afe47c	4349.31	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1045	349	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4368.75	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1046	349	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4422.05	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1047	349	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2006.57	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1048	350	6ac1e176-e710-4b5e-9453-95765db20ba3	5057.59	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1049	350	6ac1e176-e710-4b5e-9453-95765db20ba3	5188.93	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1050	350	6ac1e176-e710-4b5e-9453-95765db20ba3	4901.93	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1051	351	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4324.16	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1052	351	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	1914.16	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1053	351	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	5192.26	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1054	352	ee522e07-1315-4463-8a9b-f890b601c047	1485.45	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1055	352	ee522e07-1315-4463-8a9b-f890b601c047	1613.43	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1056	352	ee522e07-1315-4463-8a9b-f890b601c047	2492.79	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1057	353	463737cc-950b-4a41-8d73-a3daf931fee5	3808.93	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1058	353	463737cc-950b-4a41-8d73-a3daf931fee5	2882.45	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1059	353	463737cc-950b-4a41-8d73-a3daf931fee5	4830.57	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1060	354	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5365.07	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1061	354	5bf27593-0c3d-489f-bed4-c80dc2936fdf	3885.57	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1062	354	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1126.96	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1063	355	fc7c7272-6d55-49a3-88d7-fc37133a103f	5398.74	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1064	355	fc7c7272-6d55-49a3-88d7-fc37133a103f	1974.10	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1065	355	fc7c7272-6d55-49a3-88d7-fc37133a103f	3994.66	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1066	356	1934abf8-eca9-41d8-bc5f-9c649285b76b	2821.36	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1067	356	1934abf8-eca9-41d8-bc5f-9c649285b76b	4133.69	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1068	356	1934abf8-eca9-41d8-bc5f-9c649285b76b	3857.08	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1069	357	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3021.10	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1070	357	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4430.04	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1071	357	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4146.68	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1072	358	584a1909-5797-4297-88d3-06bf5dc3922a	3926.00	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1073	358	584a1909-5797-4297-88d3-06bf5dc3922a	5150.11	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1074	358	584a1909-5797-4297-88d3-06bf5dc3922a	1190.61	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1075	359	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3393.40	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1076	359	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3201.05	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1077	359	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2936.25	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1078	360	dde964d6-6ffa-4b25-97b6-128969afe47c	1537.66	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1079	360	dde964d6-6ffa-4b25-97b6-128969afe47c	4432.54	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1080	360	dde964d6-6ffa-4b25-97b6-128969afe47c	2070.74	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1081	361	dbbbe49c-e100-4576-b406-320908c8873e	1581.91	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1082	361	dbbbe49c-e100-4576-b406-320908c8873e	2962.57	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1083	361	dbbbe49c-e100-4576-b406-320908c8873e	3750.24	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1084	362	fc7c7272-6d55-49a3-88d7-fc37133a103f	4966.40	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1085	362	fc7c7272-6d55-49a3-88d7-fc37133a103f	2181.42	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1086	362	fc7c7272-6d55-49a3-88d7-fc37133a103f	5643.91	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1087	363	5432f125-2d5e-42ab-849a-29add2cf0a74	4593.37	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1088	363	5432f125-2d5e-42ab-849a-29add2cf0a74	3896.49	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1089	363	5432f125-2d5e-42ab-849a-29add2cf0a74	4327.75	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1090	364	a602c1a3-89cf-44a4-b419-f6827ad3701b	1900.09	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1091	364	a602c1a3-89cf-44a4-b419-f6827ad3701b	3752.94	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1092	364	a602c1a3-89cf-44a4-b419-f6827ad3701b	2758.05	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1093	365	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	5127.59	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1094	365	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4287.54	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1095	365	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	1560.40	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1096	366	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5762.26	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1097	366	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2421.19	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1098	366	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3043.46	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1099	367	77e168c1-05e0-4314-8a24-5e838350a3d8	3142.71	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1100	367	77e168c1-05e0-4314-8a24-5e838350a3d8	5019.74	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1101	367	77e168c1-05e0-4314-8a24-5e838350a3d8	1177.82	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1102	368	cff64755-2065-4e58-866f-f092cbd9e73b	5231.94	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1103	368	cff64755-2065-4e58-866f-f092cbd9e73b	3546.33	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1104	368	cff64755-2065-4e58-866f-f092cbd9e73b	1819.68	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1105	369	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	5318.96	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1106	369	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2232.39	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1107	369	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2231.70	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1108	370	a83848ba-0779-4fac-98ee-f5f459b2742b	2646.79	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1109	370	a83848ba-0779-4fac-98ee-f5f459b2742b	5897.89	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1110	370	a83848ba-0779-4fac-98ee-f5f459b2742b	5294.97	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1111	371	51072377-1472-46cb-b180-8542677f5eb2	3099.76	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1112	371	51072377-1472-46cb-b180-8542677f5eb2	2046.59	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1113	371	51072377-1472-46cb-b180-8542677f5eb2	1891.38	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1114	372	ee522e07-1315-4463-8a9b-f890b601c047	4636.33	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1115	372	ee522e07-1315-4463-8a9b-f890b601c047	4349.24	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1116	372	ee522e07-1315-4463-8a9b-f890b601c047	2683.78	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1117	373	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	1365.37	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1118	373	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	1663.36	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1119	373	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2107.33	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1120	374	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	5000.33	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1121	374	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2186.47	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1122	374	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3989.39	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1123	375	584a1909-5797-4297-88d3-06bf5dc3922a	3482.26	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1124	375	584a1909-5797-4297-88d3-06bf5dc3922a	5149.29	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1125	375	584a1909-5797-4297-88d3-06bf5dc3922a	1878.28	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1126	376	dd35da46-4416-412a-8a22-f3f39491bb7b	3916.60	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1127	376	dd35da46-4416-412a-8a22-f3f39491bb7b	2077.19	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1128	376	dd35da46-4416-412a-8a22-f3f39491bb7b	3968.70	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1129	377	ee522e07-1315-4463-8a9b-f890b601c047	5569.40	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1130	377	ee522e07-1315-4463-8a9b-f890b601c047	2063.96	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1131	377	ee522e07-1315-4463-8a9b-f890b601c047	1416.02	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1132	378	dbbbe49c-e100-4576-b406-320908c8873e	1604.62	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1133	378	dbbbe49c-e100-4576-b406-320908c8873e	4940.57	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1134	378	dbbbe49c-e100-4576-b406-320908c8873e	3897.70	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1135	379	584a1909-5797-4297-88d3-06bf5dc3922a	3710.93	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1136	379	584a1909-5797-4297-88d3-06bf5dc3922a	1069.38	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1137	379	584a1909-5797-4297-88d3-06bf5dc3922a	3709.56	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1138	380	b794e95a-97f4-4c05-aa2d-3c13c4155841	4954.28	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1139	380	b794e95a-97f4-4c05-aa2d-3c13c4155841	5715.01	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1140	380	b794e95a-97f4-4c05-aa2d-3c13c4155841	3994.00	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1141	381	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5297.40	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1142	381	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2371.81	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1143	381	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3658.55	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1144	382	9255fabc-799b-4cc7-8797-5f2470f6adf6	5050.42	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1145	382	9255fabc-799b-4cc7-8797-5f2470f6adf6	5666.61	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1146	382	9255fabc-799b-4cc7-8797-5f2470f6adf6	2395.81	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1147	383	387d98f7-ccf9-4077-8f79-f0be51c40d05	3942.84	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1148	383	387d98f7-ccf9-4077-8f79-f0be51c40d05	1256.55	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1149	383	387d98f7-ccf9-4077-8f79-f0be51c40d05	3466.81	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1150	384	bd38508e-8797-4220-ae2e-dd7883b41f17	1704.66	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1151	384	bd38508e-8797-4220-ae2e-dd7883b41f17	5647.76	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1152	384	bd38508e-8797-4220-ae2e-dd7883b41f17	1902.66	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1153	385	a83848ba-0779-4fac-98ee-f5f459b2742b	2075.90	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1154	385	a83848ba-0779-4fac-98ee-f5f459b2742b	3060.17	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1155	385	a83848ba-0779-4fac-98ee-f5f459b2742b	3507.69	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1156	386	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	4159.91	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1157	386	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3774.36	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1158	386	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	5129.51	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1159	387	9255fabc-799b-4cc7-8797-5f2470f6adf6	5085.71	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1160	387	9255fabc-799b-4cc7-8797-5f2470f6adf6	2238.95	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1161	387	9255fabc-799b-4cc7-8797-5f2470f6adf6	1930.77	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1162	388	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2280.71	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1163	388	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2177.25	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1164	388	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1700.04	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1165	389	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2903.57	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1166	389	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	5672.73	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1167	389	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2406.98	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1168	390	da6ac18e-72e9-484a-ad75-d044260789cc	2091.49	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1169	390	da6ac18e-72e9-484a-ad75-d044260789cc	3431.17	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1170	390	da6ac18e-72e9-484a-ad75-d044260789cc	4478.81	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1171	391	5432f125-2d5e-42ab-849a-29add2cf0a74	4098.88	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1172	391	5432f125-2d5e-42ab-849a-29add2cf0a74	2967.87	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1173	391	5432f125-2d5e-42ab-849a-29add2cf0a74	2225.72	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1174	392	9255fabc-799b-4cc7-8797-5f2470f6adf6	3223.14	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1175	392	9255fabc-799b-4cc7-8797-5f2470f6adf6	1239.48	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1176	392	9255fabc-799b-4cc7-8797-5f2470f6adf6	4284.30	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1177	393	a602c1a3-89cf-44a4-b419-f6827ad3701b	5008.14	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1178	393	a602c1a3-89cf-44a4-b419-f6827ad3701b	4230.19	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1179	393	a602c1a3-89cf-44a4-b419-f6827ad3701b	2317.41	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1180	394	6833f990-6a38-4f28-aa18-e31697fa7dc9	3751.41	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1181	394	6833f990-6a38-4f28-aa18-e31697fa7dc9	2429.66	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1182	394	6833f990-6a38-4f28-aa18-e31697fa7dc9	2577.15	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1183	395	cff64755-2065-4e58-866f-f092cbd9e73b	5980.21	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1184	395	cff64755-2065-4e58-866f-f092cbd9e73b	3279.65	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1185	395	cff64755-2065-4e58-866f-f092cbd9e73b	1148.11	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1186	396	387d98f7-ccf9-4077-8f79-f0be51c40d05	2686.97	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1187	396	387d98f7-ccf9-4077-8f79-f0be51c40d05	5972.82	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1188	396	387d98f7-ccf9-4077-8f79-f0be51c40d05	3833.52	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1189	397	463737cc-950b-4a41-8d73-a3daf931fee5	2602.17	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1190	397	463737cc-950b-4a41-8d73-a3daf931fee5	2119.67	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1191	397	463737cc-950b-4a41-8d73-a3daf931fee5	1025.79	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1192	398	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2258.05	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1193	398	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3156.85	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1194	398	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2966.50	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1195	399	ee522e07-1315-4463-8a9b-f890b601c047	2066.80	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1196	399	ee522e07-1315-4463-8a9b-f890b601c047	1045.50	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1197	399	ee522e07-1315-4463-8a9b-f890b601c047	5850.67	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1198	400	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3958.21	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1199	400	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	4815.84	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1200	400	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	1827.42	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1201	401	a602c1a3-89cf-44a4-b419-f6827ad3701b	5465.68	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1202	401	a602c1a3-89cf-44a4-b419-f6827ad3701b	1107.15	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1203	401	a602c1a3-89cf-44a4-b419-f6827ad3701b	5537.49	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1204	402	b794e95a-97f4-4c05-aa2d-3c13c4155841	2938.37	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1205	402	b794e95a-97f4-4c05-aa2d-3c13c4155841	4290.14	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1206	402	b794e95a-97f4-4c05-aa2d-3c13c4155841	5485.98	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1207	403	dbbbe49c-e100-4576-b406-320908c8873e	4035.56	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1208	403	dbbbe49c-e100-4576-b406-320908c8873e	5656.94	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1209	403	dbbbe49c-e100-4576-b406-320908c8873e	3737.92	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1210	404	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2958.65	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1211	404	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1304.41	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1212	404	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5320.58	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1213	405	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3153.27	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1214	405	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3676.28	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1215	405	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3667.60	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1216	406	584a1909-5797-4297-88d3-06bf5dc3922a	1869.97	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1217	406	584a1909-5797-4297-88d3-06bf5dc3922a	5354.56	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1218	406	584a1909-5797-4297-88d3-06bf5dc3922a	4698.06	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1219	407	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2583.12	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1220	407	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1194.25	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1221	407	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1299.75	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1222	408	387d98f7-ccf9-4077-8f79-f0be51c40d05	2980.03	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1223	408	387d98f7-ccf9-4077-8f79-f0be51c40d05	2304.30	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1224	408	387d98f7-ccf9-4077-8f79-f0be51c40d05	1410.36	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1225	409	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3744.27	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1226	409	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2863.10	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1227	409	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5765.07	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1228	410	b794e95a-97f4-4c05-aa2d-3c13c4155841	4030.43	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1229	410	b794e95a-97f4-4c05-aa2d-3c13c4155841	4061.02	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1230	410	b794e95a-97f4-4c05-aa2d-3c13c4155841	5755.83	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1231	411	dbbbe49c-e100-4576-b406-320908c8873e	2734.90	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1232	411	dbbbe49c-e100-4576-b406-320908c8873e	4616.74	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1233	411	dbbbe49c-e100-4576-b406-320908c8873e	3481.81	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1234	412	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2368.61	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1235	412	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1152.19	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1236	412	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4882.32	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1237	413	77e168c1-05e0-4314-8a24-5e838350a3d8	2207.61	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1238	413	77e168c1-05e0-4314-8a24-5e838350a3d8	3031.80	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1239	413	77e168c1-05e0-4314-8a24-5e838350a3d8	4802.08	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1240	414	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1429.66	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1241	414	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3809.03	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1242	414	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1809.01	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1243	415	dbbbe49c-e100-4576-b406-320908c8873e	1396.06	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1244	415	dbbbe49c-e100-4576-b406-320908c8873e	3813.77	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1245	415	dbbbe49c-e100-4576-b406-320908c8873e	2880.42	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1246	416	b794e95a-97f4-4c05-aa2d-3c13c4155841	2089.08	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1247	416	b794e95a-97f4-4c05-aa2d-3c13c4155841	4311.76	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1248	416	b794e95a-97f4-4c05-aa2d-3c13c4155841	3106.73	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1249	417	a602c1a3-89cf-44a4-b419-f6827ad3701b	2512.25	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1250	417	a602c1a3-89cf-44a4-b419-f6827ad3701b	4942.24	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1251	417	a602c1a3-89cf-44a4-b419-f6827ad3701b	4464.58	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1252	418	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4031.28	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1253	418	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4742.19	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1254	418	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4069.22	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1255	419	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5251.93	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1256	419	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5503.33	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1257	419	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5430.86	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1258	420	8088628d-f77a-430d-b228-cc3649b8a3e1	2643.10	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1259	420	8088628d-f77a-430d-b228-cc3649b8a3e1	3733.77	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1260	420	8088628d-f77a-430d-b228-cc3649b8a3e1	1152.49	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1261	421	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4338.46	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1262	421	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4191.51	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1263	421	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1536.53	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1264	422	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4075.74	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1265	422	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3741.34	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1266	422	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4451.14	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1267	423	6ac1e176-e710-4b5e-9453-95765db20ba3	5027.17	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1268	423	6ac1e176-e710-4b5e-9453-95765db20ba3	1417.74	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1269	423	6ac1e176-e710-4b5e-9453-95765db20ba3	1917.31	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1270	424	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2362.25	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1271	424	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2507.40	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1272	424	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3573.59	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1273	425	584a1909-5797-4297-88d3-06bf5dc3922a	1998.21	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1274	425	584a1909-5797-4297-88d3-06bf5dc3922a	2958.57	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1275	425	584a1909-5797-4297-88d3-06bf5dc3922a	2133.22	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1276	426	b794e95a-97f4-4c05-aa2d-3c13c4155841	5291.73	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1277	426	b794e95a-97f4-4c05-aa2d-3c13c4155841	4311.47	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1278	426	b794e95a-97f4-4c05-aa2d-3c13c4155841	4482.11	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1279	427	a83848ba-0779-4fac-98ee-f5f459b2742b	1990.75	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1280	427	a83848ba-0779-4fac-98ee-f5f459b2742b	3829.11	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1281	427	a83848ba-0779-4fac-98ee-f5f459b2742b	4459.67	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1282	428	fc7c7272-6d55-49a3-88d7-fc37133a103f	5018.25	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1283	428	fc7c7272-6d55-49a3-88d7-fc37133a103f	4068.84	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1284	428	fc7c7272-6d55-49a3-88d7-fc37133a103f	5930.63	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1285	429	8088628d-f77a-430d-b228-cc3649b8a3e1	2706.81	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1286	429	8088628d-f77a-430d-b228-cc3649b8a3e1	5250.75	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1287	429	8088628d-f77a-430d-b228-cc3649b8a3e1	4734.36	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1288	430	dde964d6-6ffa-4b25-97b6-128969afe47c	4587.75	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1289	430	dde964d6-6ffa-4b25-97b6-128969afe47c	2160.73	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1290	430	dde964d6-6ffa-4b25-97b6-128969afe47c	4365.08	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1291	431	da6ac18e-72e9-484a-ad75-d044260789cc	3094.46	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1292	431	da6ac18e-72e9-484a-ad75-d044260789cc	3090.85	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1293	431	da6ac18e-72e9-484a-ad75-d044260789cc	5147.20	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1294	432	da6ac18e-72e9-484a-ad75-d044260789cc	3082.77	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1295	432	da6ac18e-72e9-484a-ad75-d044260789cc	3738.96	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1296	432	da6ac18e-72e9-484a-ad75-d044260789cc	1893.50	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1297	433	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2741.41	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1298	433	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3090.01	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1299	433	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1497.97	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1300	434	fc7c7272-6d55-49a3-88d7-fc37133a103f	5806.62	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1301	434	fc7c7272-6d55-49a3-88d7-fc37133a103f	3580.07	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1302	434	fc7c7272-6d55-49a3-88d7-fc37133a103f	4867.53	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1303	435	5432f125-2d5e-42ab-849a-29add2cf0a74	5692.67	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1304	435	5432f125-2d5e-42ab-849a-29add2cf0a74	2931.69	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1305	435	5432f125-2d5e-42ab-849a-29add2cf0a74	2640.24	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1306	436	463737cc-950b-4a41-8d73-a3daf931fee5	1847.97	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1307	436	463737cc-950b-4a41-8d73-a3daf931fee5	4111.80	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1308	436	463737cc-950b-4a41-8d73-a3daf931fee5	4222.09	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1309	437	9255fabc-799b-4cc7-8797-5f2470f6adf6	2129.84	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1310	437	9255fabc-799b-4cc7-8797-5f2470f6adf6	2822.02	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1311	437	9255fabc-799b-4cc7-8797-5f2470f6adf6	2104.49	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1312	438	bd38508e-8797-4220-ae2e-dd7883b41f17	1312.32	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1313	438	bd38508e-8797-4220-ae2e-dd7883b41f17	2978.15	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1314	438	bd38508e-8797-4220-ae2e-dd7883b41f17	2197.42	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1315	439	6833f990-6a38-4f28-aa18-e31697fa7dc9	1857.75	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1316	439	6833f990-6a38-4f28-aa18-e31697fa7dc9	1140.62	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1317	439	6833f990-6a38-4f28-aa18-e31697fa7dc9	3448.85	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1318	440	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2758.82	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1319	440	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2090.90	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1320	440	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1592.56	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1321	441	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2049.42	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1322	441	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2476.99	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1323	441	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5173.42	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1324	442	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3563.38	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1325	442	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1150.42	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1326	442	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5273.49	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1327	443	dde964d6-6ffa-4b25-97b6-128969afe47c	3080.81	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1328	443	dde964d6-6ffa-4b25-97b6-128969afe47c	4851.78	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1329	443	dde964d6-6ffa-4b25-97b6-128969afe47c	3725.90	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1330	444	6ac1e176-e710-4b5e-9453-95765db20ba3	5413.71	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1331	444	6ac1e176-e710-4b5e-9453-95765db20ba3	3987.23	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1332	444	6ac1e176-e710-4b5e-9453-95765db20ba3	4111.53	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1333	445	1934abf8-eca9-41d8-bc5f-9c649285b76b	1782.13	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1334	445	1934abf8-eca9-41d8-bc5f-9c649285b76b	4576.94	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1335	445	1934abf8-eca9-41d8-bc5f-9c649285b76b	2331.89	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1336	446	ee522e07-1315-4463-8a9b-f890b601c047	1293.88	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1337	446	ee522e07-1315-4463-8a9b-f890b601c047	1466.34	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1338	446	ee522e07-1315-4463-8a9b-f890b601c047	3234.76	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1339	447	dbbbe49c-e100-4576-b406-320908c8873e	5336.34	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1340	447	dbbbe49c-e100-4576-b406-320908c8873e	4196.24	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1341	447	dbbbe49c-e100-4576-b406-320908c8873e	5758.89	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1342	448	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2080.13	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1343	448	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1541.87	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1344	448	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4857.22	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1345	449	584a1909-5797-4297-88d3-06bf5dc3922a	3293.83	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1346	449	584a1909-5797-4297-88d3-06bf5dc3922a	2540.78	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1347	449	584a1909-5797-4297-88d3-06bf5dc3922a	1123.93	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1348	450	a83848ba-0779-4fac-98ee-f5f459b2742b	5650.23	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1349	450	a83848ba-0779-4fac-98ee-f5f459b2742b	2916.90	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1350	450	a83848ba-0779-4fac-98ee-f5f459b2742b	1806.71	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1351	451	5432f125-2d5e-42ab-849a-29add2cf0a74	3999.57	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1352	451	5432f125-2d5e-42ab-849a-29add2cf0a74	4005.39	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1353	451	5432f125-2d5e-42ab-849a-29add2cf0a74	5104.56	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1354	452	9255fabc-799b-4cc7-8797-5f2470f6adf6	4961.38	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1355	452	9255fabc-799b-4cc7-8797-5f2470f6adf6	3607.58	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1356	452	9255fabc-799b-4cc7-8797-5f2470f6adf6	4515.92	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1357	453	a602c1a3-89cf-44a4-b419-f6827ad3701b	5507.75	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1358	453	a602c1a3-89cf-44a4-b419-f6827ad3701b	2062.43	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1359	453	a602c1a3-89cf-44a4-b419-f6827ad3701b	3457.82	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1360	454	387d98f7-ccf9-4077-8f79-f0be51c40d05	1055.01	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1361	454	387d98f7-ccf9-4077-8f79-f0be51c40d05	5345.70	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1362	454	387d98f7-ccf9-4077-8f79-f0be51c40d05	3459.47	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1363	455	dbbbe49c-e100-4576-b406-320908c8873e	5707.29	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1364	455	dbbbe49c-e100-4576-b406-320908c8873e	1675.01	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1365	455	dbbbe49c-e100-4576-b406-320908c8873e	3784.86	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1366	456	b794e95a-97f4-4c05-aa2d-3c13c4155841	2923.00	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1367	456	b794e95a-97f4-4c05-aa2d-3c13c4155841	1168.68	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1368	456	b794e95a-97f4-4c05-aa2d-3c13c4155841	1294.56	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1369	457	dde964d6-6ffa-4b25-97b6-128969afe47c	5428.14	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1370	457	dde964d6-6ffa-4b25-97b6-128969afe47c	1206.60	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1371	457	dde964d6-6ffa-4b25-97b6-128969afe47c	4228.09	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1372	458	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2319.35	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1373	458	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4835.18	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1374	458	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2783.44	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1375	459	6ac1e176-e710-4b5e-9453-95765db20ba3	4114.18	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1376	459	6ac1e176-e710-4b5e-9453-95765db20ba3	3871.55	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1377	459	6ac1e176-e710-4b5e-9453-95765db20ba3	4968.38	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1378	460	51072377-1472-46cb-b180-8542677f5eb2	3460.40	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1379	460	51072377-1472-46cb-b180-8542677f5eb2	1799.23	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1380	460	51072377-1472-46cb-b180-8542677f5eb2	3643.87	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1381	461	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3456.90	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1382	461	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4390.24	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1383	461	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4235.69	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1384	462	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2270.40	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1385	462	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5465.16	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1386	462	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2828.70	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1387	463	5432f125-2d5e-42ab-849a-29add2cf0a74	1805.79	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1388	463	5432f125-2d5e-42ab-849a-29add2cf0a74	1990.82	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1389	463	5432f125-2d5e-42ab-849a-29add2cf0a74	5453.33	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1390	464	cff64755-2065-4e58-866f-f092cbd9e73b	1331.51	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1391	464	cff64755-2065-4e58-866f-f092cbd9e73b	1517.94	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1392	464	cff64755-2065-4e58-866f-f092cbd9e73b	5636.33	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1393	465	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2950.70	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1394	465	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	5002.97	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1395	465	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	5992.11	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1396	466	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	1303.74	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1397	466	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2068.02	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1398	466	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2998.77	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1399	467	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2804.36	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1400	467	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3529.36	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1401	467	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	5322.92	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1402	468	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	5490.37	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1403	468	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2408.51	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1404	468	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3009.34	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1405	469	a602c1a3-89cf-44a4-b419-f6827ad3701b	2753.61	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1406	469	a602c1a3-89cf-44a4-b419-f6827ad3701b	2014.98	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1407	469	a602c1a3-89cf-44a4-b419-f6827ad3701b	4151.74	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1408	470	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5004.22	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1409	470	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4888.22	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1410	470	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2349.66	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1411	471	584a1909-5797-4297-88d3-06bf5dc3922a	3417.04	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1412	471	584a1909-5797-4297-88d3-06bf5dc3922a	2240.06	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1413	471	584a1909-5797-4297-88d3-06bf5dc3922a	5814.84	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1414	472	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	2344.96	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1415	472	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5344.18	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1416	472	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5750.85	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1417	473	584a1909-5797-4297-88d3-06bf5dc3922a	1794.67	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1418	473	584a1909-5797-4297-88d3-06bf5dc3922a	5792.69	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1419	473	584a1909-5797-4297-88d3-06bf5dc3922a	3861.84	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1420	474	fc7c7272-6d55-49a3-88d7-fc37133a103f	2041.28	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1421	474	fc7c7272-6d55-49a3-88d7-fc37133a103f	5350.39	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1422	474	fc7c7272-6d55-49a3-88d7-fc37133a103f	1042.12	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1423	475	fc7c7272-6d55-49a3-88d7-fc37133a103f	4024.46	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1424	475	fc7c7272-6d55-49a3-88d7-fc37133a103f	2768.26	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1425	475	fc7c7272-6d55-49a3-88d7-fc37133a103f	2763.35	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1426	476	6ac1e176-e710-4b5e-9453-95765db20ba3	5346.42	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1427	476	6ac1e176-e710-4b5e-9453-95765db20ba3	4283.53	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1428	476	6ac1e176-e710-4b5e-9453-95765db20ba3	3149.93	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1429	477	cff64755-2065-4e58-866f-f092cbd9e73b	5307.88	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1430	477	cff64755-2065-4e58-866f-f092cbd9e73b	4218.10	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1431	477	cff64755-2065-4e58-866f-f092cbd9e73b	4785.87	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1432	478	1934abf8-eca9-41d8-bc5f-9c649285b76b	5739.61	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1433	478	1934abf8-eca9-41d8-bc5f-9c649285b76b	4177.30	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1434	478	1934abf8-eca9-41d8-bc5f-9c649285b76b	5531.55	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1435	479	ee522e07-1315-4463-8a9b-f890b601c047	5202.22	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1436	479	ee522e07-1315-4463-8a9b-f890b601c047	5782.01	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1437	479	ee522e07-1315-4463-8a9b-f890b601c047	1748.38	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1438	480	dbbbe49c-e100-4576-b406-320908c8873e	1280.88	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1439	480	dbbbe49c-e100-4576-b406-320908c8873e	5879.17	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1440	480	dbbbe49c-e100-4576-b406-320908c8873e	2667.57	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1441	481	1934abf8-eca9-41d8-bc5f-9c649285b76b	1600.06	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1442	481	1934abf8-eca9-41d8-bc5f-9c649285b76b	2583.62	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1443	481	1934abf8-eca9-41d8-bc5f-9c649285b76b	1070.11	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1444	482	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4705.47	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1445	482	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	4178.84	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1446	482	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2023.72	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1447	483	a602c1a3-89cf-44a4-b419-f6827ad3701b	3926.70	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1448	483	a602c1a3-89cf-44a4-b419-f6827ad3701b	4764.92	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1449	483	a602c1a3-89cf-44a4-b419-f6827ad3701b	4548.95	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1450	484	1934abf8-eca9-41d8-bc5f-9c649285b76b	3956.96	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1451	484	1934abf8-eca9-41d8-bc5f-9c649285b76b	4912.60	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1452	484	1934abf8-eca9-41d8-bc5f-9c649285b76b	2796.80	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1453	485	51072377-1472-46cb-b180-8542677f5eb2	3286.40	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1454	485	51072377-1472-46cb-b180-8542677f5eb2	2843.52	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1455	485	51072377-1472-46cb-b180-8542677f5eb2	2711.79	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1456	486	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1584.26	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1457	486	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3669.44	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1458	486	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1397.78	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1459	487	6ac1e176-e710-4b5e-9453-95765db20ba3	3338.23	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1460	487	6ac1e176-e710-4b5e-9453-95765db20ba3	5692.82	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1461	487	6ac1e176-e710-4b5e-9453-95765db20ba3	3119.74	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1462	488	ee522e07-1315-4463-8a9b-f890b601c047	1747.48	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1463	488	ee522e07-1315-4463-8a9b-f890b601c047	3215.40	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1464	488	ee522e07-1315-4463-8a9b-f890b601c047	2014.81	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1465	489	dde964d6-6ffa-4b25-97b6-128969afe47c	2212.49	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1466	489	dde964d6-6ffa-4b25-97b6-128969afe47c	1676.54	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1467	489	dde964d6-6ffa-4b25-97b6-128969afe47c	1028.25	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1468	490	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2218.16	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1469	490	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	5237.79	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1470	490	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2717.98	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1471	491	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3455.76	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1472	491	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2030.80	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1473	491	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5570.01	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1474	492	77e168c1-05e0-4314-8a24-5e838350a3d8	1539.69	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1475	492	77e168c1-05e0-4314-8a24-5e838350a3d8	2511.43	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1476	492	77e168c1-05e0-4314-8a24-5e838350a3d8	4723.41	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1477	493	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2465.28	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1478	493	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3610.72	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1479	493	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3843.72	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1480	494	fc7c7272-6d55-49a3-88d7-fc37133a103f	3064.44	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1481	494	fc7c7272-6d55-49a3-88d7-fc37133a103f	4041.37	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1482	494	fc7c7272-6d55-49a3-88d7-fc37133a103f	5122.53	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1483	495	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5712.36	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1484	495	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5360.97	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1485	495	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3064.59	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1486	496	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1260.28	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1487	496	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2637.12	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1488	496	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3475.02	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1489	497	a602c1a3-89cf-44a4-b419-f6827ad3701b	4741.44	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1490	497	a602c1a3-89cf-44a4-b419-f6827ad3701b	4040.96	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1491	497	a602c1a3-89cf-44a4-b419-f6827ad3701b	5359.86	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1492	498	5432f125-2d5e-42ab-849a-29add2cf0a74	2676.00	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1493	498	5432f125-2d5e-42ab-849a-29add2cf0a74	5729.61	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1494	498	5432f125-2d5e-42ab-849a-29add2cf0a74	3955.66	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1495	499	b1f5db31-bfc8-409c-8925-0d21f1c780e6	1448.23	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1496	499	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5007.76	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1497	499	b1f5db31-bfc8-409c-8925-0d21f1c780e6	4591.54	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1498	500	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	4813.50	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1499	500	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3990.31	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1500	500	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2252.83	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1501	501	51072377-1472-46cb-b180-8542677f5eb2	4199.28	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1502	501	51072377-1472-46cb-b180-8542677f5eb2	1536.61	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1503	501	51072377-1472-46cb-b180-8542677f5eb2	5799.04	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1504	502	6ac1e176-e710-4b5e-9453-95765db20ba3	4055.81	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1505	502	6ac1e176-e710-4b5e-9453-95765db20ba3	4652.65	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1506	502	6ac1e176-e710-4b5e-9453-95765db20ba3	3688.35	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1507	503	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3003.60	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1508	503	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3140.47	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1509	503	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2205.22	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1510	504	9255fabc-799b-4cc7-8797-5f2470f6adf6	3035.23	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1511	504	9255fabc-799b-4cc7-8797-5f2470f6adf6	2787.62	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1512	504	9255fabc-799b-4cc7-8797-5f2470f6adf6	2047.17	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1513	505	dd35da46-4416-412a-8a22-f3f39491bb7b	5473.25	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1514	505	dd35da46-4416-412a-8a22-f3f39491bb7b	2043.73	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1515	505	dd35da46-4416-412a-8a22-f3f39491bb7b	4569.88	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1516	506	51072377-1472-46cb-b180-8542677f5eb2	4049.31	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1517	506	51072377-1472-46cb-b180-8542677f5eb2	5461.96	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1518	506	51072377-1472-46cb-b180-8542677f5eb2	1333.59	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1519	507	5432f125-2d5e-42ab-849a-29add2cf0a74	5704.79	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1520	507	5432f125-2d5e-42ab-849a-29add2cf0a74	4305.68	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1521	507	5432f125-2d5e-42ab-849a-29add2cf0a74	5813.90	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1522	508	a602c1a3-89cf-44a4-b419-f6827ad3701b	5464.34	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1523	508	a602c1a3-89cf-44a4-b419-f6827ad3701b	4321.17	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1524	508	a602c1a3-89cf-44a4-b419-f6827ad3701b	5969.21	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1525	509	51072377-1472-46cb-b180-8542677f5eb2	1411.61	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1526	509	51072377-1472-46cb-b180-8542677f5eb2	3984.10	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1527	509	51072377-1472-46cb-b180-8542677f5eb2	2029.86	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1528	510	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2066.88	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1529	510	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3254.97	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1530	510	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1219.83	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1531	511	77e168c1-05e0-4314-8a24-5e838350a3d8	3513.61	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1532	511	77e168c1-05e0-4314-8a24-5e838350a3d8	3938.73	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1533	511	77e168c1-05e0-4314-8a24-5e838350a3d8	4482.93	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1534	512	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5094.73	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1535	512	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4043.15	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1536	512	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3858.11	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1537	513	dbbbe49c-e100-4576-b406-320908c8873e	5465.47	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1538	513	dbbbe49c-e100-4576-b406-320908c8873e	4196.52	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1539	513	dbbbe49c-e100-4576-b406-320908c8873e	5104.44	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1540	514	a602c1a3-89cf-44a4-b419-f6827ad3701b	3072.77	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1541	514	a602c1a3-89cf-44a4-b419-f6827ad3701b	1560.73	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1542	514	a602c1a3-89cf-44a4-b419-f6827ad3701b	4001.06	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1543	515	8088628d-f77a-430d-b228-cc3649b8a3e1	3560.67	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1544	515	8088628d-f77a-430d-b228-cc3649b8a3e1	3318.94	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1545	515	8088628d-f77a-430d-b228-cc3649b8a3e1	5931.60	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1546	516	8088628d-f77a-430d-b228-cc3649b8a3e1	3633.15	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1547	516	8088628d-f77a-430d-b228-cc3649b8a3e1	2193.84	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1548	516	8088628d-f77a-430d-b228-cc3649b8a3e1	5645.69	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1549	517	dbbbe49c-e100-4576-b406-320908c8873e	1802.36	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1550	517	dbbbe49c-e100-4576-b406-320908c8873e	3429.94	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1551	517	dbbbe49c-e100-4576-b406-320908c8873e	3771.00	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1552	518	dde964d6-6ffa-4b25-97b6-128969afe47c	4958.17	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1553	518	dde964d6-6ffa-4b25-97b6-128969afe47c	5534.00	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1554	518	dde964d6-6ffa-4b25-97b6-128969afe47c	5736.23	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1555	519	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1314.37	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1556	519	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	2989.91	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1557	519	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5027.53	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1558	520	9255fabc-799b-4cc7-8797-5f2470f6adf6	1267.22	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1559	520	9255fabc-799b-4cc7-8797-5f2470f6adf6	4653.93	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1560	520	9255fabc-799b-4cc7-8797-5f2470f6adf6	4153.08	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1561	521	a602c1a3-89cf-44a4-b419-f6827ad3701b	1017.52	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1562	521	a602c1a3-89cf-44a4-b419-f6827ad3701b	1657.21	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1563	521	a602c1a3-89cf-44a4-b419-f6827ad3701b	1234.83	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1564	522	a602c1a3-89cf-44a4-b419-f6827ad3701b	1761.66	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1565	522	a602c1a3-89cf-44a4-b419-f6827ad3701b	3618.45	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1566	522	a602c1a3-89cf-44a4-b419-f6827ad3701b	2547.31	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1567	523	9255fabc-799b-4cc7-8797-5f2470f6adf6	2564.06	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1568	523	9255fabc-799b-4cc7-8797-5f2470f6adf6	4237.56	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1569	523	9255fabc-799b-4cc7-8797-5f2470f6adf6	4410.16	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1570	524	5432f125-2d5e-42ab-849a-29add2cf0a74	5664.03	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1571	524	5432f125-2d5e-42ab-849a-29add2cf0a74	3666.56	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1572	524	5432f125-2d5e-42ab-849a-29add2cf0a74	2169.06	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1573	525	77e168c1-05e0-4314-8a24-5e838350a3d8	5241.07	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1574	525	77e168c1-05e0-4314-8a24-5e838350a3d8	1270.57	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1575	525	77e168c1-05e0-4314-8a24-5e838350a3d8	3610.21	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1576	526	584a1909-5797-4297-88d3-06bf5dc3922a	1669.09	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1577	526	584a1909-5797-4297-88d3-06bf5dc3922a	4658.84	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1578	526	584a1909-5797-4297-88d3-06bf5dc3922a	2229.19	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1579	527	a602c1a3-89cf-44a4-b419-f6827ad3701b	4317.73	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1580	527	a602c1a3-89cf-44a4-b419-f6827ad3701b	5690.77	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1581	527	a602c1a3-89cf-44a4-b419-f6827ad3701b	5477.38	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1582	528	463737cc-950b-4a41-8d73-a3daf931fee5	4081.42	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1583	528	463737cc-950b-4a41-8d73-a3daf931fee5	1904.83	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1584	528	463737cc-950b-4a41-8d73-a3daf931fee5	2001.53	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1585	529	6ac1e176-e710-4b5e-9453-95765db20ba3	3737.89	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1586	529	6ac1e176-e710-4b5e-9453-95765db20ba3	1555.55	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1587	529	6ac1e176-e710-4b5e-9453-95765db20ba3	1090.31	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1588	530	ee522e07-1315-4463-8a9b-f890b601c047	5766.63	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1589	530	ee522e07-1315-4463-8a9b-f890b601c047	2160.48	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1590	530	ee522e07-1315-4463-8a9b-f890b601c047	1039.47	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1591	531	a83848ba-0779-4fac-98ee-f5f459b2742b	2533.71	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1592	531	a83848ba-0779-4fac-98ee-f5f459b2742b	4011.24	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1593	531	a83848ba-0779-4fac-98ee-f5f459b2742b	4323.07	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1594	532	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4171.59	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1595	532	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5911.07	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1596	532	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3592.62	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1597	533	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5998.29	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1598	533	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5774.85	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1599	533	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1795.23	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1600	534	8088628d-f77a-430d-b228-cc3649b8a3e1	3047.84	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1601	534	8088628d-f77a-430d-b228-cc3649b8a3e1	5550.78	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1602	534	8088628d-f77a-430d-b228-cc3649b8a3e1	1144.81	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1603	535	dd35da46-4416-412a-8a22-f3f39491bb7b	1478.55	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1604	535	dd35da46-4416-412a-8a22-f3f39491bb7b	5947.51	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1605	535	dd35da46-4416-412a-8a22-f3f39491bb7b	4618.76	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1606	536	a602c1a3-89cf-44a4-b419-f6827ad3701b	5275.74	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1607	536	a602c1a3-89cf-44a4-b419-f6827ad3701b	5674.44	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1608	536	a602c1a3-89cf-44a4-b419-f6827ad3701b	3198.55	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1609	537	ee522e07-1315-4463-8a9b-f890b601c047	2734.02	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1610	537	ee522e07-1315-4463-8a9b-f890b601c047	2715.61	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1611	537	ee522e07-1315-4463-8a9b-f890b601c047	2547.97	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1612	538	dde964d6-6ffa-4b25-97b6-128969afe47c	1046.93	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1613	538	dde964d6-6ffa-4b25-97b6-128969afe47c	3661.80	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1614	538	dde964d6-6ffa-4b25-97b6-128969afe47c	3116.78	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1615	539	dde964d6-6ffa-4b25-97b6-128969afe47c	3672.36	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1616	539	dde964d6-6ffa-4b25-97b6-128969afe47c	5890.94	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1617	539	dde964d6-6ffa-4b25-97b6-128969afe47c	2376.13	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1618	540	9255fabc-799b-4cc7-8797-5f2470f6adf6	1267.82	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1619	540	9255fabc-799b-4cc7-8797-5f2470f6adf6	1140.48	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1620	540	9255fabc-799b-4cc7-8797-5f2470f6adf6	3934.45	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1621	541	a602c1a3-89cf-44a4-b419-f6827ad3701b	5340.46	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1622	541	a602c1a3-89cf-44a4-b419-f6827ad3701b	1425.86	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1623	541	a602c1a3-89cf-44a4-b419-f6827ad3701b	1678.20	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1624	542	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	4131.84	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1625	542	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	4253.89	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1626	542	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3513.93	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1627	543	cff64755-2065-4e58-866f-f092cbd9e73b	1405.24	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1628	543	cff64755-2065-4e58-866f-f092cbd9e73b	1542.19	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1629	543	cff64755-2065-4e58-866f-f092cbd9e73b	5302.94	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1630	544	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5345.76	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1631	544	b1f5db31-bfc8-409c-8925-0d21f1c780e6	2561.16	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1632	544	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5900.66	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1633	545	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2490.82	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1634	545	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	4425.03	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1635	545	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2450.24	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1636	546	dbbbe49c-e100-4576-b406-320908c8873e	1908.95	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1637	546	dbbbe49c-e100-4576-b406-320908c8873e	4287.77	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1638	546	dbbbe49c-e100-4576-b406-320908c8873e	1937.28	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1639	547	463737cc-950b-4a41-8d73-a3daf931fee5	1162.43	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1640	547	463737cc-950b-4a41-8d73-a3daf931fee5	4526.89	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1641	547	463737cc-950b-4a41-8d73-a3daf931fee5	2942.16	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1642	548	dd35da46-4416-412a-8a22-f3f39491bb7b	5736.93	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1643	548	dd35da46-4416-412a-8a22-f3f39491bb7b	2454.52	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1644	548	dd35da46-4416-412a-8a22-f3f39491bb7b	4386.99	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1645	549	dd35da46-4416-412a-8a22-f3f39491bb7b	5722.70	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1646	549	dd35da46-4416-412a-8a22-f3f39491bb7b	5471.61	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1647	549	dd35da46-4416-412a-8a22-f3f39491bb7b	2212.59	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1648	550	51072377-1472-46cb-b180-8542677f5eb2	2890.70	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1649	550	51072377-1472-46cb-b180-8542677f5eb2	2450.10	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1650	550	51072377-1472-46cb-b180-8542677f5eb2	4458.10	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1651	551	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	3123.54	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1652	551	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	5401.80	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1653	551	bb519a2d-d8ce-4cdf-b87e-7d3b6315061b	2756.38	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1654	552	a83848ba-0779-4fac-98ee-f5f459b2742b	5091.40	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1655	552	a83848ba-0779-4fac-98ee-f5f459b2742b	5048.38	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1656	552	a83848ba-0779-4fac-98ee-f5f459b2742b	3793.73	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1657	553	1934abf8-eca9-41d8-bc5f-9c649285b76b	5695.25	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1658	553	1934abf8-eca9-41d8-bc5f-9c649285b76b	2094.71	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1659	553	1934abf8-eca9-41d8-bc5f-9c649285b76b	1360.50	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1660	554	dd35da46-4416-412a-8a22-f3f39491bb7b	2076.94	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1661	554	dd35da46-4416-412a-8a22-f3f39491bb7b	3590.81	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1662	554	dd35da46-4416-412a-8a22-f3f39491bb7b	2368.23	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1663	555	cff64755-2065-4e58-866f-f092cbd9e73b	2468.02	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1664	555	cff64755-2065-4e58-866f-f092cbd9e73b	2122.93	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1665	555	cff64755-2065-4e58-866f-f092cbd9e73b	2698.07	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1666	556	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	5346.83	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1667	556	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2352.68	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1668	556	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1079.30	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1669	557	da6ac18e-72e9-484a-ad75-d044260789cc	3657.44	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1670	557	da6ac18e-72e9-484a-ad75-d044260789cc	4634.07	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1671	557	da6ac18e-72e9-484a-ad75-d044260789cc	4634.67	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1672	558	6833f990-6a38-4f28-aa18-e31697fa7dc9	2884.94	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1673	558	6833f990-6a38-4f28-aa18-e31697fa7dc9	5479.94	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1674	558	6833f990-6a38-4f28-aa18-e31697fa7dc9	4455.63	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1675	559	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	2482.70	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1676	559	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	1880.69	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1677	559	e4bfe294-e6e5-4626-9f2a-969f2aa938c3	3974.74	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1678	560	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	1080.95	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1679	560	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	2818.54	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1680	560	ad0b7e41-18fc-4945-8aa9-6793788b0e7c	3993.09	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1681	561	da6ac18e-72e9-484a-ad75-d044260789cc	2810.74	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1682	561	da6ac18e-72e9-484a-ad75-d044260789cc	2062.58	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1683	561	da6ac18e-72e9-484a-ad75-d044260789cc	2679.38	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1684	562	51072377-1472-46cb-b180-8542677f5eb2	1399.21	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1685	562	51072377-1472-46cb-b180-8542677f5eb2	5385.05	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1686	562	51072377-1472-46cb-b180-8542677f5eb2	4932.06	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1687	563	6833f990-6a38-4f28-aa18-e31697fa7dc9	2021.69	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1688	563	6833f990-6a38-4f28-aa18-e31697fa7dc9	4605.61	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1689	563	6833f990-6a38-4f28-aa18-e31697fa7dc9	4488.62	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1690	564	dd35da46-4416-412a-8a22-f3f39491bb7b	2248.25	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1691	564	dd35da46-4416-412a-8a22-f3f39491bb7b	1361.36	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1692	564	dd35da46-4416-412a-8a22-f3f39491bb7b	3924.33	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1693	565	6833f990-6a38-4f28-aa18-e31697fa7dc9	4283.32	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1694	565	6833f990-6a38-4f28-aa18-e31697fa7dc9	2544.62	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1695	565	6833f990-6a38-4f28-aa18-e31697fa7dc9	4560.25	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1696	566	ee522e07-1315-4463-8a9b-f890b601c047	4498.11	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1697	566	ee522e07-1315-4463-8a9b-f890b601c047	3806.56	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1698	566	ee522e07-1315-4463-8a9b-f890b601c047	4553.09	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1699	567	1934abf8-eca9-41d8-bc5f-9c649285b76b	2557.85	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1700	567	1934abf8-eca9-41d8-bc5f-9c649285b76b	1154.05	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1701	567	1934abf8-eca9-41d8-bc5f-9c649285b76b	2436.09	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1702	568	a602c1a3-89cf-44a4-b419-f6827ad3701b	1492.71	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1703	568	a602c1a3-89cf-44a4-b419-f6827ad3701b	2917.62	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1704	568	a602c1a3-89cf-44a4-b419-f6827ad3701b	3100.57	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1705	569	b794e95a-97f4-4c05-aa2d-3c13c4155841	4731.76	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1706	569	b794e95a-97f4-4c05-aa2d-3c13c4155841	5739.08	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1707	569	b794e95a-97f4-4c05-aa2d-3c13c4155841	5376.49	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1708	570	9255fabc-799b-4cc7-8797-5f2470f6adf6	3217.01	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1709	570	9255fabc-799b-4cc7-8797-5f2470f6adf6	5570.85	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1710	570	9255fabc-799b-4cc7-8797-5f2470f6adf6	2526.62	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1711	571	463737cc-950b-4a41-8d73-a3daf931fee5	4300.36	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1712	571	463737cc-950b-4a41-8d73-a3daf931fee5	4361.86	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1713	571	463737cc-950b-4a41-8d73-a3daf931fee5	4121.91	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1714	572	387d98f7-ccf9-4077-8f79-f0be51c40d05	3177.58	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1715	572	387d98f7-ccf9-4077-8f79-f0be51c40d05	4320.15	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1716	572	387d98f7-ccf9-4077-8f79-f0be51c40d05	5825.04	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1717	573	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5224.51	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1718	573	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1910.44	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1719	573	5bf27593-0c3d-489f-bed4-c80dc2936fdf	1188.49	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1720	574	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	4304.27	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1721	574	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5248.85	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1722	574	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	1741.20	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1723	575	ee522e07-1315-4463-8a9b-f890b601c047	5477.03	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1724	575	ee522e07-1315-4463-8a9b-f890b601c047	1100.03	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1725	575	ee522e07-1315-4463-8a9b-f890b601c047	2506.24	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1726	576	a83848ba-0779-4fac-98ee-f5f459b2742b	1763.15	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1727	576	a83848ba-0779-4fac-98ee-f5f459b2742b	5409.82	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1728	576	a83848ba-0779-4fac-98ee-f5f459b2742b	5853.62	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1729	577	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3684.98	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1730	577	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3611.40	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1731	577	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5621.30	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1732	578	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5228.33	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1733	578	fd99f59b-fcc6-42ef-a407-207f110f2d7b	5239.01	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1734	578	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3421.30	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1735	579	5bf27593-0c3d-489f-bed4-c80dc2936fdf	2030.85	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1736	579	5bf27593-0c3d-489f-bed4-c80dc2936fdf	5886.71	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1737	579	5bf27593-0c3d-489f-bed4-c80dc2936fdf	4591.76	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1738	580	fd99f59b-fcc6-42ef-a407-207f110f2d7b	4360.59	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1739	580	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3811.16	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1740	580	fd99f59b-fcc6-42ef-a407-207f110f2d7b	1234.72	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1741	581	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5411.65	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1742	581	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5031.75	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1743	581	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3063.57	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1744	582	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5801.03	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1745	582	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	5427.31	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1746	582	ea3a5bea-7de6-4fd6-b6e6-31d11aed3231	3317.81	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1747	583	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3645.22	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1748	583	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2773.95	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1749	583	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2516.37	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1750	584	a83848ba-0779-4fac-98ee-f5f459b2742b	3815.74	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1751	584	a83848ba-0779-4fac-98ee-f5f459b2742b	5692.72	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1752	584	a83848ba-0779-4fac-98ee-f5f459b2742b	1597.51	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1753	585	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2462.91	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1754	585	fd99f59b-fcc6-42ef-a407-207f110f2d7b	3351.10	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1755	585	fd99f59b-fcc6-42ef-a407-207f110f2d7b	2805.86	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1756	586	51072377-1472-46cb-b180-8542677f5eb2	5404.77	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1757	586	51072377-1472-46cb-b180-8542677f5eb2	1420.99	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1758	586	51072377-1472-46cb-b180-8542677f5eb2	3735.40	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1759	587	9255fabc-799b-4cc7-8797-5f2470f6adf6	3111.82	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1760	587	9255fabc-799b-4cc7-8797-5f2470f6adf6	3214.45	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1761	587	9255fabc-799b-4cc7-8797-5f2470f6adf6	5748.84	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1762	588	dd35da46-4416-412a-8a22-f3f39491bb7b	5698.35	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1763	588	dd35da46-4416-412a-8a22-f3f39491bb7b	2632.64	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1764	588	dd35da46-4416-412a-8a22-f3f39491bb7b	3758.02	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1765	589	dbbbe49c-e100-4576-b406-320908c8873e	4888.46	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1766	589	dbbbe49c-e100-4576-b406-320908c8873e	1989.91	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1767	589	dbbbe49c-e100-4576-b406-320908c8873e	5099.28	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1768	590	a602c1a3-89cf-44a4-b419-f6827ad3701b	5659.64	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1769	590	a602c1a3-89cf-44a4-b419-f6827ad3701b	5884.23	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1770	590	a602c1a3-89cf-44a4-b419-f6827ad3701b	3159.66	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1771	591	dd35da46-4416-412a-8a22-f3f39491bb7b	5203.67	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1772	591	dd35da46-4416-412a-8a22-f3f39491bb7b	5807.02	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1773	591	dd35da46-4416-412a-8a22-f3f39491bb7b	2282.70	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1774	592	da6ac18e-72e9-484a-ad75-d044260789cc	5776.66	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1775	592	da6ac18e-72e9-484a-ad75-d044260789cc	1887.87	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1776	592	da6ac18e-72e9-484a-ad75-d044260789cc	1249.13	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1777	593	dbbbe49c-e100-4576-b406-320908c8873e	2229.97	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1778	593	dbbbe49c-e100-4576-b406-320908c8873e	1806.13	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1779	593	dbbbe49c-e100-4576-b406-320908c8873e	3171.84	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1780	594	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	1316.04	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1781	594	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5749.76	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1782	594	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	4304.05	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1783	595	584a1909-5797-4297-88d3-06bf5dc3922a	4130.52	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1784	595	584a1909-5797-4297-88d3-06bf5dc3922a	5686.49	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1785	595	584a1909-5797-4297-88d3-06bf5dc3922a	2783.71	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1786	596	b1f5db31-bfc8-409c-8925-0d21f1c780e6	3929.55	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1787	596	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5155.96	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1788	596	b1f5db31-bfc8-409c-8925-0d21f1c780e6	5265.50	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1789	597	463737cc-950b-4a41-8d73-a3daf931fee5	3533.60	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1790	597	463737cc-950b-4a41-8d73-a3daf931fee5	4232.75	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1791	597	463737cc-950b-4a41-8d73-a3daf931fee5	3700.51	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1792	598	fc7c7272-6d55-49a3-88d7-fc37133a103f	1298.63	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1793	598	fc7c7272-6d55-49a3-88d7-fc37133a103f	1590.68	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1794	598	fc7c7272-6d55-49a3-88d7-fc37133a103f	5801.70	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1795	599	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5580.29	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1796	599	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	5320.74	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1797	599	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	3464.73	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1798	600	a602c1a3-89cf-44a4-b419-f6827ad3701b	5582.50	2023-01-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1799	600	a602c1a3-89cf-44a4-b419-f6827ad3701b	3516.53	2023-02-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1800	600	a602c1a3-89cf-44a4-b419-f6827ad3701b	1222.28	2023-03-01 00:00:00+00	online	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1801	601	a83848ba-0779-4fac-98ee-f5f459b2742b	2111.00	2025-02-06 00:00:00+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1802	602	51072377-1472-46cb-b180-8542677f5eb2	20102.00	2025-02-05 00:00:00+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1803	603	dd35da46-4416-412a-8a22-f3f39491bb7b	1999.00	2025-02-06 00:00:00+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1804	550	dd35da46-4416-412a-8a22-f3f39491bb7b	2011.00	2025-02-09 00:00:00+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1805	604	dd35da46-4416-412a-8a22-f3f39491bb7b	9191.00	2025-02-04 00:00:00+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1806	602	dd35da46-4416-412a-8a22-f3f39491bb7b	29191.00	2025-02-06 00:00:00+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1807	603	dd35da46-4416-412a-8a22-f3f39491bb7b	2211.00	2025-02-12 00:00:00+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1808	605	dd35da46-4416-412a-8a22-f3f39491bb7b	2919.00	2025-02-08 00:00:00+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1809	605	dd35da46-4416-412a-8a22-f3f39491bb7b	22111.00	2025-02-08 00:00:00+00	offline	completed	faafafaa	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1810	605	dd35da46-4416-412a-8a22-f3f39491bb7b	22112.00	2025-02-09 00:00:00+00	offline	completed	JEJE BONEL	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1811	605	dd35da46-4416-412a-8a22-f3f39491bb7b	22211.00	2025-02-08 00:00:00+00	offline	completed	yeboa	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1812	605	dd35da46-4416-412a-8a22-f3f39491bb7b	91911.00	2025-02-07 00:00:00+00	offline	completed	fafafafafffff	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1813	605	dd35da46-4416-412a-8a22-f3f39491bb7b	29112.00	2025-02-07 00:00:00+00	offline	completed	faffa llkk	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1814	605	dd35da46-4416-412a-8a22-f3f39491bb7b	1288.00	2025-02-08 00:00:00+00	offline	completed	kkeee	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1815	605	dd35da46-4416-412a-8a22-f3f39491bb7b	22112.00	2025-02-08 00:00:00+00	offline	completed	aaaaaaa	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1816	605	dd35da46-4416-412a-8a22-f3f39491bb7b	1122.00	2025-02-08 00:00:00+00	offline	completed	ffaaaffffff	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1817	605	dd35da46-4416-412a-8a22-f3f39491bb7b	9999.00	2025-02-08 00:00:00+00	offline	completed	fafffffffaaxxx	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1818	605	dd35da46-4416-412a-8a22-f3f39491bb7b	3333.00	2025-02-05 00:00:00+00	offline	completed	faffaaa	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1819	605	dd35da46-4416-412a-8a22-f3f39491bb7b	55555.00	2025-02-08 00:00:00+00	offline	completed	fa44114141	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1820	605	dd35da46-4416-412a-8a22-f3f39491bb7b	22114.00	2025-02-08 00:00:00+00	offline	completed	fafafaaff1212314	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1821	602	dd35da46-4416-412a-8a22-f3f39491bb7b	2477.00	2025-02-05 00:00:00+00	offline	completed	fafafff	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1822	603	dd35da46-4416-412a-8a22-f3f39491bb7b	2000.00	2025-02-12 10:01:31.167+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1823	88	dd35da46-4416-412a-8a22-f3f39491bb7b	1000.00	2025-02-12 10:01:31.167+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1824	185	dd35da46-4416-412a-8a22-f3f39491bb7b	6000.00	2025-02-12 10:01:31.167+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1825	54	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2222.00	2025-02-12 15:47:22.146+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1826	144	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	22222.00	2025-02-12 15:47:29.452+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1827	118	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	22222.00	2025-02-12 15:48:20.289+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1828	144	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	22222.00	2025-02-12 15:48:20.289+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1829	118	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	3131.00	2025-02-12 15:48:20.289+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1830	144	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	22222.00	2025-02-12 15:48:50.844+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1831	604	dd35da46-4416-412a-8a22-f3f39491bb7b	2000.00	2025-02-17 07:11:33.548+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1832	604	dd35da46-4416-412a-8a22-f3f39491bb7b	2000.00	2025-02-17 07:12:21.911+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1833	602	dd35da46-4416-412a-8a22-f3f39491bb7b	2000.00	2025-02-17 07:12:21.911+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1834	605	dd35da46-4416-412a-8a22-f3f39491bb7b	5000.00	2025-02-17 07:12:21.911+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1835	1	dd35da46-4416-412a-8a22-f3f39491bb7b	1000.00	2025-02-17 09:12:19.056+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1836	648	dd35da46-4416-412a-8a22-f3f39491bb7b	1000.00	2025-02-17 09:12:19.056+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1837	649	dd35da46-4416-412a-8a22-f3f39491bb7b	9000.00	2025-02-17 09:14:11.609+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1838	649	dd35da46-4416-412a-8a22-f3f39491bb7b	2000.00	2025-02-17 09:18:28.271+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1839	602	dd35da46-4416-412a-8a22-f3f39491bb7b	5000.00	2025-02-17 09:18:28.271+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1840	605	dd35da46-4416-412a-8a22-f3f39491bb7b	3000.00	2025-02-17 09:18:28.271+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1841	1	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	1000.00	2025-02-19 15:53:07.55+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1842	602	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	4000.00	2025-02-19 15:53:07.55+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1843	605	aefe15fe-4937-4f55-a6cb-fb8d739c5905	10000.00	2025-02-19 15:57:42.741+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1874	605	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	20000.00	2025-02-20 00:00:00+00	offline	completed	Dami pera boss	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	\N	\N	\N	\N	\N	\N	\N	\N	\N
1875	602	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	15000.00	2025-02-20 00:00:00+00	offline	completed	yebah	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	\N	\N	\N	\N	\N	\N	\N	\N	\N
1876	605	aefe15fe-4937-4f55-a6cb-fb8d739c5905	13000.00	2025-02-20 00:00:00+00	offline	completed	bonus	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	\N	\N	\N	\N	\N	\N	\N	\N	\N
1877	605	aefe15fe-4937-4f55-a6cb-fb8d739c5905	10000.00	2025-02-27 00:00:00+00	offline	completed	benggbeng	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	\N	\N	\N	\N	\N	\N	\N	\N	\N
1878	605	aefe15fe-4937-4f55-a6cb-fb8d739c5905	5000.00	2025-02-20 00:00:00+00	offline	completed	fafaff	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	\N	\N	\N	\N	\N	\N	\N	\N	\N
1879	650	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	20000.00	2025-02-21 00:00:00+00	offline	completed	ghahhh	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1880	651	aefe15fe-4937-4f55-a6cb-fb8d739c5905	20000.00	2025-02-20 00:00:00+00	offline	completed	fga12234	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1886	605	ee522e07-1315-4463-8a9b-f890b601c047	31414.00	2025-02-20 00:00:00+00	offline	completed	fdfasdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1892	605	d7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96	2222.00	2025-02-20 00:00:00+00	offline	completed		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1893	2	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	241.00	2025-02-20 00:00:00+00	offline	completed		f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	\N	\N	\N	\N	\N	\N	\N	\N	\N
1894	21	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	21455.00	2025-02-20 00:00:00+00	offline	completed		f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	\N	\N	\N	\N	\N	\N	\N	\N	\N
1895	12	aefe15fe-4937-4f55-a6cb-fb8d739c5905	44114.00	2025-02-20 00:00:00+00	offline	completed	hhhhhh	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	\N	\N	\N	\N	\N	\N	\N	\N	\N
1897	651	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	5000.00	2025-02-20 08:14:21.416+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1898	652	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	5000.00	2025-02-20 08:14:21.416+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1947	605	aefe15fe-4937-4f55-a6cb-fb8d739c5905	5155.00	2025-02-26 09:54:06.441+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1949	670	aefe15fe-4937-4f55-a6cb-fb8d739c5905	2000.00	2025-02-26 09:55:16.318+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1955	605	aefe15fe-4937-4f55-a6cb-fb8d739c5905	2000.00	2025-02-26 10:08:37.99+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1956	670	aefe15fe-4937-4f55-a6cb-fb8d739c5905	2000.00	2025-02-26 10:08:37.99+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1958	605	aefe15fe-4937-4f55-a6cb-fb8d739c5905	999.00	2025-02-26 10:10:41.611+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1960	651	aefe15fe-4937-4f55-a6cb-fb8d739c5905	1.00	2025-02-26 10:10:41.611+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1962	605	aefe15fe-4937-4f55-a6cb-fb8d739c5905	9100.00	2025-02-26 10:11:43.857+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1964	651	aefe15fe-4937-4f55-a6cb-fb8d739c5905	91.00	2025-02-26 10:11:43.857+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1966	605	aefe15fe-4937-4f55-a6cb-fb8d739c5905	1000.00	2025-02-26 10:12:58.262+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1968	673	aefe15fe-4937-4f55-a6cb-fb8d739c5905	4000.00	2025-02-26 10:12:58.262+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1975	674	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	2012.00	2025-02-26 00:00:00+00	offline	completed	\N	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	\N	\N	\N	\N	\N	\N	\N	\N	\N
1984	673	aefe15fe-4937-4f55-a6cb-fb8d739c5905	999.00	2025-02-26 10:37:49.468+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1986	602	aefe15fe-4937-4f55-a6cb-fb8d739c5905	1001.00	2025-02-26 10:37:49.468+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1996	602	aefe15fe-4937-4f55-a6cb-fb8d739c5905	1000.00	2025-02-26 15:01:34.997+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1998	602	aefe15fe-4937-4f55-a6cb-fb8d739c5905	1093.00	2025-02-26 15:01:53.282+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2000	602	aefe15fe-4937-4f55-a6cb-fb8d739c5905	1093.00	2025-02-26 15:03:28.135+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2002	602	aefe15fe-4937-4f55-a6cb-fb8d739c5905	10991.00	2025-02-26 15:03:32.229+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2008	602	aefe15fe-4937-4f55-a6cb-fb8d739c5905	50.00	2025-02-26 15:10:12.958+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2010	602	aefe15fe-4937-4f55-a6cb-fb8d739c5905	51.00	2025-02-26 15:10:39.207+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2015	673	aefe15fe-4937-4f55-a6cb-fb8d739c5905	80.00	2025-02-26 15:14:21.358+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2017	680	aefe15fe-4937-4f55-a6cb-fb8d739c5905	303.00	2025-02-26 15:17:03.041+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2019	681	aefe15fe-4937-4f55-a6cb-fb8d739c5905	32.00	2025-02-26 15:24:24.863+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2021	682	aefe15fe-4937-4f55-a6cb-fb8d739c5905	34.00	2025-02-26 15:24:24.863+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2023	683	aefe15fe-4937-4f55-a6cb-fb8d739c5905	80.00	2025-02-26 15:27:34.378+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2025	684	aefe15fe-4937-4f55-a6cb-fb8d739c5905	20.00	2025-02-26 15:27:34.378+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2027	685	aefe15fe-4937-4f55-a6cb-fb8d739c5905	11.00	2025-02-26 15:36:39.794+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2029	686	aefe15fe-4937-4f55-a6cb-fb8d739c5905	11.00	2025-02-26 15:36:39.794+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2031	687	aefe15fe-4937-4f55-a6cb-fb8d739c5905	34.00	2025-02-26 15:51:57.078+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2033	673	aefe15fe-4937-4f55-a6cb-fb8d739c5905	300.00	2025-02-26 15:51:57.078+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2035	688	aefe15fe-4937-4f55-a6cb-fb8d739c5905	54.00	2025-02-26 00:00:00+00	offline	completed	tteeaa	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2041	44	1dcfd06d-826c-4c00-a64c-c2eabe1abfbd	424.00	2025-02-26 16:11:55.619+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2043	689	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	441.00	2025-02-26 16:16:07.679+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2045	615	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	444.00	2025-02-26 16:16:44.353+00	offline	completed	45511	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2047	605	aefe15fe-4937-4f55-a6cb-fb8d739c5905	224.00	2025-02-26 16:17:16.742+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2049	603	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	551.00	2025-02-26 16:17:42.254+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2051	603	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	5111.00	2025-02-26 16:20:04.973+00	offline	completed	\N	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	\N	\N	\N	\N	\N	\N	\N	\N	\N
2053	604	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	9954.00	2025-02-26 16:24:48.653+00	offline	completed	\N	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	\N	\N	\N	\N	\N	\N	\N	\N	\N
2055	690	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	1.00	2025-02-26 16:24:48.653+00	offline	completed	\N	f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4	\N	\N	\N	\N	\N	\N	\N	\N	\N
2057	602	aefe15fe-4937-4f55-a6cb-fb8d739c5905	20040.00	2025-02-26 16:26:54.366+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2062	615	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	20.00	2025-02-27 08:28:09.264+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2068	691	aefe15fe-4937-4f55-a6cb-fb8d739c5905	700.00	2025-02-27 08:34:43.992+00	online	completed	\N	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	df950c1d-a63b-4100-b525-af14ace15822	\N	\N	\N	\N	\N	\N	\N	\N
2069	691	aefe15fe-4937-4f55-a6cb-fb8d739c5905	700.00	2025-02-27 08:36:37.846+00	online	completed	\N	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	815d3d3c-6ca7-4701-84d8-720d15175a4d	\N	\N	\N	\N	\N	\N	\N	\N
2070	691	aefe15fe-4937-4f55-a6cb-fb8d739c5905	700.00	2025-02-27 08:39:05.243+00	online	completed	\N	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	0783ca3a-059e-48fa-99a0-48d109f49d2d	\N	\N	\N	\N	\N	\N	\N	\N
2071	691	aefe15fe-4937-4f55-a6cb-fb8d739c5905	1000.00	2025-02-27 08:39:12.085+00	online	completed	\N	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	d418339b-1a13-45b3-9ece-27271078c851	\N	\N	\N	\N	\N	\N	\N	\N
2072	691	aefe15fe-4937-4f55-a6cb-fb8d739c5905	1000.00	2025-02-27 08:39:35.16+00	online	completed	\N	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	992a3de5-e58a-4d8d-9fb8-c7b9b18406e7	\N	\N	\N	\N	\N	\N	\N	\N
2073	691	aefe15fe-4937-4f55-a6cb-fb8d739c5905	333.00	2025-02-27 08:40:04.629+00	online	completed	\N	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	7bd55e50-82ae-4ec2-8e0d-181d2ef13cd7	\N	\N	\N	\N	\N	\N	\N	\N
2074	691	aefe15fe-4937-4f55-a6cb-fb8d739c5905	333.00	2025-02-27 08:44:40.327+00	online	completed	\N	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	8587476b-79c9-4655-9908-da0d0f088cb2	\N	\N	\N	\N	\N	\N	\N	\N
2075	691	aefe15fe-4937-4f55-a6cb-fb8d739c5905	333.00	2025-02-27 08:48:36.005+00	online	completed	\N	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	9541271d-f81e-46ca-b942-b5b6dac4814d	\N	\N	\N	\N	\N	\N	\N	\N
2076	691	aefe15fe-4937-4f55-a6cb-fb8d739c5905	333.00	2025-02-27 08:48:45.072+00	online	completed	\N	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2bfde88f-61b7-4caf-a7bd-6eb85d5c042c	\N	\N	\N	\N	\N	\N	\N	\N
2077	691	aefe15fe-4937-4f55-a6cb-fb8d739c5905	333.00	2025-02-27 08:49:36.783+00	online	completed	\N	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	7031047d-258f-4808-9865-f0c2345cf2f7	\N	\N	\N	\N	\N	\N	\N	\N
2078	691	aefe15fe-4937-4f55-a6cb-fb8d739c5905	333.00	2025-02-27 08:51:15.924+00	online	completed	\N	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	27cc153f-2728-47d3-bf3d-55076cf2c176	\N	\N	\N	\N	\N	\N	\N	\N
2079	691	aefe15fe-4937-4f55-a6cb-fb8d739c5905	444.00	2025-02-27 08:52:44.155+00	online	completed	\N	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	397584c4-0ef1-4d90-b853-cd16bea4c268	\N	\N	\N	\N	\N	\N	\N	\N
2080	691	aefe15fe-4937-4f55-a6cb-fb8d739c5905	4445.00	2025-02-27 08:56:59.206+00	online	completed	\N	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	f5bf0c0a-6c04-4b99-a717-c5b87d71aeb0	\N	\N	\N	\N	\N	\N	\N	\N
2083	692	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	414.00	2025-02-27 09:14:08.075+00	offline	completed	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2085	693	aefe15fe-4937-4f55-a6cb-fb8d739c5905	4444.00	2025-02-27 10:47:04.04+00	online	completed	Payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2086	694	aefe15fe-4937-4f55-a6cb-fb8d739c5905	9898.00	2025-02-27 15:16:37.575+00	online	completed	Payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2087	695	aefe15fe-4937-4f55-a6cb-fb8d739c5905	3233.00	2025-02-27 15:39:01.153+00	online	completed	Payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2089	673	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	124.00	2025-02-27 15:54:08.993+00	offline	completed	\N	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	\N	\N	\N	\N	\N	\N	\N	\N	\N
2091	673	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	2000.00	2025-02-27 16:17:28.777+00	offline	completed	\N	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	\N	\N	\N	\N	\N	\N	\N	\N	\N
2092	695	aefe15fe-4937-4f55-a6cb-fb8d739c5905	4411.00	2025-02-27 16:52:44.293+00	online	completed	Payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2093	673	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	2000.00	2025-02-27 17:45:47.626+00	online	completed	Bulk payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2094	673	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	1000.00	2025-02-27 18:02:49.46+00	online	completed	Bulk payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2095	604	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	200.00	2025-02-27 18:02:49.484+00	online	completed	Bulk payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2096	604	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	800.00	2025-02-27 18:23:31.887+00	online	completed	Bulk payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2097	605	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	1200.00	2025-02-27 18:23:31.91+00	online	completed	Bulk payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2098	702	aefe15fe-4937-4f55-a6cb-fb8d739c5905	2223.00	2025-02-28 02:01:21.387+00	online	completed	Payment via RETAIL_OUTLET (CEBUANA)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2099	673	aefe15fe-4937-4f55-a6cb-fb8d739c5905	2000.00	2025-02-28 02:10:17.918+00	online	completed	Bulk payment via RETAIL_OUTLET (CEBUANA)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2100	673	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	20001.00	2025-02-28 02:13:49.84+00	online	completed	Bulk payment via RETAIL_OUTLET (CEBUANA)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2101	700	aefe15fe-4937-4f55-a6cb-fb8d739c5905	9199.00	2025-02-28 02:28:49.628+00	online	completed	Payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2102	673	aefe15fe-4937-4f55-a6cb-fb8d739c5905	1111.00	2025-02-28 02:42:39.561+00	online	completed	Bulk payment via RETAIL_OUTLET (7ELEVEN)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2103	702	aefe15fe-4937-4f55-a6cb-fb8d739c5905	22122.00	2025-02-28 03:12:48.441+00	online	completed	Payment via RETAIL_OUTLET (7ELEVEN)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2104	673	aefe15fe-4937-4f55-a6cb-fb8d739c5905	1111.00	2025-02-28 03:13:22.716+00	online	completed	Bulk payment via RETAIL_OUTLET (7ELEVEN)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2105	673	aefe15fe-4937-4f55-a6cb-fb8d739c5905	21212.00	2025-02-28 03:14:42.678+00	online	completed	Bulk payment via RETAIL_OUTLET (7ELEVEN)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2106	702	aefe15fe-4937-4f55-a6cb-fb8d739c5905	12122.00	2025-02-28 03:15:23.341+00	online	completed	Payment via RETAIL_OUTLET (DP_ECPAY_LOAN)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2107	702	aefe15fe-4937-4f55-a6cb-fb8d739c5905	32122.00	2025-02-28 03:22:57.601+00	online	completed	Payment via RETAIL_OUTLET (DP_ECPAY_LOAN)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2108	673	aefe15fe-4937-4f55-a6cb-fb8d739c5905	1122.00	2025-02-28 03:22:59.029+00	online	completed	Bulk payment via RETAIL_OUTLET (7ELEVEN)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2109	673	aefe15fe-4937-4f55-a6cb-fb8d739c5905	2000.00	2025-02-28 03:32:12.259+00	online	completed	Bulk payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2110	673	aefe15fe-4937-4f55-a6cb-fb8d739c5905	22213.00	2025-02-28 03:37:18.813+00	online	completed	Bulk payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2111	673	aefe15fe-4937-4f55-a6cb-fb8d739c5905	112.00	2025-02-28 03:42:44.833+00	online	completed	Bulk payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2112	673	aefe15fe-4937-4f55-a6cb-fb8d739c5905	9119.00	2025-02-28 03:46:37.204+00	online	completed	Bulk payment via RETAIL_OUTLET (7ELEVEN)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2113	673	aefe15fe-4937-4f55-a6cb-fb8d739c5905	1122.00	2025-02-28 03:49:53.727+00	online	completed	Bulk payment via RETAIL_OUTLET (CEBUANA)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2114	604	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	11231.00	2025-02-28 03:52:23.04+00	online	completed	Bulk payment via RETAIL_OUTLET (DP_MLHUILLIER)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2115	604	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	9109.00	2025-02-28 03:55:42.441+00	online	completed	Bulk payment via RETAIL_OUTLET (DP_ECPAY_LOAN)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2116	673	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	2131.00	2025-02-28 05:51:55.971+00	online	completed	Bulk payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2117	722	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	909.00	2025-02-28 06:42:48.068+00	online	completed	Bulk payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2118	673	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	999.00	2025-02-28 06:43:30.108+00	online	completed	Bulk payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2119	723	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	8100.00	2025-02-28 06:43:30.132+00	online	completed	Bulk payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2120	702	aefe15fe-4937-4f55-a6cb-fb8d739c5905	32122.00	2025-02-28 06:57:26.49+00	online	completed	Payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2121	673	aefe15fe-4937-4f55-a6cb-fb8d739c5905	9999.00	2025-02-28 06:59:13.638+00	online	completed	Bulk payment via EWALLET (GCASH)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2122	702	aefe15fe-4937-4f55-a6cb-fb8d739c5905	9898.00	2025-02-28 07:08:18.801+00	online	completed	Payment via EWALLET (GRABPAY)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: payment_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_transactions (id, reference_id, invoice_id, invoice_url, status, amount, fee_amount, currency, payment_method, payment_channel, payment_details, payer_email, payer_name, created_by, created_at, updated_at, expires_at, paid_at) FROM stdin;
38156439-06e7-4fdb-96e0-5f9efccf6a90	donation_4355f932-c7d3-4fff-a7f0-32d00378baa3	\N	\N	PENDING	9000.00	\N	PHP	\N	\N	\N	john@gmai.com	John Doe	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	2025-02-27 04:10:36.033484+00	2025-02-27 04:10:36.033484+00	\N	\N
b6328554-d606-4ac6-9b72-9d134003b060	m_Uhe9mUoHrL	\N	\N	pending	500.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:21:29.348422+00	2025-02-27 08:21:29.348422+00	\N	\N
935744d0-641f-4163-bb19-c0b7637adc89	m_p90I1g7RMV	\N	\N	pending	500.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:22:10.717489+00	2025-02-27 08:22:10.717489+00	\N	\N
23df9e07-4bb5-4f46-8751-84b5add84eab	m_LosdFoYbJq	\N	\N	pending	500.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:23:56.058418+00	2025-02-27 08:23:56.058418+00	\N	\N
9eb311e4-59e3-4c75-88fc-f6ffebc630c0	m_vyI3wCpel2	\N	\N	pending	500.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:25:29.816754+00	2025-02-27 08:25:29.816754+00	\N	\N
b6abd5e3-4acf-49cc-9b05-c825c80e7704	m_bKDKyBpyUc	\N	\N	pending	600.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:26:25.420168+00	2025-02-27 08:26:25.420168+00	\N	\N
eaa2335b-636d-4e67-b0da-c8877282bf19	m_OqhCsLDUgk	\N	\N	pending	600.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:28:43.9479+00	2025-02-27 08:28:43.9479+00	\N	\N
e975facc-31df-4e85-8f69-be8e102387de	m_XQpqGu6HPt	\N	\N	pending	700.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:28:57.783136+00	2025-02-27 08:28:57.783136+00	\N	\N
6cbc93be-2f5f-4eb9-8a4a-00ab36868520	m_lEjbPPEoOy	\N	\N	pending	700.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:30:33.179225+00	2025-02-27 08:30:33.179225+00	\N	\N
312ebc13-22ad-43a0-83e1-8947dc252fda	m_uWWMD8U8Kv	\N	\N	pending	700.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:32:45.339894+00	2025-02-27 08:32:45.339894+00	\N	\N
120d74da-ba1f-44e1-a782-790e54f84f8a	m_qUjCUES7Bd	\N	\N	pending	700.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:32:47.529601+00	2025-02-27 08:32:47.529601+00	\N	\N
df950c1d-a63b-4100-b525-af14ace15822	m_F6I9pBLHH6	\N	\N	pending	700.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:34:43.942078+00	2025-02-27 08:34:43.942078+00	\N	\N
815d3d3c-6ca7-4701-84d8-720d15175a4d	m_8Qywv-EDRz	\N	\N	pending	700.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:36:37.840107+00	2025-02-27 08:36:37.840107+00	\N	\N
0783ca3a-059e-48fa-99a0-48d109f49d2d	m_W8Y6NV5gvp	\N	\N	pending	700.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:39:05.238575+00	2025-02-27 08:39:05.238575+00	\N	\N
d418339b-1a13-45b3-9ece-27271078c851	m_JwNltNU7VI	\N	\N	pending	1000.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:39:12.081264+00	2025-02-27 08:39:12.081264+00	\N	\N
992a3de5-e58a-4d8d-9fb8-c7b9b18406e7	m_Qk6aKd-Xo9	\N	\N	pending	1000.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:39:35.154225+00	2025-02-27 08:39:35.154225+00	\N	\N
7bd55e50-82ae-4ec2-8e0d-181d2ef13cd7	m_ZYAh95h_Q_	\N	\N	pending	333.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:40:04.62498+00	2025-02-27 08:40:04.62498+00	\N	\N
8587476b-79c9-4655-9908-da0d0f088cb2	m_cSCI1fynaW	\N	\N	pending	333.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:44:40.320424+00	2025-02-27 08:44:40.320424+00	\N	\N
9541271d-f81e-46ca-b942-b5b6dac4814d	m_hU8J_GeMW_	\N	\N	pending	333.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:48:36.00016+00	2025-02-27 08:48:36.00016+00	\N	\N
2bfde88f-61b7-4caf-a7bd-6eb85d5c042c	m_8_IEbJKi30	\N	\N	pending	333.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:48:45.067434+00	2025-02-27 08:48:45.067434+00	\N	\N
7031047d-258f-4808-9865-f0c2345cf2f7	m_5vonmz-KCB	\N	\N	pending	333.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:49:36.777765+00	2025-02-27 08:49:36.777765+00	\N	\N
830d1872-0f68-4f8e-bec6-427ae7824cc7	m_kdWAKYew6V	67c11b70604981230e958621	https://checkout-staging.xendit.co/web/67c11b70604981230e958621	pending	2012.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:11:59.314Z", "donors": [{"amount": 2012, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:11:59.324336+00	2025-02-28 02:11:59.324336+00	2025-03-01 02:12:00.181+00	\N
27cc153f-2728-47d3-bf3d-55076cf2c176	m_qAJQLiCSdV	67c02784e1222084dfa646ad	https://checkout-staging.xendit.co/web/67c02784e1222084dfa646ad	pending	333.00	\N	PHP	\N	\N	\N	test@example.com	Test Donor	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:51:15.918514+00	2025-02-27 08:51:15.918514+00	2025-02-28 08:51:21.818+00	\N
397584c4-0ef1-4d90-b853-cd16bea4c268	m_NsRJ8OPzfc	67c027dc604981fffb93afb3	https://checkout-staging.xendit.co/web/67c027dc604981fffb93afb3	pending	444.00	\N	PHP	\N	\N	\N	test@example.com	Test Donorzz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:52:44.15016+00	2025-02-27 08:52:44.15016+00	2025-02-28 08:52:44.735+00	\N
f5bf0c0a-6c04-4b99-a717-c5b87d71aeb0	m_u6Y5CUETQA	67c028dbe12220150ca649c5	https://checkout-staging.xendit.co/web/67c028dbe12220150ca649c5	pending	4445.00	\N	PHP	\N	\N	\N	test@example.com	Test Donorzzz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 08:56:59.200836+00	2025-02-27 08:56:59.200836+00	2025-02-28 08:56:59.761+00	\N
4c03ab62-b48e-49b1-b906-af9e32635845	m_lGYaJDkXLw	\N	\N	pending	44445.00	\N	PHP	\N	\N	\N	test@example.com	Test Donorzzz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 09:01:43.47807+00	2025-02-27 09:01:43.47807+00	\N	\N
eebf8be5-0036-43ba-9bd7-9e6652c46a5d	m_uNGkYzaK4x	67c02b49e122204144a64ffb	https://checkout-staging.xendit.co/web/67c02b49e122204144a64ffb	pending	44445.00	\N	PHP	\N	\N	{"date": "2025-02-27T09:07:21.035Z", "donorId": 691, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	test@example.com	Test Donorzzz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 09:07:21.036912+00	2025-02-27 09:07:21.036912+00	2025-02-28 09:07:21.734+00	\N
4ee5ebe2-2952-4100-a8e4-f400f4ce7c7f	m_ty4ZbSNNyL	67c02d6fe122208f94a65523	https://checkout-staging.xendit.co/web/67c02d6fe122208f94a65523	paid	44455.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-27T09:16:30.611Z", "donorId": 691, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c02d6fe122208f94a65523", "amount": 44455, "status": "PAID", "created": "2025-02-27T09:16:31.390Z", "is_high": false, "paid_at": "2025-02-27T09:16:45.072Z", "updated": "2025-02-27T09:16:47.314Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_dda37b8e-908c-4891-87d1-044559e4a2c4", "description": "Donation to Missionary from Test Donorzzz", "external_id": "m_ty4ZbSNNyL", "paid_amount": 44455, "payer_email": "test@example.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-20fd7561-244e-4b7e-899f-930cb2f24a97", "failure_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/failure", "success_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/success"}}	test@example.com	Test Donorzzz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 09:16:30.613346+00	2025-02-27 09:16:30.613346+00	2025-02-28 09:16:31.262+00	2025-02-27 09:16:48.42+00
2e4eb938-c4cd-41a3-8ce0-245f260e4ba1	m_x9oR9d8_9o	67c02eda60498103d493c12f	https://checkout-staging.xendit.co/web/67c02eda60498103d493c12f	paid	44155.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-27T09:22:33.847Z", "donorId": 691, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c02eda60498103d493c12f", "amount": 44155, "status": "PAID", "created": "2025-02-27T09:22:34.620Z", "is_high": false, "paid_at": "2025-02-27T09:22:45.115Z", "updated": "2025-02-27T09:22:47.073Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_d26205b9-220c-4946-a50f-f4056e488536", "description": "Donation to Missionary from Test Donorzzz", "external_id": "m_x9oR9d8_9o", "paid_amount": 44155, "payer_email": "test@example.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-ea7ee80b-cd44-428e-ba88-794bbe629c0e", "failure_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/failure", "success_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/success"}}	test@example.com	Test Donorzzz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 09:22:33.856603+00	2025-02-27 09:22:33.856603+00	2025-02-28 09:22:34.391+00	2025-02-27 09:22:47.848+00
90319e1e-d088-4d1c-a0c7-613aa5f6d3b9	m_8-63N6KcFi	67c03017e122200d66a65a6b	https://checkout-staging.xendit.co/web/67c03017e122200d66a65a6b	paid	44155.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-27T09:27:51.224Z", "donorId": 691, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c03017e122200d66a65a6b", "amount": 44155, "status": "PAID", "created": "2025-02-27T09:27:52.079Z", "is_high": false, "paid_at": "2025-02-27T09:27:59.771Z", "updated": "2025-02-27T09:28:01.572Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_9fbe4d05-6135-4d46-a51b-96565383196a", "description": "Donation to Missionary from Test Donorzzxz", "external_id": "m_8-63N6KcFi", "paid_amount": 44155, "payer_email": "test@example.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-a23f26db-f7f6-4b6c-8303-412962093458", "failure_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/failure", "success_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/success"}}	test@example.com	Test Donorzzxz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 09:27:51.226882+00	2025-02-27 09:27:51.226882+00	2025-02-28 09:27:51.957+00	2025-02-27 09:28:02.903+00
f96b0d13-fb3f-4090-88ba-39b7c8c2c29b	m_cq-WOEPid7	67c032a9604981758d93cbc6	https://checkout-staging.xendit.co/web/67c032a9604981758d93cbc6	paid	5555.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-27T09:38:49.055Z", "donorId": 693, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c032a9604981758d93cbc6", "amount": 5555, "status": "PAID", "created": "2025-02-27T09:38:49.846Z", "is_high": false, "paid_at": "2025-02-27T09:38:58.750Z", "updated": "2025-02-27T09:39:00.512Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_30245c75-0d57-476a-bb84-dce4a6f23126", "description": "Donation to Missionary from Test Dxz", "external_id": "m_cq-WOEPid7", "paid_amount": 5555, "payer_email": "teszt@example.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-0eb2517b-3f90-46f6-a5e2-fb14682511ed", "failure_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/failure", "success_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/success"}}	teszt@example.com	Test Dxz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 09:38:49.058042+00	2025-02-27 09:38:49.058042+00	2025-02-28 09:38:49.708+00	2025-02-27 09:39:01.103+00
2a6e9d05-8ff2-47e2-a448-c9ade14fd9d8	m_phsvzj9Zem	67c03489e12220b331a66614	https://checkout-staging.xendit.co/web/67c03489e12220b331a66614	paid	2255.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-27T09:46:48.926Z", "donorId": 693, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c03489e12220b331a66614", "amount": 2255, "status": "PAID", "created": "2025-02-27T09:46:49.549Z", "is_high": false, "paid_at": "2025-02-27T09:46:57.829Z", "updated": "2025-02-27T09:48:17.982Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_02a8fa0c-adff-47ed-90db-f3876c7fe31b", "description": "Donation to Missionary from Test Dxz", "external_id": "m_phsvzj9Zem", "paid_amount": 2255, "payer_email": "teszt@example.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-34cfd6a7-1163-4f2e-a56d-fd770ea2f8da", "failure_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/failure", "success_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/success"}}	teszt@example.com	Test Dxz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 09:46:48.935458+00	2025-02-27 09:46:48.935458+00	2025-02-28 09:46:49.497+00	2025-02-27 09:48:18.578+00
e0862152-d5ed-49e4-a513-8cba01633199	m_znYpPebbwF	67c036b06049811f2493d65b	https://checkout-staging.xendit.co/web/67c036b06049811f2493d65b	pending	220055.00	\N	PHP	\N	\N	{"date": "2025-02-27T09:56:00.307Z", "donorId": 693, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	teszt@example.com	Test Dxz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 09:56:00.316194+00	2025-02-27 09:56:00.316194+00	2025-02-28 09:56:00.944+00	\N
22d695f4-d981-410d-aa6b-715da04803bc	m_FGtvOPolYV	67c036fa604981477e93d725	https://checkout-staging.xendit.co/web/67c036fa604981477e93d725	paid	220055.00	\N	PHP	CREDIT_CARD	CREDIT_CARD	{"date": "2025-02-27T09:57:13.889Z", "donorId": 693, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c036fa604981477e93d725", "amount": 220055, "status": "PAID", "created": "2025-02-27T09:57:14.555Z", "is_high": false, "paid_at": "2025-02-27T10:00:53.719Z", "updated": "2025-02-27T10:00:53.960Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "description": "Donation to Missionary from Test Dxz", "external_id": "m_FGtvOPolYV", "paid_amount": 220055, "payer_email": "teszt@example.com", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "CREDIT_CARD", "payment_channel": "CREDIT_CARD", "credit_card_token": "67c037c53416540016ae6a0d", "failure_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/failure", "success_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/success", "credit_card_charge_id": "67c037d53416540016ae6a18"}}	teszt@example.com	Test Dxz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 09:57:13.891845+00	2025-02-27 09:57:13.891845+00	2025-02-28 09:57:14.528+00	2025-02-27 10:00:55.1+00
a45b4229-d8fc-4f15-ac21-d24a00b2b91e	m_GZXWcS1Sby	67c03a49e12220598da67892	https://checkout-staging.xendit.co/web/67c03a49e12220598da67892	pending	220055.00	\N	PHP	\N	\N	{"date": "2025-02-27T10:11:20.619Z", "donorId": 693, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	teszt@example.com	Test Dxz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 10:11:20.628674+00	2025-02-27 10:11:20.628674+00	2025-02-28 10:11:21.268+00	\N
bac68cd6-a510-4ad5-a362-88cda69781b7	m_fLM-kq_hn3	67c03b5a604981379293e881	https://checkout-staging.xendit.co/web/67c03b5a604981379293e881	pending	220055.00	\N	PHP	\N	\N	{"date": "2025-02-27T10:15:54.020Z", "donorId": 693, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	teszt@example.com	Test Dxz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 10:15:54.029127+00	2025-02-27 10:15:54.029127+00	2025-02-28 10:15:54.622+00	\N
4216fb4d-4511-43c3-b415-f9947ebc09af	m_O-T5In4uyO	67c0a7056049812d0a94b97d	https://checkout-staging.xendit.co/web/67c0a7056049812d0a94b97d	pending	2000.00	\N	PHP	\N	\N	{"date": "2025-02-27T17:55:16.584Z", "donors": [{"amount": 1000, "donorId": "673", "donorName": "Rob G"}, {"amount": 1000, "donorId": "603", "donorName": "Robert Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 17:55:16.586388+00	2025-02-27 17:55:16.586388+00	2025-02-28 17:55:17.461+00	\N
6a8d9983-c782-41b3-9c31-82e905394cfe	m_EAPY8E5NdL	67c1169e6049815551957c15	https://checkout-staging.xendit.co/web/67c1169e6049815551957c15	pending	9999.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:51:25.731Z", "donorId": 700, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	chingchongefet@example.com	Bebfey Ching	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:51:25.733526+00	2025-02-28 01:51:25.733526+00	2025-03-01 01:51:26.397+00	\N
55a66657-f465-46e3-9219-a7a8f022bb96	m_LZtxaDkiIK	67c03c5c604981764193eae8	https://checkout-staging.xendit.co/web/67c03c5c604981764193eae8	paid	1025.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-27T10:20:11.613Z", "donorId": 693, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c03c5c604981764193eae8", "amount": 1025, "status": "PAID", "created": "2025-02-27T10:20:12.369Z", "is_high": false, "paid_at": "2025-02-27T10:20:21.041Z", "updated": "2025-02-27T10:20:23.193Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_cd9bbce9-a4d5-4fa0-92c6-573775c3c131", "description": "Donation to Missionary from Test Dxz", "external_id": "m_LZtxaDkiIK", "paid_amount": 1025, "payer_email": "teszt@example.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-ee60757b-becc-4a1d-9094-9df284043bae", "failure_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/failure", "success_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/success"}}	teszt@example.com	Test Dxz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 10:20:11.623188+00	2025-02-27 10:20:11.623188+00	2025-02-28 10:20:12.26+00	2025-02-27 10:20:23.838+00
97d03c56-08d5-49f4-b62c-d4ec221ef614	m_vOpMOh75w3	\N	\N	pending	3325.00	\N	PHP	\N	\N	{"date": "2025-02-27T10:32:49.877Z", "donorId": 693, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	teszt@example.com	Test Dxz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 10:32:49.880919+00	2025-02-27 10:32:49.880919+00	\N	\N
cf37b179-9862-422d-b91e-84e3719671fd	m_qkjc0vQj7y	67c11c29e122202850a816f1	https://checkout-staging.xendit.co/web/67c11c29e122202850a816f1	pending	20132.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:15:04.771Z", "donors": [{"amount": 20132, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:15:04.781472+00	2025-02-28 02:15:04.781472+00	2025-03-01 02:15:05.456+00	\N
c108c732-190a-4e8b-b8e9-39a2d1c574cb	m_Z6Jcd2-bhh	67c040af6049815fe793f465	https://checkout-staging.xendit.co/web/67c040af6049815fe793f465	paid	3325.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-27T10:38:39.334Z", "donorId": 693, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c040af6049815fe793f465", "amount": 3325, "status": "PAID", "created": "2025-02-27T10:38:40.187Z", "is_high": false, "paid_at": "2025-02-27T10:38:56.891Z", "updated": "2025-02-27T10:38:59.169Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_5f37e36a-52f6-4a58-b4ff-3e134aa1e29d", "description": "Donation to Missionary from Test Dxz", "external_id": "m_Z6Jcd2-bhh", "paid_amount": 3325, "payer_email": "teszt@example.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-1e437c08-1c2c-485b-9c6e-3caa0bbffeb7", "failure_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/failure", "success_redirect_url": "https://a796-180-191-53-179.ngrok-free.app/payment/success"}}	teszt@example.com	Test Dxz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 10:38:39.343723+00	2025-02-27 10:38:39.343723+00	2025-02-28 10:38:40.053+00	2025-02-27 10:39:00.391+00
cc269192-bfa0-4f5f-a326-fa294434d5c6	m_rAKD0YGKbi	67c04260e12220e1dca68be8	https://checkout-staging.xendit.co/web/67c04260e12220e1dca68be8	paid	4444.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-27T10:45:52.149Z", "donorId": 693, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c04260e12220e1dca68be8", "amount": 4444, "status": "PAID", "created": "2025-02-27T10:45:52.882Z", "is_high": false, "paid_at": "2025-02-27T10:47:00.685Z", "updated": "2025-02-27T10:47:02.462Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_5240841d-5763-419d-8692-7156d03ffe25", "description": "Donation to Missionary from Test Dxz", "external_id": "m_rAKD0YGKbi", "paid_amount": 4444, "payer_email": "teszt@example.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-24b45cc8-96d1-484b-8ed4-54010c5323bd", "failure_redirect_url": "https://de42-180-191-53-179.ngrok-free.app/payment/failure", "success_redirect_url": "https://de42-180-191-53-179.ngrok-free.app/payment/success"}}	teszt@example.com	Test Dxz	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 10:45:52.150468+00	2025-02-27 10:45:52.150468+00	2025-02-28 10:45:52.797+00	2025-02-27 10:47:04.022+00
7bdc4e3c-5f85-4a68-9c1d-5e336f87b84f	m_Q1rDGBMh6_	67c081c460498127ee9471b1	https://checkout-staging.xendit.co/web/67c081c460498127ee9471b1	paid	9898.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-27T15:16:20.073Z", "donorId": 694, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c081c460498127ee9471b1", "amount": 9898, "status": "PAID", "created": "2025-02-27T15:16:21.195Z", "is_high": false, "paid_at": "2025-02-27T15:16:35.066Z", "updated": "2025-02-27T15:16:37.114Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_72af3b15-d9b0-4c36-8e16-447c4b2b66ab", "description": "Donation to Missionary from Biboy Ching", "external_id": "m_Q1rDGBMh6_", "paid_amount": 9898, "payer_email": "chingchongt@example.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-b5b73e29-dbc1-4a36-845f-87b1037fbd94", "failure_redirect_url": "https://de42-180-191-53-179.ngrok-free.app/payment/failure", "success_redirect_url": "https://de42-180-191-53-179.ngrok-free.app/payment/success"}}	chingchongt@example.com	Biboy Ching	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 15:16:20.076031+00	2025-02-27 15:16:20.076031+00	2025-02-28 15:16:21.053+00	2025-02-27 15:16:37.56+00
a78fcfdc-d85e-4938-9204-e389913089c0	m_0-oXePUX1f	67c08709604981f184947b3b	https://checkout-staging.xendit.co/web/67c08709604981f184947b3b	paid	3233.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-27T15:38:49.253Z", "donorId": 695, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c08709604981f184947b3b", "amount": 3233, "status": "PAID", "created": "2025-02-27T15:38:50.316Z", "is_high": false, "paid_at": "2025-02-27T15:38:57.922Z", "updated": "2025-02-27T15:39:00.373Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_b7281d5e-40d3-4a2b-8297-b8c766183aa7", "description": "Donation to Missionary from Biboeey Ching", "external_id": "m_0-oXePUX1f", "paid_amount": 3233, "payer_email": "chingchongeet@example.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-332b8eb0-7b47-44ba-b4aa-01e37b56e5ff", "failure_redirect_url": "https://de42-180-191-53-179.ngrok-free.app/payment/failure", "success_redirect_url": "https://de42-180-191-53-179.ngrok-free.app/payment/success"}}	chingchongeet@example.com	Biboeey Ching	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 15:38:49.256403+00	2025-02-27 15:38:49.256403+00	2025-02-28 15:38:50.183+00	2025-02-27 15:39:01.134+00
048eb98f-79e8-42d0-a411-a39668fc8d77	m_Uy0BTkne5v	67c08aade122205b21a715c6	https://checkout-staging.xendit.co/web/67c08aade122205b21a715c6	pending	124.00	\N	PHP	\N	\N	{"date": "2025-02-27T15:54:20.343Z", "donorId": 696, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary"}	bulk@example.com	Bulk Donation	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 15:54:20.344587+00	2025-02-27 15:54:20.344587+00	2025-02-28 15:54:21.412+00	\N
957d5c3d-eb34-4787-964a-7165e5428344	m_Bxh7hHw5wz	67c0984ee122202864a72f33	https://checkout-staging.xendit.co/web/67c0984ee122202864a72f33	paid	4411.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-27T16:52:29.823Z", "donorId": 695, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c0984ee122202864a72f33", "amount": 4411, "status": "PAID", "created": "2025-02-27T16:52:31.057Z", "is_high": false, "paid_at": "2025-02-27T16:52:40.349Z", "updated": "2025-02-27T16:52:43.114Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_dce913ad-2fdb-4f94-a805-b946160ed1b5", "description": "Donation to Missionary from Bebey Ching", "external_id": "m_Bxh7hHw5wz", "paid_amount": 4411, "payer_email": "chingchongeet@example.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-e005e254-00fb-4b85-a5a4-9ac6b766c623", "failure_redirect_url": "https://de42-180-191-53-179.ngrok-free.app/payment/failure", "success_redirect_url": "https://de42-180-191-53-179.ngrok-free.app/payment/success"}}	chingchongeet@example.com	Bebey Ching	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 16:52:29.833786+00	2025-02-27 16:52:29.833786+00	2025-02-28 16:52:30.883+00	2025-02-27 16:52:44.211+00
4a453870-8121-4159-82b1-d57b48c10fe6	m_wzfn1tbde2	67c09b3460498151a794a3ba	https://checkout-staging.xendit.co/web/67c09b3460498151a794a3ba	pending	2000.00	\N	PHP	\N	\N	{"date": "2025-02-27T17:04:51.985Z", "donors": [{"email": "robneil@gmail.com", "amount": 2000, "donorId": "673", "donorName": "Rob G"}], "donorId": 602, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	robneil@gmail.com	Rob G	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 17:04:51.986194+00	2025-02-27 17:04:51.986194+00	2025-02-28 17:04:52.71+00	\N
c6705602-0428-464e-abc5-d858658389ab	m_uCHP9aqXr3	\N	\N	pending	4000.00	\N	PHP	\N	\N	{"date": "2025-02-27T17:08:59.273Z", "donors": [{"email": "robg@gmail.com", "amount": 4000, "donorId": "673", "donorName": "Rob G"}], "donorId": 698, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	robg@gmail.com	Rob G	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 17:08:59.27546+00	2025-02-27 17:08:59.27546+00	\N	\N
ec4617b5-2437-4da5-9195-81233cc64a59	m_ZGVrkjYf9D	67c09e20e1222063c9a73a7e	https://checkout-staging.xendit.co/web/67c09e20e1222063c9a73a7e	pending	2000.00	\N	PHP	\N	\N	{"date": "2025-02-27T17:17:19.968Z", "donors": [{"amount": 2000, "donorId": "673", "donorName": "Rob G"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 17:17:19.971518+00	2025-02-27 17:17:19.971518+00	2025-02-28 17:17:20.931+00	\N
abacbf2c-46ab-4595-8348-fc841dddfd89	m_7z_00CqQS3	67c09f00e122206ff2a73c0b	https://checkout-staging.xendit.co/web/67c09f00e122206ff2a73c0b	pending	44112.00	\N	PHP	\N	\N	{"date": "2025-02-27T17:21:03.169Z", "donorId": 695, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	chingchongeet@example.com	Bebey Ching	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 17:21:03.171262+00	2025-02-27 17:21:03.171262+00	2025-02-28 17:21:04.016+00	\N
919ec2c6-082b-41a8-b400-6a050d0fda19	m_dHjgBIvzY0	67c09f26e122207de6a73c3b	https://checkout-staging.xendit.co/web/67c09f26e122207de6a73c3b	pending	2000.00	\N	PHP	\N	\N	{"date": "2025-02-27T17:21:41.875Z", "donors": [{"amount": 2000, "donorId": "673", "donorName": "Rob G"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 17:21:41.876954+00	2025-02-27 17:21:41.876954+00	2025-02-28 17:21:42.582+00	\N
1300e054-6445-446d-adee-7a3706a5bbf7	m_ubfE8F5djA	67c0a011e122201047a73e36	https://checkout-staging.xendit.co/web/67c0a011e122201047a73e36	pending	22.00	\N	PHP	\N	\N	{"date": "2025-02-27T17:25:36.819Z", "donors": [{"amount": 22, "donorId": "673", "donorName": "Rob G"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 17:25:36.821582+00	2025-02-27 17:25:36.821582+00	2025-02-28 17:25:37.542+00	\N
c42ee190-9a55-4815-89ef-014b15f6f9ec	m_wtb6fKay8c	\N	\N	pending	122.00	\N	PHP	\N	\N	{"date": "2025-02-27T17:31:38.411Z", "donors": [{"amount": 122, "donorId": "673", "donorName": "Rob G"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 17:31:38.413482+00	2025-02-27 17:31:38.413482+00	\N	\N
85c1ebee-455d-4fb2-9c8a-b052cb089d63	m_barXbTtX8u	\N	\N	pending	1222.00	\N	PHP	\N	\N	{"date": "2025-02-27T17:38:08.841Z", "donors": [{"amount": 1222, "donorId": "673", "donorName": "Rob G"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 17:38:08.844095+00	2025-02-27 17:38:08.844095+00	\N	\N
cd571c2a-963b-4efb-ae36-66380a1bae5a	m_lmJdLkFapv	67c0a4c0e122203233a74609	https://checkout-staging.xendit.co/web/67c0a4c0e122203233a74609	paid	2000.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-27T17:45:35.265Z", "donors": [{"amount": 2000, "donorId": "673", "donorName": "Rob G"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true, "xenditResponse": {"id": "67c0a4c0e122203233a74609", "amount": 2000, "status": "PAID", "created": "2025-02-27T17:45:36.673Z", "is_high": false, "paid_at": "2025-02-27T17:45:42.390Z", "updated": "2025-02-27T17:45:46.472Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_b0a6cfd1-e74a-4c5a-9ff2-2346de47d70a", "description": "Donation to Campus Director", "external_id": "m_lmJdLkFapv", "paid_amount": 2000, "payer_email": "cd@gmail.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-b0b153fb-62dd-455a-92e3-24abd1903318", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=m_lmJdLkFapv", "success_redirect_url": "http://localhost:3000/donation/success?ref=m_lmJdLkFapv"}}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 17:45:35.267609+00	2025-02-27 17:45:35.267609+00	2025-02-28 17:45:36.38+00	2025-02-27 17:45:47.558+00
6b887338-70ff-467a-b5fc-f7fde2774cea	m_RaafxiKbKI	67c0a535e1222019b0a7472a	https://checkout-staging.xendit.co/web/67c0a535e1222019b0a7472a	pending	1000.00	\N	PHP	\N	\N	{"date": "2025-02-27T17:47:32.858Z", "donors": [{"amount": 500, "donorId": "673", "donorName": "Rob G"}, {"amount": 500, "donorId": "690", "donorName": "yeyeh"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 17:47:32.858978+00	2025-02-27 17:47:32.858978+00	2025-02-28 17:47:33.665+00	\N
5630d1bc-3094-4614-a71c-4c70a67996a1	m_Cfbx5XrvEB	67c11cd6e122207a25a8183b	https://checkout-staging.xendit.co/web/67c11cd6e122207a25a8183b	pending	2143.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:17:57.991Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:17:58.000602+00	2025-02-28 02:17:58.000602+00	2025-03-01 02:17:59.007+00	\N
16efb486-e454-4225-91f0-53e07028fa49	m_5XI6vSRfZh	67c0a8bd604981165894bce3	https://checkout-staging.xendit.co/web/67c0a8bd604981165894bce3	paid	1200.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-27T18:02:36.914Z", "donors": [{"amount": 1000, "donorId": "673", "donorName": "Rob G"}, {"amount": 200, "donorId": "604", "donorName": "Reb Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true, "xenditResponse": {"id": "67c0a8bd604981165894bce3", "amount": 1200, "status": "PAID", "created": "2025-02-27T18:02:38.044Z", "is_high": false, "paid_at": "2025-02-27T18:02:45.925Z", "updated": "2025-02-27T18:02:48.390Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_e9efac87-0845-4058-aadc-56d0ceecfddb", "description": "Donation to Campus Director", "external_id": "m_5XI6vSRfZh", "paid_amount": 1200, "payer_email": "cd@gmail.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-02fcae0c-a529-4366-b8bf-6e8fa8599598", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=m_5XI6vSRfZh", "success_redirect_url": "http://localhost:3000/donation/success?ref=m_5XI6vSRfZh"}}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 18:02:36.917832+00	2025-02-27 18:02:36.917832+00	2025-02-28 18:02:37.914+00	2025-02-27 18:02:49.443+00
f0125d38-2b9e-44c3-9b39-98071be9a9ba	m_TimgMJDZNP	67c0aac5e12220608ca75030	https://checkout-staging.xendit.co/web/67c0aac5e12220608ca75030	pending	2000.00	\N	PHP	\N	\N	{"date": "2025-02-27T18:11:16.990Z", "donors": [{"amount": 1000, "donorId": "673", "donorName": "Rob G"}, {"amount": 1000, "donorId": "604", "donorName": "Reb Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 18:11:16.993161+00	2025-02-27 18:11:16.993161+00	2025-02-28 18:11:17.772+00	\N
ccad8724-b3e2-48fb-bc9a-8d36bdb7620d	m_vXgEIR426d	67c0abd4604981526194c231	https://checkout-staging.xendit.co/web/67c0abd4604981526194c231	pending	2000.00	\N	PHP	\N	\N	{"date": "2025-02-27T18:15:47.276Z", "donors": [{"amount": 1000, "donorId": "673", "donorName": "Rob G"}, {"amount": 1000, "donorId": "604", "donorName": "Reb Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 18:15:47.279651+00	2025-02-27 18:15:47.279651+00	2025-02-28 18:15:48.157+00	\N
f0c3a223-8d62-4491-9f5e-c5a08d8e96f7	m_ZpRuOGHlK3	67c0ad09e122205f87a753c5	https://checkout-staging.xendit.co/web/67c0ad09e122205f87a753c5	pending	441412.00	\N	PHP	\N	\N	{"date": "2025-02-27T18:20:56.744Z", "donorId": 695, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	chingchongeet@example.com	Bebey Ching	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 18:20:56.753654+00	2025-02-27 18:20:56.753654+00	2025-02-28 18:20:57.835+00	\N
e6585cce-8cf9-4d9d-b1b7-ed860075e2dc	m_I9edofJaPM	67c114db60498121f6957918	https://checkout-staging.xendit.co/web/67c114db60498121f6957918	pending	129.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:43:54.560Z", "donors": [{"amount": 120, "donorId": "673", "donorName": "Rob G"}, {"amount": 9, "donorId": "604", "donorName": "Reb Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:43:54.561787+00	2025-02-28 01:43:54.561787+00	2025-03-01 01:43:55.115+00	\N
c0d7f311-2d2c-48bb-8e89-ea9518f30bc4	m_ungEJ087dA	67c115016049813cc995795a	https://checkout-staging.xendit.co/web/67c115016049813cc995795a	pending	129.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:44:32.346Z", "donors": [{"amount": 120, "donorId": "673", "donorName": "Rob G"}, {"amount": 9, "donorId": "604", "donorName": "Reb Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:44:32.348266+00	2025-02-28 01:44:32.348266+00	2025-03-01 01:44:33.005+00	\N
db434187-0cca-4c53-934e-0c8ba6b4cd4c	m_F95L-NdtUQ	67c11518e1222042d0a80891	https://checkout-staging.xendit.co/web/67c11518e1222042d0a80891	pending	1200.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:44:55.423Z", "donors": [{"amount": 500, "donorId": "673", "donorName": "Rob G"}, {"amount": 700, "donorId": "604", "donorName": "Reb Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:44:55.424375+00	2025-02-28 01:44:55.424375+00	2025-03-01 01:44:56.042+00	\N
c0d207f9-193b-461b-b790-2ee3ae8a619a	m_cepBDerp_a	67c11523e12220a210a808c7	https://checkout-staging.xendit.co/web/67c11523e12220a210a808c7	pending	12000.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:45:06.799Z", "donors": [{"amount": 5000, "donorId": "673", "donorName": "Rob G"}, {"amount": 7000, "donorId": "604", "donorName": "Reb Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:45:06.798888+00	2025-02-28 01:45:06.798888+00	2025-03-01 01:45:07.351+00	\N
34f467d1-5ce4-44c2-ae64-5933306620be	m_8A__z5CTZh	67c11531e122208d7aa808f0	https://checkout-staging.xendit.co/web/67c11531e122208d7aa808f0	pending	99.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:45:20.691Z", "donorId": 700, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	chingchongefet@example.com	Bebfey Ching	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:45:20.692222+00	2025-02-28 01:45:20.692222+00	2025-03-01 01:45:21.214+00	\N
3d7dc28d-e422-4b40-bd54-c07935218c52	m_hKzIF937-l	67c115e5e12220564aa80a19	https://checkout-staging.xendit.co/web/67c115e5e12220564aa80a19	pending	5000.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:48:20.931Z", "donors": [{"amount": 2500, "donorId": "673", "donorName": "Rob G"}, {"email": "robneil@gmail.com", "amount": 2500, "donorId": "602", "donorName": "Rob Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:48:20.93304+00	2025-02-28 01:48:20.93304+00	2025-03-01 01:48:21.739+00	\N
c52a59f2-ca84-4362-9337-af46ec48b7c3	m_kOZb-CodeR	67c115f9e12220a275a80a56	https://checkout-staging.xendit.co/web/67c115f9e12220a275a80a56	pending	99.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:48:40.737Z", "donorId": 700, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	chingchongefet@example.com	Bebfey Ching	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:48:40.738706+00	2025-02-28 01:48:40.738706+00	2025-03-01 01:48:41.344+00	\N
f0044092-2ac0-46a7-8bfb-b7021420d70d	m__v28tfDSmF	67c0ad9a6049817c5f94c549	https://checkout-staging.xendit.co/web/67c0ad9a6049817c5f94c549	paid	2000.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-27T18:23:21.629Z", "donors": [{"amount": 800, "donorId": "604", "donorName": "Reb Guevarra"}, {"email": "yoshl@gmail.com", "phone": "9999 9999", "amount": 1200, "donorId": "605", "donorName": "Yosh Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true, "xenditResponse": {"id": "67c0ad9a6049817c5f94c549", "amount": 2000, "status": "PAID", "created": "2025-02-27T18:23:22.847Z", "is_high": false, "paid_at": "2025-02-27T18:23:28.704Z", "updated": "2025-02-27T18:23:30.736Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_825aefb3-b0eb-4f4d-8daf-9d2b0789ff31", "description": "Donation to Campus Director", "external_id": "m__v28tfDSmF", "paid_amount": 2000, "payer_email": "cd@gmail.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-96dfe08b-de38-4d4f-9e0f-5b90074f74f9", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=m__v28tfDSmF", "success_redirect_url": "http://localhost:3000/donation/success?ref=m__v28tfDSmF"}}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-27 18:23:21.631017+00	2025-02-27 18:23:21.631017+00	2025-02-28 18:23:22.677+00	2025-02-27 18:23:31.868+00
dc738f0f-1645-4ef1-af2e-805b7251761b	m__zLcU5uSDU	\N	\N	pending	2143.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:19:28.405Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:19:28.414994+00	2025-02-28 02:19:28.414994+00	\N	\N
f5362324-0455-437e-b272-a17f868548e2	m_aiCSfRziUC	67c10ee3e122202b1aa7fd8a	https://checkout-staging.xendit.co/web/67c10ee3e122202b1aa7fd8a	pending	9199.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:18:26.623Z", "donorId": 700, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	chingchongefet@example.com	Bebfey Ching	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:18:26.626037+00	2025-02-28 01:18:26.626037+00	2025-03-01 01:18:27.452+00	\N
2e7e889d-eba8-4a0f-bb63-a448e4421ad7	m_93Qc1Jz_RI	67c110cde12220d76fa800df	https://checkout-staging.xendit.co/web/67c110cde12220d76fa800df	pending	9000.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:26:37.439Z", "donors": [{"amount": 3000, "donorId": "673", "donorName": "Rob G"}, {"email": "yoshl@gmail.com", "phone": "9999 9999", "amount": 6000, "donorId": "605", "donorName": "Yosh Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:26:37.44041+00	2025-02-28 01:26:37.44041+00	2025-03-01 01:26:37.997+00	\N
960cfdaf-0684-442d-b696-74895e7d84a3	m_wZUuRFTH2_	67c1113c604981743995726b	https://checkout-staging.xendit.co/web/67c1113c604981743995726b	pending	120.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:28:27.806Z", "donors": [{"amount": 120, "donorId": "673", "donorName": "Rob G"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:28:27.808649+00	2025-02-28 01:28:27.808649+00	2025-03-01 01:28:28.509+00	\N
2135dbb7-9dab-402e-b2cf-56218caada90	m_H3eKiT1vWW	67c111f9604981063e9573d2	https://checkout-staging.xendit.co/web/67c111f9604981063e9573d2	pending	6000.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:31:36.482Z", "donors": [{"amount": 3000, "donorId": "673", "donorName": "Rob G"}, {"email": "yoshl@gmail.com", "phone": "9999 9999", "amount": 3000, "donorId": "605", "donorName": "Yosh Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:31:36.485375+00	2025-02-28 01:31:36.485375+00	2025-03-01 01:31:37.119+00	\N
3e190961-f0cf-4e59-8154-48f55c865b5f	m_h9M2145hKK	67c11210e12220fa88a802de	https://checkout-staging.xendit.co/web/67c11210e12220fa88a802de	pending	120.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:31:59.648Z", "donors": [{"amount": 120, "donorId": "673", "donorName": "Rob G"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:31:59.649925+00	2025-02-28 01:31:59.649925+00	2025-03-01 01:32:00.286+00	\N
68a32a4c-1ac5-4af3-b8ee-25899eb33fa7	m_7nX4lM3pQP	67c1123360498139ac957410	https://checkout-staging.xendit.co/web/67c1123360498139ac957410	pending	9199.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:32:34.762Z", "donorId": 700, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	chingchongefet@example.com	Bebfey Ching	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:32:34.771777+00	2025-02-28 01:32:34.771777+00	2025-03-01 01:32:35.378+00	\N
50d3ff44-2d4a-4001-a3a9-701a8ed58ba7	m_7DEruvMvZ4	67c113ece122202150a8063b	https://checkout-staging.xendit.co/web/67c113ece122202150a8063b	pending	1222.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:39:55.730Z", "donors": [{"amount": 1222, "donorId": "673", "donorName": "Rob G"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:39:55.731657+00	2025-02-28 01:39:55.731657+00	2025-03-01 01:39:56.714+00	\N
3a87d230-25e5-4a1b-bbb1-625570067a8d	m_MHtVNXW5yD	67c114c0604981a250957901	https://checkout-staging.xendit.co/web/67c114c0604981a250957901	pending	129.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:43:27.933Z", "donors": [{"amount": 120, "donorId": "673", "donorName": "Rob G"}, {"amount": 9, "donorId": "604", "donorName": "Reb Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:43:27.935456+00	2025-02-28 01:43:27.935456+00	2025-03-01 01:43:28.545+00	\N
3b2fa6c8-dfd4-4e46-b05b-667cabe20061	m_SKQLc3AWC2	67c114ec6049811fb4957947	https://checkout-staging.xendit.co/web/67c114ec6049811fb4957947	pending	1290.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:44:11.441Z", "donors": [{"amount": 1200, "donorId": "673", "donorName": "Rob G"}, {"amount": 90, "donorId": "604", "donorName": "Reb Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:44:11.442421+00	2025-02-28 01:44:11.442421+00	2025-03-01 01:44:12.008+00	\N
46715105-0af3-48b4-90a8-3e3bf1dd4bfd	m_lZGLeQ6bg_	67c116906049812819957be3	https://checkout-staging.xendit.co/web/67c116906049812819957be3	pending	99.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:51:11.832Z", "donorId": 700, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	chingchongefet@example.com	Bebfey Ching	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:51:11.841789+00	2025-02-28 01:51:11.841789+00	2025-03-01 01:51:12.415+00	\N
3f4ab285-14bf-48b1-af22-0ac98bca6ef3	m_z5oqqKSgms	67c116fbe122200f44a80c4a	https://checkout-staging.xendit.co/web/67c116fbe122200f44a80c4a	pending	2000.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:52:58.598Z", "donors": [{"amount": 2000, "donorId": "673", "donorName": "Rob G"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:52:58.600201+00	2025-02-28 01:52:58.600201+00	2025-03-01 01:52:59.276+00	\N
6c82224e-eef4-482e-997f-26bfd4c1ecab	m_qEsRxg0EHW	67c11825604981791b957ee2	https://checkout-staging.xendit.co/web/67c11825604981791b957ee2	paid	20001.00	\N	PHP	RETAIL_OUTLET	CEBUANA	{"date": "2025-02-28T01:57:57.358Z", "donors": [{"amount": 20001, "donorId": "673", "donorName": "Rob G"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true, "xenditResponse": {"id": "67c11825604981791b957ee2", "amount": 20001, "status": "PAID", "created": "2025-02-28T01:57:57.989Z", "is_high": false, "paid_at": "2025-02-28T01:58:46.601Z", "updated": "2025-02-28T01:58:46.603Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "pymt-4a0bde54-57cd-451e-ae2e-ed72c86e998a", "description": "Donation to Campus Director", "external_id": "m_qEsRxg0EHW", "paid_amount": 20001, "payer_email": "cd@gmail.com", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "RETAIL_OUTLET", "payment_channel": "CEBUANA", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=m_qEsRxg0EHW", "success_redirect_url": "http://localhost:3000/donation/success?ref=m_qEsRxg0EHW"}}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:57:57.359726+00	2025-02-28 01:57:57.359726+00	2025-03-01 01:57:57.889+00	2025-02-28 02:13:49.758+00
7010103d-6c3f-4deb-95fb-86ac65c7b6f5	m_Js3akgQON3	67c117f36049811314957eab	https://checkout-staging.xendit.co/web/67c117f36049811314957eab	pending	9999.00	\N	PHP	\N	\N	{"date": "2025-02-28T01:57:07.419Z", "donorId": 700, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	chingchongefet@example.com	Bebfey Ching	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:57:07.429049+00	2025-02-28 01:57:07.429049+00	2025-03-01 01:57:07.992+00	\N
8c5d1d79-9ee6-46f6-a8c6-128a31e031af	m_YinI6C3VXi	67c11df36049818d2d958aa5	https://checkout-staging.xendit.co/web/67c11df36049818d2d958aa5	pending	2143.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:22:42.932Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:22:42.94169+00	2025-02-28 02:22:42.94169+00	2025-03-01 02:22:43.603+00	\N
25fdd4f8-639f-474a-98d8-776647286e19	m_nlJyv3_PWE	67c118166049819ba6957ed7	https://checkout-staging.xendit.co/web/67c118166049819ba6957ed7	paid	2223.00	\N	PHP	RETAIL_OUTLET	CEBUANA	{"date": "2025-02-28T01:57:42.011Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c118166049819ba6957ed7", "items": [{"name": "Donation to Missionary", "price": 2223, "category": "missionary", "quantity": 1}], "amount": 2223, "status": "PAID", "created": "2025-02-28T01:57:42.696Z", "is_high": false, "paid_at": "2025-02-28T02:01:20.073Z", "updated": "2025-02-28T02:01:20.073Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "pymt-88ae35c4-bb03-4a86-8f84-9d081ffa3835", "description": "Donation to Missionary", "external_id": "m_nlJyv3_PWE", "paid_amount": 2223, "payer_email": "cfet@example.com", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "RETAIL_OUTLET", "payment_channel": "CEBUANA", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=m_nlJyv3_PWE", "success_redirect_url": "http://localhost:3000/donation/success?ref=m_nlJyv3_PWE"}}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:57:42.012713+00	2025-02-28 01:57:42.012713+00	2025-03-01 01:57:42.594+00	2025-02-28 02:01:21.363+00
846172ec-b2bd-4103-be3d-c32e5c96c979	m_HN_c62bCSy	\N	\N	pending	22243.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:01:56.235Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:01:56.243878+00	2025-02-28 02:01:56.243878+00	\N	\N
659d38eb-e2e7-4906-b43b-8eb91127c0d5	m_yS_1EfIc9s	67c11e83604981014a958bd0	https://checkout-staging.xendit.co/web/67c11e83604981014a958bd0	pending	2143.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:25:07.242Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:25:07.242996+00	2025-02-28 02:25:07.242996+00	2025-03-01 02:25:07.787+00	\N
3b1993f0-616f-4a5f-9dff-191ecf7312d3	m_oM39P1j8v3	67c11992e122203740a8119c	https://checkout-staging.xendit.co/web/67c11992e122203740a8119c	pending	22243.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:04:01.954Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:04:01.966238+00	2025-02-28 02:04:01.966238+00	2025-03-01 02:04:02.756+00	\N
75e7e1c9-5892-4e4c-a8d8-8d44e7984413	m_inOyf6Vr6N	67c11a29e12220857ea81306	https://checkout-staging.xendit.co/web/67c11a29e12220857ea81306	pending	2143.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:06:32.630Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:06:32.640428+00	2025-02-28 02:06:32.640428+00	2025-03-01 02:06:33.498+00	\N
f4bb6aa9-3754-4c1d-8258-ac27f19e7a04	m_Ccrf8pJ7_e	67c11f30604981820b958d3b	https://checkout-staging.xendit.co/web/67c11f30604981820b958d3b	pending	212243.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:27:59.576Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:27:59.585848+00	2025-02-28 02:27:59.585848+00	2025-03-01 02:28:00.309+00	\N
0d59bf1b-9cab-4ea4-8f41-78583a17eeff	m_EswTbUkdcM	67c113d46049814df0957731	https://checkout-staging.xendit.co/web/67c113d46049814df0957731	paid	9199.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-28T01:39:31.540Z", "donorId": 700, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c113d46049814df0957731", "items": [{"name": "Donation to Missionary", "price": 9199, "category": "missionary", "quantity": 1}], "amount": 9199, "status": "PAID", "created": "2025-02-28T01:39:32.368Z", "is_high": false, "paid_at": "2025-02-28T01:43:02.350Z", "updated": "2025-02-28T01:43:04.711Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_76d22d1b-5792-4149-98b9-0311e288f383", "description": "Donation to Missionary", "external_id": "m_EswTbUkdcM", "paid_amount": 9199, "payer_email": "chingchongefet@example.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-1d6fd7d2-3b7c-4f56-a329-166e770ac8b7", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=m_EswTbUkdcM", "success_redirect_url": "http://localhost:3000/donation/success?ref=m_EswTbUkdcM"}}	chingchongefet@example.com	Bebfey Ching	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 01:39:31.549494+00	2025-02-28 01:39:31.549494+00	2025-03-01 01:39:32.319+00	2025-02-28 02:28:49.596+00
34b803e3-2485-4cf6-bf21-c3c19e73d24b	m_saGrRs03RW	67c11a7e60498198d495841f	https://checkout-staging.xendit.co/web/67c11a7e60498198d495841f	paid	2000.00	\N	PHP	RETAIL_OUTLET	CEBUANA	{"date": "2025-02-28T02:07:57.550Z", "donors": [{"amount": 2000, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true, "xenditResponse": {"id": "67c11a7e60498198d495841f", "amount": 2000, "status": "PAID", "created": "2025-02-28T02:07:58.403Z", "is_high": false, "paid_at": "2025-02-28T02:10:16.578Z", "updated": "2025-02-28T02:10:16.580Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "pymt-219b4f67-9ec8-4e42-a5ab-e53e6b4fb705", "description": "Donation to Missionary", "external_id": "m_saGrRs03RW", "paid_amount": 2000, "payer_email": "missionary@gmail.com", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "RETAIL_OUTLET", "payment_channel": "CEBUANA", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=m_saGrRs03RW", "success_redirect_url": "http://localhost:3000/donation/success?ref=m_saGrRs03RW"}}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:07:57.552983+00	2025-02-28 02:07:57.552983+00	2025-03-01 02:07:58.298+00	2025-02-28 02:10:17.816+00
92ce5e81-e312-46ea-82cf-d5c5c87ca26d	m_qlQxFyDhf8	\N	\N	pending	2143.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:25:01.785Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:25:01.794175+00	2025-02-28 02:25:01.794175+00	\N	\N
5e966887-54c3-4af0-afe9-9f7b572450d4	m_N1YLZshMo1	67c11b2060498130e49585c6	https://checkout-staging.xendit.co/web/67c11b2060498130e49585c6	pending	20001.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:10:40.186Z", "donors": [{"amount": 20001, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:10:40.187432+00	2025-02-28 02:10:40.187432+00	2025-03-01 02:10:40.922+00	\N
556f63cc-f10b-46ed-a44d-1038afc44877	m_gdDP7SN59X	67c11e81e122205df4a81b95	https://checkout-staging.xendit.co/web/67c11e81e122205df4a81b95	pending	2143.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:25:05.272Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:25:05.274551+00	2025-02-28 02:25:05.274551+00	2025-03-01 02:25:05.821+00	\N
1c1e9e4d-1054-4bcd-9754-7e9056e180f6	m_Aq6kYMIgsV	67c11e85e122205feea81ba8	https://checkout-staging.xendit.co/web/67c11e85e122205feea81ba8	pending	2143.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:25:08.685Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:25:08.686028+00	2025-02-28 02:25:08.686028+00	2025-03-01 02:25:09.24+00	\N
83fd604c-730e-4e4a-94d4-84ae9995d8f9	m_mrUF0T9zEz	67c11e95e12220a48ca81bca	https://checkout-staging.xendit.co/web/67c11e95e12220a48ca81bca	pending	212243.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:25:25.257Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:25:25.259198+00	2025-02-28 02:25:25.259198+00	2025-03-01 02:25:25.907+00	\N
235eedd9-c093-4ea0-9416-89bb688ab657	m_rmoOwCM1r_	67c11f3e604981144f958d5d	https://checkout-staging.xendit.co/web/67c11f3e604981144f958d5d	pending	2143.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:28:14.075Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:28:14.07634+00	2025-02-28 02:28:14.07634+00	2025-03-01 02:28:14.683+00	\N
b58a6347-6646-4337-bae5-99ce101384f0	m_VLUd8cpH91	\N	\N	pending	21243.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:29:54.207Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:29:54.21631+00	2025-02-28 02:29:54.21631+00	\N	\N
d07969d6-7ac2-4a8e-9fd5-4c4c3cdbef01	m_yWgv5uk4P1	67c1203260498145b6958f5e	https://checkout-staging.xendit.co/web/67c1203260498145b6958f5e	pending	21243.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:32:18.291Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:32:18.300314+00	2025-02-28 02:32:18.300314+00	2025-03-01 02:32:18.976+00	\N
3c81040a-3915-4665-bd2a-d1c3e3b2f81c	m_-cEWsOKP7L	67c121b1e12220904ca82152	https://checkout-staging.xendit.co/web/67c121b1e12220904ca82152	pending	21243.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:38:40.853Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:38:40.862362+00	2025-02-28 02:38:40.862362+00	2025-03-01 02:38:41.731+00	\N
ee2f906d-58ac-44c7-8625-763dec0845e1	m_YN9MJrnTPR	67c121d760498182b89592fe	https://checkout-staging.xendit.co/web/67c121d760498182b89592fe	pending	21243.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:39:18.399Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:39:18.407976+00	2025-02-28 02:39:18.407976+00	2025-03-01 02:39:19.13+00	\N
cefc13b8-fd9c-4c9a-b25d-6db289ddf734	m_DUp5NIrmaf	67c121e0e122204614a821bd	https://checkout-staging.xendit.co/web/67c121e0e122204614a821bd	pending	21243.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:39:27.788Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:39:27.789971+00	2025-02-28 02:39:27.789971+00	2025-03-01 02:39:28.537+00	\N
9a34b73b-b0e6-411e-a62e-5ed8651a9bf7	m_yfPY4TVMH-	67c121f160498173b3959327	https://checkout-staging.xendit.co/web/67c121f160498173b3959327	pending	201321.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:39:45.307Z", "donors": [{"amount": 201321, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:39:45.309157+00	2025-02-28 02:39:45.309157+00	2025-03-01 02:39:45.917+00	\N
760c59ce-9f05-4efd-b4db-f150a00421b6	m_wBt571yQny	67c121ff604981ea3a959340	https://checkout-staging.xendit.co/web/67c121ff604981ea3a959340	pending	2022.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:39:59.298Z", "donors": [{"amount": 2022, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:39:59.300202+00	2025-02-28 02:39:59.300202+00	2025-03-01 02:39:59.911+00	\N
eb45be37-af8b-48ec-a882-77b1efeb62ec	m_J7WQe2mHr8	67c12214e1222017c1a8221d	https://checkout-staging.xendit.co/web/67c12214e1222017c1a8221d	pending	1201.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:40:19.447Z", "donors": [{"amount": 1201, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:40:19.449003+00	2025-02-28 02:40:19.449003+00	2025-03-01 02:40:20.058+00	\N
eda85670-10c8-456e-8518-5f33645caa4f	m_j4M1y46wMl	67c12225604981777b95939c	https://checkout-staging.xendit.co/web/67c12225604981777b95939c	pending	2202.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:40:36.545Z", "donors": [{"amount": 2202, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:40:36.547487+00	2025-02-28 02:40:36.547487+00	2025-03-01 02:40:37.234+00	\N
071674bf-d7d8-4228-a3d9-0d220b250254	m_UUOvyGOw_q	67c1222e604981a59d9593b1	https://checkout-staging.xendit.co/web/67c1222e604981a59d9593b1	pending	2222.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:40:46.022Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:40:46.023749+00	2025-02-28 02:40:46.023749+00	2025-03-01 02:40:46.779+00	\N
80d572c6-eceb-4652-b44b-6b7d225d01f6	m_7UnXi2L6ce	67c122396049810ed79593bd	https://checkout-staging.xendit.co/web/67c122396049810ed79593bd	pending	2222.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:40:56.741Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:40:56.743037+00	2025-02-28 02:40:56.743037+00	2025-03-01 02:40:57.404+00	\N
b01ba64c-77d7-4a84-adae-3e7359f4377a	m_lRKoGNka6r	67c12272e122207f3ca822a7	https://checkout-staging.xendit.co/web/67c12272e122207f3ca822a7	pending	2222.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:41:53.929Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:41:53.937804+00	2025-02-28 02:41:53.937804+00	2025-03-01 02:41:54.614+00	\N
4ed3b680-8802-426e-b553-89edd88ea8dd	m_NuUJ5VmZpD	67c12282e122209e8aa822d1	https://checkout-staging.xendit.co/web/67c12282e122209e8aa822d1	pending	2222.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:42:09.959Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:42:09.96+00	2025-02-28 02:42:09.96+00	2025-03-01 02:42:10.581+00	\N
431c30b7-6789-4962-b9ba-beee3240367d	m_fDnzr9R2ym	67c12292e122203dd2a822f3	https://checkout-staging.xendit.co/web/67c12292e122203dd2a822f3	paid	1111.00	\N	PHP	RETAIL_OUTLET	7ELEVEN	{"date": "2025-02-28T02:42:25.896Z", "donors": [{"amount": 1111, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true, "xenditResponse": {"id": "67c12292e122203dd2a822f3", "amount": 1111, "status": "PAID", "created": "2025-02-28T02:42:26.620Z", "is_high": false, "paid_at": "2025-02-28T02:42:38.248Z", "updated": "2025-02-28T02:42:38.252Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "pymt-395e8eb6-3af1-41d2-8fdc-19d935e135f7", "description": "Donation to Missionary", "external_id": "m_fDnzr9R2ym", "paid_amount": 1111, "payer_email": "missionary@gmail.com", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "RETAIL_OUTLET", "payment_channel": "7ELEVEN", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=m_fDnzr9R2ym", "success_redirect_url": "http://localhost:3000/donation/success?ref=m_fDnzr9R2ym"}}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:42:25.898153+00	2025-02-28 02:42:25.898153+00	2025-03-01 02:42:26.498+00	2025-02-28 02:42:39.506+00
6013bd88-88e0-4bd4-ab58-8444a968952b	m_5Uo7efpr7u	67c1232ce12220eb81a823e4	https://checkout-staging.xendit.co/web/67c1232ce12220eb81a823e4	pending	2222.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:44:59.228Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:44:59.238668+00	2025-02-28 02:44:59.238668+00	2025-03-01 02:45:00.175+00	\N
375242f8-5593-4bee-800c-364a8c53b1ea	m_3eRtjdSrJp	67c123386049810e129595fb	https://checkout-staging.xendit.co/web/67c123386049810e129595fb	pending	2222.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:45:11.374Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:45:11.375166+00	2025-02-28 02:45:11.375166+00	2025-03-01 02:45:12.144+00	\N
5781ca52-35f1-49c0-9fda-21a7d1236b59	m_OUonDAlbmm	67c12352e122200370a82475	https://checkout-staging.xendit.co/web/67c12352e122200370a82475	pending	11111.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:45:38.148Z", "donors": [{"amount": 11111, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:45:38.148785+00	2025-02-28 02:45:38.148785+00	2025-03-01 02:45:38.814+00	\N
b5e6080e-67dd-4543-bbe4-145f659095a6	m_fHByMiIuhu	67c12387e1222064d0a824f2	https://checkout-staging.xendit.co/web/67c12387e1222064d0a824f2	pending	1211.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:46:30.325Z", "donors": [{"amount": 1211, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:46:30.335063+00	2025-02-28 02:46:30.335063+00	2025-03-01 02:46:31.05+00	\N
ffbf246d-9ab7-4cc9-9e8c-2d2841fd1915	m_aYi8sWZgzh	67c1239460498134ff959678	https://checkout-staging.xendit.co/web/67c1239460498134ff959678	pending	12122.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:46:44.331Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:46:44.332855+00	2025-02-28 02:46:44.332855+00	2025-03-01 02:46:44.97+00	\N
3833bc3c-9328-4a55-b8b4-2b0f0c7aaa73	m_AD1rKaBWqb	67c123cbe1222007eda82598	https://checkout-staging.xendit.co/web/67c123cbe1222007eda82598	pending	22122.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:47:38.858Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:47:38.865996+00	2025-02-28 02:47:38.865996+00	2025-03-01 02:47:39.661+00	\N
2b645a78-b6d1-44ff-a898-237e443b1144	m_0nfbZ-bMr5	67c125a7e122200b2ba82944	https://checkout-staging.xendit.co/web/67c125a7e122200b2ba82944	pending	12112.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:55:34.878Z", "donors": [{"amount": 12112, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:55:34.888093+00	2025-02-28 02:55:34.888093+00	2025-03-01 02:55:35.976+00	\N
d4ee35f0-88e0-4174-91b8-da5eef6a78d8	m_eX9whXqUn7	67c125b5e1222002bea82955	https://checkout-staging.xendit.co/web/67c125b5e1222002bea82955	pending	11.00	\N	PHP	\N	\N	{"date": "2025-02-28T02:55:48.478Z", "donors": [{"amount": 11, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 02:55:48.479557+00	2025-02-28 02:55:48.479557+00	2025-03-01 02:55:49.461+00	\N
d5363ba5-2bdf-4031-b9bb-65ffd1a44f64	m_WjJ0XH-v2J	67c128bbe122208e11a830b0	https://checkout-staging.xendit.co/web/67c128bbe122208e11a830b0	pending	11.00	\N	PHP	\N	\N	{"date": "2025-02-28T03:08:42.401Z", "donors": [{"amount": 11, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 03:08:42.410416+00	2025-02-28 03:08:42.410416+00	2025-03-01 03:08:43.167+00	\N
9d7aa47c-b670-4432-a1ee-124a3511cc1d	m_szXi-Ygtbq	67c1298c604981216495a311	https://checkout-staging.xendit.co/web/67c1298c604981216495a311	paid	22122.00	\N	PHP	RETAIL_OUTLET	7ELEVEN	{"date": "2025-02-28T03:12:12.115Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c1298c604981216495a311", "items": [{"name": "Donation to Missionary", "price": 22122, "category": "missionary", "quantity": 1}], "amount": 22122, "status": "PAID", "created": "2025-02-28T03:12:12.999Z", "is_high": false, "paid_at": "2025-02-28T03:12:47.156Z", "updated": "2025-02-28T03:12:47.157Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "pymt-c95b3b69-4687-4fb4-8f4e-f4604b1e7f9a", "description": "Donation to Missionary", "external_id": "m_szXi-Ygtbq", "paid_amount": 22122, "payer_email": "cfet@example.com", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "RETAIL_OUTLET", "payment_channel": "7ELEVEN", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=m_szXi-Ygtbq", "success_redirect_url": "http://localhost:3000/donation/success?ref=m_szXi-Ygtbq"}}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 03:12:12.12498+00	2025-02-28 03:12:12.12498+00	2025-03-01 03:12:12.934+00	2025-02-28 03:12:48.401+00
1ef6cd91-6039-4e16-896b-48573a88184d	m_hEw8dJuF32	67c129c9e122205087a832c3	https://checkout-staging.xendit.co/web/67c129c9e122205087a832c3	paid	1111.00	\N	PHP	RETAIL_OUTLET	7ELEVEN	{"date": "2025-02-28T03:13:12.783Z", "donors": [{"amount": 1111, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true, "xenditResponse": {"id": "67c129c9e122205087a832c3", "amount": 1111, "status": "PAID", "created": "2025-02-28T03:13:13.837Z", "is_high": false, "paid_at": "2025-02-28T03:13:22.370Z", "updated": "2025-02-28T03:13:22.371Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "pymt-3cf11d02-71da-4062-a064-30ad1555a439", "description": "Donation to Missionary", "external_id": "m_hEw8dJuF32", "paid_amount": 1111, "payer_email": "missionary@gmail.com", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "RETAIL_OUTLET", "payment_channel": "7ELEVEN", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=m_hEw8dJuF32", "success_redirect_url": "http://localhost:3000/donation/success?ref=m_hEw8dJuF32"}}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 03:13:12.785352+00	2025-02-28 03:13:12.785352+00	2025-03-01 03:13:13.514+00	2025-02-28 03:13:22.702+00
77eed9f4-043b-4b82-beec-9a82485ec3f2	m_THkGUq3iOO	67c12a0ce12220584da8334f	https://checkout-staging.xendit.co/web/67c12a0ce12220584da8334f	paid	21212.00	\N	PHP	RETAIL_OUTLET	7ELEVEN	{"date": "2025-02-28T03:14:19.869Z", "donors": [{"amount": 21212, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true, "xenditResponse": {"id": "67c12a0ce12220584da8334f", "amount": 21212, "status": "PAID", "created": "2025-02-28T03:14:20.622Z", "is_high": false, "paid_at": "2025-02-28T03:14:41.782Z", "updated": "2025-02-28T03:14:41.783Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "pymt-8efa5c38-a520-4059-8780-19381bb7c485", "description": "Donation to Missionary", "external_id": "m_THkGUq3iOO", "paid_amount": 21212, "payer_email": "missionary@gmail.com", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "RETAIL_OUTLET", "payment_channel": "7ELEVEN", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=m_THkGUq3iOO", "success_redirect_url": "http://localhost:3000/donation/success?ref=m_THkGUq3iOO"}}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 03:14:19.871482+00	2025-02-28 03:14:19.871482+00	2025-03-01 03:14:20.587+00	2025-02-28 03:14:42.661+00
5b7de493-7bfe-4c45-bbd3-76905f2074af	703_1740714146829	67c130a3e122204fb1a84077	https://checkout-staging.xendit.co/web/67c130a3e122204fb1a84077	paid	112.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-28T03:42:26.829Z", "donors": [{"amount": 112, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true, "xenditResponse": {"id": "67c130a3e122204fb1a84077", "amount": 112, "status": "PAID", "created": "2025-02-28T03:42:27.765Z", "is_high": false, "paid_at": "2025-02-28T03:42:41.631Z", "updated": "2025-02-28T03:42:43.930Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_c2991d79-f3e6-43a4-a32b-475077e876c2", "description": "Donation to Missionary", "external_id": "703_1740714146829", "paid_amount": 112, "payer_email": "missionary@gmail.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-50b11be9-4f01-421f-8f16-b842ad4eb8c2", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=703_1740714146829", "success_redirect_url": "http://localhost:3000/donation/success?ref=703_1740714146829"}}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 03:42:26.83134+00	2025-02-28 03:42:26.83134+00	2025-03-01 03:42:27.609+00	2025-02-28 03:42:44.82+00
c0aac696-1f74-4e17-9e73-fb3490a2a12f	703_1740714386341	67c13193e12220c37ba842c2	https://checkout-staging.xendit.co/web/67c13193e12220c37ba842c2	paid	9119.00	\N	PHP	RETAIL_OUTLET	7ELEVEN	{"date": "2025-02-28T03:46:26.341Z", "donors": [{"amount": 9119, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true, "xenditResponse": {"id": "67c13193e12220c37ba842c2", "amount": 9119, "status": "PAID", "created": "2025-02-28T03:46:27.235Z", "is_high": false, "paid_at": "2025-02-28T03:46:36.630Z", "updated": "2025-02-28T03:46:36.630Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "pymt-27a0b877-f893-4c53-80a8-57e84b82aec8", "description": "Donation to Missionary", "external_id": "703_1740714386341", "paid_amount": 9119, "payer_email": "missionary@gmail.com", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "RETAIL_OUTLET", "payment_channel": "7ELEVEN", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=703_1740714386341", "success_redirect_url": "http://localhost:3000/donation/success?ref=703_1740714386341"}}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 03:46:26.34379+00	2025-02-28 03:46:26.34379+00	2025-03-01 03:46:27.152+00	2025-02-28 03:46:37.19+00
2c80f3d7-8911-4957-8c5a-35c6f5a876d6	m_fPBHf2OfQ8	67c12a41e12220580fa833dd	https://checkout-staging.xendit.co/web/67c12a41e12220580fa833dd	paid	12122.00	\N	PHP	RETAIL_OUTLET	DP_ECPAY_LOAN	{"date": "2025-02-28T03:15:13.145Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c12a41e12220580fa833dd", "items": [{"name": "Donation to Missionary", "price": 12122, "category": "missionary", "quantity": 1}], "amount": 12122, "status": "PAID", "created": "2025-02-28T03:15:13.932Z", "is_high": false, "paid_at": "2025-02-28T03:15:23.046Z", "updated": "2025-02-28T03:15:23.046Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "pymt-f4cea265-0e2e-42d7-aa17-eaa77dc3b502", "description": "Donation to Missionary", "external_id": "m_fPBHf2OfQ8", "paid_amount": 12122, "payer_email": "cfet@example.com", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "RETAIL_OUTLET", "payment_channel": "DP_ECPAY_LOAN", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=m_fPBHf2OfQ8", "success_redirect_url": "http://localhost:3000/donation/success?ref=m_fPBHf2OfQ8"}}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 03:15:13.153931+00	2025-02-28 03:15:13.153931+00	2025-03-01 03:15:13.901+00	2025-02-28 03:15:23.326+00
ba7a79a0-cbb0-44f4-bb78-e4f4739fe279	m_DmE8Kgn91u	67c12bf760498196d795a7a8	https://checkout-staging.xendit.co/web/67c12bf760498196d795a7a8	paid	32122.00	\N	PHP	RETAIL_OUTLET	DP_ECPAY_LOAN	{"date": "2025-02-28T03:22:30.412Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c12bf760498196d795a7a8", "items": [{"name": "Donation to Missionary", "price": 32122, "category": "missionary", "quantity": 1}], "amount": 32122, "status": "PAID", "created": "2025-02-28T03:22:31.385Z", "is_high": false, "paid_at": "2025-02-28T03:22:56.161Z", "updated": "2025-02-28T03:22:56.162Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "pymt-e7cdfff6-8b43-4c4c-9e74-459a94156f1d", "description": "Donation to Missionary", "external_id": "m_DmE8Kgn91u", "paid_amount": 32122, "payer_email": "cfet@example.com", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "RETAIL_OUTLET", "payment_channel": "DP_ECPAY_LOAN", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=m_DmE8Kgn91u", "success_redirect_url": "http://localhost:3000/donation/success?ref=m_DmE8Kgn91u"}}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 03:22:30.421756+00	2025-02-28 03:22:30.421756+00	2025-03-01 03:22:31.271+00	2025-02-28 03:22:57.521+00
fc22603c-77e7-42f8-903e-9cd45df8a1b8	m_7JeubGBJ6r	67c12c04e122203103a83760	https://checkout-staging.xendit.co/web/67c12c04e122203103a83760	paid	1122.00	\N	PHP	RETAIL_OUTLET	7ELEVEN	{"date": "2025-02-28T03:22:43.638Z", "donors": [{"amount": 1122, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true, "xenditResponse": {"id": "67c12c04e122203103a83760", "amount": 1122, "status": "PAID", "created": "2025-02-28T03:22:44.614Z", "is_high": false, "paid_at": "2025-02-28T03:22:58.281Z", "updated": "2025-02-28T03:22:58.282Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "pymt-db71838a-a520-4096-b99f-0885ae166487", "description": "Donation to Missionary", "external_id": "m_7JeubGBJ6r", "paid_amount": 1122, "payer_email": "missionary@gmail.com", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "RETAIL_OUTLET", "payment_channel": "7ELEVEN", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=m_7JeubGBJ6r", "success_redirect_url": "http://localhost:3000/donation/success?ref=m_7JeubGBJ6r"}}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 03:22:43.63907+00	2025-02-28 03:22:43.63907+00	2025-03-01 03:22:44.409+00	2025-02-28 03:22:59.015+00
7e43450e-2d6d-4d0a-bcb1-6e299e5bdbf0	702_1740713253449	67c12d26e12220f4b8a839dd	https://checkout-staging.xendit.co/web/67c12d26e12220f4b8a839dd	pending	32122.00	\N	PHP	\N	\N	{"date": "2025-02-28T03:27:33.449Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary"}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 03:27:33.459118+00	2025-02-28 03:27:33.459118+00	2025-03-01 03:27:34.496+00	\N
ef2065cb-7bbe-4bc9-8717-43e64b320e72	703_1740713524241	67c12e35604981e46895ac80	https://checkout-staging.xendit.co/web/67c12e35604981e46895ac80	paid	2000.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-28T03:32:04.241Z", "donors": [{"amount": 2000, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true, "xenditResponse": {"id": "67c12e35604981e46895ac80", "amount": 2000, "status": "PAID", "created": "2025-02-28T03:32:05.113Z", "is_high": false, "paid_at": "2025-02-28T03:32:09.417Z", "updated": "2025-02-28T03:32:11.761Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_a6cada23-e5f2-4308-8721-574779256235", "description": "Donation to Missionary", "external_id": "703_1740713524241", "paid_amount": 2000, "payer_email": "missionary@gmail.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-8d6ddfcf-68a3-465f-aefd-a0b35d0ecae4", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=703_1740713524241", "success_redirect_url": "http://localhost:3000/donation/success?ref=703_1740713524241"}}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 03:32:04.244115+00	2025-02-28 03:32:04.244115+00	2025-03-01 03:32:05.006+00	2025-02-28 03:32:12.245+00
87b731d7-19e4-40c7-a4a8-5bcb6f019d9a	703_1740713824132	67c12f60604981211495aede	https://checkout-staging.xendit.co/web/67c12f60604981211495aede	paid	22213.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-28T03:37:04.132Z", "donors": [{"amount": 22213, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true, "xenditResponse": {"id": "67c12f60604981211495aede", "amount": 22213, "status": "PAID", "created": "2025-02-28T03:37:04.909Z", "is_high": false, "paid_at": "2025-02-28T03:37:14.452Z", "updated": "2025-02-28T03:37:18.438Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_b80333b9-6e93-4870-b986-d3329b534d55", "description": "Donation to Missionary", "external_id": "703_1740713824132", "paid_amount": 22213, "payer_email": "missionary@gmail.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-f1f92367-cdf3-49d2-8ab8-f7ef27121472", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=703_1740713824132", "success_redirect_url": "http://localhost:3000/donation/success?ref=703_1740713824132"}}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 03:37:04.134686+00	2025-02-28 03:37:04.134686+00	2025-03-01 03:37:04.837+00	2025-02-28 03:37:18.798+00
32ec8758-83ad-497f-8155-f1f5a09f8143	703_1740714585886	67c1325ae122205767a8442a	https://checkout-staging.xendit.co/web/67c1325ae122205767a8442a	paid	1122.00	\N	PHP	RETAIL_OUTLET	CEBUANA	{"date": "2025-02-28T03:49:45.886Z", "donors": [{"amount": 1122, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true, "xenditResponse": {"id": "67c1325ae122205767a8442a", "amount": 1122, "status": "PAID", "created": "2025-02-28T03:49:46.905Z", "is_high": false, "paid_at": "2025-02-28T03:49:53.240Z", "updated": "2025-02-28T03:49:53.241Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "pymt-51e60c7a-a91e-4374-a94c-b9c7eca3e915", "description": "Donation to Missionary", "external_id": "703_1740714585886", "paid_amount": 1122, "payer_email": "missionary@gmail.com", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "RETAIL_OUTLET", "payment_channel": "CEBUANA", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=703_1740714585886", "success_redirect_url": "http://localhost:3000/donation/success?ref=703_1740714585886"}}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 03:49:45.887998+00	2025-02-28 03:49:45.887998+00	2025-03-01 03:49:46.755+00	2025-02-28 03:49:53.709+00
00f77510-2331-4c35-b703-8ddadbe6aa01	699_1740714735603	67c132f06049817e0a95b55d	https://checkout-staging.xendit.co/web/67c132f06049817e0a95b55d	paid	11231.00	\N	PHP	RETAIL_OUTLET	DP_MLHUILLIER	{"date": "2025-02-28T03:52:15.603Z", "donors": [{"amount": 11231, "donorId": "604", "donorName": "Reb Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true, "xenditResponse": {"id": "67c132f06049817e0a95b55d", "amount": 11231, "status": "PAID", "created": "2025-02-28T03:52:16.346Z", "is_high": false, "paid_at": "2025-02-28T03:52:22.340Z", "updated": "2025-02-28T03:52:22.341Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "pymt-e124c2d7-fbf4-46f0-afc8-38a3932d1022", "description": "Donation to Campus Director", "external_id": "699_1740714735603", "paid_amount": 11231, "payer_email": "cd@gmail.com", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "RETAIL_OUTLET", "payment_channel": "DP_MLHUILLIER", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=699_1740714735603", "success_redirect_url": "http://localhost:3000/donation/success?ref=699_1740714735603"}}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 03:52:15.604979+00	2025-02-28 03:52:15.604979+00	2025-03-01 03:52:16.32+00	2025-02-28 03:52:23.023+00
d0902499-3ec1-4188-ab9f-fc78ae4d90fa	699_1740714933714	67c133b6604981279095b6e8	https://checkout-staging.xendit.co/web/67c133b6604981279095b6e8	paid	9109.00	\N	PHP	RETAIL_OUTLET	DP_ECPAY_LOAN	{"date": "2025-02-28T03:55:33.714Z", "donors": [{"amount": 9109, "donorId": "604", "donorName": "Reb Guevarra"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true, "xenditResponse": {"id": "67c133b6604981279095b6e8", "amount": 9109, "status": "PAID", "created": "2025-02-28T03:55:34.559Z", "is_high": false, "paid_at": "2025-02-28T03:55:41.449Z", "updated": "2025-02-28T03:55:41.450Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "pymt-853e114c-bd7d-457e-baed-ea51d3f5c224", "description": "Donation to Campus Director", "external_id": "699_1740714933714", "paid_amount": 9109, "payer_email": "cd@gmail.com", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "RETAIL_OUTLET", "payment_channel": "DP_ECPAY_LOAN", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=699_1740714933714", "success_redirect_url": "http://localhost:3000/donation/success?ref=699_1740714933714"}}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 03:55:33.716272+00	2025-02-28 03:55:33.716272+00	2025-03-01 03:55:34.523+00	2025-02-28 03:55:42.424+00
1133ff5f-78e3-48bc-af98-812ac8143314	699_1740721907575	67c14ef4e12220b26aa88c9c	https://checkout-staging.xendit.co/web/67c14ef4e12220b26aa88c9c	paid	2131.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-28T05:51:47.575Z", "donors": [{"amount": 2131, "donorId": "673", "donorName": "Rob G"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true, "xenditResponse": {"id": "67c14ef4e12220b26aa88c9c", "amount": 2131, "status": "PAID", "created": "2025-02-28T05:51:48.380Z", "is_high": false, "paid_at": "2025-02-28T05:51:52.973Z", "updated": "2025-02-28T05:51:54.991Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_8d0b392c-f62f-4847-85f7-a5a6d5d826d4", "description": "Donation to Campus Director", "external_id": "699_1740721907575", "paid_amount": 2131, "payer_email": "cd@gmail.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-1e8ad307-fde6-413c-9499-3163ed3e2bd1", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=699_1740721907575", "success_redirect_url": "http://localhost:3000/donation/success?ref=699_1740721907575"}}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 05:51:47.580433+00	2025-02-28 05:51:47.580433+00	2025-03-01 05:51:48.362+00	2025-02-28 05:51:55.954+00
c8da495c-4d65-48af-b33b-97bbc445cfd1	699_1740721974484	67c14f3660498180ef95f95c	https://checkout-staging.xendit.co/web/67c14f3660498180ef95f95c	pending	2000.00	\N	PHP	\N	\N	{"date": "2025-02-28T05:52:54.484Z", "donors": [{"amount": 2000, "donorId": "673", "donorName": "Rob G"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 05:52:54.489342+00	2025-02-28 05:52:54.489342+00	2025-03-01 05:52:55.197+00	\N
91d8d74d-25f8-42d1-9d13-b7333add94ae	699_1740724956042	67c15adce12220fd34a8aad4	https://checkout-staging.xendit.co/web/67c15adce12220fd34a8aad4	paid	909.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-28T06:42:36.042Z", "donors": [{"email": "fae112@gacc.com", "amount": 909, "donorId": "722", "donorName": "ffae12"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true, "xenditResponse": {"id": "67c15adce12220fd34a8aad4", "amount": 909, "status": "PAID", "created": "2025-02-28T06:42:36.713Z", "is_high": false, "paid_at": "2025-02-28T06:42:43.231Z", "updated": "2025-02-28T06:42:46.598Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_d11046dc-65ca-4135-90d0-90fe64241635", "description": "Donation to Campus Director", "external_id": "699_1740724956042", "paid_amount": 909, "payer_email": "cd@gmail.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-8fb71422-6c22-4c2e-9fb0-7c733034e9cd", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=699_1740724956042", "success_redirect_url": "http://localhost:3000/donation/success?ref=699_1740724956042"}}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 06:42:36.045236+00	2025-02-28 06:42:36.045236+00	2025-03-01 06:42:36.641+00	2025-02-28 06:42:48.052+00
dd33e7cd-963e-45c0-bd41-334e4db2b2eb	699_1740725004605	67c15b0d60498118a996194d	https://checkout-staging.xendit.co/web/67c15b0d60498118a996194d	paid	9099.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-28T06:43:24.605Z", "donors": [{"amount": 999, "donorId": "673", "donorName": "Rob G"}, {"email": "popp@gmai.com", "amount": 8100, "donorId": "723", "donorName": "jepoo"}], "donorId": 699, "isAnonymous": false, "recipientId": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "donationType": "missionary", "recipientName": "Campus Director", "isBulkDonation": true, "xenditResponse": {"id": "67c15b0d60498118a996194d", "amount": 9099, "status": "PAID", "created": "2025-02-28T06:43:25.392Z", "is_high": false, "paid_at": "2025-02-28T06:43:28.105Z", "updated": "2025-02-28T06:43:29.578Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_2e21d53f-320c-4557-ad30-ce7034372523", "description": "Donation to Campus Director", "external_id": "699_1740725004605", "paid_amount": 9099, "payer_email": "cd@gmail.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-c78094c8-0f25-41dd-9064-ee909ba3fe2d", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=699_1740725004605", "success_redirect_url": "http://localhost:3000/donation/success?ref=699_1740725004605"}}	cd@gmail.com	Campus Director	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 06:43:24.607776+00	2025-02-28 06:43:24.607776+00	2025-03-01 06:43:25.263+00	2025-02-28 06:43:30.09+00
f0c7e053-2261-4171-97c9-034fae67f898	702_1740725828523	67c15e44604981996b961fb4	https://checkout-staging.xendit.co/web/67c15e44604981996b961fb4	paid	32122.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-28T06:57:08.523Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c15e44604981996b961fb4", "items": [{"name": "Donation to Missionary", "price": 32122, "category": "missionary", "quantity": 1}], "amount": 32122, "status": "PAID", "created": "2025-02-28T06:57:09.276Z", "is_high": false, "paid_at": "2025-02-28T06:57:23.084Z", "updated": "2025-02-28T06:57:25.167Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_c21a8e06-6991-408a-ace8-7a498ebc5c7e", "description": "Donation to Missionary", "external_id": "702_1740725828523", "paid_amount": 32122, "payer_email": "cfet@example.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-dd262ea7-dffb-421e-94a3-978f5dd10b81", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=702_1740725828523", "success_redirect_url": "http://localhost:3000/donation/success?ref=702_1740725828523"}}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 06:57:08.533235+00	2025-02-28 06:57:08.533235+00	2025-03-01 06:57:09.111+00	2025-02-28 06:57:26.414+00
ea06974f-cafb-491c-8e21-0597046b86a8	703_1740725941980	67c15eb6e12220e910a8b385	https://checkout-staging.xendit.co/web/67c15eb6e12220e910a8b385	paid	9999.00	\N	PHP	EWALLET	GCASH	{"date": "2025-02-28T06:59:01.980Z", "donors": [{"amount": 9999, "donorId": "673", "donorName": "Rob G"}], "donorId": 703, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "recipientName": "Missionary", "isBulkDonation": true, "xenditResponse": {"id": "67c15eb6e12220e910a8b385", "amount": 9999, "status": "PAID", "created": "2025-02-28T06:59:02.715Z", "is_high": false, "paid_at": "2025-02-28T06:59:06.703Z", "updated": "2025-02-28T06:59:12.135Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_8c719fe4-2642-4d39-b291-3c34c7e31aba", "description": "Donation to Missionary", "external_id": "703_1740725941980", "paid_amount": 9999, "payer_email": "missionary@gmail.com", "ewallet_type": "GCASH", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GCASH", "payment_method_id": "pm-a9c3ae48-72c4-45e6-865d-23be6cc1fde6", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=703_1740725941980", "success_redirect_url": "http://localhost:3000/donation/success?ref=703_1740725941980"}}	missionary@gmail.com	Missionary	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 06:59:01.98424+00	2025-02-28 06:59:01.98424+00	2025-03-01 06:59:02.549+00	2025-02-28 06:59:13.622+00
181ef7e7-fe71-40c4-8578-8cd3b2557ed5	702_1740726482327	67c160d2604981584096252f	https://checkout-staging.xendit.co/web/67c160d2604981584096252f	paid	9898.00	\N	PHP	EWALLET	GRABPAY	{"date": "2025-02-28T07:08:02.327Z", "donorId": 702, "isAnonymous": false, "recipientId": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "donationType": "missionary", "xenditResponse": {"id": "67c160d2604981584096252f", "items": [{"name": "Donation to Missionary", "price": 9898, "category": "missionary", "quantity": 1}], "amount": 9898, "status": "PAID", "created": "2025-02-28T07:08:03.132Z", "is_high": false, "paid_at": "2025-02-28T07:08:15.609Z", "updated": "2025-02-28T07:08:17.516Z", "user_id": "6725eb31fad762caaa849a76", "currency": "PHP", "payment_id": "ewc_82cf8073-4b7f-4ebb-a4ac-204a4d184b63", "description": "Donation to Missionary", "external_id": "702_1740726482327", "paid_amount": 9898, "payer_email": "cfet@example.com", "ewallet_type": "GRABPAY", "merchant_name": "Victory Bulacan Incorporated", "payment_method": "EWALLET", "payment_channel": "GRABPAY", "payment_method_id": "pm-510e3dfc-c77c-4c6e-b0dc-c480f79252ab", "failure_redirect_url": "http://localhost:3000/donation/failed?ref=702_1740726482327", "success_redirect_url": "http://localhost:3000/donation/success?ref=702_1740726482327"}}	cfet@example.com	hing	fa5060a6-3996-46ea-ae5f-bd3fed7e251a	2025-02-28 07:08:02.337476+00	2025-02-28 07:08:02.337476+00	2025-03-01 07:08:03.112+00	2025-02-28 07:08:18.771+00
\.


--
-- Data for Name: invoice_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoice_items (id, invoice_id, donation_id, amount, missionary_id, donor_id, created_at) FROM stdin;
bc22dc7a-8e4b-43c7-a30d-141ea7f41adb	67c12d26e12220f4b8a839dd	\N	32122.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 03:27:33.467338+00
07662bd9-f43f-4501-a711-bdf0b589dc63	67c15e44604981996b961fb4	\N	32122.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 06:57:08.542153+00
f35c26bd-214f-4711-bccb-c4da49bb35f6	67c160d2604981584096252f	\N	9898.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 07:08:02.347117+00
cb2a660f-40ce-4c5c-8069-58b1ebf86faf	67c040af6049815fe793f465	\N	3325.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	693	2025-02-27 10:38:39.352003+00
3308026d-c39e-45e4-bbad-e86bc51d56e4	67c04260e12220e1dca68be8	\N	4444.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	693	2025-02-27 10:45:52.156806+00
9a7c2aa0-c324-4cfd-9f74-6a1d1eef3a68	67c081c460498127ee9471b1	\N	9898.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	694	2025-02-27 15:16:20.08179+00
54d16e2d-3538-44af-beb3-1d4aa1ab8bba	67c08709604981f184947b3b	\N	3233.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	695	2025-02-27 15:38:49.263419+00
54732ca2-cec5-4dd4-83c3-f654264efd99	67c08aade122205b21a715c6	\N	124.00	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	696	2025-02-27 15:54:20.351519+00
b5e9ea4b-1ceb-43fd-a540-b29a58e0696f	67c0984ee122202864a72f33	\N	4411.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	695	2025-02-27 16:52:29.843983+00
a58d47db-0ebf-4394-bd1d-74685d898887	67c09f00e122206ff2a73c0b	\N	44112.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	695	2025-02-27 17:21:03.178452+00
dd894ffc-1118-4061-ae80-9762b2da5fd9	67c0ad09e122205f87a753c5	\N	441412.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	695	2025-02-27 18:20:56.761815+00
eb23dc32-448c-42af-bc19-7848ec981c90	67c10ee3e122202b1aa7fd8a	\N	9199.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	700	2025-02-28 01:18:26.636241+00
9b486bf7-79d4-418d-b403-bea7273d8c97	67c1123360498139ac957410	\N	9199.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	700	2025-02-28 01:32:34.77934+00
939453f3-c9f7-482a-9093-de8d3f4176ae	67c113d46049814df0957731	\N	9199.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	700	2025-02-28 01:39:31.556975+00
12eb1574-6ec1-4e4c-b47d-39714f67545e	67c11531e122208d7aa808f0	\N	99.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	700	2025-02-28 01:45:20.696055+00
cf80455e-a796-4f22-8626-5d53e65e2b35	67c115f9e12220a275a80a56	\N	99.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	700	2025-02-28 01:48:40.746714+00
e857b3df-eca2-4e8a-8165-4657e343be1c	67c116906049812819957be3	\N	99.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	700	2025-02-28 01:51:11.849465+00
ee0319a0-9a0e-44bf-a080-98a7fc6c97fe	67c1169e6049815551957c15	\N	9999.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	700	2025-02-28 01:51:25.739991+00
fc044795-6d13-4b37-9a0c-13c28a4e4aa5	67c117f36049811314957eab	\N	9999.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	700	2025-02-28 01:57:07.43839+00
fe413cd9-3324-43e2-b7e0-302e13e2942e	67c118166049819ba6957ed7	\N	2223.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 01:57:42.019008+00
3176b848-4b62-4387-8bf2-73321a5220b0	\N	\N	22243.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:01:56.251892+00
0e5b5c13-8031-4117-bdbc-895e8ffb612a	67c11992e122203740a8119c	\N	22243.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:04:02.000436+00
045fb394-e7a0-44c8-9013-4ffc7cd31986	67c11a29e12220857ea81306	\N	2143.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:06:32.652122+00
85d47f36-cf60-4dd1-92a0-d96ba3bd0a55	67c11cd6e122207a25a8183b	\N	2143.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:17:58.204889+00
a48d22a9-6c71-4283-97f5-e12713da3bdc	\N	\N	2143.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:19:28.423986+00
f6e8fb3c-3665-42fa-bee3-b40e116c6c48	67c11df36049818d2d958aa5	\N	2143.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:22:42.949612+00
55b2ae78-1550-4b09-a3c1-719ff44db1c8	\N	\N	2143.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:25:01.801598+00
8c791673-42a6-46bd-b9cd-f8ff7c36046a	67c11e81e122205df4a81b95	\N	2143.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:25:05.281186+00
f0f55587-9371-411f-b289-9fd7081d9f2a	67c11e83604981014a958bd0	\N	2143.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:25:07.250631+00
0f87328c-d988-44d2-85d9-1129420f1fcc	67c11e85e122205feea81ba8	\N	2143.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:25:08.69172+00
f747ea05-d574-41c8-8497-878ed97adc9b	67c11e95e12220a48ca81bca	\N	212243.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:25:25.266486+00
ad090933-ec2b-4779-9a67-8947efdd90e4	67c11f30604981820b958d3b	\N	212243.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:27:59.594894+00
065da957-20b8-473d-b0f7-57a2a9d6a6a8	67c11f3e604981144f958d5d	\N	2143.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:28:14.083222+00
d0a773b8-9d9d-4c48-a009-036fffcd2aaa	\N	\N	21243.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:29:54.223869+00
abbe240f-d375-4de1-85b1-82413f5fa003	67c1203260498145b6958f5e	\N	21243.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:32:18.30951+00
f172be37-b444-43a4-9b9a-3d85ccafe825	67c121b1e12220904ca82152	\N	21243.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:38:40.871095+00
b936004c-b338-46ea-8a83-04cbd8611b75	67c121d760498182b89592fe	\N	21243.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:39:18.415461+00
bcb091b8-e065-49df-bb57-99e9ce3cbbaa	67c121e0e122204614a821bd	\N	21243.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:39:27.795823+00
36791fd6-3931-468b-9aa5-158ed4733bab	67c1222e604981a59d9593b1	\N	2222.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:40:46.030489+00
5f0eff38-190b-44dd-b8e5-acfa5c2a91e4	67c122396049810ed79593bd	\N	2222.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:40:56.753109+00
2fffa9f0-c323-4863-9c4d-90d77265ff2e	67c12272e122207f3ca822a7	\N	2222.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:41:53.945903+00
a959ecbc-c1c1-4169-8064-29cb6e2037db	67c12282e122209e8aa822d1	\N	2222.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:42:09.965169+00
64690b07-5228-4986-ad78-fd1ab783a001	67c1232ce12220eb81a823e4	\N	2222.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:44:59.314895+00
b4d8a263-81c4-469f-988e-2ff792a29213	67c123386049810e129595fb	\N	2222.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:45:11.381057+00
3b11babb-1488-4bbf-b25e-5b77b4aaa836	67c1239460498134ff959678	\N	12122.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:46:44.340223+00
3d0f6f6d-e182-436d-b7ec-6745c9b224e5	67c123cbe1222007eda82598	\N	22122.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 02:47:38.874058+00
09f0657c-ff72-4a08-844d-b3fcd600add2	67c1298c604981216495a311	\N	22122.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 03:12:12.136202+00
76f103de-995c-4f97-842b-cb683ac9b926	67c12a41e12220580fa833dd	\N	12122.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 03:15:13.161615+00
6c0afbae-317d-4a83-beef-36d219c5ed3f	67c12bf760498196d795a7a8	\N	32122.00	aefe15fe-4937-4f55-a6cb-fb8d739c5905	702	2025-02-28 03:22:30.430473+00
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
236	aefe15fe-4937-4f55-a6cb-fb8d739c5905	2025-02-27	2025-02-28	ffaaa	pending	none	none	2025-02-26 10:19:01.736136+00	2025-02-26 10:19:01.736136+00	vacation	\N	\N
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
202	aefe15fe-4937-4f55-a6cb-fb8d739c5905	2025-02-25	2025-02-28	hhaaafg12	approved	none	approved	2025-02-25 06:34:39.910666+00	2025-02-25 06:34:39.910666+00	vacation	\N	\N
203	94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb	2025-02-27	2025-03-01	009900	pending	none	none	2025-02-25 16:24:54.369319+00	2025-02-25 16:24:54.369319+00	sick	\N	\N
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
-- Data for Name: webhook_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.webhook_logs (id, payload, created_at) FROM stdin;
\.


--
-- Data for Name: messages_2025_02_16; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.messages_2025_02_16 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_02_17; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.messages_2025_02_17 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_02_18; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.messages_2025_02_18 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_02_19; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.messages_2025_02_19 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_02_20; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.messages_2025_02_20 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_02_21; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.messages_2025_02_21 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2025_02_22; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.messages_2025_02_22 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-02-21 14:12:31
20211116045059	2025-02-21 14:12:31
20211116050929	2025-02-21 14:12:31
20211116051442	2025-02-21 14:12:31
20211116212300	2025-02-21 14:12:31
20211116213355	2025-02-21 14:12:31
20211116213934	2025-02-21 14:12:31
20211116214523	2025-02-21 14:12:31
20211122062447	2025-02-21 14:12:31
20211124070109	2025-02-21 14:12:31
20211202204204	2025-02-21 14:12:31
20211202204605	2025-02-21 14:12:31
20211210212804	2025-02-21 14:12:32
20211228014915	2025-02-21 14:12:32
20220107221237	2025-02-21 14:12:32
20220228202821	2025-02-21 14:12:32
20220312004840	2025-02-21 14:12:32
20220603231003	2025-02-21 14:12:32
20220603232444	2025-02-21 14:12:32
20220615214548	2025-02-21 14:12:32
20220712093339	2025-02-21 14:12:32
20220908172859	2025-02-21 14:12:32
20220916233421	2025-02-21 14:12:32
20230119133233	2025-02-21 14:12:32
20230128025114	2025-02-21 14:12:32
20230128025212	2025-02-21 14:12:32
20230227211149	2025-02-21 14:12:32
20230228184745	2025-02-21 14:12:32
20230308225145	2025-02-21 14:12:32
20230328144023	2025-02-21 14:12:32
20231018144023	2025-02-21 14:12:32
20231204144023	2025-02-21 14:12:32
20231204144024	2025-02-21 14:12:32
20231204144025	2025-02-21 14:12:32
20240108234812	2025-02-21 14:12:32
20240109165339	2025-02-21 14:12:32
20240227174441	2025-02-21 14:12:32
20240311171622	2025-02-21 14:12:32
20240321100241	2025-02-21 14:12:32
20240401105812	2025-02-21 14:12:32
20240418121054	2025-02-21 14:12:32
20240523004032	2025-02-21 14:12:32
20240618124746	2025-02-21 14:12:32
20240801235015	2025-02-21 14:12:32
20240805133720	2025-02-21 14:12:32
20240827160934	2025-02-21 14:12:32
20240919163303	2025-02-21 14:12:32
20240919163305	2025-02-21 14:12:32
20241019105805	2025-02-21 14:12:32
20241030150047	2025-02-21 14:12:32
20241108114728	2025-02-21 14:12:32
20241121104152	2025-02-21 14:12:32
20241130184212	2025-02-21 14:12:32
20241220035512	2025-02-21 14:12:32
20241220123912	2025-02-21 14:12:32
20241224161212	2025-02-21 14:12:32
20250107150512	2025-02-21 14:12:32
20250110162412	2025-02-21 14:12:32
20250123174212	2025-02-21 14:12:32
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
20250208123027	{"-- Drop policies if they exist\nDO $$ BEGIN\n    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'select_own_donations' AND tablename = 'donations') THEN\n        DROP POLICY \\"select_own_donations\\" ON \\"public\\".\\"donations\\";\n    END IF;\n    \n    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'insert_leave_requests' AND tablename = 'leave_requests') THEN\n        DROP POLICY \\"insert_leave_requests\\" ON \\"public\\".\\"leave_requests\\";\n    END IF;\n    \n    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'insert_surplus_requests' AND tablename = 'surplus_requests') THEN\n        DROP POLICY \\"insert_surplus_requests\\" ON \\"public\\".\\"surplus_requests\\";\n    END IF;\n    \n    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'select_surplus_requests' AND tablename = 'surplus_requests') THEN\n        DROP POLICY \\"select_surplus_requests\\" ON \\"public\\".\\"surplus_requests\\";\n    END IF;\n    \n    IF EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'select_own_profile' AND tablename = 'profiles') THEN\n        DROP POLICY \\"select_own_profile\\" ON \\"public\\".\\"profiles\\";\n    END IF;\nEND $$","-- Revoke permissions if table exists\nDO $$ BEGIN\n    IF EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'donations' AND schemaname = 'public') THEN\n        REVOKE ALL ON TABLE \\"public\\".\\"donations\\" FROM \\"anon\\", \\"authenticated\\", \\"service_role\\";\n        \n        -- Drop constraints if they exist\n        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'donations_created_by_fkey') THEN\n            ALTER TABLE \\"public\\".\\"donations\\" DROP CONSTRAINT \\"donations_created_by_fkey\\";\n        END IF;\n        \n        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'donations_missionary_id_fkey') THEN\n            ALTER TABLE \\"public\\".\\"donations\\" DROP CONSTRAINT \\"donations_missionary_id_fkey\\";\n        END IF;\n        \n        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'donations_source_check') THEN\n            ALTER TABLE \\"public\\".\\"donations\\" DROP CONSTRAINT \\"donations_source_check\\";\n        END IF;\n        \n        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'donations_status_check') THEN\n            ALTER TABLE \\"public\\".\\"donations\\" DROP CONSTRAINT \\"donations_status_check\\";\n        END IF;\n        \n        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_missionary') THEN\n            ALTER TABLE \\"public\\".\\"donations\\" DROP CONSTRAINT \\"fk_missionary\\";\n        END IF;\n        \n        IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'donations_pkey') THEN\n            ALTER TABLE \\"public\\".\\"donations\\" DROP CONSTRAINT \\"donations_pkey\\";\n        END IF;\n        \n        -- Drop indexes\n        DROP INDEX IF EXISTS \\"public\\".\\"donations_pkey\\";\n        DROP INDEX IF EXISTS \\"public\\".\\"idx_missionary_id\\";\n        \n        -- Drop the table\n        DROP TABLE \\"public\\".\\"donations\\";\n    END IF;\nEND $$","-- Drop sequence if exists\nDROP SEQUENCE IF EXISTS \\"public\\".\\"donations_id_seq\\"","-- Add columns and constraints to existing tables\nALTER TABLE \\"public\\".\\"leave_requests\\" ADD COLUMN IF NOT EXISTS \\"lead_pastor_notes\\" text","ALTER TABLE \\"public\\".\\"leave_requests\\" DISABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"surplus_requests\\" ADD COLUMN IF NOT EXISTS \\"lead_pastor_notes\\" text","-- Add constraints with existence checks\nDO $$ BEGIN\n    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'leave_requests_lead_pastor_approval_check') THEN\n        ALTER TABLE \\"public\\".\\"leave_requests\\" ADD CONSTRAINT \\"leave_requests_lead_pastor_approval_check\\" \n        CHECK ((lead_pastor_approval = ANY (ARRAY['none'::text, 'approved'::text, 'rejected'::text, 'override-approved'::text, 'override-rejected'::text]))) NOT VALID;\n        \n        ALTER TABLE \\"public\\".\\"leave_requests\\" VALIDATE CONSTRAINT \\"leave_requests_lead_pastor_approval_check\\";\n    END IF;\n    \n    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'surplus_requests_lead_pastor_approval_check') THEN\n        ALTER TABLE \\"public\\".\\"surplus_requests\\" ADD CONSTRAINT \\"surplus_requests_lead_pastor_approval_check\\" \n        CHECK ((lead_pastor_approval = ANY (ARRAY['none'::text, 'approved'::text, 'rejected'::text, 'override-approved'::text, 'override-rejected'::text]))) NOT VALID;\n        \n        ALTER TABLE \\"public\\".\\"surplus_requests\\" VALIDATE CONSTRAINT \\"surplus_requests_lead_pastor_approval_check\\";\n    END IF;\nEND $$","-- Create policies\nDO $$ BEGIN\n    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'insert_own_leave_requests' AND tablename = 'leave_requests') THEN\n        CREATE POLICY \\"insert_own_leave_requests\\"\n        ON \\"public\\".\\"leave_requests\\"\n        AS permissive\n        FOR insert\n        TO public\n        WITH CHECK (((requester_id = auth.uid()) OR (( SELECT profiles.role\n           FROM profiles\n          WHERE (profiles.id = auth.uid())) = 'superadmin'::text)));\n    END IF;\n    \n    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'Enable read access for all users' AND tablename = 'profiles') THEN\n        CREATE POLICY \\"Enable read access for all users\\"\n        ON \\"public\\".\\"profiles\\"\n        AS permissive\n        FOR select\n        TO public\n        USING (((id = auth.uid()) OR (auth.email() = 'robneil@gmail.com'::text)));\n    END IF;\n    \n    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'insert_own_surplus_requests' AND tablename = 'surplus_requests') THEN\n        CREATE POLICY \\"insert_own_surplus_requests\\"\n        ON \\"public\\".\\"surplus_requests\\"\n        AS permissive\n        FOR insert\n        TO public\n        WITH CHECK ((missionary_id = auth.uid()));\n    END IF;\n    \n    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'select_own_surplus_requests' AND tablename = 'surplus_requests') THEN\n        CREATE POLICY \\"select_own_surplus_requests\\"\n        ON \\"public\\".\\"surplus_requests\\"\n        AS permissive\n        FOR select\n        TO public\n        USING ((missionary_id = auth.uid()));\n    END IF;\n    \n    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE policyname = 'select_own_profile' AND tablename = 'profiles') THEN\n        CREATE POLICY \\"select_own_profile\\"\n        ON \\"public\\".\\"profiles\\"\n        AS permissive\n        FOR select\n        TO public\n        USING (((id = auth.uid()) OR (auth.uid() = 'aebdeee3-427f-4d5b-832d-8c4ebaecdddc'::uuid)));\n    END IF;\nEND $$"}	feb8-current_db_state
20250208145227	{"DO $$ \nBEGIN\n    IF NOT EXISTS (\n        SELECT 1 \n        FROM information_schema.columns \n        WHERE table_schema = 'public' \n        AND table_name = 'donor_donations' \n        AND column_name = 'notes'\n    ) THEN\n        ALTER TABLE \\"public\\".\\"donor_donations\\" ADD COLUMN \\"notes\\" text;\n    END IF;\nEND $$"}	feb8-current_db_statev2
20250225140632	{"-- Create materialized view for missionary monthly stats\r\nCREATE MATERIALIZED VIEW IF NOT EXISTS missionary_monthly_stats AS\r\nWITH monthly_donations AS (\r\n  SELECT \r\n    missionary_id,\r\n    to_char(date_trunc('month', date), 'YYYY-MM') as month,\r\n    SUM(amount) as total_donations\r\n  FROM donor_donations \r\n  WHERE status = 'completed'\r\n  GROUP BY missionary_id, to_char(date_trunc('month', date), 'YYYY-MM')\r\n)\r\nSELECT \r\n  p.id as missionary_id,\r\n  p.monthly_goal,\r\n  md.month,\r\n  COALESCE(md.total_donations, 0) as total_donations,\r\n  CASE \r\n    WHEN p.monthly_goal > 0 THEN \r\n      ROUND((COALESCE(md.total_donations, 0)::numeric / p.monthly_goal::numeric) * 100, 2)\r\n    ELSE 0\r\n  END as goal_percentage\r\nFROM profiles p\r\nLEFT JOIN monthly_donations md ON p.id = md.missionary_id\r\nWHERE p.role = 'missionary'","-- Create an index on the month field for better query performance\r\nCREATE INDEX IF NOT EXISTS missionary_monthly_stats_month_idx ON missionary_monthly_stats(month)","-- Create a function to refresh the materialized view\r\nCREATE OR REPLACE FUNCTION refresh_missionary_monthly_stats()\r\nRETURNS trigger\r\nLANGUAGE plpgsql\r\nAS $$\r\nBEGIN\r\n  REFRESH MATERIALIZED VIEW CONCURRENTLY missionary_monthly_stats;\r\n  RETURN NULL;\r\nEND;\r\n$$","-- Create triggers to refresh the view when donations change\r\nDROP TRIGGER IF EXISTS refresh_missionary_stats_on_donation ON donor_donations","CREATE TRIGGER refresh_missionary_stats_on_donation\r\n  AFTER INSERT OR UPDATE OR DELETE\r\n  ON donor_donations\r\n  FOR EACH STATEMENT\r\n  EXECUTE FUNCTION refresh_missionary_monthly_stats()","-- Create trigger to refresh when missionary goals are updated\r\nDROP TRIGGER IF EXISTS refresh_missionary_stats_on_profile ON profiles","CREATE TRIGGER refresh_missionary_stats_on_profile\r\n  AFTER UPDATE OF monthly_goal\r\n  ON profiles\r\n  FOR EACH STATEMENT\r\n  EXECUTE FUNCTION refresh_missionary_monthly_stats()","-- Down Migration\r\n-- DROP TRIGGER IF EXISTS refresh_missionary_stats_on_donation ON donor_donations;\r\n-- DROP TRIGGER IF EXISTS refresh_missionary_stats_on_profile ON profiles;\r\n-- DROP FUNCTION IF EXISTS refresh_missionary_monthly_stats();\r\n-- DROP MATERIALIZED VIEW IF EXISTS missionary_monthly_stats;"}	create_missionary_stats_view
\.


--
-- Data for Name: seed_files; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.seed_files (path, hash) FROM stdin;
supabase/seed.sql	f1043d63f0cd5916fbd23500ea8745472b70763b6389c02f4c3cb023da9d5831
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 484, true);


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

SELECT pg_catalog.setval('public.donor_donations_id_seq', 2122, true);


--
-- Name: donors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.donors_id_seq', 723, true);


--
-- Name: leave_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leave_requests_id_seq', 236, true);


--
-- Name: local_churches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.local_churches_id_seq', 1, false);


--
-- Name: surplus_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.surplus_requests_id_seq', 145, true);


--
-- Name: webhook_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.webhook_logs_id_seq', 1, false);


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

