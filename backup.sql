--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.16
-- Dumped by pg_dump version 9.3.16
-- Started on 2017-05-25 11:04:23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 1 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1976 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 195 (class 1255 OID 65717)
-- Name: countstat(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION countstat(data text) RETURNS bigint
    LANGUAGE sql
    AS $$
	select count(nutritional_status) from statusrepo where nutritional_status=data;
$$;


ALTER FUNCTION public.countstat(data text) OWNER TO postgres;

--
-- TOC entry 190 (class 1255 OID 32839)
-- Name: dropchild(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dropchild(par_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
        declare
            loc_id text;
            loc_res text;
        begin
            select into loc_id id from children where id =par_id;
            if loc_id isnull then
                loc_res ='Data Not Found.';
            else

                --how to delete po
				delete from children where id= par_id;
                loc_res ='Data deleted';
            end if;
                return loc_res;
		end;
    $$;


ALTER FUNCTION public.dropchild(par_id bigint) OWNER TO postgres;

--
-- TOC entry 189 (class 1255 OID 32825)
-- Name: dropfocal(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION dropfocal(par_id bigint) RETURNS text
    LANGUAGE plpgsql
    AS $$
        declare
            loc_id text;
            loc_res text;
        begin
            select into loc_id id from focal where id =par_id;
            if loc_id isnull then
                loc_res ='Data Not Found.';
            else

                --how to delete po
				delete from focal where id= par_id;
                loc_res ='Data deleted';
            end if;
                return loc_res;
		end;
    $$;


ALTER FUNCTION public.dropfocal(par_id bigint) OWNER TO postgres;

--
-- TOC entry 192 (class 1255 OID 49206)
-- Name: getaccess(bigint, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getaccess(par_id bigint, par_lname text) RETURNS text
    LANGUAGE plpgsql
    AS $$
	declare
		loc_id text;
		loc_res text;
	
	begin
		select into loc_id id, position from employees where id=par_id;
		
		if loc_id is null then
			loc_res = 'Person not authorized';
		
		else
			loc_res = 'Access granted';
		
		end if;
			return loc_res;
	end;

$$;


ALTER FUNCTION public.getaccess(par_id bigint, par_lname text) OWNER TO postgres;

--
-- TOC entry 196 (class 1255 OID 65712)
-- Name: getchildren(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getchildren(OUT bigint, OUT text, OUT text, OUT real, OUT real, OUT text) RETURNS SETOF record
    LANGUAGE sql
    AS $$
	select children.id, children.first_name, children.last_name, children.weight, children.height, statusRepo.nutritional_status from children, statusRepo where statusRepo.id=children.id;
$$;


ALTER FUNCTION public.getchildren(OUT bigint, OUT text, OUT text, OUT real, OUT real, OUT text) OWNER TO postgres;

--
-- TOC entry 193 (class 1255 OID 57396)
-- Name: getfocal(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getfocal(OUT bigint, OUT text, OUT text, OUT text) RETURNS SETOF record
    LANGUAGE sql
    AS $$
	select id, first_name, last_name, position from employees;
$$;


ALTER FUNCTION public.getfocal(OUT bigint, OUT text, OUT text, OUT text) OWNER TO postgres;

--
-- TOC entry 198 (class 1255 OID 65647)
-- Name: newchild(bigint, text, text, real, real); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION newchild(par_id bigint, par_fname text, par_lname text, par_weight real, par_height real) RETURNS text
    LANGUAGE plpgsql
    AS $$
	declare
		loc_id text;
		id text;
		loc_res text;
		status real;
	
	begin
		if loc_id isnull then
			insert into children(id, first_name, last_name, weight, height) values (par_id, par_fname, par_lname, par_weight, par_height);
			
			status := par_weight/(par_height*par_height);
			
			case
				when status< 18.5 then
					insert into statusRepo(id, calc_BMI, nutritional_status) values(par_id, status, 'Underweight');
				
				when status >=18.5 and status <=24.9 then
					insert into statusRepo(id, calc_BMI, nutritional_status) values(par_id, status, 'Normal');
				when status >=25 and status <=29.9 then
					insert into statusRepo(id, calc_BMI, nutritional_status) values(par_id, status, 'Overweight');
				
				else	
					insert into statusRepo(id, calc_BMI, nutritional_status) values(par_id, status, 'Obesity');
				
			end case;
		
			
			
			loc_res ='Successfully added';
			
			
		elsif loc_id is not null then
			loc_res ='Child exists';
		
		end if;
			return loc_res;
	
			
	end;
$$;


ALTER FUNCTION public.newchild(par_id bigint, par_fname text, par_lname text, par_weight real, par_height real) OWNER TO postgres;

--
-- TOC entry 197 (class 1255 OID 65705)
-- Name: newchild2(bigint, text, text, real, real); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION newchild2(par_id bigint, par_fname text, par_lname text, par_weight real, par_height real) RETURNS text
    LANGUAGE plpgsql
    AS $$
	declare
		loc_id text;
		loc_res text;
		status real;
	
	begin
		select into loc_id id from children where id=par_id;
		if loc_id isnull then
			insert into children(id, first_name, last_name, weight, height) values (par_id, par_fname, par_lname, par_weight, par_height);
			status := par_weight/(par_height*par_height);
			
				case
				when status< 18.5 then
					insert into statusRepo(id, calc_BMI, nutritional_status) values(par_id, status, 'Underweight');
				
				when status >=18.5 and status <=24.9 then
					insert into statusRepo(id, calc_BMI, nutritional_status) values(par_id, status, 'Normal');
				when status >=25 and status <=29.9 then
					insert into statusRepo(id, calc_BMI, nutritional_status) values(par_id, status, 'Overweight');
				
				else	
					insert into statusRepo(id, calc_BMI, nutritional_status) values(par_id, status, 'Obesity');
				
			end case;
			loc_res ='Successfully added';
		
			elsif loc_id is not null then
			loc_res ='Child exists';
		
		end if;
			return loc_res;
	
		
	end;

$$;


ALTER FUNCTION public.newchild2(par_id bigint, par_fname text, par_lname text, par_weight real, par_height real) OWNER TO postgres;

--
-- TOC entry 194 (class 1255 OID 57397)
-- Name: newemployee(bigint, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION newemployee(par_id bigint, par_fname text, par_lname text, par_position text) RETURNS text
    LANGUAGE plpgsql
    AS $$
	declare
		loc_id text;
		loc_res text;
	
	begin
		select into loc_id id from employees where id=par_id;
		if loc_id isnull then
			insert into employees(id, first_name, last_name, position) values (par_id, par_fname, par_lname, par_position);
			loc_res ='Employee Added';
		
		else
			loc_res ='Employee Exists';
		
		end if;
			return loc_res;
		
	end;
$$;


ALTER FUNCTION public.newemployee(par_id bigint, par_fname text, par_lname text, par_position text) OWNER TO postgres;

--
-- TOC entry 187 (class 1255 OID 24683)
-- Name: newfocal(bigint, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION newfocal(par_id bigint, par_fname text, par_lname text, par_designation text) RETURNS text
    LANGUAGE plpgsql
    AS $$
    declare
        loc_id text;
        loc_res text;

    begin
        select into loc_id id from focal where id =par_id;
        if loc_id isnull then
            insert into focal(id, first_name, last_name, designation) values (par_id, par_fname, par_lname, par_designation);
            loc_res ='Focal Added';
         else
            loc_res ='Focal Exists';
         end if;
            return loc_res;
    end;
    $$;


ALTER FUNCTION public.newfocal(par_id bigint, par_fname text, par_lname text, par_designation text) OWNER TO postgres;

--
-- TOC entry 191 (class 1255 OID 65600)
-- Name: searchfocal(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION searchfocal(par_data text, OUT text, OUT text, OUT text) RETURNS SETOF record
    LANGUAGE sql
    AS $$
	select first_name, last_name, position from employees where first_name=par_data or last_name=par_data or position=par_data;
$$;


ALTER FUNCTION public.searchfocal(par_data text, OUT text, OUT text, OUT text) OWNER TO postgres;

--
-- TOC entry 188 (class 1255 OID 32823)
-- Name: updatefocal(bigint, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION updatefocal(par_id bigint, par_designation text) RETURNS text
    LANGUAGE plpgsql
    AS $$
		declare
			loc_id text;
			loc_res text;
		begin
			select into loc_id id from focal where id= par_id;
			if loc_id isnull then
				loc_res = 'Data not found';
			else
				--update query
				update focal set designation = par_designation where id=par_id;
				loc_res ='Data updated.';
			end if;
				return loc_res;
		end;
	$$;


ALTER FUNCTION public.updatefocal(par_id bigint, par_designation text) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 173 (class 1259 OID 65681)
-- Name: children; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE children (
    id bigint NOT NULL,
    first_name text,
    last_name text,
    weight real,
    height real
);


ALTER TABLE public.children OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 65588)
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE employees (
    id bigint NOT NULL,
    first_name text,
    last_name text,
    "position" text
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 24650)
-- Name: focal; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE focal (
    id bigint NOT NULL,
    first_name text,
    last_name text,
    designation text
);


ALTER TABLE public.focal OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 65689)
-- Name: statusrepo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE statusrepo (
    id bigint NOT NULL,
    calc_bmi real,
    nutritional_status text
);


ALTER TABLE public.statusrepo OWNER TO postgres;

--
-- TOC entry 1967 (class 0 OID 65681)
-- Dependencies: 173
-- Data for Name: children; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY children (id, first_name, last_name, weight, height) FROM stdin;
20131234	Albeto	Einstein	42	1.60000002
1	A	B	58	2
9090	Aga	Mulach	56	2
1996	Jehan	Ananggo	46	1
1995	Johanna	Ananggo	46	1.20000005
20	ABAA	ajalak	20	0.699999988
201	ABAA	ajalak	20	0.699999988
2013	Ailen	Aspe	42	1.5
2014	Allen	Aspe	40	1.29999995
\.


--
-- TOC entry 1966 (class 0 OID 65588)
-- Dependencies: 172
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY employees (id, first_name, last_name, "position") FROM stdin;
20131364	Aspe	Ailen Grace	Supervisor
20131300	Holmes	Sherlock	Focal Person
124	Holmes	1agkl	Focal Person
1249	Holmes	1agkl	Focal Person
124999	Holmes	1agkl	Focal Person
124909	Holmes	1agkl00	Focal Person
12490900	Holmes	1agkl00	Focal Person
19094	Holmes	1agkl00	Focal Person
190947	Holmes	1agkl00	Focal Person
19094799	Holmes	1agkl00	Focal Person
12415	Holmes	Mycroft	Supervisor
1241500	Holmes	Mycroft	Supervisor
12415000	Holmes	Mycroft	Supervisor
20131365	Einstein	Albert	Supervisor
1234059	Hawking	Stephen	Focal Person
1234050	Hawking	Stephen	Focal Person
1	Brahe	Tycho	Focal Person
92	Gonzales	Michelle	Focal Person
45			
7980			
2013900	Ariston	Kim	Focal Person
20137239	Reid	James	Focal Person
20001	John	Holmes	Focal Person
\.


--
-- TOC entry 1965 (class 0 OID 24650)
-- Dependencies: 171
-- Data for Name: focal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY focal (id, first_name, last_name, designation) FROM stdin;
1	Sherlock	Holmes	Tibanga
\.


--
-- TOC entry 1968 (class 0 OID 65689)
-- Dependencies: 174
-- Data for Name: statusrepo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY statusrepo (id, calc_bmi, nutritional_status) FROM stdin;
20131234	16.4062481	Underweight
1	14.5	Underweight
9090	14	Underweight
1996	46	Obesity
1995	31.9444427	Obesity
20	40.81633	Obesity
201	40.81633	Obesity
2013	18.666666	Normal
2014	23.668642	Normal
\.


--
-- TOC entry 1854 (class 2606 OID 65688)
-- Name: children_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY children
    ADD CONSTRAINT children_pkey PRIMARY KEY (id);


--
-- TOC entry 1852 (class 2606 OID 65595)
-- Name: employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- TOC entry 1850 (class 2606 OID 24657)
-- Name: focal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY focal
    ADD CONSTRAINT focal_pkey PRIMARY KEY (id);


--
-- TOC entry 1856 (class 2606 OID 65696)
-- Name: statusrepo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY statusrepo
    ADD CONSTRAINT statusrepo_pkey PRIMARY KEY (id);


--
-- TOC entry 1857 (class 2606 OID 65697)
-- Name: statusrepo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY statusrepo
    ADD CONSTRAINT statusrepo_id_fkey FOREIGN KEY (id) REFERENCES children(id);


--
-- TOC entry 1975 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2017-05-25 11:04:23

--
-- PostgreSQL database dump complete
--

