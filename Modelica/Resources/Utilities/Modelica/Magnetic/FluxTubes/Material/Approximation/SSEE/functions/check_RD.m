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
    N=length(par.HD);
    if N>128
        disp(['Note: too high number of nodes increases the risk of noisy' ...
              'derivative and increases the number of spline intervals']);
    for k=1:N-1
        if(par.HD(k)>=par.HD(k+1))
        dispVal('rawData H not strictly increasing: k=', k);
        result=-3; return;
        end
    end
    for k=1:N-1
        if(par.JD(k)>=par.JD(k+1))
            dispVal('rawData J not strictly increasing: k=', k);
            result=-4; return;
        end
    end
end
