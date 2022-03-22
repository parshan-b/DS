/*
Overview:
Briefly define business and analytical objectives and think through how the data should be transformed 
and structured for analysis. Execute on your plan using SQL: perform the necessary ETL (extract, 
transform, and load) tasks on the available data, construct and evaluate your models, and then present 
your findings and insights effectively. 

CASE:
AdventureWorks is a wholesale distributor that has several resellers under its umbrella, each reseller 
sells a variety of products catering to Bikes, Components, clothing, and Accessories.  
AdventureWorks is trying to improve its operational performance and on several dimensions such as 
products, reseller performance, shipping times etc. It is also trying to come up with a past performance 
analysis on products sold, demographics and customer behaviour analytics to help them improve sales 
and marketing. 
*/

/*Findings:
AdventureWorks (AW) is to reassess their reseller network since AW’s profit is strongly tied to resellers’ sales performance. Past sales data dated from July 2005 to June 2008 was provided by AW to facilitate the analytical work and to help derive actionable insights that will cultivate a more profitable reseller network.

Macro trends, reseller performance analyses, and detailed geospatial analyses were performed to gain insight on addressing the business problem. 

At the macro-level, it was discovered that revenue dipped in the months of January, April, July, and October. These months can be targeted for additional promotions to increase sales. It was also evident that product costs had a dramatic increase in the 2007-2008 fiscal year,
which may be associated with supply side difficulties during the 2007-2008 fiscal year.

Reseller’s performance was calculated and ranked by a custom metric which assess the ability of an average employee to generate annualized profits. It is evident that top ranking resellers are associated with having higher margins, lower discounts, and relatively high
units sold. Similarly, the best performing business type is Value Added Reseller, who share the same characteristics of higher margins, lower discounts, and relatively high units sold.

With the aid of visualization tools, geospatial analysis was performed to identify potential market entry opportunities and reseller bases that could be further improved to capture and serve more customers efficiently. This was done by looking into cities where AW customers
reside but do not have access to a local reseller. Furthermore, it was found that in all countries, the mountain bikes are the only AW bikes with a positive margin.

The above analyses yield actionable insights for AW to optimize their reseller network. The priority recommendation is that AW should expand into 17 cities in eastern Australia, where 50% of AW customers currently do not have a local AW reseller in their city. When expanding, AW should also focus on adding Value Added Resellers and promoting their mountain bikes to increase the probability that this expansion is profitable.

A further expansion into western US should also be considered by making AW products more conveniently accessible to the already strong customer base. The margins of AW’s main product, bikes, also needs to be improved in Germany if AW wants to achieve long term success in that market. Finally, further analysis needs to be undertaken to determine if price wars and cannibalization are occurring in postal codes with multiple local resellers. If so, AW should consider dropping lower performing resellers in those areas.
/*

/*It is important to note that for the reseller sales table, the data types of the order date, ship date, and due date 
are not correct, and thus, the exported .csv version of this table was not able to capture the timestamp information 
from the Excel file. Therefore, the order date, ship date, and due date were first converted to the type of short date 
in Excel before the Excel file was exported to .csv file.  */

DROP TABLE IF EXISTS SalesTerritory;
CREATE TABLE SalesTerritory (
	SalesTerritoryKey VARCHAR(5),
	SalesTerritoryAlternateKey VARCHAR(50),
	SalesTerritoryRegion VARCHAR(50),
	SalesTerritoryCountry VARCHAR(50),
	SalesTerritoryGroup VARCHAR(50),
	PRIMARY KEY (SalesTerritoryKey)
);

DROP TABLE IF EXISTS Currency;
CREATE TABLE Currency (
	CurrencyKey VARCHAR(5),
	CurrencyAlternateKey VARCHAR(10),
	CurrencyName VARCHAR(50),
	PRIMARY KEY (CurrencyKey)
);

DROP TABLE IF EXISTS Geography;
CREATE TABLE Geography (
	GeographyKey VARCHAR(5),
	City VARCHAR(50),
	StateProvinceCode VARCHAR(50),
	StateProvinceName VARCHAR(50),
	CountryRegionCode VARCHAR(10),
	EnglishCountryRegionName VARCHAR(50),
	SpanishCountryRegionName VARCHAR(50),
	FrenchCountryRegionName VARCHAR(50),
	PostalCode VARCHAR(10),
	SalesTerritoryKey VARCHAR(10),
	IpAddressLocator VARCHAR(30)
);

DROP TABLE IF EXISTS Reseller;
CREATE TABLE Reseller (
	ResellerKey VARCHAR(5),
	GeographyKey VARCHAR(5),
	ResellerAlternateKey VARCHAR(15),
	Phone VARCHAR(30),
	BusinessType TEXT,
	ResellerName TEXT,
	NumberEmployees INTEGER,
	OrderFrequency VARCHAR(3),
	OrderMonth VARCHAR(5),
	FirstOrderYear VARCHAR(4),
	LastOrderYear VARCHAR(4),
	ProductLine VARCHAR(20),
	AddressLine1 TEXT,
	AddressLine2 TEXT,
	AnnualSales INTEGER,
	BankName TEXT,
	MinPaymentType VARCHAR(5),
	MinPaymentAmount VARCHAR(5),
	AnnualRevenue INTEGER,
	YearOpened VARCHAR(4)
);

