within Modelica.Clocked;
package Examples
  "Library of examples to demonstrate the usage of package Modelica_Synchronous"
  extends Modelica.Icons.ExamplesPackage;

  package SimpleControlledDrive
    "Examples based on a simple controlled drive with different ways to define the sampling"
  extends Modelica.Icons.ExamplesPackage;

    model Continuous "Simple controlled drive with continuous controller"
     extends Modelica.Icons.Example;

      Modelica.Mechanics.Rotational.Components.Inertia load(J=10,
        phi(fixed=true, start=0),
        w(fixed=true, start=0))
        annotation (Placement(transformation(extent={{80,0},{100,20}})));
      Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed       annotation (
         Placement(transformation(
            extent={{-10,-10},{6,6}},
            rotation=-90,
            origin={110,-15})));
      Modelica.Blocks.Sources.Ramp ramp(duration=2)
        annotation (Placement(transformation(extent={{-111,0},{-91,20}})));

      Modelica.Blocks.Continuous.PI PI(
        initType=Modelica.Blocks.Types.Init.InitialOutput,
        y_start=0,
        T=0.1,
        k=110)
        annotation (Placement(transformation(extent={{-12,0},{8,20}})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{-43,0},{-23,20}})));

      Modelica.Mechanics.Rotational.Sources.Torque torque
        annotation (Placement(transformation(extent={{53,0},{73,20}})));

    equation
      connect(speed.flange, load.flange_b)       annotation (Line(
          points={{108,-5},{108,10},{100,10}}));
      connect(feedback.y, PI.u) annotation (Line(
          points={{-24,10},{-14,10}},
          color={0,0,127}));
      connect(torque.flange, load.flange_a) annotation (Line(
          points={{73,10},{80,10}}));
      connect(ramp.y, feedback.u1) annotation (Line(
          points={{-90,10},{-41,10}},
          color={0,0,127}));
      connect(PI.y, torque.tau) annotation (Line(
          points={{9,10},{51,10}},
          color={0,0,127}));
      connect(speed.w, feedback.u2) annotation (Line(
          points={{108,-21.8},{108,-26},{-33,-26},{-33,2}},
          color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-140,-100},
                {140,100}},
            grid={2,2}), graphics={
            Text(
              extent={{-35,39},{15,33}},
              lineColor={255,0,0},
              textString="feedback controller"),
            Text(
              extent={{54,39},{104,33}},
              lineColor={255,0,0},
              textString="plant"),
            Rectangle(extent={{-120,40},{-70,-20}}, lineColor={255,0,0}),
            Text(
              extent={{-119,39},{-71,33}},
              lineColor={255,0,0},
              textString="reference"),
            Rectangle(extent={{-46,40},{18,-34}}, lineColor={255,0,0}),
            Rectangle(extent={{40,40},{120,-34}}, lineColor={255,0,0})}),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2})),
        Documentation(info="<html>
<p>
Original simple controlled drive with a
<b>continuous-time</b> controller.
</p>
</html>"),
        experiment(
          StopTime=5));
    end Continuous;

    model ClockedWithDiscreteTextbookController
      "Simple controlled drive with discrete textbook controller (period is not used in the controller)"
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

      Clocked.RealSignals.Periodic.PI PI(
        Td=1,
        x(fixed=true),
        kd=110) annotation (Placement(transformation(extent={{-14,0},{6,20}})));
      Clocked.RealSignals.Sampler.SampleClocked sample2
        annotation (Placement(transformation(extent={{-68,4},{-56,16}})));
      Clocked.RealSignals.Sampler.Hold hold1
        annotation (Placement(transformation(extent={{26,4},{38,16}})));
      Clocked.RealSignals.Sampler.Sample sample1
        annotation (Placement(transformation(extent={{38,-38},{26,-26}})));
    Clocked.ClockSignals.Clocks.PeriodicRealClock periodicClock(period=0.1)
        annotation (Placement(transformation(extent={{-106,-46},{-94,-34}})));
    equation
      connect(speed.flange, load.flange_b)       annotation (Line(
          points={{115,-5},{115,10},{107,10}}));
      connect(torque.flange, load.flange_a) annotation (Line(
          points={{80,10},{87,10}}));
      connect(feedback.y, PI.u) annotation (Line(
          points={{-24,10},{-16,10}},
          color={0,0,127}));
      connect(ramp.y, sample2.u) annotation (Line(
          points={{-90,10},{-69.2,10}},
          color={0,0,127}));
      connect(sample2.y, feedback.u1) annotation (Line(
          points={{-55.4,10},{-41,10}},
          color={0,0,127}));
      connect(PI.y, hold1.u) annotation (Line(
          points={{7,10},{24.8,10}},
          color={0,0,127}));
      connect(hold1.y, torque.tau) annotation (Line(
          points={{38.6,10},{58,10}},
          color={0,0,127}));
      connect(sample1.u, speed.w) annotation (Line(
          points={{39.2,-32},{115,-32},{115,-21.8}},
          color={0,0,127}));
      connect(feedback.u2, sample1.y) annotation (Line(
          points={{-33,2},{-34,2},{-34,-32},{25.4,-32}},
          color={0,0,127}));
    connect(periodicClock.y, sample2.clock) annotation (Line(
        points={{-93.4,-40},{-62,-40},{-62,2.8}},
        color={175,175,175},
        pattern=LinePattern.Dot,
        thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-140,
              -100},{140,100}},
            grid={2,2}), graphics={
            Text(
              extent={{-41,39},{9,33}},
              lineColor={255,0,0},
              textString="feedback controller"),
            Text(
              extent={{54,39},{104,33}},
              lineColor={255,0,0},
              textString="plant"),
            Rectangle(extent={{-120,40},{-80,-20}}, lineColor={255,0,0}),
            Text(
              extent={{-125,39},{-77,33}},
              lineColor={255,0,0},
              textString="reference"),
            Rectangle(extent={{-46,40},{14,-48}}, lineColor={255,0,0}),
            Rectangle(extent={{50,40},{132,-48}}, lineColor={255,0,0})}),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2})),
        Documentation(info="<html>
<p>
Simple controlled drive with discrete-time textbook controller
modelled as a clocked partition
(period is not used in the controller)
</p>
</html>"),
        experiment(
          StopTime=5));
    end ClockedWithDiscreteTextbookController;

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
              -100},{140,100}},
            grid={2,2}), graphics={
            Text(
              extent={{-41,37},{9,31}},
              lineColor={255,0,0},
              textString="feedback controller"),
            Text(
              extent={{40,37},{90,31}},
              lineColor={255,0,0},
              textString="plant"),
            Rectangle(extent={{-108,40},{-74,-8}},  lineColor={255,0,0}),
            Text(
              extent={{-113,37},{-65,31}},
              lineColor={255,0,0},
              textString="reference"),
            Rectangle(extent={{-50,40},{6,-40}},  lineColor={255,0,0}),
            Rectangle(extent={{32,40},{104,-40}}, lineColor={255,0,0})}),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2})),
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
          resolution=Clocked.Types.Resolution.ms)
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
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-140,
              -100},{140,100}},
            grid={2,2}), graphics={
            Text(
              extent={{-41,39},{9,33}},
              lineColor={255,0,0},
              textString="feedback controller"),
            Text(
              extent={{54,39},{104,33}},
              lineColor={255,0,0},
              textString="plant"),
            Rectangle(extent={{-120,40},{-80,-20}}, lineColor={255,0,0}),
            Text(
              extent={{-125,39},{-77,33}},
              lineColor={255,0,0},
              textString="reference"),
            Rectangle(extent={{-46,40},{14,-48}}, lineColor={255,0,0}),
            Rectangle(extent={{50,40},{132,-48}}, lineColor={255,0,0})}),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2})),
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
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-140,
              -100},{140,100}},
            grid={2,2}), graphics={
            Text(
              extent={{-41,37},{9,31}},
              lineColor={255,0,0},
              textString="feedback controller"),
            Text(
              extent={{46,37},{96,31}},
              lineColor={255,0,0},
              textString="plant"),
            Rectangle(extent={{-106,40},{-72,-10}}, lineColor={255,0,0}),
            Text(
              extent={{-113,37},{-65,31}},
              lineColor={255,0,0},
              textString="reference"),
            Rectangle(extent={{-50,40},{14,-40}}, lineColor={255,0,0}),
            Rectangle(extent={{36,40},{108,-40}}, lineColor={255,0,0})}),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2})),
        Documentation(info="<html>
<p>
Simple controlled drive with discrete-time controller
modelled as a clocked partition.
The PI controller is defined with a continuous-time block.
The clocked partition is automatically discretized with an
implicit Euler method by setting parameter
<b>useSolver</b> = true in the <b>Advanced</b> menu
of block <b>periodicClock</b> and then selecting
<b>ImplicitEuler</b> as <b>SolverMethod</b> for the partition.
</p>
</html>"),
        experiment(
          StopTime=5));
    end ClockedWithDiscretizedContinuousController;

    model ClockedWith_AD_DA_Effects
      "Simple controlled drive with discrete controller and simulated AD and DA effects"
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

      Clocked.RealSignals.Sampler.SampleWithADeffects sample2(
        limited=true,
        quantized=true,
        yMax=10,
        bits=16)
        annotation (Placement(transformation(extent={{-68,4},{-56,16}})));
      Clocked.RealSignals.Sampler.HoldWithDAeffects hold1(
        computationalDelay=true,
        resolution=10,
        shiftCounter=2,
        limited=true,
        quantized=true,
        yMax=9.5,
        yMin=-9.5,
        bits=16) annotation (Placement(transformation(extent={{26,4},{38,16}})));
      Clocked.RealSignals.Sampler.SampleWithADeffects sample1(noisy=true, noise(
            noiseMax=0.01))
        annotation (Placement(transformation(extent={{38,-36},{26,-24}})));
      Clocked.RealSignals.NonPeriodic.PI PI(T=0.1, k=110)
        annotation (Placement(transformation(extent={{-14,0},{6,20}})));
      Clocked.RealSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{8,-36},{-4,-24}})));
    Clocked.ClockSignals.Clocks.PeriodicRealClock periodicClock(period=0.1)
        annotation (Placement(transformation(extent={{-54,-74},{-42,-62}})));
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
      connect(feedback.y, PI.u) annotation (Line(
          points={{-24,10},{-16,10}},
          color={0,0,127}));
      connect(PI.y, hold1.u) annotation (Line(
          points={{7,10},{24.8,10}},
          color={0,0,127}));
      connect(sample1.y, assignClock1.u) annotation (Line(
          points={{25.4,-30},{9.2,-30}},
          color={0,0,127}));
      connect(assignClock1.y, feedback.u2) annotation (Line(
          points={{-4.6,-30},{-33,-30},{-33,2}},
          color={0,0,127}));
    connect(periodicClock.y, assignClock1.clock) annotation (Line(
        points={{-41.4,-68},{2,-68},{2,-37.2}},
        color={175,175,175},
        pattern=LinePattern.Dot,
        thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-140,
              -100},{140,100}},
            grid={2,2}), graphics={
            Text(
              extent={{-41,39},{9,33}},
              lineColor={255,0,0},
              textString="feedback controller"),
            Text(
              extent={{54,39},{104,33}},
              lineColor={255,0,0},
              textString="plant"),
            Rectangle(extent={{-120,40},{-80,-20}}, lineColor={255,0,0}),
            Text(
              extent={{-125,39},{-77,33}},
              lineColor={255,0,0},
              textString="reference"),
            Rectangle(extent={{-46,40},{14,-48}}, lineColor={255,0,0}),
            Rectangle(extent={{50,40},{132,-48}}, lineColor={255,0,0})}),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2})),
        Documentation(info="<html>
<p>
This is the same model as
<a href=\"modelica://Modelica.Clocked.Examples.SimpleControlledDrive.ClockedWithDiscreteController\">ClockedWithDiscreteController</a>.
The only difference is that real world effects like limitation, value discretization, noise
and computing time are taken into account.
</p>
</html>"),
        experiment(
          StopTime=5));
    end ClockedWith_AD_DA_Effects;
  annotation (Documentation(info="<html>
<p>
This package shows the same example in different variants.
</p>

<p>
Model <a href=\"modelica://Modelica.Clocked.Examples.SimpleControlledDrive.Continuous\">SimpleControlledDrive.Continuous</a>
is the <b>continuous-time</b> model from which the sampled-data versions are derived.
The model consists of a reference controller (\"ramp\"), a feedback controller
(\"feedback\" and \"PI\") and a plant (\"torque\", \"load\" and \"speed\").
The task of the controller is to control the speed of the load inertia
using a simple PI controller.
</p>

<p>
The other example models under this package show different variants how
the continuous-time model from above can be transformed to a periodic sampled-data
system with one sample period.
</p>
</html>"));
  end SimpleControlledDrive;

  package CascadeControlledDrive
    "Examples based on a simple drive with cascade controller and different ways to define the sampling and super-sampling"
    extends Modelica.Icons.ExamplesPackage;

    model Continuous "Drive with continuous-time cascade controller"
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

      Modelica.Blocks.Continuous.PI PI(
        k=100,
        initType=Modelica.Blocks.Types.Init.InitialState,
        x_start=0,
        T=0.5)
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
      connect(PI.y, torque.tau) annotation (Line(
          points={{35,10},{62.3,10}},
          color={0,0,127}));
      connect(speed.w, feedback2.u2) annotation (Line(
          points={{110,-16.6},{110,-30},{-4,-30},{-4,3.6}},
          color={0,0,127}));
      connect(angle.phi, feedback1.u2) annotation (Line(
          points={{128,-16.6},{128,-46},{-74,-46},{-74,3.6}},
          color={0,0,127}));
      connect(kinematicPTP.q[1], feedback1.u1) annotation (Line(
          points={{-113,18},{-100,18},{-100,10},{-80.4,10}},
          color={0,0,127}));
      connect(feedback1.y, gain.u) annotation (Line(
          points={{-66.8,10},{-58,10}},
          color={0,0,127}));
      connect(gain.y, feedback2.u1) annotation (Line(
          points={{-35,10},{-10.4,10}},
          color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-140,
                -100},{140,100}},
            grid={2,2}), graphics={
            Text(
              extent={{-12,38},{38,32}},
              lineColor={255,0,0},
              textString="fast controller"),
            Text(
              extent={{66,37},{116,31}},
              lineColor={255,0,0},
              textString="plant"),
            Rectangle(extent={{-138,40},{-110,-20}},lineColor={255,0,0}),
            Text(
              extent={{-142,38},{-103,33}},
              lineColor={255,0,0},
              textString="reference"),
            Rectangle(extent={{-92,40},{-28,-68}},lineColor={255,0,0}),
            Rectangle(extent={{-14,40},{38,-68}}, lineColor={255,0,0}),
            Rectangle(extent={{56,40},{134,-68}}, lineColor={255,0,0}),
            Text(
              extent={{-89,38},{-39,32}},
              lineColor={255,0,0},
              textString="slow controller")}),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2})),
        Documentation(info="<html>
<p>
Original cascade controlled drive with a
<b>continuous-time</b> controller.
</p>
</html>"),
        experiment(StopTime=4));
    end Continuous;

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
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-140,
                -100},{140,100}},
            grid={2,2}), graphics={
            Text(
              extent={{-12,38},{38,32}},
              lineColor={255,0,0},
              textString="fast controller"),
            Text(
              extent={{66,37},{116,31}},
              lineColor={255,0,0},
              textString="plant"),
            Rectangle(extent={{-138,40},{-110,-20}},lineColor={255,0,0}),
            Text(
              extent={{-142,38},{-103,33}},
              lineColor={255,0,0},
              textString="reference"),
            Rectangle(extent={{-86,40},{-32,-52}},lineColor={255,0,0}),
            Rectangle(extent={{-14,40},{38,-52}}, lineColor={255,0,0}),
            Rectangle(extent={{56,40},{136,-52}}, lineColor={255,0,0}),
            Text(
              extent={{-83,38},{-33,32}},
              lineColor={255,0,0},
              textString="slow controller")}),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2})),
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
                -100},{140,100}},
            grid={2,2}), graphics={
            Text(
              extent={{-12,38},{38,32}},
              lineColor={255,0,0},
              textString="fast controller"),
            Text(
              extent={{66,37},{116,31}},
              lineColor={255,0,0},
              textString="plant"),
            Rectangle(extent={{-138,40},{-110,-20}},lineColor={255,0,0}),
            Text(
              extent={{-142,38},{-103,33}},
              lineColor={255,0,0},
              textString="reference"),
            Rectangle(extent={{-86,40},{-32,-48}},lineColor={255,0,0}),
            Rectangle(extent={{-14,40},{38,-48}}, lineColor={255,0,0}),
            Rectangle(extent={{56,40},{134,-48}}, lineColor={255,0,0}),
            Text(
              extent={{-83,38},{-33,32}},
              lineColor={255,0,0},
              textString="slow controller")}),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2})),
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

    model AbsoluteClocks
      "Drive with clocked cascade controller where all partitions are defined with exact (integer) clock that need to be compatible to each other"

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
        annotation (Placement(transformation(extent={{-46,-46},{-58,-34}})));
      Clocked.RealSignals.Sampler.Hold hold1
        annotation (Placement(transformation(extent={{42,4},{54,16}})));
      Clocked.RealSignals.Sampler.SampleClocked sample3
        annotation (Placement(transformation(extent={{-100,4},{-88,16}})));
      Clocked.RealSignals.Sampler.SuperSample super(inferFactor=true)
        annotation (Placement(transformation(extent={{-28,4},{-16,16}})));
      Clocked.ClockSignals.Clocks.PeriodicExactClock slowClock(factor=10,
          resolution=Clocked.Types.Resolution.ms)
        annotation (Placement(transformation(extent={{-128,-74},{-116,-62}})));
      Clocked.ClockSignals.Clocks.PeriodicExactClock fastClock(factor=2,
          resolution=Clocked.Types.Resolution.ms)
        annotation (Placement(transformation(extent={{22,-76},{34,-64}})));
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
          points={{128,-16.6},{128,-40},{-44.8,-40}},
          color={0,0,127}));
      connect(sample1.y, feedback2.u2) annotation (Line(
          points={{39.4,-20},{-4,-20},{-4,3.6}},
          color={0,0,127}));
      connect(sample2.y, feedback1.u2) annotation (Line(
          points={{-58.6,-40},{-74,-40},{-74,3.6}},
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
      connect(slowClock.y, sample3.clock) annotation (Line(
          points={{-115.4,-68},{-94,-68},{-94,2.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(fastClock.y, sample1.clock) annotation (Line(
          points={{34.6,-70},{46,-70},{46,-27.2}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-140,-100},
                {140,100}},
            grid={2,2}), graphics={
            Text(
              extent={{-12,38},{38,32}},
              lineColor={255,0,0},
              textString="fast controller"),
            Text(
              extent={{66,37},{116,31}},
              lineColor={255,0,0},
              textString="plant"),
            Rectangle(extent={{-138,40},{-110,-20}},lineColor={255,0,0}),
            Text(
              extent={{-142,38},{-103,33}},
              lineColor={255,0,0},
              textString="reference"),
            Rectangle(extent={{-86,40},{-32,-48}},lineColor={255,0,0}),
            Rectangle(extent={{-14,40},{38,-48}}, lineColor={255,0,0}),
            Rectangle(extent={{56,40},{134,-48}}, lineColor={255,0,0}),
            Text(
              extent={{-83,38},{-33,32}},
              lineColor={255,0,0},
              textString="slow controller")}),
       Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}},
            grid={2,2})),
        Documentation(info="<html>
<p>
Cascade control drive with discrete-time controller where two
periodic clock with absolute periods are defined and
are associated to
the corresponding controller partitions.
The super-sampling factor of block \"super\" is derived by
clock inference.
</p>
</html>"),
        experiment(StopTime=4));
    end AbsoluteClocks;

  annotation (Documentation(info="<html>
<p>
This package shows the same example in different variants.
</p>

<p>
Model <a href=\"modelica://Modelica.Clocked.Examples.CascadeControlledDrive.Continuous\">CascadeControlledDrive.Continuous</a>
is the <b>continuous-time</b> model from which the sampled-data versions are derived.
The \"CascadeControlledDrive\" example adds another position control cascade to the
<a href=\"modelica://Modelica.Clocked.Examples.SimpleControlledDrive\">SimpleControlledDrive</a>
example. This model demonstrates a control system with two cascaded control loops.
The goal is to control the angle of the load inertia.
</p>

<p>
The other example models under this package show different variants how
the continuous-time model from above can be transformed to a periodic sampled-data
system with two sample periods, where the two discrete-time controllers are
precisely time-synchronized to each other.
</p>
</html>"));
  end CascadeControlledDrive;

  package Systems "Examples of complete systems"
    extends Modelica.Icons.ExamplesPackage;

    model ControlledMixingUnit
      "Simple example of a mixing unit where a (discretized) nonlinear inverse plant model is used as feedforward controller"
       extends Modelica.Icons.Example;
    import SI = Modelica.SIunits;
      parameter SI.Frequency freq = 1/300 "Critical frequency of filter";
      parameter Real c0(unit="mol/l") = 0.848 "Nominal concentration";
      parameter SI.Temperature T0 = 308.5 "Nominal temperature";
      parameter Real a1_inv =  0.2674;
      parameter Real a21_inv = 1.815;
      parameter Real a22_inv = 0.4682;
      parameter Real b_inv =   1.5476;
      parameter Real k0_inv =  1.05e14;
      parameter Real eps = 34.2894;
      parameter Real x10 = 0.42;
      parameter Real x10_inv = 0.6;
      parameter Real x20 = 0.01;
      parameter Real u0 = -0.0224;
      final parameter Real c_start(unit="mol/l") = c0*(1-x10);
      final parameter Real c_inv_start(unit="mol/l") = c0*(1-x10_inv);
      final parameter SI.Temperature T_start = T0*(1+x20);
      final parameter Real c_high_start(unit="mol/l") = c0*(1-0.72);
      final parameter Real T_c_start = T0*(1+u0);
      parameter Real pro=1.5 "Deviations of plant to inverse plant parameters";
      final parameter Real a1=a1_inv*pro;
      final parameter Real a21=a21_inv*pro;
      final parameter Real a22=a22_inv*pro;
      final parameter Real b=b_inv*pro;
      final parameter Real k0=k0_inv*pro;
      Clocked.Examples.Systems.Utilities.ComponentsMixingUnit.MixingUnit invMixingUnit(
        c0=c0,
        T0=T0,
        a1=a1_inv,
        a21=a21_inv,
        a22=a22_inv,
        b=b_inv,
        k0=k0_inv,
        eps=eps,
        c(start=c_start, fixed=true),
        T(
          start=T_start,
          fixed=true,
          stateSelect=StateSelect.always),
        T_c(start=T_c_start))
        annotation (Placement(transformation(extent={{-12,14},{-32,34}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{40,-18},{56,-2}})));
      Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
        annotation (Placement(transformation(extent={{-54,8},{-2,40}})));
      Clocked.Examples.Systems.Utilities.ComponentsMixingUnit.MixingUnit mixingUnit(
        c(start=c_start, fixed=true),
        T(start=T_start, fixed=true),
        c0=c0,
        T0=T0,
        a1=a1,
        a21=a21,
        a22=a22,
        b=b,
        k0=k0,
        eps=eps)
        annotation (Placement(transformation(extent={{88,-20},{108,0}})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{-24,-20},{-4,0}})));
      Modelica.Blocks.Math.Gain gain(k=20) annotation (Placement(transformation(
              extent={{4,-20},{24,0}})));

      Utilities.ComponentsMixingUnit.CriticalDamping filter(
        n=3,
        f=freq,
        x(start={0.49,0.49,0.49}, fixed={true,false,false}))
        annotation (Placement(transformation(extent={{-86,14},{-66,34}})));
      Clocked.RealSignals.Sampler.Hold hold1(y_start=0)
        annotation (Placement(transformation(extent={{66,-16},{78,-4}})));
      Clocked.RealSignals.Sampler.Sample sample1
        annotation (Placement(transformation(extent={{80,-40},{68,-28}})));
      Clocked.ClockSignals.Clocks.PeriodicRealClock periodicClock1(
        useSolver=true,
        period=1,
        solverMethod="ExplicitEuler")
        annotation (Placement(transformation(extent={{-134,-26},{-122,-14}})));
      Modelica.Blocks.Sources.Step step(height=c_high_start - c_start, offset=
            c_start)
        annotation (Placement(transformation(extent={{-136,14},{-116,34}})));
      RealSignals.Sampler.SampleClocked  sample2
        annotation (Placement(transformation(extent={{-108,18},{-96,30}})));
    equation
      connect(feedback.y, gain.u) annotation (Line(points={{-5,-10},{-5,-10},
              {2,-10}},
            color={0,0,127}));
      connect(gain.y, add.u2) annotation (Line(
          points={{25,-10},{32,-10},{32,-14.8},{38.4,-14.8}},
          color={0,0,127}));
      connect(inverseBlockConstraints.y2, invMixingUnit.T_c) annotation (Line(
          points={{-5.9,24},{-10,24}},
          color={0,0,127}));
      connect(invMixingUnit.c, inverseBlockConstraints.u2) annotation (Line(
          points={{-34,30},{-38,30},{-38,24},{-48.8,24}},
          color={0,0,127}));
      connect(invMixingUnit.T, feedback.u1) annotation (Line(
          points={{-34,18},{-46,18},{-46,-10},{-22,-10}},
          color={0,0,127}));
      connect(filter.y, inverseBlockConstraints.u1) annotation (Line(
          points={{-65,24},{-56.6,24}},
          color={0,0,127}));
      connect(hold1.y, mixingUnit.T_c) annotation (Line(
          points={{78.6,-10},{86,-10}},
          color={0,0,127}));
      connect(add.y, hold1.u) annotation (Line(
          points={{56.8,-10},{64.8,-10}},
          color={0,0,127}));
      connect(sample1.u, mixingUnit.T) annotation (Line(
          points={{81.2,-34},{116,-34},{116,-16},{110,-16}},
          color={0,0,127}));
      connect(sample1.y, feedback.u2) annotation (Line(
          points={{67.4,-34},{-14,-34},{-14,-18}},
          color={0,0,127}));
      connect(inverseBlockConstraints.y1, add.u1) annotation (Line(
          points={{-0.7,24},{30,24},{30,-5.2},{38.4,-5.2}},
          color={0,0,127}));
      connect(sample2.u,step. y) annotation (Line(
          points={{-109.2,24},{-115,24}},
          color={0,0,127}));
      connect(filter.u, sample2.y) annotation (Line(
          points={{-88,24},{-95.4,24}},
          color={0,0,127}));
      connect(periodicClock1.y, sample2.clock) annotation (Line(
          points={{-121.4,-20},{-102,-20},{-102,16.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
                -100},{120,100}}),      graphics={Rectangle(extent={{-90,44},
                {60,-44}}, lineColor={255,0,0}), Text(
            extent={{12,42},{58,34}},
            lineColor={255,0,0},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textString="controller")}),
        experiment(StopTime=300),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}})),
        Documentation(info="<html>
<p>
Since a long time, Modelica is used to model advanced nonlinear control systems.
Especially, Modelica allows a semi-automatic treatment of inverse nonlinear
plant models. In the fundamental article (Looye et.al. 2005, see
<a href=\"modelica://Modelica.Clocked.UsersGuide.Literature\">Literature</a> or
<a href=\"https://www.modelica.org/events/Conference2005/online_proceedings/Session3/Session3c3.pdf\">Download</a>)
this approach is described and several controller structures are presented to
utilize an inverse plant model in the controller. This approach is attractive
because it results in a systematic procedure to design a controller for the
whole operating range of a plant. This is in contrast to standard controller
design techniques that usually design a linear controller for a plant model
that is linearized at a specific operating point. Therefore the operating range of such controllers is inherently limited.
</p>

<p>
Up to Modelica 3.2, controllers with inverse plant models can only be
defined as continuous-time systems. Via the export mechanism of a Modelica tool
they could be exported with solvers embedded in the code and then used as
sampled data system in other environments. However, it is not possible
to re-import the sampled data system to Modelica.
</p>

<p>
The synchronous features of Modelica 3.3 together with the
Modelica_Synchronous library offer now completely new possibilities,
so that the inverse model can be designed and evaluated as sampled data
system within Modelica and a Modelica simulation environment.
This approach is shown at hand of a simple example using
a nonlinear plant model of a
mixing unit (F&ouml;llinger O. (1998): Nichtlineare Regelungen I,
Oldenbourg Verlag, 8. Auflage, page 279) and utilizing this plant
model as nonlinear feed-forward controller according to (Looye et.al. 2005):
</p>

<p>
A substance A is flowing continuously into a mixing reactor.
Due to a catalyst, the substance reacts and splits into several base
substances that are continuously removed. The reaction generates
energy and therefore the reactor is cooled with a cooling medium.
The cooling temperature T_c(t) in [K] is the primary actuation signal.
Substance A is described by its concentration c(t) in [mol/l] and
its temperature T(t) in [K].
The concentration c(t) is the signal to be primarily controlled
and the temperature T(t) is the signal that is measured.
These equations are collected together in input/output block
<a href=\"modelica://Modelica.Clocked.Examples.Systems.Utilities.ComponentsMixingUnit.MixingUnit\">Utilities.ComponentsMixingUnit.MixingUnit</a>.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/ControlledMixingUnit_PlantModel.png\">
</p>

<p>
The design of the control system proceeds now in the following steps:
</p>

<h4>Pre-Filter</h4>
<p>
Inverting a model usually means that equations need to be symbolically
differentiated and that higher derivatives of the inputs are needed
(that are usually not available). One approach is to filter the inputs,
so that a Modelica tool can determine the derivatives of the filtered
input from the filter states. The minimum needed filter order is determined
by first inverting the continuous-time plant model from the variable
to be primarily controlled (here: \"c\") to the actuator input
(here: \"T_c\"). This is performed with the help of block
<a href=\"modelica://Modelica.Blocks.Math.InverseBlockConstraints\">Modelica.Blocks.Math.InverseBlockConstraints</a>
that allows connecting an external input to an output
in the pre-filter design block
<a href=\"modelica://Modelica.Clocked.Examples.Systems.Utilities.ComponentsMixingUnit.FilterOrder\">Utilities.ComponentsMixingUnit.FilterOrder</a>:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/ControlledMixingUnit_FilterDesign.png\">
</p>


<p>
Translating this
model will generate the continuous-time inverse plant model.
However, a Modelica tool will give an error message that it
has to differentiate the model, but this requires the
<b>second derivative</b> of the external input c_ref and this derivative
is not available. The conclusion is that a low pass filter of at
least second order has to be connected between c_ref and c, for example
<a href=\"modelica:Modelica.Blocks.Continuous.Filter\">Modelica.Blocks.Continuous.Filter</a>. Only filter types should be used that do not have \"vibrations\" in the time domain for
a step input. Therefore, parameter <b>analogFilter</b> of the component should be
selected as <b>CriticalDamping</b> (= only real poles), or
<b>Bessel</b> (= nearly no vibrations, but steeper frequency response as
CriticalDamping). The cut-off frequency <b>f_cut</b> is manually
selected by simulations of the closed loop system. In the example,
a CriticalDamping filter of third order (the third order is selected to
get smoother signals) and a cut-off frequency of 1/300 Hz is used.
</p>

<h4>Design of Controller</h4>
<p>
The controller for the mixing unit is shown in the diagram layer of block
at hand, as
well as in the following figure:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/ControlledMixingUnit_Controller.png\">
</p>

It consists of the filter discussed above. The input to the filter is the reference
concentration which is filtered by the low pass filter. The output of the filter
is used as input to the concentration c in the inverse plant model.
This model computes the desired cooling temperature T_c (which is used
as desired cooling temperature at the output of the controller)
and the desired temperature T (which is used as desired value for
the feedback controller). This part of the control system is the
\"feed-forward\" part that computes the desired actuator signal.
As feedback controller a simple P-Controller with one gain is used.
</p>

<p>
This controller could be defined as continuous-time system in previous Modelica
versions. However, with Modelica 3.3 it is now also possible to define the
controller as sampled data system. For this, the two inputs are sampled
(sample1 and sample2) and the actuator output is hold (hold1).
The controller partition is then associated with a periodic clock
(via sample2) that has a sample period of 1 s and a
solverMethod = \"ExplicitEuler\". Since the controller partition is a
continuous-time system, it is discretized and solved with an explicit
Euler method at every clock tick (by integrating from the previous to
the actual time instant of the clock).
</p>

<h4>Simulation Results</h4>
<p>
The controller works perfectly if the same parameters for the plant
and the inverse plant model are used (follows perfectly the filtered reference
concentration). Changing all parameters of the inverse plant model by 50 %
(with exception of parameter <b>e</b> since the plant is very sensitive to it)
still results in a reasonable control behavior as shown in the next two figures:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/ControlledMixingUnit_Result.png\">
</p>

<p>
The green curve in the upper window is the (clocked) output of the filter,
that is, it is the desired concentration. The red curve in the upper window is the
concentration of model mixingUnit, which is the concentration in the plant.
Obviously, the concentration follows reasonably well the desired one. By using a more involved feedback controller, the control error could be substantially reduced.
</p>
</html>"));
    end ControlledMixingUnit;

    model EngineThrottleControl
     extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Step speedRef(
      startTime=5,
      offset=207.34,
      height=103.67)
        annotation (Placement(transformation(extent={{-90,6},{-70,26}})));
      Clocked.Examples.Systems.Utilities.ComponentsThrottleControl.SpeedControl
        speedControl
        annotation (Placement(transformation(extent={{-32,-5},{0,25}})));
      Clocked.RealSignals.Sampler.Sample sample1
        annotation (Placement(transformation(extent={{-60,9},{-46,23}})));
      Clocked.RealSignals.Sampler.Hold hold1(y_start=8.9)
        annotation (Placement(transformation(extent={{8,4},{20,16}})));
      Clocked.ClockSignals.Clocks.Rotational.FixedRotationalClock rotationalClock(
          trigger_interval(displayUnit="deg") = 3.1415926535898)
        annotation (Placement(transformation(extent={{20,-50},{0,-30}})));
      Clocked.Examples.Systems.Utilities.ComponentsThrottleControl.Engine2 engine(
          crankshaftPositionEvent(trigger_interval=rotationalClock.trigger_interval))
        annotation (Placement(transformation(extent={{30,-4},{58,24}})));
      Modelica.Blocks.Sources.Step step(
        height=-5,
        offset=25,
        startTime=2)
        annotation (Placement(transformation(extent={{148,17},{134,31}})));
      Modelica.Blocks.Sources.Step step1(
        height=5,
        offset=0,
        startTime=8)
        annotation (Placement(transformation(extent={{148,-10},{134,4}})));
      Modelica.Blocks.Math.Add add(k1=-1, k2=-1)
        annotation (Placement(transformation(extent={{122,4},{110,16}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque2(
                                        useSupport=false)
                                annotation (Placement(transformation(extent={{90,0},{
                70,20}})));
      Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={64,-22})));
      Modelica.Blocks.Continuous.Der derivative
        annotation (Placement(transformation(extent={{20,-90},{0,-70}})));
      RealSignals.Sampler.SampleClocked sample2
        annotation (Placement(transformation(extent={{-24,-74},{-36,-86}})));
    equation
    connect(speedRef.y, sample1.u)             annotation (Line(
          points={{-69,16},{-61.4,16}},
          color={0,0,127}));
      connect(sample1.y, speedControl.N_des) annotation (Line(
          points={{-45.3,16},{-35.2,16}},
          color={0,0,127}));
      connect(speedControl.Theta, hold1.u) annotation (Line(
          points={{1.6,10},{6.8,10}},
          color={0,0,127}));
      connect(hold1.y, engine.Theta)    annotation (Line(
          points={{20.6,10},{27.2,10}},
          color={0,0,127}));
      connect(torque2.flange, engine.flange_b)    annotation (Line(
          points={{70,10},{58.56,10}}));

      connect(add.y, torque2.tau) annotation (Line(
          points={{109.4,10},{92,10}},
          color={0,0,127}));
      connect(step1.y, add.u2) annotation (Line(
          points={{133.3,-3},{128,-3},{128,6.4},{123.2,6.4}},
          color={0,0,127}));
      connect(step.y, add.u1) annotation (Line(
          points={{133.3,24},{128,24},{128,13.6},{123.2,13.6}},
          color={0,0,127}));
      connect(engine.flange_b, angleSensor.flange) annotation (Line(
          points={{58.56,10},{64,10},{64,-12}}));
      connect(angleSensor.phi, derivative.u) annotation (Line(points={{64,-33},
              {64,-80},{22,-80}}, color={0,0,127}));
      connect(derivative.y, sample2.u)
        annotation (Line(points={{-1,-80},{-22.8,-80}}, color={0,0,127}));
      connect(sample2.y, speedControl.N) annotation (Line(points={{-36.6,-80},{
              -50,-80},{-50,1},{-35.2,1}},   color={0,0,127}));
      connect(rotationalClock.y, sample2.clock) annotation (Line(
          points={{-1,-40},{-30,-40},{-30,-72.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(angleSensor.phi, rotationalClock.angle)
        annotation (Line(points={{64,-33},{64,-40},{22,-40}}, color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{160,100}}),
                          graphics={Rectangle(extent={{104,36},{154,-22}},
                lineColor={0,0,255}), Text(
              extent={{110,-16},{152,-20}},
              lineColor={0,0,255},
              textString="Load torque")}),
                                     Icon(coordinateSystem(preserveAspectRatio=true,
                      extent={{-100,-100},{100,100}})),
      experiment(StopTime=1.1),
      Documentation(info="<html>
<p>
This example shows how to model a non-periodic synchronous sampled data systems
with the <code>Modelica_Synchronous library</code>. This is demonstrated at hand
of a closed-loop throttle control synchronized to the crankshaft angle of an
internal combustion engine. This system has the following properties:
<ul>
<li> Engine speed is regulated with a throttle actuator.</li>
<li> Controller execution is synchronized with the engine crankshaft angle.</li>
<li> The influence of disturbances, such as a change in load torque, is reduced.</li>
</ul>
<p>
The complete system is shown in figure below (diagram-layer):
</p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/EngineThrottleControl_Model.png\">
<p>
Block <code>speedControl</code> is the discrete control system. The boundaries
of this controller are defined by <code>sample1</code>, <code>sample2</code> and
<code>hold1</code>. The sampling is done via <code>rotationalClock</code>, an
event-based clock that ticks every 180° rotation of the crankshaft angle. The
speed controller therefore is automatically executed every half-rotation of the
engine's crankshaft. To produce respective clock ticks,
<a href=\"modelica://Modelica.Clocked.ClockSignals.Clocks.Rotational.RotationalClock\">rotationalClock</a>
bookeeps the angular of the last time a half-rotation of
the crankshaft has been recognized (<code>angular_offset</code>). Given
<code>angular_offset</code>, the event-condition for half-rotations is:
<p>
<code>abs(angle - angular_offset) >= abs(trigger_interval)</code>
<p>
with <code>trigger_interval = 180°</code>. The model of
<code>rotationalClock</code> therefore is (diagram-layer):
</p>
<img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/RotationalClock_Model.png\">
<p>
In the end, <code>rotationalClock</code> samples it's own input angle to bookeep
an offset used to decide when to tick; the clock's event condition depends on
the state present when the condition changed last time from beeing non-satisfied
to beeing satisfied, i.e., the state when the clock last ticked.
</html>"));
    end EngineThrottleControl;

    package Utilities
      extends Modelica.Icons.UtilitiesPackage;
      package ComponentsThrottleControl
        extends Modelica.Icons.Package;
        block ThrottleBody "Basic throttle body equations"
          extends Modelica.Blocks.Interfaces.BlockIcon;

        parameter Real P_0 = 1 "Atmospheric pressure, bar";
        protected
          Real m_ai(start=0, fixed=true) "mass, g";
          Real f_Theta "auxiliary variable";
          Real g_Pm "auxiliary variable";
        public
          Modelica.Blocks.Interfaces.RealInput Theta "throttle angle, degrees"
            annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
          Modelica.Blocks.Interfaces.RealInput Pm
            "Intake manifold presure, bar"
            annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
          Modelica.Blocks.Interfaces.RealOutput m_ai_dot
            "Mass flow rate of air into manifold (g/s)"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));

        protected
          Real tmp1;
          Real tmp2;
          Real pratio;
          Real gpratio;
        equation

        der(m_ai) = f_Theta * g_Pm;
        f_Theta = 2.821 - 0.05231*Theta + 0.10299*Theta^2 - 0.00063*Theta^3; // different to paper 0.0063*Theta^3
        // Note: If the flow direction changes, i.e. Pm>P_0 the logic will fail since sqrt(-x)
        tmp1 = Pm / P_0;
        tmp2 = P_0 / Pm;
        pratio = min(tmp1, tmp2);
        gpratio = if pratio >= 0.5 then 2*sqrt(pratio - pratio^2) else 1;
        g_Pm = sign(P_0 - Pm) * gpratio;
        /*
g_Pm = if Pm <= P_0/2 then 1.0 else 2/P_0*sqrt(Pm*P_0 - Pm^2);
*/
        m_ai_dot = der(m_ai);
          annotation (Diagram(graphics));
        end ThrottleBody;

        block IntakeManifold "Dynamics of the intake manifold"
        extends Modelica.Blocks.Interfaces.BlockIcon;
          parameter Real RTVmRatio = 0.41328
            "RT/V_m TODO: What are sensible individual values of R,T, and V_m! (took same value like SIMULINK example for comparison reasons)";
          parameter Real P_0 = 0.543
            "Initial value for P_m, (bar) (took same value like SIMULINK example for comparison reasons)";
          Modelica.Blocks.Interfaces.RealInput m_ai_dot
            "Mass flow rate of air into manifold (g/s) "
            annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
          Modelica.Blocks.Interfaces.RealInput N "Engine speed (rad/sec)"
            annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
          Modelica.Blocks.Interfaces.RealOutput m_ao_dot
            "Mass flow rate of air out of manifold (g/s)"
            annotation (Placement(transformation(extent={{100,50},{120,70}})));
          Modelica.Blocks.Interfaces.RealOutput P_m(start=P_0, fixed=true)
            "Intake manifold presure, (bar)"
            annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
        equation
          der(P_m) = RTVmRatio*(m_ai_dot - m_ao_dot); // TODO adapt so that der(m_ai) and der(m_ao) is used!
          m_ao_dot = -0.366 + 0.08979*N*P_m - 0.0337*N*P_m^2 + 0.0001*N^2*P_m;

          annotation (Diagram(graphics));
        end IntakeManifold;

        block TorqueGeneration
        extends Modelica.Blocks.Interfaces.BlockIcon;
          parameter Real AFR = 14.6
            "air-fuel ratio (took same value like SIMULINK example for comparison reasons)";
          parameter Real sigma = 15.0
            "spark advance, BTDC (took same value like SIMULINK example for comparison reasons)";
          Modelica.Blocks.Interfaces.RealInput m_a
            "Mass of air charge in cylinder (delayed of 180deg crankshaft rotation) (g) "
            annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
          Modelica.Blocks.Interfaces.RealInput N "Engine speed (rad/sec)"
            annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
          Modelica.Blocks.Interfaces.RealOutput T_torque_e
            "Torque generated by engine"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        equation

         T_torque_e = -181.3 + 379.36*m_a + 21.91*AFR - 0.85*AFR^2 + 0.26*sigma
         - 0.0028*sigma^2 + 0.027*N - 0.000107*N^2 + 0.00048*N*sigma
         + 2.55*sigma*m_a - 0.05*sigma^2*m_a;

          annotation (Diagram(graphics));
        end TorqueGeneration;

        block SpeedControl
          "Discrete control of crankshaft speed by throttle actuation"
          parameter Real k_p = 0.0614 "Proportional gain";
          parameter Real k_I = 0.0723 "Integral gain";
          Modelica.Blocks.Interfaces.RealInput N_des "Desired speed, (rad/s)" annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
          Modelica.Blocks.Interfaces.RealInput N "Measured speed, (rad/s)"
                                                                          annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
          Modelica.Blocks.Interfaces.RealOutput Theta(start=8.9)
            "throttle angle, degrees"                                                      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        protected
          Real x_d(start=8.973, fixed=true);
        /*
initial equation
  N_des = pre(N_des);
  N = pre(N);
*/
        equation
          when Clock() then
             x_d = previous(x_d) + k_I*interval()*(previous(N_des) - previous(N));
             Theta = k_p*(N_des - N) + x_d;
          end when;
          annotation (Diagram(graphics), Icon(graphics={
                Rectangle(
                  extent={{-100,100},{100,-100}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-4,-36},{74,20},{74,-2},{-4,-58},{-4,-36}},
                  lineColor={95,95,95},
                  fillColor={175,175,175},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{8,-34},{28,-44},{20,-50},{0,-40},{8,-34}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{20,-50},{28,-44},{32,-52},{24,-58},{20,-50}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{24,-58},{32,-52},{32,-74},{24,-80},{24,-58}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{0,-40},{20,-50},{24,-58},{24,-80},{22,-80},{22,-58},{20,
                      -54},{0,-44},{0,-40}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-14,44},{-18,36},{-10,42},{-8,48},{-14,44}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-18,36},{-10,42},{-10,18},{-18,12},{-18,36}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-20,14},{-20,36},{-16,44},{4,34},{4,30},{-16,40},{-18,36},
                      {-18,12},{-20,14}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-8,50},{12,40},{4,34},{-16,44},{-8,50}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-150,90},{150,60}},
                  textString="%name",
                  lineColor={0,0,255}),
                Polygon(
                  points={{28,-18},{48,-28},{40,-34},{20,-24},{28,-18}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{40,-34},{48,-28},{52,-36},{44,-42},{40,-34}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{44,-42},{52,-36},{52,-58},{44,-64},{44,-42}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{20,-24},{40,-34},{44,-42},{44,-64},{42,-64},{42,-42},{40,
                      -38},{20,-28},{20,-24}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{48,-4},{68,-14},{60,-20},{40,-10},{48,-4}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{60,-20},{68,-14},{72,-22},{64,-28},{60,-20}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{64,-28},{72,-22},{72,-44},{64,-50},{64,-28}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{40,-10},{60,-20},{64,-28},{64,-50},{62,-50},{62,-28},{60,
                      -24},{40,-14},{40,-10}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{68,10},{88,0},{80,-6},{60,4},{68,10}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{80,-6},{88,0},{92,-8},{84,-14},{80,-6}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{84,-14},{92,-8},{92,-30},{84,-36},{84,-14}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{60,4},{80,-6},{84,-14},{84,-36},{82,-36},{82,-14},{80,
                      -10},{60,0},{60,4}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-34,30},{-38,22},{-30,28},{-28,34},{-34,30}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-38,22},{-30,28},{-30,4},{-38,-2},{-38,22}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-40,0},{-40,22},{-36,30},{-16,20},{-16,16},{-36,26},{-38,
                      22},{-38,-2},{-40,0}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-28,36},{-8,26},{-16,20},{-36,30},{-28,36}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-54,16},{-58,8},{-50,14},{-48,20},{-54,16}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-58,8},{-50,14},{-50,-10},{-58,-16},{-58,8}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-60,-14},{-60,8},{-56,16},{-36,6},{-36,2},{-56,12},{-58,
                      8},{-58,-16},{-60,-14}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-48,22},{-28,12},{-36,6},{-56,16},{-48,22}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-74,0},{-78,-8},{-70,-2},{-68,4},{-74,0}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-78,-8},{-70,-2},{-70,-26},{-78,-32},{-78,-8}},
                  lineColor={0,0,255},
                  fillColor={255,255,127},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-80,-30},{-80,-8},{-76,0},{-56,-10},{-56,-14},{-76,-4},{
                      -78,-8},{-78,-32},{-80,-30}},
                  lineColor={0,0,255},
                  fillColor={191,191,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-68,6},{-48,-4},{-56,-10},{-76,0},{-68,6}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-64,-4},{-4,-36},{-4,-58},{-64,-26},{-64,-4}},
                  lineColor={95,95,95},
                  fillColor={75,75,75},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-64,-4},{-4,-36},{74,20},{14,52},{-64,-4}},
                  lineColor={95,95,95},
                  fillColor={160,160,164},
                  fillPattern=FillPattern.Solid)}));
        end SpeedControl;

        block CylinderAirCharge
          "Integrates the air mass flow into a cylinder. After the charge for one cylinder is complete, resets the mass to 0"
        extends Modelica.Blocks.Interfaces.BlockIcon;

          Modelica.Blocks.Interfaces.RealOutput m_a
            "Mass of an cylinder air charge (g)"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          Modelica.Blocks.Interfaces.RealInput m_ao_dot
            "Mass flow rate of air out of manifold (g/s)"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

          Clocked.ClockSignals.Interfaces.ClockInput clock annotation (
              Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=90,
                origin={0,-120})));
        protected
          Real m_a_total(start=0, fixed=true)
            "Total amount of air that was sucked in";
          Real m_a_last "Amount of air sucked in until last clock event";
        equation
          der(m_a_total) = m_ao_dot;
          m_a = m_a_total - hold(m_a_last);
          when clock then
            m_a_last = sample(m_a_total);
          end when;

          annotation (Diagram(graphics));
        end CylinderAirCharge;

        block InductionToPowerDelay
          "Accounts for the induction-to-power stroke lag"
        extends Modelica.Blocks.Interfaces.BlockIcon;
          Modelica.Blocks.Interfaces.RealInput m_a
            "Mass of cylinder air charge (g)"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput m_a_delayed
            "180deg delayed mass of cylinder air charge (g)"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        protected
          Real m_a_sampled(start=0.152, fixed=true);
          Real m_a_delayedSampled(start=0.152, fixed=true);
        public
          Clocked.ClockSignals.Interfaces.ClockInput clock annotation (
              Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=90,
                origin={0,-120})));
        equation
          when clock then
            m_a_sampled = sample(m_a);
            m_a_delayedSampled = previous(m_a_sampled);
          end when;
          m_a_delayed = hold(m_a_delayedSampled);
          annotation (Diagram(graphics));
        end InductionToPowerDelay;

        model Engine2 "Internal combustion engine"

        public
          Modelica.Blocks.Interfaces.RealInput Theta "throttle angle, degrees"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Clocked.Examples.Systems.Utilities.ComponentsThrottleControl.ThrottleBody
            throttleBody
            annotation (Placement(transformation(extent={{-78,20},{-58,40}})));
          Clocked.Examples.Systems.Utilities.ComponentsThrottleControl.IntakeManifold
            intakeManifold
            annotation (Placement(transformation(extent={{-78,-20},{-58,0}})));
          Clocked.Examples.Systems.Utilities.ComponentsThrottleControl.TorqueGeneration
            torqueGeneration
            annotation (Placement(transformation(extent={{18,28},{38,48}})));
          Clocked.ClockSignals.Clocks.Rotational.FixedRotationalClock crankshaftPositionEvent
            annotation (Placement(transformation(extent={{70,-74},{50,-54}})));
          Clocked.Examples.Systems.Utilities.ComponentsThrottleControl.InductionToPowerDelay
            inductionToPowerDelay
            annotation (Placement(transformation(extent={{-22,-20},{-2,0}})));
          Clocked.Examples.Systems.Utilities.ComponentsThrottleControl.CylinderAirCharge
            cylinderAirCharge
            annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
          Modelica.Mechanics.Rotational.Sources.Torque
                                    torque(useSupport=false)
                                   annotation (Placement(transformation(extent={{40,-8},
                    {56,8}})));
          Modelica.Mechanics.Rotational.Components.Inertia
                                        inertia1(J=0.14, w(fixed=true, start=209),
            phi(fixed=true, start=0))
            annotation (Placement(transformation(extent={{64,-8},{80,8}})));
          Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
             Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={88,-18})));
          Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
            annotation (Placement(transformation(extent={{94,-10},{114,10}})));
          Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation (
             Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=-90,
                origin={100,-46})));
        equation
          connect(Theta, throttleBody.Theta) annotation (Line(
              points={{-120,0},{-92,0},{-92,36},{-80,36}},
              color={0,0,127}));
          connect(throttleBody.m_ai_dot, intakeManifold.m_ai_dot) annotation (Line(
              points={{-57,30},{-52,30},{-52,10},{-86,10},{-86,-4},{-80,-4}},
              color={0,0,127}));
          connect(intakeManifold.P_m, throttleBody.Pm) annotation (Line(
              points={{-57,-16},{-52,-16},{-52,-26},{-88,-26},{-88,24},{-80,24}},
              color={0,0,127}));
          connect(inductionToPowerDelay.m_a_delayed, torqueGeneration.m_a)
            annotation (Line(
              points={{-1,-10},{6,-10},{6,44},{16,44}},
              color={0,0,127}));
          connect(cylinderAirCharge.m_a, inductionToPowerDelay.m_a) annotation (
              Line(
              points={{-29,-10},{-24,-10}},
              color={0,0,127}));
          connect(intakeManifold.m_ao_dot, cylinderAirCharge.m_ao_dot) annotation (
              Line(
              points={{-57,-4},{-56,-4},{-56,-10},{-52,-10}},
              color={0,0,127}));
          connect(cylinderAirCharge.clock, crankshaftPositionEvent.y)
            annotation (Line(points={{-40,-22},{-40,-64},{49,-64}}, color={128,
                  0,255}));
          connect(inductionToPowerDelay.clock, crankshaftPositionEvent.y)
            annotation (Line(points={{-12,-22},{-12,-64},{49,-64}}, color={128,
                  0,255}));
          connect(torque.tau, torqueGeneration.T_torque_e) annotation (Line(
              points={{38.4,0},{32,0},{32,20},{48,20},{48,38},{39,38}},
              color={0,0,127}));
          connect(torque.flange, inertia1.flange_a) annotation (Line(
              points={{56,0},{64,0}}));
          connect(inertia1.flange_b, speedSensor.flange) annotation (Line(
              points={{80,0},{84,0},{84,-8},{88,-8}}));
          connect(inertia1.flange_b, flange_b) annotation (Line(
              points={{80,0},{104,0}}));
          connect(torqueGeneration.N, speedSensor.w) annotation (Line(
              points={{16,32},{10,32},{10,-36},{88,-36},{88,-29}},
              color={0,0,127}));
          connect(intakeManifold.N, speedSensor.w) annotation (Line(
              points={{-80,-16},{-86,-16},{-86,-78},{88,-78},{88,-29}},
              color={0,0,127}));
          connect(angleSensor.flange, inertia1.flange_b) annotation (Line(
              points={{100,-36},{100,0},{80,0}}));
          connect(angleSensor.phi, crankshaftPositionEvent.angle) annotation (
             Line(
              points={{100,-57},{100,-64},{72,-64}},
              color={0,0,127}));
          annotation (Icon(graphics={
                Rectangle(
                  extent={{-100,100},{100,-100}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-56,62},{36,76},{46,52},{-46,38},{-56,62}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{58,8},{-34,-6},{-34,-46},{58,-32},{58,8}},
                  pattern=LinePattern.None,
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-58,-38},{-34,-46},{-34,-6},{-16,28},{-36,54},{-46,38},{-56,62},
                      {-76,48},{-58,2},{-58,-38}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={175,175,175},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-16,28},{76,42},{58,8},{-34,-6},{-16,28}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-36,54},{-16,28},{76,42},{56,68},{-36,54}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-18,54},{2,34}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{40,62},{60,42}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{12,58},{32,38}},
                  lineColor={0,0,255},
                  pattern=LinePattern.None,
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),
                Line(points={{-46,38},{-36,54},{40,66}}),
                Text(
                  extent={{-100,-50},{100,-90}},
                  lineColor={0,0,255},
                  fillColor={255,255,0},
                  fillPattern=FillPattern.Solid,
                  textString="%name")}), Diagram(graphics));
        end Engine2;
      end ComponentsThrottleControl;

      package ComponentsMixingUnit
        extends Modelica.Icons.Package;
        model MixingUnit
          "Mixing unit demo from Foellinger, Nichtlineare Regelungen II, p. 280"
        import SI = Modelica.SIunits;
          Modelica.Blocks.Interfaces.RealInput T_c(unit="K")
            "Cooling temperature"
            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
          Modelica.Blocks.Interfaces.RealOutput c(unit="mol/l") "Concentration"
            annotation (Placement(transformation(extent={{100,40},{140,80}})));
          Modelica.Blocks.Interfaces.RealOutput T(unit="K")
            "Temperature in mixing unit"
            annotation (Placement(transformation(extent={{100,-80},{140,-40}})));
          parameter Real c0(unit="mol/l") = 0.848 "Nominal concentration";
          parameter SI.Temperature T0 = 308.5 "Nominal temperature";
          parameter Real a1 = 0.2674;
          parameter Real a21 = 1.815;
          parameter Real a22 = 0.4682;
          parameter Real b = 1.5476;
          parameter Real k0 = 1.05e14;
          parameter Real eps = 34.2894;
          Real gamma "Reaction speed";
        protected
          parameter SI.Time tau0 = 60;
          parameter Real wk0 = k0/c0;
          parameter Real weps = eps*T0;
          parameter Real wa11 = a1/tau0;
          parameter Real wa12 = c0/tau0;
          parameter Real wa13 = c0*a1/tau0;
          parameter Real wa21 = a21/tau0;
          parameter Real wa22 = a22*T0/tau0;
          parameter Real wa23 = T0*(a21 - b)/tau0;
          parameter Real wb = b/tau0;
        equation
          gamma = c*wk0*exp( -weps/T);
          der(c) = -wa11*c - wa12*gamma + wa13;
          der(T) = -wa21*T + wa22*gamma + wa23 + wb*T_c;
          annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                    -100,-100},{100,100}})),
                               Icon(coordinateSystem(preserveAspectRatio=false,
                  extent={{-100,-100},{100,100}}), graphics={
                Rectangle(
                  extent={{-100,40},{100,-100}},
                  lineColor={255,255,255},
                  fillColor={0,255,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{-100,100},{-100,-100},{100,-100},{100,100}}, color={0,
                      0,0}),
                Text(
                  extent={{-144,148},{148,100}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="%name"),
                Text(
                  extent={{118,-86},{160,-124}},
                  textString="T"),
                Text(
                  extent={{116,114},{158,76}},
                  textString="c"),
                Text(
                  extent={{-194,72},{-108,34}},
                  textString="T_c"),
                Line(points={{0,-50},{0,-100}}),
                Ellipse(
                  extent={{-42,-38},{0,-66}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{0,-38},{42,-66}},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{0,80},{0,16}}),
                Line(points={{20,80},{20,16}}),
                Line(points={{-86,-72},{-86,-114}}),
                Line(points={{-66,-72},{-66,-114}})}));
        end MixingUnit;

        model MixingUnitWithContinuousControl
           extends Modelica.Icons.Example;
        import SI = Modelica.SIunits;

          parameter SI.Frequency freq = 1/300 "Critical frequency of filter";
          parameter Real c0(unit="mol/l") = 0.848 "Nominal concentration";
          parameter SI.Temperature T0 = 308.5 "Nominal temperature";
          parameter Real a1_inv =  0.2674;
          parameter Real a21_inv = 1.815;
          parameter Real a22_inv = 0.4682;
          parameter Real b_inv =   1.5476;
          parameter Real k0_inv =  1.05e14;
          parameter Real eps = 34.2894;

          parameter Real x10 = 0.42;
          parameter Real x10_inv = 0.6;
          parameter Real x20 = 0.01;
          parameter Real u0 = -0.0224;

          final parameter Real c_start(unit="mol/l") = c0*(1-x10);
          final parameter Real c_inv_start(unit="mol/l") = c0*(1-x10_inv);
          final parameter SI.Temperature T_start = T0*(1+x20);
          final parameter Real c_high_start(unit="mol/l") = c0*(1-0.72);
          final parameter Real T_c_start = T0*(1+u0);

          parameter Real pro=1.1
            "Deviations of plant to inverse plant parameters";
          final parameter Real a1=a1_inv*pro;
          final parameter Real a21=a21_inv*pro;
          final parameter Real a22=a22_inv*pro;
          final parameter Real b=b_inv*pro;
          final parameter Real k0=k0_inv*pro;

          Utilities.ComponentsMixingUnit.MixingUnit invMixingUnit(
            c0= c0,
            T0= T0,
            a1= a1_inv,
            a21=a21_inv,
            a22=a22_inv,
            b = b_inv,
            k0= k0_inv,
            eps=eps,
            c(start=c_start, fixed=true),
            T(start=T_start,
              fixed=true,
              stateSelect=StateSelect.always),
            T_c(start=T_c_start, fixed=true))
            annotation (Placement(transformation(extent={{-14,14},{-34,34}})));
          Modelica.Blocks.Math.Add add
            annotation (Placement(transformation(extent={{40,-18},{56,-2}})));
          Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
            annotation (Placement(transformation(extent={{-54,8},{-2,40}})));
          Modelica.Blocks.Continuous.CriticalDamping filter(f=freq, n=3,
            normalized=false)
            annotation (Placement(transformation(extent={{-86,14},{-66,34}})));
          Utilities.ComponentsMixingUnit.MixingUnit   mixingUnit(
            c(start=c_start, fixed=true),
            T(start=T_start, fixed=true),
            c0= c0,
            T0= T0,
            a1= a1,
            a21=a21,
            a22=a22,
            b = b,
            k0= k0,
            eps=eps)
            annotation (Placement(transformation(extent={{70,-20},{90,0}})));
          Modelica.Blocks.Math.Feedback feedback
            annotation (Placement(transformation(extent={{-24,-20},{-4,0}})));
          Modelica.Blocks.Sources.Step step(height=c_high_start - c_start, offset=
                c_start)
            annotation (Placement(transformation(extent={{-118,14},{-98,34}})));
          Modelica.Blocks.Math.Gain gain(k=20) annotation (Placement(transformation(
                  extent={{4,-20},{24,0}})));
        equation
          connect(step.y, filter.u)  annotation (Line(points={{-97,24},{-97,24},{
                  -88,24}},
                color={0,0,127}));
          connect(mixingUnit.T, feedback.u2) annotation (Line(points={{92,-16},{
                  98,-16},{98,-36},{-14,-36},{-14,-18}},
                                                      color={0,0,127}));
          connect(feedback.y, gain.u) annotation (Line(points={{-5,-10},{-5,-10},
                  {2,-10}},
                color={0,0,127}));
          connect(add.y, mixingUnit.T_c) annotation (Line(
              points={{56.8,-10},{68,-10}},
              color={0,0,127}));
          connect(gain.y, add.u2) annotation (Line(
              points={{25,-10},{32,-10},{32,-14.8},{38.4,-14.8}},
              color={0,0,127}));
          connect(inverseBlockConstraints.y2, invMixingUnit.T_c) annotation (Line(
              points={{-5.9,24},{-12,24}},
              color={0,0,127}));
          connect(inverseBlockConstraints.y1, add.u1) annotation (Line(
              points={{-0.7,24},{32,24},{32,-5.2},{38.4,-5.2}},
              color={0,0,127}));
          connect(filter.y, inverseBlockConstraints.u1) annotation (Line(
              points={{-65,24},{-56.6,24}},
              color={0,0,127}));
          connect(invMixingUnit.T, feedback.u1) annotation (Line(
              points={{-36,18},{-42,18},{-42,-10},{-22,-10}},
              color={0,0,127}));
          connect(invMixingUnit.c, inverseBlockConstraints.u2) annotation (Line(
              points={{-36,30},{-38,30},{-38,24},{-48.8,24}},
              color={0,0,127}));
          annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-120,
                    -100},{100,100}}),      graphics),
            experiment(StopTime=500),
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}})));
        end MixingUnitWithContinuousControl;

        model FilterOrder "Block to determine the minimum filter order"
           extends Modelica.Icons.Example;
          MixingUnit mixingUnit
            annotation (Placement(transformation(extent={{-20,-2},{0,18}})));
          Modelica.Blocks.Math.InverseBlockConstraints
            inverseBlockConstraints
            annotation (Placement(transformation(extent={{24,-8},{-42,30}})));
          Modelica.Blocks.Interfaces.RealInput c_ref
            annotation (Placement(transformation(extent={{70,-4},{40,26}})));
        equation
          connect(inverseBlockConstraints.u1, c_ref) annotation (Line(
              points={{27.3,11},{55,11}},
              color={0,0,127}));
          connect(mixingUnit.T_c, inverseBlockConstraints.y2) annotation (
              Line(
              points={{-22,8},{-30,8},{-30,11},{-37.05,11}},
              color={0,0,127}));
          connect(mixingUnit.c, inverseBlockConstraints.u2) annotation (Line(
              points={{2,14},{10,14},{10,11},{17.4,11}},
              color={0,0,127}));
          annotation (Diagram(graphics));
        end FilterOrder;

        block CriticalDamping
          "Output the input signal filtered with an n-th order filter with critical damping"

          import Modelica.Blocks.Types.Init;
          extends Modelica.Blocks.Interfaces.SISO;

          parameter Integer n=2 "Order of filter";
          parameter Modelica.SIunits.Frequency f(start=1) "Cut-off frequency";
          parameter Boolean normalized = true
            "= true, if amplitude at f_cut is 3 dB, otherwise unmodified filter";
            /*
  parameter Real x_start[n]=zeros(n) "Initial or guess values of states"
    annotation (Dialog(group="Initialization"));
*/
          output Real x[n](start=zeros(n)) "Filter states";
        protected
          parameter Real alpha=if normalized then sqrt(2^(1/n) - 1) else 1.0
            "Frequency correction factor for normalized filter";
          parameter Real w=2*Modelica.Constants.pi*f/alpha;
        equation
          der(x[1]) = (u - x[1])*w;
          for i in 2:n loop
            der(x[i]) = (x[i - 1] - x[i])*w;
          end for;
          y = x[n];
          annotation (
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                    100}}), graphics={
                Line(points={{-80.6897,77.6256},{-80.6897,-90.3744}}, color={192,192,
                      192}),
                Polygon(
                  points={{-79.7044,90.6305},{-87.7044,68.6305},{-71.7044,68.6305},{-79.7044,
                      88.6305},{-79.7044,90.6305}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
                Polygon(
                  points={{90,-80},{68,-72},{68,-88},{90,-80}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{0,0},{60,-60}},
                  lineColor={192,192,192},
                  textString="PTn"),
                Line(points={{-80.7599,-80.5082},{-70.7599,-74.5082},{-56,-60},{-48,-42},
                      {-42,-18},{-36,4},{-26,20},{-10.7599,34.9018},{-0.759907,
                      38.8218},{9.24009,41.6818},{19.2401,43.7818},{29.2401,45.3118},
                      {39.2401,46.4318},{49.2401,47.2518},{59.2401,47.8518},{69.2401,
                      48.2918},{79.2401,48.6118}}, color={0,0,127}),
                Text(
                  extent={{-70,94},{26,48}},
                  lineColor={192,192,192},
                  textString="%n"),
                Text(
                  extent={{8,-106},{8,-146}},
                  textString="f=%f")}),
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
                Line(points={{40,0},{-40,0}}),
                Text(
                  extent={{-55,55},{55,5}},
                  textString="1"),
                Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
                Line(points={{-100,0},{-60,0}}, color={0,0,255}),
                Line(points={{60,0},{100,0}}, color={0,0,255}),
                Text(
                  extent={{-54,-6},{44,-56}},
                  textString="(s/w + 1)"),
                Text(
                  extent={{38,-10},{58,-30}},
                  textString="n")}),
            Documentation(info="<html>
<p>This block defines the transfer function between the
input u and the output y
as an n-th order filter with <i>critical damping</i>
characteristics and cut-off frequency f. It is
a slightly simplified version of the \"Modelica.Blocks.Continuous.CriticalDamping\" block from the MSL 3.2.1.
It doesn't provide the same initialization capabilities as the MSL block, since the initialization of
clocked partitions is currently performed different to the continuous time partitions.
</p>

</html>
"));
        end CriticalDamping;
      end ComponentsMixingUnit;
    end Utilities;
  annotation (Documentation(info="<html>
<p>
This package contains complete <b>system models</b> of
simplified realistic applications.
</p>
</html>"));
  end Systems;

  package Elementary
    "Examples that are used for the documentation of the blocks"
    extends Modelica.Icons.ExamplesPackage;

    package ClockSignals
      "Examples that are used for the documentation of the Modelica.Clocked.ClockSignals sub-library"
      extends Modelica.Icons.ExamplesPackage;

      model SubSample "Example of a SubSample block for Clock signals"
      import Modelica_Synchronous =
             Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-56,24},{-44,36}})));
      Modelica.Clocked.ClockSignals.Sampler.SubSample subSample(
                             factor=3)
        annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1
          annotation (Placement(transformation(extent={{16,52},{28,64}})));
        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-24,48},{-4,68}})));
      equation
      connect(periodicClock.y, subSample.u) annotation (Line(
          points={{-43.4,30},{-23.2,30}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
        connect(sine.y, sample1.u) annotation (Line(points={{-3,58},{14.8,58},{
                14.8,58}}, color={0,0,127}));
        connect(subSample.y, sample1.clock) annotation (Line(
            points={{-9.4,30},{22,30},{22,50.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),             experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.ClockSignals.Sampler.SubSample\">Modelica.Clocked.ClockSignals.Sampler.SubSample</a>.
</p>
</html>"));
      end SubSample;

      model SuperSample "Example of a SuperSample block for Clock signals"
      import Modelica_Synchronous =
             Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-56,24},{-44,36}})));
      Modelica.Clocked.ClockSignals.Sampler.SuperSample superSample(
            factor=3)
        annotation (Placement(transformation(extent={{-26,24},{-14,36}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1
          annotation (Placement(transformation(extent={{10,56},{22,68}})));
        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-30,52},{-10,72}})));
      equation
      connect(periodicClock.y, superSample.u) annotation (Line(
          points={{-43.4,30},{-27.2,30}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
        connect(sine.y, sample1.u)
          annotation (Line(points={{-9,62},{8.8,62}}, color={0,0,127}));
        connect(superSample.y, sample1.clock) annotation (Line(
            points={{-13.4,30},{2,30},{16,30},{16,54.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),             experiment(StopTime=0.08),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.ClockSignals.Sampler.SuperSample\">Modelica.Clocked.ClockSignals.Sampler.SuperSample</a>.
</p>
</html>"));
      end SuperSample;

      model ShiftSample "Example of a ShiftSample block for Clock signals"
      import Modelica_Synchronous =
             Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-56,24},{-44,36}})));
        Modelica.Clocked.ClockSignals.Sampler.ShiftSample shiftSample(
          shiftCounter=4, resolution=3)
          annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1
          annotation (Placement(transformation(extent={{14,54},{26,66}})));
        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-26,50},{-6,70}})));
      equation
      connect(periodicClock.y, shiftSample.u) annotation (Line(
          points={{-43.4,30},{-23.2,30}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
        connect(sine.y, sample1.u)
          annotation (Line(points={{-5,60},{12.8,60}}, color={0,0,127}));
        connect(shiftSample.y, sample1.clock) annotation (Line(
            points={{-9.4,30},{20,30},{20,52.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),             experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.ClockSignals.Sampler.ShiftSample\">Modelica.Clocked.ClockSignals.Sampler.ShiftSample</a>.
</p>
</html>"));
      end ShiftSample;

      model RotationalSample
        "Simple example of a rotational clock with variable trigger interval and
   switching rotation-direction."
        extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.Sine angle_input(
          amplitude = 10,
          freqHz = 1)
          annotation (Placement(transformation(extent = {{-70,-10},{-50,10}})));
        Modelica.Blocks.Sources.Pulse trigger_interval_input(
          amplitude = 2,
          period = 1,
          offset = 1)
          annotation (Placement(transformation(extent = {{-70,30},{-50,50}})));
        Clocked.ClockSignals.Clocks.Rotational.RotationalClock rotationalClock
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Clocked.RealSignals.Sampler.SampleClocked sample_angle
          annotation (Placement(transformation(extent={{34,-14},{46,-26}})));

      equation
        connect(angle_input.y, rotationalClock.angle)
          annotation (Line(
            points = {{-49,0},{-12,0}},
            color = {0,0,127}));
        connect(rotationalClock.y, sample_angle.clock)
          annotation (Line(
            points = {{11,0},{40,0},{40,-12.8}},
            color = {175,175,175},
            pattern = LinePattern.Dot,
            thickness = 0.5));
        connect(angle_input.y, sample_angle.u)
          annotation (Line(
            points = {{-49,0},{-30,0},{-30,-20},{32.8,-20}},
            color = {0,0,127}));
        connect(trigger_interval_input.y, rotationalClock.trigger_interval)
          annotation (Line(
            points = {{-49,40},{-40,40},{-40,6},{-12,6}},
            color = {0,0,127}));

        annotation (
          preferredView = "info",
          experiment(StopTime = 2),
          Documentation(info="<html>
    Simple example of a rotational clock with variable trigger interval and
    switching rotation-direction. The input rotation is just sinodical,
    switching direction every half second. The trigger interval is changed with
    the same pace; every half second it is doubled or halfed respectively. The
    generated clocked signals are therefore:
    <p>
    <img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/RotationalSample_Result.png\">.
    </html>"));
      end RotationalSample;

      model LogicalSample
        "Simple example of conjunctive and disjunctive logical clocks, combining clock
   signals to derive new event driven clocks."
        extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.Sine sine_angle_input(
          amplitude = 10,
          freqHz = 1)
          annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
        Modelica.Blocks.Sources.Cosine cosine_angle_input(
          amplitude = 10,
          freqHz = 1)
          annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
        Modelica.Blocks.Sources.Pulse trigger_interval_input(
          amplitude = 2,
          period = 1,
          offset = 1)
          annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

        Clocked.ClockSignals.Clocks.Rotational.RotationalClock rotational_clock_1
          annotation (Placement(transformation(extent={{-20,30},{0,50}})));
        Clocked.ClockSignals.Clocks.Rotational.RotationalClock rotational_clock_2
          annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));

        Clocked.ClockSignals.Clocks.Logical.ConjunctiveClock conjunctiveClock
          annotation (Placement(transformation(extent={{40,20},{60,40}})));
        Clocked.ClockSignals.Clocks.Logical.DisjunctiveClock disjunctiveClock
          annotation (Placement(transformation(extent={{40,-40},{60,-20}})));

        Clocked.RealSignals.Sampler.SampleClocked sample_conjunctive
          annotation (Placement(transformation(extent={{74,54},{86,66}})));
        Clocked.RealSignals.Sampler.SampleClocked sample_disjunctive
          annotation (Placement(transformation(extent={{74,-54},{86,-66}})));
      equation
        connect(sine_angle_input.y, rotational_clock_1.angle)
          annotation (Line(
            points={{-59,40},{-22,40}},
            color = {0,0,127}));
        connect(trigger_interval_input.y, rotational_clock_1.trigger_interval)
          annotation (Line(
            points={{-59,0},{-40,0},{-40,46},{-22,46}},
            color = {0,0,127}));
        connect(trigger_interval_input.y, rotational_clock_2.trigger_interval)
          annotation (Line(
            points={{-59,0},{-40,0},{-40,-34},{-22,-34}},
            color = {0,0,127}));
        connect(cosine_angle_input.y, rotational_clock_2.angle)
          annotation (Line(
            points={{-59,-40},{-22,-40}},
            color = {0,0,127}));
        connect(rotational_clock_1.y, conjunctiveClock.u[1])
          annotation (Line(
            points = {{1,40},{20,40},{20,34},{40,34},{40,30}},
            color = {175,175,175},
            pattern = LinePattern.Dot,
            thickness = 0.5));
        connect(rotational_clock_2.y, conjunctiveClock.u[2])
          annotation (Line(
            points = {{1,-40},{20,-40},{20,30},{40,30}},
            color = {175,175,175},
            pattern = LinePattern.Dot,
            thickness = 0.5));
        connect(rotational_clock_1.y, disjunctiveClock.u[1])
          annotation (Line(
            points = {{1,40},{20,40},{20,-28},{40,-28},{40,-30}},
            color = {175,175,175},
            pattern = LinePattern.Dot,
            thickness = 0.5));
        connect(rotational_clock_2.y, disjunctiveClock.u[2])
          annotation (Line(
            points = {{1,-40},{20,-40},{20,-30},{40,-30}},
            color = {175,175,175},
            pattern = LinePattern.Dot,
            thickness = 0.5));

        connect(disjunctiveClock.y, sample_disjunctive.clock) annotation (Line(
            points={{61,-30},{80,-30},{80,-52.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
        connect(conjunctiveClock.y, sample_conjunctive.clock) annotation (Line(
            points={{61,30},{80,30},{80,52.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
        connect(sample_conjunctive.u, sine_angle_input.y) annotation (Line(
              points={{72.8,60},{-50,60},{-50,40},{-59,40}}, color={0,0,127}));
        connect(sample_disjunctive.u, sine_angle_input.y) annotation (Line(
              points={{72.8,-60},{-50,-60},{-50,40},{-59,40}}, color={0,0,127}));
        annotation (
          preferredView = "info",
          experiment(StopTime = 2),
          Documentation(info="<html>
    Simple example of two logical clocks, a conjunctive and a disjunctive clock.
    Both receive the very same clock inputs, produced by two rotational clocks
    with slightly shifted input angle waves (sine and cosine respectively). The
    configuration and results of the rotational clocks are explained in the
    <a href=\"modelica://Modelica.Clocked.Examples.Elementary.ClockSignals.RotationalSample\">rotational clocks example</a>.
    The generated clocked signals of the disjunctive and conjunctive clock are
    therefore:
    <p>
    <img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/LogicalSample_Result.png\">.
    </html>"));
      end LogicalSample;
    annotation (Documentation(info="<html>
<p>
This package contains models that have been used to produce
the figures in the documentation of the
<a href=\"modelica://Modelica.Clocked.ClockSignals\">Modelica.Clocked.ClockSignals</a>
sub-library.
</p>
</html>"));
    end ClockSignals;

    package RealSignals
      "Examples that are used for the documentation of the Modelica.Clocked.RealSignals sub-library"
      extends Modelica.Icons.ExamplesPackage;
      model Sample1 "Example of a Sample block for Real signals"
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Clocked.RealSignals.Sampler.Sample sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Clocked.RealSignals.Sampler.AssignClock assignClock
          annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
        Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(factor=20,
            resolution=Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-42,-2},{-30,10}})));
      equation
        connect(sine.y, sample.u) annotation (Line(
            points={{-59,30},{-47.2,30}},
            color={0,0,127}));
        connect(sample.y, assignClock.u) annotation (Line(
            points={{-33.4,30},{-23.2,30}},
            color={0,0,127}));
        connect(periodicClock.y, assignClock.clock) annotation (Line(
            points={{-29.4,4},{-16,4},{-16,22.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.Sample\">Modelica.Clocked.RealSignals.Sampler.Sample</a>.
</p>
</html>"));
      end Sample1;

      model Sample2
        "Example of a Sample block with discontinuous Real input signals"
       extends Modelica.Icons.Example;
        Clocked.RealSignals.Sampler.Sample sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Clocked.RealSignals.Sampler.AssignClock assignClock
          annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
        Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(factor=20,
            resolution=Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-42,-2},{-30,10}})));
      Modelica.Blocks.Sources.Step step(startTime=0.1)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      equation
        connect(sample.y, assignClock.u) annotation (Line(
            points={{-33.4,30},{-23.2,30}},
            color={0,0,127}));
        connect(periodicClock.y, assignClock.clock) annotation (Line(
            points={{-29.4,4},{-16,4},{-16,22.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
      connect(step.y, sample.u) annotation (Line(
          points={{-59,30},{-47.2,30}},
          color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.Sample\">Modelica.Clocked.RealSignals.Sampler.Sample</a>.
</p>
</html>"));
      end Sample2;

      model Sample3
        "Example of a Sample block for Real signals with direct feed-through in the continuous-time and the clocked partition"
        import Modelica_Synchronous =
               Modelica.Clocked;
       extends Modelica.Icons.Example;
        Modelica.Clocked.RealSignals.Sampler.SampleClocked sample1
          annotation (Placement(transformation(extent={{-52,24},{-40,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-76,-6},{-64,6}})));
      Modelica.Blocks.Sources.Step step(startTime=0.04)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Blocks.Math.Gain gain(k=1.2)
          annotation (Placement(transformation(extent={{-8,20},{12,40}})));
        Modelica.Clocked.RealSignals.Sampler.Hold hold
          annotation (Placement(transformation(extent={{20,24},{32,36}})));
        Modelica.Blocks.Math.Feedback feedback
          annotation (Placement(transformation(extent={{-36,20},{-16,40}})));
        Modelica.Clocked.RealSignals.Sampler.Sample sample2
          annotation (Placement(transformation(extent={{6,-6},{-6,6}})));
      equation
        connect(step.y, sample1.u)
                                annotation (Line(
          points={{-59,30},{-53.2,30}},
          color={0,0,127}));
        connect(gain.y, hold.u) annotation (Line(
            points={{13,30},{18.8,30}},
            color={0,0,127}));
        connect(feedback.y, gain.u) annotation (Line(
            points={{-17,30},{-10,30}},
            color={0,0,127}));
        connect(sample2.y, feedback.u2) annotation (Line(
            points={{-6.6,0},{-26,0},{-26,22}},
            color={0,0,127}));
        connect(periodicClock.y, sample1.clock) annotation (Line(
            points={{-63.4,0},{-46,0},{-46,22.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
        connect(sample1.y, feedback.u1) annotation (Line(
            points={{-39.4,30},{-34,30}},
            color={0,0,127}));
        connect(hold.y, sample2.u) annotation (Line(
            points={{32.6,30},{38,30},{38,0},{7.2,0}},
            color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.Sample\">Modelica.Clocked.RealSignals.Sampler.Sample</a>.
</p>
</html>"));
      end Sample3;

      model SampleClocked "Example of a SampleClocked block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
      equation
        connect(sine.y, sample.u) annotation (Line(
            points={{-59,30},{-47.2,30}},
            color={0,0,127}));
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.SampleClocked\">Modelica.Clocked.RealSignals.Sampler.SampleClocked</a>.
</p>
</html>"));
      end SampleClocked;

      model SampleVectorizedAndClocked
        "Example of a SampleVectorizedAndClocked block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.Sine sine2(
        freqHz=2,
        offset=0.1,
        startTime=0)
          annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
        Modelica.Clocked.RealSignals.Sampler.SampleVectorizedAndClocked
                                                        sample(n=2)
          annotation (Placement(transformation(extent={{-14,24},{-2,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-28,-6},{-16,6}})));
        Modelica.Blocks.Sources.Sine sine1(startTime=0, freqHz=3)
          annotation (Placement(transformation(extent={{-80,-2},{-60,18}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-15.4,0},{-8,0},{-8,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sine1.y, sample.u[1]) annotation (Line(
          points={{-59,8},{-38,8},{-38,29.4},{-15.2,29.4}},
          color={0,0,127}));
      connect(sine2.y, sample.u[2]) annotation (Line(
          points={{-59,40},{-38,40},{-38,30.6},{-15.2,30.6}},
          color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.SampleVectorizedAndClocked\">Modelica.Clocked.RealSignals.Sampler.SampleVectorizedAndClocked</a>.
</p>
</html>"));
      end SampleVectorizedAndClocked;

      model SampleWithADeffects
        "Example of a SampleWithADeffects block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          startTime=0,
          amplitude=0.95)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.RealSignals.Sampler.SampleWithADeffects
                                                        sample(
          noisy=true,
          limited=true,
          quantized=true,
          yMax=0.8,
          redeclare
            Modelica.Clocked.RealSignals.Sampler.Utilities.Internal.UniformNoise
            noise(noiseMax=0.2))
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.RealSignals.Sampler.AssignClock assignClock
          annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            resolution=Modelica.Clocked.Types.Resolution.ms, factor=20)
          annotation (Placement(transformation(extent={{-42,-2},{-30,10}})));
      equation
        connect(sine.y, sample.u) annotation (Line(
            points={{-59,30},{-47.2,30}},
            color={0,0,127}));
        connect(sample.y, assignClock.u) annotation (Line(
            points={{-33.4,30},{-23.2,30}},
            color={0,0,127}));
        connect(periodicClock.y, assignClock.clock) annotation (Line(
            points={{-29.4,4},{-16,4},{-16,22.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=0.2),
          Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.SampleWithADeffects\">Modelica.Clocked.RealSignals.Sampler.SampleWithADeffects</a>.
</p>
</html>"));
      end SampleWithADeffects;

      model Hold "Example of a Hold block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-52,24},{-40,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
      Modelica.Clocked.RealSignals.Sampler.Hold hold(y_start=-1.0)
        annotation (Placement(transformation(extent={{-8,24},{4,36}})));
      Modelica.Clocked.RealSignals.Sampler.ShiftSample shiftSample(
          shiftCounter=2)
        annotation (Placement(transformation(extent={{-30,24},{-18,36}})));
      equation
        connect(sine.y, sample.u) annotation (Line(
            points={{-59,30},{-53.2,30}},
            color={0,0,127}));
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-55.4,0},{-46,0},{-46,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample.y, shiftSample.u) annotation (Line(
          points={{-39.4,30},{-31.2,30}},
          color={0,0,127}));
      connect(shiftSample.y, hold.u) annotation (Line(
          points={{-17.4,30},{-9.2,30}},
          color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.Hold\">Modelica.Clocked.RealSignals.Sampler.Hold</a>.
</p>
</html>"));
      end Hold;

      model HoldWithDAeffects1
        "Example of a HoldWithDAeffects block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          startTime=0,
        amplitude=2)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-52,24},{-40,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
      Modelica.Clocked.RealSignals.Sampler.HoldWithDAeffects
                                                    hold(
        computationalDelay=true,
        shiftCounter=1,
        resolution=2,
        y_start=0.5,
        limited=true,
        yMax=1.9)
        annotation (Placement(transformation(extent={{-8,24},{4,36}})));
      Modelica.Clocked.RealSignals.Sampler.ShiftSample shiftSample(
          shiftCounter=2)
        annotation (Placement(transformation(extent={{-30,24},{-18,36}})));
      equation
        connect(sine.y, sample.u) annotation (Line(
            points={{-59,30},{-53.2,30}},
            color={0,0,127}));
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-55.4,0},{-46,0},{-46,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample.y, shiftSample.u) annotation (Line(
          points={{-39.4,30},{-31.2,30}},
          color={0,0,127}));
        connect(shiftSample.y, hold.u) annotation (Line(
            points={{-17.4,30},{-9.2,30}},
            color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.HoldWithDAeffects\">Modelica.Clocked.RealSignals.Sampler.HoldWithDAeffects</a>.
</p>
</html>"));
      end HoldWithDAeffects1;

      model HoldWithDAeffects2
        "Example of a HoldWithDAeffects block for Real signals (with a computational delay of one sample period)"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          startTime=0,
        amplitude=2)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-52,24},{-40,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
      Modelica.Clocked.RealSignals.Sampler.HoldWithDAeffects
                                                    hold(
        computationalDelay=true,
        shiftCounter=1,
        y_start=0.5,
        limited=true,
        yMax=1.9,
        resolution=1)
        annotation (Placement(transformation(extent={{-8,24},{4,36}})));
      Modelica.Clocked.RealSignals.Sampler.ShiftSample shiftSample(
          shiftCounter=2)
        annotation (Placement(transformation(extent={{-30,24},{-18,36}})));
      equation
        connect(sine.y, sample.u) annotation (Line(
            points={{-59,30},{-53.2,30}},
            color={0,0,127}));
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-55.4,0},{-46,0},{-46,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample.y, shiftSample.u) annotation (Line(
          points={{-39.4,30},{-31.2,30}},
          color={0,0,127}));
        connect(shiftSample.y, hold.u) annotation (Line(
            points={{-17.4,30},{-9.2,30}},
            color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.HoldWithDAeffects\">Modelica.Clocked.RealSignals.Sampler.HoldWithDAeffects</a>.
</p>
</html>"));
      end HoldWithDAeffects2;

      model SubSample "Example of a SubSample block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
      Modelica.Clocked.RealSignals.Sampler.SubSample subSample(
          inferFactor=false, factor=3)
        annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
      equation
        connect(sine.y, sample.u) annotation (Line(
            points={{-59,30},{-47.2,30}},
            color={0,0,127}));
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample.y, subSample.u) annotation (Line(
          points={{-33.4,30},{-23.2,30}},
          color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.SubSample\">Modelica.Clocked.RealSignals.Sampler.SubSample</a>.
</p>
</html>"));
      end SubSample;

      model SuperSample "Example of a SuperSample block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
      Modelica.Clocked.RealSignals.Sampler.SuperSample superSample(inferFactor=false,
            factor=3)
        annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
      equation
        connect(sine.y, sample.u) annotation (Line(
            points={{-59,30},{-47.2,30}},
            color={0,0,127}));
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
        connect(sample.y, superSample.u)
                                     annotation (Line(
          points={{-33.4,30},{-23.2,30}},
          color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.08),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.SuperSample\">Modelica.Clocked.RealSignals.Sampler.SuperSample</a>.
</p>
</html>"));
      end SuperSample;

      model SuperSampleInterpolated
        "Example of a SuperSampleInterpolated block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
      Modelica.Clocked.RealSignals.Sampler.SuperSampleInterpolated superSampleIpo(
          inferFactor=false, factor=3)
        annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
      equation
        connect(sine.y, sample.u) annotation (Line(
            points={{-59,30},{-47.2,30}},
            color={0,0,127}));
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample.y, superSampleIpo.u)
                                     annotation (Line(
          points={{-33.4,30},{-23.2,30}},
          color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.06),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.SuperSampleInterpolated\">Modelica.Clocked.RealSignals.Sampler.SuperSampleInterpolated</a>.
</p>
</html>"));
      end SuperSampleInterpolated;

      model ShiftSample "Example of a ShiftSample block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
        Modelica.Clocked.RealSignals.Sampler.ShiftSample shiftSample1(
            shiftCounter=4, resolution=3)
          annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
      equation
        connect(sine.y, sample.u) annotation (Line(
            points={{-59,30},{-47.2,30}},
            color={0,0,127}));
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
        connect(sample.y, shiftSample1.u) annotation (Line(
            points={{-33.4,30},{-23.2,30}},
            color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.ShiftSample\">Modelica.Clocked.RealSignals.Sampler.ShiftSample</a>.
</p>
</html>"));
      end ShiftSample;

      model BackSample "Example of a BackSample block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
        Modelica.Clocked.RealSignals.Sampler.ShiftSample shiftSample1(
            shiftCounter=4, resolution=3)
          annotation (Placement(transformation(extent={{-26,24},{-14,36}})));
      Modelica.Clocked.RealSignals.Sampler.BackSample backSample1(
        backCounter=4,
        resolution=3,
        y_start=0.5)
        annotation (Placement(transformation(extent={{-4,24},{8,36}})));
      equation
        connect(sine.y, sample.u) annotation (Line(
            points={{-59,30},{-47.2,30}},
            color={0,0,127}));
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
        connect(sample.y, shiftSample1.u) annotation (Line(
            points={{-33.4,30},{-27.2,30}},
            color={0,0,127}));
      connect(shiftSample1.y, backSample1.u) annotation (Line(
          points={{-13.4,30},{-5.2,30}},
          color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.BackSample\">Modelica.Clocked.RealSignals.Sampler.BackSample</a>.
</p>
</html>"));
      end BackSample;

      model AssignClock "Example of a AssignClock block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-42,0},{-30,12}})));
      Modelica.Clocked.RealSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{-26,22},{-14,34}})));
      Modelica.Clocked.RealSignals.NonPeriodic.UnitDelay unitDelay1
        annotation (Placement(transformation(extent={{-38,48},{-58,68}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{-58,18},{-38,38}})));
      Modelica.Blocks.Sources.Constant const(k=1)
        annotation (Placement(transformation(extent={{-92,12},{-72,32}})));
      equation
      connect(periodicClock.y, assignClock1.clock) annotation (Line(
          points={{-29.4,6},{-20,6},{-20,20.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(add.u2, const.y) annotation (Line(
          points={{-60,22},{-71,22}},
          color={0,0,127}));
      connect(assignClock1.y, unitDelay1.u) annotation (Line(
          points={{-13.4,28},{-2,28},{-2,58},{-36,58}},
          color={0,0,127}));
      connect(unitDelay1.y, add.u1) annotation (Line(
          points={{-59,58},{-68,58},{-68,34},{-60,34}},
          color={0,0,127}));
      connect(add.y, assignClock1.u) annotation (Line(
          points={{-37,28},{-27.2,28}},
          color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.AssignClock\">Modelica.Clocked.RealSignals.Sampler.AssignClock</a>.
</p>
</html>"));
      end AssignClock;

      model AssignClockVectorized
        "Example of a AssignClockVectorized block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-54,-50},{-42,-38}})));
      Modelica.Clocked.RealSignals.NonPeriodic.UnitDelay unitDelay1
        annotation (Placement(transformation(extent={{-38,58},{-58,78}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{-58,28},{-38,48}})));
      Modelica.Blocks.Sources.Constant const(k=1)
        annotation (Placement(transformation(extent={{-92,22},{-72,42}})));
      Modelica.Clocked.RealSignals.Sampler.AssignClockVectorized
        assignClock1(n=2)
        annotation (Placement(transformation(extent={{-24,18},{-12,30}})));
      Modelica.Blocks.Math.Add add1
        annotation (Placement(transformation(extent={{-58,2},{-38,22}})));
      Modelica.Blocks.Sources.Constant const1(k=2)
        annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
      Modelica.Clocked.RealSignals.NonPeriodic.UnitDelay unitDelay2
        annotation (Placement(transformation(extent={{-38,-28},{-58,-8}})));
      equation
      connect(add.u2, const.y) annotation (Line(
          points={{-60,32},{-71,32}},
          color={0,0,127}));
      connect(unitDelay1.y, add.u1) annotation (Line(
          points={{-59,68},{-68,68},{-68,44},{-60,44}},
          color={0,0,127}));
      connect(periodicClock.y, assignClock1.clock) annotation (Line(
          points={{-41.4,-44},{-18,-44},{-18,16.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(const1.y, add1.u1) annotation (Line(
          points={{-71,0},{-68,0},{-68,18},{-60,18}},
          color={0,0,127}));
      connect(unitDelay2.y, add1.u2) annotation (Line(
          points={{-59,-18},{-66,-18},{-66,6},{-60,6}},
          color={0,0,127}));
      connect(add.y, assignClock1.u[1]) annotation (Line(
          points={{-37,38},{-32,38},{-32,23.4},{-25.2,23.4}},
          color={0,0,127}));
      connect(add1.y, assignClock1.u[2]) annotation (Line(
          points={{-37,12},{-32,12},{-32,24.6},{-25.2,24.6}},
          color={0,0,127}));
      connect(assignClock1.y[2], unitDelay2.u) annotation (Line(
          points={{-11.4,24.3},{-6,24.3},{-6,-18},{-36,-18}},
          color={0,0,127}));
      connect(assignClock1.y[1], unitDelay1.u) annotation (Line(
          points={{-11.4,23.7},{-6,23.7},{-6,68},{-36,68}},
          color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.AssignClockVectorized\">Modelica.Clocked.RealSignals.Sampler.AssignClockVectorized</a>.
</p>
</html>"));
      end AssignClockVectorized;

      model UpSample1 "Example of an UpSample block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-48,24},{-36,36}})));
      Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample upSample1
        annotation (Placement(transformation(extent={{-26,34},{-14,46}})));
      Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample upSample2(
          inferFactor=false, factor=3)
        annotation (Placement(transformation(extent={{-26,14},{-14,26}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{0,20},{20,40}})));
      equation
      connect(sine.y, sample.u) annotation (Line(
          points={{-59,30},{-49.2,30}},
          color={0,0,127}));
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-55.4,0},{-42,0},{-42,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample.y, upSample1.u) annotation (Line(
          points={{-35.4,30},{-32,30},{-32,40},{-27.2,40}},
          color={0,0,127}));
      connect(upSample2.u, sample.y) annotation (Line(
          points={{-27.2,20},{-32,20},{-32,30},{-35.4,30}},
          color={0,0,127}));
      connect(upSample2.y, add.u2) annotation (Line(
          points={{-13.4,20},{-8,20},{-8,24},{-2,24}},
          color={0,0,127}));
      connect(upSample1.y, add.u1) annotation (Line(
          points={{-13.4,40},{-8,40},{-8,36},{-2,36}},
          color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample\">Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample</a>.
</p>
</html>"));
      end UpSample1;

      model UpSample2
        "Example of an UpSample block for Real signals combined with FIR filter blocks"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                        sample
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
      connect(sine.y, sample.u) annotation (Line(
          points={{-59,30},{-49.2,30}},
          color={0,0,127}));
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-55.4,0},{-42,0},{-42,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
        connect(upSample.u, sample.y)
                                     annotation (Line(
          points={{-25.2,30},{-35.4,30}},
          color={0,0,127}));
        connect(sample.y, superSampleIpo.u) annotation (Line(
            points={{-35.4,30},{-32,30},{-32,-38},{10.8,-38}},
            color={0,0,127}));
        connect(upSample.y, FIR2.u) annotation (Line(
            points={{-11.4,30},{-8,30},{-8,-4},{4,-4}},
            color={0,0,127}));
        connect(FIR1.u, upSample.y) annotation (Line(
            points={{4,30},{-11.4,30}},
            color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=0.06),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample\">Modelica.Clocked.RealSignals.Sampler.Utilities.UpSample</a>.
</p>
</html>"));
      end UpSample2;

      model AssignClockToTriggerHold
        "Example of an AssignClockToTriggerHold block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-48,24},{-36,36}})));
      Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler
        annotation (Placement(transformation(extent={{10,40},{30,60}})));
      Modelica.Clocked.RealSignals.Sampler.Utilities.AssignClockToTriggerHold
        clockToTrigger
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      equation
      connect(sine.y, sample.u) annotation (Line(
          points={{-59,30},{-49.2,30}},
          color={0,0,127}));
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-55.4,0},{-42,0},{-42,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(triggeredSampler.u, sine.y) annotation (Line(
          points={{8,50},{-54,50},{-54,30},{-59,30}},
          color={0,0,127}));
      connect(sample.y, clockToTrigger.u) annotation (Line(
          points={{-35.4,30},{-22,30}},
          color={0,0,127}));
      connect(triggeredSampler.trigger, clockToTrigger.y) annotation (Line(
          points={{20,38.2},{20,30},{1,30}},
          color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.Utilities.AssignClockToTriggerHold\">Modelica.Clocked.RealSignals.Sampler.Utilities.AssignClockToTriggerHold</a>.
</p>
</html>"));
      end AssignClockToTriggerHold;

      model AssignClockToSquareWaveHold
        "Example of an AssignClockToSquareWaveHold block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-48,24},{-36,36}})));
      Modelica.Clocked.RealSignals.Sampler.Utilities.AssignClockToSquareWaveHold
        clockToSquareWave
        annotation (Placement(transformation(extent={{-24,20},{-4,40}})));
      equation
      connect(sine.y, sample.u) annotation (Line(
          points={{-59,30},{-49.2,30}},
          color={0,0,127}));
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-55.4,0},{-42,0},{-42,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample.y, clockToSquareWave.u) annotation (Line(
          points={{-35.4,30},{-26,30}},
          color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.Utilities.AssignClockToSquareWaveHold\">Modelica.Clocked.RealSignals.Sampler.Utilities.AssignClockToSquareWaveHold</a>.
</p>
</html>"));
      end AssignClockToSquareWaveHold;

      model UniformNoise "Example of a UniformNoise block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
      Modelica.Clocked.RealSignals.Sampler.Utilities.Internal.UniformNoise
        uniformNoise
        annotation (Placement(transformation(extent={{-26,20},{-6,40}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{-76,20},{-56,40}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample.y, uniformNoise.u) annotation (Line(
          points={{-33.4,30},{-28,30}},
          color={0,0,127}));
      connect(const.y, sample.u) annotation (Line(
          points={{-55,30},{-47.2,30}},
          color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=1.1),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.Sampler.Utilities.Internal.UniformNoise\">Modelica.Clocked.RealSignals.Sampler.Utilities.Internal.UniformNoise</a>.
</p>
</html>"));
      end UniformNoise;

      model FractionalDelay
        "Example of a FractionalDelay block for Real signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
        Modelica.Blocks.Sources.Sine sine(freqHz=2,
          offset=0.1,
          startTime=0)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.RealSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-48,24},{-36,36}})));
      Modelica.Clocked.RealSignals.NonPeriodic.FractionalDelay
        fractionalDelay(shift=3, resolution=2)
        annotation (Placement(transformation(extent={{-26,20},{-6,40}})));
      equation
      connect(sine.y, sample.u) annotation (Line(
          points={{-59,30},{-49.2,30}},
          color={0,0,127}));
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-55.4,0},{-42,0},{-42,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(fractionalDelay.u, sample.y) annotation (Line(
          points={{-28,30},{-35.4,30}},
          color={0,0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Example used to generate a figure for the documentation of block
<a href=\"Modelica.Clocked.RealSignals.NonPeriodic.FractionalDelay\">Modelica.Clocked.RealSignals.NonPeriodic.FractionalDelay</a>.
</p>
</html>"));
      end FractionalDelay;

      model TimeBasedStep
        "Example of using the clocked simulation time based Step source block"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;
      Modelica.Clocked.RealSignals.TimeBasedSources.Step
                                                    step(startTime=0.2)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      Modelica.Clocked.RealSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{-24,24},{-12,36}})));
      Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
        periodicClock1(period=0.1)
        annotation (Placement(transformation(extent={{-70,-18},{-58,-6}})));
      equation

      connect(step.y, assignClock1.u) annotation (Line(
          points={{-39,30},{-25.2,30}},
          color={0,0,127}));
      connect(periodicClock1.y, assignClock1.clock) annotation (Line(
          points={{-57.4,-12},{-18,-12},{-18,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                {{-100,-100},{100,100}})), Documentation(info="<html>
<p>
Example for block
<a href=\"Modelica.Clocked.RealSignals.TimeBasedSources.Step\">Modelica.Clocked.RealSignals.TimeBasedSources.Step</a>.
</p>
</html>"));
      end TimeBasedStep;

      model TickBasedStep
        "Example of using the clocked tick based Step source block"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;
      Modelica.Clocked.RealSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{-24,24},{-12,36}})));
      Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
        periodicClock1(period=0.1)
        annotation (Placement(transformation(extent={{-70,-18},{-58,-6}})));
      Modelica.Clocked.RealSignals.TickBasedSources.Step step(startTick=3)
        annotation (Placement(transformation(extent={{-66,20},{-46,40}})));
      equation

      connect(periodicClock1.y, assignClock1.clock) annotation (Line(
          points={{-57.4,-12},{-18,-12},{-18,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(step.y, assignClock1.u)       annotation (Line(
          points={{-45,30},{-25.2,30}},
          color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                {{-100,-100},{100,100}})), Documentation(info="<html>
<p>
Example for block
<a href=\"Modelica.Clocked.RealSignals.TickBasedSources.Step\">Modelica.Clocked.RealSignals.TickBasedSources.Step</a>.
</p>
</html>"));
      end TickBasedStep;

      model TimeBasedSine
        "Example of using the clocked time based Sine source block"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;
      Modelica.Clocked.RealSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{-24,24},{-12,36}})));
      Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
        periodicClock1(period=0.1)
        annotation (Placement(transformation(extent={{-70,-18},{-58,-6}})));
      Modelica.Clocked.RealSignals.TimeBasedSources.Sine
                                                    sine(freqHz=2)
        annotation (Placement(transformation(extent={{-66,20},{-46,40}})));
      equation

      connect(periodicClock1.y, assignClock1.clock) annotation (Line(
          points={{-57.4,-12},{-18,-12},{-18,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sine.y, assignClock1.u) annotation (Line(
          points={{-45,30},{-25.2,30}},
          color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                {{-100,-100},{100,100}})), Documentation(info="<html>
<p>
Example for block
<a href=\"Modelica.Clocked.RealSignals.TimeBasedSources.Sine\">Modelica.Clocked.RealSignals.TimeBasedSources.Sine</a>.
</p>
</html>"));
      end TimeBasedSine;

      model TickBasedSine
        "Example of using the clocked tick based Sine source block"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;
      Modelica.Clocked.RealSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{-24,24},{-12,36}})));
      Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
        periodicClock1(period=0.1)
        annotation (Placement(transformation(extent={{-70,-18},{-58,-6}})));
      Modelica.Clocked.RealSignals.TickBasedSources.Sine sine(
        periodTicks=10,
        periodOffset=2,
          startTick=4)
        annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
      Modelica.Blocks.Sources.Sine sineRef(
        freqHz=1,
        phase=1/5*(2*Modelica.Constants.pi),
        startTime=0.3)
        annotation (Placement(transformation(extent={{-72,58},{-52,78}})));
      equation

      connect(periodicClock1.y, assignClock1.clock) annotation (Line(
          points={{-57.4,-12},{-18,-12},{-18,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sine.y, assignClock1.u)       annotation (Line(
          points={{-51,30},{-25.2,30}},
          color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                {{-100,-100},{100,100}})), Documentation(info="<html>
<p>
Example for block
<a href=\"Modelica.Clocked.RealSignals.TickBasedSources.Step\">Modelica.Clocked.RealSignals.TickBasedSources.Step</a>.
</p>
</html>"));
      end TickBasedSine;

      model TimeBasedRamp
        "Example of using the clocked time based Ramp source block"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;
      Modelica.Clocked.RealSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{-24,24},{-12,36}})));
      Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
        periodicClock1(period=0.1)
        annotation (Placement(transformation(extent={{-70,-18},{-58,-6}})));
      Modelica.Clocked.RealSignals.TimeBasedSources.Ramp
                                                    ramp(duration=0.5)
        annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
      equation

      connect(periodicClock1.y, assignClock1.clock) annotation (Line(
          points={{-57.4,-12},{-18,-12},{-18,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(ramp.y, assignClock1.u) annotation (Line(
          points={{-51,30},{-25.2,30}},
          color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                {{-100,-100},{100,100}})), Documentation(info="<html>
<p>
Example for block
<a href=\"Modelica.Clocked.RealSignals.TimeBasedSources.Ramp\">Modelica.Clocked.RealSignals.TimeBasedSources.Ramp</a>.
</p>
</html>"));
      end TimeBasedRamp;

      model TickBasedRamp
        "Example of using the clocked tick based Ramp source block"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;
      Modelica.Clocked.RealSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{-24,24},{-12,36}})));
      Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
        periodicClock1(period=0.1)
        annotation (Placement(transformation(extent={{-70,-18},{-58,-6}})));
      Modelica.Clocked.RealSignals.TickBasedSources.Ramp ramp(
        height=1,
        durationTicks=3,
        startTick=2,
        offset=0)
        annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
      equation

      connect(periodicClock1.y, assignClock1.clock) annotation (Line(
          points={{-57.4,-12},{-18,-12},{-18,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(ramp.y, assignClock1.u)       annotation (Line(
          points={{-51,30},{-25.2,30}},
          color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                {{-100,-100},{100,100}})), Documentation(info="<html>
<p>
Example for block
<a href=\"Modelica.Clocked.RealSignals.TickBasedSources.Ramp\">Modelica.Clocked.RealSignals.TickBasedSources.Ramp</a>.
</p>
</html>"));
      end TickBasedRamp;
    annotation (Documentation(info="<html>
<p>
This package contains models that have been used to produce
the figures in the documentation of the
<a href=\"modelica://Modelica.Clocked.RealSignals\">Modelica.Clocked.RealSignals</a>
sub-library.
</p>
</html>"));
    end RealSignals;

    package IntegerSignals
      "Examples that are used for the documentation of the Modelica.Clocked.IntegerSignals sub-library"
      extends Modelica.Icons.ExamplesPackage;

      model Sample1 "Example of a Sample block for Integer signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
       extends Modelica.Icons.Example;
        Modelica.Clocked.IntegerSignals.Sampler.AssignClock
                                                             assignClock
          annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-42,-2},{-30,10}})));
      Modelica.Blocks.Sources.IntegerStep
                                   step(startTime=0.1)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Modelica.Clocked.IntegerSignals.Sampler.Sample sample
        annotation (Placement(transformation(extent={{-48,24},{-36,36}})));
      equation
        connect(periodicClock.y, assignClock.clock) annotation (Line(
            points={{-29.4,4},{-16,4},{-16,22.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
      connect(step.y, sample.u) annotation (Line(
          points={{-59,30},{-49.2,30}},
          color={255,127,0}));
      connect(sample.y, assignClock.u) annotation (Line(
          points={{-35.4,30},{-23.2,30}},
          color={255,127,0}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.IntegerSignals.Sampler.Sample\">Modelica.Clocked.IntegerSignals.Sampler.Sample</a>.
</p>
</html>"));
      end Sample1;

      model Sample2
        "Example of a Sample block for Integer signals with direct feed-through in the continuous-time and the clocked partition"
        import Modelica_Synchronous =
               Modelica.Clocked;
       extends Modelica.Icons.Example;
        Modelica.Clocked.IntegerSignals.Sampler.SampleClocked
                                                               sample1
          annotation (Placement(transformation(extent={{-60,24},{-48,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-76,-6},{-64,6}})));
      Modelica.Blocks.Sources.IntegerStep
                                   step(startTime=0.04)
        annotation (Placement(transformation(extent={{-96,20},{-76,40}})));
        Modelica.Clocked.IntegerSignals.Sampler.Hold
                                                      hold
          annotation (Placement(transformation(extent={{22,24},{34,36}})));
        Modelica.Clocked.IntegerSignals.Sampler.Sample
                                                        sample2
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
        connect(hold.u, sum2.y) annotation (Line(
            points={{20.8,30},{14.9,30}},
            color={255,127,0}));
        connect(hold.y, sample2.u) annotation (Line(
            points={{34.6,30},{50,30},{50,0},{7.2,0}},
            color={255,127,0}));
        connect(sample1.u, step.y) annotation (Line(
            points={{-61.2,30},{-75,30}},
            color={255,127,0}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}},
              grid={1,1}),           graphics), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.IntegerSignals.Sampler.Sample\">Modelica.Clocked.IntegerSignals.Sampler.Sample</a>.
</p>
</html>"),Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={1,1})));
      end Sample2;

      model SampleClocked
        "Example of a SampleClocked block for Integer signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.IntegerStep
                                     step(startTime=0.1, offset=1)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.IntegerSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
        connect(step.y, sample.u) annotation (Line(
            points={{-59,30},{-47.2,30}},
            color={255,127,0}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.IntegerSignals.Sampler.SampleClocked\">Modelica.Clocked.IntegerSignals.Sampler.SampleClocked</a>.
</p>
</html>"));
      end SampleClocked;

      model SampleVectorizedAndClocked
        "Example of a SampleVectorizedAndClocked block for Integer signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.IntegerStep
                                     step2(offset=1, startTime=0.04)
          annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
        Modelica.Clocked.IntegerSignals.Sampler.SampleVectorizedAndClocked
                                                        sample(n=2)
          annotation (Placement(transformation(extent={{-14,24},{-2,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-28,-6},{-16,6}})));
        Modelica.Blocks.Sources.IntegerStep
                                     step1(startTime=0.08)
          annotation (Placement(transformation(extent={{-80,-2},{-60,18}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-15.4,0},{-8,0},{-8,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
        connect(step1.y, sample.u[1]) annotation (Line(
            points={{-59,8},{-38,8},{-38,29.4},{-15.2,29.4}},
            color={255,127,0}));
        connect(step2.y, sample.u[2]) annotation (Line(
            points={{-59,40},{-38,40},{-38,30.6},{-15.2,30.6}},
            color={255,127,0}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.IntegerSignals.Sampler.SampleVectorizedAndClocked\">Modelica.Clocked.IntegerSignals.Sampler.SampleVectorizedAndClocked</a>.
</p>
</html>"));
      end SampleVectorizedAndClocked;

      model Hold "Example of a Hold block for Integer signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.IntegerTable table(table=[0,1; 0.05,2; 0.1,0; 0.15,-1;
              0.2,3])
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.IntegerSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-52,24},{-40,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
      Modelica.Clocked.IntegerSignals.Sampler.Hold
                                                    hold(y_start=-1)
        annotation (Placement(transformation(extent={{-8,24},{4,36}})));
      Modelica.Clocked.IntegerSignals.Sampler.ShiftSample
                                                           shiftSample(
          shiftCounter=2)
        annotation (Placement(transformation(extent={{-30,24},{-18,36}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-55.4,0},{-46,0},{-46,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
        connect(table.y, sample.u) annotation (Line(
            points={{-59,30},{-53.2,30}},
            color={255,127,0}));
        connect(sample.y, shiftSample.u) annotation (Line(
            points={{-39.4,30},{-31.2,30}},
            color={255,127,0}));
        connect(shiftSample.y, hold.u) annotation (Line(
            points={{-17.4,30},{-9.2,30}},
            color={255,127,0}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.IntegerSignals.Sampler.Hold\">Modelica.Clocked.IntegerSignals.Sampler.Hold</a>.
</p>
</html>"));
      end Hold;

      model SubSample "Example of a SubSample block for Integer signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.IntegerSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
      Modelica.Clocked.IntegerSignals.Sampler.SubSample
                                                         subSample(
          inferFactor=false, factor=3)
        annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
        Modelica.Blocks.Sources.IntegerTable table(table=[0,1; 0.05,2; 0.1,0; 0.15,-1;
              0.2,3])
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
        connect(table.y, sample.u) annotation (Line(
            points={{-59,30},{-47.2,30}},
            color={255,127,0}));
        connect(sample.y, subSample.u) annotation (Line(
            points={{-33.4,30},{-23.2,30}},
            color={255,127,0}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.IntegerSignals.Sampler.SubSample\">Modelica.Clocked.IntegerSignals.Sampler.SubSample</a>.
</p>
</html>"));
      end SubSample;

      model SuperSample "Example of a SuperSample block for Integer signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.IntegerSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
      Modelica.Clocked.IntegerSignals.Sampler.SuperSample superSample(inferFactor=false,
            factor=3)
        annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
        Modelica.Blocks.Sources.IntegerTable table(table=[0,1; 0.05,2; 0.1,0; 0.15,-1;
              0.2,3])
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(table.y, sample.u) annotation (Line(
          points={{-59,30},{-47.2,30}},
          color={255,127,0}));
      connect(sample.y, superSample.u) annotation (Line(
          points={{-33.4,30},{-23.2,30}},
          color={255,127,0}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.IntegerSignals.Sampler.SuperSample\">Modelica.Clocked.IntegerSignals.Sampler.SuperSample</a>.
</p>
</html>"));
      end SuperSample;

      model ShiftSample "Example of a ShiftSample block for Integer signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.IntegerSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
        Modelica.Clocked.IntegerSignals.Sampler.ShiftSample shiftSample1(
            shiftCounter=4, resolution=3)
          annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
        Modelica.Blocks.Sources.IntegerTable table(table=[0,1; 0.025,2; 0.05,
            0; 0.075,-1; 0.1,3])
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(table.y, sample.u) annotation (Line(
          points={{-59,30},{-47.2,30}},
          color={255,127,0}));
      connect(sample.y, shiftSample1.u) annotation (Line(
          points={{-33.4,30},{-23.2,30}},
          color={255,127,0}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.IntegerSignals.Sampler.ShiftSample\">Modelica.Clocked.IntegerSignals.Sampler.ShiftSample</a>.
</p>
</html>"));
      end ShiftSample;

      model BackSample "Example of a BackSample block for Integer signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.IntegerSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
        Modelica.Clocked.IntegerSignals.Sampler.ShiftSample shiftSample1(
            shiftCounter=4, resolution=3)
          annotation (Placement(transformation(extent={{-18,24},{-6,36}})));
      Modelica.Clocked.IntegerSignals.Sampler.BackSample backSample1(
        backCounter=4,
        resolution=3,
        y_start=1)
        annotation (Placement(transformation(extent={{14,24},{26,36}})));
        Modelica.Blocks.Sources.IntegerTable table(table=[0,1; 0.025,2; 0.05,
            0; 0.075,-1; 0.1,3])
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample.y, shiftSample1.u) annotation (Line(
          points={{-33.4,30},{-19.2,30}},
          color={255,127,0}));
      connect(shiftSample1.y, backSample1.u) annotation (Line(
          points={{-5.4,30},{12.8,30}},
          color={255,127,0}));
      connect(table.y, sample.u) annotation (Line(
          points={{-59,30},{-47.2,30}},
          color={255,127,0}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.IntegerSignals.Sampler.BackSample\">Modelica.Clocked.IntegerSignals.Sampler.BackSample</a>.
</p>
</html>"));
      end BackSample;

      model AssignClock "Example of an AssignClock block for Integer signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-42,0},{-30,12}})));
      Modelica.Clocked.IntegerSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{-26,22},{-14,34}})));
      Modelica.Clocked.IntegerSignals.NonPeriodic.UnitDelay unitDelay1
        annotation (Placement(transformation(extent={{-38,48},{-58,68}})));
      Modelica.Blocks.Sources.IntegerConstant
                                       const(k=1)
        annotation (Placement(transformation(extent={{-96,12},{-76,32}})));
      Modelica.Blocks.MathInteger.Sum sum(nu=2)
        annotation (Placement(transformation(extent={{-54,22},{-42,34}})));
      equation
      connect(periodicClock.y, assignClock1.clock) annotation (Line(
          points={{-29.4,6},{-20,6},{-20,20.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(assignClock1.y, unitDelay1.u) annotation (Line(
          points={{-13.4,28},{-2,28},{-2,58},{-36,58}},
          color={0,0,127}));
      connect(unitDelay1.y, sum.u[1]) annotation (Line(
          points={{-59,58},{-70,58},{-70,30.1},{-54,30.1}},
          color={255,127,0}));
      connect(const.y, sum.u[2]) annotation (Line(
          points={{-75,22},{-62,22},{-62,25.9},{-54,25.9}},
          color={255,127,0}));
      connect(sum.y, assignClock1.u) annotation (Line(
          points={{-41.1,28},{-27.2,28}},
          color={255,127,0}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.IntegerSignals.Sampler.AssignClock\">Modelica.Clocked.IntegerSignals.Sampler.AssignClock</a>.
</p>
</html>"));
      end AssignClock;

      model AssignClockVectorized
        "Example of an AssignClockVectorized block for Integer signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-54,-50},{-42,-38}})));
      Modelica.Clocked.IntegerSignals.NonPeriodic.UnitDelay unitDelay1
        annotation (Placement(transformation(extent={{-38,58},{-58,78}})));
      Modelica.Blocks.Sources.IntegerConstant
                                       const(k=1)
        annotation (Placement(transformation(extent={{-92,22},{-72,42}})));
      Modelica.Clocked.IntegerSignals.Sampler.AssignClockVectorized
        assignClock1(n=2)
        annotation (Placement(transformation(extent={{-24,18},{-12,30}})));
      Modelica.Blocks.Sources.IntegerConstant
                                       const1(k=2)
        annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
      Modelica.Clocked.IntegerSignals.NonPeriodic.UnitDelay unitDelay2
        annotation (Placement(transformation(extent={{-38,-28},{-58,-8}})));
      Modelica.Blocks.MathInteger.Sum sum1(nu=2)
        annotation (Placement(transformation(extent={{-54,32},{-42,44}})));
      Modelica.Blocks.MathInteger.Sum sum2(nu=2)
        annotation (Placement(transformation(extent={{-54,4},{-42,16}})));
      equation
      connect(periodicClock.y, assignClock1.clock) annotation (Line(
          points={{-41.4,-44},{-18,-44},{-18,16.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(assignClock1.y[1], unitDelay1.u) annotation (Line(
          points={{-11.4,23.7},{4,23.7},{4,68},{-36,68}},
          color={255,127,0}));
      connect(assignClock1.y[2], unitDelay2.u) annotation (Line(
          points={{-11.4,24.3},{4,24.3},{4,-18},{-36,-18}},
          color={255,127,0}));
      connect(unitDelay1.y, sum1.u[1]) annotation (Line(
          points={{-59,68},{-64,68},{-64,40.1},{-54,40.1}},
          color={255,127,0}));
      connect(const.y, sum1.u[2]) annotation (Line(
          points={{-71,32},{-62,32},{-62,35.9},{-54,35.9}},
          color={255,127,0}));
      connect(const1.y, sum2.u[1]) annotation (Line(
          points={{-71,0},{-68,0},{-68,12},{-54,12.1}},
          color={255,127,0}));
      connect(unitDelay2.y, sum2.u[2]) annotation (Line(
          points={{-59,-18},{-62,-18},{-62,8},{-58,8},{-58,8},{-54,7.9}},
          color={255,127,0}));
      connect(sum1.y, assignClock1.u[1]) annotation (Line(
          points={{-41.1,38},{-34,38},{-34,23.4},{-25.2,23.4}},
          color={255,127,0}));
      connect(sum2.y, assignClock1.u[2]) annotation (Line(
          points={{-41.1,10},{-34,10},{-34,24.6},{-25.2,24.6}},
          color={255,127,0}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.IntegerSignals.Sampler.AssignClockVectorized\">Modelica.Clocked.IntegerSignals.Sampler.AssignClockVectorized</a>.
</p>
</html>"));
      end AssignClockVectorized;

      model UpSample "Example of an UpSample block for Integer signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
        Modelica.Clocked.IntegerSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-48,24},{-36,36}})));
      Modelica.Clocked.IntegerSignals.Sampler.Utilities.UpSample upSample1
        annotation (Placement(transformation(extent={{-26,34},{-14,46}})));
      Modelica.Clocked.IntegerSignals.Sampler.Utilities.UpSample upSample2(
          inferFactor=false, factor=3)
        annotation (Placement(transformation(extent={{-26,14},{-14,26}})));
        Modelica.Blocks.Sources.IntegerTable table(table=[0,1; 0.025,2; 0.05,
            0; 0.075,-1; 0.1,3])
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Modelica.Blocks.MathInteger.Sum sum(nu=2)
        annotation (Placement(transformation(extent={{2,24},{14,36}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-55.4,0},{-42,0},{-42,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(table.y, sample.u) annotation (Line(
          points={{-59,30},{-49.2,30}},
          color={255,127,0}));
      connect(sample.y, upSample1.u) annotation (Line(
          points={{-35.4,30},{-32,30},{-32,40},{-27.2,40}},
          color={255,127,0}));
      connect(sample.y, upSample2.u) annotation (Line(
          points={{-35.4,30},{-32,30},{-32,20},{-27.2,20}},
          color={255,127,0}));
      connect(upSample1.y, sum.u[1]) annotation (Line(
          points={{-13.4,40},{-6,40},{-6,32.1},{2,32.1}},
          color={255,127,0}));
      connect(upSample2.y, sum.u[2]) annotation (Line(
          points={{-13.4,20},{-6,20},{-6,27.9},{2,27.9}},
          color={255,127,0}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.IntegerSignals.Sampler.Utilities.UpSample\">Modelica.Clocked.IntegerSignals.Sampler.Utilities.UpSample</a>.
</p>
</html>"));
      end UpSample;

      model TimeBasedStep
        "Example of using the clocked simulation time based Integer Step source block"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.IntegerSignals.TimeBasedSources.Step step(
          height=3,
          offset=1,
          startTime=0.2)
          annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
        periodicClock1(period=0.1)
        annotation (Placement(transformation(extent={{-60,-8},{-48,4}})));
        Modelica.Clocked.IntegerSignals.Sampler.AssignClock assignClock1
          annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
      equation
        connect(step.y, assignClock1.u) annotation (Line(
            points={{-39,30},{-23.2,30}},
            color={255,127,0}));
        connect(periodicClock1.y, assignClock1.clock) annotation (Line(
            points={{-47.4,-2},{-16,-2},{-16,22.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=1.0),
        Documentation(info="<html>
<p>
Example for block
<a href=\"Modelica.Clocked.IntegerSignals.TimeBasedSources.Step\">Modelica.Clocked.IntegerSignals.TimeBasedSources.Step</a>.
</p>
</html>"));
      end TimeBasedStep;

      model TickBasedStep
        "Example of using the clocked simulation tick/sample based Integer Step source block"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

      Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
        periodicClock1(period=0.1)
        annotation (Placement(transformation(extent={{-60,-8},{-48,4}})));
        Modelica.Clocked.IntegerSignals.Sampler.AssignClock assignClock1
          annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
      Modelica.Clocked.IntegerSignals.TickBasedSources.Step step(
        height=3,
        offset=1,
          startTick=3)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      equation
        connect(periodicClock1.y, assignClock1.clock) annotation (Line(
            points={{-47.4,-2},{-16,-2},{-16,22.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
      connect(step.y, assignClock1.u) annotation (Line(
          points={{-39,30},{-23.2,30}},
          color={255,127,0}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=1.0),
        Documentation(info="<html>
<p>
Example for block
<a href=\"Modelica.Clocked.IntegerSignals.TickBasedSources.Step\">Modelica.Clocked.IntegerSignals.TickBasedSources.Step</a>.
</p>
</html>"));
      end TickBasedStep;
    annotation (Documentation(info="<html>
<p>
This package contains models that have been used to produce
the figures in the documentation of the
<a href=\"modelica://Modelica.Clocked.IntegerSignals\">Modelica.Clocked.IntegerSignals</a>
sub-library.
</p>
</html>"));
    end IntegerSignals;

    package BooleanSignals
      "Examples that are used for the documentation of the Modelica.Clocked.BooleanSignals sub-library"
      extends Modelica.Icons.ExamplesPackage;

      model Sample1 "Example of a Sample block for Boolean signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
       extends Modelica.Icons.Example;
        Modelica.Clocked.BooleanSignals.Sampler.AssignClock
                                                             assignClock
          annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-42,-2},{-30,10}})));
      Modelica.Blocks.Sources.BooleanStep
                                   step(startTime=0.1)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Modelica.Clocked.BooleanSignals.Sampler.Sample sample
        annotation (Placement(transformation(extent={{-48,24},{-36,36}})));
      equation
        connect(periodicClock.y, assignClock.clock) annotation (Line(
            points={{-29.4,4},{-16,4},{-16,22.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
      connect(step.y, sample.u) annotation (Line(
          points={{-59,30},{-49.2,30}},
          color={255,0,255}));
      connect(sample.y, assignClock.u) annotation (Line(
          points={{-35.4,30},{-23.2,30}},
          color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.BooleanSignals.Sampler.Sample\">Modelica.Clocked.BooleanSignals.Sampler.Sample</a>.
</p>
</html>"));
      end Sample1;

      model Sample2
        "Example of a Sample block for Boolean signals with direct feed-through in the continuous-time and the clocked partition"
        import Modelica_Synchronous =
               Modelica.Clocked;
       extends Modelica.Icons.Example;
        Modelica.Clocked.BooleanSignals.Sampler.SampleClocked
                                                               sample1
          annotation (Placement(transformation(extent={{-60,24},{-48,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-76,-6},{-64,6}})));
      Modelica.Blocks.Sources.BooleanStep
                                   step(startTime=0.04)
        annotation (Placement(transformation(extent={{-96,20},{-76,40}})));
        Modelica.Clocked.BooleanSignals.Sampler.Hold
                                                      hold
          annotation (Placement(transformation(extent={{22,24},{34,36}})));
        Modelica.Clocked.BooleanSignals.Sampler.Sample
                                                        sample2
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
      connect(hold.y, sample2.u) annotation (Line(
          points={{34.6,30},{39,30},{39,0},{7.2,0}},
          color={255,0,255}));
      connect(sample2.y, xor.u2) annotation (Line(
          points={{-6.6,0},{-47,0},{-47,22},{-41,22}},
          color={255,0,255}));
      connect(xor.u1, sample1.y) annotation (Line(
          points={{-41,30},{-47.4,30}},
          color={255,0,255}));
      connect(hold.u, xor1.y) annotation (Line(
          points={{20.8,30},{17.4,30},{17.4,31},{15,31}},
          color={255,0,255}));
      connect(xor1.u1, integerConstant.y) annotation (Line(
          points={{-8,31},{-8,45.5},{-17,45.5},{-17,61}},
          color={255,0,255}));
      connect(xor1.u2, xor.y) annotation (Line(
          points={{-8,23},{-13,23},{-13,30},{-18,30}},
          color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}},
              grid={1,1}),           graphics), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.BooleanSignals.Sampler.Sample\">Modelica.Clocked.BooleanSignals.Sampler.Sample</a>.
</p>
</html>"),Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}},
              grid={1,1})));
      end Sample2;

      model SampleClocked
        "Example of a SampleClocked block for Boolean signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.BooleanStep
                                     step(startTime=0.1)
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.BooleanSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample.u, step.y) annotation (Line(
          points={{-47.2,30},{-59,30}},
          color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.BooleanSignals.Sampler.SampleClocked\">Modelica.Clocked.BooleanSignals.Sampler.SampleClocked</a>.
</p>
</html>"));
      end SampleClocked;

      model SampleVectorizedAndClocked
        "Example of a SampleVectorizedAndClocked block for Boolean signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.BooleanStep
                                     step2(startTime=0.04)
          annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
        Modelica.Clocked.BooleanSignals.Sampler.SampleVectorizedAndClocked
                                                        sample(n=2)
          annotation (Placement(transformation(extent={{-14,24},{-2,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-28,-6},{-16,6}})));
        Modelica.Blocks.Sources.BooleanStep
                                     step1(startTime=0.08)
          annotation (Placement(transformation(extent={{-80,-2},{-60,18}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-15.4,0},{-8,0},{-8,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
        connect(sample.u[1], step2.y) annotation (Line(
            points={{-15.2,29.4},{-36,29.4},{-36,40},{-59,40}},
            color={255,0,255}));
        connect(step1.y, sample.u[2]) annotation (Line(
            points={{-59,8},{-38,8},{-38,30.6},{-15.2,30.6}},
            color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.BooleanSignals.Sampler.SampleVectorizedAndClocked\">Modelica.Clocked.BooleanSignals.Sampler.SampleVectorizedAndClocked</a>.
</p>
</html>"));
      end SampleVectorizedAndClocked;

      model Hold "Example of a Hold block for Boolean signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Blocks.Sources.BooleanTable table(table={0.05,0.15})
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Modelica.Clocked.BooleanSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-52,24},{-40,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
      Modelica.Clocked.BooleanSignals.Sampler.Hold
                                                    hold(y_start=false)
        annotation (Placement(transformation(extent={{-8,24},{4,36}})));
      Modelica.Clocked.BooleanSignals.Sampler.ShiftSample
                                                           shiftSample(
          shiftCounter=2)
        annotation (Placement(transformation(extent={{-30,24},{-18,36}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-55.4,0},{-46,0},{-46,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
        connect(table.y, sample.u) annotation (Line(
            points={{-59,30},{-53.2,30}},
            color={255,127,0}));
      connect(shiftSample.u, sample.y) annotation (Line(
          points={{-31.2,30},{-39.4,30}},
          color={255,0,255}));
      connect(hold.u, shiftSample.y) annotation (Line(
          points={{-9.2,30},{-17.4,30}},
          color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.BooleanSignals.Sampler.Hold\">Modelica.Clocked.BooleanSignals.Sampler.Hold</a>.
</p>
</html>"));
      end Hold;

      model SubSample "Example of a SubSample block for Boolean signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.BooleanSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
      Modelica.Clocked.BooleanSignals.Sampler.SubSample
                                                         subSample(
          inferFactor=false, factor=3)
        annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
        Modelica.Blocks.Sources.BooleanTable table(table={0.05,0.15})
          annotation (Placement(transformation(extent={{-76,20},{-56,40}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample.u, table.y) annotation (Line(
          points={{-47.2,30},{-55,30}},
          color={255,0,255}));
      connect(subSample.u, sample.y) annotation (Line(
          points={{-23.2,30},{-33.4,30}},
          color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.BooleanSignals.Sampler.SubSample\">Modelica.Clocked.BooleanSignals.Sampler.SubSample</a>.
</p>
</html>"));
      end SubSample;

      model SuperSample "Example of a SuperSample block for Boolean signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.BooleanSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
      Modelica.Clocked.BooleanSignals.Sampler.SuperSample superSample(inferFactor=false,
            factor=3)
        annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
        Modelica.Blocks.Sources.BooleanTable table(table={0.05,0.15})
          annotation (Placement(transformation(extent={{-78,20},{-58,40}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(table.y, sample.u) annotation (Line(
          points={{-57,30},{-47.2,30}},
          color={255,0,255}));
      connect(superSample.u, sample.y) annotation (Line(
          points={{-23.2,30},{-33.4,30}},
          color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.2),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.BooleanSignals.Sampler.SuperSample\">Modelica.Clocked.BooleanSignals.Sampler.SuperSample</a>.
</p>
</html>"));
      end SuperSample;

      model ShiftSample "Example of a ShiftSample block for Boolean signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.BooleanSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
        Modelica.Clocked.BooleanSignals.Sampler.ShiftSample shiftSample1(
            shiftCounter=4, resolution=3)
          annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
        Modelica.Blocks.Sources.BooleanTable table(table={0.05,0.15})
          annotation (Placement(transformation(extent={{-78,20},{-58,40}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample.u, table.y) annotation (Line(
          points={{-47.2,30},{-57,30}},
          color={255,0,255}));
      connect(shiftSample1.u, sample.y) annotation (Line(
          points={{-23.2,30},{-33.4,30}},
          color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.BooleanSignals.Sampler.ShiftSample\">Modelica.Clocked.BooleanSignals.Sampler.ShiftSample</a>.
</p>
</html>"));
      end ShiftSample;

      model BackSample "Example of a BackSample block for Boolean signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.BooleanSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-46,24},{-34,36}})));
        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-62,-6},{-50,6}})));
        Modelica.Clocked.BooleanSignals.Sampler.ShiftSample shiftSample1(
            shiftCounter=4, resolution=3)
          annotation (Placement(transformation(extent={{-18,24},{-6,36}})));
      Modelica.Clocked.BooleanSignals.Sampler.BackSample backSample1(
        backCounter=4,
        resolution=3,
        y_start=true)
        annotation (Placement(transformation(extent={{14,24},{26,36}})));
        Modelica.Blocks.Sources.BooleanTable table(table={0.05,0.15})
          annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-49.4,0},{-40,0},{-40,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(sample.u, table.y) annotation (Line(
          points={{-47.2,30},{-59,30}},
          color={255,0,255}));
      connect(shiftSample1.u, sample.y) annotation (Line(
          points={{-19.2,30},{-33.4,30}},
          color={255,0,255}));
      connect(backSample1.u, shiftSample1.y) annotation (Line(
          points={{12.8,30},{-5.4,30}},
          color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.BooleanSignals.Sampler.BackSample\">Modelica.Clocked.BooleanSignals.Sampler.BackSample</a>.
</p>
</html>"));
      end BackSample;

      model AssignClock "Example of an AssignClock block for Boolean signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-42,0},{-30,12}})));
      Modelica.Clocked.BooleanSignals.Sampler.AssignClock assignClock1
        annotation (Placement(transformation(extent={{-26,22},{-14,34}})));
      Modelica.Clocked.BooleanSignals.NonPeriodic.UnitDelay unitDelay1
        annotation (Placement(transformation(extent={{-38,48},{-58,68}})));
      Modelica.Blocks.Logical.Xor xor
        annotation (Placement(transformation(extent={{-59,18},{-39,38}})));
        Modelica.Blocks.Sources.BooleanConstant integerConstant(k=true)
          annotation (Placement(transformation(extent={{-96,3},{-76,23}})));
      equation
      connect(periodicClock.y, assignClock1.clock) annotation (Line(
          points={{-29.4,6},{-20,6},{-20,20.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(assignClock1.y, unitDelay1.u) annotation (Line(
          points={{-13.4,28},{-2,28},{-2,58},{-36,58}},
          color={0,0,127}));
      connect(assignClock1.u, xor.y) annotation (Line(
          points={{-27.2,28},{-38,28}},
          color={255,0,255}));
      connect(integerConstant.y, xor.u2) annotation (Line(
          points={{-75,13},{-68.5,13},{-68.5,20},{-61,20}},
          color={255,0,255}));
      connect(unitDelay1.y, xor.u1) annotation (Line(
          points={{-59,58},{-70,58},{-70,28},{-61,28}},
          color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.BooleanSignals.Sampler.AssignClock\">Modelica.Clocked.BooleanSignals.Sampler.AssignClock</a>.
</p>
</html>"));
      end AssignClock;

      model AssignClockVectorized
        "Example of an AssignClockVectorized block for Boolean signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-54,-50},{-42,-38}})));
      Modelica.Clocked.BooleanSignals.NonPeriodic.UnitDelay unitDelay1
        annotation (Placement(transformation(extent={{-38,58},{-58,78}})));
      Modelica.Clocked.BooleanSignals.Sampler.AssignClockVectorized
        assignClock1(n=2)
        annotation (Placement(transformation(extent={{-24,18},{-12,30}})));
      Modelica.Clocked.BooleanSignals.NonPeriodic.UnitDelay unitDelay2(y_start=
            true)
        annotation (Placement(transformation(extent={{-38,-28},{-58,-8}})));
      Modelica.Blocks.Logical.Xor xor
        annotation (Placement(transformation(extent={{-57,28},{-37,48}})));
        Modelica.Blocks.Sources.BooleanConstant integerConstant(k=true)
          annotation (Placement(transformation(extent={{-92,21},{-72,41}})));
      Modelica.Blocks.Logical.Xor xor1
        annotation (Placement(transformation(extent={{-57,2},{-37,22}})));
        Modelica.Blocks.Sources.BooleanConstant integerConstant1(k=true)
          annotation (Placement(transformation(extent={{-92,-9},{-72,11}})));
      equation
      connect(periodicClock.y, assignClock1.clock) annotation (Line(
          points={{-41.4,-44},{-18,-44},{-18,16.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(xor.u1, unitDelay1.y) annotation (Line(
          points={{-59,38},{-64,38},{-64,68},{-59,68}},
          color={255,0,255}));
      connect(xor.u2, integerConstant.y) annotation (Line(
          points={{-59,30},{-65,30},{-65,31},{-71,31}},
          color={255,0,255}));
      connect(xor1.u1, integerConstant1.y) annotation (Line(
          points={{-59,12},{-66,12},{-66,1},{-71,1}},
          color={255,0,255}));
      connect(unitDelay2.y, xor1.u2) annotation (Line(
          points={{-59,-18},{-64,-18},{-64,4},{-59,4}},
          color={255,0,255}));
      connect(xor.y, assignClock1.u[1]) annotation (Line(
          points={{-36,38},{-32,38},{-32,23.4},{-25.2,23.4}},
          color={255,0,255}));
      connect(xor1.y, assignClock1.u[2]) annotation (Line(
          points={{-36,12},{-32,12},{-32,24.6},{-25.2,24.6}},
          color={255,0,255}));
      connect(assignClock1.y[1], unitDelay1.u) annotation (Line(
          points={{-11.4,23.7},{-2,23.7},{-2,68},{-36,68}},
          color={255,0,255}));
      connect(assignClock1.y[2], unitDelay2.u) annotation (Line(
          points={{-11.4,24.3},{-2,24.3},{-2,-18},{-36,-18}},
          color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.BooleanSignals.Sampler.AssignClockVectorized\">Modelica.Clocked.BooleanSignals.Sampler.AssignClockVectorized</a>.
</p>
</html>"));
      end AssignClockVectorized;

      model UpSample "Example of an UpSample block for Boolean signals"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.ClockSignals.Clocks.PeriodicExactClock periodicClock(
            factor=20, resolution=Modelica.Clocked.Types.Resolution.ms)
          annotation (Placement(transformation(extent={{-68,-6},{-56,6}})));
        Modelica.Clocked.BooleanSignals.Sampler.SampleClocked
                                                        sample
          annotation (Placement(transformation(extent={{-48,24},{-36,36}})));
      Modelica.Clocked.BooleanSignals.Sampler.Utilities.UpSample upSample1
        annotation (Placement(transformation(extent={{-26,34},{-14,46}})));
      Modelica.Clocked.BooleanSignals.Sampler.Utilities.UpSample upSample2(
          inferFactor=false, factor=3)
        annotation (Placement(transformation(extent={{-26,14},{-14,26}})));
        Modelica.Blocks.Sources.BooleanTable table1(table={0.05,0.15})
          annotation (Placement(transformation(extent={{-82,20},{-62,40}})));
      Modelica.Blocks.Logical.And and1
        annotation (Placement(transformation(extent={{0,20},{20,40}})));
      equation
      connect(periodicClock.y, sample.clock) annotation (Line(
          points={{-55.4,0},{-42,0},{-42,22.8}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5));
      connect(table1.y, sample.u) annotation (Line(
          points={{-61,30},{-49.2,30}},
          color={255,0,255}));
      connect(upSample1.u, sample.y) annotation (Line(
          points={{-27.2,40},{-30,40},{-30,30},{-35.4,30}},
          color={255,0,255}));
      connect(upSample2.u, sample.y) annotation (Line(
          points={{-27.2,20},{-30,20},{-30,30},{-35.4,30}},
          color={255,0,255}));
      connect(upSample1.y, and1.u1) annotation (Line(
          points={{-13.4,40},{-8,40},{-8,30},{-2,30}},
          color={255,0,255}));
      connect(upSample2.y, and1.u2) annotation (Line(
          points={{-13.4,20},{-8,20},{-8,22},{-2,22}},
          color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}),   graphics), experiment(StopTime=0.09),
        Documentation(info="<html>
<p>
Elementary example for the documentation of block
<a href=\"Modelica.Clocked.BooleanSignals.Sampler.Utilities.UpSample\">Modelica.Clocked.BooleanSignals.Sampler.Utilities.UpSample</a>.
</p>
</html>"));
      end UpSample;

      model TimeBasedStep
        "Example of using the clocked simulation time based Boolean Step source block"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.BooleanSignals.TimeBasedSources.Step step(
          startTime=0.2)
          annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
        periodicClock1(period=0.1)
        annotation (Placement(transformation(extent={{-60,-8},{-48,4}})));
        Modelica.Clocked.BooleanSignals.Sampler.AssignClock assignClock1
          annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
      equation
        connect(periodicClock1.y, assignClock1.clock) annotation (Line(
            points={{-47.4,-2},{-16,-2},{-16,22.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
        connect(step.y, assignClock1.u) annotation (Line(
            points={{-39,30},{-23.2,30}},
            color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=1.0),
        Documentation(info="<html>
<p>
Example for block
<a href=\"Modelica.Clocked.BooleanSignals.TimeBasedSources.Step\">Modelica.Clocked.BooleanSignals.TimeBasedSources.Step</a>.
</p>
</html>"));
      end TimeBasedStep;

      model TickBasedStep
        "Example of using the clocked simulation tick/sample based Boolean Step source block"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

      Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
        periodicClock1(period=0.1)
        annotation (Placement(transformation(extent={{-60,-8},{-48,4}})));
        Modelica.Clocked.BooleanSignals.Sampler.AssignClock assignClock1
          annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
      Modelica.Clocked.BooleanSignals.TickBasedSources.Step step(startTick=
              3)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      equation
        connect(periodicClock1.y, assignClock1.clock) annotation (Line(
            points={{-47.4,-2},{-16,-2},{-16,22.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
        connect(assignClock1.u, step.y) annotation (Line(
            points={{-23.2,30},{-39,30}},
            color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=1.0),
        Documentation(info="<html>
<p>
Example for block
<a href=\"Modelica.Clocked.BooleanSignals.TickBasedSources.Step\">Modelica.Clocked.BooleanSignals.TickBasedSources.Step</a>.
</p>
</html>"));
      end TickBasedStep;

      model TimeBasedPulse
        "Example of using the clocked simulation time based Boolean Pulse source block"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

        Modelica.Clocked.BooleanSignals.TimeBasedSources.Pulse pulse(
          width=50,
          period=0.4,
          startTime=0.1)
          annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
        periodicClock1(period=0.1)
        annotation (Placement(transformation(extent={{-60,-8},{-48,4}})));
        Modelica.Clocked.BooleanSignals.Sampler.AssignClock assignClock1
          annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
      equation
        connect(periodicClock1.y, assignClock1.clock) annotation (Line(
            points={{-47.4,-2},{-16,-2},{-16,22.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
        connect(pulse.y, assignClock1.u) annotation (Line(
            points={{-39,30},{-23.2,30}},
            color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=1.0),
        Documentation(info="<html>
<p>
Example for block
<a href=\"Modelica.Clocked.BooleanSignals.TimeBasedSources.Pulse\">Modelica.Clocked.BooleanSignals.TimeBasedSources.Pulse</a>.
</p>
</html>"));
      end TimeBasedPulse;

      model TickBasedPulse
        "Example of using the clock tick based Boolean Pulse source block"
        import Modelica_Synchronous =
               Modelica.Clocked;
         extends Modelica.Icons.Example;

      Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock
        periodicClock1(period=0.1)
        annotation (Placement(transformation(extent={{-60,-8},{-48,4}})));
        Modelica.Clocked.BooleanSignals.Sampler.AssignClock assignClock1
          annotation (Placement(transformation(extent={{-22,24},{-10,36}})));
        Modelica.Clocked.BooleanSignals.TickBasedSources.Pulse pulse(
          widthTicks=2,
          periodTicks=4,
          startTick=2)
          annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      equation
        connect(periodicClock1.y, assignClock1.clock) annotation (Line(
            points={{-47.4,-2},{-16,-2},{-16,22.8}},
            color={175,175,175},
            pattern=LinePattern.Dot,
            thickness=0.5));
        connect(pulse.y, assignClock1.u) annotation (Line(
            points={{-39,30},{-23.2,30}},
            color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}})), experiment(StopTime=1.0),
        Documentation(info="<html>
<p>
Example for block
<a href=\"Modelica.Clocked.BooleanSignals.TickBasedSources.Pulse\">Modelica.Clocked.BooleanSignals.TickBasedSources.Pulse</a>.
</p>
</html>"));
      end TickBasedPulse;
    annotation (Documentation(info="<html>
<p>
This package contains models that have been used to produce
the figures in the documentation of the
<a href=\"modelica://Modelica.Clocked.BooleanSignals\">Modelica.Clocked.BooleanSignals</a>
sub-library.
</p>
</html>"));
    end BooleanSignals;
  annotation (Documentation(info="<html>
<p>
This package contains models that have been used to produce
the figures in the documentation of the various blocks of
the Modelica_Synchronous library. As a result, all the examples
shown in the block documentations can be easily inspected and
simulated.
</p>
</html>"));
  end Elementary;
annotation (Documentation(info="<html>
<p>
This package contains examples to demonstrate the usage of package Modelica.Clocked.
</p>
</html>"));
end Examples;