within ModelicaTest.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse;
model ThyristorBridge2Pulse_RLV_Characteristic
  "Characteristic of two pulse Graetz thyristor bridge rectifier with R-L load and voltage"
  extends Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse.ThyristorBridge2Pulse_RLV_Characteristic;
  annotation (
    experiment(
      StopTime=5.05,
      Interval=0.0002,
      Tolerance=1e-06),
    TestCase(shouldPass = true,
      __ModelicaAssociation(Comparison(timeWindows={TimeWindow(4.95, 5.05)}))));
end ThyristorBridge2Pulse_RLV_Characteristic;
