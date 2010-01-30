within Modelica.Electrical.QuasiStationary.SinglePhase.Sensors;
model CurrentSensor "Current sensor"
  extends QuasiStationary.SinglePhase.Interfaces.RelativeSensor;
equation
  v = Complex(0);
  y = i;
  annotation (Icon(graphics={Text(
          extent={{-29,-11},{30,-70}},
          lineColor={0,0,0},
          textString=
               "I")}),    Diagram(graphics),
  Documentation(info="<html>
<p>
This sensor can be used to measure the complex current.
</p>

<h4>See also</h4>

<p>
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>
</p>

</html>"));
end CurrentSensor;
