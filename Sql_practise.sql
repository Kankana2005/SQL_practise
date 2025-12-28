create table test(
my_date date,
my_time time,
my_dataTime dateTime
);

insert into test
values (current_date()+1,null,null);

select * from test;
drop table test;

create table products (
product_id int,
product_name varchar(25),
price decimal (4,2)
);

alter table products 
add constraint
unique(product_name);

select * from products

insert into products(product_id,product_name,price)
values (100 , "chocolate", 3.99),
(101 , "chocolatebar", 99.00),
(102 , "chocolatesoup", 9.99),
(103 , "chocolatecone", 5.99);
select * from products;

alter table products
modify price decimal(4,2) not null; 

-- ## chcek constarint
select * from emp;
alter table emp
add constraint chk_hourly_pay check(hourly_pay >=100);
alter table emp
drop check chk_hourly_pay;

-- ## Dafault Constraint
insert into products(product_id,product_name,price)
values (104,"straw",0.0),
(105,"napkin",0.0);

select * from products;

SET SQL_SAFE_UPDATES = 0;
-- DELETE FROM products
-- WHERE product_id >= 104;
-- SET SQL_SAFE_UPDATES = 1;

alter table products
alter price set default 0;


insert into products(product_id,product_name)
values (104, "straw"),
(105,"napkin"),
(106,"fork");

create table trans(
trans_id int,
amnt decimal(5,2),
trans_time datetime default now());
insert into trans ( trans_id, amnt)
values (2,3.80);
select * from trans;
drop table trans;

-- primary key constraint
create table transactions(
trans_id int primary key,
amnt decimal (5,2) 
);
insert into transactions(trans_id , amnt)
values (1000, 3.00),
(1001,4.99),
(1002 , 5.87),
(1003,93.9);
select * from transactions;
select amnt 
from transactions 
where trans_id = 1003;
drop table transactions;

-- # Auto_increment attribute
create table trans(
trans_id int primary key auto_increment,
amnt decimal (5,2));
insert into trans ( amnt)
values (4.99),
(5.88),(9.90),(8.78),(7.09);

alter table trans 
auto_increment = 1000;
insert into trans ( amnt)
values (4.99),
(5.88),(9.90),(8.78),(7.09);
delete from trans;
select * from trans;

-- # Foreign Keys
create table customers(
customer_id int primary key auto_increment,
first_name varchar(50),
last_name varchar(50));
select * from customers;
insert into customers(first_name , last_name)
values ("kankana","Ghosh"),
("John","Cena"),
("Roman","Reigns");
drop table trans;
create table trans (
trans_id int primary key auto_increment,
amnt decimal(5,2),
customer_id int,
foreign key(customer_id) references customers(customer_id)
);
select * from trans;
alter table  trans
drop foreign key trans_ibfk_1;

alter table trans
add constraint fk_customer_id
foreign key (customer_id) references customers(customer_id);

delete from trans;
select * from trans;

insert into trans (amnt , customer_id)
values (4.99,3),
(5.66,2),(6.90,1),(4.34,3);
select * from trans;

insert into trans (amnt , customer_id)
values(14.18,Null);
select * from trans;
insert into customers(first_name,last_name)
values ("mili","das");
select * from customers;

select * 
from trans right join customers
on trans.customer_id = customers.customer_id;

-- #Functions
select count(amnt) as "Todays transactions"
from trans;
select min(amnt) as "minimum"
from trans;
select max(amnt) as "maximum"
from trans;
select avg(amnt) as average
from trans;
select sum(amnt) as total from trans;

select concat(first_name," ",last_name) as full_name from emp;

-- #Logical operators
alter table emp add column job varchar(25) after hourly_pay;
alter table emp
alter job set default null;
insert into emp (job)
values ("cashier"),("Cleaner"),("Sweeper"),
("waiter");

delete from emp where employee_id is Null;
select * from emp;

-- #Logical Operators
update emp
set job = "asst. manager"
where employee_id = 5;
select * from emp;
select * from emp where hire_date > 2023-05-12 and job = "cook"; 
select * from emp where job = "cook" or job = "cahsier";
select * from emp where not job = "cook" and not job = "manager";
select * from emp where hire_date between "2023-02-13" and "2023-05-05";

-- #wild Card characters
select * from emp where first_name like "k%";
select * from emp where last_name like "%a";
select * from emp where job like "_ook";
select * from emp where job like "_a%";

-- #Order by
select * from emp 
order by hourly_pay desc;
select * from emp 
order by employee_id ;

-- # Limit Clause
select * from emp 
limit 5;

-- #Union 
select first_name,last_name from emp
union
select first_name,last_name from customers;

#slef joins
alter table customers
add referral_id  int;
select * from customers;
update customers 
set referral_id = 3
where customer_id = 5;
select a.customer_id, a.first_name , a.last_name,
concat(b.first_name,b.last_name) as "referred by"
from customers as a
inner join customers as b 
on a.referral_id = b.customer_id;

select * from emp;
alter table emp
add column supervisor_id int;

SET SQL_SAFE_UPDATES = 0;
UPDATE emp
SET supervisor_id = 1
WHERE job = "asst. manager";
-- AND TRIM(LOWER(job)) NOT IN ('manager', 'asst. manager');
select a.employee_id ,a.first_name,a.last_name,a.job,
concat(b.first_name,b.last_name) as "supervised from",b.job

 from emp as a
