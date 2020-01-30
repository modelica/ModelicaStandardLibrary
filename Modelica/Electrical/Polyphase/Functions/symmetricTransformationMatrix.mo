within Modelica.Electrical.Polyphase.Functions;
function symmetricTransformationMatrix
  "Transformation matrix for symmetrical components"
  extends Modelica.Icons.Function;
  import Modelica.ComplexMath.fromPolar;
  input Integer m "Number of phases";
  output Complex tM[m, m]
    "Transformation matrix for m phase symmetrical components";
protected
  Integer nBase=numberOfSymmetricBaseSystems(m);
  Integer mBase=integer(m/nBase);
  Real factor=nBase/m;
  SI.Angle oM[m,m]=symmetricOrientationMatrix(m);
algorithm
  //fill only elements within baseSystems
  for i in 1:nBase loop
    for j in 1:nBase loop
      for ii in (i - 1)*mBase + 1:i*mBase loop
        for jj in (j - 1)*mBase + 1:j*mBase loop
          tM[ii,jj] :=fromPolar(if i==j then factor else 0, oM[ii,jj]);
        end for;
      end for;
    end for;
  end for;
  annotation (Documentation(info="<html>
<p>
This function determines the transformation matrix of the symmetrical winding with m phases.
</p>
<p>
The transformation matrix can be used to determine the symmetrical components from time phasors.
</p>
<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Electrical.Polyphase.UsersGuide.PhaseOrientation\">User's guide</a> on symmetrical components and orientation.
</p>
</html>"));
end symmetricTransformationMatrix;