DROP TABLE IF EXISTS ResellerSales;
CREATE TABLE ResellerSales (
	ProductKey VARCHAR(5),
	OrderDateKey VARCHAR(10),
	DueDateKey VARCHAR(10),
	ShipDateKey VARCHAR(10),
	ResellerKey VARCHAR(5),
	EmployeeKey VARCHAR(5),
	PromotionKey VARCHAR(3),
	CurrencyKey VARCHAR(5),
	SalesTerritoryKey VARCHAR(3),
	SalesOrderNumber VARCHAR(10),
	SalesOrderLineNumber VARCHAR(5),
	RevisionNumber VARCHAR(3),
	OrderQuantity INTEGER,
	UnitPrice REAL,
	ExtendedAmount REAL,
	UnitPriceDiscountPct REAL,
	DiscountAmount REAL,
	ProductStandardCost REAL,
	TotalProductCost REAL,
	SalesAmount REAL,
	TaxAmt REAL,
	Freight REAL,
	CarrierTrackingNumber VARCHAR(20),
	CustomerPONumber VARCHAR(20),
	OrderDate TIMESTAMP,
	DueDate TIMESTAMP,
	ShipDate TIMESTAMP
);

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
	CustomerKey VARCHAR(10),
	GeographyKey VARCHAR(5),
	CustomerAlternateKey VARCHAR(15),
	Title VARCHAR(50),
	FirstName VARCHAR(50),
	MiddleName VARCHAR(50),
	LastName VARCHAR(50),
	NameStyle VARCHAR (5),
	BirthDate DATE,
	MaritalStatus VARCHAR(5),
	Suffix VARCHAR(10),
	Gender CHAR(1),
	EmailAddress VARCHAR(100),
	YearlyIncome INTEGER,
	TotalChildren INTEGER,
	NumberChildrenAtHome INTEGER,
	EnglishEducation VARCHAR(50),
	SpanishEducation VARCHAR(50),
	FrenchEducation VARCHAR(50),
	EnglishOccupation VARCHAR(50),
	SpanishOccupation VARCHAR(50),
	FrenchOccupation VARCHAR(50),
	HouseOwnerFlag INTEGER,
	NumberCarsOwned INTEGER,
	AddressLine1 VARCHAR(150),
	AddressLine2 VARCHAR(150),
	Phone VARCHAR(30),
	DateFirstPurchase DATE,
	CommuteDistance VARCHAR(20)
);

CREATE TABLE Product (
	ProductKey TEXT,
	ProductAlternateKey TEXT,
	ProductSubcategoryKey TEXT,
	WeightUnitMeasureCode TEXT,
	SizeUnitMeasureCode TEXT,
	EnglishProductName TEXT,
	SpanishProductName TEXT,
	FrenchProductName TEXT,
	StandardCost TEXT,
	FinishedGoodsFlag TEXT,
	Color TEXT,
	SafetyStockLevel TEXT,
	ReorderPoint TEXT,
	ListPrice REAL,
	Size VARCHAR(5),
	SizeRange VARCHAR(20),
	Weight REAL,
	DaysToManufacture INTEGER,
	ProductLine VARCHAR(5),
	DealerPrice REAL,
	Class VARCHAR(3),
	Style VARCHAR(3),
	ModelName VARCHAR(50),
	LargePhoto TEXT,
	EnglishDescription TEXT,
	FrenchDescription TEXT,
	ChineseDescription TEXT,
	ArabicDescription TEXT,
	HebrewDescription TEXT,
	ThaiDescription TEXT, 
	GermanDescription TEXT,
	JapaneseDescription TEXT,
	TurkishDescription TEXT,
	StartDate TIMESTAMP,
	EndDate TIMESTAMP,
	Status VARCHAR(30)
);

CREATE TABLE ProductCategory (
	ProductCategoryKey VARCHAR(3),
	PRIMARY KEY (ProductCategoryKey),
	ProductCategoryAlternateKey VARCHAR(3),
	EnglishProductCategoryName TEXT,
	SpanishProductCategoryName TEXT,
	FrenchProductCategoryName TEXT
);

CREATE TABLE ProductSubcategory (
	ProductSubcategoryKey VARCHAR(5),
	ProductSubcategoryAlternateKey VARCHAR(5),
	EnglishProductSubcategoryName TEXT,
	SpanishProductSubcategoryName TEXT,
	FrenchProductSubcategoryName TEXT,
	ProductCategoryKey VARCHAR(3)
);
*/

--All ANALYSIS related code starts here:
--Which resellers are performing better, in comparison to the ones not performing what are these resellers doing better, 
--do they have better margins, are the better resellers shipping products faster or are they selling more products?

--better performance: 
--sales % monthly growth (->seasonality) 
--margins: sales amount, total product cost
--number of sale in each sales territory

SELECT * FROM resellersales;

--alter the variable type for proper ordering of the rows
ALTER TABLE resellersales ALTER COLUMN resellerkey TYPE INTEGER USING resellerkey::integer;
ALTER TABLE reseller ALTER COLUMN resellerkey TYPE INTEGER USING resellerkey::integer;

--check the years involved
SELECT DISTINCT EXTRACT(YEAR FROM orderdate) FROM resellersales ORDER BY 1;

--check the currency used
SELECT DISTINCT resellersales.currencykey, currencyalternatekey FROM resellersales, currency
WHERE resellersales.currencykey = currency.currencykey;

