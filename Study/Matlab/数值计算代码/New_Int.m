%保存文件名为New_Int.m
%Newton基本插值公式
%x为向量，全部的插值节点
%y为向量，差值节点处的函数值
%xi为标量，是自变量
%yi为xi出的函数估计值
function yi=New_Int(x,y,xi)
n=length(x);
m=length(y);
if n~=m
    error('The lengths of X ang Y must be equal!');
    return;
end
%计算均差表Y
Y=zeros(n);
Y(:,1)=y';  %将节点的函数值赋给Y的第一列
for k=1:n-1
    for i=1:n-k
        if abs(x(i+k)-x(i))<eps  %避免相邻两个数相等
            error('the DATA is error!');
            return;
        end
        Y(i,k+1)=(Y(i+1,k)-Y(i,k))/(x(i+k)-x(i))  %构造差商表
    end
end
%计算牛顿插值公式
yi=0;
for i=1:n
    z=1;
    for k=1:i-1
        z=z*(xi-x(k));  %得到因子（x-x(k))
    end
    yi=yi+Y(1,i)*z
end

New_Int([0.40 0.55 0.65 0.80 0.90],[0.41075 0.57815 0.69675 0.88811
1.02652],0.596);