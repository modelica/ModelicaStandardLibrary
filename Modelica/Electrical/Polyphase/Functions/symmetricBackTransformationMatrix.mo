within Modelica.Electrical.Polyphase.Functions;
function symmetricBackTransformationMatrix
  "Back transformation matrix for symmetrical components"
  extends Modelica.Icons.Function;
  import Modelica.ComplexMath.fromPolar;
  input Integer m "Number of phases";
  output Complex bTM[m, m]
    "Back transformation matrix for m phase symmetrical components";
protected
  Integer nBase=numberOfSymmetricBaseSystems(m);
  Integer mBase=integer(m/nBase);
  Real factor=1;
  SI.Angle oM[m,m]=symmetricOrientationMatrix(m);
algorithm
  //inverse (within baseSystems): conjugate and transpose
  for i in 1:nBase loop
    for j in 1:nBase loop
      for ii in (i - 1)*mBase + 1:i*mBase loop
        for jj in (j - 1)*mBase + 1:j*mBase loop
          bTM[ii,jj] :=fromPolar(if i==j then factor else 0, -oM[jj,ii]);
        end for;
      end for;
    end for;
  end for;
  annotation (Documentation(info="<html>
<p>
This function determines the back transformation matrix of the symmetrical winding with m phases.
</p>
<p>
The back transformation matrix can be used to determine the time phasors from the symmetrical components.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
end symmetricBackTransformationMatrix;
