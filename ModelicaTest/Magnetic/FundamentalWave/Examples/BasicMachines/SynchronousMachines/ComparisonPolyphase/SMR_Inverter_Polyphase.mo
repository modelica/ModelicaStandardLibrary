within ModelicaTest.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.ComparisonPolyphase;
model SMR_Inverter_Polyphase
  "Starting of polyphase synchronous reluctance machine with inverter"
  extends Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.ComparisonPolyphase.SMR_Inverter_Polyphase;
  annotation (experiment(StopTime=1.30, Interval=1E-4, Tolerance=1e-06),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(1.20, 1.30)}))));
end SMR_Inverter_Polyphase;
