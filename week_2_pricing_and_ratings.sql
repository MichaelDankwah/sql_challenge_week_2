-- D. Pricing and Ratings


-- 1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?

SELECT
    CONCAT ('$', SUM(
        CASE
            WHEN pn.pizza_name = 'Meatlovers' THEN 12
            WHEN pn.pizza_name = 'Vegetarian' THEN 10
            ELSE 0
        END
    ))  AS total_revenue
FROM
    customer_orders co
JOIN
    pizza_names pn ON co.pizza_id = pn.pizza_id;

-- 2. What if there was an additional $1 charge for any pizza extras?
     -- Add cheese is $1 extra
     
SELECT
    CONCAT('$', SUM(
        CASE
            WHEN pn.pizza_name = 'Meatlovers' THEN 12 + IF(co.extras <> '', 1, 0)
            WHEN pn.pizza_name = 'Vegetarian' THEN 10 + IF(co.extras <> '', 1, 0)
            ELSE 0
        END
    )) AS total_revenue
FROM
    customer_orders co
JOIN
    pizza_names pn ON co.pizza_id = pn.pizza_id;

-- 3. The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.

CREATE TABLE runner_ratings (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    runner_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    rating_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES customer_orders(order_id),
    FOREIGN KEY (runner_id) REFERENCES runners(runner_id)
);


-- 4. Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
		-- customer_id
		-- order_id
		-- runner_id
		-- rating
		-- order_time
		-- pickup_time
		-- Time between order and pickup
		-- Delivery duration
		-- Average speed
		-- Total number of pizzas

-- 5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?

	-- calculate the total revenue generated from all orders
SELECT CONCAT( '$', SUM(
    CASE
        WHEN pn.pizza_name = 'Meatlovers' THEN 12
        WHEN pn.pizza_name = 'Vegetarian' THEN 10
        ELSE 0
    END
)) AS total_revenue
FROM customer_orders co
JOIN pizza_names pn ON co.pizza_id = pn.pizza_id;

-- calculate total expenses
SELECT CONCAT('$', SUM(REPLACE(RO.distance, 'km', '') * 0.30))
AS total_expenses
FROM runner_orders RO;

-- subtract expenses from revenue
SELECT CONCAT('$', 
    (SELECT 
        (SELECT SUM(
            CASE
                WHEN pn.pizza_name = 'Meatlovers' THEN 12
                WHEN pn.pizza_name = 'Vegetarian' THEN 10
                ELSE 0
            END
        ) FROM customer_orders co
        JOIN pizza_names pn ON co.pizza_id = pn.pizza_id) - 
        (SELECT SUM(REPLACE(RO.distance, 'km', '') * 0.30) AS total_expenses
        FROM runner_orders RO)
    )
) AS money_left_over;








