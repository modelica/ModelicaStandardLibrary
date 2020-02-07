within Modelica.Mechanics.MultiBody.Sensors.Internal;
partial model PartialAbsoluteSensor "Base class for absolute sensor models"
  extends Modelica.Icons.RoundSensor;

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
    "Coordinate system a of which the absolute kinematic quantities are measured" annotation (Placement(
        transformation(extent={{-116,-16},{-84,16}})));

equation
  assert(cardinality(frame_a) > 0, "Connector frame_a must be connected at least once");

  annotation (Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-108,43},{-72,18}},
          textColor={128,128,128},
          textString="a"), Line(
          points={{-70,0},{-96,0},{-96,0}})}), Documentation(info="<html>
<p>
This is a base class of a 3-dim. mechanical component with one frame
<strong>frame_a</strong> in order to measure an absolute quantity of this
connector.
This partial class can be used for sensors defined either by components or by equations.
</p>
</html>"));
end PartialAbsoluteSensor;
