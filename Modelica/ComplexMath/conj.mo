within Modelica.ComplexMath;
function conj "Conjugate of complex number"
  extends Modelica.Icons.Function;
  input Complex c1 "Complex number";
  output Complex c2 "= c1.re - j*c1.im";
algorithm
  c2 := Complex(c1.re, -c1.im);
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the Complex conjugate of the Complex input.</p>
</html>"));
end conj;
