1.    
Переменной $c будет присвоено значение a+b, так как мы не указали что это переменные, и bash просто записал в значение строку.  
Переменной $d будет присвоено 1+2, так как мы указали что a и b это переменные, но это все еще строка.  
Переменной $e будет присвоено 3, так как мы указали что хотим получить значение, результатом которого будет сложение переменных a и b.  
2.  
```
#!/usr/bin/env bash
while ((1==1))
do
curl https://localhost:4757
if (($?==0))
then
break
else
date >> curl.log
sleep 1
fi
done
```
3.  
``` 
#!/usr/bin/env bash
declare -i count
counter=5
array_ip=("192.168.0.1:80" "173.194.222.113:80" "87.250.250.242:80")
while (($counter > 0))
do
for ip in ${array_ip[@]}
do
{ echo; echo "$(date +%Y/%m/%d_%T) check $ip: "; curl --fail --silent --show-error --connect-timeout 2 $ip; } >> curl_ip.log 2>&1
done
let "counter -= 1"
sleep 1
done
``` 
```
f1tz@f1tz-linux:~$ cat curl_ip.log 


2021/07/27_15:34:43 check 192.168.0.1:80: 
curl: (28) Connection timed out after 2001 milliseconds

2021/07/27_15:34:45 check 173.194.222.113:80: 
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>

2021/07/27_15:34:45 check 87.250.250.242:80: 
curl: (22) The requested URL returned error: 406 Not acceptable

2021/07/27_15:34:46 check 192.168.0.1:80: 
curl: (28) Connection timed out after 2000 milliseconds

2021/07/27_15:34:48 check 173.194.222.113:80: 
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>

2021/07/27_15:34:49 check 87.250.250.242:80: 
curl: (22) The requested URL returned error: 406 Not acceptable

2021/07/27_15:34:50 check 192.168.0.1:80: 
curl: (28) Connection timed out after 2001 milliseconds

2021/07/27_15:34:52 check 173.194.222.113:80: 
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>

2021/07/27_15:34:52 check 87.250.250.242:80: 
curl: (22) The requested URL returned error: 406 Not acceptable

2021/07/27_15:34:53 check 192.168.0.1:80: 
curl: (28) Connection timed out after 2001 milliseconds

2021/07/27_15:34:55 check 173.194.222.113:80: 
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>

2021/07/27_15:34:55 check 87.250.250.242:80: 
curl: (22) The requested URL returned error: 406 Not acceptable

2021/07/27_15:34:56 check 192.168.0.1:80: 
curl: (28) Connection timed out after 2001 milliseconds

2021/07/27_15:34:58 check 173.194.222.113:80: 
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>

2021/07/27_15:34:58 check 87.250.250.242:80: 
curl: (22) The requested URL returned error: 406 Not acceptable
```
4.  
```
#!/usr/bin/env bash
declare -i avail
avail=1
array_ip=("173.194.222.113:80" "87.250.250.242:80" "192.168.0.1:80")
while (($avail == 1))
do
for ip in "${array_ip[@]}"
do
curl --connect-timeout 2 "$ip" > /dev/null 2>&1
if (($? != 0))
then
echo "$ip" > error.log
avail=0
break
fi
done
done
```
``` 
f1tz@f1tz-linux:~$ cat error.log 
192.168.0.1:80
```