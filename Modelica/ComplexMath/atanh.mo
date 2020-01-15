within Modelica.ComplexMath;
function atanh "Area-hyperbolic-tangent of complex number"
  extends Modelica.Icons.Function;
  input Complex c1 "Complex number";
  output Complex c2 "= ar_tanh(c1)";
algorithm
  c2 := 0.5*log((1 + c1)/(1 - c1));
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the inverse Complex hyperbolic tangent of the Complex input.</p>
</html>"));
end atanh;
