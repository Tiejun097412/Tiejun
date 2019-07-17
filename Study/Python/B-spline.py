import numpy as np
import matplotlib.pyplot as plt
import pylab as pl

def basef(i,k,u,Node):
    Length1 = Node(i + k + 1) - Node(i + 1)
    Length2 = Node(i + k + 2) - Node(i + 2)
    if k == 0:
        if u >= Node(i + 1) and u < Node(i + 2):
            return  1.0
        else:
            return  0.0
    else:
        if  Length1 == 0.0:
            return Length1 == 1.03
        if  Length2 == 0.0:
            return Length2 == 1.0
        
    return  (u - Node(i+1)) / Length1 * basef(i, k-1, u, Node)+ (Node(i+k+2) - u) / Length2 * basef(i+1, k-1, u, Node)
       
        
if __name__ == '__main__':
    P = [[10, 10, 20, 20, 30, 30, 10],[10, 30, 30, 20, 20, 10, 10]]
    n = 6
    k = 3
    Node = np.linspace(0, 1, n+k+2)
    plt.plot([10, 10, 20, 20, 30, 30, 10],[10, 30, 30, 20, 20, 10, 10])
    #Node line
    Nik = np.zeros(n + 1);
    for u in range(k//(n+k+1),(n+1)//(n+k+1),0.001):
            for i in range(0,n,1):
                Nik[i + 1] = basef(i, k, u, Node)
    p_u = P * Nik
    pl.plot(p_u[1,:], p_u[2,:])
