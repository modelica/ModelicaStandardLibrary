within ModelicaTest.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMEE_Generator
  "Electrical excited synchronous machine operating as generator"
  extends Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.SMEE_Generator;
  annotation (experiment(StopTime=15.10, Interval=0.001, Tolerance=1e-06),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(14.90, 15.10)}))));
end SMEE_Generator;
