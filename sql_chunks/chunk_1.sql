BEGIN;
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

INSERT INTO _realtime.extensions VALUES ('8bbf4c46-7893-4864-ac74-b3f0fbf38d24', 'postgres_cdc_rls', '{"region": "us-east-1", "db_host": "kJXKCTyBDOjzVqRzlL8bFKK3IQuQz/MySxNPWLAyhk8=", "db_name": "sWBpZNdjggEPTQVlI52Zfw==", "db_port": "+enMDFi1J/3IrrquHHwUmA==", "db_user": "uxbEq/zz8DXVD53TOI1zmw==", "slot_name": "supabase_realtime_replication_slot", "db_password": "sWBpZNdjggEPTQVlI52Zfw==", "publication": "supabase_realtime", "ssl_enforced": false, "poll_interval_ms": 100, "poll_max_changes": 100, "poll_max_record_bytes": 1048576}', 'realtime-dev', '2025-02-28 01:09:52', '2025-02-28 01:09:52');


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: _realtime; Owner: postgres
--

INSERT INTO _realtime.schema_migrations VALUES (20210706140551, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20220329161857, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20220410212326, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20220506102948, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20220527210857, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20220815211129, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20220815215024, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20220818141501, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20221018173709, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20221102172703, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20221223010058, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20230110180046, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20230810220907, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20230810220924, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20231024094642, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20240306114423, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20240418082835, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20240625211759, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20240704172020, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20240902173232, '2025-02-04 04:08:13');
INSERT INTO _realtime.schema_migrations VALUES (20241106103258, '2025-02-04 04:08:13');


--
-- Data for Name: tenants; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

