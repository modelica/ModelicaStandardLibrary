within Modelica.Mechanics;
package Translational "Library to model 1-dimensional, translational mechanical systems"
  extends Modelica.Icons.Package;

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
<blockquote><pre>
Modelica.Units.SI.Position s    \"Absolute position of flange\";
<strong>flow</strong> Modelica.Units.SI.Force f  \"Cut-force in the flange\";
</pre></blockquote>

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
Copyright &copy; 1998-2020, Modelica Association and contributors
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
