drop table if exists pizza_sales;
CREATE TABLE pizza_sales (
    pizza_id INT PRIMARY KEY,
    order_id INT,
    pizza_name_id VARCHAR(100),
    quantity INT,
    order_date TEXT,
    order_time TEXT,
    unit_price NUMERIC(8,2),
    total_price NUMERIC(8,2),
    pizza_size VARCHAR(100),
    pizza_category VARCHAR(100),
    pizza_ingredients TEXT,
    pizza_name VARCHAR(100)
);
select * from pizza_sales
limit 10;
-- TOTAL REVENUE 
select round(sum(total_price),2) as 
total_revenue from pizza_sales;
--AVERAGE ORDER VALUE
select sum(total_price)/count(distinct order_id) as avg_ord_value
from pizza_sales;
--TOTAL PIZZAS SOLD
select sum(quantity) as TOTAL_PIZZA_SOLD from pizza_sales;
--TOTAL ORDERS 
select count(distinct order_id) as 
total_orders from pizza_sales;
--AVERAGE PIZZA PER ORDER
select round(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id) as decimal(10,2)),2)
as AVG_PIZZA_PER_ORDER FROM pizza_sales;
-- CHART REQUIREMENT 
--DAILY TREND FOR TOTAL ORDER

SELECT TO_CHAR(TO_DATE(order_date, 'DD-MM-YYYY'), 'Day') AS order_day,mm
       COUNT(DISTINCT order_id) AS total_order
FROM pizza_sales
GROUP BY TO_CHAR(TO_DATE(order_date, 'DD-MM-YYYY'), 'Day')
ORDER BY MIN(TO_DATE(order_date, 'DD-MM-YYYY'));

--DAILY TREND FOR HOURS

SELECT EXTRACT(HOUR FROM order_time::time) AS order_hour,--WE USE TIME SYNTAX LIKE THAT BEACUSE ORDER TIME IS IN THE TEXT FORMAT
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY EXTRACT(HOUR FROM order_time::time)
ORDER BY order_hour;

--PERCENTAGE OF SALES Y PIZZA CATEGORY
SELECT pizza_category,
       SUM(total_price) AS total_sales,
       SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales
	   WHERE EXTRACT(MONTH FROM TO_DATE(order_date, 'DD-MM-YYYY')) = 1) AS pct
FROM pizza_sales
WHERE EXTRACT(MONTH FROM TO_DATE(order_date, 'DD-MM-YYYY')) =1-- this will indicate for january
GROUP BY pizza_category;

--PERCENTAGE OF SALES BY PIZZA SIZE
SELECT pizza_size,
       ROUND(SUM(total_price),2) AS total_sales,
       ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales),2) as pct
	   from pizza_sales
GROUP BY pizza_size;   

--TOTAL PIZZA SALES BY CATEGORY

select pizza_category, sum(quantity) as total_price
from pizza_Sales
group by pizza_category

--TOP 5 MOST SELLED  PIZZAS
select  pizza_name, sum(quantity) as total_price
from pizza_Sales
group by pizza_name
order by sum(quantity) desc
limit 5;
 --TOP 5 WOEST SELLER PIZZAS
 select  pizza_name, sum(quantity) as total_price
from pizza_Sales
group by pizza_name
order by sum(quantity) asc
limit 5;



	   