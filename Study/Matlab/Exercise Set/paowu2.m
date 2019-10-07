 clc;
clear;
format short e
a=0;b=1;c=0;d=1;
N =input('请输入剖分数：');
h1 = (b-a)/N; 
n = N +1 ;
tau = 0.01;
tmax = 1;
x = linspace(a,b,n);
y = linspace(c,d,n);
k = tmax/tau+1;
T = linspace(0,tmax,2*k);
%～～～～～～～～～～～～～～～精确解～～～～～～～～～～～～～～～～～～～%
ue2d = zeros(N-1,N-1);%矩阵形式
for j = 1:N-1
    for i =1:N-1
        ue2d(i,j) = sin(pi*x(i+1))*cos(pi*y(j+1));%赋值
    end
end
%矩阵变向量
ue1d = reshape(ue2d',[],1);
g = zeros(1,2*k);

for i = 1:2*k
    g(1,i) = exp(-pi^2*T(i)/8);
end
UE = ue1d * g;
%～～～～～～～～～～～～～～～初值～～～～～～～～～～～～～～～～～～～～%
u0 = zeros(N-1,N-1);
for j = 1:N-1
    for i =1:N-1
        u0(i,j) = sin(pi*x(i+1))*cos(pi*y(j+1));
    end
end
%矩阵变向量
U0 = reshape(u0',[],1);

%～～～～～～～～～～～～～～～数值解～～～～～～～～～～～～～～～～～～～%
%创建系数矩阵
h2 = tau/(32*(h1^2));

E = eye(N-1);

B1 = (1+2*h2)*E - h2*diag(ones(1,N-2), 1)...
    -h2*diag(ones(1,N-2),-1);

B2 = (1-2*h2)*E + h2*diag(ones(1,N-2), 1)...
    + h2*diag(ones(1,N-2),-1);

l = zeros(1,N-1);
l(1,1) = h2;
l(1,end) = h2;
A0 = kron(E,diag(l));

A1 = kron(B1,E);


A02 = kron(E,B2);
A2 = A02 + A0;

A03 = kron(E,B1);
A3 = A03 - A0;

A4 = kron(B2,E);



%得到处理完边界之后的系数矩阵

% %求解
U = zeros((N-1)*(N-1),k);
U(:,1) = U0;
for i = 2 : 2 : 2*k
    U(:,i) = A1\(A2*U(:,i-1));
    U(:,i+1) = A3\(A4*U(:,i));
end

e = abs(U(:,end) - UE(:,end));

%范数
max = max(e);
ne = norm(e)/((N-1)*(N-1));
%误差图
e_hat = reshape(e,N-1,N-1);
x2 = x(2:end-1);
y2 = y(2:end-1);
[X,Y] = meshgrid(y2,x2);
surf(X,Y,e_hat);