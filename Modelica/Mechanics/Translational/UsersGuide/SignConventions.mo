within Modelica.Mechanics.Translational.UsersGuide;
class SignConventions "Sign Conventions"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html>

<p>
The variables of a component of this library can be accessed in the
usual way. However, since most of these variables are basically elements
of <strong>vectors</strong>, i.e., have a direction, the question arises how the
signs of variables shall be interpreted. The basic idea is explained
at hand of the following figure:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/drive2.png\" alt=\"drive2\">
</div>

<p>
First, one has to define
a <strong>positive</strong> direction of this line, called <strong>axis of movement</strong>.
In the top of the figure this is characterized by an arrow
and a corresponding text. The simple rule is now:
If a variable of a component is positive and can be interpreted as
the element of a vector (e.g., force or velocity vector), the
corresponding vector is directed into the positive direction
of the axis of movement. In the following figure, the right-most
mass of the figure above is displayed with the positive
vector direction displayed according to this rule:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/drive3.png\" alt=\"drive3\">
</div>
<p>
The cut-force <code>mass2.flange_a.f</code>
of the right mass is directed into the
direction of movement if the values are positive. Similarly,
the velocity <code>mass2.v</code> of the right mass
is also directed into the
direction of movement if the values are positive
</p>
</html>"));

end SignConventions;
