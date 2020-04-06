within Modelica.Clocked.Examples.Elementary.RealSignals;
model UpSample1 "Example of an UpSample block for Real signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
  Modelica.Blocks.Sources.Sine sine(f=2,
    offset=0.1,
    startTime=0)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-48,24},{-36,36}})));
Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample upSample1
  annotation (Placement(transformation(extent={{-26,34},{-14,46}})));
Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample upSample2(
    inferFactor=false, factor=3)
  annotation (Placement(transformation(extent={{-26,14},{-14,26}})));
Modelica.Blocks.Math.Add add
  annotation (Placement(transformation(extent={{0,20},{20,40}})));
equation
  connect(sine.y, sample1.u)
    annotation (Line(points={{-59,30},{-49.2,30}}, color={0,0,127}));
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-55.4,0},{-42,0},{-42,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sample1.y, upSample1.u) annotation (Line(points={{-35.4,30},{-32,30},
          {-32,40},{-27.2,40}}, color={0,0,127}));
  connect(upSample2.u, sample1.y) annotation (Line(points={{-27.2,20},{-32,20},
          {-32,30},{-35.4,30}}, color={0,0,127}));
connect(upSample2.y, add.u2) annotation (Line(
    points={{-13.4,20},{-8,20},{-8,24},{-2,24}},
    color={0,0,127}));
connect(upSample1.y, add.u1) annotation (Line(
    points={{-13.4,40},{-8,40},{-8,36},{-2,36}},
    color={0,0,127}));
  annotation (experiment(StopTime=0.09),
  Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample\">Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample</a>.
</p>
</html>"));
end UpSample1;
