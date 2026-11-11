function fig=pltRes(par,RD)
% -----------------------------------------------------------------------
% Purpose: Plot results
% Input  : parameter struct par, indicator whether rawData alone or not
% Output : handles to figures
% Author : A. Haumer
% Date   : 2026-08-15
% -----------------------------------------------------------------------
    ND=length(par.HD);
    if ~RD
        Hmin=min(min(par.HD),0);
        Hmax=max(max(par.HD),50000);
        Np=10000; % number of points
        H=linspace(Hmin,Hmax,Np);
% pre-allocate result vectors to increase speed
        J=zeros(Np,1); mu_r=zeros(Np,1); mu_rd=zeros(Np,1);
        for kp=1:Np
            J(kp)=appSSEE_J(par, H(kp));
            mu_rd(kp)=appSSEE_mu_rd(par, H(kp));
            mu_r(kp) =fun_mu_r(J(kp),H(kp),par.mu_ri);
        end
    end
% J(H)
    fig(1)=figure;
    if RD
        semilogx(par.HD(2:ND), par.JD(2:ND), ':ob'); hold on;
    else
        semilogx(H(2:Np), J(2:Np), '-b'); hold on;
        semilogx(par.HD(2:ND), par.JD(2:ND), 'ob'); 
        legend('J(H)','measured','Location','southeast');
    end
    grid on; title(par.material); 
    xlabel("H [A/m]"); ylabel("J [T]");
    fig(2)=figure;
    if RD
        plot(par.HD, par.JD, ':ob'); hold on;
    else
        plot(H, J, '-b'); hold on;
        plot(par.HD, par.JD, 'ob');
        legend('J(H)','measured','Location','southeast','AutoUpdate','off');
    end
    grid on; title(par.material);
    xlabel("H [A/m]"); ylabel("J [T]");
    xlim([0 1000]);
% mu_r(H) and mu_rd(H)
    fig(3)=figure;
    if RD
        loglog(par.HD(2:ND), par.mu_rD(2:ND), ':ob'); hold on;
        loglog(par.HD(2:ND), par.mu_rdD(2:ND), ':ok');
        legend('\mu_r(H)','\mu_r_d(H)','Location','northeast');
    else
        loglog(H(2:Np), mu_r(2:Np), '-b'); hold on;
        loglog(par.HD(2:ND), par.mu_rD(2:ND), 'ob');
        loglog(H(2:Np), mu_rd(2:Np), '--k');
        loglog(par.HD(2:ND), par.mu_rdD(2:ND), 'ok');
        legend('\mu_r(H)','measured','\mu_r_d(H)','measured', ...
            'Location','northeast');
    end
    grid on; title(par.material);
    xlabel("H [A/m]"); ylabel("\mu_r");
    fig(4)=figure;
    if RD
        plot(par.HD, par.mu_rD, ':ob');hold on;
        plot(par.HD, par.mu_rdD, ':ok');
        legend('\mu_r(H)','\mu_r_d(H)','Location','northeast');
    else
        plot(H, mu_r, '-b'); hold on;
        plot(par.HD, par.mu_rD, 'ob');
        plot(H, mu_rd, '--k');
        plot(par.HD, par.mu_rdD, 'ok');
        legend('\mu_r(H)','measured','\mu_r_d(H)','measured', ...
            'Location','northeast','AutoUpdate','off');
    end
    grid on; title(par.material);
    xlabel("H [A/m]"); ylabel("\mu_r");
    xlim([0 500]);
end
