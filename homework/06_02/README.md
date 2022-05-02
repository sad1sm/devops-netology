1.  
```
version: '3.1'

services:

  db:
    image: postgres:12
    restart: always
    environment:
      POSTGRES_PASSWORD: MySuPeR$eCrEtP@sSw0rD
    volumes:
      - pg-data:/var/lib/postgresql/data
      - pg-backup:/backup

volumes:
    pg-data:
      driver: local
    pg-backup:
      driver: local
```
2.  
```
test_db=# \l
                                             List of databases
   Name    |      Owner      | Encoding |  Collate   |   Ctype    |            Access privileges            
-----------+-----------------+----------+------------+------------+-----------------------------------------
 postgres  | postgres        | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres        | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                            +
           |                 |          |            |            | postgres=CTc/postgres
 template1 | postgres        | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                            +
           |                 |          |            |            | postgres=CTc/postgres
 test_db   | test-admin-user | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/"test-admin-user"                  +
           |                 |          |            |            | "test-admin-user"=CTc/"test-admin-user"
(4 rows)
```

```
test_db=# \d orders
                                          Table "public.orders"
          Column          |       Type        | Collation | Nullable |              Default               
--------------------------+-------------------+-----------+----------+------------------------------------
 id                       | integer           |           | not null | nextval('orders_id_seq'::regclass)
 наименование             | character varying |           |          | 
 цена                     | integer           |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
```

```
                                               Table "public.clients"
              Column               |       Type        | Collation | Nullable |               Default               
-----------------------------------+-------------------+-----------+----------+-------------------------------------
 id                                | integer           |           | not null | nextval('clients_id_seq'::regclass)
 фамилия                           | character varying |           |          | 
 страна проживания                 | character varying |           |          | 
 заказ                             | integer           |           |          | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "country" btree ("страна проживания")
Foreign-key constraints:
    "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
```

`SELECT * FROM information_schema.table_privileges where table_name like 'orders' or table_name like 'clients';`

```
 grantor  |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy 
----------+------------------+---------------+--------------+------------+----------------+--------------+----------------
 postgres | postgres         | test_db       | public       | orders     | INSERT         | YES          | NO
 postgres | postgres         | test_db       | public       | orders     | SELECT         | YES          | YES
 postgres | postgres         | test_db       | public       | orders     | UPDATE         | YES          | NO
 postgres | postgres         | test_db       | public       | orders     | DELETE         | YES          | NO
 postgres | postgres         | test_db       | public       | orders     | TRUNCATE       | YES          | NO
 postgres | postgres         | test_db       | public       | orders     | REFERENCES     | YES          | NO
 postgres | postgres         | test_db       | public       | orders     | TRIGGER        | YES          | NO
 postgres | test-simple-user | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | postgres         | test_db       | public       | clients    | INSERT         | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | SELECT         | YES          | YES
 postgres | postgres         | test_db       | public       | clients    | UPDATE         | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | DELETE         | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | TRUNCATE       | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | REFERENCES     | YES          | NO
 postgres | postgres         | test_db       | public       | clients    | TRIGGER        | YES          | NO
 postgres | test-simple-user | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | DELETE         | NO           | NO
```

3.  
```
test_db=# select count(*) from clients;
 count 
-------
     5
(1 row)

test_db=# select count(*) from orders;
 count 
-------
     5
(1 row)
```

4.  
```
update clients set заказ=(select id from orders where наименование='Книга') where фамилия='Иванов Иван Иванович';
update clients set заказ=(select id from orders where наименование='Монитор') where фамилия='Петров Петр Петрович';
update clients set заказ=(select id from orders where наименование='Гитара') where фамилия='Иоганн Себастьян Бах';
```

```
test_db=#  select * from clients where заказ is not null;
 id |             фамилия             | страна проживания | заказ 
----+----------------------------------------+-----------------------------------+------------
  1 | Иванов Иван Иванович | USA                               |          3
  2 | Петров Петр Петрович | Canada                            |          4
  3 | Иоганн Себастьян Бах | Japan                             |          5
(3 rows)
```

5.  
```
test_db=# explain analyze select from clients where заказ is not null;
                                             QUERY PLAN                                             
----------------------------------------------------------------------------------------------------
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=0) (actual time=0.030..0.035 rows=3 loops=1)
   Filter: ("заказ" IS NOT NULL)
   Rows Removed by Filter: 2
 Planning Time: 0.120 ms
 Execution Time: 0.069 ms
(5 rows)
```
Последовательное сканирование таблицы clients (ожидаемые значения: стоимость(по времени) от 0 до 18.10 секунд, строк 806, длинна строк 0) (действительные значения от 0.030 до 0.035 секунд, количество строк 3, количество повторов 1). Фильтр ненулевое значение в столбце заказ. Было отфильтровано 2 строки. Планируемое время выполнения запроса 0.120 миллисекунд, реальное 0.069 миллисекунд.  

6.  
```
$ pg_dump test_db > /backup/test_db.sql
$ exit
$ docker-compose down
$ vi docker-compose.yml
$ docker-compose up -d
$ docker exec -it 06_02-new_db-1 bash
$ su - postgres
$ psql < /backup/test_db.sql
```
