# Top ten products sold and value over the entire period

	SELECT product_name, ROUND(SUM(unit_price * quantity),2) AS total_sales
	FROM supermarket_products sp
	JOIN supermarket_sales ss
		ON sp.product_id = ss.product_id
	GROUP BY product_name
	ORDER BY total_sales DESC
	LIMIT 10;
