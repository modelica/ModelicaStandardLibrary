within Modelica.Mechanics.Rotational.UsersGuide;
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
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/drive2.png\" alt=\"drive2\">
</div>

<p>
In the figure, three identical drive trains are shown. The only
difference is that the gear of the middle drive train and the
gear as well as the right inertia of the lower drive train
are horizontally flipped with regards to the upper drive train.
The signs of variables are now interpreted in the following way:
Due to the 1-dimensional nature of the model, all components are
basically connected together along one line (more complicated
cases are discussed below). First, one has to define
a <strong>positive</strong> direction of this line, called <strong>axis of rotation</strong>.
In the top of the figure this is characterized by an arrow
and a corresponding text. The simple rule is now:
If a variable of a component is positive and can be interpreted as
the element of a vector (e.g., torque or angular velocity vector), the
corresponding vector is directed into the positive direction
of the axis of rotation. In the following figure, the right-most
inertias of the figure above are displayed with the positive
vector direction displayed according to this rule:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/drive3.png\" alt=\"drive3\">
</div>
<p>
The cut-torques <code>J2.flange_a.tau</code>, <code>J4.flange_a.tau</code> and <code>J6.flange_b.tau</code>
of the right inertias are all identical and are directed into the
direction of rotation if the values are positive. Similarly,
the angular velocities <code>J2.w</code>, <code>J4.w</code> and <code>J6.w</code> of the right inertias
are all identical and are also directed into the
direction of rotation if the values are positive. Some special
cases are shown in the next figure:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/drive4.png\" alt=\"drive4\">
</div>

<p>
In the upper part of the figure, two variants of the connection of an
external torque and an inertia are shown. In both cases, a positive
signal input into the torque component accelerates the inertias
<code>inertia1</code> and <code>inertia2</code> into the positive axis of rotation,
i.e., the angular accelerations <code>inertia1.a</code> and <code>inertia2.a</code>
are positive and are directed along the &quot;axis of rotation&quot; arrow.
In the lower part of the figure the connection of inertias with
a planetary gear is shown. Note, that the three flanges of the
planetary gearbox are located along the axis of rotation and that
the axis direction determines the positive rotation along these
flanges. As a result, the positive rotation for <code>inertia4</code> and <code>inertia6</code>
is as indicated with the additional black arrows.
</p>
</html>"));

end SignConventions;
