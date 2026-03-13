# E-Commerce Sales and Customer Insights Analysis

# Question 1: How many products were sold each month and total profit?
SELECT OrderYear, OrderMonthName, 
       SUM(OrderQuantity) AS TotalUnitsSold,
       SUM(Profit) AS TotalProfit
FROM mastersales
GROUP BY OrderYear, OrderMonthName, OrderMonth
ORDER BY OrderYear, OrderMonth;

# Question 2: Which age groups and gender generate the most profit?
SELECT Gender,
       CASE
           WHEN Age < 25 THEN '<25'
           WHEN Age BETWEEN 25 AND 34 THEN '25-34'
           WHEN Age BETWEEN 35 AND 44 THEN '35-44'
           ELSE '45+'
       END AS AgeGroup,
       SUM(Profit) AS TotalProfit,
       COUNT(DISTINCT CustomerKey) AS NumCustomers
FROM mastersales
GROUP BY Gender,
         CASE
           WHEN Age < 25 THEN '<25'
           WHEN Age BETWEEN 25 AND 34 THEN '25-34'
           WHEN Age BETWEEN 35 AND 44 THEN '35-44'
           ELSE '45+'
         END
ORDER BY TotalProfit DESC;

# Question 3: Which products sold the most units and generated the highest profit?

SELECT ProductKey, Type, Size, Style,
       SUM(OrderQuantity) AS UnitsSold,
       SUM(Profit) AS TotalProfit
FROM mastersales
GROUP BY ProductKey, Type, Size, Style
ORDER BY UnitsSold DESC
LIMIT 10;

# Question 4: Which categories and subcategories are most profitable?

SELECT CategoryName, SubcategoryName,
       SUM(Profit) AS TotalProfit,
       SUM(OrderQuantity) AS UnitsSold
FROM mastersales
GROUP BY CategoryName, SubcategoryName
ORDER BY TotalProfit DESC;

# Question 5: How does PriceCategory affect total units sold and profit?

SELECT PriceCategory,
       SUM(OrderQuantity) AS UnitsSold,
       SUM(Profit) AS TotalProfit
FROM mastersales
GROUP BY PriceCategory
ORDER BY TotalProfit DESC;

# Question 6: Who are the top 5 customers by total profit generated?

SELECT CustomerKey,
       SUM(Profit) AS TotalProfit,
       COUNT(*) AS TotalOrders
FROM mastersales
GROUP BY CustomerKey
ORDER BY TotalProfit DESC
LIMIT 5;

# Question 7: Which products take the longest to process?

SELECT CategoryName, ProductKey, Type,
       AVG(ProcessingDays) AS AvgProcessingDays
FROM mastersales
GROUP BY CategoryName, ProductKey, Type
ORDER BY AvgProcessingDays DESC;

# Question 8: Do homeowners or customers with more children buy more units?

SELECT HomeOwner, TotalChildren,
       SUM(OrderQuantity) AS TotalUnitsSold,
       SUM(Profit) AS TotalProfit
FROM mastersales
GROUP BY HomeOwner, TotalChildren
ORDER BY TotalProfit DESC;

# Question 9: Which categories perform best in each month?

SELECT OrderMonthName, OrderMonth, CategoryName,
       SUM(OrderQuantity) AS UnitsSold,
       SUM(Profit) AS TotalProfit
FROM mastersales
GROUP BY OrderMonthName, OrderMonth, CategoryName
ORDER BY OrderMonth, TotalProfit DESC;

# Question 10: Which products have the highest average profit margin?

SELECT ProductKey, Type, Size, Style,
       AVG(ProfitMargin) AS AvgProfitMargin,
       SUM(Profit) AS TotalProfit
FROM mastersales
GROUP BY ProductKey, Type, Size, Style
ORDER BY AvgProfitMargin DESC
LIMIT 10;