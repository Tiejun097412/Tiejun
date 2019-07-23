% P =[1,1,1,2,2,3,3,2,1;
%     1,2,3,3,2,2,1,1,1];

P=[ones(1,31),linspace(1.1,4,30),4*ones(1,30),fliplr(linspace(1,3.9,30)),1,1;
 linspace(1,4,31),4*ones(1,30),fliplr(linspace(1,3.9,30)),ones(1,30),1.2,1.4];
m = 123;
k=3;
plot(P(1,1:m), P(2,1:m),...
                        'o','LineWidth',1,...
                        'MarkerEdgeColor','k',...
                        'MarkerFaceColor','g',...
                        'MarkerSize',6);
                    
line(P(1,1:m), P(2,1:m));
%定义域：u3---> u9
%基函数：s3---> s8
%M3=[-1,3,-3,1;3,-6,3,0;-3,3,3,0;1,0,1,0];
M3 = [1,4,1,0;-3,0,3,0;3,-6,3,0;-1,3,-3,1];
syms t
s = t*ones(m+k+1,2);

T = [1,t,t*t,t*t*t];

for i = k : 1 : m+k-4
    A = 1/6 * T* M3 * [P(:,i+1-k),P(:,i+2-k),P(:,i+3-k),P(:,i+4-k)]';%1×2
    s(i,1) = A(1,1);
    s(i,2) = A(1,2);
end



for i = k : 1 : m+k-4
    a=subs(s(i,1),0:0.1:1);
    b=subs(s(i,2),0:0.1:1);
    line(a, b, 'Marker','.','LineStyle','--', 'Color','r');
end
        
