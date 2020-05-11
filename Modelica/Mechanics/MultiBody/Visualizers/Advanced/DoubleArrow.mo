within Modelica.Mechanics.MultiBody.Visualizers.Advanced;
model DoubleArrow
  "Visualizing a double arrow with variable size"

  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Mechanics.MultiBody.Frames;
  import T = Modelica.Mechanics.MultiBody.Frames.TransformationMatrices;
  import Modelica.Units.Conversions.to_unit1;

  input Frames.Orientation R=Frames.nullRotation()
    "Orientation object to rotate the world frame into the arrow frame" annotation(Dialog);
  input SI.Position r[3]={0,0,0}
    "Position vector from origin of world frame to origin of arrow frame, resolved in world frame" annotation(Dialog);
  input SI.Position r_tail[3]={0,0,0}
    "Position vector from origin of arrow frame to double arrow tail, resolved in arrow frame" annotation(Dialog);
  input Real r_head[3]={0,0,0}
    "Vector from double arrow tail to the head of the double arrow, resolved in arrow frame" annotation(Dialog);
  input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.ArrowColor
    "Color of double arrow" annotation(Dialog(colorSelector=true));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Material property describing the reflecting of ambient light (= 0 means, that light is completely absorbed)"  annotation(Dialog);
  parameter Types.VectorQuantity quantity=Types.VectorQuantity.Torque
    "Kind of physical quantity represented by the vector";
  input Boolean headAtOrigin=true "= true, if the vector is pointing towards the origin of vector frame" annotation(Dialog);
protected
  outer Modelica.Mechanics.MultiBody.World world;
  SI.Position rvisobj[3] = r + T.resolve1(R.T, r_tail);
  Visualizers.Advanced.Vector arrowLine(
    coordinates=r_head,
    color=color,
    specularCoefficient=specularCoefficient,
    r=rvisobj,
    quantity=quantity,
    headAtOrigin=headAtOrigin,
    twoHeadedArrow=true,
    R=R) if world.enableAnimation;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-100,28},{0,-28}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,60},{100,0},{40,-60},{40,60}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,105},{150,65}},
          textString="%name",
          textColor={0,0,255}),
        Polygon(
          points={{0,60},{60,0},{0,-60},{0,60}},
          lineColor={128,128,128},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Model <strong>DoubleArrow</strong> defines a double arrow that is dynamically
visualized at the defined location (see variables below).
Nonetheless, visualizing physical vectors by means of
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Vector\">Vector</a>
can be better option in many cases.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Visualizers/Advanced/DoubleArrow.png\" alt=\"model Visualizers.Advanced.DoubleArrow\">
</div>

<p>
The dialog variables <code>R</code>, <code>r</code>, <code>r_tail</code>, <code>r_head</code>, <code>color</code>,
<code>specularCoefficient</code>, and <code>headAtOrigin</code>
are declared as (time varying) <strong>input</strong> variables.
If the default equation is not appropriate, a&nbsp;corresponding
modifier equation has to be provided in the
model where an <strong>Arrow</strong> instance is used, e.g., in the form
</p>

<blockquote><pre>
Visualizers.Advanced.DoubleArrow doubleArrow(r_head = {sin(time),cos(time},0})
</pre></blockquote>

<p>
Variable <strong>color</strong> is an Integer vector with 3&nbsp;elements,
{r,&nbsp;g,&nbsp;b}, and specifies the color of the shape.
{r,&nbsp;g,&nbsp;b} are the &quot;red&quot;, &quot;green&quot; and &quot;blue&quot; color parts.
Note, r, g and b are given in the range 0&nbsp;&hellip;&nbsp;255.
The predefined type
<a href=\"modelica://Modelica.Mechanics.MultiBody.Types.Color\">MultiBody.Types.Color</a>
contains a&nbsp;menu definition of the colors used in the MultiBody
library together with a&nbsp;color editor.
</p>
</html>"));
end DoubleArrow;
