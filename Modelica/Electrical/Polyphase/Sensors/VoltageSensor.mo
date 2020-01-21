within Modelica.Electrical.Polyphase.Sensors;
model VoltageSensor "Polyphase voltage sensor"
  extends Modelica.Icons.RoundSensor;
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput v[m](each unit="V")
    "Voltage between pin p and n (= p.v - n.v) as output signal"
    annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor[m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(voltageSensor.n, plug_n.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(voltageSensor.p, plug_p.pin)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(voltageSensor.v, v) annotation (Line(
      points={{0,-11},{0,-110}}, color={0,0,127}));
  annotation (
    Icon(graphics={Line(points={{-70,0},{-90,0}}),
          Line(points={{70,0},{90,0}}),Line(points={{0,-100},
          {0,-70}}, color={0,0,127}),
        Text(
          extent={{150,-100},{-150,-70}},
          textString="m=%m"),
        Text(
          extent={{-150,80},{150,120}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-30,-10},{30,-70}},
          textString="V",
          textColor={64,64,64})}),Documentation(info="<html>
<p>
Contains m voltage sensors (Modelica.Electrical.Analog.Sensors.VoltageSensor),
thus measuring the m potential differences <em>v[m]</em> between the m pins of plug_p and plug_n.
</p>
</html>"));
end VoltageSensor;
