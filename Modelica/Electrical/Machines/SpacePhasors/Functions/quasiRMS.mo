within Modelica.Electrical.Machines.SpacePhasors.Functions;
function quasiRMS "Calculate quasi-RMS value of input"
  extends Modelica.Icons.Function;
  import Modelica.Constants.pi;
  input Real x[3];
  output Real y;
protected
  Integer m=size(x, 1) "Number of phases";
  SI.Angle phi[m]=
      Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m);
  Real TransformationMatrix[2, m]=2/m*{+cos(+phi),+sin(+phi)};
  Real h[2]=TransformationMatrix*x;
algorithm
  y := sqrt(h[1]^2 + h[2]^2)/sqrt(2);
  annotation (Inline=true, Documentation(info="<html>
  Transformation of m phase values (voltages or currents) to space phasor and calculate length of space phasor / sqrt(2).
</html>"));
end quasiRMS;
