within ModelicaTest.Electrical.PowerConverters.Examples.ACAC;
model Dimmer_R "Dimmer with resistive load"
  extends Modelica.Electrical.PowerConverters.Examples.ACAC.Dimmer_R;
  annotation (experiment(
      StopTime=3.00,
      Interval=0.0002,
      Tolerance=1e-06),
    TestCase(
      shouldPass = true,
      __MAPLib_ComparisonWindow={2.90, 3.00}),
    Documentation(info="<html>
<p>
This model demonstrates the behaviour of a dimmer with phase-angle control with resistive load.
</p>
<p>
The reference voltage is prescribed by a trapezoid between zero and full voltage.
The <a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.Control.VoltageToAngle\">voltageToAngle block</a>
calculates the necessary phase angle, which is processed by
the <a href=\"modelica://Modelica.Electrical.PowerConverters.ACDC.Control.Signal2mPulse\">Signal2mPulse adaptor</a>,
applying the firing signals to the
<a href=\"modelica://Modelica.Electrical.PowerConverters.ACAC.SinglePhaseTriac\">triac</a>.
</p>
</html>"));
end Dimmer_R;
