within Modelica.Clocked.Examples.SimpleControlledDrive;
model ExactlyClockedWithDiscreteController
  "Simple controlled drive with discrete controller and exact periodic clocks (period is used in the controller)"
 extends Modelica.Icons.Example;

  Modelica.Mechanics.Rotational.Components.Inertia load(J=10,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{87,0},{107,20}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed       annotation (
     Placement(transformation(
        extent={{-10,-10},{6,6}},
        rotation=-90,
        origin={117,-15})));
  Modelica.Blocks.Sources.Ramp ramp(duration=2)
    annotation (Placement(transformation(extent={{-111,0},{-91,20}})));

  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-43,0},{-23,20}})));

  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{60,0},{80,20}})));

  Clocked.RealSignals.Sampler.SampleClocked sample2
    annotation (Placement(transformation(extent={{-68,4},{-56,16}})));
  Clocked.RealSignals.Sampler.Hold hold1
    annotation (Placement(transformation(extent={{26,4},{38,16}})));
  Clocked.RealSignals.Sampler.Sample sample1
    annotation (Placement(transformation(extent={{38,-36},{26,-24}})));
  Clocked.RealSignals.NonPeriodic.PI PI(
    x(fixed=true),
    T=0.1,
    k=110) annotation (Placement(transformation(extent={{-14,0},{6,20}})));
Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(factor=100,
      resolution=Modelica.Clocked.Types.Resolution.ms)
    annotation (Placement(transformation(extent={{-100,-46},{-88,-34}})));
equation
  connect(speed.flange, load.flange_b)       annotation (Line(
      points={{115,-5},{115,10},{107,10}}));
  connect(torque.flange, load.flange_a) annotation (Line(
      points={{80,10},{87,10}}));
  connect(ramp.y, sample2.u) annotation (Line(
      points={{-90,10},{-69.2,10}},
      color={0,0,127}));
  connect(sample2.y, feedback.u1) annotation (Line(
      points={{-55.4,10},{-41,10}},
      color={0,0,127}));
  connect(hold1.y, torque.tau) annotation (Line(
      points={{38.6,10},{58,10}},
      color={0,0,127}));
  connect(speed.w, sample1.u) annotation (Line(
      points={{115,-21.8},{115,-30},{39.2,-30}},
      color={0,0,127}));
  connect(sample1.y, feedback.u2) annotation (Line(
      points={{25.4,-30},{-33,-30},{-33,2}},
      color={0,0,127}));
  connect(feedback.y, PI.u) annotation (Line(
      points={{-24,10},{-16,10}},
      color={0,0,127}));
  connect(PI.y, hold1.u) annotation (Line(
      points={{7,10},{24.8,10}},
      color={0,0,127}));
connect(periodicClock.y, sample2.clock) annotation (Line(
    points={{-87.4,-40},{-62,-40},{-62,2.8}},
    color={175,175,175},
    pattern=LinePattern.Dot,
    thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-140,-100},{140,100}}),
    graphics={
        Text(
          extent={{-41,39},{9,33}},
          textColor={255,0,0},
          textString="feedback controller"),
        Text(
          extent={{54,39},{104,33}},
          textColor={255,0,0},
          textString="plant"),
        Rectangle(extent={{-120,40},{-80,-20}}, lineColor={255,0,0}),
        Text(
          extent={{-125,39},{-77,33}},
          textColor={255,0,0},
          textString="reference"),
        Rectangle(extent={{-46,40},{14,-48}}, lineColor={255,0,0}),
        Rectangle(extent={{50,40},{132,-48}}, lineColor={255,0,0})}),
    Documentation(info="<html>
<p>
This is the same model as
<a href=\"modelica://Modelica.Clocked.Examples.SimpleControlledDrive.ClockedWithDiscreteController\">ClockedWithDiscreteController</a>.
The only difference is that the clock is defined with an exact periodic clock and not with
a Real periodic clock.
</p>
</html>"),
    experiment(StopTime=5));
end ExactlyClockedWithDiscreteController;
