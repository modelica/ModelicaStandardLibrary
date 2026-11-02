function mu_rd=appSSEE_mu_rd(par, H)
% -----------------------------------------------------------------------
% Purpose: Approximation mu_rd with smoothing spline + exp. extrapolation
% Input  : parameter struct par, magnetic field strength H
% Output : relative differential permeability mu_rd
% Author : A. Haumer
% Date   : 2026-08-15
% -----------------------------------------------------------------------
    if H<par.hH1
        mu_rd=appSS_mu_rd(par,H);
    elseif H>par.hH2
        mu_rd=appEE_mu_rd(par,H);
    else
        h=(H-par.hH1)/(par.hH2-par.hH1);
        mu_rd=1+(1-h)*(appSS_mu_rd(par,H)-1)+h*(appEE_mu_rd(par,H)-1);
    end
end
