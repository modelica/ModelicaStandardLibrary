within ModelicaTest.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMEE_Generator "Electrical excited synchronous machine operating as generator"
  extends Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.SMEE_Generator;
  annotation (
    experiment(
      StopTime=15.1,
      Interval=1E-4,
      Tolerance=1e-06),
    TestCase(shouldPass = true,
      __ModelicaAssociation(Comparison(timeWindows={TimeWindow(14.9, 15.1)}))),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                         graphics={         Text(
                  extent={{20,8},{100,0}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static",
          textColor={0,0,0}),                      Text(
          extent={{20,-92},{100,-100}},
                  textStyle={TextStyle.Bold},
          textString="%m phase transient",
          textColor={0,0,0})}));
end SMEE_Generator;
