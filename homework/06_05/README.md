1.  
```
  FROM centos:7

  ENV ES_PATH_CONF=/var/lib/conf
  ENV ES_PATH_WORK=/var/lib/work

  EXPOSE 9200
  EXPOSE 9300

  RUN \
  yum install -y wget perl-Digest-SHA tar && \
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.0-linux-x86_64.tar.gz && \
  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.2.0-linux-x86_64.tar.gz.sha512 && \
  shasum -a 512 -c elasticsearch-8.2.0-linux-x86_64.tar.gz.sha512 && \
  tar -xzf elasticsearch-8.2.0-linux-x86_64.tar.gz

  RUN useradd elasticsearch
  RUN chown elasticsearch -R /elasticsearch-8.2.0

  WORKDIR /var/lib
  RUN mkdir data work conf logs
  COPY  ["elasticsearch.yml", "jvm.options", "log4j2.properties", "/var/lib/conf/"]
  RUN chown elasticsearch -R /var/lib

  USER elasticsearch
  WORKDIR /elasticsearch-8.2.0/bin 
  ENTRYPOINT ["./elasticsearch","-E","discovery.type=single-node"]
```
  
https://hub.docker.com/repository/docker/f1tz/netology_test
  
```
$ curl -k -u elastic:password https://127.0.0.1:9200/

{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "MeYJyR9sT76rtvNtSYTVJQ",
  "version" : {
    "number" : "8.2.0",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "b174af62e8dd9f4ac4d25875e9381ffe2b9282c5",
    "build_date" : "2022-04-20T10:35:10.180408517Z",
    "build_snapshot" : false,
    "lucene_version" : "9.1.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
```
  
2.  
```
$ curl -k -u elastic:password https://0.0.0.0:9200/_cat/indices
green  open ind-1 Nz1NXsU9Qna06coz4bxirQ 1 0 0 0 225b 225b
yellow open ind-2 yyK2FNSdSFa1v9PXuy7avQ 2 1 0 0 450b 450b
yellow open ind-3 B4A_r7GCRt2fmm1krqJM3g 4 2 0 0 900b 900b
```
```
$ curl -k -u elastic:password https://0.0.0.0:9200/_cluster/health?pretty
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 9,
  "active_shards" : 9,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 47.368421052631575
}
```
  
Статус `yellow` из-за того, что мы находимся не в кластере.  
  
```
$ curl -k -u elastic:password -X DELETE "https://localhost:9200/ind-1?pretty" 
{
  "acknowledged" : true
}
$ curl -k -u elastic:password -X DELETE "https://localhost:9200/ind-2?pretty" 
{
  "acknowledged" : true
}
$ curl -k -u elastic:password -X DELETE "https://localhost:9200/ind-3?pretty" 
{
  "acknowledged" : true
}
```
3.  
```
$ curl -k -u elastic:password -X PUT "https://localhost:9200/_snapshot/netology_backup?verify=false&pretty" -H 'Content-Type: application/json' -d'
{              
  "type": "fs",
  "settings": {
    "location": "netology_backup"
  }
}
'
{
  "acknowledged" : true
}
```
```
$ curl -k -u elastic:password https://0.0.0.0:9200/_cat/indices
green open test fvpNoqPhTwOlymxhWXDYZw 1 0 0 0 225b 225b
```
```
[elasticsearch@a0284943f11e netology_backup]$ pwd
/elasticsearch-8.2.0/snapshots/netology_backup

[elasticsearch@a0284943f11e netology_backup]$ ls -lha
total 44K
drwxr-xr-x 3 elasticsearch elasticsearch 4.0K May 15 00:05 .
drwxr-xr-x 3 elasticsearch elasticsearch 4.0K May 15 00:05 ..
-rw-r--r-- 1 elasticsearch elasticsearch 1.1K May 15 00:05 index-0
-rw-r--r-- 1 elasticsearch elasticsearch    8 May 15 00:05 index.latest
drwxr-xr-x 5 elasticsearch elasticsearch 4.0K May 15 00:05 indices
-rw-r--r-- 1 elasticsearch elasticsearch  18K May 15 00:05 meta-eJ5v8fspRJ-4V04Df6VXNg.dat
-rw-r--r-- 1 elasticsearch elasticsearch  389 May 15 00:05 snap-eJ5v8fspRJ-4V04Df6VXNg.dat
```   
```
$ curl -k -u elastic:password https://0.0.0.0:9200/_cat/indices
green open test-2 cc6LrqISRCi1pnuzMbFy4g 1 0 0 0 225b 225b
```
```
$ curl -k -u elastic:password -X POST "https://localhost:9200/_snapshot/netology_backup/snapshot_1/_restore?pretty" -H 'Content-Type: application/json' -d'
{
  "indices": "test"
}
'
{
  "accepted" : true
}

$ curl -k -u elastic:password https://0.0.0.0:9200/_cat/indices
green open test   --N89GL4T6OcPJwN4aVtqw 1 0 0 0 225b 225b
green open test-2 cc6LrqISRCi1pnuzMbFy4g 1 0 0 0 225b 225b
```
