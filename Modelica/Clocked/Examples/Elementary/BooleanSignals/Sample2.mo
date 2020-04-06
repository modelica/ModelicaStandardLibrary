within Modelica.Clocked.Examples.Elementary.BooleanSignals;
model Sample2
  "Example of a Sample block for Boolean signals with direct feed-through in the continuous-time and the clocked partition"
 extends Modelica.Icons.Example;
  Modelica.Clocked.BooleanSignals.Sampler.SampleClocked  sample1
    annotation (Placement(transformation(extent={{-60,24},{-48,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-76,-6},{-64,6}})));
Modelica.Blocks.Sources.BooleanStep
                             step(startTime=0.04)
  annotation (Placement(transformation(extent={{-96,20},{-76,40}})));
  Modelica.Clocked.BooleanSignals.Sampler.Hold hold1
    annotation (Placement(transformation(extent={{22,24},{34,36}})));
  Modelica.Clocked.BooleanSignals.Sampler.Sample  sample2
    annotation (Placement(transformation(extent={{6,-6},{-6,6}})));
  Modelica.Blocks.Sources.BooleanConstant integerConstant(k=true)
    annotation (Placement(transformation(extent={{-38,51},{-18,71}})));
Modelica.Blocks.Logical.Xor xor
  annotation (Placement(transformation(extent={{-39,20},{-19,40}})));
Modelica.Blocks.Logical.Xor xor1
  annotation (Placement(transformation(extent={{-6,21},{14,41}})));
equation
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-63.4,0},{-54,0},{-54,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
connect(step.y, sample1.u) annotation (Line(
    points={{-75,30},{-61.2,30}},
    color={255,0,255}));
  connect(hold1.y, sample2.u) annotation (Line(points={{34.6,30},{39,30},{39,0},
          {7.2,0}}, color={255,0,255}));
connect(sample2.y, xor.u2) annotation (Line(
    points={{-6.6,0},{-47,0},{-47,22},{-41,22}},
    color={255,0,255}));
connect(xor.u1, sample1.y) annotation (Line(
    points={{-41,30},{-47.4,30}},
    color={255,0,255}));
  connect(hold1.u, xor1.y) annotation (Line(points={{20.8,30},{17.4,30},{17.4,
          31},{15,31}}, color={255,0,255}));
connect(xor1.u1, integerConstant.y) annotation (Line(
    points={{-8,31},{-8,45.5},{-17,45.5},{-17,61}},
    color={255,0,255}));
connect(xor1.u2, xor.y) annotation (Line(
    points={{-8,23},{-13,23},{-13,30},{-18,30}},
    color={255,0,255}));
  annotation (experiment(StopTime=0.2),
    Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"modelica://Modelica.Clocked.BooleanSignals.Sampler.Sample\">Modelica.Clocked.BooleanSignals.Sampler.Sample</a>.
</p>
</html>"));
end Sample2;
