within Modelica.ComplexMath;
function arg "Phase angle of complex number"
  extends Modelica.Icons.Function;
  input Complex c "Complex number";
  input Modelica.SIunits.Angle phi0=0
    "Phase angle phi shall be in the range: -pi < phi-phi0 < pi";
  output Modelica.SIunits.Angle phi "= phase angle of c";
algorithm
  phi := Modelica.Math.atan3(
      c.im,
      c.re,
      phi0);
  annotation(Inline=true, Documentation(info="<html>
<p>This function returns the Real argument of the Complex input, i.e., its angle.</p>
</html>"));
end arg;
