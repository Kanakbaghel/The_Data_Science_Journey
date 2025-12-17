Select * from demo.emp_info;
Select * from demo.emp_sal_desig;

-- Inner Joins : 

Select *
from demo.emp_info as T1 # Alias for the table
inner join
demo.emp_sal_desig as T2 # Alias for the table
# on demo.emp_info.emp_id = demo.emp_sal_desig.emp_id
On T1.emp_id = T2.emp_id;

# when the fields names are identical in the two tables
Select *
from demo.emp_info as T1 # Alias for the table
inner join
demo.emp_sal_desig as T2 # Alias for the table
using (emp_id);

# Alternate Syntax :

SELECT * 
FROM 
	demo.emp_info AS T1 , 
    demo.emp_sal_desig AS T2
WHERE
	t1.emp_id = T2.emp_id;
    



SELECT * 
FROM 
	demo.emp_info AS T1 
		LEFT JOIN
    demo.emp_sal_desig AS T2 
ON t1.emp_id = T2.emp_id;
    
SELECT 
	T1.*, # get all columns from T1 --> demo.emp_info
	T2.salary , T2.design # get the salary and desig column from T2
FROM 
	demo.emp_info AS T1 
		LEFT JOIN
    demo.emp_sal_desig AS T2 
ON t1.emp_id = T2.emp_id;

# Right Joins

SELECT 
	T1.*, # get all columns from T1 --> demo.emp_info
	T2.* # get all columns from T2 --> demo.emp_sal_desig
FROM 
	demo.emp_info AS T1 
		RIGHT JOIN
    demo.emp_sal_desig AS T2 
ON t1.emp_id = T2.emp_id;

# All rows from T2 and relevant information from T1


# Left join and Right Join are complementary to each other
SELECT 
	T2.*,T1.*
FROM 
	demo.emp_info AS T1 
		RIGHT JOIN
    demo.emp_sal_desig AS T2 
ON t1.emp_id = T2.emp_id;

SELECT 
	*
FROM 
	demo.emp_sal_desig AS T1
		LEFT JOIN
	demo.emp_info AS T2
ON  t1.emp_id = T2.emp_id;

# Self Joins : Joins to itself

SELECT * FROM demo.emp_info_2;

SELECT t1.* , t2.emp_name AS manager
FROM demo.emp_info_2 AS T1
LEFT JOIN
demo.emp_info_2 AS T2
ON t1.reportsto = t2.emp_id;

# Cross Joins

-- NO need of a common column
-- All possible combinations

SELECT * FROM demo.Food;
SELECT * FROM demo.Beverages;

# Combo Meal
SELECT 
	t1.item_name as food_item,
    t2.item_name as bev_item,
    t1.item_cost as food_cost,
    t2.item_cost as bev_cost,
    round(t1.item_cost + t2.item_cost, 2) as total_cost,
    round((t1.item_cost + t2.item_cost) * 0.9 , 2 )AS disc_cost
FROM
	demo.food as t1
		CROSS JOIN
	demo.beverages AS t2;
    

SELECT * FROM demo.emp_info AS T1 
LEFT JOIN 
demo.emp_sal_desig AS T2
ON T1.emp_id = T2.emp_id

UNION

SELECT * FROM demo.emp_info AS T1 
RIGHT JOIN 
demo.emp_sal_desig AS T2
ON T1.emp_id = T2.emp_id;

# Full Outer join in MySQL

SELECT t1.emp_id, t1.emp_name, t1.exp, t1.skills, t2.salary, t2.design 
FROM demo.emp_info AS T1 
LEFT JOIN 
demo.emp_sal_desig AS T2
ON T1.emp_id = T2.emp_id
UNION
SELECT t1.emp_id, t1.emp_name, t1.exp, t1.skills, t2.salary, t2.design 
FROM demo.emp_info AS T1 
RIGHT JOIN 
demo.emp_sal_desig AS T2
ON T1.emp_id = T2.emp_id

# union : Append of tables with same number of columns in the same order

/*
Year 1 : 2 Columns date | Sales
Year 2 : 2 Columns date | Sales
Year 3 : 2 Columns date | Sales
*/

/*
1. No of columns should be exactly same in the tables --> Error 
2. Order of the Columns should be same --> SQL does not consider column names or types it simply stacks
*/

SELECT 'A' AS lab1, 'B' AS lab2
UNION
SELECT 'C' AS lab1;
# Error Code: 1222. The used SELECT statements have a different number of columns

SELECT 'A' AS lab1, 'B' AS lab2
UNION
SELECT 1 AS ex1, 2 AS ex2
;

SELECT emp_id , Skills
FROM demo.emp_info
UNION
SELECT item_id, Item_name
FROM demo.Beverages;

# Some Other Examples : if(), case when, colaesce
# Stored Procedures | Stored Function | Triggers |
