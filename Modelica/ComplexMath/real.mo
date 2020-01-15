within Modelica.ComplexMath;
function real "Real part of complex number"
  extends Modelica.Icons.Function;
  input Complex c "Complex number";
  output Real r "= c.re";
algorithm
  r := c.re;
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the real part of the Complex input.</p>
</html>"));
end real;
