within Modelica.Mechanics;
package MultiBody "Library to model 3-dimensional mechanical systems"
  extends Modelica.Icons.Package;

import SI = Modelica.SIunits;
import Cv = Modelica.SIunits.Conversions;
import C = Modelica.Constants;


package UsersGuide "User's Guide of MultiBody Library"
  extends Modelica.Icons.Information;

  package Tutorial "Tutorial"
    extends Modelica.Icons.Information;

    class OverView "Overview of MultiBody library"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
Library <strong>MultiBody</strong> is a <strong>free</strong> Modelica package providing
3-dimensional mechanical components to model in a convenient way
<strong>mechanical systems</strong>, such as robots, mechanisms, vehicles.
A basic feature is that all components have <strong>animation</strong> information
with appropriate default sizes and colors. A typical screenshot of the
animation of a double pendulum is shown in the figure below, together
with its schematic.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/DoublePendulumSmall.png\">

<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/DoublePendulumDiagramSmall.png\" alt=\"double pendulum (diagram layer)\">
</p>

<p>
Note, that all components - the coordinate system of the world frame,
the gravity acceleration vector, the revolute joints and the
bodies - are visualized in the animation.<br>
This library replaces the long available ModelicaAdditions.MultiBody
library, since it is much more easier to use and more powerful.
The main features of the library are:
</p>
<ul>
<li>About <strong>60 main components</strong>, i.e., joint, force, part,
    body, sensor and visualizer components that are ready to use
    and have useful default animation properties. One-dimensional
    force laws can be defined with components of the Modelica.Mechanics.Rotational
    and of the Modelica.Mechanics.Translational library and can be
    connected via available flange connectors to MultiBody
    components.</li>
<li>About <strong>75 functions</strong> to operate in a convenient way on
    orientation objects, e.g., to transform vector quantities between
    frames, or compute the orientation object of a planar rotation.
    The basic idea is to hide the actual definition of an <strong>orientation</strong>
    by providing essentially an <strong>Orientation</strong> type together with
    <strong>functions</strong> operating on instances of this type. Orientation
    objects based on a 3x3 transformation matrix and on quaternions
    are provided. As a side effect, the equations in all other
    components are simpler and easier to understand.</li>
<li> <strong>A World model</strong> has to be present in every model on top
     level. Here the gravity field is defined (currently: no gravity,
     uniform gravity, point gravity), the visualization of the
     world coordinate system and default settings for animation.
     If a world model is not present, it is automatically provided
     together with a warning message.</li>
<li><strong>Built-in animation properties</strong> of all components, such as
    joints, forces, bodies, sensors. This allows an easy visual
    check of the constructed model. Animation of every component
    can be switched off via a parameter. The animation of a complete
    system can be switched off via one parameter in the <strong>world</strong>
    model. If animation is switched off, all equations related
    to animation are removed from the generated code. This is especially
    important for real-time simulation.</li>
<li><strong>Automatic handling of kinematic loops</strong>.
    Components can be connected together in a nearly arbitrary fashion.
    It does not matter whether components are flipped. This does not
    influence the efficiency. If kinematic loop structures occur,
    this is automatically handled in an efficient way by a new
    technique to transform a certain class of overdetermined sets of
    differential algebraic equations symbolically to a system where
    the number of equations and unknowns are the same (the user need
    <strong>not</strong> cut loops with special cut-joints to construct a
    tree-structure).</li>
<li><strong>Automatic state selection from joints and bodies</strong>.
    Most joints and all bodies have potential states. A Modelica
    translator will use the generalized coordinates
    of joints as states if possible. If this is not possible,
    states are selected from body coordinates. As a consequence,
    strange joints with 6 degrees of freedom are not necessary
    to define a body moving freely in space. An advanced user
    may select states manually from the <strong>Advanced</strong> menu of the
    corresponding components or use a Modelica parameter modification
    to set the \"stateSelect\" attribute directly.</li>
<li> <strong>Analytic solution of kinematic loops</strong>. The non-linear
    equations occurring in kinematic loops are solved <strong>analytically</strong>
    for a large class of mechanisms, such as a 4 bar mechanism,
    a slider-crank mechanism or a MacPherson suspension. This is performed
    by constructing such loops with assembly joints JointXXX,
    available in the Modelica.Mechanics.MultiBody.Joints package. Assembly joints consist
    of 3 joints that have together 6 degrees of freedom, i.e., no
    constraints.They do not have potential states. When the motion
    of the two frame connectors are provided, a non-linear system of
    equation is solved analytically to compute the motion of the 3 joints.
    Analytic loop handling is especially important for real-time simulation.</li>
<li> <strong>Line force components may have mass</strong>.
     Masses of line force components are located on the line on which
     the force is acting. They approximate the mass properties of
     a real physical device by one or two point masses. For example,
     a spring has often significant mass that has to be taken into
     account. If masses are set to zero, the additional code to handle
     these point masses is removed. If the masses are taken into
     account, the calculation overhead is small (the reason is that
     the occurring kinematic loops are analytically solved).</li>
<li> <strong>Force components may be connected directly together</strong>, e.g.,
     3-dimensional springs in series connection. Usually,
     multi-body programs have the restriction that force components
     can only be connected between two bodies. Such restrictions are
     not present in the Modelica multi-body library, since it is
     a fully object-oriented, equation based library. Usually, if
     force components are connected directly together, non-linear
     systems of equations occur. The advantage is often, that this
     may avoid stiff systems that would occur if a small mass has
     to be put in between the two force elements.</li>
<li><strong>Initialization definition is available via menus</strong>.
    Initialization of states in joints and bodies can be
    performed in the parameter menu, <strong>without</strong> typing Modelica
    statements. For non-standard initialization, the usual
    Modelica commands can be used.</li>
