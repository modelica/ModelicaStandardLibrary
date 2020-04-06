within Modelica.Clocked.Examples.Elementary.IntegerSignals;
model Sample2
  "Example of a Sample block for Integer signals with direct feed-through in the continuous-time and the clocked partition"
 extends Modelica.Icons.Example;
  Modelica.Clocked.IntegerSignals.Sampler.SampleClocked  sample1
    annotation (Placement(transformation(extent={{-60,24},{-48,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-76,-6},{-64,6}})));
Modelica.Blocks.Sources.IntegerStep
                             step(startTime=0.04)
  annotation (Placement(transformation(extent={{-96,20},{-76,40}})));
  Modelica.Clocked.IntegerSignals.Sampler.Hold hold1
    annotation (Placement(transformation(extent={{22,24},{34,36}})));
  Modelica.Clocked.IntegerSignals.Sampler.Sample  sample2
    annotation (Placement(transformation(extent={{6,-6},{-6,6}})));
Modelica.Blocks.MathInteger.Sum sum1(k={1,-1}, nu=2)
  annotation (Placement(transformation(extent={{-26,22},{-14,34}})));
Modelica.Blocks.MathInteger.Sum sum2(         nu=2)
  annotation (Placement(transformation(extent={{2,24},{14,36}})));
  Modelica.Blocks.Sources.IntegerConstant integerConstant(k=2)
    annotation (Placement(transformation(extent={{-34,50},{-14,70}})));
equation
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-63.4,0},{-54,0},{-54,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sample1.y, sum1.u[1])
                             annotation (Line(
    points={{-47.4,30},{-39.7,30},{-39.7,30.1},{-26,30.1}},
    color={255,127,0}));
  connect(sample2.y, sum1.u[2])
                             annotation (Line(
    points={{-6.6,0},{-40,0},{-40,25.9},{-26,25.9}},
    color={255,127,0}));
  connect(integerConstant.y, sum2.u[1]) annotation (Line(
      points={{-13,60},{-4,60},{-4,32.1},{2,32.1}},
      color={255,127,0}));
  connect(sum1.y, sum2.u[2]) annotation (Line(
      points={{-13.1,28},{-5.55,28},{-5.55,27.9},{2,27.9}},
      color={255,127,0}));
  connect(hold1.u, sum2.y)
    annotation (Line(points={{20.8,30},{14.9,30}}, color={255,127,0}));
  connect(hold1.y, sample2.u) annotation (Line(points={{34.6,30},{50,30},{50,0},
          {7.2,0}}, color={255,127,0}));
  connect(sample1.u, step.y) annotation (Line(
      points={{-61.2,30},{-75,30}},
      color={255,127,0}));
  annotation (experiment(StopTime=0.2),
    Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"modelica://Modelica.Clocked.IntegerSignals.Sampler.Sample\">Modelica.Clocked.IntegerSignals.Sampler.Sample</a>.
</p>
</html>"));
end Sample2;
