1.  
```
mysql> \s
--------------
mysql  Ver 8.0.29 for Linux on x86_64 (MySQL Community Server - GPL)
```

```
mysql> select count(*) from orders where price >= 300;
+----------+
| count(*) |
+----------+
|        3 |
+----------+
1 row in set (0.00 sec)
```
2.  
```
CREATE USER 'test'@'localhost'
IDENTIFIED WITH mysql_native_password BY 'test-pass'
WITH MAX_QUERIES_PER_HOUR 100
PASSWORD EXPIRE INTERVAL 180 DAY
FAILED_LOGIN_ATTEMPTS 3
ATTRIBUTE '{"fname": "James", "lname": "Pretty"}'
```
```
mysql> select * from information_schema.user_attributes where user = 'test';
+------+-----------+---------------------------------------+
| USER | HOST      | ATTRIBUTE                             |
+------+-----------+---------------------------------------+
| test | localhost | {"fname": "James", "lname": "Pretty"} |
+------+-----------+---------------------------------------+
1 row in set (0.00 sec)
```
3.  
```
mysql> SELECT TABLE_NAME, ENGINE   FROM information_schema.TABLES  WHERE TABLE_SCHEMA = 'test_db';
+------------+--------+
| TABLE_NAME | ENGINE |
+------------+--------+
| orders     | InnoDB |
+------------+--------+
1 row in set (0.01 sec)
```
```
mysql> ALTER TABLE orders ENGINE = MyISAM;
Query OK, 5 rows affected (0.29 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE orders ENGINE = InnoDB;
Query OK, 5 rows affected (0.14 sec)
Records: 5  Duplicates: 0  Warnings: 0
```
```
+----------+------------+------------------------------------+
| Query_ID | Duration   | Query                              |
+----------+------------+------------------------------------+
|       17 | 0.28306125 | ALTER TABLE orders ENGINE = MyISAM |
|       18 | 0.14024525 | ALTER TABLE orders ENGINE = InnoDB |
+----------+------------+------------------------------------+
```
4.  
```
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL
innodb_buffer_pool_size=2G       # Буффер кеширования 30% от ОЗУ
innodb_log_file_size=100M        # Размер файла логов операций 100 Мб
innodb_log_buffer_size=1M        # Размер буффера с незакомиченными транзакциями 1 Мб
innodb_file_per_table=ON         # Нужна компрессия таблиц для экономии места на диске
innodb_flush_method=O_DSYNC      # Скорость IO важнее сохранности данных
innodb_flush_log_at_trx_commit=2 # Скорость IO важнее сохранности данных
```
