within ModelicaTest.Electrical.PowerConverters.Examples.ACAC;
model SoftStarter "Soft start of an induction machine"
  extends Modelica.Electrical.PowerConverters.Examples.ACAC.SoftStarter;
  annotation (experiment(
      StopTime=10,
      Interval=0.0002,
      Tolerance=1e-06),
    TestCase(
      shouldPass = true,
      __MAPLib_ComparisonWindow={2.50, 2.60}),
    Documentation(info="<html>
<p>This model demonstrates a soft start of an induction machine:
Voltage ramp is started at 0.1 s and should ramp up to nominal voltage within 4s,
but current is limited to 2.5 times nominal current.
At 5.5 s a voltage ramp down within 3 s is required.
</p>
<p>Reference voltage is controlled by the
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.SoftStartControl\">softStartControl block</a>,
reference voltage is converted to firing angle by the
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.VoltageToAngle\">voltageToAngle block</a>.
Firing angle is processed by the
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control.Signal2mPulse\">Signal2mPulse adaptor</a>
to firing signals which are applied to the
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.PolyphaseTriac\">triac</a>.
</p>
<p>
Compare starting with firing angle by
<a href=\"modelica://Modelica.Electrical.Machines.Examples.InductionMachines.IMC_DOL\">starting direct on line</a>,
<a href=\"modelica://Modelica.Electrical.Machines.Examples.InductionMachines.IMC_YD\">star-delta starting</a>, and
<a href=\"modelica://Modelica.Electrical.Machines.Examples.InductionMachines.IMC_Transformer\">starting via a transformer</a>.
</p>
</html>"));
end SoftStarter;
