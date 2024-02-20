# DATA CLEANING PROCESS

# First look at inventory table

SELECT * 
FROM supermarket_inventory;

# Checking for identifier inaccuracies

SELECT COUNT(DISTINCT store_id), COUNT(DISTINCT store_name)
FROM supermarket_inventory;

# Updating table headers to preferred format

ALTER TABLE supermarket_inventory
RENAME COLUMN StoreId TO store_id,
RENAME COLUMN ProductId TO product_id,
RENAME COLUMN StoreName TO store_name,
RENAME COLUMN Address TO street_address,
RENAME COLUMN QuantityAvailable TO quantity_available;

# Validating completeness of data quantities - checked all available fields but only listing the one with missing values

SELECT * 
FROM supermarket_inventory
WHERE store_name = '' OR store_name IS NULL;

# Updated missing values based on value of store_id

UPDATE supermarket_inventory
SET store_name = 'Dollar Tree'
WHERE store_id = 21791 AND store_name = '';

# First look at sales table

SELECT * 
FROM supermarket_sales;

# Changed date field to appropriate format

UPDATE supermarket_sales
SET Date = str_to_date(`Date`, '%m/%d/%Y');

# Updating table headers to preferred format

ALTER TABLE supermarket_sales
RENAME COLUMN SalesId TO sales_id,
RENAME COLUMN StoreId TO store_id,
RENAME COLUMN ProductId TO product_id,
RENAME COLUMN Date TO date,
RENAME COLUMN UnitPrice TO unit_price,
RENAME COLUMN Quantity TO quantity;

# Checked for any NULL or missing values in all fields (only showing one query) -- None found

SELECT * 
FROM supermarket_sales
WHERE quantity IS NULL OR quantity = '';

# First look at products table

SELECT *
FROM supermarket_products;

# Updating table headers to preferred format

ALTER TABLE supermarket_products
RENAME COLUMN ProductId TO product_id,
RENAME COLUMN ProductName TO product_name,
RENAME COLUMN Supplier TO supplier,
RENAME COLUMN ProductCost TO product_cost;

# Validate product names for any typos

SELECT DISTINCT product_name
FROM supermarket_products
ORDER BY product_name;

# Update single product to match other with correct spelling

UPDATE supermarket_products
SET product_name = REPLACE(product_name,'Appetiser - Bought','Appetizer - Bought');

# Checked for any NULL or missing values in all fields (only showing one query) -- None found

SELECT *
FROM supermarket_products
WHERE product_cost = '' OR product_cost IS NULL;

# DATA CLEANING COMPLETE
