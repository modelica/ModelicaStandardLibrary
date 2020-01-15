within Modelica.ComplexMath;
function atan "Arc-tangent of complex number"
  extends Modelica.Icons.Function;
  input Complex c1 "Complex number";
  output Complex c2 "= arc_tan(c1)";
algorithm
  c2 := 0.5*j*log((j + c1)/(j - c1));
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the inverse Complex tangent of the Complex input.</p>
</html>"));
end atan;
