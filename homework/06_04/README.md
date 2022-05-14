1.  
```
\l[+]   - вывод списка БД
\c      - подключение к БД
\dt[S+] - вывод списка таблиц
\d[S+]  - вывод описания содержимого таблиц
\q      - выход из psql
```
2.  
```
test_database=# SELECT attname, avg_width FROM pg_stats WHERE tablename = 'orders';
 attname | avg_width 
---------+-----------
 id      |         4
 title   |        16
 price   |         4
(3 rows)
```
Столбец с именем `title`.  
3.  
```
begin;

create table orders_1 (check(price >= 499)) inherits (orders);
create table orders_2 (check(price <= 500)) inherits (orders);

create rule orders_ins_499 as 
on insert to orders
where (price >= 499)
do instead 
insert into orders_1 values (new.*);

create rule orders_ins_500 as 
on insert to orders
where (price <= 500)
do instead 
insert into orders_2 values (new.*);

insert into orders select * from orders;
delete from only orders;

commit;
```
На момент проектирования таблицы было возможно включить для нее партицирование.  
4.  
Добавил бы в бекап UNIQUE:  
```
CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL UNIQUE,
    price integer DEFAULT 0
);
```
