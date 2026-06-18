CREATE TABLE online_retail (
    Invoice VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity TEXT,
    InvoiceDate TEXT,
    Price TEXT,
    CustomerID TEXT,
    Country TEXT,
    Revenue TEXT
);



select count(*) from online_retail;

select * from online_retail limit 10;

#1 Find the total revenue generated from all sales.
select sum(cast(revenue as numeric)) from online_retail;


#2 Top 10 Products by Revenue
SELECT Description,
       SUM(CAST(Revenue AS NUMERIC)) AS total_revenue
FROM online_retail
GROUP BY Description
ORDER BY total_revenue DESC
LIMIT 10;


#3 Top 10 Products by Quantity Sold
SELECT Description,
       SUM(CAST(Quantity AS NUMERIC)) AS total_quantity
FROM online_retail
GROUP BY Description
ORDER BY total_quantity DESC
LIMIT 10;


#4 Total Orders by Country
SELECT country,
       COUNT(Invoice) AS total_order
FROM online_retail
GROUP BY country
ORDER BY total_order DESC;


#5 Average Revenue by Country
SELECT country,
       AVG(CAST(revenue AS NUMERIC)) AS avg_revenue
FROM online_retail
GROUP BY country
ORDER BY avg_revenue DESC;


#6 Monthly Revenue Trend
SELECT 
    TO_CHAR(
        TO_TIMESTAMP(InvoiceDate, 'YYYY-MM-DD HH24:MI:SS'),
        'Month'
    ) AS Month,

    SUM(CAST(Revenue AS NUMERIC)) AS Total_Revenue

FROM online_retail

GROUP BY Month
ORDER BY Total_Revenue DESC;


#7 Top 5 Countries by Quantity Sold.
SELECT country,
       SUM(CAST(quantity AS NUMERIC)) AS quantity_sold
FROM online_retail
GROUP BY country
ORDER BY quantity_sold DESC
LIMIT 5;


#8 Best Selling Products by Number of Orders
SELECT Description,
       COUNT(Invoice) AS total_orders
FROM online_retail
GROUP BY Description
ORDER BY total_orders DESC
LIMIT 10;


#9 Highest Revenue Generating Products
SELECT Description,
       SUM(CAST(Revenue AS NUMERIC)) AS Total_Revenue
FROM online_retail
GROUP BY Description
ORDER BY Total_Revenue DESC
LIMIT 10;


#10 Lowest Revenue Generating Products
SELECT Description,
       SUM(CAST(Revenue AS NUMERIC)) AS Total_Revenue
FROM online_retail
GROUP BY Description
ORDER BY Total_Revenue ASC
LIMIT 10;


#11 Monthly Number of Orders
SELECT 
    TO_CHAR(
        TO_TIMESTAMP(InvoiceDate, 'YYYY-MM-DD HH24:MI:SS'),
        'Month'
    ) AS Month,

    COUNT(Invoice) AS Monthly_Total_Orders

FROM online_retail

GROUP BY Month
ORDER BY Monthly_Total_Orders DESC;


#12 Average Quantity Sold Per Product
SELECT Description,
       AVG(CAST(Quantity AS NUMERIC)) AS Avg_Quantity_Sold
FROM online_retail
GROUP BY Description
ORDER BY Avg_Quantity_Sold DESC
LIMIT 10;


#13 Product Revenue Ranking
SELECT Description,

       SUM(CAST(Revenue AS NUMERIC)) AS Total_Revenue,

       RANK() OVER(
           ORDER BY SUM(CAST(Revenue AS NUMERIC)) DESC
       ) AS Product_Rank

FROM online_retail

GROUP BY Description;


#14 Running Total Revenue
SELECT Description,

       SUM(CAST(Revenue AS NUMERIC)) AS Total_Revenue,

       SUM(SUM(CAST(Revenue AS NUMERIC))) 
       OVER(ORDER BY SUM(CAST(Revenue AS NUMERIC)) DESC)
       AS Running_Total

FROM online_retail

GROUP BY Description
ORDER BY Total_Revenue DESC;


#15 Revenue Contribution Percentage by Country
SELECT 
    country,

    ROUND(SUM(CAST(revenue AS NUMERIC)), 2) AS total_revenue,

    ROUND(
        (
            SUM(CAST(revenue AS NUMERIC))
            /
            (SELECT SUM(CAST(revenue AS NUMERIC))
             FROM online_retail)
        ) * 100,
        2
    ) AS revenue_percentage

FROM online_retail

GROUP BY country
ORDER BY revenue_percentage DESC;
