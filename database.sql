--create database NAIS

create table focal(
    id int8 primary key references employees(id),
    designation text
);


create table employees(
	id int8 primary key,
	first_name text,
	last_name text,
	position text
	

);

create or replace function newEmployee(par_id int8, par_fname text, par_lname text, par_position text) returns text as
$$
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
$$
	language 'plpgsql';

--	select newEmployee(20131364, 'Ailen Grace', 'Aspe', 'Supervisor');



create table children(
   id int8 primary key,
    first_name text,
    last_name text,
    weight real,
    height real
);

create table statusRepo(
	id int8 references children(id),
	calc_BMI real,
	nutritional_status text
);

create or replace function newChild(par_id int, par_fname text, par_lname text, par_weight real, par_height real) returns text as
$$
	declare
		loc_id text;
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
		
			insert into statusRepo(id, calc_BMI) values(par_id, status);
			
			loc_res ='Successfully added';
			
			
		elsif loc_id is not null then
			loc_res ='Child exists';
		
		end if;
			return loc_res;
	
			
	end;
$$
	language 'plpgsql';

--select newChild(20131234, 'Alberto', 'Einstein', 42, 1.6);


create or replace function dropEmployee(par_id int8) returns text as
    $$
        declare
            loc_id text;
            loc_res text;
        begin
            select into loc_id id from employees where id =par_id;
            if loc_id isnull then
                loc_res ='Data Not Found.';
            else

				delete from employees where id= par_id;
                loc_res ='Data deleted';
            end if;
                return loc_res;
		end;
    $$
        language 'plpgsql';
--select dropEmployee(10);


create or replace function updateEmployee(in par_id int8, par_position text) returns text as
	$$
		declare
			loc_id text;
			loc_res text;
		begin
			select into loc_id id from employees where id= par_id;
			if loc_id isnull then
				loc_res = 'Data not found';
			else

				update employees set position = par_position where id=par_id;
				loc_res ='Data updated.';
			end if;
				return loc_res;
		end;
	$$

		language 'plpgsql';
	
	--select updateEmployee(1, 'Canaway');
	
	---cascade delete

	create or replace function dropChild(par_id int8) returns text as
    $$
        declare
            loc_id text;
            loc_res text;
        begin
            select into loc_id id from children where id =par_id;
            if loc_id isnull then
                loc_res ='Data Not Found.';
            else

				delete from children where id= par_id;
                loc_res ='Data deleted';
            end if;
                return loc_res;
		end;
    $$
        language 'plpgsql';
	--select dropChild(1234);
	
	