inner join emp as b
on a.supervisor_id = b.employee_id; 

-- View
create view emp_reg as
select first_name , last_name from emp;
select * from emp_reg 
order by first_name;
drop  view emp_reg;

alter table customers
add column email varchar(25);
select * from customers;
update customers
set email = "kankanaghosh@gmail.com"
where customer_id = 5;

create view customer_email as 
select email from customers;

select * from customer_email;
select * from customers;
insert into customers (customer_id,first_name,last_name,referral_id,email)
values (6,"kiran","Ghosh",5,"kiran@gmail.com");


-- index
show indexes from customers;
create index last_name_idx 
on customers(last_name);
select  * from customers
where first_name = "kankana";

alter table customers
drop index last_name_idx;

create index first_last_name_idx
on customers(last_name , first_name);
select * from customers
where last_name = "Ghosh" and first_name = "kiran";
select * from customers;

-- subquery
select * from emp;
 select first_name,last_name , hourly_pay ,(select avg(hourly_pay) from emp) as avg_pay
 from emp;
 
 select first_name , last_name,hourly_pay
from emp
where hourly_pay > 
(select avg(hourly_pay) from emp);

select * from customers;
select * from trans;
select first_name , last_name 
from customers
where customer_id in (select distinct customer_id from trans 
where customer_id is not null);

-- Group by 
alter table trans
add column order_date date;
select * from trans;

alter table trans 
modify order_date  date;
update trans 
set order_date = '2023-06-01'
where trans_id = 9;

insert into trans (trans_id,amnt,customer_id,order_date)
values (10,6.88,null,"2023-09-01");

select sum(amnt), order_date
from trans
group by order_date;

select sum(amnt) , customer_id 
from trans
group by customer_id;

select count(amnt) , customer_id
from trans
group by customer_id
having count(amnt) > 1 and  customer_id is not null;

-- Rollup
select count(trans_id) , order_date
from trans
group by order_date with rollup;

select count(trans_id) as "No. of customers" ,
customer_id from trans
group by customer_id with rollup;

select * from emp;
select sum(hourly_pay), employee_id
from emp
group by employee_id with rollup;

-- on delete clause
set foreign_key_checks = 0;
select * from customers;
delete from customers
where customer_id = 3;

select * from trans;
alter table trans
drop foreign key fk_customer_id;

alter table trans
add constraint fk_customer_id
foreign key(customer_id) references customers(customer_id) 
on delete set null;

delete from trans 
where customer_id = 3;

alter table trans
drop foreign key fk_trans_id;

-- On delete cascade
alter table trans
add constraint fk_trans_id
foreign key(customer_id) references customers(customer_id)
on delete cascade;

select * from customers;
insert into customers(customer_id,first_name,last_name,email)
values (3,"jhuma","Ghosh","jhuma@gmail.com");
update trans
set customer_id = 3
where trans_id = 9;
select * from trans;

delete from customers
where customer_id = 3;

-- Stored Procedures
delimiter $$
create procedure get_customers()
begin
	select * from customers;
end $$
delimiter ; 

call get_customers();
drop procedure get_customers;
delimiter $$
create procedure find_customer(in id int)
begin
	select * from customers
    where customer_id = id;
    
end $$
delimiter ;

call find_customer(1);
drop procedure find_customer;

delimiter $$
create procedure find_customer(in f_name varchar(50) , in l_name varchar(50))
begin
	select * from customers
    where first_name = f_name and last_name = l_name;
end $$
delimiter ;

call find_customer("mili","das");

-- Triggers
alter table emp
add column salary decimal(7,2) after hourly_pay;

select * from emp;

set sql_safe_updates = 0;

update emp 
set salary = hourly_pay * 2080;

alter table emp 
modify salary decimal(10,2); 

create trigger before_hourly_pay_update
before update on emp
for each row
set new.salary = (new.hourly_pay * 2080);

show triggers;
update emp 
set hourly_pay = hourly_pay + 2;
select * from emp;

delete from emp
where employee_id = 3;
select * from emp;

create trigger before_hourly_Pay
before insert on emp
for each row
set new.salary = (new.hourly_pay * 2080);

select * from emp;
insert into emp 
values(3,"gopal","ghosh",100,null,"janitor", "2023-09-12", 4,null);


create table expense (
	expense_id int primary key,
    expense_name varchar(50),
    expense_total decimal (10,2));
    
insert into expense
values (1,"salary",0),(2,"supplies",0),(3,"taxes",0)   ; 
select * from expense;   

update expense 
set expense_total = (select sum(salary) from emp where expense_name = "salary") ;

create trigger after_salary_delete
after delete on emp
for each row update expense 
set expense_total = expense_total - old.salary
where expense_name = "salary";

delete from emp 
where employee_id = 3;
select * from expense;

create trigger after_salary_insert
after insert on emp
for each row
update expense
set expense_total = expense_total + new.salary 
where expense_name = "salary";

select * from emp;
insert into emp
values (3, "gopal","ghosh",10,null,"janitor","2023-10-12",4,null);
select * from expense;

create trigger after_salary_change
after update on emp
for each row
update expense
set expense_total = expense_total + ( new.salary - old.salary)
where expense_name = "salary";

-- DROP TRIGGER IF EXISTS after_salary_change;

update emp
set hourly_pay = 100
where employee_id = 1;
select * from expense;

 
 


    
    








