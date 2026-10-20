function mu_ri = app_mu_ri(par)
% -----------------------------------------------------------------------
% Purpose: determine mu_ri using smoothing splines
% Input  : parameter struct par
% Output : initial relative permeability mu_ri
% Author : A. Haumer
% Date   : 2026-08-15
% -----------------------------------------------------------------------
    mu_0=4e-7*pi;
    p=0.005;
    pp=csaps(par.HD,par.JD,p);
    % dpp=fnder(pp);
    % mu_ri=1+fnval(dpp,0)/mu_0;
% calculate mu_ri
    if exist("OCTAVE_VERSION","builtin")>0
        mu_ri=1+pp.coefs(2,3)/mu_0;
    else
        mu_ri=1+pp.coefs(1,3)/mu_0;
    end
end
