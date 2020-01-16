within Modelica.Mechanics.Translational.Sensors;
model AccSensor "Ideal sensor to measure the absolute acceleration"
  extends Translational.Interfaces.PartialAbsoluteSensor;
  SI.Velocity v "Absolute velocity of flange";
  Modelica.Blocks.Interfaces.RealOutput a(unit="m/s2")
    "Absolute acceleration of flange as output signal" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));

equation
  v = der(flange.s);
  a = der(v);
  annotation (
    Documentation(info="<html>
<p>
Measures the <em>absolute acceleration a</em>
of a flange in an ideal way and provides the result as
output signals (to be further processed with blocks of the
Modelica.Blocks library).
</p>

</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-24,20},{66,-40}},
          textColor={64,64,64},
          textString="m/s2")}));
end AccSensor;
