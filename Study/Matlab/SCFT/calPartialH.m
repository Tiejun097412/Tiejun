function partialH = calPartialH( scft, cmp_pmt, init_mesh, Mthd)	

	partialH = 0;
	cmpmesh = get_cmp_mesh(init_mesh);

	scft = updatePropagator(cmp_pmt, cmpmesh, scft, Mthd);
	q_times_qplus = scft.q.*flip(scft.qplus, 1);

	scft.sQ = updateQ(scft, cmpmesh, q_times_qplus);

	partialH = partialH - sum(log(scft.sQ(:)));

end
