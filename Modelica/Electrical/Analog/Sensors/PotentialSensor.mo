within Modelica.Electrical.Analog.Sensors;
model PotentialSensor "Sensor to measure the potential"
  extends Modelica.Icons.RoundSensor;

  Interfaces.PositivePin p "Pin to be measured" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput phi(unit="V")
    "Absolute voltage potential as output signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  p.i = 0;
  phi = p.v;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-70,0},{-90,0}}, color={0,0,255}),
        Line(points={{100,0},{70,0}}, color={0,0,127}),
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
<p>The potential sensor converts the voltage of a node (with respect to the ground node) into a real valued signal. It does not influence the current sum at the node which voltage is measured, therefore, the electrical behavior is not influenced by the sensor.</p>
</html>"));
end PotentialSensor;
