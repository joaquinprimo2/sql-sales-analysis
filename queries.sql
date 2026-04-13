-- Total vendido por país
SELECT c.country, SUM(o.amount) AS total_vendido
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.country;

-- 
Total vendido por país
SELECT c.country, SUM(o.amount) AS total_vendido
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.country;

-- 
Total vendido por categoría
SELECT p.category, SUM(o.amount) AS total_vendido
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.category;


--
 Top 3 clientes que más gastaron
SELECT customer_id, SUM(amount) AS top_clientes
FROM orders
GROUP BY customer_id
ORDER BY top_clientes DESC
LIMIT 3;

-- 
Clientes con al menos 2 pedidos
SELECT customer_id, COUNT(*) AS cantidad_pedidos
FROM orders
GROUP BY customer_id
HAVING COUNT(*) >= 2;

-- 
Pedido más alto de cada cliente
SELECT order_id, customer_id, product_id, amount
FROM (
           SELECT order_id, customer_id, product_id, amount,
                  ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY amount DESC) AS rn
           FROM orders
) t
WHERE rn = 1;

--
 Top 2 pedidos más altos de cada cliente
SELECT order_id, customer_id, product_id, amount
FROM (
            SELECT order_id, customer_id, product_id, amount,
                   ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY amount DESC) AS rn
           FROM orders
) t
WHERE rn <= 2;

--
 Países con gasto total mayor a 1500
SELECT c.country, SUM(amount) AS gasto_total
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.country
HAVING SUM(amount) > 1500;
