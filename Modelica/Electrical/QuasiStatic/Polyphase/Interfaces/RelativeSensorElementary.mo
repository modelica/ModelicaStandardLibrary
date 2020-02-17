within Modelica.Electrical.QuasiStatic.Polyphase.Interfaces;
partial model RelativeSensorElementary "Elementary partial voltage / current sensor"
  extends Modelica.Icons.RoundSensor;
  extends TwoPlugElementary;
  annotation (Icon(graphics={
        Line(points={{-70,0},{-94,0}}, color={85,170,255}),
        Line(points={{70,0},{94,0}}, color={85,170,255}),
        Line(points={{0,-70},{0,-80},{0,-90},{0,-100}}, color={85,170,255}),
        Text(
          extent={{150,-100},{-150,-70}},
          textString="m=%m"),
        Text(
          textColor={0,0,255},
          extent={{-150,80},{150,120}},
          textString="%name")}), Documentation(info="<html>
<p>
The relative sensor partial model relies on the
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.TwoPlug\">TwoPlug</a> to measure the complex voltages, currents or power. Additionally this model contains a proper icon and a definition of the angular velocity.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.AbsoluteSensor\">AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.AbsoluteSensor\">SinglePhase.Interfaces.AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.RelativeSensorElementary\">SinglePhase.Interfaces.RelativeSensorElementary</a>
</p>

</html>"));

end RelativeSensorElementary;
