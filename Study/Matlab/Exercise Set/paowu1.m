clear
a=0;b=1;c=0;d=1;
h1 =  0.2;
tau = 0.01;
tmax = 1;
alpha = 1;
x = linspace(a,b,1/h1+1);
y = linspace(c,d,1/h1+1);
k = tmax/tau;
T = linspace(0,tmax,2*k+1);
n = 1/h1-1;
%～～～～～～～～～～～～～～～初值～～～～～～～～～～～～～～～～～～～～%
u0 = zeros(n,n);
%矩阵变向量
U0 = reshape(u0,[],1);

%～～～～～～～～～～～～～～～数值解～～～～～～～～～～～～～～～～～～～%
%余项
f2d = zeros(n,n);
for j = 1:n
    for i =1:n
        f2d(i,j) = sin(2*pi*x(i+1))*sin(pi*y(j+1));
    end
end
%矩阵变向量
f1d = reshape(f2d',[],1);
g = zeros(1,2*k+1);


for i = 1:(2*k+1)
    g(1,i) = sin(5*pi*T(i));
end
F = f1d * g;
%创建系数矩阵
h2 = tau/(2*(h1^2));

E = eye(n);

B1 = (1+2*h2)*E - h2*diag(ones(1,n-1), 1)...
    -h2*diag(ones(1,n-1),-1);

B2 = (1-2*h2)*E + h2*diag(ones(1,n-1), 1)...
    + h2*diag(ones(1,n-1),-1);

A1 = kron(B1,E);

A2 = kron(E,B2);

A3 = kron(E,B1);

A4 = kron(B2,E);

% %求解: ADI法
U = zeros(n*n,2*k+1);
U(:,1) = U0;
for i = 1 : 2 : 2*k
    U(:,i+1) = A1\(A2*U(:,i) + tau*F(:,i));
    U(:,i+2) = A3\(A4*U(:,i+1) + tau*F(:,i+1));
end

U_hat = reshape(U(:,end),n,n);
x2 = x(2:end-1);
y2 = y(2:end-1);
[X,Y] = meshgrid(y2,x2);
surf(X,Y,U_hat);