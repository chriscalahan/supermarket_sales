# Top ten products sold and value over the entire period

SELECT product_name, ROUND(SUM(unit_price * quantity),2) AS total_sales
FROM walmart_products wp
JOIN walmart_sales ws
	ON wp.product_id = ws.product_id
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;
