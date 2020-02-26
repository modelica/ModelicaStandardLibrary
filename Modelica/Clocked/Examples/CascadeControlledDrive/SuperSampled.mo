within Modelica.Clocked.Examples.CascadeControlledDrive;
model SuperSampled
  "Drive with clocked cascade controller where fastest partition is defined with a clock and slower partition is defined with super-sampling"

 extends Modelica.Icons.Example;

  Modelica.Mechanics.Rotational.Components.Inertia load(J=10,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{88,2},{104,18}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed       annotation (
     Placement(transformation(
        extent={{-7.5,-7.5},{4.5,4.5}},
        rotation=-90,
        origin={111.5,-11.5})));

  Clocked.RealSignals.NonPeriodic.PI PI(
    k=100,
    T=0.5,
    x(fixed=true))
    annotation (Placement(transformation(extent={{14,0},{34,20}})));
  Modelica.Blocks.Math.Feedback feedback2
    annotation (Placement(transformation(extent={{-12,2},{4,18}})));

  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{64,2},{81,18}})));

  Modelica.Mechanics.Rotational.Sensors.AngleSensor angle annotation (
      Placement(transformation(
        extent={{6,-6},{-6,6}},
        rotation=90,
        origin={128,-10})));
  Modelica.Blocks.Sources.KinematicPTP2 kinematicPTP(
    q_end={Modelica.Constants.pi},
    qd_max={2},
    qdd_max={3})
    annotation (Placement(transformation(extent={{-134,0},{-114,20}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{-82,2},{-66,18}})));
  Modelica.Blocks.Math.Gain gain(k=20)
    annotation (Placement(transformation(extent={{-56,0},{-36,20}})));
  Clocked.RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{52,-26},{40,-14}})));
  Clocked.RealSignals.Sampler.Sample sample2
    annotation (Placement(transformation(extent={{18,-46},{6,-34}})));
  Clocked.RealSignals.Sampler.Hold hold1
    annotation (Placement(transformation(extent={{42,4},{54,16}})));
  Clocked.RealSignals.Sampler.Sample sample3
    annotation (Placement(transformation(extent={{-100,4},{-88,16}})));
  Clocked.RealSignals.Sampler.SuperSample super(factor=5, inferFactor=false)
    annotation (Placement(transformation(extent={{-28,4},{-16,16}})));
  Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
        0.002)
    annotation (Placement(transformation(extent={{76,-72},{64,-60}})));
equation
  connect(speed.flange, load.flange_b)       annotation (Line(
      points={{110,-4},{110,10},{104,10}}));
  connect(feedback2.y, PI.u)
                            annotation (Line(
      points={{3.2,10},{12,10}},
      color={0,0,127}));
  connect(torque.flange, load.flange_a) annotation (Line(
      points={{81,10},{88,10}}));
  connect(angle.flange, load.flange_b) annotation (Line(
      points={{128,-4},{128,10},{104,10}}));
  connect(feedback1.y, gain.u) annotation (Line(
      points={{-66.8,10},{-58,10}},
      color={0,0,127}));
  connect(speed.w, sample1.u) annotation (Line(
      points={{110,-16.6},{110,-20},{53.2,-20}},
      color={0,0,127}));
  connect(angle.phi, sample2.u) annotation (Line(
      points={{128,-16.6},{128,-40},{19.2,-40}},
      color={0,0,127}));
  connect(sample1.y, feedback2.u2) annotation (Line(
      points={{39.4,-20},{-4,-20},{-4,3.6}},
      color={0,0,127}));
  connect(sample2.y, feedback1.u2) annotation (Line(
      points={{5.4,-40},{-74,-40},{-74,3.6}},
      color={0,0,127}));
  connect(PI.y, hold1.u) annotation (Line(
      points={{35,10},{40.8,10}},
      color={0,0,127}));
  connect(hold1.y, torque.tau) annotation (Line(
      points={{54.6,10},{62.3,10}},
      color={0,0,127}));
  connect(sample3.y, feedback1.u1) annotation (Line(
      points={{-87.4,10},{-80.4,10}},
      color={0,0,127}));
  connect(kinematicPTP.q[1], sample3.u) annotation (Line(
      points={{-113,18},{-106,18},{-106,10},{-101.2,10}},
      color={0,0,127}));
connect(gain.y, super.u)    annotation (Line(
      points={{-35,10},{-29.2,10}},
      color={0,0,127}));
connect(super.y, feedback2.u1)    annotation (Line(
      points={{-15.4,10},{-10.4,10}},
      color={0,0,127}));
  connect(periodicRealClock.y, sample1.clock) annotation (Line(
      points={{63.4,-66},{46,-66},{46,-27.2}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-140,
            -100},{140,100}}),
    graphics={
        Text(
          extent={{-12,38},{38,32}},
          textColor={255,0,0},
          textString="fast controller"),
        Text(
          extent={{66,37},{116,31}},
          textColor={255,0,0},
          textString="plant"),
        Rectangle(extent={{-138,40},{-110,-20}},lineColor={255,0,0}),
        Text(
          extent={{-142,38},{-103,33}},
          textColor={255,0,0},
          textString="reference"),
        Rectangle(extent={{-86,40},{-32,-48}},lineColor={255,0,0}),
        Rectangle(extent={{-14,40},{38,-48}}, lineColor={255,0,0}),
        Rectangle(extent={{56,40},{134,-48}}, lineColor={255,0,0}),
        Text(
          extent={{-83,38},{-33,32}},
          textColor={255,0,0},
          textString="slow controller")}),
    Documentation(info="<html>
<p>
Cascade control drive with discrete-time controller where one
periodic clock is defined for the fastest control loop,
and the periodic clock of the slower control loop is implicitly
defined by the super-sampling factor defined at the \"super\" block.
</p>
</html>"),
    experiment(StopTime=4));
end SuperSampled;
