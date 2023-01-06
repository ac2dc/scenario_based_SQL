
-- USE CASE 1 //

-- Create a new table called '[Transaction_tbl]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Transaction_tbl]', 'U') IS NOT NULL
DROP TABLE [dbo].[Transaction_tbl]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Transaction_tbl]
(
    [CustID] INT NOT NULL, 
    [TransID] INT NOT NULL PRIMARY KEY,
    [TransAmt] FLOAT NOT NULL,
    [TransDate] DATE 
);
GO

-- Insert rows into table 'Transaction_tbl' in schema '[dbo]'
INSERT INTO [dbo].[Transaction_tbl]
( -- Columns to insert data into
 [CustID], [TransID], [TransAmt],[TransDate]
)
VALUES
( 
 1001, 20001,100241 ,'2020-04-23'
),
( 
 1001, 20002 ,112478 ,'2020-04-23'
),
( 
 1001, 24500,789563 ,'2020-04-23'
),
( 
 1001, 12250, 457896,'2020-04-23'
),
( 
 1002, 12458, 458963,'2020-04-23'
),
( 
 1002, 45620,125786 ,'2020-04-23'
),
( 
 1002,78962 , 745867,'2020-04-23'
)
-- Add more rows here
GO

--- SOLUTION ------------- //

SELECT A.CustID,TransID,A.TransAmt,MaxTransAmt,(TransAmt/MaxTransAmt) AS Ratio,TransDate
FROM Transaction_Tbl A
INNER JOIN
(SELECT CustID,Max(TransAmt) As MaxTransAmt FROM Transaction_Tbl
GROUP BY CustID) B
ON A.CustID=B.CustID;



-- USE CASE 2 -------------------------------- Bhaskar  --------------------------------------------------

WITH t1 as (
    SELECT convert(varchar(7), Pay_date, 126) as pay_month, Depertment_id ,
	AVG(ammount) OVER(PARTITION BY DATEPART(month,Pay_date),Depertment_id) as dept_avg, 
	AVG(ammount) OVER(PARTITION BY DATEPART(month,Pay_date)) as comp_avg
	FROM salary as s JOIN employee as e
	ON e.Employee_id = s.Employee_id
)
SELECT DISTINCT Pay_month, Depertment_id, 
       CASE WHEN dept_avg > comp_avg THEN 'higher'
       WHEN dept_avg = comp_avg THEN 'same'
ELSE 'lower'
END AS comparison
FROM t1
ORDER BY 1 DESC;

-- USE CASE 3 --------------- Bhaskar ---------------------------------


-- Create a new table called '[stadium]' in schema '[dbo]'
-- Drop the table if it already existsk
IF OBJECT_ID('[dbo].[stadium]', 'U') IS NOT NULL
DROP TABLE [dbo].[stadium]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[stadium]
(
    [id] INT NOT NULL PRIMARY KEY, -- Primary Key column
    [visit_date] date NOT NULL,
    [people] int NOT NULL
);
GO

-- Insert rows into table 'sta[stadium]' in schema '[dbo]'
INSERT INTO [dbo].[stadium]
( -- Columns to insert data into
 [id], [visit_date], [people]
)
VALUES(
1,'2017-01-01', 10
),
(
2,'2017-01-02', 109
),
(
3, '2017-01-03',150  
),
(
4,  '2017-01-04', 99
),
(
5, '2017-01-05',145  
),
(
6, '2017-01-06', 1455
),
(
7, '2017-01-07', 199
),
(
8, '2017-01-08', 188
)
GO

--------------- SOLUTION -----------------------------

WITH t1 AS (
            SELECT id, 
                   visit_date,
                   people,
                   id - ROW_NUMBER() OVER(ORDER BY visit_date) AS dates
              FROM stadium
            WHERE people >= 100) 
            
SELECT t1.id, 
       t1.visit_date,
       t1.people
FROM t1
LEFT JOIN (
            SELECT dates, 
                   COUNT(*) as total
              FROM t1
            GROUP BY dates) AS b
ON t1.dates = b.dates
WHERE b.total > 2;

----------- USE CASE 4 --------------------- Bhaskar -------------------------------------------------------

-- Create a new table called '[Customer_UC]' in schema '[dbo]'

-- Drop the table if it already exists

IF OBJECT_ID('[dbo].[Customer_UC]', 'U') IS NOT NULL

DROP TABLE [dbo].[Customer_UC]

GO

-- Create the table in the specified schema

CREATE TABLE [dbo].[Customer_UC]

(

       [customer_id] INT NOT NULL  , -- Primary Key column

       [name] varchar(50) NOT NULL,

       [visited_on] DATE NOT NULL,

       [amount] INT

);

GO

-- Insert rows into table 'Customer_UC' in schema '[dbo]'

INSERT INTO [dbo].[Customer_UC]

( -- Columns to insert data into

 [customer_id], [name], [visited_on],[amount]

)

VALUES

( -- First row: values for the columns in the list above

1, 'John', '2019-01-01',100

),

(
2,'Deniel','2019-01-02',110

),

(

3,'Ashok','2019-01-03',120      

),

(

4,'Anil',' 2019-01-04',130

),

(

5,'Gundu',' 2019-01-05',110

),

(6,'Elvis',' 2019-01-06',140

),

(

7,'Anna',' 2019-01-07',150

),

(

8,'Maria',' 2019-01-08',80

),

