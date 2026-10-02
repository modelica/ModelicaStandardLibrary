within ModelicaTest.Electrical.Machines.Examples.InductionMachines;
model IMC_withLosses
  "Test example: InductionMachineSquirrelCage with losses"
  extends Modelica.Electrical.Machines.Examples.InductionMachines.IMC_withLosses;
  annotation (experiment(StopTime=4.6, Interval=1E-4, Tolerance=1e-06),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(4.5, 4.6)}))));
end IMC_withLosses;
