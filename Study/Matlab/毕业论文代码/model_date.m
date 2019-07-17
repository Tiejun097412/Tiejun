function SDC = model_date( Lr,Rr,Ls,Rs,left_condation,right_condation,...
    initial_condation,Exact )
%%  MODEL_DATE ：ＭDE
 
 
SDC = struct('space_grid',@space_grid,'time_grid',@time_grid,...
    'left_boundary',@left_boundary,'right_boundary',@right_boundary,...
    'initial_value',@initial_value,'exact',@exact);
 
    function    [ r,dr ] = space_grid( M )
        dr = ( Rr - Lr ) / M;
        r = linspace( Lr,Rr,M+1 );
    end
 
    function    [ s,ds ] = time_grid( N )
        ds = ( Rs - Ls ) / N;
        s = linspace( Ls,Rs,N+1 );
    end
 
    function q = initial_value( r )
        q = initial_condation( r );
    end
 
    function q = left_boundary( s )
        q = left_condation( s );
    end
 
    function q = right_boundary( s )
        q = right_condation( s );
    end
 
    function q = exact( r,s,M,N)
        q = zeros( M + 1,N + 1 );
        for i = 1:M + 1
            q(i,1:end) = Exact( r(i),s);
        end
    end
 
end