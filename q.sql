select o.order_name, o.created_at, c.name, cc.company_name from orders o inner JOIN customers c ON (o.customer_id = c.login) inner join customer_companies cc on (cc.company_id = c.company_id);

--also summig the total amout of the order
select o.id,o.order_name, o.created_at, c.name, cc.company_name, (select sum(oi.quantity*oi.price_per_unit) as total_sum from order_items oi where oi.order_id = o.id) from orders o inner JOIN customers c ON (o.customer_id = c.login) inner join customer_companies cc on (cc.company_id = c.company_id) order by o.id;


-- new way, sme thing, total amount is coming from oi, need to fetch deliver qunaityt
SELECT o.id,
       customers.name,
       sum(oi.quantity*oi.price_per_unit),
       
--        sum( products.sku )
FROM orders o 
LEFT JOIN customers 
ON o.customer_id = customers.login
LEFT JOIN order_items oi
ON oi.order_id = o.id
-- LEFT JOIN  products
-- ON products.id = line_items.product_id
GROUP BY o.id,customers.name


-- qunaity is coming from deliveries, amount not coming

-- new way, sme thing, total amount is coming from oi, need to fetch deliver qunaityt
SELECT o.id,
       customers.name,
       sum(oi.quantity*oi.price_per_unit),
       sum(d.delivered_quantity)

FROM orders o 
LEFT JOIN customers 
ON o.customer_id = customers.login
LEFT JOIN order_items oi
ON oi.order_id = o.id
Left join deliveries d 
on d.order_item_id  = oi.id
GROUP BY o.id,customers.name
order by o.id


-- all done

SELECT o.id,
       customers.name,
       o.order_name,
       sum(oi.quantity*oi.price_per_unit) as total_amount,

       (select sum(d.delivered_quantity*oi2.price_per_unit) from deliveries d join order_items oi2 on d.order_item_id = oi2.id where oi2.order_id = o.id) as delivered_amount

FROM orders o 
LEFT JOIN customers 
ON o.customer_id = customers.login
LEFT JOIN order_items oi
ON oi.order_id = o.id
Left join deliveries d 
on d.order_item_id  = oi.id
where o.order_name like '%%'
GROUP BY o.id,customers.name
order by o.order_name
-- limit 5 offset 1
