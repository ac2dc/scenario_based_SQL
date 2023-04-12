--- Recursive CTE
/*
WITH expression_name (column_list)
AS
(
    -- Anchor member
    initial_query  
    UNION ALL
    -- Recursive member that references expression_name.
    recursive_query  
)
-- references expression name
SELECT *
FROM   expression_name
*/
-- WITH cte_numbers(n, weekday) 
-- AS (
--     SELECT 
--         0, 
--         DATENAME(DW, 0)
--     UNION ALL
--     SELECT    
--         n + 1, 
--         DATENAME(DW, n + 1)
--     FROM    
--         cte_numbers
--     WHERE n < 6
-- )
-- SELECT 
--     weekday
-- FROM 
--     cte_numbers;


declare @enddate date =  dateadd(mm,-12,getdate()) 
print(@enddate)
declare @startdate date = getdate()
print(@startdate)

-- where timestamp between @startdate and @enddate



-- with incrementer( prev_year) as (
--     select @startdate 
-- )


SELECT CHARINDEX('is', 'This is a string');