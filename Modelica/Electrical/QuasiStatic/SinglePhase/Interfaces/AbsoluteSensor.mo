within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
partial model AbsoluteSensor "Partial potential sensor"
  extends Modelica.Icons.RoundSensor;
  SI.AngularVelocity omega;
  PositivePin pin "Positive quasi-static single-phase pin" annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}})));
equation
  omega = der(pin.reference.gamma);
  pin.i = Complex(0);
  annotation (Icon(graphics={
        Line(points={{-70,0},{-94,0}}, color={85,170,255}),
        Text(
          extent={{-150,120},{150,80}},
          textColor={0,0,255},
          textString="%name")}),         Documentation(info="<html>
<p>
The absolute sensor partial model provides a single
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.PositivePin\">positive pin</a>
to measure the complex voltage, frequency, angular frequency. Additionally this model contains
a proper icon and a definition of the angular velocity.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.RelativeSensorElementary\">RelativeSensorElementary</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.AbsoluteSensor\">Polyphase.Interfaces.AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.RelativeSensorElementary\">Polyphase.Interfaces.RelativeSensorElementary</a>
</p>

</html>"));
end AbsoluteSensor;
