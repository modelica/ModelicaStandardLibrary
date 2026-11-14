within Modelica.Mechanics.MultiBody.Sensors.Internal;
model PartialAbsoluteBaseSensor
  "Base class for absolute sensor models defined by equations (frame_resolve must be connected exactly once)"
  extends Interfaces.PartialAbsoluteSensor(
    break y);

equation
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  frame_resolve.f = zeros(3);
  frame_resolve.t = zeros(3);

  annotation (Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
        Line(
          points={{-70,0},{-100,0}}),
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
