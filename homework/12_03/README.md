# Домашнее задание к занятию "Запуск приложений в K8S"

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod'а

1. Создать Deployment приложения состоящего из двух контейнеров - nginx и multitool. Решить возникшую ошибку  
[deployment.yml](deployment.yml)  
>Ошибка была в том, что внутри контейнера multilool тоже есть nginx и происходил конфликт портов. Из README.md к multitool узнал что решается это обозначением переменных HTTP_PORT & HTTPS_PORT. Порты переназначил.  
2. После запуска увеличить кол-во реплик работающего приложения до 2  
3. Продемонстрировать кол-во подов до и после масштабирования  
```bash
% kubectl get pods   
NAME                               READY   STATUS    RESTARTS   AGE
nginx-deployment-8886d4dcf-fngdz   2/2     Running   0          5m35s
```

```bash
% kubectl get pods 
NAME                               READY   STATUS    RESTARTS   AGE
nginx-deployment-8886d4dcf-fngdz   2/2     Running   0          7m40s
nginx-deployment-8886d4dcf-h249l   2/2     Running   0          5s       
```
4. Создать Service, который обеспечит доступ до реплик приложений из п.1  
[deployment-svc.yml](deployment-svc.yml)
```bash
% kubectl get svc                                                                              
NAME             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)           AGE
kubernetes       ClusterIP   10.152.183.1     <none>        443/TCP           13h
deployment-svc   ClusterIP   10.152.183.198   <none>        80/TCP,1180/TCP   22m
```
5. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl` что из пода есть доступ до приложений из п.1  
[multitool.yml](multitool.yml)
```bash
% kubectl get pods
NAME                               READY   STATUS    RESTARTS   AGE
nginx-deployment-8886d4dcf-fngdz   2/2     Running   0          48m
nginx-deployment-8886d4dcf-h249l   2/2     Running   0          48m
multitool                          1/1     Running   0          14s
```
```bash
% kubectl exec multitool -- curl http://10.152.183.198     
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
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   612  100   612    0     0   220k      0 --:--:-- --:--:-- --:--:--  298k
```
```bash
% kubectl exec multitool -- curl http://10.152.183.198:1180
WBITT Network MultiTool (with NGINX) - nginx-deployment-8886d4dcf-h249l - 10.1.254.78 - HTTP: 1180 , HTTPS: 11443 . (Formerly praqma/network-multitool)
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   152  100   152    0     0  74363      0 --:--:-- --:--:-- --:--:--  148k
```
------

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий

1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения  
[deployment-init.yml](deployment-init.yml)
2. Убедиться, что nginx не стартует. В качестве init-контейнера взять busybox
```bash
% kubectl apply -f 12_03/deployment-init.yml 
deployment.apps/nginx-init created
```
```bash
% kubectl get pods                              
NAME                               READY   STATUS       RESTARTS      AGE
nginx-deployment-8886d4dcf-fngdz   2/2     Running      0             84m
nginx-deployment-8886d4dcf-h249l   2/2     Running      0             84m
multitool                          1/1     Running      0             36m
nginx-init-7b749c9c6c-mtmqr        0/1     Init:Error   2 (28s ago)   33s
```
3. Создать и запустить Service. Убедиться, что nginx запустился  
[deployment-init-svc.yml](deployment-init-svc.yml)
```bash
% kubectl apply -f 12_03/deployment-init-svc.yml 
service/nginx-svc created
```
4. Продемонстрировать состояние пода до и после запуска сервиса
```bash
% kubectl get pods                              
NAME                               READY   STATUS       RESTARTS      AGE
nginx-deployment-8886d4dcf-fngdz   2/2     Running      0             84m
nginx-deployment-8886d4dcf-h249l   2/2     Running      0             84m
multitool                          1/1     Running      0             36m
nginx-init-7b749c9c6c-mtmqr        0/1     Init:Error   2 (28s ago)   33s
```
```bash
% kubectl get pods      
NAME                               READY   STATUS    RESTARTS   AGE
nginx-deployment-8886d4dcf-fngdz   2/2     Running   0          85m
nginx-deployment-8886d4dcf-h249l   2/2     Running   0          85m
multitool                          1/1     Running   0          36m
nginx-init-7b749c9c6c-mtmqr        1/1     Running   0          59s
```