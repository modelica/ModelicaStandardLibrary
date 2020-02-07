within Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures;
class AnalyticLoopHandling "Analytic loop handling"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>
<p>
It is well known that the non-linear
algebraic equations of most mechanical loops in technical devices can be
solved analytically. It is, however, difficult to perform this fully
automatically and therefore none of the commercial, general purpose multi-body
programs, such as MSC ADAMS, LMS DADS, SIMPACK, have this feature.
These programs solve loop structures with pure numerical methods. Multi-body
programs that are designed for real-time simulation of the dynamics of
specific vehicles, such as ve-DYNA, usually contain manual implementations
of a particular multi-body system (the vehicle) where the occurring loops are
either analytically solved, if this is possible, or are treated by table
look-up where the tables are constructed in a pre-processing phase. Without
these features the required real-time capability would be difficult to
achieve.
</p>
<p>
In a series of papers and dissertations
Prof. Hiller and his group in Duisburg, Germany,
have developed systematic methods to handle mechanical
loops analytically, see also
<a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Literature\">MultiBody.UsersGuide.Literature</a>.
The \"characteristic pair of joints\" method
basically cuts a loop at two joints and uses geometric
invariants to reduce the number of algebraic
equations, often down to one equation that can be solved analytically. Also
several multi-body codes have been developed that are based on this method,
e.g., MOBILE. Besides the very desired feature to solve non-linear
algebraic equations analytically, i.e., efficiently and in a robust way, there
are several drawbacks: It is difficult to apply this method automatically.
Even if this would be possible in a good way, there is always the problem that
it cannot be guaranteed that the statically selected states lead to no
singularity during simulation. Therefore, the \"characteristic pair of joints\"
method is usually manually applied which requires know-how and experience.
</p>
<p>
In the MultiBody library, the \"characteristic pair of
joints\" method is supported in a restricted form such that it can be applied
also by non-specialists. The idea is to provide aggregations of joints in package
<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies\">
MultiBody.Joints.Assemblies</a>
as one object that either have <strong>6</strong> degrees of freedom or
<strong>3</strong> degrees of freedom (for usage in planar loops).
</p>
<p>
As an example, a variant of the four bar mechanism is given in
the figure below.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/FourbarAnalytic2.png\">
</blockquote>

<p>
Here, the mechanism is modeled with six revolute
joints and one prismatic joint.
In the figure below, the five revolute joints
and the prismatic joint are collected together in an assembly object
called \"jointSSP\" from
<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointSSP\">
MultiBody.Joints.Assemblies.JointSSP</a>.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/FourbarAnalytic1.png\">
</blockquote>

<p>
The JointSSP joint aggregation has a frame at the
outer spherical joint (frame_a) and a frame at
the prismatic joint (frame_b). JointSSP, as all other objects from the
Joints.Assemblies package, has the property, that the <strong>generalized
coordinates, and all other frames
defined in the assembly, can be calculated given the movement of frame_a and
of frame_b</strong>. This is performed by <strong>analytically</strong> solving non-linear
systems of equations.
<!-- (details are given in section xxx). -->
From a
structural point of view, the equations in an assembly object are written in
the form
</p>
<blockquote>
  <strong>q</strong> = <strong>
  f</strong><sub>1</sub>(<strong>r</strong><sup>a</sup>, <strong>R</strong><sup>a</sup>, <strong>r</strong><sup>b</sup>,
  <strong>R</strong><sup>b</sup>)
