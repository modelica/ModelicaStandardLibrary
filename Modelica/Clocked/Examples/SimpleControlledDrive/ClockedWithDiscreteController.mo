within Modelica.Clocked.Examples.SimpleControlledDrive;
model ClockedWithDiscreteController
  "Simple controlled drive with discrete controller (period is used in the controller)"
 extends Modelica.Icons.Example;

  Modelica.Mechanics.Rotational.Components.Inertia load(J=10,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{67,0},{87,20}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed       annotation (
     Placement(transformation(
        extent={{-10,-10},{6,6}},
        rotation=-90,
        origin={94,-7})));
  Modelica.Blocks.Sources.Ramp ramp(duration=2)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));

  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-47,0},{-27,20}})));

  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{40,0},{60,20}})));

  Clocked.RealSignals.Sampler.SampleClocked sample2
    annotation (Placement(transformation(extent={{-66,4},{-54,16}})));
  Clocked.RealSignals.Sampler.Hold hold1
    annotation (Placement(transformation(extent={{14,4},{26,16}})));
  Clocked.RealSignals.Sampler.Sample sample1
    annotation (Placement(transformation(extent={{26,-26},{14,-14}})));
  Clocked.RealSignals.NonPeriodic.PI PI(
    x(fixed=true),
    T=0.1,
    k=110) annotation (Placement(transformation(extent={{-18,0},{2,20}})));
Clocked.ClockSignals.Clocks.PeriodicRealClock periodicClock(period=0.1)
    annotation (Placement(transformation(extent={{-98,-36},{-86,-24}})));
equation
  connect(speed.flange, load.flange_b)       annotation (Line(
      points={{92,3},{92,10},{87,10}}));
  connect(torque.flange, load.flange_a) annotation (Line(
      points={{60,10},{67,10}}));
  connect(ramp.y, sample2.u) annotation (Line(
      points={{-79,10},{-67.2,10}},
      color={0,0,127}));
  connect(sample2.y, feedback.u1) annotation (Line(
      points={{-53.4,10},{-45,10}},
      color={0,0,127}));
  connect(hold1.y, torque.tau) annotation (Line(
      points={{26.6,10},{38,10}},
      color={0,0,127}));
  connect(speed.w, sample1.u) annotation (Line(
      points={{92,-13.8},{92,-20},{27.2,-20}},
      color={0,0,127}));
  connect(sample1.y, feedback.u2) annotation (Line(
      points={{13.4,-20},{-37,-20},{-37,2}},
      color={0,0,127}));
  connect(feedback.y, PI.u) annotation (Line(
      points={{-28,10},{-20,10}},
      color={0,0,127}));
  connect(PI.y, hold1.u) annotation (Line(
      points={{3,10},{12.8,10}},
      color={0,0,127}));
connect(periodicClock.y, sample2.clock) annotation (Line(
    points={{-85.4,-30},{-60,-30},{-60,2.8}},
    color={175,175,175},
    pattern=LinePattern.Dot,
    thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-140,
          -100},{140,100}}), graphics={
        Text(
          extent={{-41,37},{9,31}},
          textColor={255,0,0},
          textString="feedback controller"),
        Text(
          extent={{40,37},{90,31}},
          textColor={255,0,0},
          textString="plant"),
        Rectangle(extent={{-108,40},{-74,-8}},  lineColor={255,0,0}),
        Text(
          extent={{-113,37},{-65,31}},
          textColor={255,0,0},
          textString="reference"),
        Rectangle(extent={{-50,40},{6,-40}},  lineColor={255,0,0}),
        Rectangle(extent={{32,40},{104,-40}}, lineColor={255,0,0})}),
    Documentation(info="<html>
<p>
Simple controlled drive with discrete-timer controller
modelled as a clocked partition.
The discrete-time PI controller is parameterized
with the parameters of the continuous-time version and the
discrete-time version is derived from this parameterization
taken into account the actual sample period.
</p>
</html>"),
    experiment(
      StopTime=3));
end ClockedWithDiscreteController;
