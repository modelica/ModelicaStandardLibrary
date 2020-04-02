within Modelica.Clocked.Examples.Elementary.RealSignals;
model UpSample2
  "Example of an UpSample block for Real signals combined with FIR filter blocks"
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
Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample upSample(
      inferFactor=false, factor=3)
  annotation (Placement(transformation(extent={{-24,24},{-12,36}})));
  Modelica.Clocked.RealSignals.Sampler.SuperSampleInterpolated
    superSampleIpo(inferFactor=false, factor=3)
    annotation (Placement(transformation(extent={{12,-44},{24,-32}})));
  Modelica.Clocked.RealSignals.Periodic.FIRbyCoefficients FIR2(a={1/3,2/3,1,
        2/3,1/3}, cBufStart={0,0,0,0})
    annotation (Placement(transformation(extent={{6,-14},{26,6}})));
  Modelica.Clocked.RealSignals.Periodic.FIRbyCoefficients FIR1(a={1,1,1},
      cBufStart={0,0})
    annotation (Placement(transformation(extent={{6,20},{26,40}})));
equation
  connect(sine.y, sample1.u)
    annotation (Line(points={{-59,30},{-49.2,30}}, color={0,0,127}));
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-55.4,0},{-42,0},{-42,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(upSample.u, sample1.y)
    annotation (Line(points={{-25.2,30},{-35.4,30}}, color={0,0,127}));
  connect(sample1.y, superSampleIpo.u) annotation (Line(points={{-35.4,30},{-32,
          30},{-32,-38},{10.8,-38}}, color={0,0,127}));
  connect(upSample.y, FIR2.u) annotation (Line(
      points={{-11.4,30},{-8,30},{-8,-4},{4,-4}},
      color={0,0,127}));
  connect(FIR1.u, upSample.y) annotation (Line(
      points={{4,30},{-11.4,30}},
      color={0,0,127}));
  annotation (experiment(StopTime=0.06),
  Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample\">Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample</a>.
</p>
</html>"));
end UpSample2;
