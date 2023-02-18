# Домашнее задание к занятию "Kubernetes. Причины появления. Команда kubectl"

### Задание 1. Установка MicroK8S

1. Установить MicroK8S на локальную машину или на удаленную виртуальную машину
```bash
% brew install ubuntu/microk8s/microk8s
Running `brew update --auto-update`...
==> Tapping ubuntu/microk8s
Cloning into '/opt/homebrew/Library/Taps/ubuntu/homebrew-microk8s'...
remote: Enumerating objects: 128, done.
remote: Counting objects: 100% (16/16), done.
remote: Compressing objects: 100% (12/12), done.
remote: Total 128 (delta 2), reused 10 (delta 1), pack-reused 112
Receiving objects: 100% (128/128), 34.72 KiB | 725.00 KiB/s, done.
Resolving deltas: 100% (29/29), done.
Tapped 1 formula (15 files, 55.9KB).
==> Downloading https://formulae.brew.sh/api/formula.json
######################################################################## 100.0%
==> Fetching dependencies for ubuntu/microk8s/microk8s: mpdecimal, openssl@1.1, readline, sqlite, xz, python and kubernetes-cli
==> Fetching mpdecimal
==> Downloading https://ghcr.io/v2/homebrew/core/mpdecimal/manifests/2.5.1
######################################################################## 100.0%
==> Downloading https://ghcr.io/v2/homebrew/core/mpdecimal/blobs/sha256:5b1c62c08b42feb6e48c461a9de4751803f3ccc76830213a517f0905178dbbef
==> Downloading from https://pkg-containers.githubusercontent.com/ghcr1/blobs/sha256:5b1c62c08b42feb6e48c461a9de4751803f3ccc76830213a517f0905178dbbef?se=2023-02-18T21%3A05%3A00Z&sig=P5508lD2iGwbfD9rKcf3FeBs9SK9KhillJ
######################################################################## 100.0%
==> Fetching openssl@1.1
==> Downloading https://ghcr.io/v2/homebrew/core/openssl/1.1/manifests/1.1.1t
######################################################################## 100.0%
==> Downloading https://ghcr.io/v2/homebrew/core/openssl/1.1/blobs/sha256:e1e08ddd93298ef8776b202e4b2f86fc519bf27a72f7cfb082b69ff2868a0175
==> Downloading from https://pkg-containers.githubusercontent.com/ghcr1/blobs/sha256:e1e08ddd93298ef8776b202e4b2f86fc519bf27a72f7cfb082b69ff2868a0175?se=2023-02-18T21%3A05%3A00Z&sig=PypjiF7yfzXeXzsuhtkXDxEIErxTTbH3vK
######################################################################## 100.0%
==> Fetching readline
==> Downloading https://ghcr.io/v2/homebrew/core/readline/manifests/8.2.1
######################################################################## 100.0%
==> Downloading https://ghcr.io/v2/homebrew/core/readline/blobs/sha256:fba42a9bd6feaa8902ae4491ffdf177662e0a165a0d0ddef0988ad6ecf0f23dd
==> Downloading from https://pkg-containers.githubusercontent.com/ghcr1/blobs/sha256:fba42a9bd6feaa8902ae4491ffdf177662e0a165a0d0ddef0988ad6ecf0f23dd?se=2023-02-18T21%3A05%3A00Z&sig=XHEL%2FzKkZt3SFt8BxsT9443f9oJC4wLd
######################################################################## 100.0%
==> Fetching sqlite
==> Downloading https://ghcr.io/v2/homebrew/core/sqlite/manifests/3.40.1
######################################################################## 100.0%
==> Downloading https://ghcr.io/v2/homebrew/core/sqlite/blobs/sha256:e19a160e1012ed0d58f0e1f631d6954c2bb6feb3cf9f8e9417d6f8955b81236d
==> Downloading from https://pkg-containers.githubusercontent.com/ghcr1/blobs/sha256:e19a160e1012ed0d58f0e1f631d6954c2bb6feb3cf9f8e9417d6f8955b81236d?se=2023-02-18T21%3A05%3A00Z&sig=P%2FKphztefMoSEMB%2BJ7ocwGsOM0w5P9
######################################################################## 100.0%
==> Fetching xz
==> Downloading https://ghcr.io/v2/homebrew/core/xz/manifests/5.4.1
######################################################################## 100.0%
==> Downloading https://ghcr.io/v2/homebrew/core/xz/blobs/sha256:26ede511c3cc726f939dd2f61b7e6798409c86b62be4678f008a12d515584efb
==> Downloading from https://pkg-containers.githubusercontent.com/ghcr1/blobs/sha256:26ede511c3cc726f939dd2f61b7e6798409c86b62be4678f008a12d515584efb?se=2023-02-18T21%3A05%3A00Z&sig=DrePyHpAOZKYsZ%2F0IzWF09xidHpUAKQg
######################################################################## 100.0%
==> Fetching python@3.11
==> Downloading https://ghcr.io/v2/homebrew/core/python/3.11/manifests/3.11.2_1
######################################################################## 100.0%
==> Downloading https://ghcr.io/v2/homebrew/core/python/3.11/blobs/sha256:ecbb2abe321f79eef540a9fa17b53ff56d2df7a4c613f068fe17e1202f2271f2
==> Downloading from https://pkg-containers.githubusercontent.com/ghcr1/blobs/sha256:ecbb2abe321f79eef540a9fa17b53ff56d2df7a4c613f068fe17e1202f2271f2?se=2023-02-18T21%3A05%3A00Z&sig=aqCQ0PS1xzaKBudQCJZqoFSi3gZYNid2tL
######################################################################## 100.0%
==> Fetching kubernetes-cli
==> Downloading https://ghcr.io/v2/homebrew/core/kubernetes-cli/manifests/1.26.1
######################################################################## 100.0%
==> Downloading https://ghcr.io/v2/homebrew/core/kubernetes-cli/blobs/sha256:5a831de10724c6d6d449d81135e93d6df7c947f18c11c282b47de92af017311b
==> Downloading from https://pkg-containers.githubusercontent.com/ghcr1/blobs/sha256:5a831de10724c6d6d449d81135e93d6df7c947f18c11c282b47de92af017311b?se=2023-02-18T21%3A05%3A00Z&sig=kYjqO0LJrDus3STABTk2ZTyOg1PkaSZ2Ks
######################################################################## 100.0%
==> Fetching ubuntu/microk8s/microk8s
==> Downloading https://github.com/canonical/microk8s/archive/refs/tags/installer-v2.3.1.tar.gz
==> Downloading from https://codeload.github.com/canonical/microk8s/tar.gz/refs/tags/installer-v2.3.1
#-#O=#  #                                                                     
==> Installing microk8s from ubuntu/microk8s
==> Installing dependencies for ubuntu/microk8s/microk8s: mpdecimal, openssl@1.1, readline, sqlite, xz, python and kubernetes-cli
==> Installing ubuntu/microk8s/microk8s dependency: mpdecimal
==> Pouring mpdecimal--2.5.1.arm64_ventura.bottle.tar.gz
==> Downloading https://formulae.brew.sh/api/cask.json
######################################################################## 100.0%
🍺  /opt/homebrew/Cellar/mpdecimal/2.5.1: 71 files, 2.2MB
==> Installing ubuntu/microk8s/microk8s dependency: openssl@1.1
==> Pouring openssl@1.1--1.1.1t.arm64_ventura.bottle.tar.gz
🍺  /opt/homebrew/Cellar/openssl@1.1/1.1.1t: 8,101 files, 18MB
==> Installing ubuntu/microk8s/microk8s dependency: readline
==> Pouring readline--8.2.1.arm64_ventura.bottle.tar.gz
🍺  /opt/homebrew/Cellar/readline/8.2.1: 50 files, 1.7MB
==> Installing ubuntu/microk8s/microk8s dependency: sqlite
==> Pouring sqlite--3.40.1.arm64_ventura.bottle.tar.gz
🍺  /opt/homebrew/Cellar/sqlite/3.40.1: 11 files, 4.4MB
==> Installing ubuntu/microk8s/microk8s dependency: xz
==> Pouring xz--5.4.1.arm64_ventura.bottle.tar.gz
🍺  /opt/homebrew/Cellar/xz/5.4.1: 95 files, 1.7MB
==> Installing ubuntu/microk8s/microk8s dependency: python
==> Pouring python@3.11--3.11.2_1.arm64_ventura.bottle.tar.gz
==> /opt/homebrew/Cellar/python@3.11/3.11.2_1/bin/python3.11 -m ensurepip
==> /opt/homebrew/Cellar/python@3.11/3.11.2_1/bin/python3.11 -m pip install -v --no-deps --no-index --upgrade --isolated --target=/opt/homebrew/lib/python3.11/site-packages /opt/homebrew/Cellar/python@3.11/3.11.2_1/F
🍺  /opt/homebrew/Cellar/python@3.11/3.11.2_1: 3,178 files, 62.2MB
==> Installing ubuntu/microk8s/microk8s dependency: kubernetes-cli
==> Pouring kubernetes-cli--1.26.1.arm64_ventura.bottle.tar.gz
🍺  /opt/homebrew/Cellar/kubernetes-cli/1.26.1: 231 files, 56.3MB
==> Installing ubuntu/microk8s/microk8s
==> python3 -m venv --system-site-packages /opt/homebrew/Cellar/microk8s/2.3.1/libexec
==> /opt/homebrew/Cellar/microk8s/2.3.1/libexec/bin/pip install -v --no-deps --no-binary :all: --use-feature=no-binary-enable-wheel-cache --ignore-installed urllib3==1.26.5 click==7.1.2 progressbar33==2.4 psutil==5.9
==> /opt/homebrew/Cellar/microk8s/2.3.1/libexec/bin/pip install -v --no-deps --no-binary :all: --use-feature=no-binary-enable-wheel-cache --ignore-installed /private/tmp/microk8s-20230218-68185-tstxns/microk8s-instal
==> Caveats
Run `microk8s install` to start with MicroK8s
==> Summary
🍺  /opt/homebrew/Cellar/microk8s/2.3.1: 2,794 files, 30.0MB, built in 25 seconds
==> Running `brew cleanup microk8s`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
==> Caveats
==> microk8s
Run `microk8s install` to start with MicroK8s
```
```bash
% microk8s install
Support for 'multipass' needs to be set up. Would you like to do that now? [y/N]: y
==> Downloading https://github.com/canonical/multipass/releases/download/v1.11.1/multipass-1.11.1+mac-Darwin.pkg
==> Downloading from https://objects.githubusercontent.com/github-production-release-asset-2e65be/114128199/129ead96-924d-4d74-842b-e08aba49a72c?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%
######################################################################## 100.0%
==> Installing Cask multipass
==> Running installer for multipass; your password may be necessary.
Package installers may write to any location; options such as `--appdir` are ignored.
installer: Package name is multipass
installer: Installing at base path /
installer: The install was successful.
🍺  multipass was successfully installed!
Waiting for multipass...
warning: "--mem" long option will be deprecated in favour of "--memory" in a future release.Please update any scripts, etc.
Launched: microk8s-vm                                                           
2023-02-18T21:01:30Z INFO Waiting for automatic snapd restart...
microk8s (1.26/stable) v1.26.1 from Canonical✓ installed
microk8s-integrator-macos 0.1 from Canonical✓ installed
MicroK8s is up and running. See the available commands with `microk8s --help`.
```
2. Установить dashboard
```bash
% microk8s enable dashboard       
Infer repository core for addon dashboard
Enabling Kubernetes Dashboard
Infer repository core for addon metrics-server
Enabling Metrics-Server
serviceaccount/metrics-server created
clusterrole.rbac.authorization.k8s.io/system:aggregated-metrics-reader created
clusterrole.rbac.authorization.k8s.io/system:metrics-server created
rolebinding.rbac.authorization.k8s.io/metrics-server-auth-reader created
clusterrolebinding.rbac.authorization.k8s.io/metrics-server:system:auth-delegator created
clusterrolebinding.rbac.authorization.k8s.io/system:metrics-server created
service/metrics-server created
deployment.apps/metrics-server created
apiservice.apiregistration.k8s.io/v1beta1.metrics.k8s.io created
clusterrolebinding.rbac.authorization.k8s.io/microk8s-admin created
Metrics-Server is enabled
Applying manifest
serviceaccount/kubernetes-dashboard created
service/kubernetes-dashboard created
secret/kubernetes-dashboard-certs created
secret/kubernetes-dashboard-csrf created
secret/kubernetes-dashboard-key-holder created
configmap/kubernetes-dashboard-settings created
role.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard created
rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
deployment.apps/kubernetes-dashboard created
service/dashboard-metrics-scraper created
deployment.apps/dashboard-metrics-scrape
```
3. Сгенерировать сертификат для подключения к внешнему ip-адресу  
Не требуется для локальной установки.
------

