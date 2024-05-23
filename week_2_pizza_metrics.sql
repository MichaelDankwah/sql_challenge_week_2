-- A. Pizza Metrics

-- 1. How many pizzas were ordered?

-- Set search path to pizza_runner schema
USE pizza_runner;

-- Remove duplicate entries from customer_orders
CREATE TEMPORARY TABLE unique_customer_orders AS
SELECT DISTINCT * FROM customer_orders;

-- Count total number of pizzas ordered
SELECT COUNT(*) AS total_pizzas_ordered
FROM unique_customer_orders;


-- 2. How many unique customer orders were made?

SELECT COUNT(DISTINCT order_id) AS unique_customer_orders
FROM customer_orders;


-- 3. How many successful orders were delivered by each runner?

SELECT runner_id, COUNT(*) AS successful_orders
FROM runner_orders
WHERE cancellation IS NULL OR cancellation = ''
GROUP BY runner_id;


-- How many of each type of pizza was delivered?

SELECT co.pizza_id, pn.pizza_name, 
COUNT(*) AS pizzas_delivered
FROM customer_orders co
JOIN runner_orders ro 
ON co.order_id = ro.order_id
JOIN pizza_names pn 
ON co.pizza_id = pn.pizza_id
WHERE ro.cancellation IS NULL OR ro.cancellation = ''
GROUP BY co.pizza_id, pn.pizza_name
ORDER BY pizzas_delivered DESC;


-- How many Vegetarian and Meatlovers were ordered by each customer?

SELECT co.customer_id, pn.pizza_name, COUNT(*) AS pizzas_ordered
FROM customer_orders co
JOIN pizza_names pn ON co.pizza_id = pn.pizza_id
WHERE pn.pizza_name IN ('Vegetarian', 'Meatlovers')
GROUP BY co.customer_id, pn.pizza_name
ORDER BY co.customer_id, pn.pizza_name;


-- What was the maximum number of pizzas delivered in a single order?

USE pizza_runner;

SELECT MAX(pizza_count) AS max_pizzas_delivered
FROM (
    SELECT co.order_id, COUNT(co.pizza_id) AS pizza_count
    FROM customer_orders co
    JOIN runner_orders ro ON co.order_id = ro.order_id
    WHERE ro.cancellation IS NULL OR ro.cancellation = ''
    GROUP BY co.order_id
) AS order_pizza_counts;


-- For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

USE pizza_runner;

SELECT
    co.customer_id,
    SUM(CASE WHEN (co.exclusions IS NOT NULL AND co.exclusions <> '') 
    OR (co.extras IS NOT NULL AND co.extras <> '') 
    THEN 1 ELSE 0 END) AS pizzas_with_changes,
    SUM(CASE WHEN (co.exclusions IS NULL OR co.exclusions = '') 
    AND (co.extras IS NULL OR co.extras = '') 
    THEN 1 ELSE 0 END) AS pizzas_without_changes
FROM
    customer_orders co
JOIN
    runner_orders ro ON co.order_id = ro.order_id
WHERE
    ro.cancellation IS NULL OR ro.cancellation = ''
GROUP BY
    co.customer_id
ORDER BY
    co.customer_id;


-- How many pizzas were delivered that had both exclusions and extras?

SELECT COUNT(*) AS pizzas_with_exclusions_and_extras
FROM customer_orders co
JOIN runner_orders ro ON co.order_id = ro.order_id
WHERE (co.exclusions IS NOT NULL AND co.exclusions <> '')
  AND (co.extras IS NOT NULL AND co.extras <> '')
  AND (ro.cancellation IS NULL OR ro.cancellation = '');


-- What was the total volume of pizzas ordered for each hour of the day?

SELECT HOUR(order_time) AS order_hour, 
COUNT(*) AS total_pizzas_ordered
FROM customer_orders
GROUP BY HOUR(order_time)
ORDER BY order_hour;


-- What was the volume of orders for each day of the week?

SELECT
    DAYNAME(order_time) AS order_day,
    COUNT(*) AS total_orders
FROM
    customer_orders
GROUP BY
    DAYOFWEEK(order_time),
    order_day
ORDER BY
    DAYOFWEEK(order_time);
