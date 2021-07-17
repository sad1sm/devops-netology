1. 
``` 
route-views>sh ip ro 109.252.131.82                
Routing entry for 109.252.0.0/16
  Known via "bgp 6447", distance 20, metric 0
  Tag 2497, type external
  Last update from 202.232.0.2 7w0d ago
  Routing Descriptor Blocks:
  * 202.232.0.2, from 202.232.0.2, 7w0d ago
      Route metric is 0, traffic share count is 1
      AS Hops 3
      Route tag 2497
      MPLS label: none
```
``` 
route-views>show bgp 109.252.131.82   
BGP routing table entry for 109.252.0.0/16, version 133607257
Paths: (25 available, best #19, table default)
  Not advertised to any peer
  Refresh Epoch 1
  20912 3257 3356 8359 25513
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external
      Community: 3257:8070 3257:30515 3257:50001 3257:53900 3257:53902 20912:65004
      path 7FE0E6827410 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3561 3910 3356 8359 25513
    206.24.210.80 from 206.24.210.80 (206.24.210.80)
      Origin IGP, localpref 100, valid, external
      path 7FE135954BD0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3267 1299 8359 25513
    194.85.40.15 from 194.85.40.15 (185.141.126.1)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7FE0BF181F68 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1221 4637 3356 8359 25513
    203.62.252.83 from 203.62.252.83 (203.62.252.83)
      Origin IGP, localpref 100, valid, external
      path 7FE15CD90F88 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3333 8359 25513
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
      Origin IGP, localpref 100, valid, external
      Community: 0:151 8359:100 8359:5500 8359:55277
      path 7FE01744E088 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3549 3356 8359 25513
    208.51.134.254 from 208.51.134.254 (67.16.168.191)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 0:151 3356:2 3356:22 3356:100 3356:123 3356:519 3356:903 3356:2094 3549:2581 3549:30840 8359:100 8359:5500 8359:55277
      path 7FE170583D48 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3356 8359 25513
    4.68.4.46 from 4.68.4.46 (4.69.184.201)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 0:151 3356:2 3356:22 3356:100 3356:123 3356:519 3356:903 3356:2094 8359:100 8359:5500 8359:55277
      path 7FE10CB71070 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  53767 14315 6453 6453 3356 8359 25513
    162.251.163.2 from 162.251.163.2 (162.251.162.3)
      Origin IGP, localpref 100, valid, external
      Community: 14315:5000 53767:5000
      path 7FE0D21A4BC0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  701 3356 8359 25513
    137.39.3.55 from 137.39.3.55 (137.39.3.55)
      Origin IGP, localpref 100, valid, external
      path 7FE149A61F38 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  101 3356 8359 25513
    209.124.176.223 from 209.124.176.223 (209.124.176.223)
      Origin IGP, localpref 100, valid, external
      Community: 0:151 101:20100 101:20110 101:22100 3356:2 3356:22 3356:100 3356:123 3356:519 3356:903 3356:2094 8359:100 8359:5500 8359:55277
      Extended Community: RT:101:22100
      path 7FE150A91EF0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 2
  24441 3491 3491 3356 8359 25513
    202.93.8.242 from 202.93.8.242 (202.93.8.242)
      Origin IGP, localpref 100, valid, external
      path 7FE17A0F0188 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  852 3356 8359 25513
    154.11.12.212 from 154.11.12.212 (96.1.209.43)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7FE17599AC20 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  57866 1299 8359 25513
    37.139.139.17 from 37.139.139.17 (37.139.139.17)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 1299:20000 57866:11 57866:100 57866:101 57866:501
      path 7FE13327C9D8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20130 6939 8359 25513
    140.192.8.16 from 140.192.8.16 (140.192.8.16)
      Origin IGP, localpref 100, valid, external
      path 7FE01CD976F8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  4901 6079 8359 25513
    162.250.137.254 from 162.250.137.254 (162.250.137.254)
      Origin IGP, localpref 100, valid, external
      Community: 65000:10100 65000:10300 65000:10400
      path 7FE04ADD5330 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 4
  8283 8359 25513
    94.142.247.3 from 94.142.247.3 (94.142.247.3)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 0:151 8283:1 8283:101 8359:100 8359:5500 8359:55277
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
        value 0000 205B 0000 0000 0000 0001 0000 205B
              0000 0005 0000 0001 
      path 7FE11DAA4318 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  49788 12552 8359 25513
    91.218.184.60 from 91.218.184.60 (91.218.184.60)
      Origin IGP, localpref 100, valid, external
      Community: 12552:12000 12552:12100 12552:12101 12552:22000
      Extended Community: 0x43:100:1
      path 7FE124250970 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7018 3356 8359 25513
    12.0.1.63 from 12.0.1.63 (12.0.1.63)
      Origin IGP, localpref 100, valid, external
      Community: 7018:5000 7018:37232
      path 7FE13DFF1D68 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  2497 8359 25513
    202.232.0.2 from 202.232.0.2 (58.138.96.254)
      Origin IGP, localpref 100, valid, external, best
      path 7FE09FDF8700 RPKI State not found
      rx pathid: 0, tx pathid: 0x0
  Refresh Epoch 1
  1351 8359 25513
    132.198.255.253 from 132.198.255.253 (132.198.255.253)
      Origin IGP, localpref 100, valid, external
      path 7FE02B84F3F0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7660 2516 1299 8359 25513
    203.181.248.168 from 203.181.248.168 (203.181.248.168)
      Origin IGP, localpref 100, valid, external
      Community: 2516:1030 7660:9003
      path 7FE1463E90E8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 2
  3303 8359 25513
    217.192.89.50 from 217.192.89.50 (138.187.128.158)
      Origin IGP, localpref 100, valid, external
      Community: 0:151 3303:1004 3303:1006 3303:1030 3303:3056 8359:100 8359:5500 8359:55277
      path 7FE0FB65D718 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  6939 8359 25513
    64.71.137.241 from 64.71.137.241 (216.218.252.164)
      Origin IGP, localpref 100, valid, external
      path 7FE0B17F4998 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  19214 3257 3356 8359 25513
    208.74.64.40 from 208.74.64.40 (208.74.64.40)
      Origin IGP, localpref 100, valid, external
      Community: 3257:8108 3257:30048 3257:50002 3257:51200 3257:51203
      path 7FE00ADFC2A8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3257 3356 8359 25513
    89.149.178.10 from 89.149.178.10 (213.200.83.26)
      Origin IGP, metric 10, localpref 100, valid, external
      Community: 3257:8794 3257:30043 3257:50001 3257:54900 3257:54901
      path 7FE1233E0790 RPKI State not found
      rx pathid: 0, tx pathid: 0
```
2. Создал dummy0 интерфейс, добавил маршруты.
``` 
root@vagrant:~# cat /etc/netplan/02-dummy.yaml 
network:
  version: 2
  renderer: networkd
  bridges:
    dummy0:
      dhcp4: no
      dhcp6: no
      accept-ra: no
      interfaces: [ ]
      addresses:
        - 10.10.10.1/32
```
``` 
root@vagrant:~# ip -br route
default via 10.0.2.2 dev eth0 proto dhcp src 10.0.2.15 metric 100 
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 
10.0.2.2 dev eth0 proto dhcp scope link src 10.0.2.15 metric 100 
10.16.10.0/24 dev dummy0 scope link metric 100 
10.23.10.0/24 dev dummy0 scope link metric 100 
10.67.10.0/24 dev dummy0 scope link metric 100 
```
3. Посмотреть открытые TCP порты можно командой `ss -tap`. В моем случае открыто подключение по SSH, слушающий системный протокол RPC и слушающий запрос к DNS серверу.
``` 
root@vagrant:~# ss -tap
State      Recv-Q     Send-Q         Local Address:Port           Peer Address:Port      Process                                                       
LISTEN     0          4096                 0.0.0.0:sunrpc              0.0.0.0:*          users:(("rpcbind",pid=615,fd=4),("systemd",pid=1,fd=82))     
LISTEN     0          4096           127.0.0.53%lo:domain              0.0.0.0:*          users:(("systemd-resolve",pid=616,fd=13))                    
LISTEN     0          128                  0.0.0.0:ssh                 0.0.0.0:*          users:(("sshd",pid=1520,fd=3))                               
ESTAB      0          0                  10.0.2.15:ssh                10.0.2.2:49436      users:(("sshd",pid=14175,fd=4),("sshd",pid=14130,fd=4))      
LISTEN     0          4096                    [::]:sunrpc                 [::]:*          users:(("rpcbind",pid=615,fd=6),("systemd",pid=1,fd=85))     
LISTEN     0          128                     [::]:ssh                    [::]:*          users:(("sshd",pid=1520,fd=4)) 
```
4. Посмотреть открытые UDP порты можно командой `ss -uap`. В моем случае это DNS запрос и RPC протокол. 
``` 
root@vagrant:~# ss -uap
State      Recv-Q     Send-Q          Local Address:Port           Peer Address:Port     Process                                                       
UNCONN     0          0               127.0.0.53%lo:domain              0.0.0.0:*         users:(("systemd-resolve",pid=616,fd=12))                    
UNCONN     0          0                     0.0.0.0:sunrpc              0.0.0.0:*         users:(("rpcbind",pid=615,fd=5),("systemd",pid=1,fd=83))     
UNCONN     0          0                        [::]:sunrpc                 [::]:*         users:(("rpcbind",pid=615,fd=7),("systemd",pid=1,fd=86))
```
5.

![Home_Network.png](Home_Network.png)