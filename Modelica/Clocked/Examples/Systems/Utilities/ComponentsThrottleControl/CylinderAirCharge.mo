within Modelica.Clocked.Examples.Systems.Utilities.ComponentsThrottleControl;
block CylinderAirCharge
  "Integrates the air mass flow into a cylinder. After the charge for one
   cylinder is complete, resets the mass to 0."
  extends Modelica.Blocks.Icons.Block;

  Modelica.Blocks.Interfaces.RealOutput m_a(unit="g")
    "Mass of an cylinder air charge (g)"
    annotation (Placement(transformation(extent = {{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput m_ao_der(unit="g/s")
    "Mass flow rate of air out of manifold (g/s)"
    annotation (Placement(transformation(extent = {{-140,-20},{-100,20}})));
  ClockSignals.Interfaces.ClockInput clock
    annotation (Placement(transformation(
      extent = {{-20,-20},{20,20}},
      rotation = 90,
      origin = {0,-120})));
  Modelica.Blocks.Math.Add add(k2 = -1)
    annotation (Placement(transformation(extent = {{60,-10},{80,10}})));
  RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-6,-26},{6,-14}})));
  RealSignals.Sampler.Hold hold1
    annotation (Placement(transformation(extent={{24,-26},{36,-14}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent = {{-80,-10},{-60,10}})));

equation
  connect(add.y, m_a)
    annotation (Line(
      points = {{81,0},{110,0}},
      color = {0,0,127}));
  connect(clock, sample1.clock) annotation (Line(
      points={{0,-120},{0,-27.2}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(sample1.y, hold1.u)
    annotation (Line(points={{6.6,-20},{22.8,-20}}, color={0,0,127}));
  connect(hold1.y, add.u2) annotation (Line(points={{36.6,-20},{50,-20},{50,-6},
          {58,-6}}, color={0,0,127}));
  connect(m_ao_der, integrator.u)
    annotation (Line(
      points = {{-120,0},{-82,0}},
      color = {0,0,127}));
  connect(integrator.y, add.u1)
    annotation (Line(
      points = {{-59,0},{-20,0},{-20,6},{58,6}},
      color = {0,0,127}));
  connect(integrator.y, sample1.u) annotation (Line(points={{-59,0},{-20,0},{-20,
          -20},{-7.2,-20}}, color={0,0,127}));
end CylinderAirCharge;
