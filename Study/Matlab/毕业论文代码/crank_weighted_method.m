function [ r,s,q ] = crank_weighted_method( M,N,SDC)
%CRANK_WEIGHTED 算 法 摘 要
q = zeros(M+1,N+1);
r=linspace( 0,10,M+1);
wr= sin(r);
 
[ r,~ ] = SDC.space_grid( M );
[ s,ds ] = SDC.time_grid( N );
 
q(1:M+1,1) = SDC.initial_value( r );%q(0,r)
 
q(1,1:N+1) = SDC.left_boundary( s );
q(M+1,1:N+1) = SDC.right_boundary( s );
 
 
    for n = 1:N
        q( 2:M,n+1 ) = 1/3*(4*exp(1/2*ds)*exp(-1/2*ds*wr(2:M)').*q(2:M,n)-exp(ds)*exp(-ds*wr(2:M)').*q(2:M,n));
    end
end