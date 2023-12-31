# Total sales over 4 years by geographical area

	SELECT neighborhood, ROUND(SUM(unit_price * quantity),2) AS total_sales
	FROM walmart_sales ws
	JOIN walmart_inventory wi
		ON ws.product_id = wi.product_id
	GROUP BY neighborhood
	ORDER BY total_sales DESC;
