within Modelica.ComplexMath;
function sin "Sine of complex number"
  extends Modelica.Icons.Function;
  input Complex c1 "Complex number";
  output Complex c2 "sin(c1)";
algorithm
   c2 := (exp(Complex(-c1.im, +c1.re)) - exp(Complex(+c1.im, -c1.re)))/Complex(0, 2);
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the Complex sine of the Complex input.</p>
</html>"));
end sin;
