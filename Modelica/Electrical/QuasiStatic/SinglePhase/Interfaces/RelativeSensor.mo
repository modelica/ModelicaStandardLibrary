within Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces;
partial model RelativeSensor "Partial voltage / current sensor"
  extends Modelica.Icons.RotationalSensor;
  extends OnePort;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(
        transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  annotation (Icon(graphics={
        Line(points={{-70,0},{-94,0}}, color={85,170,255}),
        Line(points={{70,0},{94,0}}, color={85,170,255}),
        Text(
          extent={{-160,120},{160,80}},
          textColor={0,0,255},
          textString="%name"),
        Line(points={{0,-70},{0,-80},{0,-90},{0,-100}})}),
      Documentation(info="<html>
<p>
The relative sensor partial model relies on the
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.OnePort\">OnePort</a> to measure the complex voltage, current or power. Additionally this model contains a proper icon and a definition of the angular velocity.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces.AbsoluteSensor\">AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.AbsoluteSensor\">Polyphase.Interfaces.AbsoluteSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces.RelativeSensor\">Polyphase.Interfaces.RelativeSensor</a>
</p>

</html>"));
end RelativeSensor;
