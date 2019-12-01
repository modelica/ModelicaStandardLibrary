within Modelica.Electrical.QuasiStatic.SinglePhase.Sensors;
model PotentialSensor "Potential sensor"
  extends Interfaces.AbsoluteSensor;
  Modelica.ComplexBlocks.Interfaces.ComplexOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.SIunits.Voltage abs_y=Modelica.ComplexMath.abs(y) "Magnitude of complex potential";
  Modelica.SIunits.Angle arg_y=Modelica.ComplexMath.arg(y) "Argument of complex potential";
equation
  y = pin.v;
  annotation (Documentation(info="<html>

<p>
This sensor can be used to measure the complex potential.
</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.ReferenceSensor\">ReferenceSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.FrequencySensor\">FrequencySensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.VoltageSensor\">VoltageSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.CurrentSensor\">CurrentSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.PowerSensor\">PowerSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Sensors.MultiSensor\">MultiSensor</a>
</p>

</html>"),
       Icon(graphics={
        Text(
          extent={{-30,-10},{30,-70}},
          textColor={64,64,64},
          textString="V")}));
end PotentialSensor;
