/*
DIFFICULTY: 	Medium
 CHALLENGE: 	Fill Missing Client Data
	   URL:		https://datalemur.com/questions/fill-missing-product

When you log in to your retailer client's database, you notice that their product catalog data is full of gaps in the category column. Can you write a SQL query that returns the product catalog with the missing data filled in?

Assumptions

Each category is mentioned only once in a category column.
All the products belonging to same category are grouped together.
The first product from a product group will always have a defined category.
Meaning that the first item from each category will not have a missing category value.
products Table:
Column Name	Type
product_id	integer
category	varchar
name	varchar
products Example Input:
product_id	category	name
1	Shoes	Sperry Boat Shoe
2		Adidas Stan Smith
3		Vans Authentic
4	Jeans	Levi 511
5		Wrangler Straight Fit
6	Shirts	Lacoste Classic Polo
7		Nautica Linen Shirt
Example Output:
product_id	category	name
1	Shoes	Sperry Boat Shoe
2	Shoes	Adidas Stan Smith
3	Shoes	Vans Authentic
4	Jeans	Levi 511
5	Jeans	Wrangler Straight Fit
6	Shirts	Lacoste Classic Polo
7	Shirts	Nautica Linen Shirt
Explanation:
Shoes will replace all NULL values below the product Sperry Boat Shoe until Jeans appears. Similarly, Jeans will replace NULLs for the product Wrangler Straight Fit, and so on.


*********************************************************************************
*/

WITH grouped_table AS (
SELECT product_id, category, name,
COUNT(category) OVER(ORDER BY product_id) AS _grp
FROM products
),

fillingCategory AS (
SELECT product_id, category, name, _grp,
first_value(category) OVER (PARTITION BY _grp ORDER BY product_id) AS filled_category
FROM grouped_table
)

SELECT product_id, filled_category AS category, name
FROM fillingCategory;