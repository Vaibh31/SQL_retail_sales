create database sql_project_p1;
use sql_project_p1;
create table retail_sale(
transactions_id	int primary key,
sale_date date,
	sale_time time,
    customer_id	int,
    gender varchar(15),
	age	int,
    category varchar(15),	
    quantiy	int,
    price_per_unit float,
	cogs float,
    total_sale float
);
select * from retail_sale;
select count(*)
 from retail_sale ;
select * from retail_sale where transactions_id is null;
select * from retail_sale where sale is null;

SELECT * FROM retail_sale
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
    DELETE FROM retail_sale
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
SELECT COUNT(*) as total_sale FROM retail_sale;
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sale;
SELECT DISTINCT category FROM retail_sale;
select * from retail_sale where sale_date ="2022-11-05";
SELECT *
FROM retail_sale
WHERE category = 'Clothing'
  AND quantiy >=4
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-12-01';
  
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sale
GROUP BY 1;

SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sale
WHERE category = 'Beauty';

SELECT * FROM retail_sale
WHERE total_sale > 1000;

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sale
GROUP 
    BY 
    category,
    gender
ORDER BY 1;

SELECT
    year,
    month,
    avg_sale
FROM
(
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rnk
    FROM retail_sale
    GROUP BY 1, 2
) t
WHERE rnk = 1;
    


SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sale
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;



WITH hourly_sale AS
(
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sale
)

SELECT
    shift,
    COUNT(*) AS number_of_orders
FROM hourly_sale
GROUP BY shift
ORDER BY number_of_orders DESC;