--create a currency table that stores the conversion rate to USD
--https://fx.sauder.ubc.ca/etc/CADpages.pdf
--https://www.macrotrends.net/2549/pound-dollar-exchange-rate-historical-chart
--https://www.macrotrends.net/2551/australian-us-dollar-exchange-rate-historical-chart
--https://www.macrotrends.net/2548/euro-dollar-exchange-rate-historical-chart
DROP TABLE IF EXISTS currency_exchange;
CREATE TABLE currency_exchange (
	currencyid VARCHAR(5),
	currency VARCHAR(5),
	year DOUBLE PRECISION,
	conversionrate REAL
);
INSERT INTO currency_exchange
(currencyid, currency, year, conversionrate)
VALUES
('98', 'GBP', 2005, 1.82), ('98', 'GBP', 2006, 1.84),('98', 'GBP', 2007, 2), ('98', 'GBP', 2008, 1.85),
('6', 'AUD', 2005, 0.76), ('6', 'AUD', 2006, 0.75), ('6', 'AUD', 2007, 0.84),('6', 'AUD', 2008, 0.85),
('36', 'EUR', 2005, 1.24),('36', 'EUR', 2006, 1.26),('36', 'EUR', 2007, 1.37),('36', 'EUR', 2008, 1.47),
('19', 'CAD', 2005, 0.825),('19', 'CAD', 2006, 0.88),('19', 'CAD', 2007, 0.931), ('19', 'CAD', 2008, 0.937),
('100', 'USD', 2005, 1), ('100', 'USD', 2006, 1), ('100', 'USD', 2007, 1), ('100', 'USD', 2008, 1);

SELECT * FROM currency_exchange;

--create a new resellersales_usd table that keeps USD equivalent monies, as well as months since company inception
ALTER TABLE resellersales ADD COLUMN IF NOT EXISTS orderyear DOUBLE PRECISION, ADD COLUMN IF NOT EXISTS ordermonth DOUBLE PRECISION;

UPDATE resellersales SET orderyear = EXTRACT(YEAR FROM orderdate), ordermonth = EXTRACT(MONTH FROM orderdate);

SELECT * FROM resellersales;

DROP TABLE IF EXISTS resellersales_t1;
SELECT * INTO TEMP TABLE resellersales_t1
FROM resellersales LEFT JOIN currency_exchange
ON resellersales.currencykey = currency_exchange.currencyid
AND currency_exchange.year = resellersales.orderyear;

SELECT * FROM resellersales_t1;

ALTER TABLE resellersales_t1 DROP COLUMN currencyid, DROP COLUMN year;
ALTER TABLE resellersales_t1 ADD COLUMN fiscalmonth DOUBLE PRECISION, ADD COLUMN months_since_Jun_05 DOUBLE PRECISION,
ADD COLUMN fiscalyear DOUBLE PRECISION, ADD COLUMN unitpriceUSD REAL, ADD COLUMN extendedamountUSD REAL, 
ADD COLUMN discountamountUSD REAL, ADD COLUMN productstandardcostUSD REAL, ADD COLUMN totalproductcostUSD REAL, ADD COLUMN salesamountUSD REAL;

SELECT * FROM resellersales_t1;

UPDATE resellersales_t1 
SET unitpriceUSD = unitprice * conversionrate,
extendedamountUSD = extendedamount * conversionrate,
discountamountUSD = discountamount * conversionrate,
productstandardcostUSD = productstandardcost * conversionrate,
totalproductcostUSD = totalproductcost * conversionrate,
salesamountUSD = salesamount * conversionrate,
fiscalmonth= CASE WHEN MOD(((ordermonth-6) + (orderyear-2005)*12)::INTEGER, 12) = 0 THEN 12
ELSE MOD(((ordermonth-6) + (orderyear-2005)*12)::INTEGER, 12) END,
fiscalyear = FLOOR(((ordermonth-6) + (orderyear-2005)*12)/12.5) + 1;

SELECT * FROM resellersales_t1;

SELECT DISTINCT(orderyear, ordermonth), months_since_jun_05, fiscalyear FROM resellersales_t1;

--to check the conversion
select * FROM resellersales_t1 WHERE currencykey <> '100';

--creation of final table
DROP TABLE IF EXISTS resellersalesUSD;
SELECT resellerkey, salesterritorykey, currencykey, productkey, orderyear, fiscalyear, fiscalmonth, months_since_jun_05, currency, conversionrate, orderquantity, 
unitpriceUSD, extendedamountUSD, discountamountUSD, productstandardcostUSD, totalproductcostUSD, salesamountUSD, 
orderdate, duedate, shipdate INTO resellersalesUSD FROM resellersales_t1 ORDER BY resellerkey, orderyear;

SELECT * FROM resellersalesUSD;

--Geospatial Analysis
--number of sale in each sales territory
DROP TABLE IF EXISTS regionsales;
WITH territorysalesUSD AS (
	SELECT DISTINCT salesterritorykey,
	SUM(salesamountUSD) OVER (PARTITION BY salesterritorykey) AS territorysalesUSD,
	COUNT(*) OVER (PARTITION BY salesterritorykey) AS territoryorders
	FROM resellersalesUSD 
	ORDER BY territorysalesUSD DESC
)
SELECT territorysalesUSD.salesterritorykey, salesterritoryregion, salesterritorycountry, 
salesterritorygroup, territorysalesUSD, territoryorders, resellernumbers
INTO regionsales
FROM territorysalesUSD 
LEFT JOIN salesterritory 
ON territorysalesUSD.salesterritorykey = salesterritory.salesterritorykey
LEFT JOIN (SELECT salesterritorykey, COUNT(DISTINCT resellerkey) AS resellernumbers FROM resellersalesUSD GROUP BY salesterritorykey) AS resellercount
ON territorysalesUSD.salesterritorykey = resellercount.salesterritorykey
ORDER BY territorysalesUSD DESC;

