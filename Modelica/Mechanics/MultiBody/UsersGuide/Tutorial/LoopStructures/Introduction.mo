within Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures;
class Introduction "Introduction"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
In principal, no special action is needed, if
loop structures occur (contrary to the ModelicaAdditions.MultiBody library).
An example is presented in the figure below. It is available as
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Fourbar1\">
MultiBody.Examples.Loops.Fourbar1</a>
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/Fourbar1a.png\">
</blockquote>

<p>
This mechanism consists of&nbsp;6 revolute joints and&nbsp;1 prismatic joint and forms a
kinematical loop.
It has one degree of freedom. In the next figure the default animation
is shown. Note, that the axes of the revolute joints are represented by the
red cylinders and that the axis of the prismatic joint is represented by the
red box on the lower right side.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/Fourbar1b.png\" width=\"300\">
</blockquote>

<p>
Whenever loop structures occur, non-linear algebraic
equations are present on \"position level\". It is then usually not possible by
structural analysis to select states during translation (which is possible for
non-loop structures). In the example above, a non-linear
algebraic loop of 54 equations can be detected and reduced to a system of&nbsp;6 coupled
algebraic equations. Note, that this is performed without using any
\"cut-joints\" as it is usually done in multi-body programs, but by just
appropriate symbolic equation manipulation. Via the dynamic dummy derivative
method the generalized coordinates on position and velocity level from one of
the&nbsp;7 joints are dynamically selected as states during simulation. Whenever,
these two states are no longer appropriate, states from one of the other
joints are selected during simulation.
</p>
<p>
The efficiency of loop structures can usually be
enhanced, if states are statically fixed at translation time. For this
mechanism, the generalized coordinates of joint j1 (i.e., the
rotation angle of the revolute joint and its derivative;
the joint is visualized as a red cylinder at the x-axis in the animation figure above)
can always be used as states.
In the abovementioned example, this is already stated by setting parameter
\"stateSelect&nbsp;=&nbsp;<strong>StateSelect.always</strong>\"
in the \"Advanced\" menu of that joint.
When setting this flag for joint j1 in that way in
the four bar mechanism, a non-linear algebraic loop of 40
equations can be detected and reduced to a system of&nbsp;5 coupled non-linear algebraic
equations.
</p>
<p>
In many mechanisms it is possible to solve the non-linear algebraic
equations analytically. For a certain class of systems this can
be performed also with the MultiBody library. This technique
is described in section
\"<a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling\">Analytic loop handling</a>\".
</p>
</html>"));
end Introduction;
