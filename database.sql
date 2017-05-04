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


);
create or replace function