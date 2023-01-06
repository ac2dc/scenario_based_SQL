-- CREATE OR ALTER PROCEDURE pr_name (@p_name varchar, @p_age int) -- Parameter in MS SQL has to start with '@'
-- as -- $$ -- $$ used for eliminating escape character for single quotes, specific to POSTGRES only
--             -- eg $$I'm Bhaskar$$
--             -- reolace instead of alter in other dbms
-- DECLARE
--     -- variables , it should start with '@' like @v_name int
--     @v_name varchar,
--     @v_age int;
-- BEGIN
--     -- procedure body - All logic
-- END ;

select * from product_pr
