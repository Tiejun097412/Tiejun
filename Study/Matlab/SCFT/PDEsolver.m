function  [q, index] = PDEsolver(interval, cmpmesh, w, q, index, Mthd)
%%%%% explicit Euler method
	% INPUT: 
	%  SysParamts: 
	%   mesh.node:
	%   mesh.elem:
	%      w: Nx1
	%  index: point out the start position
	%
	%  OUTPUT:  	
	%      q: (nt+1)xN
	PDEflag = Mthd.PDE;

	nt = interval.n;
	dt = interval.dt;
	
	[A, M]=assemble_matrix_AM(cmpmesh); 
	F = assemble_matrix_F(cmpmesh, w);

	q0 = q(index,:);

	%%(q1-q0)/dt*M=-(A+F)*q0
	if strcmp(PDEflag, 'ExplictEuler')
		AF = A+F;
		for i=index:1:index+nt   
			q(i,:) = q0;
			b = -dt*AF*q0';
			q1 = M\b + q0';
			q0 = q1';
        end
        
	%%(q1-q0)/dt*M=-(A+F)*q1	
	elseif strcmp(PDEflag, 'ImplicitEuler')
		MAF = M+dt*(A+F); 
		for i=index:1:index+nt   
			q(i,:) = q0;                
			q1 = MAF\(M*q0');                 
			q0 = q1';
        end
        
	%%(q1-q0)/dt*M=-(A+F)*(q1+q0)/2??
    elseif strcmp(PDEflag, 'CN')
        AF = A + F;
        CM = sum(M, 2);
        for i=index:1:index+nt
            q(i, :) = q0;
            q1 = q0;
            err = inf;
            while err > 1e-8
                b = -dt*AF*(q1'+ q0')/2;
                q2 = b./CM +q0';
                err = norm(q2'-q1);
                q1 = q2';
            end
            q0 = q1;
        end
        
	%(q1-q0)/dt*M=-(A+F)*(q1+q0)/2
    elseif strcmp(PDEflag, 'ImplicitCN')
        AF = A + F;
        L = M + 0.5*dt*AF;
        for i = index:1:index+nt
            q(i, :) = q0;
%             size(M)
%             size(q0)
            q1 = L\(M*q0'-0.5*dt*AF*q0');
            q0 = q1';
        end
        
    elseif strcmp(PDEflag, 'ImplicitCN1')
        AF = A + F;
        CM = sum(M, 2);
        N = length(CM);
        L = spdiags(CM, 0, N, N) + 0.5*dt*AF;
        for i = index:1:index+nt
            q(i, :) = q0;
            q1 = L\(M*q0'-0.5*dt*AF*q0');
            q0 = q1';
        end

	elseif strcmp(PDEflag, 'RK4')
		AF= A+F;
		for i=index:1:index+nt
			q(i,:) = q0;

			k1 = q0;
			k2 = q0 + 0.5*dt*k1;
			k3 = q0 + 0.5*dt*k2;
			k4 = q0 + dt*k3;
			kk = k1+ 2*k2 + 2*k3 + k4;
			q1 = q0' + M\(AF*kk')*(dt/6);

			q0  = q1';
		end
	end

	index = index+nt;
end
