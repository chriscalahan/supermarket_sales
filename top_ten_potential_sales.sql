# TOP 10 stores in potential sales based on inventory

	WITH potent_sales(store_name, potential_sales) AS
	(
		SELECT store_name,
		ROUND(SUM(quantity_available * unit_price),2) AS potential_sales
		FROM walmart_inventory wi
		JOIN walmart_sales ws
			ON wi.product_id = ws.product_id
		JOIN walmart_products wp
			ON ws.product_id = wp.product_id
		GROUP BY store_name
		ORDER BY potential_sales DESC
		LIMIT 10
	)
	SELECT store_name,
	potential_sales,
	ROUND((potential_sales / (SELECT SUM(potential_sales) FROM potent_sales) * 100),2) AS percent
	FROM potent_sales;