SELECT * FROM regionsales ORDER BY territorysalesUSD DESC;

--continent sales
SELECT salesterritorygroup, SUM(territorysalesusd) FROM regionsales GROUP BY salesterritorygroup;

--check when each sales territory started to sell products
SELECT salesterritorykey, MIN(orderdate)
FROM resellersalesUSD
GROUP BY salesterritorykey;

--check if each reseller has no more than 1 store
SELECT COUNT(*) as TotalResellerEntries, COUNT(DISTINCT resellerkey) TotalUniqueResellers
FROM reseller;

--check if multiple resellers fall within same postal code (geographykey) > we see that many do
SELECT geographykey, COUNT(*) FROM reseller GROUP BY geographykey HAVING count(*) > 1 ORDER BY 2 DESC;

--these postal code seems to have 11 and 10 resellers respectively!
SELECT * FROM geography WHERE geographykey = '41';
SELECT * FROM geography WHERE geographykey = '409';

--look at the number of customers and resellers in each postal code, and then filter them to get the postal codes where there are customers but no resellers. This provides potential expansion areas where there is demand
DROP TABLE IF EXISTS potentialresellerlocation;
SELECT DISTINCT geography.geographykey, city, postalcode, stateprovincename, englishcountryregionname, geography.salesterritorykey, stateprovincecode, countryregioncode, 
COUNT(DISTINCT reseller) AS resellercount, COUNT(DISTINCT customerkey) AS customercount
INTO potentialresellerlocation
FROM geography LEFT JOIN reseller 
ON geography.geographykey = reseller.geographykey
LEFT JOIN customer
ON geography.geographykey = customer.geographykey
GROUP BY geography.geographykey, city, salesterritorykey, stateprovincename, englishcountryregionname, postalcode, stateprovincecode, countryregioncode
HAVING COUNT(DISTINCT reseller)=0 AND COUNT(DISTINCT customerkey) <> 0 ORDER BY customercount DESC;

SELECT * FROM potentialresellerlocation;

--look at the reseller locations
DROP TABLE IF EXISTS resellerlocation;
SELECT DISTINCT geography.geographykey, resellerkey, city, postalcode, stateprovincename, englishcountryregionname, stateprovincecode, countryregioncode
INTO resellerlocation
FROM reseller LEFT JOIN geography
ON reseller.geographykey = geography.geographykey
ORDER BY resellerkey;

SELECT * FROM resellerlocation;

--prepping reseller & customer (customers that has no local reseller) table for visualziation to identify new reseller location
DROP TABLE IF EXISTS Customer_Reseller_Location;
CREATE TABLE Customer_Reseller_Location AS (
SELECT geographykey, postalcode, city, stateprovincename, englishcountryregionname, stateprovincecode, countryregioncode, customercount,
CASE WHEN true THEN 'customer' ELSE NULL END AS category FROM potentialresellerlocation
UNION
SELECT DISTINCT geographykey, postalcode, city, stateprovincename, englishcountryregionname,stateprovincecode, countryregioncode,
CASE WHEN true THEN NULL ELSE 0 END AS customercount,
CASE WHEN true THEN 'reseller' ELSE NULL END AS category FROM resellerlocation);

SELECT * FROM Customer_Reseller_Location;

--create alt version at the CITY level (not postal code level)
DROP TABLE IF EXISTS Customer_Reseller_Location_City;
WITH T as (
SELECT city, stateprovincename, englishcountryregionname, stateprovincecode, countryregioncode, category, SUM(customercount) as customercount
FROM Customer_Reseller_Location
GROUP BY city, stateprovincename, englishcountryregionname, stateprovincecode, countryregioncode, category
)
SELECT *
INTO Customer_Reseller_Location_City
FROM T
WHERE category = 'reseller' OR city NOT IN
(SELECT city
FROM T
WHERE category = 'reseller');

SELECT * FROM Customer_Reseller_Location_City;

--COUNT all customers without reseller at CITY level (for visualization) by Country
DROP TABLE IF EXISTS customer_demand_by_country;
SELECT englishcountryregionname, countryregioncode,SUM(customercount) AS customers_without_resellers,COUNT(customercount) AS cities_without_resellers
INTO customer_demand_by_country
FROM Customer_Reseller_Location_City
GROUP BY englishcountryregionname, countryregioncode;

SELECT * FROM customer_demand_by_country;

--other insights and looking at Australia case specifically:
--total customers
SELECT COUNT(*) FROM customer;
--total customers without reseller in their city
SELECT SUM(customercount) FROM customer_reseller_location_city;
--total australian customers
SELECT COUNT(*)
FROM customer c INNER JOIN geography g
ON c.geographykey = g.geographykey
WHERE countryregioncode = 'AU';
--total australian customers without reseller in their city
SELECT SUM(customercount) FROM customer_reseller_location_city WHERE countryregioncode = 'AU';

