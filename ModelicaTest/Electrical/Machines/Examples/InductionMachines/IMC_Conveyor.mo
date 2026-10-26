within ModelicaTest.Electrical.Machines.Examples.InductionMachines;
model IMC_Conveyor
  "Test example: InductionMachineSquirrelCage with inverter driving a conveyor"
  extends Modelica.Electrical.Machines.Examples.InductionMachines.IMC_Conveyor;
  annotation (experiment(StopTime=0.35, Interval=0.001, Tolerance=1e-06),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(0.25, 0.35)}))));
end IMC_Conveyor;
