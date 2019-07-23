% 绘制三种类型的B样条曲线，需要前面所给的所有.m文件
%控制顶点
P = [ones(1,31),linspace(1.1,4,30),4*ones(1,30),fliplr(linspace(1,3.9,30));
    %2*ones(1,11),linspace(2.1,3,10),3*ones(1,10),fliplr(linspace(2,2.9,10));
    linspace(1,4,31),4*ones(1,30),fliplr(linspace(1,3.9,30)),ones(1,30)];
    %linspace(2,3,11),3*ones(1,10),fliplr(linspace(2,2.9,10)),2*ones(1,10)];

Q = [2*ones(1,11),linspace(2.1,3,10),3*ones(1,10),fliplr(linspace(2,2.9,10));
     linspace(2,3,11),3*ones(1,10),fliplr(linspace(2,2.9,10)),2*ones(1,10)];

n = 120; k = 3;
m = 40;
flag = 1;
% flag = 1，绘制均匀B样条曲线
% flag = 2, 绘制准均匀B样条曲线
% flag = 3, 绘制分段Bezier曲线

switch flag
    case 1
        NodeVector1 = linspace(0, 1, n+k+2); % 均匀B样条的节点矢量
        NodeVector2 = linspace(0, 1, m+k+2); % 均匀B样条的节点矢量
    plot(P(1, 1:n+1), P(2, 1:n+1),...
                        '.','LineWidth',1,...
                        'MarkerEdgeColor','k',...
                        'MarkerFaceColor','g',...
                        'MarkerSize',6);
    plot(Q(1, 1:m+1), Q(2, 1:m+1),...
                        '.','LineWidth',1,...
                        'MarkerEdgeColor','k',...
                        'MarkerFaceColor','g',...
                        'MarkerSize',6);
    %line(P(1,1:121), P(2,1:121))
    %line(P(1,122:n+1),P(2,122:n+1)) 
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
        
      Mik = zeros(m+1, 1);
        for u = k/(m+k+2) : 0.001 : (m+1)/(m+k+1)
        %for u = 0 : 0.005 : 1
            for i = 0 : 1 : m
                Mik(i+1, 1) = BaseFunction(i, k , u, NodeVector2);
            end
        q_u = Q * Mik;
        line(q_u(1,1),q_u(2,1), 'Marker','.','LineStyle','-', 'Color',[.3 .6 .9]);
        end  
    case 2
        NodeVector = U_quasi_uniform(n, k); % 准均匀B样条的节点矢量
        DrawSpline(n, k, P, NodeVector);
    case 3
        NodeVector = U_piecewise_Bezier(n, k);  % 分段Bezier曲线的节点矢量
        DrawSpline(n, k, P, NodeVector);
    otherwise
        fprintf('error!\n');
end
  % 绘制样条曲线
        