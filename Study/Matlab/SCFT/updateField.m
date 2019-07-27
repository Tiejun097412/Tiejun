function [scft, err] = updateField(scft, flag, Sys_para)
%%%% update fields

chiN = Sys_para.Ndeg*Sys_para.chiAB;

	if strcmp(flag, 'Euler')

%%%  compute f+(grad(1,:)) and f-(grad(2,:))
		scft.grad(1,:) = scft.rho(1,:)+scft.rho(2,:)-1.0;
		scft.grad(2,:) = 2.0*scft.mu(2,:)/chiN-scft.rho(1,:)+scft.rho(2,:);
%%%  compute  F+ and F-
		err(1) = max(norm(scft.grad(1,:), inf));
		err(2) = max(norm(scft.grad(2,:), inf));
%%%  step length for update fields
		lambda = [2, 2];
%%%  Euler scheme for updating fields mu
		scft.mu(1,:) = scft.mu(1,:) + lambda(1)*scft.grad(1,:);
		scft.mu(2,:) = scft.mu(2,:) - lambda(2)*scft.grad(2,:);
%%%  update w_A and w_B	
		scft.w(1,:) = scft.mu(1,:) - scft.mu(2,:);
		scft.w(2,:) = scft.mu(1,:) + scft.mu(2,:);
	end
end
