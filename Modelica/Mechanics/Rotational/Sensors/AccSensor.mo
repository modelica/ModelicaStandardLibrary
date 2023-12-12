within Modelica.Mechanics.Rotational.Sensors;
model AccSensor
  "Ideal sensor to measure the absolute angular acceleration of flange"

  extends Rotational.Interfaces.PartialAbsoluteSensor;
  SI.AngularVelocity w "Absolute angular velocity of flange";
  Modelica.Blocks.Interfaces.RealOutput a(unit="rad/s2")
    "Absolute angular acceleration of flange as output signal" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));

equation
  w = der(flange.phi);
  a = der(w);
  annotation (
    Documentation(info="<html>
<p>
Measures the <em>absolute angular acceleration</em>
of a&nbsp;flange in an ideal way and provides the result as
output signal&nbsp;<code>a</code>
(to be further processed with blocks of the
<a href=\"modelica://Modelica.Blocks\">Modelica.Blocks</a> library).
</p>
</html>"),
       Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="rad/s2")}));
end AccSensor;
