function par=read_txt(fileName)
% -----------------------------------------------------------------------
% Purpose: read raw data from txt-file
% Input  : fileName
% Output : struct par
% Author : A. Haumer
% Date   : 2026-08-15
% -----------------------------------------------------------------------
    firstLine=9; % Line before table starts
% get additional scalar parameters to save them later to parameter file
    fID=fopen(fileName); % skip first 2 lines #1 and # type
    fgetl(fID); fgetl(fID);
    line=fgetl(fID); par.vRef=str2double(line(strfind(line,"=")+1:end));
    line=fgetl(fID); par.BRef=str2double(line(strfind(line,"=")+1:end));
    line=fgetl(fID); par.fRef=str2double(line(strfind(line,"=")+1:end));
    line=fgetl(fID); par.dens=str2double(line(strfind(line,"=")+1:end));
    fclose(fID);
% raw data arrays J and H (ensure that all lines use the same delimiter!)
    if exist("OCTAVE_VERSION","builtin")>0
        RD=dlmread(fileName,'\t',firstLine,0);
    else
        RD=readmatrix(fileName,'NumHeaderLines',firstLine);
    end
    par.HD=RD(:,2); par.JD=RD(:,1);
    dispVal("txt: Lines of raw data=", length(par.HD));
end
