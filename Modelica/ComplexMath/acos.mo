within Modelica.ComplexMath;
function acos "Arc-cosine of complex number"
  extends Modelica.Icons.Function;
  input Complex c1 "Complex number";
  output Complex c2 "= arc_cos(c1)";
algorithm
  c2 := -j*log(c1 + j*'sqrt'(1 - c1*c1));
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the inverse Complex cosine of the Complex input.</p>
</html>"));
end acos;
