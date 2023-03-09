
-- Return all rows where 3 or more consecutive ids have more than 1000 audience sorted by ascending order of Visit_Date Stadium:

-- Using RN

select * from stadium;
with cte as (
    select *
        ,(row_number() over (order by visit_date)) rn
        ,id - (row_number() over (order by visit_date)) as x
        from
        stadium
    where
        audience>=1000
)
select id
    ,visit_date
    ,audience
from cte
where x in (
        select x from cte
        group by x having count(x)>=3);


---- Using LAG/LEAD

-- concept
--  id+1=nextID_1 AND id+2 = nextID_2 -> first row
--  id-1=prevID_1 AND id-2 = prevID_2 -> last row
--  id-1 = prevID_1 and id+1=nextID_1 -> middle row

with x as (
select id, 
       visit_date, 
       audience, 
       lag(id,1,0) over(order by id) as previd_1, 
       lag(id,2,0) over(order by id) as previd_2,
       lead(id,1,0) over(order by id) as nextid_1, 
       lead(id,2,0) over(order by id) as nextid_2
from stadium 
where audience>=1000
),
y as (
select *, 
       case when id+1=nextid_1 and id+2 = nextid_2 then 1 
            when id-1=previd_1 and id-2 = previd_2 then 1 
            when id-1 = previd_1 and id+1=nextid_1 then 1
            else 0 end as flag
from x
)
select id, visit_date, audience from y where flag = 1;


