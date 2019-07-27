#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 24 20:55:48 2019

@author: zhoutiejun
"""

import numpy as np

X = np.linspace(-5,5,11)

def f(x):
    return 1/(x*x+1)

Y = np.zeros((11))

for i in range(11):
    Y[i] = f(X[i])
    
Z = np.zeros([11,11])

for i in range(11):
    Z[0][i] = Y[i]

for i in range(1,11):
    for j in range(0,11-i):
        Z[i][j] = (Z[i-1][j+1]-Z[i-1][j])/(X[j+i]-X[j])
#计算牛顿插值公式
def newton(x):
    y=0;
    for i in range(1,11):
        W=1;
        for j in range(1,i-1):
            W=W*(x-x(j)) #得到因子（x-x(k))
        y=y+Z[i][0]*W
      
    
        
        