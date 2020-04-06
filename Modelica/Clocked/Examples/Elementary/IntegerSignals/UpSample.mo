within Modelica.Clocked.Examples.Elementary.IntegerSignals;
model UpSample "Example of an UpSample block for Integer signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
  Modelica.Clocked.IntegerSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-48,24},{-36,36}})));
Modelica.Clocked.IntegerSignals.Sampler.Utilities.UpSample upSample1
  annotation (Placement(transformation(extent={{-26,34},{-14,46}})));
Modelica.Clocked.IntegerSignals.Sampler.Utilities.UpSample upSample2(
    inferFactor=false, factor=3)
  annotation (Placement(transformation(extent={{-26,14},{-14,26}})));
  Modelica.Blocks.Sources.IntegerTable table(table=[0,1; 0.025,2; 0.05,
      0; 0.075,-1; 0.1,3])
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
Modelica.Blocks.MathInteger.Sum sum(nu=2)
  annotation (Placement(transformation(extent={{2,24},{14,36}})));
equation
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-55.4,0},{-42,0},{-42,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(table.y, sample1.u)
    annotation (Line(points={{-59,30},{-49.2,30}}, color={255,127,0}));
  connect(sample1.y, upSample1.u) annotation (Line(points={{-35.4,30},{-32,30},
          {-32,40},{-27.2,40}}, color={255,127,0}));
  connect(sample1.y, upSample2.u) annotation (Line(points={{-35.4,30},{-32,30},
          {-32,20},{-27.2,20}}, color={255,127,0}));
connect(upSample1.y, sum.u[1]) annotation (Line(
    points={{-13.4,40},{-6,40},{-6,32.1},{2,32.1}},
    color={255,127,0}));
connect(upSample2.y, sum.u[2]) annotation (Line(
    points={{-13.4,20},{-6,20},{-6,27.9},{2,27.9}},
    color={255,127,0}));
  annotation (experiment(StopTime=0.09),
  Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.Utilities.UpSample\">Modelica.Clocked.IntegerSignals.Sampler.Utilities.UpSample</a>.
</p>
</html>"));
end UpSample;
