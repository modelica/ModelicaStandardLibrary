function mu_rd=appSS_mu_rd(par, H)
% -----------------------------------------------------------------------
% Purpose: Approximation of mu_rd with smoothing spline
% Input  : parameter struct par, magnetic field strength H
% Output : relative differential permeability mu_rd
% Author : A. Haumer
% Date   : 2026-08-15
% -----------------------------------------------------------------------
    mu_0=4e-7*pi;
    mu_rd=1+fnval(par.dpp,H)/mu_0;
    % k=find(par.HD(1:end-1)<=H & par.HD(2:end)>H, 1);
    % differentiating the cubic polynomial
    % mu_rd=1+(par.pp.coefs(k,3)+ ...
    %          par.pp.coefs(k,2)*2*(H-par.HD(k))+ ...
    %          par.pp.coefs(k,1)*3*(H-par.HD(k))^2)/mu_0;
end
