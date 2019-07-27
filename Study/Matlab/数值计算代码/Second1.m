syms x 
%存储基函数
p = [1,x,x*x];
%原函数
f(x) = sin(pi*x);
%求解法方程组系数
A = zeros(3);
b = zeros(3,1);
%系数矩阵
for i = 1 : 1 : 3 
  for j = 1 : 1 : 3
    A(i,j) = int(p(i)*p(j),0,1);
  end
end
%
for i = 1 : 1 : 3
  b(i) = int(p(i)*f(x),0,1);
end 
%求解法方程组
c = A\b;
g(x) = c(1)*p(1)+c(2)*p(2)+c(3)*p(3);


a=subs(x,0:0.01:1);
b=subs(g(x),0:0.01:1);
c=subs(f(x),0:0.01:1);
line(a, b, 'Marker','.','LineStyle','--', 'Color','r');
line(a, c, 'Marker','.','LineStyle','--', 'Color','b');