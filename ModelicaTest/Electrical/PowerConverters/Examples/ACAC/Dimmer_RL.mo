within ModelicaTest.Electrical.PowerConverters.Examples.ACAC;
model Dimmer_RL "Dimmer with resistive-inductive load"
  extends Modelica.Electrical.PowerConverters.Examples.ACAC.Dimmer_RL;
  annotation (experiment(
      StopTime=3.00,
      Interval=0.0002,
      Tolerance=1e-06),
    TestCase(shouldPass = true,
      __ModelicaAssociation(Comparison(timeWindows={TimeWindow(2.90, 3.00)}))));
end Dimmer_RL;
