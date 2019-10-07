#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 23 16:27:26 2019

@author: zhoutiejun
"""

import numpy as np

def factorial(n):
  if n==1:
    return 1
  else:
    return n * factorial(n-1)

def power(x,n):
  if n ==1:
    return x
  else:
    return x*power(x,n-1)

def exp_taylor(x,n):
  c = np.ones(n+1)
  for k in range(1,n):
    c[k] = power(x,k)/factorial(k)
    
  for k in range(n):
    s = []
    s.append(c[k])
  return s

result = exp_taylor(1,100)
print("%d",result)