# Домашнее задание к занятию "Сетевое взаимодействие в K8S. Часть 2"

### Задание 1. Создать Deployment приложений backend и frontend

>1. Создать Deployment приложения _frontend_ из образа nginx с кол-вом реплик 3 шт.
```bash
% kubectl apply -f front-dep.yml 
deployment.apps/frontend created
```
```bash
% kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
frontend-7f95d756c8-lnbhs   1/1     Running   0          7s
frontend-7f95d756c8-rgrm4   1/1     Running   0          7s
frontend-7f95d756c8-zcxlw   1/1     Running   0          7s
```
>2. Создать Deployment приложения _backend_ из образа multitool. 
```bash
% kubectl apply -f back-dep.yml 
deployment.apps/backend created
```
```bash
% kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
frontend-7f95d756c8-lnbhs   1/1     Running   0          75s
frontend-7f95d756c8-rgrm4   1/1     Running   0          75s
frontend-7f95d756c8-zcxlw   1/1     Running   0          75s
backend-7f859d8454-lrlkx    1/1     Running   0          7s
```
>3. Добавить Service'ы, которые обеспечат доступ к обоим приложениям внутри кластера. 
```bash
 % kubectl apply -f dep-svc.yml 
service/deployment-svc-fe-be created
service/deployment-svc-be created
service/deployment-svc-fe created
```
```bash
% kubectl get svc
NAME                   TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                       AGE
kubernetes             ClusterIP   10.152.183.1     <none>        443/TCP                       14d
deployment-svc-fe-be   NodePort    10.152.183.253   <none>        80:31001/TCP,1180:31002/TCP   9s
deployment-svc-be      ClusterIP   10.152.183.38    <none>        80/TCP                        9s
deployment-svc-fe      ClusterIP   10.152.183.101   <none>        80/TCP                        9s
```
>4. Продемонстрировать, что приложения видят друг друга с помощью Service.
```html
% kubectl exec backend-7f859d8454-lrlkx -- curl deployment-svc-fe-be:80
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   612  100   612    0     0  58235      0 --:--:-- --:--:-- --:--:-- 61200
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
```bash
% kubectl exec backend-7f859d8454-lrlkx -- curl deployment-svc-fe-be:1180
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   145  100   145    0     0  61544      0 --:--:-- --:--:-- --:--:-- 72500
WBITT Network MultiTool (with NGINX) - backend-7f859d8454-lrlkx - 10.1.254.120 - HTTP: 1180 , HTTPS: 11443 . (Formerly praqma/network-multitool)
```
>5. Предоставить манифесты Deployment'а и Service в решении, а также скриншоты или вывод команды п.4.

Манифесты:  
[front-dep.yml](front-dep.yml)  
[back-dep.yml](back-dep.yml)  
[dep-svc.yml](dep-svc.yml)  

------

### Задание 2. Создать Ingress и обеспечить доступ к приложениям снаружи кластера

>1. Включить Ingress-controller в microk8s
```bash
% microk8s enable ingress
Infer repository core for addon ingress
Enabling Ingress
ingressclass.networking.k8s.io/public created
ingressclass.networking.k8s.io/nginx created
namespace/ingress created
serviceaccount/nginx-ingress-microk8s-serviceaccount created
clusterrole.rbac.authorization.k8s.io/nginx-ingress-microk8s-clusterrole created
role.rbac.authorization.k8s.io/nginx-ingress-microk8s-role created
clusterrolebinding.rbac.authorization.k8s.io/nginx-ingress-microk8s created
rolebinding.rbac.authorization.k8s.io/nginx-ingress-microk8s created
configmap/nginx-load-balancer-microk8s-conf created
configmap/nginx-ingress-tcp-microk8s-conf created
configmap/nginx-ingress-udp-microk8s-conf created
daemonset.apps/nginx-ingress-microk8s-controller created
Ingress is enabled
```
>2. Создать Ingress, обеспечивающий доступ снаружи по IP-адресу кластера microk8s, так чтобы при запросе только по адресу открывался _frontend_ а при добавлении /api - _backend_
```bash
% kubectl apply -f ingress.yml 
ingress.networking.k8s.io/ingress created
```
```bash
% kubectl get ingress
NAME      CLASS    HOSTS   ADDRESS     PORTS   AGE
ingress   public   *       127.0.0.1   80      1m16s
```
>3. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера
```html
% curl 192.168.64.2           
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
```bash
% curl 192.168.64.2/api       
WBITT Network MultiTool (with NGINX) - backend-7f859d8454-lrlkx - 10.1.254.120 - HTTP: 1180 , HTTPS: 11443 . (Formerly praqma/network-multitool)
```
>4. Предоставить манифесты, а также скриншоты или вывод команды п.2

Манифест: [ingress.yml](ingress.yml)

------