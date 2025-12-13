# create schema

create schema sql101;

/*
- DATBASE IS A COLLECTION OF TABLES 
- MYSQL --> SCHEMA LIKE A FOLDER WITH MULTIPLE RELATAED TABLES
*/

# make the schema default 
Use sql101;

# simple query to get data

Select * from cars;

# File --> open SQL script --> choose classicmodels.sql


# once opened --> use ctrl + A to select entire script 
# then execute using the first execution sign 
# click on refresh in schema pane and check if classicmodels is there

# shortcut for execution : ctrl(command) + shift + enter (return)

# check what are the tables present in this schema

Show Tables ; # shows all tables in the default schema

# Data Query Languages
/* -- multiline comment 
Select <field list>
From <tables>
Where <conditional filter>
Group By <aggregation>
Having < filter on aggregation>
Order By <sorting>
Limit < no. of rows>;
*/

# --> single line comment
-- single line comment 

# get all columns from a table
Select * From classicmodels.customers;

# default schema is set to classicmodels 
Select * from customers;

Select "Nimisha" as fname;


# all columns from given table
Select * from customers;

# get 1 column

Select customerName from customers;

# for few columns

Select customernumber, customername, country
From customers;


# create alias for column names in the output

Select customernumber AS CustNo, customername AS Name, country
From customers;

# calculated fields

# orderdetails table : qunatity and priceEach --> total sales value 

SELECT 
    orderNumber,
    productCode,
    (quantityOrdered * priceEach) AS total_sales_value
FROM
    orderdetails;

SELECT 
    orderNumber,
    productCode,
    ROUND(quantityOrdered * priceEach, 1) AS total_sales_value
FROM
    orderdetails;

# where clause

-- all customers from Australia

Select * from customers
where country = 'Australia';

/* comparison operator :
= : returns true when the value in the row is same as the given value
<>: returns true when the value in the row is not the same as the given value
<, <= : returns true when the value in the column is less than or equals to = the given value 
>, >= : returns true when the value in the column is greater than or equals to = the given value 
*/

-- all orders where the total sales value > 10000

SELECT 
    orderNumber,
    productCode,
    (quantityOrdered * priceEach) AS total_sales_value
FROM
    orderdetails
WHERE (quantityOrdered * priceEach)  >= 10000;

# dates  

# all orders placed before 1st June 2003
Select * 
From orders
Where orderDate < '2003-06-01';

# date format : 'CCYY-MM-DD'


/* Logical Operators:

And : return true when bith the combining conditions are True 
OR : returns True when either of the condition is True
Not: negates True --> False and vice vers
*/

-- all customers from Australia and France

Select * from customers
where country = 'Australia' OR country = 'France';

-- all products of classic cars (productline) with MSRP > 100

Select * from products 
where productLine = 'Classic Cars' and MSRP > 100;


-- all customers except for US
Select * from customers
where country <> 'USA';

# IN operator : match the value in a column to a list of values

-- Australia France or Spain
Select * from customers
where country = 'Australia' OR country = 'France' OR country = 'Spain';


Select * from customers
where country IN ('Australia', 'France','Spain');

Select * from customers
where country NOT IN ('Australia', 'France','Spain');

Select * from customers
where NOT country IN ('Australia', 'France','Spain');


# Between operator  : for range of values ( Date range or numeric range)

Select * From products
Where MSRP>= 100 and MSRP <= 200;

Select * From products
Where MSRP Between 100 and 200;

Select * From products
Where NOT MSRP Between 100 and 200; # both inclusive 

Select * from orders
where orderdate >= '2003-01-01' and orderdate < '2003-02-15';

Select * from orders
where orderdate between '2003-01-01' and '2003-02-15';

# Like : pattern matching in text 

# need all customers who has gifts in their names
/* 
Wild card matching 

% : matches to zero or more characters 
_ : matches to 1 character 

*/

/*
pick up all employee whose first name start with A
it can be followed by zero or more characters
*/


Select * From employees
Where firstName Like "A%"; 

# four letter names starting with A 
Select * From employees
Where firstName Like "A___"; 


Select * From employees
Where firstName Like "P%";

# i want employee whose name starts with P and has exactly 5 charcaters including P
Select * From employees
Where firstName Like "P____"; 

# 'AA/CCC/3045'

# Like 'AA/___/3045';

# get all customers which have 'gift'in their names

Select * from customers
Where customerName Like '%gift%';

-- Group By Aggregation
-- Having 
-- Order BY and Limit 


# order of writing a sQl query 
/* 
Select 
From 
Where 
Group By 
Having 
order BY 
Limit
*/

/* 
Execution Order

Tables are identified : FROM 
Conditional Filtering : WHERE  | works on source data 
Aggregation of Data	  : Group By 
Aggregation Filters   : Having 
Finalizing the fields in the result : Select 
Order By and Limit
*/















