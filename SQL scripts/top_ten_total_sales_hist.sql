
# TOP 10 records in actual sales over the last 4 years; Grouped by store and year

	SELECT store_name, ROUND(SUM(unit_price * quantity),2) AS total_sales, YEAR(date) AS year
	FROM supermarket_sales ss
	JOIN supermarket_inventory si
		ON ss.product_id = si.product_id
	GROUP BY store_name, year
	ORDER BY total_sales DESC, store_name, year
	LIMIT 10;
