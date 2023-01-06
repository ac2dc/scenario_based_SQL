

select * from salary order by Ammount desc;
-- select second highest salary from table
;with T as ( 
select *, dense_rank() over (order by Ammount desc) rnk
from salary) 
select Employee_id from T
where rnk = 2; --  change to 3 if you want 3rd highest

-- OR
SELECT MAX( ammount) second_sal FROM salary WHERE ammount< ( SELECT MAX( ammount) FROM salary )


select * , sum(ammount) over (order by ammount 
                                rows between unbounded preceding and 3 preceding) as tot 
from salary;

-- Deleting duplicate data in sql

-- create table  cars
-- (
--     id      int,
--     model   varchar(50),
--     brand   varchar(40),
--     color   varchar(30),
--     make    int
-- );
insert into cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into cars values (2, 'EQS', 'Mercedes-Benz', 'Black', 2022);
insert into cars values (3, 'iX', 'BMW', 'Red', 2022);
insert into cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);
insert into cars values (5, 'Model S', 'Tesla', 'Silver', 2018);
insert into cars values (6, 'Ioniq 5', 'Hyundai', 'Green', 2021);

select * from cars
order by model, brand;

-- sol 1 Using self Join
DELETE from cars 
where id in (
            SELECT c2.id
            from cars c1 
            JOIN cars c2
            on c1.model = c2.model and c1.brand = c2.brand
            where c1.id < c2.id);
-- Usinf windows funtions
select id  -- use delete to del
from (
        select *, ROW_NUMBER() over (PARTITION BY model, brand order by model, brand desc) rn 
        from cars) x 
where x.rn > 1;

-- using min agrregate funtion in a subquery


--- Using backup table w/o droping original table

select * into cars_bc from cars where 1=2;

insert into cars_bc 
select * 
from cars 
where id in (
    select min(id) from cars 
    group by model, brand
);

select * from cars_bc; 

-- Creating a temporary unique id col
-- alter table cars_bc add row_num int IDENTITY
select * from cars_bc
where row_num in (
        select max(row_num)
        from cars_bc
        group by model, brand
        having count(*) > 1
);

--------------------------------------------------------------------
----------------------------------------------------------------------
create table car_travels
(
    cars                    varchar(40),
    days                    varchar(10),
    cumulative_distance     int
);
insert into car_travels values ('Car1', 'Day1', 50);
insert into car_travels values ('Car1', 'Day2', 100);
insert into car_travels values ('Car1', 'Day3', 200);
insert into car_travels values ('Car2', 'Day1', 0);
insert into car_travels values ('Car3', 'Day1', 0);
insert into car_travels values ('Car3', 'Day2', 50);
insert into car_travels values ('Car3', 'Day3', 50);
insert into car_travels values ('Car3', 'Day4', 100);

select * from car_travels;

-- pS : Get KM travelled by car on given day --

 select *
        , cumulative_distance - lag(cumulative_distance,1,0) over(partition by cars order by [days]) as dpd

from car_travels;