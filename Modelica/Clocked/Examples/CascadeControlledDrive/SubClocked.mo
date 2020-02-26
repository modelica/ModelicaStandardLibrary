within Modelica.Clocked.Examples.CascadeControlledDrive;
model SubClocked
  "Drive with clocked cascade controller where clocks are defined with sub-sampling and partitions with super-sampling"
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
    annotation (Placement(transformation(extent={{-136,-8},{-116,12}})));
  Modelica.Blocks.Math.Feedback feedback1
    annotation (Placement(transformation(extent={{-82,2},{-66,18}})));
  Modelica.Blocks.Math.Gain gain(k=20)
    annotation (Placement(transformation(extent={{-56,0},{-36,20}})));
  Clocked.RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{52,-26},{40,-14}})));
  Clocked.RealSignals.Sampler.Sample sample2
    annotation (Placement(transformation(extent={{-42,-46},{-54,-34}})));
  Clocked.RealSignals.Sampler.Hold hold1
    annotation (Placement(transformation(extent={{42,4},{54,16}})));
  Clocked.RealSignals.Sampler.SampleClocked sample3
    annotation (Placement(transformation(extent={{-104,4},{-92,16}})));
  Clocked.RealSignals.Sampler.SuperSample super(inferFactor=true)
    annotation (Placement(transformation(extent={{-28,4},{-16,16}})));
  Clocked.ClockSignals.Sampler.SubSample subSample1(factor=5)
    annotation (Placement(transformation(extent={{16,-76},{4,-64}})));
  Clocked.ClockSignals.Clocks.PeriodicRealClock periodicRealClock(period=
        0.002)
    annotation (Placement(transformation(extent={{78,-76},{66,-64}})));
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
      points={{128,-16.6},{128,-40},{-40.8,-40}},
      color={0,0,127}));
  connect(sample1.y, feedback2.u2) annotation (Line(
      points={{39.4,-20},{-4,-20},{-4,3.6}},
      color={0,0,127}));
  connect(sample2.y, feedback1.u2) annotation (Line(
      points={{-54.6,-40},{-74,-40},{-74,3.6}},
      color={0,0,127}));
  connect(PI.y, hold1.u) annotation (Line(
      points={{35,10},{40.8,10}},
      color={0,0,127}));
  connect(hold1.y, torque.tau) annotation (Line(
      points={{54.6,10},{62.3,10}},
      color={0,0,127}));
  connect(sample3.y, feedback1.u1) annotation (Line(
      points={{-91.4,10},{-80.4,10}},
      color={0,0,127}));
  connect(kinematicPTP.q[1], sample3.u) annotation (Line(
      points={{-115,10},{-105.2,10}},
      color={0,0,127}));
connect(gain.y, super.u)    annotation (Line(
      points={{-35,10},{-29.2,10}},
      color={0,0,127}));
connect(super.y, feedback2.u1)    annotation (Line(
      points={{-15.4,10},{-10.4,10}},
      color={0,0,127}));
  connect(subSample1.y, sample3.clock) annotation (Line(
      points={{3.4,-70},{-98,-70},{-98,2.8}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(periodicRealClock.y, sample1.clock) annotation (Line(
      points={{65.4,-70},{46,-70},{46,-27.2}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(periodicRealClock.y, subSample1.u) annotation (Line(
      points={{65.4,-70},{17.2,-70}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-140,-100},{140,100}}),
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
        Rectangle(extent={{-86,40},{-32,-52}},lineColor={255,0,0}),
        Rectangle(extent={{-14,40},{38,-52}}, lineColor={255,0,0}),
        Rectangle(extent={{56,40},{136,-52}}, lineColor={255,0,0}),
        Text(
          extent={{-83,38},{-33,32}},
          textColor={255,0,0},
          textString="slow controller")}),
    Documentation(info="<html>
<p>
Cascade control drive with discrete-time controller where one
periodic clock is defined, the second periodic clock is derived by
sub-sampling of the first clock, and both clocks are associated to
the corresponding controller partitions.
The super-sampling factor of block \"super\" is derived by
clock inference.
</p>
</html>"),
    experiment(StopTime=4));
end SubClocked;
