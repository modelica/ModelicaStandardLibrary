within ModelicaTest.Electrical.PowerConverters.Examples.ACAC;
model SoftStarter "Soft start of an induction machine"
  extends Modelica.Electrical.PowerConverters.Examples.ACAC.SoftStarter;
  annotation (experiment(
      StopTime=2.60,
      Interval=0.0002,
      Tolerance=1e-06),
    TestCase(shouldPass = true,
      __ModelicaAssociation(Comparison(timeWindows={TimeWindow(2.50, 2.60)}))));
end SoftStarter;
