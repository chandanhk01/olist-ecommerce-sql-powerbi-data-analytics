
---------------------------OLIST BUSSINEST ANALYTICS ---------------------------------------------------
--Management / Executive Questions
--1) Management wants to understand the overall health of the business. What are the total sales, 
--number of orders, number of customers, and average Revenue?
select count(distinct order_id) as Total_orders from order_items 

select count(distinct customer_id) as Total_customers from customers

select  o.product_id,p.product_category_name 
,sum(o.price) as Total_Revenue from order_items o 
inner join products p 
on o.product_id=p.product_id
group by o.product_id,p.product_category_name

select p.product_category_name 
,avg(o.price) as Average_Revenue from order_items o 
inner join products p 
on o.product_id=p.product_id
group by p.product_category_name


--- 2)  Management wants to know which Brazilian states are contributing the most to company revenue. 
---Which states should the company focus on?

select top 5 s.seller_state as Contributing_states ,sum(o.price) as Total_revenue 
from order_items o inner join sellers s
on o.seller_id=s.seller_id
group by s.seller_state
order by Total_revenue desc

select top 5 s.seller_state as To_be_focused_states ,sum(o.price) as Total_revenue 
from order_items o inner join sellers s
on o.seller_id=s.seller_id
group by s.seller_state
order by Total_revenue asc

--The product team wants to understand which product categories are
--driving the company's revenue and which categories are underperforming.
select top 5 p.product_category_name ,sum(oi.price) as Total_revenue,
count(*) as Number_of_orders_sold,
(avg(oi.price)) as Average_selling_price
from order_items oi inner join 
products p 
on oi.product_id=p.product_id
group by p.product_category_name
order by Total_revenue desc 

select top 5 p.product_category_name ,sum(oi.price) as Total_revenue,
count(*) as Number_of_orders_sold,
(avg(oi.price)) as Average_selling_price
from order_items oi inner join 
products p 
on oi.product_id=p.product_id
group by p.product_category_name
order by Total_revenue asc


--- 5) The customer team wants to understand how customers are purchasing from the platform.
select * from customers;
select * from orders
select * from order_items

--Identify the top 10 customers by total spending
select top 10 c.customer_id,
count( o.order_id) as Number_of_orders,
sum(oi.price) as Total_spend
from customers c inner join orders o
on c.customer_id=o.customer_id
inner join order_items oi
on oi.order_id=o.order_id
where o.order_status='delivered'
group by c.customer_id
having count(o.order_id)>1
order by Total_spend desc

--Total number of unique customers
select count(distinct customer_id) as Total_customers from customers;


--Average number of orders per customer
with cte as(
select c.customer_unique_id as customers,count(o.order_id) as Number_of_orders
from customers c inner join orders o 
on c.customer_id=o.customer_id
group by c.customer_unique_id
)
select customers,avg(Number_of_orders) as Average_order_per_customer from cte
group by customers;

-- 6) The logistics team wants to evaluate how efficiently orders are being delivered.
--Calculate the average delivery time in days
with cte as (
select order_id,DATEDIFF(day,order_purchase_timestamp,order_delivered_customer_date)
as delivery_days
from orders
where order_status='delivered'
)
select avg(delivery_days) as Average_delivery_days_required from cte;

--Find the minimum delivery time
with cte as (
select order_id,DATEDIFF(day,order_purchase_timestamp,order_delivered_customer_date)
as delivery_days
from orders
where order_status='delivered'
)
select 
case
	when min(delivery_days)=0 then 'Same day delivery (0 days)'
end as Minimum_delivery_days_required from cte;

--Find the maximum delivery time
with cte as (
select order_id,DATEDIFF(day,order_purchase_timestamp,order_delivered_customer_date)
as delivery_days
from orders
where order_status='delivered'
)
select max(delivery_days) as Maximum_delivery_days_required from cte;

--Identify the percentage of orders delivered later than the estimated delivery date
with cte as (
select order_id,DATEDIFF(day,order_purchase_timestamp,order_delivered_customer_date)
as delivery_days_required,
DATEDIFF(day,order_purchase_timestamp,order_estimated_delivery_date)
as Estimated_delivery_days
from orders
where order_status='delivered' 
)
select 
sum(case
	when delivery_days_required>Estimated_delivery_days
	then 1
	else 0
end)*100.0/count(*)
as [Late_delivery %] from cte


-- 7) The seller management team wants to
--identify the sellers generating the most business and understand seller performance.

--1.Top 10 sellers by revenue
select top 10 s.seller_id,s.seller_state,
sum(oi.price) as Revenue 
from sellers s inner join order_items oi
on s.seller_id=oi.seller_id
group by s.seller_id,seller_state
order by Revenue desc

--2. Number of orders handled by each seller
select distinct seller_id,count(order_id) as Number_of_orders_handled from order_items
group by seller_id
order by Number_of_orders_handled desc;

--3. Average order-item price for each seller
select seller_id,avg(price) as Average_order_price from order_items
group by seller_id
order by Average_order_price desc

--The payments team wants to understand how customers are paying for their purchases.
--Required Analysis
--For each payment type:
--Number of orders
--Total payment value
--Average payment value
--Percentage of total orders
--Identify the most frequently used payment method.
select * from payments
where payment_type='Cash'

select payment_type,count(order_id) as Number_of_orders,
sum(payment_value) as Total_payment_value,
avg(payment_value) as Average_payment_value,
(count(distinct order_id)*100.000/(select count(distinct order_id) from payments)) 
as Percentage_of_total_orders
from payments
group by payment_type


--- FIND NUMBER OF REVIEWS FOR EACH REVIEW-SCORE
select distinct review_score,count(review_score) as number_of_reviews
from reviews
group by review_score
order by review_score

--FIND AVERAGE REVIEW SCORE FOR EACH PRODUCT CATEGORY
select p.product_category_name,avg(r.review_score) as Average_review
from reviews r inner join order_items oi
on r.order_id=oi.order_id inner join products p
on oi.product_id=p.product_id 
group by p.product_category_name


