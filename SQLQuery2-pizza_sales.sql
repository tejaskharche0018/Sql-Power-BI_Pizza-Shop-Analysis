

create database pizza_sales

---import data---

use pizza_sales

---KPIS---

1)---Total Revenue---

select round(sum(quantity * price),2) as [total revenue] 
from order_details as od
join pizzas as pz
on od.pizza_id = pz.pizza_id 

2)---Average Order value---

select round(sum(quantity * price)/count(distinct order_id),2) as [Average Order]
from order_details as od 
join pizzas as pz
on od.pizza_id = pz.pizza_id;

3)---Total PIzza Sold---

select sum(quantity) as [Total Sold]
from order_details;

4)---Total Orders---

select count(distinct order_id) as [Total Order]
from order_details;

5)---Average Pizza Per Order---

select sum(quantity)/count(distinct order_id) as [Avg Pizza Per Orders] 
from order_details;

---Question Answers---

6)---Daily Trends For Total Orers---

select format( date, 'dddd') as [Day Of Week] 
,count(distinct order_id) as [Total_Orders]
from orders
group by format(date, 'dddd')
order by Total_Orders desc;

7)---hourly Trends For Total Orers---

select datepart(hour, time) as [Hour]
,count(distinct order_id) as [Totl_Orders]
from orders
group by datepart(hour, time)
order by [Hour];

8)---Percentage of Sales Pizza by Cetegory---

select category,sum(quantity * price) as Revenue,
round(sum(quantity * price)*100/(select sum(quantity * price)
from pizzas pz
join order_details  od on pz.pizza_id = od.pizza_id
),2) as percentage_sales
from pizzas pz 
join pizza_types pt on pz.pizza_type_id = pt.pizza_type_id
join order_details od on od.pizza_id = pz.pizza_id
group by category;

9)---percentage of sales by pizza size---

select size,sum(quantity * price) revenue,
round(sum(quantity * price)*100/(select sum(quantity * price) 
from pizzas pz
join order_details od on pz.pizza_id = od.pizza_id
),2) as percentage_sales
from pizzas pz
join pizza_types pt on pz.pizza_type_id = pt.pizza_type_id
join order_details od on od.pizza_id= pz.pizza_id
group by size;

10)---Total pizza sold by cetegory---

select category,round(sum(quantity),2) pizza_sold
from pizzas pz
join pizza_types pt on pz.pizza_type_id = pt.pizza_type_id
join order_details od on od.pizza_id = pz.pizza_id
group  by category
order by sum(quantity) desc;

11)---top 5 best seller by total pizza sold---

select top 5 name,round(sum(quantity),2) as total_sale
from pizzas pz
join pizza_types pt on pt.pizza_type_id = pz.pizza_type_id
join order_details od on od.pizza_id = pz.pizza_id
group by name
order by total_sale desc;

12)---bottom 5 wrost seller by total pizza sold---

select top 5 name,sum(quantity) total_pizza_sold
from pizzas pz
join pizza_types pt on pt.pizza_type_id = pz.pizza_type_id
join order_details od on od.pizza_id = pz.pizza_id
group by name
order by total_pizza_sold asc;






