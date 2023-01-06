-- create table product_pr (product_code varchar(2), product_name varchar(20), price float(53), quantity_rem int, quantity_sold int);
-- create table sales_pr (order_id int primary key, order_date date, product_code varchar(20), quantity_ordered int, sales_price float(53));
create or alter procedure pr_buy_product
AS 
        declare @v_product_code varchar(20),
                @v_price  float(53);
BEGIN 
        select @v_product_code = product_code, @v_price = price
        from product_pr
        were product_name = 'Iphone 13'

        INSERT INTO sales_pr(order_date, product_code, quantity_ordered, sales_price)
                VALUES(cast(getdate() as date), @v_product_code, 1, (@v_price * 1));

        UPDATE product_pr 
        set 
        quantity_rem = (quantity_rem -1), 
        quantity_sold = (quantity_sold + 1)
        where prduct_code = v_product_code

END;