--Performance Analysis
--calculate annual year sales performance at the reseller level
DROP TABLE IF EXISTS reseller_annual_sales_backbone;
SELECT DISTINCT r.resellerkey, y.year, annual_sales_before_discount, annual_discount, annual_sales_after_discount, annual_product_cost, 
annual_units_sold, annual_net_profit, annual_margin, positive_annual_margin, annual_sales_made
INTO reseller_annual_sales_backbone
FROM reseller AS r CROSS JOIN (SELECT DISTINCT(EXTRACT(YEAR FROM duedate)) AS year FROM resellersalesUSD) AS y
LEFT JOIN
(SELECT resellerkey, EXTRACT(YEAR FROM duedate) AS sales_year,
SUM(extendedamountUSD) AS annual_sales_before_discount,
SUM(discountamountUSD) AS annual_discount,
SUM(salesamountUSD) AS annual_sales_after_discount,
SUM(totalproductcostUSD) AS annual_product_cost,
SUM(orderquantity) AS annual_units_sold,
SUM(salesamountUSD) - SUM(totalproductcostUSD) AS annual_net_profit,
(SUM(salesamountUSD) - SUM(totalproductcostUSD)) / SUM(totalproductcostUSD) AS annual_margin,
CASE WHEN ((SUM(salesamountUSD) - SUM(totalproductcostUSD)) / SUM(salesamountUSD)) > 0 
 THEN 1 ELSE 0 END AS positive_annual_margin,
CASE WHEN SUM(salesamountUSD) > 0 THEN 1 ELSE 0 END AS annual_sales_made
FROM resellersalesUSD GROUP BY resellerkey, EXTRACT(YEAR FROM duedate) ORDER BY resellerkey, sales_year) AS s
ON r.resellerkey = s.resellerkey AND y.year = s.sales_year
ORDER BY resellerkey, year;

SELECT * FROM reseller_annual_sales_backbone;

--calculate fiscal year sales performance at the reseller level
--create a backbone
DROP TABLE IF EXISTS reseller_fiscal_year_sales_backbone;
SELECT DISTINCT r.resellerkey, y.fiscalyear, annual_sales_before_discount, annual_discount, annual_sales_after_discount, annual_product_cost, 
annual_units_sold, annual_net_profit, annual_margin, positive_annual_margin, annual_sales_made
INTO reseller_fiscal_year_sales_backbone
FROM reseller AS r CROSS JOIN (SELECT DISTINCT(fiscalyear) AS fiscalyear FROM resellersalesUSD) AS y
LEFT JOIN
(SELECT resellerkey, fiscalyear,
SUM(extendedamountUSD) AS annual_sales_before_discount,
SUM(discountamountUSD) AS annual_discount,
SUM(salesamountUSD) AS annual_sales_after_discount,
SUM(totalproductcostUSD) AS annual_product_cost,
SUM(orderquantity) AS annual_units_sold,
SUM(salesamountUSD) - SUM(totalproductcostUSD) AS annual_net_profit,
(SUM(salesamountUSD) - SUM(totalproductcostUSD)) / SUM(salesamountUSD) AS annual_margin,
CASE WHEN ((SUM(salesamountUSD) - SUM(totalproductcostUSD)) / SUM(totalproductcostUSD)) > 0 THEN 1 ELSE 0 END AS positive_annual_margin,
CASE WHEN SUM(salesamountUSD) > 0 THEN 1 ELSE 0 END AS annual_sales_made
FROM resellersalesUSD GROUP BY resellerkey, fiscalyear ORDER BY resellerkey, fiscalyear) AS s
ON r.resellerkey = s.resellerkey AND y.fiscalyear = s.fiscalyear
ORDER BY resellerkey, fiscalyear;

SELECT * FROM reseller_fiscal_year_sales_backbone;

SELECT salesterritorykey, fiscalyear, SUM(salesamountUSD) FROM resellersalesUSD GROUP BY 1, 2 ORDER BY 1, 2;

--calculate monthly sales performance at the reseller level: monthly sales, monthly cost, monthly margin
--create a backbone
DROP TABLE IF EXISTS reseller_monthly_sales_backbone;
SELECT r.resellerkey, y.year, m.month,
(y.year-2005)*12+m.month AS months_since_inception,
monthly_sales_before_discount, monthly_discount, monthly_sales_after_discount, 
monthly_product_cost, monthly_units_sold, monthly_net_profit, monthly_margin
INTO reseller_monthly_sales_backbone
FROM reseller AS r CROSS JOIN (SELECT DISTINCT(EXTRACT(YEAR FROM duedate)) AS year FROM resellersalesUSD) AS y
CROSS JOIN
(SELECT DISTINCT(EXTRACT(MONTH FROM duedate)) AS month FROM resellersalesUSD) AS m
LEFT JOIN
(SELECT resellerkey, EXTRACT(YEAR FROM duedate) AS sales_year, EXTRACT(MONTH FROM duedate) AS sales_month,
SUM(extendedamountUSD) AS monthly_sales_before_discount,
 CASE WHEN SUM(discountamountUSD) = 0 THEN NULL ELSE SUM(discountamountUSD) END AS monthly_discount,
SUM(salesamountUSD) AS monthly_sales_after_discount,
SUM(totalproductcostUSD) AS monthly_product_cost,
SUM(orderquantity) AS monthly_units_sold,
SUM(salesamountUSD) - SUM(totalproductcostUSD) AS monthly_net_profit,
(SUM(salesamountUSD) - SUM(totalproductcostUSD)) / SUM(totalproductcostUSD) AS monthly_margin
FROM resellersalesUSD GROUP BY resellerkey, EXTRACT(YEAR FROM duedate), EXTRACT(MONTH FROM duedate) ORDER BY resellerkey, sales_month) AS s
ON r.resellerkey = s.resellerkey AND m.month = s.sales_month AND y.year = s.sales_year
ORDER BY resellerkey, year, month;

