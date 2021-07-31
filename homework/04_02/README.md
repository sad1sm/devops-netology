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

import os
import socket

hostm = "mail.google.com"
hostd = "drive.google.com"
hostg = "google.com"
ism = r"ipstore.mail"
isd = r"ipstore.drive"
isg = r"ipstore.google"

# check mail.google.com
if os.path.isfile(ism):
    file = open(ism, 'r+')
    storip = file.read()
    file.close()
    ipaddr = socket.gethostbyname(hostm)
    if storip != ipaddr:
        ipaddr = socket.gethostbyname(hostm)
        file = open(ism, 'w')
        file.write(ipaddr)
        file.truncate()
        file.close()
        print("[ERROR] {0} IP mismatch: {1} - {2}".format(hostm, storip, ipaddr))
    else:
        print("{0} - {1}".format(hostm, storip))
else:
    ipaddr = socket.gethostbyname(hostm)
    file = open(ism, 'w')
    file.write(ipaddr)
    file.truncate()
    file.close()

# check drive.google.com
if os.path.isfile(isd):
    file = open(isd, 'r+')
    storip = file.read()
    file.close()
    ipaddr = socket.gethostbyname(hostd)
    if storip != ipaddr:
        ipaddr = socket.gethostbyname(hostd)
        file = open(isd, 'w')
        file.write(ipaddr)
        file.truncate()
        file.close()
        print("[ERROR] {0} IP mismatch: {1} - {2}".format(hostd, storip, ipaddr))
    else:
        print("{0} - {1}".format(hostd, storip))
else:
    ipaddr = socket.gethostbyname(hostd)
    file = open(isd, 'w')
    file.write(ipaddr)
    file.truncate()
    file.close()

# check google.com
if os.path.isfile(isg):
    file = open(isg, 'r+')
    storip = file.read()
    file.close()
    ipaddr = socket.gethostbyname(hostg)
    if storip != ipaddr:
        ipaddr = socket.gethostbyname(hostg)
        file = open(isg, 'w')
        file.write(ipaddr)
        file.truncate()
        file.close()
        print("[ERROR] {0} IP mismatch: {1} - {2}".format(hostg, storip, ipaddr))
    else:
        print("{0} - {1}".format(hostg, storip))
else:
    ipaddr = socket.gethostbyname(hostg)
    file = open(isg, 'w')
    file.write(ipaddr)
    file.truncate()
    file.close()
```
``` 
f1tz@f1tz-linux:~/PycharmProjects/devops_netology/homework/04_02$ ./ping.py 
mail.google.com - 173.194.222.19
drive.google.com - 173.194.222.194
google.com - 74.125.131.113

f1tz@f1tz-linux:~/PycharmProjects/devops_netology/homework/04_02$ ./ping.py 
[ERROR] mail.google.com IP mismatch: 173.194.222.19 - 64.233.165.17
drive.google.com - 173.194.222.194
[ERROR] google.com IP mismatch: 74.125.131.113 - 64.233.165.138

f1tz@f1tz-linux:~/PycharmProjects/devops_netology/homework/04_02$ ./ping.py 
mail.google.com - 64.233.165.17
drive.google.com - 173.194.222.194
google.com - 64.233.165.138

f1tz@f1tz-linux:~/PycharmProjects/devops_netology/homework/04_02$ ./ping.py 
[ERROR] mail.google.com IP mismatch: 64.233.165.17 - 64.233.165.83
drive.google.com - 173.194.222.194
google.com - 64.233.165.138

f1tz@f1tz-linux:~/PycharmProjects/devops_netology/homework/04_02$ ./ping.py 
[ERROR] mail.google.com IP mismatch: 64.233.165.83 - 173.194.222.83
drive.google.com - 173.194.222.194
[ERROR] google.com IP mismatch: 64.233.165.138 - 74.125.131.101

f1tz@f1tz-linux:~/PycharmProjects/devops_netology/homework/04_02$ ./ping.py 
mail.google.com - 173.194.222.83
drive.google.com - 173.194.222.194
google.com - 74.125.131.101
```