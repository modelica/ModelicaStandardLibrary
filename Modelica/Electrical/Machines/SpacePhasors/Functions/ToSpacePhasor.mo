within Modelica.Electrical.Machines.SpacePhasors.Functions;
function ToSpacePhasor
  "Conversion from polyphase input to space phasor and zero sequence component"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Function;
  input Real x[:] "Polyphase (voltage or current) input";
  output Real y[2] "Space phasor";
  output Real y0 "Zero sequence component (of voltage or current)";
protected
  parameter Integer m=size(x, 1) "Number of phases" annotation(Evaluate=true);
  parameter SI.Angle phi[m]=
      Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m);
  parameter Real TransformationMatrix[2, m]=2/m*{+cos(+phi),+sin(+phi)};
  parameter Real InverseTransformation[m, 2]={{+cos(-phi[k]),-sin(-phi[k])}
      for k in 1:m};
algorithm
  y := TransformationMatrix*x;
  y0 := 1/m*sum(x);
  annotation (Inline=true, Documentation(info="<html>
Transformation of polyphase values (of voltages or currents) to space phasor and zero sequence value.
</html>"));
end ToSpacePhasor;
