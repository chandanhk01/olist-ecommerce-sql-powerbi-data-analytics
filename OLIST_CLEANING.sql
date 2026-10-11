--------1) CUSTOMERS: NO NULLS , NO DUPLICATES, CLEANED

select * from customers;

--HANDLING DUPLICATES
with cte as (
select *,row_number() over(partition by customer_id,customer_unique_id ,
customer_zip_code_prefix,customer_city,customer_state order by customer_id
) as rn from customers)
select * from cte
where rn>2

--ANALYSING DATA TYPES AND FORMATES
select column_name,data_type from INFORMATION_SCHEMA.columns
where TABLE_NAME='customers'

-----2)  REVIEWS NO DUPLICATES , CLEANED
select * from reviews;

with cte as (
select *,ROW_NUMBER() over(partition by review_id,order_id,review_score,review_comment_title,
review_comment_message,review_creation_date,review_answer_timestamp order by review_id
) as rn from reviews
)
select * from cte
where rn >1

update reviews
set review_comment_title='NO'
where review_comment_title is null

update reviews
set review_comment_message='NO'
where review_comment_message is null

select column_name,data_type from INFORMATION_SCHEMA.columns
where TABLE_NAME='reviews'

alter table reviews
alter column review_creation_date date

alter table reviews
alter column review_answer_timestamp date


-------3)  ORDERS NO DUPLICATES, CLEANED
select * from orders;

--NULL : order_approved_at,order_delivered_carrier_date,order_delivered_customer_date

with cte as(
select *,ROW_NUMBER() over(partition by order_id,customer_id,order_status,order_purchase_timestamp,
order_approved_at,order_delivered_carrier_date,order_delivered_customer_date,
order_estimated_delivery_date order by order_id
) as rn from orders
)
select * from cte
where rn>1

select column_name,data_type from INFORMATION_SCHEMA.columns
where TABLE_NAME='orders'

alter table orders
alter column order_purchase_timestamp date

alter table orders
alter column order_approved_at date

alter table orders
alter column order_delivered_carrier_date date

alter table orders
alter column order_delivered_customer_date date

alter table orders
alter column order_estimated_delivery_date date


-----4)  LOACTION: NO NULLS , CLEANED

select * from locations;

with cte as (
select *,ROW_NUMBER() over(partition by geolocation_zip_code_prefix,geolocation_lat,
geolocation_lng,geolocation_city,geolocation_state order by geolocation_lat
) as rn from locations
)
delete from cte
where rn>1

select column_name,data_type from INFORMATION_SCHEMA.columns
where TABLE_NAME='locations'


----5) PRODUCTS , NO DUPLIACTES ,CLEANED

--NULLS : product_category_name,product_name_lenght,product_description_lenght,product_photos_qty,
--product_weight_g,product_length_cm,product_height_cm,product_width_cm

--FILLING NULLS :

--product_category_name
update products 
set product_category_name='Unknown'
where product_category_name is null

--product_name_lenght
update products 
set product_category_name=len('Unknown')
where product_name_lenght is null

--product_description_lenght
--keep it null

--product_length null: 7=25 bebes =35
select distinct product_category_name,
PERCENTILE_CONT(0.5) within group(order by product_length_cm) over(partition by product_category_name)
as median
from products
where product_length_cm is not null

update products 
set product_length_cm=25
where product_category_name ='7' and product_length_cm is null

---product_photos_qty
update products 
set product_photos_qty=0
where product_photos_qty is null

---product_height_cm null: 7=12 , bebes=16
select distinct product_category_name,
PERCENTILE_CONT(0.5) within group(order by product_height_cm) over(partition by product_category_name)
as median
from products
where product_height_cm is not null

update products 
set product_height_cm=12
where product_category_name ='7' and product_height_cm is null

update products 
set product_height_cm=16
where product_category_name ='bebes' and product_height_cm is null

--product_width_cm null : 7=20 , bebes= 25
select distinct product_category_name,
PERCENTILE_CONT(0.5) within group(order by product_width_cm) over(partition by product_category_name)
as median
from products
where product_width_cm is not null

update products 
set product_width_cm=20
where product_category_name ='7' and product_width_cm is null

update products 
set product_width_cm=25
where product_category_name ='bebes' and product_width_cm is null

--product_weight_g nu;; 7=700 , bebes=850
select distinct product_category_name,
PERCENTILE_CONT(0.5) within group(order by product_weight_g) over(partition by product_category_name)
as median
from products
where product_weight_g is not null

update products 
set product_weight_g=700
where product_category_name ='7' and product_weight_g is null

update products 
set product_weight_g=850
where product_category_name ='bebes' and product_weight_g is null


--NO DUPLICATES 
with cte as (
select *,ROW_NUMBER() over(partition by product_id,product_category_name,product_name_lenght,
product_description_lenght,product_photos_qty,product_weight_g,product_length_cm,product_height_cm,
product_width_cm order by product_id
) as rn from products
)
select * from cte
where rn>1

select * from products 
where product_name_lenght is null

select column_name,data_type from INFORMATION_SCHEMA.columns
where TABLE_NAME='products'

---- 6) SELLER TABLE:  NO DUPLICATES, NO NULL VALUES

select * from sellers;

with cte as (
select *,ROW_NUMBER() over(partition by seller_id,seller_zip_code_prefix,seller_city,seller_state 
order by seller_id
)as rn from sellers
)
select * from cte
where rn>1

select column_name,data_type from INFORMATION_SCHEMA.columns
where TABLE_NAME='sellers';


--- 7)  PAYMENTS: NO DUPLIACTES, NO NULL VALUES,CLEANED

with cte as (
select *,ROW_NUMBER() over(partition by order_id,payment_sequential,payment_type,payment_installments,
payment_value order by order_id) as rn from payments
)
select*from cte
where rn>1

select * from payments

select column_name,data_type from INFORMATION_SCHEMA.columns
where TABLE_NAME='payments';

--REPLACING NOT DEFINED PAYMENT WITH CASH :
update payments
set payment_type='Cash'
where payment_type='not_defined'

---- 8) ORDER_ITEMS : NO DUPLICATES, NO NULL VALUES, CLEANED
select * from order_items;

with cte as (
select *,ROW_NUMBER() over(partition by order_id,order_item_id,product_id,
seller_id,shipping_limit_date,price,freight_value order by order_id
)  as rn from order_items
)select * from cte where rn>1

select * from order_items
where freight_value is null

select column_name,data_type from INFORMATION_SCHEMA.columns
where TABLE_NAME='order_items';

alter table order_items
alter column shipping_limit_date date

