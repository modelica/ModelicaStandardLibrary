within Modelica.Mechanics.Rotational.UsersGuide;
class RequirementsForSimulationTool "Requirements for Simulation Tools"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
This library is designed in a fully object oriented way in order that
components can be connected together in every meaningful combination
(e.g., direct connection of two springs or two inertias).
As a consequence, most models lead to a system of
differential-algebraic equations (DAE) of <strong>index&nbsp;3</strong> (= constraint
equations have to be differentiated twice in order to arrive at
a state space representation) and the Modelica translator or
the simulator has to cope with this system representation.
According to our present knowledge, this requires that the
Modelica translator is able to symbolically differentiate equations
(otherwise it is e.g., not possible to provide consistent initial
conditions; even if consistent initial conditions are present, most
numerical DAE integrators can cope at most with index&nbsp;2 DAEs).
</p>
<p>
The elements of this library can be connected together in an
arbitrary way. However, difficulties may occur, if the elements which can <strong>lock</strong> the
<strong>relative motion</strong> between two flanges are connected <strong>rigidly</strong>
together such that essentially the <strong>same relative motion</strong> can be locked.
The reason is
that the cut-torque in the locked phase is not uniquely defined if the
elements are locked at the same time instant (i.e., there does not exist a
unique solution) and some simulation systems may not be
able to handle this situation, since this leads to a singularity during
simulation. Currently, this type of problem can occur with the
Coulomb friction elements such as
<strong>BearingFriction</strong>, <strong>Clutch</strong>, <strong>Brake</strong> or <strong>LossyGear</strong>
when the elements become stuck:
</p>
<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/Rotational/UsersGuide/driveConnections3.png\" alt=\"driveConnections3\">
</div>
<p>
In the figure above, two typical situations are shown: In the upper part of
the figure, the series connection of rigidly attached <code>bearingFriction1</code> and
<code>clutch</code> components are shown. This does not hurt, because the <code>bearingFriction1</code>
element can lock the relative motion between the element and the housing (<code>fixed1</code>),
whereas the clutch element can lock the relative motion between the two
connected flanges. On the contrary, the drive train in the lower part of the figure
may give rise to simulation problems, because the <code>bearingFriction2</code> element
and the <code>brake</code> element can lock the relative motion between a flange and
the housing and these flanges are rigidly connected together, i.e.,
essentially the same relative motion can be locked. These difficulties
may be solved by either introducing a compliance between these flanges
or by combining the bearing friction and brake element into
one component and resolving the ambiguity of the frictional torque in the
stuck mode of that component. A tool may handle this situation also <strong>automatically</strong>,
by picking one solution of the infinitely many, e.g., the one where
the difference to the value of the previous time instant is as small
as possible.
</p>
</html>"));

end RequirementsForSimulationTool;
