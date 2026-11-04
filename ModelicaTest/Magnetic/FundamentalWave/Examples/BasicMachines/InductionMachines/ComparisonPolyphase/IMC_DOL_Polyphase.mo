within ModelicaTest.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.ComparisonPolyphase;
model IMC_DOL_Polyphase
  "Direct on line start of polyphase induction machine with squirrel cage"
  extends Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.InductionMachines.ComparisonPolyphase.IMC_DOL_Polyphase;
  annotation (experiment(StopTime=0.15, Interval=1E-4, Tolerance=1e-06),
    TestCase(shouldPass = true,
    __ModelicaAssociation(Comparison(timeWindows={TimeWindow(0.10, 0.15)}))));
end IMC_DOL_Polyphase;
