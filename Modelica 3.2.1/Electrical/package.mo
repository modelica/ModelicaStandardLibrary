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

</html>"),
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
    Rectangle(
      origin={20.3125,82.8571},
      extent={{-45.3125,-57.8571},{4.6875,-27.8571}}),
    Line(
      origin={8.0,48.0},
      points={{32.0,-58.0},{72.0,-58.0}}),
    Line(
      origin={9.0,54.0},
      points={{31.0,-49.0},{71.0,-49.0}}),
    Line(
      origin={-2.0,55.0},
      points={{-83.0,-50.0},{-33.0,-50.0}}),
    Line(
      origin={-3.0,45.0},
      points={{-72.0,-55.0},{-42.0,-55.0}}),
    Line(
      origin={1.0,50.0},
      points={{-61.0,-45.0},{-61.0,-10.0},{-26.0,-10.0}}),
    Line(
      origin={7.0,50.0},
      points={{18.0,-10.0},{53.0,-10.0},{53.0,-45.0}}),
    Line(
      origin={6.2593,48.0},
      points={{53.7407,-58.0},{53.7407,-93.0},{-66.2593,-93.0},{-66.2593,-58.0}})}));
end Electrical;