(

9,'Jaze',' 2019-01-09',110

),

(

1,'John',' 2019-01-10',130

),

(

3,'Jade',' 2019-01-10',150

)

GO
---------------------- Solution 4 -------------------------------------

SELECT visited_on, 
       SUM(amount) OVER(ORDER BY visited_on ROWS 6 PRECEDING),
       ROUND(AVG(amount) OVER(ORDER BY visited_on ROWS 6 PRECEDING),2)
FROM (
        SELECT visited_on, SUM(amount) AS amount
        FROM Customer_UC
        GROUP BY 1
        ORDER BY 1
     ) AS a
ORDER BY visited_on OFFSET 6 ROWS;

------------------- -------------------------- Use Case 5 -----------------

-- Create a new table called '[LogTable]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[LogTable]', 'U') IS NOT NULL
DROP TABLE [dbo].[LogTable]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[LogTable]
(
       [id] INT NOT NULL PRIMARY KEY, -- Primary Key column
       [num] INT NOT NULL
);
GO

-- Insert rows into table 'LogTable' in schema '[dbo]'
INSERT INTO [dbo].[LogTable]
( -- Columns to insert data into
 [id], [num]
)
VALUES
( 
 1, 1
),
( 
 2, 1
),
(
3,1
),
(
4,2
),
(
5,1
),
(
6,2
),
(
7,2
)
GO;

SELECT * FROM LogTable;

----------- SOLUTION 5 --------------
SELECT DISTINCT a.num AS ConsecutiveNums
FROM(
      SELECT num,
      LAG(num) OVER(ORDER BY id ) as prev,
      LEAD(num) OVER(ORDER BY id) as next
      FROM LogTable) AS a
WHERE a.num = a.prev AND a.num = a.next;

-------------- Day 6


-- Create a new table called '[Emp_salaries]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Emp_salaries]', 'U') IS NOT NULL
DROP TABLE [dbo].[]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[]
(
       [Id] INT NOT NULL PRIMARY KEY, -- Primary Key column
       [ColumnName2] NVARCHAR(50) NOT NULL,
       [ColumnName3] NVARCHAR(50) NOT NULL
       -- Specify more columns here
);
GO

------------------ Solution 6 -----------------------------------------

SELECT ROUND(a.shortest,2) as shortest
FROM (
        SELECT SQRT(POW((p1.x-p2.x),2)+POW((p1.y-p2.y),2)) as shortest
        FROM point_2d AS p1
        CROSS JOIN point_2d AS p2
        WHERE p1.x!=p2.x OR p1.y!=p2.y
        ORDER BY SQRT(POW((p1.x-p2.x),2)+POW((p1.y-p2.y),2))
        LIMIT 1) AS a;


--------------------- Day 7 ------------------------------
-- Create a new table called '[Emp_salaries]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Emp_salaries]', 'U') IS NOT NULL
DROP TABLE [dbo].[Emp_salaries]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Emp_salaries]
(
       [id] INT NOT NULL,
       [salary] INT NOT NULL,
       [year] SMALLINT NOT NULL
);
GO
-- Insert rows into table 'Emp_salaries' in schema '[dbo]'
INSERT INTO [dbo].[Emp_salaries]
( -- Columns to insert data into
 [id], [salary], [year]
)
VALUES
(
 1, 80000, 2020
),
( 
 1, 70000, 2019
),
(
 1, 60000, 2018
),
(
 2, 65000, 2020
),
(
 2, 65000, 2019
),
(
 2, 60000, 2018
),
(
 3, 65000, 2019
),
(
 3, 60000, 2018
);

GO
------------------- solution-----------------------------
SELECT 
 a.id as Emp_ID FROM
 -- First, we'll build a subquery with employeeID, current salary, and prior year salary
 (SELECT 
     id, 
     salary, 
    -- Using window function lead, we can grab the prior year's salary
    -- Note we could alternatively use LAG and sort our year in ascending order to achieve the same result 
    LEAD(salary) OVER (PARTITION BY id ORDER BY year DESC) as previous_year_sal 
  FROM Emp_salaries ) a

-- Only pull records where the current salary is > the prior year salary
WHERE a.salary > a.previous_year_sal
GROUP BY a.id
-- Since we want 3 consecutive years of raises, 
-- there should be at least 2 records (e.g. yr 1 -> yr 2, yr 2 -> yr 3)
HAVING count(*) = 2;

--------------- day 8 Answer -----------------
SELECT *
  FROM (
        SELECT start_terminal,
               start_time,
               trip_time,
               RANK() OVER (PARTITION BY start_terminal ORDER BY trip_time DESC) AS rank
          FROM fly_tbl
         WHERE start_time < '2012-01-08'
               ) sub
 WHERE sub.rank <= 5;



------------------- Day 9 ---------------------------

----------- SOLUTION ---------------------------

select c.business_id
from(
select *
from events e
join
(select event_type as event, round(avg(occurences),2) as average from events group by event_type) b
on e.event_type = b.event) c
where c.occurences>c.average
group by c.business_id
having count(*) > 1;

--------------------------- day 11 ---------------------------------

select p1.id as p1, p2.id as p2, abs(p1.x_value-p2.x_value)*abs(p1.y_value-p2.y_value) as area
from points p1 cross join points p2
where p1.x_value!=p2.x_value and p1.y_value!=p2.y_value and p1.id<p2.id
order by area desc, p1, p2


