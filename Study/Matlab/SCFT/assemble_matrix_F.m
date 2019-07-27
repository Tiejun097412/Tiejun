function F = assemble_matrix_F(cmpmesh, w)

%  INPUT: 
%   node:
%   elem:
%   w: Nx1
%  OUTPUT:
%       F: NxN
node = cmpmesh.node;
elem = cmpmesh.elem;
area = cmpmesh.area;

N = size(node, 1);
K = tensor3();
ww = w(elem);

F = sparse(N, N);
for i = 1:2
    for j = 1:2
        Fij = ww(:,1)*K(i,1) + ww(:,2)*K(i,2);
        Fij = Fij.*area;
        F = F + sparse(elem(:,i), elem(:,j), Fij, N, N);
    end
end
