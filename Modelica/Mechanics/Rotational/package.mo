within Modelica.Mechanics;
package Rotational "Library to model 1-dimensional, rotational mechanical systems"
  extends Modelica.Icons.Package;

  annotation (Documentation(info="<html>

<p>
Library <strong>Rotational</strong> is a <strong>free</strong> Modelica package providing
1-dimensional, rotational mechanical components to model in a convenient way
drive trains with frictional losses. A typical, simple example is shown
in the next figure:
</p>

<div><img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/driveExample.png\"></div>

<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide\">Rotational.UsersGuide</a>
     discusses the most important aspects how to use this library.</li>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.Examples\">Rotational.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>

<p>
In version 3.0 of the Modelica Standard Library, the basic design of the
library has changed: Previously, bearing connectors could or could not be connected.
In 3.0, the bearing connector is renamed to \"<strong>support</strong>\" and this connector
is enabled via parameter \"useSupport\". If the support connector is enabled,
it must be connected, and if it is not enabled, it must not be connected.
</p>

<p>
In version 3.2 of the Modelica Standard Library, all <strong>dissipative</strong> components
of the Rotational library got an optional <strong>heatPort</strong> connector to which the
dissipated energy is transported in form of heat. This connector is enabled
via parameter \"useHeatPort\". If the heatPort connector is enabled,
it must be connected, and if it is not enabled, it must not be connected.
Independently, whether the heatPort is enabled or not,
the dissipated power is available from the new variable \"<strong>lossPower</strong>\" (which is
positive if heat is flowing out of the heatPort). For an example, see
<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.HeatLosses\">Examples.HeatLosses</a>.
</p>

<p>
Copyright &copy; 1998-2020, Modelica Association and contributors
</p>
</html>", revisions=""), Icon(
    coordinateSystem(preserveAspectRatio=true,
      extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
    Line(origin={-2.0,46.0},
      points={{-83.0,-66.0},{-63.0,-66.0}}),
    Line(origin={29.0,48.0},
      points={{36.0,-68.0},{56.0,-68.0}}),
    Line(origin={-2.0,49.0},
      points={{-83.0,-29.0},{-63.0,-29.0}}),
    Line(origin={29.0,52.0},
      points={{36.0,-32.0},{56.0,-32.0}}),
    Line(origin={-2.0,49.0},
      points={{-73.0,-9.0},{-73.0,-29.0}}),
    Line(origin={29.0,52.0},
      points={{46.0,-12.0},{46.0,-32.0}}),
    Line(origin={-0.0,-47.5},
      points={{-75.0,27.5},{-75.0,-27.5},{75.0,-27.5},{75.0,27.5}}),
    Rectangle(origin={13.5135,76.9841},
      lineColor={64,64,64},
      fillColor={255,255,255},
      fillPattern=FillPattern.HorizontalCylinder,
      extent={{-63.5135,-126.9841},{36.4865,-26.9841}},
      radius=10.0),
    Rectangle(origin={13.5135,76.9841},
      lineColor={64,64,64},
      extent={{-63.5135,-126.9841},{36.4865,-26.9841}},
      radius=10.0),
    Rectangle(origin={-3.0,73.0769},
      lineColor={64,64,64},
      fillColor={192,192,192},
      fillPattern=FillPattern.HorizontalCylinder,
      extent={{-87.0,-83.0769},{-47.0,-63.0769}}),
    Rectangle(origin={22.3077,70.0},
      lineColor={64,64,64},
      fillColor={192,192,192},
      fillPattern=FillPattern.HorizontalCylinder,
      extent={{27.6923,-80.0},{67.6923,-60.0}})}));
end Rotational;
