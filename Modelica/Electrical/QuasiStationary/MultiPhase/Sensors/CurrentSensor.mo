within Modelica.Electrical.QuasiStationary.MultiPhase.Sensors;
model CurrentSensor
  extends Interfaces.RelativeSensor;
  SinglePhase.Sensors.CurrentSensor currentSensor[m] 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
equation
  connect(plugToPins_p.pin_p,currentSensor. pin_p) 
    annotation (Line(points={{-68,6.10623e-016},{-53.5,6.10623e-016},{-53.5,
          1.22125e-015},{-39,1.22125e-015},{-39,6.10623e-016},{-10,6.10623e-016}},
        color={85,170,255}));
  connect(currentSensor.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,
          6.10623e-016},{39,6.10623e-016},{39,7.44522e-016},{68,7.44522e-016}},
        color={85,170,255}));
  connect(currentSensor.y, y) 
    annotation (Line(points={{6.10623e-016,-11},{6.10623e-016,-35.75},{
          1.16573e-015,-35.75},{1.16573e-015,-60.5},{5.55112e-016,-60.5},{
          5.55112e-016,-110}}, color={85,170,255}));
  annotation (Diagram(graphics),
                       Icon(graphics={Text(
          extent={{-29,-11},{30,-70}},
          lineColor={0,0,0},
          textString=
               "I")}),
  Documentation(info="<html>

<p>
This sensor can be used to measure <i>m</i> complex currents, using <i>m</i> 
<a href=\"Modelica://Modelica_QuasiStationary.SinglePhase.Sensors.CurrentSensor\">single phase CurrentSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica_QuasiStationary.SinglePhase.Sensors.CurrentSensor\">SinglePhase.CurrentSensor</a>, 
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>, 
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>, 
<a href=\"Modelica://Modelica_QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
end CurrentSensor;
