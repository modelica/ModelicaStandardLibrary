within Modelica;
package Mechanics "Library of 1-dim. and 3-dim. mechanical components (multi-body, rotational, translational)"
extends Modelica.Icons.Library2;


annotation (
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
      graphics={
      Rectangle(
        extent={{-5,-40},{45,-70}},
        lineColor={0,0,0},
        fillPattern=FillPattern.HorizontalCylinder,
        fillColor={192,192,192}),
      Ellipse(extent={{-90,-50},{-80,-60}}, lineColor={0,0,0}),
      Line(
        points={{-85,-55},{-60,-21}},
        color={0,0,0},
        thickness=0.5),
      Ellipse(extent={{-65,-16},{-55,-26}}, lineColor={0,0,0}),
      Line(
        points={{-60,-21},{9,-55}},
        color={0,0,0},
        thickness=0.5),
      Ellipse(
        extent={{4,-50},{14,-60}},
        lineColor={0,0,0},
        fillColor={0,0,0},
        fillPattern=FillPattern.Solid),
      Line(points={{-10,-34},{72,-34},{72,-76},{-10,-76}}, color={0,0,0})}),
  Documentation(info="<HTML>
<p>
This package contains components to model the movement
of 1-dim. rotational, 1-dim. translational, and
3-dim. <b>mechanical systems</b>.
</p>
</HTML>
"));
end Mechanics;
