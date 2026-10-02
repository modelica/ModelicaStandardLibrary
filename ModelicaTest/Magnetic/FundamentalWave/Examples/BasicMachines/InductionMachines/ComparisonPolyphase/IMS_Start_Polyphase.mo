within ModelicaTest.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.ComparisonPolyphase;
model IMS_Start_Polyphase
  "Starting of polyphase induction machine with slip rings"
  extends Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.ComparisonPolyphase.IMS_Start_Polyphase;
  annotation (experiment(StopTime=1.05, Interval=1E-4, Tolerance=1e-06),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(1.00, 1.05)}))));
end IMS_Start_Polyphase;
