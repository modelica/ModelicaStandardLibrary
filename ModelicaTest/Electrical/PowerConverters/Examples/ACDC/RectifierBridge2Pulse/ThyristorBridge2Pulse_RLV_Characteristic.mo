within ModelicaTest.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse;
model ThyristorBridge2Pulse_RLV_Characteristic
  "Characteristic of two pulse Graetz thyristor bridge rectifier with R-L load and voltage"
  extends Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse.ThyristorBridge2Pulse_RLV_Characteristic;
  annotation (
    experiment(
      StopTime=5.05,
      Interval=0.0002,
      Tolerance=1e-06),
    TestCase(
      shouldPass = true,
      __MAPLib_ComparisonWindow={4.95, 5.05}),
    Documentation(info="<html>

<p>This examples shows a two pulse full controlled bridge example with R-L load including DC voltage source. The additional DC voltage source in this example enables negative average load voltages.</p>

<p>Plot average voltage <code>meanVoltage.v</code> versus firingAngle <code>pulse2.firingAngle</code> to see control characteristic of this type of rectifier with R-L load including active voltage.</p>
</html>"));
end ThyristorBridge2Pulse_RLV_Characteristic;
