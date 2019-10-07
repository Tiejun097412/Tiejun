import numpy as np

a=0;b=1;c=0;d=1
N = int(input('请输入剖分数：'))
h1 = (b-a)/N
n = N +1 
tau = 0.1
tmax = 1
x = np.linspace(a,b,n)
y = np.linspace(c,d,n)
k = int(tmax/tau+1)
#print(k)
T = np.linspace(0,tmax,2*k)
#～～～～～～～～～～～～～～～精确解～～～～～～～～～～～～～～～～～～～
ue2d = np.zeros((N-1,N-1))#矩阵形式
for j in range(0,N-2):
    for i in range(0,N-2):
        ue2d[i,j] = np.sin(np.pi*x[i+1])*np.cos(np.pi*y[j+1])#赋值
        
ue1d = ue2d.reshape(((N-1)**2,1),order = 'C')

f = np.zeros((1,2*k))
                                                
for i in range(0,2*k-1):
    f[0,i] = np.exp(-np.pi**2*T[i]/8)

UE = np.matmul(ue1d,f)
#～～～～～～～～～～～～～～～初值～～～～～～～～～～～～～～～～～～～～
u0 = np.zeros((N-1,N-1))
for j in range(0,N-2):
    for i in range(0,N-2):
        u0[i,j] = np.sin(np.pi*x[i+1])*np.cos(np.pi*y[j+1])

U0 = u0.reshape((N-1)**2,order = 'C')
        
#～～～～～～～～～～～～～～～数值解～～～～～～～～～～～～～～～～～～～
#创建系数矩阵
h2 = tau/(32*(h1**2))
E = np.eye(N-1)

B1 = (1+2*h2)*np.eye(N-1,k = 0) - h2*np.eye(N-1,k = 1) - h2*np.eye(N-1,k = -1)
B2 = (1-2*h2)*np.eye(N-1,k = 0) + h2*np.eye(N-1,k = 1) + h2*np.eye(N-1,k = -1)

l = np.zeros(N-1)
l[0] = h2
l[N-2] = h2
A0 = np.kron(E,np.diag(l))
A1 = np.kron(B1,E)
#print(A1)
#print(np.linalg.inv(A1))
A02 = np.kron(E,B2)
A2 = A02 + A0
#print(A2)
A03 = np.kron(E,B1)
A3 = A03 - A0
A4 = np.kron(B2,E)
#得到处理完边界之后的系数矩阵
#求解
U = np.zeros(((N-1)**2,2*k))
U[:,0] = U0

for i in range(1,2,k):
    U[:,i] = np.matmul(np.linalg.inv(A1)*A2,U[:,i-1])
    U[:,i+1] = np.matmul(np.linalg.inv(A3)*A4,U[:,i])

e = abs(U[:,k-1] - UE[:,k-1])
print(e)
#范数
max = np.linalg.norm(e,ord = np.inf)

print("无穷范数为：" ,max)

ne = np.linalg.norm(e,ord = 2)/(N-1)**2

print("L2范数为：" ,ne)
