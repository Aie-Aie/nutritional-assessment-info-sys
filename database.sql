--create database NAIS

create table focal(
    id int8 primary key,
    first_name text,
    last_name text,
    designation text
);
create table supervisors(

    id int8 primary key,
    first_name text,
    last_name text

);

create table children(
   id int8 primary key,
    first_name text,
    last_name text,
    weight real,
    height real,
    BMI real

);
create or replace function newfocal(par_id int8, par_fname text, par_lname text, par_designation text) returns text as
$$
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
    $$
    language 'plpgsql';
--select newfocal(1,'Sherlock', 'Holmes', 'Tibanga');

--insert into supervisors(id, first_name, last_name) values (1364, 'Mycroft', 'Holmes');
--insert into supervisors(id, first_name, last_name) values (2013, 'Allan', 'Turing');

create or replace function

