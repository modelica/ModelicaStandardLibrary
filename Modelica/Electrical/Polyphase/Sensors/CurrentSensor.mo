within Modelica.Electrical.Polyphase.Sensors;
model CurrentSensor "Polyphase current sensor"
  extends Modelica.Icons.RoundSensor;
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePlug plug_n(final m=m) annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput i[m](each unit="A")
    "Current in the branch from p to n as output signal" annotation (
      Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor[m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(plug_p.pin, currentSensor.p)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,0,255}));
  connect(currentSensor.n, plug_n.pin)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(currentSensor.i, i) annotation (Line(
      points={{0,-11},{0,-110}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
                                       Line(points={{0,-100},
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
          textColor={64,64,64},
          textString="A"),  Line(points={{100,0},{-100,0}}, color={0,0,255})}),
                                  Documentation(info="<html>
<p>
Contains m current sensors (Modelica.Electrical.Analog.Sensors.CurrentSensor),
thus measuring the m currents <em>i[m]</em> flowing from the m pins of plug_p to the m pins of plug_n.
</p>
</html>"));
end CurrentSensor;
