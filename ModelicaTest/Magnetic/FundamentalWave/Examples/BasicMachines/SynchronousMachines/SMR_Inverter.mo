within ModelicaTest.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMR_Inverter
  "Starting of synchronous reluctance machine with inverter"
  extends Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.SMR_Inverter;
  annotation (experiment(StopTime=1.30, Interval=1E-4, Tolerance=1e-06),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(1.20, 1.30)}))));
end SMR_Inverter;
