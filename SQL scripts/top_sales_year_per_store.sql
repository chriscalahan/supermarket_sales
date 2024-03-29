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
