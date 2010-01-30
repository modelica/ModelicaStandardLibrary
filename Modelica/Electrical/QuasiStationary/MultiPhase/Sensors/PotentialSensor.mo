within Modelica.Electrical.QuasiStationary.MultiPhase.Sensors;
model PotentialSensor
  extends Interfaces.AbsoluteSensor;
  SinglePhase.Sensors.PotentialSensor potentialSensor[m] 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
equation

  connect(plugToPins_p.pin_p, potentialSensor.pin) annotation (Line(points={{
          -68,6.10623e-016},{-53.5,6.10623e-016},{-53.5,1.22125e-015},{-39,
          1.22125e-015},{-39,6.10623e-016},{-10,6.10623e-016}}, color={85,170,
          255}));
  connect(potentialSensor.y, y) annotation (Line(points={{11,6.10623e-016},{
          35.75,6.10623e-016},{35.75,1.16573e-015},{60.5,1.16573e-015},{60.5,
          5.55112e-016},{110,5.55112e-016}}, color={85,170,255}));
  annotation (Icon(graphics={Text(
          extent={{-29,-11},{30,-70}},
          lineColor={0,0,0},
          textString=
               "V")}),    Diagram(graphics),
  Documentation(info="<html>

<p>
This sensor can be used to measure <i>m</i> complex potentials, using <i>m</i> 
<a href=\"Modelica://Modelica_QuasiStationary.SinglePhase.Sensors.PotentialSensor\">single phase PotentialSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica_QuasiStationary.SinglePhase.Sensors.PotentialSensor\">SinglePhase.PotentialSensor</a>, 
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>, 
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>, 
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
end PotentialSensor;
