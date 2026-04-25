within ModelicaTest.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTapmPulse;
model ThyristorCenterTapmPulse_RLV_Characteristic
  "Characteristic of 2*m pulse thyristor rectifier with center tap and R-L load and voltage"
  extends Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTapmPulse.ThyristorCenterTapmPulse_RLV_Characteristic;
  annotation (
    experiment(
      StopTime=5.05,
      Tolerance=1e-06,
      Interval=0.0002),
    TestCase(
      shouldPass = true,
      __MAPLib_ComparisonWindow={4.95, 5.05}),
    Documentation(info="<html>
<p>This example shows a controlled <code>m</code> pulse center tap rectifier with R-L load including DC voltage source, where <code>m</code> is the number of phases. The additional DC voltage source in this example enables negative average load voltages.</p>

<p>Plot average voltage <code>meanVoltage.v</code> versus firingAngle <code>pulsem.firingAngle</code> to see control characteristic of this type of rectifier with R-L load including active voltage.</p>
</html>"));
end ThyristorCenterTapmPulse_RLV_Characteristic;
