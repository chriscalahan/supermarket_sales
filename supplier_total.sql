# Number of products supplied per Supplier with percentage of total over span of data history (4 years)

	SELECT supplier,
    neighborhood AS delivered_to,
	COUNT(ws.product_id) total_supplied,
	(COUNT(ws.product_id)/(SELECT COUNT(*) FROM walmart_sales)) * 100 AS percent
	FROM walmart_products wp
	JOIN walmart_sales ws
		ON wp.product_id = ws.product_id
    JOIN walmart_inventory wi
		ON ws.product_id = wi.product_id
	GROUP BY supplier, neighborhood
	ORDER BY total_supplied DESC;
    
	# Check to validate that each store has a single location for above script

    SELECT DISTINCT * FROM
    (SELECT store_name, neighborhood
    FROM walmart_inventory
    ORDER BY store_name) validate;