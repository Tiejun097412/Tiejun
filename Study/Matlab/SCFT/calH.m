function H = calH(cmpmesh, mu, Sys_para)

chiN = Sys_para.Ndeg*Sys_para.chiAB;

mu1_int  = integrate_space_w(cmpmesh, mu(1,:));
mu2_int2 = integrate_space_w2(cmpmesh, mu(2,:));

H = -mu1_int + mu2_int2/chiN;

end