SELECT * FROM reseller_monthly_sales_backbone;

--trend all resellers' monthly sales since inception (48 months)
DROP TABLE IF EXISTS aggregated_monthly_sales_since_inception;
SELECT months_since_inception, SUM(monthly_sales_before_discount) AS monthly_sales_before_discount,
SUM(monthly_discount) AS monthly_discount, SUM(monthly_sales_after_discount) AS monthly_sales_after_discount,
SUM(monthly_product_cost) AS monthly_product_cost,
(SUM(monthly_sales_after_discount) - lag(SUM(monthly_sales_after_discount), 1) OVER (ORDER BY months_since_inception)) / 
lag(SUM(monthly_sales_after_discount), 1) OVER (ORDER BY months_since_inception) AS monthly_sales_growth,
(SUM(monthly_discount) - lag(SUM(monthly_discount) , 1) OVER (ORDER BY months_since_inception)) / 
lag(SUM(monthly_discount) , 1) OVER (ORDER BY months_since_inception) AS monthly_discount_change
INTO aggregated_monthly_sales_since_inception
FROM reseller_monthly_sales_backbone GROUP BY months_since_inception ORDER BY months_since_inception;

SELECT * FROM aggregated_monthly_sales_since_inception;

--create monthly sales per fiscal year table (36 months only compared to the above table)
DROP TABLE IF EXISTS aggregated_monthly_sales_since_mid_05;
SELECT ROW_NUMBER() OVER(ORDER BY months_since_inception) AS fiscal_year_month_since_inception,
FLOOR(ROW_NUMBER() OVER(ORDER BY months_since_inception)/12.5) + 1 AS fiscal_year ,* 
INTO aggregated_monthly_sales_since_mid_05
FROM aggregated_monthly_sales_since_inception
WHERE monthly_sales_before_discount IS NOT NULL;

SELECT * FROM aggregated_monthly_sales_since_mid_05;

--look at fiscal year sales: Jul 05 ~ Jun 06, Jul 06 ~ Jun 07, Jul 07 ~ Jun 08
DROP TABLE IF EXISTS fiscal_year_sales;
SELECT fiscal_year, SUM(monthly_sales_after_discount) AS fiscal_year_sales, 
(SUM(monthly_sales_after_discount) - lag(SUM(monthly_sales_after_discount), 1) OVER (ORDER BY fiscal_year)) / 
lag(SUM(monthly_sales_after_discount), 1) OVER (ORDER BY fiscal_year) AS fiscal_year_sales_growth,
SUM(monthly_sales_before_discount) - SUM(monthly_product_cost) AS fiscal_year_net_profit,
SUM(monthly_product_cost) AS annual_COGS
INTO fiscal_year_sales
FROM aggregated_monthly_sales_since_mid_05 GROUP BY fiscal_year ORDER BY 1;

SELECT * FROM fiscal_year_sales;

--count resellers that have positive fiscal year margin for each fiscal year
DROP TABLE IF EXISTS reseller_with_fiscal_positive_margin_count;
SELECT fiscalyear, SUM(positive_annual_margin) AS number_of_resellers_with_positive_margin 
INTO reseller_with_fiscal_positive_margin_count
FROM reseller_fiscal_year_sales_backbone GROUP BY 1 ORDER BY 1;

SELECT * FROM reseller_with_fiscal_positive_margin_count;

--trend the sales of each normal year
DROP TABLE IF EXISTS aggregated_annual_sales_since_inception;
SELECT EXTRACT(YEAR FROM duedate) AS sales_year, SUM(salesamountUSD) AS annual_sales,
SUM(totalproductcostUSD) AS annual_COGS,
SUM(salesamountUSD) - SUM(totalproductcostUSD) AS annual_net_profit,
(SUM(salesamountUSD) - lag(SUM(salesamountUSD), 1) OVER (ORDER BY EXTRACT(YEAR FROM duedate))) / 
lag(SUM(salesamountUSD), 1) OVER (ORDER BY EXTRACT(YEAR FROM duedate)) AS sales_growth
INTO aggregated_annual_sales_since_inception
FROM resellersalesUSD GROUP BY EXTRACT(YEAR FROM duedate) ORDER BY sales_year;

SELECT * FROM aggregated_annual_sales_since_inception;

--understand monthly sales amount (afer discount), and correlation between monthly discount and monthly sales
DROP TABLE IF EXISTS overlay_aggregated_fiscal_month_sales;
SELECT fiscalmonth, SUM(salesamountUSD) AS monthly_sales, 
SUM(discountamountUSD) AS monthly_discount, SUM(orderquantity) AS monthly_units_sold,
(SUM(salesamountUSD) - lag(SUM(salesamountUSD), 1) OVER (ORDER BY fiscalmonth)) / 
lag(SUM(salesamountUSD), 1) OVER (ORDER BY fiscalmonth) AS sales_growth,
(SUM(discountamountUSD) - lag(SUM(discountamountUSD), 1) OVER (ORDER BY fiscalmonth)) / 
lag(SUM(discountamountUSD), 1) OVER (ORDER BY fiscalmonth) AS discount_change,
(SUM(orderquantity) - lag(SUM(orderquantity), 1) OVER (ORDER BY fiscalmonth))::REAL / 
lag(SUM(orderquantity), 1) OVER (ORDER BY fiscalmonth)::REAL AS units_sold_change
INTO overlay_aggregated_fiscal_month_sales
FROM resellersalesUSD GROUP BY fiscalmonth ORDER BY fiscalmonth;

