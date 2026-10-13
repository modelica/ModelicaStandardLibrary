function mu_rd=fun_mu_rd(HD, JD)
% -----------------------------------------------------------------------
% Purpose: Calculate mu_rd from J and H
% Input  : polarization J and magnetic field strength H
% Beware : numerical differentiation!
% Output : relative differential permeability mu_rd
% Author : A. Haumer
% Date   : 2026-08-15
% -----------------------------------------------------------------------
    mu_0=4e-7*pi;
    N=length(HD);
%   first interval: forward  difference
    mu_rd(1)=1+(JD(2)-JD(1))/(HD(2)-HD(1))/mu_0;
%   inner intervals: average between forward and backward difference
    for k=2:N-1
        mu_rd(k)=1+((JD(k+1)-JD(k))/(HD(k+1)-HD(k))+ ...
                    (JD(k)-JD(k-1))/(HD(k)-HD(k-1)))/(2*mu_0);
    end
%   last  interval: backward difference
    mu_rd(N)=1+(JD(N)-JD(N-1))/(HD(N)-HD(N-1))/mu_0;
end
