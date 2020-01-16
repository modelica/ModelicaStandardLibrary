within Modelica.Mechanics.Rotational.Sensors;
model SpeedSensor
  "Ideal sensor to measure the absolute flange angular velocity"

  extends Rotational.Interfaces.PartialAbsoluteSensor;
  Modelica.Blocks.Interfaces.RealOutput w(unit="rad/s")
    "Absolute angular velocity of flange as output signal" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));

equation
  w = der(flange.phi);
  annotation (
    Documentation(info="<html>
<p>
Measures the <strong>absolute angular velocity w</strong> of a flange in an ideal
way and provides the result as output signal <strong>w</strong>
(to be further processed with blocks of the Modelica.Blocks library).
</p>
</html>"),
       Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="rad/s")}));
end SpeedSensor;
