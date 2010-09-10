within Modelica;
package Mechanics "Library of 1-dim. and 3-dim. mechanical components (multi-body, rotational, translational)"
extends Modelica.Icons.Package;

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

<p>
Note, all <b>dissipative</b> components of the Modelica.Mechanics library have
an optional <b>heatPort</b> connector to which the
dissipated energy is transported in form of heat. This connector is enabled
via parameter \"useHeatPort\". If the heatPort connector is enabled,
it must be connected, and if it is not enabled, it must not be connected.
Independently, whether the heatPort is enabled or not,
the dissipated power is available from variable \"<b>lossPower</b>\" (which is
positive if heat is flowing out of the heatPort).
</p>
</HTML>
"));
end Mechanics;
