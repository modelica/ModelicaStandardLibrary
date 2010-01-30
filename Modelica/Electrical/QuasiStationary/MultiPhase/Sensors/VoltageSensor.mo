within Modelica.Electrical.QuasiStationary.MultiPhase.Sensors;
model VoltageSensor
  extends Interfaces.RelativeSensor;
  SinglePhase.Sensors.VoltageSensor voltageSensor[m] 
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
equation
  connect(plugToPins_p.pin_p, voltageSensor.pin_p) 
    annotation (Line(points={{-68,0},{-53.5,0},{-53.5,1.22125e-015},{-39,1.22125e-015},
          {-39,0},{-10,0}},
        color={85,170,255}));
  connect(voltageSensor.pin_n, plugToPins_n.pin_n) annotation (Line(points={{10,0},{
          39,0},{39,2.44929e-016},{68,2.44929e-016}},
        color={85,170,255}));
  connect(voltageSensor.y, y) 
    annotation (Line(points={{0,-11},{0,-35.75},{1.16573e-015,-35.75},{1.16573e-015,
          -60.5},{0,-60.5},{0,-110}},
                               color={85,170,255}));
  annotation (Diagram(graphics),
                       Icon(graphics={Text(
          extent={{-29,-11},{30,-70}},
          lineColor={0,0,0},
          textString=
               "V")}),
  Documentation(info="<html>

<p>
This sensor can be used to measure <i>m</i> complex voltages, using <i>m</i> 
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">single phase VoltageSensors</a>.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">SinglePhase.VoltageSensor</a>, 
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PotentialSensor\">PotentialSensor</a>, 
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.CurrentSensor\">CurrentSensor</a>, 
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
end VoltageSensor;
