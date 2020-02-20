within Modelica.Clocked.Examples.SimpleControlledDrive;
model ClockedWithDiscretizedContinuousController
  "Simple controlled drive with discretized continuous-time controller"
 extends Modelica.Icons.Example;

  Modelica.Mechanics.Rotational.Components.Inertia load(J=10,
    phi(fixed=true, start=0),
    w(fixed=true, start=0))
    annotation (Placement(transformation(extent={{69,0},{89,20}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed       annotation (
     Placement(transformation(
        extent={{-10,-10},{6,6}},
        rotation=-90,
        origin={97,-9})));
  Modelica.Blocks.Sources.Ramp ramp(duration=2)
    annotation (Placement(transformation(extent={{-101,0},{-81,20}})));

  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-47,0},{-27,20}})));

  Modelica.Mechanics.Rotational.Sources.Torque torque
    annotation (Placement(transformation(extent={{42,0},{62,20}})));

  Clocked.RealSignals.Sampler.SampleClocked sample2
    annotation (Placement(transformation(extent={{-66,4},{-54,16}})));
  Clocked.RealSignals.Sampler.Hold hold1
    annotation (Placement(transformation(extent={{20,4},{32,16}})));
  Clocked.RealSignals.Sampler.Sample sample1
    annotation (Placement(transformation(extent={{30,-26},{18,-14}})));
  Modelica.Blocks.Continuous.PI PI(
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=0,
    T=0.1,
    k=110)
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
Clocked.ClockSignals.Clocks.PeriodicRealClock periodicClock(
    period=0.1,
    useSolver=true,
    solverMethod="ImplicitEuler")
    annotation (Placement(transformation(extent={{-94,-32},{-82,-20}})));
equation
  connect(speed.flange, load.flange_b)       annotation (Line(
      points={{95,1},{95,10},{89,10}}));
  connect(torque.flange, load.flange_a) annotation (Line(
      points={{62,10},{69,10}}));
  connect(ramp.y, sample2.u) annotation (Line(
      points={{-80,10},{-67.2,10}},
      color={0,0,127}));
  connect(sample2.y, feedback.u1) annotation (Line(
      points={{-53.4,10},{-45,10}},
      color={0,0,127}));
  connect(hold1.y, torque.tau) annotation (Line(
      points={{32.6,10},{40,10}},
      color={0,0,127}));
  connect(speed.w, sample1.u) annotation (Line(
      points={{95,-15.8},{95,-20},{31.2,-20}},
      color={0,0,127}));
  connect(sample1.y, feedback.u2) annotation (Line(
      points={{17.4,-20},{-37,-20},{-37,2}},
      color={0,0,127}));
  connect(feedback.y, PI.u)  annotation (Line(
      points={{-28,10},{-22,10}},
      color={0,0,127}));
  connect(PI.y, hold1.u)  annotation (Line(
      points={{1,10},{18.8,10}},
      color={0,0,127}));
connect(periodicClock.y, sample2.clock) annotation (Line(
    points={{-81.4,-26},{-60,-26},{-60,2.8}},
    color={175,175,175},
    pattern=LinePattern.Dot,
    thickness=0.5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-140,-100},{140,100}}),
      graphics={
        Text(
          extent={{-41,37},{9,31}},
          textColor={255,0,0},
          textString="feedback controller"),
        Text(
          extent={{46,37},{96,31}},
          textColor={255,0,0},
          textString="plant"),
        Rectangle(extent={{-106,40},{-72,-10}}, lineColor={255,0,0}),
        Text(
          extent={{-113,37},{-65,31}},
          textColor={255,0,0},
          textString="reference"),
        Rectangle(extent={{-50,40},{14,-40}}, lineColor={255,0,0}),
        Rectangle(extent={{36,40},{108,-40}}, lineColor={255,0,0})}),
    Documentation(info="<html>
<p>
Simple controlled drive with discrete-time controller
modelled as a clocked partition.
The PI controller is defined with a continuous-time block.
The clocked partition is automatically discretized with an
implicit Euler method by setting parameter
<strong>useSolver</strong> = true in the <strong>Advanced</strong> menu
of block <strong>periodicClock</strong> and then selecting
<strong>ImplicitEuler</strong> as <strong>SolverMethod</strong> for the partition.
</p>
</html>"),
    experiment(
      StopTime=5));
end ClockedWithDiscretizedContinuousController;
