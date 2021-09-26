1.  
  * Для переменной c не будет назначено значение, так как сложение строки и числа не поддерживается.
``` 
>>> a = 1
>>> b = '2'
>>> c = a + b 
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unsupported operand type(s) for +: 'int' and 'str'
```
  * Что бы получить 12 нужно сложить строки:
``` 
>>> c = str(a) + str(b)
>>> print(c)
12
```
  * Что бы получить 3 нужно сложить числа:
``` 
>>> c = int(a) + int(b)
>>> print(c)
3
```
2.  
``` 
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
path = os.getcwd()
for result in result_os.split('\n'):
    if result.find('изменено') != -1:
        prepare_result = result.replace('\tизменено:      ', '')
        print(os.path.join(path, prepare_result))
```
Вывод:
``` 
f1tz@f1tz-linux:~/netology/sysadm-homeworks$ ./check.py 
/home/f1tz/netology/sysadm-homeworks/01-intro-01/README.md
/home/f1tz/netology/sysadm-homeworks/02-git-04-tools/README.md
```
3.  
``` 
#!/usr/bin/env python3

import os
import sys

if len(sys.argv) >= 2:
    path = sys.argv[1]
    bash_command = [f"cd {path}", "git status"]
else:
    path = os.getcwd()
    bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]

result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('изменено') != -1:
        prepare_result = result.replace('\tизменено:      ', '')
        print(os.path.join(path, prepare_result))
```
Вывод:
```
f1tz@f1tz-linux:~/netology/sysadm-homeworks$ ./check.py /home/f1tz/PycharmProjects/devops_netology/
/home/f1tz/PycharmProjects/devops_netology/has_been_moved.txt
/home/f1tz/PycharmProjects/devops_netology/homework/03_02/README.md
f1tz@f1tz-linux:~/netology/sysadm-homeworks$ ./check.py
/home/f1tz/netology/sysadm-homeworks/01-intro-01/README.md
/home/f1tz/netology/sysadm-homeworks/02-git-04-tools/README.md

```
4.  
``` 
#!/usr/bin/env python3

import socket
import time

wait = 2
services = {'drive.google.com':'', 'mail.google.com':'', 'google.com':''}

while 1==1 :
  for host in services:
    ip = socket.gethostbyname(host)
    if ip != services[host]:
        print(f'[ERROR] {host} IP mismatch: {services[host]} {ip}')
        services[host]=ip
    time.sleep(wait)
```
``` 
f1tz@f1tz-linux:~/PycharmProjects/devops_netology/homework/04_02$ ./ping.py 
[ERROR] drive.google.com IP mismatch:  142.250.150.194
[ERROR] mail.google.com IP mismatch:  108.177.14.83
[ERROR] google.com IP mismatch:  173.194.221.138
[ERROR] mail.google.com IP mismatch: 108.177.14.83 108.177.14.19
[ERROR] mail.google.com IP mismatch: 108.177.14.19 108.177.14.83
[ERROR] google.com IP mismatch: 173.194.221.138 173.194.221.113
[ERROR] mail.google.com IP mismatch: 108.177.14.83 108.177.14.19
[ERROR] google.com IP mismatch: 173.194.221.113 173.194.221.138
```