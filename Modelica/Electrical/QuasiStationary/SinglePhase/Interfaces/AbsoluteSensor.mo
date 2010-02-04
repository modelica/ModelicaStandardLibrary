within Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces;
partial model AbsoluteSensor "Partial potential sensor"
  extends Modelica.Icons.RotationalSensor;
  Modelica.SIunits.AngularVelocity omega = der(pin.reference.gamma);
  QuasiStationary.SinglePhase.Interfaces.PositivePin pin "Pin"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  Modelica.ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(transformation(extent=
           {{100,-10},{120,10}}, rotation=0)));
equation
  pin.i = Complex(0);
  annotation (Diagram(graphics),
                       Icon(graphics={
        Line(points={{-70,0},{-94,0}}, color={0,0,0}),
        Text(
          extent={{-100,100},{100,70}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={170,85,255},
          fillPattern=FillPattern.Solid,
          textString=
               "%name"),
        Line(points={{70,0},{80,0},{90,0},{100,0}}, color={85,170,255})}),
  Documentation(info="<html>
<p>
The absolute sensor partial model provides a single
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin\">positive pin</a> to measure the complex voltage. Additionally this model contains a proper icon and a definition of the angular velocity.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.RelativeSensor\">RelativeSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.AbsoluteSensor\">MultiPhase.Interfaces.AbsoluteSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.RelativeSensor\">MultiPhase.Interfaces.RelativeSensor</a>
</p>

</html>"));
end AbsoluteSensor;
