within Modelica.Electrical.Machines.SpacePhasors.Functions;
function FromPolar "Converts a space phasor from polar coordinates"
  extends Modelica.Icons.Function;
  input Real absolute "Magnitude of space phasor";
  input SI.Angle angle "Angle of space phasor";
  output Real x[2] "Real and imaginary part of space phasor";
protected
  constant Real small=Modelica.Constants.small;
algorithm
  x := absolute*{cos(angle),sin(angle)};
  annotation (Inline=true, Documentation(info="<html>
Converts a space phasor from polar coordinates to rectangular coordinates.
</html>"));
end FromPolar;
