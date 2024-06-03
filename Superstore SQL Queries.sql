SELECT * FROM mproject.superstore;



-- What are total sales and total profits of each year?

SELECT YEAR(`order date`) AS year, SUM(sales), SUM(profit)
FROM superstore
GROUP BY year;


-- What are the total profits and total sales per quarter?

SELECT QUARTER(`order date`) AS quarter, YEAR(`order date`) AS year,
SUM(sales) AS total_sales , SUM(profit) AS total_profit
FROM superstore
GROUP BY year, quarter
ORDER BY year, quarter;


-- what quarters were the most profitable to us from 2020–2023.

SELECT QUARTER(`order date`) AS quarter, 
SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore
GROUP BY quarter
ORDER BY quarter;


-- What region generates the highest sales and profits?

SELECT region , SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_profit DESC;


-- What are the profit margin by each region?

SELECT region, ROUND(SUM(profit) / SUM(sales) * 100 , 2) AS profit_margin
FROM superstore
GROUP BY region
ORDER BY profit_margin DESC;


-- What state brings in the highest sales and profits?

SELECT `ship state`,
SUM(sales) AS total_sales , SUM(profit) AS total_profit 
FROM superstore
GROUP BY `ship state`
ORDER BY total_profit DESC
LIMIT 10;


-- Let's observe bottom 10 states

SELECT `ship state`,
SUM(sales) AS total_sales , SUM(profit) AS total_profit 
FROM superstore
GROUP BY `ship state`
ORDER BY total_profit ASC
LIMIT 10;


-- What city brings in the highest sales and profits?

SELECT `ship city`,
SUM(sales) AS total_sales , SUM(profit) AS total_profit 
FROM superstore
GROUP BY `ship city`
ORDER BY total_profit DESC
LIMIT 10;

-- Let's observe bottom 10 cities

SELECT `ship city`,
SUM(sales) AS total_sales , SUM(profit) AS total_profit 
FROM superstore
GROUP BY `ship city`
ORDER BY total_profit ASC
LIMIT 10;


-- What category brings in the highest sales and profit?

SELECT category, SUM(sales) AS total_sales , SUM(profit) AS total_profit
FROM superstore
GROUP BY Category
ORDER BY total_profit DESC;


-- What category generates the highest sales and profits in each region?

SELECT category, region,
SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore
GROUP BY Category, Region
ORDER BY total_profit DESC;


-- What subcategory generates the highest sales and profits in each region and state?

SELECT `sub-category`, region , `ship state`,
SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore
GROUP BY `sub-category`, region, `ship state`
ORDER BY total_profit DESC
LIMIT 10;


-- What segment makes the most of our profits and sales?

SELECT segment, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore
GROUP BY segment
ORDER BY total_profit DESC;


-- How many customers do we have (unique customer IDs) in total and how much per region and state?

SELECT COUNT(DISTINCT `customer id`) AS total_customer
FROM superstore;

SELECT region, COUNT(DISTINCT `customer id`) AS total_customer
FROM superstore
GROUP BY region;

SELECT `ship state`, COUNT(DISTINCT `customer id`) AS total_customer
FROM superstore
GROUP BY `ship state`
ORDER BY total_customer DESC;


-- What customers spent the most with us?

SELECT `customer id`, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore
GROUP BY `Customer ID`
ORDER BY total_profit DESC
LIMIT 10;


-- Identify orders where the ship date overlaps with another order’s ship date


SELECT A.`Order ID`, A.`Ship Date`, B.`Order ID` AS OverlappingOrderID, B.`Ship Date` AS OverlappingShipDate
FROM superstore A
JOIN superstore B ON A.`Order ID` <> B.`Order ID`
                  AND A.`Ship Date` BETWEEN B.`Ship Date` AND date_add(B.`Ship Date`, INTERVAL 0 DAY);
                  
                  
-- Average shipping time per class and in total

SELECT AVG(DATEDIFF(`ship date`, `order date`)) AS avg_shipping_time
FROM superstore;

SELECT `ship mode`, ROUND(AVG(DATEDIFF(`ship date`, `order date`)),1) AS avg_shipping_time
FROM superstore
GROUP BY `ship mode`
ORDER BY avg_shipping_time DESC;


-- which city has the most number of orders?

SELECT `ship city`, COUNT(`order id`) as no_of_orders
FROM superstore
GROUP BY `ship city`
ORDER BY no_of_orders DESC;


-- which subcategory has the highest quantity sold?

SELECT `sub-category` , quantity
FROM superstore
GROUP BY `Sub-Category`, quantity
ORDER BY quantity DESC;


-- get the total profit & sales and the total number of orders in different ship mode 

SELECT `ship mode`,COUNT(`order id`) AS total_orders, SUM(profit) AS total_profit, SUM(sales) AS total_sales
FROM superstore
GROUP BY `ship mode`
ORDER BY total_profit DESC;


-- Find product sold in a region with highest total number of qauntity

SELECT `product name`, region, SUM(quantity) total_quantity
FROM superstore
GROUP BY `product name`, region
ORDER BY total_quantity DESC
LIMIT 1; 


-- which customer has the highest number of orders?

SELECT `customer id`, COUNT(`order id`) AS no_of_orders 
FROM superstore
GROUP BY `customer id`
ORDER BY no_of_orders DESC
LIMIT 1;


-- Identify best-selling products in each category

SELECT * FROM(SELECT `product name`, category, quantity,
DENSE_RANK() OVER(PARTITION BY category ORDER BY quantity DESC) AS 'rank'
FROM superstore) AS t
WHERE t.rank = 1;


-- which month has the highest sales and profit in each year?

select * from(SELECT YEAR(`Order Date`) AS SalesYear,
              MONTH(`Order Date`) AS SalesMonth, SUM(Sales) AS total_sales ,
              SUM(profit) AS total_profit ,ROW_NUMBER() OVER(PARTITION BY YEAR(`Order Date`) ORDER BY SUM(sales) DESC) AS row_no
              FROM superstore 
              GROUP BY SalesYear, SalesMonth) AS t
WHERE t.row_no = 1;


select month(`order date`), sum(sales), sum(profit) from superstore
where `order date` like '2020-09%'
group by month(`order date`);


select sum(sales) from superstore;