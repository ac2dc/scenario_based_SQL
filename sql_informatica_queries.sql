-- 1 - 100 using for loop

with cte as (
    select 1 as num
        union all
    select  num + 1 from cte where num < 10
)
SELECT * from cte;


-- Home work

-- write a query to get 15 days date 
with get_date as(
    select GETDATE() as Dates
    union all
    select Dates + 15 from get_date where Dates < 15
)
select * from get_date; 





