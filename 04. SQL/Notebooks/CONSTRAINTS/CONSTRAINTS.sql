# GROUP BY AGGREGATION
# HAVING 
# ORDER BY AND LIMIT

-- CRUD : CREATE READ UPDATE DELETE
USE classicmodels;

-- GET ALL ORDERS MADE ON CHRISTMAS EVE ACROSS ALL YEARS
SELECT ORDERNUMBER, ORDERDATE, CUSTOMERNUMBER
FROM ORDERS
WHERE day(ORDERDATE) = 25 AND month(ORDERDATE) = 12;

# GROUP BY AND HAVING
# TOTAL ORDER VALUE?

SELECT sum(quantityOrdered * priceEach ) AS TotalOrderValue
FROM orderdetails;

-- TOTAL ORDER VALUE FOR EACH ORDER
SELECT * FROM orderdetails;

SELECT ORDERNUMBER, 
sum(quantityOrdered * priceEach) AS OrderValue
FROM ORDERDETAILS
GROUP BY ORDERNUMBER
;

-- GET TOTAL COUNT OF ORDERS PER CUSTOMERS
SELECT CUSTOMERNUMBER, count(DISTINCT ORDERNUMBER) AS Count_of_Orders
FROM ORDERS
GROUP BY CUSTOMERNUMBER;

-- ORDERED BY ORDER NUMBER , HIGHEST AT TOP
SELECT CUSTOMERNUMBER, count(DISTINCT ORDERNUMBER) AS Count_of_Orders
FROM ORDERS
GROUP BY CUSTOMERNUMBER
ORDER BY COUNT_OF_ORDERS DESC;

-- HAVING CLAUSE : FILTERS 
SELECT ORDERNUMBER, 
sum(quantityOrdered * priceEach) AS OrderValue
FROM ORDERDETAILS
GROUP BY ORDERNUMBER
HAVING ORDERVALUE > 50000;

-- ORDER DETAILS AND EVEN CALCULATIONS
SELECT * FROM ORDERDETAILS 
WHERE (priceEach * quantityOrdered) > 1000;

# GROUP BY --> AGGREGATION
SELECT customerNumber, ordernumber, count(orderNumber) AS Count_of_Orders
FROM ORDERS
GROUP BY customerNumber
HAVING Count_of_Orders > 10;

/*
WHEN USING GROUP BY IN SELECT STATEMENT,
ONLY TWO TYPES OF FIELDS  ARE ALLOWED IN THE SELECT CLAUSE :

1. COLUMNS INCLUDED IN THE GROUP BY CLAUSE (i.e., NON AGGREGATED )
2. AGGREGATED COLUMNS (USING FUNCTIONS LIKE COUNT, COUNT, SUM, AVG,ETC )
3. AUTOMATIC AGGREGATION APPLIED TO NON AGGREGATED COLUMNS IN NEWER VERSIONS 
*/

SELECT * FROM ORDERS 
WHERE CUSTOMERNUMBER = 114;

SELECT customerNumber, count(orderNumber) AS Count_of_Orders
FROM ORDERS
GROUP BY customerNumber
HAVING Count_of_Orders > 10;

-- ORDER BY 
SELECT * FROM ORDERS
ORDER BY CUSTOMERNUMBER;

SELECT * , round(quantityOrdered * priceEach, 2) AS OrderValue
FROM ORDERDETAILS
ORDER BY ORDERVALUE DESC;

# TOP THREE ORDERS BY ORDER VALUE
SELECT * , round(quantityOrdered * priceEach, 2) AS OrderValue
FROM ORDERDETAILS
ORDER BY ORDERVALUE DESC
LIMIT 3;

# BOTTOM 3
SELECT * , round(quantityOrdered * priceEach, 2) AS OrderValue
FROM ORDERDETAILS
ORDER BY ORDERVALUE 
LIMIT 3;

SELECT * FROM ORDERDETAILS
ORDER BY PRODUCTCODE;


SELECT * FROM ORDERDETAILS
ORDER BY PRODUCTCODE, quantityOrdered DESC, priceEach DESC;

# SELECT A RANGE OF ROWS
SELECT * , round(quantityOrdered * priceEach, 2) AS OrderValue
FROM ORDERDETAILS
ORDER BY ORDERVALUE 
LIMIT 15 OFFSET 20;


/*---------------------------------------------------------------------------------------------------------*/

-- CREATE OPERATIONS
CREATE SCHEMA DEMO;

/*
CREATE TABLE IF NOT EXISTS <SCHEMA>,<TABLE_NAME>(
VARNAME DATATYPE CONSTRAINTS,
VARNAME DATATYPE CONSTRAINTS,
VARNAME DATATYPE CONSTRAINTS,
VARNAME DATATYPE CONSTRAINTS,
VARNAME DATATYPE CONSTRAINTS,
)
*/

