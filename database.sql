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


create table children(
   id int8 primary key,
    first_name text,
    last_name text,
    weight real,
    height real,
    BMI text

);

create or replace function newChild(par_id int8, par_fname text, par_lname text, par_weight real, par_height real, par_BMI text) returns text as
$$
    declare
        loc_id text;
        loc_res text;
    begin
        select into loc_id id from children where id= par_id;
        if loc_id isnull then
            insert into children(id, first_name, last_name, weight, height, BMI) values (par_id, par_fname, par_lname, par_weight, par_height, par_BMI);
            loc_res ='New child added';
        else
            loc_res ='Data exists'
        end if;
            return loc_res;
        end;
$$
    language 'plpgsql';

create or replace function dropfocal(par_id int8) returns text as
    $$
        declare
            loc_id text;
            loc_res text;
        begin
            select into loc_id from focal where id =par_id;
            if loc_id isnull then
                loc_res ='Data Not Found.';
            else

                --how to delete po
                loc_res ='Data deleted';
            end if;
                return loc_res;
		end;
    $$
        language 'plpgsql';

create or replace function updatefocal(par_id int8, par_designation text) returns text as
	$$
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
	$$

		language 'plpgsql';
	
	--select updatefocal(1, 'Canaway');




