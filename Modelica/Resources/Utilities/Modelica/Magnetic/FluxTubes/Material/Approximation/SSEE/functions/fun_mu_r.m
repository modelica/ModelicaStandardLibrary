function mu_r=fun_mu_r(J, H, mu_ri)
% -----------------------------------------------------------------------
% Purpose: Calculate mu_r from J and H
% Input  : polarization J, magnetic field strength H,
%          initial relative permeability mu_ri
% Output : relative permeability mu_r
% Author : A. Haumer
% Date   : 2026-08-15
% -----------------------------------------------------------------------
    mu_0=4e-7*pi;
    Heps=1e-6; % smallest field strength to protect against division by 0
    if H<=Heps
        mu_r=mu_ri;
    else
        mu_r=1+J/(mu_0*H);
    end
end
