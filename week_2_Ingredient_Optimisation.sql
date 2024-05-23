-- C. Ingredient Optimisation

-- 1. What was the most commonly added extra?

SELECT
    pt.topping_name AS most_common_extra,
    COUNT(*) AS occurrence_count
FROM
    customer_orders co
JOIN
    pizza_toppings pt ON FIND_IN_SET(pt.topping_id, REPLACE(co.extras, ' ', '')) > 0
WHERE
    co.extras IS NOT NULL
GROUP BY
    pt.topping_name
ORDER BY
    occurrence_count DESC
LIMIT 1;



-- 2. What was the most common exclusion?

SELECT
    pt.topping_name AS most_common_exclusion,
    COUNT(*) AS occurrence_count
FROM
    customer_orders co
JOIN
    pizza_toppings pt ON FIND_IN_SET(pt.topping_id, REPLACE(co.exclusions, ' ', '')) > 0
WHERE
    co.exclusions IS NOT NULL
GROUP BY
    pt.topping_name
ORDER BY
    occurrence_count DESC
LIMIT 1;


-- 3. Generate an order item for each record in the customers_orders table in the format of one of the following:
    -- Meat Lovers
    --  Meat Lovers - Exclude Beef
    --  Meat Lovers - Extra Bacon
    --  Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers

SELECT
    co.order_id,
    CONCAT(
        pn.pizza_name,
        CASE WHEN co.exclusions IS NOT NULL THEN 
            CONCAT(' - Exclude ', GROUP_CONCAT(pt.topping_name SEPARATOR ', '))
        ELSE '' 
        END,
        CASE WHEN co.extras IS NOT NULL THEN 
            CONCAT(' - Extra ', GROUP_CONCAT(pt.topping_name SEPARATOR ', '))
        ELSE '' 
        END
    ) AS order_item
FROM
    customer_orders co
JOIN
    pizza_names pn ON co.pizza_id = pn.pizza_id
LEFT JOIN
    pizza_toppings pt ON FIND_IN_SET(pt.topping_id, REPLACE(co.exclusions, ' ', '')) > 0 OR FIND_IN_SET(pt.topping_id, REPLACE(co.extras, ' ', '')) > 0
GROUP BY
    co.order_id, pn.pizza_name, co.exclusions, co.extras;



-- 4. Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
    --  For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"

SELECT
    CONCAT(
        pn.pizza_name, ': ',
        GROUP_CONCAT(
            CASE
                WHEN pt.topping_name IS NOT NULL THEN
                    CASE
                        WHEN (SELECT COUNT(*) FROM pizza_toppings pt2 WHERE pt2.topping_name = pt.topping_name) > 1 THEN CONCAT('2x', pt.topping_name)
                        ELSE pt.topping_name
                    END
                ELSE ''
            END
            ORDER BY pt.topping_name
            SEPARATOR ', '
        )
    ) AS pizza_ingredients
FROM
    customer_orders co
JOIN
    pizza_names pn ON co.pizza_id = pn.pizza_id
LEFT JOIN
    pizza_recipes pr ON co.pizza_id = pr.pizza_id
LEFT JOIN
    pizza_toppings pt ON FIND_IN_SET(pt.topping_id, REPLACE(co.exclusions, ' ', '')) > 0
GROUP BY
    co.order_id, pn.pizza_name
ORDER BY
    co.order_id;


-- 5. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?

USE pizza_runner;

SELECT
    pt.topping_name AS ingredient,
    COUNT(*) AS total_quantity
FROM
    customer_orders co
JOIN
    pizza_toppings pt ON FIND_IN_SET(pt.topping_id, REPLACE(co.exclusions, ' ', '')) > 0 OR FIND_IN_SET(pt.topping_id, REPLACE(co.extras, ' ', '')) > 0
WHERE
    co.exclusions IS NOT NULL OR co.extras IS NOT NULL
GROUP BY
    pt.topping_name
ORDER BY
    total_quantity DESC;
