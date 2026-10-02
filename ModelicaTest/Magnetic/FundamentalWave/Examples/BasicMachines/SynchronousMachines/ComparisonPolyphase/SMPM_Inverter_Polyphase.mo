within ModelicaTest.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.ComparisonPolyphase;
model SMPM_Inverter_Polyphase
  "Starting of polyphase permanent magnet synchronous machine with inverter"
  extends Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.ComparisonPolyphase.SMPM_Inverter_Polyphase;
  annotation (experiment(StopTime=1.30, Interval=1E-4, Tolerance=1e-006),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(1.20, 1.30)}))));
end SMPM_Inverter_Polyphase;
