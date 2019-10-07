clc;
clear;
format short e
a=0;b=pi;c=0;d=1;
N =input('请输入剖分数：');

h1 = (b-a)/N; 
h2 = (d-c)/N;
n = N +1 ;
x = linspace(a,b,n);
y = linspace(c,d,n);
%～～～～～～～～～～～～～～～精确解～～～～～～～～～～～～～～～～～～～%
ue = zeros(n,n);
for i = 1 : n
    for j =1 : n
        ue(i,j) = 1/(9+pi^2)*cos(3*x(i))*sin(pi*y(j));
    end
end
%矩阵变向量
UE = reshape(ue',[],1);
%～～～～～～～～～～～～～～～数值解～～～～～～～～～～～～～～～～～～～%
%右端项
f = zeros(n,n);
for j = 1:n
    for i =1:n
        f(i,j) = cos(3*x(i))*sin(pi*y(j));
    end
end
%矩阵变向量
F = reshape(f',[],1);

%创建系数矩阵
h12 = 1/h1^2;
h22 = 1/h2^2;

E = eye(n);

B = (h12+h22)*E - h12*diag(ones(1,n-1), 1)...
    - h12*diag(ones(1,n-1),-1);

C = (h12+h22)*E - h22*diag(ones(1,n-1), 1)...
    - h22*diag(ones(1,n-1),-1);

%考虑边界条件
B(1,1) = 1/2*h12 + h22;
B(n,n) = 1/2*h12 + h22;

A = kron(B,E)+kron(E,C);

%求解
U = A\F;
e = abs(UE - U);

u = reshape(U,n,n)';
norm = norm(e);
max = max(e);




