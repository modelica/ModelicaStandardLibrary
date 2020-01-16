within Modelica.Mechanics.Translational.Sensors;
model SpeedSensor "Ideal sensor to measure the absolute velocity"
  extends Translational.Interfaces.PartialAbsoluteSensor;
  Modelica.Blocks.Interfaces.RealOutput v(unit="m/s")
    "Absolute velocity of flange as output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));

equation
  v = der(flange.s);
  annotation (
    Documentation(info="<html>
<p>
Measures the <em>absolute velocity v</em> of a flange in an ideal way and provides the result as
output signals (to be further processed with blocks of the
Modelica.Blocks library).
</p>

</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-24,20},{66,-40}},
          textColor={64,64,64},
          textString="m/s")}));
end SpeedSensor;
