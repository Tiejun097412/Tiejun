% 绘制三种类型的B样条曲线，需要前面所给的所有.m文件
%控制顶点
P = [ones(1,21),linspace(1.1,2,10),2*ones(1,10),linspace(2.1,3,10),3*ones(1,10),linspace(3,1,20),1,1;
    linspace(1,3,21),3*ones(1,10),linspace(2.9,2,10),2*ones(1,10),linspace(1.9,1,10),ones(1,20),1.1,1.2];

n = 82; k = 3;

flag = 1;
% flag = 1，绘制均匀B样条曲线
% flag = 2, 绘制准均匀B样条曲线
% flag = 3, 绘制分段Bezier曲线


NodeVector1 = linspace(0, 1, n+k+2); % 均匀B样条的节点矢量
plot(P(1, 1:n+1), P(2, 1:n+1),...
                        'o','LineWidth',1,...
                        'MarkerEdgeColor','k',...
                        'MarkerFaceColor','g',...
                        'MarkerSize',6);
    %%关于大矩形
Nik = zeros(n+1, 1);
for u = k/(n+k+1) : 0.001 : (n+1)/(n+k+1)%为了只在定义域中计算
%for u = 0 : 0.005 : 1
    for i = 0 : 1 : n
        Nik(i+1, 1) = BaseFunction(i, k , u, NodeVector1);
    end
    p_u = P * Nik;
    line(p_u(1,1), p_u(2,1), 'Marker','.','LineStyle','-', 'Color',[.3 .6 .9]);
end
      
pv=[1,1;1,3;2,3;2,2;3,2;3,1;1,1];
[p,t]=distmesh2d(@dpoly,@huniform,0.01,[-1,-1; 2,1],pv,pv);
        