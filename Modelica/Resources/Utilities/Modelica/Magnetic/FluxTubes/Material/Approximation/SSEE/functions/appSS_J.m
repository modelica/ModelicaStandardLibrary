function J=appSS_J(par, H)
% -----------------------------------------------------------------------
% Purpose: Approximation of J with smoothing spline
% Input  : parameter struct par, magnetic field strength H
% Output : Polarization J
% Author : A. Haumer
% Date   : 2026-08-15
% -----------------------------------------------------------------------
    J=fnval(par.pp,H);
    % par.pp.breaks     =par.HD
    % par.pp.coefs(:,4)~=par.JD(1:end-1) (smoothing splines)
    % k=find(par.HD(1:end-1)<=H & par.HD(2:end)>H, 1);
    % J=par.pp.coefs(k,4)+ ...
    %   par.pp.coefs(k,3)*(H-par.HD(k))+ ...
    %   par.pp.coefs(k,2)*(H-par.HD(k))^2+ ...
    %   par.pp.coefs(k,1)*(H-par.HD(k))^3;
end

