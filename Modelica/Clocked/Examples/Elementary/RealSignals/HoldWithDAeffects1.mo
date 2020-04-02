within Modelica.Clocked.Examples.Elementary.RealSignals;
model HoldWithDAeffects1
  "Example of a HoldWithDAeffects block for Real signals"
   extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine(f=2,
    startTime=0,
  amplitude=2)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-52,24},{-40,36}})));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
      factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
Modelica.Clocked.RealSignals.Sampler.HoldWithDAeffects hold1(
    computationalDelay=true,
    shiftCounter=1,
    resolution=2,
    y_start=0.5,
    limited=true,
    yMax=1.9) annotation (Placement(transformation(extent={{-8,24},{4,36}})));
Modelica.Clocked.RealSignals.Sampler.ShiftSample shiftSample1(shiftCounter=2)
    annotation (Placement(transformation(extent={{-30,24},{-18,36}})));
equation
  connect(sine.y, sample1.u)
    annotation (Line(points={{-59,30},{-53.2,30}}, color={0,0,127}));
  connect(periodicClock.y, sample1.clock) annotation (Line(
      points={{-55.4,0},{-46,0},{-46,22.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sample1.y, shiftSample1.u)
    annotation (Line(points={{-39.4,30},{-31.2,30}}, color={0,0,127}));
  connect(shiftSample1.y, hold1.u)
    annotation (Line(points={{-17.4,30},{-9.2,30}}, color={0,0,127}));
  annotation (experiment(StopTime=0.2),
  Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.HoldWithDAeffects\">Modelica.Clocked.RealSignals.Sampler.HoldWithDAeffects</a>.
</p>
</html>"));
end HoldWithDAeffects1;
