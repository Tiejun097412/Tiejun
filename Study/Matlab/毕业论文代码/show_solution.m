function show = show_solution(  )
%% SHOW_SOLUTION 可视化控制
show = struct('image',@image,'max_error',@max_error,...
    'L2_error',@L2_error,'rate',@rate,'image_3_3',@image_3_3,...
    'rate_figure_space',@rate_figure_space,'rate_figure_time',@rate_figure_time);
 
   function image( M,N,SDC)
        color =  {'-r^'};
        figure
            [ r,~,q ] = crank_weighted_method( M,N,SDC);
            plot( r,q( 1:end,end ),char(color( 1 ) ) );
            hold on;
            xlabel('r');ylabel( ['q( r,','s)'] );     
   end
    
    function Max_Error = max_error( M,N,SDC)
        Max_Error = zeros( length( M ),1 );
        for k = 1:length( M )
            [ r,s,q ] = crank_weighted_method( M(k),N(k),SDC);
            qe = SDC.exact( r,s,M(k),N(k));
            Max_Error( k,1 ) = max( max( abs( q - qe ) ) );
        end
    end
 
function image_3_3( r,s,q,qe )
        figure
        [ r,s ] = meshgrid(s,r);
        subplot(1,3,1)
        mesh( r,s,q );
        xlabel('s');ylabel('r');zlabel('$\overline{q}(r,s)$','interpreter','latex','FontSize',10);
%         title(['数值解图像']);
        subplot(1,3,2)
        mesh( r,s,qe );
        xlabel('s');ylabel('r');zlabel('$q(r,s)$','interpreter','latex','FontSize',10);
%         title(['真解图像']);
        subplot(1,3,3)
        mesh( r,s,abs(q-qe) );
        xlabel('s');ylabel('r');zlabel('$|\overline{q}(r,s)-q(r,s)|$','interpreter','latex','FontSize',10);
%         title(['误差图像']);
end

    function L2_Error = L2_error( M,N,SDC )
        L2_Error = zeros( length( M ),1 );
         for k = 1:length( M )
            [ r,s,q ] = crank_weighted_method( M(k),N(k),SDC);
            qe = SDC.exact( r,s,M(k),N(k));
            [ ~,dr ] = SDC.space_grid( M(k) );
            [ ~,ds ] = SDC.time_grid( N(k) );
           L2_Error( k,1 ) = sqrt( dr * ds * sum( sum( ( q - qe ).^2 ) ) );
         end
    end

    function Rate = rate(error)
        Rate = log2(error(1:end-1)./error(2:end));      
    end

    function rate_figure_space( M,N,SDC)
        figure
        Error=zeros( size(M) );
        step = Error;
        for k = 1:length( M )
            [ r,s,q ] =  crank_weighted_method( M(k),N(k),SDC);
            qe = SDC.exact( r,s,M(k),N(k));
            [ ~,dr ] = SDC.space_grid( M(k) );
            [ ~,ds ] = SDC.time_grid( N(k) );
            Error( k ) = sqrt( dr * ds * sum( sum( ( q - qe ).^2 ) ) );
            step( k ) = dr;
        end
        
        loglog( step,Error,'-r^' );
        hold on;
        loglog( step,step.^2,'-g*' );
        xlabel('log(r)');ylabel('loglog(error)');
        legend(' 观测阶 ','理论阶')
        title(' 空间观测阶与空间理论阶对比图')
    end

end
