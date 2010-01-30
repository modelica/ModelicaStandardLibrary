within Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces;
partial model RelativeSensor "Partial voltage / current sensor"
  extends Modelica.Icons.RotationalSensor;
  extends OnePort;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput y annotation (Placement(transformation(
        origin={0,-110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  annotation (Diagram(graphics),
                       Icon(graphics={
        Line(points={{-70,0},{-94,0}}, color={0,0,0}),
        Line(points={{70,0},{94,0}}, color={0,0,0}),
        Text(
          extent={{-100,100},{100,70}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={170,85,255},
          fillPattern=FillPattern.Solid,
          textString=
               "%name"),
        Line(points={{0,-70},{0,-80},{0,-90},{0,-100}}, color={85,170,255})}),
  Documentation(info="<html>
<p>
The relative sensor partial model relies on the 
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.OnePort\">OnePort</a> to measure the complex voltage, current or power. Additionally this model contains a proper icon and a definition of the angular velocity. 
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.AbsoluteSensor\">AbsoluteSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.AbsoluteSensor\">MultiPhase.Interfaces.AbsoluteSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Interfaces.RelativeSensor\">MultiPhase.Interfaces.RelativeSensor</a>
</p>

</html>"));
end RelativeSensor;
