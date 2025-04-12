-- Quantitative Analysis on the 'tesil' database
select * from clients;

--CLIENTS
	-- No of Clients:
	select count(distinct client_id) as "no of clients" from clients;

	-- No of Clients with Rfx:
	select count(distinct rfx.client_id) as "no of clients",
	count(distinct rfx.client_id) * 100.00 / sum(count(distinct clients.client_id)) over() as "%_of total client"
	from rfx
	full join clients on rfx.client_id = clients.client_id;

	-- Client with high no. of rfx"
	select clients.client_name as client, count(rfx.rfx_id) as "no. of rfx"
	from clients
	left join rfx on clients.client_id = rfx.client_id
	group by clients.client_name
	having count(rfx.rfx_id) >= 5
	order by 2 desc;

	-- No of Clients with Orders:
	select count(distinct orders.client_id) as "no of clients",
	count(distinct orders.client_id) * 100.00 / sum(count(distinct clients.client_id)) over() as "%_of total client"
	from orders
	full join clients on orders.client_id = clients.client_id;

	
--RFX
	-- No fo Rfx:
	select count(distinct rfx_id) as "no of rfx" from rfx;

	-- Total, Average, Minimum, Maximun and Range of Rfx Value:
	select format(sum(rfx_value),'c','ig-NG') as "total rfx value", format(avg(rfx_value),'c','ig-NG') as "average rfx value",
	format(max(rfx_value),'c','ig-NG') as "max rfx value", format(min(rfx_value),'c','ig-NG') as "minimum rfx value",
	format((max(rfx_value) - min(rfx_value)),'c','ig-NG') as "rfx value range"
	from rfx;

	-- Total no. of rfx and rfx value by clients:
	--i. ordered by no of rfx:
	select client_name as client, count(r.client_id) as "No of Rfx", count(r.rfx_id) *100.00 / sum(count(r.rfx_id)) over () as "% of total no. of rfx",
	sum(r.rfx_value) as "total rfx value"
	from clients c
	left join rfx r on c.client_id = r.client_id
	where r.rfx_value > 0
	group by client_name
	order by 2 desc;

	--ii. ordered by rfx value:
	select client_name as client, count(r.client_id) as "No of Rfx",
	sum(r.rfx_value) as "total rfx value", sum(r.rfx_value) *100.00 / sum(sum(r.rfx_value)) over() as "% of overall total rfx value"
	from clients c
	left join rfx r on c.client_id = r.client_id
	where r.rfx_value > 0
	group by client_name
	order by 3 desc;

	

--ORDERS
	-- No of Orders:
	select count(distinct order_id) as "no of orders" from orders;

	-- Total, Average, Minimum, Maximun and Range of Orders Value:
	select format(sum(order_value),'c','ig-NG') as "total order value", format(avg(order_value),'c','ig-NG') as "average order value",
	format(max(order_value),'c','ig-NG') as "max order value", format(min(order_value),'c','ig-NG') as "minimum order value",
	format((max(order_value) - min(order_value)),'c','ig-NG') as "order value range"
	from orders;


	-- Total no. of orders and orders value by clients:
	--i. ordered by no of order:
	select client_name as client, count(o.client_id) as "No of Order", count(o.order_id) *100.00 / sum(count(o.order_id)) over () as "% of total no. of order",
	sum(o.order_value) as "total order value"
	from clients c
	left join orders o on c.client_id = o.client_id
	where o.order_value > 0
	group by client_name
	order by 2 desc;

	--ii. ordered by order value:
	select client_name as client, count(o.client_id) as "No of Order",
	sum(o.order_value) as "total order value", sum(o.order_value) *100.00 / sum(sum(o.order_value)) over() as "% of overall total order value"
	from clients c
	left join orders o on c.client_id = o.client_id
	where o.order_value > 0
	group by client_name
	order by 3 desc;


-- BUSINESS SECTOR:
select * from clients;
select * from rfx;
select * from orders;

--ok
	select distinct count(r.rfx_id) as "no. of rfx", c.business_sector,
	sum(r.rfx_value) as "total rfx value", sum(r.rfx_value)*100.00 / sum(sum(r.rfx_value)) over() as "% of overall rfx total"
	from clients c
	left join rfx r on c.client_id = r.client_id
	group by c.business_sector
	order by 1 desc;

--ok
	select distinct count(o.order_id) as "no of orders", c.business_sector,
	sum(o.order_value) as "total order value", sum(o.order_value) / sum(sum(o.order_value)) over() as "% of overall orders total"
	from clients c
	left join orders o on c.client_id = o.client_id
	group by c.business_sector
	order by 1 desc;

	

create table #clientrfxorders
as

select c.client_name, count(r.rfx_id), count(o.order_id), sum(r.rfx_value), sum(o.order_value)
from clients c
join rfx r on c.client_id = r.client_id
join orders o on c.client_id = o.client_id
group by c.client_name;