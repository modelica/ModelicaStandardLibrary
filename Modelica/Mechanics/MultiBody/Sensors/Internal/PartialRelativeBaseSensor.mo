within Modelica.Mechanics.MultiBody.Sensors.Internal;
model PartialRelativeBaseSensor
  "Base class for relative sensor models defined by equations (frame_resolve must be connected exactly once)"
  extends Modelica.Icons.RoundSensor;

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
    "Coordinate system a (measurement is between frame_a and frame_b)" annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_b
    "Coordinate system b (measurement is between frame_a and frame_b)" annotation (Placement(
        transformation(extent={{84,-16},{116,16}})));

  Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve
    "Coordinate system in which vector is optionally resolved"
    annotation (Placement(transformation(extent={{84,64},{116,96}})));

equation
  assert(cardinality(frame_a) > 0, "Connector frame_a must be connected at least once");
  assert(cardinality(frame_b) > 0, "Connector frame_b must be connected at least once");
  assert(cardinality(frame_resolve) == 1, "Connector frame_resolve must be connected exactly once");
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  frame_b.f = zeros(3);
  frame_b.t = zeros(3);
  frame_resolve.f = zeros(3);
  frame_resolve.t = zeros(3);

  annotation (Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-108,43},{-72,18}},
          textColor={128,128,128},
          textString="a"),
        Text(
          extent={{72,43},{108,18}},
          textColor={128,128,128},
          textString="b"),
        Line(
          points={{-70,0},{-96,0},{-96,0}}),
        Line(
          points={{96,0},{70,0},{70,0}}),
        Line(
          points={{0,-70},{0,-100}},
          color={0,0,127}),
        Line(
          points={{60,36},{60,36},{60,80},{95,80}},
          pattern=LinePattern.Dot)}), Documentation(info="<html>
<p>
Partial base class for relative sensor models defined by equations.
The connector frame_resolve is always enabled and must be connected exactly once.
</p>
</html>"));
end PartialRelativeBaseSensor;
