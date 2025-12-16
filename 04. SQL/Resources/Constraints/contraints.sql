-- Group By Aggregation
-- Having 
-- Order BY and Limit 

-- CRUD :
/* 
C -> Create
R -> Read (Select)
U -> Update
D -> Delete
*/
-- get all orders made on Christmas eve across all years


Select orderNumber,orderDate, customerNumber
From orders
Where Day(orderDate) = 25 AND Month(orderDate) = 12;

# Group By and Having 
# total order value ?

Select sum(quantityOrdered * priceEach) as total_order_value
From orderdetails;

# total order value for each order 

Select * from orderdetails;


Select orderNumber, 
sum(quantityOrdered * priceEach) as order_value
From orderdetails
Group By orderNumber
;

-- get total count of orders per customer

Select customerNumber, count(Distinct orderNumber) as count_of_orders
From orders
Group by customerNumber;


-- ordered by order numbers, highest at top
Select customerNumber, count(Distinct orderNumber) as count_of_orders
From orders
Group by customerNumber
Order By count_of_orders Desc;

-- Having Clause : filter 

Select orderNumber, 
sum(quantityOrdered * priceEach) as order_value
From orderdetails
Group By orderNumber
;

Select orderNumber, 
sum(quantityOrdered * priceEach) as order_value
From orderdetails
Group By orderNumber
Having order_value > 50000
;

# Where vs Having 

-- Where works on source data columns
-- orderdetails and even calculations

Select * from orderdetails
Where (priceEach * quantityOrdered)> 1000;

# group by --> aggregation 

Select customerNumber, ordernumber, count(orderNumber) as count_order
From orders
Group by customerNumber
Having count_order >10;

/* 
When using GROUP BY in a SELECT statement, 
only two types of fields are allowed in the SELECT clause:

1. Columns included in the GROUP BY clause (i.e., non-aggregated group keys)
2. Aggregated columns (using functions like COUNT, SUM, AVG, etc.)
3. Automatic aggregation applied to non aggregated columns in newer versions
*/

Select * from orders
where customerNumber = 114;

Select customerNumber, count(orderNumber) as count_order
From orders
Group by customerNumber
Having count_order >10;

-- order by 

Select * from orders
order by customerNumber;

Select * , round(quantityOrdered* priceEach, 2) as order_value
from orderdetails
order by  order_value desc;



# Top three orders by order value
Select * , round(quantityOrdered* priceEach, 2) as order_value
from orderdetails
order by  order_value desc
Limit 3;


# bottom 3

Select * , round(quantityOrdered* priceEach, 2) as order_value
from orderdetails
order by  order_value 
limit 3;

Select * from orderdetails
order by productCode;

Select * from orderdetails
order by productCode, quantityOrdered desc, priceEach desc;


# select a range of rows


Select * , round(quantityOrdered* priceEach, 2) as order_value
from orderdetails
order by  order_value 
limit 15 offset 20;


/*-----------------------------------------------*/


-- Create operations

Create schema if not exists demo;


/*
Create Table If Not Exists <schema>.<table_name>(
varname datatype constraint,
varname datatype constraint,
varname datatype constraint,
varname datatype constraint,
varname datatype constraint
)
*/
-- Numeric : integer, float, decimal, boolean
/* String : 
1. Char -> fixed size
2. Varchar -> variable length upto a max given 
3. Text -> contain nay string
*/
/* Dates:
Date : CCYY-MM-DD
Datetime: CCYY-MM-DD hh:mm:ss
*/




/* Constraints : Rules for fields | columns

1. Unique : No duplicates
2. Not Null : No Null values will be accepted 
3. Primary Key : uniquely identifies the record (row) | unique and not null
4. Foreign Key : primary key from another table | 
		ensuring the integrity of the relationship between 2 tables
5. Default : In the event of value not being entered, the default value will be taken
6. Check : before making any entry, validate the data
*/

Use demo;

# create a table in the demo

Create table if not exists customers_details(
custID char(4) primary key,
custName varchar(50) not null,
addressline1 varchar(100) not null,
addressline2 varchar(100),
city varchar(50),
state varchar(50),
country varchar(50) Default 'Germany',
contact_no varchar(20) not null,
age int check(age between 18 and 50)

# primary key (custId)
# check(age between 18 and 50)

);

# upon re-execution : we get a warning and nt an error;

# insert Values 

/*
Insert Into <table_name> (feild list in the same order as you plan to input the data )
Values
( input1, input2, input3), # row no 1
( input1, input2, input3), # row no 2
( input1, input2, input3), # row no 3
( input1, input2, input3) # row no 4
;
*/

-- if inputting the value for all columns then field list not required

Insert Into customers_details 
Values
('C001', 'Anna Schmidt', '123 Hauptstrasse', 'Building A', 'Berlin', 'Berlin', 'Germany', '+49-1701234567', 28),
('C002', 'John Patel', '22 MG Road', 'Floor 2', 'Mumbai', 'Maharashtra', 'India', '+91-9820012345', 35),
('C003', 'Elena Rossi', 'Via Roma 45', 'Apt 12', 'Rome', 'Lazio', 'Italy', '+39-3456789012', 30),
('C004', 'David Kim', '88 Gangnam-daero', 'Suite 8', 'Seoul', 'Seoul', 'South Korea', '+82-1023456789', 40),
('C005', 'Lena Garcia', '500 Gran Via', 'Unit 10C', 'Madrid', 'Madrid', 'Spain', '+34-612345678', 25);



