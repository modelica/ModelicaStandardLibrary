within Modelica.ComplexMath;
function cosh "Hyperbolic-cosine of complex number"
  extends Modelica.Icons.Function;
  input Complex c1 "Complex number";
  output Complex c2 "= cosh(c1)";
algorithm
  c2 := Complex(Math.cosh(c1.re)*Math.cos(c1.im), Math.sinh(c1.re)*Math.sin(c1.im));
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the Complex hyperbolic cosine of the Complex input.</p>
</html>"));
end cosh;
