within Modelica.ComplexMath;
function tan "Tangent of complex number"
  extends Modelica.Icons.Function;
  input Complex c1 "Complex number";
  output Complex c2 "= tan(c1)";
algorithm
  c2 := sin(c1)/cos(c1);
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the Complex tangent of the Complex input.</p>
</html>"));
end tan;
