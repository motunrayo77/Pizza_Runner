SELECT * FROM pizza_runner.customer_orders;

SELECT * FROM pizza_runner.pizza_names;

SELECT * FROM pizza_runner.pizza_recipes;

SELECT * FROM pizza_runner.pizza_toppings;

SELECT * FROM pizza_runner.runner_orders;

SELECT * FROM pizza_runner.runners;




Q--1 How many pizzas were ordered?

SELECT 
	COUNT (*) as pizza_ordered
FROM 
	pizza_runner.customer_orders c;

Q--2  How many unique customer orders were made?

SELECT 
	COUNT(DISTINCT order_id) as unique_orders
FROM 
	pizza_runner.customer_orders c;

Q--3 How many successful orders were delivered by each runner?

SELECT 
	runner_id, 
	COUNT(*) as amt_successful_delivery
FROM 
	pizza_runner.runner_orders
WHERE 
	cancellation ISNULL
GROUP BY 
	runner_id;

Q4--How many of each type of pizza was delivered?

SELECT 
	pizza_id,
	count (*) as no_delivered
FROM 
	pizza_runner.customer_orders c
JOIN 
	pizza_runner.runner_orders r
ON c.order_id = r.order_id
WHERE 
	cancellation ISNULL
GROUP BY
	pizza_id;

Q5--How many Vegetarian and Meatlovers were ordered by each customer?

SELECT 
	customer_id,
	COUNT(CASE WHEN pizza_name = 'Meatlovers' THEN pizza_name END ) as Meatlovers, 
	COUNT(CASE WHEN pizza_name = 'Vegetarian' THEN pizza_name END ) as Vegetarian
FROM 
	pizza_runner.customer_orders c
JOIN pizza_runner.pizza_names p
ON c.pizza_id = p.pizza_id
group by
	customer_id 
order by 
	customer_id;

Q6--What was the maximum number of pizzas delivered in a single order?
SELECT  
	MAX(total_pizza_ordered) as Max_
FROM(
	SELECT
	c.order_id,
	COUNT(pizza_id) as total_pizza_ordered
FROM 
	pizza_runner.customer_orders c
JOIN  pizza_runner.runner_orders r
ON c.order_id = r.order_id
WHERE r.cancellation ISNULL
GROUP BY
	c.order_id
ORDER BY
	c.order_id);


Q7--For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

SELECT
	customer_id, 
	count(cancellation) as Changes
FROM
	pizza_runner.customer_orders c
JOIN  pizza_runner.runner_orders r
ON c.order_id = r.order_id
WHERE 
	r.cancellation IS NOT NULL
GROUP BY 
	customer_id
ORDER BY 
	customer_id, Changes;

Q--8 How many pizzas were delivered that had both exclusions and extras?

SELECT 
	COUNT(pizza_id) AS no_pizza
FROM 
	pizza_runner.customer_orders c
JOIN 
	pizza_runner.runner_orders r
ON c.order_id = r.order_id
WHERE 
	exclusions  IS NOT NULL AND extras IS NOT NULL;


Q--9 What was the total volume of pizzas ordered for each hour of the day?

SELECT  
	EXTRACT(HOUR FROM order_time) AS hour_of_the_day,
	COUNT(pizza_id) AS volume_pizza
FROM 
	pizza_runner.customer_orders
GROUP BY 
	hour_of_the_day
ORDER BY
	hour_of_the_day;

Q--10 What was the volume of orders for each day of the week?
SELECT 
	EXTRACT(DAY FROM order_time) AS day_of_the_week, 
	TO_CHAR(order_time, 'Day' ) AS day_name,
	COUNT(pizza_id) AS volume_pizza
FROM pizza_runner.customer_orders
GROUP BY
	day_of_the_week, order_time
ORDER BY
	day_of_the_week;










