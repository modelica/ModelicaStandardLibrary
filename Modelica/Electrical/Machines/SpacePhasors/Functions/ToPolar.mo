within Modelica.Electrical.Machines.SpacePhasors.Functions;
function ToPolar "Converts a space phasor to polar coordinates"
  extends Modelica.Icons.Function;
  input Real x[2] "Real and imaginary part of space phasor";
  output Real absolute "Magnitude of space phasor";
  output SI.Angle angle "Angle of space phasor";
protected
  constant Real small=Modelica.Constants.small;
algorithm
  absolute := sqrt(x[1]^2 + x[2]^2);
  angle := if absolute <= small then 0 else Modelica.Math.atan2(x[2], x[1]);
  /*
  if absolute <= small then
    angle := 0;
  else
    if x[2] >= 0 then
      angle :=  Modelica.Math.acos(x[1]/absolute);
    else
      angle := -Modelica.Math.acos(x[1]/absolute);
    end if;
  end if;
*/
  annotation (Inline=true, Documentation(info="<html>
Converts a space phasor from rectangular coordinates to polar coordinates, providing angle=0 for {0,0}.
</html>"));
end ToPolar;
