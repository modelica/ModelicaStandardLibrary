within Modelica.Mechanics.Translational.Sensors;
model MultiSensor
  "Ideal sensor to measure the absolute velocity, force and power between two flanges"
  extends Translational.Interfaces.PartialRelativeSensor;
  Modelica.Blocks.Interfaces.RealOutput power(unit="W")
    "Power in flange flange_a as output signal" annotation (Placement(
        transformation(
        origin={-60,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput f(unit="N")
    "Force in flange_a and flange_b (f = flange_a.f = -flange_b.f) as output signal"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,-110})));
  Modelica.Blocks.Interfaces.RealOutput v(unit="m/s")
    "Absolute velocity of flange as output signal"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-110})));
equation
  flange_a.s = flange_b.s;
  f = flange_a.f;
  v = der(flange_a.s);
  power = f*v;

  annotation (
    Documentation(info="<html>
<p>
Measures the <em>absolute velocity</em> of the <code>flange_a</code> and
the <em>cut-force</em> and <em>power</em> between two flanges
in an ideal way and provides the results as output signals&nbsp;<code>v</code>,
<code>f</code> and <code>power</code>, respectively.
</p>
</html>"),
       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={    Line(points={{-60,
          -100},{-60,-60}}, color={0,0,127}),
                              Line(points={{0,-100},{0,-60}}, color={0,0,127}),
          Line(points={{60,-100},{60,-60}}, color={0,0,127}),
        Text(
          extent={{-100,-60},{-60,-100}},
          textColor={64,64,64},
          textString="W"),
        Text(
          extent={{-20,-60},{20,-100}},
          textColor={64,64,64},
          textString="N"),
        Text(
          extent={{60,-60},{100,-100}},
          textColor={64,64,64},
          textString="m/s")}));
end MultiSensor;