<li><strong>Multi-body specific error messages</strong>. Annotations
    and assert statements have been introduced that provide
    in many cases warning or error messages that are related
    to the library components (and not to specific equations
    as it is usual in Modelica libraries). This requires
    appropriate tool support, as it is.</li>
<li><strong>Inverse models</strong> of mechanical systems can be easily
    defined by using motion generators, e.g.,
    Modelica.Mechanics.Rotational.Position. Also, non-standard
    inverse models can be generated, e.g., when elasticity is present
    it might be necessary to differentiate equations several times.</li>
</ul>
</html>"));
    end OverView;

    class FirstExample "A first example"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
As a first example it shall be demonstrated how to build up, simulate
and animate a <strong>simple pendulum</strong>.
</p>
<p>
A simple pendulum consisting of a <strong>body</strong> and a <strong>revolute</strong> joint
with <strong>linear damping</strong> in the joint, is first build-up as
Modelica composition diagram, resulting in:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/FirstExample/PenulumSchematic1.png\"
alt=\"Modelica composition diagram of simple pendulum\">
</p>

<p>
In the following figure the location of the used
model components is shown. Drag these components in the diagram layer
and connect them according to the figure:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/FirstExample/PenulumSchematic2.png\">
</p>

<p>
Every model that uses model components from the MultiBody library
must have an instance of the Modelica.Mechanics.MultiBody.World model on highest level.
The reason is that in the world object the gravity field is defined
(uniform gravity or point gravity), as well as the default sizes of
animation shapes and this information is reported to all used
components. If the World object is missing, a warning message is
printed and an instance of the World object with default settings is
automatically utilized (this feature is defined with annotations).
</p>
<p>
In a second step the parameters of the dragged components need to be
defined. Some parameters are vectors that have to be defined with respect
to a local coordinate system of the corresponding component. The easiest
way to perform this is to define a <strong>reference configuration</strong> of your
multi-body model: In this configuration, the relative coordinates of
all joints are zero. This means that all coordinate systems on all
components are parallel to each other. Therefore, this just means
that all vectors are resolved in the world frame in this configuration.
</p>
<p>
The reference configuration for the simple pendulum shall be defined
in the following way: The y-axis of the world frame is directed
upwards, i.e., the opposite direction of the gravity acceleration.
The x-axis of the world frame is orthogonal to it. The revolute joint
is placed in the origin of the world frame. The rotation axis of the revolute
joint is directed along the z-axis of the world frame. The body is
placed on the x-axis of the world frame (i.e., the rotation angle of the
revolute joint is zero, when the body is on the x-axis).
In the following figures the definition of this reference configuration
is shown in the parameter menus of the revolute joint and the body:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/FirstExample/ActuatedRevolute.png\">
<br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/FirstExample/Body.png\">
</p>

<p>
Translate and simulate the model.
Automatically, all defined components are visualized in
an animation using default absolute or relative sizes
of the components. For example, a body is visualized as
a sphere and as a cylinder. The default size of the sphere is defined
as parameter in the world object. You may change this size
in the \"Animation\" parameter menu of the body (see parameter menu
above). The default size of the cylinder is defined relatively
to the size of the sphere (half of the sphere size).
With default settings, the following animation is defined:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/Pendulum.png\">
</p>

