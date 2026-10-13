function savParSSEE(par)
% -----------------------------------------------------------------------
% Purpose: Save parameters to file for copy-paste to Modelica
% Input  : parameter struct par
% Output : file "Par_"par.material".txt"
% Author : A. Haumer
% Date   : 2026-08-15
% -----------------------------------------------------------------------
    fileName=['Par_' par.material '.txt'];
    fID=fopen(fileName,'w');
    fprintf(fID, '  extends BaseData(\n');
% common parameters
    fprintf(fID, '    Type="%s",\n', par.material);
    fprintf(fID, '    vRef = %9.2f,\n', par.vRef);
    fprintf(fID, '    BRef = %9.5f,\n', par.BRef);
    fprintf(fID, '    fRef = %9.2f,\n', par.fRef);
    fprintf(fID, '    dens = %9.2f,\n', par.dens);
    fprintf(fID, '    mu_ri= %9.2f,\n', par.mu_ri);
% Exponential Extrapolation
    fprintf(fID, '    k0   = %1u,\n',   par.k0);
    fprintf(fID, '    Hpar = %9.2f,\n', par.Hpar);
    fprintf(fID, '    Hsat = %9.1f,\n', par.Hsat);
    fprintf(fID, '    Jsat = %9.5f,\n', par.Jsat);
% Homotopy
    fprintf(fID, '    hH1  = %9.2f,\n', par.hH1);
    fprintf(fID, '    hH2  = %9.2f,\n', par.hH2);
%   length of raw data = 1 + length of interval coefficients
    N=length(par.HD);
    fprintf(fID, '    N    = %1u,\n', N);
% Smoothing Spline coefficients
    for m=1:4
        fprintf(fID, '    c%1u={\n', 4-m);
        kB=1; kE=min(kB+4, N-1);
        while kB<=N-1
            fprintf(fID, '    ');
            for k=kB:kE
                if k==N-1
                    fprintf(fID, '%12.5e},',par.pp.coefs(k,m));
                else
                    fprintf(fID, '%12.5e,' ,par.pp.coefs(k,m));
                end
            end
            fprintf(fID, '\n');
            kB=kE+1; kE=min(kB+4, N-1);
        end
    end
% Raw Data
    fprintf(fID, '    HD={\n');
    kB=1; kE=min(kB+6, N);
    while kB<=N
        fprintf(fID, '    ');
        for k=kB:kE
            if k==N
                fprintf(fID, '%9.2f},',par.HD(k));
            else
                fprintf(fID, '%9.2f,' ,par.HD(k));
            end
        end
        fprintf(fID, '\n');
        kB=kE+1; kE=min(kB+6, N);
    end
    fprintf(fID, '    JD={\n');
    kB=1; kE=min(kB+6, N);
    while kB<=N
        fprintf(fID, '    ');
        for k=kB:kE
            if k==N
                fprintf(fID, '%9.5f});',par.JD(k));
            else
                fprintf(fID, '%9.5f,' ,par.JD(k));
            end
        end
        fprintf(fID, '\n');
        kB=kE+1; kE=min(kB+6, N);
    end
    fclose(fID);
end
