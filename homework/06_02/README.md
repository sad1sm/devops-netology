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