Select * from customers_details;


# enter values for only specific columns
Insert Into customers_details(custID, custName, addressline1,city, country, contact_no, age)
Values
('C006', 'Mark Lee', '12 Orchard Road, Blk B', 'Singapore', 'Singapore', '+65-91234567', 32);

Select * from customers_details;

-- primary key constraint : unique and not null

Insert Into customers_details(custID, custName, addressline1,city, state, country, contact_no, age)
Values
('C006', 'Emily Wang', '88 Queen St, Level 3', 'Toronto', 'Ontario', 'Canada', '+1-6471234567', 29 );

# Error Code: 1062. Duplicate entry 'C006' for key 'customers_details.PRIMARY'

Insert Into customers_details(custID, custName, addressline1,city, state, country, contact_no, age)
Values
(Null, 'Emily Wang', '88 Queen St, Level 3', 'Toronto', 'Ontario', 'Canada', '+1-6471234567', 29 );
# Error Code: 1048. Column 'custID' cannot be null


Insert Into customers_details(custID, custName, addressline1,city, state, country, contact_no, age)
Values
('C007', 'Emily Wang', '88 Queen St, Level 3', 'Toronto', 'Ontario', 'Canada', '+1-6471234567', 29 );

Select * from customers_details;

-- Not null constraint

Insert Into customers_details(custID, custName, addressline1, city, state, country, contact_no, age)
Values
('C008', 'Jane Smith', Null, 'Madison', 'WI', 'USA', '555-5678', 28);
# Error Code: 1048. Column 'addressline1' cannot be null

Insert Into customers_details(custID, custName, addressline1, city, state, country, contact_no, age)
Values
('C008', 'Jane Smith', '456 Oak St', Null, 'WI', 'USA', '555-5678', 28);

Select * from customers_details;

-- default constraint 

Insert Into customers_details(custID, custName, addressline1, city, contact_no, age)
Values
('C009', 'Hans Müller', '123 Hauptstrasse', 'Berlin', '030-123456', 40);

Select * from customers_details;


Insert Into customers_details(custID, custName, addressline1, city, country, contact_no, age)
Values
('C010', 'Arun Sharma', '56 MG Road', 'Mumbai' , Null, '022-23456789', 32);

Select * from customers_details;


-- check constraint 

Insert Into customers_details(custID, custName, addressline1, city, state, country, contact_no)
Values
('C011', 'Lena Schmidt', '789 Lindenstrasse', 'Hamburg', 'Hamburg', 'Germany', '040-987654'),
('C012', 'Ravi Patel', '12 Nehru Nagar', 'Ahmedabad', 'Gujarat', 'India', '079-567890'),
('C013', 'Carlos Souza', '456 Rua das Flores', 'São Paulo', 'SP', 'Brazil', '+55-11-98765432'),
('C014', 'Yuki Takahashi', '123 Sakura Street', 'Tokyo', 'Tokyo', 'Japan', '+81-3-12345678');

Select * from customers_details;

Insert Into customers_details(custID, custName, addressline1, city, state, country, contact_no, age)
Values
('C015', 'Sophie Williams', '25 Collins Street', 'Melbourne', 'Victoria', 'Australia', '+61-3-98765432', 33),
('C016', 'Pierre Dupont', '78 Rue de Paris', 'Lyon', 'Auvergne-Rhône-Alpes', 'France', '+33-4-987654', 38),
('C017', 'Thabo Mbeki', '101 Main Road', 'Cape Town', 'Western Cape', 'South Africa', '+27-21-2345678', 15);

Select * from customers_details;


# Error Code: 3819. Check constraint 'customers_details_chk_1' is violated.



# Create order table

Create table if not exists orders(
orderNo int Auto_increment Primary key,
orderDate Date Not Null,
orderStatus varchar(25),
custNo char(4),
Foreign Key (custNo) References customers_details(custID)
);

Insert into orders 
Values
(100, '2025-05-01', 'Packing', 'C014');

Select * from orders;

Insert into orders (orderDate, orderStatus, custNo)
Values
( '2025-05-01', 'Packing', 'C012');

Select * from orders;


Insert into orders (orderDate, orderStatus, custNo)
Values
( '2025-05-02', 'Cancelled', 'C016');

Select * from orders;

/* 
 Error Code: 1452. Cannot add or update a child row: 
a foreign key constraint fails (`demo`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`custNo`) REFERENCES `customers_details` (`custID`))
*/



# Alter Table : 
/*
add columns,
modify datatypes,
add or modify constraints
*/


Insert into orders (orderDate, orderStatus, custNo)
Values
( '2025-05-05', 'Cancelled', 'C011');

Select * from orders;

Alter Table orders
Add Constraint orderDateChk1
Check (orderDate < '2025-05-05');


Select CURRENT_DATE();
# Error Code: 3819. Check constraint 'orderDateChk1' is violated.



-- Alter table to add an email column with a default value 

Alter table customers_details
Add email varchar(255) Default 'abc@xyz.com';

Select * from customers_details;

# Modify or update these values
-- Update operation 
-- Remove Rows : Delete and Truncate oprations
-- Remove table| Schema : Drop option

# Joins 













