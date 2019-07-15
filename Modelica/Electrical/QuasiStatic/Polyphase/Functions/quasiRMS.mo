within Modelica.Electrical.QuasiStatic.Polyphase.Functions;
function quasiRMS
  "Overall quasi-RMS value of complex input (current or voltage)"
  extends Modelica.Icons.Function;
  import Modelica.ComplexMath.abs;
  input Complex u[:];
  output Real y;
  import Modelica.Constants.pi;
protected
  Integer m=size(u, 1) "Number of phases";
algorithm
  // y := sum({abs(u[k]) for k in 1:m})/m;
  // Alternative implementation due to https://trac.openmodelica.org/OpenModelica/ticket/4496
  y :=sum({sqrt(u[k].re^2 + u[k].im^2) for k in 1:m})/m;
  annotation (Inline=true, Documentation(info="<html>
  This function determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> value of a polyphase system,
  represented by m quasi-static time domain phasors.
</html>"));
end quasiRMS;
