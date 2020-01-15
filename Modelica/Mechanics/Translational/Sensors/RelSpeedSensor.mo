within Modelica.Mechanics.Translational.Sensors;
model RelSpeedSensor "Ideal sensor to measure the relative speed"
  extends Translational.Interfaces.PartialRelativeSensor;
  SI.Position s_rel "Distance between the two flanges (flange_b.s - flange_a.s)";
  Modelica.Blocks.Interfaces.RealOutput v_rel(unit="m/s")
    "Relative velocity between two flanges (= der(flange_b.s) - der(flange_a.s)) as output signal"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));

equation
  s_rel = flange_b.s - flange_a.s;
  v_rel = der(s_rel);
  0 = flange_a.f;
  annotation (
    Documentation(info="<html>
<p>
Measures the <em>relative speed v</em> of a flange in an ideal way and provides the result as
output signals (to be further processed with blocks of the
Modelica.Blocks library).
</p>

</html>",
      revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>First Version from August 26, 1999 by P. Beater</em></li>
</ul>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
                              Line(points={{0,-100},{0,-61}}, color={0,0,
          127}),
        Text(
          extent={{-24,20},{66,-40}},
          textColor={64,64,64},
          textString="m/s")}));
end RelSpeedSensor;
