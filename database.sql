--create database NAIS

create table focal(
    id int8 primary key references employees(id),
    designation text
);

create or replace function countstat(in data text) returns text as
$$
	select count(nutritional_status) from statusrepo where nutritional_status=data;
$$
language 'sql';
--select * from countstat('Normal')


create or replace function getfocal(out int8, out text, out text, out text) returns setof record as
$$
	select id, first_name, last_name, position from employees;
$$
language 'sql';

-- select * from getfocal();

create or replace function getchildren(out int8, out text, out text, out real, out real, out text) returns setof record as
$$
	select children.id, children.first_name, children.last_name, children.weight, children.height, statusRepo.nutritional_status from children, statusRepo where statusRepo.id=children.id;
$$
language 'sql';
--select * from getchildren()
create or replace function searchfocal(in par_data text, out text, out text, out text)  returns setof record as
$$
	select first_name, last_name, position from employees where first_name=par_data or last_name=par_data or position=par_data;
$$
language 'sql';

--select * from searchfocal('Holmes');


create table employees(
	id int8 primary key,
	first_name text,
	last_name text,
	position text
	

);
create or replace function getaccess(par_id int8, par_lname text) returns text as
$$
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

$$ 
	language 'plpgsql';
			

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
-- select newEmployee(20130000, 'Sherlock', 'Holmes', 'Focal Person');



create table children(
   id int8 primary key,
    first_name text,
    last_name text,
    weight real,
    height real
);

create table statusRepo(
	
	id int8 primary key references children(id),
	calc_BMI real,
	nutritional_status text
);

create or replace function newchild(par_id int8,par_fname text, par_lname text, par_weight real, par_height real) returns text as
$$
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
$$
	language 'plpgsql';


create or replace function newchild2(par_id int8,par_fname text, par_lname text, par_weight real, par_height real) returns text as
$$
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

$$
	language 'plpgsql';

--select newchild2(20131234, 'Alberto', 'Einstein', 42, 1.6);


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
	
	
