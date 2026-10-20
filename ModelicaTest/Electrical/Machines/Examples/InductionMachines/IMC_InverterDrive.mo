within ModelicaTest.Electrical.Machines.Examples.InductionMachines;
model IMC_InverterDrive
  "Test example: InductionMachineSquirrelCage inverter drive"
  extends Modelica.Electrical.Machines.Examples.InductionMachines.IMC_InverterDrive;
  annotation (experiment(StopTime=0.95, Interval=5e-05, Tolerance=1e-06),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(0.85, 0.95)}))));
end IMC_InverterDrive;
