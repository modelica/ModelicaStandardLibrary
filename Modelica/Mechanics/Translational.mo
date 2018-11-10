within Modelica.Mechanics;
package Translational
  "Library to model 1-dimensional, translational mechanical systems"
  extends Modelica.Icons.Package;
  import SI = Modelica.SIunits;

  package UsersGuide "User's Guide of Translational Library"
    extends Modelica.Icons.Information;

    class Overview "Overview"
      extends Modelica.Icons.Information;

      annotation (DocumentationClass=true, Documentation(info="<html>

<p>
This package contains components to model <strong>1-dimensional translational
mechanical</strong> systems, including different types of masses,
external forces, spring/damper elements,
frictional elements, elastogaps, elements to measure position, velocity,
acceleration and the cut-force of a flange. In sublibrary
<strong>Examples</strong> several examples are present to demonstrate the usage of
the elements. Just open the corresponding example model and simulate
the model according to the provided description.
</p>
<p>
A unique feature of this library is the <strong>component-oriented</strong>
modeling of <strong>Coulomb friction</strong> elements, such as support friction.
Even (dynamically) coupled friction elements can be handled
<strong>without</strong> introducing stiffness which leads to fast simulations.
The underlying theory is new and is based on the solution of mixed
continuous/discrete systems of equations, i.e., equations where the
<strong>unknowns</strong> are of type <strong>Real</strong>, <strong>Integer</strong> or <strong>Boolean</strong>.
Provided appropriate numerical algorithms for the solution of such types of
systems are available in the simulation tool, the simulation of
(dynamically) coupled friction elements of this library is
<strong>efficient</strong> and <strong>reliable</strong>.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/drive1.png\" alt=\"drive1\">
</p>

<p>
A simple example of the usage of this library is given in the
figure above. This drive consists of a shaft with mass m1=1 which
is connected via a spring to a second shaft with mass m2=5.
The left shaft is driven via an external, sinusoidal force.
The <strong>filled</strong> and <strong>non-filled green squares</strong> at the left and
right side of a component represent <strong>mechanical flanges</strong>.
Drawing a line between such squares means that the corresponding
flanges are <strong>rigidly attached</strong> to each other.
By convention in this library, the connector characterized as a
<strong>filled</strong> green square is called <strong>flange_a</strong> and placed at the
left side of the component in the \"design view\" and the connector
characterized as a <strong>non-filled</strong> green square is called <strong>flange_b</strong>
and placed at the right side of the component in the \"design view\".
The two connectors are completely <strong>identical</strong>, with the only
exception that the graphical layout is a little bit different in order
to distinguish them for easier access of the connector variables.
For example, <code>m1.flange_a.f</code> is the cut-force in the connector
<code>flange_a</code> of component <code>m1</code>.
</p>
<p>
The components of this
library can be <strong>connected</strong> together in an <strong>arbitrary</strong> way. E.g., it is
possible to connect two springs or two shafts with mass directly
together, see figure below.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/driveConnections1.png\" alt=\"driveConnections1\"><br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/driveConnections2.png\" alt=\"driveConnections2\"><br>
</p>

</html>"));

    end Overview;

    class FlangeConnectors "Flange Connectors"
      extends Modelica.Icons.Information;

      annotation (DocumentationClass=true, Documentation(info="<html>
<p>
A flange is described by the connector class
Interfaces.<strong>Flange_a</strong>
or Interfaces.<strong>Flange_b</strong>. As already noted, the two connector
classes are completely identical. There is only a difference in the icons,
in order to easier identify a flange variable in a diagram.
Both connector classes contain the following variables:
</p>
<pre>
   Modelica.SIunits.Position   s \"Absolute position of flange\";
   <strong>flow</strong> Modelica.SIunits.Force f \"Cut-force in the flange\";
</pre>
<p>
If needed, the velocity <code>v</code> and the
acceleration <code>a</code> of a flange connector can be
determined by differentiation of the flange position <code>s</code>:
</p>
<pre>
     v = <strong>der</strong>(s);    a = <strong>der</strong>(v);
</pre>
</html>"));

    end FlangeConnectors;

    class SupportForces "Support Forces"
      extends Modelica.Icons.Information;

      annotation (DocumentationClass=true, Documentation(info="<html>

<p>The following figure shows examples of components equipped with
a support flange (framed flange in the lower center), which can be used
to fix components on the ground or on other moving elements or to combine
them with force elements. Via Boolean parameter <strong>useSupport</strong>, the
support flange is enabled or disabled. If it is enabled, it must be connected.
If it is disabled, it need not be connected.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/bearing.png\" alt=\"bearing\">
</p>

<p>
Depending on the setting of <strong>useSupport</strong>, the icon of the corresponding
component is changing, to either show the support flange or a ground mounting.
For example, the two implementations in the following figure give
identical results.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/bearing2.png\" alt=\"bearing2\">
</p>

</html>"));

    end SupportForces;

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

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/drive2.png\" alt=\"drive2\">
</p>

<p>
First, one has to define
a <strong>positive</strong> direction of this line, called <strong>axis of movement</strong>.
In the top part of the figure this is characterized by an arrow
defined as <code>axis of movement</code>. The simple rule is now:
If a variable of a component is positive and can be interpreted as
the element of a vector (e.g., force or velocity vector), the
corresponding vector is directed into the positive direction
of the axis of movement. In the following figure, the right-most
mass of the figure above is displayed with the positive
vector direction displayed according to this rule:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/drive3.png\" alt=\"drive3\">
</p>
<p>
The cut-force <code>m2.flange_a.f</code>
of the right mass is directed into the
direction of movement if the values are positive. Similarly,
the velocity <code>m2.v</code> of the right mass
is also directed into the
direction of movement if the values are positive
</p>
</html>"));

    end SignConventions;

    class UserDefinedComponents "User Defined Components"
      extends Modelica.Icons.Information;

      annotation (DocumentationClass=true, Documentation(info="<html>
<p>
In this section some hints are given to define your own
1-dimensional translational components which are compatible with the
elements of this package.
It is convenient to define a new
component by inheritance from one of the following base classes,
which are defined in sublibrary Interfaces:
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Name</th><th>Description</th></tr>
<tr>
  <td><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialCompliant\">PartialCompliant</a>
  </td>
  <td>Compliant connection of two translational 1-dim. flanges
                   (used for force laws such as a spring or a damper).</td>
</tr>

<tr>
  <td><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialCompliantWithRelativeStates\">PartialCompliantWithRelativeStates</a>
  </td>
  <td> Same as \"PartialCompliant\", but relative position and relative speed are
                    defined as preferred states. Use this partial model if the force law
                    needs anyway the relative speed. The advantage is that it is usually better
                    to use relative positions between drive train components
                    as states, especially, if the position is not limited.
</td>
</tr>

<tr>
  <td><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport2\">PartialElementaryTwoFlangesAndSupport2</a>
</td>
  <td> Partial model for a 1-dim. translational component consisting of the flange of
                    an input shaft, the flange of an output shaft and the support.
  </td>
</tr>

<tr>
  <td><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialForce\">PartialForce</a>
</td>
  <td> Partial model of a force acting at the flange (accelerates the flange).
  </td>
</tr>

<tr>
  <td><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialTwoFlanges\">PartialTwoFlanges</a>
</td>
  <td>General connection of two translational 1-dim. flanges.
  </td>
</tr>

<tr>
  <td><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialAbsoluteSensor\">PartialAbsoluteSensor</a>
</td>
  <td>Measure absolute flange variables.
  </td>
</tr>

<tr>
  <td><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialRelativeSensor\">PartialRelativeSensor</a>
</td>
  <td>Measure relative flange variables.
  </td>
</tr>
</table>

<p>
The difference between these base classes are the auxiliary
variables defined in the model and the relations between
the flange variables already defined in the base class.
For example, in model <strong>PartialCompliant</strong> there is no
support flange, whereas in model
<strong>PartialElementaryTwoFlangesAndSupport2</strong>
there is a support flange.
</p>
<p>
The equations of a mechanical component are vector equations, i.e.,
they need to be expressed in a common coordinate system.
Therefore, for a component a <strong>local axis of movement</strong> has to be
defined. All vector quantities, such as cut-forces or
velocities have to be expressed according to this definition.
Examples for such a definition are given in the following figure
for a mass component:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/driveAxis.png\" alt=\"driveAxis\">
</p>

<p>
As can be seen, all vectors are directed into the direction
of the movement axis. The positions in the flanges are defined
correspondingly.
</p>
<p>
On first view, one may assume that the selected local
coordinate system has an influence on the usage of the
component. But this is not the case, as shown in the next figure:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/masses.png\" alt=\"masses\">
</p>

<p>
In the figure the <strong>local</strong> axes of rotation of the components
are shown. The connection of two masses in the left and in the
right part of the figure are completely equivalent, i.e., the right
part is just a different drawing of the left part. This is due to the
fact, that by a connection, the two local coordinate systems are
made identical and the (automatically) generated connection equations
(= positions are identical, cut-forces sum-up to zero) are also
expressed in this common coordinate system. Therefore, even if in
the left figure it seems to be that the velocity vector of
<code>m2</code> goes from right to left, in reality it goes from
left to right as shown in the right part of the figure, where the
local coordinate systems are drawn such that they are aligned.
Note, that the simple rule stated in section 4 (Sign conventions)
also determines that
the velocity of <code>m2</code> in the left part of the
figure is directed from left to right.
</p>
<p>
To summarize, the local coordinate system selected for a component
is just necessary, in order that the equations of this component
are expressed correctly. The selection of the coordinate system
is arbitrary and has no influence on the usage of the component.
Especially, the actual direction of, e.g., a cut-force is most
easily determined by the rule of section 4. A more strict determination
by aligning coordinate systems and then using the vector direction
of the local coordinate systems, often requires a re-drawing of the
diagram and is therefore less convenient to use.
</p>
</html>"));

    end UserDefinedComponents;

    class StateSelection "State Selection"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
Only a few components of the Translational library use the der(..) operator
and are therefore candidates to have states. Most important, component <a href=\"modelica://Modelica.Mechanics.Translational.Components.Mass\">Mass</a>
defines the absolute position and the absolute velocity of this
component as candidate for states. In the \"Advanced\" menu the built-in StateSelect
enumeration can be set to define the priority to use these variables as states.
Without further action, in most cases a tool will select these variables as states.
</p>

<p>
For positioning drive trains where the goal is to position a load, the absolute positions of the components are bounded,
and the issue discussed below is not present.
</p>

<p>
For drive trains where the goal is to control the velocity of a load,
the absolute positions of the components are quickly increasing
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
drive train), since then the allowed error
also grows without bounds. The effect is that the error control on this variable is practically
switched off. The correct way to handle this would be to set reltol_i = 0 on such a state
variable and only use an absolute tolerance for the step size control.
</p>

<p>
Currently, in Modelica there is no possibility to provide this information.
In order to reduce this effect, it is advisable to not use absolute angles, but
relative angles as states. A user can define relative variables as states
explicitly with component
<a href=\"modelica://Modelica.Mechanics.Translational.Components.RelativeStates\">RelativeStates</a>.
Furthermore, all compliant components, such as
<a href=\"modelica://Modelica.Mechanics.Translational.Components.SpringDamper\">SpringDamper</a> are
defining the relative position and the relative velocity as preferred states.
Therefore, a tool will select in most cases relative positions as states.
</p>

<p>
The relative positions of compliant components are usually small.
Without further action, the error control would not work properly on variables
that are so small (so often switching the error control off). The remedy is to define
explicitly a nominal value on the relative angle. This definition is provided in the
\"Advanced\" menu of the compliant components with parameter \"s_nominal\".
The default value is 1e-4 m, to be in the order of a compliant deformation of a
drive.
</p>
</html>"));
    end StateSelection;

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
Germany<br>
email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a>
</p>

<h4>Contributors to this library</h4>

<ul>
<li> Main author until 2006:<br>
     Peter Beater<br>
     Universit&auml;t Paderborn, Abteilung Soest<br>
     Fachbereich Maschinenbau/Automatisierungstechnik<br>
     L&uuml;becker Ring 2<br>
     D 59494 Soest<br>
     Germany<br>
     email: <a href=\"mailto:info@beater.de\">info@beater.de</a>
     </li>
<li> <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> (DLR-RM)</li>
<li> Christian Schweiger (DLR-RM, until 2006).</li>
<li> <a href=\"https://www.haumer.at/\">Anton Haumer</a><br>
     Technical Consulting &amp; Electrical Engineering<br>
     D-93049 Regensburg, Germany<br>
     email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a></li>
</ul>
</html>"));
    end Contact;

    annotation (DocumentationClass=true, Documentation(info="<html>
<p>Library <strong>Translational</strong> is a <strong>free</strong> Modelica package providing 1-dimensional, translational mechanical components to model in a convenient way translational mechanical systems.
More details are given in the following sub-sections:
</p>

<ul>
<li> <a href=\"modelica://Modelica.Mechanics.Translational.UsersGuide.Overview\">Overview</a></li>
<li> <a href=\"modelica://Modelica.Mechanics.Translational.UsersGuide.FlangeConnectors\">Flange Connectors</a></li>
<li> <a href=\"modelica://Modelica.Mechanics.Translational.UsersGuide.SupportForces\">Support Forces</a></li>
<li> <a href=\"modelica://Modelica.Mechanics.Translational.UsersGuide.SignConventions\">Sign Conventions</a></li>
<li> <a href=\"modelica://Modelica.Mechanics.Translational.UsersGuide.UserDefinedComponents\">User Defined Components</a></li>
<li> <a href=\"modelica://Modelica.Mechanics.Translational.UsersGuide.StateSelection\">State Selection</a></li>
</ul>

</html>"));
  end UsersGuide;

  package Examples "Demonstration examples of the components of this package"

    extends Modelica.Icons.ExamplesPackage;

    model SignConvention "Examples for the used sign conventions"
      extends Modelica.Icons.Example;
      Translational.Components.Mass mass1(
        L=1,
        s(fixed=true),
        v(fixed=true),
        m=1) annotation (Placement(transformation(extent={{40,60},{60,80}})));
      Translational.Sources.Force force1 annotation (Placement(transformation(
              extent={{0,60},{20,80}})));
      Modelica.Blocks.Sources.Constant constant1(k=1) annotation (Placement(
            transformation(extent={{-40,60},{-20,80}})));
      Translational.Components.Mass mass2(
        L=1,
        s(fixed=true),
        v(fixed=true),
        m=1) annotation (Placement(transformation(extent={{40,0},{60,20}})));
      Translational.Sources.Force force2 annotation (Placement(transformation(
              extent={{0,20},{20,40}})));
      Modelica.Blocks.Sources.Constant constant2(k=1) annotation (Placement(
            transformation(extent={{-40,20},{-20,40}})));
      Translational.Components.Mass mass3(
        L=1,
        s(fixed=true),
        v(fixed=true),
        m=1) annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
      Translational.Sources.Force force3(useSupport=false)
                                                          annotation (Placement(
            transformation(extent={{20,-40},{0,-20}})));
      Modelica.Blocks.Sources.Constant constant3(k=1) annotation (Placement(
            transformation(extent={{60,-40},{40,-20}})));
      Translational.Components.Fixed fixed
        annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
    equation
      connect(constant1.y, force1.f)
        annotation (Line(points={{-19,70},{-2,70}}, color={0,0,127}));
      connect(constant2.y, force2.f)
        annotation (Line(points={{-19,30},{-2,30}}, color={0,0,127}));
      connect(constant3.y, force3.f)
        annotation (Line(points={{39,-30},{22,-30}}, color={0,0,127}));
      connect(force1.flange, mass1.flange_a) annotation (Line(
          points={{20,70},{40,70}}, color={0,127,0}));
      connect(force2.flange, mass2.flange_b) annotation (Line(
          points={{20,30},{70,30},{70,10},{60,10}}, color={0,127,0}));
      connect(mass3.flange_b, force3.flange) annotation (Line(
          points={{-20,-30},{0,-30}}, color={0,127,0}));
      connect(fixed.flange, force3.support) annotation (Line(
          points={{10,-50},{10,-40}}, color={0,127,0}));
      annotation (
        Documentation(info="<html>
<p>
If all arrows point in the same direction, a positive force
results in a positive acceleration&nbsp;<var>a</var>, velocity&nbsp;<var>v</var> and position&nbsp;<var>s</var>.
</p>
<p>
For a force of 1&nbsp;N and a mass of 1&nbsp;kg this leads to
</p>
<blockquote><pre>
a = 1 m/s2
v = 1 m/s after 1 s (SlidingMass1.v)
s = 0.5 m after 1 s (SlidingMass1.s)
</pre></blockquote>
<p>
The acceleration is not available for plotting.
</p>
<p>
System 1) and 2) are equivalent. It doesn't matter whether the
force pushes at flange_a in system&nbsp;1 or pulls at flange_b in system&nbsp;2.
</p><p>
It is of course possible to ignore the arrows and connect the models
in an arbitrary way. But then it is hard see in what direction the
force acts.
</p><p>
In the third system the two arrows are opposed which means that the
force acts in the opposite direction (in the same direction as in
the two other examples).
</p>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),graphics={Text(
                  extent={{-100,80},{-82,60}},
                  textString="1)",
                  lineColor={0,0,255}),Text(
                  extent={{-100,40},{-82,20}},
                  textString="2)",
                  lineColor={0,0,255}),Text(
                  extent={{-100,-20},{-82,-40}},
                  textString="3)",
                  lineColor={0,0,255})}),
        experiment(StopTime=1.0, Interval=0.001));
    end SignConvention;

    model InitialConditions "Setting of initial conditions"

      extends Modelica.Icons.Example;

      Translational.Components.Fixed fixed2(s0=1) annotation (Placement(
            transformation(extent={{-90,30},{-70,50}})));
      Translational.Components.Spring s2(s_rel0=2, c=1e3) annotation (Placement(
            transformation(extent={{-60,30},{-40,50}})));
      Translational.Components.Mass m3(
        L=3,
        s(start=4.5, fixed=true),
        v(fixed=true),
        m=1) annotation (Placement(transformation(extent={{-20,30},{0,50}})));
      Translational.Components.SpringDamper sd2(
        s_rel0=4,
        c=111,
        d=1) annotation (Placement(transformation(extent={{20,30},{40,50}})));
      Translational.Components.Mass m4(
        L=5,
        s(start=12.5, fixed=true),
        v(fixed=true),
        m=1) annotation (Placement(transformation(extent={{60,30},{80,50}})));

      Translational.Components.Fixed fixed1(s0=-1) annotation (Placement(
            transformation(extent={{-100,-70},{-80,-50}})));
      Translational.Components.Spring s1(
        s_rel0=1,
        c=1e3,
        s_rel(start=0.5, fixed=true)) annotation (Placement(transformation(
              extent={{-60,-70},{-40,-50}})));
      Translational.Components.Mass m1(
        L=1,
        v(fixed=true),
        m=1) annotation (Placement(transformation(extent={{-20,-70},{0,-50}})));
      Translational.Components.SpringDamper sd1(
        s_rel0=1,
        c=111,
        s_rel(start=1, fixed=true),
        v_rel(fixed=true),
        d=1) annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
      Translational.Components.Mass m2(L=2, m=1) annotation (Placement(
            transformation(extent={{60,-70},{80,-50}})));
    equation
      connect(s2.flange_a, fixed2.flange) annotation (Line(
          points={{-60,40},{-80,40}}, color={0,127,0}));
      connect(s1.flange_a, fixed1.flange) annotation (Line(
          points={{-60,-60},{-90,-60}}, color={0,127,0}));
      connect(m1.flange_a, s1.flange_b) annotation (Line(
          points={{-20,-60},{-40,-60}}, color={0,127,0}));
      connect(sd1.flange_a, m1.flange_b) annotation (Line(
          points={{20,-60},{0,-60}}, color={0,127,0}));
      connect(m2.flange_a, sd1.flange_b) annotation (Line(
          points={{60,-60},{40,-60}}, color={0,127,0}));
      connect(m4.flange_a, sd2.flange_b) annotation (Line(
          points={{60,40},{40,40}}, color={0,127,0}));
      connect(sd2.flange_a, m3.flange_b) annotation (Line(
          points={{20,40},{0,40}}, color={0,127,0}));
      connect(m3.flange_a, s2.flange_b) annotation (Line(
          points={{-20,40},{-40,40}}, color={0,127,0}));
      annotation (
        Documentation(info="<html>
<p>
There are several ways to set initial conditions.
In the first system the position of the mass m3 was defined
by using the modifier s(start=4.5), the position of m4 by s(start=12.5).
These positions were chosen such that the system is at rest. To calculate
these values start at the left (fixed2) with a value of 1&nbsp;m. The spring s2
has an unstretched length of 2&nbsp;m and m3 an length of 3&nbsp;m, which leads to
</p>

<blockquote><pre>
  1   m (fixed2)
+ 2   m (spring s2)
+ 3/2 m (half of the length of mass m3)
-------
  4,5 m = s(start = 4.5) for m3
+ 3/2 m (half of the length of mass m3)
+ 4   m (springDamper sd2)
+ 5/2 m (half of length of mass m4)
-------
 12,5 m = s(start = 12.5) for m4
</pre></blockquote>

<p>
This selection of initial conditions can prioritize the selection of
those variables (m3.s and m4.s) as state variables.
</p>

<p>
In the second example, the lengths of the springs are given start values
but they cannot be used as state for pure springs (only for the spring/damper
combination). In this case the system is not at rest.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/InitialConditions.png\">
</blockquote>

</html>"),
        experiment(StopTime=5.0, Interval=0.001),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={
            Line(points={{-80,58},{-80,46}}, color={0,0,255}),
            Text(
              extent={{-10,5},{10,-5}},
              lineColor={255,0,0},
              textString="ref= 0 m",
              origin={-96,73},
              rotation=90),
            Line(
              points={{-10,76},{-10,50}},
              color={0,0,255}),
            Text(
              extent={{-40,82},{-20,72}},
              lineColor={255,0,0},
              textString=" 4.5 m "),
            Line(
              points={{70,90},{70,50}},
              color={0,0,255}),
            Text(
              extent={{40,98},{60,88}},
              lineColor={255,0,0},
              textString="12.5 m"),
            Text(
              extent={{-60,16},{-40,6}},
              lineColor={0,0,255},
              textString="  2 m  "),
            Text(
              extent={{20,16},{40,6}},
              lineColor={0,0,255},
              textString="  4 m  "),
            Text(
              extent={{-20,16},{0,6}},
              textString="  3 m  "),
            Text(
              extent={{60,16},{80,6}},
              textString="  5 m  "),
            Text(
              extent={{-60,-84},{-40,-94}},
              lineColor={255,0,0},
              textString=" 0.5 m
 (1 m) "), Text(
              extent={{20,-84},{40,-94}},
              lineColor={255,0,0},
              textString=" 1 m
 (1 m) "), Text(
              extent={{-20,-84},{0,-94}},
              textString="  1 m  "),
            Text(
              extent={{60,-84},{80,-94}},
              textString="  2 m  "),
            Line(
              points={{-90,-32},{-90,-56}},
              color={0,0,255}),
            Text(
              extent={{-10,5},{10,-5}},
              lineColor={255,0,0},
              origin={-96,-35},
              rotation=90,
              textString="ref= -1 m"),
            Line(
              points={{-10,-32},{-10,-50}},
              color={0,0,255}),
            Text(
              extent={{-20,-22},{0,-32}},
              lineColor={0,0,255},
              textString="  0 m  "),
            Line(
              points={{70,-32},{70,-50}},
              color={0,0,255}),
            Text(
              extent={{20,-24},{40,-34}},
              lineColor={238,46,47},
              textString=" 2.5 m "),
            Line(
              points={{-90,54},{-80,54}},
              color={0,0,255},
              arrow={Arrow.None,Arrow.Open}),
            Line(
              points={{-90,70},{-10,70}},
              color={0,0,255},
              arrow={Arrow.None,Arrow.Open}),
            Line(
              points={{-90,86},{70,86}},
              color={0,0,255},
              arrow={Arrow.None,Arrow.Open}),
            Line(points={{-60,30},{-60,16}}, color={0,0,255}),
            Line(points={{-40,30},{-40,16}}, color={0,0,255}),
            Line(points={{-20,30},{-20,16}}, color={0,0,255}),
            Line(points={{0,30},{0,16}}, color={0,0,255}),
            Line(points={{20,30},{20,16}}, color={0,0,255}),
            Line(points={{40,30},{40,16}}, color={0,0,255}),
            Line(points={{60,30},{60,16}}, color={0,0,255}),
            Line(points={{80,30},{80,16}}, color={0,0,255}),
            Line(
              points={{-60,20},{-40,20}},
              color={0,0,255},
              arrow={Arrow.Open,Arrow.Open}),
            Line(
              points={{-20,20},{0,20}},
              color={0,0,255},
              arrow={Arrow.Open,Arrow.Open}),
            Line(
              points={{20,20},{40,20}},
              color={0,0,255},
              arrow={Arrow.Open,Arrow.Open}),
            Line(
              points={{60,20},{80,20}},
              color={0,0,255},
              arrow={Arrow.Open,Arrow.Open}),
            Line(
              points={{-90,90},{-90,46}},
              color={0,0,255}),
            Text(
              extent={{-90,66},{-70,56}},
              lineColor={255,0,0},
              textString="1 m "),
            Line(
              points={{-60,-70},{-60,-84}},
              color={0,0,255}),
            Line(
              points={{-40,-70},{-40,-84}},
              color={0,0,255}),
            Line(
              points={{-20,-70},{-20,-84}},
              color={0,0,255}),
            Line(
              points={{0,-70},{0,-84}},
              color={0,0,255}),
            Line(
              points={{20,-70},{20,-84}},
              color={0,0,255}),
            Line(
              points={{40,-70},{40,-84}},
              color={0,0,255}),
            Line(
              points={{60,-70},{60,-84}},
              color={0,0,255}),
            Line(
              points={{80,-70},{80,-84}},
              color={0,0,255}),
            Line(
              points={{-60,-80},{-40,-80}},
              color={0,0,255},
              arrow={Arrow.Open,Arrow.Open}),
            Line(
              points={{-20,-80},{0,-80}},
              color={0,0,255},
              arrow={Arrow.Open,Arrow.Open}),
            Line(
              points={{20,-80},{40,-80}},
              color={0,0,255},
              arrow={Arrow.Open,Arrow.Open}),
            Line(
              points={{60,-80},{80,-80}},
              color={0,0,255},
              arrow={Arrow.Open,Arrow.Open}),
            Line(
              points={{-90,-36},{-10,-36}},
              color={0,0,255},
              arrow={Arrow.Open,Arrow.Open}),
            Line(
              points={{-10,-36},{70,-36}},
              color={0,0,255},
              arrow={Arrow.Open,Arrow.Open}),
            Text(
              extent={{-60,-24},{-40,-34}},
              lineColor={238,46,47},
              textString="1 m ")}));
    end InitialConditions;

    model WhyArrows "Use of arrows in Mechanics.Translational"

      extends Modelica.Icons.Example;

      Translational.Components.Fixed fixed annotation (Placement(transformation(
              extent={{-20,20},{0,40}})));
      Translational.Components.Rod rod1(L=1) annotation (Placement(
            transformation(extent={{-48,20},{-28,40}})));
      Translational.Components.Rod rod2(L=1) annotation (Placement(
            transformation(extent={{20,20},{40,40}})));
      Translational.Components.Rod rod3(L=1) annotation (Placement(
            transformation(extent={{-30,58},{-50,78}})));
      Translational.Sensors.PositionSensor positionSensor2 annotation (
          Placement(transformation(extent={{60,20},{80,40}})));
      Translational.Sensors.PositionSensor positionSensor1 annotation (
          Placement(transformation(extent={{-60,20},{-80,40}})));
      Translational.Sensors.PositionSensor positionSensor3 annotation (
          Placement(transformation(extent={{-60,58},{-80,78}})));
      Translational.Components.Fixed fixed1(s0=-1.9) annotation (Placement(
            transformation(extent={{-100,-60},{-80,-40}})));
      Translational.Components.Spring spring1(s_rel0=2, c=11) annotation (
          Placement(transformation(extent={{-80,-60},{-60,-40}})));
      Translational.Components.Mass mass1(
        L=2,
        s(fixed=true),
        v(fixed=true),
        m=1) annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
      Translational.Components.Fixed fixed2(s0=-1.9) annotation (Placement(
            transformation(extent={{0,-60},{20,-40}})));
      Translational.Components.Spring spring2(s_rel0=2, c=11) annotation (
          Placement(transformation(extent={{30,-60},{50,-40}})));
      Translational.Components.Mass inertia2(
        L=2,
        m=1,
        s(fixed=true),
        v(fixed=true)) annotation (Placement(transformation(extent={{80,-60},{
                60,-40}})));
    equation
      connect(spring1.flange_b, mass1.flange_b) annotation (Line(points={{-60,-50},
              {-60,-72},{-30,-72},{-30,-50}}, color={0,127,0}));
      connect(spring2.flange_b, inertia2.flange_b)
        annotation (Line(points={{50,-50},{60,-50}}, color={0,127,0}));
      connect(rod3.flange_b, positionSensor3.flange) annotation (Line(
          points={{-50,68},{-60,68}}, color={0,127,0}));
      connect(rod1.flange_a, positionSensor1.flange) annotation (Line(
          points={{-48,30},{-60,30}}, color={0,127,0}));
      connect(rod1.flange_b, fixed.flange) annotation (Line(
          points={{-28,30},{-10,30}}, color={0,127,0}));
      connect(rod3.flange_a, fixed.flange) annotation (Line(
          points={{-30,68},{-10,68},{-10,30}}, color={0,127,0}));
      connect(fixed.flange, rod2.flange_a) annotation (Line(
          points={{-10,30},{20,30}}, color={0,127,0}));
      connect(rod2.flange_b, positionSensor2.flange) annotation (Line(
          points={{40,30},{60,30}}, color={0,127,0}));
      connect(fixed1.flange, spring1.flange_a) annotation (Line(
          points={{-90,-50},{-80,-50}}, color={0,127,0}));
      connect(fixed2.flange, spring2.flange_a) annotation (Line(
          points={{10,-50},{30,-50}}, color={0,127,0}));
      annotation (
        Documentation(info="<html>
<p>
When using the models of the translational sublibrary
it is recommended to make sure that all arrows point in
the same direction because then all component have the
same reference system.
In the example the distance from flange_a of Rod1 to flange_b
of Rod2 is 2&nbsp;m. The distance from flange_a of Rod1 to flange_b
of Rod3 is also 2&nbsp;m though it is difficult to see that. Without
the arrows it would be almost impossible to notice.
That all arrows point in the same direction is a sufficient
condition for an easy use of the library. There are cases
where horizontally flipped models can be used without
problems.
</p>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Text(
                  extent={{-84,10},{88,2}},
                  lineColor={0,0,255},
                  textString="positionSensor2.s = positionSensor3.s"),Text(
                  extent={{-78,-4},{86,-12}},
                  lineColor={0,0,255},
                  textString="positionSensor3.s <>positionSensor1.s"),Text(
                  extent={{-82,-80},{92,-88}},
                  textString="Both systems are equivalent",
                  lineColor={0,0,255}),Line(
                  points={{-90,-28},{90,-28}},
                  thickness=0.5,
                  color={0,0,255})}),
        experiment(StopTime=1.0, Interval=0.001));
    end WhyArrows;

    model Accelerate "Use of model accelerate"

      extends Modelica.Icons.Example;
      Translational.Sources.Accelerate accelerate annotation (Placement(
            transformation(extent={{-10,-10},{10,10}})));
      Translational.Components.Mass mass(L=1, m=1) annotation (Placement(
            transformation(extent={{30,-10},{50,10}})));
      Modelica.Blocks.Sources.Constant constantAcc(k=1) annotation (Placement(
            transformation(extent={{-50,-10},{-30,10}})));
    equation
      connect(accelerate.flange, mass.flange_a) annotation (Line(
          points={{10,0},{30,0}},   color={0,127,0}));
      connect(constantAcc.y, accelerate.a_ref) annotation (Line(
          points={{-29,0},{-12,0}},   color={0,0,127}));
      annotation (Documentation(info="<html>
<p>
Demonstrate usage of component
<a href=\"modelica://Modelica.Mechanics.Translational.Sources.Accelerate\">Sources.Accelerate</a>
by moving a mass with a predefined acceleration.
</p>
</html>"), experiment(StopTime=1.0, Interval=0.001));
    end Accelerate;

    model Damper "Use of damper models"

      extends Modelica.Icons.Example;

      Translational.Components.Mass mass1(
        L=1,
        s(start=3, fixed=true),
        v(start=10, fixed=true),
        m=1) annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
      Translational.Components.Damper damper1(d=25) annotation (Placement(
            transformation(extent={{-10,50},{10,70}})));
      Translational.Components.Fixed fixed1(s0=4.5) annotation (Placement(
            transformation(extent={{30,50},{50,70}})));
      Translational.Components.Mass mass2(
        L=1,
        s(start=3, fixed=true),
        v(start=10, fixed=true),
        m=1) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Translational.Components.Damper damper2(d=25) annotation (Placement(
            transformation(extent={{-10,0},{10,20}})));
      Translational.Components.Fixed fixed2(s0=4.5) annotation (Placement(
            transformation(extent={{30,-10},{50,10}})));
      Translational.Components.Mass mass3(
        L=1,
        s(start=3, fixed=true),
        v(start=10, fixed=true),
        m=1) annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
      Translational.Components.Fixed fixed3(s0=4.5) annotation (Placement(
            transformation(extent={{30,-70},{50,-50}})));
      Translational.Components.Spring spring2(s_rel0=1, c=1) annotation (
          Placement(transformation(extent={{-10,-20},{10,0}})));
      Translational.Components.SpringDamper springDamper3(
        s_rel0=1,
        d=25,
        c=1) annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
    equation
      connect(mass1.flange_b, damper1.flange_a)
        annotation (Line(points={{-40,60},{-10,60}}, color={0,127,0}));
      connect(mass2.flange_b, damper2.flange_a)
        annotation (Line(points={{-40,0},{-20,0},{-20,10},{-10,10}},
                                                     color={0,127,0}));
      connect(damper2.flange_b, spring2.flange_b)
        annotation (Line(points={{10,10},{20,10},{20,-10},{10,-10}},
                                                  color={0,127,0}));
      connect(damper2.flange_a, spring2.flange_a)
        annotation (Line(points={{-10,10},{-20,10},{-20,-10},{-10,-10}},
                                                      color={0,127,0}));
      connect(mass3.flange_b, springDamper3.flange_a)
        annotation (Line(points={{-40,-60},{-10,-60}}, color={0,127,0}));
      connect(damper1.flange_b, fixed1.flange) annotation (Line(
          points={{10,60},{40,60}},color={0,127,0}));
      connect(damper2.flange_b, fixed2.flange) annotation (Line(points={{10,10},{20,10},{20,0},{40,0}},
                                                                                         color={0,127,0}));
      connect(springDamper3.flange_b, fixed3.flange) annotation (Line(
          points={{10,-60},{40,-60}},color={0,127,0}));
      annotation (Documentation(info="<html>
<p>
Demonstrate usage of a translational damper component in various configurations.
</p>
</html>"), experiment(StopTime=1.0, Interval=0.001));
    end Damper;

    model Oscillator "Oscillator demonstrates the use of initial conditions"

      extends Modelica.Icons.Example;

      Translational.Components.Mass mass1(
        L=1,
        s(start=-0.5, fixed=true),
        v(start=0, fixed=true),
        m=1) annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      Translational.Components.Spring spring1(s_rel0=1, c=10000) annotation (
          Placement(transformation(extent={{20,20},{40,40}})));
      Translational.Components.Fixed fixed1(s0=1) annotation (Placement(
            transformation(extent={{60,20},{80,40}})));
      Translational.Sources.Force force1 annotation (Placement(transformation(
              extent={{-60,20},{-40,40}})));
      Modelica.Blocks.Sources.Sine sine1(freqHz=15.9155) annotation (Placement(
            transformation(extent={{-100,20},{-80,40}})));
      Translational.Components.Mass mass2(
        L=1,
        s(start=-0.5, fixed=true),
        v(start=0, fixed=true),
        m=1) annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      Translational.Components.Spring spring2(s_rel0=1, c=10000) annotation (
          Placement(transformation(extent={{20,-50},{40,-30}})));
      Translational.Components.Fixed fixed2(s0=1) annotation (Placement(
            transformation(extent={{60,-40},{80,-20}})));
      Translational.Sources.Force force2 annotation (Placement(transformation(
              extent={{-60,-40},{-40,-20}})));
      Modelica.Blocks.Sources.Sine sine2(freqHz=15.9155) annotation (Placement(
            transformation(extent={{-100,-40},{-80,-20}})));
      Translational.Components.Damper damper1(d=10) annotation (Placement(
            transformation(extent={{20,-30},{40,-10}})));
    equation
      connect(mass1.flange_b, spring1.flange_a)
        annotation (Line(points={{0,30},{20,30}}, color={0,127,0}));
      connect(spring2.flange_a, damper1.flange_a)
        annotation (Line(points={{20,-40},{10,-40},{10,-20},{20,-20}},
                                                     color={0,127,0}));
      connect(mass2.flange_b, spring2.flange_a)
        annotation (Line(points={{0,-30},{10,-30},{10,-40},{20,-40}},
                                                    color={0,127,0}));
      connect(damper1.flange_b, spring2.flange_b)
        annotation (Line(points={{40,-20},{50,-20},{50,-40},{40,-40}},
                                                     color={0,127,0}));
      connect(sine1.y, force1.f)
        annotation (Line(points={{-79,30},{-62,30}}, color={0,0,127}));
      connect(sine2.y, force2.f)
        annotation (Line(points={{-79,-30},{-62,-30}}, color={0,0,127}));
      connect(spring1.flange_b, fixed1.flange) annotation (Line(
          points={{40,30},{70,30}}, color={0,127,0}));
      connect(force2.flange, mass2.flange_a) annotation (Line(
          points={{-40,-30},{-20,-30}}, color={0,127,0}));
      connect(force1.flange, mass1.flange_a) annotation (Line(
          points={{-40,30},{-20,30}}, color={0,127,0}));
      connect(spring2.flange_b, fixed2.flange) annotation (Line(
          points={{40,-40},{50,-40},{50,-30},{70,-30}},
                                      color={0,127,0}));
      annotation (Documentation(info="<html>
<p>
A spring - mass system is a mechanical oscillator. If no
damping is included and the system is excited at resonance
frequency infinite amplitudes will result.
The resonant frequency is given by
omega_res&nbsp;=&nbsp;sqrt(c&nbsp;/&nbsp;m)
with:
</p>

<blockquote><pre>
c ... spring stiffness
m ... mass
</pre></blockquote>

<p>
To make sure that the system is initially at rest the initial
conditions s(start=-0.5) and v(start=0) for the sliding masses
are set.
If damping is added the amplitudes are bounded.
</p>
</html>"), experiment(StopTime=1.0, Interval=0.001));
    end Oscillator;

    model Sensors "Sensors for translational systems"
      extends Modelica.Icons.Example;

      Translational.Sensors.ForceSensor forceSensor annotation (Placement(
            transformation(extent={{-40,10},{-20,30}})));
      Modelica.Mechanics.Translational.Sensors.MultiSensor multiSensor
        annotation (Placement(transformation(extent={{-10,10},{10,30}})));
      Translational.Sensors.SpeedSensor speedSensor1 annotation (Placement(
            transformation(extent={{60,-50},{80,-30}})));
      Translational.Sensors.PositionSensor positionSensor1 annotation (
          Placement(transformation(extent={{60,-20},{80,0}})));
      Translational.Sensors.AccSensor accSensor1 annotation (Placement(
            transformation(extent={{60,-80},{80,-60}})));
      Translational.Sensors.PositionSensor positionSensor2 annotation (
          Placement(transformation(extent={{60,10},{80,30}})));
      Translational.Components.Mass mass(
        L=1,
        s(fixed=true),
        v(fixed=true),
        m=1) annotation (Placement(transformation(extent={{30,10},{50,30}})));
      Translational.Sources.Force force annotation (Placement(transformation(
              extent={{-70,10},{-50,30}})));
      Modelica.Blocks.Sources.Sine sineForce(amplitude=10, freqHz=4)
        annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
    equation
      connect(sineForce.y, force.f)
        annotation (Line(points={{-79,20},{-72,20}}, color={0,0,127}));
      connect(forceSensor.flange_a, force.flange) annotation (Line(
          points={{-40,20},{-50,20}}, color={0,127,0}));
      connect(mass.flange_a, positionSensor1.flange) annotation (Line(
          points={{30,20},{20,20},{20,-10},{60,-10}},
                                            color={0,127,0}));
      connect(mass.flange_a, speedSensor1.flange) annotation (Line(
          points={{30,20},{20,20},{20,-40},{60,-40}},
                                              color={0,127,0}));
      connect(mass.flange_a, accSensor1.flange) annotation (Line(
          points={{30,20},{20,20},{20,-70},{60,-70}},
                                              color={0,127,0}));
      connect(mass.flange_b, positionSensor2.flange) annotation (Line(
          points={{50,20},{60,20}}, color={0,127,0}));
      connect(forceSensor.flange_b, multiSensor.flange_a) annotation (Line(
          points={{-20,20},{-10,20}},color={0,127,0}));
      connect(multiSensor.flange_b, mass.flange_a) annotation (Line(
          points={{10,20},{30,20}}, color={0,127,0}));
      annotation (Documentation(info="<html>
<p>
These sensors measure
</p>

<blockquote><pre>
force f in N
position s in m
velocity v in m/s
acceleration a in m/s2
</pre></blockquote>

<p>
In this example, the measured velocity and acceleration is independent of
the flange the sensor is connected to. In contrast, the measured position
depends on the flange (flange_a or flange_b) and the
length&nbsp;<var>L</var> of the component.
Plot <code>positionSensor1.s</code>, <code>positionSensor2.s</code> and <code>mass.s</code>
to see the difference.
</p>
</html>"), experiment(StopTime=1.0, Interval=0.001));
    end Sensors;

    model Friction "Use of model Stop"
      extends Modelica.Icons.Example;
      Modelica.Mechanics.Translational.Components.MassWithStopAndFriction stop1(
        L=1,
        s(fixed=true),
        v(fixed=true),
        smax=25,
        smin=-25,
        m=1,
        F_prop=1,
        F_Coulomb=5,
        F_Stribeck=10,
        fexp=2) annotation (Placement(transformation(extent={{20,60},{40,80}})));
      Translational.Sources.Force force annotation (Placement(transformation(
              extent={{-20,60},{0,80}})));
      Modelica.Blocks.Sources.Sine sineForce(amplitude=25, freqHz=0.25)
        annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
      Modelica.Mechanics.Translational.Components.MassWithStopAndFriction stop2(
        L=1,
        smax=0.9,
        smin=-0.9,
        F_Coulomb=3,
        F_Stribeck=5,
        s(start=0, fixed=true),
        m=1,
        F_prop=1,
        fexp=2,
        v(start=-5, fixed=true)) annotation (Placement(transformation(extent={{38,-60},{58,-40}})));
      Translational.Components.Spring spring(s_rel0=1, c=500) annotation (
          Placement(transformation(extent={{0,-60},{20,-40}})));
      Translational.Components.Fixed fixed2(s0=-1.75) annotation (Placement(
            transformation(extent={{-40,-60},{-20,-40}})));
      Translational.Sources.Force force2 annotation (Placement(transformation(
              extent={{-20,0},{0,20}})));
      Components.Mass mass(
        m=1,
        L=1,
        s(fixed=true),
        v(fixed=true))
        annotation (Placement(transformation(extent={{10,0},{30,20}})));
      Components.SupportFriction supportFriction(f_pos=Examples.Utilities.GenerateStribeckFrictionTable(
                F_prop=1,
                F_Coulomb=5,
                F_Stribeck=10,
                fexp=2,
                v_max=12,
                nTable=50))
        annotation (Placement(transformation(extent={{40,0},{60,20}})));
    equation
      connect(spring.flange_b, stop2.flange_a)
        annotation (Line(points={{20,-50},{38,-50}}, color={0,127,0}));
      connect(sineForce.y, force.f)
        annotation (Line(points={{-39,70},{-22,70}}, color={0,0,127}));
      connect(spring.flange_a, fixed2.flange) annotation (Line(
          points={{0,-50},{-30,-50}}, color={0,127,0}));
      connect(force.flange, stop1.flange_a) annotation (Line(
          points={{0,70},{20,70}}, color={0,127,0}));
      connect(force2.flange, mass.flange_a) annotation (Line(
          points={{0,10},{10,10}},  color={0,127,0}));
      connect(mass.flange_b, supportFriction.flange_a) annotation (Line(
          points={{30,10},{40,10}}, color={0,127,0}));
      connect(sineForce.y, force2.f) annotation (Line(
          points={{-39,70},{-30,70},{-30,10},{-22,10}}, color={0,0,127}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Text(
                  extent={{-100,80},{-80,60}},
                  textString="1)",
                  lineColor={0,0,255}),Text(
                  extent={{-100,20},{-80,0}},
                  textString="2)",
                  lineColor={0,0,255}),Text(
                  extent={{-100,-40},{-80,-60}},
                  lineColor={0,0,255},
                  textString="3)")}),
        Documentation(info="<html>
<ol>
<li> Simulate and then plot stop1.f as a function of stop1.v
     This gives the Stribeck curve.</li>
<li> The same model is also available by modeling the system with a Mass and
     a SupportFriction model. The SupportFriction model defines the friction characteristic
     with a table. The table is constructed with function
     Examples.Utilities.GenerateStribeckFrictionTable(..) to generate the
     same friction characteristic as with stop1.
     The simulation results of stop1 and of model mass are therefore identical.</li>
<li> Model stop2 gives an example for a hard stop. However there
     can arise some problems with the used modeling approach (use of
     <strong>reinit</strong>(..), convergence problems). In this case use the ElastoGap
     to model a stop (see example Preload).</li>
</ol>
</html>"),
        experiment(StopTime=5.0, Interval=0.001));
    end Friction;

    model PreLoad "Preload of a spool using ElastoGap models"

      extends Modelica.Icons.Example;

      Translational.Components.ElastoGap innerContactA(
        c=1000e3,
        d=250,
        s_rel0=0.001) annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
      Translational.Components.ElastoGap innerContactB(
        c=1000e3,
        d=250,
        s_rel0=0.001) annotation (Placement(transformation(extent={{50,0},{70,20}})));
      Translational.Components.Mass spool(
        L=0.19,
        m=0.150,
        s(start=0.01475, fixed=true),
        v(fixed=true)) annotation (Placement(transformation(extent={{10,-70},{50,-30}})));
      Translational.Components.Fixed fixedLe(s0=-0.0955) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-90,70})));
      Translational.Components.Mass springPlateA(
        m=10e-3,
        L=0.002,
        s(start=-0.093, fixed=true),
        v(fixed=true)) annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
      Translational.Components.Mass springPlateB(
        m=10e-3,
        s(start=-0.06925, fixed=true),
        L=0.002,
        v(fixed=true)) annotation (Placement(transformation(extent={{20,40},{40,60}})));
      Translational.Components.Spring spring(c=20e3, s_rel0=0.025) annotation (
          Placement(transformation(extent={{-10,40},{10,60}})));
      Translational.Components.ElastoGap outerContactA(
        c=1000e3,
        d=250,
        s_rel0=0.0015) annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
      Translational.Components.ElastoGap outerContactB(
        c=1000e3,
        d=250,
        s_rel0=0.0015) annotation (Placement(transformation(extent={{50,40},{70,60}})));
      Translational.Components.Rod rod1(L=0.007) annotation (Placement(
            transformation(extent={{-40,10},{-20,30}})));
      Translational.Components.Damper friction(d=2500) annotation (Placement(
            transformation(
            origin={-80,30},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Translational.Sources.Force force annotation (Placement(transformation(
              extent={{-38,-60},{-18,-40}})));
      Translational.Components.Rod housing(L=0.0305) annotation (Placement(
            transformation(extent={{-10,60},{10,80}})));
      Translational.Components.Rod rod3(L=0.00575) annotation (Placement(
            transformation(extent={{-40,-20},{-20,0}})));
      Translational.Components.Rod rod4(L=0.00575) annotation (Placement(
            transformation(extent={{20,-20},{40,0}})));
      Translational.Components.Rod rod2(L=0.007) annotation (Placement(
            transformation(extent={{20,10},{40,30}})));
      Modelica.Blocks.Sources.Sine sineForce(amplitude=150, freqHz=0.01)
        annotation (Placement(transformation(extent={{-78,-60},{-58,-40}})));
    equation
      connect(outerContactA.flange_b, springPlateA.flange_a)
        annotation (Line(points={{-50,50},{-40,50}}, color={0,127,0}));
      connect(springPlateA.flange_b, spring.flange_a) annotation (Line(points={{-20,50},{-10,50}},
                                           color={0,127,0}));
      connect(spring.flange_b, springPlateB.flange_a)
        annotation (Line(points={{10,50},{20,50}}, color={0,127,0}));
      connect(springPlateB.flange_b, outerContactB.flange_a)
        annotation (Line(points={{40,50},{50,50}},         color={0,127,0}));
      connect(outerContactB.flange_b, housing.flange_b)
        annotation (Line(points={{70,50},{80,50},{80,70},{10,70}},
                                                           color={0,127,0}));
      connect(springPlateA.flange_b, rod1.flange_a) annotation (Line(points={{-20,50},{-20,32},{-40,32},{-40,20}},
                                               color={0,127,0}));
      connect(innerContactA.flange_a, rod3.flange_a) annotation (Line(points={{-70,10},{-80,10},{-80,-10},{-40,-10}},
                                                 color={0,127,0}));
      connect(innerContactA.flange_b, rod1.flange_b) annotation (Line(points={{-50,10},{-20,10},{-20,20}},
                                          color={0,127,0}));
      connect(rod2.flange_a, innerContactB.flange_a)
        annotation (Line(points={{20,20},{20,10},{50,10}}, color={0,127,0}));
      connect(rod4.flange_b, innerContactB.flange_b)
        annotation (Line(points={{40,-10},{80,-10},{80,10},{70,10}},
                                                         color={0,127,0}));
      connect(friction.flange_b, rod3.flange_a)
        annotation (Line(points={{-80,20},{-80,-10},{-40,-10}},
                                                            color={0,127,0}));
      connect(rod3.flange_b, rod4.flange_a)
        annotation (Line(points={{-20,-10},{20,-10}},
                                                  color={0,127,0}));
      connect(rod2.flange_b, springPlateB.flange_a) annotation (Line(points={{40,20},{40,32},{20,32},{20,50}},
                                               color={0,127,0}));
      connect(spool.flange_a, rod4.flange_a)
        annotation (Line(points={{10,-50},{0,-50},{0,-10},{20,-10}},
                                                        color={0,127,0}));
      connect(sineForce.y, force.f) annotation (Line(points={{-57,-50},{-40,-50}},
                          color={0,0,127}));
      connect(force.flange, spool.flange_a) annotation (Line(
          points={{-18,-50},{10,-50}},color={0,127,0}));
      connect(outerContactA.flange_a, fixedLe.flange) annotation (Line(
          points={{-70,50},{-80,50},{-80,70},{-90,70}},
                                               color={0,127,0}));
      connect(housing.flange_a, fixedLe.flange) annotation (Line(
          points={{-10,70},{-90,70}}, color={0,127,0}));
      connect(friction.flange_a, fixedLe.flange) annotation (Line(
          points={{-80,40},{-80,70},{-90,70}},
                                      color={0,127,0}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}})),
        Documentation(info="<html>
<p>
When designing hydraulic valves it is often necessary to hold the spool in
a certain position as long as an external force is below a threshold value.
If this force exceeds the threshold value a linear relation between force
and position is desired.
There are designs that need only one spring to accomplish this task. Using
the ElastoGap elements this design can be modelled easily.
Drawing of spool.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/PreLoad.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/PreLoad3.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/PreLoad4.png\"><br>
</p>

<p>
Simulate for 100&nbsp;s and plot the spool position <code>spool.s</code>
as a function of working force <code>force.f</code>.
For positive force, the spool moves in positive direction - in figure below
the start value <code>spool.s.start</code> influences the offset.
.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/PreLoad2.png\">
</p>
</html>"),
        experiment(StopTime=100, Interval=0.1));
    end PreLoad;

    model ElastoGap "Demonstrate usage of ElastoGap"
      extends Modelica.Icons.Example;
      Components.Fixed fixed
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Components.Rod rod1(L=2)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Components.Rod rod2(L=2)
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      Components.SpringDamper springDamper1(
        c=10,
        s_rel0=1,
        s_rel(fixed=false, start=1),
        d=1.5)
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      Components.SpringDamper springDamper2(
        c=10,
        s_rel0=1,
        s_rel(fixed=false, start=1),
        d=1.5) annotation (Placement(transformation(extent={{20,20},{40,40}})));
      Components.Mass mass1(
        s(fixed=true, start=2),
        L=0,
        m=1,
        v(fixed=true))
        annotation (Placement(transformation(extent={{-10,20},{10,40}})));
      Components.ElastoGap elastoGap1(
        c=10,
        s_rel(fixed=false, start=1.5),
        s_rel0=1.5,
        d=1.5)
        annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
      Components.ElastoGap elastoGap2(
        c=10,
        s_rel(fixed=false, start=1.5),
        s_rel0=1.5,
        d=1.5)
        annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
      Components.Mass mass2(
        s(fixed=true, start=2),
        L=0,
        m=1,
        v(fixed=true))
        annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
      parameter SI.TranslationalDampingConstant d=1.5 "Damping constant";
    equation

      connect(rod1.flange_b, fixed.flange) annotation (Line(
          points={{-20,0},{0,0}}, color={0,127,0}));
      connect(fixed.flange, rod2.flange_a) annotation (Line(
          points={{0,0},{20,0}}, color={0,127,0}));
      connect(springDamper1.flange_a, rod1.flange_a) annotation (Line(
          points={{-40,30},{-50,30},{-50,0},{-40,0}}, color={0,127,0}));
      connect(springDamper2.flange_b, rod2.flange_b) annotation (Line(
          points={{40,30},{50,30},{50,0},{40,0}}, color={0,127,0}));
      connect(springDamper1.flange_b, mass1.flange_a) annotation (Line(
          points={{-20,30},{-10,30}}, color={0,127,0}));
      connect(mass1.flange_b, springDamper2.flange_a) annotation (Line(
          points={{10,30},{20,30}}, color={0,127,0}));
      connect(rod1.flange_a, elastoGap1.flange_a) annotation (Line(
          points={{-40,0},{-50,0},{-50,-30},{-40,-30}}, color={0,127,0}));
      connect(rod2.flange_b, elastoGap2.flange_b) annotation (Line(
          points={{40,0},{50,0},{50,-30},{40,-30}}, color={0,127,0}));
      connect(elastoGap1.flange_b, mass2.flange_a) annotation (Line(
          points={{-20,-30},{-10,-30}}, color={0,127,0}));
      connect(mass2.flange_b, elastoGap2.flange_a) annotation (Line(
          points={{10,-30},{20,-30}}, color={0,127,0}));
      annotation (
        experiment(StopTime=5, Interval=0.01),
        Documentation(info="<html>
<p>
This model demonstrates the effect of ElastoGaps on eigenfrequency:
Plot mass1.s and mass2.s as well as mass1.v and mass2.v to see that effect.
</p>
<p>
While mass1 is moved by both spring/damper forces all the time, this is not the case for mass2
since elastoGap1 lifts off at s&nbsp;&gt;&nbsp;-0.5 m and elastoGap2 lifts off at s&nbsp;&lt;&nbsp;+0.5 m.
Therefore, mass2 moves freely as long as -0.5&nbsp;m&nbsp;&lt;&nbsp;s&nbsp;&lt;&nbsp;+0.5&nbsp;m.
</p>
</html>"));
    end ElastoGap;

    model Brake "Demonstrate braking of a translational moving mass"
      extends Modelica.Icons.Example;

      Modelica.Mechanics.Translational.Components.Brake brake(fn_max=1,
          useSupport=false)
        annotation (Placement(transformation(extent={{0,50},{20,30}})));
      Modelica.Mechanics.Translational.Components.Mass mass1(
        m=1,
        s(fixed=true),
        v(start=1, fixed=true))
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      Modelica.Blocks.Sources.Step step(startTime=0.1, height=2) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            origin={-30,0})));
      Modelica.Mechanics.Translational.Components.Brake brake1(fn_max=1,
          useSupport=true)
        annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
      Modelica.Mechanics.Translational.Components.Mass mass2(
        m=1,
        s(fixed=true),
        v(start=1, fixed=true))
        annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
      Modelica.Mechanics.Translational.Components.Fixed fixed
        annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
    equation
      connect(mass1.flange_b, brake.flange_a) annotation (Line(
          points={{-20,40},{0,40}}, color={0,127,0}));
      connect(step.y, brake.f_normalized) annotation (Line(
          points={{-19,0},{10,0},{10,29}},     color={0,0,127}));
      connect(mass2.flange_b, brake1.flange_a) annotation (Line(
          points={{-20,-40},{0,-40}}, color={0,127,0}));
      connect(step.y, brake1.f_normalized) annotation (Line(
          points={{-19,0},{10,0},{10,-29}},     color={0,0,127}));
      connect(fixed.flange, brake1.support) annotation (Line(
          points={{10,-60},{10,-50}}, color={0,127,0}));
      annotation (Documentation(info="<html>
<p>
This model consists of a mass with an initial velocity of 1&nbsp;m/s.
After 0.1&nbsp;s, a brake is activated and it is shown that the mass decelerates until
it arrives at rest and remains at rest. Two versions of this system are present,
one where the brake is implicitly grounded and one where it is grounded explicitly.
</p>
</html>"), experiment(StopTime=2.0, Interval=0.001));
    end Brake;

    model HeatLosses "Demonstrate the modeling of heat losses"
      extends Modelica.Icons.Example;
      Components.Mass mass1(
        m=1,
        s(fixed=true),
        L=0.1,
        v(fixed=true))
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Components.SpringDamper springDamper(
        s_rel(fixed=true),
        v_rel(fixed=true),
        c=100,
        d=10,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Components.Damper damper(d=10, useHeatPort=true) annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={-40,-40})));
      Components.ElastoGap elastoGap(
        c=100,
        d=20,
        s_rel0=-0.02,
        useHeatPort=true)
        annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
      Components.Fixed fixed1
        annotation (Placement(transformation(extent={{-50,-70},{-30,-50}})));
      Sources.Force force
        annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
      Blocks.Sources.Sine sine1(freqHz=1, amplitude=20)
        annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
      Components.Mass mass2(
        m=1,
        L=0.1,
        s(fixed=false),
        v(fixed=false))
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      Components.SupportFriction supportFriction(useHeatPort=true)
        annotation (Placement(transformation(extent={{50,-10},{70,10}})));
      Components.Spring spring(c=100, s_rel(fixed=true))
        annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
      Components.Mass mass3(
        m=1,
        L=0.1,
        s(fixed=false),
        v(fixed=true))
        annotation (Placement(transformation(extent={{-10,50},{10,70}})));
      Components.Brake brake(fn_max=10, useHeatPort=true)
        annotation (Placement(transformation(extent={{20,50},{40,70}})));
      Blocks.Sources.Sine sine2(amplitude=10, freqHz=2)
        annotation (Placement(transformation(extent={{0,80},{20,100}})));
      Components.MassWithStopAndFriction massWithStopAndFriction(
        L=0.1,
        m=1,
        F_prop=0.5,
        F_Coulomb=1,
        F_Stribeck=2,
        fexp=2,
        smin=0,
        smax=0.4,
        v(fixed=true),
        useHeatPort=true)
        annotation (Placement(transformation(extent={{80,50},{100,70}})));
      Thermal.HeatTransfer.Components.Convection convection
        annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
      Blocks.Sources.Constant const(k=20)
        annotation (Placement(transformation(extent={{70,-60},{50,-40}})));
      Thermal.HeatTransfer.Celsius.FixedTemperature TAmbient(T=25)
        "Ambient temperature"
        annotation (Placement(transformation(extent={{70,-90},{50,-70}})));
      Components.Fixed fixed2
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
      Components.SpringDamper springDamper1(
        c=10000,
        d=1000,
        useHeatPort=true,
        s_rel(fixed=true))
        annotation (Placement(transformation(extent={{50,50},{70,70}})));
    equation

      connect(mass1.flange_b, springDamper.flange_a) annotation (Line(
          points={{-20,0},{-10,0}},   color={0,127,0}));
      connect(sine1.y, force.f) annotation (Line(
          points={{-79,0},{-72,0}},   color={0,0,127}));
      connect(force.flange, mass1.flange_a) annotation (Line(
          points={{-50,0},{-40,0}},   color={0,127,0}));
      connect(mass1.flange_a, damper.flange_a) annotation (Line(
          points={{-40,0},{-40,-30}},color={0,127,0}));
      connect(damper.flange_b, fixed1.flange) annotation (Line(
          points={{-40,-50},{-40,-60}}, color={0,127,0}));
      connect(springDamper.flange_b, mass2.flange_a) annotation (Line(
          points={{10,0},{20,0}},   color={0,127,0}));
      connect(mass2.flange_b, supportFriction.flange_a) annotation (Line(
          points={{40,0},{50,0}},   color={0,127,0}));
      connect(supportFriction.flange_b, spring.flange_a) annotation (Line(
          points={{70,0},{70,20},{-50,20},{-50,60},{-40,60}},
                                    color={0,127,0}));
      connect(spring.flange_b, mass3.flange_a) annotation (Line(
          points={{-20,60},{-10,60}},
                                    color={0,127,0}));
      connect(mass3.flange_b, brake.flange_a) annotation (Line(
          points={{10,60},{20,60}},   color={0,127,0}));
      connect(sine2.y, brake.f_normalized) annotation (Line(
          points={{21,90},{30,90},{30,71}},    color={0,0,127}));
      connect(elastoGap.flange_b, mass1.flange_a) annotation (Line(
          points={{-50,-30},{-40,-30},{-40,0}},
                                             color={0,127,0}));
      connect(const.y, convection.Gc) annotation (Line(
          points={{49,-50},{30,-50},{30,-70}},
                                             color={0,0,127}));
      connect(TAmbient.port, convection.fluid) annotation (Line(
          points={{50,-80},{40,-80}}, color={191,0,0}));
      connect(elastoGap.flange_a, fixed2.flange) annotation (Line(
          points={{-70,-30},{-90,-30}},
                                     color={0,127,0}));
      connect(elastoGap.heatPort, convection.solid) annotation (Line(
          points={{-70,-40},{-70,-80},{20,-80}},  color={191,0,0}));
      connect(damper.heatPort, convection.solid) annotation (Line(
          points={{-30,-30},{-10,-30},{-10,-80},{20,-80}},
                                                color={191,0,0}));
      connect(springDamper.heatPort, convection.solid) annotation (Line(
          points={{-10,-10},{-10,-80},{20,-80}}, color={191,0,0}));
      connect(supportFriction.heatPort, convection.solid) annotation (Line(
          points={{50,-10},{50,-30},{-10,-30},{-10,-80},{20,-80}},
                                                               color={191,0,0}));
      connect(brake.heatPort, convection.solid) annotation (Line(
          points={{20,50},{20,30},{90,30},{90,-30},{-10,-30},{-10,-80},{20,-80}},
                                                                 color={191,0,0}));
      connect(massWithStopAndFriction.heatPort, convection.solid) annotation (
          Line(
          points={{80,50},{80,30},{90,30},{90,-30},{-10,-30},{-10,-80},{20,-80}},
                                                                 color={191,0,0}));
      connect(brake.flange_b, springDamper1.flange_a) annotation (Line(
          points={{40,60},{50,60}},   color={0,127,0}));
      connect(springDamper1.flange_b, massWithStopAndFriction.flange_a)
        annotation (Line(
          points={{70,60},{80,60}},   color={0,127,0}));
      connect(springDamper1.heatPort, convection.solid) annotation (Line(
          points={{50,50},{50,30},{90,30},{90,-30},{-10,-30},{-10,-80},{20,-80}},
                                                                 color={191,0,0}));
      annotation (
        Documentation(info="<html>
<p>
This model demonstrates how to model the dissipated power of a Translational model,
by enabling the heatPort of all components and connecting these heatPorts via
a convection element to the environment. The total heat flow generated by the
elements and transported to the environment
is present in variable convection.fluid.
</p>
</html>"),
        experiment(StopTime=2.0, Interval=0.001),
        Diagram(coordinateSystem(extent={{-100,-100},{100,100}},
              preserveAspectRatio=false)));
    end HeatLosses;

    model EddyCurrentBrake "Demonstrate the usage of the translational eddy current brake"
      extends Modelica.Icons.Example;
      Modelica.Mechanics.Translational.Sources.EddyCurrentForce
        eddyCurrentForce(
        f_nominal=100,
        v_nominal=10,
        useHeatPort=true,
        TRef=293.15,
        alpha20(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Mechanics.Translational.Components.Mass mass(
        m=1,
        s(fixed=true, start=0),
        v(fixed=true, start=20))
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=1, T(
            fixed=true)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-10,-30})));
    equation
      connect(eddyCurrentForce.flange, mass.flange_a)
        annotation (Line(points={{10,0},{20,0}}, color={0,127,0}));
      connect(eddyCurrentForce.heatPort, heatCapacitor.port) annotation (Line(
            points={{-10,-10},{-10,-15},{-10,-20}}, color={191,0,0}));
      annotation (
        experiment(StopTime=1.0, Interval=0.001),
        Documentation(info="<html>
An eddy current brake reduces the speed of a moving mass. Kinetic energy is converted to thermal energy which leads to a temperature increase of the thermal capacitance of the brake, which can be assumed as adiabatic during the rather short time span of the braking.
</html>"));
    end EddyCurrentBrake;

    model GenerationOfFMUs
      "Example to demonstrate variants to generate FMUs (Functional Mock-up Units)"
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Sine sine1(freqHz=2, amplitude=10)
        annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
      Modelica.Mechanics.Translational.Examples.Utilities.DirectMass directMass(
          m=1.1) annotation (Placement(transformation(extent={{0,40},{20,60}})));
      Modelica.Mechanics.Translational.Examples.Utilities.InverseMass
        inverseMass(m=2.2)
        annotation (Placement(transformation(extent={{40,40},{60,60}})));
      Modelica.Mechanics.Translational.Examples.Utilities.SpringDamper
        springDamper(c=1e4, d=100)
        annotation (Placement(transformation(extent={{20,-20},{40,0}})));
      Modelica.Mechanics.Translational.Components.Mass mass2a(
        m=1.1,
        s(fixed=true, start=0),
        v(fixed=true, start=0))
        annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
      Modelica.Mechanics.Translational.Sources.Force force2
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
      Modelica.Mechanics.Translational.Components.GeneralForceToPositionAdaptor forceToPosition2a(use_pder2=false)
        annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
      Modelica.Mechanics.Translational.Components.Mass mass2b(
        m=2.2,
        s(fixed=true, start=0),
        v(fixed=true, start=0))
        annotation (Placement(transformation(extent={{70,-20},{90,0}})));
      Modelica.Mechanics.Translational.Components.GeneralForceToPositionAdaptor forceToPosition2b(use_pder2=false)
        annotation (Placement(transformation(extent={{70,-20},{50,0}})));
      Modelica.Mechanics.Translational.Examples.Utilities.Spring spring(c=1e4)
        annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
      Modelica.Mechanics.Translational.Components.Mass mass3a(
        m=1.1,
        s(fixed=true, start=0),
        v(fixed=true, start=0))
        annotation (Placement(transformation(extent={{-30,-80},{-10,-60}})));
      Modelica.Mechanics.Translational.Sources.Force force3
        annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
      Modelica.Mechanics.Translational.Components.GeneralForceToPositionAdaptor forceToPosition3a(use_pder=false, use_pder2=false)
        annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
      Modelica.Mechanics.Translational.Components.Mass mass3b(
        m=2.2,
        s(fixed=true, start=0),
        v(fixed=true, start=0))
        annotation (Placement(transformation(extent={{70,-80},{90,-60}})));
      Modelica.Mechanics.Translational.Components.GeneralForceToPositionAdaptor forceToPosition3b(use_pder=false, use_pder2=false)
        annotation (Placement(transformation(extent={{70,-80},{50,-60}})));
    equation
      connect(sine1.y, directMass.fDrive)
        annotation (Line(points={{-79,50},{-2,50}},  color={0,0,127}));
      connect(directMass.s, inverseMass.s)
        annotation (Line(points={{21,58},{38,58}},color={0,0,127}));
      connect(directMass.v,inverseMass.v)
        annotation (Line(points={{21,53},{30,53},{30,55},{38,55}},
                                                  color={0,0,127}));
      connect(directMass.a, inverseMass.a)
        annotation (Line(points={{21,47},{30,47},{30,45},{38,45}},
                                                  color={0,0,127}));
      connect(inverseMass.f, directMass.f)
        annotation (Line(points={{39,42},{22,42}}, color={0,0,127}));
      connect(force2.flange, mass2a.flange_a)
        annotation (Line(points={{-40,-10},{-30,-10}}, color={0,127,0}));
      connect(mass2a.flange_b, forceToPosition2a.flange)
        annotation (Line(points={{-10,-10},{-2,-10}},  color={0,127,0}));
      connect(forceToPosition2b.flange, mass2b.flange_a)
        annotation (Line(points={{62,-10},{70,-10}}, color={0,127,0}));
      connect(force3.flange, mass3a.flange_a)
        annotation (Line(points={{-40,-70},{-30,-70}}, color={0,127,0}));
      connect(mass3a.flange_b, forceToPosition3a.flange)
        annotation (Line(points={{-10,-70},{-2,-70}},  color={0,127,0}));
      connect(forceToPosition3b.flange, mass3b.flange_a)
        annotation (Line(points={{62,-70},{70,-70}}, color={0,127,0}));
      connect(forceToPosition2a.f, springDamper.f1)
        annotation (Line(points={{3,-18},{19,-18}}, color={0,0,127}));
      connect(springDamper.f2, forceToPosition2b.f)
        annotation (Line(points={{41,-18},{57,-18}}, color={0,0,127}));
      connect(forceToPosition3a.f, spring.f1)
        annotation (Line(points={{3,-78},{19,-78}}, color={0,0,127}));
      connect(spring.f2, forceToPosition3b.f)
        annotation (Line(points={{41,-78},{57,-78}}, color={0,0,127}));
      connect(forceToPosition3a.p, spring.s1)
        annotation (Line(points={{3,-62},{18,-62}}, color={0,0,127}));
      connect(spring.s2, forceToPosition3b.p)
        annotation (Line(points={{42,-62},{57,-62}}, color={0,0,127}));
      connect(forceToPosition2a.p, springDamper.s1)
        annotation (Line(points={{3,-2},{18,-2}}, color={0,0,127}));
      connect(forceToPosition2a.pder, springDamper.v1) annotation (Line(
            points={{3,-5},{10,-5},{10,-5},{18,-5}},
                                                   color={0,0,127}));
      connect(springDamper.s2, forceToPosition2b.p)
        annotation (Line(points={{42,-2},{57,-2}}, color={0,0,127}));
      connect(forceToPosition2b.pder, springDamper.v2) annotation (Line(
            points={{57,-5},{50,-5},{50,-5},{42,-5}}, color={0,0,127}));
      connect(sine1.y, force2.f) annotation (Line(points={{-79,50},{-70,50},
              {-70,-10},{-62,-10}}, color={0,0,127}));
      connect(sine1.y, force3.f) annotation (Line(points={{-79,50},{-70,50},
              {-70,-70},{-62,-70}}, color={0,0,127}));
      annotation (experiment(StopTime=1, Interval=0.001), Documentation(info="<html>
<p>
This example demonstrates how to generate an input/output block (e.g. in form of an
FMU - <a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>) from various Translational components.
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
<strong>Connecting two masses</strong><br>
The upper part (DirectMass, InverseMass)
demonstrates how to export two masses and connect them
together in a target system. This requires that one of the masses
(here: DirectMass)
is defined to have states and the position, velocity and
acceleration are provided in the interface.
The other mass (here: InverseMass) is moved according
to the provided input position, velocity and acceleration.
</p>

<p>
<strong>Connecting a force element that needs position and velocities</strong><br>
The middle part (SpringDamper) demonstrates how to export a force element
that needs both position and velocities for its force law and connect this
force law in a target system between two masses.
</p>

<p>
<strong>Connecting a force element that needs only positions</strong><br>
The lower part (Spring) demonstrates how to export a force element
that needs only positions for its force law and connect this
force law in a target system between two masses.
</p>
</html>"));
    end GenerationOfFMUs;

    package Utilities "Utility classes used by translational example models"
      extends Modelica.Icons.UtilitiesPackage;

      function GenerateStribeckFrictionTable
        "Generate Stribeck friction table for example Friction for the SupportFriction"
        extends Modelica.Icons.Function;
        input Real F_prop(final unit="N.s/m", final min=0)
          "Velocity dependent friction coefficient";
        input Modelica.SIunits.Force F_Coulomb
          "Constant friction: Coulomb force";
        input Modelica.SIunits.Force F_Stribeck "Stribeck effect";
        input Real fexp(final unit="s/m", final min=0) "Exponential decay";
        input Real v_max "Generate table from v=0 ... v_max";
        input Integer nTable(min=2) = 100 "Number of table points";
        output Real table[nTable, 2] "Friction table";
      algorithm
        for i in 1:nTable loop
          table[i, 1] := v_max*(i - 1)/(nTable - 1);
          table[i, 2] := F_Coulomb + F_prop*table[i, 1] + F_Stribeck*Modelica.Math.exp(-fexp*
            table[i, 1]);
        end for;
        annotation (Documentation(info="<html>
<p>
Returns a table with the friction characteristic table[nTable,2] = [0, f1; ....; v_max, fn], where the first
column is the velocity v in the range 0..v_max and the second column is the friction force
according to the Stribeck curve:
</p>
<pre>
  F_Coulomb + F_prop*v + F_Stribeck*exp(-fexp*v);
</pre>

</html>"));
      end GenerateStribeckFrictionTable;

      model DirectMass "Input/output block of a direct mass model"
        extends Modelica.Blocks.Icons.Block;
        parameter Modelica.SIunits.Mass m(min=0)=1 "Mass";
        Modelica.Mechanics.Translational.Components.Mass mass(
          m=m,
          s(start=0, fixed=true),
          v(start=0, fixed=true))
          annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
        Modelica.Mechanics.Translational.Sources.Force forceSource
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
        Modelica.Blocks.Interfaces.RealInput fDrive(unit="N")
          "Accelerating force acting at flange (= -flange.f)"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Mechanics.Translational.Components.GeneralForceToPositionAdaptor forceToPosition
          annotation (Placement(transformation(extent={{10,-10},{30,10}})));
        Modelica.Blocks.Interfaces.RealOutput s(unit="m")
          "Mass moves with position s due to force f"
          annotation (Placement(transformation(extent={{100,70},{120,90}})));
        Modelica.Blocks.Interfaces.RealOutput v(unit="m/s")
          "Mass moves with speed v due to force f"
          annotation (Placement(transformation(extent={{100,20},{120,40}})));
        Modelica.Blocks.Interfaces.RealOutput a(unit="m/s2")
          "Mass moves with acceleration a due to force f"
          annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
        Modelica.Blocks.Interfaces.RealInput f(unit="N") "Force to drive the mass"
                                    annotation (Placement(transformation(
                extent={{140,-100},{100,-60}})));
      equation
        connect(forceToPosition.f, f) annotation (Line(points={{23,-8},{60,
                -8},{60,-80},{120,-80}}, color={0,0,127}));
        connect(forceToPosition.p, s) annotation (Line(points={{23,8},{60,8},
                {60,80},{110,80}}, color={0,0,127}));
        connect(forceToPosition.pder, v) annotation (Line(points={{23,5},{
                80,5},{80,30},{110,30}}, color={0,0,127}));
        connect(forceToPosition.pder2, a) annotation (Line(points={{23,2},{
                80,2},{80,-30},{110,-30}}, color={0,0,127}));
        connect(fDrive, forceSource.f)
          annotation (Line(points={{-120,0},{-52,0}}, color={0,0,127}));
        connect(forceSource.flange, mass.flange_a)
          annotation (Line(points={{-30,0},{-20,0}}, color={0,127,0}));
        connect(mass.flange_b, forceToPosition.flange)
          annotation (Line(points={{0,0},{18,0}}));
        annotation (Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Text(
                      extent={{-84,-58},{24,-90}},
                      lineColor={135,135,135},
                      textString="to FMU"),Text(
                      extent={{8,96},{92,66}},
                      horizontalAlignment=TextAlignment.Right,
                textString="s"),                            Text(
                      extent={{10,46},{94,16}},
                      horizontalAlignment=TextAlignment.Right,
                textString="v"),   Text(
                      extent={{10,-10},{94,-40}},
                      horizontalAlignment=TextAlignment.Right,
                      textString="a"),Text(
                      extent={{-150,-110},{150,-140}},
                textString="m=%m"),      Bitmap(extent={{-96,-42},{64,54}},
                  fileName="modelica://Modelica/Resources/Images/Mechanics/Translational/DirectMass.png"),
                Text( extent={{10,-60},{94,-90}},
                      horizontalAlignment=TextAlignment.Right,
                textString="f")}), Documentation(info="<html>
<p>
A translational component with pure signal interface which can be applied for
a FMU (<a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>)
exchange.
The input force <code>fDrive</code> is applied on one side of a sliding mass
whereby the input force&nbsp;<code>f</code> is applied
on the other side of it.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.Translational.Examples.Utilities.InverseMass\">InverseMass</a>.
</p>
</html>"));
      end DirectMass;

      model InverseMass "Input/output block of an inverse mass model"
        extends Modelica.Blocks.Icons.Block;
        parameter Modelica.SIunits.Mass m=1 "Mass";
        Modelica.Mechanics.Translational.Components.Mass mass(
          m=m)           annotation (Placement(transformation(extent={{-10,
                  -10},{10,10}})));
        Modelica.Mechanics.Translational.Components.GeneralPositionToForceAdaptor positionToForce
          annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
        Modelica.Blocks.Interfaces.RealInput s(unit="m") "Position to drive the mass"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealInput v(unit="m/s") "Speed to drive the mass"
          annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
        Modelica.Blocks.Interfaces.RealInput a(unit="m/s2")
          "Acceleration to drive the mass"            annotation (Placement(
              transformation(extent={{-140,-70},{-100,-30}})));
        Modelica.Blocks.Interfaces.RealOutput f(unit="N")
          "Force needed to drive the flange according to s, v, a"
          annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
      equation

        connect(positionToForce.f, f) annotation (Line(points={{-23,-8},{-60,
                -8},{-60,-80},{-110,-80}}, color={0,0,127}));
        connect(positionToForce.flange, mass.flange_a)
          annotation (Line(points={{-18,0},{-10,0}}, color={0,127,0}));
        connect(positionToForce.p, s) annotation (Line(points={{-23,8},{-60,
                8},{-60,80},{-120,80}}, color={0,0,127}));
        connect(positionToForce.pder, v) annotation (Line(points={{-23,5},{-80,
                5},{-80,50},{-120,50}},     color={0,0,127}));
        connect(positionToForce.pder2, a) annotation (Line(points={{-23,2},{-80,
                2},{-80,-50},{-120,-50}},      color={0,0,127}));
        annotation (Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Text(
                      extent={{0,-62},{96,-94}},
                      lineColor={135,135,135},
                      textString="to FMU"),Text(
                      extent={{-94,96},{-10,66}},
                      horizontalAlignment=TextAlignment.Left,
                textString="s"),     Text(
                      extent={{-94,46},{-10,16}},
                      horizontalAlignment=TextAlignment.Left,
                textString="v"),   Text(
                      extent={{-92,-14},{-8,-44}},
                      horizontalAlignment=TextAlignment.Left,
                      textString="a"),Text(
                      extent={{-150,-110},{150,-140}},
                textString="m=%m"),      Bitmap(extent={{-58,-42},{98,48}},
                  fileName="modelica://Modelica/Resources/Images/Mechanics/Translational/InverseMass.png"),
                Text( extent={{-90,-64},{-6,-94}},
                      horizontalAlignment=TextAlignment.Left,
                textString="f")}), Documentation(info="<html>
<p>
A translational component with pure signal interface which can be applied for
a FMU (<a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>)
exchange.
Based on the kinematic inputs applied on a sliding mass
the output force&nbsp;<code>f</code> is returned.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Mechanics.Translational.Examples.Utilities.DirectMass\">DirectMass</a>.
</p>
</html>"));
      end InverseMass;

      model SpringDamper "Input/output block of a spring/damper model"
        extends Modelica.Blocks.Icons.Block;
        parameter Modelica.SIunits.TranslationalSpringConstant c=1e4
          "Spring constant";
        parameter Modelica.SIunits.TranslationalDampingConstant d=1
          "Damping constant";
        parameter Modelica.SIunits.Length s_rel0=0
          "Unstretched spring length";

        Modelica.Mechanics.Translational.Components.GeneralPositionToForceAdaptor positionToForce1(use_pder2=false)
          annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
        Modelica.Blocks.Interfaces.RealInput s1(unit="m")
          "Position of left flange of force element"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealInput v1(unit="m/s")
          "Speed to left flange of force element"
          annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
        Modelica.Blocks.Interfaces.RealOutput f1(unit="N")
          "Force generated by the force element" annotation (Placement(
              transformation(extent={{-100,-90},{-120,-70}})));
        SpringDamperNoRelativeStates springDamper(
          c=c,
          d=d,
          s_rel0=s_rel0)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Interfaces.RealInput s2(unit="m")
          "Position of right flange of force element"
          annotation (Placement(transformation(extent={{140,60},{100,100}})));
        Modelica.Blocks.Interfaces.RealInput v2(unit="m/s")
          "Speed to right flange of force element"
          annotation (Placement(transformation(extent={{140,30},{100,70}})));
        Modelica.Blocks.Interfaces.RealOutput f2(unit="N")
          "Force generated by the force element"
          annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
        Modelica.Mechanics.Translational.Components.GeneralPositionToForceAdaptor positionToForce2(use_pder2=false)
          annotation (Placement(transformation(extent={{30,-10},{10,10}})));
      equation

        connect(f1, positionToForce1.f) annotation (Line(points={{-110,-80},{
                -40,-80},{-40,-8},{-23,-8}}, color={0,0,127}));
        connect(positionToForce2.f, f2) annotation (Line(points={{23,-8},{
                40,-8},{40,-80},{110,-80}},
                                     color={0,0,127}));
        connect(positionToForce1.flange, springDamper.flange_a)
          annotation (Line(points={{-18,0},{-10,0}},color={0,127,0}));
        connect(springDamper.flange_b, positionToForce2.flange)
          annotation (Line(points={{10,0},{18,0}}, color={0,127,0}));
        connect(positionToForce1.p, s1) annotation (Line(points={{-23,8},{
                -40,8},{-40,80},{-120,80}}, color={0,0,127}));
        connect(positionToForce1.pder, v1) annotation (Line(points={{-23,5},{
                -60,5},{-60,50},{-120,50}},  color={0,0,127}));
        connect(positionToForce2.p, s2) annotation (Line(points={{23,8},{40,
                8},{40,80},{120,80}}, color={0,0,127}));
        connect(positionToForce2.pder, v2) annotation (Line(points={{23,5},{60,
                5},{60,50},{120,50}},     color={0,0,127}));
        annotation (Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Text(
                      extent={{-48,-36},{48,-68}},
                      lineColor={135,135,135},
                      textString="to FMU"),Text(
                      extent={{-94,96},{-10,66}},
                      horizontalAlignment=TextAlignment.Left,
                textString="s1"),      Text(
                      extent={{-150,-118},{150,-148}},
                      textString="c=%c
d=%d"),         Bitmap(extent={{-72,-44},{84,46}},
                  fileName="modelica://Modelica/Resources/Images/Mechanics/Translational/SpringDamper.png"),
                Text( extent={{12,96},{96,66}},
                      horizontalAlignment=TextAlignment.Right,
                textString="s2"),      Text(
                      extent={{12,48},{96,18}},
                      horizontalAlignment=TextAlignment.Right,
                textString="v2"),    Text(
                      extent={{10,-60},{94,-90}},
                      horizontalAlignment=TextAlignment.Right,
                textString="f2"),      Text(
                      extent={{-94,46},{-10,16}},
                      horizontalAlignment=TextAlignment.Left,
                textString="v1"),    Text(
                      extent={{-90,-64},{-6,-94}},
                      horizontalAlignment=TextAlignment.Left,
                textString="f1")}), Documentation(info="<html>
<p>
A linear 1D translational spring and damper in parallel with pure signal
interface which can be applied for
a FMU (<a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>)
exchange.
</p>
</html>"));
      end SpringDamper;

      model Spring "Input/output block of a spring model"
        extends Modelica.Blocks.Icons.Block;
        parameter Modelica.SIunits.TranslationalSpringConstant c=1e4
          "Spring constant";
        parameter Modelica.SIunits.Length s_rel0=0
          "Unstretched spring length";

        Modelica.Mechanics.Translational.Components.GeneralPositionToForceAdaptor positionToForce1(use_pder=false, use_pder2=
              false) annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
        Modelica.Blocks.Interfaces.RealInput s1(unit="m")
          "Position of left flange of force element"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealOutput f1(unit="N")
          "Force generated by the force element"
          annotation (Placement(transformation(extent={{-100,-90},{-120,-70}})));
        Modelica.Mechanics.Translational.Components.Spring spring(c=c,
            s_rel0=s_rel0) annotation (Placement(transformation(extent={{-10,
                  -10},{10,10}})));
        Modelica.Blocks.Interfaces.RealInput s2(unit="m")
          "Position of right flange of force element"
          annotation (Placement(transformation(extent={{140,60},{100,100}})));
        Modelica.Blocks.Interfaces.RealOutput f2(unit="N")
          "Force generated by the force element"
          annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
        Modelica.Mechanics.Translational.Components.GeneralPositionToForceAdaptor positionToForce2(use_pder=false, use_pder2=
              false) annotation (Placement(transformation(extent={{30,-10},{10,10}})));
      equation

        connect(f1, positionToForce1.f) annotation (Line(points={{-110,-80},{-60,-80},
                {-60,-8},{-23,-8}}, color={0,0,127}));
        connect(positionToForce2.f, f2) annotation (Line(points={{23,-8},{60,-8},{60,-80},
                {110,-80}}, color={0,0,127}));
        connect(positionToForce1.flange, spring.flange_a)
          annotation (Line(points={{-18,0},{-10,0}}, color={0,127,0}));
        connect(spring.flange_b, positionToForce2.flange)
          annotation (Line(points={{10,0},{18,0}}, color={0,127,0}));
        connect(positionToForce1.p, s1) annotation (Line(points={{-23,8},{
                -60,8},{-60,80},{-120,80}}, color={0,0,127}));
        connect(positionToForce2.p, s2) annotation (Line(points={{23,8},{60,
                8},{60,80},{120,80}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
              graphics={Text(
                      extent={{-48,-36},{48,-68}},
                      lineColor={135,135,135},
                      textString="to FMU"),Text(
                      extent={{-94,96},{-10,66}},
                      horizontalAlignment=TextAlignment.Left,
                textString="s1"),      Text(
                      extent={{-150,-114},{150,-144}},
                      textString="c=%c"),Bitmap(extent={{-88,-36},{92,56}},
                  fileName="modelica://Modelica/Resources/Images/Mechanics/Translational/Spring.png"),
                Text( extent={{12,96},{96,66}},
                      horizontalAlignment=TextAlignment.Right,
                textString="s2"),      Text(
                      extent={{10,-60},{94,-90}},
                      horizontalAlignment=TextAlignment.Right,
                textString="f2"),      Text(
                      extent={{-90,-64},{-6,-94}},
                      horizontalAlignment=TextAlignment.Left,
                textString="f1")}), Documentation(info="<html>
<p>
A linear 1D translational spring with pure signal
interface which can be applied for
a FMU (<a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>)
exchange.
</p>
</html>"));
      end Spring;

      model SpringDamperNoRelativeStates
        "Linear 1D translational spring and damper in parallel (s and v are not used as states)"
        parameter Modelica.SIunits.TranslationalSpringConstant c(final min=0, start=1.0e5) "Spring constant";
        parameter Modelica.SIunits.TranslationalDampingConstant d(final min=0, start=0) "Damping constant";
        parameter Modelica.SIunits.Length s_rel0=0
          "Unstretched spring length";
        Modelica.SIunits.Velocity v_rel(start=0)
          "Relative velocity (= der(s_rel))";
        extends Modelica.Mechanics.Translational.Interfaces.PartialCompliant;
        extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
      protected
        Modelica.SIunits.Force f_c "Spring force";
        Modelica.SIunits.Force f_d "Damping force";
      equation
        v_rel = der(s_rel);
        f_c = c*(s_rel - s_rel0);
        f_d = d*v_rel;
        f = f_c + f_d;
        lossPower = f_d*v_rel;
        annotation (
          Documentation(info="<html>
<p>
A <strong>spring</strong> and <strong>damper</strong> element <strong>connected in parallel</strong>.
The component can be
connected either between two masses to describe the joint elasticity
and damping, or between a mass and the housing (component Fixed),
to describe a coupling of the element with the housing via a spring/damper.
</p>

<p>
This is the same element as <a href=\"modelica://Modelica.Mechanics.Translational.Components.SpringDamper\">Translational.Components.SpringDamper</a>
but with the only difference, that the relative quantities are not used as states. If the relative
states are potentially used as states, \"a_rel = der(v_rel)\" is present, and then exporting this model
as FMU requires to also have the accelerations in the flanges as inputs, which is usually not
desired for a force element.
</p>
</html>"),Icon(
            coordinateSystem(preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}),
              graphics={
          Line(points={{-80,40},{-60,40},{-45,10},{-15,70},{15,10},{45,70},{60,40},{80,40}}, color={0,127,0}),
          Line(points={{-80,40},{-80,-60}}, color={0,127,0}),
          Line(points={{-80,-60},{-50,-60}}, color={0,127,0}),
          Rectangle(extent={{-50,-40},{40,-80}},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
                lineColor={0,127,0}),
          Line(points={{-50,-40},{70,-40}}, color={0,127,0}),
          Line(points={{-50,-80},{70,-80}}, color={0,127,0}),
          Line(points={{40,-60},{80,-60}}, color={0,127,0}),
          Line(points={{80,40},{80,-60}}, color={0,127,0}),
          Line(points={{-90,0},{-80,0}}, color={0,127,0}),
          Line(points={{80,0},{90,0}}, color={0,127,0}),
          Text(origin={0,-9},
            extent={{-150,-144},{150,-104}},
            textString="d=%d"),
          Text(extent={{-190,110},{190,70}},
            lineColor={0,0,255},
            textString="%name"),
          Text(
            origin={0,-7},
            extent={{-150,-108},{150,-68}},
                textString="c=%c"),
          Line(visible=useHeatPort,
            points={{-100,-100},{-100,-55},{-5,-55}},
            color={191,0,0},
            pattern=LinePattern.Dot),
              Polygon(
                points={{51,-10},{21,0},{21,-20},{51,-10}},
                lineColor={95,127,95},
                fillColor={95,127,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-59,-10},{21,-10}}, color={95,127,95})}),
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
                textString="s_rel"),
              Rectangle(
                extent={{-50,-20},{40,-80}},
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
      annotation (Documentation(info="<html>
<p>
This package contains utility models and functions used by some
of the example models from the translational mechanics package.
</p>
</html>"));
    end Utilities;
    annotation (Documentation(info="<html>
<p>
This package contains example models to demonstrate the usage of the
Translational package. Open the models and
simulate them according to the provided description in the models.
</p>

</html>"));
  end Examples;

  package Components "Components for 1D translational mechanical drive trains"
    extends Modelica.Icons.Package;

    model Fixed "Fixed flange"
      parameter SI.Position s0=0 "Fixed offset position of housing";

      Interfaces.Flange_b flange annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180)));
    equation
      flange.s = s0;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
            Line(points={{-80,-40},{80,-40}}, color={0,127,0}),
            Line(points={{80,-40},{40,-80}}, color={0,127,0}),
            Line(points={{40,-40},{0,-80}}, color={0,127,0}),
            Line(points={{0,-40},{-40,-80}}, color={0,127,0}),
            Line(points={{-40,-40},{-80,-80}}, color={0,127,0}),
            Line(points={{0,-40},{0,-10}}, color={0,127,0}),
            Text(
              extent={{-150,-90},{150,-130}},
              textString="%name",
              lineColor={0,0,255})}), Documentation(info="<html>
<p>
The <em>flange</em> of a 1D translational mechanical system <em>fixed</em>
at an position s0 in the <em>housing</em>. May be used:
</p>
<ul>
<li> to connect a compliant element, such as a spring or a damper,
     between a sliding mass and the housing.</li>
<li> to fix a rigid element, such as a sliding mass, at a specific
     position.</li>
</ul>

</html>"));
    end Fixed;

    model Mass "Sliding mass with inertia"
      parameter SI.Mass m(min=0, start=1) "Mass of the sliding mass";
      parameter StateSelect stateSelect=StateSelect.default
        "Priority to use s and v as states" annotation (Dialog(tab="Advanced"));
      extends Translational.Interfaces.PartialRigid(L=0,s(start=0, stateSelect=
              stateSelect));
      SI.Velocity v(start=0, stateSelect=stateSelect)
        "Absolute velocity of component";
      SI.Acceleration a(start=0) "Absolute acceleration of component";

    equation
      v = der(s);
      a = der(v);
      m*a = flange_a.f + flange_b.f;
      annotation (
        Documentation(info="<html>
<p>
Sliding mass with <em>inertia, without friction</em> and two rigidly connected flanges.
</p>
<p>
The sliding mass has the length L, the position coordinate s is in the middle.
Sign convention: A positive force at flange flange_a moves the sliding mass in the positive direction.
A negative force at flange flange_a moves the sliding mass to the negative direction.
</p>

</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-100,0},{100,0}}, color={0,127,0}),
            Rectangle(
              extent={{-55,-30},{56,30}},
              fillPattern=FillPattern.Sphere,
              fillColor={160,215,160},
              lineColor={0,127,0}),
            Polygon(
              points={{50,-90},{20,-80},{20,-100},{50,-90}},
              lineColor={95,127,95},
              fillColor={95,127,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-60,-90},{20,-90}}, color={95,127,95}),
            Text(
              extent={{-150,85},{150,45}},
              textString="%name",
              lineColor={0,0,255},
              fillColor={110,210,110},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,-45},{150,-75}},
              textString="m=%m",
              fillColor={110,221,110},
              fillPattern=FillPattern.Solid,
              fontSize=0)}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{-100,0},{-55,0}}, color={0,127,0}),
              Line(points={{55,0},{100,0}}, color={0,127,0}),Rectangle(
                  extent={{-55,-30},{55,30}},
                  fillPattern=FillPattern.Sphere,
                  fillColor={255,255,255}),Polygon(
                  points={{50,-90},{20,-80},{20,-100},{50,-90}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),Line(points={{-60,-90},{20,-90}}),Line(points={{-100,-29},{-100,-61}}),
              Line(points={{100,-61},{100,-28}}),Line(points={{-98,
              -60},{98,-60}}),Polygon(
                  points={{-101,-60},{-96,-59},{-96,-61},{-101,-60}},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{100,-60},{95,-61},{95,-59},{100,-60}},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-44,-41},{51,-57}},
                  textString="Length L",
                  lineColor={0,0,255}),Line(points={{0,30},{0,53}}),
              Line(points={{-72,40},{1,40}}),Polygon(
                  points={{-7,42},{-7,38},{-1,40},{-7,42}},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-61,53},{-9,42}},
                  textString="Position s",
                  lineColor={0,0,255})}));
    end Mass;

    model Rod "Rod without inertia"
      extends Translational.Interfaces.PartialRigid;

    equation
      0 = flange_a.f + flange_b.f;
      annotation (
        Documentation(info="<html>
<p>
A translational rod <strong>without inertia</strong> and two rigidly connected flanges.
</p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{-100,0},{100,0}}, color={0,127,0}),
                                                            Polygon(
              points={{50,-90},{20,-80},{20,-100},{50,-90}},
              lineColor={95,127,95},
              fillColor={95,127,95},
              fillPattern=FillPattern.Solid),    Line(points={{-60,-90},{20,-90}}, color={95,127,95}),
                                                                                   Rectangle(
              extent={{-60,10},{60,-10}},
              lineColor={0,127,0},
              fillColor={160,215,160},
              fillPattern=FillPattern.Solid),    Text(
                  extent={{-150,80},{150,40}},
                  textString="%name",
                  lineColor={0,0,255}),Text(
                  extent={{-150,-30},{150,-60}},
                  textString="L=%L")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{-100,0},{-55,0}}, color={0,127,0}),
              Line(points={{54,0},{100,0}}, color={0,127,0}),Polygon(
                  points={{50,-90},{20,-80},{20,-100},{50,-90}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),Line(points={{-60,-90},{20,-90}}),Rectangle(
                  extent={{-55,3},{53,-4}},
                  lineColor={160,160,164},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-100,-29},{-100,
              -61}}),Line(points={{100,-61},{100,-28}}),
              Line(points={{-98,-60},{98,-60}}),Polygon(
                  points={{-101,-60},{-96,-59},{-96,-61},{-101,-60}},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{100,-60},{95,-61},{95,-59},{100,-60}},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-44,-41},{51,-57}},
                  textString="Length L",
                  lineColor={0,0,255})}));
    end Rod;

    model Spring "Linear 1D translational spring"
      extends Translational.Interfaces.PartialCompliant;
      parameter SI.TranslationalSpringConstant c(final min=0, start=1)
        "Spring constant";
      parameter SI.Distance s_rel0=0 "Unstretched spring length";

    equation
      f = c*(s_rel - s_rel0);
      annotation (
        Documentation(info="<html>
<p>
A <em>linear 1D translational spring</em>. The component can be connected either
between two sliding masses, or between
a sliding mass and the housing (model Fixed), to describe
a coupling of the sliding mass with the housing via a spring.
</p>

</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-60,-90},{20,-90}}, color={95,127,95}),
            Polygon(
              points={{50,-90},{20,-80},{20,-100},{50,-90}},
              lineColor={95,127,95},
              fillColor={95,127,95},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{-98,0},{-60,0},{-44,-30},{-16,30},{14,-30},{44,30},{
                  60,0},{100,0}}, color={0,127,0}),
            Text(
              extent={{-150,-45},{150,-75}},
              textString="c=%c")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{-100,0},{-100,65}}, color=
              {128,128,128}),Line(points={{100,0},{100,65}}, color={128,128,128}),
              Line(points={{-100,60},{100,60}}, color={128,128,128}),Polygon(
                  points={{90,63},{100,60},{90,57},{90,63}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-56,66},{36,81}},
                  lineColor={0,0,255},
                  textString="s_rel"),Line(points={{-86,0},{-60,0},{-44,-30},{-16,
              30},{14,-30},{44,30},{60,0},{84,0}})}));
    end Spring;

    model Damper "Linear 1D translational damper"
      extends Translational.Interfaces.PartialCompliantWithRelativeStates;
      parameter SI.TranslationalDampingConstant d(final min=0, start=0)
        "Damping constant";
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
    equation
      f = d*v_rel;
      lossPower = f*v_rel;
      annotation (
        Documentation(info="<html>
<p>
<em>Linear, velocity dependent damper</em> element. It can be either connected
between a sliding mass and the housing (model Fixed), or
between two sliding masses.
</p>

</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{-90,0},{100,0}}, color={0,127,0}),
              Line(points={{-60,-30},{-60,30}}),                    Rectangle(
                  extent={{-60,30},{30,-30}},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid,
              lineColor={0,127,0}),                                           Polygon(
              points={{50,-90},{20,-80},{20,-100},{50,-90}},
              lineColor={95,127,95},
              fillColor={95,127,95},
              fillPattern=FillPattern.Solid),    Line(points={{-60,-90},{20,-90}}, color={95,127,95}),
                                                                                   Text(
                  extent={{-150,90},{150,50}},
                  textString="%name",
                  lineColor={0,0,255}),Text(
                  extent={{-150,-45},{150,-75}},
                  textString="d=%d"),Line(
                  visible=useHeatPort,
                  points={{-100,-100},{-100,-20},{-14,-20}},
                  color={191,0,0},
                  pattern=LinePattern.Dot),
                                    Line(points={{60,-30},{-60,-30},{-60,30},{60,30}}, color={0,127,0})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{-90,0},{-60,0}}),
              Line(points={{-60,-30},{-60,30}}),Line(
              points={{-60,-30},{60,-30}}),Line(points={{-60,30},
              {60,30}}),Rectangle(
                  extent={{-60,30},{30,-30}},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{30,0},{90,0}}),Line(points={{-50,60},{50,60}}, color={128,128,128}),
              Polygon(
                  points={{50,63},{60,60},{50,57},{50,63}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-58,68},{42,78}},
                  lineColor={128,128,128},
                  textString="der(s_rel)")}));
    end Damper;

    model SpringDamper "Linear 1D translational spring and damper in parallel"
      extends Translational.Interfaces.PartialCompliantWithRelativeStates;
      parameter SI.TranslationalSpringConstant c(final min=0, start=1)
        "Spring constant";
      parameter SI.TranslationalDampingConstant d(final min=0, start=1)
        "Damping constant";
      parameter SI.Position s_rel0=0 "Unstretched spring length";
      extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
    protected
      Modelica.SIunits.Force f_c "Spring force";
      Modelica.SIunits.Force f_d "Damping force";
    equation
      f_c = c*(s_rel - s_rel0);
      f_d = d*v_rel;
      f = f_c + f_d;
      lossPower = f_d*v_rel;
      annotation (
        Documentation(info="<html>
<p>
A <em>spring and damper element connected in parallel</em>.
The component can be
connected either between two sliding masses to describe the elasticity
and damping, or between a sliding mass and the housing (model Fixed),
to describe a coupling of the sliding mass with the housing via a spring/damper.
</p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{-80,40},{-60,40},{-45,10},{-15,70},{15,10},{45,70},{
                  60,40},{80,40}}, color={0,127,0}),
            Line(points={{-80,40},{-80,-70},{80,-70},{80,40}}, color={0,127,0}),
            Line(points={{-90,0},{-80,0}}, color={0,127,0}),
            Line(points={{80,0},{90,0}}, color={0,127,0}),
            Polygon(
              points={{53,-20},{23,-10},{23,-30},{53,-20}},
              lineColor={95,127,95},
              fillColor={95,127,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-57,-20},{23,-20}}, color={95,127,95}),
            Text(
              extent={{-150,120},{150,80}},
              textString="%name",
              lineColor={0,0,255}),
            Text(
              extent={{-150,-135},{150,-165}},
              textString="d=%d"),
            Text(
              extent={{-150,-100},{150,-130}},
              textString="c=%c"),
            Line(
              visible=useHeatPort,
              points={{-100,-100},{-100,-80},{-5,-80}},
              color={191,0,0},
              pattern=LinePattern.Dot),
            Rectangle(
              extent={{-50,-50},{40,-90}},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid,
              lineColor={0,127,0}), Line(points={{70,-90},{-50,-90},{-50,-50},{70,-50}}, color={0,127,0})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(
                  points={{-80,32},{-58,32},{-43,2},{-13,62},{17,2},{47,62},{62,
                32},{80,32}},
                  thickness=0.5),Line(points={{-100,31},{-100,96}}, color={128,128,128}),
              Line(points={{100,29},{100,94}}, color={128,128,128}),
              Line(points={{-98,82},{100,82}}, color={128,128,128}),Polygon(
                  points={{90,85},{100,82},{90,79},{90,85}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-63,83},{46,103}},
                  lineColor={0,0,255},
                  textString="s_rel"),Rectangle(
                  extent={{-52,-28},{38,-72}},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Line(points={{-51,-72},{69,-72}}),Line(points={{-52,-28},{68,-28}}),
              Line(points={{38,-50},{80,-50}}),Line(points={{-80,
              -50},{-52,-50}}),Line(points={{-80,32},{-80,-50}}),Line(points={{80,32},{80,-50}}),
              Line(points={{-90,0},{-80,0}}),Line(points={{90,0},
              {80,0}})}));
    end SpringDamper;

    model ElastoGap "1D translational spring damper combination with gap"
      extends Modelica.Mechanics.Translational.Interfaces.PartialCompliantWithRelativeStates;
      parameter SI.TranslationalSpringConstant c(final min=0, start=1)
        "Spring constant";
      parameter SI.TranslationalDampingConstant d(final min=0, start=1)
        "Damping constant";
      parameter SI.Position s_rel0=0 "Unstretched spring length";
      parameter Real n(final min=1) = 1
        "Exponent of spring force ( f_c = -c*|s_rel-s_rel0|^n )";
      extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

      /*
Please note that initialization might fail due to the nonlinear spring characteristic
(spring force is zero for s_rel > s_rel0)
if a positive force is acting on the element and no other force balances this force
(e.g., when setting both initial velocity and acceleration to 0)
*/
      Boolean contact "=true, if contact, otherwise no contact";
    protected
      Modelica.SIunits.Force f_c "Spring force";
      Modelica.SIunits.Force f_d2 "Linear damping force";
      Modelica.SIunits.Force f_d
        "Linear damping force which is limited by spring force (|f_d| <= |f_c|)";
    equation
      // Modify contact force, so that it is only "pushing" and not
      // "pulling/sticking" and that it is continuous
      contact = s_rel < s_rel0;
      f_c = smooth(1, noEvent(if contact then -c*abs(s_rel - s_rel0)^n else 0));
      f_d2 = if contact then d*v_rel else 0;
      f_d = smooth(0, noEvent(if contact then (if f_d2 < f_c then f_c else if
        f_d2 > -f_c then -f_c else f_d2) else 0));
      f = f_c + f_d;
      lossPower = f_d*v_rel;
      annotation (
        Documentation(info="<html>
<p>
This component models a spring damper combination that can lift off.
It can be connected between a sliding mass and the housing (model
<a href=\"modelica://Modelica.Mechanics.Translational.Components.Fixed\">Fixed</a>),
to describe the contact of a sliding mass with the housing.
</p>

<p>
As long as s_rel &gt; s_rel0, no force is exerted (s_rel = flange_b.s - flange_a.s).
If s_rel &le; s_rel0, the contact force is basically computed with a linear
spring/damper characteristic. With parameter n&ge;1 (exponent of spring force),
a nonlinear spring force can be modeled:
</p>

<pre>
   desiredContactForce = c*|s_rel - s_rel0|^n + d*<strong>der</strong>(s_rel)
</pre>

<p>
Note, Hertzian contact is described by:
</p>
<ul>
<li> Contact between two metallic spheres: n=1.5</li>
<li> Contact between two metallic plates: n=1</li>
</ul>

<p>
The above force law leads to the following difficulties:
</p>

<ol>
<li> If the damper force becomes larger as the spring force and with opposite sign,
     the contact force would be \"pulling/sticking\" which is unphysical, since during
     contact only pushing forces can occur.</li>

<li> When contact occurs with a non-zero relative speed (which is the usual
     situation), the damping force has a non-zero value and therefore the contact
     force changes discontinuously at s_rel = s_rel0. Again, this is not physical
     because the force can only change continuously. (Note, this component is not an
     idealized model where a steep characteristic is approximated by a discontinuity,
     but it shall model the steep characteristic.)</li>
</ol>

<p>
In the literature there are several proposals to fix problem (2). Especially, often
the following model is used (see, e.g.,
Lankarani, Nikravesh: Continuous Contact Force Models for Impact
Analysis in Multibody Systems, Nonlinear Dynamics 5, pp. 193-207, 1994,
<a href=\"http://www.springerlink.com/content/h50x61270q06p65n/fulltext.pdf\">pdf-download</a>):
</p>

<pre>
   f = c*s_rel^n + (d*s_rel^n)*<strong>der</strong>(s_rel)
</pre>

<p>
However, this and other models proposed in literature violate
issue (1), i.e., unphysical pulling forces can occur (if d*<strong>der</strong>(s_rel)
becomes large enough). Note, if the force law is of the form \"f = f_c + f_d\", then a
necessary condition is that |f_d| &le; |f_c|, otherwise (1) and (2) are violated.
For this reason, the most simplest approach is used in the ElastoGap model
to fix both problems by using this necessary condition in the force law directly.
If s_rel0 = 0, the equations are:
</p>

<pre>
    <strong>if</strong> s_rel &ge; 0 <strong>then</strong>
       f = 0;    // contact force
    <strong>else</strong>
       f_c  = -c*|s_rel|^n;          // contact spring force (Hertzian contact force)
       f_d2 = d*<strong>der</strong>(s_rel);         // linear contact damper force
       f_d  = <strong>if</strong> f_d2 &lt;  f_c <strong>then</strong>  f_c <strong>else</strong>
              <strong>if</strong> f_d2 &gt; -f_c <strong>then</strong> -f_c <strong>else</strong> f_d2;  // bounded damper force
       f    = f_c + f_d;            // contact force
    <strong>end if</strong>;
</pre>

<p>
Note, since |f_d| &le; |f_c|, pulling forces cannot occur and the contact force
is always continuous, especially around the start of the penetration at s_rel = s_rel0.
</p>

<p>
In the next figure, a typical simulation with the ElastoGap model is shown
(<a href=\"modelica://Modelica.Mechanics.Translational.Examples.ElastoGap\">Examples.ElastoGap</a>)
where the different effects are visualized:
</p>

<ol>
<li> Curve 1 (elastoGap1.f) is the unmodified contact force, i.e., the linear spring/damper
     characteristic. A pulling/sticking force is present at the end of the contact.</li>
<li> Curve 2 (elastoGap2.f) is the contact force, where the force is explicitly set to
     zero when pulling/sticking occurs. The contact force is discontinuous when contact starts.</li>
<li> Curve 3 (elastoGap3.f) is the ElastoGap model of this library. No discontinuity and no
     pulling/sticking occurs.</li>
</ol>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/ElastoGap1.png\">
</p>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{-100,0},{-50,0}}, color={0,127,0}),
              Line(
                  points={{-48,34},{-48,-46}},
                  thickness=1),Line(points={{8,40},{8,2}}),Line(
              points={{-2,0},{38,0},{38,44},{-2,44}}),Line(
              points={{38,22},{72,22}}),Line(
                  points={{-12,-38},{-12,20}},
                  thickness=1),Line(points={{-12,22},{8,22}}),
              Line(points={{-12,-38},{-2,-38}}),Line(points={{72,
              0},{100,0}}, color={0,127,0}),Line(points={{72,22},{72,-42}}),Line(points={{-2,-38},{10,-28},{22,-48},{38,-28},{
              50,-48},{64,-28},{72,-40}}),Rectangle(
                  extent={{8,44},{38,0}},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-64,-80},{64,-64}},
                  lineColor={0,0,255},
                  textString="s_rel"),Line(points={{-100,-29},{-100,-61}}),Line(points={{100,-61},{100,-28}}),
              Line(points={{-98,-60},{98,-60}}),Polygon(
                  points={{-101,-60},{-96,-59},{-96,-61},{-101,-60}},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{100,-60},{95,-61},{95,-59},{100,-60}},
                  fillPattern=FillPattern.Solid)}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{-98,0},{-48,0}}, color={0,127,0}),
              Line(
                  points={{-48,36},{-48,-38}},
                  thickness=1,
              color={0,127,0}),                Line(
                  points={{-12,-38},{-12,36}},
                  thickness=1,
              color={0,127,0}),Line(points={{-12,-28},{70,-28},{70,24}}, color={0,127,0}),
                                              Line(points={{70,0},{98,0}},
                       color={0,127,0}),
              Line(points={{-12,24},{0,24},{6,34},{18,14},{30,34},{42,14},{54,34},{60,24},{70,24}}, color={0,127,0}),
              Rectangle(
                  extent={{10,-6},{50,-50}},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid,
              lineColor={0,127,0}),              Line(points={{-52,-70},{28,-70}}, color={95,127,95}),
                                                                                   Polygon(
              points={{58,-70},{28,-60},{28,-80},{58,-70}},
              lineColor={95,127,95},
              fillColor={95,127,95},
              fillPattern=FillPattern.Solid),    Text(
                  extent={{-150,100},{150,60}},
                  textString="%name",
                  lineColor={0,0,255}), Text(
                  extent={{-150,-125},{150,-95}},
                  textString="c=%c"),Text(
                  extent={{-150,-160},{150,-130}},
                  textString="d=%d"),
              Line(
                  visible=useHeatPort,
                  points={{-100,-100},{-100,-44},{22,-44},{22,-28}},
                  color={191,0,0},
                  pattern=LinePattern.Dot),
              Line(points={{0,-50},{50,-50},{50,-6},{0,-6}}, color={0,127,0})}));
    end ElastoGap;

    model SupportFriction "Coulomb friction in support"

      extends Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
      extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;

      parameter Real f_pos[:, 2]=[0, 1]
        "[v, f] Positive sliding friction characteristic (v>=0)";
      parameter Real peak(final min=1) = 1
        "Peak for maximum friction force at w==0 (f0_max = peak*f_pos[1,2])";
      extends Translational.Interfaces.PartialFriction;

      SI.Position s "= flange_a.s - support.s";
      SI.Force f "Friction force";
      SI.Velocity v "Absolute velocity of flange_a and flange_b";
      SI.Acceleration a "Absolute acceleration of flange_a and flange_b";
    equation
      // Constant auxiliary variables
      f0 = Modelica.Math.Vectors.interpolate(
            f_pos[:, 1],
            f_pos[:, 2],
            0,
            1);
      f0_max = peak*f0;
      free = false;

      s = flange_a.s - s_support;
      flange_a.s = flange_b.s;

      // velocity and acceleration of flanges
      v = der(s);
      a = der(v);
      v_relfric = v;
      a_relfric = a;

      // Friction force
      flange_a.f + flange_b.f - f = 0;

      // Friction force
      f = if locked then sa*unitForce else (
        if startForward then
          Modelica.Math.Vectors.interpolate(f_pos[:, 1], f_pos[:, 2], v, 1)
        else if startBackward then
          -Modelica.Math.Vectors.interpolate(f_pos[:, 1], f_pos[:, 2], -v, 1)
        else if pre(mode) == Forward then
          Modelica.Math.Vectors.interpolate(f_pos[:, 1], f_pos[:, 2], v, 1)
        else
          -Modelica.Math.Vectors.interpolate(f_pos[:, 1], f_pos[:, 2], -v, 1));

      lossPower = f*v_relfric;
      annotation (
        Documentation(info="<html>
<p>
This element describes <strong>Coulomb friction</strong> in <strong>support</strong>,
i.e., a frictional force acting between a flange and the housing.
The positive sliding friction force \"f\" has to be defined
by table \"f_pos\" as function of the absolute velocity \"v\".
E.g.
</p>
<pre>
       v |   f
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
   f_pos = [0, 0; 1, 2; 2, 5; 3, 8];
</pre>
<p>
Currently, only linear interpolation in the table is supported.
Outside of the table, extrapolation through the last
two table entries is used. It is assumed that the negative
sliding friction force has the same characteristic with negative
values. Friction is modelled in the following way:
</p>
<p>
When the absolute velocity \"v\" is not zero, the friction force
is a function of v and of a constant normal force. This dependency
is defined via table f_pos and can be determined by measurements,
e.g., by driving the gear with constant velocity and measuring the
needed driving force (= friction force).
</p>
<p>
When the absolute velocity becomes zero, the elements
connected by the friction element become stuck, i.e., the absolute
position remains constant. In this phase the friction force is
calculated from a force balance due to the requirement, that
the absolute acceleration shall be zero.  The elements begin
to slide when the friction force exceeds a threshold value,
called the maximum static friction force, computed via:
</p>
<pre>
   maximum_static_friction = <strong>peak</strong> * sliding_friction(v=0)  (<strong>peak</strong> >= 1)
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
<dd><strong>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</strong>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>
<p>
More precise friction models take into account the elasticity of the
material when the two elements are \"stuck\", as well as other effects,
like hysteresis. This has the advantage that the friction element can
be completely described by a differential equation without events. The
drawback is that the system becomes stiff (about 10-20 times slower
simulation) and that more material constants have to be supplied which
requires more sophisticated identification. For more details, see the
following references, especially (Armstrong and Canudas de Wit 1996):
</p>
<dl>
<dt>Armstrong B. (1991):</dt>
<dd><strong>Control of Machines with Friction</strong>. Kluwer Academic
    Press, Boston MA.<br><br></dd>
<dt>Armstrong B., and Canudas de Wit C. (1996):</dt>
<dd><strong>Friction Modeling and Compensation.</strong>
    The Control Handbook, edited by W.S.Levine, CRC Press,
    pp. 1369-1382.<br><br></dd>
<dt>Canudas de Wit C., Olsson H., &Aring;str&ouml;m K.J., and Lischinsky P. (1995):</dt>
<dd><strong>A new model for control of systems with friction.</strong>
    IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.<br><br></dd>
</dl>

</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
          graphics={
            Polygon(
              points={{-50,-50},{-10,-90},{-10,-100},{10,-100},{10,-90},{50,-50},{-50,-50}},
              lineColor={95,95,95},
              fillColor={131,175,131},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-48,-10},{-28,-30}},
              lineColor={0,127,0},
              fillPattern=FillPattern.Sphere,
              fillColor={255,255,255}),
            Ellipse(
              extent={{-10,-10},{10,-30}},
              lineColor={0,127,0},
              fillPattern=FillPattern.Sphere,
              fillColor={255,255,255}),
            Ellipse(
              extent={{30,-10},{50,-30}},
              lineColor={0,127,0},
              fillPattern=FillPattern.Sphere,
              fillColor={255,255,255}),
            Ellipse(
              extent={{-50,30},{-30,10}},
              lineColor={0,127,0},
              fillPattern=FillPattern.Sphere,
              fillColor={255,255,255}),
            Ellipse(
              extent={{-10,30},{10,10}},
              lineColor={0,127,0},
              fillPattern=FillPattern.Sphere,
              fillColor={255,255,255}),
            Ellipse(
              extent={{30,30},{50,10}},
              lineColor={0,127,0},
              fillPattern=FillPattern.Sphere,
              fillColor={255,255,255}),
            Rectangle(
              extent={{-90,10},{90,-10}},
              lineColor={0,127,0},
              fillColor={160,215,160},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,100},{150,60}},
              textString="%name",
              lineColor={0,0,255}),
            Polygon(
              points={{-60,30},{60,30},{60,20},{80,20},{80,50},{-80,50},{-80,20},{-60,20},{-60,30}},
              lineColor={95,95,95},
              fillPattern=FillPattern.Solid,
              fillColor={131,175,131}),
            Line(
              visible=useHeatPort,
              points={{-100,-100},{-100,-20},{0,-20}},
              color={191,0,0},
              pattern=LinePattern.Dot),
            Polygon(
              points={{-60,-30},{60,-30},{60,-20},{80,-20},{80,-50},{-80,-50},{-80,-20},{-60,-20},{-60,-30}},
              lineColor={95,95,95},
              fillPattern=FillPattern.Solid,
              fillColor={131,175,131})}));
    end SupportFriction;

    model Brake "Brake based on Coulomb friction"

      extends Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport2;
      extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
      parameter Real mue_pos[:, 2]=[0, 0.5]
        "[v, f] Positive sliding friction characteristic (v>=0)";
      parameter Real peak(final min=1) = 1
        "Peak for maximum value of mue at w==0 (mue0_max = peak*mue_pos[1,2])";
      parameter Real cgeo(final min=0) = 1
        "Geometry constant containing friction distribution assumption";
      parameter SI.Force fn_max(final min=0, start=1) "Maximum normal force";
      extends Translational.Interfaces.PartialFriction;

      SI.Position s "Absolute position of flange_a and of flange_b";
      SI.Force f "Brake friction force";
      SI.Velocity v "Absolute velocity of flange_a and flange_b";
      SI.Acceleration a "Absolute acceleration of flange_a and flange_b";

      Real mue0 "Friction coefficient for v=0 and forward sliding";
      SI.Force fn "Normal force (=fn_max*f_normalized)";

      // Constant auxiliary variable
      Modelica.Blocks.Interfaces.RealInput f_normalized
        "Normalized force signal 0..1 (normal force = fn_max*f_normalized; brake is active if > 0)"
        annotation (Placement(transformation(
            origin={0,110},
            extent={{20,-20},{-20,20}},
            rotation=90)));
    equation
      mue0 = Modelica.Math.Vectors.interpolate(
            mue_pos[:, 1],
            mue_pos[:, 2],
            0,
            1);

      s = s_a;
      s = s_b;

      // velocity and acceleration of flanges flange_a and flange_b
      v = der(s);
      a = der(v);
      v_relfric = v;
      a_relfric = a;

      // Friction force, normal force and friction force for v_rel=0
      flange_a.f + flange_b.f - f = 0;
      fn = fn_max*f_normalized;
      f0 = mue0*cgeo*fn;
      f0_max = peak*f0;
      free = fn <= 0;

      // Friction force
      f = if locked then sa*unitForce else if free then 0 else cgeo*fn*(if
        startForward then Modelica.Math.Vectors.interpolate(
            mue_pos[:, 1],
            mue_pos[:, 2],
            v,
            1) else if startBackward then -Modelica.Math.Vectors.interpolate(
            mue_pos[:, 1],
            mue_pos[:, 2],
            -v,
            1) else if pre(mode) == Forward then
        Modelica.Math.Vectors.interpolate(
            mue_pos[:, 1],
            mue_pos[:, 2],
            v,
            1) else -Modelica.Math.Vectors.interpolate(
            mue_pos[:, 1],
            mue_pos[:, 2],
            -v,
            1));

      lossPower = f*v_relfric;
      annotation (Documentation(info="<html>
<p>
This component models a <strong>brake</strong>, i.e., a component where a frictional
force is acting between the housing and a flange and a controlled normal
force presses the flange to the housing in order to increase friction.
The normal force fn has to be provided as input signal f_normalized in a normalized form
(0 &le; f_normalized &le; 1),
fn = fn_max*f_normalized, where fn_max has to be provided as parameter.
Friction in the brake is modelled in the following way:
</p>
<p>
When the absolute velocity \"v\" is not zero, the friction force
is a function of the velocity dependent friction coefficient  mue(v) , of
the normal force \"fn\", and of a geometry constant \"cgeo\" which takes into
account the geometry of the device and the assumptions on the friction
distributions:
</p>
<pre>
        frictional_force = <strong>cgeo</strong> * <strong>mue</strong>(v) * <strong>fn</strong>
</pre>
<p>
   Typical values of coefficients of friction:
</p>
<pre>
      dry operation   :  <strong>mue</strong> = 0.2 .. 0.4
      operating in oil:  <strong>mue</strong> = 0.05 .. 0.1
</pre>
<p>
    The positive part of the friction characteristic <strong>mue</strong>(v),
    v >= 0, is defined via table mue_pos (first column = v,
    second column = mue). Currently, only linear interpolation in
    the table is supported.
</p>
<p>
   When the absolute velocity becomes zero, the elements
   connected by the friction element become stuck, i.e., the absolute
   position remains constant. In this phase the friction force is
   calculated from a force balance due to the requirement, that
   the absolute acceleration shall be zero.  The elements begin
   to slide when the friction force exceeds a threshold value,
   called the  maximum static friction force, computed via:
</p>
<pre>
       frictional_force = <strong>peak</strong> * <strong>cgeo</strong> * <strong>mue</strong>(w=0) * <strong>fn</strong>   (<strong>peak</strong> >= 1)
</pre>
<p>
This procedure is implemented in a \"clean\" way by state events and
leads to continuous/discrete systems of equations if friction elements
are dynamically coupled. The method is described in:
</p>
<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><strong>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</strong>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>
<p>
More precise friction models take into account the elasticity of the
material when the two elements are \"stuck\", as well as other effects,
like hysteresis. This has the advantage that the friction element can
be completely described by a differential equation without events. The
drawback is that the system becomes stiff (about 10-20 times slower
simulation) and that more material constants have to be supplied which
requires more sophisticated identification. For more details, see the
following references, especially (Armstrong and Canudas de Wit 1996):
</p>
<dl>
<dt>Armstrong B. (1991):</dt>
<dd><strong>Control of Machines with Friction</strong>. Kluwer Academic
    Press, Boston MA.<br><br></dd>
<dt>Armstrong B., and Canudas de Wit C. (1996):</dt>
<dd><strong>Friction Modeling and Compensation.</strong>
    The Control Handbook, edited by W.S.Levine, CRC Press,
    pp. 1369-1382.<br><br></dd>
<dt>Canudas de Wit C., Olsson H., &Aring;str&ouml;m K.J., and Lischinsky P. (1995):</dt>
<dd><strong>A new model for control of systems with friction.</strong>
    IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.<br><br></dd>
</dl>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Rectangle(
              extent={{-90,10},{90,-10}},
              lineColor={0,127,0},
              fillColor={160,215,160},
              fillPattern=FillPattern.Solid),    Polygon(
                  points={{0,-30},{10,-50},{-10,-50},{0,-30}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),Polygon(
                  points={{10,50},{-10,50},{0,30},{10,50}},
                  lineColor={0,0,127},
                  fillColor={0,0,127},
                  fillPattern=FillPattern.Solid),Line(
                  points={{0,90},{0,50}}, color={0,0,127}),
                                          Rectangle(
                  extent={{20,28},{30,22}},
                  lineColor={175,190,175},
                  fillColor={175,190,175},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{20,-22},{30,-28}},
                  lineColor={175,190,175},
                  fillColor={175,190,175},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{30,28},{36,-102}},
                  lineColor={175,190,175},
                  fillColor={175,190,175},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{14,-96},{30,-102}},
                  lineColor={175,190,175},
                  fillColor={175,190,175},
                  fillPattern=FillPattern.Solid),Line(
                  points={{0,-50},{0,-60},{-40,-50},{-40,48},{0,60},{0,90}}, color={0,0,127}),
                                                                             Text(
                  extent={{-150,-120},{150,-160}},
                  textString="%name",
                  lineColor={0,0,255}),Line(
                  visible=useHeatPort,
                  points={{-100,-102},{-100,-16},{0,-16}},
                  color={191,0,0},
                  pattern=LinePattern.Dot),      Rectangle(
                  extent={{-20,30},{20,20}},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{-20,-20},{20,-30}},
                  fillPattern=FillPattern.Solid)}));
    end Brake;

    model IdealGearR2T
      "Gearbox transforming rotational into translational motion"
      extends Modelica.Mechanics.Rotational.Components.IdealGearR2T;
      annotation (
        Documentation(info="<html>
<p>Couples rotational and translational motion, like a toothed wheel with a toothed rack, specifying the ratio of rotational / translational motion.</p>
</html>"));
    end IdealGearR2T;

    model IdealRollingWheel
      "Simple 1-dim. model of an ideal rolling wheel without inertia"
      extends Modelica.Mechanics.Rotational.Components.IdealRollingWheel;
      annotation (
        Documentation(info="<html>
<p>Couples rotational and translational motion, like an ideal rolling wheel, specifying the wheel radius.</p>
</html>"));
    end IdealRollingWheel;

    model InitializeFlange
      "Initializes a flange with pre-defined position, speed and acceleration (usually, this is reference data from a control bus)"
      extends Modelica.Blocks.Icons.Block;
      parameter Boolean use_s_start=true
        "= true, if initial position is defined by input s_start, otherwise not initialized";
      parameter Boolean use_v_start=true
        "= true, if initial speed is defined by input v_start, otherwise not initialized";
      parameter Boolean use_a_start=true
        "= true, if initial acceleration is defined by input a_start, otherwise not initialized";

      parameter StateSelect stateSelect=StateSelect.default
        "Priority to use flange angle and speed as states";

      Modelica.Blocks.Interfaces.RealInput s_start(unit="m") if use_s_start
        "Initial position of flange" annotation (Placement(transformation(
              extent={{-140,40},{-100,80}})));
      Modelica.Blocks.Interfaces.RealInput v_start(unit="m/s") if use_v_start
        "Initial speed of flange" annotation (Placement(transformation(extent={
                {-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealInput a_start(unit="m/s2") if use_a_start
        "Initial angular acceleration of flange" annotation (Placement(
            transformation(extent={{-140,-80},{-100,-40}})));
      Interfaces.Flange_b flange "Flange that is initialized" annotation (
          Placement(transformation(extent={{90,-10},{110,10}})));

      Modelica.SIunits.Position s_flange(stateSelect=stateSelect) = flange.s
        "Flange position";
      Modelica.SIunits.Velocity v_flange(stateSelect=stateSelect) = der(
        s_flange) "= der(s_flange)";

    protected
      encapsulated model Set_s_start "Set s_start"
        import Modelica;
        extends Modelica.Blocks.Icons.Block;
        Modelica.Blocks.Interfaces.RealInput s_start(unit="m") "Start position"
          annotation (HideResult=true, Placement(transformation(extent={{-140,-20},
                  {-100,20}})));

        Modelica.Mechanics.Translational.Interfaces.Flange_b flange annotation (
           Placement(transformation(extent={{90,-10},{110,10}})));
      initial equation
        flange.s = s_start;
      equation
        flange.f = 0;

      end Set_s_start;

      encapsulated model Set_v_start "Set v_start"
        import Modelica;
        extends Modelica.Blocks.Icons.Block;
        Modelica.Blocks.Interfaces.RealInput v_start(unit="m/s")
          "Start velocity" annotation (HideResult=true, Placement(
              transformation(extent={{-140,-20},{-100,20}})));

        Modelica.Mechanics.Translational.Interfaces.Flange_b flange annotation (
           Placement(transformation(extent={{90,-10},{110,10}})));
      initial equation
        der(flange.s) = v_start;
      equation
        flange.f = 0;

      end Set_v_start;

      encapsulated model Set_a_start "Set a_start"
        import Modelica;
        extends Modelica.Blocks.Icons.Block;
        Modelica.Blocks.Interfaces.RealInput a_start(unit="m/s2")
          "Start acceleration" annotation (HideResult=true, Placement(
              transformation(extent={{-140,-20},{-100,20}})));

        Modelica.Mechanics.Translational.Interfaces.Flange_b flange(s(
              stateSelect=StateSelect.avoid)) annotation (Placement(
              transformation(extent={{90,-10},{110,10}})));
        Modelica.SIunits.Velocity v=der(flange.s) annotation (HideResult=true);
      initial equation
        der(v) = a_start;
      equation
        flange.f = 0;

      end Set_a_start;

      encapsulated model Set_flange_f "Set flange_f to zero"
        import Modelica;
        extends Modelica.Blocks.Icons.Block;
        Modelica.Mechanics.Translational.Interfaces.Flange_b flange annotation (
           Placement(transformation(extent={{90,-10},{110,10}})));
      equation
        flange.f = 0;
      end Set_flange_f;
    protected
      Set_s_start set_s_start if use_s_start annotation (Placement(
            transformation(extent={{-20,50},{0,70}})));
      Set_v_start set_v_start if use_v_start annotation (Placement(
            transformation(extent={{-20,-10},{0,10}})));
      Set_a_start set_a_start if use_a_start annotation (Placement(
            transformation(extent={{-20,-70},{0,-50}})));
      Set_flange_f set_flange_f annotation (Placement(transformation(extent={{
                20,-100},{40,-80}})));
    equation
      connect(set_s_start.flange, flange) annotation (Line(
          points={{0,60},{60,60},{60,0},{100,0}}));
      connect(set_v_start.flange, flange) annotation (Line(
          points={{0,0},{100,0}}));
      connect(set_a_start.flange, flange) annotation (Line(
          points={{0,-60},{60,-60},{60,0},{100,0}}));
      connect(set_flange_f.flange, flange) annotation (Line(
          points={{40,-90},{60,-90},{60,0},{100,0}}));
      connect(s_start, set_s_start.s_start) annotation (Line(
          points={{-120,60},{-22,60}}, color={0,0,127}));
      connect(v_start, set_v_start.v_start) annotation (Line(
          points={{-120,0},{-22,0}}, color={0,0,127}));
      connect(a_start, set_a_start.a_start) annotation (Line(
          points={{-120,-60},{-22,-60}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-94,74},{68,46}},
                  textString="s_start"),Text(
                  extent={{-94,16},{70,-14}},
                  textString="v_start"),Text(
                  extent={{-94,-46},{66,-74}},
                  textString="a_start")}), Documentation(info="<html>
<p>
This component is used to optionally initialize the position, speed,
and/or acceleration of the flange to which this component
is connected. Via parameters use_s_start, use_v_start, use_a_start
the corresponding input signals s_start, v_start, a_start are conditionally
activated. If an input is activated, the corresponding flange property
is initialized with the input value at start time.
</p>

<p>
For example, if \"use_s_start = true\", then flange.s is initialized
with the value of the input signal \"s_start\" at the start time.
</p>

<p>
Additionally, it is optionally possible to define the \"StateSelect\"
attribute of the flange position and the flange speed via parameter
\"stateSelection\".
</p>

<p>
This component is especially useful when the initial values of a flange
shall be set according to reference signals of a controller that are
provided via a signal bus.
</p>

</html>"));
    end InitializeFlange;

    model MassWithStopAndFriction
      "Sliding mass with hard stop and Stribeck friction"
      extends PartialFrictionWithStop;
      SI.Velocity v(start=0, stateSelect=StateSelect.always)
        "Absolute velocity of flange_a and flange_b";
      SI.Acceleration a(start=0)
        "Absolute acceleration of flange_a and flange_b";
      parameter Modelica.SIunits.Mass m(start=1) "Mass";
      parameter Real F_prop(
        final unit="N.s/m",
        final min=0,
        start=1) "Velocity dependent friction";
      parameter Modelica.SIunits.Force F_Coulomb(start=5)
        "Constant friction: Coulomb force";
      parameter Modelica.SIunits.Force F_Stribeck(start=10) "Stribeck effect";
      parameter Real fexp(
        final unit="s/m",
        final min=0,
        start=2) "Exponential decay";
      extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPortWithoutT;
      Integer stopped
        "Mode of stop (-1: hard stop at flange_a, 0: no stop, +1: hard stop at flange_b";
      encapsulated partial model PartialFrictionWithStop
        "Base model of Coulomb friction elements with stop"

        import SI = Modelica.SIunits;
        import Modelica.Mechanics.Translational.Interfaces.PartialRigid;
        parameter SI.Position smax(start=25)
          "Right stop for (right end of) sliding mass";
        parameter SI.Position smin(start=-25)
          "Left stop for (left end of) sliding mass";
        parameter SI.Velocity v_small=1e-3
          "Relative velocity near to zero (see model info text)"
          annotation (Dialog(tab="Advanced"));
        // Equations to define the following variables have to be defined in subclasses
        SI.Velocity v_relfric "Relative velocity between frictional surfaces";
        SI.Acceleration a_relfric
          "Relative acceleration between frictional surfaces";
        SI.Force f
          "Friction force (positive, if directed in opposite direction of v_rel)";
        SI.Force f0 "Friction force for v=0 and forward sliding";
        SI.Force f0_max "Maximum friction force for v=0 and locked";
        Boolean free "true, if frictional element is not active";
        // Equations to define the following variables are given in this class
        Real sa(unit="1")
          "Path parameter of friction characteristic f = f(a_relfric)";
        Boolean startForward(start=false, fixed=true)
          "= true, if v_rel=0 and start of forward sliding or v_rel > v_small";
        Boolean startBackward(start=false, fixed=true)
          "= true, if v_rel=0 and start of backward sliding or v_rel < -v_small";
        Boolean locked(start=false) "true, if v_rel=0 and not sliding";
        extends PartialRigid(s(start=0, stateSelect=StateSelect.always));
        constant Integer Unknown=3 "Value of mode is not known";
        constant Integer Free=2 "Element is not active";
        constant Integer Forward=1 "v_rel > 0 (forward sliding)";
        constant Integer Stuck=0
          "v_rel = 0 (forward sliding, locked or backward sliding)";
        constant Integer Backward=-1 "v_rel < 0 (backward sliding)";
        Integer mode(
          final min=Backward,
          final max=Unknown,
          start=Unknown,
          fixed=true)
          "Mode of friction (-1: backward sliding, 0: stuck, 1: forward sliding, 2: inactive, 3: unknown)";
      protected
        constant SI.Acceleration unitAcceleration=1 annotation (HideResult=true);
        constant SI.Force unitForce=1 annotation (HideResult=true);
      equation
        /* Friction characteristic
   (locked is introduced to help the Modelica translator determining
   the different structural configurations,
   if for each configuration special code shall be generated)
*/
        startForward = pre(mode) == Stuck and (sa > f0_max/unitForce and s < (
          smax - L/2) or pre(startForward) and sa > f0/unitForce and s < (smax
           - L/2)) or pre(mode) == Backward and v_relfric > v_small or initial()
           and (v_relfric > 0);
        startBackward = pre(mode) == Stuck and (sa < -f0_max/unitForce and s >
          (smin + L/2) or pre(startBackward) and sa < -f0/unitForce and s > (
          smin + L/2)) or pre(mode) == Forward and v_relfric < -v_small or
          initial() and (v_relfric < 0);
        locked = not free and not (pre(mode) == Forward or startForward or pre(
          mode) == Backward or startBackward);

        a_relfric/unitAcceleration = if locked then 0 else if free then sa
           else if startForward then sa - f0_max/unitForce else if
          startBackward then sa + f0_max/unitForce else if pre(mode) == Forward
           then sa - f0_max/unitForce else sa + f0_max/unitForce;

        /* Friction torque has to be defined in a subclass. Example for a clutch:
   f = if locked then sa else
       if free then   0 else
       cgeo*fn*(if startForward then          Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], v_relfric, 1) else
                if startBackward then        -Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], -v_relfric, 1) else
                if pre(mode) == Forward then  Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], v_relfric, 1) else
                                             -Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], -v_relfric, 1));
*/
        // finite state machine to determine configuration
        mode = if free then Free else (if (pre(mode) == Forward or pre(mode)
           == Free or startForward) and v_relfric > 0 and s < (smax - L/2)
           then Forward else if (pre(mode) == Backward or pre(mode) == Free or
          startBackward) and v_relfric < 0 and s > (smin + L/2) then Backward
           else Stuck);
        annotation (Documentation(info="<html>
<p>
Basic model for Coulomb friction that models the stuck phase in a reliable way.<br>
Additionally, a left and right stop are handled.
</p>
</html>"));
      end PartialFrictionWithStop;
    equation
      // Constant auxiliary variables
      f0 = (F_Coulomb + F_Stribeck);
      f0_max = f0*1.001;
      free = f0 <= 0 and F_prop <= 0 and s > smin + L/2 and s < smax - L/2;
      // Velocity and acceleration of flanges
      v = der(s);
      a = der(v);
      v_relfric = v;
      a_relfric = a;
      // Equilibrium of forces
      0 = flange_a.f + flange_b.f - f - m*der(v);
      // Friction force
      f = if locked then sa*unitForce else if free then 0 else (if startForward
         then F_prop*v + F_Coulomb + F_Stribeck else if startBackward then
        F_prop*v - F_Coulomb - F_Stribeck else if pre(mode) == Forward then
        F_prop*v + F_Coulomb + F_Stribeck*Modelica.Math.exp(-fexp*abs(v)) else F_prop*v -
        F_Coulomb - F_Stribeck*Modelica.Math.exp(-fexp*abs(v)));
      lossPower = f*v_relfric;
      when (initial()) then
        assert(s > smin + L/2 or s >= smin + L/2 and v >= 0,
          "Error in initialization of hard stop. (s - L/2) must be >= smin\n"
           + "(s=" + String(s) + ", L=" + String(L) + ", smin=" + String(smin)
           + ")");
        assert(s < smax - L/2 or s <= smax - L/2 and v <= 0,
          "Error in initialization of hard stop. (s + L/2) must be <= smax\n"
           + "(s=" + String(s) + ", L=" + String(L) + ", smax=" + String(smax)
           + ")");
      end when;

      // Define events for hard stops and reinitialize the state variables velocity v and position s
      stopped = if s <= smin + L/2 then -1 else if s >= smax - L/2 then +1
         else 0;
      when stopped <> 0 then
        reinit(s, if stopped < 0 then smin + L/2 else smax - L/2);
        reinit(v, 0);
      end when;
      /*
Version 1:

  when not (s < smax - L/2) then
    reinit(s, smax - L/2);
    if (not initial() or v>0) then
      reinit(v, 0);
    end if;
  end when;

  when not (s > smin + L/2) then
    reinit(s, smin + L/2);
    if (not initial() or v<0) then
      reinit(v, 0);
    end if;
  end when;

Version 2:
        stopped := if s <= smin + L/2 then -1 else if s >= smax - L/2 then +1 else 0;
      when (initial()) then
        assert(s > smin + L/2 or s >= smin + L/2 and v >= 0,
          "Error in initialization of hard stop. (s - L/2) must be >= smin\n"+
          "(s=" + String(s) + ", L=" + String(L) + ", smin=" + String(smin) + ")");
        assert(s < smax - L/2 or s <= smax - L/2 and v <= 0,
          "Error in initialization of hard stop. (s + L/2) must be <= smax\n"+
          "(s=" + String(s) + ", L=" + String(L) + ", smax=" + String(smax) + ")");
      end when;
      when stopped <> 0 then
        reinit(s, if stopped < 0 then smin + L/2 else smax - L/2);
        if (not initial() or stopped*v>0) then
           reinit(v, 0);
        end if;
      end when;
*/
      annotation (
        Documentation(info="<html>
<p>This element describes the <em>Stribeck friction characteristics</em> of a sliding mass,
i. e. the frictional force acting between the sliding mass and the support. Included is a
<em>hard stop</em> for the position.</p>
<p>
The surface is fixed and there is friction between sliding mass and surface.
The frictional force f is given for positive velocity v by:
</p>
<blockquote><pre>
f = F_Coulomb + F_prop * v + F_Stribeck * exp (-fexp * v)
</pre></blockquote>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/Stribeck.png\">
</p>

<p>
The distance between the left and the right connector is given by parameter L.
The position of the center of gravity, coordinate s, is in the middle between
the two flanges.</p>
<p>
There are hard stops at smax and smin, i. e. if
<em><code>flange_a.s &gt;= smin</code></em> and <em><code>flange_b.s &lt;= xmax </code></em> the sliding mass can move freely.</p>
<p>When the absolute velocity becomes zero, the sliding mass becomes stuck, i.e., the absolute position remains constant. In this phase the
friction force is calculated from a force balance due to the requirement that the
absolute acceleration shall be zero. The elements begin to slide when the friction
force exceeds a threshold value, called the maximum static friction force, computed via:</p>
<blockquote><pre>
   maximum_static_friction =  F_Coulomb + F_Stribeck
</pre></blockquote>
<p>
<font color=\"#ff0000\"> <strong>This requires the states Stop.s and Stop.v</strong> </font>. If these states are eliminated during the index reduction
the model will not work. To avoid this any inertias should be connected via springs
to the Stop element, other sliding masses, dampers or hydraulic chambers must be avoided.</p>
<p>For more details of the used friction model see the following reference:</p>

<dl>
<dt>Beater P. (1999):</dt>
<dd><a href=\"http://www.springer.de/cgi-bin/search_book.pl?isbn=3-540-65444-5\">
Entwurf hydraulischer Maschinen</a>. Springer Verlag Berlin Heidelberg New York.</dd>
</dl>

<p>The friction model is implemented in a \"clean\" way by state events and leads to
continuous/discrete systems of equations which have to be solved by appropriate
numerical methods. The method is described in
(see also a short sketch in <a href=\"modelica://Modelica.Mechanics.Rotational.UsersGuide.ModelingOfFriction\">UsersGuide.ModelingOfFriction</a>):
</p>

<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E. (1999):</dt>
<dd><em>Hybrid Modeling in Modelica based on the Synchronous Data Flow Principle</em>.
    CACSD'99, Aug. 22.-26, Hawaii. </dd>
</dl>

<p>More precise friction models take into account the elasticity of the material when
the two elements are \"stuck\", as well as other effects, like hysteresis. This has
the advantage that the friction element can be completely described by a differential
equation without events. The drawback is that the system becomes stiff (about 10-20 times
slower simulation) and that more material constants have to be supplied which requires more
sophisticated identification. For more details, see the following references, especially
(Armstrong and Canudas de Wit 1996):</p>
<dl>
<dt>
Armstrong B. (1991):</dt>
<dd><em>Control of Machines with Friction</em>. Kluwer Academic Press, Boston MA.<br>
</dd>
<dt>Armstrong B., and Canudas de Wit C. (1996): </dt>
<dd><em>Friction Modeling and Compensation.</em> The Control Handbook, edited by W.S.Levine, CRC Press, pp. 1369-1382.<br>
</dd>
<dt>Canudas de Wit C., Olsson H., &Aring;str&ouml;m K.J., and Lischinsky P. (1995): </dt>
<dd><em>A new model for control of systems with friction.</em> IEEE Transactions on Automatic Control, Vol. 40, No. 3, pp. 419-425.<br>
</dd>
</dl>

<h4>Optional heatPort</h4>
<p>
The dissipated energy is transported in form of heat to the optional heatPort connector
that can be enabled via parameter \"useHeatPort\". Independently whether the heatPort is
or is not enabled, the dissipated power is defined with variable \"lossPower\".
If contact occurs at the hard stops, the lossPower is not correctly modelled
at this time instant, because the hard stop would introduce a Dirac impulse
in the lossPower due to the discontinuously changing kinetic energy of the mass
(lossPower is the derivative of the kinetic energy at the time instant of the impact).
</p>

</html>", revisions="<html>
<h4>Release Notes:</h4>
<ul>
<li><em>First Version from December 7, 1999 by P. Beater (based on Rotational.BearingFriction)</em></li>
<li><em>July 14, 2001 by P. Beater, assert on initialization added, diagram modified</em></li>
<li><em>October 11, 2001, by Hans Olsson, Dassault Syst&egrave;mes AB, modified assert to handle start at stops,
modified event logic such if you have friction parameters equal to zero you do not get events
between the stops.</em></li>
<li><em>June 10, 2002 by P. Beater, StateSelect.always for variables s and v (instead of fixed=true). </em></li>
</ul>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
          graphics={
            Line(points={{-100,0},{100,0}},color={0,127,0}),
            Polygon(
              points={{80,-100},{50,-90},{50,-110},{80,-100}},
              lineColor={95,127,95},
              fillColor={95,127,95},
              fillPattern=FillPattern.Solid),
            Line(points={{-40,-100},{50,-100}}, color={95,127,95}),
            Rectangle(
              extent={{-30,30},{30,-30}},
              fillPattern=FillPattern.Sphere,
              fillColor={166,221,166},
              lineColor={0,127,0}),
            Rectangle(
              extent={{-64,-16},{-56,-46}},
              fillPattern=FillPattern.Solid,
              lineColor={0,127,0},
              fillColor={0,127,0}),
            Rectangle(
              extent={{56,-16},{64,-46}},
              fillPattern=FillPattern.Solid,
              lineColor={0,127,0},
              fillColor={0,127,0}),
            Text( extent={{-150,80},{150,40}},
                  textString="%name",
                  lineColor={0,0,255}),
            Line(points={{-50,-90},{-28,-68}}, color={0,127,0}),
            Line(points={{-30,-90},{-8,-68}}, color={0,127,0}),
            Line(points={{-10,-90},{12,-68}}, color={0,127,0}),
            Line(points={{10,-90},{32,-68}}, color={0,127,0}),
            Text(
              extent={{-150,-110},{150,-140}},
              textString="m=%m"),
            Line(
              visible=useHeatPort,
              points={{-100,-100},{-100,-40},{3,-40}},
              color={191,0,0},
              pattern=LinePattern.Dot),
            Rectangle(
              extent={{-70,-46},{70,-70}},
              fillColor={160,215,160},
              fillPattern=FillPattern.Solid,
              lineColor={0,127,0})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
          graphics={
            Polygon(
              points={{50,-75},{20,-65},{20,-85},{50,-75}},
              lineColor={128,128,128},
              fillColor={128,128,128},
              fillPattern=FillPattern.Solid),
            Line(points={{-60,-75},{20,-75}}),
            Rectangle(
              extent={{-30,26},{35,-9}},
              fillPattern=FillPattern.Sphere,
              fillColor={255,255,255}),
            Line(points={{-90,0},{-30,0}}, color={0,127,0}),
            Line(points={{35,0},{90,0}}, color={0,127,0}),
            Rectangle(
              extent={{-68,-14},{76,-29}},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-119,43},{-111,17}},
              fillPattern=FillPattern.Solid),
            Line(points={{-111,43},{-111,50}}),
            Line(points={{-151,49},{-113,49}}),
            Text(
              extent={{-149,51},{-126,60}},
              textString="s min",
              lineColor={0,0,255}),
            Polygon(
              points={{-121,52},{-111,49},{-121,46},{-121,52}},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{124,42},{132,17}},
              fillPattern=FillPattern.Solid),
            Line(points={{124,39},{124,87}}),
            Line(points={{-19,78},{121,78}}),
            Text(
              extent={{-17,83},{6,92}},
              textString="s max",
              lineColor={0,0,255}),
            Polygon(
              points={{114,81},{124,78},{114,75},{114,81}},
              fillPattern=FillPattern.Solid),
            Line(
              points={{5,26},{5,63}}),
            Line(
              points={{-77,58},{-1,58}}),
            Text(
              extent={{-75,60},{-38,71}},
              textString="Position s",
              lineColor={0,0,255}),
            Polygon(
              points={{-5,61},{5,58},{-5,55},{-5,61}},
              fillPattern=FillPattern.Solid),
            Line(points={{-100,-10},{-100,-60}}),
            Line(points={{100,-10},{100,-60}}),
            Polygon(
              points={{90,-47},{100,-50},{90,-53},{90,-47}},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-90,-47},{-90,-53},{-100,-50},{-90,-47}},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,-50},{92,-50}}),
            Text(
              extent={{-11,-46},{26,-36}},
              textString="Length L",
              lineColor={0,0,255})}));
    end MassWithStopAndFriction;

    model RelativeStates "Definition of relative state variables"
      extends Translational.Interfaces.PartialTwoFlanges;
      parameter StateSelect stateSelect=StateSelect.prefer
        "Priority to use the relative angle and relative speed as states";
      SI.Position s_rel(start=0, stateSelect=StateSelect.prefer)
        "Relative position used as state variable";
      SI.Velocity v_rel(start=0, stateSelect=StateSelect.prefer)
        "Relative velocity used as state variable";
      SI.Acceleration a_rel(start=0) "Relative angular acceleration";

    equation
      s_rel = flange_b.s - flange_a.s;
      v_rel = der(s_rel);
      a_rel = der(v_rel);
      flange_a.f = 0;
      flange_b.f = 0;
      annotation (
        Documentation(info="<html>
<p>
Usually, the absolute position and the absolute velocity of
Modelica.Mechanics.Translational.Inertia models are used as state variables.
In some circumstances, relative quantities are better suited, e.g.,
because it may be easier to supply initial values.
In such cases, model <strong>RelativeStates</strong> allows the definition of state variables
in the following way:
</p>
<ul>
<li> Connect an instance of this model between two flange connectors.</li>
<li> The <strong>relative position</strong> and the <strong>relative velocity</strong>
     between the two connectors are used as <strong>state variables</strong>.</li>
</ul>
<p>
An example is given in the next figure
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/relativeStates2.png\" alt=\"relativeStates2\">
</p>

<p>
Here, the relative position and the relative velocity between
the two masses are used as state variables. Additionally, the
simulator selects either the absolute position and absolute
velocity of model mass1 or of model mass2 as state variables.
</p>

</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={ Line(
                  points={{-100,0},{100,0}},
                  pattern=LinePattern.Dot,
              color={0,127,0}),
            Ellipse(
              extent={{-40,40},{40,-40}},
              lineColor={52,219,218},
              fillColor={52,219,218},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-40,40},{40,-40}},
              textString="S",
              lineColor={0,0,255}),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Line(
              points={{-100,0},{100,0}},
              pattern=LinePattern.Dash,
              color={0,127,0}),
            Ellipse(
              extent={{-40,40},{40,-40}},
              lineColor={52,219,218},
              fillColor={52,219,218},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-40,40},{40,-40}},
              textString="S",
              lineColor={0,0,255}),
            Line(points={{-100,-10},{-100,-80}},
              color={160,160,164}),
            Line(points={{100,-10},{100,-80}}, color={
              160,160,164}),
            Polygon(
                  points={{80,-65},{80,-55},{100,-60},{80,-65}},
                  lineColor={160,160,164},
                  fillColor={160,160,164},
                  fillPattern=FillPattern.Solid),Line(points={{-100,-60},{80,-60}},
              color={160,160,164}),Text(
                  extent={{-30,-70},{30,-90}},
                  textString="v_rel",
                  lineColor={0,0,255}),Line(points={{-76,80},{-5,80}}, color={
              128,128,128}),Polygon(
                  points={{14,80},{-6,85},{-6,75},{14,80}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{18,87},{86,74}},
                  lineColor={128,128,128},
                  textString="moving direction")}));
    end RelativeStates;

    model GeneralForceToPositionAdaptor
      "Signal adaptor for a Translational flange with position, speed, and acceleration as outputs and force as input (especially useful for FMUs)"
      extends Modelica.Blocks.Interfaces.Adaptors.FlowToPotentialAdaptor(
        final Name_p="s",
        final Name_pder="v",
        final Name_pder2="a",
        final Name_f="f",
        final Name_fder="der(f)",
        final Name_fder2="der2(f)",
        final use_fder=false,
        final use_fder2=false,
        final p(unit="m"),
        final pder(unit="m/s"),
        final pder2(unit="m/s2"),
        final f(unit="N"),
        final fder(unit="N/s"),
        final fder2(unit="N/s2"));
      Modelica.Mechanics.Translational.Interfaces.Flange_a flange
        annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
    equation
      y = flange.s "output = potential = position";
      u = flange.f "input = flow = force";
      annotation (
        defaultComponentName="forceToPositionAdaptor",
        Documentation(info="<html>
<p>
Adaptor between a flange connector and a signal representation of the flange.
This component is used to provide a pure signal interface around a Translational model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>).
Examples of the usage of this adaptor are provided in
<a href=\"modelica://Modelica.Mechanics.Translational.Examples.GenerationOfFMUs\">Translational.Examples.GenerationOfFMUs</a>.
This adaptor has force as input and position, velocity and acceleration as output signals.
</p>
</html>"),     Icon(graphics={
                Rectangle(
                  extent={{-20,100},{20,-100}},
                  lineColor={0,127,0},
                  radius=10,
              lineThickness=0.5)}));
    end GeneralForceToPositionAdaptor;

    model GeneralPositionToForceAdaptor
      "Signal adaptor for a Translational flange with force as output and position, speed and acceleration as input (especially useful for FMUs)"
      extends Modelica.Blocks.Interfaces.Adaptors.PotentialToFlowAdaptor(
        final Name_p="s",
        final Name_pder="v",
        final Name_pder2="a",
        final Name_f="f",
        final Name_fder="der(f)",
        final Name_fder2="der2(f)",
        final use_fder=false,
        final use_fder2=false,
        final p(unit="m"),
        final pder(unit="m/s"),
        final pder2(unit="m/s2"),
        final f(unit="N"),
        final fder(unit="N/s"),
        final fder2(unit="N/s2"));
      Modelica.Mechanics.Translational.Interfaces.Flange_b flange
        annotation (Placement(transformation(extent={{10,-10},{30,10}}),
            iconTransformation(extent={{10,-10},{30,10}})));
    equation
      y = flange.f "output = flow = force";
      u = flange.s "input = potential = position";
      annotation (
        defaultComponentName="positionToForceAdaptor",
        Documentation(info="<html>
<p>
Adaptor between a flange connector and a signal representation of the flange.
This component is used to provide a pure signal interface around a Translational model
and export this model in form of an input/output block,
especially as FMU (<a href=\"https://www.fmi-standard.org\">Functional Mock-up Unit</a>).
Examples of the usage of this adaptor are provided in
<a href=\"modelica://Modelica.Mechanics.Translational.Examples.GenerationOfFMUs\">Translational.Examples.GenerationOfFMUs</a>.
This adaptor has position, velocity and acceleration as input signals and
force as output signal.
</p>
<p>
Note, the input signals must be consistent to each other
(v=der(s), a=der(v)).
</p>
</html>"), Icon(graphics={
                Rectangle(
                  extent={{-20,100},{20,-100}},
                  lineColor={0,127,0},
                  radius=10,
              lineThickness=0.5)}));
    end GeneralPositionToForceAdaptor;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={Rectangle(
            origin={11.5,31.183},
            lineColor={64,64,64},
            fillColor={255,255,255},
            fillPattern=FillPattern.Sphere,
            extent={{-67,-66},{44,-6}})}), Documentation(info="<html>
<p>
This package contains basic components 1D mechanical translational drive trains.
</p>
</html>"));
  end Components;

  package Sensors "Sensors for 1-dim. translational mechanical quantities"

    extends Modelica.Icons.SensorsPackage;

    model PositionSensor "Ideal sensor to measure the absolute position"
      extends Translational.Interfaces.PartialAbsoluteSensor;
      Modelica.Blocks.Interfaces.RealOutput s(unit="m")
        "Absolute position of flange as output signal" annotation (Placement(
            transformation(extent={{100,-11},{120,9}}),
            iconTransformation(extent={{100,-10},{120,10}})));

    equation
      s = flange.s;
      annotation (
        Documentation(info="<html>
<p>
Measures the <em>absolute position s</em> of a flange in an ideal way and provides the result as
output signals (to be further processed with blocks of the
Modelica.Blocks library).
</p>

</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
              Text(
                  extent={{80,-28},{114,-62}},
                  textString="s")}));
    end PositionSensor;

    model SpeedSensor "Ideal sensor to measure the absolute velocity"
      extends Translational.Interfaces.PartialAbsoluteSensor;
      Modelica.Blocks.Interfaces.RealOutput v(unit="m/s")
        "Absolute velocity of flange as output signal" annotation (Placement(
            transformation(extent={{100,-10},{120,10}})));

    equation
      v = der(flange.s);
      annotation (
        Documentation(info="<html>
<p>
Measures the <em>absolute velocity v</em> of a flange in an ideal way and provides the result as
output signals (to be further processed with blocks of the
Modelica.Blocks library).
</p>

</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
              Text(
                  extent={{80,-28},{111,-61}},
                  textString="v")}));
    end SpeedSensor;

    model AccSensor "Ideal sensor to measure the absolute acceleration"
      extends Translational.Interfaces.PartialAbsoluteSensor;
      SI.Velocity v "Absolute velocity of flange";
      Modelica.Blocks.Interfaces.RealOutput a(unit="m/s2")
        "Absolute acceleration of flange as output signal" annotation (
          Placement(transformation(extent={{100,-10},{120,10}})));

    equation
      v = der(flange.s);
      a = der(v);
      annotation (
        Documentation(info="<html>
<p>
Measures the <em>absolute acceleration a</em>
of a flange in an ideal way and provides the result as
output signals (to be further processed with blocks of the
Modelica.Blocks library).
</p>

</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
              Text(
                  extent={{80,-28},{115,-60}},
                  textString="a")}));
    end AccSensor;

    model RelPositionSensor "Ideal sensor to measure the relative position"
      extends Translational.Interfaces.PartialRelativeSensor;
      Modelica.Blocks.Interfaces.RealOutput s_rel(unit="m")
        "Distance between two flanges (= flange_b.s - flange_a.s) as output signal"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-110})));

    equation
      s_rel = flange_b.s - flange_a.s;
      0 = flange_a.f;
      annotation (
        Documentation(info="<html>
<p>
Measures the <em>relative position s</em> of a flange in an ideal way and provides the result as
output signals (to be further processed with blocks of the
Modelica.Blocks library).
</p>

</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={                        Text(
                  extent={{8,-68},{42,-102}},
                  textString="s"),Line(points={{0,-99},{0,-60}}, color={0,0,127})}));
    end RelPositionSensor;

    model RelSpeedSensor "Ideal sensor to measure the relative speed"
      extends Translational.Interfaces.PartialRelativeSensor;
      SI.Position s_rel
        "Distance between the two flanges (flange_b.s - flange_a.s)";
      Modelica.Blocks.Interfaces.RealOutput v_rel(unit="m/s")
        "Relative velocity between two flanges (= der(flange_b.s) - der(flange_a.s)) as output signal"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-110})));

    equation
      s_rel = flange_b.s - flange_a.s;
      v_rel = der(s_rel);
      0 = flange_a.f;
      annotation (
        Documentation(info="<html>
<p>
Measures the <em>relative speed v</em> of a flange in an ideal way and provides the result as
output signals (to be further processed with blocks of the
Modelica.Blocks library).
</p>

</html>", revisions="<html>
<p><strong>Release Notes:</strong></p>
<ul>
<li><em>First Version from August 26, 1999 by P. Beater</em></li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={                        Text(
                  extent={{8,-68},{42,-102}},
                  textString="v"),Line(points={{0,-100},{0,-61}}, color={0,0,
              127})}));
    end RelSpeedSensor;

    model RelAccSensor "Ideal sensor to measure the relative acceleration"
      extends Translational.Interfaces.PartialRelativeSensor;
      SI.Position s_rel
        "Distance between the two flanges (flange_b.s - flange_a.s)";
      SI.Velocity v_rel
        "Relative velocity between the two flanges (der(flange_b.s) - der(flange_a.s))";
      Modelica.Blocks.Interfaces.RealOutput a_rel(unit="m/s2")
        "Relative acceleration between two flanges (= der(v_rel)) as output signal"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-110})));

    equation
      s_rel = flange_b.s - flange_a.s;
      v_rel = der(s_rel);
      a_rel = der(v_rel);
      0 = flange_a.f;
      annotation (
        Documentation(info="<html>
<p>
Measures the <em>relative acceleration a</em> of a flange in an ideal way and provides the result as
output signals (to be further processed with blocks of the
Modelica.Blocks library).
</p>

</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={                        Text(
                  extent={{7,-68},{41,-102}},
                  textString="a"),Line(points={{0,-99},{0,-60}}, color={0,0,127})}));
    end RelAccSensor;

    model ForceSensor "Ideal sensor to measure the force between two flanges"
      extends Translational.Interfaces.PartialRelativeSensor;
      Modelica.Blocks.Interfaces.RealOutput f(unit="N")
        "Force in flange_a and flange_b (f = flange_a.f = -flange_b.f) as output signal"
        annotation (Placement(transformation(
            origin={-80,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));
    equation
      flange_a.s = flange_b.s;
      flange_a.f = f;
      annotation (
        Documentation(info="<html>
<p>
Measures the <em>cut-force between two flanges</em> in an ideal way
and provides the result as output signal (to be further processed
with blocks of the Modelica.Blocks library).
</p>

</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Text(
                  extent={{-40,-70},{40,-120}},
                  textString="f"),         Line(points={{-80,-100},
              {-80,0}}, color={0,0,127})}));
    end ForceSensor;

    model PowerSensor
      "Ideal sensor to measure the power between two flanges (= flange_a.f*der(flange_a.s))"
      extends Translational.Interfaces.PartialRelativeSensor;
      Modelica.Blocks.Interfaces.RealOutput power(unit="W")
        "Power in flange flange_a as output signal" annotation (Placement(
            transformation(
            origin={-80,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));
    equation
      flange_a.s = flange_b.s;
      power = flange_a.f*der(flange_a.s);
      annotation (
        Documentation(info="<html>
<p>
Measures the <strong>power between two flanges</strong> in an ideal way
and provides the result as output signal <strong>power</strong>
(to be further processed with blocks of the Modelica.Blocks library).
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Text(
                  extent={{-75,-79},{67,-119}},
                  textString="power"),     Line(points={{-80,
              -100},{-80,0}}, color={0,0,127})}));
    end PowerSensor;

    model MultiSensor
      "Ideal sensor to measure the absolute velocity, force and power between two flanges"
      extends Translational.Interfaces.PartialRelativeSensor;
      Modelica.Blocks.Interfaces.RealOutput power(unit="W")
        "Power in flange flange_a as output signal" annotation (Placement(
            transformation(
            origin={-60,-110},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.Blocks.Interfaces.RealOutput f(unit="N")
        "Force in flange_a and flange_b (f = flange_a.f = -flange_b.f) as output signal"
        annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={0,-110})));
      Modelica.Blocks.Interfaces.RealOutput v(unit="m/s")
        "Absolute velocity of flange as output signal as output signal"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={60,-110})));
    equation
      flange_a.s = flange_b.s;
      f = flange_a.f;
      v = der(flange_a.s);
      power = f*v;

      annotation (
        Documentation(info="<html>
<p>
Measures the <strong>absolute velocity</strong> of a flange_a, the <strong>cut-force</strong> and <strong>power</strong> between two flanges in an
ideal way and provides the results as output signals <strong>v</strong>, <strong>f</strong> and <strong>power</strong>, respectively.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Text(
                  extent={{-146,-70},{-56,-100}},
                  textString="power"),     Line(points={{-60,
              -100},{-60,-60}}, color={0,0,127}),Text(
                  extent={{-28,-71},{52,-101}},
                  textString="f"),Line(points={{0,-100},{0,-60}}, color={0,0,127}),
              Line(points={{60,-100},{60,-60}}, color={0,0,127}),Text(
                  extent={{60,-70},{114,-101}},
                  textString="v")}));
    end MultiSensor;
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Line(points={{-56,-61},{-56,-81}}),
          Line(points={{-36,-61},{-36,-81}}),
          Line(points={{-16,-61},{-16,-81}}),
          Line(points={{4,-61},{4,-81}}),
          Line(points={{24,-61},{24,-81}}),
          Line(points={{44,-61},{44,-81}})}), Documentation(info=
           "<html>
<p>
This package contains ideal sensor components that provide
the connector variables as signals for further processing with the
Modelica.Blocks library.
</p>
</html>"));
  end Sensors;

  package Sources "Sources to drive 1D translational mechanical components"
    extends Modelica.Icons.SourcesPackage;

    model Position
      "Forced movement of a flange according to a reference position"
      extends
        Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2(
         s(stateSelect=if exact then StateSelect.default else StateSelect.prefer));
      parameter Boolean exact=false
        "Is true/false for exact treatment/filtering of the input signal, respectively";
      parameter SI.Frequency f_crit=50
        "If exact=false, critical frequency of filter to filter input signal"
        annotation (Dialog(enable=not exact));
      SI.Velocity v(start=0, stateSelect=if exact then StateSelect.default
             else StateSelect.prefer)
        "If exact=false, absolute velocity of flange else dummy";
      SI.Acceleration a(start=0)
        "If exact=false, absolute acceleration of flange else dummy";
      Modelica.Blocks.Interfaces.RealInput s_ref(unit="m")
        "Reference position of flange as input signal" annotation (Placement(
            transformation(extent={{-140,-20},{-100,20}})));
    protected
      parameter Modelica.SIunits.AngularFrequency w_crit=2*Modelica.Constants.pi
          *f_crit "Critical frequency";
      constant Real af=1.3617 "s coefficient of Bessel filter";
      constant Real bf=0.6180 "s*s coefficient of Bessel filter";

    initial equation
      if not exact then
        s = s_ref;
      end if;
    equation
      if exact then
        s = s_ref;
        v = 0;
        a = 0;
      else
        // Filter: a = s_ref*S^2/(1 + (af/w_crit)*S + (bf/w_crit^2)*S^2)
        v = der(s);
        a = der(v);
        a = ((s_ref - s)*w_crit - af*v)*(w_crit/bf);
      end if;

      annotation (
        Documentation(info="<html>
<p>
The input signal <strong>s_ref</strong> defines the <strong>reference
position</strong> in [m]. Flange <strong>flange</strong> is <strong>forced</strong>
to move relative to the support connector according to this reference motion. According to parameter
<strong>exact</strong> (default = <strong>false</strong>), this is done in the following way:
</p>
<ol>
<li><strong>exact=true</strong><br>
    The reference position is treated <strong>exactly</strong>. This is only possible, if
    the input signal is defined by an analytical function which can be
    differentiated at least twice. If this prerequisite is fulfilled,
    the Modelica translator will differentiate the input signal twice
    in order to compute the reference acceleration of the flange.</li>
<li><strong>exact=false</strong><br>
    The reference position is <strong>filtered</strong> and the second derivative
    of the filtered curve is used to compute the reference acceleration
    of the flange. This second derivative is <strong>not</strong> computed by
    numerical differentiation but by an appropriate realization of the
    filter. For filtering, a second order Bessel filter is used.
    The critical frequency (also called cut-off frequency) of the
    filter is defined via parameter <strong>f_crit</strong> in [Hz]. This value
    should be selected in such a way that it is higher as the essential
    low frequencies in the signal.</li>
</ol>
<p>
The input signal can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>

</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
          graphics={
            Rectangle(
              extent={{-100,20},{100,-20}},
              lineColor={0,127,0},
              fillColor={160,215,160},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{150,60},{-150,100}},
              textString="%name",
              lineColor={0,0,255}),
            Line(points={{0,52},{0,32}}, color={0,127,0}),
            Line(points={{-29,32},{30,32}}, color={0,127,0}),
            Line(points={{-30,-32},{30,-32}}, color={0,127,0}),
            Line(points={{0,-32},{0,-100}}, color={0,127,0}),
            Text(extent={{30,-60},{150,-30}},
              textString="exact="),
            Text(extent={{30,-90},{150,-60}},
              textString="%exact"),
            Text(extent={{-140,-60},{-40,-30}},
              lineColor={128,128,128},
              horizontalAlignment=TextAlignment.Right,
              textString="s_ref")}));
    end Position;

    model Speed "Forced movement of a flange according to a reference speed"
      extends
        Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2(
         s(
          start=0,
          fixed=true,
          stateSelect=StateSelect.prefer));
      parameter Boolean exact=false
        "Is true/false for exact treatment/filtering of the input signal, respectively";
      parameter SI.Frequency f_crit=50
        "If exact=false, critical frequency of filter to filter input signal"
        annotation (Dialog(enable=not exact));
      SI.Velocity v(stateSelect=if exact then StateSelect.default else
            StateSelect.prefer) "Absolute velocity of flange";
      SI.Acceleration a
        "If exact=false, absolute acceleration of flange else dummy";
      Modelica.Blocks.Interfaces.RealInput v_ref(unit="m/s")
        "Reference speed of flange as input signal" annotation (Placement(
            transformation(extent={{-140,-20},{-100,20}})));

    protected
      parameter Modelica.SIunits.AngularFrequency w_crit=2*Modelica.Constants.pi
          *f_crit "Critical frequency";
    initial equation
      if not exact then
        v = v_ref;
      end if;
    equation
      v = der(s);
      if exact then
        v = v_ref;
        a = 0;
      else
        // Filter: a = v_ref/(1 + (1/w_crit)*s)
        a = der(v);
        a = (v_ref - v)*w_crit;
      end if;

      annotation (
        Documentation(info="<html>
<p>
The input signal <strong>v_ref</strong> defines the <strong>reference
speed</strong> in [m/s]. Flange <strong>flange</strong> is <strong>forced</strong>
to move relative to the support connector  according to this reference motion. According to parameter
<strong>exact</strong> (default = <strong>false</strong>), this is done in the following way:
</p>
<ol>
<li><strong>exact=true</strong><br>
    The reference speed is treated <strong>exactly</strong>. This is only possible, if
    the input signal is defined by an analytical function which can be
    differentiated at least once. If this prerequisite is fulfilled,
    the Modelica translator will differentiate the input signal once
    in order to compute the reference acceleration of the flange.</li>
<li><strong>exact=false</strong><br>
    The reference speed is <strong>filtered</strong> and the first derivative
    of the filtered curve is used to compute the reference acceleration
    of the flange. This first derivative is <strong>not</strong> computed by
    numerical differentiation but by an appropriate realization of the
    filter. For filtering, a first order filter is used.
    The critical frequency (also called cut-off frequency) of the
    filter is defined via parameter <strong>f_crit</strong> in [Hz]. This value
    should be selected in such a way that it is higher as the essential
    low frequencies in the signal.</li>
</ol>
<p>
The input signal can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>

</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
          graphics={
            Line(points={{-30,-32},{30,-32}}, color={0,127,0}),
            Line(points={{0,-32},{0,-100}}, color={0,127,0}),
            Rectangle(
              extent={{-100,20},{100,-20}},
              lineColor={0,127,0},
              fillColor={160,215,160},
              fillPattern=FillPattern.Solid),
            Line(points={{-29,32},{30,32}}, color={0,127,0}),
            Line(points={{0,52},{0,32}}, color={0,127,0}),
            Text(
              extent={{150,60},{-150,100}},
              textString="%name",
              lineColor={0,0,255}),
            Text(extent={{-140,-60},{-40,-30}},
              lineColor={128,128,128},
              horizontalAlignment=TextAlignment.Right,
              textString="v_ref"),
            Text(extent={{30,-60},{150,-30}},
              textString="exact="),
            Text(extent={{30,-90},{150,-60}},
              textString="%exact")}));
    end Speed;

    model Accelerate
      "Forced movement of a flange according to an acceleration signal"
      extends
        Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2(
        s(start=0,
          fixed=true,
          stateSelect=StateSelect.prefer));
      SI.Velocity v(
        start=0,
        fixed=true,
        stateSelect=StateSelect.prefer) "Absolute velocity of flange";
      SI.Acceleration a "Absolute acceleration of flange";

      Modelica.Blocks.Interfaces.RealInput a_ref(unit="m/s2")
        "Absolute acceleration of flange as input signal" annotation (Placement(
            transformation(extent={{-140,-20},{-100,20}})));

    equation
      v = der(s);
      a = der(v);
      a = a_ref;

      annotation (
        Documentation(info="<html>
<p>
The input signal <strong>a</strong> in [m/s2] moves the 1D translational flange
connector flange with a predefined <em>acceleration</em>, i.e., the flange
is <em>forced</em> to move relative to the support connector  with this acceleration. The velocity and the
position of the flange are also predefined and are determined by
integration of the acceleration.
</p>
<p>
The acceleration \"a(t)\" can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Source.
</p>

</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
          graphics={
            Line(points={{-30,-32},{30,-32}}, color={0,127,0}),
            Line(points={{0,-32},{0,-100}}, color={0,127,0}),
            Rectangle(
              extent={{-100,20},{100,-20}},
              lineColor={0,127,0},
              fillColor={160,215,160},
              fillPattern=FillPattern.Solid),
            Line(points={{-29,32},{30,32}}, color={0,127,0}),
            Line(points={{0,52},{0,32}}, color={0,127,0}),
            Text(extent={{150,60},{-150,100}},
              textString="%name",
              lineColor={0,0,255}),
            Text(extent={{-140,-60},{-40,-30}},
              lineColor={128,128,128},
              horizontalAlignment=TextAlignment.Right,
              textString="a_ref")}));
    end Accelerate;

    model Move
      "Forced movement of a flange according to a position, velocity and acceleration signal"
      extends
        Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2;
      Modelica.Blocks.Interfaces.RealInput u[3]
        "Position, velocity and acceleration of flange as input signals"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    protected
      function position
        extends Modelica.Icons.Function;
        input Real q_qd_qdd[3]
          "Required values for position, speed, acceleration";
        input Real dummy
          "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
        output Real q;
      algorithm
        q := q_qd_qdd[1];
        annotation (derivative(noDerivative=q_qd_qdd) = position_der, LateInline=true);
      end position;

      function position_der
        extends Modelica.Icons.Function;
        input Real q_qd_qdd[3]
          "Required values for position, speed, acceleration";
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
        input Real q_qd_qdd[3]
          "Required values for position, speed, acceleration";
        input Real dummy
          "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
        input Real dummy_der;
        input Real dummy_der2;
        output Real qdd;
      algorithm
        qdd := q_qd_qdd[3];
      end position_der2;
    equation
      s = position(u, time);

      annotation (
        Documentation(info="<html>
<p>
Flange <strong>flange_b</strong> is <strong>forced</strong> to move relative to the support connector with a predefined motion
according to the input signals:
</p>
<pre>
    u[1]: position of flange
    u[2]: velocity of flange
    u[3]: acceleration of flange
</pre>
<p>
The user has to guarantee that the input signals are consistent to each other,
i.e., that u[2] is the derivative of u[1] and that
u[3] is the derivative of u. There are, however,
also applications where by purpose these conditions do not hold. For example,
if only the position dependent terms of a mechanical system shall be
calculated, one may provide position = position(t) and set the velocity
and the acceleration to zero.
</p>
<p>
The input signals can be provided from one of the signal generator
blocks of the block library Modelica.Blocks.Sources.
</p>

</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
          graphics={
            Line(points={{-30,-32},{30,-32}}, color={0,127,0}),
            Line(points={{0,-32},{0,-100}}, color={0,127,0}),
            Rectangle(
              extent={{-100,20},{100,-20}},
              lineColor={0,127,0},
              fillColor={160,215,160},
              fillPattern=FillPattern.Solid),
            Line(points={{0,52},{0,32}}, color={0,127,0}),
            Line(points={{-29,32},{30,32}}, color={0,127,0}),
          Text(
            extent={{150,60},{-150,100}},
            textString="%name",
            lineColor={0,0,255}),
          Text(extent={{-140,-60},{-40,-30}},
            lineColor={128,128,128},
            horizontalAlignment=TextAlignment.Right,
            textString="s,v,a")}));
    end Move;

    model Force
      "External force acting on a drive train element as input signal"
      extends Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2;
      Modelica.Blocks.Interfaces.RealInput f(unit="N")
        "Driving force as input signal" annotation (Placement(transformation(
              extent={{-140,-20},{-100,20}})));

    equation
      flange.f = -f;

      annotation (
        Documentation(info="<html>
<p>
The input signal \"f\" in [N] characterizes an <em>external
force</em> which acts (with positive sign) at a flange,
i.e., the component connected to the flange is driven by force f.
</p>
<p>
Input signal f can be provided from one of the signal generator
blocks of Modelica.Blocks.Source.
</p>
</html>"),
        Icon(
          coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}),
          graphics={
            Line(points={{0,-60},{0,-101}}, color={0,127,0}),
            Polygon(
              points={{-100,10},{20,10},{20,41},{90,0},{20,-41},{20,-10},{-100,-10},{-100,10}},
              lineColor={0,127,0},
              fillColor={160,215,160},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,-32},{-80,-62}},
              textString="f"),
            Text(
              extent={{-150,90},{150,50}},
              textString="%name",
              lineColor={0,0,255}),
            Polygon(
              points={{50,-54},{-30,-54},{-30,-46},{-60,-60},{-30,-74},{-30,-66},{50,-66},{50,-54}},
              lineColor={0,127,0},
              fillColor={160,215,160},
              fillPattern=FillPattern.Solid)}));
    end Force;

    model Force2 "Input signal acting as torque on two flanges"
      extends Translational.Interfaces.PartialTwoFlanges;
      Modelica.Blocks.Interfaces.RealInput f(unit="N")
        "Driving force as input signal" annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,60}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,40})));

    equation
      flange_a.f = f;
      flange_b.f = -f;
      annotation (defaultComponentName="force",
        Documentation(info="<html>
<p>
The input signal \"f\" in [N] characterizes an <em>external
force</em> which acts (with positive sign) at both flanges,
i.e., the components connected to these flanges are driven by force f.
</p>
<p>
Input signal s can be provided from one of the signal generator
blocks of Modelica.Blocks.Source.
</p>

</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Text(
                  extent={{-150,-40},{150,-80}},
                  textString="%name",
                  lineColor={0,0,255}),Polygon(
              points={{90,0},{60,-30},{60,-10},{10,-10},{10,10},{60,10},{60,30},{90,0}},
              lineColor={0,127,0},
              fillColor={160,215,160},
              fillPattern=FillPattern.Solid),    Polygon(
              points={{-90,0},{-60,30},{-60,10},{-10,10},{-10,-10},{-60,-10},{-60,-30},{-90,0}},
              lineColor={0,127,0},
              fillColor={160,215,160},
              fillPattern=FillPattern.Solid)}));
    end Force2;

    model LinearSpeedDependentForce "Linear dependency of force versus speed"
      extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
      parameter Modelica.SIunits.Force f_nominal
        "Nominal force (if negative, force is acting as load)";
      parameter Boolean ForceDirection=true
        "Same direction of force in both directions of movement";
      parameter Modelica.SIunits.Velocity v_nominal(min=Modelica.Constants.eps)
        "Nominal speed";
      Modelica.SIunits.Velocity v
        "Velocity of flange with respect to support (= der(s))";

    equation
      v = der(s);
      if ForceDirection then
        f = -f_nominal*abs(v/v_nominal);
      else
        f = -f_nominal*(v/v_nominal);
      end if;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
              Line(points={{-75,0},{75,0}}, color={192,192,192}),
              Line(points={{0,60},{0,-50}}, color={192,192,192}),
                                      Line(points={{-60,-45},{60,45}}, color={0,0,127})}),
                                  Documentation(info="<html>
<p>
Model of force, linearly dependent on velocity of flange.<br>
Parameter ForceDirection chooses whether direction of force is the same in both directions of movement or not.
</p>
</html>"));
    end LinearSpeedDependentForce;

    model QuadraticSpeedDependentForce
      "Quadratic dependency of force versus speed"
      extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
      parameter Modelica.SIunits.Force f_nominal
        "Nominal force (if negative, force is acting as load)";
      parameter Boolean ForceDirection=true
        "Same direction of force in both directions of movement";
      parameter Modelica.SIunits.Velocity v_nominal(min=Modelica.Constants.eps)
        "Nominal speed";
      Modelica.SIunits.Velocity v
        "Velocity of flange with respect to support (= der(s))";
    equation
      v = der(s);
      if ForceDirection then
        f = -f_nominal*(v/v_nominal)^2;
      else
        f = -f_nominal*smooth(1, if v >= 0 then (v/v_nominal)^2 else -(v/v_nominal)^2);
      end if;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
              Line(points={{-60,50},{-60,-40}}, color={192,192,192}),
              Line(points={{-75,-30},{75,-30}}, color={192,192,192}),
            Line(
              points={{-60,-30},{-40,-28},{-20,-22},{0,-10},{20,6},{40,26},{58,52}},
              color={0,0,127},
              smooth=Smooth.Bezier)}),     Documentation(info="<html>
<p>
Model of force, quadratic dependent on velocity of flange.<br>
Parameter ForceDirection chooses whether direction of force is the same in both directions of movement or not.
</p>
</html>"));
    end QuadraticSpeedDependentForce;

    model ConstantForce "Constant force, not dependent on speed"
      extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
      parameter Modelica.SIunits.Force f_constant
        "Nominal force (if negative, force is acting as load)";
    equation
      f = -f_constant;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
              Line(points={{-75,10},{75,10}},
                                            color={192,192,192}),
              Line(points={{0,60},{0,0}}, color={192,192,192}),
              Line(points={{-75,30},{75,30}}, color={0,0,127}),
              Text(extent={{-120,-40},{120,-10}},
              textString="%f_constant")}),            Documentation(info="<html>
<p>Model of constant force, not dependent on velocity of flange.</p>
<p>Please note:<br>
Positive force accelerates in positive direction of movement, but brakes in reverse direction of movement.<br>
Negative force brakes in positive direction of movement, but accelerates in reverse direction of movement.</p>
</html>"));
    end ConstantForce;

    model SignForce "Constant force changing sign with speed"
      extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
      import Modelica.Constants.pi;
      parameter Modelica.SIunits.Force f_nominal
        "Nominal force (if negative, force is acting as load)";
      parameter Modelica.Blocks.Types.Regularization reg=Modelica.Blocks.Types.Regularization.Exp
        "Type of regularization" annotation(Evaluate=true);
      parameter Modelica.SIunits.Velocity v0(final min=Modelica.Constants.eps, start=0.1)
        "Regularization below v0";
    Modelica.SIunits.Velocity v
        "Velocity of flange with respect to support (= der(s))";

    equation
      v = der(s);
      if reg==Modelica.Blocks.Types.Regularization.Exp then
        f = -f_nominal*(2/(1 + Modelica.Math.exp(-v/(0.01*v0)))-1);
      elseif reg==Modelica.Blocks.Types.Regularization.Sine then
        f = -f_nominal*smooth(1, (if abs(v)>=v0 then sign(v) else Modelica.Math.sin(pi/2*v/v0)));
      elseif reg==Modelica.Blocks.Types.Regularization.Linear then
        f = -f_nominal*(if abs(v)>=v0 then sign(v) else (v/v0));
      else//if reg==Modelica.Blocks.Types.Regularization.CoSine
        f = -f_nominal*(if abs(v)>=v0 then sign(v) else sign(v)*(1 - Modelica.Math.cos(pi/2*v/v0)));
      end if;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
              Line(points={{0,66},{0,-20}}, color={192,192,192}),
              Line(points={{-75,24},{75,24}},
                                            color={192,192,192}),
            Line(points={{-74,-12},{-8,-12},{-6,-10},{6,58},{8,60},{74,60}}),
              Text(
                extent={{-120,-50},{120,-20}},
              textString="%f_nominal")}),                                       Documentation(info="<html>
<p>Model of constant force which changes sign with direction of movement.</p>
<p>Please note:<br>
Positive force accelerates in both directions of movement.<br>
Negative force brakes in both directions of movement.</p>
<p>Around zero speed regularization avoids numerical problems.</p>
</html>"));
    end SignForce;

    model ConstantSpeed "Constant speed, not dependent on force"
      extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
      parameter Modelica.SIunits.Velocity v_fixed
        "Fixed speed (if negative, force is acting as load)";
      Modelica.SIunits.Velocity v
        "Velocity of flange with respect to support (= der(s))";
    equation
      v = der(s);
      v = v_fixed;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
              Line(points={{-60,60},{-60,-10}}, color={192,192,192}),
              Line(points={{-75,0},{75,0}}, color={192,192,192}),
                                      Line(points={{10,-15},{10,70}}, color={0,0,127}),
          Text(extent={{-120,-50},{120,-20}},
              textString="%v_fixed")}),         Documentation(info="<html>
<p>
Model of <strong>fixed</strong> velocity of flange, not dependent on force.
</p>
</html>"));
    end ConstantSpeed;

    model ForceStep "Constant force, not dependent on speed"
      extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
      parameter Modelica.SIunits.Force stepForce(start=1)
        "Height of force step (if negative, force is acting as load)";
      parameter Modelica.SIunits.Force offsetForce(start=0) "Offset of force";
      parameter Modelica.SIunits.Time startTime=0
        "Force = offset for time < startTime";
    equation
      f = -offsetForce - (if time < startTime then 0 else stepForce);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
              Line(points={{-75,0},{75,0}}, color={192,192,192}),
                                      Line(points={{-75,-30},{0,-30},{0,45},{65,45}}, color={0,0,127}),
                                          Text(
              extent={{0,-40},{100,-10}},
              lineColor={128,128,128},
              textString="time")}),     Documentation(info="<html>
<p>
Model of a force step at time startTime.
Positive force accelerates in positive direction of <code>flange</code> translation.
</p>
</html>"));
    end ForceStep;

    model EddyCurrentForce "Simple model of a translational eddy current brake"
      import Modelica.Electrical.Machines.Thermal.linearTemperatureDependency;
      parameter Modelica.SIunits.Force f_nominal
        "Maximum force (always braking)";
      parameter Modelica.SIunits.Velocity v_nominal(min=Modelica.Constants.eps)
        "Nominal speed (leads to maximum force) at reference temperature";
      parameter Modelica.SIunits.Temperature TRef(start=293.15)
        "Reference temperature";
      parameter
        Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
        alpha20(start=0) "Temperature coefficient of material";
      extends Modelica.Mechanics.Translational.Interfaces.PartialForce;
      extends Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort;
      Modelica.SIunits.Velocity v
        "Velocity of flange with respect to support (= der(s))";
      Real v_normalized "Relative speed v/v_nominal";
    equation
      v = der(s);
      v_normalized = v/(v_nominal*linearTemperatureDependency(1, TRef, alpha20, TheatPort));
      f = 2*f_nominal*v_normalized/(1 + v_normalized*v_normalized);
      lossPower = f*v;
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={
              Line(points={{-75,0},{75,0}}, color={192,192,192}),
              Line(points={{0,60},{0,-50}}, color={192,192,192}),
            Line(points={{0,0},{4,25},{8,41},{12,48},{16,50},{20,49},{24,46},{28,42},{32,38},{36,34},{46,25},{56,18},{66,12},{76,8}}, color={0,0,127}, smooth=Smooth.Bezier),
            Line(points={{0,0},{-4,-25},{-8,-41},{-12,-48},{-16,-50},{-20,-49},{-24,-46},{-28,-42},{-32,-38},{-36,-34},{-46,-25},{-56,-18},{-66,-12},{-76,-8}}, color={0,0,127}, smooth=Smooth.Bezier)}),
        Documentation(info="<html>
<p>This is a simple model of a translational <strong>eddy current brake</strong>. The force versus speed characteristic is defined by Kloss' equation.</p>
<p><strong>Thermal behaviour:</strong><br>
The resistance of the braking fin is influenced by the actual temperature Theatport, which in turn shifts the speed v_nominal at which the (unchanged) maximum torque occurs.<br>
If the heatPort is not used (useHeatPort = false), the operational temperature remains at the given temperature T.<br>
However, the speed v_nominal at which the maximum torque occurs is adapted from reference temperature TRef to the operational temperature.</p>
</html>"));
    end EddyCurrentForce;
    annotation (Documentation(info="<html>
<p>
This package contains ideal sources to drive 1D mechanical translational drive trains.
</p>
</html>"));
  end Sources;

  package Interfaces
    "Interfaces for 1-dim. translational mechanical components"
    extends Modelica.Icons.InterfacesPackage;

    connector Flange "One-dimensional translational flange"

      SI.Position s "Absolute position of flange";
      flow SI.Force f "Cut force directed into flange";
      annotation (
        Documentation(info="<html>
<p>
This is a connector for 1D translational mechanical systems.
It has no icon definition and is only used by inheritance from
flange connectors to define different icons.
</p>
<p>
The following variables are defined in this connector:
</p>

<blockquote><pre>
s: Absolute position of the flange in [m]. A positive translation
   means that the flange is translated along the flange axis.
f: Cut-force in direction of the flange axis in [N].
</pre></blockquote>
</html>"));
    end Flange;

    connector Flange_a
      "One-dimensional translational flange (left, flange axis directed INTO cut plane)"
      extends Flange;

      annotation (
        defaultComponentName="flange_a",
        Documentation(info="<html>
<p>
This is a connector for 1-dim. translational mechanical systems which represents
a mechanical flange. In the cut plane of
the flange a unit vector n, called flange axis, is defined which is directed
INTO the cut plane, i. e. from left to right. All vectors in the cut plane are
resolved with respect to
this unit vector. E.g. force f characterizes a vector which is directed in
the direction of n with value equal to f. When this flange is connected to
other 1D translational flanges, this means that the axes vectors of the connected
flanges are identical.
</p>
<p>
The following variables are transported through this connector:
</p>

<blockquote><pre>
s: Absolute position of the flange in [m]. A positive translation
   means that the flange is translated along the flange axis.
f: Cut-force in direction of the flange axis in [N].
</pre></blockquote>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,127,0},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Rectangle(
              extent={{-40,-40},{40,40}},
              lineColor={0,127,0},
              fillColor={0,127,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-160,110},{40,50}},
              lineColor={0,127,0},
              textString="%name")}));
    end Flange_a;

    connector Flange_b
      "One-dimensional translational flange (right, flange axis directed OUT OF cut plane)"
      extends Flange;

      annotation (
        defaultComponentName="flange_b",
        Documentation(info="<html>
<p>
This is a connector for 1-dim. translational mechanical systems which represents
a mechanical flange. In the cut plane of
the flange a unit vector n, called flange axis, is defined which is directed
OUT OF the cut plane. All vectors in the cut plane are resolved with respect to
this unit vector. E.g. force f characterizes a vector which is directed in
the direction of n with value equal to f. When this flange is connected to
other 1D translational flanges, this means that the axes vectors of the connected
flanges are identical.
</p>
<p>
The following variables are transported through this connector:
</p>

<blockquote><pre>
s: Absolute position of the flange in [m]. A positive translation
   means that the flange is translated along the flange axis.
f: Cut-force in direction of the flange axis in [N].
</pre></blockquote>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={0,127,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Rectangle(
              extent={{-40,-40},{40,40}},
              lineColor={0,127,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-40,110},{160,50}},
              lineColor={0,127,0},
              textString="%name")}));
    end Flange_b;

    connector Support "Support/housing flange of a one-dimensional translational component"
      extends Flange;

      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Rectangle(
                  extent={{-60,60},{60,-60}},
                  fillColor={175,190,175},
                  fillPattern=FillPattern.Solid,
                  pattern=LinePattern.None),           Text(
                  extent={{-160,110},{40,50}},
                  lineColor={0,127,0},
                  textString="%name"),Rectangle(
                  extent={{-40,-40},{40,40}},
                  lineColor={0,127,0},
                  fillColor={0,127,0},
                  fillPattern=FillPattern.Solid)}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Rectangle(
                  extent={{-90,-90},{90,90}},
                  lineColor={0,127,0},
                  fillColor={175,175,175},
                  fillPattern=FillPattern.Solid),Rectangle(
              extent={{-150,150},{150,-150}},
              fillColor={175,190,175},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),    Rectangle(
                  extent={{-90,-90},{90,90}},
                  lineColor={0,127,0},
                  fillColor={0,127,0},
                  fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
This is a connector for 1-dim. translational mechanical systems and models
the support or housing of a shaft.
The following variables are defined in this connector:
</p>

<blockquote><pre>
s: Absolute position of the support/housing in [m].
f: Reaction force in the support/housing in [N].
</pre></blockquote>

<p>
The support connector is usually defined as conditional connector. It is most convenient to utilize it
</p>
<ul>
<li> For models to be build graphically (i.e., the model is build up by drag-and-drop
     from elementary components):<br/>
     <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialOneFlangeAndSupport\">PartialOneFlangeAndSupport</a>,<br/>
     <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialTwoFlangesAndSupport\">PartialTwoFlangesAndSupport</a>.<br/>&nbsp;</li>
<li> For models to be build textually (i.e., elementary models):<br/>
     <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2\">PartialElementaryOneFlangeAndSupport</a>,<br/>
     <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport2\">PartialElementaryTwoFlangesAndSupport</a>,<br/>
     <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryRotationalToTranslational\">PartialElementaryRotationalToTranslational</a>.</li>
</ul>
</html>"));
    end Support;

    model InternalSupport
      "Adapter model to utilize conditional support connector"
      input SI.Force f
        "External support force (must be computed via force balance in model where InternalSupport is used; = flange.f)";
      SI.Position s "External support position (= flange.s)";
      Flange_a flange
        "Internal support flange (must be connected to the conditional support connector for useSupport=true and to conditional fixed model for useSupport=false)"
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    equation
      flange.f = f;
      flange.s = s;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-200,80},{200,40}},
                  lineColor={0,0,255},
                  textString="%name"),Rectangle(
                  extent={{-20,20},{20,-20}},
                  lineColor={0,127,0},
                  fillColor={175,190,175},
                  fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
This is an adapter model to utilize a conditional support connector
in an elementary component, i.e., where the component equations are
defined textually:
</p>

<ul>
<li> If <em>useSupport = true</em>, the flange has to be connected to the conditional
     support connector.</li>
<li> If <em>useSupport = false</em>, the flange has to be connected to the conditional
     fixed model.</li>
</ul>

<p>
Variable <strong>f</strong> is defined as <strong>input</strong> and must be provided when using
this component as a modifier (computed via a force balance in
the model where InternalSupport is used). Usually, model InternalSupport is
utilized via the partial models:
</p>

<blockquote>
<a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport\">
PartialElementaryOneFlangeAndSupport</a>,<br>
<a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport\">
PartialElementaryTwoFlangesAndSupport</a>,<br>
<a href=\"modelica://Modelica.Mechanics.Translational.Interfaces.PartialElementaryRotationalToTranslational\">
PartialElementaryRotationalToTranslational</a>.
</blockquote>

<p>
Note, the support position can always be accessed as internalSupport.s, and
the support force can always be accessed as internalSupport.f.
</p>
</html>"));
    end InternalSupport;

    partial model PartialTwoFlanges
      "Component with two translational 1D flanges"

      Flange_a flange_a
        "(left) driving flange (flange axis directed in to cut plane, e. g. from left to right)"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Flange_b flange_b
        "(right) driven flange (flange axis directed out of cut plane)"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      annotation (Documentation(info="<html>
<p>
This is a 1D translational component with two flanges.
It is used e.g., to built up parts of a drive train consisting
of several base components.
</p>
</html>"));
    end PartialTwoFlanges;

    partial model PartialOneFlangeAndSupport
      "Partial model for a component with one translational 1-dim. shaft flange and a support used for graphical modeling, i.e., the model is build up by drag-and-drop from elementary components"
      parameter Boolean useSupport=false
        "= true, if support flange enabled, otherwise implicitly grounded"
        annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      Flange_b flange "Flange of component" annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
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
      connect(fixed.flange, internalSupport) annotation (Line(
          points={{20,-84},{20,-80},{0,-80}}, color={0,127,0}));
      connect(internalSupport, support)
        annotation (Line(points={{0,-80},{0,-100}}));
      annotation (
        Documentation(info="<html>
<p>
This is a 1-dim. translational component with one flange and a support/housing.
It is used e.g., to build up parts of a drive train graphically consisting
of several components.
</p>

<p>
If <em>useSupport=true</em>, the support connector is conditionally enabled
and needs to be connected.<br>
If <em>useSupport=false</em>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>

</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Text(
                  extent={{-38,-98},{-6,-96}},
                  lineColor={95,95,95},
                  textString="(if useSupport)"),Text(
                  extent={{21,-95},{61,-96}},
                  lineColor={95,95,95},
                  textString="(if not useSupport)")}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(
                  points={{-50,-120},{-30,-100}}, color={0,127,0}),
                                                  Line(
                  points={{-30,-120},{-10,-100}}, color={0,127,0}),
                                                  Line(
                  points={{-10,-120},{10,-100}}, color={0,127,0}),
                                                 Line(
                  points={{10,-120},{30,-100}}, color={0,127,0}),
                                                Line(
                  points={{-30,-100},{30,-100}}, color={0,127,0})}));
    end PartialOneFlangeAndSupport;

    partial model PartialTwoFlangesAndSupport
      "Partial model for a component with two translational 1-dim. shaft flanges and a support used for graphical modeling, i.e., the model is build up by drag-and-drop from elementary components"
      parameter Boolean useSupport=false
        "= true, if support flange enabled, otherwise implicitly grounded"
        annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      Flange_a flange_a "Flange of left end" annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}})));
      Flange_b flange_b "Flange of right end" annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
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
      connect(fixed.flange, internalSupport) annotation (Line(
          points={{20,-84},{20,-80},{0,-80}}, color={0,127,0}));
      connect(internalSupport, support)
        annotation (Line(points={{0,-80},{0,-100}}));
      annotation (
        Documentation(info="<html>
<p>
This is a 1-dim. translational component with two flanges and a support/housing.
It is used e.g., to build up parts of a drive train graphically consisting
of several components.
</p>

<p>
If <em>useSupport=true</em>, the support connector is conditionally enabled
and needs to be connected.<br>
If <em>useSupport=false</em>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>

</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Text(
                  extent={{-38,-98},{-6,-96}},
                  lineColor={95,95,95},
                  textString="(if useSupport)"),Text(
                  extent={{20,-95},{60,-96}},
                  lineColor={95,95,95},
                  textString="(if not useSupport)")}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(
                  points={{-50,-120},{-30,-100}}, color={0,127,0}),
                                                  Line(
                  points={{-30,-120},{-10,-100}}, color={0,127,0}),
                                                  Line(
                  points={{-10,-120},{10,-100}}, color={0,127,0}),
                                                 Line(
                  points={{10,-120},{30,-100}}, color={0,127,0}),
                                                Line(
                  points={{-30,-100},{30,-100}}, color={0,127,0})}));
    end PartialTwoFlangesAndSupport;

    partial model PartialRigid
      "Rigid connection of two translational 1D flanges"
      SI.Position s
        "Absolute position of center of component (s = flange_a.s + L/2 = flange_b.s - L/2)";
      parameter SI.Length L(start=0)
        "Length of component, from left flange to right flange (= flange_b.s - flange_a.s)";
      Flange_a flange_a "Left flange of translational component" annotation (
          Placement(transformation(extent={{-110,-10},{-90,10}})));
      Flange_b flange_b "Right flange of translational component" annotation (
          Placement(transformation(extent={{90,-10},{110,10}})));
    equation
      flange_a.s = s - L/2;
      flange_b.s = s + L/2;
      annotation (Documentation(info="<html>
<p>
This is a 1-dim. translational component with two <em>rigidly</em> connected flanges.
The fixed distance between the left and the right flange is defined by parameter \"L\".
The forces at the right and left flange can be different.
It is used e.g., to built up sliding masses.
</p>
</html>"));
    end PartialRigid;

    partial model PartialCompliant
      "Compliant connection of two translational 1D flanges"

      Flange_a flange_a
        "Left flange of compliant 1-dim. translational component" annotation (
          Placement(transformation(extent={{-110,-10},{-90,10}})));
      Flange_b flange_b
        "Right flange of compliant 1-dim. translational component" annotation (
          Placement(transformation(extent={{90,-10},{110,10}})));
      SI.Position s_rel(start=0)
        "Relative distance (= flange_b.s - flange_a.s)";
      SI.Force f
        "Force between flanges (positive in direction of flange axis R)";

    equation
      s_rel = flange_b.s - flange_a.s;
      flange_b.f = f;
      flange_a.f = -f;
      annotation (Documentation(info="<html>
<p>
This is a 1D translational component with a <em>compliant</em> connection of two
translational 1D flanges where inertial effects between the two
flanges are not included. The absolute value of the force at the left and the right
flange is the same. It is used to built up springs, dampers etc.
</p>

</html>"), Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Polygon(
                  points={{50,-90},{20,-80},{20,-100},{50,-90}},
                  lineColor={128,128,128},
                  fillColor={128,128,128},
                  fillPattern=FillPattern.Solid),Line(points={{-60,-90},{20,-90}})}));
    end PartialCompliant;

    partial model PartialCompliantWithRelativeStates
      "Base model for the compliant connection of two translational 1-dim. shaft flanges where the relative position and relative velocities are used as states"

      parameter StateSelect stateSelect=StateSelect.prefer
        "Priority to use s_rel and v_rel as states"
        annotation (HideResult=true, Dialog(tab="Advanced"));
      parameter SI.Distance s_nominal=1e-4
        "Nominal value of s_rel (used for scaling)"
        annotation (Dialog(tab="Advanced"));

      SI.Position s_rel(
        start=0,
        stateSelect=stateSelect,
        nominal=s_nominal) "Relative distance (= flange_b.s - flange_a.s)";
      SI.Velocity v_rel(start=0, stateSelect=stateSelect)
        "Relative velocity (= der(s_rel))";

      SI.Force f "Forces between flanges (= flange_b.f)";
      Translational.Interfaces.Flange_a flange_a
        "Left flange of compliant 1-dim. translational component" annotation (
          Placement(transformation(extent={{-110,-10},{-90,10}})));
      Translational.Interfaces.Flange_b flange_b
        "Right flange of compliant 1-dim. translational component" annotation (
          Placement(transformation(extent={{90,-10},{110,10}})));

    equation
      s_rel = flange_b.s - flange_a.s;
      v_rel = der(s_rel);
      flange_b.f = f;
      flange_a.f = -f;
      annotation (Documentation(info="<html>
<p>
This is a 1-dim. translational component with a compliant connection of two
translational 1-dim. flanges where inertial effects between the two
flanges are neglected. The basic assumption is that the cut-forces
of the two flanges sum-up to zero, i.e., they have the same absolute value
but opposite sign: flange_a.f + flange_b.f = 0. This base class
is used to built up force elements such as springs, dampers, friction.
</p>

<p>
The difference to base class \"PartialCompliant\" is that the relative
distance and the relative velocity are defined as preferred states.
The reason is that for a large class of drive trains,
the absolute position is quickly increasing during operation.
Numerically, it is better to use relative distances between drive train components
because they remain in a limited size. For this reason, StateSelect.prefer
is set for the relative distance of this component.
</p>

<p>
In order to improve the numerics, a nominal value for the relative distance
should be set, since drive train distances are in a small order and
then step size control of the integrator is practically switched off for
such a variable. A default nominal value of s_nominal = 1e-4 is defined.
This nominal value might also be computed from other values, such
as \"s_nominal = f_nominal / c\" for a spring, if f_nominal
and c have more meaningful values for the user.
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
      Modelica.SIunits.Length s
        "Distance between flange and support (= flange.s - support.s)";
      Flange_b flange "Flange of component" annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));

    protected
      InternalSupport internalSupport(f=-flange.f)
        "Internal support/housing of component as a model with connector flange (flange is either connected to support, if useSupport=true, or connected to fixed, if useSupport=false)"
        annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
      Components.Fixed fixed if not useSupport
        "Fixed support/housing, if not useSupport"
        annotation (Placement(transformation(extent={{10,-97},{30,-77}})));
    public
      Support support if useSupport "Support/housing of component"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    equation
      s = flange.s - internalSupport.s;
      connect(internalSupport.flange, support) annotation (Line(
          points={{0,-80},{0,-100}}, color={0,127,0}));
      connect(fixed.flange, internalSupport.flange) annotation (Line(
          points={{20,-87},{20,-80},{0,-80}}, color={0,127,0}));
      annotation (
        obsolete = "Obsolete model - use Modelica.Mechanics.Translational.Interfaces.PartialElementaryOneFlangeAndSupport2 instead",
        Documentation(info="<html>
<p>
This is a 1-dim. translational component with one flange and a support/housing.
It is used to build up elementary components of a drive train with
equations in the text layer.
</p>

<p>
If <em>useSupport=true</em>, the support connector is conditionally enabled
and needs to be connected.<br>
If <em>useSupport=false</em>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>

</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Text(
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
    end PartialElementaryOneFlangeAndSupport;

    partial model PartialElementaryOneFlangeAndSupport2
      "Partial model for a component with one translational 1-dim. shaft flange and a support used for textual modeling, i.e., for elementary models"
      parameter Boolean useSupport=false
        "= true, if support flange enabled, otherwise implicitly grounded"
        annotation (
        Evaluate=true,
        HideResult=true,
        choices(checkBox=true));
      Modelica.SIunits.Length s
        "Distance between flange and support (= flange.s - support.s)";
      Flange_b flange "Flange of component" annotation (Placement(
            transformation(extent={{90,-10},{110,10}})));
      Support support(s=s_support, f=-flange.f) if useSupport
        "Support/housing of component"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    protected
      Modelica.SIunits.Length s_support "Absolute position of support flange";
    equation
      s = flange.s - s_support;
      if not useSupport then
        s_support = 0;
      end if;
      annotation (Documentation(info="<html>
<p>
This is a 1-dim. translational component with one flange and a support/housing.
It is used to build up elementary components of a drive train with
equations in the text layer.
</p>

<p>
If <em>useSupport=true</em>, the support connector is conditionally enabled
and needs to be connected.<br>
If <em>useSupport=false</em>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>

</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
          graphics={
            Line(
              visible=not useSupport,
              points={{-50,-120},{-30,-100}}, color={0,127,0}),
            Line(
              visible=not useSupport,
              points={{-30,-120},{-10,-100}}, color={0,127,0}),
            Line(
              visible=not useSupport,
              points={{-10,-120},{10,-100}}, color={0,127,0}),
            Line(
              visible=not useSupport,
              points={{10,-120},{30,-100}}, color={0,127,0}),
            Line(
              visible=not useSupport,
              points={{-30,-100},{30,-100}}, color={0,127,0})}));
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
      Modelica.SIunits.Length s_a "Distance between left flange and support";
      Modelica.SIunits.Length s_b "Distance between right flange and support";
    protected
      InternalSupport internalSupport(f=-flange_a.f - flange_b.f)
        "Internal support/housing of component as a model with connector flange (flange is either connected to support, if useSupport=true, or connected to fixed, if useSupport=false)"
        annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
      Components.Fixed fixed if not useSupport
        "Fixed support/housing, if not useSupport"
        annotation (Placement(transformation(extent={{10,-97},{30,-77}})));
    public
      Support support if useSupport "Support/housing of component"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    equation
      s_a = flange_a.s - internalSupport.s;
      s_b = flange_b.s - internalSupport.s;
      connect(internalSupport.flange, support) annotation (Line(
          points={{0,-80},{0,-100}}, color={0,127,0}));
      connect(fixed.flange, internalSupport.flange) annotation (Line(
          points={{20,-87},{20,-80},{0,-80}}, color={0,127,0}));
      annotation (
        obsolete = "Obsolete model - use Modelica.Mechanics.Translational.Interfaces.PartialElementaryTwoFlangesAndSupport2 instead",
        Documentation(info="<html>
<p>
This is a 1-dim. translational component with two flanges and an additional support.
It is used e.g., to build up elementary ideal gear components. The component
contains the force balance, i.e., the sum of the forces of the connectors
is zero (therefore, components that are based on PartialGear cannot have
a mass). The support connector needs to be connected
to avoid the unphysical behavior that the
support force is required to be zero (= the default value, if the
connector is not connected).
</p>

</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Text(
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
    end PartialElementaryTwoFlangesAndSupport;

    partial model PartialElementaryTwoFlangesAndSupport2
      "Partial model for a component with one translational 1-dim. shaft flange and a support used for textual modeling, i.e., for elementary models"
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
      Support support(s=s_support, f=-flange_a.f - flange_b.f) if useSupport
        "Support/housing of component"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      Modelica.SIunits.Length s_a "Distance between left flange and support";
      Modelica.SIunits.Length s_b "Distance between right flange and support";
    protected
      Modelica.SIunits.Length s_support "Absolute position of support flange";
    equation
      s_a = flange_a.s - s_support;
      s_b = flange_b.s - s_support;
      if not useSupport then
        s_support = 0;
      end if;

      annotation (Documentation(info="<html>
<p>
This is a 1-dim. translational component with two flanges and an additional support.
It is used e.g., to build up elementary ideal gear components. The component
contains the force balance, i.e., the sum of the forces of the connectors
is zero (therefore, components that are based on PartialGear cannot have
a mass). The support connector needs to be connected
to avoid the unphysical behavior that the
support force is required to be zero (= the default value, if the
connector is not connected).
</p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
          graphics={
            Line(
              visible=not useSupport,
              points={{-50,-120},{-30,-100}}, color={0,127,0}),
            Line(
              visible=not useSupport,
              points={{-30,-120},{-10,-100}}, color={0,127,0}),
            Line(
              visible=not useSupport,
              points={{-10,-120},{10,-100}}, color={0,127,0}),
            Line(
              visible=not useSupport,
              points={{10,-120},{30,-100}}, color={0,127,0}),
            Line(
              visible=not useSupport,
              points={{-30,-100},{30,-100}}, color={0,127,0})}));
    end PartialElementaryTwoFlangesAndSupport2;

    partial model PartialElementaryRotationalToTranslational
      "Partial model to transform rotational into translational motion"
      extends
        Modelica.Mechanics.Rotational.Interfaces.PartialElementaryRotationalToTranslational;
      annotation (Documentation(info="<html>
<p>This is a 1-dim. rotational component with</p>
<ul>
<li>one rotational flange,</li>
<li>one rotational support/housing,</li>
<li>one translational flange, and</li>
<li>one translational support/housing</li>
</ul>
<p>This model is used to build up elementary components of a drive train transforming rotational into translational motion with equations in the text layer.</p>
<p>If <em>useSupportR=true</em>, the rotational support connector is conditionally enabled and needs to be connected.</p>
<p>If <em>useSupportR=false</em>, the rotational support connector is conditionally disabled and instead the rotational part is internally fixed to ground.</p>
<p>If <em>useSupportT=true</em>, the translational support connector is conditionally enabled and needs to be connected.</p>
<p>If <em>useSupportT=false</em>, the translational support connector is conditionally disabled and instead the translational part is internally fixed to ground.</p>
</html>"));
    end PartialElementaryRotationalToTranslational;

    partial model PartialForce
      "Partial model of a force acting at the flange (accelerates the flange)"
      extends PartialElementaryOneFlangeAndSupport2;
      Modelica.SIunits.Force f
        "Accelerating force acting at flange (= flange.f)";
    equation
      f = flange.f;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
                  extent={{-96,100},{96,-92}},
                  lineColor={255,255,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{0,-60},{0,-100}}, color={0,127,0}),
                                                                                 Text(
                  extent={{-150,140},{150,100}},
                  lineColor={0,0,255},
                  textString="%name"),Line(points={{-78,80},{51,80}}, color={95,127,95}),
              Polygon(
              points={{81,80},{51,90},{51,70},{81,80}},
              fillColor={95,127,95},
              fillPattern=FillPattern.Solid,
              lineColor={95,127,95}),            Line(points={{-52,-60},{77,-60}}, color={95,127,95}),
                                                                                   Polygon(
              points={{-82,-60},{-51,-50},{-51,-70},{-82,-60}},
              fillColor={95,127,95},
              fillPattern=FillPattern.Solid,
              lineColor={95,127,95})}),             Documentation(info="<html>
<p>
Partial model of force that accelerates the flange.
</p>

<p>
If <em>useSupport=true</em>, the support connector is conditionally enabled
and needs to be connected.<br>
If <em>useSupport=false</em>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>
</html>"));
    end PartialForce;

    partial model PartialAbsoluteSensor
      "Device to measure a single absolute flange variable"

      extends Modelica.Icons.TranslationalSensor;

      Interfaces.Flange_a flange
        "Flange to be measured (flange axis directed in to cut plane, e. g. from left to right)"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));

    equation
      0 = flange.f;
      annotation (Documentation(info="<html>
<p>
This is the superclass of a 1D translational component with one flange and one
output signal in order to measure an absolute kinematic quantity in the flange
and to provide the measured signal as output signal for further processing
with the Modelica.Blocks blocks.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{-100,-90},{-20,-90}}, color={95,127,95}),
                                                                           Polygon(
              points={{10,-90},{-20,-80},{-20,-100},{10,-90}},
              lineColor={95,127,95},
              fillColor={95,127,95},
              fillPattern=FillPattern.Solid),    Line(points={{-70,0},{-100,0}}, color={0,127,0}),
                                                                                Line(points={{70,0},{100,0}}, color={0,0,127}),
              Text(
                  extent={{-150,80},{150,40}},
                  textString="%name",
                  lineColor={0,0,255})}));
    end PartialAbsoluteSensor;

    partial model PartialRelativeSensor
      "Device to measure a single relative variable between two flanges"

      extends Modelica.Icons.TranslationalSensor;

      Interfaces.Flange_a flange_a
        "(left) driving flange (flange axis directed in to cut plane, e. g. from left to right)"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Interfaces.Flange_b flange_b
        "(right) driven flange (flange axis directed out of cut plane)"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));

    equation
      0 = flange_a.f + flange_b.f;
      annotation (Documentation(info="<html>
<p>
This is a superclass for 1D translational components with two rigidly connected
flanges and one output signal in order to measure relative kinematic quantities
between the two flanges or the cut-force in the flange and
to provide the measured signal as output signal for further processing
with the Modelica.Blocks blocks.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{-51,34},{29,34}}, color={95,127,95}),
              Polygon(
              points={{59,34},{29,44},{29,24},{59,34}},
              fillColor={95,127,95},
              fillPattern=FillPattern.Solid,
              lineColor={95,127,95}),            Line(points={{-70,0},{-100,0}}, color={0,127,0}),
                                                                                Line(points={{70,0},{100,0}}, color={0,127,0}),
                                                                                                             Text(
                  extent={{-150,100},{150,60}},
                  textString="%name",
                  lineColor={0,0,255})}));
    end PartialRelativeSensor;

    partial model PartialFriction "Base model of Coulomb friction elements"

      //extends Translational.Interfaces.PartialRigid;
      parameter SI.Velocity v_small=1e-3
        "Relative velocity near to zero (see model info text)"
        annotation (Dialog(tab="Advanced"));
      // Equations to define the following variables have to be defined in subclasses
      SI.Velocity v_relfric "Relative velocity between frictional surfaces";
      SI.Acceleration a_relfric
        "Relative acceleration between frictional surfaces";
      //SI.Force f "Friction force (positive, if directed in opposite direction of v_relfric)";
      SI.Force f0 "Friction force for v_relfric=0 and forward sliding";
      SI.Force f0_max "Maximum friction force for v_relfric=0 and locked";
      Boolean free "= true, if frictional element is not active";
      // Equations to define the following variables are given in this class
      Real sa(unit="1")
        "Path parameter of friction characteristic f = f(a_relfric)";
      Boolean startForward(start=false, fixed=true)
        "= true, if v_relfric=0 and start of forward sliding";
      Boolean startBackward(start=false, fixed=true)
        "= true, if v_relfric=0 and start of backward sliding";
      Boolean locked(start=false) "= true, if v_relfric=0 and not sliding";
      constant Integer Unknown=3 "Value of mode is not known";
      constant Integer Free=2 "Element is not active";
      constant Integer Forward=1 "v_relfric > 0 (forward sliding)";
      constant Integer Stuck=0
        "v_relfric = 0 (forward sliding, locked or backward sliding)";
      constant Integer Backward=-1 "v_relfric < 0 (backward sliding)";
      Integer mode(
        final min=Backward,
        final max=Unknown,
        start=Unknown,
        fixed=true)
        "Mode of friction (-1: backward sliding, 0: stuck, 1: forward sliding, 2: inactive, 3: unknown)";
    protected
      constant SI.Acceleration unitAcceleration=1 annotation (HideResult=true);
      constant SI.Force unitForce=1 annotation (HideResult=true);
    equation
      /* Friction characteristic
   (locked is introduced to help the Modelica translator determining
   the different structural configurations,
   if for each configuration special code shall be generated)
*/
      startForward = pre(mode) == Stuck and (sa > f0_max/unitForce or pre(
        startForward) and sa > f0/unitForce) or pre(mode) == Backward and
        v_relfric > v_small or initial() and (v_relfric > 0);
      startBackward = pre(mode) == Stuck and (sa < -f0_max/unitForce or pre(
        startBackward) and sa < -f0/unitForce) or pre(mode) == Forward and
        v_relfric < -v_small or initial() and (v_relfric < 0);
      locked = not free and not (pre(mode) == Forward or startForward or pre(
        mode) == Backward or startBackward);

      a_relfric/unitAcceleration = if locked then 0 else if free then sa else
        if startForward then sa - f0_max/unitForce else if startBackward then
        sa + f0_max/unitForce else if pre(mode) == Forward then sa - f0_max/
        unitForce else sa + f0_max/unitForce;

      /* Friction torque has to be defined in a subclass. Example for a clutch:
   f = if locked then sa else
       if free then   0 else
       cgeo*fn*(if startForward then          Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], v_relfric, 1) else
                if startBackward then        -Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], -v_relfric, 1) else
                if pre(mode) == Forward then  Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], v_relfric, 1) else
                                             -Modelica.Math.Vectors.interpolate(mue_pos[:,1], mue_pos[:,2], -v_relfric, 1));
*/
      // finite state machine to determine configuration
      mode = if free then Free else (if (pre(mode) == Forward or pre(mode) ==
        Free or startForward) and v_relfric > 0 then Forward else if (pre(mode)
         == Backward or pre(mode) == Free or startBackward) and v_relfric < 0
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
<dd><strong>Hybrid Modeling in Modelica based on the Synchronous
    Data Flow Principle</strong>. CACSD'99, Aug. 22.-26, Hawaii.</dd>
</dl>
</html>"));
    end PartialFriction;

    annotation (Documentation(info="<html>
<p>
This package contains connectors and partial models for 1-dim.
translational mechanical components. The components of this package can
only be used as basic building elements for models.
</p>
</html>"));
  end Interfaces;

  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Line(origin={14,53}, points={{-84,-73},{66,-73}}),
        Rectangle(
          origin={14,53},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.Sphere,
          extent={{-81,-65},{-8,-22}}),
        Line(
          origin={14,53},
          points={{-8,-43},{-1,-43},{6,-64},{17,-23},{29,-65},{40,-23},{50,-44},
              {61,-44}}),
        Line(origin={14,53}, points={{-59,-73},{-84,-93}}),
        Line(origin={14,53}, points={{-11,-73},{-36,-93}}),
        Line(origin={14,53}, points={{-34,-73},{-59,-93}}),
        Line(origin={14,53}, points={{14,-73},{-11,-93}}),
        Line(origin={14,53}, points={{39,-73},{14,-93}}),
        Line(origin={14,53}, points={{63,-73},{38,-93}})}), Documentation(info="<html>
<p>
This package contains components to model <em>1-dimensional translational
mechanical</em> systems.
</p>
<p>
The <em>filled</em> and <em>non-filled green squares</em> at the left and
right side of a component represent <em>mechanical flanges</em>.
Drawing a line between such squares means that the corresponding
flanges are <em>rigidly attached</em> to each other. The components of this
library can be usually connected together in an arbitrary way. E.g. it is
possible to connect two springs or two sliding masses with inertia directly
together.
</p>
<p> The only <em>connection restriction</em> is that the Coulomb friction
elements (e.g., MassWithStopAndFriction) should be only connected
together provided a compliant element, such as a spring, is in between.
The reason is that otherwise the frictional force is not uniquely
defined if the elements are stuck at the same time instant (i.e., there
does not exist a unique solution) and some simulation systems may not be
able to handle this situation, since this leads to a singularity during
simulation. It can only be resolved in a \"clean way\" by combining the
two connected friction elements into
one component and resolving the ambiguity of the frictional force in the
stuck mode.
</p>
<p> Another restriction arises if the hard stops in model MassWithStopAndFriction are used, i. e.
the movement of the mass is limited by a stop at smax or smin.
<font color=\"#ff0000\"> <strong>This requires the states Stop.s and Stop.v</strong> </font>. If these states are eliminated during the index reduction
the model will not work. To avoid this any inertias should be connected via springs
to the Stop element, other sliding masses, dampers or hydraulic chambers must be avoided.</p>
<p>
In the <em>icon</em> of every component an <em>arrow</em> is displayed in grey
color. This arrow characterizes the coordinate system in which the vectors
of the component are resolved. It is directed into the positive
translational direction (in the mathematical sense).
In the flanges of a component, a coordinate system is rigidly attached
to the flange. It is called <em>flange frame</em> and is directed in parallel
to the component coordinate system. As a result, e.g., the positive
cut-force of a \"left\" flange (flange_a) is directed into the flange, whereas
the positive cut-force of a \"right\" flange (flange_b) is directed out of the
flange. A flange is described by a Modelica connector containing
the following variables:
</p>
<pre>
   Modelica.SIunits.Position s    \"Absolute position of flange\";
   <strong>flow</strong> Modelica.SIunits.Force f  \"Cut-force in the flange\";
</pre>

<p>
This library is designed in a fully object oriented way in order that
components can be connected together in every meaningful combination
(e.g., direct connection of two springs or two shafts with inertia).
As a consequence, most models lead to a system of
differential-algebraic equations of <em>index 3</em> (= constraint
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
In version 3.2 of the Modelica Standard Library, all <strong>dissipative</strong> components
of the Translational library got an optional <strong>heatPort</strong> connector to which the
dissipated energy is transported in form of heat. This connector is enabled
via parameter \"useHeatPort\". If the heatPort connector is enabled,
it must be connected, and if it is not enabled, it must not be connected.
Independently, whether the heatPort is enabled or not,
the dissipated power is available from the new variable \"<strong>lossPower</strong>\" (which is
positive if heat is flowing out of the heatPort). For an example, see
<a href=\"modelica://Modelica.Mechanics.Translational.Examples.HeatLosses\">Examples.HeatLosses</a>.
</p>

<p>
Copyright &copy; 1998-2018, Modelica Association, Anton Haumer and Universit&auml;t Paderborn, FB 12.
</p>
<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>", revisions="<html>
<ul>
<li><em>Version 1.2.0 2010-07-22</em>
       by Anton Haumer and Martin Otter<br>
       heatPort introduced for all dissipative elements, and
       text in icons improved.
       <br></li>

<li><em>Version 1.1.0 2007-11-16</em>
       by Anton Haumer<br>
       Redesign for Modelica 3.0-compliance<br>
       Added new components according to Mechanics.Rotational library
       <br></li>

<li><em>Version 1.01 (July 18, 2001)</em>
       by Peter Beater<br>
       Assert statement added to \"Stop\", small bug fixes in examples.
       <br></li>

<li><em>Version 1.0 (January 5, 2000)</em>
       by Peter Beater<br>
       Realized a first version based on Modelica library Mechanics.Rotational
       by Martin Otter and an existing Dymola library onedof.lib by Peter Beater.</li>
</ul>
</html>"));
end Translational;
