# Total sales over 4 years by geographical area

	SELECT neighborhood, ROUND(SUM(unit_price * quantity),2) AS total_sales
	FROM supermarket_sales ss
	JOIN supermarket_inventory si
		ON ss.product_id = si.product_id
	GROUP BY neighborhood
	ORDER BY total_sales DESC;
