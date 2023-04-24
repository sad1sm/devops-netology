# Домашнее задание к занятию «Управление доступом»

### Задание 1. Создайте конфигурацию для подключения пользователя

1. Создайте и подпишите SSL-сертификат для подключения к кластеру.
```
$ openssl genrsa -out dev.key 2048
```
```
$ openssl req -new -key dev.key -out dev.csr -subj "/CN=dev"
```
```
$ openssl x509 -req -in dev.csr -CA /var/snap/microk8s/current/certs/ca.crt -CAkey /var/snap/microk8s/current/certs/ca.key -CAcreateserial -out dev.crt -days 500
Certificate request self-signature ok
subject=CN = dev
```
```
$ kubectl config set-credentials dev --client-certificate=.user_cert/dev.crt --client-key=.user_cert/dev.key
User "dev" set.
```
```
$ kubectl config set-context microk8s --cluster=microk8s-cluster --user=dev
Context "microk8s" modified.
```
2. Настройте конфигурационный файл kubectl для подключения.
3. Создайте роли и все необходимые настройки для пользователя.
4. Предусмотрите права пользователя. Пользователь может просматривать логи подов и их конфигурацию (`kubectl logs pod <pod_id>`, `kubectl describe pod <pod_id>`).

---

То что разрешено- работает:
```
$ kubectl get pods
NAME                   READY   STATUS    RESTARTS      AGE
nginx-c58dcfdb-v6tmn   1/1     Running   1 (22m ago)   40m
```
```
$ kubectl logs nginx-c58dcfdb-v6tmn
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: can not modify /etc/nginx/conf.d/default.conf (read-only file system?)
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2023/04/24 18:08:48 [notice] 1#1: using the "epoll" event method
2023/04/24 18:08:48 [notice] 1#1: nginx/1.23.4
2023/04/24 18:08:48 [notice] 1#1: built by gcc 10.2.1 20210110 (Debian 10.2.1-6) 
2023/04/24 18:08:48 [notice] 1#1: OS: Linux 5.15.0-69-generic
2023/04/24 18:08:48 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 65536:65536
2023/04/24 18:08:48 [notice] 1#1: start worker processes
2023/04/24 18:08:48 [notice] 1#1: start worker process 22
2023/04/24 18:08:48 [notice] 1#1: start worker process 23
10.1.77.24 - - [24/Apr/2023:18:12:06 +0000] "GET / HTTP/1.1" 200 120 "-" "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36" "45.183.156.26"
```
```
$ kubectl describe pod nginx-c58dcfdb-v6tmn
Name:             nginx-c58dcfdb-v6tmn
Namespace:        default
Priority:         0
Service Account:  default
Node:             k8s/10.128.0.8
Start Time:       Mon, 24 Apr 2023 17:32:42 +0000
Labels:           app=nginx
                  pod-template-hash=c58dcfdb
Annotations:      cni.projectcalico.org/containerID: c24493710553c045df34c6ce7f6cda2f5eee94e737cc5f7bdf82fc04d5060736
                  cni.projectcalico.org/podIP: 10.1.77.26/32
                  cni.projectcalico.org/podIPs: 10.1.77.26/32
Status:           Running
IP:               10.1.77.26
IPs:
  IP:           10.1.77.26
Controlled By:  ReplicaSet/nginx-c58dcfdb
Containers:
  nginx:
    Container ID:   containerd://50b725cb37c9ab732fcfae59cc6b01e0c4abf0c4a8e1e823d216f7489b830b66
    Image:          nginx:latest
    Image ID:       docker.io/library/nginx@sha256:63b44e8ddb83d5dd8020327c1f40436e37a6fffd3ef2498a6204df23be6e7e94
    Port:           443/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Mon, 24 Apr 2023 18:08:46 +0000
    Last State:     Terminated
      Reason:       Unknown
      Exit Code:    255
      Started:      Mon, 24 Apr 2023 17:32:44 +0000
      Finished:     Mon, 24 Apr 2023 17:50:21 +0000
    Ready:          True
    Restart Count:  1
    Environment:    <none>
    Mounts:
      /etc/nginx/conf.d/ from config-nginx (rw)
      /usr/share/nginx/html/ from html-nginx (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-qqmbt (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  html-nginx:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      nginx-page
    Optional:  false
  config-nginx:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      nginx-conf
    Optional:  false
  kube-api-access-qqmbt:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>
```
---
То что запрещено- не работает:
```
$ kubectl delete pod nginx-c58dcfdb-v6tmn
Error from server (Forbidden): pods "nginx-c58dcfdb-v6tmn" is forbidden: User "dev" cannot delete resource "pods" in API group "" in the namespace "default"
```
5. Предоставьте манифесты и скриншоты и/или вывод необходимых команд.  
[role.yml](role.yml)  
[role-rb.yml](role-rb.yml)
------
