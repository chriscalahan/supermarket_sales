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
