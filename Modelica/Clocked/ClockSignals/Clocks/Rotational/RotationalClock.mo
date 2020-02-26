within Modelica.Clocked.ClockSignals.Clocks.Rotational;
block RotationalClock
  "Event clock generating a clock tick each time an observed input angle changed for a rotational-interval given as variable input"
  extends PartialRotationalClock;

  Modelica.Blocks.Interfaces.RealInput trigger_interval(unit = "rad")
    "Rotational-interval the input angle must be changed to trigger the next clock tick"
    annotation (Placement(transformation(extent = {{-140,40},{-100,80}})));

  ClockSignals.Clocks.EventClock y_clock(
    useSolver = useSolver,
    solverMethod = solverMethod)
    annotation (Placement(transformation(
      extent = {{10,-10},{-10,10}},
      rotation = 90,
      origin = {70,-10})));
  RealSignals.Sampler.SampleClocked update_offset
    annotation (Placement(transformation(extent = {{-78,-8},{-62,8}})));
  RealSignals.Sampler.Hold angular_offset
    annotation (Placement(transformation(extent = {{-48,-8},{-32,8}})));
  Modelica.Blocks.Math.Add sub(k2 = -1)
    annotation (Placement(transformation(extent = {{-10,20},{10,40}})));
  Modelica.Blocks.Logical.Less less
    annotation (Placement(transformation(extent = {{60,28},{80,48}})));
  Modelica.Blocks.Math.Abs abs2
    annotation (Placement(transformation(extent = {{20,50},{40,70}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent = {{20,20},{40,40}})));
  Modelica.Blocks.Math.Sign direction_sign(generateEvent = false)
    annotation (Placement(transformation(extent = {{-50,-70},{-30,-50}})));
  Modelica.Blocks.Math.RealToInteger cast
    annotation (Placement(transformation(extent = {{-10,-70},{10,-50}})));
  IntegerSignals.NonPeriodic.IntegerChange changed
    annotation (Placement(transformation(extent = {{60,-90},{80,-70}})));
  RealSignals.Sampler.SampleClocked update_direction
    annotation (Placement(transformation(extent = {{-76,-54},{-64,-66}})));

algorithm
  assert(trigger_interval > 0 or trigger_interval < 0,
    "The rotational-interval of rotational clocks must be non-zero.");

equation
  connect(angle, update_offset.u)
    annotation (Line(
      points = {{-120,0},{-79.6,0}},
      color = {0,0,127}));
  connect(y_clock.y, update_offset.clock)
    annotation (Line(
      points = {{70,-21},{70,-30},{-70,-30},{-70,-9.6}},
      color = {175,175,175},
      pattern = LinePattern.Dot,
      thickness = 0.5));
  connect(update_offset.y, angular_offset.u)
    annotation (Line(
      points = {{-61.2,0},{-49.6,0}},
      color = {0,0,127}));
  connect(angular_offset.y,sub. u2)
    annotation (Line(
      points = {{-31.2,0},{-20,0},{-20,24},{-12,24}},
      color = {0,0,127}));
  connect(less.y, y_clock.u)
    annotation (Line(
      points = {{81,38},{90,38},{90,10},{70,10},{70,2}},
      color = {255,0,255}));
  connect(y_clock.y, y)
    annotation (Line(
      points = {{70,-21},{70,-30},{90,-30},{90,0},{110,0}},
      color = {175,175,175},
      pattern = LinePattern.Dot,
      thickness = 0.5));
  connect(sub.y, abs1.u)
    annotation (Line(
      points = {{11,30},{18,30}},
      color = {0,0,127}));
  connect(angle, sub.u1)
    annotation (Line(
      points = {{-120,0},{-90,0},{-90,36},{-12,36}},
      color = {0,0,127}));
  connect(trigger_interval, abs2.u)
    annotation (Line(
      points = {{-120,60},{18,60}},
      color = {0,0,127}));
  connect(abs1.y, less.u2)
    annotation (Line(
      points = {{41,30},{58,30}},
      color = {0,0,127}));
  connect(abs2.y, less.u1)
    annotation (Line(
      points = {{41,60},{52,60},{52,38},{58,38}},
      color = {0,0,127}));
  connect(direction_sign.y, cast.u)
    annotation (Line(
      points = {{-29,-60},{-12,-60}},
      color = {0,0,127}));
  connect(cast.y, changed.u)
    annotation (Line(
      points = {{11,-60},{50,-60},{50,-80},{58,-80}},
      color = {255,127,0}));
  connect(y_clock.y, update_direction.clock)
    annotation (Line(
      points = {{70,-21},{70,-30},{-70,-30},{-70,-52.8}},
      color = {175,175,175},
      pattern = LinePattern.Dot,
      thickness = 0.5));
  connect(update_direction.y, direction_sign.u)
    annotation (Line(
      points = {{-63.4,-60},{-52,-60}},
      color = {0,0,127}));
  connect(sub.y, update_direction.u)
    annotation (Line(
      points = {{11,30},{14,30},{14,-20},{-90,-20},{-90,-60},{-77.2,-60}},
      color = {0,0,127}));
  connect(changed.y, direction_changed)
    annotation (Line(
      points = {{81,-80},{110,-80}},
      color = {255,0,255}));
  connect(cast.y, direction)
    annotation (Line(
      points = {{11,-60},{50,-60},{50,-40},{110,-40}},
      color = {255,127,0}));

  annotation (
    Icon(graphics={
      Line(
        points = {{-100,60},{-90,60},{-80,60}},
        color = {0,0,127})}),
    Documentation(info="<html>
    For a simple example cf. the
    <a href=\"modelica://Modelica.Clocked.Examples.Elementary.ClockSignals.RotationalSample\">rotational sampling example</a>.
    </html>"));
end RotationalClock;
