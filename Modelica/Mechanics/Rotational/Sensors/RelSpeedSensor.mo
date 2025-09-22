within Modelica.Mechanics.Rotational.Sensors;
model RelSpeedSensor
  "Ideal sensor to measure the relative angular velocity between two flanges"

  extends Rotational.Interfaces.PartialRelativeSensor;

  SI.Angle phi_rel
    "Relative angle between two flanges (flange_b.phi - flange_a.phi)";
  Modelica.Blocks.Interfaces.RealOutput w_rel(unit="rad/s")
    "Relative angular velocity between two flanges (= der(flange_b.phi) - der(flange_a.phi)) as output signal"
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

equation
  phi_rel = flange_b.phi - flange_a.phi;
  w_rel = der(phi_rel);
  0 = flange_a.tau;
  annotation (
    Documentation(info="<html>
<p>
Measures the <em>relative angular velocity</em> between two flanges
in an ideal way and provides the result as output signal <code>w_rel</code>
(to be further processed with blocks of the
<a href=\"modelica://Modelica.Blocks\">Modelica.Blocks</a> library).
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
          textString="rad/s")}));
end RelSpeedSensor;
