function result=check_RD(par)
% -----------------------------------------------------------------------
% Purpose: Check RawData
% Input  : parameter struct par
% Output : result (<0 means erroneous)
% Author : A. Haumer
% Date   : 2026-10-28
% -----------------------------------------------------------------------
    result=0;
    if par.HD(1)~=0
        disp('rawData J(H) has to start with (0,0)');
        result=-1; return;
    end
    if par.JD(1)~=0
        disp('rawData J(H) has to start with (0,0)');
        result=-2; return;
    end
    if ~all(diff(par.HD)>0)
        disp('rawData H not strictly increasing!');
        result=-3; return;
    end
    if ~all(diff(par.JD)>0)
        disp('rawData J not strictly increasing!');
        result=-4; return;
    end
end
