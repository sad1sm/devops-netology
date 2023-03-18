# Домашнее задание к занятию "Хранение в K8s. Часть 1"

### Задание 1. Создать Deployment приложения, состоящего из двух контейнеров и обменивающихся данными

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Сделать так, чтобы busybox писал каждые 5 секунд в некий файл в общей директории.
3. Обеспечить возможность чтения файла контейнером multitool.
4. Продемонстрировать, что multitool может читать файл, который периодоически обновляется.
```bash
% kubectl apply -f dep-mult-busy.yml
deployment.apps/deployment-mb created
```
```bash
% kubectl get pods                    
NAME                             READY   STATUS    RESTARTS   AGE
deployment-mb-75fff47799-bdxls   2/2     Running   0          12s
```
```bash
% kubectl exec -it deployment-mb-75fff47799-bdxls -c busybox -- sh  
/ # cat /opt/log/health_check.log 
Hello, Netology! Sat Mar 18 19:27:44 UTC 2023
Hello, Netology! Sat Mar 18 19:27:49 UTC 2023
Hello, Netology! Sat Mar 18 19:27:54 UTC 2023
Hello, Netology! Sat Mar 18 19:27:59 UTC 2023
Hello, Netology! Sat Mar 18 19:28:04 UTC 2023
Hello, Netology! Sat Mar 18 19:28:09 UTC 2023
Hello, Netology! Sat Mar 18 19:28:14 UTC 2023
Hello, Netology! Sat Mar 18 19:28:19 UTC 2023
Hello, Netology! Sat Mar 18 19:28:24 UTC 2023
Hello, Netology! Sat Mar 18 19:28:29 UTC 2023
Hello, Netology! Sat Mar 18 19:28:34 UTC 2023
Hello, Netology! Sat Mar 18 19:28:39 UTC 2023
Hello, Netology! Sat Mar 18 19:28:44 UTC 2023
Hello, Netology! Sat Mar 18 19:28:49 UTC 2023
Hello, Netology! Sat Mar 18 19:28:54 UTC 2023
Hello, Netology! Sat Mar 18 19:28:59 UTC 2023
Hello, Netology! Sat Mar 18 19:29:04 UTC 2023
Hello, Netology! Sat Mar 18 19:29:09 UTC 2023
/ # 
```
```bash
% kubectl exec -it deployment-mb-75fff47799-bdxls -c multitool -- sh
/ # cat /opt/busy_log/health_check.log 
Hello, Netology! Sat Mar 18 19:27:44 UTC 2023
Hello, Netology! Sat Mar 18 19:27:49 UTC 2023
Hello, Netology! Sat Mar 18 19:27:54 UTC 2023
Hello, Netology! Sat Mar 18 19:27:59 UTC 2023
Hello, Netology! Sat Mar 18 19:28:04 UTC 2023
Hello, Netology! Sat Mar 18 19:28:09 UTC 2023
Hello, Netology! Sat Mar 18 19:28:14 UTC 2023
Hello, Netology! Sat Mar 18 19:28:19 UTC 2023
Hello, Netology! Sat Mar 18 19:28:24 UTC 2023
Hello, Netology! Sat Mar 18 19:28:29 UTC 2023
Hello, Netology! Sat Mar 18 19:28:34 UTC 2023
Hello, Netology! Sat Mar 18 19:28:39 UTC 2023
Hello, Netology! Sat Mar 18 19:28:44 UTC 2023
Hello, Netology! Sat Mar 18 19:28:49 UTC 2023
Hello, Netology! Sat Mar 18 19:28:54 UTC 2023
Hello, Netology! Sat Mar 18 19:28:59 UTC 2023
Hello, Netology! Sat Mar 18 19:29:04 UTC 2023
Hello, Netology! Sat Mar 18 19:29:09 UTC 2023
Hello, Netology! Sat Mar 18 19:29:14 UTC 2023
Hello, Netology! Sat Mar 18 19:29:19 UTC 2023
Hello, Netology! Sat Mar 18 19:29:24 UTC 2023
Hello, Netology! Sat Mar 18 19:29:29 UTC 2023
Hello, Netology! Sat Mar 18 19:29:34 UTC 2023
/ # 
```
5. Предоставить манифесты Deployment'а в решении, а также скриншоты или вывод команды п.4  
[dep-mult-busy.yml](dep-mult-busy.yml)

------

### Задание 2. Создать DaemonSet приложения, которое может прочитать логи ноды

1. Создать DaemonSet приложения состоящего из multitool.
2. Обеспечить возможность чтения файла `/var/log/syslog` кластера microK8S.
3. Продемонстрировать возможность чтения файла изнутри пода.
```bash
% kubectl apply -f daemon-set.yml 
daemonset.apps/ds-multitool created
```
```bash
% kubectl get daemonset                
NAME           DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
ds-multitool   1         1         1       1            1           <none>          53s
```
```bash
% kubectl get pods
NAME                             READY   STATUS             RESTARTS   AGE
deployment-mb-75fff47799-bdxls   2/2     Running            0          43m
ds-multitool-s9h7p               1/1     Running            0          79s
```
```bash
% kubectl exec -it ds-multitool-s9h7p -- tail -n 5 /opt/log/syslog
Mar 19 00:03:56 microk8s-vm microk8s.daemon-containerd[1090]: time="2023-03-19T00:03:56.772444540+03:00" level=info msg="Container exec \"2b4a8192da848be48547528885c6f7474d26f6c8cf31ae21a3abe0a3423843a7\" stdin closed"
Mar 19 00:04:11 microk8s-vm microk8s.daemon-kubelite[1092]: W0319 00:04:11.792248    1092 machine.go:65] Cannot read vendor id correctly, set empty.
Mar 19 00:04:18 microk8s-vm microk8s.daemon-containerd[1090]: time="2023-03-19T00:04:18.294846314+03:00" level=info msg="Container exec \"dc1166831a7fa2e916797157d7756456a2ab51359e5247c276d1f6eb86556856\" stdin closed"
Mar 19 00:04:18 microk8s-vm microk8s.daemon-containerd[1090]: time="2023-03-19T00:04:18.295970321+03:00" level=error msg="Failed to resize process \"dc1166831a7fa2e916797157d7756456a2ab51359e5247c276d1f6eb86556856\" console for container \"1fb77acdbf15ac350ef76aa18e1a48f3d96f40d5ecbe31eb2f0e3515a2d56e7c\"" error="cannot resize a stopped container: unknown"
Mar 19 00:05:10 microk8s-vm microk8s.daemon-containerd[1090]: time="2023-03-19T00:05:10.720966395+03:00" level=info msg="Container exec \"4402fa7733de839686cee809e91d5bdd0c7e0defbde4af91e7ad3eb075fdeaa7\" stdin closed"
```
4. Предоставить манифесты Deployment, а также скриншоты или вывод команды п.2  
[daemon-set.yml](daemon-set.yml)

