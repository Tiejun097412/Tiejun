%   时间：10-May-2019
%   M：r方向区间剖分数(空间）
%   N：s方向区间剖分数（时间）
%   left_condation：左边值条件
%   right_condation：右边值条件
%   initial_condation：初值条件
clear;clc;
Lr = 0; Rr = 10; Ls = 0; Rs = 1/2;
M = 256; N = 256;
left_condation = @( s ) exp((1-sin(0))*s).*ones(1,N+1);
right_condation = @( s ) exp((1-sin(10))*s).*ones(1,N+1);
initial_condation = @( r ) ones(1,N+1);
 
exact = @(r,s) exp((1-sin(r))*s);
 
show = show_solution( );
 
SDC = model_date( Lr,Rr,Ls,Rs,left_condation,right_condation,...
    initial_condation,exact);
[ r,s,q ] = crank_weighted_method( M,N,SDC);
qe = SDC.exact( r,s,M,N);
show.image( M,N,SDC);
show.image_3_3( r,s,q,qe )
max_error = show.max_error( M,N,SDC);
max_rate = show.rate(max_error);
L2_error = show.L2_error(M,N,SDC);
L2_rate = show.rate(L2_error);
show.rate_figure_space( M,N,SDC);


%show.rate_figure_time( M,N,SDC);
disp( '          M=N   max_error:       max_rate   L2_error:     L2_rate');
format short g
disp([M,max_error,vertcat( NaN,max_rate ),L2_error,vertcat( NaN,L2_rate )])