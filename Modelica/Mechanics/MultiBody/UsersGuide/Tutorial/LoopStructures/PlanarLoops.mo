within Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures;
class PlanarLoops "Planar loops"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<p>
In the figure below, the model of a V6 engine is
shown that has a simple combustion model. It is available as
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6\">
MultiBody.Examples.Loops.EngineV6</a>.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_1.png\">
</div>

<p>
The Modelica schematic of one cylinder
is given in the figure below. Connecting 6 instances of this
cylinder appropriately together results in the engine schematic displayed
above.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_2.png\">
</div>

<p>
In the next figure the animation of the engine is
shown. Every cylinder consists essentially of 1 prismatic and 2 revolute
joints that form a planar loop, since the axes of the two revolute joints are
parallel to each other and the axis of the prismatic joint is orthogonal to
the revolute joint axes. All 6 cylinders together form a coupled set of 6
loops that have together 1 degree of freedom.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_3.png\" width=\"303\" height=\"136\">
</div>

<p>
All planar loops, and especially the engine, result in
a DAE (= Differential-Algebraic Equation system)
that does not have a unique solution. The reason is that, e.g., the cut
forces in direction of the axes of the revolute joints cannot be uniquely
computed. Any value fulfills the DAE equations. This is a structural property
that is determined by the symbolic algorithms. Since they detect that the DAE is
structurally singular, a further processing is not possible. Without
additional information it is also impossible that the symbolic algorithms
could be enhanced because if the axes of rotations of the revolute joints are
only slightly changed such that they are no longer parallel to each other, the
planar loop can no longer move and has 0 degrees of freedom. Algorithms based
on pure structural information cannot distinguish these two cases.
</p>
<p>
The usual remedy is to remove superfluous constraints,
e.g., along the axis of rotation of <strong>one</strong> revolute joint. Since this is
not easy for an inexperienced modeler, the special joint:
<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.RevolutePlanarLoopConstraint\">
RevolutePlanarLoopConstraint</a> is provided that removes these constraints.
Exactly one revolute joint in a every planar loop must be replaced by this
joint type. In the engine example, this special joint is used for
the revolute joint B2 in the cylinder model above. The icon of the joint is
slightly different to other revolute joints to visualize this case.
</p>
<p>
If a modeler is not aware of the problems with planar
loops and models them without special consideration, a Modelica
translator displays an error
message and points out that a planar loop may be the reason and suggests to
use the RevolutePlanarLoopConstraint joint.
This error message is due to an annotation in
the Frame connector.
</p>
<blockquote><pre>
<strong>connector</strong> Frame
   ...
   <strong>flow</strong> SI.Force f[3] <strong>annotation</strong>(unassignedMessage=\"...\");
<strong>end</strong> Frame;
</pre></blockquote>
<p>
If no assignment can be found for some
forces in a connector, the \"unassignedMessage\" is displayed. In most cases the
reason for this is a planar loop or two joints that constrain the same motion.
Both cases are discussed in the error message.
</p>
<p>
Note, that the non-linear algebraic equations occurring
in planar loops can be solved analytically in most cases and therefore it is
highly recommended to use the techniques discussed in section
\"<a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling\">Analytic loop handling</a>\"
for such systems.
</p>
</html>"));
end PlanarLoops;
