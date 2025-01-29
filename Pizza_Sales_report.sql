-- Retrieve the total number of orders placed.
select count(order_id) as total_orders_placed from orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM
    orders_details AS od
        INNER JOIN
    pizzas AS p ON p.pizza_id = od.pizza_id;
    -- 817860.05

-- Identify the highest-priced pizza.
SELECT pizza_types.name , pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc limit 1;
-- The Greek Pizza	35.95

-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size, COUNT(order_details_id) AS order_count
FROM
    pizzas
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY 1
ORDER BY order_count DESC
LIMIT 1;
--- L	18526

-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name,
    SUM(orders_details.quantity) AS total_qty_ordered
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY 1
ORDER BY total_qty_ordered DESC
LIMIT 5;
-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category,
    SUM(orders_details.quantity) AS total_qty_ordered
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY 1
ORDER BY total_qty_ordered DESC;

-- Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time) AS hour_day, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY 1;
Join relevant tables to find the category-wise distribution of pizzas.
select count(pizza_type_id), category
from pizza_types
group by 2;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
select avg(quantity_total) 
from
(
select date(order_date) , sum(quantity) as quantity_total
from orders
left join orders_details
on orders.order_id = orders_details.order_id 
group by 1) as daily_totals;

-- 138.4749


-- Determine the top 3 most ordered pizza types based on revenue.

select pizza_types.name, 
round(sum(orders_details.quantity * pizzas.price),0) as revenue
from pizza_types
inner join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
inner join orders_details on pizzas.pizza_id = orders_details.pizza_id
group by 1
order by revenue desc limit 3;

-- Calculate the percentage contribution of each pizza type to total revenue.
WITH TotalSales AS (
    SELECT ROUND(SUM(orders_details.quantity * pizzas.price), 2) AS total_sales
    FROM orders_details
    JOIN pizzas ON pizzas.pizza_id = orders_details.pizza_id ),
RevenueByCategory AS (
    SELECT pizza_types.category,orders_details.quantity * pizzas.price) AS category_revenue
    FROM pizza_types
    INNER JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
    INNER JOIN orders_details ON pizzas.pizza_id = orders_details.pizza_id
    GROUP BY Pizza_types.category)
SELECT category,ROUND(category_revenue / (SELECT total_sales FROM TotalSales) * 100, 2) AS revenue
FROM RevenueByCategory;
    
-- Analyze the cumulative revenue generated over time.
select order_date ,
round(sum(revenue) over (order by order_date),2) as cum_revenue
from
(SELECT orders.order_date,sum(orders_details.quantity * pizzas.price) as revenue
FROM orders_details
LEFT JOIN orders ON ORDERS.order_id = orders_details.order_id
LEFT JOIN pizzas ON pizzas.pizza_id = orders_details.pizza_id
group by 1) as sales;





































-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
with table1 as (
select pizza_types.category,pizza_types.name,
sum(orders_details.quantity * pizzas.price) as revenue
from pizza_types 
left join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
left join orders_details  on orders_details.pizza_id = pizzas.pizza_id
group by 1,2),
 table2 as (
select category , name,revenue,
rank () over (partition by category  order by revenue desc) as revenue_rnk
from table1)
select *
from table2
where revenue_rnk <= 3
order by category;



