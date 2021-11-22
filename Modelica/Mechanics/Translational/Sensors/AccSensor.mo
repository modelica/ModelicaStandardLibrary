within Modelica.Mechanics.Translational.Sensors;
model AccSensor "Ideal sensor to measure the absolute acceleration of flange"
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
Measures the <em>absolute acceleration</em>
of a&nbsp;flange in an ideal way and provides the result as
output signal&nbsp;<code>a</code>
(to be further processed with blocks of the
<a href=\"modelica://Modelica.Blocks\">Modelica.Blocks</a> library).
</p>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-24,20},{66,-40}},
          textColor={64,64,64},
          textString="m/s2")}));
end AccSensor;
