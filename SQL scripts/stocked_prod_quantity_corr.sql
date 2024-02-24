# Create a temporary table showing the top ten products sold by the 3 best stores

CREATE temporary table temp_table AS 
	SELECT product_name,
			SUM(quantity_available) AS quantity_avilable,
			SUM(quantity) AS total_quantity, 
			ROUND(AVG(unit_price),2) AS avg_price, 
			ROUND(SUM(unit_price * quantity),2) AS total_sales
	FROM supermarket_products sp
	JOIN supermarket_sales ss
		ON sp.product_id = ss.product_id
	JOIN supermarket_inventory si
		ON ss.product_id = si.product_id
	WHERE supplier IN ('Ben Franklin','Shopko','Family Dollar')
	GROUP BY product_name, supplier, neighborhood
	ORDER BY total_sales DESC, total_quantity DESC
	LIMIT 10;
# Create a secondary temp table containing a single column or product names from the primary temp table

CREATE temporary table t2 AS
	SELECT product_name 
	FROM temp_table;

# Querying all products and relevant metrics from all stores compared to 3 best stores
# The lower the ranking (1-4), the less inventory they stocked for that product

SELECT product_name,
		SUM(quantity_available) AS quantity_available,
		SUM(quantity) AS total_quantity, 
		ROUND(AVG(unit_price),2) AS avg_price, 
		ROUND(SUM(unit_price * quantity),2) AS total_sales,
       		DENSE_RANK() OVER(PARTITION BY product_name ORDER BY SUM(quantity_available) DESC) AS ranking
FROM supermarket_products sp
JOIN supermarket_sales ss
	ON sp.product_id = ss.product_id
JOIN supermarket_inventory si
	ON ss.product_id = si.product_id
WHERE product_name IN (SELECT * FROM t2)
GROUP BY product_name, supplier, neighborhood
ORDER BY total_sales DESC, total_quantity DESC;