SELECT * FROM overlay_aggregated_fiscal_month_sales;

--understand seasonality, and correlation between seasonal discount and seasonal sales
--normal months instead of fiscal months are used here
DROP TABLE IF EXISTS overlay_aggregated_quarterly_sales;
WITH quarterly_sales_since_inception AS (
	SELECT sales_month/3 AS quarter, 
	SUM(monthly_sales) OVER (ORDER BY sales_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS quarterly_sales,
	SUM(monthly_discount) OVER (ORDER BY sales_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS quarterly_discount,
	SUM(monthly_units_sold) OVER (ORDER BY sales_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS quarterly_units_sold
	FROM overlay_aggregated_monthly_sales
	WHERE sales_month/3 in (1,2,3,4)
	ORDER BY quarter
)
SELECT quarter, quarterly_sales, 
(quarterly_sales - lag(quarterly_sales, 1) OVER (ORDER BY quarter)) / 
lag(quarterly_sales, 1) OVER (ORDER BY quarter) AS quarterly_sales_growth,
quarterly_discount,
(quarterly_discount - lag(quarterly_discount, 1) OVER (ORDER BY quarter)) / 
lag(quarterly_discount, 1) OVER (ORDER BY quarter) AS quarterly_discount_change,
quarterly_units_sold,
(quarterly_units_sold - lag(quarterly_units_sold, 1) OVER (ORDER BY quarter))::REAL / 
lag(quarterly_units_sold, 1) OVER (ORDER BY quarter)::REAL AS quarterly_units_sold_change
INTO overlay_aggregated_quarterly_sales
FROM quarterly_sales_since_inception ORDER BY quarter;

SELECT * FROM overlay_aggregated_quarterly_sales;

--back to reseller level
SELECT * FROM reseller_annual_sales_backbone;
SELECT * FROM reseller_fiscal_year_sales_backbone;

--reseller performance analysis

DROP TABLE IF EXISTS reseller_normal_year_performance_ranking;
WITH reseller_performance AS (
	SELECT resellerkey, 
	SUM(positive_annual_margin) AS positive_annual_margin_count,
	SUM(annual_sales_made) AS positive_sales_year_count,
	SUM(annual_net_profit) AS total_net_profit, 
	SUM(annual_sales_after_discount) AS total_sales_after_discount,
	SUM(annual_product_cost) AS total_product_cost,
	SUM(annual_net_profit)/SUM(annual_sales_after_discount) AS margin,
	SUM(annual_units_sold) AS total_units_sold
	FROM reseller_annual_sales_backbone GROUP BY resellerkey 
	HAVING SUM(positive_annual_margin) IS NOT NULL ORDER BY total_net_profit DESC, positive_annual_margin_count DESC
)
SELECT reseller_performance.resellerkey, geographykey, businesstype, numberemployees, positive_sales_year_count, positive_annual_margin_count,
total_net_profit/numberemployees/positive_sales_year_count AS employee_annual_profit_generating_capability,
ntile(100) OVER (ORDER BY total_net_profit/numberemployees/positive_sales_year_count) AS employee_annual_profit_generating_capability_percentile,
margin, ntile(100) OVER (ORDER BY margin) AS margin_percentile,
total_net_profit/positive_sales_year_count AS avg_annual_net_profit,
ntile(100) OVER (ORDER BY total_net_profit/positive_sales_year_count) AS avg_annual_net_profit_percentile,
ntile(100) OVER (ORDER BY total_sales_after_discount/positive_sales_year_count) AS avg_annual_sales_percentile,
ntile(100) OVER (ORDER BY total_product_cost/total_units_sold DESC) AS product_cost_control_percentile,
ntile(100) OVER (ORDER BY total_units_sold/positive_sales_year_count) AS avg_annual_units_sold_percentile,
ntile(100) OVER (ORDER BY positive_annual_margin_count/positive_sales_year_count, margin) AS positive_annual_margin_frequency_percentile
INTO reseller_normal_year_performance_ranking
FROM reseller_performance LEFT JOIN reseller ON reseller_performance.resellerkey = reseller.resellerkey
GROUP BY reseller_performance.resellerkey, geographykey, businesstype, numberemployees, positive_sales_year_count, positive_annual_margin_count,
employee_annual_profit_generating_capability, margin, avg_annual_net_profit, total_sales_after_discount, total_product_cost, 
total_units_sold, positive_annual_margin_count
ORDER BY employee_annual_profit_generating_capability_percentile DESC, employee_annual_profit_generating_capability DESC,
avg_annual_net_profit_percentile DESC, avg_annual_net_profit DESC, margin_percentile DESC, margin DESC;

SELECT * FROM reseller_normal_year_performance_ranking ORDER BY employee_annual_profit_generating_capability DESC;

DROP TABLE IF EXISTS reseller_fiscal_year_performance_ranking;
WITH reseller_performance AS (
	SELECT resellerkey, 
	SUM(positive_annual_margin) AS positive_annual_margin_count,
	SUM(annual_sales_made) AS positive_sales_year_count,
	SUM(annual_net_profit) AS total_net_profit, 
	SUM(annual_sales_after_discount) AS total_sales_after_discount,
	SUM(annual_product_cost) AS total_product_cost,
	SUM(annual_net_profit)/SUM(annual_sales_after_discount) AS margin,
	SUM(annual_units_sold) AS total_units_sold,
	SUM(annual_discount)/SUM(annual_sales_before_discount) AS total_discount
	FROM reseller_fiscal_year_sales_backbone GROUP BY resellerkey 
	HAVING SUM(positive_annual_margin) IS NOT NULL ORDER BY total_net_profit DESC, positive_annual_margin_count DESC
)
SELECT reseller_performance.resellerkey, geographykey, businesstype, positive_sales_year_count, positive_annual_margin_count,
total_net_profit/numberemployees/positive_sales_year_count AS employee_annual_profit_generating_capability, 
numberemployees, ntile(100) OVER (ORDER BY numberemployees) as numberemployees_percentile,
ntile(100) OVER (ORDER BY total_net_profit/numberemployees/positive_sales_year_count) AS employee_annual_profit_generating_capability_percentile,
margin, ntile(100) OVER (ORDER BY margin) AS margin_percentile,
total_net_profit/positive_sales_year_count AS avg_annual_net_profit,
total_discount/positive_sales_year_count AS avg_annual_discount, ntile(100) OVER (ORDER BY total_discount/positive_sales_year_count) as avg_annual_discount_percentile,
total_units_sold/positive_sales_year_count AS avg_annual_units_sold, ntile(100) OVER (ORDER BY total_units_sold/positive_sales_year_count) as avg_annual_units_sold_percentile,
ntile(100) OVER (ORDER BY total_net_profit/positive_sales_year_count) AS avg_annual_net_profit_percentile,
ntile(100) OVER (ORDER BY total_sales_after_discount/positive_sales_year_count) AS avg_annual_sales_percentile,
ntile(100) OVER (ORDER BY total_product_cost/total_units_sold DESC) AS product_cost_control_percentile,
ntile(100) OVER (ORDER BY positive_annual_margin_count/positive_sales_year_count, margin) AS positive_annual_margin_frequency_percentile
INTO reseller_fiscal_year_performance_ranking
FROM reseller_performance LEFT JOIN reseller ON reseller_performance.resellerkey = reseller.resellerkey
GROUP BY reseller_performance.resellerkey, geographykey, businesstype, numberemployees, positive_sales_year_count, positive_annual_margin_count,
employee_annual_profit_generating_capability, margin, avg_annual_net_profit, total_sales_after_discount, total_product_cost, 
total_units_sold, positive_annual_margin_count, total_discount
ORDER BY employee_annual_profit_generating_capability_percentile DESC, employee_annual_profit_generating_capability DESC,
avg_annual_net_profit_percentile DESC, avg_annual_net_profit DESC, margin_percentile DESC, margin DESC;

SELECT * FROM reseller_fiscal_year_performance_ranking;

-- attach geocoding data to be able to map different performing resellers to assess geographic impacts
SELECT *
FROM reseller_fiscal_year_performance_ranking 
LEFT JOIN reseller
ON reseller.resellerkey = reseller_fiscal_year_performance_ranking.resellerkey
LEFT JOIN geography
ON geography.geographykey = reseller.geographykey;

--understanding product margins at geographic level
-- product-margins at country level (category level)
DROP TABLE IF EXISTS category_margins;
WITH product_region_sales AS (
SELECT salesterritorycountry, salesterritoryregion,englishproductcategoryname,englishproductsubcategoryname, SUM(salesamountusd) as sales, SUM(totalproductcostusd) as cost
FROM resellersalesusd s
INNER JOIN salesterritory t
ON t.salesterritorykey = s.salesterritorykey
INNER JOIN product p
ON s.productkey = p.productkey
INNER JOIN productsubcategory c
ON c.productsubcategorykey = p.productsubcategorykey
INNER JOIN productcategory c2
ON c2.productcategorykey = c.productcategorykey
GROUP BY salesterritorycountry,salesterritoryregion,englishproductcategoryname,englishproductsubcategoryname
) 
SELECT salesterritorycountry, englishproductcategoryname, ((SUM(sales)-SUM(cost))/SUM(sales))*100 as category_margin
INTO category_margins
FROM product_region_sales
GROUP BY salesterritorycountry, englishproductcategoryname
ORDER BY 1,3 DESC;

-- product-margins at country level (subcategory level)
DROP TABLE IF EXISTS bike_margins;
WITH product_region_sales AS (
SELECT salesterritorycountry, salesterritoryregion,englishproductcategoryname,englishproductsubcategoryname, SUM(salesamountusd) as sales, SUM(totalproductcostusd) as cost
FROM resellersalesusd s
INNER JOIN salesterritory t
ON t.salesterritorykey = s.salesterritorykey
INNER JOIN product p
ON s.productkey = p.productkey
INNER JOIN productsubcategory c
ON c.productsubcategorykey = p.productsubcategorykey
INNER JOIN productcategory c2
ON c2.productcategorykey = c.productcategorykey
WHERE englishproductcategoryname = 'Bikes'
GROUP BY salesterritorycountry,salesterritoryregion,englishproductcategoryname,englishproductsubcategoryname
)
SELECT salesterritorycountry, englishproductsubcategoryname, ((SUM(sales)-SUM(cost))/SUM(sales))*100 as subcategory_margin
INTO bike_margins
FROM product_region_sales
GROUP BY salesterritorycountry, englishproductsubcategoryname
ORDER BY 1,3 DESC;
