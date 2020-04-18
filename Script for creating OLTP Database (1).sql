--Author:  Yemisi Adeoluwa
--Script Title: Create OLTP (relational) database and tables for EarlyStartStoreLtd DB
--Date: 19/08/2018


DROP DATABASE EarlyStartStoreLtdDW
GO

 
CREATE DATABASE EarlyStartStoreLtdDW
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    CREATE TABLE dbo.Product (
	productID int IDENTITY(1,1) NOT NULL,
	[description] varchar(100) NOT NULL,
	manifacturerName varchar(30) NULL,
	barcode nvarchar(35) NOT NULL,
	price DECIMAL(19, 4) NOT NULL,
	color nvarchar(15) NULL,
	startDate datetime NOT NULL,
	expiryDate datetime NULL,
    CONSTRAINT pk_product_productID PRIMARY KEY (productID),
	)
GO

	CREATE TABLE dbo.City (
	b  cityID int IDENTITY(3,1) NOT NULL,
	city varchar(20) NOT NULL,
	country varchar(25) NOT NULL,
	CONSTRAINT pk_cityID PRIMARY KEY (cityID)
	)
	GO

	CREATE TABLE dbo.Employee (
	employeeID int IDENTITY(4,1) NOT NULL,
	first_Name varchar(30) NOT NULL,
	last_Name varchar(30) NOT NULL,
	jobTitle varchar(35) NOT NULL,
	street varchar(45) NOT NULL,
	postcode nvarchar(18) NOT NULL,
	cityID int NOT NULL,
	startDate DATETIME NOT NULL,
	endDate DATETIME NULL,
	CONSTRAINT pk_employeeID PRIMARY KEY (employeeID),
	CONSTRAINT fk_emp_cityID FOREIGN KEY (cityID) REFERENCES City(cityID)
	)
	GO

CREATE TABLE dbo.Customer (
	CustomerID int IDENTITY(2,1) NOT NULL,
	first_Name nvarchar(25) NOT NULL,
	last_Name nvarchar(25) NOT NULL,
	[Address] nvarchar(60) NOT NULL,
	Postcode nvarchar(30) NOT NULL,
	cityID int  NOT NULL,
	telephone NVARCHAR (30) NULL,
	mobile nvarchar(30) NOT NULL,
	email nvarchar(50) NULL,
	CONSTRAINT pk_customer_customerID PRIMARY KEY (customerID),
	CONSTRAINT fk_customer_cityID FOREIGN KEY (cityID) REFERENCES City(cityID)
	)
	GO
	

	CREATE TABLE dbo.SupplierCategory (
	supplierCategoryID int IDENTITY(6,1) NOT NULL,
	typeofSupplier VARCHAR (65) NOT NULL,
	goodDeliveryDate DATETIME NOT NULL,
	paymentDate DATETIME NOT NULL,
	contractStartDate DATETIME NOT NULL,
	contractEndDate DATETIME NULL,
	CONSTRAINT pk_supplierCategoryID PRIMARY KEY (supplierCategoryID)
	)
	GO

ALTER TABLE dbo.Supplier
ALTER COLUMN email nvarchar(90) NULL
GO

CREATE TABLE dbo.Supplier (
supplierID int IDENTITY(5,1) NOT NULL,
supplierName varchar(55) NOT NULL,
supplierCategoryID int NOT NULL,
address varchar(85) NOT NULL,
cityID int NOT NULL,
region varchar(70) NOT NULL,
postalcode varchar(8) NOT NULL,
telephone NVARCHAR(20) NOT NULL,
email nvarchar(20) NULL,
CONSTRAINT pk_supplierID PRIMARY KEY (SupplierID),
CONSTRAINT fk_sup_supplierCategoryID FOREIGN KEY (supplierCategoryID) REFERENCES SupplierCategory(supplierCategoryID),
CONSTRAINT fk_supplier_cityID FOREIGN KEY (supplierCategoryID) REFERENCES SupplierCategory(supplierCategoryID)
)
GO

CREATE TABLE dbo.SalesPerson (
salesPersonID int IDENTITY(7,2) NOT NULL,
salesPersonNumber INT NOT NULL,
first_Name varchar(30) NOT NULL,
last_Name varchar(35) NOT NULL,
CONSTRAINT pk_salesPersonID PRIMARY KEY (salesPersonID)
)
GO

--ALTER TABLE dbo.CustomerOrder
  --ALTER COLUMN description VARCHAR(100) NULL
  --GO

  ALTER TABLE dbo.CustomerOrder
  ALTER COLUMN unitPrice MONEY NULL
  GO

CREATE TABLE dbo.CustomerOrder (
customerOrderID int IDENTITY(9,5) NOT NULL,
customerID int NOT NULL,
salesPersonID int NOT NULL,
[description] VARCHAR(100) NULL,
quantity int  NULL,
unitPrice DECIMAL(19, 4) NULL,
VAT DECIMAL(19, 4) NULL,
total_excludingVAT DECIMAL(19, 4) NULL,
total_inclVAT DECIMAL(19, 4) NULL,
orderDate DATETIME NULL,
CONSTRAINT pk_customerorderID PRIMARY KEY (CustomerOrderID),
CONSTRAINT fk_custOrd_customerID FOREIGN KEY (customerID) REFERENCES Customer(customerID),
CONSTRAINT fk_custOrd_salesPersonID FOREIGN KEY (salesPersonID) REFERENCES SalesPerson(salesPersonID)
)
GO


CREATE TABLE dbo.Sales (
salesID int IDENTITY(8,3) NOT NULL,
salesPersonID int NOT NULL,
productID int NOT NULL,
customerOrderID int NOT NULL,
sales_Location varchar(30) NOT NULL,
orderQty int NULL,
unitPrice DECIMAL(19, 4) NULL,
unit_Price_Discount_Pct int NULL,
discountAmount DECIMAL(19, 4) NULL,
productStandardCost DECIMAL(19, 4) NOT NULL,
totalProductCost DECIMAL(19, 4) NOT NULL,
salesAmount DECIMAL(19, 4) NOT NULL,
orderDate DATETIME NOT NULL,
CONSTRAINT pk_sales_salesID PRIMARY KEY (SalesID),
CONSTRAINT fk_sales_salesPersonID FOREIGN KEY (salesPersonID) REFERENCES SalesPerson(salesPersonID),
CONSTRAINT fk_sales_productID FOREIGN KEY (productID) REFERENCES Product(productID),
CONSTRAINT fk_customerOrderID FOREIGN KEY (customerOrderID) REFERENCES CustomerOrder(customerOrderID)
)
GO






