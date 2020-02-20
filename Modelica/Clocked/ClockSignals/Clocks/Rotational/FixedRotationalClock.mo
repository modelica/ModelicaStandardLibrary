within Modelica.Clocked.ClockSignals.Clocks.Rotational;
model FixedRotationalClock
  "Event clock generating a clock tick each time an observed input angle changed for a certain, constant rotational-interval"
  extends PartialRotationalClock;

  parameter SI.Angle trigger_interval = 2*Modelica.Constants.pi
    "Rotational-interval the input angle must be changed to trigger the next clock tick";

  RotationalClock rotationalClock
    annotation (Placement(transformation(extent = {{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant threshold(k = trigger_interval)
    annotation (Placement(transformation(extent = {{-80,20},{-60,40}})));

equation
  connect(angle, rotationalClock.angle)
    annotation (Line(
      points = {{-120,0},{-12,0}},
      color = {0,0,127}));
  connect(threshold.y, rotationalClock.trigger_interval)
    annotation (Line(
      points = {{-59,30},{-40,30},{-40,6},{-12,6}},
      color = {0,0,127}));
  connect(rotationalClock.y, y)
    annotation (Line(
      points = {{11,0},{110,0}},
      color = {175,175,175},
      pattern = LinePattern.Dot,
      thickness = 0.5));
  connect(rotationalClock.direction_changed, direction_changed)
    annotation (Line(
      points = {{11,-8},{60,-8},{60,-80},{110,-80}},
      color = {255,0,255}));
  connect(rotationalClock.direction, direction)
    annotation (Line(
      points = {{11,-4},{70,-4},{70,-40},{110,-40}},
      color = {255,127,0}));

  annotation (Icon(graphics={
    Text(
      extent={{-150,-110},{150,-150}},
      textColor = {0,0,0},
      textString = "%trigger_interval%")}));
end FixedRotationalClock;
