within ModelicaTest.Electrical.Machines.Examples.InductionMachines;
model IMC_DCBraking "Induction machine with DC current braking"
  extends Modelica.Electrical.Machines.Examples.InductionMachines.IMC_DCBraking;
  annotation (experiment(StopTime=16.1, Interval=0.001, Tolerance=1e-06),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(16.0, 16.1)}))));
end IMC_DCBraking;
