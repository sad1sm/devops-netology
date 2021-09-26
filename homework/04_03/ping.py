#!/usr/bin/env python3

import socket
import time
import json
import yaml

wait = 2
services = {'drive.google.com':'', 'mail.google.com':'', 'google.com':''}

while 1==1 :
    for host in services:
        ip = socket.gethostbyname(host)
        if ip != services[host]:
            print(f'[ERROR] {host} IP mismatch: {services[host]} {ip}')
            with open(host+".json",'w') as js:
                js_data = json.dumps({host : ip})
                js.write(js_data)
            with open(host+".yaml",'w') as yml:
                yml_data = yaml.dump([{host : ip}])
                yml.write(yml_data)
            services[host]=ip
    time.sleep(wait)