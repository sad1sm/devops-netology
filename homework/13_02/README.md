# Домашнее задание к занятию «Хранение в K8s. Часть 2»

### Задание 1

**Что нужно сделать**

Создать Deployment приложения, использующего локальный PV, созданный вручную.

1. Создать Deployment приложения, состоящего из контейнеров busybox и multitool.
2. Создать PV и PVC для подключения папки на локальной ноде, которая будет использована в поде.
```
 % kubectl apply -f mb-pv.yml -f mb-pvc.yml -f dep-mult-busy.yml
persistentvolume/mb-pv created
persistentvolumeclaim/mb-pvc created
deployment.apps/deployment-mb created
```
```
% kubectl get pods
NAME                             READY   STATUS    RESTARTS   AGE
deployment-mb-5cf664878c-mknpk   2/2     Running   0          31s
```
```
% kubectl get pv  
NAME    CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM            STORAGECLASS   REASON   AGE
mb-pv   512Mi      RWO            Delete           Bound    default/mb-pvc   host-path               2m19s
```
```
% kubectl get pvc
NAME     STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
mb-pvc   Bound    mb-pv    512Mi      RWO            host-path      2m33s
```
3. Продемонстрировать, что multitool может читать файл, в который busybox пишет каждые пять секунд в общей директории. 
```
% kubectl exec -it deployment-mb-5cf664878c-7x2ft -c busybox -- sh  
/ # cat /opt/log/health_check.log 
Hello, Netology! Sun Mar 19 08:33:47 UTC 2023
Hello, Netology! Sun Mar 19 08:33:52 UTC 2023
Hello, Netology! Sun Mar 19 08:33:57 UTC 2023
Hello, Netology! Sun Mar 19 08:34:02 UTC 2023
Hello, Netology! Sun Mar 19 08:34:07 UTC 2023
Hello, Netology! Sun Mar 19 08:34:12 UTC 2023
Hello, Netology! Sun Mar 19 08:34:17 UTC 2023
Hello, Netology! Sun Mar 19 08:34:22 UTC 2023
Hello, Netology! Sun Mar 19 08:34:27 UTC 2023
Hello, Netology! Sun Mar 19 08:34:32 UTC 2023
Hello, Netology! Sun Mar 19 08:34:37 UTC 2023
```
```
% kubectl exec -it deployment-mb-5cf664878c-7x2ft -c multitool -- sh
/ # cat /opt/busy_log/health_check.log 
Hello, Netology! Sun Mar 19 08:33:47 UTC 2023
Hello, Netology! Sun Mar 19 08:33:52 UTC 2023
Hello, Netology! Sun Mar 19 08:33:57 UTC 2023
Hello, Netology! Sun Mar 19 08:34:02 UTC 2023
Hello, Netology! Sun Mar 19 08:34:07 UTC 2023
Hello, Netology! Sun Mar 19 08:34:12 UTC 2023
Hello, Netology! Sun Mar 19 08:34:17 UTC 2023
Hello, Netology! Sun Mar 19 08:34:22 UTC 2023
Hello, Netology! Sun Mar 19 08:34:27 UTC 2023
Hello, Netology! Sun Mar 19 08:34:32 UTC 2023
Hello, Netology! Sun Mar 19 08:34:37 UTC 2023
Hello, Netology! Sun Mar 19 08:34:42 UTC 2023
Hello, Netology! Sun Mar 19 08:34:47 UTC 2023
Hello, Netology! Sun Mar 19 08:34:52 UTC 2023
Hello, Netology! Sun Mar 19 08:34:57 UTC 2023
Hello, Netology! Sun Mar 19 08:35:02 UTC 2023
Hello, Netology! Sun Mar 19 08:35:07 UTC 2023
Hello, Netology! Sun Mar 19 08:35:12 UTC 2023
Hello, Netology! Sun Mar 19 08:35:17 UTC 2023
```
```
% cat /opt/data/share/health_check.log
Hello, Netology! Sun Mar 19 08:33:47 UTC 2023
Hello, Netology! Sun Mar 19 08:33:52 UTC 2023
Hello, Netology! Sun Mar 19 08:33:57 UTC 2023
Hello, Netology! Sun Mar 19 08:34:02 UTC 2023
Hello, Netology! Sun Mar 19 08:34:07 UTC 2023
Hello, Netology! Sun Mar 19 08:34:12 UTC 2023
Hello, Netology! Sun Mar 19 08:34:17 UTC 2023
Hello, Netology! Sun Mar 19 08:34:22 UTC 2023
Hello, Netology! Sun Mar 19 08:34:27 UTC 2023
Hello, Netology! Sun Mar 19 08:34:32 UTC 2023
Hello, Netology! Sun Mar 19 08:34:37 UTC 2023
Hello, Netology! Sun Mar 19 08:34:42 UTC 2023
Hello, Netology! Sun Mar 19 08:34:47 UTC 2023
Hello, Netology! Sun Mar 19 08:34:52 UTC 2023
Hello, Netology! Sun Mar 19 08:34:57 UTC 2023
Hello, Netology! Sun Mar 19 08:35:02 UTC 2023
Hello, Netology! Sun Mar 19 08:35:07 UTC 2023
Hello, Netology! Sun Mar 19 08:35:12 UTC 2023
Hello, Netology! Sun Mar 19 08:35:17 UTC 2023
Hello, Netology! Sun Mar 19 08:35:22 UTC 2023
Hello, Netology! Sun Mar 19 08:35:27 UTC 2023
Hello, Netology! Sun Mar 19 08:35:32 UTC 2023
Hello, Netology! Sun Mar 19 08:35:37 UTC 2023
Hello, Netology! Sun Mar 19 08:35:42 UTC 2023
Hello, Netology! Sun Mar 19 08:35:47 UTC 2023
Hello, Netology! Sun Mar 19 08:35:52 UTC 2023
Hello, Netology! Sun Mar 19 08:35:57 UTC 2023
Hello, Netology! Sun Mar 19 08:36:02 UTC 2023
Hello, Netology! Sun Mar 19 08:36:07 UTC 2023
Hello, Netology! Sun Mar 19 08:36:12 UTC 2023
Hello, Netology! Sun Mar 19 08:36:17 UTC 2023
Hello, Netology! Sun Mar 19 08:36:23 UTC 2023
Hello, Netology! Sun Mar 19 08:36:28 UTC 2023
Hello, Netology! Sun Mar 19 08:36:33 UTC 2023
Hello, Netology! Sun Mar 19 08:36:38 UTC 2023
Hello, Netology! Sun Mar 19 08:36:43 UTC 2023
Hello, Netology! Sun Mar 19 08:36:48 UTC 2023
Hello, Netology! Sun Mar 19 08:36:53 UTC 2023
Hello, Netology! Sun Mar 19 08:36:58 UTC 2023
Hello, Netology! Sun Mar 19 08:37:03 UTC 2023
Hello, Netology! Sun Mar 19 08:37:08 UTC 2023
Hello, Netology! Sun Mar 19 08:37:13 UTC 2023
Hello, Netology! Sun Mar 19 08:37:18 UTC 2023
Hello, Netology! Sun Mar 19 08:37:23 UTC 2023
Hello, Netology! Sun Mar 19 08:37:28 UTC 2023
Hello, Netology! Sun Mar 19 08:37:33 UTC 2023
Hello, Netology! Sun Mar 19 08:37:38 UTC 2023
Hello, Netology! Sun Mar 19 08:37:43 UTC 2023
Hello, Netology! Sun Mar 19 08:37:48 UTC 2023
Hello, Netology! Sun Mar 19 08:37:53 UTC 2023
Hello, Netology! Sun Mar 19 08:37:58 UTC 2023
Hello, Netology! Sun Mar 19 08:38:03 UTC 2023
Hello, Netology! Sun Mar 19 08:38:08 UTC 2023
Hello, Netology! Sun Mar 19 08:38:13 UTC 2023
Hello, Netology! Sun Mar 19 08:38:18 UTC 2023
Hello, Netology! Sun Mar 19 08:38:23 UTC 2023
Hello, Netology! Sun Mar 19 08:38:28 UTC 2023
Hello, Netology! Sun Mar 19 08:38:33 UTC 2023
Hello, Netology! Sun Mar 19 08:38:38 UTC 2023
Hello, Netology! Sun Mar 19 08:38:43 UTC 2023
```
4. Продемонстрировать, что файл сохранился на локальном диске ноды, а также что произойдёт с файлом после удаления пода и deployment. Пояснить, почему.  
* При удалении пода он пересоздается, фаил присутствует.  
* При удалении деплоймента фаил остается, так как остался pv.  
* При удалении pvc+pv фаил остаётся, хотя я и имею в манифесте "persistentVolumeReclaimPolicy: Delete". Причиной этому является то, что эта опция срабатывает только в облачных хранилищах.
```
% kubectl delete deployment deployment-mb                      
deployment.apps "deployment-mb" deleted
% kubectl delete pvc mb-pvc              
persistentvolumeclaim "mb-pvc" deleted
% kubectl delete pv mb-pv  
persistentvolume "mb-pv" deleted
% cat /opt/data/share/health_check.log
Hello, Netology! Sun Mar 19 08:33:47 UTC 2023
Hello, Netology! Sun Mar 19 08:33:52 UTC 2023
Hello, Netology! Sun Mar 19 08:33:57 UTC 2023
...
```
5. Предоставить манифесты, а также скриншоты или вывод необходимых команд.  
[dep-mult-busy.yml](dep-mult-busy.yml)  
[mb-pvc.yml](mb-pvc.yml)  
[mb-pv.yml](mb-pv.yml)
------

