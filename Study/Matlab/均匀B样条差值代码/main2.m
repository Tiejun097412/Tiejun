% 绘制三种类型的B样条曲线，需要前面所给的所有.m文件
%控制顶点
P = [ones(1,31),linspace(1.1,4,30),4*ones(1,30),linspace(3.9,1,30),1,1;
    linspace(1,4,31),4*ones(1,30),linspace(3.9,1,30),ones(1,30),1.2,1.4];
    

Q = [2*ones(1,11),linspace(2.1,3,10),3*ones(1,10),linspace(2.9,2,10),2,2;
    linspace(2,3,11),3*ones(1,10),linspace(2.9,2,10),2*ones(1,10),2.2,2.4];

n = 122; k = 3;
m = 42;

NodeVector1 = linspace(0, n+k+1, n+k+2); % 大矩形对应的均匀B样条的节点矢量
NodeVector2 = linspace(0, m+k+1, m+k+2); % 小矩形对应的均匀B样条的节点矢量

    plot(P(1, 1:n+1), P(2, 1:n+1),...
                        '.','LineWidth',1,...
                        'MarkerEdgeColor','k',...
                        'MarkerFaceColor','g',...
                        'MarkerSize',6);
    %line(P(1,1:n+1), P(2,1:n+1))
    
    plot(Q(1, 1:m+1), Q(2, 1:m+1),...
                        '.','LineWidth',1,...
                        'MarkerEdgeColor','k',...
                        'MarkerFaceColor','g',...
                        'MarkerSize',6);
    %打印控制点
    
   
    %%关于大矩形
        Nik = zeros(n+1, 1);
        for u = k: 0.1 : (n+1)%为了只在定义域中计算
       %for u = 0 : 0.005 : 1 
            for i = 0 : 1 : n
                Nik(i+1, 1) = BaseFunction(i, k , u, NodeVector1);
            end
        p_u = Nik'*P';
        line(p_u(1,1), p_u(1,2), 'Marker','.','LineStyle','--', 'Color','r');
        end
        
    %%关于小矩形
      Mik = zeros(m+1, 1);
        for u = k : 0.1 : (m+1)
        %for u = 0 : 0.005 : 1
            for i = 0 : 1 : m
                Mik(i+1, 1) = BaseFunction(i, k , u, NodeVector2);
            end
        q_u = Mik'*Q';
        line(q_u(1,1),q_u(1,2), 'Marker','.','LineStyle','-', 'Color','b');
        end  