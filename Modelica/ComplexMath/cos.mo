within Modelica.ComplexMath;
function cos "Cosine of complex number"
  extends Modelica.Icons.Function;
  input Complex c1 "Complex number";
  output Complex c2 "= cos(c1)";
algorithm
  c2 := (exp(Complex(-c1.im, +c1.re)) + exp(Complex(+c1.im, -c1.re)))/2;
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the Complex cosine of the Complex input.</p>
</html>"));
end cos;
