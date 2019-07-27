function [scft, scftAux] = get_scft_data(sys_pmt, cmp_pmt)

nspecies = sys_pmt.Nspecies;
nblend   = sys_pmt.Nblend;
   nt    = cmp_pmt.Nt;
   ndof  = cmp_pmt.Ndof;

scft.q     = zeros(nt, ndof);
scft.qplus = zeros(nt, ndof);
scft.sQ    = zeros(1, nblend);
scft.rho   = zeros(nspecies, ndof);
scft.w     = zeros(nspecies, ndof);
scft.mu    = zeros(nspecies, ndof);
scft.grad  = zeros(nspecies, ndof);

scftAux.mu_old   = zeros(nspecies, ndof);   
scftAux.rho_old  = zeros(nspecies, ndof);
scftAux.grad_old = zeros(nspecies, ndof);

end
