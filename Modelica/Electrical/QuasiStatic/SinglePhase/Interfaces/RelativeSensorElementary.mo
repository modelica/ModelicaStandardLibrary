within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
partial model RelativeSensorElementary "Elementary partial voltage / current sensor"
  extends Modelica.Icons.RoundSensor;
  extends TwoPinElementary;

equation
  Complex(0,0) = pin_p.i + pin_n.i "Current balance";

  annotation (Icon(graphics={
        Line(points={{-70,0},{-94,0}}, color={85,170,255}),
        Line(points={{70,0},{94,0}}, color={85,170,255}),
        Text(
          extent={{-150,120},{150,80}},
          textColor={0,0,255},
          textString="%name"),
        Line(points={{0,-100},{0,-70}}, color={85,170,255})}),
      Documentation(info="<html>
<p>
The relative sensor partial model relies on the
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.TwoPinElementary\">TwoPinElementary</a>
to measure the complex voltage or current. Additionally this model contains a proper icon and a definition of the angular velocity.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.AbsoluteSensor\">AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.AbsoluteSensor\">Polyphase.Interfaces.AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.RelativeSensorElementary\">Polyphase.Interfaces.RelativeSensorElementary</a>
</p>

</html>"));
end RelativeSensorElementary;
