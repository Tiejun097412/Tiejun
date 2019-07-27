function W2 = integrate_space_w2(mymesh, w)
%%%%  \int w^2 dr

[lambda, wt] = quadpts(3);

nQuad = length(wt);
ww = w(mymesh.elem);

NT = size(mymesh.elem, 1);
b = zeros(NT, 1);
for i = 1:nQuad
    b = b + wt(i)*(ww*lambda(i, :)').^2;
end
b = b.*mymesh.area;
W2 = sum(b);