### Задание 2

**Что нужно сделать**

Создать Deployment приложения, которое может хранить файлы на NFS с динамическим созданием PV.

1. Включить и настроить NFS-сервер на MicroK8S.
2. Создать Deployment приложения состоящего из multitool, и подключить к нему PV, созданный автоматически на сервере NFS.
```
$ kubectl get deployments,pvc,sc
NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/deployment-nfs   1/1     1            1           14m

NAME                            STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/nfs-pvc   Bound    pvc-52852fbf-68cc-49f9-8820-3f4ca2f82478   512Mi      RWO            nfs-csi        3m28s

NAME                                                      PROVISIONER            RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
storageclass.storage.k8s.io/microk8s-hostpath (default)   microk8s.io/hostpath   Delete          WaitForFirstConsumer   false                  24m
storageclass.storage.k8s.io/nfs-csi                       nfs.csi.k8s.io         Delete          Immediate              false                  103s
```
3. Продемонстрировать возможность чтения и записи файла изнутри пода. 
```bash
$ kubectl exec -it deployment-nfs-6475fdb497-csmjw  -- sh
/ # cd /opt/log/
/opt/log # ls
/opt/log # mkdir netology
/opt/log # touch netology.txt
/opt/log # echo "Hello, Netology!" > netology.txt 
/opt/log # cat netology.txt 
Hello, Netology!
/opt/log # ls
netology      netology.txt
/opt/log # exit
```
```bash
$ ls /srv/nfs/
pvc-52852fbf-68cc-49f9-8820-3f4ca2f82478
$ cd /srv/nfs/pvc-52852fbf-68cc-49f9-8820-3f4ca2f82478/
$ ls
netology  netology.txt
$ cat netology.txt 
Hello, Netology!
```
4. Предоставить манифесты, а также скриншоты или вывод необходимых команд.  
[sc-nfs.yaml](sc-nfs.yaml)   
[nfs-pvc.yml](nfs-pvc.yml)  
[dep-mult-nfs.yml](dep-mult-nfs.yml)