within Modelica.Mechanics.MultiBody.Visualizers.Advanced;
model Vector "Visualizing a vector quantity (force, torque, etc.)"

  extends ModelicaServices.Animation.Vector;
  extends Modelica.Utilities.Internal.PartialModelicaServices.Animation.PartialVector;

  annotation (
    Documentation(info="<html>
<p>
Model <strong>Vector</strong> defines a&nbsp;vector that is dynamically
visualized at the defined location (see variables below).
The vector length does not represent
a&nbsp;physical length, but a&nbsp;different 3-dimensional quantity
(such as force, torque, speed, &hellip;), except for <strong>RelativePosition</strong>.

That allows the vectors of similar quantities to be scaled appropriately during post-processing.
This is useful, even for <strong>RelativePosition</strong> and in that case to disable or
exaggerate the relative positions.
</p>

<p>
The dialog variables <code>R</code>, <code>r</code>, <code>coordinates</code>, <code>color</code>,
<code>specularCoefficient</code>, <code>quantity</code>, <code>headAtOrigin</code>, and <code>twoHeadedArrow</code>
are declared as (time varying) <strong>input</strong> variables.
If the default equation is not appropriate, a&nbsp;corresponding
modifier equation has to be provided in the
model where a&nbsp;<strong>Vector</strong> instance is used, e.g., in the form
</p>
<blockquote><pre>
Visualizers.Advanced.Vector vectorForce(coordinates = {sin(time),cos(time),0});
</pre></blockquote>

<p>
Variable <code>color</code> is an Integer vector with 3&nbsp;elements,
{r,&nbsp;g,&nbsp;b}, and specifies the color of the shape.
{r,&nbsp;g,&nbsp;b} are the &quot;red&quot;, &quot;green&quot; and &quot;blue&quot; color parts.
Note, r, g and b are given in the range 0&nbsp;&hellip;&nbsp;255.
The predefined type
<a href=\"modelica://Modelica.Mechanics.MultiBody.Types.Color\">MultiBody.Types.Color</a>
contains a&nbsp;menu definition of the colors used in the MultiBody
library together with a&nbsp;color editor.
</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Polygon(
          points={{20,60},{100,0},{20,-60},{20,60}},
          fillColor={60,120,180},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-150,105},{150,65}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{-100,-28},{20,28}},
          fillColor={60,120,180},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-100,-8},{20,-20}},
          fillColor={46,94,140},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-100,-20},{20,-28}},
          fillColor={26,53,80},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{20,-20},{100,0},{20,-48},{20,-20}},
          fillColor={46,93,140},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{20,-60},{100,0},{20,-48},{20,-60}},
          fillColor={26,53,80},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-100,26},{20,4}},
          fillColor={73,147,220},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-100,22},{20,14}},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{20,56},{100,0},{20,18},{20,56}},
          fillColor={72,149,220},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{20,48},{100,0},{20,36},{20,48}},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0})}));
end Vector;
