within Modelica.Clocked.Examples.Elementary.BooleanSignals;
model UpSample "Example of an UpSample block for Boolean signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
  Modelica.Clocked.BooleanSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-48,24},{-36,36}})));
Modelica.Clocked.BooleanSignals.Sampler.Utilities.UpSample upSample1
  annotation (Placement(transformation(extent={{-26,34},{-14,46}})));
Modelica.Clocked.BooleanSignals.Sampler.Utilities.UpSample upSample2(
    inferFactor=false, factor=3)
  annotation (Placement(transformation(extent={{-26,14},{-14,26}})));
  Modelica.Blocks.Sources.BooleanTable table1(table={0.05,0.15})
    annotation (Placement(transformation(extent={{-82,20},{-62,40}})));
Modelica.Blocks.Logical.And and1
  annotation (Placement(transformation(extent={{0,20},{20,40}})));
equation
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-55.4,0},{-42,0},{-42,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(table1.y, sample1.u)
    annotation (Line(points={{-61,30},{-49.2,30}}, color={255,0,255}));
  connect(upSample1.u, sample1.y) annotation (Line(points={{-27.2,40},{-30,40},
          {-30,30},{-35.4,30}}, color={255,0,255}));
  connect(upSample2.u, sample1.y) annotation (Line(points={{-27.2,20},{-30,20},
          {-30,30},{-35.4,30}}, color={255,0,255}));
connect(upSample1.y, and1.u1) annotation (Line(
    points={{-13.4,40},{-8,40},{-8,30},{-2,30}},
    color={255,0,255}));
connect(upSample2.y, and1.u2) annotation (Line(
    points={{-13.4,20},{-8,20},{-8,22},{-2,22}},
    color={255,0,255}));
  annotation (experiment(StopTime=0.09),
  Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.Utilities.UpSample\">Modelica.Clocked.BooleanSignals.Sampler.Utilities.UpSample</a>.
</p>
</html>"));
end UpSample;
