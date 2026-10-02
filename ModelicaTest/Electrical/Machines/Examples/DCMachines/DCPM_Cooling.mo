within ModelicaTest.Electrical.Machines.Examples.DCMachines;
model DCPM_Cooling "Test example: Cooling of a DCPM motor"
  extends Modelica.Electrical.Machines.Examples.DCMachines.DCPM_Cooling;
  annotation (experiment(StopTime=5.75, Interval=1E-3, Tolerance=1E-6),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(5.25, 5.75)}))));
end DCPM_Cooling;
