within ModelicaTest.Electrical.PowerConverters.Examples.ACDC.Rectifier1Pulse;
model Thyristor1Pulse_R_Characteristic
  "Control characteristic of one pulse rectifier with resistive load"
  extends Modelica.Electrical.PowerConverters.Examples.ACDC.Rectifier1Pulse.Thyristor1Pulse_R_Characteristic;
  annotation (
    experiment(
      StopTime=5.05,
      Tolerance=1e-06,
      Interval=0.0002),
    TestCase(
      shouldPass = true,
      __MAPLib_ComparisonWindow={4.95, 5.05}),
    Documentation(info="<html>
<p>This example demonstrates the operational behavior of a single-phase controlled rectifier with variable firing angle and resistive load. The average load voltage can be controlled by means of the firing angle.</p>
<p><br>Plot average voltage <code>meanVoltage.v</code> versus firingAngle <code>pulse2.firingAngle</code> to see control characteristic of this type of rectifier with resistive load.</p>
</html>"));
end Thyristor1Pulse_R_Characteristic;
