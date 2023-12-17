
# TOP 10 records in actual sales over the last 4 years; Grouped by store and year

	SELECT store_name, ROUND(SUM(unit_price * quantity),2) AS total_sales, YEAR(date) AS year
	FROM walmart_sales ws
	JOIN walmart_inventory wi
		ON ws.product_id = wi.product_id
	GROUP BY store_name, year
	ORDER BY total_sales DESC, store_name, year
	LIMIT 10;