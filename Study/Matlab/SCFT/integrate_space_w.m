function W = integrate_space_w(cmpmesh, w)
%%%%  \int w dr

[lambda, wt] = quadpts(3);

nQuad = length(wt);
ww = w(cmpmesh.elem);

NT = size(cmpmesh.elem, 1);
b = zeros(NT, 1);
for i = 1:nQuad
    b = b + wt(i)*ww*lambda(i, :)';
end
b = b.*cmpmesh.area;
W = sum(b);
