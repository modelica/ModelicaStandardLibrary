within Modelica.ComplexMath;
function tanh "Hyperbolic-tangent of complex number"
  extends Modelica.Icons.Function;
  input Complex c1 "Complex number";
  output Complex c2 "= tanh(c1)";
algorithm
  c2 := sinh(c1)/cosh(c1);
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the Complex hyperbolic tangent of the Complex input.</p>
</html>"));
end tanh;
