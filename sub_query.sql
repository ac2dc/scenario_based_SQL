-->> Solution breakup:
-- 1) get the file ext
-- 2) for each day, find how many times each file ext was modified.
-- 3) for each day, get the max modified file ext from #2
-- 4) if there is a tie then concatenate file ext.


-->> PostgreSQL
-- Dataset PostgreSQL
-- drop table files;
-- create table files
-- (
-- id              int primary key,
-- date_modified   date,
-- file_name       varchar(50)
-- );
-- insert into files values (1	,   to_date('2021-06-03','yyyy-mm-dd'), 'thresholds.svg');
-- insert into files values (2	,   to_date('2021-06-01','yyyy-mm-dd'), 'redrag.py');
-- insert into files values (3	,   to_date('2021-06-03','yyyy-mm-dd'), 'counter.pdf');
-- insert into files values (4	,   to_date('2021-06-06','yyyy-mm-dd'), 'reinfusion.py');
-- insert into files values (5	,   to_date('2021-06-06','yyyy-mm-dd'), 'tonoplast.docx');
-- insert into files values (6	,   to_date('2021-06-01','yyyy-mm-dd'), 'uranian.pptx');
-- insert into files values (7	,   to_date('2021-06-03','yyyy-mm-dd'), 'discuss.pdf');
-- insert into files values (8	,   to_date('2021-06-06','yyyy-mm-dd'), 'nontheologically.pdf');
-- insert into files values (9	,   to_date('2021-06-01','yyyy-mm-dd'), 'skiagrams.py');
-- insert into files values (10,   to_date('2021-06-04','yyyy-mm-dd'), 'flavors.py');
-- insert into files values (11,   to_date('2021-06-05','yyyy-mm-dd'), 'nonv.pptx');
-- insert into files values (12,   to_date('2021-06-01','yyyy-mm-dd'), 'under.pptx');
-- insert into files values (13,   to_date('2021-06-02','yyyy-mm-dd'), 'demit.csv');
-- insert into files values (14,   to_date('2021-06-02','yyyy-mm-dd'), 'trailings.pptx');
-- insert into files values (15,   to_date('2021-06-04','yyyy-mm-dd'), 'asst.py');
-- insert into files values (16,   to_date('2021-06-03','yyyy-mm-dd'), 'pseudo.pdf');
-- insert into files values (17,   to_date('2021-06-03','yyyy-mm-dd'), 'unguarded.jpeg');
-- insert into files values (18,   to_date('2021-06-06','yyyy-mm-dd'), 'suzy.docx');
-- insert into files values (19,   to_date('2021-06-06','yyyy-mm-dd'), 'anitsplentic.py');
-- insert into files values (20,   to_date('2021-06-03','yyyy-mm-dd'), 'tallies.py');

-- -- Solution PostgreSQL:
-- with cte as
-- (select date_modified, substring(file_name, position('.' in file_name) + 1) as file_ext, count(1) as cnt
-- from files
-- group by date_modified,file_ext)
-- select date_modified, string_agg(file_ext, ',' order by file_ext desc) as extension, max(cnt) as count
-- from cte c1
-- where cnt = (select max(cnt) from cte c2 where c1.date_modified=c2.date_modified )
-- group by date_modified
-- order by 1;



-->> MSSQL
-- Dataset MSSQL:
drop table files;
create table files
(
id              int primary key,
date_modified   date,
file_name       varchar(50)
);
insert into files values (1	,   convert(datetime, '2021-06-03'), 'thresholds.svg');
insert into files values (2	,   convert(datetime, '2021-06-01'), 'redrag.py');
insert into files values (3	,   convert(datetime, '2021-06-03'), 'counter.pdf');
insert into files values (4	,   convert(datetime, '2021-06-06'), 'reinfusion.py');
insert into files values (5	,   convert(datetime, '2021-06-06'), 'tonoplast.docx');
insert into files values (6	,   convert(datetime, '2021-06-01'), 'uranian.pptx');
insert into files values (7	,   convert(datetime, '2021-06-03'), 'discuss.pdf');
insert into files values (8	,   convert(datetime, '2021-06-06'), 'nontheologically.pdf');
insert into files values (9	,   convert(datetime, '2021-06-01'), 'skiagrams.py');
insert into files values (10,   convert(datetime, '2021-06-04'), 'flavors.py');
insert into files values (11,   convert(datetime, '2021-06-05'), 'nonv.pptx');
insert into files values (12,   convert(datetime, '2021-06-01'), 'under.pptx');
insert into files values (13,   convert(datetime, '2021-06-02'), 'demit.csv');
insert into files values (14,   convert(datetime, '2021-06-02'), 'trailings.pptx');
insert into files values (15,   convert(datetime, '2021-06-04'), 'asst.py');
insert into files values (16,   convert(datetime, '2021-06-03'), 'pseudo.pdf');
insert into files values (17,   convert(datetime, '2021-06-03'), 'unguarded.jpeg');
insert into files values (18,   convert(datetime, '2021-06-06'), 'suzy.docx');
insert into files values (19,   convert(datetime, '2021-06-06'), 'anitsplentic.py');
insert into files values (20,   convert(datetime, '2021-06-03'), 'tallies.py');

-- Solution MSSQL
with cte as
    (select date_modified
    , substring(file_name
                , charindex('.' , file_name) + 1
                , len(file_name) - charindex('.' , file_name) ) as file_ext
    , count(1) as cnt
    from files
    group by date_modified
    , substring(file_name
                , charindex('.' , file_name) + 1
                , len(file_name) - charindex('.' , file_name) ))
select date_modified, string_agg(file_ext, ',' ) within group (order by file_ext desc) as extension, max(cnt) as count
from cte c1
where cnt = (select max(cnt) from cte c2 where c1.date_modified=c2.date_modified )
group by date_modified
order by 1;
