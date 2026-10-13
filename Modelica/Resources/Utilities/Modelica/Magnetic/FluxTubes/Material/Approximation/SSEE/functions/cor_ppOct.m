function pp=cor_ppOct(ppI)
% -----------------------------------------------------------------------
% Purpose: correct Octave's pp-struct
% Input  : struct ppI (Octave's version)
% Output : struct pp (deleted first and last entry)
% Author : A. Haumer
% Date   : 2026-08-15
% -----------------------------------------------------------------------
    pp.form  =ppI.form;
    pp.breaks=ppI.breaks(1,2:size(ppI.breaks,2)-1);
    pp.coefs =ppI.coefs(2:size(ppI.coefs,1)-1,:);
    pp.pieces=ppI.pieces-2;
    pp.order =ppI.order;
    pp.dim   =ppI.dim;
end
