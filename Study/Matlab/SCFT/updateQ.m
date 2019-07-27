function sQ = updateQ(scft, cmpmesh)
%%%  compute single chain partition function sQ  

	nt = length(scft.q(:,1));
	sQ(1) = integrate_space_w(cmpmesh, scft.q(nt,:));
	sQ(1) = sQ(1)/cmpmesh.tol_area;
    
end
