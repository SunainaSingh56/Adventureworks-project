CREATE DATABASE customer_dataset;
use customer_dataset;

CREATE TABLE Customer (
    CustomerKey INT PRIMARY KEY,
    Prefix VARCHAR(10),
    Gender VARCHAR(10),
    Age INT,
    MaritalStatus VARCHAR(10),
    EducationLevel VARCHAR(50),
    Occupation VARCHAR(50),
    AnnualIncome DECIMAL(12,2),
    TotalChildren INT,
    HomeOwner VARCHAR(5)
);


CREATE TABLE ProductCategories (
    ProductCategoryKey INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

CREATE TABLE ProductSubcategories (
    ProductSubcategoryKey INT PRIMARY KEY,
    SubcategoryName VARCHAR(50),
    ProductCategoryKey INT,
    
    FOREIGN KEY (ProductCategoryKey)
    REFERENCES ProductCategories(ProductCategoryKey)
);

CREATE TABLE Product (
    ProductKey INT PRIMARY KEY,
    SubcategoryID INT,
    Type VARCHAR(50),
    Size VARCHAR(20),
    Style VARCHAR(20),
    ProductCost DECIMAL(10,4),
    ProductPrice DECIMAL(10,4),
    Profit DECIMAL(10,4),
    ProfitMargin DECIMAL(6,2),
    PriceCategory VARCHAR(20),

    FOREIGN KEY (SubcategoryID)
    REFERENCES ProductSubcategories(ProductSubcategoryKey)
);

CREATE TABLE Sales (
    OrderDate DATE,
    StockDate DATE,
    OrderYear INT,
    OrderMonth INT,
    OrderMonthName VARCHAR(20),
    ProductKey INT,
    CustomerKey INT,
    TerritoryKey INT,
    OrderQuantity INT,
    ProcessingDays INT,

    FOREIGN KEY (ProductKey)
    REFERENCES Product(ProductKey),

    FOREIGN KEY (CustomerKey)
    REFERENCES Customer(CustomerKey)
);

CREATE TABLE MasterSales AS
SELECT
    s.OrderDate,
    s.StockDate,
    s.OrderYear,
    s.OrderMonth,
    s.OrderMonthName,
    s.OrderQuantity,
    s.ProcessingDays,

    c.CustomerKey,
    c.Prefix,
    c.Gender,
    c.Age,
    c.MaritalStatus,
    c.EducationLevel,
    c.Occupation,
    c.AnnualIncome,
    c.TotalChildren,
    c.HomeOwner,

    p.ProductKey,
    p.Type,
    p.Size,
    p.Style,
    p.ProductCost,
    p.ProductPrice,
    p.Profit,
    p.ProfitMargin,
    p.PriceCategory,

    psc.SubcategoryName,
    pc.CategoryName

FROM Sales s
LEFT JOIN Customer c
    ON s.CustomerKey = c.CustomerKey
LEFT JOIN Product p
    ON s.ProductKey = p.ProductKey
LEFT JOIN ProductSubcategories psc
    ON p.SubcategoryID = psc.ProductSubcategoryKey
LEFT JOIN ProductCategories pc
    ON psc.ProductCategoryKey = pc.ProductCategoryKey;
