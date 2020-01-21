within Modelica.Mechanics.Translational.Sensors;
model PositionSensor "Ideal sensor to measure the absolute position"
  extends Translational.Interfaces.PartialAbsoluteSensor;
  Modelica.Blocks.Interfaces.RealOutput s(unit="m")
    "Absolute position of flange as output signal" annotation (Placement(
        transformation(extent={{100,-11},{120,9}}),
        iconTransformation(extent={{100,-10},{120,10}})));

equation
  s = flange.s;
  annotation (
    Documentation(info="<html>
<p>
Measures the <em>absolute position s</em> of a flange in an ideal way and provides the result as
output signals (to be further processed with blocks of the
Modelica.Blocks library).
</p>

</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Text(
          extent={{-24,20},{66,-40}},
          textColor={64,64,64},
          textString="m")}));
end PositionSensor;
