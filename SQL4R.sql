create table employee_duplicate (emp_id int not null , emp_name varchar(10), salary money, create_timpestamp varchar(20));

drop table employee_duplicate;

insert into employee_duplicate values( 1, 'bd', 1000, '2019-02-12'),(1, 'ar',2000, '2019-02-123'),(2,'nv',2300,'2019-04-23'),(1, 'ar',2000, '2019-02-123'),(2,'nv',2300,'2019-04-23'),(1, 'ar',2000, '2019-02-123'),(2,'nv',2300,'2019-04-23');

-- 