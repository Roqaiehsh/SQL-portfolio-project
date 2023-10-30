CREATE DATABASE IF NOT EXISTS salesDataWalmart;
CREATE TABLE IF NOT EXISTS sale(
invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
branch VARCHAR (5) NOT NULL,
city VARCHAR (30) NOT NULL,
customer_type VARCHAR(30) NOT NULL,
gender VARCHAR(10) NOT NULL,
product_line VARCHAR(100) NOT NULL,
unit_price DECIMAL(10,2) NOT NULL,
quantity INT NOT NULL,
VAT FLOAT(6,4) NOT NULL,
total DECIMAL(12,4) NOT NULL ,
date DATETIME NOT NULL,
time TIME NOT NULL,
payment_method VARCHAR(15) NOT NULL,
cogs DECIMAL(10,2) NOT NULL,
gross_margin_pct FLOAT(11,9),
gross_incom DECIMAL (12,4) NOT NULL,
rating FLOAT(6,4));

SELECT * FROM salesdatawalmart.sale;

-- --------------------------------------------------------------------------------
-- ---------------------------- Feature Engineering--------------------------------
-- --------------------------------------------------------------------------------
 ## time _of_ day:
 
 SELECT time,
         (CASE
         WHEN `time` BETWEEN "00:00:00"AND "12:00:00" THEN "Morning"
          WHEN `time` BETWEEN "12:01:00"AND "16:00:00" THEN "Afternoon"
          ELSE "Evening"
          END) AS time_of_day
 FROM sale;
 
 
 ## create new column time_of_day:
 
 ALTER TABLE sale ADD COLUMN time_of_day VARCHAR(20);
 UPDATE sale
 SET  time_of_day =
         (CASE
         WHEN `time` BETWEEN "00:00:00"AND "12:00:00" THEN "Morning"
          WHEN `time` BETWEEN "12:01:00"AND "16:00:00" THEN "Afternoon"
          ELSE "Evening"
          END) ;
          
## day_name

SELECT date,
           DAYNAME(date)
FROM sale;

## create new column day_name:

ALTER TABLE sale ADD COLUMN day_name VARCHAR(20);
UPDATE sale
SET day_name = DAYNAME(date);

## create new column month_name:

SELECT date,
        MONTHNAME(date)
FROM sale;        
ALTER TABLE sale ADD COLUMN month_name VARCHAR(10);
UPDATE sale
SET month_name = MONTHNAME(date);

-- --------------------------------------------------------------------------------------
-- -------------------------Generic--------------------------------------------------
-- -----------------------------------------------------------------------------------
## How many unique cities does the data have?
SELECT 
     DISTINCT(city)
FROM sale;
     
## In which city is each branch?
SELECT
 DISTINCT city,branch
 FROM sale;

-- -----------------------------------------------------------------------------------
-- --------------------Product--------------------------------------------------------
## How many product lines does the data have?
SELECT
     DISTINCT(product_line)
FROM sale;     

## What is the most common payment method?
SELECT
      payment_method,COUNT(payment_method) AS cnt
      FROM sale
      GROUP BY payment_method
      ORDER BY cnt DESC;
    
 ## What is the most selling product line?
 
 SELECT
      product_line,COUNT(product_line) AS cnt
      FROM sale
      GROUP BY product_line
      ORDER BY cnt DESC;     

## What is the total revenue by month?
SELECT month_name AS month,
SUM(total) AS total_revenue
FROM sale
GROUP BY month_name
ORDER BY total_revenue DESC;

## What month had the largest COGS?
SELECT month_name AS month,SUM(cogs) AS cogs
FROM sale
GROUP BY month_name
ORDER BY cogs DESC;
## What product_line had the largest revenue?
SELECT product_line, SUM(total) AS total_revenue
FROM sale
GROUP BY product_line
ORDER BY total_revenue DESC;

## What is the city with the largest revenue?
SELECT city,SUM(total) AS total_revenue
FROM sale
GROUP BY city
ORDER BY total_revenue DESC;

##What product_line had the largest VAT?
SELECT product_line,AVG(VAT) AS avg_tax
FROM sale
GROUP BY product_line
ORDER BY avg_tax DESC;

## Which branch sold more products than average product sold?
SELECT branch,SUM(quantity)AS quantity
FROM sale
GROUP BY branch
HAVING SUM(quantity)> (SELECT AVG(quantity) FROM sale);

##What is the most common product line by gender?
SELECT product_line,
       gender,COUNT(gender) AS total_cnt
FROM sale
GROUP BY product_line,gender
ORDER BY total_cnt DESC;       

## What is average rating of each product line?
SELECT product_line, ROUND(AVG(rating),2) AS avg_rating
FROM sale
GROUP BY product_line
ORDER BY avg_rating DESC;


-- --------------------------------------------------------------------------------------------------
-- --------------------------Sales------------------------------------------------------------------

##Number of sales made in each time of day per week;
SELECT COUNT(quantity) AS number_of_sales, time_of_day
FROM sale
GROUP BY time_of_day
ORDER BY number_of_sales DESC;

-- for determininig number of sales per day of week ,Filter should apply by add "WHERE" caluse; 

SELECT COUNT(quantity) AS number_of_sales, time_of_day
FROM sale
WHERE day_name = "Sunday"
GROUP BY time_of_day
ORDER BY number_of_sales DESC;

## Which of customer types brings the most revenue?
SELECT customer_type,SUM(total) AS total_revenue
From sale
GROUP BY customer_type
ORDER BY total_revenue DESC;

## Which city has largest tax percent/VAT(value added tax)?
SELECT city, ROUND(AVG(VAT),2) AS VAT
FROM sale
GROUP BY city
ORDER BY VAT DESC;

## Which customer type pays the most in VAT?
SELECT customer_type, AVG(VAT) AS VAT
FROM sale
GROUP BY customer_type
ORDER BY VAT DESC;


-- --------------------------------------------------------------------------------------------------------------
-- -----------------------Customer-----------------------------------------------------------------------------------

## How many unique customer type does the data have?
SELECT  DISTINCT(customer_type)
FROM sale;

## How many unique payment methods does the data have?
SELECT DISTINCT(payment_method)
FROM sale;

##Which customer type buys the most?
SELECT customer_type,count(total)AS customer_count
FROM sale
GROUP BY customer_type
ORDER BY customer_count DESC;

## What is the gender of most of the customers?
SELECT gender,COUNT(gender)AS total_gender
FROM sale
GROUP BY gender
ORDER BY total_gender DESC;

## What is gender distribution per branch?
SELECT branch, gender,COUNT(gender) AS gender_count
FROM sale
GROUP BY branch,gender
ORDER BY gender_count DESC;

##Which time of the day do customers give most rating?
SELECT time_of_day,AVG(rating) AS avg_rating
FROM sale
GROUP BY time_of_day
ORDER BY avg_rating  DESC;

## Which time of the day do customers give most rating per branch?
SELECT time_of_day, branch,AVG(rating) AS avg_rating
FROM sale
GROUP BY time_of_day, branch
ORDER BY avg_rating DESC;
-- The second way for doing this is applying filter on branch by adding "WHERE" clause;
-- EXAMPLE:
SELECT time_of_day, AVG(rating) AS avg_rating
FROM sale
WHERE branch = "A"
GROUP BY time_of_day
ORDER BY avg_rating DESC;

## Which day of the week has best average rating?
SELECT day_name, ROUND(AVG(rating),3) AS avg_rating
FROM sale
GROUP BY day_name
ORDER BY avg_rating DESC;






