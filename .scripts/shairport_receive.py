#!/usr/bin/python

import sys
import os

directory = '/tmp/shairport_control'

if not os.path.exists(directory):
    os.makedirs(directory)

def simple_write(name, data):
  fo = open(directory + '/' + name, 'w')
  fo.write(data)
  fo.close()

for line in sys.stdin:
  if 'Active-Remote' in line:
    simple_write('shairport_active_id', str(line.split('"')[1]))
    print(line.split('"')[1])
  if 'Connection from' in line:
    if 'IPv4' in line:
      print('IPv4')
      simple_write('shairport_ip', line.split(':')[-2].strip())
      simple_write('shairport_port', str(int(line.split(':')[-1]) - 1))
      print(int(line.split(':')[-1]) - 2)
    elif 'IPv6' in line:
      simple_write('shairport_ip', '[' + (':'.join(line.replace('::', 
':').split(':')[1:-1])).strip() + ']')
      simple_write('shairport_port', str(int(line.split(':')[-1]) - 2))
      print(int(line.split(':')[-1]) - 1)
