within Modelica.ComplexMath;
function exp "Exponential of complex number"
  extends Modelica.Icons.Function;
  input Complex c1 "Complex number";
  output Complex c2 "= exp(c1)";
algorithm
  c2 := Complex(Math.exp(c1.re)*Math.cos(c1.im), Math.exp(c1.re)*Math.sin(c1.im));
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the Complex natural exponential of the Complex input.</p>
</html>"));
end exp;
