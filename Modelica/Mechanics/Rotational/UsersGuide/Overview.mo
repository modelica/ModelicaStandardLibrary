within Modelica.Mechanics.Rotational.UsersGuide;
class Overview "Overview"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html>

<p>
This package contains components to model <strong>1-dimensional rotational
mechanical</strong> systems, including different types of gearboxes,
shafts with inertia, external torques, spring/damper elements,
frictional elements, backlash, elements to measure angle, angular velocity,
angular acceleration and the cut-torque of a flange. In sublibrary
<strong><a href=\"modelica://Modelica.Mechanics.Rotational.Examples\">Examples</a></strong>
several examples are present to demonstrate the usage of
the elements. Just open the corresponding example model and simulate
the model according to the provided description.
</p>
<p>
A unique feature of this library is the <strong>component-oriented</strong>
modeling of <strong>Coulomb friction</strong> elements, such as friction in bearings,
clutches, brakes, and gear efficiency. Even (dynamically) coupled
friction elements, e.g., as in automatic gearboxes, can be handled
<strong>without</strong> introducing stiffness which leads to fast simulations.
The underlying theory is new and is based on the solution of mixed
continuous/discrete systems of equations, i.e., equations where the
<strong>unknowns</strong> are of type <strong>Real</strong>, <strong>Integer</strong> or <strong>Boolean</strong>.
Provided appropriate numerical algorithms for the solution of such types of
systems are available in the simulation tool, the simulation of
(dynamically) coupled friction elements of this library is
<strong>efficient</strong> and <strong>reliable</strong>.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/drive1.png\" alt=\"drive1\">
</div>

<p>
A simple example of the usage of this library is given in the
figure above. This drive consists of a shaft <code>J1</code> with inertia
<var>J</var>&nbsp;=&nbsp;0.2&nbsp;kg.m<sup>2</sup> which
is connected via an ideal gearbox with gear ratio&nbsp;=&nbsp;5 to a second shaft <code>J2</code>
with inertia <var>J</var>&nbsp;=&nbsp;5&nbsp;kg.m<sup>2</sup>. The left shaft is driven via an external,
sinusoidal torque.
The <strong>filled</strong> and <strong>non-filled grey squares</strong> at the left and
right side of a component represent <strong>mechanical flanges</strong>.
Drawing a line between such squares means that the corresponding
flanges are <strong>rigidly attached</strong> to each other.
By convention in this library, the connector characterized as a
<strong>filled</strong> grey square is called <strong>flange_a</strong> and placed at the
left side of the component in the &quot;design view&quot; and the connector
characterized as a <strong>non-filled</strong> grey square is called <strong>flange_b</strong>
and placed at the right side of the component in the &quot;design view&quot;.
The two connectors are completely <strong>identical</strong>, with the only
exception that the graphical layout is a little bit different in order
to distinguish them for easier access of the connector variables.
For example, <code>J1.flange_a.tau</code> is the cut-torque in the connector
<code>flange_a</code> of component <code>J1</code>.
</p>
<p>
The components of this
library can be <strong>connected</strong> together in an <strong>arbitrary</strong> way. E.g., it is
possible to connect two springs or two shafts with inertia directly
together, see figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/driveConnections1.png\" alt=\"driveConnections1\"><br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/driveConnections2.png\" alt=\"driveConnections2\">
</div>
</html>"));

end Overview;
