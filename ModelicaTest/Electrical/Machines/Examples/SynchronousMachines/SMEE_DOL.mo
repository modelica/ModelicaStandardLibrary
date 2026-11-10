within ModelicaTest.Electrical.Machines.Examples.SynchronousMachines;
model SMEE_DOL
  "Test example: ElectricalExcitedSynchronousMachine starting direct on line"
  extends Modelica.Electrical.Machines.Examples.SynchronousMachines.SMEE_DOL;
  annotation (experiment(StopTime=2.05, Interval=0.0001, Tolerance=1e-006),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(2.00, 2.05)}))));
end SMEE_DOL;
