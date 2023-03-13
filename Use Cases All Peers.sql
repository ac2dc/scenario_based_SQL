----day4---
----anil--
-------


-----sandepp---
Create Table Staffing (
employee_id int,
is_consultant bit,
job_id int)


Insert into Staffing values(111,1,7898)
Insert into Staffing values(121,0,6789)
Insert into Staffing values(111,1,9020)
Insert into Staffing values(156,1,4455)
Insert into Staffing values(111,1,8885)


Create Table Consulting_engagements(
job_id int,
client_id int,
start_dates date,
end_dates date,
contract_amount int
)



Insert into Consulting_engagements values (6789,20045,'06/01/2021 00:00:00','11/12/2021 00:00:00',33040.00)
Insert into Consulting_engagements values (8885,20022,'07/05/2021 00:00:00','07/31/2021 00:00:00',4670.00)
Insert into Consulting_engagements values (9020,20345,'08/14/2021 00:00:00','10/31/2021 00:00:00',22370.00)
Insert into Consulting_engagements values (4455,20001,'01/25/2021 00:00:00','05/31/2021 00:00:00',31839.00)
Insert into Consulting_engagements values (7898,20076,'05/25/2021 00:00:00','06/30/2021 00:00:00',11290.00)
Insert into Consulting_engagements values (3462,20099,'09/15/2021 00:00:00','11/15/2021 00:00:00',240000.00)
Insert into Consulting_engagements values (2354,20001,'10/14/2021 00:00:00','12/31/2021 00:00:00',54000.00)


---Problem Statement:  

--Google wants to know how many days of bench time each consultant had in 2021.
--Being "on the bench" means you have a gap between two client engagements.
--Assume that each consultant is only staffed to one consulting engagement at a time.
--Write a query to pull each employee ID and their total bench time in days during 2021.
--Assumptions: All listed employees are current employees who were hired before 2021.
--The engagements in the consulting_engagements table are complete for the year 2021.
select employee_id,abs(sum(DATEDIFF(day,start_dates,end_dates)+1)-365) as bench_days from Consulting_engagements c join Staffing s
on
s.job_id=c.job_id where is_consultant= 1
group by employee_id;

---------umeer--------



Create Table Trade_tbl(
TRADE_ID varchar(20),
Trade_Timestamp time,
Trade_Stock varchar(20),
Quantity int,
Price Float
)
Insert into Trade_tbl Values('TRADE1','10:01:05','ITJunction4All',100,20)
Insert into Trade_tbl Values('TRADE2','10:01:06','ITJunction4All',20,15)
Insert into Trade_tbl Values('TRADE3','10:01:08','ITJunction4All',150,30)
Insert into Trade_tbl Values('TRADE4','10:01:09','ITJunction4All',300,32)
Insert into Trade_tbl Values('TRADE5','10:10:00','ITJunction4All',-100,19)
Insert into Trade_tbl Values('TRADE6','10:10:01','ITJunction4All',-300,19)

select * from Trade_tbl
--Write SQL to find all couples of trade for same stock that happened in the range of 10 seconds and having price difference by more than 10 %.
--Output result should also list the percentage of price difference between the 2 trade.

select a.trade_id,b.TRADE_ID,floor(abs(((a.Price-b.price)/a.price)*100 )) as per from Trade_tbl a join Trade_tbl b on a.TRADE_ID<b.TRADE_ID 
where abs(datediff(second,a.trade_timestamp,b.trade_timestamp))<10 and  
abs(((a.Price-b.price)/a.price)*100 ) >10

-- DAY 5

----Day 5
---sandeep--
Create Table Calls
(
From_Id int,
To_Id int,Duration int   
)
INSERT INTO Calls Values(1,2,59);
INSERT INTO Calls Values(2,1,11);
INSERT INTO Calls Values(1,3,20);
INSERT INTO Calls Values(3,4,100);
INSERT INTO Calls Values(3,4,200);
INSERT INTO Calls Values(3,4,200);
INSERT INTO Calls Values(4,3,499);

/*Calls Table has three columns namely From_Id, To_Id and Duration.
It contains duration of calls between From_Id and To_Id.
Write a SQL query to report the number of calls and the total call duration between
each pair of distinct persons (Person1, Person2) where Person1 is less than Person2.
Return the result as shown in Output Table.*/
select a.From_Id,a.To_Id from Calls a ,calls b
where a.From_Id<b.To_Id
select person1,person2,count(Duration) as total_Calls,sum(Duration) as Total_Duration

from

(select case when from_id<to_id then from_id else  to_id end as person1 ,case when from_id>to_id then from_id else TO_ID  end as person2 ,duration from calls) X

where person1<person2

group by person1,person2


-----umer--


create table SSC_Exam (
Id int,
English int,
Maths int,
Science int,
Geography int,
History int,
Sanskrit int)


Insert into SSC_Exam Values (1,85,99,92,86,86,99)
Insert into SSC_Exam Values (2,81,82,83,86,95,96)
Insert into SSC_Exam Values (3,76,55,76,76,56,76)
Insert into SSC_Exam Values (4,84,84,84,84,84,84)
Insert into SSC_Exam Values (5,83,99,45,88,75,90)

/*Problem Statement :- For the 2021 academic year, students have appeared in the SSC exam.
Write a SQL query to calculate the percentage of results using the best of the five rule i.e.
You must take the top five grades for each student and calculate the percentage.*/
select id,floor(sum(English+History+Maths+Science+Geography+Sanskrit)/6 ) as tot from SSC_Exam
group by id

