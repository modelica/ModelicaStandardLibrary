within Modelica.Electrical.Machines.SpacePhasors.Functions;
function FromSpacePhasor
  "Conversion from space phasor and zero sequence component to polyphase"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Function;
  input Real x[2] "Space phasor";
  input Real x0 "Zero sequence component";
  input Integer m "Number of phases";
  output Real y[m] "Polyphase output";
protected
  parameter SI.Angle phi[m]=
      Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m);
  parameter Real TransformationMatrix[2, m]=2/m*{+cos(+phi),+sin(+phi)};
  parameter Real InverseTransformation[m, 2]={{+cos(-phi[k]),-sin(-phi[k])}
      for k in 1:m};

algorithm
  y := fill(x0, m) + InverseTransformation*x;

  annotation (Inline=true, Documentation(info="<html>
Transformation of space phasor and zero sequence value to polyphase values (of voltages or currents).
</html>"));
end FromSpacePhasor;
