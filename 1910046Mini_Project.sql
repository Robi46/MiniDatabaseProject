
-- A project to design a database for an online grocery shop

create database mini_project1;
use mini_project1;

CREATE TABLE orders (
    row_id int PRIMARY KEY NOT NULL ,
    order_id varchar(10)   NOT NULL ,
    order_date datetime  NOT NULL ,
    item_id varchar(15)   NOT NULL ,
    quantity int  NOT NULL ,
    cust_id int   NOT NULL ,
    delivery boolean  NOT NULL ,
    add_id int   NOT NULL 
);

CREATE TABLE customer (
    cust_id int PRIMARY KEY  NOT NULL ,
    cust_firstname varchar(40)  NOT NULL ,
    cust_lastname varchar(40)  NOT NULL
);

CREATE TABLE address (
    add_id int PRIMARY KEY  NOT NULL ,
    delivery_address varchar(200)  NOT NULL ,
    delivery_city varchar(50)  NOT NULL ,
    delivery_zipcode varchar(30)  NOT NULL
);

CREATE TABLE item (
    item_id varchar(15)  PRIMARY KEY NOT NULL ,
    stock_id varchar(20)  NOT NULL ,
    item_name varchar(40)  NOT NULL ,
    item_type varchar(40)  NOT NULL ,
    item_size varchar(30)  NOT NULL ,
    item_price decimal(5,2)  NOT NULL
    );

CREATE TABLE stock (
    stock_id varchar(30) PRIMARY KEY  NOT NULL ,
    stock_type varchar(30)  NOT NULL ,
    in_stock varchar(30)  NOT NULL
);

Alter Table customer 
Add cust_phone int (11); 









use mini_project1;

insert into orders
values ( '1','201','2003-03-23','3102','7','1001','1','8103'),
( '2','202','2004-04-23','3103','12','1002','1','8104');

insert into address
values('8103','343.fair2','Sylhet','6677'),
('8104','5c3.villa2','Khulna','3787');

Insert into customer 
values( '1001','Hamid','Hasan','02376478276'),
('1002','Mustafa','Rashed', '89457239474');

insert into item 
Values ( '3101','501','Cocacola','beverage','2.2','98'),
 ('3102','503','Oreo','snacks','180','68'),
  ('3103','504','Kitkat','Chocolate','25','40');
  
  Insert into stock
values( '001','solid','300'),
('002','Liquid','200');
Update stock
set stock_type = 'Kilogram'
where stock_id = '001';
Update stock
set stock_type = 'Litre'
where stock_id = '002';



update stock
set stock_id='501'
where stock_id='002';
use mini_project1;
update stock
set stock_id='503' and stock_type='Gram'
where stock_id='0';


use mini_project1;
Insert into stock
values( '503','gram','100'),
( '504','gram','700');




-- Query section

-- 1. Find the customer who has delivery zip code of 3787

use mini_project1;

select cust_firstname, cust_lastname,cust_phone from customer c join orders o on (c.cust_id = o.cust_id) join address a on o.add_id = a.add_id 
where delivery_zipcode = '3787'; 

-- 2. Find the amount of sale ordered on 2003-03-23  from order id 201 and how much of that item is in stock

use mini_project1;

Select i.item_price*o.quantity as sale , s.in_stock as In_Stock from orders o join item i on 
( o.item_id = i.item_id ) join stock s on ( i.stock_id = s.stock_id ) where o.order_date = '2003-03-23'
 and o.order_id = '201' ;

-- 3. Find the item name ordered by Hasan

use mini_project1;
select i.item_name from item i join orders o on ( i.item_id = o.item_id ) join customer c on 
( o.cust_id = c.cust_id ) where c.cust_firstname = 'Hasan' or c.cust_lastname = 'Hasan' ;

-- 4. Find the stock type of that item which is ordered by a customer who lives in Khulna on 2004-04-23 date

use mini_project1;
select s.stock_type from stock s join item i on ( s.stock_id = i.stock_id ) join orders o on 
( o.item_id = i.item_id ) join address a on ( a.add_id = o.add_id) where a.delivery_city = 'Khulna' and 
o.order_date = '2004-04-23'; 

-- 5. Find the orders which are delivered
use mini_project1;
select order_id from orders where delivery = '1'; 

-- 6. Find the delivery address of order id 202
use mini_project1;
select delivery_address from address a join orders o on ( a.add_id = o.add_id ) where o.order_id = '202';

-- 7. Find the phone number of customer of order id of 201
use mini_project1;
select cust_phone from customer c join orders o on ( c.cust_id = o.cust_id ) where o.order_id = '201';

-- 8. Find the stock id of stock type of gram

use mini_project1;
select stock_id from stock where stock_type = 'gram';

-- 9. Find the items which are more than 100 in stock
use mini_project1;
select i.item_id from item i join stock s on ( i.stock_id = s.stock_id ) where in_stock > 100;

-- 10. Find the total quantity of all rows
use mini_project1;
select sum(quantity) as total_quantity from orders ;

-- 11. Find the item id of that item which is worth more than the average of all the prices
use mini_project1;
select i.item_id    from ( select  avg( item_price) as prc from item )
as tb , item i where i.item_price > tb.prc;
