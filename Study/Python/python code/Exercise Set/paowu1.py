import numpy as np

a=0;b=1;c=0;d=1
h1 = 0.2
tau = 0.01
tmax = 1
alpha = 1
x = np.linspace(a,b,1/h1 + 1)
y = np.linspace(c,d,1/h1 + 1)
k = int(tmax/tau)
#print(k)
T = np.linspace(0,tmax,2*k+1)
n = int(1/h1 -1)
#～～～～～～～～～～～～～～～初值～～～～～～～～～～～～～～～～～～～
u0 = np.zeros((n,n))#矩阵形式
U0 = u0.reshape(n**2,order = 'C')
       
#～～～～～～～～～～～～～～～数值解～～～～～～～～～～～～～～～～～～～
#余项
f2d = np.zeros((n,n));
for j in range(0,n-1):
    for i in range(0,n-1):
        f2d[i,j] = np.sin(2*np.pi*x[i+1])*np.sin(np.pi*y[j+1]);

#矩阵变向量
f1d = f2d.reshape(((n)**2,1),order = 'C');
g = np.zeros((1,2*k+1));

for i in range(0,2*k):
    g[0,i] = np.sin(5*np.pi*T[i]);

F = np.matmul(f1d,g);
#创建系数矩阵
h2 = tau/(2*(h1**2));

E = np.eye(n);

B1 = (1+2*h2)*np.eye(n) - h2*np.eye(n,k = 1) - h2*np.eye(n,k = -1);

B2 = (1-2*h2)*np.eye(n) + h2*np.eye(n,k = 1) + h2*np.eye(n,k = -1);

A1 = np.kron(B1,E);

A2 = np.kron(E,B2);

A3 = np.kron(E,B1);

A4 = np.kron(B2,E);
#得到处理完边界之后的系数矩阵
#求解
U = np.zeros((n**2,2*k))
U[:,0] = U0
##Error:could not broadcast input array from shape (16,1) into shape (16)
##debug:把U0 = u0.reshape((n**2,1),order = 'C')改为U0 = u0.reshape(n**2,order = 'C')

for i in range(0,2,2*k-1):
    U[:,i+1] = np.matmul(np.linalg.inv(A1),np.matmul(A2,U[:,i-1]) + tau*F[:,i])
    U[:,i+2] = np.matmul(np.linalg.inv(A3),np.matmul(A4,U[:,i+1]) + tau*F[:,i+1])


print(U[:,11])