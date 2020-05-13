within Modelica.Clocked.Examples.Elementary.ClockSignals;
model LogicalSample
  "Simple example of conjunctive and disjunctive logical clocks, combining clock signals to derive new event driven clocks."
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine sine_angle_input(
    amplitude = 10,
    f = 1)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Sources.Cosine cosine_angle_input(
    amplitude = 10,
    f = 1)
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
    Documentation(info="<html><p>
    Simple example of two logical clocks, a conjunctive and a disjunctive clock.
    Both receive the very same clock inputs, produced by two rotational clocks
    with slightly shifted input angle waves (sine and cosine respectively). The
    configuration and results of the rotational clocks are explained in the
    <a href=\"modelica://Modelica.Clocked.Examples.Elementary.ClockSignals.RotationalSample\">rotational clocks example</a>.
    The generated clocked signals of the disjunctive and conjunctive clock are
    therefore:
    </p>
    <div><img src=\"modelica://Modelica/Resources/Images/Clocked/Examples/LogicalSample_Result.png\" alt=\"LogicalSample_Result.png\"></div>.
    </html>"));
end LogicalSample;
