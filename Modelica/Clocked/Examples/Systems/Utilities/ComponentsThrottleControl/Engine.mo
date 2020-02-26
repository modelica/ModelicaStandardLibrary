within Modelica.Clocked.Examples.Systems.Utilities.ComponentsThrottleControl;
model Engine "Internal combustion engine."
  Modelica.Blocks.Interfaces.RealInput Theta(unit="deg")
    "Throttle angle (deg)"
    annotation (Placement(transformation(extent = {{-140,-20},{-100,20}})));
  ThrottleBody throttleBody
    annotation (Placement(transformation(extent = {{-80,30},{-60,50}})));
  IntakeManifold intakeManifold
    annotation (Placement(transformation(extent = {{-80,-10},{-60,10}})));
  TorqueGeneration torqueGeneration
    annotation (Placement(transformation(extent = {{20,30},{40,50}})));
  ClockSignals.Clocks.Rotational.FixedRotationalClock crankshaftPositionEvent(
    trigger_interval = 3.1415926535898)
    annotation (Placement(transformation(extent = {{40,-70},{20,-50}})));
  InductionToPowerDelay inductionToPowerDelay
    annotation (Placement(transformation(extent = {{-20,-10},{0,10}})));
  CylinderAirCharge cylinderAirCharge
    annotation (Placement(transformation(extent = {{-50,-10},{-30,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport = false)
    annotation (Placement(transformation(extent = {{22,-8},{38,8}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(
    J = 0.14,
    w(fixed = true, start = 209),
    phi(fixed = true, start = 0))
    annotation (Placement(transformation(extent = {{42,-8},{58,8}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
    annotation (Placement(transformation(
      extent = {{-10,-10},{10,10}},
      rotation = 270,
      origin = {70,-20})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
    annotation (Placement(transformation(extent = {{90,-10},{110,10}})));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
    annotation (Placement(transformation(
      extent = {{-10,-10},{10,10}},
      rotation = -90,
      origin = {90,-20})));
  ClockSignals.Interfaces.ClockOutput synchronize
    annotation (Placement(transformation(extent = {{100,-80},{120,-60}})));

equation
  connect(Theta, throttleBody.Theta)
    annotation (Line(
      points = {{-120,0},{-94,0},{-94,46},{-82,46}},
      color = {0,0,127}));
  connect(throttleBody.m_ai_der, intakeManifold.m_ai_der)
    annotation (Line(
      points = {{-59,40},{-52,40},{-52,20},{-86,20},{-86,6},{-82,6}},
      color = {0,0,127}));
  connect(intakeManifold.P_m, throttleBody.Pm)
    annotation (Line(
      points = {{-59,-6},{-56,-6},{-56,-20},{-90,-20},{-90,34},{-82,34}},
      color = {0,0,127}));
  connect(inductionToPowerDelay.m_a_delayed, torqueGeneration.m_a)
    annotation (Line(
      points = {{1,0},{6,0},{6,46},{18,46}},
      color = {0,0,127}));
  connect(cylinderAirCharge.m_a, inductionToPowerDelay.m_a)
    annotation (Line(
      points = {{-29,0},{-22,0}},
      color = {0,0,127}));
  connect(intakeManifold.m_ao_der, cylinderAirCharge.m_ao_der)
    annotation (Line(
      points = {{-59,6},{-56,6},{-56,0},{-52,0}},
      color = {0,0,127}));
  connect(torque.tau, torqueGeneration.T_torque_e)
    annotation (Line(
      points = {{20.4,0},{14,0},{14,20},{48,20},{48,40},{41,40}},
      color = {0,0,127}));
  connect(torque.flange, inertia.flange_a)
    annotation (Line(points = {{38,0},{42,0}}));
  connect(inertia.flange_b, speedSensor.flange)
    annotation (Line(points = {{58,0},{70,0},{70,-10}}));
  connect(inertia.flange_b, flange_b)
    annotation (Line(points = {{58,0},{100,0}}));
  connect(torqueGeneration.N, speedSensor.w)
    annotation (Line(
      points = {{18,34},{10,34},{10,-40},{70,-40},{70,-31}},
      color = {0,0,127}));
  connect(intakeManifold.N, speedSensor.w)
    annotation (Line(
      points = {{-82,-6},{-86,-6},{-86,-90},{70,-90},{70,-31}},
      color = {0,0,127}));
  connect(angleSensor.flange, inertia.flange_b)
    annotation (Line(points = {{90,-10},{90,0},{58,0}}));
  connect(angleSensor.phi, crankshaftPositionEvent.angle)
    annotation (Line(
      points = {{90,-31},{90,-60},{42,-60}},
      color = {0,0,127}));
  connect(crankshaftPositionEvent.y, inductionToPowerDelay.clock)
    annotation (Line(
      points = {{19,-60},{-10,-60},{-10,-12}},
      color = {175,175,175},
      pattern = LinePattern.Dot,
      thickness = 0.5));
  connect(crankshaftPositionEvent.y, cylinderAirCharge.clock)
    annotation (Line(
      points = {{19,-60},{-40,-60},{-40,-12}},
      color = {175,175,175},
      pattern = LinePattern.Dot,
      thickness = 0.5));
  connect(crankshaftPositionEvent.y, synchronize)
    annotation (Line(
      points = {{19,-60},{-10,-60},{-10,-80},{60,-80},{60,-70},{110,-70}},
      color = {175,175,175},
      pattern = LinePattern.Dot,
      thickness = 0.5));

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
          textColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid,
          textString="%name")}));
end Engine;
