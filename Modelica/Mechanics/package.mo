within Modelica;
package Mechanics "Library of 1-dim. and 3-dim. mechanical components (multi-body, rotational, translational)"
extends Modelica.Icons.Package;


annotation (
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
      Rectangle(
        origin={8.6,63.3333},
        lineColor={64,64,64},
        fillColor={192,192,192},
        fillPattern=FillPattern.HorizontalCylinder,
        extent={{-4.6,-93.3333},{41.4,-53.3333}}),
      Ellipse(
        origin={9.0,46.0},
        extent={{-90.0,-60.0},{-80.0,-50.0}}),
      Line(
        origin={9.0,46.0},
        points={{-85.0,-55.0},{-60.0,-21.0}},
        thickness=0.5),
      Ellipse(
        origin={9.0,46.0},
        extent={{-65.0,-26.0},{-55.0,-16.0}}),
      Line(
        origin={9.0,46.0},
        points={{-60.0,-21.0},{9.0,-55.0}},
        thickness=0.5),
      Ellipse(
        origin={9.0,46.0},
        fillPattern=FillPattern.Solid,
        extent={{4.0,-60.0},{14.0,-50.0}}),
      Line(
        origin={9.0,46.0},
        points={{-10.0,-26.0},{72.0,-26.0},{72.0,-86.0},{-10.0,-86.0}})}),
  Documentation(info="<html>
<p>
This package contains components to model the movement
of 1-dim. rotational, 1-dim. translational, and
3-dim. <strong>mechanical systems</strong>.
</p>

<p>
Note, all <strong>dissipative</strong> components of the Modelica.Mechanics library have
an optional <strong>heatPort</strong> connector to which the
dissipated energy is transported in form of heat. This connector is enabled
via parameter \"useHeatPort\". If the heatPort connector is enabled,
it must be connected, and if it is not enabled, it must not be connected.
Independently, whether the heatPort is enabled or not,
the dissipated power is available from variable \"<strong>lossPower</strong>\" (which is
positive if heat is flowing out of the heatPort).
</p>
</html>"));
end Mechanics;
