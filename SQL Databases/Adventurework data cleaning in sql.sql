# DATA CLEANING FOR ANALYSIS

# 1 Check for Duplicate Rows & delete

SELECT 
    OrderDate,
    CustomerKey,
    ProductKey,
    OrderQuantity,
    ProductPrice,
    Profit,
    MIN(StockDate) AS StockDate,
    COUNT(*) AS duplicate_count
FROM mastersales
GROUP BY 
    OrderDate, 
    CustomerKey, 
    ProductKey, 
    OrderQuantity, 
    ProductPrice, 
    Profit
HAVING COUNT(*) > 1;

ALTER TABLE mastersales
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;

DELETE m
FROM mastersales m
LEFT JOIN (
    SELECT MIN(id) AS keep_id
    FROM mastersales
    GROUP BY OrderDate, CustomerKey, ProductKey, OrderQuantity, ProductPrice, Profit
) t
ON m.id = t.keep_id
WHERE t.keep_id IS NULL;

# 2 Check missing / NULLs
SELECT 
    SUM(CASE WHEN OrderQuantity IS NULL THEN 1 ELSE 0 END) AS MissingOrderQuantity,
    SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS MissingProfit,
    SUM(CASE WHEN CustomerKey IS NULL THEN 1 ELSE 0 END) AS MissingCustomerKey,
    SUM(CASE WHEN ProductKey IS NULL THEN 1 ELSE 0 END) AS MissingProductKey
FROM mastersales;

DELETE FROM mastersales
WHERE Profit IS NULL
   OR ProductKey IS NULL
   OR CustomerKey IS NULL;

# 3  Check negative values
SELECT *
FROM mastersales
WHERE OrderQuantity < 0 OR ProductPrice < 0 OR Profit < 0;

# 4 Check distinct values for categorical columns
SELECT DISTINCT OrderMonthName, OrderMonth FROM mastersales ORDER BY OrderMonth;
SELECT DISTINCT CategoryName FROM mastersales;
SELECT DISTINCT PriceCategory FROM mastersales;
SELECT DISTINCT Gender FROM mastersales;
SELECT DISTINCT HomeOwner FROM mastersales;

# 5. Check invalid dates
SELECT *
FROM mastersales
WHERE OrderDate IS NULL OR StockDate IS NULL;

# 6. Check for Outliers
--Example: Find extreme order quantities
SELECT *
FROM mastersales
WHERE OrderQuantity > 1000; 

-- Example: Find extreme profits
SELECT *
FROM mastersales
WHERE Profit > 10000;

