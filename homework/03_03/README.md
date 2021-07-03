1. `chdir("/tmp") = 0`  
2. `openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3`  
3.   
Выясняем pid процесса `ps aux | grep processname`  
Смотрим содержимое `ls -lha /proc/$pid/fd` и видимо строку с нужными нам данными:  
`lrwx------ 1 user user 64 июл  3 13:52 3 -> '/path/to/file/error.log (deleted)'`  
Видим из строки выше что данные в дескрипторе 3. Дропаем содержимое `echo > /proc/$pid/fd/3`  
4. Зомби процессы занимаю незначительное количество памяти и pid.
5.  
```
vagrant@vagrant:~$ sudo opensnoop-bpfcc
PID    COMM               FD ERR PATH
606    irqbalance          6   0 /proc/interrupts
606    irqbalance          6   0 /proc/stat
606    irqbalance          6   0 /proc/irq/20/smp_affinity
606    irqbalance          6   0 /proc/irq/0/smp_affinity
606    irqbalance          6   0 /proc/irq/1/smp_affinity
606    irqbalance          6   0 /proc/irq/8/smp_affinity
606    irqbalance          6   0 /proc/irq/12/smp_affinity
606    irqbalance          6   0 /proc/irq/14/smp_affinity
606    irqbalance          6   0 /proc/irq/15/smp_affinity
```
6. 
`uname -a ` исользует системный вызов `uname()`  

man 2 uname:  
`Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.`  
7. Через `;` команды выполнятся друг за другом независимо от результата предыдущей команды. Через `&&` вторая команда начнет выполняться только в случае успешного завершения первой. Выставив в bash `set -e` смысла изсользовать `&&` нет, так как `set -e` заложен в конструкцию `&&` и bash завершит исполнение скрипта, если любая из команд завершится с ошибкой.  
8. `set -euxo pipefail`
```
-e      	завершение работы при ошибке для интерактивного режима работы shell;
-u      	считать ошибкой отсутствие параметра при подстановке;
-x	        вывод команд перед выполнением.
-o pipefail     прекращает выполнение скрипта, даже если одна из частей пайпа завершилась ошибкой.
```
Такую конструкцию хорошо использовать в сценариях так как с ней скрипт завершится в любой непонятной ситуации (будь то отсутствие файла, папки, прав или, например, отсутствие одной установленной переменной), и при этом мы будем иметь логирование и видеть что пытался сделать скрипт когда упал в ошибку.  
9. `ps a -o stat`  
Наиболее часто встречающийся статус это S (interruptible sleep), программы ожидающие какого-то вызова, которые можно прервать. Остальные буквы это дополнительные статусы (многопоточность, приоритет и т.д.)
