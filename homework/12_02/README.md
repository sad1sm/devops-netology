# Домашнее задание к занятию "Базовые объекты K8S"

### Задание 1. Создать Pod с именем "hello-world"

1. Создать манифест (yaml-конфигурацию) Pod  
[hello-world.yml](hello-world.yml)
2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2  
Невозможно использовать данный image на Mac с процессором Apple Silicon M2.  
Заменил на [kicbase/echo-server:1.0](https://github.com/kubernetes/minikube/pull/15397)  
3. Подключиться локально к Pod с помощью `kubectl port-forward` и вывести значение (curl или в браузере)
```bash
% sudo kubectl port-forward hello-world 20080:8080
Forwarding from 127.0.0.1:20080 -> 8080
Forwarding from [::1]:20080 -> 8080
```
```bash
% curl -vvvv http://127.0.0.1:20080     
*   Trying 127.0.0.1:20080...
* Connected to 127.0.0.1 (127.0.0.1) port 20080 (#0)
> GET / HTTP/1.1
> Host: 127.0.0.1:20080
> User-Agent: curl/7.85.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Content-Type: text/plain
< Date: Sat, 18 Feb 2023 23:23:28 GMT
< Content-Length: 105
< 
Request served by hello-world

HTTP/1.1 GET /

Host: 127.0.0.1:20080
Accept: */*
User-Agent: curl/7.85.0
* Connection #0 to host 127.0.0.1 left intact
```
------

### Задание 2. Создать Service и подключить его к Pod

1. Создать Pod с именем "netology-web"  
[netology-web.yml](netology-web.yml)  
2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2  
Невозможно использовать данный image на Mac с процессором Apple Silicon M2.  
Заменил на [kicbase/echo-server:1.0](https://github.com/kubernetes/minikube/pull/15397)  
3. Создать Service с именем "netology-svc" и подключить к "netology-web"  
[netology-svc.yml](netology-svc.yml)  
4. Подключиться локально к Service с помощью `kubectl port-forward` и вывести значениt (curl или в браузере)  
```bash
% sudo kubectl port-forward svc/netology-svc 20080:8080
Forwarding from 127.0.0.1:20080 -> 8080
Forwarding from [::1]:20080 -> 8080
```
```bash
% curl -vvvv http://127.0.0.1:20080     
*   Trying 127.0.0.1:20080...
* Connected to 127.0.0.1 (127.0.0.1) port 20080 (#0)
> GET / HTTP/1.1
> Host: 127.0.0.1:20080
> User-Agent: curl/7.85.0
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Content-Type: text/plain
< Date: Sat, 18 Feb 2023 23:36:09 GMT
< Content-Length: 106
< 
Request served by netology-web

HTTP/1.1 GET /

Host: 127.0.0.1:20080
Accept: */*
User-Agent: curl/7.85.0
* Connection #0 to host 127.0.0.1 left intact
```

------
```bash
% kubectl get pods
NAME           READY   STATUS    RESTARTS      AGE
hello-world    1/1     Running   1 (15m ago)   26m
netology-web   1/1     Running   0             11m
```
```bash
% kubectl get services
NAME           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
kubernetes     ClusterIP   10.152.183.1     <none>        443/TCP    155m
netology-svc   ClusterIP   10.152.183.210   <none>        8080/TCP   5m18s
```