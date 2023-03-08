#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed May 13 14:57:24 2020

@author: dimitris
"""


def pollute_the_planes(ax,ay,t):
    global i_have_to_be_one
    i_have_to_be_one = 1
    for (a,b) in airplanes:
        if (ax != a and ay != b):
            myMap[a][b] = t+7
            Deque.appendleft((a, b, t+7))
    return

def add_places(x, y, t):
    global N
    global M
    global i_have_to_be_one
    if (x > 0):
        if((myMap[x-1][y] < 0 or myMap[x-1][y] > t+2) and myMap[x-1][y] != (-6)):
            if (i_have_to_be_one == 0):
                if myMap[x-1][y] == (-2):
                    pollute_the_planes(x-1,y,t)
            myMap[x-1][y] = t+2
            Deque.appendleft((x-1,y,t+2))
    if (x < N-1):
        if((myMap[x+1][y] < 0 or myMap[x+1][y] > t+2) and myMap[x+1][y] != (-6)):
            if (i_have_to_be_one == 0):
                if myMap[x+1][y] == (-2):
                    pollute_the_planes(x+1,y,t)
            myMap[x+1][y] = t+2
            Deque.appendleft((x+1,y,t+2))
    if (y > 0):
        if((myMap[x][y-1] < 0 or myMap[x][y-1] > t+2) and myMap[x][y-1] != (-6)):
            if (i_have_to_be_one == 0):
                if myMap[x][y-1] == (-2):
                    pollute_the_planes(x,y-1,t)
            myMap[x][y-1] = t+2
            Deque.appendleft((x,y-1,t+2))
    if (y < M-1):
        if((myMap[x][y+1] < 0 or myMap[x][y+1] > t+2) and myMap[x][y+1] != (-6)):
            if (i_have_to_be_one == 0):
                if myMap[x][y+1] == (-2):
                    pollute_the_planes(x,y+1,t)
            myMap[x][y+1] = t+2
            Deque.appendleft((x,y+1,t+2))

def pollution():
    global i_have_to_be_one
    
    while Deque:
           
        (x, y, t) = Deque.pop()
        
        add_places(x,y,t)
    return

def bfs(hx, hy):
    global visited
    global path
    global M
    global N
    global counter
    while Deque:
        
        (x,y,t) = Deque.pop()
       
        if (x < N-1 and myMap[x+1][y] > t+1 and visited[x+1][y] == False):
            path[x+1][y] = 'D'
            visited[x+1][y] = True
            Deque.appendleft((x+1,y,t+1))
        if (y > 0 and myMap[x][y-1] > t+1 and visited[x][y-1] == False):
            path[x][y-1] = 'L'
            visited[x][y-1] = True
            Deque.appendleft((x,y-1,t+1))
        if (y < M-1 and myMap[x][y+1] > t+1 and visited[x][y+1] == False):
            path[x][y+1] = 'R'
            visited[x][y+1] = True
            Deque.appendleft((x,y+1,t+1))
        if (x > 0 and myMap[x-1][y] > t+1 and visited[x-1][y] == False):
            path[x-1][y] = 'U'
            visited[x-1][y] = True
            Deque.appendleft((x-1,y,t+1))
        if (visited[hx][hy] == True):
            break
    return  

def find_the_path(sx, sy):
    global path
    global moves
    while Deque2:
        moves = moves+1
        (x,y) = Deque2.pop()
        if (x,y) == (sx,sy):
            break
        elif path[x][y] == 'D':
            resque_path.appendleft('D')
            Deque2.append((x-1,y))
        elif path[x][y] == 'L':
            resque_path.appendleft('L')
            Deque2.append((x,y+1))
        elif path[x][y] == 'R':
            resque_path.appendleft('R')
            Deque2.append((x,y-1))
        elif path[x][y] == 'U':
            resque_path.appendleft('U')
            Deque2.append((x+1,y))
        
from collections import deque
myMap = deque(deque())
airplanes = deque()
virus = deque()
home = deque()
swter = deque()
i_have_to_be_one = 0

import sys
with open (sys.argv[1], 'rt') as f:
    c = 0
    r = 0
    M=0
    row=[]
    while True:
        ch = f.read(1)
        if ch == '':
            break
        if ch == '\n':
            if r==0:
                M = c
            r+=1
            c=0
            myMap.append(row)
            row=[]
            continue
        if ch == 'W':
            row.append(0)
            virus.append((r,c))
        elif ch == 'A':
            row.append(-2)
            airplanes.append((r,c))
        elif ch == 'T':
            row.append(-4)
            home.append((r,c))
        elif ch == 'S':
            row.append(-5)
            swter.append((r,c))
        elif ch == 'X':
            row.append(-6)
        else:
            row.append(-1)
        c+=1
   
N = r

#now we start the polution
(a,b) = virus.pop()   
(swter_x, swter_y) = swter.pop()
(home_x, home_y) = home.pop()
#we are polluting the place of virus
Deque = deque([(a, b, 0)])
pollution()

#we are going to find the path for swter
path = [['E' for x in range(M)] for i in range(N)]
visited = [[False for x in range(M)] for i in range(N)]
Deque.appendleft((swter_x, swter_y, 0))
visited[swter_x][swter_y] = True

bfs(home_x, home_y)
if visited[home_x][home_y] == False:
    print('IMPOSSIBLE')
else:
    Deque2 = deque()
    resque_path = deque()
    Deque2.appendleft((home_x,home_y))
    moves = -1
    find_the_path(swter_x,swter_y)

    print(moves)
    print(''.join(resque_path))

    