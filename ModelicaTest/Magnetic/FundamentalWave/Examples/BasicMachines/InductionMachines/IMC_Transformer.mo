within ModelicaTest.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_Transformer
  "Induction machine with squirrel cage starting with transformer"
  extends Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.IMC_Transformer;
  annotation (experiment(StopTime=2.05, Interval=1E-4, Tolerance=1e-06),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(2.00, 2.05)}))));
end IMC_Transformer;
