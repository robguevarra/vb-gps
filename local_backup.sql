--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
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
-- Name: get_auth_email(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_auth_email() RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  RETURN (SELECT email FROM auth.users WHERE id = auth.uid());
END;
$$;


ALTER FUNCTION public.get_auth_email() OWNER TO postgres;

--
-- Name: is_superadmin(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.is_superadmin() RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 
    FROM user_roles 
    WHERE user_id = auth.uid() 
    AND role = 'superadmin'
  );
END;
$$;


ALTER FUNCTION public.is_superadmin() OWNER TO postgres;

--
-- PostgreSQL database dump complete
--