INSERT INTO _realtime.tenants VALUES ('981d873b-a5a1-412e-ab9e-ab4eb850f0e4', 'realtime-dev', 'realtime-dev', 'iNjicxc4+llvc9wovDvqymwfnj9teWMlyOIbJ8Fh6j2WNU8CIJ2ZgjR6MUIKqSmeDmvpsKLsZ9jgXJmQPpwL8w==', 200, '2025-02-28 01:09:52', '2025-02-28 01:09:52', 100, 'postgres_cdc_rls', 100000, 100, 100, false, '{"keys": [{"k": "c3VwZXItc2VjcmV0LWp3dC10b2tlbi13aXRoLWF0LWxlYXN0LTMyLWNoYXJhY3RlcnMtbG9uZw", "kty": "oct"}]}', false, false);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'ec125e45-8fae-41a0-ac82-b5d462ba801c', '{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-21 15:54:25.650226+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '1f7bf5fd-fdd3-43d9-a78d-39eb94affe58', '{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-21 15:55:23.628063+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '9c87fee5-a15f-492f-983c-1367482e6d9c', '{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-21 15:55:25.534297+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f99d9c68-0f97-40ac-8952-2ef51cf8c4aa', '{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-21 15:56:51.706661+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '0ab91aff-3196-4c41-be67-e58cf23aca75', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-21 15:57:08.078964+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '7d49422a-039b-49dc-b84a-2f47f2c89038', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-21 15:57:14.629808+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f0168392-59d7-48e9-8894-dba6e9cdfa19', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-21 15:57:26.054698+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '224a8a54-c2af-466a-8a05-282f08243af2', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-21 15:57:36.976021+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '230e68bf-c52a-447a-8035-306e1673c581', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 05:34:22.199556+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '16093e1f-7f97-4a65-a848-dacf49e0c5ed', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 06:08:24.289511+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '2abe493f-3285-490d-8484-8239cbd40153', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 06:08:25.793095+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '623275d0-893b-4a65-a545-1c710d12f319', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 06:08:28.634978+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '8af9017d-b468-429c-af44-a193941b5cd0', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 06:08:29.819076+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '295eab51-254a-494a-9f49-fac46261c974', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 06:08:33.269583+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '13e58880-b7b7-48cd-97d6-e1fbb2aaaee9', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 06:08:51.543021+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a1e182cd-be40-44f8-94d5-b9c379ba724d', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 06:09:49.504757+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a8d483cb-d0f3-4779-b3a9-fa69d4883523', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 06:09:51.039963+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '8f8c91eb-0a0f-4a88-9e54-80316e96a14e', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 06:11:19.466311+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '5a4ee70a-17fa-4ffd-8625-cdb3358838f0', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 06:11:20.70089+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '6f5691fd-b180-418a-9ff7-b4154eff35a8', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 06:18:36.361314+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '5d8b566a-80cf-4d37-9cce-3e38d21c8a7c', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 06:18:40.91807+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'e4b5d14f-66ef-477d-8eca-a0987150a1fd', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 06:34:20.924777+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '24851250-9b78-41c5-a628-f14f0e36bf37', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 06:34:25.610718+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '1cc2061b-1309-4f09-be2f-d7db2de73730', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 06:34:41.984032+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '399ecbf0-4441-497f-afcc-5dd1ef2b9ae4', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 06:34:44.891674+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '15b043ff-e078-4e53-b6bb-048944ce64fd', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 06:35:01.457737+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '4060dc28-e0cd-40fb-af61-bd62f3f09d5c', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 06:35:05.043125+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '52d6b857-8bf3-4353-88c1-0a404dda7d85', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 06:35:11.264759+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '32b5f49e-309d-4c9a-ada6-2b6200136d49', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 06:39:09.152513+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '4574dda1-76d4-4003-9bb8-f7d128878e9d', '{"action":"token_refreshed","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-25 07:37:11.666987+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'faad71a6-2146-4d2d-a6e3-8f38cc164da5', '{"action":"token_revoked","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-25 07:37:11.668054+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'e77531bd-c09a-40bb-b7ca-c3fd606b3c19', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 07:44:39.141229+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '82815e1c-909e-4632-bab6-44b001153630', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 07:44:40.560002+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '3ba8d421-8959-4aca-8e27-ad9863491ed6', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 07:51:42.633074+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '00ae889c-01d6-44f5-a587-ca22340f8049', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 07:51:45.625802+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '321762fb-e654-40a9-95b1-a564a47cd62f', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 08:31:09.454657+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '05d8736f-e5d7-4018-b0ce-f4897ea9e431', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 08:31:12.37143+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '605b7fc9-8319-46e7-9a43-579e0620dffc', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 09:18:18.234988+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '8439e0e5-5546-4240-914c-6cc464cffb88', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 09:18:20.734752+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '1688d8b9-cb91-4db4-b7bb-7462138102bd', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 09:18:36.995903+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'de2a8081-51b0-4406-acfa-0211af219188', '{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 09:18:39.605646+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '54100f1a-3d1b-467d-adf4-498dcaa07ca8', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 09:20:29.356924+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '01e6a6e6-0464-46ec-b594-b01b5357e204', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 09:20:31.699713+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'e1616fc7-99a6-4c93-9e22-92f9e5076d88', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 09:20:33.383622+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'ec965f88-462c-4119-8231-a27440dbeede', '{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 09:20:38.728936+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'cdebba60-c426-40f8-bbde-979343d607f2', '{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-25 12:39:04.71026+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a4d66cb4-c232-4d63-b169-d4b9cf077c76', '{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-25 12:39:04.711323+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f77ffbd8-3486-4d3c-a863-707d6a21a54d', '{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-25 13:37:32.156041+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '2b3071b1-b61f-4b62-85cd-cfb1287bd89a', '{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-25 13:37:32.158252+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'e93cf15c-baa8-4d5c-bead-7a7f5a0e4f2f', '{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-25 14:35:59.407991+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'b6acf952-a571-4726-be08-75bb15c90699', '{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-25 14:35:59.40963+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f5feea34-e430-4680-b013-2bd0c9c11004', '{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 09:06:40.785456+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'adceb443-c396-4420-a849-a2baeb304104', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 09:06:43.131958+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'debc137a-2fac-47e8-b4c3-d95515cb9bc5', '{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 09:20:24.059074+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '1cb532de-4eee-44dc-9ba7-501bc96a1552', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 09:20:27.807525+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '3a36bb13-55e6-4c4b-917c-73759bf17c83', '{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 09:29:41.677945+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '749140ff-3a93-4378-aebc-7e503dcfcceb', '{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 09:29:44.713756+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '07419651-05cd-4f6d-9e06-49084b6c5ed5', '{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 09:59:05.742872+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '92d87ad3-c4a6-448e-81f1-49f6d36efad4', '{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 09:59:07.630173+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '6f63cf46-973a-453e-9270-e00bd6c9e02d', '{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-25 15:34:07.497808+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '1b83d730-2e61-4ff2-8faa-6131cbee5059', '{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-25 15:34:07.499344+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '7c18183a-9fd2-461f-92e3-82bf65d56c2d', '{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 15:48:15.040274+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '0fa222f7-e659-419f-942e-f1e830b0551a', '{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 15:48:16.356849+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '0908374e-9ff7-4852-b742-844e7e8aadc0', '{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 16:20:25.378012+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '8da4b591-d6ce-47d7-aa58-e0293144aebd', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 16:20:30.005291+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'd768fa3e-c01a-4220-bfa9-873ec8262ec6', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 16:24:08.299569+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f55f4a3a-8dba-4f7f-91c9-ad6ccace3a43', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 16:24:10.5446+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'dc337e06-6c1b-47ce-ade1-8641ca6325b0', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 16:32:47.429921+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '6eaef101-7efe-4abd-a21b-8d1298769c13', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 16:33:01.528173+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c5b3743e-f7c7-41c4-9b46-4b78c44ab9ab', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-25 16:33:47.999146+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '07f4d641-61df-4241-b838-a41f56d03d96', '{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-25 16:33:51.151776+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '7e4c6760-82e8-4164-9d30-bdc1ca268dfe', '{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-26 03:15:39.647687+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '54f45549-a79b-452a-b903-b98fdac6552e', '{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-26 03:15:39.649602+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '314dac09-3c8c-45c7-9b95-388208bb3c46', '{"action":"token_refreshed","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-26 06:17:38.473718+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '050760b4-669c-4d0d-8f49-050bd00bd23a', '{"action":"token_revoked","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-26 06:17:38.474638+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '90efe266-eb04-4dd9-819d-bd91953f94e4', '{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:20:28.869625+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '49331514-1f82-4ba6-be30-27bdb4216395', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:20:33.416542+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '24b66424-3a73-4191-abed-67694f7a87cf', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:20:56.308978+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f99a5304-2986-4f54-ad2b-c5ad0e82f42d', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:20:59.321568+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '02064edf-ce60-445b-a36f-8bc8c7452068', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:21:03.895148+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'b2448ad5-7bba-4ee3-8f1f-5332a3b7d51a', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:21:08.612876+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'eab213a0-637a-4310-bcfe-9112a4544d33', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:21:30.343418+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'fe73dbc1-afeb-4463-be24-65ee9f10fdab', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:21:32.775938+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'b9a02122-0027-44d6-a1c8-567cacf25980', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:23:48.846881+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '4ad04b79-dc35-424b-a2a4-3c09249edcc4', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:23:50.482609+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'ecc272fc-ef6a-4314-8b98-4e954405be81', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:23:54.017922+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'dced42d2-5c92-48a3-93f3-0b0af15f0c23', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:23:56.519734+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '28071076-d7ad-4045-8b4e-7974e86ad5ba', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:24:30.854184+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f6fd0a5e-daf7-47c9-86d3-b453dd570f51', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:24:33.089203+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'b8a4dfd3-c763-4951-a214-24bb574b1296', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:34:50.183535+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a23a981e-c9e8-4e1b-bcc8-5fa7474e34cf', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:34:53.323031+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'b72281c5-7e35-4995-83a2-9016723492ea', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:35:01.185772+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '986ba13f-c268-4f04-8b59-431846b0a233', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:35:03.13364+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '82b3f712-64cd-4b53-81f2-5cc8f5c7a8e0', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:35:05.098978+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '3132eb8f-e295-487f-aa7f-6b37f7f5767f', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:35:19.507575+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c5ca147b-20c7-4689-bc76-0753f4df14cb', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:35:26.751675+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '74afb69a-705d-45e3-ae45-7eb3e5c3615e', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:35:32.758498+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a3eb66d8-1238-4bfb-ad4c-708bb75edd83', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:35:37.283004+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '282288aa-6276-43f9-afec-36ab51edc7e9', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:35:41.7865+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '566a154d-70df-4ff5-9501-eacd66b96218', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:35:47.111501+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '8034c4a0-bf7f-4e5c-b462-c02d6f026b25', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:41:46.104308+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '5f9739a5-1293-4ff0-a846-89d61dae9fd7', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:41:47.205118+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '023f4b8f-80bd-4857-9e43-5f9e4e61169f', '{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:43:01.826576+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '9b39df37-2c7a-4fef-8102-2ed87a5247a7', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:43:12.531781+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '1a241c36-1f2d-45c3-8b52-d0e83296bd6d', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:43:27.228002+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a75815ac-36e7-4c3a-80c0-627e64946c0e', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:43:29.324045+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '8467ac93-95f8-4448-88db-20f860165f11', '{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:43:30.47816+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a26419a2-9279-4737-8add-5904d28b6f54', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:43:32.315785+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '31459ec7-1165-4fe4-9a71-47db34250031', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:25:03.358695+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'b34407aa-cd29-47ae-9d21-afb382028bdf', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:25:04.813842+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'babaa6fc-7186-437b-a2e6-d2a88ef5ca9a', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:35:06.88883+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '46af0dfa-004a-469e-84d2-a2132283631e', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:35:14.040767+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '2a194366-f430-4f84-99f4-388238de5e07', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:35:17.106149+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '0ffbe53c-2ed9-4579-a9f8-7016e490c982', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:35:18.119915+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'fc62f68d-0157-4318-a1c6-4bf2890d1517', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:35:30.229789+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '18e544ad-dd98-404d-b1c5-9d43a83933b2', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:35:31.313162+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '7c96930c-28a7-4fdb-8bf3-53696f56bf6b', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:36:03.587295+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '5dc96e58-72f4-430f-b54b-b163f5f46153', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:38:14.720917+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '2f386e2d-9e02-4991-a8a0-0755f4fbeb77', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:41:48.981288+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '96210080-ca94-4074-b398-4d0a05506fc4', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:41:49.912466+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '199673d9-8663-482e-bf0f-5797cc175c02', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:42:09.464462+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '2ae6649d-56da-4db3-ac62-eae2fcbfdf70', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:42:10.536446+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '3bd125a8-27d5-4d47-866e-6e889e603699', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:42:54.179586+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '63e04003-7684-4a6d-9086-44bbf73e6381', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:42:56.143535+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '3ce08344-fb59-4c44-bdd4-2874bd66d7e7', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:42:57.502953+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'bda0b7b4-2490-4729-8363-e897dc402164', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:43:00.450113+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a1eb9631-0e81-4635-8505-e3f8825e345a', '{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:43:14.089947+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '28b9c550-6d29-453f-8b09-4678dde25f47', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:43:16.832367+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '4ac2c1e7-746a-450e-ad20-1af33b2828b8', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:43:18.51145+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c4176ced-8a3a-458a-947d-4b064776e3c0', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:43:22.525576+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '07c8833f-3faa-4bca-ac84-a4237562376f', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:43:24.554436+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '2de0d230-39d7-402b-88df-2f15d492fdbf', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:43:25.427582+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '3b495507-d237-4375-b0c6-d12bd1a2b5eb', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:43:43.49671+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '6c898396-9f3f-4383-b67c-8368dce7f6bb', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:45:13.714249+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '68f8268a-c3a3-485b-a56f-a7549f970d8d', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:45:24.128458+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c3504927-e3b2-4549-bc5c-d626843d33d8', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:45:25.178735+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'eeec6ce3-06d4-4746-a7c4-9262a699b5e1', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:47:50.235057+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '1ff35807-ac2e-4623-860e-a70d5a142bd3', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:47:51.623785+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '43c07816-aa9c-486d-b0f9-1fe59e8b57d9', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:47:55.185921+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '5d36c45f-46c0-481d-ba54-165c3245a535', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:47:58.686121+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '73056075-fa9d-49ee-8413-a31a3d812808', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:48:41.523483+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '0333ca2e-e584-4fa4-bd26-5b3c59b9ebe0', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:48:45.337246+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'af76bf87-dc94-40a5-a006-44b3a29d733a', '{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:48:48.649964+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'cbc411d2-bd7e-4d80-b830-10d24d161644', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:50:41.56946+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '66c270ea-a1d2-4ff8-a81a-f5783695bdd4', '{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:50:44.048051+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '938e106d-1578-49f9-83e5-502281dfb5bd', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:51:57.240244+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'fff9fc82-b8cb-41b5-a410-f28604ea3eee', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:51:59.070281+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'dd726109-6e99-450e-92bd-b9a6b38535c5', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:52:00.208379+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'd09fc50e-a4bf-45a6-a588-c97956d4bf1d', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:52:02.097031+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '12dbdcdf-4f33-4b30-b389-3ebfbd89d0dd', '{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:52:03.27179+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '70613f6a-5a28-42ca-aca6-9aead5424961', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:52:05.072191+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f3420362-a697-4340-bc69-bba2a18a3374', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:52:06.154194+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '85ad2249-b4f9-4258-8308-67b25f7af9ee', '{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:52:08.452715+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'd39d7663-7ffc-4d6d-8788-7ac16cbb9621', '{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:53:55.13982+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'd0492874-dca8-4365-a355-627c66b2f387', '{"action":"login","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:53:56.738072+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c1a61e73-c9c9-4c1d-886e-a7efac538c90', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:54:24.141023+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '1b7a4b9b-6424-4d68-b924-b6b772a036f0', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:56:02.800792+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'ad7affa2-21a5-48f4-9696-85a3d6d6ba6f', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:56:04.488044+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'bae3c8de-4d0f-4382-82d1-82e09df79f62', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:56:07.930181+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '080b9ffe-97cb-4d8c-a498-aad8b47eaccc', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:56:09.006184+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '895c3ca7-2360-4b17-a958-c25be3d7f791', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:00:34.434311+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c2db9e52-09d7-4c23-ab78-cb043ac363fa', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:01:35.541778+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '9d6f7b52-402a-45d2-aecc-08d8955e47e7', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:01:37.593831+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '5e31e805-710d-40ce-a127-9a5413e89668', '{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:01:38.920421+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '443e2a10-a4a0-44e7-8d83-60e40a1a8146', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:01:41.493896+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '8038533f-135b-4c37-87a2-84813a99f870', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:01:42.812589+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '640725d6-9c79-4f43-aad6-386433bf9920', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:05:45.689076+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'd1abfd1b-eaa6-4b2c-b75a-ccd51af0dbfd', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:05:47.73065+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'bdb32a3a-9431-4816-abb0-768a6600aae8', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:08:22.039999+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'd6bf2abe-38c2-46d4-a45a-d3598f8e8283', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:08:29.481101+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'dda10903-0ebc-4984-8b11-c70a41cb6e32', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:08:31.38947+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '8fdadb57-c015-4899-913f-105d3e070a43', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:08:35.504458+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'da272cab-5454-4f3d-8829-e20b549d4424', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:08:38.34359+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'e290b5df-97c3-4712-952b-570e45074fae', '{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:49:11.718012+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'cd5f7925-7bd2-43f0-9ccd-1564af714e0f', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:49:23.907455+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '20f5a53c-5169-432c-a277-161966565279', '{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:50:45.724785+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'b4bb7479-45d1-48f4-af9c-716196d2423e', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:50:47.614983+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '800256eb-df46-4a5e-b6c8-b99e0fcee326', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:50:49.899572+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'bc60d6b5-f756-424a-9f4c-58ca3a1269be', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:50:53.103599+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'ccc453db-aed8-4d1e-86e2-4a0205397d48', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:50:54.233619+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '26fcf589-dd0d-455c-981b-c21155de2c20', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:51:55.254091+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '090ce21e-f043-4bf1-9a8f-b97a2ddb6e9a', '{"action":"logout","actor_id":"aebdeee3-427f-4d5b-832d-8c4ebaecdddc","actor_username":"robneil@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 06:54:19.829088+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '15482cab-891e-4784-a0e3-d2b0cc46bcd4', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 06:54:22.655901+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '2294b195-b922-4d4f-a0e2-e3470b032f3a', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:00:36.019891+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'ef73e31c-645e-469b-ab40-48ef64f7d465', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:00:38.428325+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '7ad53468-11d6-4945-9078-ecdec1053fe3', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:00:39.467203+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '2ad20543-fd3f-438e-ad0a-bb590ab2379c', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:01:34.141312+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c810a62d-e291-40c8-a895-f855e3de8175', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:08:26.666249+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '43336259-8551-4df0-93de-d96c964bd128', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:08:27.918314+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '24154553-3561-4376-aaa1-ff8f8d94fec3', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:10:10.96468+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '6911f5b0-d337-4aa0-a59e-70fe1168b47b', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:10:12.086795+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'eef1f26a-0d3e-4b10-aa13-e94dbbfaa844', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:10:13.328915+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c7fa674b-cb0f-4d0e-b67b-ffb4db20a9c3', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:10:15.295329+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'd3d8118e-ab06-454b-bea6-cd9e421b3630', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:10:16.361145+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f23f5134-f625-46fa-ac32-76a6ff1f31a7', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:10:19.203398+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '1a872477-7e41-4138-9a26-d98b7123ca60', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:10:20.128346+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '7c1ddbd6-58aa-4071-b830-d0e65be54804', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:10:43.681631+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a82eeebf-2c84-4eba-8850-637ca9e32fa3', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:10:44.831296+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '22101257-c73e-474c-a13c-43ed0dda1ff8', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:11:15.427666+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'fc2338ed-ce9b-44c1-ae4d-69f8cba05724', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:11:17.322187+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'e220d77e-95f8-4956-903d-b993de8873dc', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:11:21.746699+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '0cd38a00-086e-4309-b5a0-11e6d0d263b8', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:11:23.030796+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '211bfdc1-3ef9-4f18-84d4-d69eba178221', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:11:30.938565+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '2c48ecca-b570-41d0-b6b7-c474c3004aaf', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:11:33.158229+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c1486289-43eb-4164-9e90-8c9a6ca462de', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:11:35.560695+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '07b72227-2282-41dd-82fa-c039ec86c800', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:11:37.066355+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '968b940e-62a2-4509-9076-221227702cd9', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:11:40.850752+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'b8a9e1eb-0c38-4037-80c6-d473ed2e5db7', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:11:43.219159+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '955e1987-396b-4887-bf69-573255267050', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:11:47.010076+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '730e53ac-9d0a-477b-bd27-4964072df0b1', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:11:51.08924+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '1486585f-8123-442d-b793-dae77e3a649c', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:12:01.166436+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f04b44c9-50e5-4ce6-b2e3-2ad4f196c530', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:19:18.042209+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c0bd1379-568e-4cf2-b6e5-8d16fdecab73', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:19:20.469106+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c64b42b1-9ed7-4948-a05d-54f9b22dcc2d', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:20:54.504358+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a621f2a6-a2de-46de-a03c-5e9c4045ed42', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:20:56.749083+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '45c43955-56d6-4281-9e4d-87e8fe1ee779', '{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:20:58.682517+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'e91c9c41-55e9-47a2-93a5-6f0d6a596720', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:21:23.566355+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '6fa4a812-92bc-47b6-aec8-8c8b0187b425', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:27:44.626589+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '1f5b7bfd-bcfc-43ea-947c-b1fcc8ab44f6', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:27:46.304963+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '93651196-d3b4-4516-83ce-d2963e7b0064', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:27:47.706575+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '33848b9f-d894-46ac-94cb-6b957d3dd80d', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:27:54.200354+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'ba352809-542d-45b9-a825-326c321440ff', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:27:55.695128+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f695242d-a93c-4eff-a7f3-34e5d03df42e', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:27:57.815561+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '1bfcf92a-1713-4ec2-8fa5-e437206fa06b', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:01:57.430632+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '8f07490e-7c8b-4a9f-8818-7d1ccef18c3b', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:01:58.655691+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '5a7193bf-d98e-4dee-900f-485ffd3b3de6', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:05:05.667852+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '99a98a51-6dc1-4b52-92e1-fb889324fd49', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:05:06.847237+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '1dcbe3a7-6d1e-4214-bba6-50bc2ee034bd', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:07:34.036113+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'cabf179d-d023-4975-ae7b-0e3ae9c786be', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:07:36.18091+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f538a6aa-329c-4506-a232-00612c4244a9', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:09:22.047776+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '08c17c03-4e11-49bb-9484-ddecdcfcf573', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:09:24.203457+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '3edfe72b-6d14-4f97-9e2d-e901d1825c92', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:12:18.648841+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '0f3e3781-7656-4c36-a6e3-bd60e67a5f4d', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:12:20.071786+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '0ab03458-8f5a-47e9-801c-fe326efee06a', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:15:05.917501+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '05923ec0-2d26-4bd6-bd32-be360bad2cea', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:15:08.88038+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a287c1f7-5b03-448c-8d67-4c6d6365e1e7', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:56:36.970107+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '55a3d14d-a4e3-4b2d-a5df-95c2e7a09cfe', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:56:38.592156+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c8a95012-fb3a-4373-8bdc-e951f5600563', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 09:11:06.244288+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a7dd6e02-36ce-46f0-b7f6-27c1746d39e1', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 09:11:08.23963+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'bc0a149f-aaa3-4dc2-816a-3c8a5fa17fab', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 09:50:20.57527+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'ba56c306-9c9c-44cc-90bf-a2aa93abe1b6', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 09:50:22.328353+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '9e39f72c-326f-4a06-b0ff-898ef07d0185', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:27:58.864337+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '12f4132c-d899-4817-a6a1-ea9ba6101d03', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:28:25.000785+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '4af12461-9fa1-4c21-aa2c-fe06eceebf81', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 07:59:05.472669+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'eb76813e-150d-42ed-94bc-bc6b2e4a1cd2', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 07:59:09.676294+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '6ef5a823-5dd6-4e14-b929-4e93d19065c3', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:06:10.800879+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '8f48c769-4da4-4cee-b474-244de89bba47', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:06:11.86834+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '12e66433-72f4-4ff6-b641-1116317a1c67', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:07:37.849687+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c7793f20-ecd7-4f3b-9e1a-c81a86a54f32', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:07:39.745964+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '94824818-9da3-406f-b27c-51dec6179a13', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:09:14.268081+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'bbf3afe6-3575-4a8f-b8b0-5e2a4d8ab105', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:09:15.705347+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'cb601e60-5f56-4cab-9be0-2bd240337fc4', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:10:32.541129+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'd70e927e-b68e-43b4-afce-8b1a70894344', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:10:33.583882+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a7d95664-4450-4211-bec8-505744b219e8', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:12:22.197613+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '2a88f177-2091-459c-a216-cfc59094f02f', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:12:25.596169+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '13974ba6-cfb8-4ba6-9402-c5fdb7ffde9d', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:25:04.954289+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '5b4a3c05-32b8-47f7-bcac-9b6efd842705', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:25:06.964565+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '3dcf6d64-3c7d-40af-a712-0ca14a53fcca', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:25:45.789324+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '2d322cc9-bd89-4901-8211-50f1efb42ee3', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:25:48.278008+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'cfb7cd0a-28db-4d3e-b4a7-a714f820302f', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:57:06.744677+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a58e3feb-948c-4f8d-999b-fa0434d08836', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:57:08.150832+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'd86ab4d9-31a5-4b5c-b353-b56d4701c14a', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 08:57:53.994451+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '67aed1e4-ebde-4797-ba10-d483b60d9046', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 08:57:56.09109+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'de35da23-9ee4-46c7-b08f-6e2d70126498', '{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 09:38:44.84999+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '42f336e8-1dec-49b2-ba68-d8819a193328', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 09:38:47.029936+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '76a98446-9068-404b-897b-fa7a29b9ded5', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 09:42:29.694014+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'e844cb9b-edfc-4ef7-8931-c605c4b72efc', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 09:42:31.875502+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '3448bf02-62e9-4752-86c0-58e7eeeef9ff', '{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 09:43:18.862781+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '7f8a52d2-c4ce-4cfe-bef5-347d39f20ddf', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 09:43:21.027033+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '34cf3f66-e5e8-4992-8c9c-ca9f5232d4f6', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 10:02:41.796136+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '04b07daa-44c1-4352-b483-be2267dda24b', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 10:02:43.080436+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'db5be854-b8b3-4d01-81e9-17249dc31b31', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 10:02:46.309507+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'e6850b69-9074-4a94-9b3f-75253482a377', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 10:02:47.274032+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '30633131-95f5-476d-a79b-2e64d79fb5f6', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 10:19:09.63743+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '3d5fbe74-3a6b-4e0d-a41a-1e54dbc54b02', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 10:19:11.974121+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '0430f1ae-4558-4aaa-95f6-58434d740a05', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 10:19:50.131958+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '503b4966-780f-4ca1-b877-d139b71cb68c', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 10:19:53.103066+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '0f243312-6acc-49b7-bb63-899c4f37f3a2', '{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 10:35:29.524283+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '17b91915-f18b-4797-80c2-9037d3f84461', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 10:35:30.444612+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'bb3462f3-35b8-41d2-8c06-c720742103c5', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 15:41:54.149416+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'da90bd0d-894d-4117-9fad-877fadc920ea', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 15:41:56.550069+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '5a9b42ce-535c-4db7-afe7-3ffbe16b4092', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 16:02:53.033379+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a5314dc3-2350-4578-82a7-d5c78044e0bf', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 16:02:55.18308+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '66aab0ab-0455-4b39-9a05-89c2f0b4ad5c', '{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 16:16:58.021578+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'cad5d9e5-4ef7-4fb1-9b98-135d7b3a12e8', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 16:17:00.430502+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f7bf9e3f-ded0-4658-8269-e2f98878f79f', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 16:17:24.411954+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '086ace8a-e400-47f6-a20c-6569aa6371e4', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 16:17:26.634001+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '85bef108-ca49-491e-a74f-c68c616170ef', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 16:27:10.974663+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '1e8f7d51-b484-4671-a6f9-56c4fea5f06b', '{"action":"login","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 16:27:13.674678+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f9f5e124-dc12-4f4d-becf-6f5e8b4dbf3f', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 16:27:49.304601+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '00e1edd0-4432-42d1-9ac7-33129ee60317', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 16:27:51.863018+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'aba84095-f7c9-41e6-b11d-e94665b2c403', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 16:28:11.752662+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'ac69cb7e-465f-42b0-b6f7-f8501a10d942', '{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 10:34:22.379763+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '200194b8-ee96-4212-ae9a-fdb29436faba', '{"action":"login","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 10:34:23.786123+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '957bc829-3b40-44b3-b43c-62384a5afe8c', '{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 10:36:35.620259+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'e31d13eb-d412-42a5-a6c8-27cce7c271bd', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 10:36:37.892373+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '7fb2f8d9-726c-43aa-a955-60c56ecf4e38', '{"action":"token_refreshed","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-26 14:49:57.634029+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '14275c5c-cdd9-437e-82c6-a4c66ba37c33', '{"action":"token_revoked","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-26 14:49:57.635106+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '53ac7973-a561-48d5-8944-8daffe377a6d', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 14:51:32.039749+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c05ad7c6-6f01-4313-802e-01f5314f971b', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 14:51:33.627448+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '4c747c3e-6ff3-45b7-951c-6c780782e031', '{"action":"logout","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 15:07:14.855497+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '9e8e7c57-7771-4bf7-a42b-6be32d97c09e', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 15:07:17.658322+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '0d488402-04df-4f97-9124-97061b007e3a', '{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 16:02:37.897287+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'b43fbbb1-ddc4-4068-ac7b-9d7082dd48dc', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 16:02:40.267673+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '2c23f5ff-a3a3-4987-891a-8480a6b90b75', '{"action":"logout","actor_id":"f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4","actor_username":"finance@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 16:26:15.415287+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '3df2be71-70cc-443d-865e-8a2660914615', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 16:26:17.834749+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f9c9ad5b-b6d8-4240-b01c-11cce7bac250', '{"action":"logout","actor_id":"6d5b86c5-2939-4003-bb6f-6b177a60038e","actor_username":"pastor@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-26 16:27:36.501499+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'de8291ab-c3d0-47bd-846d-b9d2d281bd2c', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-26 16:27:40.278773+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'd47bcd31-c869-4929-a55e-11c760b3ce9b', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-27 02:57:34.479829+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '4ef86603-d927-450a-9542-62e9bdc18087', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-27 03:02:47.174966+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'b3d97332-78cb-4f4c-9d50-9993c7a11d35', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-27 03:02:48.283419+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '53b9091f-4649-45e0-aeab-f85ed23586fa', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 04:00:48.756872+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '2ad73ffb-a8fb-4503-b349-328ddf385930', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 04:00:48.757949+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '62b3df6b-6287-4fed-b127-5eaf830d954c', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 04:58:53.608527+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'd6c1c9ec-b7e9-4869-81df-1ab12b612b1e', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 04:58:53.609708+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'e99b106d-afe6-4692-b2b5-d515a0d404d0', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 07:54:32.869578+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '69b25fd5-f348-4915-bd37-23150267f2de', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 07:54:32.871797+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '27f79d64-67ac-4c26-8f7e-f0233323b48c', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"payment@victorybulacan.org","user_id":"fa5060a6-3996-46ea-ae5f-bd3fed7e251a","user_phone":""}}', '2025-02-27 08:17:02.152796+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '5cfb8150-deaf-476f-bc91-b9d5b6c8a30a', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 08:56:31.509896+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '82fb22ec-7eea-4171-8a23-88106e1cb11e', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 08:56:31.510894+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '0bc9b4bf-0248-4c6f-a5c2-9a9193ecad97', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-27 09:13:43.065636+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '75e797a7-ab83-4d1a-94f0-ae8269708e96', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 09:54:43.204062+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '9914588d-f171-4869-92eb-3a0a0e56ac6a', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 09:54:43.205227+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '6cf5a891-66f8-4cb7-9e62-5d0cebe9e981', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 10:14:24.740347+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '7f77bc1c-a7f0-449a-959f-5a0cc584cf7e', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 10:14:24.74092+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '4846a66a-2fca-4384-b5e8-04c455fab1a5', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 10:52:43.211563+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a410b5f0-4df4-4047-8829-f656418daf07', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 10:52:43.21308+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '18ba8ca1-37ad-4283-9d0e-73c1abf88808', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 15:15:48.075704+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'da8fc3fb-d062-45b3-8642-0cf395f0fc4d', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 15:15:48.077359+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '58bfd33d-12ec-4ed2-bdd7-f3f48b249eae', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-27 15:41:23.524683+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '4b9b6aa5-0adc-428a-845e-4afb4e37d8bf', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 16:14:17.202905+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '267b0a75-d3fd-4949-81ad-1f016fe980aa', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 16:14:17.20362+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'bd824a55-3985-43a0-a3bb-d0a82ed2b614', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 16:39:38.429778+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '397fc22c-5c45-4c7d-a60f-dc8a18506dd6', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 16:39:38.43039+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a6cfb398-be32-431b-bd98-cc8ff1b00282', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-27 16:56:14.569399+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'e48e1b9a-90f9-4da3-ba66-b18ec4e70d58', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 17:45:51.788884+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '2c75ca13-7746-4e3b-84a0-dd163622ed03', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 17:45:51.790262+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'fc1ebca8-7269-4015-9d44-b9a62875b10e', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 17:54:23.231332+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'a09ac44f-f228-4686-b6f0-ffc4dae892b8', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-27 17:54:23.232149+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '080fbf55-fe3b-49d7-9e05-3488ce177319', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 01:17:34.051079+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'e687c449-9149-4cfb-9d9f-94565ec68229', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 01:17:34.052727+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'cbe524b2-f624-4f52-9ba9-477ed16c9f84', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-28 02:07:29.45167+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'da4435a3-6750-41c0-a6e5-25b42ef0f853', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 02:17:57.976033+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'bc112f27-fd3b-4cff-bf9a-e5e1473b7504', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 02:17:57.97664+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '34b2e709-6d7f-466e-81c9-970e14f3e517', '{"action":"token_refreshed","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 03:05:55.508774+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'e66483ed-d596-489f-9e78-4a61e286976b', '{"action":"token_revoked","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 03:05:55.509837+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c18a57be-296b-4c9a-92de-4cf2c31c64f2', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 03:18:04.539398+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '46fdf136-8e55-4ba9-9c93-8706a6d27348', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 03:18:04.540186+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '595f0f1e-2b27-419c-9d4d-c404b9a2a0b5', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 03:18:04.552452+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '0583d596-3699-47f4-9e19-7e94da8e3748', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 03:18:04.577164+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '1a2f706e-fae2-4159-b3e3-48d207aa0cba', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-28 03:59:41.509997+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'ed69933e-ab7a-417f-af35-be8eaee7df72', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-28 03:59:42.56039+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '429d8684-f6b8-45ef-a88b-0d9f6473cc12', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-28 04:12:43.201095+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '4643bb6f-e908-4d45-b3b6-d64432660e40', '{"action":"login","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-28 04:12:44.857191+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '04b4f5ae-226a-4423-8eb7-302303e6bf3a', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 05:11:10.15072+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'f8e6ece7-c7ff-45ea-88ff-f4ac200ebf07', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 05:11:10.152139+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'da1c7d1c-eafb-4084-b8b4-12faab123d2d', '{"action":"token_refreshed","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 06:09:16.966305+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'e351d6f2-b539-4d06-8b9e-4a83df555559', '{"action":"token_revoked","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 06:09:16.967823+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '5241b16a-dd54-4fe2-b37b-0e774316aa64', '{"action":"logout","actor_id":"94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb","actor_username":"cd@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-28 06:57:29.635951+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', 'c35f4b35-a523-4d8e-be0d-7324912d2ba0', '{"action":"login","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-02-28 06:57:33.71737+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '076d66e3-115b-423a-ad4e-b7c6f2406524', '{"action":"token_refreshed","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 07:55:49.309919+00', '');
INSERT INTO auth.audit_log_entries VALUES ('00000000-0000-0000-0000-000000000000', '64eefa5a-1b4a-408a-91e0-977a253c9ce1', '{"action":"token_revoked","actor_id":"aefe15fe-4937-4f55-a6cb-fb8d739c5905","actor_username":"missionary@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-02-28 07:55:49.311173+00', '');


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.users VALUES (NULL, 'b794e95a-97f4-4c05-aa2d-3c13c4155841', NULL, NULL, 'mar.loyd.quinto@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'b1f5db31-bfc8-409c-8925-0d21f1c780e6', NULL, NULL, 'paul.ryan.pasia@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'bb519a2d-d8ce-4cdf-b87e-7d3b6315061b', NULL, NULL, 'john.ian.susi@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'd7b3a44d-8356-4a38-a7f5-f5ecf6a2ee96', NULL, NULL, 'jhomar.carlo.salazar@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'dd35da46-4416-412a-8a22-f3f39491bb7b', NULL, NULL, 'dan.joash.bagadiong@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'a83848ba-0779-4fac-98ee-f5f459b2742b', NULL, NULL, 'cielo.marie.angeles@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, '51072377-1472-46cb-b180-8542677f5eb2', NULL, NULL, 'sarah.grace.de.peralta@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, '9255fabc-799b-4cc7-8797-5f2470f6adf6', NULL, NULL, 'dahlia.delos.reyes@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, '6833f990-6a38-4f28-aa18-e31697fa7dc9', NULL, NULL, 'caroll.jane.perez@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, '6ac1e176-e710-4b5e-9453-95765db20ba3', NULL, NULL, 'ma..jirah.joy.rivera@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, '463737cc-950b-4a41-8d73-a3daf931fee5', NULL, NULL, 'emmanuel.victoria@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, '8088628d-f77a-430d-b228-cc3649b8a3e1', NULL, NULL, 'mary.florenz.krizza.anzures@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'da6ac18e-72e9-484a-ad75-d044260789cc', NULL, NULL, 'a-j.de.guzman@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'a602c1a3-89cf-44a4-b419-f6827ad3701b', NULL, NULL, 'ariane.lingat@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, '1dcfd06d-826c-4c00-a64c-c2eabe1abfbd', NULL, NULL, 'genriel.santiago@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'fd99f59b-fcc6-42ef-a407-207f110f2d7b', NULL, NULL, 'desimae.vhiel.susi@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'dde964d6-6ffa-4b25-97b6-128969afe47c', NULL, NULL, 'princess.blessie.ventic@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'dbbbe49c-e100-4576-b406-320908c8873e', NULL, NULL, 'emily.dionisio@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, '5432f125-2d5e-42ab-849a-29add2cf0a74', NULL, NULL, 'ma..bernadette.sheyne.mariano@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'bd38508e-8797-4220-ae2e-dd7883b41f17', NULL, NULL, 'ronald.carlo.bechayda@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'fc7c7272-6d55-49a3-88d7-fc37133a103f', NULL, NULL, 'ben-joe.ryell.prada@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'e4bfe294-e6e5-4626-9f2a-969f2aa938c3', NULL, NULL, 'rose.ann.solo@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'cff64755-2065-4e58-866f-f092cbd9e73b', NULL, NULL, 'jemica.dela.cruz@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'ee522e07-1315-4463-8a9b-f890b601c047', NULL, NULL, 'laira.santos@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, '77e168c1-05e0-4314-8a24-5e838350a3d8', NULL, NULL, 'christine.joy.velasco@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'ea3a5bea-7de6-4fd6-b6e6-31d11aed3231', NULL, NULL, 'roberto.del.rosario.jr.@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, '387d98f7-ccf9-4077-8f79-f0be51c40d05', NULL, NULL, 'michael.macale@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, 'ad0b7e41-18fc-4945-8aa9-6793788b0e7c', NULL, NULL, 'wendy.cainong@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, '1934abf8-eca9-41d8-bc5f-9c649285b76b', NULL, NULL, 'diana.camaso@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, '5bf27593-0c3d-489f-bed4-c80dc2936fdf', NULL, NULL, 'christian.reyes@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES (NULL, '584a1909-5797-4297-88d3-06bf5dc3922a', NULL, NULL, 'mary.anne.ma??????osa@example.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', 'ab8dc40a-9c9b-4391-823b-8578ab506e5e', NULL, NULL, 'erick@victory.ph', '$2a$06$uItYcsOBm8eBgt7QVONaF.FOMfMH1uOTIbc/bqyGu.atszZDHAdRS', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '{"provider": "email", "providers": ["email"]}', '{"full_name": "Erick Fernandez"}', false, '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', 'ec874457-5ac3-48c2-90dd-9ea0b8166635', NULL, NULL, 'red@victory.ph', '$2a$06$F5Jeg/omusrLqDKzZFIsG.9ctGGX0UWe1zBeJ2NMl9VyJFlyg9A.m', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '{"provider": "email", "providers": ["email"]}', '{"full_name": "Red Pondang"}', false, '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', '48d301bd-fea6-4d85-92c0-bf066aa23ae8', NULL, NULL, 'king@victory.ph', '$2a$06$EyNZ3392zU21Lccs8gQOau/sy/bKsaXkeK9HJbxMHmuy0vAr0py2y', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '{"provider": "email", "providers": ["email"]}', '{"full_name": "King Borlongan"}', false, '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', 'a3a1e735-b662-49ab-8ccc-a23686553bc3', NULL, NULL, 'loyd@victory.ph', '$2a$06$uX30zKgwacDmXdQitLVPsO.T15tHd.xEbwOAPwlxB2WFzmp1RkS/W', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '{"provider": "email", "providers": ["email"]}', '{"full_name": "Loyd Janobas"}', false, '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', '326aada0-3dcc-4566-84cc-2541c0e134e2', NULL, NULL, 'moss@victory.ph', '$2a$06$19KvkzA0VRY0Roam91kaR.icF/K5RVDQVAH/798xz8yG72N1UeHSe', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '{"provider": "email", "providers": ["email"]}', '{"full_name": "Moss Manalaysay"}', false, '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', '6f9579a9-4f08-4ab5-8fd2-b7c3d2ee87e2', NULL, NULL, 'anthony@victory.ph', '$2a$06$IoLlM4tFiZx3TY8r9b8Om.UoQlZe/tHfC7doVnim3r8bnqvHQRexu', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '{"provider": "email", "providers": ["email"]}', '{"full_name": "Anthony Licud"}', false, '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', '910ef066-fdcb-4f99-aac4-458aaacc7a5b', NULL, NULL, 'rouie@victory.ph', '$2a$06$Es.rUCzV.4RfnuhakTPefua1Rpg57bpFFX0QS9rLEhWcs8lr4yTke', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '{"provider": "email", "providers": ["email"]}', '{"full_name": "Rouie Gutierrez"}', false, '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', '712b5dd0-cd8d-4293-8e66-640624002f2b', NULL, NULL, 'robert@victory.ph', '$2a$06$N671sRr.I7CHarEpX3kHQO3HhiI8RX1akDmbqdVagLSn8xGNz58Ra', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '2025-02-06 02:59:11.366863+00', '', '', '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', '{"provider": "email", "providers": ["email"]}', '{"full_name": "Robert Guevarra"}', false, '2025-02-06 02:59:11.366863+00', '2025-02-06 02:59:11.366863+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', '3795175a-52aa-495b-81c8-01e2d7ae99de', 'authenticated', 'authenticated', 'rob.guevarra@gmail.com', '$2a$10$BC3kgPAaleXzuALMTqGv2.iDF7IQgDgWR/Gksr/od0guIjECp6dLe', '2025-02-19 02:17:04.338282+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-02-19 02:17:04.333903+00', '2025-02-19 02:33:39.634178+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', 'b188f631-2561-457a-9be6-f556043dfc94', 'authenticated', 'authenticated', 'zoebguevarra@gmail.com', '$2a$10$bQHdaPyK1mdXGgQg9o7vq.69b5aB3wbEsZknKCuY8gylTeGxY35eq', '2025-02-19 12:19:24.266501+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-02-19 12:19:24.26075+00', '2025-02-19 12:19:24.267059+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', 'bba4e5c1-2eb0-46bd-8f09-cd331ceab351', 'authenticated', 'authenticated', 'xionguevarra@gmail.com', '$2a$10$uuySj6hE0NPYCJ/9hY7eY.GQoHA5JVNKiNe.233sCB17XzJQmCRAS', '2025-02-19 12:22:37.70027+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-02-19 12:22:37.698012+00', '2025-02-19 12:22:37.700734+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', 'bdebd3ea-5c80-4dff-a03c-a7d0a08947ef', 'authenticated', 'authenticated', 'gracebguevarra@gmail.com', '$2a$10$tKIxwleZhiOphLhMGDgkDOd5pu.xBB6ooHQaKkiRG9ly778P8MCc.', '2025-02-19 12:24:33.056454+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-02-19 12:24:33.054346+00', '2025-02-19 12:24:33.056864+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', '94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb', 'authenticated', 'authenticated', 'cd@gmail.com', '$2a$10$dKkU/wN4mOLpL.K852iaGeHZG8MyDfLvcyV/.hOsd/MgEEoTKbjBK', '2025-02-19 13:56:36.950301+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-02-28 04:12:44.857785+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-02-19 13:56:36.947999+00', '2025-02-28 06:09:16.970499+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', 'f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4', 'authenticated', 'authenticated', 'finance@gmail.com', '$2a$10$Lzy8Zvwn31AF8ZODI3d0WOF2qRecqIZaYe5Ct/vH.bUftt8tckDfq', '2025-02-19 13:29:47.97838+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-02-26 16:17:26.635334+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-02-19 13:29:47.975428+00', '2025-02-26 16:17:26.636787+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', 'dc34a52e-aed8-4354-abb6-7b49085ac24e', 'authenticated', 'authenticated', 'yoshiii@gmail.com', '$2a$10$UxqGBuoqgsO/sv1kE9/ZTe76jtRU.pKUW7NHCSeUDbNiAXIv4oMp.', '2025-02-19 12:38:02.883063+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-02-19 12:38:02.880649+00', '2025-02-19 12:38:02.883441+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', '047a2a75-cb6a-46b6-a039-2958efb1af2b', 'authenticated', 'authenticated', 'yosxxx@gmail.com', '$2a$10$Paeli66jhVZyj66x8jbGDeCYOV55pbWdvLxIIqJCyZhjeXIthzGQS', '2025-02-19 12:38:31.38067+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-02-19 12:38:31.378627+00', '2025-02-19 12:38:31.381196+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', '3573c57b-43e2-4947-9f9b-38d9bd01ee7f', 'authenticated', 'authenticated', 'jeje@gmail.com', '$2a$10$kpZ/v2HbAslAxY0OFPTf8ewfBOuWpX9dabxUnTnQfuiP.sQNG5G.6', '2025-02-19 12:40:19.188704+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-02-19 12:40:19.186283+00', '2025-02-19 12:40:19.189136+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', 'bc9fc16c-f1f9-4c2f-ba95-51bd5a0594f3', 'authenticated', 'authenticated', 'jejehaa@gmail.com', '$2a$10$jjvya720DEl2VoXs5Fq51ea/jLjYKWtof.G0CO8sqIll.9eKbs2Fe', '2025-02-19 12:40:30.356781+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-02-19 12:40:30.354803+00', '2025-02-19 12:40:30.357201+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', '94f2d973-d8df-435e-8b43-98e7b44fe45b', 'authenticated', 'authenticated', 'reverx@gmail.com', '$2a$10$ECtO3fAXDaZVBSTj5Uo2de/jch7UkvX7V7P/OBhWjU695VzHmoWmu', '2025-02-19 12:44:47.231916+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-02-19 12:44:47.229524+00', '2025-02-19 12:44:47.232275+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', '6d5b86c5-2939-4003-bb6f-6b177a60038e', 'authenticated', 'authenticated', 'pastor@gmail.com', '$2a$10$lafH4rkirV1Xu0/wTSW4LO6UqzinPdhBdGjhrERdOiRzVAqT0cAFG', '2025-02-19 13:30:03.49485+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-02-26 16:27:13.675216+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-02-19 13:30:03.492587+00', '2025-02-26 16:27:13.676371+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', 'fa5060a6-3996-46ea-ae5f-bd3fed7e251a', 'authenticated', 'authenticated', 'payment@victorybulacan.org', '$2a$10$QaQcIH9LGiqQdXFimIDRkue1tbC.c9G4awxDgKSSrYTBgDL7bTYhO', '2025-02-27 08:17:02.153929+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-02-27 08:17:02.140358+00', '2025-02-27 08:17:02.154624+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', 'aebdeee3-427f-4d5b-832d-8c4ebaecdddc', 'authenticated', 'authenticated', 'robneil@gmail.com', '$2a$10$wE3mczoBf3hHpZkp2jzRIun1BjDERCfP2eLLfohe8YJugtBS0.8D2', '2025-02-04 04:10:22.352101+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-02-26 06:53:56.739017+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-02-04 04:10:22.347235+00', '2025-02-26 06:53:56.740467+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);
INSERT INTO auth.users VALUES ('00000000-0000-0000-0000-000000000000', 'aefe15fe-4937-4f55-a6cb-fb8d739c5905', 'authenticated', 'authenticated', 'missionary@gmail.com', '$2a$10$NgRI2rXLmcWMDCbeiBdYp.hlbTwNJpLauzflbj5MpSH6SnFgwszAO', '2025-02-19 13:56:14.839908+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-02-28 06:57:33.718054+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-02-19 13:56:14.836832+00', '2025-02-28 07:55:49.313576+00', NULL, NULL, '', '', NULL, DEFAULT, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.identities VALUES ('aebdeee3-427f-4d5b-832d-8c4ebaecdddc', 'aebdeee3-427f-4d5b-832d-8c4ebaecdddc', '{"sub": "aebdeee3-427f-4d5b-832d-8c4ebaecdddc", "email": "robneil@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-02-04 04:10:22.34949+00', '2025-02-04 04:10:22.349524+00', '2025-02-04 04:10:22.349524+00', DEFAULT, '4d958e0f-6574-460b-9cb2-ce8ccf685d1c');
INSERT INTO auth.identities VALUES ('3795175a-52aa-495b-81c8-01e2d7ae99de', '3795175a-52aa-495b-81c8-01e2d7ae99de', '{"sub": "3795175a-52aa-495b-81c8-01e2d7ae99de", "email": "rob.guevarra@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-02-19 02:17:04.336428+00', '2025-02-19 02:17:04.336457+00', '2025-02-19 02:17:04.336457+00', DEFAULT, 'c3ef17ee-19dc-46c6-98ef-257f12093b4c');
INSERT INTO auth.identities VALUES ('b188f631-2561-457a-9be6-f556043dfc94', 'b188f631-2561-457a-9be6-f556043dfc94', '{"sub": "b188f631-2561-457a-9be6-f556043dfc94", "email": "zoebguevarra@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-02-19 12:19:24.264563+00', '2025-02-19 12:19:24.264602+00', '2025-02-19 12:19:24.264602+00', DEFAULT, 'caefc411-b1ea-4334-93a0-753153dbd611');
INSERT INTO auth.identities VALUES ('bba4e5c1-2eb0-46bd-8f09-cd331ceab351', 'bba4e5c1-2eb0-46bd-8f09-cd331ceab351', '{"sub": "bba4e5c1-2eb0-46bd-8f09-cd331ceab351", "email": "xionguevarra@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-02-19 12:22:37.699021+00', '2025-02-19 12:22:37.699052+00', '2025-02-19 12:22:37.699052+00', DEFAULT, '3a26755a-eadf-469c-b268-b623685f7cb3');
INSERT INTO auth.identities VALUES ('bdebd3ea-5c80-4dff-a03c-a7d0a08947ef', 'bdebd3ea-5c80-4dff-a03c-a7d0a08947ef', '{"sub": "bdebd3ea-5c80-4dff-a03c-a7d0a08947ef", "email": "gracebguevarra@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-02-19 12:24:33.055194+00', '2025-02-19 12:24:33.055221+00', '2025-02-19 12:24:33.055221+00', DEFAULT, 'fca02ae0-0c91-4ee1-b193-45ec48a80d8f');
INSERT INTO auth.identities VALUES ('dc34a52e-aed8-4354-abb6-7b49085ac24e', 'dc34a52e-aed8-4354-abb6-7b49085ac24e', '{"sub": "dc34a52e-aed8-4354-abb6-7b49085ac24e", "email": "yoshiii@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-02-19 12:38:02.88173+00', '2025-02-19 12:38:02.881758+00', '2025-02-19 12:38:02.881758+00', DEFAULT, '91076c97-a00a-4720-a485-f7add7e04aad');
INSERT INTO auth.identities VALUES ('047a2a75-cb6a-46b6-a039-2958efb1af2b', '047a2a75-cb6a-46b6-a039-2958efb1af2b', '{"sub": "047a2a75-cb6a-46b6-a039-2958efb1af2b", "email": "yosxxx@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-02-19 12:38:31.379426+00', '2025-02-19 12:38:31.379452+00', '2025-02-19 12:38:31.379452+00', DEFAULT, '0d15c7f6-b222-44ef-b724-329db1f4d89f');
INSERT INTO auth.identities VALUES ('3573c57b-43e2-4947-9f9b-38d9bd01ee7f', '3573c57b-43e2-4947-9f9b-38d9bd01ee7f', '{"sub": "3573c57b-43e2-4947-9f9b-38d9bd01ee7f", "email": "jeje@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-02-19 12:40:19.187279+00', '2025-02-19 12:40:19.187308+00', '2025-02-19 12:40:19.187308+00', DEFAULT, '6cbb660c-28be-4e48-9fa2-2d6d5542e8d6');
INSERT INTO auth.identities VALUES ('bc9fc16c-f1f9-4c2f-ba95-51bd5a0594f3', 'bc9fc16c-f1f9-4c2f-ba95-51bd5a0594f3', '{"sub": "bc9fc16c-f1f9-4c2f-ba95-51bd5a0594f3", "email": "jejehaa@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-02-19 12:40:30.35558+00', '2025-02-19 12:40:30.355606+00', '2025-02-19 12:40:30.355606+00', DEFAULT, 'a21c4001-2011-4b0c-a232-1ece14f8f4f8');
INSERT INTO auth.identities VALUES ('94f2d973-d8df-435e-8b43-98e7b44fe45b', '94f2d973-d8df-435e-8b43-98e7b44fe45b', '{"sub": "94f2d973-d8df-435e-8b43-98e7b44fe45b", "email": "reverx@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-02-19 12:44:47.230583+00', '2025-02-19 12:44:47.230608+00', '2025-02-19 12:44:47.230608+00', DEFAULT, 'd60c87d9-9884-4952-ad59-7e1f42b10d38');
INSERT INTO auth.identities VALUES ('f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4', 'f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4', '{"sub": "f2ea43d7-09a8-44b7-a193-7d3ddf2fb6f4", "email": "finance@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-02-19 13:29:47.976711+00', '2025-02-19 13:29:47.976746+00', '2025-02-19 13:29:47.976746+00', DEFAULT, 'ca7781c3-e309-4382-88db-477c954fcb3e');
INSERT INTO auth.identities VALUES ('6d5b86c5-2939-4003-bb6f-6b177a60038e', '6d5b86c5-2939-4003-bb6f-6b177a60038e', '{"sub": "6d5b86c5-2939-4003-bb6f-6b177a60038e", "email": "pastor@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-02-19 13:30:03.49344+00', '2025-02-19 13:30:03.493466+00', '2025-02-19 13:30:03.493466+00', DEFAULT, 'fa1b4a82-6325-4976-b3f5-0485a3cdea2f');
INSERT INTO auth.identities VALUES ('aefe15fe-4937-4f55-a6cb-fb8d739c5905', 'aefe15fe-4937-4f55-a6cb-fb8d739c5905', '{"sub": "aefe15fe-4937-4f55-a6cb-fb8d739c5905", "email": "missionary@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-02-19 13:56:14.837967+00', '2025-02-19 13:56:14.838001+00', '2025-02-19 13:56:14.838001+00', DEFAULT, '0a7d3769-83a1-4d33-b479-d6712374d902');
INSERT INTO auth.identities VALUES ('94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb', '94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb', '{"sub": "94cdc9fd-73eb-4644-b7a5-b55ce1bf68fb", "email": "cd@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-02-19 13:56:36.948921+00', '2025-02-19 13:56:36.948944+00', '2025-02-19 13:56:36.948944+00', DEFAULT, '049c5da4-920f-4244-976e-15b576804363');
INSERT INTO auth.identities VALUES ('fa5060a6-3996-46ea-ae5f-bd3fed7e251a', 'fa5060a6-3996-46ea-ae5f-bd3fed7e251a', '{"sub": "fa5060a6-3996-46ea-ae5f-bd3fed7e251a", "email": "payment@victorybulacan.org", "email_verified": false, "phone_verified": false}', 'email', '2025-02-27 08:17:02.14872+00', '2025-02-27 08:17:02.148755+00', '2025-02-27 08:17:02.148755+00', DEFAULT, '6c521fda-52d8-4f40-8db1-6912697b5bcd');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.sessions VALUES ('d4f88361-ded1-4a95-8d43-79388b6c0f9e', 'aefe15fe-4937-4f55-a6cb-fb8d739c5905', '2025-02-28 02:07:29.452951+00', '2025-02-28 03:05:55.513161+00', NULL, 'aal1', NULL, '2025-02-28 03:05:55.51313', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', '172.18.0.1', NULL);
INSERT INTO auth.sessions VALUES ('51329bf2-e86a-46c9-9ade-2b04d86095f3', 'aefe15fe-4937-4f55-a6cb-fb8d739c5905', '2025-02-28 06:57:33.718161+00', '2025-02-28 07:55:49.314654+00', NULL, 'aal1', NULL, '2025-02-28 07:55:49.314612', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', '172.18.0.1', NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.mfa_amr_claims VALUES ('d4f88361-ded1-4a95-8d43-79388b6c0f9e', '2025-02-28 02:07:29.45735+00', '2025-02-28 02:07:29.45735+00', 'password', 'e49b7c9c-493e-4f81-bd79-47f320e26836');
INSERT INTO auth.mfa_amr_claims VALUES ('51329bf2-e86a-46c9-9ade-2b04d86095f3', '2025-02-28 06:57:33.720481+00', '2025-02-28 06:57:33.720481+00', 'password', 'b4404031-979c-4eca-b13f-3dff9c1034cf');


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.refresh_tokens VALUES ('00000000-0000-0000-0000-000000000000', 476, 'ZjRbi_7w8WuZv-qstnQMgg', 'aefe15fe-4937-4f55-a6cb-fb8d739c5905', true, '2025-02-28 02:07:29.455566+00', '2025-02-28 03:05:55.510312+00', NULL, 'd4f88361-ded1-4a95-8d43-79388b6c0f9e');
INSERT INTO auth.refresh_tokens VALUES ('00000000-0000-0000-0000-000000000000', 478, 'JC-q4SF4u0Lj7gitsStIoA', 'aefe15fe-4937-4f55-a6cb-fb8d739c5905', false, '2025-02-28 03:05:55.510986+00', '2025-02-28 03:05:55.510986+00', 'ZjRbi_7w8WuZv-qstnQMgg', 'd4f88361-ded1-4a95-8d43-79388b6c0f9e');
INSERT INTO auth.refresh_tokens VALUES ('00000000-0000-0000-0000-000000000000', 484, 'mL5uWfnctzquukJ1EBLpjA', 'aefe15fe-4937-4f55-a6cb-fb8d739c5905', true, '2025-02-28 06:57:33.719201+00', '2025-02-28 07:55:49.311754+00', NULL, '51329bf2-e86a-46c9-9ade-2b04d86095f3');
INSERT INTO auth.refresh_tokens VALUES ('00000000-0000-0000-0000-000000000000', 485, 'ZVPLbI4HEaz8CkL5OQmyWw', 'aefe15fe-4937-4f55-a6cb-fb8d739c5905', false, '2025-02-28 07:55:49.312726+00', '2025-02-28 07:55:49.312726+00', 'mL5uWfnctzquukJ1EBLpjA', '51329bf2-e86a-46c9-9ade-2b04d86095f3');


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO auth.schema_migrations VALUES ('20171026211738');
INSERT INTO auth.schema_migrations VALUES ('20171026211808');
INSERT INTO auth.schema_migrations VALUES ('20171026211834');
INSERT INTO auth.schema_migrations VALUES ('20180103212743');
INSERT INTO auth.schema_migrations VALUES ('20180108183307');
INSERT INTO auth.schema_migrations VALUES ('20180119214651');
INSERT INTO auth.schema_migrations VALUES ('20180125194653');
INSERT INTO auth.schema_migrations VALUES ('00');
INSERT INTO auth.schema_migrations VALUES ('20210710035447');
INSERT INTO auth.schema_migrations VALUES ('20210722035447');
INSERT INTO auth.schema_migrations VALUES ('20210730183235');
INSERT INTO auth.schema_migrations VALUES ('20210909172000');
INSERT INTO auth.schema_migrations VALUES ('20210927181326');
INSERT INTO auth.schema_migrations VALUES ('20211122151130');
INSERT INTO auth.schema_migrations VALUES ('20211124214934');
INSERT INTO auth.schema_migrations VALUES ('20211202183645');
INSERT INTO auth.schema_migrations VALUES ('20220114185221');
INSERT INTO auth.schema_migrations VALUES ('20220114185340');
INSERT INTO auth.schema_migrations VALUES ('20220224000811');
INSERT INTO auth.schema_migrations VALUES ('20220323170000');
INSERT INTO auth.schema_migrations VALUES ('20220429102000');
INSERT INTO auth.schema_migrations VALUES ('20220531120530');
INSERT INTO auth.schema_migrations VALUES ('20220614074223');
INSERT INTO auth.schema_migrations VALUES ('20220811173540');
INSERT INTO auth.schema_migrations VALUES ('20221003041349');
INSERT INTO auth.schema_migrations VALUES ('20221003041400');
INSERT INTO auth.schema_migrations VALUES ('20221011041400');
INSERT INTO auth.schema_migrations VALUES ('20221020193600');
INSERT INTO auth.schema_migrations VALUES ('20221021073300');
INSERT INTO auth.schema_migrations VALUES ('20221021082433');
INSERT INTO auth.schema_migrations VALUES ('20221027105023');
INSERT INTO auth.schema_migrations VALUES ('20221114143122');
INSERT INTO auth.schema_migrations VALUES ('20221114143410');
INSERT INTO auth.schema_migrations VALUES ('20221125140132');
INSERT INTO auth.schema_migrations VALUES ('20221208132122');
INSERT INTO auth.schema_migrations VALUES ('20221215195500');
INSERT INTO auth.schema_migrations VALUES ('20221215195800');
INSERT INTO auth.schema_migrations VALUES ('20221215195900');
INSERT INTO auth.schema_migrations VALUES ('20230116124310');
INSERT INTO auth.schema_migrations VALUES ('20230116124412');
INSERT INTO auth.schema_migrations VALUES ('20230131181311');
INSERT INTO auth.schema_migrations VALUES ('20230322519590');
INSERT INTO auth.schema_migrations VALUES ('20230402418590');
INSERT INTO auth.schema_migrations VALUES ('20230411005111');
INSERT INTO auth.schema_migrations VALUES ('20230508135423');
INSERT INTO auth.schema_migrations VALUES ('20230523124323');
INSERT INTO auth.schema_migrations VALUES ('20230818113222');
INSERT INTO auth.schema_migrations VALUES ('20230914180801');
INSERT INTO auth.schema_migrations VALUES ('20231027141322');
INSERT INTO auth.schema_migrations VALUES ('20231114161723');
INSERT INTO auth.schema_migrations VALUES ('20231117164230');
INSERT INTO auth.schema_migrations VALUES ('20240115144230');
INSERT INTO auth.schema_migrations VALUES ('20240214120130');
INSERT INTO auth.schema_migrations VALUES ('20240306115329');
INSERT INTO auth.schema_migrations VALUES ('20240314092811');
INSERT INTO auth.schema_migrations VALUES ('20240427152123');
INSERT INTO auth.schema_migrations VALUES ('20240612123726');
INSERT INTO auth.schema_migrations VALUES ('20240729123726');
INSERT INTO auth.schema_migrations VALUES ('20240802193726');
INSERT INTO auth.schema_migrations VALUES ('20240806073726');
INSERT INTO auth.schema_migrations VALUES ('20241009103726');


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: key; Type: TABLE DATA; Schema: pgsodium; Owner: supabase_admin
--



--
-- Data for Name: districts; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: donors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.donors VALUES (1, 'Donor 1', 'donor1@example.com', '0911234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (2, 'Donor 2', 'donor2@example.com', '0921234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (3, 'Donor 3', 'donor3@example.com', '0931234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (4, 'Donor 4', 'donor4@example.com', '0941234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (5, 'Donor 5', 'donor5@example.com', '0951234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (6, 'Donor 6', 'donor6@example.com', '0961234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (7, 'Donor 7', 'donor7@example.com', '0971234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (8, 'Donor 8', 'donor8@example.com', '0981234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (9, 'Donor 9', 'donor9@example.com', '0991234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (10, 'Donor 10', 'donor10@example.com', '09101234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (11, 'Donor 11', 'donor11@example.com', '09111234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (12, 'Donor 12', 'donor12@example.com', '09121234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (13, 'Donor 13', 'donor13@example.com', '09131234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (14, 'Donor 14', 'donor14@example.com', '09141234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (15, 'Donor 15', 'donor15@example.com', '09151234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (16, 'Donor 16', 'donor16@example.com', '09161234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (17, 'Donor 17', 'donor17@example.com', '09171234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (18, 'Donor 18', 'donor18@example.com', '09181234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (19, 'Donor 19', 'donor19@example.com', '09191234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (20, 'Donor 20', 'donor20@example.com', '09201234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (21, 'Donor 21', 'donor21@example.com', '09211234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (22, 'Donor 22', 'donor22@example.com', '09221234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (23, 'Donor 23', 'donor23@example.com', '09231234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (24, 'Donor 24', 'donor24@example.com', '09241234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (25, 'Donor 25', 'donor25@example.com', '09251234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (26, 'Donor 26', 'donor26@example.com', '09261234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (27, 'Donor 27', 'donor27@example.com', '09271234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (28, 'Donor 28', 'donor28@example.com', '09281234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (29, 'Donor 29', 'donor29@example.com', '09291234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (30, 'Donor 30', 'donor30@example.com', '09301234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (31, 'Donor 31', 'donor31@example.com', '09311234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (32, 'Donor 32', 'donor32@example.com', '09321234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (33, 'Donor 33', 'donor33@example.com', '09331234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (34, 'Donor 34', 'donor34@example.com', '09341234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (35, 'Donor 35', 'donor35@example.com', '09351234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (36, 'Donor 36', 'donor36@example.com', '09361234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (37, 'Donor 37', 'donor37@example.com', '09371234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (38, 'Donor 38', 'donor38@example.com', '09381234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (39, 'Donor 39', 'donor39@example.com', '09391234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (40, 'Donor 40', 'donor40@example.com', '09401234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (41, 'Donor 41', 'donor41@example.com', '09411234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (42, 'Donor 42', 'donor42@example.com', '09421234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (43, 'Donor 43', 'donor43@example.com', '09431234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (44, 'Donor 44', 'donor44@example.com', '09441234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (45, 'Donor 45', 'donor45@example.com', '09451234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (46, 'Donor 46', 'donor46@example.com', '09461234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (47, 'Donor 47', 'donor47@example.com', '09471234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (48, 'Donor 48', 'donor48@example.com', '09481234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (49, 'Donor 49', 'donor49@example.com', '09491234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (50, 'Donor 50', 'donor50@example.com', '09501234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (51, 'Donor 51', 'donor51@example.com', '09511234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (52, 'Donor 52', 'donor52@example.com', '09521234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (53, 'Donor 53', 'donor53@example.com', '09531234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (54, 'Donor 54', 'donor54@example.com', '09541234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (55, 'Donor 55', 'donor55@example.com', '09551234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (56, 'Donor 56', 'donor56@example.com', '09561234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (57, 'Donor 57', 'donor57@example.com', '09571234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (58, 'Donor 58', 'donor58@example.com', '09581234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (59, 'Donor 59', 'donor59@example.com', '09591234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (60, 'Donor 60', 'donor60@example.com', '09601234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (61, 'Donor 61', 'donor61@example.com', '09611234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (62, 'Donor 62', 'donor62@example.com', '09621234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (63, 'Donor 63', 'donor63@example.com', '09631234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (64, 'Donor 64', 'donor64@example.com', '09641234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (65, 'Donor 65', 'donor65@example.com', '09651234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (66, 'Donor 66', 'donor66@example.com', '09661234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (67, 'Donor 67', 'donor67@example.com', '09671234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (68, 'Donor 68', 'donor68@example.com', '09681234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (69, 'Donor 69', 'donor69@example.com', '09691234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (70, 'Donor 70', 'donor70@example.com', '09701234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (71, 'Donor 71', 'donor71@example.com', '09711234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (72, 'Donor 72', 'donor72@example.com', '09721234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (73, 'Donor 73', 'donor73@example.com', '09731234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (74, 'Donor 74', 'donor74@example.com', '09741234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (75, 'Donor 75', 'donor75@example.com', '09751234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (76, 'Donor 76', 'donor76@example.com', '09761234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (77, 'Donor 77', 'donor77@example.com', '09771234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (78, 'Donor 78', 'donor78@example.com', '09781234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (79, 'Donor 79', 'donor79@example.com', '09791234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (80, 'Donor 80', 'donor80@example.com', '09801234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (81, 'Donor 81', 'donor81@example.com', '09811234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (82, 'Donor 82', 'donor82@example.com', '09821234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (83, 'Donor 83', 'donor83@example.com', '09831234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (84, 'Donor 84', 'donor84@example.com', '09841234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (85, 'Donor 85', 'donor85@example.com', '09851234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (86, 'Donor 86', 'donor86@example.com', '09861234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (87, 'Donor 87', 'donor87@example.com', '09871234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (88, 'Donor 88', 'donor88@example.com', '09881234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (89, 'Donor 89', 'donor89@example.com', '09891234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (90, 'Donor 90', 'donor90@example.com', '09901234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (91, 'Donor 91', 'donor91@example.com', '09911234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (92, 'Donor 92', 'donor92@example.com', '09921234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (93, 'Donor 93', 'donor93@example.com', '09931234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (94, 'Donor 94', 'donor94@example.com', '09941234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (95, 'Donor 95', 'donor95@example.com', '09951234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (96, 'Donor 96', 'donor96@example.com', '09961234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (97, 'Donor 97', 'donor97@example.com', '09971234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (98, 'Donor 98', 'donor98@example.com', '09981234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (99, 'Donor 99', 'donor99@example.com', '09991234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (100, 'Donor 100', 'donor100@example.com', '091001234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (101, 'Donor 101', 'donor101@example.com', '091011234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (102, 'Donor 102', 'donor102@example.com', '091021234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (103, 'Donor 103', 'donor103@example.com', '091031234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (104, 'Donor 104', 'donor104@example.com', '091041234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (105, 'Donor 105', 'donor105@example.com', '091051234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (106, 'Donor 106', 'donor106@example.com', '091061234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (107, 'Donor 107', 'donor107@example.com', '091071234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (108, 'Donor 108', 'donor108@example.com', '091081234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (109, 'Donor 109', 'donor109@example.com', '091091234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (110, 'Donor 110', 'donor110@example.com', '091101234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (111, 'Donor 111', 'donor111@example.com', '091111234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (112, 'Donor 112', 'donor112@example.com', '091121234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (113, 'Donor 113', 'donor113@example.com', '091131234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (114, 'Donor 114', 'donor114@example.com', '091141234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (115, 'Donor 115', 'donor115@example.com', '091151234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (116, 'Donor 116', 'donor116@example.com', '091161234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (117, 'Donor 117', 'donor117@example.com', '091171234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (118, 'Donor 118', 'donor118@example.com', '091181234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (119, 'Donor 119', 'donor119@example.com', '091191234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (120, 'Donor 120', 'donor120@example.com', '091201234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (121, 'Donor 121', 'donor121@example.com', '091211234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (122, 'Donor 122', 'donor122@example.com', '091221234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (123, 'Donor 123', 'donor123@example.com', '091231234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (124, 'Donor 124', 'donor124@example.com', '091241234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (125, 'Donor 125', 'donor125@example.com', '091251234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (126, 'Donor 126', 'donor126@example.com', '091261234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (127, 'Donor 127', 'donor127@example.com', '091271234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (128, 'Donor 128', 'donor128@example.com', '091281234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (129, 'Donor 129', 'donor129@example.com', '091291234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (130, 'Donor 130', 'donor130@example.com', '091301234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (131, 'Donor 131', 'donor131@example.com', '091311234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (132, 'Donor 132', 'donor132@example.com', '091321234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (133, 'Donor 133', 'donor133@example.com', '091331234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (134, 'Donor 134', 'donor134@example.com', '091341234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (135, 'Donor 135', 'donor135@example.com', '091351234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (136, 'Donor 136', 'donor136@example.com', '091361234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (137, 'Donor 137', 'donor137@example.com', '091371234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (138, 'Donor 138', 'donor138@example.com', '091381234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (139, 'Donor 139', 'donor139@example.com', '091391234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (140, 'Donor 140', 'donor140@example.com', '091401234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (141, 'Donor 141', 'donor141@example.com', '091411234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (142, 'Donor 142', 'donor142@example.com', '091421234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (143, 'Donor 143', 'donor143@example.com', '091431234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (144, 'Donor 144', 'donor144@example.com', '091441234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (145, 'Donor 145', 'donor145@example.com', '091451234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (146, 'Donor 146', 'donor146@example.com', '091461234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (147, 'Donor 147', 'donor147@example.com', '091471234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (148, 'Donor 148', 'donor148@example.com', '091481234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (149, 'Donor 149', 'donor149@example.com', '091491234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (150, 'Donor 150', 'donor150@example.com', '091501234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (151, 'Donor 151', 'donor151@example.com', '091511234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (152, 'Donor 152', 'donor152@example.com', '091521234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (153, 'Donor 153', 'donor153@example.com', '091531234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (154, 'Donor 154', 'donor154@example.com', '091541234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (155, 'Donor 155', 'donor155@example.com', '091551234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (156, 'Donor 156', 'donor156@example.com', '091561234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (157, 'Donor 157', 'donor157@example.com', '091571234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (158, 'Donor 158', 'donor158@example.com', '091581234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (159, 'Donor 159', 'donor159@example.com', '091591234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (160, 'Donor 160', 'donor160@example.com', '091601234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (161, 'Donor 161', 'donor161@example.com', '091611234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (162, 'Donor 162', 'donor162@example.com', '091621234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (163, 'Donor 163', 'donor163@example.com', '091631234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (164, 'Donor 164', 'donor164@example.com', '091641234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (165, 'Donor 165', 'donor165@example.com', '091651234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (166, 'Donor 166', 'donor166@example.com', '091661234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (167, 'Donor 167', 'donor167@example.com', '091671234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (168, 'Donor 168', 'donor168@example.com', '091681234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (169, 'Donor 169', 'donor169@example.com', '091691234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (170, 'Donor 170', 'donor170@example.com', '091701234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (171, 'Donor 171', 'donor171@example.com', '091711234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (172, 'Donor 172', 'donor172@example.com', '091721234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (173, 'Donor 173', 'donor173@example.com', '091731234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (174, 'Donor 174', 'donor174@example.com', '091741234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (175, 'Donor 175', 'donor175@example.com', '091751234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (176, 'Donor 176', 'donor176@example.com', '091761234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (177, 'Donor 177', 'donor177@example.com', '091771234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (669, 'yost', NULL, NULL, '2025-02-26 09:49:00.398716+00');
INSERT INTO public.donors VALUES (178, 'Donor 178', 'donor178@example.com', '091781234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (179, 'Donor 179', 'donor179@example.com', '091791234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (180, 'Donor 180', 'donor180@example.com', '091801234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (181, 'Donor 181', 'donor181@example.com', '091811234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (182, 'Donor 182', 'donor182@example.com', '091821234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (183, 'Donor 183', 'donor183@example.com', '091831234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (184, 'Donor 184', 'donor184@example.com', '091841234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (185, 'Donor 185', 'donor185@example.com', '091851234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (186, 'Donor 186', 'donor186@example.com', '091861234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (187, 'Donor 187', 'donor187@example.com', '091871234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (188, 'Donor 188', 'donor188@example.com', '091881234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (189, 'Donor 189', 'donor189@example.com', '091891234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (190, 'Donor 190', 'donor190@example.com', '091901234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (191, 'Donor 191', 'donor191@example.com', '091911234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (192, 'Donor 192', 'donor192@example.com', '091921234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (193, 'Donor 193', 'donor193@example.com', '091931234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (194, 'Donor 194', 'donor194@example.com', '091941234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (195, 'Donor 195', 'donor195@example.com', '091951234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (196, 'Donor 196', 'donor196@example.com', '091961234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (197, 'Donor 197', 'donor197@example.com', '091971234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (198, 'Donor 198', 'donor198@example.com', '091981234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (199, 'Donor 199', 'donor199@example.com', '091991234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (200, 'Donor 200', 'donor200@example.com', '092001234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (201, 'Donor 201', 'donor201@example.com', '092011234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (202, 'Donor 202', 'donor202@example.com', '092021234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (203, 'Donor 203', 'donor203@example.com', '092031234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (204, 'Donor 204', 'donor204@example.com', '092041234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (205, 'Donor 205', 'donor205@example.com', '092051234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (206, 'Donor 206', 'donor206@example.com', '092061234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (207, 'Donor 207', 'donor207@example.com', '092071234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (208, 'Donor 208', 'donor208@example.com', '092081234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (209, 'Donor 209', 'donor209@example.com', '092091234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (210, 'Donor 210', 'donor210@example.com', '092101234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (211, 'Donor 211', 'donor211@example.com', '092111234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (212, 'Donor 212', 'donor212@example.com', '092121234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (213, 'Donor 213', 'donor213@example.com', '092131234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (214, 'Donor 214', 'donor214@example.com', '092141234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (215, 'Donor 215', 'donor215@example.com', '092151234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (216, 'Donor 216', 'donor216@example.com', '092161234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (217, 'Donor 217', 'donor217@example.com', '092171234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (218, 'Donor 218', 'donor218@example.com', '092181234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (219, 'Donor 219', 'donor219@example.com', '092191234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (220, 'Donor 220', 'donor220@example.com', '092201234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (221, 'Donor 221', 'donor221@example.com', '092211234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (222, 'Donor 222', 'donor222@example.com', '092221234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (223, 'Donor 223', 'donor223@example.com', '092231234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (224, 'Donor 224', 'donor224@example.com', '092241234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (225, 'Donor 225', 'donor225@example.com', '092251234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (226, 'Donor 226', 'donor226@example.com', '092261234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (227, 'Donor 227', 'donor227@example.com', '092271234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (228, 'Donor 228', 'donor228@example.com', '092281234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (229, 'Donor 229', 'donor229@example.com', '092291234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (230, 'Donor 230', 'donor230@example.com', '092301234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (231, 'Donor 231', 'donor231@example.com', '092311234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (232, 'Donor 232', 'donor232@example.com', '092321234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (233, 'Donor 233', 'donor233@example.com', '092331234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (234, 'Donor 234', 'donor234@example.com', '092341234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (235, 'Donor 235', 'donor235@example.com', '092351234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (236, 'Donor 236', 'donor236@example.com', '092361234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (237, 'Donor 237', 'donor237@example.com', '092371234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (238, 'Donor 238', 'donor238@example.com', '092381234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (239, 'Donor 239', 'donor239@example.com', '092391234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (240, 'Donor 240', 'donor240@example.com', '092401234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (241, 'Donor 241', 'donor241@example.com', '092411234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (242, 'Donor 242', 'donor242@example.com', '092421234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (243, 'Donor 243', 'donor243@example.com', '092431234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (244, 'Donor 244', 'donor244@example.com', '092441234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (245, 'Donor 245', 'donor245@example.com', '092451234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (246, 'Donor 246', 'donor246@example.com', '092461234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (247, 'Donor 247', 'donor247@example.com', '092471234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (248, 'Donor 248', 'donor248@example.com', '092481234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (249, 'Donor 249', 'donor249@example.com', '092491234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (250, 'Donor 250', 'donor250@example.com', '092501234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (251, 'Donor 251', 'donor251@example.com', '092511234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (252, 'Donor 252', 'donor252@example.com', '092521234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (253, 'Donor 253', 'donor253@example.com', '092531234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (254, 'Donor 254', 'donor254@example.com', '092541234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (255, 'Donor 255', 'donor255@example.com', '092551234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (256, 'Donor 256', 'donor256@example.com', '092561234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (257, 'Donor 257', 'donor257@example.com', '092571234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (258, 'Donor 258', 'donor258@example.com', '092581234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (259, 'Donor 259', 'donor259@example.com', '092591234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (260, 'Donor 260', 'donor260@example.com', '092601234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (261, 'Donor 261', 'donor261@example.com', '092611234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (262, 'Donor 262', 'donor262@example.com', '092621234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (263, 'Donor 263', 'donor263@example.com', '092631234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (264, 'Donor 264', 'donor264@example.com', '092641234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (265, 'Donor 265', 'donor265@example.com', '092651234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (670, 'jexxg', NULL, NULL, '2025-02-26 09:55:03.003487+00');
INSERT INTO public.donors VALUES (266, 'Donor 266', 'donor266@example.com', '092661234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (267, 'Donor 267', 'donor267@example.com', '092671234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (268, 'Donor 268', 'donor268@example.com', '092681234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (269, 'Donor 269', 'donor269@example.com', '092691234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (270, 'Donor 270', 'donor270@example.com', '092701234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (271, 'Donor 271', 'donor271@example.com', '092711234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (272, 'Donor 272', 'donor272@example.com', '092721234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (273, 'Donor 273', 'donor273@example.com', '092731234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (274, 'Donor 274', 'donor274@example.com', '092741234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (275, 'Donor 275', 'donor275@example.com', '092751234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (276, 'Donor 276', 'donor276@example.com', '092761234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (277, 'Donor 277', 'donor277@example.com', '092771234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (278, 'Donor 278', 'donor278@example.com', '092781234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (279, 'Donor 279', 'donor279@example.com', '092791234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (280, 'Donor 280', 'donor280@example.com', '092801234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (281, 'Donor 281', 'donor281@example.com', '092811234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (282, 'Donor 282', 'donor282@example.com', '092821234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (283, 'Donor 283', 'donor283@example.com', '092831234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (284, 'Donor 284', 'donor284@example.com', '092841234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (285, 'Donor 285', 'donor285@example.com', '092851234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (286, 'Donor 286', 'donor286@example.com', '092861234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (287, 'Donor 287', 'donor287@example.com', '092871234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (288, 'Donor 288', 'donor288@example.com', '092881234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (289, 'Donor 289', 'donor289@example.com', '092891234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (290, 'Donor 290', 'donor290@example.com', '092901234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (291, 'Donor 291', 'donor291@example.com', '092911234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (292, 'Donor 292', 'donor292@example.com', '092921234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (293, 'Donor 293', 'donor293@example.com', '092931234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (294, 'Donor 294', 'donor294@example.com', '092941234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (295, 'Donor 295', 'donor295@example.com', '092951234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (296, 'Donor 296', 'donor296@example.com', '092961234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (297, 'Donor 297', 'donor297@example.com', '092971234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (298, 'Donor 298', 'donor298@example.com', '092981234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (299, 'Donor 299', 'donor299@example.com', '092991234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (300, 'Donor 300', 'donor300@example.com', '093001234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (301, 'Donor 301', 'donor301@example.com', '093011234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (302, 'Donor 302', 'donor302@example.com', '093021234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (303, 'Donor 303', 'donor303@example.com', '093031234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (304, 'Donor 304', 'donor304@example.com', '093041234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (305, 'Donor 305', 'donor305@example.com', '093051234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (306, 'Donor 306', 'donor306@example.com', '093061234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (307, 'Donor 307', 'donor307@example.com', '093071234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (308, 'Donor 308', 'donor308@example.com', '093081234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (309, 'Donor 309', 'donor309@example.com', '093091234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (310, 'Donor 310', 'donor310@example.com', '093101234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (311, 'Donor 311', 'donor311@example.com', '093111234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (312, 'Donor 312', 'donor312@example.com', '093121234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (313, 'Donor 313', 'donor313@example.com', '093131234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (314, 'Donor 314', 'donor314@example.com', '093141234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (315, 'Donor 315', 'donor315@example.com', '093151234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (316, 'Donor 316', 'donor316@example.com', '093161234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (317, 'Donor 317', 'donor317@example.com', '093171234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (318, 'Donor 318', 'donor318@example.com', '093181234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (319, 'Donor 319', 'donor319@example.com', '093191234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (320, 'Donor 320', 'donor320@example.com', '093201234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (321, 'Donor 321', 'donor321@example.com', '093211234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (322, 'Donor 322', 'donor322@example.com', '093221234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (323, 'Donor 323', 'donor323@example.com', '093231234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (324, 'Donor 324', 'donor324@example.com', '093241234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (325, 'Donor 325', 'donor325@example.com', '093251234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (326, 'Donor 326', 'donor326@example.com', '093261234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (327, 'Donor 327', 'donor327@example.com', '093271234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (328, 'Donor 328', 'donor328@example.com', '093281234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (329, 'Donor 329', 'donor329@example.com', '093291234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (330, 'Donor 330', 'donor330@example.com', '093301234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (331, 'Donor 331', 'donor331@example.com', '093311234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (332, 'Donor 332', 'donor332@example.com', '093321234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (333, 'Donor 333', 'donor333@example.com', '093331234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (334, 'Donor 334', 'donor334@example.com', '093341234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (335, 'Donor 335', 'donor335@example.com', '093351234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (336, 'Donor 336', 'donor336@example.com', '093361234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (337, 'Donor 337', 'donor337@example.com', '093371234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (338, 'Donor 338', 'donor338@example.com', '093381234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (339, 'Donor 339', 'donor339@example.com', '093391234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (340, 'Donor 340', 'donor340@example.com', '093401234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (341, 'Donor 341', 'donor341@example.com', '093411234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (342, 'Donor 342', 'donor342@example.com', '093421234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (343, 'Donor 343', 'donor343@example.com', '093431234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (344, 'Donor 344', 'donor344@example.com', '093441234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (345, 'Donor 345', 'donor345@example.com', '093451234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (346, 'Donor 346', 'donor346@example.com', '093461234567', '2025-02-04 04:08:51.060317+00');
INSERT INTO public.donors VALUES (347, 'Donor 347', 'donor347@example.com', '093471234567', '2025-02-04 04:08:51.060317+00');
COMMIT;
