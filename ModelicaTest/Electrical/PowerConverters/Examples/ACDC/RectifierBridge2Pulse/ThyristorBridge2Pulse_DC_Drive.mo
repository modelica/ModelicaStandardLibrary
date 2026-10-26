within ModelicaTest.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse;
model ThyristorBridge2Pulse_DC_Drive
  "Two pulse Graetz thyristor bridge feeding a DC drive"
  extends Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierBridge2Pulse.ThyristorBridge2Pulse_DC_Drive;
  annotation (
    experiment(
      StopTime=2.55,
      Interval=0.0002,
      Tolerance=1e-006),
    TestCase(shouldPass = true,
      __ModelicaAssociation(Comparison(timeWindows={TimeWindow(2.45, 2.55)}))));
end ThyristorBridge2Pulse_DC_Drive;
