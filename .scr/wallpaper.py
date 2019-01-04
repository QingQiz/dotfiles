#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import os
import random
from os import system
from os import path

wallp = '/home/{}/Pictures/WallP'.format(os.environ['USER'])
socdir = path.split(path.relpath(__file__))[0]

pic = os.listdir(wallp)
siz = len(pic)

now = 0
try:
    now = open(path.join(socdir, '.nowpap'), 'r').read().strip('\n')
    now = int(now)
except:
    now = 0

nxt = 0
if len(sys.argv) == 1:
    nxt = now + 1
else:
    add = 1
    try:
        add = int(sys.argv[1])
    except:
        if sys.argv[1] == '-d':
            system('rm -f "{}"'.format(path.join(wallp, pic[now])))
        elif sys.argv[1] == '-r':
            add = random.randint(0, siz + 1)
    nxt = now + add

nxt %= siz

system('feh --bg-fill "{}"'.format(path.join(wallp, pic[nxt])))
open(path.join(socdir, '.nowpap'), 'w').write(str(nxt))


