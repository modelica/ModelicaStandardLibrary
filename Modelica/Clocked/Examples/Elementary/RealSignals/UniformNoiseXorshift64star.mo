within Modelica.Clocked.Examples.Elementary.RealSignals;
model UniformNoiseXorshift64star
  "Example of a UniformNoiseXorshift64star block for Real signals"
   extends Modelica.Icons.Example;

  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
Modelica.Clocked.RealSignals.Sampler.Utilities.Internal.UniformNoiseXorshift64star
  uniformNoiseXorshift64star
  annotation (Placement(transformation(extent={{-26,20},{-6,40}})));
Modelica.Blocks.Sources.Constant const(k=0)
  annotation (Placement(transformation(extent={{-76,20},{-56,40}})));
equation
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-49.4,0},{-40,0},{-40,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sample1.y, uniformNoiseXorshift64star.u)
    annotation (Line(points={{-33.4,30},{-28,30}}, color={0,0,127}));
  connect(const.y, sample1.u)
    annotation (Line(points={{-55,30},{-47.2,30}}, color={0,0,127}));
  annotation (experiment(StopTime=1),
  Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.Internal.UniformNoiseXorshift64star\">Modelica.Clocked.RealSignals.Sampler.Utilities.Internal.UniformNoiseXorshift64star</a>.
</p>
</html>"));
end UniformNoiseXorshift64star;
