within Modelica.Electrical.Analog.Sensors;
model CurrentSensor "Sensor to measure the current in a branch"
  extends Modelica.Icons.RoundSensor;

  Interfaces.PositivePin p "Positive pin" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.NegativePin n "Negative pin" annotation (Placement(
        transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput i(unit="A")
    "Current in the branch from p to n as output signal"
     annotation (Placement(transformation(
        origin={0,-110},
        extent={{10,-10},{-10,10}},
        rotation=90)));

equation
  p.v = n.v;
  p.i = i;
  n.i = -i;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,80},{150,120}},
          textString="%name",
          textColor={0,0,255}),
        Line(points={{0,-100},{0,-70}}, color={0,0,127}),
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="A"),  Line(points={{100,0},{-100,0}}, color={0,0,255})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-153,79},{147,119}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>The current sensor converts the current flowing between the two connectors into a real valued signal. The two connectors are in the sensor connected like a short cut. The sensor has to be placed within an electrical connection in series.  It does not influence the current sum at the connected nodes. Therefore, the electrical behavior is not influenced by the sensor.</p>
</html>"));
end CurrentSensor;
