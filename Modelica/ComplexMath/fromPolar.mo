within Modelica.ComplexMath;
function fromPolar "Complex from polar representation"
  extends Modelica.Icons.Function;
  input Real len "abs of complex";
  input Modelica.SIunits.Angle phi "arg of complex";
  output Complex c "= len*cos(phi) + j*len*sin(phi)";
algorithm
  c := Complex(len*Modelica.Math.cos(phi), len*Modelica.Math.sin(phi));
  annotation(Inline=true, Documentation(info="<html>
<p>This function constructs a Complex number from its length (absolute) and angle (argument).</p>
</html>"));
end fromPolar;
