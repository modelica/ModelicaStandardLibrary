within ModelicaTest.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_withLosses
  "Induction machine with squirrel cage and losses"
  extends Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.IMC_withLosses;
  annotation (experiment(StopTime=4.60, Interval=1E-4, Tolerance=1e-06),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(4.50, 4.60)}))));
end IMC_withLosses;
