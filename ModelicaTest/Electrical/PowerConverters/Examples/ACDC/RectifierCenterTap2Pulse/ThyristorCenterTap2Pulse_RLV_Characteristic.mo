within ModelicaTest.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse;
model ThyristorCenterTap2Pulse_RLV_Characteristic
  "Characteristic of two pulse thyristor rectifier with center tap and R-L load and voltage"
  extends Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2Pulse.ThyristorCenterTap2Pulse_RLV_Characteristic;
  annotation (
    experiment(
      StopTime=5.05,
      Tolerance=1e-06,
      Interval=0.0002),
    TestCase(shouldPass = true,
      __ModelicaAssociation(Comparison(timeWindows={TimeWindow(4.95, 5.05)}))));
end ThyristorCenterTap2Pulse_RLV_Characteristic;
