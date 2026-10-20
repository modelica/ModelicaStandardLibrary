within ModelicaTest.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMEE_LoadDump
  "Test example: ElectricalExcitedSynchronousMachine with voltage controller"
  extends Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.SMEE_LoadDump;
  annotation (experiment(StopTime=4.05, Interval=1E-4, Tolerance=1e-06),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(4.00, 4.05)}))));
end SMEE_LoadDump;
