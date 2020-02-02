within Modelica.Electrical.Polyphase.Sensors;
model PotentialSensor "Polyphase potential sensor"
  extends Modelica.Icons.RoundSensor;
  parameter Integer m(final min=1) = 3 "Number of phases" annotation(Evaluate=true);
  Interfaces.PositivePlug plug_p(final m=m) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput phi[m](each unit="V")
    "Absolute voltage potential as output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  Modelica.Electrical.Analog.Sensors.PotentialSensor potentialSensor[m]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(potentialSensor.p, plug_p.pin)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(potentialSensor.phi, phi) annotation (Line(
      points={{11,0},{110,0}}, color={0,0,127}));
  annotation (
    Icon(graphics={Line(points={{70,0},{100,0}}, color={0,0,127}),
          Line(points={{-70,0},{-90,0}}, color={0,0,255}),
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
          textColor={64,64,64})}),    Documentation(info="<html>
<p>
Contains m potential sensors (Modelica.Electrical.Analog.Sensors.PotentialSensor),
thus measuring the m potentials <em>phi[m]</em> of the m pins of plug_p.
</p>
</html>"));
end PotentialSensor;
