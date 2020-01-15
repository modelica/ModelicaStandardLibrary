within Modelica.ComplexMath;
function acosh "Area-hyperbolic-cosine of complex number"
  extends Modelica.Icons.Function;
  input Complex c1 "Complex number";
  output Complex c2 "= ar_cosh(c1)";
algorithm
  c2 := log(c1 + (c1 + 1)*'sqrt'((c1 - 1)/(c1 + 1)));
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the inverse Complex hyperbolic cosine of the Complex input.</p>
</html>"));
end acosh;
