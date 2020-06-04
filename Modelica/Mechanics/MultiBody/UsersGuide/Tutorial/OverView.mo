within Modelica.Mechanics.MultiBody.UsersGuide.Tutorial;
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

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/DoublePendulumSmall.png\">

<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/UsersGuide/Tutorial/DoublePendulumDiagramSmall.png\" alt=\"double pendulum (diagram layer)\">
</div>

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
