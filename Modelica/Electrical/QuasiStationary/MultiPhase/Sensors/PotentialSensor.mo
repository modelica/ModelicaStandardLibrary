within Modelica.Electrical.QuasiStationary.MultiPhase.Sensors;
model PotentialSensor
  extends Interfaces.AbsoluteSensor;
  SinglePhase.Sensors.PotentialSensor potentialSensor[m] 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
equation

  connect(plugToPins_p.pin_p, potentialSensor.pin) annotation (Line(points={{-68,0},
          {-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},{-39,0},{-10,0}},
                                                                color={85,170,
          255}));
  connect(potentialSensor.y, y) annotation (Line(points={{11,0},{35.75,0},{35.75,
          1.16573e-015},{60.5,1.16573e-015},{60.5,0},{110,0}},
                                             color={85,170,255}));
  annotation (Icon(graphics={Text(
          extent={{-29,-11},{30,-70}},
          lineColor={0,0,0},
          textString=
               "V")}),    Diagram(graphics),
  Documentation(info="<html>

<p>
This sensor can be used to measure <i>m</i> complex potentials, using <i>m</i> 
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">single phase PotentialSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">SinglePhase.PotentialSensor</a>, 
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.VoltageSensor\">VoltageSensor</a>, 
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>, 
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
end PotentialSensor;
