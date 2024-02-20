# Number of products supplied per Supplier with the percentage of total throughout data history (4 years)

    SELECT supplier,
    neighborhood AS delivered_to,
    COUNT(ss.product_id) total_supplied,
    (COUNT(ss.product_id)/(SELECT COUNT(*) FROM supermarket_sales)) * 100 AS percent
    FROM supermarket_products sp
    JOIN supermarket_sales ss
	ON sp.product_id = ss.product_id
    JOIN supermarket_inventory si
	ON ss.product_id = si.product_id
    GROUP BY supplier, neighborhood
    ORDER BY total_supplied DESC;
    
# Check to validate that each store has a single location for the above script

    SELECT DISTINCT * FROM
    (SELECT store_name, neighborhood
    FROM supermarket_inventory
    ORDER BY store_name) validate;
