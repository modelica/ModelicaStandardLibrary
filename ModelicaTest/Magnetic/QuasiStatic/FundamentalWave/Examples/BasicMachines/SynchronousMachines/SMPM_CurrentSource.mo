within ModelicaTest.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.SynchronousMachines;
model SMPM_CurrentSource "Test example: PermanentMagnetSynchronousMachine fed by current source"
  extends Modelica.Magnetic.QuasiStatic.FundamentalWave.Examples.BasicMachines.SynchronousMachines.SMPM_CurrentSource;
  annotation (
    experiment(StopTime=0.20, Interval=1E-4, Tolerance=1E-6),
    TestCase(shouldPass = true,
      __ModelicaAssociation(Comparison(timeWindows={TimeWindow(0.00, 0.20)}))),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{30,48},{110,40}},
                  textStyle={TextStyle.Bold},
          textString="%m phase quasi-static"),               Text(
                  extent={{30,-52},{110,-60}},
                  textStyle={TextStyle.Bold},
                  textString="%m phase transient")}));
end SMPM_CurrentSource;
