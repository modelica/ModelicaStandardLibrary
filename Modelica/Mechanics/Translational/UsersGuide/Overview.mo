within Modelica.Mechanics.Translational.UsersGuide;
class Overview "Overview"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html>

<p>
This package contains components to model <strong>1-dimensional translational
mechanical</strong> systems, including different types of masses,
external forces, spring/damper elements,
frictional elements, elastogaps, elements to measure position, velocity,
acceleration or the cut-force of a flange. In sublibrary
<strong><a href=\"modelica://Modelica.Mechanics.Translational.Examples\">Examples</a></strong>
several examples are present to demonstrate the usage of
the elements. Just open the corresponding example model and simulate
the model according to the provided description.
</p>
<p>
A unique feature of this library is the <strong>component-oriented</strong>
modeling of <strong>Coulomb friction</strong> elements, such as support friction.
Even (dynamically) coupled friction elements can be handled
<strong>without</strong> introducing stiffness, which leads to fast simulations.
The underlying theory is based on the solution of mixed
continuous/discrete systems of equations, i.e., equations where the
<strong>unknowns</strong> are of type <strong>Real</strong>, <strong>Integer</strong> or <strong>Boolean</strong>.
Provided appropriate numerical algorithms for the solution of such types of
systems are available in the simulation tool, the simulation of
(dynamically) coupled friction elements of this library is
<strong>efficient</strong> and <strong>reliable</strong>.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/drive1.png\" alt=\"drive1\">
</div>

<p>
A simple example of the usage of this library is given in the
figure above. This model consists of a <code>mass1</code> with mass <var>m</var>&nbsp;=&nbsp;1&nbsp;kg which
is connected via a spring to a <code>mass2</code> with mass <var>m</var>&nbsp;=&nbsp;5&nbsp;kg.
The left mass is driven via an external, sinusoidal force.
The <strong>filled</strong> and <strong>non-filled green squares</strong> at the left and
right side of a component represent <strong>mechanical flanges</strong>.
Drawing a line between such squares means that the corresponding
flanges are <strong>rigidly attached</strong> to each other.
By convention in this library, the connector characterized as a
<strong>filled</strong> green square is called <strong>flange_a</strong> and placed at the
left side of the component in the &quot;design view&quot; and the connector
characterized as a <strong>non-filled</strong> green square is called <strong>flange_b</strong>
and placed at the right side of the component in the &quot;design view&quot;.
The two connectors are completely <strong>identical</strong>, with the only
exception that the graphical layout is a little bit different in order
to distinguish them for easier access of the connector variables.
For example, <code>mass1.flange_a.f</code> is the cut-force in the connector
<code>flange_a</code> of component <code>mass1</code>.
</p>
<p>
The components of this
library can be <strong>connected</strong> together in an <strong>arbitrary</strong> way. E.g., it is
possible to connect two springs or two shafts with mass directly
together, see figure below.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/driveConnections1.png\" alt=\"driveConnections1\"><br>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Translational/UsersGuide/driveConnections2.png\" alt=\"driveConnections2\"><br>
</div>
</html>"));

end Overview;
