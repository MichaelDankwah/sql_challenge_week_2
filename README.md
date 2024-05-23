# Pizza Runner Project

## Overview
The Pizza Runner project is a simulated case study that explores the operations of a fictional pizza delivery service called Pizza Runner. The project involves data modeling, SQL query writing, and data analysis to optimize operations and improve customer experience.

## Concepts Explored
- **Entity-Relationship Modeling**: Designing the database schema using entity-relationship diagrams to represent relationships between entities such as runners, customers, orders, and pizzas.

- **Data Cleaning and Transformation**: Preprocessing and transforming raw data to ensure consistency and accuracy, such as handling missing values, standardizing data formats, and removing duplicates.

- **SQL Queries**: Writing SQL queries to retrieve, filter, aggregate, and analyze data from multiple tables, including basic operations like SELECT, INSERT, UPDATE, and DELETE, as well as more advanced queries involving joins, subqueries, and aggregate functions.

- **Data Analysis**: Analyzing the dataset to gain insights into various aspects of Pizza Runner's operations, such as order volume, delivery performance, customer preferences, and revenue generation.

## Dataset Used
The dataset used in this project consists of multiple tables representing different entities and relationships within the Pizza Runner ecosystem. Key tables include:
- `runners`: Information about the delivery runners, including their IDs and registration dates.
- `customer_orders`: Details of customer orders, including order IDs, customer IDs, pizza IDs, order times, and additional specifications like exclusions and extras.
- `runner_orders`: Records of order deliveries by runners, including order IDs, runner IDs, pickup times, distances traveled, and delivery durations.
- `pizza_names`, `pizza_recipes`, `pizza_toppings`: Tables containing information about pizza names, recipes, and toppings.

## Lessons Learned

### SQL Techniques Explored
- **Joins**: Understanding and utilizing different types of joins (e.g., INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN) to combine data from multiple tables based on related columns.
- **Subqueries**: Using subqueries to nest one SELECT statement within another, allowing for more complex and dynamic data retrieval.
- **Aggregation**: Employing aggregate functions (e.g., SUM, COUNT, AVG, MAX, MIN) to perform calculations on groups of rows and generate summary statistics.
- **Conditional Logic**: Implementing conditional logic (e.g., CASE statements, IF-ELSE conditions) within SQL queries to handle different scenarios and derive calculated fields.
- **Data Manipulation**: Performing various data manipulation tasks, such as filtering rows with WHERE clauses, sorting results with ORDER BY, and limiting the number of rows with LIMIT.
- **Data Cleaning**: Applying SQL functions (e.g., REPLACE, COALESCE) to clean and transform data, handle null values, and standardize data formats.
- **Window Functions**: Utilizing window functions (e.g., ROW_NUMBER, RANK, LEAD, LAG) to perform calculations over a set of rows related to the current row.
- **Grouping and Aggregation**: Grouping data using GROUP BY clauses and aggregating grouped data with aggregate functions to generate summary reports.
- **Performance Optimization**: Optimizing SQL queries for performance by indexing columns, avoiding unnecessary joins or subqueries, and using appropriate WHERE clauses to filter data efficiently.
- **Data Analysis and Reporting**: Leveraging SQL queries to analyze data, generate insights, and produce reports that support decision-making and business intelligence.

## Conclusion
The Pizza Runner project provided a valuable learning experience in database management, SQL query writing, and data analysis. By exploring various SQL techniques and applying them to real-world scenarios, I gained insights into effective database design, data manipulation, and analytical skills. This project highlighted the importance of continuous learning, practice, and community engagement in mastering SQL proficiency and driving business value through data-driven decision-making. I look forward to applying these skills in future projects and furthering my journey in data management and analysis.


