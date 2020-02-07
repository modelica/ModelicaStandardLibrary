within Modelica.Mechanics.MultiBody.Sensors.Internal;
model PartialAbsoluteBaseSensor
  "Base class for absolute sensor models defined by equations (frame_resolve must be connected exactly once)"
  extends Modelica.Icons.RoundSensor;

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
    "Coordinate system from which kinematic quantities are measured" annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})));

  Modelica.Mechanics.MultiBody.Interfaces.Frame_resolve frame_resolve
    "Coordinate system in which output vector(s) is optionally resolved"
    annotation (Placement(transformation(extent={{-16,-16},{16,16}},
        rotation=-90,
        origin={0,-100})));

equation
  assert(cardinality(frame_a) > 0, "Connector frame_a must be connected at least once");
  assert(cardinality(frame_resolve) == 1, "Connector frame_resolve must be connected exactly once");
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  frame_resolve.f = zeros(3);
  frame_resolve.t = zeros(3);

  annotation (Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-108,43},{-72,18}},
          textColor={95,95,95},
          textString="a"),
        Line(
          points={{-70,0},{-96,0},{-96,0}}),
        Line(
          points={{0,15},{0,-15}},
          color={0,0,127},
          origin={85,0},
          rotation=90),
        Line(
          points={{0,-95},{0,-95},{0,-70},{0,-70}},
          pattern=LinePattern.Dot),
        Text(
          extent={{0,-75},{131,-100}},
          textColor={95,95,95},
          textString="resolve")}), Documentation(info="<html>
<p>
Partial base class for absolute sensor models defined by equations.
The connector frame_resolve is always enabled and must be connected exactly once.
</p>
</html>"));
end PartialAbsoluteBaseSensor;
