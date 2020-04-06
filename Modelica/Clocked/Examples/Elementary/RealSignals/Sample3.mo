within Modelica.Clocked.Examples.Elementary.RealSignals;
model Sample3
  "Example of a Sample block for Real signals with direct feed-through in the continuous-time and the clocked partition"
 extends Modelica.Icons.Example;
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-52,24},{-40,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-76,-6},{-64,6}})));
Modelica.Blocks.Sources.Step step(startTime=0.04)
  annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Math.Gain gain(k=1.2)
    annotation (Placement(transformation(extent={{-8,20},{12,40}})));
  Modelica.Clocked.RealSignals.Sampler.Hold hold1
    annotation (Placement(transformation(extent={{20,24},{32,36}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-36,20},{-16,40}})));
  Modelica.Clocked.RealSignals.Sampler.Sample sample2
    annotation (Placement(transformation(extent={{6,-6},{-6,6}})));
equation
  connect(step.y, sample1.u)
                          annotation (Line(
    points={{-59,30},{-53.2,30}},
    color={0,0,127}));
  connect(gain.y, hold1.u)
    annotation (Line(points={{13,30},{18.8,30}}, color={0,0,127}));
  connect(feedback.y, gain.u) annotation (Line(
      points={{-17,30},{-10,30}},
      color={0,0,127}));
  connect(sample2.y, feedback.u2) annotation (Line(
      points={{-6.6,0},{-26,0},{-26,22}},
      color={0,0,127}));
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-63.4,0},{-46,0},{-46,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sample1.y, feedback.u1) annotation (Line(
      points={{-39.4,30},{-34,30}},
      color={0,0,127}));
  connect(hold1.y, sample2.u) annotation (Line(points={{32.6,30},{38,30},{38,0},
          {7.2,0}}, color={0,0,127}));
  annotation (experiment(StopTime=0.2),
  Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Sample\">Modelica.Clocked.RealSignals.Sampler.Sample</a>.
</p>
</html>"));
end Sample3;
