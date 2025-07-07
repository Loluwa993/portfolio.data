-- display some table existing in the DATABASE
SELECT * from customers;
SELECT * from categories;
SELECT * from orderdetails;


-- display selected info from 'categories'
SELECT cat.categoryid, cat.categoryname
FROM categories cat;


-- display selected info from 'customers'
SELECT customerid, customername, contactname
FROM customers;


-- display selected info from 'orderdetails'
SELECT orderid, productid, quantity
FROM orderdetails;