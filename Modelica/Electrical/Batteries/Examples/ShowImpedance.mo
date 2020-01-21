within Modelica.Electrical.Batteries.Examples;
model ShowImpedance "Show complex cell impedance"
  extends Modelica.Icons.Example;
  Blocks.Sources.LogFrequencySweep logSweep(
    wMin=1e-6,
    wMax=1e3,
    duration=1)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Utilities.Impedance impedance(cellData=cellData)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  parameter ParameterRecords.TransientData.ExampleData cellData(Qnom=3600, Ri=
        0.01)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
equation
  connect(logSweep.y, impedance.f)
    annotation (Line(points={{-29,0},{-12,0}}, color={0,0,127}));
  annotation (experiment(Interval=0.0001, StopTime=1), Documentation(info="<html>
<p>
Plot <code>impedance.z.im</code> versus <code>impedance.z.re</code>
</p>
</html>"));
end ShowImpedance;
