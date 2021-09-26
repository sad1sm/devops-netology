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