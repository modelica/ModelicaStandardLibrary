function mu_rd=appEE_mu_rd(par, H)
% -----------------------------------------------------------------------
% Purpose: Approximation of mu_rd with exponential extrapolation
% Input  : parameter struct par, magnetic field strength H
% Output : relative differential permeability mu_rd
% Author : A. Haumer
% Date   : 2026-08-15
% ----------------------------------------------------------------------
    mu_0=4e-7*pi;
    mu_rd=1+(par.Jsat-par.JD(par.k0))/(mu_0*par.Hpar)* ...
          exp(-(H-par.HD(par.k0))/par.Hpar);
end
