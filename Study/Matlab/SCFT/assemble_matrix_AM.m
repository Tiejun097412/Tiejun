function [A,M] = assemble_matrix_AM(cmpmesh)
% to assemble standare matrix A and matrix M for no coefficient equation
node = cmpmesh.node;
elem = cmpmesh.elem;

%% important constants
Ndof = size(node,1);
quadorder = 2;

%% compute geometric quantities and gradient of local basis
[Dphi,area] = gradbasis(node,elem);

%% weight and guass point
[lambda,weight] = quadpts(quadorder);
phi = lambda;
nQuad = size(lambda,1);

%% assemble stiffness matrix
A = sparse(Ndof,Ndof);
for i = 1:3
    for j = i:3
        Aij = (Dphi(:,1,i).*Dphi(:,1,j) + Dphi(:,2,i).*Dphi(:,2,j)).*area;
        %size(Mij)
        if (j==i)
            A = A + sparse(elem(:,i),elem(:,j),Aij,Ndof,Ndof);
        else
            A = A + sparse([elem(:,i);elem(:,j)],[elem(:,j);elem(:,i)],...
                           [Aij; Aij],Ndof,Ndof);        
        end        
    end
end
clear Aij


%% assemble mass matrix
M = sparse(Ndof,Ndof);
for i = 1:3
    for j = i:3
        Mij = 0;
        for p = 1:nQuad 
            Mij = Mij + weight(p)*phi(p,i)*phi(p,j).*area;
        end
        if (j == i)
            M = M + sparse(elem(:,i),elem(:,j),Mij,Ndof,Ndof);
        else
            M = M + sparse([elem(:,i);elem(:,j)],[elem(:,j);elem(:,i)],...
                       [Mij; Mij],Ndof,Ndof);        
        end        
    end
end
clear Mij


