within Modelica.Electrical.Analog.Interfaces;
partial model AbsoluteSensor
  "Base class to measure the absolute value of a pin variable"
  extends Modelica.Icons.RoundSensor;

  Interfaces.PositivePin p "Positive electrical pin" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput y
    "Measured quantity as Real output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-70,0},{-90,0}}),
        Line(points={{70,0},{100,0}}, color={0,0,255}),
        Text(
          extent={{-150,80},{150,120}},
          textString="%name",
          textColor={0,0,255})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Line(points={{-70,0},{-96,0}}),
          Line(points={{70,0},{100,0}}, color={0,0,255})}),
    Documentation(revisions="<html>
<ul>
<li><em> 1998   </em>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>The AbsoluteSensor is a partial model for converting values that can be calculated from one pin connector into a real valued signal. The special calculation has to be described in the model which inherits the AbsoluteSensor.  It is often used in sensor devices. To be a true sensor the modeller has to take care that the sensor model does not influence the electrical behavior to be measured.</p>
</html>"));

end AbsoluteSensor;