</blockquote>
<p>
where <strong>r</strong><sup>a</sup>, <strong>R</strong><sup>a</sup>,
<strong>r</strong><sup>b</sup>, <strong>R</strong><sup>b</sup> are the variables defining the
position and orientation of the frame_a and frame_b, respectively, and
<strong>q</strong> are the generalized positional coordinates inside the
assembly, e.g., the angle of a revolute joint. Given angle
<span style=\"font-family:Symbol\">j</span> of revolute joint j1 from the four
bar mechanism, frame_a and frame_b of the assembly object can be computed by a
forward recursion
</p>
<blockquote>
(<strong>r</strong><sup>a</sup>,
<strong>R</strong><sup>a</sup>, <strong>r</strong><sup>b</sup>, <strong>R</strong><sup>b</sup>) = <strong>f</strong>(<span style=\"font-family:Symbol\">j)</span>
</blockquote>
<p>
Since this is a structural property, the
symbolic algorithms can automatically select <span style=\"font-family:Symbol\">
j</span> and its derivative as states and then all positional variables can be
computed in a forwards sequence. It is now understandable that a Modelica
translator can
transform the equations of the four bar mechanism to a recursive sequence of
statements that has no non-linear algebraic loops anymore (remember,
the previous \"straightforward\" solution with 6 revolute joints and 1
prismatic joint has a nonlinear system of equations of order 5).
</p>
<p>
The aggregated joint
objects consist of a combination of either a revolute or prismatic joint and
of a rod that has either two spherical joints at its two ends or a spherical
and a universal joint, respectively. For all combinations, analytic solutions
can be determined. For planar loops, combinations of 1, 2 or 3 revolute joints
with parallel axes and of 2 or 1 prismatic joint with axes that are orthogonal
to the revolute joints can be treated analytically. The currently supported
combinations are listed in the table below.
</p>
<div align=\"left\">
    <table border=\"1\" cellspacing=\"0\" cellpadding=\"0\">
      <tr>
        <td colspan=\"2\"> <strong>3-dimensional Loops:</strong></td>
      </tr>
      <tr>
        <td>JointSSR</td>
        <td>Spherical - Spherical - Revolute</td>
      </tr>
      <tr>
        <td>JointSSP</td>
        <td>Spherical - Spherical - Prismatic</td>
      </tr>
      <tr>
        <td>JointUSR</td>
        <td>Universal - Spherical - Revolute</td>
      </tr>
      <tr>
        <td>JointUSP</td>
        <td>Universal - Spherical - Prismatic</td>
      </tr>
      <tr>
        <td>JointUPS</td>
        <td>Universal - Prismatic - Spherical</td>
      </tr>
      <tr>
        <td colspan=\"2\"><strong>Planar Loops:</strong></td>
      </tr>
      <tr>
        <td>JointRRR</td>
        <td>Revolute - Revolute - Revolute</td>
      </tr>
      <tr>
        <td>JointRRP</td>
        <td>Revolute - Revolute - Prismatic</td>
      </tr>
</table>
</div>
<p>
On first view this seems to be quite restrictive. However, mechanical devices are usually built up with rods connected by spherical joints on each end,
and additionally with revolute and prismatic joints.
Therefore, the combinations of the above table occur frequently.
The universal joint is usually not present in actual devices but is used
(a) if two JointXXX components can be connected such that a revolute
and a universal joint together form a spherical joint
and (b) if the orientation of the connecting rod between two
spherical joints is needed, e.g., since a body shall be attached.
In this case one of the spherical joints might be replaced by a
universal joint. This approximation is fine as long as the mass
and inertia of the rod is not significant.
</p>
<p>
Let us discuss item (a) in more detail: The
MacPherson suspension in the next figure has three frame connectors.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/MacPherson1.png\">
</blockquote>

<p>
The lower left one (frameChassis) is fixed to the vehicle chassis. The
upper left one (frameSteering) is driven by the steering mechanism, i.e. the
movement of both frames are given. The frame connector on the right (frameWheel)
drives the wheel. The three frames are connected by a mechanism consisting
essentially of two rods with spherical joints on both ends. These are built up
by a jointUPS and a jointSSR assemblies.
As can be seen, the universal joint from the jointUPS
assembly is connected to the revolute joint of the jointSSR assembly.
Therefore, we have 3 revolute joints connected together at one point and if
the axes of rotations are chosen appropriately, this describes a spherical
joint. In other words, the two connected assemblies define the desired two
rods with spherical joints on each ends.
</p>
<p>
The movement of the chassis, frameChassis, is computed
outside of the suspension model. When the generalized coordinates of revolute joint
\"jointArm\" (lower left part in figure) are used as states, then frame_a and
frame_b of the jointUPS joint can be calculated. After the non-linear loop
with jointUPS is (analytically) solved, all frames on this assembly are
known, especially,
the one connected to frame_b of the jointSSR assembly. Since frame_a of
jointSSR is connected to frameSteering which is computed from the steering
mechanism, again the two required frame movements of the jointSSR assembly are
calculated. This in turn means that also all other frames on the jointSSR
assembly can be computed, especially, the one connected to frameWheel that drives
the wheel. From this analysis it is clear that a tool is able to solve these
coupled loops analytically.
</p>
<p>
Another example is the model of the V6 engine,
see next figure for an animation view and the original definition
of one cylinder with elementary joints.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_3.png\" width=\"303\" height=\"136\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_2.png\">
</blockquote>

<p>
Here, it is sufficient to rewrite the basic cylinder model
by replacing the joints with a JointRRP object that has two
revolute and one prismatic joint, as can be seen in next figure.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_4.png\">
</blockquote>

<p>
Since 6
cylinders are connected together, 6 coupled loops with 6 JointRRP objects are
present. This model is available as
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6_analytic\">
MultiBody.Examples.Loops.EngineV6_analytic</a>.
</p>
<p>
The composition diagram of the connected 6 cylinders is
shown in the next figure
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_1.png\">
</blockquote>
<p>
It can be seen that the revolute joint
of the crank shaft (joint \"bearing\" in left part of figure) might be
selected as degree of freedom. Then, the&nbsp;4 connector frames of all cylinders
can be computed. As a result, the computations of the cylinders are decoupled
from each other. Within one cylinder
the position of frame_a and frame_b of the jointRRP assembly
can be computed and therefore the generalized coordinates of the two revolute
and the prismatic joint in the jointRRP object can be determined. Considering this
analysis, it is not surprising that a Modelica translator
is able to transform the DAE
equations into a sequential evaluation without any non-linear loop.
Compare this nice result with the model using only elementary joints
that leads to a DAE with 6 algebraic loops and 5 non-linear equations per
loop. Additionally, a linear system of equations of order 43 is present.
The simulation time is about 5 times faster with the analytic loop handling.
</p>
</html>"));
end AnalyticLoopHandling;
