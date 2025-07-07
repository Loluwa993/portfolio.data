-- Sales Perfomance Analysis:

-- exploring the 'orders' and others table
select * from orders;

select * from orderdetails;

select * from customers;


-- Sales Summary :
select count(distinct(o.orderid)) as no_of_orders,
count(distinct(o.customerid)) as no_of_customers,
count(distinct(productid)) as no_of_products,
sum(ord.quantity * prod.price) as total_sales_amount,
round(avg(ord.quantity * prod.price),2) as average_sales_amount
from orders as o
join orderdetails as ord on ord.orderid = o.orderid
join products as prod on prod.productid = ord.productid;


-- Sales Amount per 'orderdetails' :
select ord.orderdetailid, ord.orderid, ord.productid,
prod.productname, ord.quantity, prod.price,
(ord.quantity * prod.price) as amount
from orderdetails as ord
join products as prod
on prod.productid = ord.productid;


-- Sales Amount per 'order' :
select o.orderid,
sum(ord.quantity * prod.price) as order_amount
from orders as o
join orderdetails as ord on ord.orderid = o.orderid
join products as prod on prod.productid = ord.productid
group by o.orderid
order by 1 asc;


-- Sales Amount per Year and Month
select
	extract(year from o.orderdate) as sales_year,
	to_char(o.orderdate,'month') as sales_month,
	sum(ord.quantity * prod.price) as total_sale_amount
from orders o
join orderdetails as ord on ord.orderid = o.orderid
join products as prod on prod.productid = ord.productid 
group by 
	sales_year, sales_month, extract(month from o.orderdate)
order by 
	sales_year, extract(month from o.orderdate);


-- Sales Amount per Customer (Top 5 Customer on Sales)
select
	c.customername,
	count(o.orderid) as no_of_orders,
	round(sum(ord.quantity * prod.price),2) as total_sale_amount
from customers c
join orders o on o.customerid = c.customerid
join orderdetails ord on ord.orderid = o.orderid
join products prod on prod.productid = ord.productid
group by
	c.customername
order by
	total_sale_amount desc
limit 10;


-- Sales Amount by Product Categories (Best Selling Category)
select
	cat.categoryname, count(o.orderid) as no_of_orders,
	round(sum(ord.quantity * prod.price),2) as total_sale_amount,
	round(avg(ord.quantity * prod.price),2) as average_sale_amount
from categories cat
join products prod on prod.categoryid = cat.categoryid
join orderdetails ord on ord.productid = prod.productid
join orders o on o.orderid = ord.orderid
group by
	cat.categoryname
order by
	total_sale_amount desc;


-- Sales Amount by Product (Top 10 Selling Products)
select
	productname, count(ord.productid) as no_of_order,
	price,
	sum(ord.quantity) as total_ordered_qty,
	round(sum(ord.quantity * prod.price),2) as total_sale_amount,
	round(avg(ord.quantity * prod.price),2) as average_sale_amount
from products prod
join orderdetails ord on ord.productid = prod.productid
group by
	productname,price
order by
	total_sale_amount desc
limit 10;