-- NUMERIC : INTEGER , FLOAT , DECIMAL, BOOL
-- STRING : 
/*
1. CHAR --> FIXED SIZE 
2. VARCHAR --> VARIABLE LENGTH UPTO A MAX GIVEN 
3. TEXT --> CONTAINS NAY STRING 
*/
-- DATES :
/*
DATE : CCYY-MM-DD
DATETIME : CCYY-MM-DD-HH-MM-SS
*/
-- CONTRAINTS : RULES FOR FIELDS | COLUMNS
/*
1. UNIQUE : NO DUPLICATES WILL BE ACCEPTED
2. NOT NULL : NO NULL VALUES WILL BE ACCEPTED
3. PRIMARY KEY : UNIQUELY IDENTIFIES THE RECORD (ROWS) | UNIQUE AND NOT NULL
4. FOREIGN KEY : PRIMARY KEY FROM ANOTHER TABLE | 
				 ENSURING THE INTEGRITY OF THE RELATIONSHIP BETWEEN TWO TABLES 
5. DEFAULT : IN THE EVENT OF VALUE NOT BEING ENTERED, THE DEFAULT VALUE WILL BE TAKEN
6. CHECK : BEFORE MAKING ANY ENTRY, VALIDATE THE DATA
 
*/
USE DEMO;

# CREATE A TABLE IN THE SCHEMA DEMO
CREATE TABLE if not exists CustomerDetails(
custID char (4) primary key,
custName varchar(50) not null,
addressline1 varchar(100) not null,
addressline2 varchar(100),
city varchar(50),
state varchar(50),
country varchar(50) default 'Germany',
contact_No varchar(20) not null,
age int check ( age between 18 and 50)

# primary key (custID)
# check ( age betweeen 18 and 50)
);

# upon re-execution : we get a warning and not an error
# INSERT VALUES 
/*
INSERT INTO <TABLE NAME> (FIELD LIST IN THE SAME ORDER AS YOU PLAN TO INPUT TO DATA ) 
VALUES
( input1, input2, input3), # row no 1
( input1, input2, input3), # row no 2
( input1, input2, input3), # row no 3
( input1, input2, input3) # row no 4
;
*/

-- IF INPUTIING THE VALUE FOR ALL COLUMNS THEN FIELD LIST NOT REQUIRED 
INSERT INTO customerdetails
VALUES
('A102', 'Emily Carter', '56 Green Park', 'Block A', 'Munich', 'Bavaria', 'Germany', '+49 1523345678', 38),
('A103', 'Liam Brown', '89 Sector 21', 'Tower C', 'Toronto', 'Ontario', 'Canada', '+1 6478892345', 29),
('A104', 'Sophia Patel', '44 MG Road', 'Wing B', 'Mumbai', 'Maharashtra', 'India', '+91 9876543210', 33),
('A105', 'Michael Smith', '12 Baker Street', 'Suite 5', 'London', 'London', 'United Kingdom', '+44 7700123456', 41),
('A106', 'Ava Johnson', '77 Orchard Lane', 'Building D', 'Sydney', 'NSW', 'Australia', '+61 412345678', 27),
('A107', 'Noah Williams', '201 Sunset Blvd', 'Unit 9', 'Los Angeles', 'California', 'USA', '+1 3105557890', 36);

SELECT * FROM CUSTOMERDETAILS;

INSERT INTO customerdetails (CUSTID, CUSTNAME, ADDRESSLINE1, CITY, country, CONTACT_NO, AGE)
VALUES
('A101','Mark Lee', 'DDA 23', 'Singapore', 'Singapore', '+65 91234567', 32);

SELECT * FROM CUSTOMERDETAILS;

-- PRIMARY KEY CONSTRAINTS : UNIQUE AND NOT NULL
INSERT INTO customerdetails (CUSTID, CUSTNAME, ADDRESSLINE1, CITY, street, country, CONTACT_NO, AGE)
VALUES
('A108','Emily Wang', '88 Queen st ', 'Toronto', 'Ontario', 'Canada', '+65 65214897', 29);

select * FROM CUSTOMERDETAILS;

-- NOT NULL CONSTRAINTS
INSERT INTO customerdetails (CUSTID, CUSTNAME, ADDRESSLINE1, CITY, street, country, CONTACT_NO, AGE)
VALUES
('A109','Nina Patel', NULL , 'Sydney', 'Sunrise Height', 'Australia', '+61 412345678', 25);
# Error Code: 1048. Column 'addressline1' cannot be null

