function J=appSSEE_J(par, H)
% -----------------------------------------------------------------------
% Purpose: Approximation of J with smoothing spline + exp. extrapolation
% Input  : parameter struct par, magnetic field strength H
% Output : Polarization J
% Author : A. Haumer
% Date   : 2026-08-15
% -----------------------------------------------------------------------
    if H<par.hH1
        J=appSS_J(par,H);
    elseif H>par.hH2
        J=appEE_J(par,H);
    else
        h=(H-par.hH1)/(par.hH2-par.hH1);
        J=(1-h)*appSS_J(par,H) + h*appEE_J(par,H);
    end
end
