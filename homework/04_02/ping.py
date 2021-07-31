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