<p>
The world coordinate system is visualized as coordinate system
with axes labels. The direction of the gravity acceleration
vector is shown as green arrow. The red cylinder represents
the rotation axis of the revolute joint and the light blue
shapes represent the body. The center of mass of the body is
in the middle of the light blue sphere.
</p>
</html>"));
    end FirstExample;

    package LoopStructures "Loop structures"
      extends Modelica.Icons.Information;

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
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/Fourbar1b.png\" width=300>
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

      class PlanarLoops "Planar loops"
        extends Modelica.Icons.Information;

        annotation (Documentation(info="<html>
<p>
In the figure below, the model of a V6 engine is
shown that has a simple combustion model. It is available as
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6\">
MultiBody.Examples.Loops.EngineV6</a>.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_1.png\">
</p>

<p>
The Modelica schematic of one cylinder
is given in the figure below. Connecting 6 instances of this
cylinder appropriately together results in the engine schematic displayed
above.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_2.png\">
</p>

<p>
In the next figure the animation of the engine is
shown. Every cylinder consists essentially of 1 prismatic and 2 revolute
joints that form a planar loop, since the axes of the two revolute joints are
parallel to each other and the axis of the prismatic joint is orthogonal to
the revolute joint axes. All 6 cylinders together form a coupled set of 6
loops that have together 1 degree of freedom.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/LoopStructures/EngineV6_3.png\" width=\"303\" height=\"136\">
</p>

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
<pre>
  <strong>connector</strong> Frame
     ...
     <strong>flow</strong> SI.Force f[3] <strong>annotation</strong>(unassignedMessage=\"..\");
  <strong>end</strong> Frame;
</pre>
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
      annotation (Documentation(info="<html>
<p>
The MultiBody library has the feature that all components
can be connected together in a nearly arbitrary fashion.
Therefore, kinematic loop structures pose in principal
no problems. In this section several examples are given,
the special treatment of planar loops is discussed and it is explained
how a kinematic loop structure can be modeled such that the
occurring non-linear algebraic equation systems are solved
analytically. There are the following sub-chapters:
</p>
<ol>
<li><a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.Introduction\">Introduction</a>
</li>
<li><a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.PlanarLoops\">Planar loops</a>.
</li>
<li><a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling\">Analytic loop handling</a>.
</li>
</ol>
</html>"));
    end LoopStructures;

    class ConnectionOfLineForces "Connection of LineForces"
      extends Modelica.Icons.Information;
      annotation (Documentation(info="<html>
<p>
Line force elements, such as a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.Spring\">Spring</a>,
are usually connected between two parts. In fact, this is the only possibility
in most multi-body programs. In an equation based system like Modelica, more
general connections are possible. In particular
<strong>3-dimensional line force</strong> elements can be connected together
in <strong>series</strong> without having a body with mass at the
connection point. This is advantageous since stiff systems can be avoided, say, due to
a stiff spring and a small mass at the connection point.
For an example, see model
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.ThreeSprings\">ThreeSprings</a>:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/ThreeSprings.png\">
</p>

<p>
Here, three springs are connected together at one point, without having a body
at the connection point of the springs. There is one difficulty: In such a situation
the orientation object at the connection point is undefined, because
the springs do not transmit torques. Translation will therefore fail, if three springs
and a body are connected together in this way. To handle such a case, all line force
elements have flags \"fixedRotationAtFrame_a\" and \"fixedRotationAtFrame_b\" in their
\"Advanced\" parameter menu. For example, if \"fixedRotationAtFrame_b = <strong>true</strong>\",
the orientation object at frame_b is explicitly set to a null rotation, i.e.,
</p>

<blockquote><pre>
frame_b.R = Modelica.Mechanics.MultiBody.Frames.nullRotation();
</pre></blockquote>

<p>
This means that the coordinate system in the connection point of the three springs
is always parallel to the world frame. When this option is selected, the corresponding
frame in the line force icon is marked with a red circle and with the text \"R=0\".
This is shown in the next figure, where this option is selected for spring3.frame_b:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/ThreeSpringsDiagramLayer.png\">
</p>

<p>
Note, if this flag is not set to <strong>true</strong>, a translation error will occur.
Due to the usage of overdetermined connectors in the MultiBody library, the error
message will be something like: .
</p>

<blockquote><p>
\"The overdetermined connectors &lt;...&gt; are connected but do not have any root defined\"
</p></blockquote>

<p>
The two flags \"fixedRotationAtFrame_a\" and \"fixedRotationAtFrame_b must be set very carefully
because a wrong definition can lead to a model that simulates, but the simulation
result is wrong. This is the case whenever the movement of the resulting system depends
on the orientation object that was arbitrarily set in parallel to the world frame.
A typical example is shown in the next figure:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/ThreeSprings2DiagramLayer.png\">
</p>

<p>
Here, spring3.frame_b.R is defined to be in parallel to the world frame.
However, this is then also the orientation of fixedTranslation.frame_a, and this
in turn means that the left part of the fixedTranslation object is always in parallel
to the world frame. Since this is not correct, this model
will result in a <strong>wrong simulation result</strong>
This system is mathematically not well-defined and does not have a solution.
The only way to model such a system is by providing a mass and an inertia tensor
to fixedTranslation. Then, the flags are not needed, because the \"connection\"
point of the springs is a body where the absolution position vector and the
orientation matrix of the body-fixed coordinate system are used as states.
</p>

</html>"));
    end ConnectionOfLineForces;

    annotation (DocumentationClass=true, Documentation(info="<html>
<p>
This tutorial provides an introduction into the
MultiBody library.
</p>
<ol>
<li><a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.OverView\">Overview of
MultiBody library</a> summarizes the most important aspects.
</li>
<li><a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.FirstExample\">A first example</a>
  describes in detail all the steps to build a simple pendulum model.
</li>
<li><a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.LoopStructures\">Loop structures</a>
  explains how to model kinematic loops, especially by analytically
  solving non-linear equations.
</li>
<li><a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces\">ConnectionOfLineForces</a>
  explains how to connect line force components directly together.
</li>
</ol>
</html>"));
  end Tutorial;

  class Upgrade "Upgrade from Former Versions"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<p>
If different versions of the MultiBody library are not
compatible to each other, corresponding conversion scripts are
provided. As a result, models build with an older version
of the MultiBody library are automatically converted to the
new version when the model is loaded. The user is prompted
whether automatic conversion shall take place or not.
Problems are not to be expected. Still one should first make
a copy of such a model as backup before the conversion
is performed.
</p>
<p>
<strong>Upgrade from ModelicaAdditions.MultiBody</strong>
</p>
<p>
There is now also a conversion script from the \"old\"
<strong>ModelicaAdditions.MultiBody</strong> library to the
\"new\" Modelica.Mechanics.MultiBody library. This script is also
automatically invoked. Since the differences between the \"old\" and the
\"new\" MultiBody library are so large, not everything is
converted and it might be that some pieces have to
be adapted manually. Still, this script is useful, since
many class names, parameters and modifiers are
automatically converted.
</p>
<p>
Components from the following sublibraries
are automatically converted
to the Modelica.Mechanics.MultiBody library:
</p>
<ul>
<li> ModelicaAdditions.MultiBody.Parts</li>
<li> ModelicaAdditions.MultiBody.Joints</li>
<li> ModelicaAdditions.MultiBody.Forces</li>
<li> Part of ModelicaAdditions.MultiBody.Interfaces</li>
</ul>
<p>
Models using the ModelicaAdditions.MultiBody library
that are programmed with <strong>equations</strong> are only partly converted:
The Frame connectors will be converted to the \"new\"
Frame connectors of the MultiBody library, but the equations
that reference variables of the Frame connectors will
<strong>not</strong> be converted. For a manual conversion, the following
table might be helpful showing how the <strong>variables</strong> of the
\"old\" and the \"new\" <strong>Frame connectors</strong> are
related to each other (resolve2 and angularVelocity2 are
functions from library Modelica.Mechanics.MultiBody.Frames):
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th><strong>ModelicaAdditions.MultiBody.<br>
           Interfaces.Frame_a</strong></th>
    <th><strong>MultiBody.Interfaces.Frame_a</strong></th></tr>
<tr>
  <td>frame_a.<strong>r0</strong></td>
  <td>= frame_a.r_0 (is converted)</td>
</tr>
<tr>
  <td>frame_a.<strong>S</strong></td>
  <td>= transpose(frame_a.R)</td>
</tr>
<tr>
  <td>frame_a.<strong>v</strong></td>
  <td>= resolve2(frame_a.R, <strong>der</strong>(frame_a.r_0))</td>
</tr>
<tr>
  <td>frame_a.<strong>w</strong></td>
  <td>= angularVelocity2(frame_a.R)</td>
</tr>
<tr>
  <td>frame_a.<strong>a</strong></td>
  <td>= resolve2(frame_a.R, <strong>der</strong>(v_0)); v_0 = der(r_0)</td>
</tr>
<tr>
  <td>frame_a.<strong>z</strong></td>
  <td>= <strong>der</strong>(w);  w = angulaVelocity2(frame_a.R)</td>
</tr>
<tr>
  <td>frame_a.<strong>f</strong></td>
  <td>= frame_a.f (no conversion needed)</td>
</tr>
<tr>
  <td>frame_a.<strong>t</strong></td>
  <td>= frame_a.t (no conversion needed)</td>
</tr>
</table>
<p>
<strong>Upgrade from MultiBody 0.99 (and earlier) to 1.0 (and later)</strong>
</p>
<p>
The conversion from MultiBody 0.99 to 1.0 does not work in some rare
cases, where own components are implemented using functions of the
MultiBody.Frames package. In this case, the conversion has to be
performed manually. The changes in 1.0 with regards to 0.99 are:
</p>
<p>
The definition of the Modelica.Mechanics.MultiBody.Frames.Orientation object has changed.
In 0.99 this was just an alias type for a transformation matrix
(now Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.Orientation).
In 1.0 the orientation object is a record holding the
transformation matrix from frame 1 to frame 2 and the angular
velocity of the transformation matrix resolved in frame 2.
The reason is that this allows to compute the angular velocity
in many cases by standard recursive formulas and not by
differentiation of the transformation matrix. This is usually
much more efficient. As a consequence, the following
calls in 0.99 should be changed:
</p>
<pre>
   Frames.angularVelocity1(T,der(T)) -> Frames.angularVelocity1(T)
   Frames.angularVelocity2(T,der(T)) -> Frames.angularVelocity2(T)
   Frames.from_T(T)                  -> Frames.from_T2(T,der(T))
</pre>
</html>"));
  end Upgrade;

  class Literature "Literature"
    extends Modelica.Icons.References;

    annotation (Documentation(info="<html>
<ul>
<li>Technical details of this library are described in the paper:
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E.:</dt>
<dd> <strong>The New Modelica MultiBody Library</strong>.
     Modelica 2003 Conference, Link&ouml;ping, Sweden,
     pp. 311-330, Nov. 3-4, 2003.
     Download from:
     <a href=\"https://www.modelica.org/events/Conference2003/papers/h37_Otter_multibody.pdf\">https://www.modelica.org/events/Conference2003/papers/h37_Otter_multibody.pdf</a>
     </dd>
</dl>
</li>
<li>The method how to describe drive trains with 1-dimensional mechanics
and to mount them on 3-dimensional components without neglecting
dynamical effects is described in:
<dl>
<dt>Schweiger C., and Otter M.:</dt>
<dd> <strong>Modelling 3-dim. Mechanical Effects of 1-dim. Powertrains</strong>.
     Modelica 2003 Conference, Link&ouml;ping, Sweden,
     pp. 149-158, Nov. 3-4, 2003.
     Download from:
<a href=\"https://www.modelica.org/events/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">https://www.modelica.org/events/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf</a>
     </dd>
</dl>
</li>
<li> The method to solve a certain class of kinematic loops
     analytically is based on:
<dl>
<dt>Woernle C.:</dt>
<dd><strong>Ein systematisches Verfahren zur Aufstellung der geometrischen
    Schliessbedingungen in kinematischen Schleifen mit Anwendung
    bei der R&uuml;ckw&auml;rtstransformation f&uuml;r
    Industrieroboter.</strong><br>
    Fortschritt-Berichte VDI, Reihe 18, Nr. 59, Duesseldorf: VDI-Verlag 1988,
    ISBN 3-18-145918-6.<br>&nbsp;</dd>
<dt>Hiller M., and Woernle C.:</dt>
<dd><strong>A Systematic Approach for Solving the Inverse Kinematic
    Problem of Robot Manipulators</strong>.<br>
    Proceedings 7th World Congress Th. Mach. Mech., Sevilla 1987. </dd>
</dl>
</li>
</ul>
</html>"));
  end Literature;

  class Contact "Contact"
    extends Modelica.Icons.Contact;

    annotation (Documentation(info="<html>
<h4>Library officers</h4>

<p>
<strong>Jakub Tobolar</strong> and <a href=\"http://www.robotic.dlr.de/Martin.Otter/\"><strong>Martin Otter</strong></a><br>
Deutsches Zentrum f&uuml;r Luft- und Raumfahrt e.V. (DLR)<br>
Institut f&uuml;r Systemdynamik und Regelungstechnik (DLR-SR)<br>
Forschungszentrum Oberpfaffenhofen<br>
D-82234 Wessling<br>
Germany
</p>

<h4>Acknowledgements</h4>

<ul>
<li> The central idea to handle a certain class of overdetermined, consistent
     set of differential algebraic equations (i.e., there are more equations than
     unknowns) with symbolic transformation algorithms was developed together
     with Hilding Elmqvist and Sven Erik Mattsson, previously at Dassault Syst&egrave;mes AB, Lund, Sweden.
     The MultiBody library is heavily relying on this feature which is a
     prerequisite for a truly \"object-oriented\" multi-body systems library,
     where components can be connected together in any meaningful way.</li>
<li> The Examples.Loops.EngineV6 demo of a six cylinder V6 engine with
     6 planar loops and 1 degree of freedom is from Hilding Elmqvist and
     Sven Erik Mattsson.</li>
<li> Modelica.Mechanics.MultiBody.Forces.LineForceWithMass is based on model
     \"RelativeDistance\" from the Modelica VehicleDynamics library of
     Johan Andreasson from Royal Institute of Technology, Stockholm, Sweden.</li>
<li> The 1-dim. components (Parts.Rotor1D, Parts.BevelGear1D, Mounting1D) and
     Joints.GearConstraints are from Christian Schweiger.</li>
<li> The design of this library is based on work carried out
     in the EU RealSim project (Real-time Simulation for Design of
     Multi-physics Systems) funded by the European Commission within
     the Information Societies Technology (IST) programme under
     contract number IST 1999-11979.
     </li>
</ul>
</html>"));
  end Contact;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
Library <strong>MultiBody</strong> is a <strong>free</strong> Modelica package providing
3-dimensional mechanical components to model in a convenient way
<strong>mechanical systems</strong>, such as robots, mechanisms, vehicles.
This package contains the User's Guide for the MultiBody library.
</p>
<ol>
<li> <a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial\">Tutorial</a>
gives an introduction into the most important aspects of the library.
</li>
<li> <a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Upgrade\">Upgrade</a> describes
  how to upgrade from former versions, especially from the \"old\"
  ModelicaAdditions.MultiBody library.
</li>
<li> <a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Literature\">Literature</a> provides
  references that have been used to design and implement this library.
</li>
<li> <a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Contact\">Contact</a> provides
  information about the author of the library as well as
  acknowledgments.
</li>
</ol>
</html>"));
end UsersGuide;


model World
  "World coordinate system + gravity field + default animation definition"

  import Modelica.Mechanics.MultiBody.Types.GravityTypes;
  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Constants.pi;

  Interfaces.Frame_b frame_b
    "Coordinate system fixed in the origin of the world frame"
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  parameter Boolean enableAnimation=true
    "= true, if animation of all components is enabled";
  parameter Boolean animateWorld=true
    "= true, if world coordinate system shall be visualized" annotation(Dialog(enable=enableAnimation));
  parameter Boolean animateGravity=true
    "= true, if gravity field shall be visualized (acceleration vector or field center)" annotation(Dialog(enable=enableAnimation));
  parameter Boolean animateGround=false
    "= true, if ground plane shall be visualized" annotation(Dialog(enable=enableAnimation));
  parameter Types.AxisLabel label1="x" "Label of horizontal axis in icon";
  parameter Types.AxisLabel label2="y" "Label of vertical axis in icon";
  parameter Types.GravityTypes gravityType=GravityTypes.UniformGravity
    "Type of gravity field" annotation(Evaluate=true);
  parameter SI.Acceleration g=Modelica.Constants.g_n "Constant gravity acceleration"
    annotation (Dialog(enable=gravityType == Modelica.Mechanics.MultiBody.Types.GravityTypes.UniformGravity));
  parameter Types.Axis n={0,-1,0}
    "Direction of gravity resolved in world frame (gravity = g*n/length(n))"
    annotation (Evaluate=true, Dialog(enable=gravityType == Modelica.Mechanics.MultiBody.Types.GravityTypes.UniformGravity));
  parameter Real mue(
    unit="m3/s2",
    min=0) = 3.986004418e14
    "Gravity field constant (default = field constant of earth)"
    annotation (Dialog(enable=gravityType == Modelica.Mechanics.MultiBody.Types.GravityTypes.PointGravity));
  parameter Boolean driveTrainMechanics3D=true
    "= true, if 3-dim. mechanical effects of Parts.Mounting1D/Rotor1D/BevelGear1D shall be taken into account";

  parameter SI.Distance axisLength=nominalLength/2
    "Length of world axes arrows"
    annotation (Dialog(tab="Animation", group="if animateWorld = true", enable=enableAnimation and animateWorld));
  parameter SI.Distance axisDiameter=axisLength/defaultFrameDiameterFraction
    "Diameter of world axes arrows"
    annotation (Dialog(tab="Animation", group="if animateWorld = true", enable=enableAnimation and animateWorld));
  parameter Boolean axisShowLabels=true "= true, if labels shall be shown"
    annotation (Dialog(tab="Animation", group="if animateWorld = true", enable=enableAnimation and animateWorld));
  input Types.Color axisColor_x=Modelica.Mechanics.MultiBody.Types.Defaults.FrameColor
    "Color of x-arrow"
    annotation (Dialog(colorSelector=true,tab="Animation", group="if animateWorld = true", enable=enableAnimation and animateWorld));
  input Types.Color axisColor_y=axisColor_x
    annotation (Dialog(colorSelector=true,tab="Animation", group="if animateWorld = true", enable=enableAnimation and animateWorld));
  input Types.Color axisColor_z=axisColor_x "Color of z-arrow"
    annotation (Dialog(colorSelector=true,tab="Animation", group="if animateWorld = true", enable=enableAnimation and animateWorld));

  parameter SI.Position gravityArrowTail[3]={0,0,0}
    "Position vector from origin of world frame to arrow tail, resolved in world frame"
    annotation (Dialog(tab="Animation", group=
          "if animateGravity = true and gravityType = UniformGravity",
          enable=enableAnimation and animateGravity and gravityType == GravityTypes.UniformGravity));
  parameter SI.Length gravityArrowLength=axisLength/2 "Length of gravity arrow"
    annotation (Dialog(tab="Animation", group=
          "if animateGravity = true and gravityType = UniformGravity",
          enable=enableAnimation and animateGravity and gravityType == GravityTypes.UniformGravity));
  parameter SI.Diameter gravityArrowDiameter=gravityArrowLength/
      defaultWidthFraction "Diameter of gravity arrow" annotation (Dialog(tab=
          "Animation", group=
          "if animateGravity = true and gravityType = UniformGravity",
          enable=enableAnimation and animateGravity and gravityType == GravityTypes.UniformGravity));
  input Types.Color gravityArrowColor={0,230,0} "Color of gravity arrow"
    annotation (Dialog(colorSelector=true, tab="Animation", group=
          "if animateGravity = true and gravityType = UniformGravity",
          enable=enableAnimation and animateGravity and gravityType == GravityTypes.UniformGravity));
  parameter SI.Diameter gravitySphereDiameter=12742000
    "Diameter of sphere representing gravity center (default = mean diameter of earth)"
    annotation (Dialog(tab="Animation", group=
          "if animateGravity = true and gravityType = PointGravity",
          enable=enableAnimation and animateGravity and gravityType == GravityTypes.PointGravity));
  input Types.Color gravitySphereColor={0,230,0} "Color of gravity sphere"
    annotation (Dialog(colorSelector=true, tab="Animation", group=
          "if animateGravity = true and gravityType = PointGravity",
          enable=enableAnimation and animateGravity and gravityType == GravityTypes.PointGravity));

  parameter MultiBody.Types.Axis groundAxis_u=if abs(n[1])>=0.99 then {0,1,0} else {1,0,0}
    "Vector along 1st axis (called u) of ground plane, resolved in world frame (should be perpendicular to gravity direction)"
    annotation (Dialog(
      tab="Animation", group="if animateGround = true and gravityType = UniformGravity",
      enable=enableAnimation and animateGround and gravityType == GravityTypes.UniformGravity));
  parameter Modelica.SIunits.Length groundLength_u=2 "Length of ground plane along groundAxis_u"
    annotation (Dialog(
      tab="Animation", group="if animateGround = true and gravityType = UniformGravity",
      enable=enableAnimation and animateGround and gravityType == GravityTypes.UniformGravity));
  parameter Modelica.SIunits.Length groundLength_v=groundLength_u "Length of ground plane perpendicular to groundAxis_u"
    annotation (Dialog(
      tab="Animation", group="if animateGround = true and gravityType = UniformGravity",
      enable=enableAnimation and animateGround and gravityType == GravityTypes.UniformGravity));
  input Types.Color groundColor={200,200,200}
    "Color of ground plane"
    annotation (Dialog(
      colorSelector=true,
      tab="Animation", group="if animateGround = true and gravityType = UniformGravity",
      enable=enableAnimation and animateGround and gravityType == GravityTypes.UniformGravity));

  parameter SI.Length nominalLength=1 "\"Nominal\" length of multi-body system"
    annotation (Dialog(tab="Defaults"));
  parameter SI.Length defaultAxisLength=nominalLength/5
    "Default for length of a frame axis (but not world frame)"
    annotation (Dialog(tab="Defaults"));
  parameter SI.Length defaultJointLength=nominalLength/10
    "Default for the fixed length of a shape representing a joint"
    annotation (Dialog(tab="Defaults"));
  parameter SI.Length defaultJointWidth=nominalLength/20
    "Default for the fixed width of a shape representing a joint"
    annotation (Dialog(tab="Defaults"));
  parameter SI.Length defaultForceLength=nominalLength/10
    "Default for the fixed length of a shape representing a force (e.g., damper)"
    annotation (Dialog(tab="Defaults"));
  parameter SI.Length defaultForceWidth=nominalLength/20
    "Default for the fixed width of a shape representing a force (e.g., spring, bushing)"
    annotation (Dialog(tab="Defaults"));
  parameter SI.Length defaultBodyDiameter=nominalLength/9
    "Default for diameter of sphere representing the center of mass of a body"
    annotation (Dialog(tab="Defaults"));
  parameter Real defaultWidthFraction=20
    "Default for shape width as a fraction of shape length (e.g., for Parts.FixedTranslation)"
    annotation (Dialog(tab="Defaults"));
  parameter SI.Length defaultArrowDiameter=nominalLength/40
    "Default for arrow diameter (e.g., of forces, torques, sensors)"
    annotation (Dialog(tab="Defaults"));
  parameter Real defaultFrameDiameterFraction=40
    "Default for arrow diameter of a coordinate system as a fraction of axis length"
    annotation (Dialog(tab="Defaults"));
  parameter Real defaultSpecularCoefficient(min=0) = 0.7
    "Default reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Defaults"));
  parameter Real defaultN_to_m(unit="N/m", min=0) = 1000
    "Default scaling of force arrows (length = force/defaultN_to_m)"
    annotation (Dialog(tab="Defaults"));
  parameter Real defaultNm_to_m(unit="N.m/m", min=0) = 1000
    "Default scaling of torque arrows (length = torque/defaultNm_to_m)"
    annotation (Dialog(tab="Defaults"));

  replaceable function gravityAcceleration =
       Modelica.Mechanics.MultiBody.Forces.Internal.standardGravityAcceleration (
           gravityType=gravityType, g=g*Modelica.Math.Vectors.normalizeWithAssert(n), mue=mue)
       constrainedby Modelica.Mechanics.MultiBody.Interfaces.partialGravityAcceleration
    "Function to compute the gravity acceleration, resolved in world frame"
       annotation(choicesAllMatching=true,Dialog(enable=gravityType==
                   Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity),
    Documentation(info="<html>
<p>Replaceable function to define the gravity field.
   Default is function
   <a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.Internal.standardGravityAcceleration\">standardGravityAcceleration</a>
   that provides some simple gravity fields (no gravity, constant parallel gravity field,
   point gravity field).
   By redeclaring this function, any type of gravity field can be defined, see example
     <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.UserDefinedGravityField\">Examples.Elementary.UserDefinedGravityField</a>.
</p>
</html>"));

  /* The World object can only use the Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape model, but no
     other models in package Modelica.Mechanics.MultiBody.Visualizers, since the other models access
     data of the "outer Modelica.Mechanics.MultiBody.World world" object, i.e., there are
     mutually dependent classes. For this reason, the higher level visualization
     objects cannot be used.
  */
protected
  parameter Integer ndim=if enableAnimation and animateWorld then 1 else 0;
  parameter Integer ndim2=if enableAnimation and animateWorld and
      axisShowLabels then 1 else 0;

  // Parameters to define axes
  parameter SI.Length headLength=min(axisLength, axisDiameter*Types.Defaults.
      FrameHeadLengthFraction);
  parameter SI.Length headWidth=axisDiameter*Types.Defaults.
      FrameHeadWidthFraction;
  parameter SI.Length lineLength=max(0, axisLength - headLength);
  parameter SI.Length lineWidth=axisDiameter;

  // Parameters to define axes labels
  parameter SI.Length scaledLabel=Modelica.Mechanics.MultiBody.Types.Defaults.FrameLabelHeightFraction*
      axisDiameter;
  parameter SI.Length labelStart=1.05*axisLength;

  // x-axis
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape x_arrowLine(
    shapeType="cylinder",
    length=lineLength,
    width=lineWidth,
    height=lineWidth,
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    color=axisColor_x,
    specularCoefficient=0) if enableAnimation and animateWorld;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape x_arrowHead(
    shapeType="cone",
    length=headLength,
    width=headWidth,
    height=headWidth,
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    color=axisColor_x,
    r={lineLength,0,0},
    specularCoefficient=0) if enableAnimation and animateWorld;
  Modelica.Mechanics.MultiBody.Visualizers.Internal.Lines x_label(
    lines=scaledLabel*{[0, 0; 1, 1],[0, 1; 1, 0]},
    diameter=axisDiameter,
    color=axisColor_x,
    r_lines={labelStart,0,0},
    n_x={1,0,0},
    n_y={0,1,0},
    specularCoefficient=0) if enableAnimation and animateWorld and axisShowLabels;

  // y-axis
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape y_arrowLine(
    shapeType="cylinder",
    length=lineLength,
    width=lineWidth,
    height=lineWidth,
    lengthDirection={0,1,0},
    widthDirection={1,0,0},
    color=axisColor_y,
    specularCoefficient=0) if enableAnimation and animateWorld;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape y_arrowHead(
    shapeType="cone",
    length=headLength,
    width=headWidth,
    height=headWidth,
    lengthDirection={0,1,0},
    widthDirection={1,0,0},
    color=axisColor_y,
    r={0,lineLength,0},
    specularCoefficient=0) if enableAnimation and animateWorld;
  Modelica.Mechanics.MultiBody.Visualizers.Internal.Lines y_label(
    lines=scaledLabel*{[0, 0; 1, 1.5],[0, 1.5; 0.5, 0.75]},
    diameter=axisDiameter,
    color=axisColor_y,
    r_lines={0,labelStart,0},
    n_x={0,1,0},
    n_y={-1,0,0},
    specularCoefficient=0) if enableAnimation and animateWorld and axisShowLabels;

  // z-axis
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape z_arrowLine(
    shapeType="cylinder",
    length=lineLength,
    width=lineWidth,
    height=lineWidth,
    lengthDirection={0,0,1},
    widthDirection={0,1,0},
    color=axisColor_z,
    specularCoefficient=0) if enableAnimation and animateWorld;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape z_arrowHead(
    shapeType="cone",
    length=headLength,
    width=headWidth,
    height=headWidth,
    lengthDirection={0,0,1},
    widthDirection={0,1,0},
    color=axisColor_z,
    r={0,0,lineLength},
    specularCoefficient=0) if enableAnimation and animateWorld;
  Modelica.Mechanics.MultiBody.Visualizers.Internal.Lines z_label(
    lines=scaledLabel*{[0, 0; 1, 0],[0, 1; 1, 1],[0, 1; 1, 0]},
    diameter=axisDiameter,
    color=axisColor_z,
    r_lines={0,0,labelStart},
    n_x={0,0,1},
    n_y={0,1,0},
    specularCoefficient=0) if enableAnimation and animateWorld and axisShowLabels;

  // Uniform gravity visualization
  parameter SI.Length gravityHeadLength=min(gravityArrowLength,
      gravityArrowDiameter*Types.Defaults.ArrowHeadLengthFraction);
  parameter SI.Length gravityHeadWidth=gravityArrowDiameter*Types.Defaults.ArrowHeadWidthFraction;
  parameter SI.Length gravityLineLength=max(0, gravityArrowLength - gravityHeadLength);
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape gravityArrowLine(
    shapeType="cylinder",
    length=gravityLineLength,
    width=gravityArrowDiameter,
    height=gravityArrowDiameter,
    lengthDirection=n,
    widthDirection={0,1,0},
    color=gravityArrowColor,
    r_shape=gravityArrowTail,
    specularCoefficient=0) if enableAnimation and animateGravity and gravityType == GravityTypes.UniformGravity;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape gravityArrowHead(
    shapeType="cone",
    length=gravityHeadLength,
    width=gravityHeadWidth,
    height=gravityHeadWidth,
    lengthDirection=n,
    widthDirection={0,1,0},
    color=gravityArrowColor,
    r_shape=gravityArrowTail + Modelica.Math.Vectors.normalize(
                                                n)*gravityLineLength,
    specularCoefficient=0) if enableAnimation and animateGravity and gravityType == GravityTypes.UniformGravity;

  // Point gravity visualization
  parameter Integer ndim_pointGravity=if enableAnimation and animateGravity
       and gravityType == GravityTypes.UniformGravity then 1 else 0;
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape gravitySphere(
    shapeType="sphere",
    r_shape={-gravitySphereDiameter/2,0,0},
    lengthDirection={1,0,0},
    length=gravitySphereDiameter,
    width=gravitySphereDiameter,
    height=gravitySphereDiameter,
    color=gravitySphereColor,
    specularCoefficient=0) if enableAnimation and animateGravity and gravityType == GravityTypes.PointGravity;

/*
  function gravityAcceleration = gravityAccelerationTypes (
      gravityType=gravityType,
      g=g*Modelica.Math.Vectors.normalize(
                                     n),
      mue=mue);
*/

  // Ground plane visualization
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface surface(
    final multiColoredSurface=false,
    final wireframe=false,
    final color=groundColor,
    final specularCoefficient=0,
    final transparency=0,
    final R=Modelica.Mechanics.MultiBody.Frames.absoluteRotation(
      Modelica.Mechanics.MultiBody.Frames.from_nxy(n, groundAxis_u),
      Modelica.Mechanics.MultiBody.Frames.axesRotations({1,2,3}, {pi/2,pi/2,0}, {0,0,0})),
    final r_0=zeros(3),
    final nu=2,
    final nv=2,
    redeclare function surfaceCharacteristic =
      Modelica.Mechanics.MultiBody.Visualizers.Advanced.SurfaceCharacteristics.rectangle(
      lu=groundLength_u, lv=groundLength_v)) if
      enableAnimation and animateGround and gravityType == GravityTypes.UniformGravity;
equation
  Connections.root(frame_b.R);

  assert(Modelica.Math.Vectors.length(
                       n) > 1e-10,
    "Parameter n of World object is wrong (length(n) > 0 required)");
  frame_b.r_0 = zeros(3);
  frame_b.R = Frames.nullRotation();
  annotation (
    defaultComponentName="world",
    defaultComponentPrefixes="inner",
    missingInnerMessage="No \"world\" component is defined. A default world
component with the default gravity field will be used
(g=9.81 in negative y-axis). If this is not desired,
drag Modelica.Mechanics.MultiBody.World into the top level of your model.",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-100,-118},{-100,61}},
          thickness=0.5),
        Polygon(
          points={{-100,100},{-120,60},{-80,60},{-100,100},{-100,100}},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-119,-100},{59,-100}},
          thickness=0.5),
        Polygon(
          points={{99,-100},{59,-80},{59,-120},{99,-100}},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,145},{150,105}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{95,-113},{144,-162}},
          textString="%label1"),
        Text(
          extent={{-170,127},{-119,77}},
          textString="%label2"),
        Line(points={{-56,78},{-56,-26}}, color={0,0,255}),
        Polygon(
          points={{-68,-26},{-56,-66},{-44,-26},{-68,-26}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{2,78},{2,-26}}, color={0,0,255}),
        Polygon(
          points={{-10,-26},{2,-66},{14,-26},{-10,-26}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(points={{66,80},{66,-26}}, color={0,0,255}),
        Polygon(
          points={{54,-26},{66,-66},{78,-26},{54,-26}},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255})}),
    Documentation(info="<html>
<p>
Model <strong>World</strong> represents a global coordinate system fixed in
ground. This model serves several purposes:
</p>
<ul>
<li> It is used as <strong>inertial system</strong> in which
     the equations of all elements of the MultiBody library
     are defined.</li>
<li> It is the world frame of an <strong>animation window</strong> in which
     all elements of the MultiBody library are visualized.</li>
<li> It is used to define the <strong>gravity field</strong> in which a
     multi-body model is present. Default is a uniform gravity
     field where the gravity acceleration vector g is the
     same at every position. Additionally, a point gravity field or no
     gravity can be selected. Also, function gravityAcceleration can
     be redeclared to a user-defined function that computes the gravity
     acceleration, see example
     <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.UserDefinedGravityField\">Examples.Elementary.UserDefinedGravityField</a>.
     </li>
<li> It is used to define <strong>default settings</strong> of animation properties
     (e.g., the diameter of a sphere representing by default
     the center of mass of a body, or the diameters of the cylinders
     representing a revolute joint).</li>
<li> It is used to define a <strong>visual representation</strong> of the
     world model (= 3 coordinate axes with labels), of the defined
     gravity field and of a ground plane perpendicular to the gravity direction.<br>
    <img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/world.png\" alt=\"MultiBody.World\">
</li>
</ul>
<p>
Since the gravity field function is required from all bodies with mass
and the default settings of animation properties are required
from nearly every component, exactly one instance of model World needs
to be present in every model on the top level. The basic declaration
needs to be:
</p>

<blockquote><pre>
<strong>inner</strong> Modelica.Mechanics.MultiBody.World world
</pre></blockquote>

<p>
Note, it must be an <strong>inner</strong> declaration with instance name <strong>world</strong>
in order that this world object can be accessed from all objects in the
model. When dragging the \"World\" object from the package browser into
the diagram layer, this declaration is automatically generated
(this is defined via annotations in model World).
</p>
<p>
All vectors and tensors of a mechanical system are resolved in a
frame that is local to the corresponding component. Usually,
if all relative joint coordinates vanish, the local frames
of all components are parallel to each other, as well as to the
world frame (this holds as long as a Parts.FixedRotation,
component is <strong>not</strong> used). In this \"reference configuration\"
it is therefore
alternatively possible to resolve all vectors in the world
frame, since all frames are parallel to each other.
This is often very convenient. In order to give some visual
support in such a situation, in the icon of a World instance
two axes of the world frame are shown and the labels
of these axes can be set via parameters.
</p>
</html>"));
end World;


annotation (
  Documentation(info="<html>
<p>
Library <strong>MultiBody</strong> is a <strong>free</strong> Modelica package providing
3-dimensional mechanical components to model in a convenient way
<strong>mechanical systems</strong>, such as robots, mechanisms, vehicles.
Typical animations generated with this library are shown
in the next figure:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/MultiBody.png\">
</p>

<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide\">MultiBody.UsersGuide</a>
     discusses the most important aspects how to use this library.</li>
<li> <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples\">MultiBody.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>

<p>
Copyright &copy; 1998-2018, Modelica Association and DLR.
</p>
<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Polygon(
          points={{-58,76},{6,76},{-26,50},{-58,76}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-26,50},{28,-50}}),
        Ellipse(
          extent={{-4,-14},{60,-78}},
          lineColor={135,135,135},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255})}));
end MultiBody;
