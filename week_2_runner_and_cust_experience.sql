-- B. Runner and Customer Experience


-- 1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

SELECT 
    DATE_FORMAT(registration_date - INTERVAL (WEEKDAY(registration_date)) DAY, '%Y-%m-%d') AS week_starting,
    COUNT(*) AS runners_signed_up
FROM 
    runners
GROUP BY 
    week_starting
ORDER BY 
    week_starting;


-- 2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

SELECT 
    ro.runner_id,
    AVG(TIMESTAMPDIFF(MINUTE, co.order_time, ro.pickup_time)) AS average_pickup_time_minutes
FROM 
    customer_orders co
JOIN 
    runner_orders ro ON co.order_id = ro.order_id
WHERE 
    ro.pickup_time IS NOT NULL
GROUP BY 
    ro.runner_id
ORDER BY 
    ro.runner_id;



-- 3. What was the average distance travelled for each customer?

SELECT
    co.customer_id,
    AVG(CAST(REPLACE(ro.distance, 'km', '') AS DECIMAL(10, 2))) AS average_distance_traveled
FROM
    customer_orders co
JOIN
    runner_orders ro ON co.order_id = ro.order_id
WHERE
    ro.distance IS NOT NULL
GROUP BY
    co.customer_id
ORDER BY
    co.customer_id;


-- 4. What was the difference between the longest and shortest delivery times for all orders?

USE pizza_runner;

SELECT
    MAX(TIMESTAMPDIFF(MINUTE, co.order_time, ro.pickup_time)) - MIN(TIMESTAMPDIFF(MINUTE, co.order_time, ro.pickup_time)) 
    AS delivery_time_difference
FROM
    customer_orders co
JOIN
    runner_orders ro ON co.order_id = ro.order_id
WHERE
    ro.pickup_time IS NOT NULL;


-- 5. What was the average speed for each runner for each delivery and do you notice any trend for these values?

USE pizza_runner;

SELECT
    ro.runner_id,
    co.order_id,
    -- Calculate average speed if distance and pickup time are not null, and cancellation reason is null
    CASE
        WHEN ro.distance IS NOT NULL AND ro.pickup_time IS NOT NULL AND ro.cancellation IS NULL THEN
            (CAST(REPLACE(ro.distance, 'km', '') AS DECIMAL(10, 2)) / TIMESTAMPDIFF(MINUTE, ro.pickup_time, ro.cancellation)) * 60
        ELSE
            NULL  -- Return null if any condition is not met
    END AS average_speed_kmh
FROM
    runner_orders ro
JOIN
    customer_orders co ON ro.order_id = co.order_id
ORDER BY
    ro.runner_id, co.order_id;


-- 6. What is the successful delivery percentage for each runner?

SELECT
    ro.runner_id,
    COUNT(*) AS total_deliveries,
    SUM(CASE WHEN ro.cancellation IS NULL THEN 1 ELSE 0 END) 
    AS successful_deliveries,
    CONCAT(FORMAT((SUM(CASE WHEN ro.cancellation IS NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2), '%') 
    AS success_percentage
FROM
    runner_orders ro
GROUP BY
    ro.runner_id
ORDER BY
    ro.runner_id;
