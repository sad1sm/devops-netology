1. Узнал.
2. Не могут. Так как файл и жесткая ссылка на него ссылается на один и тот же inode и у них будут одни и те же разрешения.  
3. Сделал destroy, заменил содержимое файла.  
```
$ fdisk -l
Disk /dev/sda: 64 GiB, 68719476736 bytes, 134217728 sectors
Disk model: VBOX HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xfc48e488

Device     Boot   Start       End   Sectors  Size Id Type
/dev/sda1  *       2048   1050623   1048576  512M  b W95 FAT32
/dev/sda2       1052670 134215679 133163010 63.5G  5 Extended
/dev/sda5       1052672 134215679 133163008 63.5G 8e Linux LVM


Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/mapper/vgvagrant-root: 62.55 GiB, 67150807040 bytes, 131153920 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/mapper/vgvagrant-swap_1: 980 MiB, 1027604480 bytes, 2007040 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
```
4. 
```
$ fdisk /dev/sdb
n
p
1
2048
+2G
n
p
2
4196352
5242879
w
$ fdisk -l
...
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x5097a4d7

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdb1          2048 4196351 4194304    2G 83 Linux
/dev/sdb2       4196352 5242879 1046528  511M 83 Linux
...
```
5.
```
$ sfdisk -d /dev/sdb > sdb
$ sfdisk /dev/sdc < sdb
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new DOS disklabel with disk identifier 0x5097a4d7.
/dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 511 MiB.
/dev/sdc3: Done.

New situation:
Disklabel type: dos
Disk identifier: 0x5097a4d7

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdc1          2048 4196351 4194304    2G 83 Linux
/dev/sdc2       4196352 5242879 1046528  511M 83 Linux

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```
6.
```
$ mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
mdadm: size set to 2094080K
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.
```
7.
```
$ mdadm --create --verbose /dev/md1 --level=0 --raid-devices=2 /dev/sdb2 /dev/sdc2
mdadm: chunk size defaults to 512K
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md1 started.
```
8.
```
$ pvcreate /dev/md0
  Physical volume "/dev/md0" successfully created.
$ pvcreate /dev/md1
  Physical volume "/dev/md1" successfully created.
```
9.
``` 
$ vgcreate test_vg /dev/md0 /dev/md1
  Volume group "test_vg" successfully created
```
10.
```
$ lvcreate --name test_lv --size 100m test_vg /dev/md1
  Logical volume "test_lv" created.
```
11.
``` 
$ mkfs.ext4 /dev/test_vg/test_lv 
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done
```
12.  
`mkdir /tmp/new && mount /dev/test_vg/test_lv /tmp/new`  
13.
``` 
$ wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
--2021-07-10 17:35:32--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 20965422 (20M) [application/octet-stream]
Saving to: ‘/tmp/new/test.gz’

/tmp/new/test.gz    100%[===================>]  19.99M  29.9MB/s    in 0.7s    

2021-07-10 17:35:33 (29.9 MB/s) - ‘/tmp/new/test.gz’ saved [20965422/20965422]

$ ls /tmp/new/
test.gz
```
14.
```
$ lsblk
NAME                  MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                     8:0    0   64G  0 disk  
├─sda1                  8:1    0  512M  0 part  /boot/efi
├─sda2                  8:2    0    1K  0 part  
└─sda5                  8:5    0 63.5G  0 part  
  ├─vgvagrant-root    253:0    0 62.6G  0 lvm   /
  └─vgvagrant-swap_1  253:1    0  980M  0 lvm   [SWAP]
sdb                     8:16   0  2.5G  0 disk  
├─sdb1                  8:17   0    2G  0 part  
│ └─md0                 9:0    0    2G  0 raid1 
└─sdb2                  8:18   0  511M  0 part  
  └─md1                 9:1    0 1018M  0 raid0 
    └─test_vg-test_lv 253:2    0  100M  0 lvm   /tmp/new
sdc                     8:32   0  2.5G  0 disk  
├─sdc1                  8:33   0    2G  0 part  
│ └─md0                 9:0    0    2G  0 raid1 
└─sdc2                  8:34   0  511M  0 part  
  └─md1                 9:1    0 1018M  0 raid0 
    └─test_vg-test_lv 253:2    0  100M  0 lvm   /tmp/new
```
15.
``` 
$ gzip -t /tmp/new/test.gz
$ echo $?
0
```
16.
``` 
$ pvmove /dev/md1 /dev/md0
  /dev/md1: Moved: 100.00%
$ lsblk
NAME                  MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
sda                     8:0    0   64G  0 disk  
├─sda1                  8:1    0  512M  0 part  /boot/efi
├─sda2                  8:2    0    1K  0 part  
└─sda5                  8:5    0 63.5G  0 part  
  ├─vgvagrant-root    253:0    0 62.6G  0 lvm   /
  └─vgvagrant-swap_1  253:1    0  980M  0 lvm   [SWAP]
sdb                     8:16   0  2.5G  0 disk  
├─sdb1                  8:17   0    2G  0 part  
│ └─md0                 9:0    0    2G  0 raid1 
│   └─test_vg-test_lv 253:2    0  100M  0 lvm   /tmp/new
└─sdb2                  8:18   0  511M  0 part  
  └─md1                 9:1    0 1018M  0 raid0 
sdc                     8:32   0  2.5G  0 disk  
├─sdc1                  8:33   0    2G  0 part  
│ └─md0                 9:0    0    2G  0 raid1 
│   └─test_vg-test_lv 253:2    0  100M  0 lvm   /tmp/new
└─sdc2                  8:34   0  511M  0 part  
  └─md1                 9:1    0 1018M  0 raid0
```
17.
```
$ mdadm /dev/md0 --fail /dev/sdc1
mdadm: set /dev/sdc1 faulty in /dev/md0
$ cat /proc/mdstat 
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10] 
md1 : active raid0 sdc2[1] sdb2[0]
      1042432 blocks super 1.2 512k chunks
      
md0 : active raid1 sdc1[1](F) sdb1[0]
      2094080 blocks super 1.2 [2/1] [U_]
      
unused devices: <none>
```
18.
``` 
$dmesg | grep md0
[  204.470291] md/raid1:md0: not clean -- starting background reconstruction
[  204.470294] md/raid1:md0: active with 2 out of 2 mirrors
[  204.470381] md0: detected capacity change from 0 to 2144337920
[  204.472306] md: resync of RAID array md0
[  215.116197] md: md0: resync done.
[ 1388.308838] md/raid1:md0: Disk failure on sdc1, disabling device.
               md/raid1:md0: Operation continuing on 1 devices.
```
19.
``` 
$ gzip -t /tmp/new/test.gz
$ echo $?
0
```
20.
``` 
$ vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...
```