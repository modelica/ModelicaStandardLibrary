within ModelicaTest.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse;
model ThyristorBridge2mPulse_RLV_Characteristic
  "Characteristic of 2*m pulse thyristor rectifier bridge with R-L load and voltage"
  extends Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2mPulse.ThyristorBridge2mPulse_RLV_Characteristic;
  annotation (
    experiment(
      StopTime=5.05,
      Interval=0.0002,
      Tolerance=1e-06),
    TestCase(shouldPass = true,
      __ModelicaAssociation(Comparison(timeWindows={TimeWindow(4.95, 5.05)}))));
end ThyristorBridge2mPulse_RLV_Characteristic;
