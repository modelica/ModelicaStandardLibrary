within Modelica.Electrical.PowerConverters.Examples.DCDC.ChopperBuckBoost;
model ChopperBuckBoost_DutyCycle
  extends DCDC.ExampleTemplates.ChopperBuckBoost(pwm(useConstantDutyCycle=false));
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Step dutyCycle(
    height=0.2,
    offset=idleDutyCycle - 0.1,
    startTime=0.05)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
equation
  connect(dutyCycle.y, pwm.dutyCycle)
    annotation (Line(points={{1,-40},{8,-40}},  color={0,0,127}));
  annotation (experiment(
      StopTime=0.1,
      Interval=1e-06,
      Tolerance=1e-06),
      Documentation(info="<html>
<p>
This examples demonstrates bidirectional coupling of two batteries with different voltages as used in automotive. 
For <code>idleDutyCycle = 1 - (VLV/VHV)</code>, no current is exchanged.
</p>
<p>
Starting with <code>dutyCycle &lt; idleDutyCycle</code>, the high voltage battery feeds the low voltage battery. 
Changing the <code>dutyCycle &gt; idleDutyCycle</code>, the low voltage battery feeds the high voltage battery. 
</p>
<p>
The capacitors are precharged to the battery voltages, but the inductor leads zero current. 
The current sensor may be used to implement current control.
</p>
<h4>Control</h4>
<p>
For hints implementing control, see:
Stefan Norbert Matlok, 
<a href=\"https://nbn-resolving.org/urn:nbn:de:bvb:29-opus4-146221\"><em>Digitale Regelung bidirektionaler Gleichspannungswandler</em></a> 
(German, <em>Digital control of bidirectional DC/DC converters</em>), PhD thesis University Erlangen-Nuremberg 2020.
</p>
</html>"));
end ChopperBuckBoost_DutyCycle;
