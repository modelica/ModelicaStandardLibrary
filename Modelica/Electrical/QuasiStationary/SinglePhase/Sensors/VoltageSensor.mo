within Modelica.Electrical.QuasiStationary.SinglePhase.Sensors;
model VoltageSensor "Voltage sensor"
  extends QuasiStationary.SinglePhase.Interfaces.RelativeSensor;
equation
  i = Complex(0);
  y = v;
  annotation (Icon(graphics={Text(
          extent={{-29,-11},{30,-70}},
          lineColor={0,0,0},
          textString=
               "V")}),    Diagram(graphics),
  Documentation(info="<html>
<p>
This sensor can be used to measure the complex voltage.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
end VoltageSensor;
