within ModelicaTest.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_Transformer "Induction machine with squirrel cage starting with transformer"
  extends Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.InductionMachines.IMC_Transformer;
  annotation (experiment(StopTime=2.1, Interval=0.0001, Tolerance=1e-06),
    TestCase(shouldPass = true,
      __ModelicaAssociation(Comparison(timeWindows={TimeWindow(2.00, 2.10)}))),
    Diagram(graphics={
        Text(
          extent={{80,8},{160,0}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static"),
                                            Text(
                  extent={{80,-92},{160,-100}},
                  textStyle={TextStyle.Bold},
          textString="%m phase transient")}));
end IMC_Transformer;
