import numpy as np
import matplotlib.pyplot as plt

N=10000
x=np.linspace(0,1,N+1)
u=np.zeros(N+1)
u[0]=1
uexact=np.exp(x)
step=1/N

def eular(x,u):
    return u

for i in range(0,N):
    u[i+1] = u[i] + eular(x[i],u[i])*step
plt.plot(x,u-uexact)
plt.show()
