within Modelica;
package Electrical "Library of electrical models (analog, digital, machines, multi-phase)"
extends Modelica.Icons.Package;

annotation (
  Documentation(info="<html>
<p>
This library contains electrical components to build up analog and digital circuits,
as well as machines to model electrical motors and generators,
especially three phase induction machines such as an asynchronous motor.
</p>

</HTML>
"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
      Rectangle(extent={{-29,-13},{3,-27}}, lineColor={0,0,0}),
      Line(points={{37,-58},{62,-58}}, color={0,0,0}),
      Line(points={{36,-49},{61,-49}}, color={0,0,0}),
      Line(points={{-78,-50},{-43,-50}}, color={0,0,0}),
      Line(points={{-67,-55},{-55,-55}}, color={0,0,0}),
      Line(points={{-61,-50},{-61,-20},{-29,-20}}, color={0,0,0}),
      Line(points={{3,-20},{48,-20},{48,-49}}, color={0,0,0}),
      Line(points={{48,-58},{48,-78},{-61,-78},{-61,-55}}, color={0,0,0})}));
end Electrical;
