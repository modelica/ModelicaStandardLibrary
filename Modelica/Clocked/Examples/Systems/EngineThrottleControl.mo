within Modelica.Clocked.Examples.Systems;
model EngineThrottleControl
  "Closed-loop throttle control synchronized to the crankshaft angle of an
   internal combustion engine"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Step speedRef(
    startTime = 5,
    offset = 207.34,
    height = 103.67)
    annotation (Placement(transformation(extent = {{-90,6},{-70,26}})));
  Utilities.ComponentsThrottleControl.SpeedControl speedControl
    annotation (Placement(transformation(extent = {{-32,-5},{0,25}})));
  RealSignals.Sampler.Sample sample1
    annotation (Placement(transformation(extent = {{-60,9},{-46,23}})));
  RealSignals.Sampler.Hold hold1(y_start=8.9)
    annotation (Placement(transformation(extent={{8,4},{20,16}})));
  Utilities.ComponentsThrottleControl.Engine engine
    annotation (Placement(transformation(extent = {{32,-4},{60,24}})));
  Modelica.Blocks.Sources.Step step1(
    height = -5,
    offset = 25,
    startTime = 2)
    annotation (Placement(transformation(extent = {{148,23},{134,37}})));
  Modelica.Blocks.Sources.Step step2(
    height = 5,
    offset = 0,
    startTime = 8)
    annotation (Placement(transformation(extent = {{148,-16},{134,-2}})));
  Modelica.Blocks.Math.Add add(k1 = -1, k2 = -1)
    annotation (Placement(transformation(extent = {{116,4},{104,16}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport = false)
    annotation (Placement(transformation(extent = {{90,0},{70,20}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
    annotation (Placement(transformation(
      extent = {{-10,-10},{10,10}},
      rotation = -90,
      origin = {70,-30})));
  Modelica.Blocks.Continuous.Der derivative
    annotation (Placement(transformation(extent = {{20,-60},{0,-40}})));
  RealSignals.Sampler.SampleClocked sample2
    annotation (Placement(transformation(extent = {{-24,-44},{-36,-56}})));

equation
  connect(speedRef.y, sample1.u)
    annotation (Line(
      points = {{-69,16},{-61.4,16}},
      color = {0,0,127}));
  connect(sample1.y, speedControl.N_des)
    annotation (Line(
      points = {{-45.3,16},{-35.2,16}},
      color = {0,0,127}));
  connect(speedControl.Theta, hold1.u)
    annotation (Line(points={{1.6,10},{6.8,10}}, color={0,0,127}));
  connect(hold1.y, engine.Theta)
    annotation (Line(points={{20.6,10},{29.2,10}}, color={0,0,127}));
  connect(torque.flange, engine.flange_b)
    annotation (Line(
      points = {{70,10},{60,10}}));
  connect(add.y, torque.tau)
    annotation (Line(
      points = {{103.4,10},{92,10}},
      color = {0,0,127}));
  connect(step2.y, add.u2)
    annotation (Line(
      points = {{133.3,-9},{128,-9},{128,6.4},{117.2,6.4}},
      color = {0,0,127}));
  connect(step1.y, add.u1)
    annotation (Line(
      points = {{133.3,30},{128,30},{128,13.6},{117.2,13.6}},
      color = {0,0,127}));
  connect(engine.flange_b, angleSensor.flange)
    annotation (Line(
      points = {{60,10},{70,10},{70,-20}}));
  connect(angleSensor.phi, derivative.u)
    annotation (Line(
      points = {{70,-41},{70,-50},{22,-50}},
      color = {0,0,127}));
  connect(derivative.y, sample2.u)
    annotation (Line(
      points = {{-1,-50},{-22.8,-50}},
      color = {0,0,127}));
  connect(sample2.y, speedControl.N)
    annotation (Line(
      points = {{-36.6,-50},{-50,-50},{-50,1},{-35.2,1}},
      color = {0,0,127}));
  connect(sample2.clock, engine.synchronize)
    annotation (Line(
      points = {{-30,-42.8},{-30,-20},{64,-20},{64,0},{61.4,0},{61.4,0.2}},
      color = {175,175,175},
      pattern = LinePattern.Dot,
      thickness = 0.5));

  annotation (
    Diagram(
      coordinateSystem(
        preserveAspectRatio = true,
        extent = {{-100,-100},{160,100}}),
      graphics={
        Rectangle(
          extent = {{100,60},{152,-30}},
          lineColor = {0,0,255}),
        Text(
          extent = {{100,60},{150,40}},
          textColor = {0,0,255},
          textString = "Load torque")}),
    experiment(StopTime = 1.1),
    Documentation(info="<html>
<p>
This example shows how to model a non-periodic synchronous sampled data systems
with the <code>Modelica.Clocked library</code>. This is demonstrated at hand
of a closed-loop throttle control synchronized to the crankshaft angle of an
internal combustion engine. This system has the following properties:</p>
<ul>
<li> The engine speed is regulated with a throttle actuator.</li>
<li> Controller execution is synchronized with the engine crankshaft angle.</li>
<li> The influence of disturbances, such as a change in load torque, is reduced.</li>
</ul>
<p>
The complete system is shown in the figure below (diagram-layer):
</p>
<img
  src=\"modelica://Modelica/Resources/Images/Clocked/Examples/EngineThrottleControl_Model.png\"
  alt=\"EngineThrottleControl_Model.png\">
<p>
Block <code>speedControl</code> is the discrete control system. The boundaries
of this controller are defined by <code>sample1</code>, <code>sample2</code> and
<code>hold</code>. The sampling is done in terms of sensors within the engine
which observe its crankshaft angle; every 180° rotation of the crankshaft, the engine
internally synchronizes is throttles. The respective synchronization points are provided
as clocked outputs that in turn are used to trigger the external controller. The speed
controller therefore is automatically executed every half-rotation of the engine's
crankshaft in sync with the engine's internal throttle-cycle. The following diagram
illustrates the engine's respective internal setup:
</p>
<img
  src=\"modelica://Modelica/Resources/Images/Clocked/Examples/Engine_Model.png\"
  alt=\"Engine_Model.png\">
<p>
The <code>crankshaftPositionEvent</code>-clock is the event-clock synchronizing the
engine's internal throttle-cycle and external control. It produces a clock tick for
every half-rotation and is implemented as
<a href=\"modelica://Modelica.Clocked.ClockSignals.Clocks.Rotational.RotationalClock\">RotationalClock</a>.
</p><p>The following diagram illustrates the logic of such a rotational clock:
</p>
<img
  src=\"modelica://Modelica/Resources/Images/Clocked/Examples/RotationalClock_Model.png\"
  alt=\"RotationalClock_Model.png\">
<p>
It accounts the angular of the last time a rotation has been
recognized (<code>angular_offset</code>). Given
<code>angular_offset</code>, the event-condition for rotations is:
</p><p>
<code>abs(angle - angular_offset) >= abs(trigger_interval)</code>
</p><p>
In our case, <code>angle</code> is the position of the crankshaft of the engine and
<code>trigger_interval</code> is 180°. In the end,
<code>crankshaftPositionEvent</code> samples it's own input angle to account
an offset used to decide when to tick; the clock's event condition depends on
the state present when the condition changed last time from being non-satisfied
to being satisfied, i.e., the state when the clock last ticked.
</p><p>
<em>This example model is based on the following references:</em>
</p>
<dl>
<dt>Crossley, P.R. and Cook, J. (1991):</dt>
<dd> <strong>A nonlinear engine model for drivetrain system development</strong>.
     International Conference on Control, Edinburgh, UK, March.<br>&nbsp;</dd>
<dt>Simulink&reg; (R2010b) demo model <code>sldemo_enginewc.mdl</code>:</dt>
<dd><strong>Engine Timing Model with Closed Loop Control</strong>.
    The <code>EngineThrottleControl</code> example uses the same parameter values as the <code>sldemo_enginewc.mdl</code> demo model which is shipped with the Simulink&reg; software developed by The MathWorks, Inc.
    Hence, the simulation results of these models can be compared conveniently.<br>&nbsp;</dd>
</dl>
</html>"));
end EngineThrottleControl;
