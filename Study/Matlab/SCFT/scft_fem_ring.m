clear;
clc;
close all;


%% PDE Method
Mthd.PDE = 'ImplicitCN';
Mthd.Iter = 'Euler';

%% cmp_mesh 
% Rg=5;
% rg=1;
h=0.2;
% fd=@(p) ddiff(dcircle(p,0,0,Rg),dcircle(p,0,0,rg));
% [node,elem]=distmesh2d(fd,@huniform,h,Rg*[-1,-1;1,1],[]);

fd=@(p) ddiff(drectangle(p,-1,1,-1,1),drectangle(p,-0.3,0.3,-0.3,0.3));
fh=@(p) 0.05+0.3*drectangle(p,-0.3,0.3,-0.3,0.3);
[node,elem]=distmesh2d(fd,fh,h,[-1,-1;1,1],[-1,-1;-1,1;1,-1;1,1;...
    -0.3,-0.3;-0.3,0.3;0.3,-0.3;0.3,0.3]);

% [node,elem]=uniformrefine(node,elem);
init_mesh.node = node;
init_mesh.elem = elem;
cmp_mesh = get_cmp_mesh(init_mesh);
disp(cmp_mesh.N);

%% sys_pmt
sys_pmt.Nspecies = 2;
sys_pmt.Nblend   = 1; %一条链
sys_pmt.Nblock   = 2; 
sys_pmt.Ndeg  	 = 100; %聚合度
sys_pmt.fA       = 0.5;
sys_pmt.chiAB 	 = 0.25;

%% cmp_pmt
cmp_pmt = get_cmp_pmt(sys_pmt, cmp_mesh);
cmp_pmt.TOL = 1.0e-6;
cmp_pmt.dtMax  = 0.05;
cmp_pmt.Initer = 20;


%% scft_data
[scft, scftAux] = get_scft_data(sys_pmt, cmp_pmt);

chiN = sys_pmt.chiAB*sys_pmt.Ndeg;

%% Initial Field
if 0
    x = node(:,1); y = node(:,2);
    n=1;
    f=@(k,x,y)(n*cos(pi/3*k)*x+n*sin(pi/3*k)*y);
    scft.w(1,:)=1/6*(cos(f(0,x,y))...
    +cos(f(1,x,y))...
    +cos(f(2,x,y))...
    +cos(f(3,x,y))...
    +cos(f(4,x,y))...
    +cos(f(5,x,y))); 
elseif 0
    x = node(:,1); y = node(:,2);
    n=1;
    scft.w(1,:)=0.5*(cos(n*x)+cos(n*y)); %% wA and wB
elseif 1
    a = -1;
    b = 1;
    scft.w(1,:) = a + (b-a).*rand(cmp_mesh.N,1);
% scft.w(2,:) = a + (b-a).*rand(cmp_mesh.N,1);
end

scft.mu(1,:) = 0.5*(scft.w(1,:)+scft.w(2,:)); %w-
scft.mu(2,:) = 0.5*(scft.w(2,:)-scft.w(1,:)); %w-

        
scft.rho(1,:) = 0.5 + scft.mu(2,:)/chiN;
scft.rho(2,:) = 1.0 - scft.rho(1,:);


%% create folder
dir = ['rand_R',num2str(1,2),'_r',num2str(0.5,2),'_fA',num2str(sys_pmt.fA,2),...
    '_chiN',num2str(chiN,3),'/'];
if ~exist(dir,'dir')  
    mkdir(dir)
end 

%% Initial solution
figure(1)
showsolution(cmp_mesh.node, cmp_mesh.elem, scft.rho(1,:),2);
colorbar;
title('Iteration=0');
saveas(1,[dir,'rho1_0'],'png');


%% Parameter
tol = cmp_pmt.TOL;
iterMax = cmp_pmt.Maxiter;

res = inf;
Hold = inf;
ediff = inf;

iteration = 0;
Ham = [];
fid=fopen([dir,'result.txt'],'wt'); 
fprintf(fid,'Omega: center=[0,0],radius=.2%',1);
fprintf(fid,'fA=%.1f,chiN=%.1f\n',sys_pmt.fA, chiN);
fprintf(fid,'h=%.1f,tau=%.1e,tol=%.1e\n',h,cmp_pmt.dtMax,cmp_pmt.TOL);
     
     
while (res > tol) %&& (iteration < iterMax) 

	t1loop = clock;
	iteration = iteration + 1;
    
    %% Compute forward and backward propagator 
    scft = updatePropagator(cmp_pmt, cmp_mesh, scft, Mthd);

    %% Assemble integrand function for computing densities and Q
    q_times_qplus = scft.q.*flip(scft.qplus, 1);

    %%  Compute single chain partition function sQ  
    scft.sQ = updateQ(scft, cmp_mesh);

    %%  compute densities
    scft = updateDensity(scft, cmp_pmt, q_times_qplus);

    %%  update fields 
    [scft, err] = updateField(scft, Mthd.Iter, sys_pmt);

    %% evaluate error
    err1 = err(1);  err2 = err(2);
    rho_err = max(scftAux.rho_old(:)-scft.rho(:));
    mu1_err  = max(scftAux.mu_old(1,:)-scft.mu(1,:));
    mu2_err  = max(scftAux.mu_old(2,:)-scft.mu(2,:));
    grad1_err  = max(scftAux.grad_old(1,:)-scft.grad(1,:));
    grad2_err  = max(scftAux.grad_old(2,:)-scft.grad(2,:));

    scftAux.rho_old = scft.rho;    
    scftAux.mu_old = scft.mu;
    scftAux.grad_old = scft.grad;

    %% evaluate energy
    H = calH(cmp_mesh, scft.mu, sys_pmt);
    H = H/cmp_mesh.tol_area - log(scft.sQ(1));
    Ham = [Ham; H];
  
    ediff = H-Hold;
    Hold = H;
    res = abs(ediff);

    fprintf('iteration = %d: Energy = %.12e, res = %e\n',  iteration, H, res);
    fprintf(fid,'iteration %d: sQ=%.12e, Energy = %.12e, ediff = %e, err1 = %e, err2 = %e\n', ...
        iteration, scft.sQ(1), H, ediff, err1, err2);
    
    n=floor(log10(iteration))+1;
    if mod(iteration,10^(n-1)) == 0
        %% solution
        figure(1)
        showsolution(cmp_mesh.node, cmp_mesh.elem, scft.rho(1,:),2);
        colorbar;
        title(['Iteration=',num2str(iteration)]);
        saveas(1,[dir,'rho1_',int2str(iteration)],'png');
    end
end

%% solution
figure(1)
showsolution(cmp_mesh.node, cmp_mesh.elem, scft.rho(1,:),2);
colorbar;
title(['Iteration=',num2str(iteration)]);
saveas(1,[dir,'rho1_',int2str(iteration)],'png');

%% plot free energy
figure(2);
plot(Ham(1:end));
ylabel('Hamiltonian');
xlabel('Time Step');
saveas(2,[dir,'Hamiltonian.png']);
