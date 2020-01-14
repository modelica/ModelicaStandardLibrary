within Modelica.Mechanics.Rotational.Sensors;
model AccSensor
  "Ideal sensor to measure the absolute flange angular acceleration"

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
Measures the <strong>absolute angular acceleration a</strong> of a flange in an ideal
way and provides the result as output signal <strong>a</strong> (to be further processed with
blocks of the Modelica.Blocks library).
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
