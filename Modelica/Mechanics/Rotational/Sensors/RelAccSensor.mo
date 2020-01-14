within Modelica.Mechanics.Rotational.Sensors;
model RelAccSensor
  "Ideal sensor to measure the relative angular acceleration between two flanges"

  extends Rotational.Interfaces.PartialRelativeSensor;

  SI.Angle phi_rel
    "Relative angle between two flanges (flange_b.phi - flange_a.phi)";
  SI.AngularVelocity w_rel "Relative angular velocity between two flanges";
  Modelica.Blocks.Interfaces.RealOutput a_rel(unit="rad/s2")
    "Relative angular acceleration between two flanges as output signal"
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

equation
  phi_rel = flange_b.phi - flange_a.phi;
  w_rel = der(phi_rel);
  a_rel = der(w_rel);
  0 = flange_a.tau;
  annotation (
    Documentation(info="<html>
<p>
Measures the <strong>relative angular acceleration a_rel</strong> between two flanges
in an ideal way and provides the result as output signal <strong>a_rel</strong>
(to be further processed with blocks of the Modelica.Blocks library).
</p>
</html>"),
       Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Line(points={{0.0,-100.0},{0.0,-70.0}},
      color={0,0,127}),
        Text(
          extent={{-50,-14},{50,-54}},
          textColor={64,64,64},
          textString="rad/s2")}));
end RelAccSensor;
