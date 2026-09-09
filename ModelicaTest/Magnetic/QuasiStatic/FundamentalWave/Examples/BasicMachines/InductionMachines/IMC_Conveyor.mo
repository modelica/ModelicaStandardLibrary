within ModelicaTest.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.InductionMachines;
model IMC_Conveyor "Induction machine with squirrel cage and inverter driving a conveyor"
  extends Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.InductionMachines.IMC_Conveyor;
  annotation (experiment(StopTime=5.00, Interval=0.0001, Tolerance=1e-06),
    TestCase(shouldPass = true,
      __ModelicaAssociation(Comparison(timeWindows={TimeWindow(4.00, 5.00)}))),
    Diagram(graphics={
        Text(
          extent={{20,60},{100,52}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static"),
                                            Text(
                  extent={{20,-40},{100,-48}},
                  textStyle={TextStyle.Bold},
          textString="%m phase transient")}));
end IMC_Conveyor;
