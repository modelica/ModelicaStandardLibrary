function y=funObjEE(x, par)
% -----------------------------------------------------------------------
% Purpose: objective function for optimization of exp.extrapolation
% Input  : Vector of optimization parameters x, struct par
% Output : objective function value to be minimized
% Author : A. Haumer
% Date   : 2026-08-15
% -----------------------------------------------------------------------
    par.Jsat=x(1); par.Hpar=x(2)*10000; % scaling
    y=0;
    for kd = par.k0:length(par.HD)
        JApp=appEE_J(par, par.HD(kd));
        y = y + (JApp/par.JD(kd)-1)^2;
    end
end
