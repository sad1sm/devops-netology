## Virtual Box & Vagrant

1-4. Установил Virtual Box, установил Vagrant, терминал установлен, конфигурацию файла Vagrantfile поправил.  

5. По-умолчанию создалась виртуальная машина с 2 ядрами процессора, 1 ГБ оперативной памяти, и диском на 64 ГБ с файловой системой LVM.  
1. Добавить оперативной памяти и ресурсов процессора можно указав дополнительные параметры в Vagrantfile:  
```
  v.memory = 1024  
  v.cpus = 2
```
7. `f1tz@linux:/home/f1tz/vagrant# vagrant ssh`
```
Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-73-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu 24 Jun 2021 07:12:23 PM UTC

  System load:  0.0               Processes:             109
  Usage of /:   2.4% of 61.31GB   Users logged in:       0
  Memory usage: 17%               IPv4 address for eth0: 10.0.2.15
  Swap usage:   0%


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Thu Jun 24 18:43:14 2021 from 10.0.2.2
vagrant@vagrant:~$ 
```
8. 
    8.1 Задать длину history можно переменной HISTSIZE, строка в man 1178.  
    8.2 ignoreboth включает два параметра: ignorespace - не сохранять св историю строки начинающиеся с пробела и ignoredups - не сохранять дублирующиеся строки.   
1. {} - используются в сценарии когда требуется построить список, строка в man 231.  
1. Для создания 100000 файлов используем конструкцию touch {1..100000}, 300000 файлов создать не получилось, слишком большой список аргументов.  
1. Выводит 1 (True) так как /tmp существует и это директория.
1. 
```
$ mkdir /tmp/new_path_directory/  
$ cp /bin/bash /tmp/new_path_directory/
$ PATH=/tmp/new_path_directory:$PATH
$ type -a bash
bash is /tmp/new_path_directory/bash
bash is /usr/bin/bash
bash is /bin/bash
```
13. at выполняет команды в определенное время, batch выполняет команды тогда, когда позволяет уровень средней нагрузки системы.
1.
```
vagrant@vagrant:~$ exit 
logout
Connection to 127.0.0.1 closed.
f1tz@linux:/home/f1tz/vagrant# vagrant halt
==> default: Attempting graceful shutdown of VM...
```
