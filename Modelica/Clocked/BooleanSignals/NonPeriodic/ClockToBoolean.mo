within Modelica.Clocked.BooleanSignals.NonPeriodic;
block ClockToBoolean
  "Block to translate clock signals to continuous Boolean events (each time the input clock ticks a rising Boolean output edge is produced)."
  extends ClockSignals.Interfaces.ClockedBlockIcon;
  extends Modelica.Blocks.Icons.PartialBooleanBlock;

  ClockSignals.Interfaces.ClockInput u
    "Connector of clock input signal."
    annotation (Placement(transformation(extent = {{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    "Connector of continuous Boolean output signal."
    annotation (Placement(transformation(extent = {{100,-10},{120,10}})));

  Sampler.SampleClocked input_sample
    annotation (Placement(transformation(
      extent = {{-6,-6},{6,6}},
      rotation = -90,
      origin={-50,14})));
  Modelica.Blocks.MathBoolean.Not input_tick
    annotation (Placement(transformation(extent = {{-26,-6},{-14,6}})));
  Sampler.Hold input_hold(y_start = false)
    annotation (Placement(transformation(extent = {{14,-6},{26,6}})));
  Modelica.Blocks.MathBoolean.ChangingEdge input_ticked
    annotation (Placement(transformation(extent = {{54,-6},{66,6}})));

equation
  connect(input_sample.y,input_tick.u)
    annotation (Line(
      points = {{-50,7.4},{-50,0},{-28.4,0}},
      color = {255,0,255}));
  connect(input_hold.y,input_sample.u)
    annotation (Line(
      points = {{26.6,0},{40,0},{40,30},{-50,30},{-50,21.2}},
      color = {255,0,255}));
  connect(input_tick.y,input_hold.u)
    annotation (Line(
      points = {{-12.8,0},{12.8,0}},
      color = {255,0,255}));
  connect(input_hold.y,input_ticked.u)
    annotation (Line(
      points = {{26.6,0},{51.6,0}},
      color = {255,0,255}));
  connect(u, input_sample.clock)
    annotation (Line(
      points = {{-120,0},{-80,0},{-80,14},{-57.2,14}},
      color = {175,175,175},
      pattern = LinePattern.Dot,
      thickness = 0.5));
  connect(input_ticked.y, y)
    annotation (Line(
      points = {{67.2,0},{110,0}},
      color = {255,0,255}));

  annotation (Icon(graphics={
    Line(
      points = {{70,60},{-70,60}},
      color = {95,95,95},
      pattern = LinePattern.Dot,
      thickness = 0.5),
    Line(
      points = {{-66,-60},{-30,-60},{-30,-16},{-30,-16},{-30,-60},{68,-60}},
      color = {255,0,255}),
    Line(
      points = {{30,-60},{30,-16}},
      color = {255,0,255}),
    Ellipse(
      extent = {{-71,7},{-85,-7}},
      lineColor = {235,235,235},
      fillColor = {235,235,235},
      fillPattern = FillPattern.Solid),
    Ellipse(
      extent = {{71,7},{85,-7}},
      lineColor = {235,235,235},
      fillColor = {235,235,235},
      fillPattern = FillPattern.Solid),
    Ellipse(
      extent = {{-40,70},{-20,50}},
      lineColor = {175,175,175},
      fillColor = {255,255,255},
      fillPattern = FillPattern.Solid),
    Ellipse(
      extent = {{22,70},{42,50}},
      lineColor = {175,175,175},
      fillColor = {255,255,255},
      fillPattern = FillPattern.Solid)}));
end ClockToBoolean;
