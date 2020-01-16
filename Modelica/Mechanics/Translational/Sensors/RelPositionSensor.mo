within Modelica.Mechanics.Translational.Sensors;
model RelPositionSensor "Ideal sensor to measure the relative position"
  extends Translational.Interfaces.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput s_rel(unit="m")
    "Distance between two flanges (= flange_b.s - flange_a.s) as output signal"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));

equation
  s_rel = flange_b.s - flange_a.s;
  0 = flange_a.f;
  annotation (
    Documentation(info="<html>
<p>
Measures the <em>relative position s</em> of a flange in an ideal way and provides the result as
output signals (to be further processed with blocks of the
Modelica.Blocks library).
</p>

</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
                              Line(points={{0,-99},{0,-60}}, color={0,0,127}),
        Text(
          extent={{-24,20},{66,-40}},
          textColor={64,64,64},
          textString="m")}));
end RelPositionSensor;
