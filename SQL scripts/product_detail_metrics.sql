# Product Details - Metrics by product, store, and location

SELECT product_name, supplier, neighborhood, 
SUM(quantity) AS total_quantity, 
ROUND(AVG(unit_price),2) AS avg_price, 
ROUND(SUM(unit_price * quantity),2) AS total_sales
FROM walmart_products sp
JOIN walmart_sales ss
	ON sp.product_id = ss.product_id
JOIN walmart_inventory si
	ON ss.product_id = si.product_id
GROUP BY product_name, supplier, neighborhood
ORDER BY total_sales DESC, total_quantity DESC;

    
