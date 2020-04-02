within Modelica.Clocked.Examples.Systems.Utilities.ComponentsThrottleControl;
block InductionToPowerDelay
  "Accounts for the induction-to-power stroke lag."
  extends Modelica.Blocks.Icons.Block;

  Modelica.Blocks.Interfaces.RealInput m_a(unit = "g")
    "Mass of cylinder air charge (g)"
    annotation (Placement(transformation(extent = {{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput m_a_delayed(unit = "g")
    "180deg delayed mass of cylinder air charge (g)"
    annotation (Placement(transformation(extent = {{100,-10},{120,10}})));
  ClockSignals.Interfaces.ClockInput clock
    annotation (Placement(transformation(
        extent = {{-20,-20},{20,20}},
        rotation = 90,
        origin = {0,-120})));
  RealSignals.Sampler.SampleClocked sample1
    annotation (Placement(transformation(extent={{-6,-6},{6,6}})));
  RealSignals.Sampler.Hold hold1(y_start=0.152)
    annotation (Placement(transformation(extent={{66,-6},{78,6}})));
  RealSignals.NonPeriodic.FractionalDelay delay(
    shift = 1,
    final resolution = 1 "Prepare model for usage in event-clock partitions")
    annotation (Placement(transformation(extent = {{30,-10},{50,10}})));

equation
  connect(clock, sample1.clock) annotation (Line(
      points={{0,-120},{0,-7.2}},
      color={175,175,175},
      pattern=LinePattern.Dot,
      thickness=0.5));
  connect(m_a, sample1.u)
    annotation (Line(points={{-120,0},{-7.2,0}}, color={0,0,127}));
  connect(hold1.y, m_a_delayed)
    annotation (Line(points={{78.6,0},{110,0}}, color={0,0,127}));
  connect(sample1.y, delay.u)
    annotation (Line(points={{6.6,0},{28,0}}, color={0,0,127}));
  connect(delay.y, hold1.u)
    annotation (Line(points={{51,0},{64.8,0}}, color={0,0,127}));
end InductionToPowerDelay;
