within Modelica.Electrical.Analog.Sensors;
model VoltageSensor "Sensor to measure the voltage between two pins"
  extends Modelica.Icons.RoundSensor;

  Interfaces.PositivePin p "Positive pin" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePin n "Negative pin" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput v(unit="V")
    "Voltage between pin p and n (= p.v - n.v) as output signal"
     annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

equation
  p.i = 0;
  n.i = 0;
  v = p.v - n.v;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-70,0},{-90,0}}, color={0,0,255}),
        Line(points={{70,0},{90,0}}, color={0,0,255}),
        Line(points={{0,-100},{0,-70}}, color={0,0,127}),
        Text(
          extent={{-150,80},{150,120}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-30,-10},{30,-70}},
          textString="V",
          textColor={64,64,64})}),
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>The voltage sensor converts the voltage between the two connectors into a real valued signal. It does not influence the current sum at the nodes in between the voltage is measured, therefore, the electrical behavior is not influenced by the sensor.</p>
</html>"));
end VoltageSensor;
