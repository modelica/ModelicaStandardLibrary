within Modelica.Mechanics;
package Rotational
  "Library to model 1-dimensional, rotational mechanical systems"
  extends Modelica.Icons.Package;
  import SI = Modelica.SIunits;

  package UsersGuide "User's Guide of Rotational Library"
    extends Modelica.Icons.Information;

    class Overview "Overview"
      extends Modelica.Icons.Information;

      annotation (DocumentationClass=true, Documentation(info="<html>

<p>
This package contains components to model <b>1-dimensional rotational
mechanical</b> systems, including different types of gearboxes,
shafts with inertia, external torques, spring/damper elements,
frictional elements, backlash, elements to measure angle, angular velocity,
angular acceleration and the cut-torque of a flange. In sublibrary
<b>Examples</b> several examples are present to demonstrate the usage of
the elements. Just open the corresponding example model and simulate
the model according to the provided description.
</p>
<p>
A unique feature of this library is the <b>component-oriented</b>
modeling of <b>Coulomb friction</b> elements, such as friction in bearings,
clutches, brakes, and gear efficiency. Even (dynamically) coupled
friction elements, e.g., as in automatic gearboxes, can be handled
<b>without</b> introducing stiffness which leads to fast simulations.
The underlying theory is new and is based on the solution of mixed
continuous/discrete systems of equations, i.e., equations where the
<b>unknowns</b> are of type <b>Real</b>, <b>Integer</b> or <b>Boolean</b>.
Provided appropriate numerical algorithms for the solution of such types of
systems are available in the simulation tool, the simulation of
(dynamically) coupled friction elements of this library is
<b>efficient</b> and <b>reliable</b>.
</p>

<p>
<IMG src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/drive1.png\" ALT=\"drive1\">
</p>

<p>
A simple example of the usage of this library is given in the
figure above. This drive consists of a shaft with inertia J1=0.2 which
is connected via an ideal gearbox with gear ratio=5 to a second shaft
with inertia J2=5. The left shaft is driven via an external,
sinusoidal torque.
The <b>filled</b> and <b>non-filled grey squares</b> at the left and
right side of a component represent <b>mechanical flanges</b>.
Drawing a line between such squares means that the corresponding
flanges are <b>rigidly attached</b> to each other.
By convention in this library, the connector characterized as a
<b>filled</b> grey square is called <b>flange_a</b> and placed at the
left side of the component in the \"design view\" and the connector
characterized as a <b>non-filled</b> grey square is called <b>flange_b</b>
and placed at the right side of the component in the \"design view\".
The two connectors are completely <b>identical</b>, with the only
exception that the graphical layout is a little bit different in order
to distinguish them for easier access of the connector variables.
For example, <code>J1.flange_a.tau</code> is the cut-torque in the connector
<code>flange_a</code> of component <code>J1</code>.
</p>
<p>
The components of this
library can be <b>connected</b> together in an <b>arbitrary</b> way. E.g., it is
possible to connect two springs or two shafts with inertia directly
together, see figure below.
</p>

<p>
<IMG src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/driveConnections1.png\" ALT=\"driveConnections1\"><br>
<IMG src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/driveConnections2.png\" ALT=\"driveConnections2\"><br>
</p>

</html>"));

    end Overview;

    class FlangeConnectors "Flange Connectors"
      extends Modelica.Icons.Information;

      annotation (DocumentationClass=true, Documentation(info="<html>
<p>
A flange is described by the connector class
Interfaces.<b>Flange_a</b>
or Interfaces.<b>Flange_b</b>. As already noted, the two connector
classes are completely identical. There is only a difference in the icons,
in order to easier identify a flange variable in a diagram.
Both connector classes contain the following variables:
</p>
<pre>
   Modelica.SIunits.Angle       phi  \"Absolute rotation angle of flange\";
   <b>flow</b> Modelica.SIunits.Torque tau  \"Cut-torque in the flange\";
</pre>
<p>
If needed, the angular velocity <code>w</code> and the
angular acceleration <code>a</code> of a flange connector can be
determined by differentiation of the flange angle <code>phi</code>:
</p>
<pre>
     w = <b>der</b>(phi);    a = <b>der</b>(w);
</pre>
</html>"));

    end FlangeConnectors;

    class SupportTorques "Support Torques"
      extends Modelica.Icons.Information;

      annotation (DocumentationClass=true, Documentation(info="<html>

<p>The following figure shows examples of components equipped with
a support flange (framed flange in the lower center), which can be used
to fix components on the ground or on other rotating elements or to combine
them with force elements. Via Boolean parameter <b>useSupport</b>, the
support torque is enabled or disabled. If it is enabled, it must be connected.
If it is disabled, it must not be connected.
Enabled support flanges offer, e.g., the possibility to model gearboxes mounted on
the ground via spring-damper-systems (cf. example
<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.ElasticBearing\">ElasticBearing</a>).
</p>

<p>
<IMG src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/bearing.png\" ALT=\"bearing\">
</p>

<p>
Depending on the setting of <b>useSupport</b>, the icon of the corresponding
component is changing, to either show the support flange or a ground mounting.
For example, the two implementations in the following figure give
identical results.
</p>

<p>
<IMG src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/bearing2.png\" ALT=\"bearing2\">
</p>

</html>"));

    end SupportTorques;

    class SignConventions "Sign Conventions"
      extends Modelica.Icons.Information;

      annotation (DocumentationClass=true, Documentation(info="<html>

<p>
The variables of a component of this library can be accessed in the
usual way. However, since most of these variables are basically elements
of <b>vectors</b>, i.e., have a direction, the question arises how the
signs of variables shall be interpreted. The basic idea is explained
at hand of the following figure:
</p>

<p>
<IMG src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/drive2.png\" ALT=\"drive2\">
</p>

<p>
In the figure, three identical drive trains are shown. The only
difference is that the gear of the middle drive train and the
gear as well as the right inertia of the lower drive train
are horizontally flipped with regards to the upper drive train.
The signs of variables are now interpreted in the following way:
Due to the 1-dimensional nature of the model, all components are
basically connected together along one line (more complicated
cases are discussed below). First, one has to define
a <b>positive</b> direction of this line, called <b>axis of rotation</b>.
In the top part of the figure this is characterized by an arrow
defined as <code>axis of rotation</code>. The simple rule is now:
If a variable of a component is positive and can be interpreted as
the element of a vector (e.g., torque or angular velocity vector), the
corresponding vector is directed into the positive direction
of the axis of rotation. In the following figure, the right-most
inertias of the figure above are displayed with the positive
vector direction displayed according to this rule:
</p>

<p>
<IMG src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/drive3.png\" ALT=\"drive3\">
</p>
<p>
The cut-torques <code>J2.flange_a.tau, J4.flange_a.tau, J6.flange_b.tau</code>
of the right inertias are all identical and are directed into the
direction of rotation if the values are positive. Similarly,
the angular velocities <code>J2.w, J4.w, J6.w</code> of the right inertias
are all identical and are also directed into the
direction of rotation if the values are positive. Some special
cases are shown in the next figure:
</p>

<p>
<IMG src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/drive4.png\" ALT=\"drive4\">
</p>

<p>
In the upper part of the figure, two variants of the connection of an
external torque and an inertia are shown. In both cases, a positive
signal input into the torque component accelerates the inertias
<code>inertia1, inertia2</code> into the positive axis of rotation,
i.e., the angular accelerations <code>inertia1.a, inertia2.a</code>
are positive and are directed along the \"axis of rotation\" arrow.
In the lower part of the figure the connection of inertias with
a planetary gear is shown. Note, that the three flanges of the
planetary gearbox are located along the axis of rotation and that
the axis direction determines the positive rotation along these
flanges. As a result, the positive rotation for <code>inertia4, inertia6</code>
is as indicated with the additional grey arrows.
</p>
</html>"));

    end SignConventions;

    class UserDefinedComponents "User Defined Components"
      extends Modelica.Icons.Information;

      annotation (DocumentationClass=true, Documentation(info="<html>
<p>
In this section some hints are given to define your own
1-dimensional rotational components which are compatible with the
elements of this package.
It is convenient to define a new
component by inheritance from one of the following base classes,
which are defined in sublibrary Interfaces:
</p>
<table BORDER=1 CELLSPACING=0 CELLPADDING=2>
<tr><th>Name</th><th>Description</th></tr>
<tr>
  <td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialCompliant\">PartialCompliant</a>
  </td>
  <td valign=\"top\">Compliant connection of two rotational 1-dim. flanges
                   (used for force laws such as a spring or a damper).</td>
</tr>

<tr>
  <td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates\">PartialCompliantWithRelativeStates</a>
  </td>
  <td valign=\"top\"> Same as \"PartialCompliant\", but relative angle and relative speed are
                    defined as preferred states. Use this partial model if the force law
                    needs anyway the relative speed. The advantage is that it is usually better
                    to use relative angles between drive train components
                    as states, especially, if the angle is not limited (e.g., as for drive trains
                    in vehicles).
</td>
</tr>

<tr>
  <td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2\">PartialElementaryTwoFlangesAndSupport2</a>
</td>
  <td valign=\"top\"> Partial model for a 1-dim. rotational gear consisting of the flange of
                    an input shaft, the flange of an output shaft and the support.
  </td>
</tr>

<tr>
  <td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialTorque\">PartialTorque</a>
</td>
  <td valign=\"top\"> Partial model of a torque acting at the flange (accelerates the flange).
  </td>
</tr>

<tr>
  <td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges\">PartialTwoFlanges</a>
</td>
  <td valign=\"top\">General connection of two rotational 1-dim. flanges.
  </td>
</tr>

<tr>
  <td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialAbsoluteSensor\">PartialAbsoluteSensor</a>
</td>
  <td valign=\"top\">Measure absolute flange variables.
  </td>
</tr>

<tr>
  <td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialRelativeSensor\">PartialRelativeSensor</a>
</td>
  <td valign=\"top\">Measure relative flange variables.
  </td>
</tr>
</table>

<p>
The difference between these base classes are the auxiliary
variables defined in the model and the relations between
the flange variables already defined in the base class.
For example, in model <b>PartialCompliant</b> there is no
support flange, whereas in model
<b>PartialElementaryTwoFlangesAndSupport2</b>
there is a support flange.
</p>
<p>
The equations of a mechanical component are vector equations, i.e.,
they need to be expressed in a common coordinate system.
Therefore, for a component a <b>local axis of rotation</b> has to be
defined. All vector quantities, such as cut-torques or angular
velocities have to be expressed according to this definition.
Examples for such a definition are given in the following figure
for an inertia component and a planetary gearbox:
</p>

<p>
<IMG src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/driveAxis.png\" ALT=\"driveAxis\">
</p>

<p>
As can be seen, all vectors are directed into the direction
of the rotation axis. The angles in the flanges are defined
correspondingly. For example, the angle <code>sun.phi</code> in the
flange of the sun wheel of the planetary gearbox is positive,
if rotated in mathematical positive direction (= counter clock
wise) along the axis of rotation.
</p>
<p>
On first view, one may assume that the selected local
coordinate system has an influence on the usage of the
component. But this is not the case, as shown in the next figure:
</p>

<p>
<IMG src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/inertias.png\" ALT=\"inertias\">
</p>

<p>
In the figure the <b>local</b> axes of rotation of the components
are shown. The connection of two inertias in the left and in the
right part of the figure are completely equivalent, i.e., the right
part is just a different drawing of the left part. This is due to the
fact, that by a connection, the two local coordinate systems are
made identical and the (automatically) generated connection equations
(= angles are identical, cut-torques sum-up to zero) are also
expressed in this common coordinate system. Therefore, even if in
the left figure it seems to be that the angular velocity vector of
<code>J2</code> goes from right to left, in reality it goes from
left to right as shown in the right part of the figure, where the
local coordinate systems are drawn such that they are aligned.
Note, that the simple rule stated in section 4 (Sign conventions)
also determines that
the angular velocity of <code>J2</code> in the left part of the
figure is directed from left to right.
</p>
<p>
To summarize, the local coordinate system selected for a component
is just necessary, in order that the equations of this component
are expressed correctly. The selection of the coordinate system
is arbitrary and has no influence on the usage of the component.
Especially, the actual direction of, e.g., a cut-torque is most
easily determined by the rule of section 4. A more strict determination
by aligning coordinate systems and then using the vector direction
of the local coordinate systems, often requires a re-drawing of the
diagram and is therefore less convenient to use.
</p>
</html>"));

    end UserDefinedComponents;

    class RequirementsForSimulationTool "Requirements for Simulation Tools"
      extends Modelica.Icons.Information;

      annotation (DocumentationClass=true, Documentation(info="<html>

<p>
This library is designed in a fully object oriented way in order that
components can be connected together in every meaningful combination
(e.g., direct connection of two springs or two inertias).
As a consequence, most models lead to a system of
differential-algebraic equations of <b>index 3</b> (= constraint
equations have to be differentiated twice in order to arrive at
a state space representation) and the Modelica translator or
the simulator has to cope with this system representation.
According to our present knowledge, this requires that the
Modelica translator is able to symbolically differentiate equations
(otherwise it is e.g., not possible to provide consistent initial
conditions; even if consistent initial conditions are present, most
numerical DAE integrators can cope at most with index 2 DAEs).
</p>
<p>
The elements of this library can be connected together in an
arbitrary way. However, difficulties may occur, if the elements which can <b>lock</b> the
<b>relative motion</b> between two flanges are connected <b>rigidly</b>
together such that essentially the <b>same relative motion</b> can be locked.
The reason is
that the cut-torque in the locked phase is not uniquely defined if the
elements are locked at the same time instant (i.e., there does not exist a
unique solution) and some simulation systems may not be
able to handle this situation, since this leads to a singularity during
simulation. Currently, this type of problem can occur with the
Coulomb friction elements <b>BearingFriction, Clutch, Brake, LossyGear</b> when
the elements become stuck:
</p>
<p>
<IMG src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/driveConnections3.png\" ALT=\"driveConnections3\">
</p>
<p>
In the figure above two typical situations are shown: In the upper part of
the figure, the series connection of rigidly attached BearingFriction and
Clutch components are shown. This does not hurt, because the BearingFriction
element can lock the relative motion between the element and the housing,
whereas the clutch element can lock the relative motion between the two
connected flanges. Contrary, the drive train in the lower part of the figure
may give rise to simulation problems, because the BearingFriction element
and the Brake element can lock the relative motion between a flange and
the housing and these flanges are rigidly connected together, i.e.,
essentially the same relative motion can be locked. These difficulties
may be solved by either introducing a compliance between these flanges
or by combining the BearingFriction and Brake element into
one component and resolving the ambiguity of the frictional torque in the
stuck mode. A tool may handle this situation also <b>automatically</b>,
by picking one solution of the infinitely many, e.g., the one where
the difference to the value of the previous time instant is as small
as possible.
</p>
</html>"));

    end RequirementsForSimulationTool;

    class StateSelection "State Selection"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
Only a few components of the Rotational library use the der(..) operator
and are therefore candidates to have states. Most important, component <a href=\"modelica://Modelica.Mechanics.Rotational.Components.Inertia\">Inertia</a>
defines the absolute rotation angle and the absolute angular velocity of this
component as candidate for states. In the \"Advanced\" menu the built-in StateSelect
enumeration can be set to define the priority to use these variables as states.
Without further action, in most cases a tool will select these variables as states.
</p>

<p>
For positioning drive trains where the goal is to position a load (e.g. the drive
train of a robot, or of an elevator), the absolute angles of the components are bounded,
and the issue discussed below is not present.
</p>

<p>
For drive trains where the goal is to control the velocity of a load (e.g. the drive
train of a vehicle or the crank angle of an engine),
the absolute angles of the components are quickly increasing
during operation. This is critical, because then the step size control of time
integrators might then no longer work appropriately:
</p>

<p>
Integrators with step size control adjust their time step size automatically
to meet user defined error bounds (\"tolerances\").
Typically the local error estimate EST_i is compared with a mixed bound for absolute and relative errors.
</p>

<pre>
   EST_i &le; abstol_i + reltol_i*|x_i|
</pre>

<p>
Here, abstol_i and reltol_i denote the bounds for the absolute and relative error of state variable x_i, respectively. This mixed error bound is used since it is more robust than a pure relative error based error bound if the nominal value x_i  is (very) close to 0.
In a Modelica simulation model, typically the same relative tolerance reltol is used for all
states and the absolute tolerances are computed using the relative tolerance and the
nominal values of the states:
</p>

<pre>
   reltol_i = reltol
   abstol_i = reltol*x_i(nominal)*0.01
</pre>

<p>
This error control fails if the state variable x_i grows without bounds (such as for a
drive train or the crank angle of a vehicle), since then the allowed error
also grows without bounds. The effect is that the error control on this variable is practically
switched off. The correct way to handle this would be to set reltol_i = 0 on such a state
variable and only use an absolute tolerance for the step size control.
</p>

<p>
Currently, in Modelica there is no possibility to provide this information.
In order to reduce this effect, it is advisable to not use absolute angles, but
relative angles as states. A user can define relative variables as states
explicitly with component
<a href=\"modelica://Modelica.Mechanics.Rotational.Components.RelativeStates\">RelativeStates</a>.
Furthermore, all compliant components, such as
<a href=\"modelica://Modelica.Mechanics.Rotational.Components.SpringDamper\">SpringDamper</a> are
defining the relative angle and the relative angular velocity as preferred states.
Therefore, a tool will select in most cases relative angles as states.
</p>

<p>
The relative angles of compliant components are usually small. For example, the
deformation of a typical elastic component is in the order of 1e-4 rad.
Without further action, the error control would not work properly on variables
that are so small (so often switching the error control off). The remedy is to define
explicitly a nominal value on the relative angle. This definition is provided in the
\"Advanced\" menu of the compliant components with parameter \"phi_nominal\".
The default value is 1e-4 rad, to be in the order of a compliant deformation of a
drive. For some components, like
a <a href=\"modelica://Modelica.Mechanics.Rotational.Components.Clutch\">Clutch</a>
this might be too small and a value of phi_nominal=1 might be more appropriate
(a value of phi_nominal = 1e-4 does not hurt, but just makes the error control
unnecessarily stringent).
</p>
</html>"));
    end StateSelection;

    class ModelingOfFriction "Modeling of Friction"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
Several elements of this library model <b>Coulomb friction</b> with the method proposed in:
</p>

<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><b>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</b>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>

<p>
The friction equations are defined in base model
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialFriction\">Interfaces.PartialFriction</a>.
Here are some explanations:
</p>

<p>
Assume first the most simplest friction problem: A block sliding on a surface.
The friction force \"f\" acts between the block surface and the environment surface and shall be a
linear function of the relative velocity \"v\" between the two surfaces.
When the relative velocity becomes zero, the two surfaces are stuck to each other and the friction force is no longer
a function of \"v\". The element starts sliding again if the friction force becomes larger than the maximum
static friction force \"f0\". This element could be defined with a parameterized curve description
leading to the following equations:
</p>

<blockquote><pre>forward  = s &gt; 1;
backward = s &lt; -1;
v = if forward then s-1 elseif backward then s+1 else 0;
f = if forward  then  f0+f1*(s-1) elseif
       backward then -f0+f1*(s+1) else f0*s;
</pre></blockquote>

<p>
This model completely describes the simplified friction element in
a declarative way. Unfortunately, currently it is not known how to transform such
an element description automatically in a form which can be simulated:
</p>

<p>
The block is described by the following equation:
</p>

<blockquote><pre>
m*der(v) = u - f
</pre></blockquote>

<p>
Note, that \"m\" is the mass of the block and \"u(t)\" is the given driving force.
If the element is in its \"forward sliding\" mode, that is s &ge; 1, this model is described by:
</p>

<blockquote><pre>
m*der(v) = u - f
       v = s - 1
       f = f_0 + f_1*(s-1)
</pre></blockquote>

<p>
which can be easily transformed into state space form with \"v\" as the state.
If the block becomes stuck, that is -1 &le; s &le; 1, the equation \"v=0\" becomes
active and therefore \"v\" can no longer be a state, that is an index
change takes place. Besides the difficulty to handle the variable state change,
there is a more serious problem:
</p>

<p>
Assume that the block is stuck and that \"s\" becomes greater than one. Before the event occurs, s &le; 1
and v = 0; at the event instant s &gt; 1 because this relation is the event triggering condition. The element
switches into the forward sliding mode where \"v\" is a state which is initialized with its last value \"v=0\".
Since \"v\" is a state, \"s\" is computed from \"v\" via \"s := v+1\", resulting in \"s=1\", that is the relation
\"s &gt; 1\" becomes false and the element switches back into the stuck mode. In other words, it is never possible to
switch into the forward sliding mode. Taking numerical errors into account, the situation is even worse.
</p>

<p>
The key to the solution is the observation that \"v=0\" in the stuck mode and when forward sliding starts, but
\"der(v) &gt; 0\" when sliding starts and der(v) = 0 in the stuck mode. Since the friction characteristic
at zero velocity is no functional relationship, again a parameterized curve description
with a new curve parameter \"s_a\" has to be used leading to the following equations (note: at zero velocity):
</p>

<blockquote><pre>
startFor  = sa &gt; 1;
startBack = sa &lt; -1;
        a = der(v);
        a = if startFor then sa-1 elseif startBack then sa+1 else 0;
        f = if startFor then f0   elseif startBack then  -f0 else f0*sa;
</pre></blockquote>

<p>
At zero velocity, these equations and the equation of the block form a mixed continuous/discrete set of
equations which has to be solved at event instants (e.g. by a fix point iteration),
When switching from sliding to stuck mode, the velocity is small or zero. Since the derivative of the constraint
equation der(v) = 0 is fulfilled in the stuck mode, the velocity remains small even if v = 0 is not explicitly
taken into account. The approach to use the acceleration der(v) = 0 as \"constraint\" instead of \"v = 0\",
is often used in multi-body software. The benefit is that the velocity \"v\" remains a state in all switching
configurations (there is a small, linear drift, but the friction element would have to stay stuck several days
before the drift becomes too large). Consequently, \"v\" is small but may have any sign when switching
from stuck to sliding mode; if the friction element starts to slide, say in the forward direction, one has
to wait until the velocity is really positive, before switching to forward mode (note, that even for
exact calculation without numerical errors a \"waiting\" phase is necessary, because \"v=0\" when sliding starts).
Since \"der(v) > 0\", this will occur after a small time period. This \"waiting\" procedure can be
described by a state machine. Collecting all the pieces together, finally results in the following equations
of a simple friction element:
</p>

<blockquote><pre>
// part of mixed system of equations
startFor  = pre(mode) == Stuck and sa &gt; 1;
startBack = pre(mode) == Stuck and sa  &lt; -1;
        a = der(v);
        a = if pre(mode) == Forward  or startFor  then  sa - 1    elseif
               pre(mode) == Backward or startBack then  sa + 1    else 0;
        f = if pre(mode) == Forward or startFor   then  f0 + f1*v elseif
               pre(mode) == Backward or startBack then -f0 + f1*v else f0*sa;

// state machine to determine configuration
mode = if (pre(mode) == Forward  or startFor)  and v&gt;0 then Forward  elseif
          (pre(mode) == Backward or startBack) and v&lt;0 then Backward else Stuck;
</pre></blockquote>

<p>
The above approach to model a simplified friction element is slightly generalized in model
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialFriction\">Interfaces.PartialFriction</a>:
</p>

<ul>
<li> The sliding friction force has a nonlinear characteristic instead a linear one,
     by interpolation in a table of f(v) values.</li>
<li> There may be a jump in the friction force when going from stuck to sliding mode
     (described with parameter peak).</li>
</ul>
</html>"));
    end ModelingOfFriction;

    class Contact "Contact"
      extends Modelica.Icons.Contact;

      annotation (Documentation(info="<html>
<dl>
<dt><b>Library Officer</b></dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> <br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik (DLR-RM)<br>
    Abteilung Systemdynamik und Regelungstechnik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br><br></dd>
</dl>

<p>
<b>Contributors to this library:</b>
</p>

<ul>
<li> <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> (DLR-RM)</li>
<li> Christian Schweiger (DLR-RM, until 2006).</li>
<li> <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
     Technical Consulting &amp; Electrical Engineering<br>
     A-3423 St.Andrae-Woerdern, Austria<br>
     email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a></li>
</ul>
</html>"));
    end Contact;

    annotation (DocumentationClass=true, Documentation(info="<html>
<p>
Library <b>Rotational</b> is a <b>free</b> Modelica package providing
1-dimensional, rotational mechanical components to model in a convenient way
drive trains with frictional losses. More details are given in the following
sub-sections:
</p>

<ul>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.Overview\">Overview</a></li>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.FlangeConnectors\">Flange Connectors</a></li>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.SupportTorques\">Support Torques</a></li>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.SignConventions\">Sign Conventions</a></li>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.UserDefinedComponents\">User Defined Components</a></li>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.RequirementsForSimulationTool\">Requirements for Simulation Tools</a></li>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a></li>
<li> <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\">Modeling of Friction</a></li>
</ul>

</html>"));
  end UsersGuide;

  package Examples "Demonstration examples of the components of this package"

    extends Modelica.Icons.ExamplesPackage;

    model First "First example: simple drive train"
      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Torque amplitude=10
        "Amplitude of driving torque";
      parameter SI.Frequency freqHz=5 "Frequency of driving torque";
      parameter SI.Inertia Jmotor(min=0) = 0.1 "Motor inertia";
      parameter SI.Inertia Jload(min=0) = 2 "Load inertia";
      parameter Real ratio=10 "Gear ratio";
      parameter Real damping=10 "Damping in bearing of gear";

      Rotational.Components.Fixed fixed annotation (Placement(transformation(
              extent={{38,-48},{54,-32}})));
      Rotational.Sources.Torque torque(useSupport=true) annotation (Placement(
            transformation(extent={{-68,-8},{-52,8}})));
      Rotational.Components.Inertia inertia1(J=Jmotor) annotation (Placement(
            transformation(extent={{-38,-8},{-22,8}})));
      Rotational.Components.IdealGear idealGear(ratio=ratio, useSupport=true)
        annotation (Placement(transformation(extent={{-8,-8},{8,8}})));
      Rotational.Components.Inertia inertia2(
        J=2,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                22,-8},{38,8}})));
      Rotational.Components.Spring spring(c=1.e4, phi_rel(fixed=true))
        annotation (Placement(transformation(extent={{52,-8},{68,8}})));
      Rotational.Components.Inertia inertia3(J=Jload, w(fixed=true, start=0))
        annotation (Placement(transformation(extent={{82,-8},{98,8}})));
      Rotational.Components.Damper damper(d=damping) annotation (Placement(
            transformation(
            origin={46,-22},
            extent={{-8,-8},{8,8}},
            rotation=270)));
      Modelica.Blocks.Sources.Sine sine(amplitude=amplitude, freqHz=freqHz)
        annotation (Placement(transformation(extent={{-98,-8},{-82,8}})));
    equation
      connect(inertia1.flange_b, idealGear.flange_a)
        annotation (Line(points={{-22,0},{-8,0}}));
      connect(idealGear.flange_b, inertia2.flange_a)
        annotation (Line(points={{8,0},{22,0}}));
      connect(inertia2.flange_b, spring.flange_a)
        annotation (Line(points={{38,0},{52,0}}));
      connect(spring.flange_b, inertia3.flange_a)
        annotation (Line(points={{68,0},{82,0}}));
      connect(damper.flange_a, inertia2.flange_b)
        annotation (Line(points={{46,-14},{46,0},{38,0}}));
      connect(damper.flange_b, fixed.flange)
        annotation (Line(points={{46,-30},{46,-40}}));
      connect(sine.y, torque.tau)
        annotation (Line(points={{-81.2,0},{-69.6,0}}, color={0,0,127}));
      connect(torque.support, fixed.flange)
        annotation (Line(points={{-60,-8},{-60,-40},{46,-40}}));
      connect(idealGear.support, fixed.flange)
        annotation (Line(points={{0,-8},{0,-40},{46,-40}}));
      connect(torque.flange, inertia1.flange_a) annotation (Line(
          points={{-52,0},{-38,0}}));
      annotation (
        Documentation(info="<html>
<p>The drive train consists of a motor inertia which is driven by
a sine-wave motor torque. Via a gearbox the rotational energy is
transmitted to a load inertia. Elasticity in the gearbox is modeled
by a spring element. A linear damper is used to model the
damping in the gearbox bearing.</p>
<p>Note, that a force component (like the damper of this example)
which is acting between a shaft and the housing has to be fixed
in the housing on one side via component Fixed.</p>
<p>Simulate for 1 second and plot the following variables:<br>
   angular velocities of inertias inertia2 and 3: inertia2.w, inertia3.w</p>

</html>"),
        experiment(StopTime=1.0, Interval=0.001));
    end First;

    model FirstGrounded
      "First example: simple drive train with grounded elements"
      extends Modelica.Icons.Example;
      parameter Modelica.SIunits.Torque amplitude=10
        "Amplitude of driving torque";
      parameter SI.Frequency freqHz=5 "Frequency of driving torque";
      parameter SI.Inertia Jmotor(min=0) = 0.1 "Motor inertia";
      parameter SI.Inertia Jload(min=0) = 2 "Load inertia";
      parameter Real ratio=10 "Gear ratio";
      parameter Real damping=10 "Damping in bearing of gear";

      Rotational.Components.Fixed fixed annotation (Placement(transformation(
              extent={{38,-48},{54,-32}})));
      Rotational.Sources.Torque torque(useSupport=false) annotation (Placement(
            transformation(extent={{-68,-8},{-52,8}})));
      Rotational.Components.Inertia inertia1(J=Jmotor) annotation (Placement(
            transformation(extent={{-38,-8},{-22,8}})));
      Rotational.Components.IdealGear idealGear(ratio=ratio, useSupport=false)
        annotation (Placement(transformation(extent={{-8,-8},{8,8}})));
      Rotational.Components.Inertia inertia2(
        J=2,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                22,-8},{38,8}})));
      Rotational.Components.Spring spring(c=1.e4, phi_rel(fixed=true))
        annotation (Placement(transformation(extent={{52,-8},{68,8}})));
      Rotational.Components.Inertia inertia3(J=Jload, w(fixed=true, start=0))
        annotation (Placement(transformation(extent={{82,-8},{98,8}})));
      Rotational.Components.Damper damper(d=damping) annotation (Placement(
            transformation(
            origin={46,-22},
            extent={{-8,-8},{8,8}},
            rotation=270)));
      Modelica.Blocks.Sources.Sine sine(amplitude=amplitude, freqHz=freqHz)
        annotation (Placement(transformation(extent={{-98,-8},{-82,8}})));
    equation
      connect(inertia1.flange_b, idealGear.flange_a)
        annotation (Line(points={{-22,0},{-8,0}}));
      connect(idealGear.flange_b, inertia2.flange_a)
        annotation (Line(points={{8,0},{22,0}}));
      connect(inertia2.flange_b, spring.flange_a)
        annotation (Line(points={{38,0},{52,0}}));
      connect(spring.flange_b, inertia3.flange_a)
        annotation (Line(points={{68,0},{82,0}}));
      connect(damper.flange_a, inertia2.flange_b)
        annotation (Line(points={{46,-14},{46,0},{38,0}}));
      connect(damper.flange_b, fixed.flange)
        annotation (Line(points={{46,-30},{46,-40}}));
      connect(sine.y, torque.tau)
        annotation (Line(points={{-81.2,0},{-69.6,0}}, color={0,0,127}));
      connect(torque.flange, inertia1.flange_a) annotation (Line(
          points={{-52,0},{-38,0}}));
      annotation (Documentation(info="<html>
<p>The drive train consists of a motor inertia which is driven by
a sine-wave motor torque. Via a gearbox the rotational energy is
transmitted to a load inertia. Elasticity in the gearbox is modeled
by a spring element. A linear damper is used to model the
damping in the gearbox bearing.</p>
<p>Note, that a force component (like the damper of this example)
which is acting between a shaft and the housing has to be fixed
in the housing on one side via component Fixed.</p>
<p>Simulate for 1 second and plot the following variables:<br>
   angular velocities of inertias inertia2 and 3: inertia2.w, inertia3.w</p>

</html>"), experiment(StopTime=1.0, Interval=0.001));
    end FirstGrounded;

    model Friction "Drive train with clutch and brake"
      import Modelica.Constants.pi;
      extends Modelica.Icons.Example;
      parameter SI.Time startTime=0.5 "Start time of step";
      output SI.Torque tMotor=torque.tau "Driving torque of inertia3";
      output SI.Torque tClutch=clutch.tau "Friction torque of clutch";
      output SI.Torque tBrake=brake.tau "Friction torque of brake";
      output SI.Torque tSpring=spring.tau "Spring torque";

      Rotational.Sources.Torque torque(useSupport=true) annotation (Placement(
            transformation(extent={{-90,-10},{-70,10}})));
      Rotational.Components.Inertia inertia3(
        J=1,
        phi(
          start=0,
          fixed=true,
          displayUnit="deg"),
        w(start=100,
          fixed=true,
          displayUnit="rad/s")) annotation (Placement(transformation(extent={{-60,
                -10},{-40,10}})));
      Rotational.Components.Clutch clutch(fn_max=160) annotation (Placement(
            transformation(extent={{-30,-10},{-10,10}})));
      Rotational.Components.Inertia inertia2(
        J=0.05,
        phi(start=0, fixed=true),
        w(start=90, fixed=true)) annotation (Placement(transformation(extent={{
                0,-10},{20,10}})));
      Rotational.Components.SpringDamper spring(c=160, d=1) annotation (
          Placement(transformation(extent={{30,-10},{50,10}})));
      Rotational.Components.Inertia inertia1(
        J=1,
        phi(start=0, fixed=true),
        w(start=90, fixed=true)) annotation (Placement(transformation(extent={{
                90,-10},{110,10}})));
      Rotational.Components.Brake brake(fn_max=1600, useSupport=true)
        annotation (Placement(transformation(extent={{60,-10},{80,10}})));
      Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(
            transformation(
            origin={-25,35},
            extent={{-5,-5},{15,15}},
            rotation=270)));
      Modelica.Blocks.Sources.Step step(startTime=startTime) annotation (
          Placement(transformation(
            origin={65,35},
            extent={{-5,-5},{15,15}},
            rotation=270)));
      Modelica.Blocks.Sources.Step step2(
        height=-1,
        offset=1,
        startTime=startTime) annotation (Placement(transformation(extent={{-160,
                -30},{-140,-10}})));
      Modelica.Blocks.Sources.Sine sine(amplitude=200, freqHz=50/pi)
        annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
      Modelica.Blocks.Math.Product product annotation (Placement(transformation(
              extent={{-120,-10},{-100,10}})));
      Rotational.Components.Fixed fixed annotation (Placement(transformation(
              extent={{-10,-30},{10,-10}})));
    equation
      connect(torque.flange, inertia3.flange_a)
        annotation (Line(points={{-70,0},{-70,0},{-60,0}}));
      connect(inertia3.flange_b, clutch.flange_a)
        annotation (Line(points={{-40,0},{-30,0}}));
      connect(clutch.flange_b, inertia2.flange_a)
        annotation (Line(points={{-10,0},{0,0}}));
      connect(inertia2.flange_b, spring.flange_a)
        annotation (Line(points={{20,0},{30,0}}));
      connect(spring.flange_b, brake.flange_a)
        annotation (Line(points={{50,0},{60,0}}));
      connect(brake.flange_b, inertia1.flange_a)
        annotation (Line(points={{80,0},{80,0},{90,0}}));
      connect(sine.y, product.u1) annotation (Line(points={{-139,20},{-130,20},
              {-130,6},{-122,6}}, color={0,0,127}));
      connect(step2.y, product.u2) annotation (Line(points={{-139,-20},{-130,-20},
              {-130,-6},{-126,-6},{-122,-6}}, color={0,0,127}));
      connect(product.y, torque.tau)
        annotation (Line(points={{-99,0},{-99,0},{-92,0}}, color={0,0,127}));
      connect(const.y, clutch.f_normalized) annotation (Line(points={{-20,19},{
              -20,12.75},{-20,11}}, color={0,0,127}));
      connect(step.y, brake.f_normalized)
        annotation (Line(points={{70,19},{70,16},{70,11}}, color={0,0,127}));
      connect(torque.support, fixed.flange)
        annotation (Line(points={{-80,-10},{-80,-20},{0,-20}}));
      connect(brake.support, fixed.flange)
        annotation (Line(points={{70,-10},{70,-20},{0,-20}}));
      annotation (Documentation(info="<html>
<p>This drive train contains a frictional <b>clutch</b> and a <b>brake</b>.
Simulate the system for 1 second using the following initial
values (defined already in the model):</p>
<pre>   inertia1.w =  90 (or brake.w)
   inertia2.w =  90
   inertia3.w = 100
</pre>
<p>Plot the output signals</p>
<pre>   tMotor      Torque of motor
   tClutch     Torque in clutch
   tBrake      Torque in brake
   tSpring     Torque in spring
</pre>
<p>as well as the absolute angular velocities of the three inertia components
(inertia1.w, inertia2.w, inertia3.w).</p>

</html>"), experiment(StopTime=3.0, Interval=0.001),
      Diagram(coordinateSystem(extent = {{-170,-100},{120,100}})));
    end Friction;

    model CoupledClutches "Drive train with 3 dynamically coupled clutches"
      extends Modelica.Icons.Example;
      parameter SI.Frequency freqHz=0.2
        "Frequency of sine function to invoke clutch1";
      parameter SI.Time T2=0.4 "Time when clutch2 is invoked";
      parameter SI.Time T3=0.9 "Time when clutch3 is invoked";

      Rotational.Components.Inertia J1(
        J=1,
        phi(fixed=true, start=0),
        w(start=10, fixed=true)) annotation (Placement(transformation(extent={{
                -70,-10},{-50,10}})));
      Rotational.Sources.Torque torque(useSupport=true) annotation (Placement(
            transformation(extent={{-100,-10},{-80,10}})));
      Rotational.Components.Clutch clutch1(peak=1.1, fn_max=20) annotation (
          Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.Blocks.Sources.Sine sin1(amplitude=10, freqHz=5) annotation (
          Placement(transformation(extent={{-130,-10},{-110,10}})));
      Modelica.Blocks.Sources.Step step1(startTime=T2) annotation (Placement(
            transformation(
            origin={25,35},
            extent={{-5,-5},{15,15}},
            rotation=270)));
      Rotational.Components.Inertia J2(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-10,
                -10},{10,10}})));
      Rotational.Components.Clutch clutch2(peak=1.1, fn_max=20) annotation (
          Placement(transformation(extent={{20,-10},{40,10}})));
      Rotational.Components.Inertia J3(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                50,-10},{70,10}})));
      Rotational.Components.Clutch clutch3(peak=1.1, fn_max=20) annotation (
          Placement(transformation(extent={{80,-10},{100,10}})));
      Rotational.Components.Inertia J4(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{
                110,-10},{130,10}})));
      Modelica.Blocks.Sources.Sine sin2(
        amplitude=1,
        freqHz=freqHz,
        phase=1.57) annotation (Placement(transformation(
            origin={-35,35},
            extent={{-5,-5},{15,15}},
            rotation=270)));
      Modelica.Blocks.Sources.Step step2(startTime=T3) annotation (Placement(
            transformation(
            origin={85,35},
            extent={{-5,-5},{15,15}},
            rotation=270)));
      Rotational.Components.Fixed fixed annotation (Placement(transformation(
              extent={{-100,-30},{-80,-10}})));
    equation
      connect(torque.flange, J1.flange_a)
        annotation (Line(points={{-80,0},{-70,0}}));
      connect(J1.flange_b, clutch1.flange_a)
        annotation (Line(points={{-50,0},{-40,0}}));
      connect(clutch1.flange_b, J2.flange_a)
        annotation (Line(points={{-20,0},{-10,0}}));
      connect(J2.flange_b, clutch2.flange_a)
        annotation (Line(points={{10,0},{10,0},{20,0}}));
      connect(clutch2.flange_b, J3.flange_a)
        annotation (Line(points={{40,0},{50,0}}));
      connect(J3.flange_b, clutch3.flange_a)
        annotation (Line(points={{70,0},{80,0}}));
      connect(clutch3.flange_b, J4.flange_a)
        annotation (Line(points={{100,0},{110,0}}));
      connect(sin1.y, torque.tau)
        annotation (Line(points={{-109,0},{-102,0}}, color={0,0,127}));
      connect(sin2.y, clutch1.f_normalized) annotation (Line(points={{-30,19},{
              -30,19},{-30,11}}, color={0,0,127}));
      connect(step1.y, clutch2.f_normalized) annotation (Line(points={{30,19},{
              30,19},{30,10},{30,11}}, color={0,0,127}));
      connect(step2.y, clutch3.f_normalized)
        annotation (Line(points={{90,19},{90,19},{90,11}}, color={0,0,127}));
      connect(fixed.flange, torque.support) annotation (Line(points={{-90,-20},
              {-90,-11},{-90,-10}}));
      annotation (
        Documentation(info="<html>
<p>This example demonstrates how variable structure
drive trains are handled. The drive train consists
of 4 inertias and 3 clutches, where the clutches
are controlled by input signals. The system has
2^3=8 different configurations and 3^3 = 27
different states (every clutch may be in forward
sliding, backward sliding or locked mode when the
relative angular velocity is zero). By invoking the
clutches at different time instances, the switching
of the configurations can be studied.</p>
<p>Simulate the system for 1.2 seconds with the
following initial values:<br>
J1.w = 10.</p>
<p>Plot the following variables:<br>
angular velocities of inertias (J1.w, J2.w, J3.w,
J4.w), frictional torques of clutches (clutchX.tau),
frictional mode of clutches (clutchX.mode) where
mode = -1/0/+1 means backward sliding,
locked, forward sliding.</p>

</html>"),
        __Dymola_Commands(file=
              "modelica://Modelica/Resources/Scripts/Dymola/Mechanics/Rotational/CoupledClutches.mos"
            "Simulate and Plot"),
        experiment(StopTime=1.5, Interval=0.001),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},
                {140,100}})));
    end CoupledClutches;

    model LossyGearDemo1
      "Example to show that gear efficiency may lead to stuck motion"
      extends Modelica.Icons.Example;
      SI.Power PowerLoss=gear.flange_a.tau*der(gear.flange_a.phi) + gear.flange_b.tau
          *der(gear.flange_b.phi) "Power lost in the gear";
      Rotational.Components.LossyGear gear(
        ratio=2,
        lossTable=[0, 0.5, 0.5, 0, 0],
        useSupport=true) annotation (Placement(transformation(extent={{-10,0},{
                10,20}})));
      Rotational.Components.Inertia Inertia1(J=1) annotation (Placement(
            transformation(extent={{-40,0},{-20,20}})));
      Rotational.Components.Inertia Inertia2(
        J=1.5,
        phi(fixed=true, start=0, nominal=0.001),
        w(fixed=true, start=0, nominal=0.01)) annotation (Placement(transformation(extent={{
                20,0},{40,20}})));
      Rotational.Sources.Torque torque1(useSupport=true) annotation (Placement(
            transformation(extent={{-70,0},{-50,20}})));
      Rotational.Sources.Torque torque2(useSupport=true) annotation (Placement(
            transformation(extent={{70,0},{50,20}})));
      Modelica.Blocks.Sources.Sine DriveSine(amplitude=10, freqHz=1)
        annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
      Modelica.Blocks.Sources.Ramp load(
        height=5,
        duration=2,
        offset=-10) annotation (Placement(transformation(extent={{100,0},{80,20}})));
      Rotational.Components.Fixed fixed annotation (Placement(transformation(
              extent={{-10,-30},{10,-10}})));
    equation
      connect(Inertia1.flange_b, gear.flange_a)
        annotation (Line(points={{-20,10},{-10,10}}));
      connect(gear.flange_b, Inertia2.flange_a)
        annotation (Line(points={{10,10},{20,10}}));
      connect(torque1.flange, Inertia1.flange_a)
        annotation (Line(points={{-50,10},{-40,10}}));
      connect(torque2.flange, Inertia2.flange_b)
        annotation (Line(points={{50,10},{40,10}}));
      connect(DriveSine.y, torque1.tau)
        annotation (Line(points={{-79,10},{-72,10}}, color={0,0,127}));
      connect(load.y, torque2.tau)
        annotation (Line(points={{79,10},{72,10}}, color={0,0,127}));
      connect(fixed.flange, gear.support)
        annotation (Line(points={{0,-20},{0,0}}));
      connect(fixed.flange, torque1.support)
        annotation (Line(points={{0,-20},{-60,-20},{-60,0}}));
      connect(fixed.flange, torque2.support)
        annotation (Line(points={{0,-20},{60,-20},{60,0}}));
      annotation (Documentation(info="<html>
<p>
This model contains two inertias which are connected by an ideal
gear where the friction between the teeth of the gear is modeled in
a physical meaningful way (friction may lead to stuck mode which
locks the motion of the gear). The friction is defined by an
efficiency factor (= 0.5) for forward and backward driving condition leading
to a torque dependent friction loss. Simulate for about 0.5 seconds.
The friction in the gear will take all modes
(forward and backward rolling, as well as stuck).
</p>
<p>
You may plot:
</p>
<pre>
Inertia1.w,
Inertia2.w : angular velocities of inertias
powerLoss  : power lost in the gear
gear.mode  :  1 = forward rolling
              0 = stuck (w=0)
             -1 = backward rolling
</pre>
</html>"), experiment(StopTime=0.5, Interval=0.001));
    end LossyGearDemo1;

    model LossyGearDemo2
      "Example to show combination of LossyGear and BearingFriction"
      extends Modelica.Icons.Example;
      SI.Power PowerLoss=gear.flange_a.tau*der(gear.flange_a.phi) + gear.flange_b.tau
          *der(gear.flange_b.phi) "Power lost in the gear";

      Rotational.Components.LossyGear gear(
        ratio=2,
        lossTable=[0, 0.5, 0.5, 0, 0],
        useSupport=true) annotation (Placement(transformation(extent={{-20,0},{
                0,20}})));
      Rotational.Components.Inertia Inertia1(J=1) annotation (Placement(
            transformation(extent={{-50,0},{-30,20}})));
      Rotational.Components.Inertia Inertia2(
        J=1.5,
        phi(fixed=true, start=0, nominal=1e-4),
        w(fixed=true, start=0, nominal=0.001)) annotation (Placement(transformation(extent={{
                10,0},{30,20}})));
      Rotational.Sources.Torque torque1(useSupport=true) annotation (Placement(
            transformation(extent={{-110,0},{-90,20}})));
      Rotational.Sources.Torque torque2(useSupport=true) annotation (Placement(
            transformation(extent={{60,0},{40,20}})));
      Modelica.Blocks.Sources.Sine DriveSine(amplitude=10, freqHz=1)
        annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
      Modelica.Blocks.Sources.Ramp load(
        height=5,
        duration=2,
        offset=-10) annotation (Placement(transformation(extent={{90,0},{70,20}})));
      Rotational.Components.BearingFriction bearingFriction(tau_pos=[0, 0.5; 1,
            1], useSupport=true) annotation (Placement(transformation(extent={{
                -80,0},{-60,20}})));
      Rotational.Components.Fixed fixed annotation (Placement(transformation(
              extent={{-20,-30},{0,-10}})));
    equation
      connect(torque2.flange, Inertia2.flange_b)
        annotation (Line(points={{40,10},{30,10}}));
      connect(Inertia2.flange_a, gear.flange_b)
        annotation (Line(points={{10,10},{0,10}}));
      connect(gear.flange_a, Inertia1.flange_b)
        annotation (Line(points={{-20,10},{-30,10}}));
      connect(Inertia1.flange_a, bearingFriction.flange_b)
        annotation (Line(points={{-50,10},{-60,10}}));
      connect(bearingFriction.flange_a, torque1.flange)
        annotation (Line(points={{-80,10},{-80,10},{-90,10}}));
      connect(DriveSine.y, torque1.tau) annotation (Line(points={{-119,10},{-119,
              10},{-112,10}}, color={0,0,127}));
      connect(load.y, torque2.tau)
        annotation (Line(points={{69,10},{62,10}}, color={0,0,127}));
      connect(gear.support, fixed.flange)
        annotation (Line(points={{-10,0},{-10,-20}}));
      connect(fixed.flange, torque2.support)
        annotation (Line(points={{-10,-20},{50,-20},{50,0}}));
      connect(fixed.flange, bearingFriction.support)
        annotation (Line(points={{-10,-20},{-70,-20},{-70,0}}));
      connect(torque1.support, fixed.flange) annotation (Line(points={{-100,0},
              {-100,-20},{-10,-20}}));
      annotation (
        Diagram(coordinateSystem(extent = {{-150,-100},{100,100}})),
        Documentation(info="<html>
<p>
This model contains bearing friction and gear friction (= efficiency).
If both friction models are stuck, there is no unique solution.
Still a reliable Modelica simulator should
be able to handle this situation.
</p>
<p>
Simulate for about 0.5 seconds. The friction elements are
in all modes (forward and backward rolling, as well as stuck).
</p>
<p>
You may plot:
</p>
<pre>
Inertia1.w,
Inertia2.w          : angular velocities of inertias
powerLoss           : power lost in the gear
bearingFriction.mode:  1 = forward rolling
                       0 = stuck (w=0)
                      -1 = backward rolling
gear.mode           :  1 = forward rolling
                       0 = stuck (w=0)
                      -1 = backward rolling
</pre>
<p>Note: This combination of LossyGear and BearingFriction is not recommended to use,
as component LossyGear includes the functionality of component BearingFriction
(only <i>peak</i> not supported).</p>
</html>"), experiment(StopTime=0.5, Interval=0.001));
    end LossyGearDemo2;

    model LossyGearDemo3
      "Example that failed in the previous version of the LossyGear version"
      extends Modelica.Icons.Example;

      Modelica.Mechanics.Rotational.Components.LossyGear gear(
        ratio=1,
        lossTable=[0, 0.25, 0.25, 0.625, 2.5],
        useSupport=false) annotation (Placement(transformation(extent={{-10,0},
                {10,20}})));
      Modelica.Mechanics.Rotational.Components.Inertia Inertia1(w(start=10), J=
            0.001) annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque1(useSupport=false)
        annotation (Placement(transformation(extent={{-68,0},{-48,20}})));
      Modelica.Mechanics.Rotational.Sources.Torque torque2(useSupport=false)
        annotation (Placement(transformation(extent={{68,0},{48,20}})));
      Modelica.Blocks.Sources.Step step(height=0) annotation (Placement(
            transformation(extent={{-100,0},{-80,20}})));
      Modelica.Blocks.Sources.Step step1(
        startTime=0.5,
        height=1,
        offset=0) annotation (Placement(transformation(
            origin={90,10},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Mechanics.Rotational.Components.Inertia Inertia2(
        J=0.001,
        phi(fixed=true, start=0),
        w(start=10, fixed=true)) annotation (Placement(transformation(extent={{
                20,0},{40,20}})));
    equation
      connect(Inertia1.flange_b, gear.flange_a)
        annotation (Line(points={{-20,10},{-16,10},{-10,10}}));
      connect(torque1.flange, Inertia1.flange_a)
        annotation (Line(points={{-48,10},{-40,10}}));
      connect(step.y, torque1.tau)
        annotation (Line(points={{-79,10},{-70,10}}, color={0,0,127}));
      connect(gear.flange_b, Inertia2.flange_a)
        annotation (Line(points={{10,10},{20,10}}));
      connect(Inertia2.flange_b, torque2.flange)
        annotation (Line(points={{40,10},{48,10}}));
      connect(step1.y, torque2.tau) annotation (Line(
          points={{79,10},{74.5,10},{74.5,10},{70,10}},
          color={0,0,127}));
      annotation (
        Diagram(coordinateSystem(extent = {{-110,-100},{110,100}})),
        Documentation(info="<html>
<p>
This example demonstrates a situation where the driving side of the
LossyGear model is not obvious.
The version of LossyGear up to version 3.1 of package Modelica failed in this case
(no convergence of the event iteration).
</p>
</html>"), experiment(StopTime=1.0, Interval=0.001));
    end LossyGearDemo3;

    model ElasticBearing "Example to show possible usage of support flange"
      extends Modelica.Icons.Example;
      Rotational.Components.Inertia shaft(
        phi(fixed=true, start=0),
        J=1,
        w(fixed=true, start=0)) annotation (Placement(transformation(extent={{-20,
                40},{0,60}})));
      Rotational.Components.Inertia load(J=50, w(fixed=true, start=0))
        annotation (Placement(transformation(extent={{70,40},{90,60}})));
      Rotational.Components.Spring spring(c=1e3, phi_rel(fixed=true))
        annotation (Placement(transformation(extent={{40,40},{60,60}})));
      Rotational.Components.Fixed fixed annotation (Placement(transformation(
              extent={{10,-70},{30,-50}})));
      Rotational.Components.SpringDamper springDamper(
        c=1e5,
        d=5,
        phi_rel(fixed=true),
        w_rel(fixed=true, nominal=1e-4)) annotation (Placement(transformation(
            origin={20,-36},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Rotational.Sources.Torque torque(useSupport=true) annotation (Placement(
            transformation(extent={{-50,40},{-30,60}})));
      Modelica.Blocks.Sources.Ramp ramp(duration=5, height=100) annotation (
          Placement(transformation(extent={{-90,40},{-70,60}})));
      Rotational.Components.IdealGear idealGear(ratio=3, useSupport=true)
        annotation (Placement(transformation(extent={{10,40},{30,60}})));
      Rotational.Components.Inertia housing(J=5) annotation (Placement(
            transformation(
            origin={20,22},
            extent={{-10,-10},{10,10}},
            rotation=90)));
      Sensors.MultiSensor multiSensor annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,-6})));
    equation
      connect(torque.flange, shaft.flange_a)
        annotation (Line(points={{-30,50},{-20,50}}));
      connect(spring.flange_b, load.flange_a)
        annotation (Line(points={{60,50},{70,50}}));
      connect(springDamper.flange_a, fixed.flange)
        annotation (Line(points={{20,-46},{20,-46},{20,-60}}));
      connect(shaft.flange_b, idealGear.flange_a)
        annotation (Line(points={{0,50},{10,50}}));
      connect(idealGear.flange_b, spring.flange_a)
        annotation (Line(points={{30,50},{40,50}}));
      connect(idealGear.support, housing.flange_b)
        annotation (Line(points={{20,40},{20,32}}));
      connect(ramp.y, torque.tau) annotation (Line(points={{-69,50},{-69,50},{-52,
              50}}, color={0,0,127}));
      connect(fixed.flange, torque.support)
        annotation (Line(points={{20,-60},{-40,-60},{-40,40}}));
      connect(housing.flange_a, multiSensor.flange_b) annotation (Line(
          points={{20,12},{20,4}}));
      connect(multiSensor.flange_a, springDamper.flange_b) annotation (Line(
          points={{20,-16},{20,-26}}));
      annotation (
        Documentation(info="<html>
<p>
This model demonstrates the usage of the bearing flange.
The gearbox is not connected rigidly to the ground, but by
a spring-damper-system. This allows examination of the gearbox
housing dynamics.</p>
<p>
Simulate for about 10 seconds and plot the angular velocities of the inertias <code>housing.w</code>,
<code>shaft.w</code> and <code>load.w</code>.</p>
</html>"),
        experiment(StopTime=10, Interval=0.01));
    end ElasticBearing;

    model Backlash "Example to demonstrate backlash"
      extends Modelica.Icons.Example;
      Rotational.Components.Fixed fixed1
        annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
      Rotational.Components.SpringDamper springDamper(
        c=20E3,
        d=50,
        phi_nominal=1)
        annotation (Placement(transformation(extent={{-20,50},{0,70}})));
      Rotational.Components.Inertia inertia1(
        J=5,
        w(fixed=true, start=0),
        phi(
          fixed=true,
          displayUnit="deg",
          start=1.570796326794897))
        annotation (Placement(transformation(extent={{20,50},{40,70}})));
      Rotational.Components.Fixed fixed2
        annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
      Rotational.Components.ElastoBacklash elastoBacklash(
        c=20E3,
        d=50,
        b(displayUnit="deg") = 0.7853981633974483,
        phi_nominal=1)
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
      Rotational.Components.Inertia inertia2(
        J=5,
        w(fixed=true, start=0),
        phi(
          fixed=true,
          start=1.570796326794897,
          displayUnit="deg"))
        annotation (Placement(transformation(extent={{20,0},{40,20}})));
      Rotational.Components.Fixed fixed3
        annotation (Placement(transformation(extent={{-52,-40},{-32,-20}})));
      Components.ElastoBacklash2           elastoBacklash2(
        c=20E3,
        d=50,
        phi_nominal=1,
        b(displayUnit="deg") = 0.78539816339745)
        annotation (Placement(transformation(extent={{-22,-40},{-2,-20}})));
      Rotational.Components.Inertia inertia3(
        J=5,
        w(fixed=true, start=0),
        phi(
          fixed=true,
          start=1.570796326794897,
          displayUnit="deg"))
        annotation (Placement(transformation(extent={{18,-40},{38,-20}})));
    equation
      connect(springDamper.flange_b, inertia1.flange_a) annotation (Line(
          points={{0,60},{20,60}}));
      connect(elastoBacklash.flange_b, inertia2.flange_a) annotation (Line(
          points={{0,10},{20,10}}));
      connect(fixed1.flange, springDamper.flange_a) annotation (Line(
          points={{-40,60},{-20,60}}));
      connect(fixed2.flange, elastoBacklash.flange_a) annotation (Line(
          points={{-40,10},{-20,10}}));
      connect(elastoBacklash2.flange_b, inertia3.flange_a)
        annotation (Line(points={{-2,-30},{18,-30}}));
      connect(fixed3.flange, elastoBacklash2.flange_a)
        annotation (Line(points={{-42,-30},{-22,-30}}));
      annotation (Documentation(info="<html>
<p>
This model demonstrates the effect of a backlash on eigenfrequency, and
also that the damping torque does not lead to unphysical pulling torques
(since the ElastoBacklash model takes care of it).
Furthermore, it shows the differences of the
<a href=\"modelica://Modelica.Mechanics.Rotational.Components.ElastoBacklash\">ElastoBacklash</a> and
<a href=\"modelica://Modelica.Mechanics.Rotational.Components.ElastoBacklash2\">ElastoBacklash2</a> components
(the ElastoBacklash2 component generates events when contact occurs and the torque changes discontinuously).
</p>
</html>"), experiment(StopTime=1.0, Interval=0.001));
    end Backlash;

    model RollingWheel "Demonstrate coupling Rotational - Translational"
      extends Modelica.Icons.Example;
      Rotational.Components.IdealRollingWheel idealRollingWheel(radius=1)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Rotational.Components.Inertia inertia(
        J=1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0))
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Rotational.Sources.TorqueStep torqueStep(
        stepTorque=10,
        offsetTorque=0,
        startTime=0.1,
        useSupport=false)
        annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
      Translational.Components.Mass mass(L=0, m=1)
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      Translational.Sources.QuadraticSpeedDependentForce
        quadraticSpeedDependentForce(
        f_nominal=-10,
        ForceDirection=false,
        v_nominal=5)
        annotation (Placement(transformation(extent={{72,-10},{52,10}})));
    equation

      connect(torqueStep.flange, inertia.flange_a) annotation (Line(
          points={{-50,0},{-40,0}}));
      connect(inertia.flange_b, idealRollingWheel.flangeR) annotation (Line(
          points={{-20,0},{-10,0}}));
      connect(idealRollingWheel.flangeT, mass.flange_a) annotation (Line(
          points={{10,0},{20,0}},
          color={0,127,0}));
      connect(quadraticSpeedDependentForce.flange, mass.flange_b) annotation (
          Line(
          points={{52,0},{40,0}},
          color={0,127,0}));
      annotation (Documentation(info="<html>
<p>
This model demonstrates the coupling between rotational and translational components:<br>
A torque (step) accelerates both the inertia (of the wheel) and the mass (of the vehicle).<br>
Du to a speed dependent force (like driving resistance), we find an equilibrium at 5 m/s after approx. 5 s.
</p>
</html>"), experiment(StopTime=5.0, Interval=0.001));
    end RollingWheel;

    model HeatLosses "Demonstrate the modeling of heat losses"
      extends Modelica.Icons.Example;
      Blocks.Sources.Sine sine(freqHz=5, amplitude=20)
        annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
      Sources.Torque torque
        annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
      Components.Inertia inertia1(
        J=2,
        phi(fixed=true, start=0),
        w(fixed=true, start=0))
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      Components.Damper damper(useHeatPort=true, d=10) annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={-20,10})));
      Components.Fixed fixed
        annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
      Thermal.HeatTransfer.Components.Convection convection
        annotation (Placement(transformation(extent={{20,-20},{40,-40}})));
      Thermal.HeatTransfer.Celsius.FixedTemperature TAmbient(T=25)
        "Ambient temperature"
        annotation (Placement(transformation(extent={{68,-40},{48,-20}})));
      Blocks.Sources.Constant const(k=20)
        annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
      Components.SpringDamper springDamper(
        c=1e4,
        d=20,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{-10,20},{10,40}})));
      Components.Inertia inertia2(
        J=2,
        phi(fixed=true, start=0),
        w(fixed=true, start=0))
        annotation (Placement(transformation(extent={{20,20},{40,40}})));
      Components.ElastoBacklash elastoBacklash(
        c=1e5,
        d=100,
        useHeatPort=true,
        b(displayUnit="rad") = 0.001)
        annotation (Placement(transformation(extent={{50,20},{70,40}})));
      Components.Inertia inertia3(
        J=2,
        phi(fixed=true, start=0),
        w(fixed=true, start=0))
        annotation (Placement(transformation(extent={{80,20},{100,40}})));
      Components.BearingFriction bearingFriction(useHeatPort=true)
        annotation (Placement(transformation(extent={{110,20},{130,40}})));
      Components.Spring spring3(c=1e4)
        annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
      Components.Inertia inertia4(
        J=2,
        phi(fixed=true, start=0),
        w(fixed=true, start=0))
        annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
      Components.LossyGear lossyGear(
        ratio=2,
        lossTable=[0, 0.8, 0.8, 1, 1; 1, 0.7, 0.7, 2, 2],
        useHeatPort=true)
        annotation (Placement(transformation(extent={{-10,70},{10,90}})));
      Components.Clutch clutch(
        useHeatPort=true,
        fn_max=10,
        phi_rel(fixed=true),
        w_rel(fixed=true))
        annotation (Placement(transformation(extent={{20,70},{40,90}})));
      Components.Inertia inertia5(J=2)
        annotation (Placement(transformation(extent={{50,70},{70,90}})));
      Blocks.Sources.Sine sine2(freqHz=0.2, amplitude=1)
        annotation (Placement(transformation(extent={{0,110},{20,130}})));
      Components.Inertia inertia6(J=2)
        annotation (Placement(transformation(extent={{110,70},{130,90}})));
      Components.OneWayClutch oneWayClutch(
        phi_rel(fixed=true),
        w_rel(fixed=true),
        startForward(fixed=true),
        stuck(fixed=true),
        fn_max=1,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{80,70},{100,90}})));
      Components.Brake brake(fn_max=2, useHeatPort=true)
        annotation (Placement(transformation(extent={{140,70},{160,90}})));
    equation

      connect(sine.y, torque.tau) annotation (Line(
          points={{-79,30},{-72,30}},
          color={0,0,127}));
      connect(torque.flange, inertia1.flange_a) annotation (Line(
          points={{-50,30},{-40,30}}));
      connect(inertia1.flange_b, damper.flange_b) annotation (Line(
          points={{-20,30},{-20,25},{-20,20},{-20,20}}));
      connect(damper.flange_a, fixed.flange) annotation (Line(
          points={{-20,0},{-20,-5},{-20,-5},{-20,-10}}));
      connect(damper.heatPort, convection.solid) annotation (Line(
          points={{-30,0},{-30,-30},{20,-30}},
          color={191,0,0}));
      connect(TAmbient.port, convection.fluid) annotation (Line(
          points={{48,-30},{40,-30}},
          color={191,0,0}));
      connect(const.y, convection.Gc) annotation (Line(
          points={{21,-60},{30,-60},{30,-40}},
          color={0,0,127}));
      connect(inertia1.flange_b, springDamper.flange_a) annotation (Line(
          points={{-20,30},{-10,30}}));
      connect(springDamper.heatPort, convection.solid) annotation (Line(
          points={{-10,20},{-10,-30},{20,-30}},
          color={191,0,0}));
      connect(springDamper.flange_b, inertia2.flange_a) annotation (Line(
          points={{10,30},{20,30}}));
      connect(elastoBacklash.flange_a, inertia2.flange_b) annotation (Line(
          points={{50,30},{40,30}}));
      connect(elastoBacklash.heatPort, convection.solid) annotation (Line(
          points={{50,20},{50,0},{-10,0},{-10,-30},{20,-30}},
          color={191,0,0}));
      connect(elastoBacklash.flange_b, inertia3.flange_a) annotation (Line(
          points={{70,30},{80,30}}));
      connect(inertia3.flange_b, bearingFriction.flange_a) annotation (Line(
          points={{100,30},{110,30}}));
      connect(convection.solid, bearingFriction.heatPort) annotation (Line(
          points={{20,-30},{-10,-30},{-10,0},{110,0},{110,20}},
          color={191,0,0}));
      connect(spring3.flange_b, inertia4.flange_a) annotation (Line(
          points={{-50,80},{-40,80}}));
      connect(bearingFriction.flange_b, spring3.flange_a) annotation (Line(
          points={{130,30},{130,48},{-70,48},{-70,80}}));
      connect(inertia4.flange_b, lossyGear.flange_a) annotation (Line(
          points={{-20,80},{-10,80}}));
      connect(lossyGear.heatPort, convection.solid) annotation (Line(
          points={{-10,70},{-10,60},{140,60},{140,0},{-10,0},{-10,-30},{20,-30}},
          color={191,0,0}));

      connect(lossyGear.flange_b, clutch.flange_a) annotation (Line(
          points={{10,80},{20,80}}));
      connect(clutch.heatPort, convection.solid) annotation (Line(
          points={{20,70},{20,60},{140,60},{140,0},{-10,0},{-10,-30},{20,-30}},
          color={191,0,0}));

      connect(clutch.flange_b, inertia5.flange_a) annotation (Line(
          points={{40,80},{50,80}}));
      connect(sine2.y, clutch.f_normalized) annotation (Line(
          points={{21,120},{30,120},{30,91}},
          color={0,0,127}));
      connect(inertia5.flange_b, oneWayClutch.flange_a) annotation (Line(
          points={{70,80},{80,80}}));
      connect(oneWayClutch.flange_b, inertia6.flange_a) annotation (Line(
          points={{100,80},{110,80}}));
      connect(sine2.y, oneWayClutch.f_normalized) annotation (Line(
          points={{21,120},{90,120},{90,91}},
          color={0,0,127}));
      connect(inertia6.flange_b, brake.flange_a) annotation (Line(
          points={{130,80},{140,80}}));
      connect(sine2.y, brake.f_normalized) annotation (Line(
          points={{21,120},{150,120},{150,91}},
          color={0,0,127}));
      connect(oneWayClutch.heatPort, convection.solid) annotation (Line(
          points={{80,70},{80,60},{140,60},{140,0},{-10,0},{-10,-30},{20,-30}},
          color={191,0,0}));

      connect(brake.heatPort, convection.solid) annotation (Line(
          points={{140,70},{140,0},{-10,0},{-10,-30},{20,-30}},
          color={191,0,0}));

      annotation (
        Documentation(info="<html>
<p>
This model demonstrates how to model the dissipated power of a drive train,
by enabling the heatPort of all components and connecting these heatPorts via
a convection element to the environment. The total heat flow generated by the
elements of the drive train and transported to the environment
is present in variable convection.fluid.
</p>
</html>"),
        experiment(StopTime=1.0, Interval=0.0001),
        Diagram(coordinateSystem(extent={{-120,-100},{180,140}})));
    end HeatLosses;

    model SimpleGearShift "Simple Gearshift"
      extends Modelica.Icons.Example;
      output Modelica.SIunits.AngularVelocity wEngine=engine.w
        "Speed of engine";
      output Modelica.SIunits.AngularVelocity wLoad=load.w "Speed of load";
      output Real gearRatio=wLoad/max(wEngine, 1E-6) "gear ratio load/engine";
      Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep(
        offsetTorque=0,
        startTime=0.5,
        stepTorque=20)
        annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
      Modelica.Mechanics.Rotational.Components.Inertia engine(J=1)
        annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
      Modelica.Mechanics.Rotational.Components.IdealPlanetary idealPlanetary(
          ratio=75/50)
        annotation (Placement(transformation(extent={{-10,0},{10,-20}})));
      Modelica.Mechanics.Rotational.Components.Inertia load(
        J=10,
        phi(fixed=true, start=0),
        w(fixed=true, start=0))
        annotation (Placement(transformation(extent={{30,-20},{50,0}})));
      Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
        quadraticSpeedDependentTorque(w_nominal(displayUnit="rpm")=
          10.471975511966, tau_nominal=-20)
        annotation (Placement(transformation(extent={{80,-20},{60,0}})));
      Modelica.Mechanics.Rotational.Components.Clutch clutch(
        cgeo=2,
        fn_max=100,
        phi_rel(fixed=true),
        w_rel(fixed=true))
        annotation (Placement(transformation(extent={{-10,10},{10,30}})));
      Modelica.Mechanics.Rotational.Components.Brake brake(cgeo=2, fn_max=100)
        annotation (Placement(transformation(extent={{20,10},{40,30}})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{-10,50},{10,70}})));
      Modelica.Blocks.Sources.Constant const1(k=1)
        annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
      Modelica.Blocks.Sources.Ramp ramp(
        height=1,
        offset=0,
        startTime=2,
        duration=0.1)
        annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    equation
      connect(torqueStep.flange, engine.flange_a) annotation (Line(
          points={{-60,-10},{-50,-10}}));
      connect(quadraticSpeedDependentTorque.flange, load.flange_b) annotation (
          Line(
          points={{60,-10},{50,-10}}));
      connect(feedback.y, brake.f_normalized) annotation (Line(
          points={{9,60},{30,60},{30,31}},
          color={0,0,127}));
      connect(engine.flange_b, idealPlanetary.sun) annotation (Line(
          points={{-30,-10},{-10,-10}}));
      connect(idealPlanetary.sun, clutch.flange_a) annotation (Line(
          points={{-10,-10},{-10,20}}));
      connect(idealPlanetary.ring, clutch.flange_b) annotation (Line(
          points={{10,-10},{10,20}}));
      connect(idealPlanetary.ring, brake.flange_a) annotation (Line(
          points={{10,-10},{20,-10},{20,20}}));
      connect(idealPlanetary.carrier, load.flange_a) annotation (Line(
          points={{-10,-14},{-20,-14},{-20,-30},{30,-30},{30,-10}}));
      connect(const1.y, feedback.u1) annotation (Line(
          points={{-19,60},{-8,60}},
          color={0,0,127}));
      connect(feedback.u2, clutch.f_normalized) annotation (Line(
          points={{0,52},{0,31}},
          color={0,0,127}));
      connect(ramp.y, clutch.f_normalized) annotation (Line(
          points={{-39,40},{0,40},{0,31}},
          color={0,0,127}));
      annotation (experiment(StopTime=5, Interval=0.01), Documentation(info="<html>
<p>This model shows how an automatic gear shift is built up from a planetary gear, a brake and a clutch. </p>
<ul>
<li>In the beginning, the clutch is free and the brake fixes the ring of the planetary. Thus we obtain a gearRatio = 1/(1 + planetary.ratio).</li>
<li>At time = 2 s, the brake frees the ring of the planetary, whereas the clutch blocks the ring and the sun. Thus we obtain a gearRatio = 1.</li>
</ul>
</html>"));
    end SimpleGearShift;

    model GenerationOfFMUs
      "Example to demonstrate variants to generate FMUs (Functional Mock-up Units)"
      extends Modelica.Icons.Example;

      Blocks.Sources.Sine sine1(freqHz=2, amplitude=10)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Utilities.DirectInertia directInertia(J=1.1)
        annotation (Placement(transformation(extent={{-20,40},{0,60}})));
      Utilities.InverseInertia inverseInertia(J=2.2)
        annotation (Placement(transformation(extent={{20,40},{40,60}})));
      Utilities.SpringDamper springDamper(c=1e4, d=100)
        annotation (Placement(transformation(extent={{10,-20},{30,0}})));
      Blocks.Sources.Sine sine2(freqHz=2, amplitude=10)
        annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
      Components.Inertia inertia2a(
        J=1.1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0))
        annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
      Sources.Torque torque2
        annotation (Placement(transformation(extent={{-68,-20},{-48,0}})));
      Components.TorqueToAngleAdaptor torqueToAngle2a(use_a=false)
        annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
      Components.Inertia inertia2b(
        phi(fixed=true, start=0),
        w(fixed=true, start=0),
        J=2.2) annotation (Placement(transformation(extent={{60,-20},{80,0}})));
      Components.TorqueToAngleAdaptor torqueToAngle2b(use_a=false)
        annotation (Placement(transformation(extent={{60,-20},{40,0}})));
      Utilities.Spring spring(c=1e4)
        annotation (Placement(transformation(extent={{10,-80},{30,-60}})));
      Blocks.Sources.Sine sine3(freqHz=2, amplitude=10)
        annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
      Components.Inertia inertia3a(
        J=1.1,
        phi(fixed=true, start=0),
        w(fixed=true, start=0))
        annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
      Sources.Torque torque3
        annotation (Placement(transformation(extent={{-68,-80},{-48,-60}})));
      Components.TorqueToAngleAdaptor torqueToAngle3a(use_a=false, use_w=false)
        annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      Components.Inertia inertia3b(
        phi(fixed=true, start=0),
        w(fixed=true, start=0),
        J=2.2)
        annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
      Components.TorqueToAngleAdaptor torqueToAngle3b(use_a=false, use_w=false)
        annotation (Placement(transformation(extent={{60,-80},{40,-60}})));
    equation
      connect(sine1.y, directInertia.tauDrive) annotation (Line(
          points={{-39,50},{-22,50}},
          color={0,0,127}));
      connect(directInertia.phi, inverseInertia.phi) annotation (Line(
          points={{1,58},{18,58}},
          color={0,0,127}));
      connect(directInertia.w, inverseInertia.w) annotation (Line(
          points={{1,53},{18,53}},
          color={0,0,127}));
      connect(directInertia.a, inverseInertia.a) annotation (Line(
          points={{1,47},{18,47}},
          color={0,0,127}));
      connect(inverseInertia.tau, directInertia.tau) annotation (Line(
          points={{19,42},{2,42}},
          color={0,0,127}));
      connect(torque2.flange, inertia2a.flange_a) annotation (Line(
          points={{-48,-10},{-40,-10}}));
      connect(sine2.y, torque2.tau) annotation (Line(
          points={{-79,-10},{-70,-10}},
          color={0,0,127}));
      connect(inertia2a.flange_b, torqueToAngle2a.flange) annotation (Line(
          points={{-20,-10},{-12,-10}}));
      connect(torqueToAngle2a.phi, springDamper.phi1) annotation (Line(
          points={{-7,-2},{8,-2}},
          color={0,0,127}));
      connect(torqueToAngle2a.w, springDamper.w1) annotation (Line(
          points={{-7,-7},{8,-7}},
          color={0,0,127}));
      connect(springDamper.tau1, torqueToAngle2a.tau) annotation (Line(
          points={{9,-18},{-6,-18}},
          color={0,0,127}));
      connect(torqueToAngle2b.phi, springDamper.phi2) annotation (Line(
          points={{47,-2},{32,-2}},
          color={0,0,127}));
      connect(torqueToAngle2b.w, springDamper.w2) annotation (Line(
          points={{47,-7},{32,-7}},
          color={0,0,127}));
      connect(springDamper.tau2, torqueToAngle2b.tau) annotation (Line(
          points={{31,-18},{46,-18}},
          color={0,0,127}));
      connect(inertia2b.flange_a, torqueToAngle2b.flange) annotation (Line(
          points={{60,-10},{52,-10}}));
      connect(torque3.flange, inertia3a.flange_a) annotation (Line(
          points={{-48,-70},{-40,-70}}));
      connect(sine3.y, torque3.tau) annotation (Line(
          points={{-79,-70},{-70,-70}},
          color={0,0,127}));
      connect(inertia3a.flange_b, torqueToAngle3a.flange) annotation (Line(
          points={{-20,-70},{-12,-70}}));
      connect(torqueToAngle3a.phi, spring.phi1) annotation (Line(
          points={{-7,-62},{8,-62}},
          color={0,0,127}));
      connect(spring.tau1, torqueToAngle3a.tau) annotation (Line(
          points={{9,-78},{-6,-78}},
          color={0,0,127}));
      connect(torqueToAngle3b.phi, spring.phi2) annotation (Line(
          points={{47,-62},{32,-62}},
          color={0,0,127}));
      connect(spring.tau2, torqueToAngle3b.tau) annotation (Line(
          points={{31,-78},{46,-78}},
          color={0,0,127}));
      connect(inertia3b.flange_a, torqueToAngle3b.flange) annotation (Line(
          points={{60,-70},{52,-70}}));
      annotation (experiment(StopTime=1, Interval=0.001), Documentation(info="<html>
<p>
This example demonstrates how to generate an input/output block (e.g. in form of an
FMU - <a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>) from various Rotational components.
The goal is to export such an input/output block from Modelica and import
it in another modeling environment. The essential issue is that before
exporting it must be known in which way the component is utilized in the
target environment. Depending on the target usage, different flange variables
need to be in the interface with either input or output causality.
Note, this example model can be used to test the FMU export/import of a Modelica tool.
Just export the components marked in the icons as \"toFMU\" as FMUs and import
them back. The models should then still work and give the same results as a
pure Modelica model.
</p>

<p>
<b>Connecting two inertias</b><br>
The upper part (DirectInertia, InverseInertia)
demonstrates how to export two inertias and connect them
together in a target system. This requires that one of the inertias
(here: DirectInertia)
is defined to have states and the angle, angular velocity and angular
acceleration are provided in the interface.
The other inertia (here: InverseInertia) is moved according
to the provided input angle, angular velocity and angular acceleration.
</p>

<p>
<b>Connecting a force element that needs angles and angular velocities</b><br>
The middle part (SpringDamper) demonstrates how to export a force element
that needs both angles and angular velocities for its force law and connect this
force law in a target system between two inertias.
</p>

<p>
<b>Connecting a force element that needs only angles</b><br>
The lower part (Spring) demonstrates how to export a force element
that needs only angles for its force law and connect this
force law in a target system between two inertias.
</p>
</html>"));
    end GenerationOfFMUs;

    package Utilities "Utility components used by the example models"
      extends Modelica.Icons.UtilitiesPackage;
      model DirectInertia "Input/output block of a direct inertia model"
        extends Modelica.Blocks.Icons.Block;
        parameter Modelica.SIunits.Inertia J(min=0)=1 "Moment of inertia";

        Modelica.Mechanics.Rotational.Components.Inertia inertia(
          phi(start=0, fixed=true),
          w(start=0, fixed=true),
          J=J) annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
        Modelica.Blocks.Interfaces.RealInput tauDrive(unit="N.m")
          "Accelerating torque acting at flange (= -flange.tau)"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Components.TorqueToAngleAdaptor torqueToAngle
          annotation (Placement(transformation(extent={{4,-10},{24,10}})));
        Modelica.Blocks.Interfaces.RealOutput phi(unit="rad")
          "Inertia moves with angle phi due to torque tau"
          annotation (Placement(transformation(extent={{100,70},{120,90}})));
        Modelica.Blocks.Interfaces.RealOutput w(unit="rad/s")
          "Inertia moves with speed w due to torque tau"
          annotation (Placement(transformation(extent={{100,20},{120,40}})));
        Modelica.Blocks.Interfaces.RealOutput a(unit="rad/s2")
          "Inertia moves with angular acceleration a due to torque tau"
          annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
        Modelica.Blocks.Interfaces.RealInput tau(unit="N.m")
          "Torque to drive the inertia"
          annotation (Placement(transformation(extent={{140,-100},{100,-60}})));
      equation

        connect(torque.flange, inertia.flange_a) annotation (Line(
            points={{-30,0},{-20,0}}));
        connect(torque.tau, tauDrive) annotation (Line(
            points={{-52,0},{-120,0}},
            color={0,0,127}));
        connect(inertia.flange_b, torqueToAngle.flange) annotation (Line(
            points={{0,0},{12,0}}));
        connect(torqueToAngle.phi, phi) annotation (Line(
            points={{17,8},{60,8},{60,80},{110,80}},
            color={0,0,127}));
        connect(torqueToAngle.w, w) annotation (Line(
            points={{17,3},{66,3},{66,30},{110,30}},
            color={0,0,127}));
        connect(torqueToAngle.tau, tau) annotation (Line(
            points={{18,-8},{60,-8},{60,-80},{120,-80}},
            color={0,0,127}));
        connect(torqueToAngle.a, a) annotation (Line(
            points={{17,-3},{66,-3},{66,-30},{110,-30}},
            color={0,0,127}));
        annotation ( Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Text(
                      extent={{-84,-58},{24,-90}},
                      lineColor={135,135,135},
                      fillColor={235,245,255},
                      fillPattern=FillPattern.Solid,
                      textString="to FMU"),Text(
                      extent={{8,96},{92,66}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      textString="phi",
                      horizontalAlignment=TextAlignment.Right),Text(
                      extent={{10,46},{94,16}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Right,
                      textString="w"),Text(
                      extent={{6,-10},{90,-40}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Right,
                      textString="a"),Text(
                      extent={{-150,-110},{150,-140}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      textString="J=%J"),Bitmap(extent={{-96,-42},{64,54}},
                fileName=
                "modelica://Modelica/Resources/Images/Mechanics/Rotational/DirectInertia.png"),
                Text( extent={{10,-60},{94,-90}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Right,
                      textString="tau")}));
      end DirectInertia;

      model InverseInertia "Input/output block of an inverse inertia model"
        extends Modelica.Blocks.Icons.Block;
        parameter Modelica.SIunits.Inertia J=1 "Moment of inertia";
        Modelica.Mechanics.Rotational.Components.Inertia inertia(
          J=J,
          phi(start=0, fixed=false),
          w(start=0, fixed=false))
          annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
        Components.AngleToTorqueAdaptor angleToTorque
          annotation (Placement(transformation(extent={{-36,-10},{-16,10}})));
        Modelica.Blocks.Interfaces.RealInput phi(unit="rad")
          "Angle to drive the inertia"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealInput w(unit="rad/s")
          "Speed to drive the inertia"
          annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
        Modelica.Blocks.Interfaces.RealInput a(unit="rad/s2")
          "Angular acceleration to drive the inertia" annotation (Placement(
              transformation(extent={{-140,-50},{-100,-10}})));
        Modelica.Blocks.Interfaces.RealOutput tau(unit="N.m")
          "Torque needed to drive the flange according to phi, w, a"
          annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
      equation

        connect(angleToTorque.phi, phi) annotation (Line(
            points={{-30,8},{-84,8},{-84,80},{-120,80}},
            color={0,0,127}));
        connect(angleToTorque.w, w) annotation (Line(
            points={{-30,2.8},{-90,2.8},{-90,30},{-120,30}},
            color={0,0,127}));
        connect(angleToTorque.a, a) annotation (Line(
            points={{-30,-3.2},{-80,-3.2},{-80,-30},{-120,-30}},
            color={0,0,127}));
        connect(angleToTorque.flange, inertia.flange_a) annotation (Line(
            points={{-24,0},{-12,0}}));
        connect(angleToTorque.tau, tau) annotation (Line(
            points={{-29,-8},{-70,-8},{-70,-80},{-110,-80}},
            color={0,0,127}));
        annotation ( Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Text(
                      extent={{0,-62},{96,-94}},
                      lineColor={135,135,135},
                      fillColor={235,245,255},
                      fillPattern=FillPattern.Solid,
                      textString="to FMU"),Text(
                      extent={{-94,96},{-10,66}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Left,
                      textString="phi"),Text(
                      extent={{-94,46},{-10,16}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Left,
                      textString="w"),Text(
                      extent={{-92,-14},{-8,-44}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Left,
                      textString="a"),Text(
                      extent={{-150,-110},{150,-140}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      textString="J=%J"),Bitmap(extent={{-58,-42},{98,48}},
                fileName=
                "modelica://Modelica/Resources/Images/Mechanics/Rotational/InverseInertia.png"),
                Text( extent={{-90,-64},{-6,-94}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Left,
                      textString="tau")}));
      end InverseInertia;

      model SpringDamper "Input/output block of a spring/damper model"
        extends Modelica.Blocks.Icons.Block;
        parameter SI.RotationalSpringConstant c=1e4 "Spring constant";
        parameter SI.RotationalDampingConstant d=1 "Damping constant";
        parameter SI.Angle phi_rel0=0 "Unstretched spring angle";

        Components.AngleToTorqueAdaptor angleToTorque1(use_a=false)
          annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
        Modelica.Blocks.Interfaces.RealInput phi1(unit="rad")
          "Angle of left flange of force element"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealInput w1(unit="rad/s")
          "Speed to left flange of force element"
          annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
        Modelica.Blocks.Interfaces.RealOutput tau1(unit="N.m")
          "Torque generated by the force element" annotation (Placement(
              transformation(extent={{-100,-90},{-120,-70}})));
        SpringDamperNoRelativeStates
                                springDamper(
          c=c,
          d=d,
          phi_rel0=phi_rel0)
          annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
        Modelica.Blocks.Interfaces.RealInput phi2(unit="rad")
          "Angle of left flange of force element"
          annotation (Placement(transformation(extent={{140,60},{100,100}})));
        Modelica.Blocks.Interfaces.RealInput w2(unit="rad/s")
          "Speed to left flange of force element"
          annotation (Placement(transformation(extent={{140,10},{100,50}})));
        Modelica.Blocks.Interfaces.RealOutput tau2(unit="N.m")
          "Torque generated by the force element"
          annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
        Components.AngleToTorqueAdaptor angleToTorque2(use_a=false)
          annotation (Placement(transformation(extent={{38,-10},{18,10}})));
      equation

        connect(angleToTorque1.phi, phi1) annotation (Line(
            points={{-24,8},{-84,8},{-84,80},{-120,80}},
            color={0,0,127}));
        connect(angleToTorque1.w, w1) annotation (Line(
            points={{-24,2.8},{-90,2.8},{-90,30},{-120,30}},
            color={0,0,127}));
        connect(angleToTorque1.tau, tau1) annotation (Line(
            points={{-23,-8},{-70,-8},{-70,-80},{-110,-80}},
            color={0,0,127}));
        connect(angleToTorque1.flange, springDamper.flange_a) annotation (Line(
            points={{-18,0},{-6,0}}));
        connect(springDamper.flange_b, angleToTorque2.flange) annotation (Line(
            points={{14,0},{26,0}}));
        connect(phi2, angleToTorque2.phi) annotation (Line(
            points={{120,80},{60,80},{60,8},{32,8}},
            color={0,0,127}));
        connect(w2, angleToTorque2.w) annotation (Line(
            points={{120,30},{70,30},{70,2.8},{32,2.8}},
            color={0,0,127}));
        connect(angleToTorque2.tau, tau2) annotation (Line(
            points={{31,-8},{60,-8},{60,-80},{110,-80}},
            color={0,0,127}));
        annotation ( Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Text(
                      extent={{-48,-36},{48,-68}},
                      lineColor={135,135,135},
                      fillColor={235,245,255},
                      fillPattern=FillPattern.Solid,
                      textString="to FMU"),Text(
                      extent={{-94,96},{-10,66}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Left,
                      textString="phi1"),Text(
                      extent={{-150,-118},{150,-148}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      textString="c=%c
d=%d"),Bitmap(extent={{-72,-44},{84,46}}, fileName=
                "modelica://Modelica/Resources/Images/Mechanics/Rotational/SpringDamper.png"),
                Text( extent={{12,96},{96,66}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Right,
                      textString="phi2"),Text(
                      extent={{12,48},{96,18}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Right,
                      textString="w2"),Text(
                      extent={{10,-60},{94,-90}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Right,
                      textString="tau2"),Text(
                      extent={{-94,46},{-10,16}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Left,
                      textString="w1"),Text(
                      extent={{-90,-64},{-6,-94}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Left,
                      textString="tau1")}));
      end SpringDamper;

      model Spring "Input/output block of a spring model"
        extends Modelica.Blocks.Icons.Block;
        parameter SI.RotationalSpringConstant c=1e4 "Spring constant";
        parameter SI.Angle phi_rel0=0 "Unstretched spring angle";

        Components.AngleToTorqueAdaptor angleToTorque1(use_a=false, use_w=false)
          annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
        Modelica.Blocks.Interfaces.RealInput phi1(unit="rad")
          "Angle of left flange of force element"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealOutput tau1(unit="N.m")
          "Torque generated by the force element" annotation (Placement(
              transformation(extent={{-100,-90},{-120,-70}})));
        Components.Spring spring(c=c, phi_rel0=phi_rel0)
          annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
        Modelica.Blocks.Interfaces.RealInput phi2(unit="rad")
          "Angle of left flange of force element"
          annotation (Placement(transformation(extent={{140,60},{100,100}})));
        Modelica.Blocks.Interfaces.RealOutput tau2(unit="N.m")
          "Torque generated by the force element"
          annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
        Components.AngleToTorqueAdaptor angleToTorque2(use_a=false, use_w=false)
          annotation (Placement(transformation(extent={{38,-10},{18,10}})));
      equation

        connect(angleToTorque1.phi, phi1) annotation (Line(
            points={{-24,8},{-84,8},{-84,80},{-120,80}},
            color={0,0,127}));
        connect(angleToTorque1.tau, tau1) annotation (Line(
            points={{-23,-8},{-70,-8},{-70,-80},{-110,-80}},
            color={0,0,127}));
        connect(angleToTorque1.flange, spring.flange_a) annotation (Line(
            points={{-18,0},{-6,0}}));
        connect(spring.flange_b, angleToTorque2.flange) annotation (Line(
            points={{14,0},{26,0}}));
        connect(phi2, angleToTorque2.phi) annotation (Line(
            points={{120,80},{60,80},{60,8},{32,8}},
            color={0,0,127}));
        connect(angleToTorque2.tau, tau2) annotation (Line(
            points={{31,-8},{60,-8},{60,-80},{110,-80}},
            color={0,0,127}));
        annotation ( Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Text(
                      extent={{-48,-36},{48,-68}},
                      lineColor={135,135,135},
                      fillColor={235,245,255},
                      fillPattern=FillPattern.Solid,
                      textString="to FMU"),Text(
                      extent={{-94,96},{-10,66}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Left,
                      textString="phi1"),Text(
                      extent={{-150,-114},{150,-144}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      textString="c=%c"),Bitmap(extent={{-88,-36},{92,56}},
                fileName=
                "modelica://Modelica/Resources/Images/Mechanics/Rotational/Spring.png"),
                Text( extent={{12,96},{96,66}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Right,
                      textString="phi2"),Text(
                      extent={{10,-60},{94,-90}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Right,
                      textString="tau2"),Text(
                      extent={{-90,-64},{-6,-94}},
                      lineColor={0,0,0},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={245,245,245},
                      horizontalAlignment=TextAlignment.Left,
                      textString="tau1")}));
      end Spring;

      model SpringDamperNoRelativeStates
        "Linear 1D rotational spring and damper in parallel (phi and w are not used as states)"
        parameter SI.RotationalSpringConstant c(final min=0, start=1.0e5)
          "Spring constant";
        parameter SI.RotationalDampingConstant d(final min=0, start=0)
          "Damping constant";
        parameter SI.Angle phi_rel0=0 "Unstretched spring angle";
        Modelica.SIunits.AngularVelocity w_rel(start=0)
          "Relative angular velocity (= der(phi_rel))";
        extends Modelica.Mechanics.Rotational.Interfaces.PartialCompliant;
        extends
          Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
      protected
        Modelica.SIunits.Torque tau_c "Spring torque";
        Modelica.SIunits.Torque tau_d "Damping torque";
      equation
        w_rel = der(phi_rel);
        tau_c = c*(phi_rel - phi_rel0);
        tau_d = d*w_rel;
        tau = tau_c + tau_d;
        lossPower = tau_d*w_rel;
        annotation (
          Documentation(info="<html>
<p>
A <b>spring</b> and <b>damper</b> element <b>connected in parallel</b>.
The component can be
connected either between two inertias/gears to describe the shaft elasticity
and damping, or between an inertia/gear and the housing (component Fixed),
to describe a coupling of the element with the housing via a spring/damper.
</p>

<p>
This is the same element as <a href=\"modelica://Modelica.Mechanics.Rotational.Components.SpringDamper\">Rotational.Components.SpringDamper</a>
but with the only difference, that the relative quantities are not used as states. If the relative
states are potentially used as states, \"a_rel = der(w_rel)\" is present, and then exporting this model
as FMU requires to also have the accelerations in the flanges as inputs, which is usually not
desired for a force element.
</p>
</html>"),Icon(
            coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}),
              graphics={
          Line(points={{-80,40},{-60,40},{-45,10},{-15,70},{15,10},{45,70},{60,40},{80,40}}),
          Line(points={{-80,40},{-80,-40}}),
          Line(points={{-80,-40},{-50,-40}}),
          Rectangle(extent={{-50,-10},{40,-70}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-50,-10},{70,-10}}),
          Line(points={{-50,-70},{70,-70}}),
          Line(points={{40,-40},{80,-40}}),
          Line(points={{80,40},{80,-40}}),
          Line(points={{-90,0},{-80,0}}),
          Line(points={{80,0},{90,0}}),
          Text(origin={0,-9},
            extent={{-150,-144},{150,-104}},
            lineColor={0,0,0},
            textString="d=%d"),
          Text(extent={{-190,110},{190,70}},
            lineColor={0,0,255},
            textString="%name"),
          Text(
            origin={0,-7},
            extent={{-150,-108},{150,-68}},
            lineColor={0,0,0},
            textString="c=%c"),
          Line(visible=useHeatPort,
            points={{-100,-100},{-100,-55},{-5,-55}},
            color={191,0,0},
            pattern=LinePattern.Dot)}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Line(
                points={{-80,32},{-58,32},{-43,2},{-13,62},{17,2},{47,62},{62,32},
                    {80,32}},
                thickness=0.5),
              Line(points={{-68,32},{-68,97}}, color={128,128,128}),
              Line(points={{72,32},{72,97}}, color={128,128,128}),
              Line(points={{-68,92},{72,92}}, color={128,128,128}),
              Polygon(
                points={{62,95},{72,92},{62,89},{62,95}},
                lineColor={128,128,128},
                fillColor={128,128,128},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-44,79},{29,91}},
                lineColor={0,0,255},
                textString="phi_rel"),
              Rectangle(
                extent={{-50,-20},{40,-80}},
                lineColor={0,0,0},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-50,-80},{68,-80}}),
              Line(points={{-50,-20},{68,-20}}),
              Line(points={{40,-50},{80,-50}}),
              Line(points={{-80,-50},{-50,-50}}),
              Line(points={{-80,32},{-80,-50}}),
              Line(points={{80,32},{80,-50}}),
              Line(points={{-96,0},{-80,0}}),
              Line(points={{96,0},{80,0}})}));
      end SpringDamperNoRelativeStates;
    end Utilities;
    annotation (Documentation(info="<html>
<p>
This package contains example models to demonstrate the usage of the
Modelica.Mechanics.Rotational package. Open the models and
simulate them according to the provided description in the models.
</p>

</html>"));
  end Examples;

  package Components "Components for 1D rotational mechanical drive trains"
    extends Modelica.Icons.Package;

    model Fixed "Flange fixed in housing at a given angle"
      parameter SI.Angle phi0=0 "Fixed offset angle of housing";

      Interfaces.Flange_b flange "(right) flange fixed in housing" annotation (
          Placement(transformation(extent={{10,-10},{-10,10}})));

    equation
      flange.phi = phi0;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-150,-90},{150,-130}},
              lineColor={0,0,255},
              textString="%name"),
            Line(points={{-80,-40},{80,-40}}),
            Line(points={{80,-40},{40,-80}}),
            Line(points={{40,-40},{0,-80}}),
            Line(points={{0,-40},{-40,-80}}),
            Line(points={{-40,-40},{-80,-80}}),
            Line(points={{0,-40},{0,-10}})}),
        Documentation(info="<html>
<p>
The <b>flange</b> of a 1D rotational mechanical system is <b>fixed</b>
at an angle phi0 in the <b>housing</b>. May be used:
</p>
<ul>
<li> to connect a compliant element, such as a spring or a damper,
     between an inertia or gearbox component and the housing.</li>
<li> to fix a rigid element, such as an inertia, with a specific
     angle to the housing.</li>
</ul>

</html>"),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Line(points={{-80,-40},{80,-40}}),
            Line(points={{80,-40},{40,-80}}),
            Line(points={{40,-40},{0,-80}}),
            Line(points={{0,-40},{-40,-80}}),
            Line(points={{-40,-40},{-80,-80}}),
            Line(points={{0,-40},{0,-4}})}));
    end Fixed;

    model Inertia "1D-rotational component with inertia"
      Rotational.Interfaces.Flange_a flange_a "Left flange of shaft"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Rotational.Interfaces.Flange_b flange_b "Right flange of shaft"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      parameter SI.Inertia J(min=0, start=1) "Moment of inertia";
      parameter StateSelect stateSelect=StateSelect.default
        "Priority to use phi and w as states"
        annotation (HideResult=true, Dialog(tab="Advanced"));
      SI.Angle phi(stateSelect=stateSelect)
        "Absolute rotation angle of component"
        annotation (Dialog(group="Initialization", showStartAttribute=true));
      SI.AngularVelocity w(stateSelect=stateSelect)
        "Absolute angular velocity of component (= der(phi))"
        annotation (Dialog(group="Initialization", showStartAttribute=true));
      SI.AngularAcceleration a
        "Absolute angular acceleration of component (= der(w))"
        annotation (Dialog(group="Initialization", showStartAttribute=true));

    equation
      phi = flange_a.phi;
      phi = flange_b.phi;
      w = der(phi);
      a = der(w);
      J*a = flange_a.tau + flange_b.tau;
      annotation (Documentation(info="<html>
<p>
Rotational component with <b>inertia</b> and two rigidly connected flanges.
</p>

</html>"), Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100.0,-100.0},{100.0,100.0}}),
      graphics={
        Rectangle(lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-10.0},{-50.0,10.0}}),
        Rectangle(lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{50.0,-10.0},{100.0,10.0}}),
        Line(points={{-80.0,-25.0},{-60.0,-25.0}}),
        Line(points={{60.0,-25.0},{80.0,-25.0}}),
        Line(points={{-70.0,-25.0},{-70.0,-70.0}}),
        Line(points={{70.0,-25.0},{70.0,-70.0}}),
        Line(points={{-80.0,25.0},{-60.0,25.0}}),
        Line(points={{60.0,25.0},{80.0,25.0}}),
        Line(points={{-70.0,45.0},{-70.0,25.0}}),
        Line(points={{70.0,45.0},{70.0,25.0}}),
        Line(points={{-70.0,-70.0},{70.0,-70.0}}),
        Rectangle(lineColor={64,64,64},
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-50.0,-50.0},{50.0,50.0}},
          radius=10.0),
        Text(lineColor={0,0,255},
          extent={{-150.0,60.0},{150.0,100.0}},
          textString="%name"),
        Text(extent={{-150.0,-120.0},{150.0,-80.0}},
          textString="J=%J"),
        Rectangle(
          lineColor = {64,64,64},
          fillColor = {255,255,255},
          extent = {{-50,-50},{50,50}},
          radius = 10)}));
    end Inertia;

    model Disc
      "1-dim. rotational rigid component without inertia, where right flange is rotated by a fixed angle with respect to left flange"
      extends Rotational.Interfaces.PartialTwoFlanges;
      parameter SI.Angle deltaPhi=0
        "Fixed rotation of left flange with respect to right flange (= flange_b.phi - flange_a.phi)";
      SI.Angle phi "Absolute rotation angle of component";

    equation
      flange_a.phi = phi - deltaPhi/2;
      flange_b.phi = phi + deltaPhi/2;
      0 = flange_a.tau + flange_b.tau;
      annotation (Documentation(info="<html>
<p>
Rotational component with two rigidly connected flanges without <b>inertia</b>.
The right flange is rotated by the fixed angle \"deltaPhi\" with respect to the left
flange.
</p>

</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
            Rectangle(    lineColor={64,64,64},
              fillColor={192,192,192},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100.0,-10.0},{99.0,10.0}}),
            Rectangle(    lineColor={64,64,64},
              fillColor={192,192,192},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-10.0,-50.0},{10.0,50.0}}),
            Text(    lineColor={0,0,255},
              extent={{-150.0,60.0},{150.0,100.0}},
              textString="%name"),
            Rectangle(    lineColor={64,64,64},
              fillColor={192,192,192},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-30.0,10.0},{-10.0,50.0}}),
            Rectangle(    lineColor={64,64,64},
              fillColor={192,192,192},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{10.0,-50.0},{30.0,-10.0}}),
            Text(    extent={{-160.0,-87.0},{160.0,-62.0}},
              textString="deltaPhi = %deltaPhi")}));
    end Disc;

    model Spring "Linear 1D rotational spring"
      extends Modelica.Mechanics.Rotational.Interfaces.PartialCompliant;
      parameter SI.RotationalSpringConstant c(final min=0, start=1.0e5)
        "Spring constant";
      parameter SI.Angle phi_rel0=0 "Unstretched spring angle";

    equation
      tau = c*(phi_rel - phi_rel0);
      annotation (
        Documentation(info="<html>
<p>
A <b>linear 1D rotational spring</b>. The component can be connected either
between two inertias/gears to describe the shaft elasticity, or between
a inertia/gear and the housing (component Fixed), to describe
a coupling of the element with the housing via a spring.
</p>

</html>"),
        Icon(
        coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
          graphics={
        Text(extent={{-150,80},{150,40}},
          textString="%name",
          lineColor={0,0,255}),
        Text(extent={{-150,-40},{150,-80}},
          lineColor={0,0,0},
          textString="c=%c"),
        Line(points={{-100,0},{-58,0},{-43,-30},{-13,30},{17,-30},{47,30},{62,0},{100,0}})}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Line(points={{-68,0},{-68,65}}, color={128,128,128}),
            Line(points={{72,0},{72,65}}, color={128,128,128}),
            Line(points={{-68,60},{72,60}}, color={128,128,128}),
            Polygon(
              points={{62,63},{72,60},{62,57},{62,63}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-22,62},{18,87}},
              lineColor={0,0,255},
              textString="phi_rel"),
            Line(points={{-96,0},{-60,0},{-42,-32},{-12,30},{18,-30},{48,28},{
                  62,0},{96,0}}, color={0,0,255})}));
    end Spring;

    model Damper "Linear 1D rotational damper"
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;
      parameter SI.RotationalDampingConstant d(final min=0, start=0)
        "Damping constant";
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
    equation
      tau = d*w_rel;
      lossPower = tau*w_rel;
      annotation (
        Documentation(info="<html>
<p>
<b>Linear, velocity dependent damper</b> element. It can be either connected
between an inertia or gear and the housing (component Fixed), or
between two inertia/gear elements.
</p>

<p>
See also the discussion
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
in the User's Guide of the Rotational library.
</p>
</html>"),
        Icon(
        coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-90,0},{-60,0}}),
        Line(points={{-60,-30},{-60,30}}),
        Line(points={{-60,-30},{60,-30}}),
        Line(points={{-60,30},{60,30}}),
        Rectangle(extent={{-60,30},{30,-30}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{30,0},{90,0}}),
        Text(extent={{-150,80},{150,40}},
          textString="%name",
          lineColor={0,0,255}),
        Text(extent={{-150,-50},{150,-90}},
          lineColor={0,0,0},
          textString="d=%d"),
        Line(visible=useHeatPort,
          points={{-100,-100},{-100,-40},{-20,-40},{-20,0}},
          color={191,0,0},
          pattern=LinePattern.Dot)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Line(points={{-96,0},{-60,0}}),
            Line(points={{-60,-30},{-60,30}}),
            Line(points={{-60,-30},{60,-30}}),
            Line(points={{-60,30},{60,30}}),
            Rectangle(
              extent={{-60,30},{30,-30}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{30,0},{96,0}}),
            Line(points={{-68,0},{-68,65}}, color={128,128,128}),
            Text(
              extent={{-40,66},{33,85}},
              lineColor={0,0,255},
              textString="phi_rel"),
            Line(points={{-68,60},{72,60}}, color={128,128,128}),
            Line(points={{72,0},{72,65}}, color={128,128,128}),
            Polygon(
              points={{62,63},{72,60},{62,57},{62,63}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid)}));
    end Damper;

    model SpringDamper "Linear 1D rotational spring and damper in parallel"
      parameter SI.RotationalSpringConstant c(final min=0, start=1.0e5)
        "Spring constant";
      parameter SI.RotationalDampingConstant d(final min=0, start=0)
        "Damping constant";
      parameter SI.Angle phi_rel0=0 "Unstretched spring angle";
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
    protected
      Modelica.SIunits.Torque tau_c "Spring torque";
      Modelica.SIunits.Torque tau_d "Damping torque";
    equation
      tau_c = c*(phi_rel - phi_rel0);
      tau_d = d*w_rel;
      tau = tau_c + tau_d;
      lossPower = tau_d*w_rel;
      annotation (
        Documentation(info="<html>
<p>
A <b>spring</b> and <b>damper</b> element <b>connected in parallel</b>.
The component can be
connected either between two inertias/gears to describe the shaft elasticity
and damping, or between an inertia/gear and the housing (component Fixed),
to describe a coupling of the element with the housing via a spring/damper.
</p>

<p>
See also the discussion
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
in the User's Guide of the Rotational library.
</p>
</html>"),
        Icon(
          coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}),
            graphics={
        Line(points={{-80,40},{-60,40},{-45,10},{-15,70},{15,10},{45,70},{60,40},{80,40}}),
        Line(points={{-80,40},{-80,-40}}),
        Line(points={{-80,-40},{-50,-40}}),
        Rectangle(extent={{-50,-10},{40,-70}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-50,-10},{70,-10}}),
        Line(points={{-50,-70},{70,-70}}),
        Line(points={{40,-40},{80,-40}}),
        Line(points={{80,40},{80,-40}}),
        Line(points={{-90,0},{-80,0}}),
        Line(points={{80,0},{90,0}}),
        Text(origin={0,-9},
          extent={{-150,-144},{150,-104}},
          lineColor={0,0,0},
          textString="d=%d"),
        Text(extent={{-190,110},{190,70}},
          lineColor={0,0,255},
          textString="%name"),
        Text(
          origin={0,-7},
          extent={{-150,-108},{150,-68}},
          lineColor={0,0,0},
          textString="c=%c"),
        Line(visible=useHeatPort,
          points={{-100,-100},{-100,-55},{-5,-55}},
          color={191,0,0},
          pattern=LinePattern.Dot)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Line(
              points={{-80,32},{-58,32},{-43,2},{-13,62},{17,2},{47,62},{62,32},
                  {80,32}},
              thickness=0.5),
            Line(points={{-68,32},{-68,97}}, color={128,128,128}),
            Line(points={{72,32},{72,97}}, color={128,128,128}),
            Line(points={{-68,92},{72,92}}, color={128,128,128}),
            Polygon(
              points={{62,95},{72,92},{62,89},{62,95}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-44,79},{29,91}},
              lineColor={0,0,255},
              textString="phi_rel"),
            Rectangle(
              extent={{-50,-20},{40,-80}},
              lineColor={0,0,0},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-50,-80},{68,-80}}),
            Line(points={{-50,-20},{68,-20}}),
            Line(points={{40,-50},{80,-50}}),
            Line(points={{-80,-50},{-50,-50}}),
            Line(points={{-80,32},{-80,-50}}),
            Line(points={{80,32},{80,-50}}),
            Line(points={{-96,0},{-80,0}}),
            Line(points={{96,0},{80,0}})}));
    end SpringDamper;

    model ElastoBacklash
      "Backlash connected in series to linear spring and damper (backlash is modeled with elasticity)"

      parameter SI.RotationalSpringConstant c(final min=Modelica.Constants.small,
          start=1.0e5) "Spring constant (c > 0 required)";
      parameter SI.RotationalDampingConstant d(final min=0, start=0)
        "Damping constant";
      parameter SI.Angle b(final min=0) = 0 "Total backlash";
      parameter SI.Angle phi_rel0=0 "Unstretched spring angle";

      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
    protected
      final parameter SI.Angle bMax=b/2
        "Backlash in range bMin <= phi_rel - phi_rel0 <= bMax";
      final parameter SI.Angle bMin=-bMax
        "Backlash in range bMin <= phi_rel - phi_rel0 <= bMax";
      SI.Torque tau_c;
      SI.Torque tau_d;
      SI.Angle phi_diff=phi_rel - phi_rel0;

      // A minimum backlash is defined in order to avoid an infinite
      // number of state events if backlash b is set to zero.
      constant SI.Angle bEps=1e-10 "Minimum backlash";

    equation
      if initial() then
        /* During initialization the characteristic is modified, in order that
        it is a strict monotone rising function. Otherwise, initialization might
        result in a singular system when the characteristic has to be
        inverted. The characteristic is modified in the range 1.5*bMin <= phi_rel - phi_rel0 <= 1.5 bMax,
        so that in this range a linear characteristic is present that approaches the original
        function continuously at its limits, e.g.,
          original:  tau(1.5*bMax) = c*(phi_diff - bMax)
                                   = c*(0.5*bMax)
          initial :  tau(1.5*bMax) = (c/3)*phi_diff
                                   = (c/3)*(3/2)*bMax
                                   = (c/2)*bMax
     */
        tau_c = if phi_diff > 1.5*bMax then c*(phi_diff - bMax) else if
          phi_diff < 1.5*bMin then c*(phi_diff - bMin) else (c/3)*phi_diff;
        tau_d = d*w_rel;
        tau = tau_c + tau_d;
        lossPower = tau_d*w_rel;
      else
        /*
     if abs(b) <= bEps then
        tau_c = c*phi_diff;
        tau_d = d*w_rel;
        tau   = tau_c + tau_d;
     elseif phi_diff > bMax then
        tau_c = c*(phi_diff - bMax);
        tau_d = d*w_rel;
        tau   = smooth(0, noEvent(if tau_c + tau_d <= 0 then 0 else tau_c + min(tau_c,tau_d)));
     elseif phi_diff < bMin then
        tau_c = c*(phi_diff - bMin);
        tau_d = d*w_rel;
        tau   = smooth(0, noEvent(if tau_c + tau_d >= 0 then 0 else tau_c + max(tau_c,tau_d)));
     else
        tau_c = 0;
        tau_d = 0;
        tau   = 0;
     end if;

     This is written in the form below, in order that parameter "b"
     is not evaluated during translation (i.e., in the above form
     it cannot be changed anymore after translation).
   */

        tau_c = if abs(b) <= bEps then c*phi_diff else if phi_diff > bMax then
          c*(phi_diff - bMax) else if phi_diff < bMin then c*(phi_diff - bMin)
           else 0;
        tau_d = d*w_rel;
        tau = if abs(b) <= bEps then tau_c + tau_d else if phi_diff > bMax
           then smooth(0, noEvent(if tau_c + tau_d <= 0 then 0 else tau_c + min(
          tau_c, tau_d))) else if phi_diff < bMin then smooth(0, noEvent(if
          tau_c + tau_d >= 0 then 0 else tau_c + max(tau_c, tau_d))) else 0;
        lossPower = if abs(b) <= bEps then tau_d*w_rel else if phi_diff > bMax
           then smooth(0, noEvent(if tau_c + tau_d <= 0 then 0 else min(tau_c,
          tau_d)*w_rel)) else if phi_diff < bMin then smooth(0, noEvent(if
          tau_c + tau_d >= 0 then 0 else max(tau_c, tau_d)*w_rel)) else 0;
      end if;
      annotation (
        Documentation(info="<html>
<p>
This element consists of a <b>backlash</b> element <b>connected in series</b>
to a <b>spring</b> and <b>damper</b> element which are <b>connected in parallel</b>.
The spring constant shall be non-zero, otherwise the component cannot be used.
</p>

<p>
In combination with components IdealGear, the ElastoBacklash model
can be used to model a gear box with backlash, elasticity and damping.
</p>

<p>
During initialization, the backlash characteristic is replaced by a continuous
approximation in the backlash region, in order to reduce problems during
initialization, especially for inverse models.
</p>

<p>
If the backlash b is smaller as 1e-10 rad (especially, if b=0),
then the backlash is ignored and the component reduces to a spring/damper
element in parallel.
</p>

<p>
In the backlash region (-b/2 &le; flange_b.phi - flange_a.phi - phi_rel0 &le; b/2) no torque
is exerted (flange_b.tau = 0). Outside of this region, contact is present and
the contact torque is basically computed with a linear
spring/damper characteristic:
</p>

<pre>
   desiredContactTorque = c*phi_contact + d*<b>der</b>(phi_contact)

            phi_contact = phi_rel - phi_rel0 - b/2 <b>if</b> phi_rel - phi_rel0 &gt;  b/2
                        = phi_rel - phi_rel0 + b/2 <b>if</b> phi_rel - phi_rel0 &lt; -b/2

            phi_rel     = flange_b.phi - flange_a.phi;
</pre>

<p>
This torque characteristic leads to the following difficulties:
</p>

<ol>
<li> If the damper torque becomes larger as the spring torque and with opposite sign,
     the contact torque would be \"pulling/sticking\" which is unphysical, since during
     contact only pushing torques can occur.</li>

<li> When contact occurs with a non-zero relative speed (which is the usual
     situation), the damping torque has a non-zero value and therefore the contact
     torque changes discontinuously at phi_rel = phi_rel0. Again, this is not physical
     because the torque can only change continuously. (Note, this component is not an
     idealized model where a steep characteristic is approximated by a discontinuity,
     but it shall model the steep characteristic.)</li>
</ol>

<p>
In the literature there are several proposals to fix problem (2). However, there
seems to be no proposal to avoid sticking. For this reason, the most simple
approach is used in the ElastoBacklash model, to fix both problems by slight changes
to the linear spring/damper characteristic:
</p>

<pre>
    // Torque characteristic when phi_rel > phi_rel0
    <b>if</b> phi_rel - phi_rel0 &lt; b/2 <b>then</b>
       tau_c = 0;          // spring torque
       tau_d = 0;          // damper torque
       flange_b.tau = 0;
    <b>else</b>
       tau_c = c*(phi_rel - phi_rel0);    // spring torque
       tau_d = d*<b>der</b>(phi_rel);            // damper torque
       flange_b.tau = <b>if</b> tau_c + tau_d &le; 0 <b>then</b> 0 <b>else</b> tau_c + <b>min</b>( tau_c, tau_d );
    <b>end if</b>;
</pre>

<p>
Note, when sticking would occur (tau_c + tau_d &le; 0), then the contact torque
is explicitly set to zero. The \"min(tau_c, tau_d)\" part in the if-expression,
limits the damping torque when it is pushing. This means that at the start of
the contact (phi_rel - phi_rel0 = b/2), the damping torque is zero and is continuous.
The effect of both modifications is that the absolute value of the damping torque
is always limited by the absolute value of the spring torque: |tau_d| &le; |tau_c|.
</p>

<p>
In the next figure, a typical simulation with the ElastoBacklash model is shown
(<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.Backlash\">Examples.Backlash</a>)
where the different effects are visualized:
</p>

<ol>
<li> Curve 1 (elastoBacklash1.tau) is the unmodified contact torque, i.e., the linear spring/damper
     characteristic. A pulling/sticking torque is present at the end of the contact.</li>
<li> Curve 2 (elastoBacklash2.tau) is the contact torque, where the torque is explicitly set to
     zero when pulling/sticking occurs. The contact torque is discontinuous at begin of
     contact.</li>
<li> Curve 3 (elastoBacklash3.tau) is the ElastoBacklash model of this library. No discontinuity and no
     pulling/sticking occurs.</li>
</ol>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/elastoBacklash1.png\">
</p>

<p>
See also the discussion
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
in the User's Guide of the Rotational library.
</p>
</html>"),
        Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
          graphics={
        Line(points={{-80,32},{-58,32},{-48,0},{-34,61},{-20,0},{-8,60},{0,30},{20,30}}),
        Rectangle(extent={{-60,-10},{-10,-50}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,-50},{0,-50}}),
        Line(points={{-60,-10},{0,-10}}),
        Line(points={{-10,-30},{20,-30}}),
        Line(points={{-80,-30},{-60,-30}}),
        Line(points={{-80,32},{-80,-30}}),
        Line(points={{20,30},{20,-30}}),
        Line(points={{-90,0},{-80,0}}),
        Line(points={{90,0},{80,0}}),
        Line(points={{20,0},{60,0},{60,-30}}),
        Line(points={{40,-12},{40,-40},{80,-40},{80,0}}),
        Text(extent={{-150,-130},{150,-90}},
          lineColor={0,0,0},
          textString="b=%b"),
        Text(extent={{-150,100},{150,60}},
          lineColor={0,0,255},
          textString="%name"),
        Text(extent={{-152,-92},{148,-52}},
          lineColor={0,0,0},
          textString="c=%c"),
        Line(visible=useHeatPort,
          points={{-100,-100},{-100,-43},{-34,-43}},
          color={191,0,0},
          pattern=LinePattern.Dot)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Line(
              points={{-80,32},{-58,32},{-48,0},{-34,60},{-20,0},{-8,60},{0,30},
                  {20,30}},
              thickness=0.5),
            Line(points={{-68,32},{-68,97}}, color={128,128,128}),
            Line(points={{80,0},{80,96}}, color={128,128,128}),
            Line(points={{-68,92},{72,92}}, color={128,128,128}),
            Polygon(
              points={{70,95},{80,92},{70,89},{70,95}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-34,77},{40,90}},
              lineColor={128,128,128},
              textString="phi_rel"),
            Rectangle(
              extent={{-60,-20},{-10,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-52,-80},{0,-80}},
              thickness=0.5),
            Line(
              points={{-52,-20},{0,-20}},
              thickness=0.5),
            Line(
              points={{-10,-50},{20,-50}},
              thickness=0.5),
            Line(
              points={{-80,-50},{-60,-50}},
              thickness=0.5),
            Line(
              points={{-80,32},{-80,-50}},
              thickness=0.5),
            Line(
              points={{20,30},{20,-50}},
              thickness=0.5),
            Line(points={{-96,0},{-80,0}}),
            Line(
              points={{96,0},{80,0}},
              thickness=0.5),
            Line(
              points={{20,0},{60,0},{60,-30}},
              thickness=0.5),
            Line(
              points={{40,-12},{40,-40},{80,-40},{80,0}},
              thickness=0.5),
            Line(points={{30,0},{30,64}}, color={128,128,128}),
            Line(points={{30,60},{80,60}}, color={128,128,128}),
            Polygon(
              points={{70,63},{80,60},{70,57},{70,63}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{39,60},{68,46}},
              lineColor={160,160,164},
              textString="b")}));
    end ElastoBacklash;

    model ElastoBacklash2
      "Backlash connected in series to linear spring and damper (backlash is modeled with elasticity; at start of contact the flange torque can jump, contrary to the ElastoBacklash model)"

      parameter Modelica.SIunits.RotationalSpringConstant c(final min=Modelica.Constants.small,
          start=1.0e5) "Spring constant (c > 0 required)";
      parameter Modelica.SIunits.RotationalDampingConstant d(final min=0, start=0)
        "Damping constant";
      parameter Modelica.SIunits.Angle b(final min=0)=0 "Total backlash";
      parameter Modelica.SIunits.Angle phi_rel0=0 "Unstretched spring angle";

      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
    protected
      final parameter Modelica.SIunits.Angle bMax=b/2
        "Backlash in range bMin <= phi_rel - phi_rel0 <= bMax";
      final parameter Modelica.SIunits.Angle bMin=-bMax
        "Backlash in range bMin <= phi_rel - phi_rel0 <= bMax";
      Modelica.SIunits.Torque tau_c;
      Modelica.SIunits.Torque tau_d;
      Modelica.SIunits.Angle phi_diff=phi_rel - phi_rel0;

      // A minimum backlash is defined in order to avoid an infinite
      // number of state events if backlash b is set to zero.
      constant Modelica.SIunits.Angle bEps=1e-10 "Minimum backlash";

    equation
      if initial() then
        /* During initialization the characteristic is modified, in order that
        it is a strict monoton rising function. Otherwise, initialization might
        result in a singular system when the characteristic has to be
        inverted. The characteristic is modified in the range 1.5*bMin <= phi_rel - phi_rel0 <= 1.5 bMax,
        so that in this range a linear characteristic is present that approaches the original
        function continuously at its limits, e.g.,
          original:  tau(1.5*bMax) = c*(phi_diff - bMax)
                                   = c*(0.5*bMax)
          initial :  tau(1.5*bMax) = (c/3)*phi_diff
                                   = (c/3)*(3/2)*bMax
                                   = (c/2)*bMax
     */
        tau_c = if phi_diff > 1.5*bMax then c*(phi_diff - bMax) else if
          phi_diff < 1.5*bMin then c*(phi_diff - bMin) else (c/3)*phi_diff;
        tau_d = d*w_rel;
        tau = tau_c + tau_d;
        lossPower = tau_d*w_rel;
       else
         /*
     if abs(b) <= bEps then
        tau_c = c*phi_diff;
        tau_d = d*w_rel;
        tau   = tau_c + tau_d;
     elseif phi_diff > bMax then
        tau_c = c*(phi_diff - bMax);
        tau_d = d*w_rel;
        tau   = if tau_c + tau_d <= 0 then 0 else tau_c + tau_d;
     elseif phi_diff < bMin then
        tau_c = c*(phi_diff - bMin);
        tau_d = d*w_rel;
        tau   = if tau_c + tau_d >= 0 then 0 else tau_c + tau_d;
     else
        tau_c = 0;
        tau_d = 0;
        tau   = 0;
     end if;

     This is written in the form below, in order that parameter "b"
     is not evaluated during translation (i.e., in the above form
     it cannot be changed anymore after translation).
   */
        tau_c = if abs(b) <= bEps then
                   c*phi_diff
                else if phi_diff > bMax then
                   c*(phi_diff - bMax)
                else if phi_diff < bMin then
                   c*(phi_diff - bMin)
                else 0;
        tau_d = d*w_rel;

        tau = if abs(b) <= bEps then
                 tau_c + tau_d
              else if phi_diff > bMax then
                 (if tau_c + tau_d <= 0 then 0 else tau_c + tau_d)
              else if phi_diff < bMin then
                 (if tau_c + tau_d >= 0 then 0 else tau_c + tau_d)
              else 0;

        lossPower = if abs(b) <= bEps then
                       tau_d*w_rel
                    else if phi_diff > bMax then
                       (if tau_c + tau_d <= 0 then 0 else tau_d*w_rel)
                    else if phi_diff < bMin then
                       (if tau_c + tau_d >= 0 then 0 else tau_d*w_rel)
                    else 0;
      end if;
      annotation (
        Documentation(info="<html>
<p>
This element consists of a <b>backlash</b> element <b>connected in series</b>
to a <b>spring</b> and <b>damper</b> element which are <b>connected in parallel</b>.
The spring constant shall be non-zero, otherwise the component cannot be used.
</p>

<p>
In combination with components IdealGear, the ElastoBacklash2 model
can be used to model a gear box with backlash, elasticity and damping.
</p>

<p>
During initialization, the backlash characteristic is replaced by a continuous
approximation in the backlash region, in order to reduce problems during
initialization, especially for inverse models.
</p>

<p>
If the backlash b is smaller as 1e-10 rad (especially, if b=0),
then the backlash is ignored and the component reduces to a spring/damper
element in parallel.
</p>

<p>
In the backlash region (-b/2 &le; flange_b.phi - flange_a.phi - phi_rel0 &le; b/2) no torque
is exerted (flange_b.tau = 0). Outside of this region, contact is present and
the contact torque is basically computed with a linear
spring/damper characteristic:
</p>

<pre>
   desiredContactTorque = c*phi_contact + d*<b>der</b>(phi_contact)

            phi_contact = phi_rel - phi_rel0 - b/2 <b>if</b> phi_rel - phi_rel0 &gt;  b/2
                        = phi_rel - phi_rel0 + b/2 <b>if</b> phi_rel - phi_rel0 &lt; -b/2

            phi_rel     = flange_b.phi - flange_a.phi;
</pre>

<p>
This torque characteristic leads to the following difficulty:
</p>

<ul>
<li> If the damper torque becomes larger as the spring torque and with opposite sign,
     the contact torque would be \"pulling/sticking\" which is unphysical, since during
     contact only pushing torques can occur.</li>
</ul>

<p>
In the literature this issue seems to be not discussed. For this reason, the most simple
approach is used in the ElastoBacklash2 model, by slightly changing
the linear spring/damper characteristic to:
</p>

<pre>
    // Torque characteristic when phi_rel > phi_rel0
    <b>if</b> phi_rel - phi_rel0 &lt; b/2 <b>then</b>
       tau_c = 0;          // spring torque
       tau_d = 0;          // damper torque
       flange_b.tau = 0;
    <b>else</b>
       tau_c = c*(phi_rel - phi_rel0);    // spring torque
       tau_d = d*<b>der</b>(phi_rel);            // damper torque
       flange_b.tau = <b>if</b> tau_c + tau_d &le; 0 <b>then</b> 0 <b>else</b> tau_c + tau_d;
    <b>end if</b>;
</pre>

<p>
Note, when sticking would occur (tau_c + tau_d &le; 0), then the contact torque
is explicitly set to zero.
</p>


<p>
This model of backlash is slightly different to the
<a href=\"modelica://Modelica.Mechanics.Rotational.Components.ElastoBacklash\">ElastoBacklash</a>
component:
</p>

<ul>
<li> An event occurs when contact occurs or when contact is released (contrary to the ElastoBacklash component).</li>
<li> When contact occurs, the torque changes discontinuously, due to the damping.
     The damping is larger as for the ElastoBacklash component (for the same damping coefficient),
    because the ElastoBacklash component has a heuristic to avoid the discontinuity of the torque when contact occurs.</li>
<li> For some models, the ElastoBacklash2 component leads to faster simulations
      (as compared when using the ElastBacklash component).</li>
</ul>


<p>
See also the discussion
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
in the User's Guide of the Rotational library.
</p>
</html>"),
        Icon(
        coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
          graphics={
        Line(points={{-80,32},{-58,32},{-48,0},{-34,61},{-20,0},{-8,60},{0,30},{20,30}}),
        Rectangle(extent={{-60,-10},{-10,-50}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,-50},{0,-50}}),
        Line(points={{-60,-10},{0,-10}}),
        Line(points={{-10,-30},{20,-30}}),
        Line(points={{-80,-30},{-60,-30}}),
        Line(points={{-80,32},{-80,-30}}),
        Line(points={{20,30},{20,-30}}),
        Line(points={{-90,0},{-80,0}}),
        Line(points={{90,0},{80,0}}),
        Line(points={{20,0},{60,0},{60,-30}}),
        Line(points={{40,-12},{40,-40},{80,-40},{80,0}}),
        Text(extent={{-150,-130},{150,-90}},
          lineColor={0,0,0},
          textString="b=%b"),
        Text(extent={{-150,100},{150,60}},
          lineColor={0,0,255},
          textString="%name"),
        Text(extent={{-152,-92},{148,-52}},
          lineColor={0,0,0},
          textString="c=%c"),
        Line(visible=useHeatPort,
          points={{-100,-100},{-100,-43},{-34,-43}},
          color={191,0,0},
          pattern=LinePattern.Dot),
            Text(
              extent={{20,48},{80,10}},
              lineColor={95,95,95},
              textString="2")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Line(
              points={{-80,32},{-58,32},{-48,0},{-34,60},{-20,0},{-8,60},{0,30},
                  {20,30}},
              thickness=0.5),
            Line(points={{-68,32},{-68,97}}, color={128,128,128}),
            Line(points={{80,0},{80,96}}, color={128,128,128}),
            Line(points={{-68,92},{72,92}}, color={128,128,128}),
            Polygon(
              points={{70,95},{80,92},{70,89},{70,95}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-34,77},{40,90}},
              lineColor={128,128,128},
              textString="phi_rel"),
            Rectangle(
              extent={{-60,-20},{-10,-80}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-52,-80},{0,-80}},
              thickness=0.5),
            Line(
              points={{-52,-20},{0,-20}},
              thickness=0.5),
            Line(
              points={{-10,-50},{20,-50}},
              thickness=0.5),
            Line(
              points={{-80,-50},{-60,-50}},
              thickness=0.5),
            Line(
              points={{-80,32},{-80,-50}},
              thickness=0.5),
            Line(
              points={{20,30},{20,-50}},
              thickness=0.5),
            Line(points={{-96,0},{-80,0}}),
            Line(
              points={{96,0},{80,0}},
              thickness=0.5),
            Line(
              points={{20,0},{60,0},{60,-30}},
              thickness=0.5),
            Line(
              points={{40,-12},{40,-40},{80,-40},{80,0}},
              thickness=0.5),
            Line(points={{30,0},{30,64}}, color={128,128,128}),
            Line(points={{30,60},{80,60}}, color={128,128,128}),
            Polygon(
              points={{70,63},{80,60},{70,57},{70,63}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{39,60},{68,46}},
              lineColor={160,160,164},
              textString="b")}));
    end ElastoBacklash2;

    model BearingFriction "Coulomb friction in bearings"
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;

      parameter Real tau_pos[:, 2]=[0, 1]
        "[w,tau] Positive sliding friction characteristic (w>=0)";
      parameter Real peak(final min=1) = 1
        "peak*tau_pos[1,2] = Maximum friction torque for w==0";

      extends Rotational.Interfaces.PartialFriction;
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

      SI.Angle phi
        "Angle between shaft flanges (flange_a, flange_b) and support";
      SI.Torque tau "Friction torque";
      SI.AngularVelocity w "Absolute angular velocity of flange_a and flange_b";
      SI.AngularAcceleration a
        "Absolute angular acceleration of flange_a and flange_b";

    equation
      // Constant auxiliary variables
      tau0 = Modelica.Math.Vectors.interpolate(tau_pos[:,1], tau_pos[:,2], 0, 1);
      tau0_max = peak*tau0;
      free = false;

      phi = flange_a.phi - phi_support;
      flange_b.phi = flange_a.phi;

      // Angular velocity and angular acceleration of flanges
      w = der(phi);
      a = der(w);
      w_relfric = w;
      a_relfric = a;

      // Friction torque
      flange_a.tau + flange_b.tau - tau = 0;

      // Friction torque
      tau = if locked then sa*unitTorque else (
        if startForward then
          Modelica.Math.Vectors.interpolate(tau_pos[:,1], tau_pos[:,2], w, 1)
        else if startBackward then
          -Modelica.Math.Vectors.interpolate(tau_pos[:,1], tau_pos[:,2], -w, 1)
        else if pre(mode) == Forward then
          Modelica.Math.Vectors.interpolate(tau_pos[:,1], tau_pos[:,2], w, 1)
        else
          -Modelica.Math.Vectors.interpolate(tau_pos[:,1], tau_pos[:,2], -w, 1));
      lossPower = tau*w_relfric;
      annotation (Documentation(info="<html>
<p>
This element describes <b>Coulomb friction</b> in <b>bearings</b>,
i.e., a frictional torque acting between a flange and the housing.
The positive sliding friction torque \"tau\" has to be defined
by table \"tau_pos\" as function of the absolute angular velocity \"w\".
E.g.
</p>
<pre>
       w | tau
      ---+-----
       0 |   0
       1 |   2
       2 |   5
       3 |   8
</pre>
<p>
gives the following table:
</p>
<pre>
   tau_pos = [0, 0; 1, 2; 2, 5; 3, 8];
</pre>
<p>
Currently, only linear interpolation in the table is supported.
Outside of the table, extrapolation through the last
two table entries is used. It is assumed that the negative
sliding friction force has the same characteristic with negative
values. Friction is modelled in the following way:
</p>
<p>
When the absolute angular velocity \"w\" is not zero, the friction torque
is a function of w and of a constant normal force. This dependency
is defined via table tau_pos and can be determined by measurements,
e.g., by driving the gear with constant velocity and measuring the
needed motor torque (= friction torque).
</p>
<p>
When the absolute angular velocity becomes zero, the elements
connected by the friction element become stuck, i.e., the absolute
angle remains constant. In this phase the friction torque is
calculated from a torque balance due to the requirement, that
the absolute acceleration shall be zero.  The elements begin
to slide when the friction torque exceeds a threshold value,
called the maximum static friction torque, computed via:
</p>
<pre>
   maximum_static_friction = <b>peak</b> * sliding_friction(w=0)  (<b>peak</b> >= 1)
</pre>
<p>
This procedure is implemented in a \"clean\" way by state events and
leads to continuous/discrete systems of equations if friction elements
are dynamically coupled which have to be solved by appropriate
numerical methods. The method is described in
(see also a short sketch in <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\">UsersGuide.ModelingOfFriction</a>):
</p>
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><b>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</b>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>
<p>
More precise friction models take into account the elasticity of the
material when the two elements are \"stuck\", as well as other effects,
like hysteresis. This has the advantage that the friction element can
be completely described by a differential equation without events. The
drawback is that the system becomes stiff (about 10-20 times slower
simulation) and that more material constants have to be supplied which
requires more sophisticated identification. For more details, see the
following references, especially (Armstrong and Canudas de Witt 1996):
</p>
<dl>
<dt>Armstrong B. (1991):</dt>
<dd><b>Control of Machines with Friction</b>. Kluwer Academic
    Press, Boston MA.<br></dd>
<dt>Armstrong B., and Canudas de Wit C. (1996):</dt>
<dd><b>Friction Modeling and Compensation.</b>
    The Control Handbook, edited by W.S.Levine, CRC Press,
    pp. 1369-1382.<br></dd>
<dt>Canudas de Wit C., Olsson H., Astroem K.J., and Lischinsky P. (1995):</dt>
<dd><b>A new model for control of systems with friction.</b>
    IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.</dd>
</dl>
</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Rectangle(lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-10.0},{100.0,10.0}}),
        Rectangle(extent={{-60.0,-60.0},{60.0,-10.0}}),
        Rectangle(fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          extent={{-60.0,-25.0},{60.0,-10.0}}),
        Rectangle(fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          extent={{-60.0,-61.0},{60.0,-45.0}}),
        Rectangle(fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-50.0,-50.0},{50.0,-18.0}}),
        Polygon(fillColor={160,160,164},
          fillPattern=FillPattern.Solid,
          points={{60.0,-60.0},{60.0,-70.0},{75.0,-70.0},{75.0,-80.0},{-75.0,-80.0},{-75.0,-70.0},{-60.0,-70.0},{-60.0,-60.0},{60.0,-60.0}}),
        Line(points={{-75.0,-10.0},{-75.0,-70.0}}),
        Line(points={{75.0,-10.0},{75.0,-70.0}}),
        Rectangle(extent={{-60.0,10.0},{60.0,60.0}}),
        Rectangle(fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          extent={{-60.0,45.0},{60.0,60.0}}),
        Rectangle(fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          extent={{-60.0,10.0},{60.0,25.0}}),
        Rectangle(fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-50.0,19.0},{50.0,51.0}}),
        Line(points={{-75.0,70.0},{-75.0,10.0}}),
        Polygon(fillColor={160,160,164},
          fillPattern=FillPattern.Solid,
          points={{60.0,60.0},{60.0,70.0},{75.0,70.0},{75.0,80.0},{-75.0,80.0},{-75.0,70.0},{-60.0,70.0},{-60.0,60.0},{60.0,60.0}}),
        Line(points={{75.0,70.0},{75.0,10.0}}),
        Text(lineColor={0,0,255},
          extent={{-150.0,90.0},{150.0,130.0}},
          textString="%name"),
        Line(points={{0.0,-80.0},{0.0,-100.0}}),
        Line(visible=useHeatPort,
          points={{-100.0,-100.0},{-100.0,-35.0},{2.0,-35.0}},
          color={191,0,0},
          pattern=LinePattern.Dot)}));
    end BearingFriction;

    model Brake "Brake based on Coulomb friction"
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;

      parameter Real mue_pos[:, 2]=[0, 0.5]
        "[w,mue] positive sliding friction coefficient (w_rel>=0)";
      parameter Real peak(final min=1) = 1
        "peak*mue_pos[1,2] = maximum value of mue for w_rel==0";
      parameter Real cgeo(final min=0) = 1
        "Geometry constant containing friction distribution assumption";
      parameter SI.Force fn_max(final min=0, start=1) "Maximum normal force";

      extends Rotational.Interfaces.PartialFriction;
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

      SI.Angle phi
        "Angle between shaft flanges (flange_a, flange_b) and support";
      SI.Torque tau "Brake friction torque";
      SI.AngularVelocity w "Absolute angular velocity of flange_a and flange_b";
      SI.AngularAcceleration a
        "Absolute angular acceleration of flange_a and flange_b";

      Real mue0 "Friction coefficient for w=0 and forward sliding";
      SI.Force fn "Normal force (=fn_max*f_normalized)";

      // Constant auxiliary variable
      Modelica.Blocks.Interfaces.RealInput f_normalized
        "Normalized force signal 0..1 (normal force = fn_max*f_normalized; brake is active if > 0)"
        annotation (Placement(transformation(
            origin={0,110},
            extent={{20,-20},{-20,20}},
            rotation=90)));

    equation
      mue0 = Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], 0, 1);

      phi = flange_a.phi - phi_support;
      flange_b.phi = flange_a.phi;

      // Angular velocity and angular acceleration of flanges flange_a and flange_b
      w = der(phi);
      a = der(w);
      w_relfric = w;
      a_relfric = a;

      // Friction torque, normal force and friction torque for w_rel=0
      flange_a.tau + flange_b.tau - tau = 0;
      fn = fn_max*f_normalized;
      tau0 = mue0*cgeo*fn;
      tau0_max = peak*tau0;
      free = fn <= 0;

      // Friction torque
      tau = if locked then sa*unitTorque else if free then 0 else cgeo*fn*(
        if startForward then
          Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], w, 1)
        else if startBackward then
          -Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], -w, 1)
        else if pre(mode) == Forward then
          Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], w, 1)
        else
          -Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], -w, 1));
      lossPower = tau*w_relfric;
      annotation (Icon(
            coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}}),
            graphics={
          Polygon(  lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            points={{-37.0,-55.0},{-37.0,-90.0},{37.0,-90.0},{37.0,-55.0},{33.0,-55.0},{33.0,-86.0},{-33.0,-86.0},{-33.0,-55.0},{-37.0,-55.0}}),
          Rectangle(  lineColor={64,64,64},
            fillColor={192,192,192},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100.0,-10.0},{-20.0,10.0}}),
          Rectangle(  lineColor={64,64,64},
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-20.0,-60.0},{20.0,60.0}},
            radius=10.0),
          Rectangle(  lineColor={64,64,64},
            extent={{-20.0,-60.0},{20.0,60.0}},
            radius=10.0),
          Rectangle(  lineColor={64,64,64},
            fillColor={192,192,192},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{20.0,-10.0},{100.0,10.0}}),
          Polygon(  lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            points={{40.0,-40.0},{70.0,-30.0},{70.0,-50.0},{40.0,-40.0}}),
          Rectangle(  fillPattern=FillPattern.Solid,
            extent={{30.0,-55.0},{40.0,-25.0}}),
          Polygon(  lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            points={{-40.0,-40.0},{-70.0,-30.0},{-70.0,-50.0},{-40.0,-40.0}}),
          Rectangle(  fillPattern=FillPattern.Solid,
            extent={{-40.0,-55.0},{-30.0,-25.0}}),
          Line(  points={{0.0,90.0},{80.0,70.0},{80.0,-40.0},{70.0,-40.0}},
            color={0,0,127}),
          Line(  points={{0.0,90.0},{-80.0,70.0},{-80.0,-40.0},{-70.0,-40.0}},
            color={0,0,127}),
          Text(  lineColor={0,0,255},
            extent={{-150.0,-180.0},{150.0,-140.0}},
            textString="%name"),
          Line(visible=useHeatPort,
            points={{-100.0,-98.0},{-100.0,-70.0},{0.0,-70.0},{0.0,-40.0}},
            color={191,0,0},
            pattern=LinePattern.Dot)}), Documentation(info="<html>
<p>
This component models a <b>brake</b>, i.e., a component where a frictional
torque is acting between the housing and a flange and a controlled normal
force presses the flange to the housing in order to increase friction.
The normal force fn has to be provided as input signal f_normalized in a normalized form
(0 &le; f_normalized &le; 1),
fn = fn_max*f_normalized, where fn_max has to be provided as parameter.
Friction in the brake is modelled in the following way:
</p>
<p>
When the absolute angular velocity \"w\" is not zero, the friction torque
is a function of the velocity dependent friction coefficient  mue(w) , of
the normal force \"fn\", and of a geometry constant \"cgeo\" which takes into
account the geometry of the device and the assumptions on the friction
distributions:
</p>
<pre>
        frictional_torque = <b>cgeo</b> * <b>mue</b>(w) * <b>fn</b>
</pre>
<p>
   Typical values of coefficients of friction:
</p>
<pre>
      dry operation   :  <b>mue</b> = 0.2 .. 0.4
      operating in oil:  <b>mue</b> = 0.05 .. 0.1
</pre>
<p>
   When plates are pressed together, where  <b>ri</b>  is the inner radius,
   <b>ro</b> is the outer radius and <b>N</b> is the number of friction interfaces,
   the geometry constant is calculated in the following way under the
   assumption of a uniform rate of wear at the interfaces:
</p>
<pre>
         <b>cgeo</b> = <b>N</b>*(<b>r0</b> + <b>ri</b>)/2
</pre>
<p>
    The positive part of the friction characteristic <b>mue</b>(w),
    w >= 0, is defined via table mue_pos (first column = w,
    second column = mue). Currently, only linear interpolation in
    the table is supported.
</p>
<p>
   When the absolute angular velocity becomes zero, the elements
   connected by the friction element become stuck, i.e., the absolute
   angle remains constant. In this phase the friction torque is
   calculated from a torque balance due to the requirement, that
   the absolute acceleration shall be zero.  The elements begin
   to slide when the friction torque exceeds a threshold value,
   called the  maximum static friction torque, computed via:
</p>
<pre>
       frictional_torque = <b>peak</b> * <b>cgeo</b> * <b>mue</b>(w=0) * <b>fn</b>   (<b>peak</b> >= 1)
</pre>
<p>
This procedure is implemented in a \"clean\" way by state events and
leads to continuous/discrete systems of equations if friction elements
are dynamically coupled. The method is described in
(see also a short sketch in <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\">UsersGuide.ModelingOfFriction</a>):
</p>
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><b>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</b>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>
<p>
More precise friction models take into account the elasticity of the
material when the two elements are \"stuck\", as well as other effects,
like hysteresis. This has the advantage that the friction element can
be completely described by a differential equation without events. The
drawback is that the system becomes stiff (about 10-20 times slower
simulation) and that more material constants have to be supplied which
requires more sophisticated identification. For more details, see the
following references, especially (Armstrong and Canudas de Witt 1996):
</p>
<dl>
<dt>Armstrong B. (1991):</dt>
<dd><b>Control of Machines with Friction</b>. Kluwer Academic
    Press, Boston MA.<br></dd>
<dt>Armstrong B., and Canudas de Wit C. (1996):</dt>
<dd><b>Friction Modeling and Compensation.</b>
    The Control Handbook, edited by W.S.Levine, CRC Press,
    pp. 1369-1382.<br></dd>
<dt>Canudas de Wit C., Olsson H., Astroem K.J., and Lischinsky P. (1995):</dt>
<dd><b>A new model for control of systems with friction.</b>
    IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.</dd>
</dl>

<p>
See also the discussion
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
in the User's Guide of the Rotational library.
</p>
</html>"));
    end Brake;

    model Clutch "Clutch based on Coulomb friction"
      extends Modelica.Mechanics.Rotational.Icons.Clutch;
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;

      parameter Real mue_pos[:, 2]=[0, 0.5]
        "[w,mue] positive sliding friction coefficient (w_rel>=0)";
      parameter Real peak(final min=1) = 1
        "peak*mue_pos[1,2] = maximum value of mue for w_rel==0";
      parameter Real cgeo(final min=0) = 1
        "Geometry constant containing friction distribution assumption";
      parameter SI.Force fn_max(final min=0, start=1) "Maximum normal force";

      extends Rotational.Interfaces.PartialFriction;
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

      Real mue0 "Friction coefficient for w=0 and forward sliding";
      SI.Force fn "Normal force (fn=fn_max*f_normalized)";
      Modelica.Blocks.Interfaces.RealInput f_normalized
        "Normalized force signal 0..1 (normal force = fn_max*f_normalized; clutch is engaged if > 0)"
        annotation (Placement(transformation(
            origin={0,110},
            extent={{20,-20},{-20,20}},
            rotation=90)));

    equation
      // Constant auxiliary variable
      mue0 = Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], 0, 1);

      // Relative quantities
      w_relfric = w_rel;
      a_relfric = a_rel;

      // Normal force and friction torque for w_rel=0
      fn = fn_max*f_normalized;
      free = fn <= 0;
      tau0 = mue0*cgeo*fn;
      tau0_max = peak*tau0;

      // Friction torque
      tau = if locked then sa*unitTorque else if free then 0 else cgeo*fn*(
        if startForward then
          Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], w_rel, 1)
        else if startBackward then
          -Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], w_rel, 1)
        else if pre(mode) == Forward then
          Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], w_rel, 1)
        else
          -Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], -w_rel, 1));
      lossPower = tau*w_relfric;
      annotation (Icon(
          coordinateSystem(preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}),
            graphics={
          Text(extent={{-150,-110},{150,-70}},
            textString="%name",
            lineColor={0,0,255}),
          Line(visible=useHeatPort,
            points={{-100,-100},{-100,-40},{0,-40}},
            color={191,0,0},
            pattern=LinePattern.Dot)}), Documentation(info="<html>
<p>
This component models a <b>clutch</b>, i.e., a component with
two flanges where friction is present between the two flanges
and these flanges are pressed together via a normal force.
The normal force fn has to be provided as input signal f_normalized in a normalized form
(0 &le; f_normalized &le; 1),
fn = fn_max*f_normalized, where fn_max has to be provided as parameter. Friction in the
clutch is modelled in the following way:
</p>
<p>
When the relative angular velocity is not zero, the friction torque is a
function of the velocity dependent friction coefficient  mue(w_rel) , of
the normal force \"fn\", and of a geometry constant \"cgeo\" which takes into
account the geometry of the device and the assumptions on the friction
distributions:
</p>
<pre>
        frictional_torque = <b>cgeo</b> * <b>mue</b>(w_rel) * <b>fn</b>
</pre>
<p>
   Typical values of coefficients of friction:
</p>
<pre>
      dry operation   :  <b>mue</b> = 0.2 .. 0.4
      operating in oil:  <b>mue</b> = 0.05 .. 0.1
</pre>
<p>
   When plates are pressed together, where  <b>ri</b>  is the inner radius,
   <b>ro</b> is the outer radius and <b>N</b> is the number of friction interfaces,
   the geometry constant is calculated in the following way under the
   assumption of a uniform rate of wear at the interfaces:
</p>
<pre>
         <b>cgeo</b> = <b>N</b>*(<b>r0</b> + <b>ri</b>)/2
</pre>
<p>
    The positive part of the friction characteristic <b>mue</b>(w_rel),
    w_rel >= 0, is defined via table mue_pos (first column = w_rel,
    second column = mue). Currently, only linear interpolation in
    the table is supported.
</p>
<p>
   When the relative angular velocity becomes zero, the elements
   connected by the friction element become stuck, i.e., the relative
   angle remains constant. In this phase the friction torque is
   calculated from a torque balance due to the requirement, that
   the relative acceleration shall be zero.  The elements begin
   to slide when the friction torque exceeds a threshold value,
   called the  maximum static friction torque, computed via:
</p>
<pre>
       frictional_torque = <b>peak</b> * <b>cgeo</b> * <b>mue</b>(w_rel=0) * <b>fn</b>   (<b>peak</b> >= 1)
</pre>
<p>
This procedure is implemented in a \"clean\" way by state events and
leads to continuous/discrete systems of equations if friction elements
are dynamically coupled. The method is described in
(see also a short sketch in <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\">UsersGuide.ModelingOfFriction</a>):
</p>
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><b>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</b>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>
<p>
More precise friction models take into account the elasticity of the
material when the two elements are \"stuck\", as well as other effects,
like hysteresis. This has the advantage that the friction element can
be completely described by a differential equation without events. The
drawback is that the system becomes stiff (about 10-20 times slower
simulation) and that more material constants have to be supplied which
requires more sophisticated identification. For more details, see the
following references, especially (Armstrong and Canudas de Witt 1996):
</p>
<dl>
<dt>Armstrong B. (1991):</dt>
<dd><b>Control of Machines with Friction</b>. Kluwer Academic
    Press, Boston MA.<br></dd>
<dt>Armstrong B., and Canudas de Wit C. (1996):</dt>
<dd><b>Friction Modeling and Compensation.</b>
    The Control Handbook, edited by W.S.Levine, CRC Press,
    pp. 1369-1382.<br></dd>
<dt>Canudas de Wit C., Olsson H., Astroem K.J., and Lischinsky P. (1995):</dt>
<dd><b>A new model for control of systems with friction.</b>
    IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.</dd>
</dl>

<p>
See also the discussion
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
in the User's Guide of the Rotational library.
</p>
</html>"));
    end Clutch;

    model OneWayClutch "Series connection of freewheel and clutch"
      extends Modelica.Mechanics.Rotational.Icons.Clutch;
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialCompliantWithRelativeStates;

      parameter Real mue_pos[:, 2]=[0, 0.5]
        "[w,mue] positive sliding friction coefficient (w_rel>=0)";
      parameter Real peak(final min=1) = 1
        "peak*mue_pos[1,2] = maximum value of mue for w_rel==0";
      parameter Real cgeo(final min=0) = 1
        "Geometry constant containing friction distribution assumption";
      parameter SI.Force fn_max(final min=0, start=1) "Maximum normal force";
      parameter SI.AngularVelocity w_small=1e10
        "Relative angular velocity near to zero if jumps due to a reinit(..) of the velocity can occur (set to low value only if such impulses can occur)"
        annotation (Dialog(tab="Advanced"));
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

      Real u "Normalized force input signal (0..1)";
      SI.Force fn "Normal force (fn=fn_max*inPort.signal)";
      Boolean startForward(start=false)
        "true, if w_rel=0 and start of forward sliding or w_rel > w_small";
      Boolean locked(start=false) "true, if w_rel=0 and not sliding";
      Boolean stuck(start=false) "w_rel=0 (locked or start forward sliding)";

    protected
      SI.Torque tau0 "Friction torque for w=0 and sliding";
      SI.Torque tau0_max "Maximum friction torque for w=0 and locked";
      Real mue0 "Friction coefficient for w=0 and sliding";
      Boolean free "true, if frictional element is not active";
      Real sa(final unit="1")
        "Path parameter of tau = f(a_rel) Friction characteristic";
      constant Real eps0=1.0e-4 "Relative hysteresis epsilon";
      SI.Torque tau0_max_low "Lowest value for tau0_max";
      parameter Real peak2=max([peak, 1 + eps0]);
      constant SI.AngularAcceleration unitAngularAcceleration=1;
      constant SI.Torque unitTorque=1;
    public
      Modelica.Blocks.Interfaces.RealInput f_normalized
        "Normalized force signal 0..1 (normal force = fn_max*f_normalized; clutch is engaged if > 0)"
        annotation (Placement(transformation(
            origin={0,110},
            extent={{20,-20},{-20,20}},
            rotation=90)));

    equation
      // Constant auxiliary variable
      mue0 = Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], 0, 1);
      tau0_max_low = eps0*mue0*cgeo*fn_max;

      // Normal force and friction torque for w_rel=0
      u = f_normalized;
      free = u <= 0;
      fn = if free then 0 else fn_max*u;
      tau0 = mue0*cgeo*fn;
      tau0_max = if free then tau0_max_low else peak2*tau0;

      /* Friction characteristic
       (locked is introduced to help the Modelica translator determining
       the different structural configurations, if for each configuration
       special code shall be generated)
    */
      startForward = pre(stuck) and (sa > tau0_max/unitTorque or pre(
        startForward) and sa > tau0/unitTorque or w_rel > w_small) or initial()
         and (w_rel > 0);
      locked = pre(stuck) and not startForward;

      // acceleration and friction torque
      a_rel = unitAngularAcceleration*(if locked then 0 else sa - tau0/
        unitTorque);
      tau = if locked then sa*unitTorque else (if free then 0 else cgeo*fn*
        Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], w_rel, 1));

      // Determine configuration
      stuck = locked or w_rel <= 0;

      lossPower = if stuck then 0 else tau*w_rel;
      annotation (Icon(
            coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}),
              graphics={
            Text(extent={{-150,-110},{150,-70}},
              textString="%name",
              lineColor={0,0,255}),
            Polygon(points={{-10,30},{50,0},{-10,-30},{-10,30}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(visible=useHeatPort,
              points={{-100,-99},{-100,-40},{0,-40}},
              color={191,0,0},
              pattern=LinePattern.Dot)}), Documentation(info="<html>
<p>
This component models a <b>one-way clutch</b>, i.e., a component with
two flanges where friction is present between the two flanges
and these flanges are pressed together via a normal force. These
flanges maybe sliding with respect to each other
Parallel connection of ClutchCombi and of FreeWheel.
                     The element is introduced to resolve the ambiguity
                     of the constraint torques of the elements.
</p>
<p>
A one-way-clutch is an element where a clutch is connected in parallel
to a free wheel. This special element is provided, because such
a parallel connection introduces an ambiguity into the model
(the constraint torques are not uniquely defined when both
elements are stuck) and this element resolves it by introducing
<b>one</b> constraint torque and not two.
</p>
<p>
Note, initial values have to be chosen for the model, such that the
relative speed of the one-way-clutch >= 0. Otherwise, the configuration
is physically not possible and an error occurs.
</p>
<p>
The normal force fn has to be provided as input signal f_normalized in a normalized form
(0 &le; f_normalized &le; 1),
fn = fn_max*f_normalized, where fn_max has to be provided as parameter. Friction in the
clutch is modelled in the following way:
</p>
<p>
When the relative angular velocity is positive, the friction torque is a
function of the velocity dependent friction coefficient  mue(w_rel) , of
the normal force \"fn\", and of a geometry constant \"cgeo\" which takes into
account the geometry of the device and the assumptions on the friction
distributions:
</p>
<pre>
        frictional_torque = <b>cgeo</b> * <b>mue</b>(w_rel) * <b>fn</b>
</pre>
<p>
   Typical values of coefficients of friction:
</p>
<pre>
      dry operation   :  <b>mue</b> = 0.2 .. 0.4
      operating in oil:  <b>mue</b> = 0.05 .. 0.1
</pre>
<p>
   When plates are pressed together, where  <b>ri</b>  is the inner radius,
   <b>ro</b> is the outer radius and <b>N</b> is the number of friction interfaces,
   the geometry constant is calculated in the following way under the
   assumption of a uniform rate of wear at the interfaces:
</p>
<pre>
         <b>cgeo</b> = <b>N</b>*(<b>r0</b> + <b>ri</b>)/2
</pre>
<p>
    The positive part of the friction characteristic <b>mue</b>(w_rel),
    w_rel >= 0, is defined via table mue_pos (first column = w_rel,
    second column = mue). Currently, only linear interpolation in
    the table is supported.
</p>
<p>
   When the relative angular velocity becomes zero, the elements
   connected by the friction element become stuck, i.e., the relative
   angle remains constant. In this phase the friction torque is
   calculated from a torque balance due to the requirement, that
   the relative acceleration shall be zero.  The elements begin
   to slide when the friction torque exceeds a threshold value,
   called the  maximum static friction torque, computed via:
</p>
<pre>
       frictional_torque = <b>peak</b> * <b>cgeo</b> * <b>mue</b>(w_rel=0) * <b>fn</b>   (<b>peak</b> >= 1)
</pre>
<p>
This procedure is implemented in a \"clean\" way by state events and
leads to continuous/discrete systems of equations if friction elements
are dynamically coupled. The method is described in
(see also a short sketch in <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\">UsersGuide.ModelingOfFriction</a>):
</p>
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><b>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</b>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>

<p>
See also the discussion
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
in the User's Guide of the Rotational library.
</p>
</html>"));
    end OneWayClutch;

    model IdealGear "Ideal gear without inertia"
      extends Modelica.Mechanics.Rotational.Icons.Gear;
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
      parameter Real ratio(start=1)
        "Transmission ratio (flange_a.phi/flange_b.phi)";
      Modelica.SIunits.Angle phi_a
        "Angle between left shaft flange and support";
      Modelica.SIunits.Angle phi_b
        "Angle between right shaft flange and support";

    equation
      phi_a = flange_a.phi - phi_support;
      phi_b = flange_b.phi - phi_support;
      phi_a = ratio*phi_b;
      0 = ratio*flange_a.tau + flange_b.tau;
      annotation (Documentation(info="<html>
<p>
This element characterizes any type of gear box which is fixed in the
ground and which has one driving shaft and one driven shaft.
The gear is <b>ideal</b>, i.e., it does not have inertia, elasticity, damping
or backlash. If these effects have to be considered, the gear has to be
connected to other elements in an appropriate way.
</p>

</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
        graphics={
          Text(extent={{-153,145},{147,105}},
            lineColor={0,0,255},
            textString="%name"),
          Text(extent={{-146,-49},{154,-79}},
            lineColor={0,0,0},
          textString="ratio=%ratio")}));
    end IdealGear;

    model LossyGear
      "Gear with mesh efficiency and bearing friction (stuck/rolling possible)"

      extends Modelica.Mechanics.Rotational.Icons.Gear;
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport2;

      parameter Real ratio(start=1)
        "Transmission ratio (flange_a.phi/flange_b.phi)";
      parameter Real lossTable[:, 5]=[0, 1, 1, 0, 0]
        "Array for mesh efficiencies and bearing friction depending on speed";
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
      Modelica.SIunits.Angle phi_a
        "Angle between left shaft flange and support";
      Modelica.SIunits.Angle phi_b
        "Angle between right shaft flange and support";

      Real sa(final unit="1") "Path parameter for acceleration and torque loss";
      SI.AngularVelocity w_a
        "Angular velocity of flange_a with respect to support";
      SI.AngularAcceleration a_a
        "Angular acceleration of flange_a with respect to support";

      Real interpolation_result[1, 4]
        "Result of interpolation in lossTable (= [eta_mf1, eta_mf2, tau_bf1, tau_bf2])";
      Real eta_mf1(unit="1") "Mesh efficiency in case that flange_a is driving";
      Real eta_mf2(unit="1") "Mesh efficiency in case that flange_b is driving";
      SI.Torque tau_bf_a "Bearing friction torque on flange_a side";
      SI.Torque tau_eta
        "Torque that determines the driving side (= if forwardSliding then flange_a.tau-tau_bf_a else if backwardSliding then flange_a.tau+tau_bf_a else flange_a.tau)";

      SI.Torque tau_bf1
        "Absolute resultant bearing friction torque with respect to flange_a in case that flange_a is driving (= |tau_bf_a*eta_mf1 + tau_bf_b/i|)";
      SI.Torque tau_bf2
        "Absolute resultant bearing friction torque with respect to flange_a in case that flange_b is driving (= |tau_bf_a/eta_mf2 + tau_bf_b/i|)";

      SI.Torque quadrant1 "Torque loss if w_a > 0 and flange_a.tau >= 0";
      SI.Torque quadrant2 "Torque loss if w_a > 0 and flange_a.tau < 0";
      SI.Torque quadrant3 "Torque loss if w_a < 0 and flange_a.tau >= 0";
      SI.Torque quadrant4 "Torque loss if w_a < 0 and flange_a.tau < 0";

      // Resultant friction torques at quadrant values for angular velocities near zero
      SI.Torque quadrant1_p
        "Torque loss at w_a = 0+ to determine driving side (flange_a.tau >= 0)";
      SI.Torque quadrant2_p
        "Torque loss at w_a = 0+ to determine driving side (flange_a.tau < 0)";
      SI.Torque quadrant3_m
        "Torque loss at w_a = 0- to determine driving side (flange_a.tau >=0)";
      SI.Torque quadrant4_m
        "Torque loss at w_a = 0- to determine driving side (flange_a.tau < 0)";

      SI.Torque tauLoss
        "Torque loss due to friction in the gear teeth and in the bearings";
      SI.Torque tauLossMax "Torque loss for positive speed";
      SI.Torque tauLossMin "Torque loss for negative speed";

      SI.Torque tauLossMax_p "Torque loss for positive speed";
      SI.Torque tauLossMin_m "Torque loss for negative speed";

      Boolean tau_aPos(start=true)
        "Only for backwards compatibility (was previously: true, if torque of flange_a is not negative)";
      Boolean tau_etaPos(start=true) "true, if torque tau_eta is not negative";
      Boolean startForward(start=false) "true, if starting to roll forward";
      Boolean startBackward(start=false) "true, if starting to roll backward";
      Boolean locked(start=false) "true, if gear is locked";

      Boolean ideal
        "= true, if losses are neglected (that is lossTable = [0, 1, 1, 0, 0])";

      constant Integer Unknown=3 "Value of mode is not known";
      constant Integer Free=2 "Element is not active";
      constant Integer Forward=1 "w_a > 0 (forward rolling)";
      constant Integer Stuck=0
        "w_a = 0 (forward rolling, locked or backward rolling)";
      constant Integer Backward=-1 "w_a < 0 (backward rolling)";
      Integer mode(
        final min=Backward,
        final max=Unknown,
        start=Free,
        fixed=true)
        "Mode of friction element (unknown, not active, forward/backward rolling, stuck)";

      SI.Torque tau_eta_p "tau_eta assuming positive omega";
      SI.Torque tau_eta_m "tau_eta assuming negative omega";
    protected
      constant SI.AngularAcceleration unitAngularAcceleration=1;
      constant SI.Torque unitTorque=1;

      // get friction and eta information for omega=0
      parameter Real eta_mf1_0(unit="1")=Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,2], 0, 1);
      parameter Real eta_mf2_0(unit="1")=Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,3], 0, 1);
      parameter SI.Torque tau_bf1_0=abs(Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,4], 0, 1));
      parameter SI.Torque tau_bf2_0=abs(Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,5], 0, 1));
      parameter SI.Torque tau_bf_a_0=if Modelica.Math.isEqual(
              eta_mf1_0,
              1.0,
              Modelica.Constants.eps) and Modelica.Math.isEqual(
              eta_mf2_0,
              1.0,
              Modelica.Constants.eps) then tau_bf1_0/2 else (tau_bf1_0 -
          tau_bf2_0)/(eta_mf1_0 - 1.0/eta_mf2_0);
      // For eta_mf1_0=eta_mf2_0=1 the given bearing
      // friction can not be separated into a part
      // on side A or B, so it is done arbitrarily.
      // Calculate tau_bf_a_0 from the following equations
      //  tau_bf1_0=eta_mf1_0*tau_bf_a_0 + 1/ratio a_0
      //  tau_bf2_0=1/eta_mf2*tau_bf_a_0 + 1/ratio tau_bf_a_0
    equation
      assert(abs(ratio) > 0,
        "Error in initialization of LossyGear: ratio may not be zero");

      ideal = Modelica.Math.Matrices.isEqual(
            lossTable,
            [0, 1, 1, 0, 0],
            Modelica.Constants.eps);

      if ideal then
        interpolation_result = [1, 1, 0, 0];
        eta_mf1 = 1;
        eta_mf2 = 1;
        tau_bf1 = 0;
        tau_bf2 = 0;
      else
        interpolation_result = [
          Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,2], noEvent(abs(w_a)), 1),
          Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,3], noEvent(abs(w_a)), 1),
          Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,4], noEvent(abs(w_a)), 1),
          Modelica.Math.Vectors.interpolate(lossTable[:,1], lossTable[:,5], noEvent(abs(w_a)), 1)];
        eta_mf1 = interpolation_result[1, 1];
        eta_mf2 = interpolation_result[1, 2];
        tau_bf1 = noEvent(abs(interpolation_result[1, 3]));
        tau_bf2 = noEvent(abs(interpolation_result[1, 4]));
      end if;

      if Modelica.Math.isEqual(
              eta_mf1,
              1.0,
              Modelica.Constants.eps) and Modelica.Math.isEqual(
              eta_mf2,
              1.0,
              Modelica.Constants.eps) then
        // For eta_mf1=eta_mf2=1 the given bearing friction can not be
        // separated into a part on side A or B, so it is done arbitrarily.
        tau_bf_a = tau_bf1/2;
      else
        //calculate tau_bf_a from the following equations
        //tau_bf1 = eta_mf1*tau_bf_a + tau_bf_b / ratio
        //tau_bf2 = 1/eta_mf2*tau_bf_a + tau_bf_b / ratio
        tau_bf_a = (tau_bf1 - tau_bf2)/(eta_mf1 - 1.0/eta_mf2);
      end if;

      phi_a = flange_a.phi - phi_support;
      phi_b = flange_b.phi - phi_support;
      phi_a = ratio*phi_b;

      // Torque balance (no inertias)
      0 = flange_b.tau + ratio*(flange_a.tau - tauLoss);

      // Speed for friction element
      w_a = der(phi_a);
      a_a = der(w_a);

      // Determine driving side
      //assuming positive omega
      tau_eta_p = flange_a.tau - tau_bf_a_0;
      //assuming negative omega
      tau_eta_m = flange_a.tau + tau_bf_a_0;

      // assuming w>=0, take value at w=0 to decide rolling/stuck mode
      quadrant1_p = (1 - eta_mf1_0)*flange_a.tau + tau_bf1_0;
      quadrant2_p = (1 - 1/eta_mf2_0)*flange_a.tau + tau_bf2_0;
      tauLossMax_p = if noEvent(tau_eta_p > 0) then quadrant1_p else
        quadrant2_p;

      // assuming w<=0, take value at w=0 to decide rolling/stuck mode
      quadrant4_m = (1 - 1/eta_mf2_0)*flange_a.tau - tau_bf2_0;
      quadrant3_m = (1 - eta_mf1_0)*flange_a.tau - tau_bf1_0;
      tauLossMin_m = if noEvent(tau_eta_m > 0) then quadrant4_m else
        quadrant3_m;

      quadrant1 = (1 - eta_mf1)*flange_a.tau + tau_bf1;
      quadrant2 = (1 - 1/eta_mf2)*flange_a.tau + tau_bf2;
      quadrant4 = (1 - 1/eta_mf2)*flange_a.tau - tau_bf2;
      quadrant3 = (1 - eta_mf1)*flange_a.tau - tau_bf1;

      //tau eta: only for determination of driving side for calculation of tauloss
      tau_eta = if ideal then flange_a.tau else (if locked then flange_a.tau
         else (if (startForward or pre(mode) == Forward) then flange_a.tau -
        tau_bf_a else flange_a.tau + tau_bf_a));

      // Torque Losses
      tau_etaPos = tau_eta >= 0;
      tau_aPos = tau_etaPos;
      tauLossMax = if tau_etaPos then quadrant1 else quadrant2;
      tauLossMin = if tau_etaPos then quadrant4 else quadrant3;

      // Determine rolling/stuck mode when w_rel = 0
      startForward = pre(mode) == Stuck and sa > tauLossMax_p/unitTorque or
        initial() and w_a > 0;
      startBackward = pre(mode) == Stuck and sa < tauLossMin_m/unitTorque or
        initial() and w_a < 0;
      locked = not (ideal or pre(mode) == Forward or startForward or pre(mode)
         == Backward or startBackward);

      /* Parameterized curve description a_a = f1(sa), tauLoss = f2(sa)
       In comparison to Modelica.Mechanics.Rotational.FrictionBase it is possible
       to simplify the following expression as mode == Stuck is assured in case
       of startForward or startBackward */
      tauLoss = if ideal then 0 else (if locked then sa*unitTorque else (if (
        startForward or pre(mode) == Forward) then tauLossMax else tauLossMin));

      a_a = unitAngularAcceleration*(if locked then 0 else sa - tauLoss/
        unitTorque);

      /* Finite state machine to fix configuration after the computation above
       The above equations are only dependent on pre(mode) and not on the actual
       value of mode. This prevents loops. So mode can be determined in one step. */
      mode = if ideal then Free else (if (pre(mode) == Forward or startForward)
         and w_a > 0 then Forward else if (pre(mode) == Backward or
        startBackward) and w_a < 0 then Backward else Stuck);

      lossPower = tauLoss*w_a;
      annotation (Documentation(info="<html>
<p>
This component models the gear ratio and the <b>losses</b> of
a standard gear box in a <b>reliable</b> way including the stuck phases
that may occur at zero speed. The gear boxes that can
be handled are fixed in the ground or on a moving support, have one input and one
output shaft, and are essentially described by the equations:
</p>
<blockquote><pre>
             flange_a.phi  = i*flange_b.phi;
-(flange_b.tau - tau_bf_b) = i*eta_mf*(flange_a.tau - tau_bf_a);

// or        -flange_b.tau = i*eta_mf*(flange_a.tau - tau_bf_a - tau_bf_b/(i*eta_mf));
</pre></blockquote>
<p>
where
</p>

<ul>
<li> <b>i</b> is the constant <b>gear ratio</b>, </li>

<li> <b>eta_mf</b> = eta_mf(w_a) is the <b>mesh efficiency</b> due to the
     friction between the teeth of the gear wheels, </li>

<li> <b>tau_bf_a</b> = tau_bf_a(w_a) is the <b>bearing friction torque</b>
     on the flange_a side,</li>

<li> <b>tau_bf_b</b> = tau_bf_b(w_a) is the <b>bearing friction torque</b>
     on the flange_b side, and</li>

<li><b>w_a</b> = der(flange_a.phi) is the speed of flange_a</li>
</ul>

<p>
The loss terms \"eta_mf\", \"tau_bf_a\" and \"tau_bf_b\" are functions of the
<i>absolute value</i> of the input shaft speed w_a and of the energy
flow direction. They are defined by parameter <b>lossTable[:,5]
</b> where the columns of this table have the following
meaning:
</p>

<table BORDER=1 CELLSPACING=0 CELLPADDING=2>
  <tbody>
    <tr>
      <td valign=\"top\">|w_a|</td>
      <td valign=\"top\">eta_mf1</td>
      <td valign=\"top\">eta_mf2</td>
      <td valign=\"top\">|tau_bf1|</td>
      <td valign=\"top\">|tau_bf2|</td>
    </tr>
    <tr>
      <td align=\"center\">...</td>
      <td align=\"center\">...</td>
      <td align=\"center\">...</td>
      <td align=\"center\">...</td>
      <td align=\"center\">...</td>
    </tr>
    <tr>
      <td align=\"center\">...</td>
      <td align=\"center\">...</td>
      <td align=\"center\">...</td>
      <td align=\"center\">...</td>
      <td align=\"center\">...</td>
    </tr>
  </tbody>
</table>

<p>with</p>
<table BORDER=1 CELLSPACING=0 CELLPADDING=2>
  <tbody>
    <tr>
      <td valign=\"top\">|w_a|</td>
      <td valign=\"top\">Absolute value of angular velocity of input shaft flange_a</td>
    </tr>
    <tr>
      <td valign=\"top\">eta_mf1</td>
      <td valign=\"top\">Mesh efficiency in case that flange_a is driving</td>
    </tr>
    <tr>
      <td valign=\"top\">eta_mf2</td>
      <td valign=\"top\">Mesh efficiency in case that flange_b is driving</td>
    </tr>
    <tr>
      <td valign=\"top\">|tau_bf1|</td>
      <td valign=\"top\"> Absolute resultant bearing friction torque with respect to flange_a
                        in case that flange_a is driving<br>
                        (= |tau_bf_a*eta_mf1 + tau_bf_b/i|)
                        </td>
    </tr>
    <tr>
      <td valign=\"top\">|tau_bf2|</td>
      <td valign=\"top\"> Absolute resultant bearing friction torque with respect to flange_a
                        in case that flange_b is driving<br>
                        (= |tau_bf_a/eta_mf2 + tau_bf_b/i|)
                        </td>
    </tr>
  </tbody>
</table>
<p>
With these variables, the mesh efficiency and the bearing friction
are formally defined as:
</p>

<blockquote><pre>
<b>if</b> (flange_a.tau - tau_bf_a)*w_a &gt; 0 <b>or</b>
   (flange_a.tau - tau_bf_a) == 0 <b>and</b> w_a &gt; 0 <b>then</b>
   eta_mf := eta_mf1
   tau_bf := tau_bf1
<b>elseif</b> (flange_a.tau - tau_bf_a)*w_a &lt; 0 <b>or</b>
       (flange_a.tau - tau_bf_a) == 0 <b>and</b> w_a &lt; 0 <b>then</b>
   eta_mf := 1/eta_mf2
   tau_bf := tau_bf2
<b>else</b> // w_a == 0
   eta_mf and tau_bf are computed such that <b>der</b>(w_a) = 0
<b>end if</b>;
-flange_b.tau = i*(eta_mf*flange_a.tau - tau_bf);
</pre></blockquote>

<p>
Note, that the losses are modeled in a physically meaningful way taking
into account that at zero speed the movement may be locked due
to the friction in the gear teeth and/or in the bearings.
Due to this important property, this component can be used in
situations where the combination of the components
Modelica.Mechanics.Rotational.IdealGear and
Modelica.Mechanics.Rotational.GearEfficiency will fail because,
e.g., chattering occurs when using the
Modelica.Mechanics.Rotational.GearEfficiency model.
</p>

<h4>Acknowledgement:</h4>
<ul>
<li> The essential idea to model efficiency
     in this way is from Christoph Pelchen, ZF Friedrichshafen.</li>
<li> The article (Pelchen et.al. 2002), see Literature below,
     and the first implementation of LossyGear (up to version 3.1 of package Modelica)
     contained a bug leading to a non-converging solution in cases where the
     driving side is not obvious.
     This was pointed out by Christian Bertsch and Max Westenkirchner, Bosch,
     and Christian Bertsch proposed a concrete solution how to fix this
     bug, see Literature below.</li>
</ul>

<h4>Literature</h4>

<ul>
<li>Pelchen C.,
Schweiger C.,
and <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Otter M.</a>:
&quot;<a href=\"https://www.modelica.org/events/Conference2002/papers/p33_Pelchen.pdf\">Modeling
and Simulating the Efficiency of Gearboxes and of Planetary Gearboxes</a>,&quot; in
<I>Proceedings of the 2nd International Modelica Conference, Oberpfaffenhofen, Germany,</I>
pp. 257-266, The Modelica Association and Institute of Robotics and Mechatronics,
Deutsches Zentrum f&uuml;r Luft- und Raumfahrt e. V., March 18-19, 2002.</li>

<li>Bertsch C. (2009):
&quot;<a href=\"modelica://Modelica/Resources/Documentation/Mechanics/Lossy-Gear-Bug_Solution.pdf\">Problem
with model LossyGear and a proposed solution</a>&quot;,
Ticket <a href=\"https://trac.modelica.org/Modelica/ticket/108\">#108</a>,
Sept. 11, 2009.</li>
</ul>

</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
        Polygon(fillColor={161,35,41},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-109.0,40.0},{-80.0,40.0},{-80.0,80.0},{-90.0,80.0},{-70.0,100.0},{-50.0,80.0},{-60.0,80.0},{-60.0,20.0},{-109.0,20.0},{-109.0,40.0}}),
        Line(points={{-80.0,20.0},{-60.0,20.0}}),
        Text(lineColor={0,0,255},
          extent={{-148.0,105.0},{152.0,145.0}},
          textString="%name"),
        Text(extent={{-145.0,-79.0},{155.0,-49.0}},
          textString="ratio=%ratio"),
        Line(visible=useHeatPort,
          points={{-100.0,-100.0},{-100.0,-30.0},{0.0,-30.0},{0.0,0.0}},
          color={191,0,0},
          pattern=LinePattern.Dot)}));
    end LossyGear;

    model IdealPlanetary "Ideal planetary gear box"
      parameter Real ratio(start=100/50)
        "Number of ring_teeth/sun_teeth (e.g., ratio=100/50)";

      // kinematic relationship
      Interfaces.Flange_a sun "Flange of sun shaft" annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Interfaces.Flange_a carrier "Flange of carrier shaft" annotation (
          Placement(transformation(extent={{-110,30},{-90,50}})));
      Interfaces.Flange_b ring "Flange of ring shaft" annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));

    equation
      (1 + ratio)*carrier.phi = sun.phi + ratio*ring.phi;

      // torque balance (no inertias)
      ring.tau = ratio*sun.tau;
      carrier.tau = -(1 + ratio)*sun.tau;
      annotation (
        Documentation(info="<html>
<p>
The IdealPlanetary gear box is an ideal gear without inertia,
elasticity, damping or backlash consisting
of an inner <b>sun</b> wheel, an outer <b>ring</b> wheel and a
<b>planet</b> wheel located between sun and ring wheel. The bearing
of the planet wheel shaft is fixed in the planet <b>carrier</b>.
The component can be connected to other elements at the
sun, ring and/or carrier flanges. It is not possible to connect
to the planet wheel. If inertia shall not be neglected,
the sun, ring and carrier inertias can be easily added by attaching
inertias (= model Inertia) to the corresponding connectors.
The inertias of the planet wheels are always neglected.
</p>
<p>
The icon of the planetary gear signals that the sun and carrier
flanges are on the left side and the ring flange is on the right side
of the gear box. However, this component is generic and is valid
independently how the flanges are actually placed (e.g., sun wheel
may be placed on the right side instead on the left side in reality).
</p>
<p>
The ideal planetary gearbox is uniquely defined by the ratio
of the number of ring teeth zr with respect to the number of
sun teeth zs. For example, if there are 100 ring teeth and
50 sun teeth then ratio = zr/zs = 2. The number of planet teeth
zp has to fulfill the following relationship:
</p>
<pre>
   <b>zp := (zr - zs) / 2</b>
</pre>
<p>
Therefore, in the above example zp = 25 is required.
</p>
<p>
According to the overall convention, the positive direction of all
vectors, especially the absolute angular velocities and cut-torques
in the flanges, are along the axis vector displayed in the icon.
</p>

</html>"),
        Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Rectangle(lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid,
          extent={{-50.0,100.0},{50.0,105.0}}),
        Rectangle(lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid,
          extent={{-50.0,-105.0},{50.0,-100.0}}),
        Line(points={{-90.0,40.0},{-70.0,40.0}}),
        Line(points={{-80.0,50.0},{-60.0,50.0}}),
        Line(points={{-70.0,50.0},{-70.0,40.0}}),
        Line(points={{-80.0,80.0},{-59.0,80.0}}),
        Line(points={{-70.0,100.0},{-70.0,80.0}}),
        Text(lineColor={0,0,255},
          extent={{-150.0,110.0},{150.0,150.0}},
          textString="%name"),
        Text(extent={{-150.0,-150.0},{150.0,-110.0}},
          textString="ratio=%ratio"),
        Rectangle(lineColor={64,64,64},
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{10.0,-100.0},{50.0,100.0}}),
        Rectangle(lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-10.0},{-50.0,10.0}}),
        Rectangle(lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{50.0,-10.0},{100.0,10.0}}),
        Rectangle(lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-80.0,60.0},{-50.0,70.0}}),
        Rectangle(origin={-30.0,65.0},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-20.0,-19.0},{20.0,19.0}}),
        Rectangle(origin={-30.0,48.0},
          fillColor={153,153,153},
          fillPattern=FillPattern.Solid,
          extent={{-20.0,-2.0},{20.0,2.0}}),
        Rectangle(origin={-30.0,82.0},
          fillColor={204,204,204},
          fillPattern=FillPattern.Solid,
          extent={{-20.0,-2.0},{20.0,2.0}}),
        Rectangle(origin={-30.0,59.0},
          fillColor={204,204,204},
          fillPattern=FillPattern.Solid,
          extent={{-20.0,-4.0},{20.0,4.0}}),
        Rectangle(origin={-30.0,73.0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-20.0,-3.0},{20.0,3.0}}),
        Rectangle(origin={-30.0,-1.0},
          fillColor={255,255,255},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-20.0,-35.0},{20.0,35.0}}),
        Rectangle(origin={-30.0,32.0},
          fillColor={153,153,153},
          fillPattern=FillPattern.Solid,
          extent={{-20.0,-2.0},{20.0,2.0}}),
        Rectangle(origin={-30.0,23.0},
          fillColor={204,204,204},
          fillPattern=FillPattern.Solid,
          extent={{-20.0,-3.0},{20.0,3.0}}),
        Rectangle(origin={-30.0,-10.0},
          fillColor={204,204,204},
          fillPattern=FillPattern.Solid,
          extent={{-20.0,-4.0},{20.0,4.0}}),
        Rectangle(origin={-30.0,-34.0},
          fillColor={102,102,102},
          fillPattern=FillPattern.Solid,
          extent={{-20.0,-2.0},{20.0,2.0}}),
        Rectangle(origin={-30.0,-25.0},
          fillColor={153,153,153},
          fillPattern=FillPattern.Solid,
          extent={{-20.0,-3.0},{20.0,3.0}}),
        Rectangle(origin={-30.0,8.0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-20.0,-4.0},{20.0,4.0}}),
        Rectangle(origin = {-30,65},
          fillColor = {192,192,192},
          extent = {{-20,-19},{20,19}}),
        Rectangle(origin = {-30,-1},
          fillColor = {255,255,255},
          extent = {{-20,-35},{20,35}}),
        Rectangle(lineColor = {64,64,64},
          fillColor = {255,255,255},
          extent = {{10,-100},{50,100}})}),
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={
        Rectangle(lineColor = {64,64,64},
          fillColor = {192,192,192},
          fillPattern = FillPattern.HorizontalCylinder,
          extent = {{-100,-10},{-50,10}}),
      Rectangle(lineColor = {64,64,64},
          fillColor = {192,192,192},
          fillPattern = FillPattern.HorizontalCylinder,
          extent = {{50,-10},{100,10}}),
        Rectangle(lineColor = {160,160,164},
          fillColor = {160,160,164},
          fillPattern = FillPattern.Solid,
          extent = {{-50,100},{50,105}}),
        Rectangle(lineColor = {160,160,164},
          fillColor = {160,160,164},
          fillPattern = FillPattern.Solid,
          extent = {{-50,-105},{50,-100}}),
        Rectangle(lineColor = {64,64,64},
          fillColor = {192,192,192},
          fillPattern = FillPattern.HorizontalCylinder,
          extent = {{-80,60},{-50,70}}),
        Line(points = {{-90,40},{-70,40}}),
        Line(points = {{-80,50},{-60,50}}),
        Line(points = {{-70,50},{-70,40}}),
        Line(points = {{-80,80},{-59,80}}),
        Line(points = {{-70,90},{-70,80}}),
        Line(points = {{-26,-42},{-32,-2}},
          color = {0,0,255},
          pattern = LinePattern.Dot),
        Text(lineColor = {0,0,255},
          extent = {{58,-78},{98,-66}},
          textString = "ring gear"),
        Text(lineColor = {0,0,255},
          extent = {{-112,87},{-56,111}},
          textString = "planet carrier "),
        Text(lineColor = {0,0,255},
          extent = {{-47,-56},{-3,-42}},
          textString = "sun gear"),
        Polygon(lineColor = {128,128,128},
          fillColor = {128,128,128},
          fillPattern = FillPattern.Solid,
          points = {{58,130},{28,140},{28,120},{58,130}}),
        Line(points = {{-52,130},{28,130}}),
        Line(points = {{-92,93},{-70,80}},
          color = {0,0,255},
          pattern = LinePattern.Dot),
        Polygon(lineColor = {128,128,128},
          fillColor = {128,128,128},
          fillPattern = FillPattern.Solid,
          points = {{-7,-86},{-27,-81},{-27,-91},{-7,-86}}),
        Line(points = {{-97,-86},{-26,-86}},
          color = {128,128,128}),
        Text(lineColor = {128,128,128},
          extent = {{-96,-84},{-28,-71}},
          textString = "rotation axis"),
        Rectangle(origin = {-30,65},
          fillColor = {192,192,192},
          fillPattern = FillPattern.HorizontalCylinder,
          extent = {{-20,-19},{20,19}}),
        Rectangle(origin = {-30,48},
          fillColor = {153,153,153},
          fillPattern = FillPattern.Solid,
          extent = {{-20,-2},{20,2}}),
        Rectangle(origin = {-30,82},
          fillColor = {204,204,204},
          fillPattern = FillPattern.Solid,
          extent = {{-20,-2},{20,2}}),
        Rectangle(origin = {-30,59},
          fillColor = {204,204,204},
          fillPattern = FillPattern.Solid,
          extent = {{-20,-4},{20,4}}),
        Rectangle(origin = {-30,73},
          fillColor = {255,255,255},
          fillPattern = FillPattern.Solid,
          extent = {{-20,-3},{20,3}}),
        Rectangle(origin = {-30,65},
          fillColor = {192,192,192},
          extent = {{-20,-19},{20,19}}),
        Rectangle(origin = {-30,-1},
          fillColor = {255,255,255},
          fillPattern = FillPattern.HorizontalCylinder,
          extent = {{-20,-35},{20,35}}),
        Rectangle(origin = {-30,32},
          fillColor = {153,153,153},
          fillPattern = FillPattern.Solid,
          extent = {{-20,-2},{20,2}}),
        Rectangle(origin = {-30,23},
          fillColor = {204,204,204},
          fillPattern = FillPattern.Solid,
          extent = {{-20,-3},{20,3}}),
        Rectangle(origin = {-30,-10},
          fillColor = {204,204,204},
          fillPattern = FillPattern.Solid,
          extent = {{-20,-4},{20,4}}),
        Rectangle(origin = {-30,-34},
          fillColor = {102,102,102},
          fillPattern = FillPattern.Solid,
          extent = {{-20,-2},{20,2}}),
        Rectangle(origin = {-30,-25},
          fillColor = {153,153,153},
          fillPattern = FillPattern.Solid,
          extent = {{-20,-3},{20,3}}),
        Rectangle(origin = {-30,8},
          fillColor = {255,255,255},
          fillPattern = FillPattern.Solid,
          extent = {{-20,-4},{20,4}}),
        Rectangle(origin = {-30,-1},
          fillColor = {255,255,255},
          extent = {{-20,-35},{20,35}}),
        Rectangle(lineColor = {64,64,64},
          fillColor = {255,255,255},
          fillPattern = FillPattern.HorizontalCylinder,
          extent = {{10,-100},{50,100}}),
        Rectangle(lineColor = {64,64,64},
          fillColor = {255,255,255},
          extent = {{10,-100},{50,100}}),
        Line(points = {{36,-26},{64,-60}},
          color = {0,0,255},
          pattern = LinePattern.Dot)}));
    end IdealPlanetary;

    model Gearbox "Realistic model of a gearbox (based on LossyGear)"
      extends Modelica.Mechanics.Rotational.Icons.Gearbox;
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlangesAndSupport;

      parameter Real ratio(start=1)
        "Transmission ratio (flange_a.phi/flange_b.phi)";
      parameter Real lossTable[:, 5]=[0, 1, 1, 0, 0]
        "Array for mesh efficiencies and bearing friction depending on speed (see docu of LossyGear)";
      parameter SI.RotationalSpringConstant c(final min=Modelica.Constants.small,
          start=1.0e5) "Gear elasticity (spring constant)";
      parameter SI.RotationalDampingConstant d(final min=0, start=0)
        "(relative) gear damping";
      parameter SI.Angle b(final min=0) = 0 "Total backlash";
      parameter StateSelect stateSelect=StateSelect.prefer
        "Priority to use phi_rel and w_rel as states"
        annotation (HideResult=true, Dialog(tab="Advanced"));
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialConditionalHeatPort(
          final T=293.15);
      Modelica.SIunits.Angle phi_rel(
        start=0,
        stateSelect=stateSelect,
        nominal=1e-4) = flange_b.phi - lossyGear.flange_b.phi
        "Relative rotation angle over gear elasticity (= flange_b.phi - lossyGear.flange_b.phi)";
      Modelica.SIunits.AngularVelocity w_rel(
        start=0,
        stateSelect=stateSelect) = der(phi_rel)
        "Relative angular velocity over gear elasticity (= der(phi_rel))";
      Modelica.SIunits.AngularAcceleration a_rel(start=0) = der(w_rel)
        "Relative angular acceleration over gear elasticity (= der(w_rel))";

      Rotational.Components.LossyGear lossyGear(
        final ratio=ratio,
        final lossTable=lossTable,
        final useSupport=true,
        final useHeatPort=true) annotation (Placement(transformation(extent={{-60,
                -20},{-20,20}})));
      Rotational.Components.ElastoBacklash elastoBacklash(
        final b=b,
        final c=c,
        final phi_rel0=0,
        final d=d,
        final useHeatPort=true) annotation (Placement(transformation(extent={{
                20,-20},{60,20}})));
    equation
      connect(flange_a, lossyGear.flange_a) annotation (Line(points={{-100,0},{
              -90,0},{-90,0},{-80,0},{-80,0},{-60,0}}));
      connect(lossyGear.flange_b, elastoBacklash.flange_a) annotation (Line(
            points={{-20,0},{-10,0},{0,0},{20,0}}));
      connect(elastoBacklash.flange_b, flange_b) annotation (Line(points={{60,0},
              {70,0},{70,0},{80,0},{80,0},{100,0}}));
      connect(elastoBacklash.heatPort, internalHeatPort) annotation (Line(
          points={{20,-20},{20,-60},{-100,-60},{-100,-80}},
          color={191,0,0}));
      connect(lossyGear.heatPort, internalHeatPort) annotation (Line(
          points={{-60,-20},{-60,-60},{-100,-60},{-100,-80}},
          color={191,0,0}));
      connect(lossyGear.support, internalSupport) annotation (Line(
          points={{-40,-20},{-40,-40},{0,-40},{0,-80}}));
      annotation (Documentation(info="<html>
<p>This component models the essential effects of a gearbox, in
particular</p>
<ul>
  <li>in component <b>lossyGear</b>
    <ul>
      <li>gear <b>efficiency</b> due to friction between the teeth</li>
      <li><b>bearing friction</b></li>
    </ul></li>
  <li>in component <b>elastoBacklash</b>
    <ul>
      <li>gear <b>elasticity</b></li>
      <li><b>damping</b></li>
      <li><b>backlash</b></li>
    </ul></li>
</ul>
<p>The inertia of the gear wheels is not modeled. If necessary,
inertia has to be taken into account by connecting components of
model Inertia to the left and/or the right flange of component
Gearbox.
</p>

</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),graphics={Text(
                  extent={{-150,150},{150,110}},
                  lineColor={0,0,255},
                  textString="%name"),Text(
                  extent={{-150,70},{150,100}},
                  lineColor={0,0,0},
                  textString="ratio=%ratio, c=%c"),Line(
                  visible=useHeatPort,
                  points={{-100,-100},{-100,-30},{0,-30}},
                  color={191,0,0},
                  pattern=LinePattern.Dot)}));
    end Gearbox;

    model IdealGearR2T
      "Gearbox transforming rotational into translational motion"
      extends Rotational.Interfaces.PartialElementaryRotationalToTranslational;
      parameter Real ratio(final unit="rad/m", start=1)
        "Transmission ratio (flange_a.phi/flange_b.s)";

    equation
      (flangeR.phi - internalSupportR.phi) = ratio*(flangeT.s -
        internalSupportT.s);
      0 = ratio*flangeR.tau + flangeT.f;
      annotation (Documentation(info="<html>
<p>
This is an ideal mass- and inertialess gearbox which transforms a
1D-rotational into a 1D-translational motion. If elasticity, damping
or backlash has to be considered, this ideal gearbox has to be
connected with corresponding elements.
This component defines the kinematic constraint:
</p>

<pre>
  (flangeR.phi - internalSupportR.phi) = ratio*(flangeT.s - internalSupportT.s);
</pre>
</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Rectangle(origin={133.3333,0.0},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-233.3333,-10.0},{-163.3333,10.0}}),
        Text(lineColor={0,0,255},
          extent={{-150.0,85.0},{150.0,125.0}},
          textString="%name"),
        Rectangle(fillColor={160,160,164},
          fillPattern=FillPattern.Solid,
          extent={{95.0,-60.0},{106.0,-10.0}}),
        Rectangle(origin={-0.5889,0.0},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid,
          extent={{-74.4111,-80.0},{106.5889,-60.0}}),
        Text(extent={{-150.0,50.0},{150.0,80.0}},
          textString="ratio=%ratio"),
        Line(points={{-100.0,15.0},{-80.0,15.0}}),
        Line(points={{-100.0,-16.0},{-80.0,-16.0}}),
        Line(points={{-100.0,-16.0},{-100.0,-100.0}}),
        Line(points={{100.0,-80.0},{100.0,-100.0}}),
        Polygon(origin={16.875,-50.0},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid,
          points={{-84.375,-10.0},{-79.375,10.0},{-69.375,10.0},{-64.375,-10.0},{-54.375,-10.0},{-49.375,10.0},{-39.375,10.0},{-34.375,-10.0},{-24.375,-10.0},{-19.375,10.0},{-9.375,10.0},{-4.375,-10.0},{5.625,-10.0},{10.625,10.0},{20.625,10.0},{25.625,-10.0},{35.625,-10.0},{40.625,10.0},{50.625,10.0},{55.625,-10.0},{65.625,-10.0},{70.625,10.0},{78.125,10.0},{78.125,-10.0}}),
        Polygon(origin={-20.0,-0.0},
          rotation=10.0,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          points={{-5.0,45.0},{-10.0,10.0},{-45.0,5.0},{-45.0,-5.0},{-10.0,-10.0},{-5.0,-45.0},{5.0,-45.0},{10.0,-10.0},{45.0,-5.0},{45.0,5.0},{10.0,10.0},{5.0,45.0}}),
        Polygon(origin={-20.0,-0.0},
          rotation=55.0,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          points={{-5.0,45.0},{-10.0,10.0},{-45.0,5.0},{-45.0,-5.0},{-10.0,-10.0},{-5.0,-45.0},{5.0,-45.0},{10.0,-10.0},{45.0,-5.0},{45.0,5.0},{10.0,10.0},{5.0,45.0}}),
        Ellipse(origin={-20.0,-0.0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-30.0,-30.0},{30.0,30.0}}),
        Ellipse(origin={-20.0,-0.0},
          fillColor={128,128,128},
          fillPattern=FillPattern.Solid,
          extent={{-10.0,-10.0},{10.0,10.0}})}));
    end IdealGearR2T;

    model IdealRollingWheel
      "Simple 1-dim. model of an ideal rolling wheel without inertia"

      extends Rotational.Interfaces.PartialElementaryRotationalToTranslational;
      parameter Modelica.SIunits.Distance radius(start=0.3) "Wheel radius";

    equation
      (flangeR.phi - internalSupportR.phi)*radius = (flangeT.s -
        internalSupportT.s);
      0 = radius*flangeT.f + flangeR.tau;
      annotation (Icon(
          coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}}),
            graphics={
          Rectangle(  lineColor={64,64,64},
            fillColor={192,192,192},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100.0,-10.0},{-46.0,10.0}}),
          Ellipse(  lineColor={64,64,64},
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-50.0,-80.0},{10.0,80.0}}),
          Rectangle(  lineColor={64,64,64},
            fillColor={255,255,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-20.0,-80.0},{12.0,80.0}}),
          Ellipse(  lineColor={64,64,64},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid,
            extent={{-16.0,-80.0},{44.0,80.0}}),
          Ellipse(  lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            extent={{-2.0,-52.0},{34.0,52.0}}),
          Ellipse(  lineColor={64,64,64},
            fillColor={192,192,192},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{12.0,-10.0},{20.0,10.0}}),
          Rectangle(  lineColor={64,64,64},
            fillColor={192,192,192},
            pattern=LinePattern.None,
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{16.0,-10.0},{60.0,10.0}}),
          Ellipse(  fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            extent={{56.0,-10.0},{64.0,10.0}}),
          Text(  lineColor={0,0,255},
            extent={{-150.0,90.0},{150.0,130.0}},
            textString="%name"),
          Polygon(  lineColor={0,127,0},
            fillColor={0,127,0},
            fillPattern=FillPattern.Solid,
            points={{80.0,10.0},{80.0,26.0},{60.0,26.0},{60.0,20.0},{70.0,20.0},{70.0,-20.0},{60.0,-20.0},{60.0,-26.0},{80.0,-26.0},{80.0,-10.0},{90.0,-10.0},{90.0,10.0},{80.0,10.0}}),
          Line(  points={{-100.0,-20.0},{-60.0,-20.0}}),
          Line(  points={{-100.0,-20.0},{-100.0,-100.0}}),
          Line(  points={{-100.0,20.0},{-60.0,20.0}}),
          Line(  points={{100.0,-90.0},{-40.0,-90.0}},
            color={0,127,0}),
          Line(  points={{70.0,-26.0},{70.0,-50.0},{100.0,-50.0},{100.0,-100.0}},
            color={0,127,0}),
          Line(  origin={-2.5,80.0},
            points={{-17.5,0.0},{17.5,0.0}},
            color={64,64,64}),
          Line(  origin={-2.5,-80.0},
            points={{-17.5,0.0},{17.5,0.0}},
            color={64,64,64}),
          Line(  origin={38.0,10.0},
            points={{-22.0,0.0},{22.0,0.0}},
            color={64,64,64}),
          Line(  origin={38.0,-10.0},
            points={{-22.0,0.0},{22.0,0.0}},
            color={64,64,64})}), Documentation(info="<html>
<p>
A simple kinematic model of a rolling wheel which has no inertia and
no rolling resistance. This component defines the kinematic constraint:
</p>

<pre>
   (flangeR.phi - internalSupportR.phi)*wheelRadius = (flangeT.s - internalSupportT.s);
</pre>
</html>"));
    end IdealRollingWheel;

    model InitializeFlange
      "Initializes a flange with pre-defined angle, speed and angular acceleration (usually, this is reference data from a control bus)"
      extends Modelica.Blocks.Icons.Block;
      parameter Boolean use_phi_start=true
        "= true, if initial angle is defined by input phi_start, otherwise not initialized";
      parameter Boolean use_w_start=true
        "= true, if initial speed is defined by input w_start, otherwise not initialized";
      parameter Boolean use_a_start=true
        "= true, if initial angular acceleration is defined by input a_start, otherwise not initialized";

      parameter StateSelect stateSelect=StateSelect.default
        "Priority to use flange angle and speed as states";

      Modelica.Blocks.Interfaces.RealInput phi_start(unit="rad") if use_phi_start
        "Initial angle of flange" annotation (Placement(transformation(extent={
                {-140,60},{-100,100}}), iconTransformation(extent={
                {-140,60},{-100,100}})));
      Modelica.Blocks.Interfaces.RealInput w_start(unit="rad/s") if use_w_start
        "Initial speed of flange" annotation (Placement(transformation(extent={
                {-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealInput a_start(unit="rad/s2") if use_a_start
        "Initial angular acceleration of flange" annotation (Placement(
            transformation(extent={{-140,-100},{-100,-60}}),
            iconTransformation(extent={{-140,-100},{-100,-60}})));
      Interfaces.Flange_b flange "Flange that is initialized" annotation (
          Placement(transformation(extent={{90,-10},{110,10}})));

      Modelica.SIunits.Angle phi_flange(stateSelect=stateSelect) = flange.phi
        "Flange angle";
      Modelica.SIunits.AngularVelocity w_flange(stateSelect=stateSelect) = der(
        phi_flange) "= der(phi_flange)";

    protected
      encapsulated model Set_phi_start "Set phi_start"
        import Modelica;
        extends Modelica.Blocks.Icons.Block;
        Modelica.Blocks.Interfaces.RealInput phi_start(unit="rad")
          "Start angle"
          annotation (HideResult=true, Placement(transformation(extent={{-140,-20},
                  {-100,20}})));

        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
            Placement(transformation(extent={{90,-10},{110,10}})));
      initial equation
        flange.phi = phi_start;
      equation
        flange.tau = 0;

      end Set_phi_start;

      encapsulated model Set_w_start "Set w_start"
        import Modelica;
        extends Modelica.Blocks.Icons.Block;
        Modelica.Blocks.Interfaces.RealInput w_start(unit="rad/s")
          "Start angular velocity"
          annotation (HideResult=true, Placement(transformation(extent={{-140,-20},
                  {-100,20}})));

        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
            Placement(transformation(extent={{90,-10},{110,10}})));
      initial equation
        der(flange.phi) = w_start;
      equation
        flange.tau = 0;

      end Set_w_start;

      encapsulated model Set_a_start "Set a_start"
        import Modelica;
        extends Modelica.Blocks.Icons.Block;
        Modelica.Blocks.Interfaces.RealInput a_start(unit="rad/s2")
          "Start angular acceleration" annotation (HideResult=true, Placement(
              transformation(extent={{-140,-20},{-100,20}})));

        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange(phi(
              stateSelect=StateSelect.avoid)) annotation (Placement(
              transformation(extent={{90,-10},{110,10}})));

        Modelica.SIunits.AngularVelocity w=der(flange.phi)
          annotation (HideResult=true);
      initial equation
        der(w) = a_start;
      equation
        flange.tau = 0;
      end Set_a_start;

      encapsulated model Set_flange_tau "Set flange.tau to zero"
        import Modelica;
        extends Modelica.Blocks.Icons.Block;
        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
            Placement(transformation(extent={{90,-10},{110,10}})));
      equation
        flange.tau = 0;
      end Set_flange_tau;
    protected
      Set_phi_start set_phi_start if use_phi_start annotation (Placement(
            transformation(extent={{-20,70},{0,90}})));
      Set_w_start set_w_start if use_w_start annotation (Placement(
            transformation(extent={{-20,-10},{0,10}})));
      Set_a_start set_a_start if use_a_start annotation (Placement(
            transformation(extent={{-20,-90},{0,-70}})));
      Set_flange_tau set_flange_tau annotation (Placement(transformation(extent=
               {{96,-90},{76,-70}})));
    equation
      connect(set_phi_start.phi_start, phi_start) annotation (Line(
          points={{-22,80},{-120,80}},
          color={0,0,127}));
      connect(set_phi_start.flange, flange) annotation (Line(
          points={{0,80},{60,80},{60,0},{100,0}}));
      connect(set_w_start.flange, flange) annotation (Line(
          points={{0,0},{100,0}}));
      connect(set_w_start.w_start, w_start) annotation (Line(
          points={{-22,0},{-120,0}},
          color={0,0,127}));
      connect(set_a_start.a_start, a_start) annotation (Line(
          points={{-22,-80},{-120,-80}},
          color={0,0,127}));
      connect(set_a_start.flange, flange) annotation (Line(
          points={{0,-80},{60,-80},{60,0},{100,0}}));
      connect(set_flange_tau.flange, flange) annotation (Line(
          points={{76,-80},{60,-80},{60,0},{100,0}}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-94,94},{68,66}},
              lineColor={0,0,0},
              textString="phi_start"),
            Text(
              extent={{-94,16},{70,-14}},
              lineColor={0,0,0},
              textString="w_start"),
            Text(
              extent={{-92,-66},{68,-94}},
              lineColor={0,0,0},
              textString="a_start")}), Documentation(info="<html>
<p>
This component is used to optionally initialize the angle, speed,
and/or angular acceleration of the flange to which this component
is connected. Via parameters use_phi_start, use_w_start, use_a_start
the corresponding input signals phi_start, w_start, a_start are conditionally
activated. If an input is activated, the corresponding flange property
is initialized with the input value at start time.
</p>

<p>
For example, if \"use_phi_start = true\", then flange.phi is initialized
with the value of the input signal \"phi_start\" at the start time.
</p>

<p>
Additionally, it is optionally possible to define the \"StateSelect\"
attribute of the flange angle and the flange speed via parameter
\"stateSelection\".
</p>

<p>
This component is especially useful when the initial values of a flange
shall be set according to reference signals of a controller that are
provided via a signal bus.
</p>
</html>"));
    end InitializeFlange;

    model RelativeStates "Definition of relative state variables"
      extends Rotational.Interfaces.PartialTwoFlanges;
      parameter StateSelect stateSelect=StateSelect.prefer
        "Priority to use the relative angle and relative speed as states";
      parameter SI.Angle phi_nominal(
        displayUnit="rad",
        min=0.0) = 1.0 "Nominal value of the relative angle (used for scaling)";

      SI.Angle phi_rel(
        start=0,
        stateSelect=stateSelect,
        nominal=if phi_nominal >= Modelica.Constants.eps then phi_nominal else
            1) "Relative rotation angle used as state variable";
      SI.AngularVelocity w_rel(start=0, stateSelect=stateSelect)
        "Relative angular velocity used as state variable";
      SI.AngularAcceleration a_rel(start=0) "Relative angular acceleration";

    equation
      phi_rel = flange_b.phi - flange_a.phi;
      w_rel = der(phi_rel);
      a_rel = der(w_rel);
      flange_a.tau = 0;
      flange_b.tau = 0;
      annotation (
        Documentation(info="<html>
<p>
Usually, the absolute angle and the absolute angular velocity of
Modelica.Mechanics.Rotational.Components.Inertia models are used as state variables.
In some circumstances, relative quantities are better suited, e.g.,
because it may be easier to supply initial values.
In such cases, model <b>RelativeStates</b> allows the definition of state variables
in the following way:
</p>
<ul>
<li> Connect an instance of this model between two flange connectors.</li>
<li> The <b>relative rotation angle</b> and the <b>relative angular velocity</b>
     between the two connectors are used as <b>state variables</b>.</li>
</ul>
<p>
An example is given in the next figure
</p>

<p>
<IMG src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/relativeStates.png\" ALT=\"relativeStates\">
</p>

<p>
Here, the relative angle and the relative angular velocity between
the two inertias are used as state variables. Additionally, the
simulator selects either the absolute angle and absolute angular
velocity of model inertia1 or of model inertia2 as state variables.
</p>

<p>
See also the discussion
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
in the User's Guide of the Rotational library.
</p>
</html>"),
        Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Ellipse(lineColor={87,195,193},
          fillColor={87,195,193},
          fillPattern=FillPattern.Solid,
          extent={{-40.0,-40.0},{40.0,40.0}}),
        Text(lineColor={0,0,255},
          extent={{-40.0,-40.0},{40.0,40.0}},
          textString="S"),
        Line(points={{-92.0,0.0},{-42.0,0.0}},
          pattern=LinePattern.Dot),
        Line(points={{40.0,0.0},{90.0,0.0}},
          pattern=LinePattern.Dot),
        Text(lineColor={0,0,255},
          extent={{-150.0,-80.0},{150.0,-40.0}},
          textString="%name")}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Ellipse(
                  extent={{-40,40},{40,-40}},
                  lineColor={0,255,255},
                  fillColor={0,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-40,40},{40,-40}},
                  textString="S",
                  lineColor={0,0,255}),Line(
                  points={{40,0},{96,0}},
                  pattern=LinePattern.Dash),Line(points={{-100,-10},{-100,-80}},
              color={160,160,164}),Line(points={{100,-10},{100,-80}}, color={
              160,160,164}),Polygon(
                  points={{80,-65},{80,-55},{100,-60},{80,-65}},
                  lineColor={160,160,164},
                  fillColor={160,160,164},
                  fillPattern=FillPattern.Solid),Line(points={{-100,-60},{80,-60}},
              color={160,160,164}),Text(
                  extent={{-30,-70},{30,-90}},
                  textString="w_rel",
                  lineColor={0,0,255}),Line(points={{-76,80},{-5,80}}, color={
              128,128,128}),Polygon(
                  points={{14,80},{-6,85},{-6,75},{14,80}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{18,87},{86,74}},
                  lineColor={128,128,128},
                  textString="rotation axis"),Line(
                  points={{-96,0},{-40,0}},
                  pattern=LinePattern.Dash)}));
    end RelativeStates;

    model TorqueToAngleAdaptor
      "Signal adaptor for a Rotational flange with angle, speed, and acceleration as outputs and torque as input (especially useful for FMUs)"
      parameter Boolean use_w=true
        "= true, enable the output connector w (angular velocity)" annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      parameter Boolean use_a=true
        "= true, enable the output connector a (angular acceleration)"
        annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));

      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
      Modelica.Blocks.Interfaces.RealOutput phi(unit="rad")
        "Flange moves with angle phi due to torque tau"
        annotation (Placement(transformation(extent={{20,70},{40,90}})));
      Modelica.Blocks.Interfaces.RealOutput w(unit="rad/s") if use_w
        "Flange moves with speed w due to torque tau"
        annotation (Placement(transformation(extent={{20,20},{40,40}})));
      Modelica.Blocks.Interfaces.RealOutput a(unit="rad/s2") if use_a
        "Flange moves with angular acceleration a due to torque tau"
        annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
      Modelica.Blocks.Interfaces.RealInput tau(unit="N.m")
        "Torque to drive the flange"
        annotation (Placement(transformation(extent={{60,-100},{20,-60}})));
    protected
      Modelica.Blocks.Interfaces.RealInput w_internal
        "Needed to connect to conditional connector w";
      Modelica.Blocks.Interfaces.RealInput a_internal
        "Needed to connect to conditional connector a";
    equation
      connect(w, w_internal);
      connect(a, a_internal);
      phi = flange.phi;
      if use_w then
        w_internal = der(phi);
      else
        w_internal = 0.0;
      end if;
      if use_a then
        a_internal = der(w_internal);
      else
        a_internal = 0.0;
      end if;
      flange.tau = tau;

      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                Rectangle(
                  extent={{-20,100},{20,-100}},
                  lineColor={64,64,64},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.HorizontalCylinder,
                  radius=10),
                Rectangle(
                  extent={{-20,100},{20,-100}},
                  lineColor={64,64,64},
                  radius=10),
                Text(
                  extent={{-20,92},{20,70}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="phi"),Text(
                  visible=use_w,
                  extent={{-20,42},{20,20}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="w"),Text(
                  visible=use_a,
                  extent={{-20,-18},{20,-40}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="a"),Text(
                  extent={{-20,-68},{20,-90}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="tau"),Text(
                  extent={{-150,150},{150,110}},
                  textString="%name",
                  lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
Adaptor between a flange connector and a signal representation of the flange.
This component is used to provide a pure signal interface around a Rotational model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>).
Examples of the usage of this adaptor are provided in
<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.GenerationOfFMUs\">Rotational.Examples.GenerationOfFMUs</a>.
This adaptor has torque as input and angle, angular velocity and angular acceleration as output signals.
</p>
</html>"));
    end TorqueToAngleAdaptor;

    model AngleToTorqueAdaptor
      "Signal adaptor for a Rotational flange with torque as output and angle, speed, and optionally acceleration as inputs (especially useful for FMUs)"
      parameter Boolean use_w=true
        "= true, enable the input connector w (angular velocity)" annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      parameter Boolean use_a=true
        "= true, enable the input connector a (angular acceleration)"
        annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange annotation (
          Placement(transformation(extent={{56,-10},{76,10}}),
            iconTransformation(extent={{10,-10},{30,10}})));
      Modelica.Blocks.Interfaces.RealInput phi(unit="rad")
        "Angle to drive the flange" annotation (Placement(transformation(extent=
               {{-80,60},{-40,100}}), iconTransformation(extent={{-60,60},{-20,
                100}})));
      Modelica.Blocks.Interfaces.RealInput w(unit="rad/s") if use_w or use_a
        "Speed to drive the flange (w=der(phi) required)" annotation (
          Placement(transformation(extent={{-80,10},{-40,50}}),
            iconTransformation(extent={{-60,8},{-20,48}})));
      Modelica.Blocks.Interfaces.RealInput a(unit="rad/s2") if use_a
        "Angular acceleration to drive the flange (a = der(w) required)"
        annotation (Placement(transformation(extent={{-80,-50},{-40,-10}}),
            iconTransformation(extent={{-60,-52},{-20,-12}})));
      Modelica.Blocks.Interfaces.RealOutput tau(unit="N.m")
        "Torque needed to drive the flange according to phi, w, a" annotation (
          Placement(transformation(extent={{-40,-90},{-60,-70}}),
            iconTransformation(extent={{-20,-90},{-40,-70}})));

    protected
      Modelica.Mechanics.Rotational.Sources.Move move if use_a
        annotation (Placement(transformation(extent={{10,-10},{30,10}})));
      Modelica.Blocks.Routing.Multiplex3 multiplex3 if use_a
        annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
      Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor
        annotation (Placement(transformation(extent={{36,-10},{56,10}})));

      Modelica.Blocks.Routing.Multiplex2 multiplex2 if use_w and not use_a
        annotation (Placement(transformation(extent={{-20,40},{0,60}})));
      Move_phi move_phi if not use_w and not use_a
        annotation (Placement(transformation(extent={{10,70},{30,90}})));
      Move_w move_w if use_w and not use_a
        annotation (Placement(transformation(extent={{10,40},{30,60}})));

      model Move_phi "Forced movement of a flange according to an angle signal"
        extends
          Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;

        Modelica.Blocks.Interfaces.RealInput phi(
          final quantity="Angle",
          final unit="rad",
          displayUnit="deg") "Rotation angle of flange with respect to support"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      equation
        phi = flange.phi - phi_support;
        annotation (Documentation(info="<html>
<p>
Flange <b>flange</b> is <b>forced</b> to move relative to flange support with a predefined motion
according to the input signal u
</p>
<pre>
    u[1]: angle of flange
    u[2]: angular velocity of flange
</pre>
<p>
The user has to guarantee that the input signals are consistent to each other,
i.e., that u[2] is the derivative of u[1].
</p>
<p>
The input signals can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>
</html>"), Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={Text(
                      extent={{-80,-60},{-80,-100}},
                      lineColor={0,0,0},
                      textString="phi"),Rectangle(
                      extent={{-100,20},{100,-20}},
                      lineColor={64,64,64},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={192,192,192}),Line(points={{-30,-32},{30,-32}}),Line(points={{0,52},{0,32}}),Line(
                points={{-29,32},{30,32}}),Line(points={{0,-32},
                {0,-100}}),Line(points={{30,-42},{20,-52}}),Line(points={{30,-32},{10,-52}}),
                Line(points={{20,-32},{0,-52}}),Line(points={{10,
                -32},{-10,-52}}),Line(points={{0,-32},{-20,-52}}),Line(points={{-10,-32},{-30,-52}}),
                Line(points={{-20,-32},{-30,-42}}),Text(
                      extent={{-150,100},{150,60}},
                      textString="%name",
                      lineColor={0,0,255})}));
      end Move_phi;

      model Move_w
        "Forced movement of a flange according to an angle and speed signal"
        extends
          Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;

        Modelica.SIunits.Angle phi
          "Rotation angle of flange with respect to support";
        Modelica.Blocks.Interfaces.RealInput u[2]
          "Angle and angular velocity of flange with respect to support as input signals"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      protected
        function position
          extends Modelica.Icons.Function;
          input Real q_qd[2] "Required values for position and speed";
          input Real dummy
            "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
          output Real q;
        algorithm
          q := q_qd[1];
          annotation (derivative(noDerivative=q_qd) = position_der,
              InlineAfterIndexReduction=true);
        end position;

        function position_der
          extends Modelica.Icons.Function;
          input Real q_qd[2] "Required values for position and speed";
          input Real dummy
            "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
          input Real dummy_der;
          output Real qd;
        algorithm
          qd := q_qd[2];
        end position_der;
      equation
        phi = flange.phi - phi_support;
        phi = position(u, time);
        annotation (Documentation(info="<html>
<p>
Flange <b>flange</b> is <b>forced</b> to move relative to flange support with a predefined motion
according to the input signals:
</p>
<pre>
    u[1]: angle of flange
    u[2]: angular velocity of flange
</pre>
<p>
The user has to guarantee that the input signals are consistent to each other,
i.e., that u[2] is the derivative of u[1].
</p>
<p>
The input signals can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>
</html>"), Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={Text(
                      extent={{-80,-60},{-80,-100}},
                      lineColor={0,0,0},
                      textString="phi,w"),Rectangle(
                      extent={{-100,20},{100,-20}},
                      lineColor={64,64,64},
                      fillPattern=FillPattern.HorizontalCylinder,
                      fillColor={192,192,192}),Line(points={{-30,-32},{30,-32}}),Line(points={{0,52},{0,32}}),Line(
                points={{-29,32},{30,32}}),Line(points={{0,-32},
                {0,-100}}),Line(points={{30,-42},{20,-52}}),Line(points={{30,-32},{10,-52}}),
                Line(points={{20,-32},{0,-52}}),Line(points={{10,
                -32},{-10,-52}}),Line(points={{0,-32},{-20,-52}}),Line(points={{-10,-32},{-30,-52}}),
                Line(points={{-20,-32},{-30,-42}}),Text(
                      extent={{-150,100},{150,60}},
                      textString="%name",
                      lineColor={0,0,255})}));
      end Move_w;
    equation
      connect(multiplex3.y, move.u) annotation (Line(
          points={{1,0},{8,0}},
          color={0,0,127}));
      connect(phi, multiplex3.u1[1]) annotation (Line(
          points={{-60,80},{-32,80},{-32,7},{-22,7}},
          color={0,0,127}));
      connect(w, multiplex3.u2[1]) annotation (Line(
          points={{-60,30},{-36,30},{-36,0},{-22,0}},
          color={0,0,127}));
      connect(a, multiplex3.u3[1]) annotation (Line(
          points={{-60,-30},{-32,-30},{-32,-7},{-22,-7}},
          color={0,0,127}));
      connect(flange, torqueSensor.flange_b) annotation (Line(
          points={{66,0},{56,0}}));
      connect(move.flange, torqueSensor.flange_a) annotation (Line(
          points={{30,0},{36,0}}));
      connect(torqueSensor.tau, tau) annotation (Line(
          points={{38,-11},{38,-80},{-50,-80}},
          color={0,0,127}));
      connect(multiplex2.y, move_w.u) annotation (Line(
          points={{1,50},{8,50}},
          color={0,0,127}));
      connect(phi, multiplex2.u1[1]) annotation (Line(
          points={{-60,80},{-46,80},{-46,80},{-32,80},{-32,56},{-22,56}},
          color={0,0,127}));
      connect(w, multiplex2.u2[1]) annotation (Line(
          points={{-60,30},{-28,30},{-28,44},{-22,44}},
          color={0,0,127}));
      connect(move_w.flange, torqueSensor.flange_a) annotation (Line(
          points={{30,50},{36,50},{36,0}}));
      connect(phi, move_phi.phi) annotation (Line(
          points={{-60,80},{8,80}},
          color={0,0,127}));
      connect(move_phi.flange, torqueSensor.flange_a) annotation (Line(
          points={{30,80},{36,80},{36,0}}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                Rectangle(
                  extent={{-20,100},{20,-100}},
                  lineColor={64,64,64},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.HorizontalCylinder,
                  radius=10),
                Rectangle(
                  extent={{-20,100},{20,-100}},
                  lineColor={64,64,64},
                  radius=10),
                Text(
                  extent={{-20,90},{20,68}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="phi"),Text(
                  visible=use_w or use_a,
                  extent={{-20,40},{20,18}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="w"),Text(
                  visible=use_a,
                  extent={{-20,-20},{20,-42}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="a"),Text(
                  extent={{-20,-70},{20,-92}},
                  lineColor={0,0,0},
                  fillPattern=FillPattern.Solid,
                  textString="tau"),Text(
                  extent={{-150,150},{150,110}},
                  textString="%name",
                  lineColor={0,0,255})}),
        Documentation(info="<html>
<p>
Adaptor between a flange connector and a signal representation of the flange.
This component is used to provide a pure signal interface around a Rotational model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>).
Examples of the usage of this adaptor are provided in
<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.GenerationOfFMUs\">Rotational.Examples.GenerationOfFMUs</a>.
This adaptor has angle, angular velocity and angular acceleration as input signals and
torque as output signal. Note, the input signals must be consistent to each other
(w=der(phi), a=der(w)).
</p>
</html>"));
    end AngleToTorqueAdaptor;

    annotation (Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
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
          extent={{27.6923,-80.0},{67.6923,-60.0}})}), Documentation(info="<html>
<p>
This package contains basic components 1D mechanical rotational drive trains.
</p>
</html>"));
  end Components;

  package Sensors
    "Sensors to measure variables in 1D rotational mechanical components"
    extends Modelica.Icons.SensorsPackage;

    model AngleSensor "Ideal sensor to measure the absolute flange angle"

      extends Rotational.Interfaces.PartialAbsoluteSensor;
      Modelica.Blocks.Interfaces.RealOutput phi(unit="rad", displayUnit="deg")
        "Absolute angle of flange as output signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      phi = flange.phi;
      annotation (Documentation(info="<html>
<p>
Measures the <b>absolute angle phi</b> of a flange in an ideal
way and provides the result as output signal <b>phi</b>
(to be further processed with blocks of the Modelica.Blocks library).
</p>
</html>"), Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Text(
                  extent={{70,-30},{120,-70}},
                  lineColor={0,0,0},
                  textString="phi")}));
    end AngleSensor;

    model SpeedSensor
      "Ideal sensor to measure the absolute flange angular velocity"

      extends Rotational.Interfaces.PartialAbsoluteSensor;
      Modelica.Blocks.Interfaces.RealOutput w(unit="rad/s")
        "Absolute angular velocity of flange as output signal" annotation (
          Placement(transformation(extent={{100,-10},{120,10}})));

    equation
      w = der(flange.phi);
      annotation (Documentation(info="<html>
<p>
Measures the <b>absolute angular velocity w</b> of a flange in an ideal
way and provides the result as output signal <b>w</b>
(to be further processed with blocks of the Modelica.Blocks library).
</p>
</html>"), Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Text(
                  extent={{70,-30},{120,-70}},
                  lineColor={0,0,0},
                  textString="w")}));
    end SpeedSensor;

    model AccSensor
      "Ideal sensor to measure the absolute flange angular acceleration"

      extends Rotational.Interfaces.PartialAbsoluteSensor;
      SI.AngularVelocity w "Absolute angular velocity of flange";
      Modelica.Blocks.Interfaces.RealOutput a(unit="rad/s2")
        "Absolute angular acceleration of flange as output signal" annotation (
          Placement(transformation(extent={{100,-10},{120,10}})));

    equation
      w = der(flange.phi);
      a = der(w);
      annotation (Documentation(info="<html>
<p>
Measures the <b>absolute angular acceleration a</b> of a flange in an ideal
way and provides the result as output signal <b>a</b> (to be further processed with
blocks of the Modelica.Blocks library).
</p>
</html>"), Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Text(
                  extent={{70,-30},{120,-70}},
                  lineColor={0,0,0},
                  textString="a")}));
    end AccSensor;

    model RelAngleSensor
      "Ideal sensor to measure the relative angle between two flanges"

      extends Rotational.Interfaces.PartialRelativeSensor;
      Modelica.Blocks.Interfaces.RealOutput phi_rel(unit="rad", displayUnit="deg")
        "Relative angle between two flanges (= flange_b.phi - flange_a.phi) as output signal"
        annotation (Placement(transformation(
            origin={0,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));

    equation
      phi_rel = flange_b.phi - flange_a.phi;
      0 = flange_a.tau;
      annotation (Documentation(info="<html>
<p>
Measures the <b>relative angle phi_rel</b> between two flanges
in an ideal way and provides the result as output signal <b>phi_rel</b>
(to be further processed with blocks of the Modelica.Blocks library).
</p>
</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Text(extent={{20.0,-114.0},{160.0,-84.0}},
          textString="phi_rel"),
       Line(points={{0.0,-100.0},{0.0,-70.0}},
        color={0,0,127})}));
    end RelAngleSensor;

    model RelSpeedSensor
      "Ideal sensor to measure the relative angular velocity between two flanges"

      extends Rotational.Interfaces.PartialRelativeSensor;

      SI.Angle phi_rel
        "Relative angle between two flanges (flange_b.phi - flange_a.phi)";
      Modelica.Blocks.Interfaces.RealOutput w_rel(unit="rad/s")
        "Relative angular velocity between two flanges (= der(flange_b.phi) - der(flange_a.phi)) as output signal"
        annotation (Placement(transformation(
            origin={0,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));

    equation
      phi_rel = flange_b.phi - flange_a.phi;
      w_rel = der(phi_rel);
      0 = flange_a.tau;
      annotation (Documentation(info="<html>
<p>
Measures the <b>relative angular velocity w_rel</b> between two flanges
in an ideal way and provides the result as output signal <b>w_rel</b>
(to be further processed with blocks of the Modelica.Blocks library).
</p>
</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Text(extent={{20.0,-118.0},{160.0,-88.0}},
          textString="w_rel"),
        Line(points={{0.0,-100.0},{0.0,-70.0}},
          color={0,0,127})}));
    end RelSpeedSensor;

    model RelAccSensor
      "Ideal sensor to measure the relative angular acceleration between two flanges"

      extends Rotational.Interfaces.PartialRelativeSensor;

      SI.Angle phi_rel
        "Relative angle between two flanges (flange_b.phi - flange_a.phi)";
      SI.AngularVelocity w_rel "Relative angular velocity between two flanges";
      Modelica.Blocks.Interfaces.RealOutput a_rel(unit="rad/s2")
        "Relative angular acceleration between two flanges as output signal"
        annotation (Placement(transformation(
            origin={0,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));

    equation
      phi_rel = flange_b.phi - flange_a.phi;
      w_rel = der(phi_rel);
      a_rel = der(w_rel);
      0 = flange_a.tau;
      annotation (Documentation(info="<html>
<p>
Measures the <b>relative angular acceleration a_rel</b> between two flanges
in an ideal way and provides the result as output signal <b>a_rel</b>
(to be further processed with blocks of the Modelica.Blocks library).
</p>
</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Text(extent={{20.0,-116.0},{160.0,-86.0}},
          textString="a_rel"),
        Line(points={{0.0,-100.0},{0.0,-70.0}},
          color={0,0,127})}));
    end RelAccSensor;

    model TorqueSensor
      "Ideal sensor to measure the torque between two flanges (= flange_a.tau)"

      extends Rotational.Interfaces.PartialRelativeSensor;
      Modelica.Blocks.Interfaces.RealOutput tau(unit="N.m")
        "Torque in flange flange_a and flange_b (tau = flange_a.tau = -flange_b.tau) as output signal"
        annotation (Placement(transformation(
            origin={-80,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));

    equation
      flange_a.phi = flange_b.phi;
      flange_a.tau = tau;
      annotation (Documentation(info="<html>
<p>
Measures the <b>cut-torque between two flanges</b> in an ideal way
and provides the result as output signal <b>tau</b>
(to be further processed with blocks of the Modelica.Blocks library).
</p>
</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Text(extent={{-50.0,-120.0},{50.0,-80.0}},
          textString="tau"),
        Line(points={{-80.0,-100.0},{-80.0,0.0}},
          color={0,0,127})}));
    end TorqueSensor;

    model PowerSensor
      "Ideal sensor to measure the power between two flanges (= flange_a.tau*der(flange_a.phi))"

      extends Rotational.Interfaces.PartialRelativeSensor;
      Modelica.Blocks.Interfaces.RealOutput power(unit="W")
        "Power in flange flange_a as output signal"
        annotation (Placement(transformation(
            origin={-80,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));

    equation
      flange_a.phi = flange_b.phi;
      power = flange_a.tau*der(flange_a.phi);
      annotation (Documentation(info="<html>
<p>
Measures the <b>power between two flanges</b> in an ideal way
and provides the result as output signal <b>power</b>
(to be further processed with blocks of the Modelica.Blocks library).
</p>
</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Text(extent={{-50.0,-120.0},{100.0,-80.0}},
          textString="power"),
        Line(points={{-80.0,-100.0},{-80.0,0.0}},
          color={0,0,127})}));
    end PowerSensor;

    model MultiSensor
      "Ideal sensor to measure the torque and power between two flanges (= flange_a.tau*der(flange_a.phi)) and the absolute angular velocity"
      extends .Modelica.Mechanics.Rotational.Interfaces.PartialRelativeSensor;
      Modelica.Blocks.Interfaces.RealOutput power(unit="W")
        "Power in flange flange_a as output signal"
        annotation (Placement(transformation(
            origin={-60,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Blocks.Interfaces.RealOutput w(unit="rad/s")
        "Absolute angular velocity of flange_a as output signal" annotation (
          Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={60,-110})));
      Modelica.Blocks.Interfaces.RealOutput tau(unit="N.m")
        "Torque in flange flange_a and flange_b (tau = flange_a.tau = -flange_b.tau) as output signal"
        annotation (Placement(transformation(
            origin={0,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));
    equation
      flange_a.phi = flange_b.phi;
      w = der(flange_a.phi);
      tau = flange_a.tau;
      power = tau*w;
      annotation (Documentation(info="<html>
<p>Measures the <b>absolute angular velocity</b> of a flange_a, the <b>cut-torque</b> and <b>power</b> between two flanges in an ideal way and provides the results as output signals <b>w</b>, <b>tau</b> and <b>power</b>, respectively.
</p>
</html>"), Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{60,-68},{100,-96}},
              lineColor={0,0,0},
              textString="w"),
            Text(
              extent={{-140,-68},{-60,-96}},
              lineColor={0,0,0},
              textString="power"),
            Text(
              extent={{-30,-68},{30,-96}},
              lineColor={0,0,0},
              textString="tau"),
            Line(points={{-60,-100},{-60,-60},{-94,-2}}),
            Line(points={{0,-100},{0,-70}}, color={0,0,127}),
            Line(points={{60,-100},{60,-60},{50,-50}}, color={0,0,127})}));
    end MultiSensor;
    annotation (Documentation(info="<html>
<p>
This package contains ideal sensor components that provide
the connector variables as signals for further processing with the
Modelica.Blocks library.
</p>
</html>"));
  end Sensors;

  package Sources "Sources to drive 1D rotational mechanical components"
    extends Modelica.Icons.SourcesPackage;

    model Position
      "Forced movement of a flange according to a reference angle signal"
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
      parameter Boolean exact=false
        "true/false exact treatment/filtering the input signal";
      parameter SI.Frequency f_crit=50
        "if exact=false, critical frequency of filter to filter input signal"
        annotation (Dialog(enable=not exact));
      SI.Angle phi(stateSelect=if exact then StateSelect.default else
            StateSelect.prefer)
        "Rotation angle of flange with respect to support";
      SI.AngularVelocity w(start=0,stateSelect=if exact then StateSelect.default
             else StateSelect.prefer)
        "If exact=false, Angular velocity of flange with respect to support else dummy";
      SI.AngularAcceleration a(start=0)
        "If exact=false, Angular acceleration of flange with respect to support else dummy";
      Modelica.Blocks.Interfaces.RealInput phi_ref(
        final quantity="Angle",
        final unit="rad",
        displayUnit="deg")
        "Reference angle of flange with respect to support as input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

    protected
      parameter Modelica.SIunits.AngularFrequency w_crit=2*Modelica.Constants.pi
          *f_crit "Critical frequency";
      constant Real af=1.3617 "s coefficient of Bessel filter";
      constant Real bf=0.6180 "s*s coefficient of Bessel filter";
    initial equation
      if not exact then
        phi = phi_ref;
      end if;
    equation
      phi = flange.phi - phi_support;
      if exact then
        phi = phi_ref;
        w = 0;
        a = 0;
      else
        // Filter: a = phi_ref*s^2/(1 + (af/w_crit)*s + (bf/w_crit^2)*s^2)
        w = der(phi);
        a = der(w);
        a = ((phi_ref - phi)*w_crit - af*w)*(w_crit/bf);
      end if;
      annotation (Documentation(info="<html>
<p>
The input signal <b>phi_ref</b> defines the <b>reference
angle</b> in [rad]. Flange <b>flange</b> is <b>forced</b>
to move according to this reference motion relative to flange support. According to parameter
<b>exact</b> (default = <b>false</b>), this is done in the following way:
</p>
<ol>
<li><b>exact=true</b><br>
    The reference angle is treated <b>exactly</b>. This is only possible, if
    the input signal is defined by an analytical function which can be
    differentiated at least twice. If this prerequisite is fulfilled,
    the Modelica translator will differentiate the input signal twice
    in order to compute the reference acceleration of the flange.</li>
<li><b>exact=false</b><br>
    The reference angle is <b>filtered</b> and the second derivative
    of the filtered curve is used to compute the reference acceleration
    of the flange. This second derivative is <b>not</b> computed by
    numerical differentiation but by an appropriate realization of the
    filter. For filtering, a second order Bessel filter is used.
    The critical frequency (also called cut-off frequency) of the
    filter is defined via parameter <b>f_crit</b> in [Hz]. This value
    should be selected in such a way that it is higher as the essential
    low frequencies in the signal.</li>
</ol>
<p>
The input signal can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>
</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Rectangle(lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-20.0},{100.0,20.0}}),
        Line(points={{-30.0,-32.0},{30.0,-32.0}}),
        Line(points={{0.0,52.0},{0.0,32.0}}),
        Line(points={{-29.0,32.0},{30.0,32.0}}),
        Line(points={{0.0,-32.0},{0.0,-100.0}}),
        Line(points={{30.0,-42.0},{20.0,-52.0}}),
        Line(points={{30.0,-32.0},{10.0,-52.0}}),
        Line(points={{20.0,-32.0},{0.0,-52.0}}),
        Line(points={{10.0,-32.0},{-10.0,-52.0}}),
        Line(points={{0.0,-32.0},{-20.0,-52.0}}),
        Line(points={{-10.0,-32.0},{-30.0,-52.0}}),
        Line(points={{-20.0,-32.0},{-30.0,-42.0}}),
        Text(extent={{-172.0,-90.0},{-56.0,-56.0}},
          textString="phi_ref"),
        Text(lineColor={0,0,255},
          extent={{-150.0,60.0},{150.0,100.0}},
          textString="%name"),
        Text(extent={{30.0,-62.0},{146.0,-28.0}},
          textString="exact="),
        Text(extent={{30.0,-98.0},{146.0,-64.0}},
          textString="%exact")}));
    end Position;

    model Speed
      "Forced movement of a flange according to a reference angular velocity signal"
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
      parameter Boolean exact=false
        "true/false exact treatment/filtering the input signal";
      parameter SI.Frequency f_crit=50
        "if exact=false, critical frequency of filter to filter input signal"
        annotation (Dialog(enable=not exact));
      SI.Angle phi(
        start=0,
        fixed=true,
        stateSelect=StateSelect.prefer)
        "Rotation angle of flange with respect to support";
      SI.AngularVelocity w(stateSelect=if exact then StateSelect.default else
            StateSelect.prefer)
        "Angular velocity of flange with respect to support";
      SI.AngularAcceleration a
        "If exact=false, angular acceleration of flange with respect to support else dummy";
      Modelica.Blocks.Interfaces.RealInput w_ref(unit="rad/s")
        "Reference angular velocity of flange with respect to support as input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

    protected
      parameter Modelica.SIunits.AngularFrequency w_crit=2*Modelica.Constants.pi
          *f_crit "Critical frequency";
    initial equation
      if not exact then
        w = w_ref;
      end if;
    equation
      phi = flange.phi - phi_support;
      w = der(phi);
      if exact then
        w = w_ref;
        a = 0;
      else
        // Filter: a = w_ref/(1 + (1/w_crit)*s)
        a = der(w);
        a = (w_ref - w)*w_crit;
      end if;
      annotation (Documentation(info="<html>
<p>
The input signal <b>w_ref</b> defines the <b>reference
speed</b> in [rad/s]. Flange <b>flange</b> is <b>forced</b>
to move relative to flange support according to this reference motion. According to parameter
<b>exact</b> (default = <b>false</b>), this is done in the following way:
</p>
<ol>
<li><b>exact=true</b><br>
    The reference speed is treated <b>exactly</b>. This is only possible, if
    the input signal is defined by an analytical function which can be
    differentiated at least once. If this prerequisite is fulfilled,
    the Modelica translator will differentiate the input signal once
    in order to compute the reference acceleration of the flange.</li>
<li><b>exact=false</b><br>
    The reference angle is <b>filtered</b> and the second derivative
    of the filtered curve is used to compute the reference acceleration
    of the flange. This second derivative is <b>not</b> computed by
    numerical differentiation but by an appropriate realization of the
    filter. For filtering, a first order filter is used.
    The critical frequency (also called cut-off frequency) of the
    filter is defined via parameter <b>f_crit</b> in [Hz]. This value
    should be selected in such a way that it is higher as the essential
    low frequencies in the signal.</li>
</ol>
<p>
The input signal can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>
</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Rectangle(lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-20.0},{100.0,20.0}}),
        Line(points={{-30.0,-32.0},{30.0,-32.0}}),
        Line(points={{0.0,52.0},{0.0,32.0}}),
        Line(points={{-29.0,32.0},{30.0,32.0}}),
        Line(points={{0.0,-32.0},{0.0,-100.0}}),
        Line(points={{-10.0,-32.0},{-30.0,-52.0}}),
        Line(points={{0.0,-32.0},{-20.0,-52.0}}),
        Line(points={{10.0,-32.0},{-10.0,-52.0}}),
        Line(points={{20.0,-32.0},{0.0,-52.0}}),
        Line(points={{-20.0,-32.0},{-30.0,-42.0}}),
        Line(points={{30.0,-32.0},{10.0,-52.0}}),
        Line(points={{30.0,-42.0},{20.0,-52.0}}),
        Text(extent={{-158.0,-78.0},{-54.0,-44.0}},
          textString="w_ref"),
        Text(lineColor={0,0,255},
          extent={{-0.0,60.0},{0.0,120.0}},
          textString="%name"),
        Text(extent={{30.0,-60.0},{146.0,-26.0}},
          textString="exact="),
        Text(extent={{30.0,-96.0},{146.0,-62.0}},
          textString="%exact")}));
    end Speed;

    model Accelerate
      "Forced movement of a flange according to an acceleration signal"
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
      SI.Angle phi(
        start=0,
        fixed=true,
        stateSelect=StateSelect.prefer)
        "Rotation angle of flange with respect to support";
      SI.AngularVelocity w(
        start=0,
        fixed=true,
        stateSelect=StateSelect.prefer)
        "Angular velocity of flange with respect to support";
      SI.AngularAcceleration a
        "Angular acceleration of flange with respect to support";

      Modelica.Blocks.Interfaces.RealInput a_ref(unit="rad/s2")
        "Absolute angular acceleration of flange with respect to support as input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

    equation
      phi = flange.phi - phi_support;
      w = der(phi);
      a = der(w);
      a = a_ref;
      annotation (Documentation(info="<html>
<p>
The input signal <b>a</b> defines an <b>angular acceleration</b>
in [rad/s2]. Flange <b>flange</b> is <b>forced</b> to move relative to flange support with
this acceleration. The angular velocity <b>w</b> and the rotation angle
<b>phi</b> of the flange are automatically determined by integration of
the acceleration.
</p>
<p>
The input signal can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>
</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Rectangle(lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-20.0},{100.0,20.0}}),
        Line(points={{-30.0,-32.0},{30.0,-32.0}}),
        Line(points={{0.0,52.0},{0.0,32.0}}),
        Line(points={{-29.0,32.0},{30.0,32.0}}),
        Line(points={{0.0,-32.0},{0.0,-100.0}}),
        Line(points={{30.0,-42.0},{20.0,-52.0}}),
        Line(points={{30.0,-32.0},{10.0,-52.0}}),
        Line(points={{20.0,-32.0},{0.0,-52.0}}),
        Line(points={{10.0,-32.0},{-10.0,-52.0}}),
        Line(points={{0.0,-32.0},{-20.0,-52.0}}),
        Line(points={{-10.0,-32.0},{-30.0,-52.0}}),
        Line(points={{-20.0,-32.0},{-30.0,-42.0}}),
        Text(extent={{-144.0,-86.0},{-46.0,-50.0}},
          textString="a_ref"),
        Text(lineColor={0,0,255},
          extent={{-150.0,60.0},{150.0,100.0}},
          textString="%name")}));
    end Accelerate;

    model Move
      "Forced movement of a flange according to an angle, speed and angular acceleration signal"
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;

      Modelica.SIunits.Angle phi "Rotation angle of flange with respect to support";
      Modelica.Blocks.Interfaces.RealInput u[3]
        "Angle, angular velocity and angular acceleration of flange with respect to support as input signals"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    protected
      function position
        extends Modelica.Icons.Function;
        input Real q_qd_qdd[3] "Required values for position, speed, acceleration";
        input Real dummy
          "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
        output Real q;
      algorithm
        q := q_qd_qdd[1];
        annotation (derivative(noDerivative=q_qd_qdd) = position_der, LateInline=true);
      end position;

      function position_der
        extends Modelica.Icons.Function;
        input Real q_qd_qdd[3] "Required values for position, speed, acceleration";
        input Real dummy
          "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
        input Real dummy_der;
        output Real qd;
      algorithm
        qd := q_qd_qdd[2];
        annotation (derivative(
            noDerivative=q_qd_qdd,
            order=2) = position_der2, LateInline=true);
      end position_der;

      function position_der2
        extends Modelica.Icons.Function;
        input Real q_qd_qdd[3] "Required values for position, speed, acceleration";
        input Real dummy
          "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
        input Real dummy_der;
        input Real dummy_der2;
        output Real qdd;
      algorithm
        qdd := q_qd_qdd[3];
      end position_der2;
    equation
      phi = flange.phi - phi_support;
      phi = position(u, time);
      annotation (Documentation(info="<html>
<p>
Flange <b>flange</b> is <b>forced</b> to move relative to flange support with a predefined motion
according to the input signals:
</p>
<pre>
    u[1]: angle of flange
    u[2]: angular velocity of flange
    u[3]: angular acceleration of flange
</pre>
<p>
The user has to guarantee that the input signals are consistent to each other,
i.e., that u[2] is the derivative of u[1] and that
u[3] is the derivative of u[2]. There are, however,
also applications where by purpose these conditions do not hold. For example,
if only the position dependent terms of a mechanical system shall be
calculated, one may provide angle = angle(t) and set the angular velocity
and the angular acceleration to zero.
</p>
<p>
The input signals can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>
</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Text(extent={{-80.0,-100.0},{-80.0,-60.0}},
          textString="phi,w,a"),
        Rectangle(lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-20.0},{100.0,20.0}}),
        Line(points={{-30.0,-32.0},{30.0,-32.0}}),
        Line(points={{0.0,52.0},{0.0,32.0}}),
        Line(points={{-29.0,32.0},{30.0,32.0}}),
        Line(points={{0.0,-32.0},{0.0,-100.0}}),
        Line(points={{30.0,-42.0},{20.0,-52.0}}),
        Line(points={{30.0,-32.0},{10.0,-52.0}}),
        Line(points={{20.0,-32.0},{0.0,-52.0}}),
        Line(points={{10.0,-32.0},{-10.0,-52.0}}),
        Line(points={{0.0,-32.0},{-20.0,-52.0}}),
        Line(points={{-10.0,-32.0},{-30.0,-52.0}}),
        Line(points={{-20.0,-32.0},{-30.0,-42.0}}),
        Text(lineColor={0,0,255},
          extent={{-150.0,60.0},{150.0,100.0}},
          textString="%name")}));
    end Move;

    model Torque "Input signal acting as external torque on a flange"
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
      Modelica.Blocks.Interfaces.RealInput tau(unit="N.m")
        "Accelerating torque acting at flange (= -flange.tau)" annotation (
          Placement(transformation(extent={{-140,-20},{-100,20}})));

    equation
      flange.tau = -tau;
      annotation (
        Documentation(info="<html>
<p>
The input signal <b>tau</b> defines an external
torque in [Nm] which acts (with negative sign) at
a flange connector, i.e., the component connected to this
flange is driven by torque <b>tau</b>.</p>
<p>
The input signal can be provided from one of the signal generator
blocks of Modelica.Blocks.Sources.
</p>
</html>"),
        Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
          graphics={
        Text(extent={{-150,110},{150,70}},
          textString="%name",
          lineColor={0,0,255}),
        Text(extent={{-62,-29},{-141,-70}},
          lineColor={0,0,0},
          textString="tau"),
        Line(points={{-88,0},{-64,30},{-36,52},{-2,62},{28,56},{48,44},{64,28},{76,14},{86,0}},
          thickness=0.5,
          smooth=Smooth.Bezier),
        Polygon(points={{86,0},{66,58},{37,27},{86,0}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-30,-30},{30,-30}}),
        Line(points={{0,-30},{0,-101}}),
        Line(points={{-30,-50},{-10,-30}}),
        Line(points={{-10,-50},{10,-30}}),
        Line(points={{10,-50},{30,-30}}),
        Line(points={{-54,-42},{-38,-28},{-16,-16},{4,-14},{22,-18},{36,-26},{48,-36},{56,-46},{64,-58}},
          smooth=Smooth.Bezier),
        Polygon(points={{-61,-66},{-44,-42},{-58,-36},{-61,-66}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{14,86},{82,73}},
              lineColor={128,128,128},
              textString="rotation axis"),
            Polygon(
              points={{10,80},{-10,85},{-10,75},{10,80}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,80},{-9,80}}, color={128,128,128}),
            Line(
              points={{-88,0},{-64,30},{-36,52},{-2,62},{28,56},{48,44},{64,28},
                  {76,14},{80,10}},
              thickness=0.5,
              smooth=Smooth.Bezier),
            Polygon(
              points={{86,0},{66,58},{38,28},{86,0}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}));
    end Torque;

    model Torque2 "Input signal acting as torque on two flanges"
      extends Rotational.Interfaces.PartialTwoFlanges;

      Modelica.Blocks.Interfaces.RealInput tau(unit="N.m")
        "Torque driving the two flanges (a positive value accelerates the flange)"
        annotation (Placement(transformation(
            origin={0,40},
            extent={{-20,-20},{20,20}},
            rotation=270)));

    equation
      flange_a.tau = tau;
      flange_b.tau = -tau;
      annotation (
        Documentation(info="<html>
<p>
The input signal <b>tau</b> defines an external
torque in [Nm] which acts at both flange connectors,
i.e., the components connected to these flanges are driven by torque <b>tau</b>.</p>
<p>The input signal can be provided from one of the signal generator
blocks of Modelica.Blocks.Sources.
</p>
</html>"),
        Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}),
          graphics={
        Text(extent={{-150,-40},{150,-80}},
          textString="%name",
          lineColor={0,0,255}),
        Polygon(points={{-78,24},{-69,17},{-89,0},{-78,24}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,20},{-70,23},{-65,26},{-60,28},{-56,29},{-50,30},{-41,30},{-35,29},{-31,28},{-26,26},{-21,23},{-17,20},{-13,15},{-10,9}},
          thickness=0.5, smooth=Smooth.Bezier),
        Line(points={{74,20},{70,23},{65,26},{60,28},{56,29},{50,30},{41,30},{35,29},{31,28},{26,26},{21,23},{17,20},{13,15},{10,9}},
          thickness=0.5, smooth=Smooth.Bezier),
        Polygon(points={{89,0},{78,24},{69,17},{89,0}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{15,-71},{83,-84}},
              lineColor={128,128,128},
              textString="rotation axis"),
            Polygon(
              points={{11,-77},{-9,-72},{-9,-82},{11,-77}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Line(points={{-79,-77},{-8,-77}}, color={128,128,128}),
            Line(
              points={{-75,20},{-71,23},{-66,26},{-61,28},{-57,29},{-51,30},{-42,
                  30},{-36,29},{-32,28},{-27,26},{-22,23},{-18,20},{-14,15},{-11,
                  9}},
              thickness=0.5, smooth=Smooth.Bezier),
            Polygon(
              points={{-79,24},{-70,17},{-90,0},{-79,24}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{73,20},{69,23},{64,26},{59,28},{55,29},{49,30},{40,30},{
                  34,29},{30,28},{25,26},{20,23},{16,20},{12,15},{9,9}},
              thickness=0.5, smooth=Smooth.Bezier),
            Polygon(
              points={{88,0},{77,24},{68,17},{88,0}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}));
    end Torque2;

    model LinearSpeedDependentTorque "Linear dependency of torque versus speed"
      extends Modelica.Mechanics.Rotational.Interfaces.PartialTorque;
      parameter Modelica.SIunits.Torque tau_nominal
        "Nominal torque (if negative, torque is acting as load)";
      parameter Boolean TorqueDirection=true
        "Same direction of torque in both directions of rotation";
      parameter Modelica.SIunits.AngularVelocity w_nominal(min=Modelica.Constants.eps)
        "Nominal speed";
      Modelica.SIunits.AngularVelocity w
        "Angular velocity of flange with respect to support (= der(phi))";
      Modelica.SIunits.Torque tau
        "Accelerating torque acting at flange (= -flange.tau)";
    equation
      w = der(phi);
      tau = -flange.tau;
      if TorqueDirection then
        tau = tau_nominal*abs(w/w_nominal);
      else
        tau = tau_nominal*(w/w_nominal);
      end if;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{-100,-100},{100,100}},
                color={0,0,127})}), Documentation(info="<html>
<p>
Model of torque, linearly dependent on angular velocity of flange.<br>
Parameter TorqueDirection chooses whether direction of torque is the same in both directions of rotation or not.
</p>
</html>"));
    end LinearSpeedDependentTorque;

    model QuadraticSpeedDependentTorque
      "Quadratic dependency of torque versus speed"
      extends Modelica.Mechanics.Rotational.Interfaces.PartialTorque;
      parameter Modelica.SIunits.Torque tau_nominal
        "Nominal torque (if negative, torque is acting as load)";
      parameter Boolean TorqueDirection=true
        "Same direction of torque in both directions of rotation";
      parameter Modelica.SIunits.AngularVelocity w_nominal(min=Modelica.Constants.eps)
        "Nominal speed";
      Modelica.SIunits.AngularVelocity w
        "Angular velocity of flange with respect to support (= der(phi))";
      Modelica.SIunits.Torque tau
        "Accelerating torque acting at flange (= -flange.tau)";
    equation
      w = der(phi);
      tau = -flange.tau;
      if TorqueDirection then
        tau = tau_nominal*(w/w_nominal)^2;
      else
        tau = tau_nominal*smooth(1, if w >= 0 then (w/w_nominal)^2 else -(w/w_nominal)^2);
      end if;
      annotation (
        Icon(
          coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
            Line(
              points={{-100.0,-100.0},{-80.0,-98.0},{-60.0,-92.0},
                {-40.0,-82.0},{-20.0,-68.0},{0.0,-50.0},{20.0,-28.0},
                {40.0,-2.0},{60.0,28.0},{80.0,62.0},{100.0,100.0}},
              color={0,0,127}, smooth=Smooth.Bezier)}),
        Documentation(info="<html>
<p>
Model of torque, quadratic dependent on angular velocity of flange.<br>
Parameter TorqueDirection chooses whether direction of torque is the same in both directions of rotation or not.
</p>
</html>"));
    end QuadraticSpeedDependentTorque;

    model ConstantTorque "Constant torque, not dependent on speed"
      extends Rotational.Interfaces.PartialTorque;
      parameter Modelica.SIunits.Torque tau_constant
        "Constant torque (if negative, torque is acting as load in positive direction of rotation)";
      Modelica.SIunits.AngularVelocity w
        "Angular velocity of flange with respect to support (= der(phi))";
      Modelica.SIunits.Torque tau
        "Accelerating torque acting at flange (= -flange.tau)";
    equation
      w = der(phi);
      tau = -flange.tau;
      tau = tau_constant;
      annotation (Icon(
          coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}),
            graphics={
              Line(
                points={{-98,0},{100,0}},
                color={0,0,127}),
              Text(
                extent={{-124.0,-40.0},{120.0,-16.0}},
                textString="%tau_constant")}), Documentation(info="<html>
<p>Model of constant torque, not dependent on angular velocity of flange.</p>
<p>Please note:<br>
Positive torque accelerates in positive direction of rotation, but brakes in reverse direction of rotation.<br>
Negative torque brakes in positive direction of rotation, but accelerates in reverse direction of rotation.</p>
</html>"));
    end ConstantTorque;

    model SignTorque "Constant torque changing sign with speed"
      extends Rotational.Interfaces.PartialTorque;
      import Modelica.Constants.pi;
      parameter Modelica.SIunits.Torque tau_constant
        "Constant torque (if negative, torque is acting as load in positive direction of rotation)";
      parameter Modelica.Blocks.Types.Regularization reg=Modelica.Blocks.Types.Regularization.Exp
        "Type of regularization"  annotation(Evaluate=true);
      parameter Modelica.SIunits.AngularVelocity w0(final min=Modelica.Constants.eps, start=0.1)
        "Regularization below w0";
      Modelica.SIunits.AngularVelocity w
        "Angular velocity of flange with respect to support (= der(phi))";
      Modelica.SIunits.Torque tau
        "Accelerating torque acting at flange (= -flange.tau)";
    equation
      w = der(phi);
      tau = -flange.tau;
      if reg==Modelica.Blocks.Types.Regularization.Exp then
        tau = tau_constant*(2/(1+exp(-w/(0.01*w0)))-1);
      elseif reg==Modelica.Blocks.Types.Regularization.Sine then
        tau = tau_constant*smooth(1, (if abs(w)>=w0 then sign(w) else sin(pi/2*w/w0)));
      elseif reg==Modelica.Blocks.Types.Regularization.Linear then
        tau = tau_constant*(if abs(w)>=w0 then sign(w) else (w/w0));
      else//if reg==Modelica.Blocks.Types.Regularization.CoSine
        tau = tau_constant*(if abs(w)>=w0 then sign(w) else sign(w)*(1 - cos(pi/2*w/w0)));
      end if;
      annotation (Icon(
          coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}),
            graphics={
              Text(
                extent={{-124.0,-40.0},{120.0,-16.0}},
                textString="%tau_constant"),
              Line(
                points={{-100,0},{100,0}},
                color={0,0,127}),
              Line(
                points={{-100,0},{100,0}},
                color={0,0,127},
              rotation=90),
            Line(points={{-80,-40},{-6,-40},{-4,-38},{4,38},{6,40},{80,40}})}),              Documentation(info="<html>
<p>Model of constant torque which changes sign with direction of rotation.</p>
<p>Please note:<br>
Positive torque accelerates in both directions of rotation.<br>
Negative torque brakes in both directions of rotation.</p>
<p>Around zero speed regularization avoids numerical problems.</p>
</html>"));
    end SignTorque;

    model ConstantSpeed "Constant speed, not dependent on torque"
      extends Modelica.Mechanics.Rotational.Interfaces.PartialTorque;
      Modelica.SIunits.AngularVelocity w
        "Angular velocity of flange with respect to support (= der(phi))";
      parameter Modelica.SIunits.AngularVelocity w_fixed "Fixed speed";
    equation
      w = der(phi);
      w = w_fixed;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{0,-100},{0,100}}, color={0,0,127}),
          Text(extent={{-116.0,-40.0},{128.0,-16.0}},
                textString="%w_fixed")}), Documentation(info="<html>
<p>
Model of <b>fixed</b> angular velocity of flange, not dependent on torque.
</p>
</html>"));
    end ConstantSpeed;

    model TorqueStep "Constant torque, not dependent on speed"
      extends Modelica.Mechanics.Rotational.Interfaces.PartialTorque;
      parameter Modelica.SIunits.Torque stepTorque(start=1)
        "Height of torque step (if negative, torque is acting as load)";
      parameter Modelica.SIunits.Torque offsetTorque(start=0)
        "Offset of torque";
      parameter Modelica.SIunits.Time startTime=0
        "Torque = offset for time < startTime";
      Modelica.SIunits.Torque tau
        "Accelerating torque acting at flange (= -flange.tau)";

    equation
      tau = -flange.tau;
      tau = offsetTorque + (if time < startTime then 0 else stepTorque);
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{-80,-60},{0,-60},{0,60},{80,
                  60}}, color={0,0,127}), Text(
              extent={{0.0,-60.0},{100.0,-40.0}},
              lineColor={0,0,255},
              textString="time")}), Documentation(info="<html>
<p>
Model of a torque step at time .<br>
Positive torque acts accelerating.
</p>
</html>"));
    end TorqueStep;

    annotation (Documentation(info="<html>
<p>
This package contains ideal sources to drive 1D mechanical rotational drive trains.
</p>
</html>"));
  end Sources;

  package Interfaces
    "Connectors and partial models for 1D rotational mechanical components"

    extends Modelica.Icons.InterfacesPackage;

    connector Flange_a
      "1-dim. rotational flange of a shaft (filled square icon)"
      SI.Angle phi "Absolute rotation angle of flange";
      flow SI.Torque tau "Cut torque in the flange";
      annotation (
        defaultComponentName="flange_a",
        Documentation(info="<html>
<p>
This is a connector for 1-dim. rotational mechanical systems and models
the mechanical flange of a shaft. The following variables are defined in this connector:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"> <b>phi</b></td>
      <td valign=\"top\"> Absolute rotation angle of the shaft flange in [rad] </td>
  </tr>
  <tr><td valign=\"top\"> <b>tau</b></td>
      <td valign=\"top\"> Cut-torque in the shaft flange in [Nm] </td>
  </tr>
</table>

<p>
There is a second connector for flanges: Flange_b. The connectors
Flange_a and Flange_b are completely identical. There is only a difference
in the icons, in order to easier identify a flange variable in a diagram.
For a discussion on the actual direction of the cut-torque tau and
of the rotation angle, see section
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.SignConventions\">Sign Conventions</a>
in the user's guide of Rotational.
</p>

<p>
If needed, the absolute angular velocity w and the
absolute angular acceleration a of the flange can be determined by
differentiation of the flange angle phi:
</p>
<pre>
     w = der(phi);    a = der(w)
</pre>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
          Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Text(
                  extent={{-160,90},{40,50}},
                  lineColor={0,0,0},
                  textString="%name"),Ellipse(
                  extent={{-40,40},{40,-40}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid)}));
    end Flange_a;

    connector Flange_b
      "1-dim. rotational flange of a shaft (non-filled square icon)"
      SI.Angle phi "Absolute rotation angle of flange";
      flow SI.Torque tau "Cut torque in the flange";
      annotation (
        defaultComponentName="flange_b",
        Documentation(info="<html>
<p>
This is a connector for 1-dim. rotational mechanical systems and models
the mechanical flange of a shaft. The following variables are defined in this connector:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"> <b>phi</b></td>
      <td valign=\"top\"> Absolute rotation angle of the shaft flange in [rad] </td>
  </tr>
  <tr><td valign=\"top\"> <b>tau</b></td>
      <td valign=\"top\"> Cut-torque in the shaft flange in [Nm] </td>
  </tr>
</table>

<p>
There is a second connector for flanges: Flange_a. The connectors
Flange_a and Flange_b are completely identical. There is only a difference
in the icons, in order to easier identify a flange variable in a diagram.
For a discussion on the actual direction of the cut-torque tau and
of the rotation angle, see section
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.SignConventions\">Sign Conventions</a>
in the user's guide of Rotational.
</p>

<p>
If needed, the absolute angular velocity w and the
absolute angular acceleration a of the flange can be determined by
differentiation of the flange angle phi:
</p>
<pre>
     w = der(phi);    a = der(w)
</pre>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Ellipse(
                  extent={{-98,100},{102,-100}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Ellipse(
                  extent={{-40,40},{40,-40}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-40,90},{160,50}},
                  lineColor={0,0,0},
                  textString="%name")}));
    end Flange_b;

    connector Support "Support/housing of a 1-dim. rotational shaft"

      SI.Angle phi "Absolute rotation angle of the support/housing";
      flow SI.Torque tau "Reaction torque in the support/housing";

      annotation (
        Documentation(info="<html>
<p>
This is a connector for 1-dim. rotational mechanical systems and models
the support or housing of a shaft. The following variables are defined in this connector:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"> <b>phi</b></td>
      <td valign=\"top\"> Absolute rotation angle of the support/housing in [rad] </td>
  </tr>
  <tr><td valign=\"top\"> <b>tau</b></td>
      <td valign=\"top\"> Reaction torque in the support/housing in [Nm] </td>
  </tr>
</table>

<p>
The support connector is usually defined as conditional connector.
It is most convenient to utilize it
</p>

<ul>
<li> For models to be build graphically (i.e., the model is build up by drag-and-drop
     from elementary components):<br>
     <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialOneFlangeAndSupport\">PartialOneFlangeAndSupport</a>,<br>
     <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlangesAndSupport\">PartialTwoFlangesAndSupport</a>, <br> &nbsp; </li>

<li> For models to be build textually (i.e., elementary models):<br>
     <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport\">PartialElementaryOneFlangeAndSupport</a>,<br>
     <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport\">PartialElementaryTwoFlangesAndSupport</a>,<br>
     <a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryRotationalToTranslational\">PartialElementaryRotationalToTranslational</a>.</li>
</ul>
</html>"),
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-150,150},{150,-150}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Rectangle(
                  extent={{-60,60},{60,-60}},
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-160,100},{40,60}},
                  lineColor={0,0,0},
                  textString="%name"),Ellipse(
                  extent={{-40,40},{40,-40}},
                  lineColor={0,0,0},
                  fillColor={135,135,135},
                  fillPattern=FillPattern.Solid)}));
    end Support;

    model InternalSupport
      "Adapter model to utilize conditional support connector"
      input Modelica.SIunits.Torque tau
        "External support torque (must be computed via torque balance in model where InternalSupport is used; = flange.tau)";
      Modelica.SIunits.Angle phi "External support angle (= flange.phi)";
      Flange_a flange
        "Internal support flange (must be connected to the conditional support connector for useSupport=true and to conditional fixed model for useSupport=false)"
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      flange.tau = tau;
      flange.phi = phi;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Ellipse(
                  extent={{-20,20},{20,-20}},
                  lineColor={135,135,135},
                  fillColor={175,175,175},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-200,80},{200,40}},
                  lineColor={0,0,255},
                  textString="%name")}), Documentation(info="<html>
<p>
This is an adapter model to utilize a conditional support connector
in an elementary component, i.e., where the component equations are
defined textually:
</p>

<ul>
<li> If <i>useSupport = true</i>, the flange has to be connected to the conditional
     support connector.</li>
<li> If <i>useSupport = false</i>, the flange has to be connected to the conditional
     fixed model.</li>
</ul>

<p>
Variable <b>tau</b> is defined as <b>input</b> and must be provided when using
this component as a modifier (computed via a torque balance in
the model where InternalSupport is used). Usually, model InternalSupport is
utilized via the partial models:
</p>

<blockquote>
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport\">
PartialElementaryOneFlangeAndSupport</a>,<br>
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryTwoFlangesAndSupport\">
PartialElementaryTwoFlangesAndSupport</a>,<br>
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.PartialElementaryRotationalToTranslational\">
PartialElementaryRotationalToTranslational</a>.
</blockquote>

<p>
Note, the support angle can always be accessed as internalSupport.phi, and
the support torque can always be accessed as internalSupport.tau.
</p>
</html>"));
    end InternalSupport;

    partial model PartialTwoFlanges
      "Partial model for a component with two rotational 1-dim. shaft flanges"

      Flange_a flange_a "Flange of left shaft" annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Flange_b flange_b "Flange of right shaft" annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      annotation (Documentation(info="<html>
<p>
This is a 1-dim. rotational component with two flanges.
It is used e.g., to build up parts of a drive train consisting
of several components.
</p>
</html>"));
    end PartialTwoFlanges;

    partial model PartialOneFlangeAndSupport
      "Partial model for a component with one rotational 1-dim. shaft flange and a support used for graphical modeling, i.e., the model is build up by drag-and-drop from elementary components"
      parameter Boolean useSupport=false
        "= true, if support flange enabled, otherwise implicitly grounded"
        annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      Flange_b flange "Flange of shaft" annotation (Placement(transformation(
              extent={{90,-10},{110,10}})));
      Support support if useSupport "Support/housing of component"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    protected
      Support internalSupport
        "Internal support/housing of component (either connected to support, if useSupport=true, or connected to fixed, if useSupport=false)"
        annotation (Placement(transformation(extent={{-3,-83},{3,-77}})));
      Components.Fixed fixed if not useSupport
        "Fixed support/housing, if not useSupport"
        annotation (Placement(transformation(extent={{10,-94},{30,-74}})));
    equation
      connect(support, internalSupport) annotation (Line(
          points={{0,-100},{0,-80}}));
      connect(internalSupport, fixed.flange) annotation (Line(
          points={{0,-80},{20,-80},{20,-84}}));
      annotation (
        Documentation(info="<html>
<p>
This is a 1-dim. rotational component with one flange and a support/housing.
It is used e.g., to build up parts of a drive train graphically consisting
of several components.
</p>

<p>
If <i>useSupport=true</i>, the support connector is conditionally enabled
and needs to be connected.<br>
If <i>useSupport=false</i>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>
</html>"),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Text(
                  extent={{-38,-98},{-6,-96}},
                  lineColor={95,95,95},
                  textString="(if useSupport)"),Text(
                  extent={{21,-95},{61,-96}},
                  lineColor={95,95,95},
                  textString="(if not useSupport)")}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(
                  visible=not useSupport,
                  points={{-50,-120},{-30,-100}}),Line(
                  visible=not useSupport,
                  points={{-30,-120},{-10,-100}}),Line(
                  visible=not useSupport,
                  points={{-10,-120},{10,-100}}),Line(
                  visible=not useSupport,
                  points={{10,-120},{30,-100}}),Line(
                  visible=not useSupport,
                  points={{-30,-100},{30,-100}})}));
    end PartialOneFlangeAndSupport;

    partial model PartialTwoFlangesAndSupport
      "Partial model for a component with two rotational 1-dim. shaft flanges and a support used for graphical modeling, i.e., the model is build up by drag-and-drop from elementary components"
      parameter Boolean useSupport=false
        "= true, if support flange enabled, otherwise implicitly grounded"
        annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      Flange_a flange_a "Flange of left shaft" annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Flange_b flange_b "Flange of right shaft" annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Support support if useSupport "Support/housing of component"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    protected
      Support internalSupport
        "Internal support/housing of component (either connected to support, if useSupport=true, or connected to fixed, if useSupport=false)"
        annotation (Placement(transformation(extent={{-3,-83},{3,-77}})));
      Components.Fixed fixed if not useSupport
        "Fixed support/housing, if not useSupport"
        annotation (Placement(transformation(extent={{10,-97},{30,-77}})));
    equation
      connect(support, internalSupport) annotation (Line(
          points={{0,-100},{0,-80}}));
      connect(internalSupport, fixed.flange) annotation (Line(
          points={{0,-80},{20,-80},{20,-87}}));
      annotation (
        Documentation(info="<html>
<p>
This is a 1-dim. rotational component with two flanges and a support/housing.
It is used e.g., to build up parts of a drive train graphically consisting
of several components.
</p>

<p>
If <i>useSupport=true</i>, the support connector is conditionally enabled
and needs to be connected.<br>
If <i>useSupport=false</i>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>
</html>"),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Text(
                  extent={{-38,-98},{-6,-96}},
                  lineColor={95,95,95},
                  textString="(if useSupport)"),Text(
                  extent={{24,-97},{64,-98}},
                  lineColor={95,95,95},
                  textString="(if not useSupport)")}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(
                  visible=not useSupport,
                  points={{-50,-120},{-30,-100}}),Line(
                  visible=not useSupport,
                  points={{-30,-120},{-10,-100}}),Line(
                  visible=not useSupport,
                  points={{-10,-120},{10,-100}}),Line(
                  visible=not useSupport,
                  points={{10,-120},{30,-100}}),Line(
                  visible=not useSupport,
                  points={{-30,-100},{30,-100}})}));
    end PartialTwoFlangesAndSupport;

    partial model PartialCompliant
      "Partial model for the compliant connection of two rotational 1-dim. shaft flanges"

      Modelica.SIunits.Angle phi_rel(start=0)
        "Relative rotation angle (= flange_b.phi - flange_a.phi)";
      Modelica.SIunits.Torque tau "Torque between flanges (= flange_b.tau)";
      Flange_a flange_a "Left flange of compliant 1-dim. rotational component"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Flange_b flange_b "Right flange of compliant 1-dim. rotational component"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));

    equation
      phi_rel = flange_b.phi - flange_a.phi;
      flange_b.tau = tau;
      flange_a.tau = -tau;
      annotation (Documentation(info="<html>
<p>
This is a 1-dim. rotational component with a compliant connection of two
rotational 1-dim. flanges where inertial effects between the two
flanges are neglected. The basic assumption is that the cut-torques
of the two flanges sum-up to zero, i.e., they have the same absolute value
but opposite sign: flange_a.tau + flange_b.tau = 0. This base class
is used to built up force elements such as springs, dampers, friction.
</p>
</html>"));
    end PartialCompliant;

    partial model PartialCompliantWithRelativeStates
      "Partial model for the compliant connection of two rotational 1-dim. shaft flanges where the relative angle and speed are used as preferred states"

      Modelica.SIunits.Angle phi_rel(
        start=0,
        stateSelect=stateSelect,
        nominal=if phi_nominal >= Modelica.Constants.eps then phi_nominal else
            1) "Relative rotation angle (= flange_b.phi - flange_a.phi)";
      Modelica.SIunits.AngularVelocity w_rel(start=0, stateSelect=stateSelect)
        "Relative angular velocity (= der(phi_rel))";
      Modelica.SIunits.AngularAcceleration a_rel(start=0)
        "Relative angular acceleration (= der(w_rel))";
      Modelica.SIunits.Torque tau "Torque between flanges (= flange_b.tau)";
      Flange_a flange_a "Left flange of compliant 1-dim. rotational component"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Flange_b flange_b "Right flange of compliant 1-dim. rotational component"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));

      parameter SI.Angle phi_nominal(
        displayUnit="rad",
        min=0.0) = 1e-4 "Nominal value of phi_rel (used for scaling)"
        annotation (Dialog(tab="Advanced"));
      parameter StateSelect stateSelect=StateSelect.prefer
        "Priority to use phi_rel and w_rel as states"
        annotation (HideResult=true, Dialog(tab="Advanced"));

    equation
      phi_rel = flange_b.phi - flange_a.phi;
      w_rel = der(phi_rel);
      a_rel = der(w_rel);
      flange_b.tau = tau;
      flange_a.tau = -tau;
      annotation (Documentation(info="<html>
<p>
This is a 1-dim. rotational component with a compliant connection of two
rotational 1-dim. flanges where inertial effects between the two
flanges are neglected. The basic assumption is that the cut-torques
of the two flanges sum-up to zero, i.e., they have the same absolute value
but opposite sign: flange_a.tau + flange_b.tau = 0. This base class
is used to built up force elements such as springs, dampers, friction.
</p>

<p>
The relative angle and the relative speed are defined as preferred states.
The reason is that for some drive trains, such as drive
trains in vehicles, the absolute angle is quickly increasing during operation.
Numerically, it is better to use relative angles between drive train components
because they remain in a limited size. For this reason, StateSelect.prefer
is set for the relative angle of this component.
</p>

<p>
In order to improve the numerics, a nominal value for the relative angle
can be provided via parameter <b>phi_nominal</b> in the Advanced menu.
The default is 1e-4 rad since relative angles are usually
in this order and the step size control of an integrator would be
practically switched off, if a default of 1 rad would be used.
This nominal value might also be computed from other values, such
as \"phi_nominal = tau_nominal / c\" for a rotational spring, if tau_nominal
and c are more meaningful for the user.
</p>

<p>
See also the discussion
<a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.StateSelection\">State Selection</a>
in the User's Guide of the Rotational library.
</p>
</html>"));
    end PartialCompliantWithRelativeStates;

    partial model PartialElementaryOneFlangeAndSupport
      "Obsolete partial model. Use PartialElementaryOneFlangeAndSupport2."
      extends Modelica.Icons.ObsoleteModel;
      parameter Boolean useSupport=false
        "= true, if support flange enabled, otherwise implicitly grounded"
        annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      Flange_b flange "Flange of shaft" annotation (Placement(transformation(
              extent={{90,-10},{110,10}})));
      Support support if useSupport "Support/housing of component"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    protected
      Rotational.Interfaces.InternalSupport internalSupport(tau=-flange.tau)
        "Internal support/housing of component as a model with connector flange (flange is either connected to support, if useSupport=true, or connected to fixed, if useSupport=false)"
        annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
      Rotational.Components.Fixed fixed if not useSupport
        "Fixed support/housing, if not useSupport"
        annotation (Placement(transformation(extent={{10,-96},{30,-76}})));
    equation
      connect(internalSupport.flange, support) annotation (Line(
          points={{0,-80},{0,-100}}));
      connect(internalSupport.flange, fixed.flange) annotation (Line(
          points={{0,-80},{20,-80},{20,-86}}));
      annotation (
        Documentation(info="<html>
<p>
This is a 1-dim. rotational component with one flange and a support/housing.
It is used to build up elementary components of a drive train with
equations in the text layer.
</p>

<p>
If <i>useSupport=true</i>, the support connector is conditionally enabled
and needs to be connected.<br>
If <i>useSupport=false</i>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>
</html>"),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Text(
                  extent={{25,-97},{65,-98}},
                  lineColor={95,95,95},
                  textString="(if not useSupport)"),Text(
                  extent={{-38,-98},{-6,-96}},
                  lineColor={95,95,95},
                  textString="(if useSupport)")}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(
                  visible=not useSupport,
                  points={{-50,-120},{-30,-100}}),Line(
                  visible=not useSupport,
                  points={{-30,-120},{-10,-100}}),Line(
                  visible=not useSupport,
                  points={{-10,-120},{10,-100}}),Line(
                  visible=not useSupport,
                  points={{10,-120},{30,-100}}),Line(
                  visible=not useSupport,
                  points={{-30,-100},{30,-100}})}));
    end PartialElementaryOneFlangeAndSupport;

    partial model PartialElementaryOneFlangeAndSupport2
      "Partial model for a component with one rotational 1-dim. shaft flange and a support used for textual modeling, i.e., for elementary models"
      parameter Boolean useSupport=false
        "= true, if support flange enabled, otherwise implicitly grounded"
        annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      Flange_b flange "Flange of shaft" annotation (Placement(transformation(
              extent={{90,-10},{110,10}})));
      Support support(phi=phi_support, tau=-flange.tau) if useSupport
        "Support/housing of component"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    protected
      Modelica.SIunits.Angle phi_support "Absolute angle of support flange";
    equation
      if not useSupport then
        phi_support = 0;
      end if;
      annotation (Documentation(info="<html>
<p>
This is a 1-dim. rotational component with one flange and a support/housing.
It is used to build up elementary components of a drive train with
equations in the text layer.
</p>

<p>
If <i>useSupport=true</i>, the support connector is conditionally enabled
and needs to be connected.<br>
If <i>useSupport=false</i>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),graphics={Line(
                  visible=not useSupport,
                  points={{-50,-120},{-30,-100}}),Line(
                  visible=not useSupport,
                  points={{-30,-120},{-10,-100}}),Line(
                  visible=not useSupport,
                  points={{-10,-120},{10,-100}}),Line(
                  visible=not useSupport,
                  points={{10,-120},{30,-100}}),Line(
                  visible=not useSupport,
                  points={{-30,-100},{30,-100}})}));
    end PartialElementaryOneFlangeAndSupport2;

    partial model PartialElementaryTwoFlangesAndSupport
      "Obsolete partial model. Use PartialElementaryTwoFlangesAndSupport2."
      extends Modelica.Icons.ObsoleteModel;
      parameter Boolean useSupport=false
        "= true, if support flange enabled, otherwise implicitly grounded"
        annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      Flange_a flange_a "Flange of left shaft" annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Flange_b flange_b "Flange of right shaft" annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Support support if useSupport "Support/housing of component"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    protected
      Rotational.Interfaces.InternalSupport internalSupport(tau=-flange_a.tau
             - flange_b.tau)
        "Internal support/housing of component as a model with connector flange (flange is either connected to support, if useSupport=true, or connected to fixed, if useSupport=false)"
        annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
      Rotational.Components.Fixed fixed if not useSupport
        "Fixed support/housing, if not useSupport"
        annotation (Placement(transformation(extent={{10,-97},{30,-77}})));
    equation
      connect(internalSupport.flange, support) annotation (Line(
          points={{0,-80},{0,-100}}));
      connect(internalSupport.flange, fixed.flange) annotation (Line(
          points={{0,-80},{20,-80},{20,-87}}));
      annotation (
        Documentation(info="<html>
<p>
This is a 1-dim. rotational component with two flanges and a support/housing.
It is used to build up elementary components of a drive train with
equations in the text layer.
</p>

<p>
If <i>useSupport=true</i>, the support connector is conditionally enabled
and needs to be connected.<br>
If <i>useSupport=false</i>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>
</html>"),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Text(
                  extent={{24,-97},{64,-98}},
                  lineColor={95,95,95},
                  textString="(if not useSupport)"),Text(
                  extent={{-38,-98},{-6,-96}},
                  lineColor={95,95,95},
                  textString="(if useSupport)")}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(
                  visible=not useSupport,
                  points={{-50,-120},{-30,-100}}),Line(
                  visible=not useSupport,
                  points={{-30,-120},{-10,-100}}),Line(
                  visible=not useSupport,
                  points={{-10,-120},{10,-100}}),Line(
                  visible=not useSupport,
                  points={{10,-120},{30,-100}}),Line(
                  visible=not useSupport,
                  points={{-30,-100},{30,-100}})}));
    end PartialElementaryTwoFlangesAndSupport;

    partial model PartialElementaryTwoFlangesAndSupport2
      "Partial model for a component with two rotational 1-dim. shaft flanges and a support used for textual modeling, i.e., for elementary models"
      parameter Boolean useSupport=false
        "= true, if support flange enabled, otherwise implicitly grounded"
        annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      Flange_a flange_a "Flange of left shaft" annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Flange_b flange_b "Flange of right shaft" annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Support support(phi=phi_support, tau=-flange_a.tau - flange_b.tau) if
        useSupport "Support/housing of component"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    protected
      Modelica.SIunits.Angle phi_support "Absolute angle of support flange";
    equation
      if not useSupport then
        phi_support = 0;
      end if;

      annotation (Documentation(info="<html>
<p>
This is a 1-dim. rotational component with two flanges and a support/housing.
It is used to build up elementary components of a drive train with
equations in the text layer.
</p>

<p>
If <i>useSupport=true</i>, the support connector is conditionally enabled
and needs to be connected.<br>
If <i>useSupport=false</i>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),graphics={Line(
                  visible=not useSupport,
                  points={{-50,-120},{-30,-100}}),Line(
                  visible=not useSupport,
                  points={{-30,-120},{-10,-100}}),Line(
                  visible=not useSupport,
                  points={{-10,-120},{10,-100}}),Line(
                  visible=not useSupport,
                  points={{10,-120},{30,-100}}),Line(
                  visible=not useSupport,
                  points={{-30,-100},{30,-100}})}));
    end PartialElementaryTwoFlangesAndSupport2;

    partial model PartialElementaryRotationalToTranslational
      "Partial model to transform rotational into translational motion"
      parameter Boolean useSupportR=false
        "= true, if rotational support flange enabled, otherwise implicitly grounded"
        annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      parameter Boolean useSupportT=false
        "= true, if translational support flange enabled, otherwise implicitly grounded"
        annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      Rotational.Interfaces.Flange_a flangeR "Flange of rotational shaft"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Mechanics.Translational.Interfaces.Flange_b flangeT
        "Flange of translational rod" annotation (Placement(transformation(
              extent={{90,10},{110,-10}})));
      Rotational.Interfaces.Support supportR if useSupportR
        "Rotational support/housing of component" annotation (Placement(
            transformation(extent={{-110,-110},{-90,-90}}),
            iconTransformation(extent={{-110,-110},{-90,-90}})));
      Translational.Interfaces.Support supportT if useSupportT
        "Translational support/housing of component" annotation (Placement(
            transformation(extent={{110,-110},{90,-90}}),
            iconTransformation(extent={{90,-110},{110,-90}})));

    protected
      Rotational.Interfaces.InternalSupport internalSupportR(tau=-flangeR.tau)
        annotation (Placement(transformation(extent={{-110,-90},{-90,-70}})));
      Translational.Interfaces.InternalSupport internalSupportT(f=-flangeT.f)
        annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
      Rotational.Components.Fixed fixedR if not useSupportR
        annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
      Translational.Components.Fixed fixedT if not useSupportT
        annotation (Placement(transformation(extent={{70,-90},{90,-70}})));
    equation
      connect(internalSupportR.flange, supportR) annotation (Line(
          points={{-100,-80},{-100,-100}}));
      connect(internalSupportR.flange, fixedR.flange) annotation (Line(
          points={{-100,-80},{-80,-80}}));
      connect(fixedT.flange, internalSupportT.flange) annotation (Line(
          points={{80,-80},{100,-80}},
          color={0,127,0}));
      connect(internalSupportT.flange, supportT) annotation (Line(
          points={{100,-80},{100,-100}},
          color={0,127,0}));
      annotation (Documentation(info="<html>

<p>
This is a 1-dim. rotational component with
</p>

<ul>
<li> one rotational flange, </li>
<li> one rotational support/housing, </li>
<li> one translational flange, and </li>
<li> one translational support/housing </li>
</ul>

<p>
This model is used to build up elementary components of a drive train
transforming rotational into translational motion with
equations in the text layer.
</p>

<p>
If <i>useSupportR=true</i>, the rotational support connector is conditionally enabled
and needs to be connected.<br>
If <i>useSupportR=false</i>, the rotational support connector is conditionally disabled
and instead the rotational part is internally fixed to ground.<br>
If <i>useSupportT=true</i>, the translational support connector is conditionally enabled
and needs to be connected.<br>
If <i>useSupportT=false</i>, the translational support connector is conditionally disabled
and instead the translational part is internally fixed to ground.
</p>
</html>"), Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Line(
              visible=not useSupportT,
              points={{85,-110},{95,-100}}),
            Line(
              visible=not useSupportT,
              points={{95,-110},{105,-100}}),
            Line(
              visible=not useSupportT,
              points={{105,-110},{115,-100}}),
            Line(
              visible=not useSupportT,
              points={{85,-100},{115,-100}}),
            Line(
              visible=not useSupportR,
              points={{-115,-110},{-105,-100}}),
            Line(
              visible=not useSupportR,
              points={{-105,-110},{-95,-100}}),
            Line(
              visible=not useSupportR,
              points={{-95,-110},{-85,-100}}),
            Line(
              visible=not useSupportR,
              points={{-115,-100},{-85,-100}})}));
    end PartialElementaryRotationalToTranslational;

    partial model PartialTorque
      "Partial model of a torque acting at the flange (accelerates the flange)"
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
      Modelica.SIunits.Angle phi
        "Angle of flange with respect to support (= flange.phi - support.phi)";

    equation
      phi = flange.phi - phi_support;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Rectangle(
              extent={{-96,96},{96,-96}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,-62},{0,-100}}),
            Line(points={{-92,0},{-76,36},{-54,62},{-30,80},{-14,88},{10,92},{
                  26,90},{46,80},{64,62}}, smooth=Smooth.Bezier),
            Text(
              extent={{-150,140},{150,100}},
              lineColor={0,0,255},
              textString="%name"),
            Polygon(
              points={{94,16},{80,74},{50,52},{94,16}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{-58,-82},{-42,-68},{-20,-56},{0,-54},{18,-56},{34,-62},
                  {44,-72},{54,-82},{60,-94}}, smooth=Smooth.Bezier),
            Polygon(
              points={{-65,-98},{-46,-80},{-58,-72},{-65,-98}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(
              visible=not useSupport,
              points={{-50,-120},{-30,-100}}),
            Line(
              visible=not useSupport,
              points={{-30,-120},{-10,-100}}),
            Line(
              visible=not useSupport,
              points={{-10,-120},{10,-100}}),
            Line(
              visible=not useSupport,
              points={{10,-120},{30,-100}}),
            Line(
              visible=not useSupport,
              points={{-30,-100},{30,-100}})}), Documentation(info="<html>
<p>
Partial model of torque that accelerates the flange.
</p>

<p>
If <i>useSupport=true</i>, the support connector is conditionally enabled
and needs to be connected.<br>
If <i>useSupport=false</i>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>
</html>"));
    end PartialTorque;

    partial model PartialAbsoluteSensor
      "Partial model to measure a single absolute flange variable"
      extends Modelica.Icons.RotationalSensor;

      Flange_a flange
        "Flange of shaft from which sensor information shall be measured"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

    equation
      0 = flange.tau;
      annotation (Documentation(info="<html>
<p>
This is a partial model of a 1-dim. rotational component with one flange of a shaft
in order to measure an absolute kinematic quantity in the flange
and to provide the measured signal as output signal for further processing
with the blocks of package Modelica.Blocks.
</p>
</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Line(points={{-70.0,0.0},{-90.0,0.0}}),
        Line(points={{70.0,0.0},{100.0,0.0}},
          color={0,0,127}),
        Text(lineColor={0,0,255},
          extent={{-150.0,80.0},{150.0,120.0}},
          textString="%name")}));
    end PartialAbsoluteSensor;

    partial model PartialRelativeSensor
      "Partial model to measure a single relative variable between two flanges"
      extends Modelica.Icons.RotationalSensor;

      Flange_a flange_a "Left flange of shaft" annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Flange_b flange_b "Right flange of shaft" annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));

    equation
      0 = flange_a.tau + flange_b.tau;
      annotation (Documentation(info="<html>
<p>
This is a partial model for 1-dim. rotational components with two rigidly connected
flanges in order to measure relative kinematic quantities
between the two flanges or the cut-torque in the flange and
to provide the measured signal as output signal for further processing
with the blocks of package Modelica.Blocks.
</p>
</html>"), Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Line(points={{-70.0,0.0},{-90.0,0.0}}),
        Line(points={{70.0,0.0},{90.0,0.0}}),
        Text(lineColor={0,0,255},
          extent={{-150.0,73.0},{150.0,113.0}},
          textString="%name")}));
    end PartialRelativeSensor;

    partial model PartialFriction "Partial model of Coulomb friction elements"

      // parameter SI.AngularVelocity w_small=1 "Relative angular velocity near to zero (see model info text)";
      parameter SI.AngularVelocity w_small=1.0e10
        "Relative angular velocity near to zero if jumps due to a reinit(..) of the velocity can occur (set to low value only if such impulses can occur)"
        annotation (Dialog(tab="Advanced"));
      // Equations to define the following variables have to be defined in subclasses
      SI.AngularVelocity w_relfric
        "Relative angular velocity between frictional surfaces";
      SI.AngularAcceleration a_relfric
        "Relative angular acceleration between frictional surfaces";
      //SI.Torque tau "Friction torque (positive, if directed in opposite direction of w_rel)";
      SI.Torque tau0 "Friction torque for w_relfric=0 and forward sliding";
      SI.Torque tau0_max "Maximum friction torque for w_relfric=0 and locked";
      Boolean free "= true, if frictional element is not active";
      // Equations to define the following variables are given in this class
      Real sa(final unit="1")
        "Path parameter of friction characteristic tau = f(a_relfric)";
      Boolean startForward(start=false, fixed=true)
        "= true, if w_relfric=0 and start of forward sliding";
      Boolean startBackward(start=false, fixed=true)
        "= true, if w_relfric=0 and start of backward sliding";
      Boolean locked(start=false) "true, if w_rel=0 and not sliding";
      constant Integer Unknown=3 "Value of mode is not known";
      constant Integer Free=2 "Element is not active";
      constant Integer Forward=1 "w_relfric > 0 (forward sliding)";
      constant Integer Stuck=0
        "w_relfric = 0 (forward sliding, locked or backward sliding)";
      constant Integer Backward=-1 "w_relfric < 0 (backward sliding)";
      Integer mode(
        final min=Backward,
        final max=Unknown,
        start=Unknown,
        fixed=true)
        "Mode of friction (-1: backward sliding, 0: stuck, 1: forward sliding, 2: inactive, 3: unknown)";
    protected
      constant SI.AngularAcceleration unitAngularAcceleration=1
        annotation (HideResult=true);
      constant SI.Torque unitTorque=1 annotation (HideResult=true);
    equation
      /* Friction characteristic
   locked is introduced to help the Modelica translator determining
   the different structural configurations,
   if for each configuration special code shall be generated
*/
      startForward = pre(mode) == Stuck and (sa > tau0_max/unitTorque or pre(
        startForward) and sa > tau0/unitTorque) or pre(mode) == Backward and
        w_relfric > w_small or initial() and (w_relfric > 0);
      startBackward = pre(mode) == Stuck and (sa < -tau0_max/unitTorque or pre(
        startBackward) and sa < -tau0/unitTorque) or pre(mode) == Forward and
        w_relfric < -w_small or initial() and (w_relfric < 0);
      locked = not free and not (pre(mode) == Forward or startForward or pre(
        mode) == Backward or startBackward);

      a_relfric/unitAngularAcceleration = if locked then 0 else if free then sa
         else if startForward then sa - tau0_max/unitTorque else if
        startBackward then sa + tau0_max/unitTorque else if pre(mode) ==
        Forward then sa - tau0_max/unitTorque else sa + tau0_max/unitTorque;

      /* Friction torque has to be defined in a subclass. Example for a clutch:
   tau = if locked then sa else
         if free then   0 else
         cgeo*fn*(if startForward then          Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], w_relfric, 1) else
                  if startBackward then        -Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], -w_relfric, 1) else
                  if pre(mode) == Forward then  Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], w_relfric, 1) else
                                               -Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], -w_relfric, 1));
*/
      // finite state machine to determine configuration
      mode = if free then Free else (if (pre(mode) == Forward or pre(mode) ==
        Free or startForward) and w_relfric > 0 then Forward else if (pre(mode)
         == Backward or pre(mode) == Free or startBackward) and w_relfric < 0
         then Backward else Stuck);
      annotation (Documentation(info="<html>
<p>
Basic model for Coulomb friction that models the stuck phase in a reliable way.
</p>

<p>
This procedure is implemented in a \"clean\" way by state events and
leads to a mixed continuous/discrete systems of equations if friction elements
are dynamically coupled which have to be solved by appropriate
numerical methods. The method is described in
(see also a short sketch in <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\">UsersGuide.ModelingOfFriction</a>):
</p>
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><b>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</b>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>
</html>"));
    end PartialFriction;

    annotation (Documentation(info="<html>
<p>
This package contains connectors and partial models for 1-dim.
rotational mechanical components. The components of this package can
only be used as basic building elements for models.
</p>
</html>"));
  end Interfaces;

  package Icons "Icons for Rotational package"
    extends Modelica.Icons.IconsPackage;
    partial class Gear "Rotational gear icon"

      annotation (Icon(
          coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}}),
            graphics={
          Rectangle(
            origin={-35.0,60.0},
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-15.0,-40.0},{15.0,40.0}}),
          Rectangle(
            origin={-35.0,0.0},
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-15.0,-21.0},{15.0,21.0}}),
          Line(
            points={{-80.0,20.0},{-60.0,20.0}}),
          Line(
            points={{-80.0,-20.0},{-60.0,-20.0}}),
          Line(
            points={{-70.0,-20.0},{-70.0,-86.0}}),
          Line(
            points={{0.0,40.0},{0.0,-86.0}}),
          Line(
            points={{-10.0,40.0},{10.0,40.0}}),
          Line(
            points={{-10.0,80.0},{10.0,80.0}}),
          Line(
            points={{60.0,-20.0},{80.0,-20.0}}),
          Line(
            points={{60.0,20.0},{80.0,20.0}}),
          Line(
            points={{70.0,-20.0},{70.0,-86.0}}),
          Line(
            points={{70.0,-86.0},{-70.0,-86.0}}),
          Rectangle(
            origin={-75.0,0.0},
            lineColor={64,64,64},
            fillColor={191,191,191},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-25.0,-10.0},{25.0,10.0}}),
          Rectangle(
            origin={75.0,0.0},
            lineColor={64,64,64},
            fillColor={191,191,191},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-25.0,-10.0},{25.0,10.0}}),
          Rectangle(
            origin={-35.0,-19.0},
            fillColor={153,153,153},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-2.0},{15.0,2.0}}),
          Rectangle(
            origin={-35.0,-8.0},
            fillColor={204,204,204},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-3.0},{15.0,3.0}}),
          Rectangle(
            origin={-35.0,19.0},
            fillColor={204,204,204},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-2.0},{15.0,2.0}}),
          Rectangle(
            origin={-35.0,8.0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-3.0},{15.0,3.0}}),
          Rectangle(
            origin={0.0,60.0},
            lineColor={64,64,64},
            fillColor={191,191,191},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-20.0,-10.0},{20.0,10.0}}),
          Rectangle(
            origin={-35.0,98.0},
            fillColor={153,153,153},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-2.0},{15.0,2.0}}),
          Rectangle(
            origin={-35.0,87.0},
            fillColor={204,204,204},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-3.0},{15.0,3.0}}),
          Rectangle(
            origin={-35.0,50.0},
            fillColor={204,204,204},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-4.0},{15.0,4.0}}),
          Rectangle(
            origin={-35.0,22.0},
            fillColor={102,102,102},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-2.0},{15.0,2.0}}),
          Rectangle(
            origin={-35.0,33.0},
            fillColor={153,153,153},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-3.0},{15.0,3.0}}),
          Rectangle(
            origin={-35.0,70.0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-4.0},{15.0,4.0}}),
          Rectangle(
            origin={35.0,60.0},
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-15.0,-21.0},{15.0,21.0}}),
          Rectangle(
            origin={35.0,41.0},
            fillColor={153,153,153},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-2.0},{15.0,2.0}}),
          Rectangle(
            origin={35.0,52.0},
            fillColor={204,204,204},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-3.0},{15.0,3.0}}),
          Rectangle(
            origin={35.0,79.0},
            fillColor={204,204,204},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-2.0},{15.0,2.0}}),
          Rectangle(
            origin={35.0,68.0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-3.0},{15.0,3.0}}),
          Rectangle(
            origin={35.0,0.0},
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-15.0,-40.0},{15.0,40.0}}),
          Rectangle(
            origin={35.0,38.0},
            fillColor={153,153,153},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-2.0},{15.0,2.0}}),
          Rectangle(
            origin={35.0,27.0},
            fillColor={204,204,204},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-3.0},{15.0,3.0}}),
          Rectangle(
            origin={35.0,-10.0},
            fillColor={204,204,204},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-4.0},{15.0,4.0}}),
          Rectangle(
            origin={35.0,-38.0},
            fillColor={102,102,102},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-2.0},{15.0,2.0}}),
          Rectangle(
            origin={35.0,-27.0},
            fillColor={153,153,153},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-3.0},{15.0,3.0}}),
          Rectangle(
            origin={35.0,10.0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            extent={{-15.0,-4.0},{15.0,4.0}}),
          Rectangle(
            origin = {-35,40},
            fillColor = {255,255,255},
            extent = {{-15,-61},{15,60}}),
          Rectangle(
            origin = {35,21},
            fillColor = {255,255,255},
            extent = {{-15,-61},{15,60}})}), Documentation(
            info="<html>
<p>
This is the icon of a gear from the rotational package.
</p>
</html>"));
    end Gear;

    model Gearbox "Icon of gear box"

      annotation (Icon(
          coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
            preserveAspectRatio=true),
            graphics={
          Rectangle(origin={20.0,0.0},
            lineColor={64,64,64},
            fillColor={192,192,192},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-120.0,-10.0},{-80.0,10.0}}),
          Polygon(fillColor={192,192,192},
            fillPattern=FillPattern.HorizontalCylinder,
            points={{-60.0,10.0},{-60.0,20.0},{-40.0,40.0},{-40.0,-40.0},{-60.0,-20.0},{-60.0,10.0}}),
          Rectangle(lineColor={64,64,64},
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-40.0,-60.0},{40.0,60.0}},
            radius=10.0),
          Rectangle(lineColor={64,64,64},
            extent={{-40.0,-60.0},{40.0,60.0}},
            radius=10.0),
          Polygon(fillColor={192,192,192},
            fillPattern=FillPattern.HorizontalCylinder,
            points={{60.0,20.0},{40.0,40.0},{40.0,-40.0},{60.0,-20.0},{60.0,20.0}}),
          Rectangle(origin={-20.0,0.0},
            lineColor={64,64,64},
            fillColor={192,192,192},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{80.0,-10.0},{120.0,10.0}}),
          Polygon(origin={0.0,10.0},
            fillColor={64,64,64},
            fillPattern=FillPattern.Solid,
            points={{-60.0,-90.0},{-50.0,-90.0},{-20.0,-30.0},{20.0,-30.0},{48.0,-90.0},{60.0,-90.0},{60.0,-100.0},{-60.0,-100.0},{-60.0,-90.0}})}), Documentation(info="<html>
<p>
This is the icon of a gear box from the rotational package.
</p>
</html>"));

    end Gearbox;

    model Clutch "Icon of a clutch"

      annotation (Icon(graphics={
          Rectangle(  lineColor={64,64,64},
            fillColor={192,192,192},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100.0,-10.0},{-30.0,10.0}}),
          Rectangle(  lineColor={64,64,64},
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-30.0,-60.0},{-10.0,60.0}}),
          Rectangle(  lineColor={64,64,64},
            extent={{-30.0,-60.0},{-10.0,60.0}}),
          Rectangle(  lineColor={64,64,64},
            fillColor={255,255,255},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{10.0,-60.0},{30.0,60.0}}),
          Rectangle(  lineColor={64,64,64},
            extent={{10.0,-60.0},{30.0,60.0}}),
          Rectangle(  lineColor={64,64,64},
            fillColor={192,192,192},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{30.0,-10.0},{100.0,10.0}}),
          Polygon(  lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            points={{-30.0,40.0},{-60.0,50.0},{-60.0,30.0},{-30.0,40.0}}),
          Polygon(  lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            points={{30.0,40.0},{60.0,50.0},{60.0,30.0},{30.0,40.0}}),
          Line(  points={{0.0,90.0},{90.0,70.0},{90.0,40.0},{30.0,40.0}},
            color={0,0,127}),
          Line(  points={{0.0,90.0},{-90.0,70.0},{-90.0,40.0},{-30.0,40.0}},
            color={0,0,127})},
          coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
            preserveAspectRatio=true)),
          Documentation(info="<html>
<p>
This is the icon of a clutch from the rotational package.
</p>
</html>"));

    end Clutch;
    annotation (
      Documentation(info="<html>
<p>
This package contains icons for the Rotational library
(that is, all the components have only graphical annotations
without any equations).
</p>
</html>"));
  end Icons;
  annotation (Documentation(info="<html>

<p>
Library <b>Rotational</b> is a <b>free</b> Modelica package providing
1-dimensional, rotational mechanical components to model in a convenient way
drive trains with frictional losses. A typical, simple example is shown
in the next figure:
</p>

<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/driveExample.png\">

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
In 3.0, the bearing connector is renamed to \"<b>support</b>\" and this connector
is enabled via parameter \"useSupport\". If the support connector is enabled,
it must be connected, and if it is not enabled, it must not be connected.
</p>

<p>
In version 3.2 of the Modelica Standard Library, all <b>dissipative</b> components
of the Rotational library got an optional <b>heatPort</b> connector to which the
dissipated energy is transported in form of heat. This connector is enabled
via parameter \"useHeatPort\". If the heatPort connector is enabled,
it must be connected, and if it is not enabled, it must not be connected.
Independently, whether the heatPort is enabled or not,
the dissipated power is available from the new variable \"<b>lossPower</b>\" (which is
positive if heat is flowing out of the heatPort). For an example, see
<a href=\"modelica://Modelica.Mechanics.Rotational.Examples.HeatLosses\">Examples.HeatLosses</a>.
</p>

<p>
Copyright &copy; 1998-2016, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
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
