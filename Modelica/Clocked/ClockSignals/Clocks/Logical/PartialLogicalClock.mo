within Modelica.Clocked.ClockSignals.Clocks.Logical;
partial block PartialLogicalClock
  "Logical clock combining arbitrary many input clock signals according to a replaceable logical combinator"
  extends Interfaces.PartialClock;

  parameter Integer nu = 2
    "Number of input connections.";

  Interfaces.ClockVectorInput u[nu]
    "Vector of Clock input signals."
    annotation (Placement(transformation(extent = {{-120,-70},{-80,70}})));

  replaceable Modelica.Blocks.Interfaces.PartialBooleanMISO combinator
    constrainedby Modelica.Blocks.Interfaces.PartialBooleanMISO(
      nu = nu)
    "Replaceable logical combinator applied on vector of Clock input signals.
     Important: Must not be any kind of negation since such would result in
     infinite many ticks for an infinitesimal short time period."
    annotation (Placement(transformation(extent = {{20,-10},{40,10}})));

  EventClock clock
    annotation (Placement(transformation(extent = {{60,-10},{80,10}})));

  // Array of input trackers:
  BooleanSignals.NonPeriodic.ClockToBoolean input_ticked[nu]
    annotation (Placement(transformation(extent = {{-50,60},{-30,80}})));
  Modelica.Blocks.Logical.And forbidden_state[nu]
    annotation (Placement(transformation(
      extent = {{-6,6},{6,-6}},
      rotation = 90,
      origin = {-70,10})));
  Modelica.Blocks.Sources.BooleanConstant S_false[nu](each k = false)
    annotation (Placement(transformation(extent = {{-34,32},{-46,44}})));
  Modelica.Blocks.Logical.LogicalSwitch suppress_S[nu]
    annotation (Placement(transformation(extent = {{-46,14},{-34,26}})));
  Modelica.Blocks.Logical.RSFlipFlop input_memory[nu]
    annotation (Placement(transformation(extent = {{-20,-10},{0,10}})));

  // Resetter:
  BooleanSignals.NonPeriodic.ClockToBoolean reset_ticked
    annotation (Placement(transformation(extent = {{80,-60},{60,-40}})));
  Modelica.Blocks.Routing.BooleanReplicator splitter(nout = nu)
    annotation (Placement(transformation(
      extent = {{6,-6},{-6,6}},
      origin = {30,-50})));

equation
  connect(clock.y, y)
    annotation (Line(
      points = {{81,0},{110,0}},
      color = {175,175,175},
      pattern = LinePattern.Dot,
      thickness = 0.5));
  connect(combinator.y, clock.u)
    annotation (Line(
      points = {{41.5,0},{58,0}},
      color = {255,0,255}));
  connect(suppress_S.y, input_memory.S)
    annotation (Line(
      points = {{-33.4,20},{-28,20},{-28,6},{-22,6}},
      color = {255,0,255}));
  connect(input_memory.Q, combinator.u)
    annotation (Line(
      points = {{1,6},{10,6},{10,0},{20,0}},
      color = {255,0,255}));
  connect(S_false.y, suppress_S.u1)
    annotation (Line(
      points = {{-46.6,38},{-52,38},{-52,24.8},{-47.2,24.8}},
      color = {255,0,255}));
  connect(splitter.y, input_memory.R)
    annotation (Line(
      points={{23.4,-50},{-52,-50},{-52,-6},{-22,-6}},
      color = {255,0,255}));
  connect(splitter.y, forbidden_state.u1)
    annotation (Line(
      points = {{23.4,-50},{-70,-50},{-70,2.8}},
      color = {255,0,255}));
  connect(forbidden_state.y, suppress_S.u2)
    annotation (Line(
      points = {{-70,16.6},{-70,20},{-47.2,20}},
      color = {255,0,255}));
  connect(clock.y, reset_ticked.u)
    annotation (Line(
      points = {{81,0},{90,0},{90,-50},{82,-50}},
      color = {175,175,175},
      pattern = LinePattern.Dot,
      thickness = 0.5));
  connect(reset_ticked.y, splitter.u)
    annotation (Line(
      points = {{59,-50},{37.2,-50}},
      color = {255,0,255}));
  connect(input_ticked.y, suppress_S.u3)
    annotation (Line(
      points = {{-29,70},{-10,70},{-10,50},{-56,50},{-56,15.2},{-47.2,15.2}},
      color = {255,0,255}));
  connect(forbidden_state.u2, input_ticked.y)
    annotation (Line(
      points = {{-74.8,2.8},{-74.8,-6},{-80,-6},{-80,50},{-10,50},{-10,70},{-29,70}},
      color = {255,0,255}));
  connect(u, input_ticked.u)
    annotation (Line(
      points = {{-100,0},{-86,0},{-86,70},{-52,70}},
      color = {175,175,175},
      pattern = LinePattern.Dot,
      thickness = 0.5));

  annotation (
    Diagram(graphics={
      Polygon(
        points={{-94,100},{6,100},{6,-20},{-94,-20},{-94,100}},
        lineColor = {238,46,47},
        pattern = LinePattern.Dash,
        lineThickness = 0.5),
      Text(
        extent={{-90,100},{-20,90}},
        textColor={238,46,47},
        pattern=LinePattern.Dash,
        lineThickness=1,
        textStyle={TextStyle.Bold},
          textString="array of input trackers"),
      Rectangle(
        extent = {{14,-26},{96,-72}},
        lineColor = {28,108,200},
        pattern = LinePattern.Dash,
        lineThickness = 0.5),
      Text(
        extent = {{14,-26},{50,-40}},
        textColor = {28,108,200},
        pattern = LinePattern.Dash,
        lineThickness = 1,
        textString = "resetter",
        textStyle = {TextStyle.Bold})}));
end PartialLogicalClock;
