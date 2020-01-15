within Modelica.ComplexMath;
function asinh "Area-hyperbolic-sine of complex number"
  extends Modelica.Icons.Function;
  input Complex c1 "Complex number";
  output Complex c2 "ar_sinh(c1)";
algorithm
  c2 := log(c1 + 'sqrt'(c1*c1 + 1));
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the inverse Complex hyperbolic sine of the Complex input.</p>
</html>"));
end asinh;
