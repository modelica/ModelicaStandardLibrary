within Modelica.Mechanics.Translational.Sensors;
model RelAccSensor "Ideal sensor to measure the relative acceleration"
  extends Translational.Interfaces.PartialRelativeSensor;
  SI.Position s_rel "Distance between the two flanges (flange_b.s - flange_a.s)";
  SI.Velocity v_rel "Relative velocity between the two flanges (der(flange_b.s) - der(flange_a.s))";
  Modelica.Blocks.Interfaces.RealOutput a_rel(unit="m/s2")
    "Relative acceleration between two flanges (= der(v_rel)) as output signal"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));

equation
  s_rel = flange_b.s - flange_a.s;
  v_rel = der(s_rel);
  a_rel = der(v_rel);
  0 = flange_a.f;
  annotation (
    Documentation(info="<html>
<p>
Measures the <em>relative acceleration a</em> of a flange in an ideal way and provides the result as
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
          textString="m/s2")}));
end RelAccSensor;
