within ModelicaTest.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2mPulse;
model ThyristorCenterTap2mPulse_RLV_Characteristic
  "Characteristic of 2*m pulse center tap thyristor rectifier with R-L load and voltage"
  extends Modelica.Electrical.PowerConverters.Examples.ACDC.RectifierCenterTap2mPulse.ThyristorCenterTap2mPulse_RLV_Characteristic;
  annotation (
    experiment(
      StopTime=5.05,
      Tolerance=1e-06,
      Interval=0.0002),
    TestCase(shouldPass = true,
      __ModelicaAssociation(Comparison(timeWindows={TimeWindow(4.95, 5.05)}))));
end ThyristorCenterTap2mPulse_RLV_Characteristic;
