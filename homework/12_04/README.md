# Домашнее задание к занятию "Сетевое взаимодействие в K8S. Часть 1"

### Задание 1. Создать Deployment и обеспечить доступ к контейнерам приложения по разным портам из другого Pod'а внутри кластера

> 1. Создать Deployment приложения, состоящего из двух контейнеров - nginx и multitool с кол-вом реплик 3шт.  
```
% kubectl get pods
NAME                               READY   STATUS    RESTARTS   AGE
multitool                          1/1     Running   0          7s
nginx-deployment-8886d4dcf-5zbmf   2/2     Running   0          7s
nginx-deployment-8886d4dcf-pq457   2/2     Running   0          7s
nginx-deployment-8886d4dcf-5tkn8   2/2     Running   0          7s
```
>2. Создать Service, который обеспечит доступ внутри кластера до контейнеров приложения из п.1 по порту 9001 - nginx 80, по 9002 - multitool 8080.  
```
% kubectl get svc                            
NAME             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)             AGE
kubernetes       ClusterIP   10.152.183.1    <none>        443/TCP             13d
deployment-svc   ClusterIP   10.152.183.93   <none>        9001/TCP,9002/TCP   14s
```
>3. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложения из п.1 по разным портам в разные контейнеры
>4. Продемонстрировать доступ с помощью `curl` по доменному имени сервиса.
```
% kubectl exec multitool -- curl deployment-svc:9001
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
100   612  100   612    0     0  25155      0 --:--:-- --:--:-- --:--:-- 25500
```
```
% kubectl exec multitool -- curl deployment-svc:9002
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   153  100   153    0     0   9861      0 --:--:-- --:--:-- --:--:-- 10200
WBITT Network MultiTool (with NGINX) - nginx-deployment-8886d4dcf-pq457 - 10.1.254.115 - HTTP: 1180 , HTTPS: 11443 . (Formerly praqma/network-multitool)
```
> 5. Предоставить манифесты Deployment'а и Service в решении, а также скриншоты или вывод команды п.4  

Манифест: [deployment.yml](deployment.yml)

------

### Задание 2. Создать Service и обеспечить доступ к приложениям снаружи кластера

>1. Создать отдельный Service приложения из Задания 1 с возможностью доступа снаружи кластера к nginx используя тип NodePort.
```
% kubectl get svc
NAME                   TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                       AGE
kubernetes             ClusterIP   10.152.183.1    <none>        443/TCP                       13d
deployment-svc         ClusterIP   10.152.183.93   <none>        9001/TCP,9002/TCP             30m
deployment-svc-local   NodePort    10.152.183.91   <none>        80:31001/TCP,1180:31002/TCP   13m
```
>2. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.
```% kubectl get ep       
NAME                   ENDPOINTS                                                           AGE
kubernetes             192.168.64.2:16443                                                  13d
deployment-svc         10.1.254.113:1180,10.1.254.114:1180,10.1.254.115:1180 + 5 more...   18m
deployment-svc-local   10.1.254.113:8080,10.1.254.114:8080,10.1.254.115:8080 + 5 more...   2m27s
```
>3. Предоставить манифест и Service в решении, а также скриншоты или вывод команды п.2.  

Манифест: [local-svc.yml](local-svc.yml)
```
% curl 192.168.64.2:31001       
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
```
% curl 192.168.64.2:31002
WBITT Network MultiTool (with NGINX) - nginx-deployment-8886d4dcf-pq457 - 10.1.254.115 - HTTP: 1180 , HTTPS: 11443 . (Formerly praqma/network-multitool)
```
------