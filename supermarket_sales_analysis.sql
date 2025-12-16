create database myanmar_supermarket;
use myanmar_supermarket;


DROP TABLE IF EXISTS supermarket_sales;

CREATE TABLE supermarket_sales (invoice_id VARCHAR(20),branch VARCHAR(5),city VARCHAR(50),customer_type VARCHAR(20),gender VARCHAR(10),product_line VARCHAR(50),unit_price DECIMAL(10,2),
quantity INT,total_sales DECIMAL(12,2),sale_date DATE,payment VARCHAR(20),rating DECIMAL(3,1)
);

Select * from supermarket_sales;

-- 1.What is the total amount of sales in the year?
Select sum(total_sales) as Total_sales from supermarket_sales;

-- 2.Which payment method was mostly used?
Select payment,  count(payment) as payment_total_count from supermarket_sales group by payment order by payment_total_count desc;

-- 3.List the cities sales and top city which has the most sales.
Select city, round(sum(total_sales),2) as sales from supermarket_sales group by city order by sales desc;

-- 4.Which  product line has the most sales?
Select product_line, round(sum(total_sales),2) as sales from supermarket_sales group by product_line order by sales desc;

-- 5.Tell the amount of the higher order and name of store and city also.
Select branch, city, total_Sales from supermarket_sales where total_sales = (Select max(total_sales) from supermarket_sales);

-- 6.List the stores and their sales and top performing products.
SELECT branch, product_line, sales
FROM (
    SELECT 
        branch,
        product_line,
        SUM(total_sales) AS sales,
        ROW_NUMBER() OVER (PARTITION BY branch ORDER BY SUM(total_sales) DESC) AS rn
    FROM supermarket_sales
    GROUP BY branch, product_line
) t
WHERE rn = 1;
