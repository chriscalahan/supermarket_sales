# PLACED ALL DATA EXPLORATION SCRIPTS IN STORED PROCEDURE -- ALSO CREATED INDIVIAL VIEWS (NOT SHOWN)


DELIMITER $$
DROP PROCEDURE IF EXISTS supermarket_analysis_scripts;
CREATE PROCEDURE supermarket_analysis_scripts ()
BEGIN

	# TOP 10 stores in potential sales based on inventory

	WITH potent_sales(store_name, potential_sales) AS
	(
		SELECT store_name,
		ROUND(SUM(quantity_available * unit_price),2) AS potential_sales
		FROM supermarket_inventory si
		JOIN supermarket_sales ss
			ON si.product_id = ss.product_id
		JOIN supermarket_products sp
			ON ss.product_id = sp.product_id
		GROUP BY store_name
		ORDER BY potential_sales DESC
		LIMIT 10
	)
	
	SELECT store_name,
	potential_sales,
	ROUND((potential_sales / (SELECT SUM(potential_sales) FROM potent_sales) * 100),2) AS percent
	FROM potent_sales;
    
	# BEST sales year and amount for each store
    
    WITH top_sales AS 
	(
		SELECT store_name, 
		ROUND(SUM(unit_price * quantity),2) AS total_sales, 
		YEAR(date) AS sale_year,
		DENSE_RANK() OVER(PARTITION BY store_name ORDER BY ROUND(SUM(unit_price * quantity),2) DESC) ranking
		FROM supermarket_sales ss
		JOIN supermarket_inventory si
			ON ss.product_id = si.product_id
		GROUP BY sale_year, store_name
		ORDER BY ranking, sale_year
        )
		
	SELECT store_name, sale_year, total_sales
	FROM top_sales
	WHERE ranking = 1
	ORDER BY total_sales DESC;
    

	# TOP 10 records in actual sales over the last 4 years; Grouped by store and year

	SELECT store_name, ROUND(SUM(unit_price * quantity),2) AS total_sales, YEAR(date) AS year
	FROM supermarket_sales ss
	JOIN supermarket_inventory si
		ON ss.product_id = si.product_id
	GROUP BY store_name, year
	ORDER BY total_sales DESC, store_name, year
	LIMIT 10;


	# Number of products supplied per Supplier with percentage of total over span of data history (4 years)

	SELECT supplier,
   	neighborhood AS delivered_to,
	COUNT(ss.product_id) total_supplied,
	(COUNT(ss.product_id)/(SELECT COUNT(*) FROM supermarket_sales)) * 100 AS percent
	FROM supermarket_products sp
	JOIN supermarket_sales ss
		ON sp.product_id = ss.product_id
    	JOIN supermarket_inventory si
		ON ss.product_id = si.product_id
	GROUP BY supplier, neighborhood
	ORDER BY total_supplied DESC;
    
    
	# Check to validate that each store has a single location for above script

	SELECT DISTINCT * 
	FROM
  	(SELECT store_name, neighborhood
   	FROM supermarket_inventory
   	ORDER BY store_name) validate;

	# Total sales over 4 years by geographical area

	SELECT neighborhood, ROUND(SUM(unit_price * quantity),2) AS total_sales
	FROM supermarket_sales ss
	JOIN supermarket_inventory si
		ON ss.product_id = si.product_id
	GROUP BY neighborhood
	ORDER BY total_sales DESC;

	# Top ten products sold and value over the entire period

	SELECT product_name, ROUND(SUM(unit_price * quantity),2) AS total_sales
	FROM supermarket_products sp
	JOIN supermarket_sales ss
		ON sp.product_id = ss.product_id
	GROUP BY product_name
	ORDER BY total_sales DESC
	LIMIT 10;
    
END $$

DELIMITER ;