### Задание 2. Установка и настройка локального kubectl
1. Установить на локальную машину kubectl
```bash
% kubectl version --short         
Client Version: v1.26.1
Kustomize Version: v4.5.7
Server Version: v1.26.1
```
2. Настроить локально подключение к кластеру
```bash
% microk8s config > ~/.kube/config
```
3. Подключиться к дашборду с помощью port-forward  
Получаю токен:
```bash
% microk8s kubectl -n kube-system describe secret $(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
Name:         kubernetes-dashboard-certs
Namespace:    kube-system
Labels:       k8s-app=kubernetes-dashboard
Annotations:  <none>

Type:  Opaque

Data
====


Name:         microk8s-dashboard-token
Namespace:    kube-system
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: default
              kubernetes.io/service-account.uid: 16094db3-da21-4817-89c8-405d43acd74a

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1123 bytes
namespace:  11 bytes
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IjJLUlBWTjJaTEJfaG5QZWM2cFpjYmxReHg0NUJhajJpelNkLUV4VlIxRVEifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJtaWNyb2s4cy1kYXNoYm9hcmQtdG9rZW4iLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjE2MDk0ZGIzLWRhMjEtNDgxNy04OWM4LTQwNWQ0M2FjZDc0YSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlLXN5c3RlbTpkZWZhdWx0In0.B5qwo_sA0Qr57nv-Whq7V1Ne-B_vwvBNV5LxOzRs1IpmJHGecO3NLQfMi5yaWiqFPEmGlxpu6YQMhF1GBQURk0o4X8lziL9c3Lom0u5i-IFvE9YXcXEHhhfIZ7Q7RP5pLTYqL9DUeRAkgHS_16zXYiXz7vANkDvz61jPhTeeoUfqc09nThiYEmPy87GLyygtpBp3LJR6hifx57gPkE470QUJfQRJ5dVPWB4wKz9wf80OYj1NdRUuo-cNVam6lpf1QkbDmn9ll1LgpWf5MOaD4SmpsY6GTDN7CkCnMURgHHWVVh9qMOfDvBlhlfPUn_f3hsVsGrBfe-SdyAhWoYqYlw


Name:         kubernetes-dashboard-csrf
Namespace:    kube-system
Labels:       k8s-app=kubernetes-dashboard
Annotations:  <none>

Type:  Opaque

Data
====
csrf:  256 bytes


Name:         kubernetes-dashboard-key-holder
Namespace:    kube-system
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
priv:  1679 bytes
pub:   459 bytes
```
Пробрасываю порт:
```bash
% sudo microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard 10443:443 --address 0.0.0.0
Forwarding from 0.0.0.0:10443 -> 8443
```
Вывод `kubectl get nodes`
```bash
% kubectl get nodes
NAME          STATUS   ROLES    AGE   VERSION
microk8s-vm   Ready    <none>   34m   v1.26.1
```
Скрин дашборда:

![](screen.png)