within Modelica.Electrical.Polyphase.Functions;
function symmetricOrientationMatrix
  "Matrix symmetric orientation angles for creating the symmetric transformation matrix"
  extends Modelica.Icons.Function;
  import Modelica.Constants.pi;
  input Integer m "Number of phases";
  output SI.Angle oM[m, m]
    "Angles of symmetric transformation matrix";
protected
  Integer nBase=numberOfSymmetricBaseSystems(m);
  Integer mBase=integer(m/nBase);
  SI.Angle o[m]=symmetricOrientation(m);
  SI.Angle oBase[numberOfSymmetricBaseSystems(m)]=o[1:mBase:m];
algorithm
  // Init transformation matrix with zeros
  oM := zeros(m, m);
  // mBase is either 2
  if mBase==2 then
    oM[1:mBase,1:mBase] := {o[1:mBase],-o[1:mBase]};
  else // or odd
    for j in 1:mBase loop
      oM[j,1:mBase] := j*o[1:mBase];
    end for;
  end if;
  // shift base orientationMatrix nBase times along diagonal
  for i in 2:nBase loop
    for k in 1:mBase loop
      oM[(i - 1)*mBase + k, (i - 1)*mBase + 1:i*mBase] := oM[k, 1:mBase] + fill(oBase[i], mBase);
    end for;
  end for;
  annotation (Documentation(info="<html>
<p>
This function determines the orientation matrix of the symmetrical winding with m phases.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
end symmetricOrientationMatrix;
