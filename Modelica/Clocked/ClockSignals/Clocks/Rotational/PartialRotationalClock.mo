within Modelica.Clocked.ClockSignals.Clocks.Rotational;
partial block PartialRotationalClock
  "Base class for event clocks that generate a clock tick each time an observed input angle changes"
  extends ClockSignals.Interfaces.PartialClock;

  Modelica.Blocks.Interfaces.RealInput angle(unit = "rad")
    "Input angle observed for generating clock ticks."
    annotation (Placement(transformation(extent = {{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.IntegerOutput direction
    "Rotation direction (sign: +1 or -1). Sampled with the provided clock signal
     'y'."
    annotation (Placement(transformation(extent = {{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.BooleanOutput direction_changed(start = false)
    "= true, if the rotation direction of the observed angle changed since the last tick of y', otherwise false. Sampled with the provided clock signal y."
    annotation (Placement(transformation(extent = {{100,-90},{120,-70}})));

  annotation (Icon(graphics={
    Line(
      points = {{60,-80},{100,-80}},
      color = {217,67,180}),
    Line(
      points = {{92,-40},{100,-40}},
      color = {244,125,35})}));
end PartialRotationalClock;
