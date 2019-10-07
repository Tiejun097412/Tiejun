U0 = u0;
U1 = zeros(4,4);
U2 = zeros(4,4);
U3 = zeros(4,4);
%对于不同剖分，获取对应点的值
for i = 1:4
    for j = 1:4
        U1(i,j) = u1(2*i,2*j);
    end
end

for i = 1:4
    for j = 1:4
        U2(i,j) = u2(4*i,4*j);
    end
end

for i = 1:4
    for j = 1:4
        U3(i,j) = u3(8*i,8*j);
    end
end
%%矩阵拉直为向量
%将剖分最密的看作精确解ex
ex = reshape(U3,[],1);
%其余解
a0 = reshape(U0,[],1);
a1 = reshape(U1,[],1);
a2 = reshape(U2,[],1);
%误差
e0 = abs(a0 - ex);
e1 = abs(a1 - ex);
e2 = abs(a2 - ex);
%二范数
n0 = norm(e0);
n1 = norm(e1);
n2 = norm(e2);
%最大范数
m0 = max(e0);
m1 = max(e1);
m2 = max(e2);
%二范数的误差阶
lo1 = log2(n0/n1);
lo2 = log2(n1/n2);
%最大范数的误差阶
mo1 = log2(m0/m1);
mo2 = log2(m1/m2);
