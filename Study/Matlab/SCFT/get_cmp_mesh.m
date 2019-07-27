function cmp_mesh = get_cmp_mesh(init_mesh)
%%  generate valid meshgrid for computation

cmp_mesh.node = init_mesh.node;
cmp_mesh.elem = init_mesh.elem;
cmp_mesh.N = size(cmp_mesh.node,1);
[~, cmp_mesh.area] = gradbasis(cmp_mesh.node,cmp_mesh.elem);
tol_area = sum(cmp_mesh.area(:));
cmp_mesh.tol_area = tol_area;

end
