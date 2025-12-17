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
	T1.* # get all columns from T1 --> demo.emp_info
	T2.salary , T2.desig # get the salary and desig column from T2
FROM 
	demo.emp_info AS T1 
		LEFT JOIN
    demo.emp_sal_desig AS T2 
ON t1.emp_id = T2.emp_id;

# Right Joins

SELECT 
	T1.* # get all columns from T1 --> demo.emp_info
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
demo.emp_info_2 AS T1
ON t1.reportsto = t1.emp_id;

# Cross Joins
