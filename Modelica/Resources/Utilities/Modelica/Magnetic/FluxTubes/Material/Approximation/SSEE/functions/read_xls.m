function par=read_xls(fileName, material)
% -----------------------------------------------------------------------
% Purpose: read raw data from spreadsheet
% Input  : material -> -> file with raw data fileName / sheet material
% Output : struct par
% Author : A. Haumer
% Date   : 2026-08-15
% -----------------------------------------------------------------------
    firstRow=10; % Row where table starts
    if exist("OCTAVE_VERSION","builtin")>0
% get additional scalar parameters to save them later to parameter file
        par.vRef=xlsread(fileName,material,'B3:B3');
        par.BRef=xlsread(fileName,material,'B4:B4');
        par.fRef=xlsread(fileName,material,'B5:B5');
        par.dens=xlsread(fileName,material,'B6:B6');
        n=firstRow-1+xlsread(fileName,material,'B8:B8');
% raw data arrays J and H
        RD=xlsread(fileName,material, ...
            ['A' mat2str(firstRow) ':B' mat2str(n)]);
    else
% get additional scalar parameters to save them later to the parameter file
        par.vRef=readmatrix(fileName,'Sheet',material,'Range','B3:B3');
        par.BRef=readmatrix(fileName,'Sheet',material,'Range','B4:B4');
        par.fRef=readmatrix(fileName,'Sheet',material,'Range','B5:B5');
        par.dens=readmatrix(fileName,'Sheet',material,'Range','B6:B6');
        n=firstRow-1+readmatrix(fileName,'Sheet',material,'Range','B8:B8');
% raw data arrays J and H
        RD=readmatrix(fileName,'Sheet',material, ...
            'Range',['A' mat2str(firstRow) ':B' mat2str(n)]);
    end
    par.HD=RD(:,2); par.JD=RD(:,1);
    dispVal("ods/xls: Lines of raw data=", length(par.HD));
end
