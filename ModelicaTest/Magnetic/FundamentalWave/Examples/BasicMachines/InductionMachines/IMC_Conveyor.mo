within ModelicaTest.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_Conveyor
  "Induction machine with squirrel cage and inverter driving a conveyor"
  extends Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.IMC_Conveyor;
  annotation (experiment(StopTime=0.35, Interval=1E-3, Tolerance=1e-06),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(0.25, 0.35)}))));
end IMC_Conveyor;
