within ModelicaTest.Electrical.Machines.Examples.InductionMachines;
model IMC_Transformer
  "Test example: InductionMachineSquirrelCage transformer starting"
  extends Modelica.Electrical.Machines.Examples.InductionMachines.IMC_Transformer;
  annotation (experiment(StopTime=2.05, Interval=1E-4, Tolerance=1e-06),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(2.00, 2.05)}))));
end IMC_Transformer;
