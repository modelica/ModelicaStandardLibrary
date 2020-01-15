within Modelica.ComplexMath;
function log "Logarithm of complex number"
  extends Modelica.Icons.Function;
  input Complex c1 "Complex number";
  output Complex c2 "= log(c1)";
algorithm
  c2 := Complex(Modelica.Math.log('abs'(c1)), arg(c1));
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the Complex natural logarithm of the Complex input.</p>
</html>"));
end log;
