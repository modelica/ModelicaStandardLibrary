within Modelica.ComplexMath;
function asin "Arc-sine of complex number"
  extends Modelica.Icons.Function;
  input Complex c1 "Complex number";
  output Complex c2 "arc_sin(c1)";
algorithm
  c2 := -j*log(j*c1 + 'sqrt'(1 - c1*c1));
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the inverse Complex sine of the Complex input.</p>
</html>"));
end asin;
