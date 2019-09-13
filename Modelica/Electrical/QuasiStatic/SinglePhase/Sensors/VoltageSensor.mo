within Modelica.Electrical.QuasiStatic.SinglePhase.Sensors;
model VoltageSensor "Voltage sensor"
  extends Interfaces.RelativeSensor;
  Modelica.SIunits.Voltage abs_y=Modelica.ComplexMath.'abs'(y) "Magnitude of complex voltage";
  Modelica.SIunits.Angle arg_y=Modelica.ComplexMath.arg(y) "Argument of complex voltage";
equation
  i = Complex(0);
  y = v;
  annotation (Documentation(info="<html>
<p>
This sensor can be used to measure the complex voltage.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PotentialSensor\">PotentialSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"),
       Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="V")}));
end VoltageSensor;
