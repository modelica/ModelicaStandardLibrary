function J=appEE_J(par, H)
% -----------------------------------------------------------------------
% Purpose: Approximation of J with exponential extrapolation
% Input  : parameter struct par, magnetic field strength H
% Output : Polarization J
% Author : A. Haumer
% Date   : 2026-08-15
% -----------------------------------------------------------------------
    J=par.JD(par.k0)+(par.Jsat-par.JD(par.k0))* ...
      (1-exp(-(H-par.HD(par.k0))/par.Hpar));
end
