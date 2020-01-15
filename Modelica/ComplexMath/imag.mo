within Modelica.ComplexMath;
function imag "Imaginary part of complex number"
  extends Modelica.Icons.Function;
  input Complex c "Complex number";
  output Real r "= c.im";
algorithm
  r := c.im;
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the imaginary part of the Complex input.</p>
</html>"));
end imag;