-- DEFAULT CONSTRAINTS
INSERT INTO customerdetails (CUSTID, CUSTNAME, ADDRESSLINE1, CITY, CONTACT_NO, AGE)
VALUES
('A110','Aisha Rahman', '45 Orchard View', 'Singapore', '+65 81234567', 27);

SELECT * FROM CUSTOMERDETAILS;

-- CHECK CONSTRAINTS

INSERT INTO customerdetails (CUSTID, CUSTNAME, ADDRESSLINE1, CITY, street, country, CONTACT_NO, AGE)
VALUES
('A111','Carlos Rivera', '102 Avenida Sur', 'Mexico City', 'Avenida Sur', 'Mexico', '+52 5512345678', 31),
('A112','Nina Patel', '7 Sunrise Heights', 'Sydney', 'Sunrise Heights', 'Australia', '+61 412345678', 25),
('A113','Ritika Malhotra', '22 Rose Avenue', 'Pune', 'Rose Avenue', 'India', '+91 9822012345', 15),
('A114','Jonathan Brooks', '77 Pine Crest', 'Chicago', 'Pine Crest', 'USA', '+1 3125557842', 39),
('A115','Saanvi Iyer', '14 Lotus Enclave', 'Chennai', 'Lotus Enclave', 'India', '+91 9840011122', 24);

# Error Code: 3819. Check constraint 'customerdetails_chk_1' is violated.

USE DEMO;

# CREATE THE ORDER TABLE
CREATE TABLE IF NOT EXISTS ORDERS(
OrderNo int auto_increment primary key,
OrderDate Date not null,
OrderStatus varchar(25),
CustNo char(4),
foreign key (CustNo) references customerdetails (custID)
);

INSERT INTO ORDERS 
values
(100, '2025-05-01', 'Packing', 'A101');

select * from orders;

# Auto increment
INSERT INTO ORDERS (orderdate , orderstatus, custno)
values
('2025-05-01', 'Packing', 'A103');

select * from orders;

# ALTER TABLE :
/*
ADD COLUMNS ,
MODIFY DATATYPES,
ADD OR MODIFY CONSTRAINTS
*/

INSERT INTO ORDERS (ORDERDATE, ORDERSTATUS, CUSTNO)
VALUES
('2025-05-05', 'Cancelled', 'A103');
SELECT * FROM ORDERS;
ALTER TABLE ORDERS
ADD CONSTRAINT ORDERDATECHK1
CHECK (ORDERDATE < '2025-05-05');

# Error Code: 3819. Check constraint 'ORDERDATECHK1' is violated.

-- ALTER TABLE TO ADD AN EMAIL COLUMN 
ALTER TABLE CUSTOMERDETAILS 
ADD Email VARCHAR(255) default 'abc@xyz.com' ;

SELECT * FROM CUSTOMERDETAILS;

# Updation : 
/*
- overall 
- for Specific Values
- Missing Values
*/

-- Default Setting is not allow changes/updates
Update customerdetails
set email = concat(custid, '@abccorp.com');

# Error Code: 1175. You are using safe update mode and you tried to update a table
# without a WHERE that uses a KEY column.
# To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

set sql_safe_updates = 0; # disable the safe mode 

# when need to update all rows:
Update customerdetails
set email = concat(custid, '@abccorp.com');

select * from customerdetails;

# replace missing values
update customerdetails
set addressline2 = "..."
where addressline2 is null ;

select * from customerdetails;

# if Mr. Michael Smith with custid A105 has changed address

update customerdetails
set addressline1 = "52 RG Road",
	addressline2 = "Block C "
where custid = 'A105' and custname = "Michael Smith";

select * from customerdetails; 

# TCL Commands
Delete from customerdetails # without where it'll remove all rows
where custid in ('A106','A107');

Select * from customerdetails;

Update customerdetails
set email = 'abc@xyz.com';

select * from customerdetails;

# want to change, still want an option to revert the changes

# Define  a transaction

start transaction;

# Change 
Update customerdetails
set email = concat(custid,'@xyz.corp');

# check
select * from customerdetails;

# revert the change
rollback;

select * from customerdetails

/*
- Drop : Drops the object : Schema, Table as a whole
# drop table_name if exists;

- Delete : conditional
-- Allows to delete specific rows when used with where clause 
-- without where, it deletes all rows and equivalent to truncate

- Truncate deletes all rows : keeping the table structure

*/

# Views
Use classicmodels;

create view cust_data_aus_view
as
select * from customers
where country = 'Australia';

select * from cust_data_aus_view;

# MODIFY OR UPDATE THESE VALUES
-- UPDATE OPERATION
-- REMOVE ROWS : DELETE AND truncate OPERATION
-- REMOVE TABLE | SCHEMA : DROP OPTION 
-- VIEWS

# JOINS




