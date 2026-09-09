within ModelicaTest.Electrical.Machines.Examples.InductionMachines;
model IMC_YDarc "Test example: InductionMachineSquirrelCage Y-D"
  extends Modelica.Electrical.Machines.Examples.InductionMachines.IMC_YDarc;
  annotation (experiment(StopTime=2.07, Interval=0.0001, Tolerance=1e-06),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(2.02, 2.07)}))));
end IMC_YDarc;
