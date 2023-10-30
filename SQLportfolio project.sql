Select * From pizza_sales;

--Total_Revenue

SELECT SUM(total_price) AS Total_Revenue From pizza_sales


--Average_Order_Value

SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS Avg_Order_Value From pizza_sales

--Total_Pizza_Sold

SELECT SUM(quantity)As Total_Pizza_Sold From pizza_sales

--Total_Orders

Select COUNT(DISTINCT order_id) AS Total_Orders From pizza_sales


--Average_Pizza_Per_Order

Select (CAST( CAST( SUM(quantity) AS DECIMAL(10,2))/
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))AS DECIMAL(10,2))) AS AVG_Pizza_Per_Order  From pizza_sales


--Daily Trend For Total Orders

SELECT DATENAME(DW, order_date) as Order_Day, COUNT(DISTINCT order_id) AS Total_Orders
From pizza_sales
Group by DATENAME(DW, order_date);


--Monthly Trend For Total Orders

Select DATENAME(MONTH, order_date)AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
From pizza_sales
Group by  DATENAME(MONTH, order_date) 
Order by Total_Orders DESC;


--Percentage Of Sales By Pizza Category

Select pizza_category,SUM (total_price) AS Total_Sales, SUM(total_price)*100/(Select SUM(total_price) From pizza_sales)AS Percentage_Of_Total_Sales
From pizza_sales 
Group By pizza_category;


--Percentage Of Sales By Pizza Category By Filter
--Filter Total_Sales By Month,IN This Case 1 AS Jan.

Select pizza_category, SUM (total_price) AS Total_Sales,SUM(total_price)*100/
(Select SUM(total_price) From pizza_sales Where MONTH(order_date)= 1)AS Percentage_Of_Total_Sales
From pizza_sales 
Where MONTH(order_date)= 1
Group By pizza_category;


--Percentage Of Sales By Pizza Size

Select pizza_size,CAST( SUM (total_price)AS DECIMAL(10,2)) AS Total_Sales,CAST(SUM(total_price)*100/
(Select SUM(total_price) From pizza_sales)AS DECIMAL(10,2) )AS Percentage_Of_Total_Sales
From pizza_sales 
Group By pizza_size
Order By  Percentage_Of_Total_Sales DESC

--Apply Filter On Percentage Of Sales By Pizza Size.
--Filter Total_Sales By Month In This Case 1 Is Equal To Jan.

Select pizza_size, CAST(SUM (total_price)AS DECIMAL(10,2)) AS Total_Sales,CAST(SUM(total_price)*100/
(Select SUM(total_price) From pizza_sales Where MONTH(order_date)= 1)AS DECIMAL(10,2))AS Percentage_Of_Total_Sales
From pizza_sales
Where MONTH(order_date)= 1
Group By pizza_size
Order By Percentage_Of_Total_Sales DESC


--Apply Filter On Percentage Of Sales By Pizza Size.
--Filter Total_Sales By Quarter In This Case 1 Is Equal To Q1.

Select pizza_size, CAST(SUM (total_price)AS DECIMAL(10,2)) AS Total_Sales,CAST(SUM(total_price)*100/
(Select SUM(total_price) From pizza_sales Where DATEPART(quarter, order_date)= 1)AS DECIMAL(10,2))AS Percentage_Of_Total_Sales
From pizza_sales
Where DATEPART(quarter, order_date)= 1
Group By pizza_size
Order By Percentage_Of_Total_Sales DESC

--Top 5 Pizza Seller BY Total Revenue

Select TOP 5 pizza_name,SUM(total_price)AS Total_Revenue
From pizza_sales
Group by pizza_name
Order by (Total_Revenue) DESC


--Bottom 5 Pizza Seller By Total Revenue


Select TOP 5 pizza_name,SUM(total_price)AS Total_Revenue
From pizza_sales
Group by pizza_name
Order by (Total_Revenue) ASC


--Top 5 Pizza Seller BY Total Quantity

Select TOP 5 pizza_name,SUM(quantity)AS Total_Quantity
From pizza_sales
Group by pizza_name
Order by (Total_Quantity) DESC


--Bottom 5 Pizza Seller BY Total Quantity

Select TOP 5 pizza_name,SUM(quantity)AS Total_Quantity
From pizza_sales
Group by pizza_name
Order by (Total_Quantity) ASC


--Top 5 Pizza Seller BY Total Orders

Select TOP 5 pizza_name,COUNT(DISTINCT order_id)AS Total_Orders
From pizza_sales
Group by pizza_name
Order by (Total_Orders) DESC


--Bottom  5 Pizza Seller BY Total Orders

Select TOP 5 pizza_name,COUNT(DISTINCT order_id)AS Total_Orders
From pizza_sales
Group by pizza_name
Order by (Total_Orders) ASC