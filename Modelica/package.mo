within ;
package Modelica "Modelica Standard Library (Version 3.0.1)"
extends Icons.Library;


annotation (
preferredView="info",
version="3.0.1",
versionBuild="$Rev$",
versionDate="$Date::                            $",
conversion(
 noneFromVersion="3.0",
 from(version="2.1", script="Scripts/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2", script="Scripts/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2.1", script="Scripts/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2.2", script="Scripts/ConvertModelica_from_2.2.2_to_3.0.mos")),
Settings(NewStateSelection=true),
Documentation(info="<HTML>
<p>
Package <b>Modelica</b> is a <b>standardized</b> and <b>free</b> package
that is developed together with the Modelica language from the
Modelica Association, see
<a href=\"http://www.Modelica.org\">http://www.Modelica.org</a>.
It is also called <b>Modelica Standard Library</b>.
It provides model components in many domains that are based on
standardized interface definitions. Some typical examples are shown
in the next figure:
</p>

<p>
<img src=\"../Images/UsersGuide/ModelicaLibraries.png\">
</p>

<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"Modelica://Modelica.UsersGuide.Overview\">Overview</a>
	 provides an overview of the Modelica Standard Library
	 inside the <a href=\"Modelica://Modelica.UsersGuide\">User's Guide</a>.</li>
<li><a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes\">Release Notes</a>
	summarizes the changes of new versions of this package.</li>
<li> <a href=\"Modelica://Modelica.UsersGuide.Contact\">Contact</a>
	 lists the contributors of the Modelica Standard Library.</li>
<li> <a href=\"../help/Documentation/ModelicaStandardLibrary.pdf\">ModelicaStandardLibrary.pdf</a>
	 is the complete documentation of the library in pdf format.
<li> The <b>Examples</b> packages in the various libraries, demonstrate
	 how to use the components of the corresponding sublibrary.</li>
</ul>

<p>
This version of the Modelica Standard Library consists of
</p>
<ul>
<li> <b>781</b> models and blocks, and</li>
<li> <b>553</b> functions
</ul>
<p>
that are directly usable (= number of public, non-partial classes).
</p>


<p>
<b>Licensed by the Modelica Association under the Modelica License 2</b><br>
Copyright &copy; 1998-2009, ABB, arsenal research, DLR, Dynasim, Fraunhofer, Modelon, TU Hamburg-Harburg, Politecnico di Milano.
</p>

<p>
<i>This Modelica package is <u>free</u> software and
the use is completely at <u>your own risk</u>;
it can be redistributed and/or modified under the terms of the
Modelica license 2, see the license conditions (including the
disclaimer of warranty)
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">here</a></u>
or at
<a href=\"http://www.Modelica.org/licenses/ModelicaLicense2\">
http://www.Modelica.org/licenses/ModelicaLicense2</a>.
</p>

</HTML>
"));


package UsersGuide "User's Guide of Modelica library"

annotation (__Dymola_DocumentationClass=true, Documentation(info="<html>
<p>
Package <b>Modelica</b> is a <b>standardized</b> and <b>pre-defined</b> package
that is developed together with the Modelica language from the
Modelica Association, see
<a href=\"http://www.Modelica.org\">http://www.Modelica.org</a>.
It is also called <b>Modelica Standard Library</b>.
It provides constants, types, connectors, partial models and model
components in various disciplines.
</p>
<p>
This is a short <b>User's Guide</b> for
the overall library. Some of the main sublibraries have their own
User's Guides that can be accessed by the following links:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Electrical.Digital.UsersGuide\">Digital</a>
	</td>
	  <td valign=\"top\">Library for digital electrical components based on the VHDL standard
		 (2-,3-,4-,9-valued logic)</td>
</tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.UsersGuide\">MultiBody</a>
			 </td>
	  <td valign=\"top\">Library to model 3-dimensional mechanical systems</td>
</tr>

<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.Rotational.UsersGuide\">Rotational</a>
			 </td>
	  <td valign=\"top\">Library to model 1-dimensional mechanical systems</td>
</tr>

<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Media.UsersGuide\">Media</a>
			 </td>
	  <td valign=\"top\">Property models of media</td>
</tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.SIunits.UsersGuide\">SIunits</a> </td>
	  <td valign=\"top\">Type definitions based on SI units according to ISO 31-1992</td>
</tr>

<tr><td valign=\"top\"><a href=\"Modelica://Modelica.StateGraph.UsersGuide\">StateGraph</a>
			 </td>
	  <td valign=\"top\">Library to model discrete event and reactive systems by hierarchical state machines</td>
</tr>


<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Utilities.UsersGuide\">Utilities</a>
			 </td>
	  <td valign=\"top\">Utility functions especially for scripting (Files, Streams, Strings, System)</td>
</tr>
</table>

</html>"));

class Overview "Overview of Modelica Library"

 annotation (Documentation(info="<html>
<p>
The Modelica Standard Library consists of the following
main sub-libraries:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Library Components</th> <th>Description</th></tr>

<tr><td valign=\"top\">
	<img src=\"../Images/UsersGuide/Lib-Electrical.png\">
	</td>
	<td valign=\"top\">
	<a href=\"Modelica://Modelica.Electrical.Analog\">Analog</a><br>
	Analog electric and electronic components, such as <br>
	resistor, capacitor, transformers, diodes, transistors,<br>
	transmission lines, switches, sources, sensors.
	</td>
</tr>

<tr><td valign=\"top\">
	<img src=\"../Images/UsersGuide/Lib-Digital.png\">
	</td>
	<td valign=\"top\">
	<a href=\"Modelica://Modelica.Electrical.Digital\">Digital</a><br>
	Digital electrical components based on the VHDL standard, <br>
	like basic logic blocks with 9-value logic, delays, gates, <br>
	sources, converters between 2-, 3-, 4-, and 9-valued logic.
	</td>
</tr>

<tr><td valign=\"top\">
	<img src=\"../Images/UsersGuide/Lib-Machines.png\">
	</td>
	<td valign=\"top\">
	<a href=\"Modelica://Modelica.Electrical.Machines\">Machines</a><br>
	Electrical asynchronous-, synchronous-, and DC-machines<br>
	(motors and generators) as well as 3-phase transformers.
	</td>
</tr>

<tr><td valign=\"top\">
	<img src=\"../Images/UsersGuide/Lib-Translational.png\">
	</td>
	<td valign=\"top\">
	<a href=\"Modelica://Modelica.Mechanics.Translational\">Translational</a><br>
	1-dim. mechanical, translational systems, e.g.,  <br>
	sliding mass, mass with stops, spring, damper.
	</td>
</tr>

<tr><td valign=\"top\">
	<img src=\"../Images/UsersGuide/Lib-Rotational.png\">
	</td>
	<td valign=\"top\">
	<a href=\"Modelica://Modelica.Mechanics.Rotational\">Rotational</a><br>
	1-dim. mechanical, rotational systems, e.g., inertias, gears, <br>
	planetary gears, convenient definition of speed/torque dependent friction<br>
	(clutches, brakes, bearings, ..)
	</td>
</tr>

<tr><td valign=\"top\">
	<img src=\"../Images/UsersGuide/Lib-MultiBody1.png\"><br>
	<img src=\"../Images/UsersGuide/Lib-MultiBody2.png\">
	</td>
	<td valign=\"top\">
	<a href=\"Modelica://Modelica.Mechanics.MultiBody\">MultiBody</a><br>
	3-dim. mechanical systems consisting of joints, bodies, force and <br>
	sensor elements. Joints can be driven by drive trains defined by<br>
	1-dim. mechanical system library (Rotational).<br>
	Every component has a default animation.<br>
	Components can be arbitrarily connected together.
	</td>
</tr>

<tr><td valign=\"top\">
	<img src=\"../Images/UsersGuide/Lib-Media.png\">
	</td>
	<td valign=\"top\">
	<a href=\"Modelica://Modelica.Media\">Media</a><br>
	Large media library providing models and functions<br>
	to compute media properties, such as h = h(p,T), d = d(p,T),<br>
	for the following media:
	<ul>
	<li> 1240 gases and mixtures between these gases.</li>
	<li> incompressible, table based liquids (h = h(T), etc.).</li>
	<li> compressible liquids</li>
	<li> dry and moist air</li>
	<li> high precision model for water (IF97).</li>
	</ul>
	</td>
</tr>

<tr><td valign=\"top\">
	<img src=\"../Images/UsersGuide/Lib-Thermal.png\">
	</td>
	<td valign=\"top\">
	<a href=\"Modelica://Modelica.Thermal.FluidHeatFlow\">FluidHeatFlow</a>,
	<a href=\"Modelica://Modelica.Thermal.HeatTransfer\">HeatTransfer</a><br>
	Simple thermo-fluid pipe flow, especially to model cooling of machines <br>
	with air or water (pipes, pumps, valves, ambient, sensors, sources) and<br>
	lumped heat transfer with heat capacitors, thermal conductors, convection,<br>
	body radiation, sources and sensors.
	</td>
</tr>

<tr><td valign=\"top\">
	<img src=\"../Images/UsersGuide/Lib-Blocks1.png\"><br>
	<img src=\"../Images/UsersGuide/Lib-Blocks2.png\">
	</td>
	<td valign=\"top\">
	<a href=\"Modelica://Modelica.Blocks\">Blocks</a><br>
	Input/output blocks to model block diagrams and logical networks, e.g.,<br>
	integerator, PI, PID, transfer function, linear state space system,<br>
	sampler, unit delay, discrete transfer function, and/or blocks,<br>
	timer, hysteresis, nonlinear and routing blocks, sources, tables.
	</td>
</tr>

<tr><td valign=\"top\">
	<img src=\"../Images/UsersGuide/Lib-StateGraph.png\">
	</td>
	<td valign=\"top\">
	<a href=\"Modelica://Modelica.StateGraph\">StateGraph</a><br>
	Hierarchical state machines with a similar modeling power as Statecharts. <br>
	Modelica is used as synchronous action language, i.e. deterministic <br>
	behavior is guaranteed
	</td>
</tr>


<tr><td valign=\"top\">
	<pre>
	A = [1,2,3;
		 3,4,5;
		 2,1,4];
	b = {10,22,12};
	x = Matrices.solve(A,b);
	Matrices.eigenValues(A);
	</pre>
	</td>
	<td valign=\"top\">
	<a href=\"Modelica://Modelica.Math\">Math</a>,
	<a href=\"Modelica://Modelica.Utilities\">Utilities</a><br>
	Functions operating on vectors and matrices, such as for solving <br>
	linear systems, eigen and singular values etc.,  and <br>
	functions operating on strings, streams, files, e.g., <br>
	to copy and remove a file or sort a vector of strings.
	</td>
</tr>

</table>

</html>
"));
end Overview;

class Connectors "Connectors"

 annotation (Documentation(info="<html>

<p>
The Modelica standard library defines the most important
<b>elementary connectors</b> in various domains. If any possible,
a user should utilize these connectors in order that components
from the Modelica Standard Library and from other libraries
can be combined without problems. The following elementary
connectors are defined (potential variables are connector variables
without the flow attribute, flow variables are connector variables
that have the flow attribute):
</p>

<table border=1 cellspacing=0 cellpadding=1>
<tr><td valign=\"top\"><b>domain</b></td>
	  <td valign=\"top\"><b>pot. variables</b></td>
	  <td valign=\"top\"><b>flow variables</b></td>
	  <td valign=\"top\"><b>connector definition</b></td>
	  <td valign=\"top\"><b>icons</b></td></tr>

<tr><td valign=\"top\"><b>electrical<br>analog</b></td>
	  <td valign=\"top\">electrical potential</td>
	  <td valign=\"top\">electrical current</td>
	  <td valign=\"top\"><a href=\"Modelica://Modelica.Electrical.Analog.Interfaces\">Modelica.Electrical.Analog.Interfaces</a>
		   <br>Pin, PositivePin, NegativePin</td>
	  <td valign=\"top\"><img src=\"../Images/UsersGuide/ElectricalPins.png\"></td></tr>

<tr><td valign=\"top\"><b>electrical<br>multi-phase</b></td>
	  <td colspan=\"2\">vector of electrical pins</td>
	  <td valign=\"top\"><a href=\"Modelica://Modelica.Electrical.MultiPhase.Interfaces\">Modelica.Electrical.MultiPhase.Interfaces</a>
		   <br>Plug, PositivePlug, NegativePlug</td>
	  <td valign=\"top\"><img src=\"../Images/UsersGuide/ElectricalPlugs.png\"></td></tr>

<tr><td valign=\"top\"><b>electrical <br>sphace phasor</b></td>
	  <td valign=\"top\">2 electrical potentials</td>
	  <td valign=\"top\">2 electrical currents</td>
	  <td valign=\"top\"><a href=\"Modelica://Modelica.Electrical.Machines.Interfaces\">Modelica.Electrical.Machines.Interfaces</a>
		   <br>SpacePhasor</td>
	  <td valign=\"top\"><img src=\"../Images/UsersGuide/SpacePhasor.png\"></td></tr>

<tr><td valign=\"top\"><b>electrical <br>digital</b></td>
	  <td valign=\"top\">Integer (1..9)</td>
	  <td valign=\"top\">---</td>
	  <td valign=\"top\"><a href=\"Modelica://Modelica.Electrical.Digital.Interfaces\">Modelica.Electrical.Digital.Interfaces</a>
		   <br>DigitalSignal, DigitalInput, DigitalOutput</td>
	  <td valign=\"top\"><img src=\"../Images/UsersGuide/Digital.png\"></td></tr>

<tr><td valign=\"top\"><b>translational</b></td>
	  <td valign=\"top\">distance</td>
	  <td valign=\"top\">cut-force</td>
	  <td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.Translational.Interfaces\">Modelica.Mechanics.Translational.Interfaces</a>
		   <br>Flange_a, Flange_b</td>
	  <td valign=\"top\"><img src=\"../Images/UsersGuide/TranslationalFlanges.png\"></td></tr>

<tr><td valign=\"top\"><b>rotational</b></td>
	  <td valign=\"top\">angle</td>
	  <td valign=\"top\">cut-torque</td>
	  <td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.Rotational.Interfaces\">Modelica.Mechanics.Rotational.Interfaces</a>
		   <br>Flange_a, Flange_b</td>
	  <td valign=\"top\"><img src=\"../Images/UsersGuide/RotationalFlanges.png\"></td></tr>

<tr><td valign=\"top\"><b>3-dim.<br>mechanics</b></td>
	  <td valign=\"top\">position vector<br>
		  orientation object</td>
	  <td valign=\"top\">cut-force vector<br>
		  cut-torque vector</td>
	  <td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Interfaces\">Modelica.Mechanics.MultiBody.Interfaces</a>
		   <br>Frame, Frame_a, Frame_b, Frame_resolve</td>
	  <td valign=\"top\"><img src=\"../Images/UsersGuide/MultiBodyFrames.png\"></td></tr>

<tr><td valign=\"top\"><b>simple<br>fluid flow</b></td>
	  <td valign=\"top\">pressure<br>
		  specific enthalpy</td>
	  <td valign=\"top\">mass flow rate<br>
		  enthalpy flow rate</td>
	  <td valign=\"top\"><a href=\"Modelica://Modelica.Thermal.FluidHeatFlow.Interfaces\">Modelica.Thermal.FluidHeatFlow.Interfaces</a>
		   <br>FlowPort, FlowPort_a, FlowPort_b</td>
	  <td valign=\"top\"><img src=\"../Images/UsersGuide/FluidHeatFlowPorts.png\"></td></tr>

<tr><td valign=\"top\"><b>heat<br>transfer</b></td>
	  <td valign=\"top\">temperature</td>
	  <td valign=\"top\">heat flow rate</td>
	  <td valign=\"top\"><a href=\"Modelica://Modelica.Thermal.HeatTransfer.Interfaces\">Modelica.Thermal.HeatTransfer.Interfaces</a>
		   <br>HeatPort, HeatPort_a, HeatPort_b</td>
	  <td valign=\"top\"><img src=\"../Images/UsersGuide/ThermalHeatPorts.png\"></td></tr>

<tr><td valign=\"top\"><b>block<br>diagram</b></td>
	  <td valign=\"top\">Real variable<br>
		  Integer variable<br>
		  Boolean variable</td>
	  <td valign=\"top\">---</td>
	  <td valign=\"top\"><a href=\"Modelica://Modelica.Blocks.Interfaces\">Modelica.Blocks.Interfaces</a>
		   <br>RealSignal, RealInput, RealOutput<br>
			   IntegerSignal, IntegerInput, IntegerOutput<br>
			   BooleanSignal, BooleanInput, BooleanOutput</td>
	  <td valign=\"top\"><img src=\"../Images/UsersGuide/Signals.png\"></tr>

<tr><td valign=\"top\"><b>state<br>machine</b></td>
	  <td valign=\"top\">Boolean variables<br>
		  (occupied, set, <br>
		   available, reset)</td>
	  <td valign=\"top\">---</td>
	  <td valign=\"top\"><a href=\"Modelica://Modelica.StateGraph.Interfaces\">Modelica.StateGraph.Interfaces</a>
		   <br>Step_in, Step_out, Transition_in, Transition_out</td>
	  <td valign=\"top\"><img src=\"../Images/UsersGuide/StateGraphPorts.png\"></td></tr>

<tr><td colspan=\"5\">&nbsp;<br><b>Connectors from libraries that will be included in one of
								   the next releases of package Modelica</b></td></tr>

<tr><td valign=\"top\"><b>thermo<br>fluid flow</b></td>
	  <td valign=\"top\">pressure<br>
		  specific enthalpy<br>
		  mass fractions</td>
	  <td valign=\"top\">mass flow rate<br>
		  enthalpy flow rate<br>
		  subst. mass flow rates</td>
	  <td valign=\"top\">Modelica_Fluid.Interfaces
		   <br>FluidPort, FluidPort_a, FluidPort_b</td>
	  <td valign=\"top\"><img src=\"../Images/UsersGuide/FluidPorts.png\"></td></tr>

<tr><td valign=\"top\"><b>magnetic</b></td>
	  <td valign=\"top\">magnetic potential</td>
	  <td valign=\"top\">magnetic flux</td>
	  <td valign=\"top\">Magnetic.Interfaces
		   <br>MagneticPort, PositiveMagneticPort, <br>NegativeMagneticPort</td>
	  <td valign=\"top\"><img src=\"../Images/UsersGuide/MagneticPorts.png\"></td></tr>


<tr><td colspan=\"5\">&nbsp;<br><b>Connectors from other libraries</b></td></tr>

<tr><td valign=\"top\"><b>hydraulic</b></td>
	  <td valign=\"top\">pressure</td>
	  <td valign=\"top\">volume flow rate</td>
	  <td valign=\"top\">HyLibLight.Interfaces
		   <br>Port_A, Port_b</td>
	  <td valign=\"top\"><img src=\"../Images/UsersGuide/HydraulicPorts.png\"></td></tr>

<tr><td valign=\"top\"><b>pneumatic</b></td>
	  <td valign=\"top\">pressure</td>
	  <td valign=\"top\">mass flow rate</td>
	  <td valign=\"top\">PneuLibLight.Interfaces
		   <br>Port_1, Port_2</td>
	  <td valign=\"top\"><img src=\"../Images/UsersGuide/PneumaticPorts.png\"></td></tr>
</table>

<p>
In all domains, usually 2 connectors are defined. The variable declarations
are <b>identical</b>, only the icons are different in order that it is easy
to distinguish connectors of the same domain that are attached at the same
component.
</p>

<p>
Modelica supports also hierarchical connectors, in a similar way as hierarchical models.
As a result, it is, e.g., possible, to collect elementary connectors together.
For example, an electrical plug consisting of two electrical pins can be defined as:
</p>

<pre>   <b>connector</b> Plug
	  <b>import</b> Modelica.Electrical.Analog.Interfaces;
	  Interfaces.PositivePin phase;
	  Interfaces.NegativePin ground;
<b>end</b> Plug;
</pre>

<p>
With one connect(..) equation, either two plugs can be connected
(and therefore implicitly also the phase and ground pins) or a
Pin connector can be directly connected to the phase or ground of
a Plug connector, such as \"connect(resistor.p, plug.phase)\".
</p>


</html>
"));
end Connectors;

class Conventions "Conventions"

 annotation (Documentation(info="<html>

<p>
Note, in the html documentation of any Modelica library,
the headings \"h1, h2, h3\" should not be used,
because they are utilized from the automatically generated documentation/headings.
Additional headings in the html documentation should start with \"h4\".
</p>

<p>
In the Modelica package the following conventions are used:
</p>
<ol>
<li> Class and instance names are written in upper and lower case
	 letters, e.g., \"ElectricCurrent\". An underscore is only used
	 at the end of a name to characterize a lower or upper index,
	 e.g., \"pin_a\".<br>&nbsp;</li>

<li> <b>Class names</b> start always with an upper case letter.<br>&nbsp;</li>

<li> <b>Instance names</b>, i.e., names of component instances and
	 of variables (with the exception of constants),
	 start usually with a lower case letter with only
	 a few exceptions if this is common sense
	 (such as \"T\" for a temperature variable).<br>&nbsp;</li>

<li> <b>Constant names</b>, i.e., names of variables declared with the
	 \"constant\" prefix, follow the usual naming conventions
	 (= upper and lower case letters) and start usually with an
	 upper case letter, e.g. UniformGravity, SteadyState.<br>&nbsp;<li>

<li> The two connectors of a domain that have identical declarations
	 and different icons are usually distinguished by \"_a\", \"_b\"
	 or \"_p\", \"_n\", e.g., Flange_a/Flange_b, HeatPort_a, HeatPort_b.<br>&nbsp;</li>

<li> The <b>instance name</b> of a component is always displayed in its icon
	 (= text string \"%name\") in <b>blue color</b>. A connector class has the instance
	 name definition in the diagram layer and not in the icon layer.
	 <b>Parameter</b> values, e.g., resistance, mass, gear ratio, are displayed
	 in the icon in <b>black color</b> in a smaller font size as the instance name.
	<br>&nbsp;<li>

<li> A main package has usually the following subpackages:
	 <ul>
	 <li><b>UsersGuide</b> containing an overall description of the library
		 and how to use it.</li>
	 <li><b>Examples</b> containing models demonstrating the
		 usage of the library.</li>
	 <li><b>Interfaces</b> containing connectors and partial
		 models.</li>
	 <li><b>Types</b> containing type, enumeration and choice
		 definitions.</li>
	 </ul>
	 </li>
</ol>

</html>
"));
end Conventions;

class ParameterDefaults "Parameter defaults"

 annotation (Documentation(info="<html>

<p>
In this section the convention is summarized how default parameters are
handled in the Modelica Standard Library (since version 3.0).
</p>

<p>
Many models in this library have parameter declarations to define
constants of a model that might be changed before simulation starts.
Example:
</p>

<blockquote>
<pre>
<b>model</b> SpringDamper
<b>parameter</b> Real c(final unit=\"N.m/rad\")    = 1e5 \"Spring constant\";
<b>parameter</b> Real d(final unit=\"N.m.s/rad\")  = 0   \"Damping constant\";
<b>parameter</b> Modelica.SIunits.Angle phi_rel0 = 0   \"Unstretched spring angle\";
...
<b>end</b> SpringDamper;
</pre>
</blockquote>

<p>
In Modelica it is possible to define a default value of a parameter in
the parameter declaration. In the example above, this is performed for
all parameters. Providing default values for all parameters can lead to
errors that are difficult to detect, since a modeler may have forgotten
to provide a meaningful value (the model simulates but gives wrong
results due to wrong parameter values). In general the following basic
situations are present:
</p>

<ol>
<li> The parameter value could be anything (e.g., a spring constant or
	 a resistance value) and therefore the user should provide a value in
	 all cases. A Modelica translator should warn, if no value is provided.
	 <br><br></li>

<li> The parameter value is not changed in &gt; 95 % of the cases
	 (e.g. initialization or visualization parameters, or parameter phi_rel0
	 in the example above). In this case a default parameter value should be
	 provided, in order that the model or function can be conveniently
	 used by a modeler.
	 <br><br></li>

<li> A modeler would like to quickly utilize a model, e.g.,
	 <ul>
	 <li> to automatically check that the model still translates and/or simulates
		  (after some changes in the library),</li>
	 <li> to make a quick demo of a library by drag-and-drop of components,</li>
	 <li> to implement a simple test model in order to get a better understanding
		  of the desired component.</li>
	 </ul>
	 In all these cases, it would be not practical, if the modeler would
	 have to provide explicit values for all parameters first.
	 </li>
</ol>

<p>
To handle the conflicting goals of (1) and (3), the Modelica Standard Library
uses two approaches to define default parameters, as demonstrated with the
following example:
</p>

<blockquote>
<pre>
<b>model</b> SpringDamper
<b>parameter</b> Real c(final unit=\"N.m/rad\"  , start=1e5) \"Spring constant\";
<b>parameter</b> Real d(final unit=\"N.m.s/rad\", start=  0) \"Damping constant\";
<b>parameter</b> Modelica.SIunits.Angle phi_rel0 = 0       \"Unstretched spring angle\";
...
<b>end</b> SpringDamper;

SpringDamper sp1;              // warning for \"c\" and \"d\"
SpringDamper sp2(c=1e4, d=0);  // fine, no warning
</pre>
</blockquote>

<p>
Both definition forms, using a \"start\" value (for \"c\" and \"d\") and providing
a declaration equation (for \"phi_rel0\"), are valid Modelica and define the value
of the parameter. By convention, it is expected that Modelica translators will
trigger a warning message for parameters that are <b>not</b> defined by a declaration
equation, by a modifier equation or in an initial equation/algorithm section.
A Modelica translator might have options to change this behavior, especially,
that no messages are printed in such cases and/or that an error is triggered
instead of a warning.
</p>

</html>
"));
end ParameterDefaults;

package ReleaseNotes "Release notes"
class Version_3_0_1 "Version 3.0.1 (Jan.27, 2009)"

   annotation (Documentation(info="<html>

<p>
This Modelica package is provided under the
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica License 2</a>
and no longer under Modelica License 1.1. There are the following reasons
why the Modelica Association changes from Modelica License 1.1 to this
new license text (note, the text below is not a legal interpretation of the
Modelica License 2. In case of a conflict, the language of the license shall prevail):
</p>

<ol>
<li> The rights of licensor and licensee are much more clearly defined. For example:
	 <ul>
	 <li> The licensed work (Original Work) can be used in unmodified form in
		  open source and commercial software (the licensee cannot change the
		  license and the work must be provided without fees)</li>
	 <li> If a model component is copied out of a Modelica package under
		  Modelica License 2 and is modified in order to adapt it to the needs
		  of the modeler, then the result can be licensed under any license
		  (including a commercial license).</li>
	 <li> It is practically not possible to change the license of a
		  Modelica package under Modelica License 2 to another license, i.e., a
		  licensee cannot change the license by adding material or changing classes,
		  so the work must remain under Modelica License 2 (to be more precise,
		  if the licensee makes modifications to the Original Work \"which represents,
		  as a whole, an original work of authorship\", he/she can change the license
		  to another license. However, for a Modelica package this would
		  require a lot of changes which is usually unrealistic).</li>
	 <li> If an executable is constructed using a Modelica package under
		  Modelica License 2, then this executable can be licensed under any
		  license (including a commercial license).</li>
	 </ul>
	 We hope that this compromise between open source contributors, commercial
	 Modelica environments and Modelica users will motivate even more people to
	 provide their Modelica packages freely under the Modelica License 2.<br><br></li>
<li> There are several new provisions that shall make law suites against licensors and licensees more unlikely (so the small risk is further reduced).</li>
</ol>



<p><br>
The following <b style=\"color:blue\">new components</b> have been added
to <b style=\"color:blue\">existing</b> libraries:
</p>

<table border=\"1\" cellspacing=0 cellpadding=2 style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><b>Electrical.Analog.Basic.</b></td></tr>
<tr><td valign=\"top\">M_Transformer</td>
	  <td valign=\"top\"> Transformer, with the possibility to
	choose the number of inductors. The inductances and the coupled inductances
	can be chosen arbitrarily.</td> </tr>

<tr><td colspan=\"2\"><b>Electrical.Analog.Lines.</b></td></tr>
<tr><td valign=\"top\">M_OLine</td>
	  <td valign=\"top\"> Segmented line model that enables the use of
	multiple lines, that means, the number of segments and the number of
	single lines can be chosen by the user. The model allows to investigate
	phenomena at multiple lines like mutual magnetic or capacitive influence.</td> </tr>
<tr><td colspan=\"2\"><b>Mechanics.Translational.Components.Examples.</b></td></tr>
<tr><td valign=\"top\">Brake</td>
	  <td valign=\"top\"> Demonstrates the usage of the translational brake component.</td> </tr>
<tr><td colspan=\"2\"><b>Media.Interfaces.PartialMedium.</b></td></tr>
<tr><td valign=\"top\">ThermoStates</td>
	  <td valign=\"top\"> Enumeration type for independent variables to identify the independent
						variables of the medium (pT, ph, phX, pTX, dTX).<br>
						An implementation of this enumeration is provided for every medium.
						(This is useful for fluid libraries that do not use the
						PartialMedium.BaseProperties model). </td> </tr>
<tr><td valign=\"top\">setSmoothState</td>
	  <td valign=\"top\"> Function that returns the thermodynamic state which smoothly approximates:
						if x > 0 then state_a else state_b.<br>
						(This is useful for pressure drop components in fluid libraries
						 where the upstream density and/or viscosity has to be computed
						 and these properties should be smooth a zero mass flow rate)<br>
						An implementation of this function is provided for every medium.</td> </tr>
<tr><td colspan=\"2\"><b>Media.Common.</b></td></tr>
<tr><td valign=\"top\">smoothStep</td>
	  <td valign=\"top\"> Approximation of a general step, such that the characteristic
						is continuous and differentiable.</td> </tr>
<tr><td colspan=\"2\"><b>Media.UsersGuide.</b></td></tr>
<tr><td valign=\"top\">Future</td>
	  <td valign=\"top\"> Short description of goals and changes of upcoming release of Modelica.Media. </td> </tr>
<tr><td colspan=\"2\"><b>Media.Media.Air.MoistAir.</b></td></tr>
<tr><td valign=\"top\">isentropicExponent</td>
	  <td valign=\"top\"> Implemented Missing Function from interface. </td> </tr>
<tr><td valign=\"top\">isentropicEnthalpyApproximation</td>
<td valign=\"top\"> Implemented function that approximates the isentropic enthalpy change.
This is only correct as long as there is no liquid in the stream.</td> </tr>
</table>


<p><br>
The following <b style=\"color:blue\">existing components</b>
have been <b style=\"color:blue\">changed</b> (in a
<b style=\"color:blue\">backward compatible</b> way):
</p>

<table border=\"1\" cellspacing=0 cellpadding=2 style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><b>Mechanics.Rotational.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> PartialFriction </td>
	  <td valign=\"top\"> Improvement of friction model so that in certain situations
						the number of iterations is much smaller.</td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.Translational.Components.Examples.</b></td></tr>
<tr><td valign=\"top\"> Friction </td>
	  <td valign=\"top\"> Added a third variant, where friction is modelled with
						the SupportFriction component.</td> </tr>

<tr><td colspan=\"2\"><b>Mechanics.Translational.Components.</b></td></tr>
<tr><td valign=\"top\"> MassWithStopAndFriction </td>
	  <td valign=\"top\"> Improvement of friction model so that in certain situations
						the number of iterations is much smaller.</td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.Translational.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> PartialFriction </td>
	  <td valign=\"top\"> Improvement of friction model so that in certain situations
						the number of iterations is much smaller.</td>
</tr>

<tr><td colspan=\"2\"><b>Media.Examples.</b></td></tr>
<tr><td valign=\"top\"> SimpleLiquidWater <br>
						IdealGasH20 <br>
						WaterIF97 <br>
						MixtureGases <br>
						MoistAir </td>
	  <td valign=\"top\"> Added equations to test the new setSmoothState(..) functions
						including the analytic derivatives of these functions.</td> </tr>

<tr><td colspan=\"2\"><b>Media.Interfaces.PartialLinearFluid.</b></td></tr>
<tr><td valign=\"top\"> setState_pTX <br>
						setState_phX <br>
						setState_psX <br>
						setState_dTX </td>
	  <td valign=\"top\"> Rewritten function in one statement so that it is usually inlined.</td> </tr>

<tr><td colspan=\"2\"><b>Media.Interfaces.PartialLinearFluid.</b></td></tr>
<tr><td valign=\"top\"> consistent use of reference_d instead of density(state </td>
	  <td valign=\"top\"> Change was done to achieve consistency with analytic inverse functions.</td> </tr>


<tr><td colspan=\"2\"><b>Media.Air.MoistAir.</b></td></tr>
<tr><td valign=\"top\"> T_phX </td>
	  <td valign=\"top\"> Interval of nonlinear solver to compute T from p,h,X changed
						from 200..6000 to 240 ..400 K.</td> </tr>

</table>


<p><br>
The following <b style=\"color:red\">critical errors</b> have been fixed (i.e. errors
that can lead to wrong simulation results):
</p>

<table border=\"1\" cellspacing=0 cellpadding=2 style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Forces</b></td></tr>
<tr><td valign=\"top\"> WorldTorque </td>
	  <td valign=\"top\"> Parameter \"ResolveInFrame\" was not propagated and therefore
						always the default (resolved in world frame) was used, independently
						of the setting of this parameter. </td>
</tr>
<tr><td valign=\"top\"> WorldForceAndTorque </td>
	  <td valign=\"top\"> Parameter \"ResolveInFrame\" was not propagated and therefore
						always the default (resolved in world frame) was used, independently
						of the setting of this parameter.<br>
						Furthermore, internally WorldTorque was used instead of
						Internal.BasicWorldTorque and therefore the visualization of
						worldTorque was performed twice. </td>
</tr>
<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Sensors</b></td></tr>
<tr><td valign=\"top\"> AbsoluteSensor </td>
	  <td valign=\"top\"> Velocity, acceleration and angular acceleration were computed
						  by differentiating in the resolveInFrame frame. This has been corrected, by
						  first transforming the vectors in to the world frame, differentiating here
						  and then transforming into resolveInFrame. The parameter in the Advanced menue
						  resolveInFrameAfterDifferentiation is then superfluous and was removed . </td>
</tr>
<tr><td valign=\"top\"> AbsoluteVelocity </td>
	  <td valign=\"top\"> The velocity was computed
						  by differentiating in the resolveInFrame frame. This has been corrected, by
						  first transforming the velocity in to the world frame, differentiating here
						  and then transforming into resolveInFrame </td>
</tr>
<tr><td valign=\"top\"> RelativeSensor </td>
	  <td valign=\"top\"> If resolveInFrame &lt;&gt; frame_resolve and
						   resolveInFrameAfterDifferentiation = frame_resolve, a translation
						error occured, since frame_resolve was not enabled in this situation.
						This has been corrected.</td>
</tr>
<tr><td valign=\"top\"> RelativeVelocity </td>
	  <td valign=\"top\"> The velocity has have been computed
						  by differentiating in the resolveInFrame frame. This has been corrected, by
						  first transforming the relative position in to frame_a, differentiating here
						  and then transforming into resolveInFrame </td>
</tr>
<tr><td valign=\"top\"> TransformRelativeVector </td>
	  <td valign=\"top\"> The transformation was wrong, since the parameters frame_r_in and frame_r_out
						have not been propagated to the submodel that performs the transformation.
						This has been corrected. </td>
</tr>
<tr><td colspan=\"2\"><b>Mechanics.Translational.Components.</b></td></tr>
<tr><td valign=\"top\"> SupportFriction<br>
						Brake </td>
	  <td valign=\"top\"> The sign of the friction force was wrong and therefore friction accelerated
						instead of decelerated. This was fixed. </td>
<tr><td valign=\"top\"> SupportFriction</td>
	  <td valign=\"top\"> The component was only correct for fixed support.
						This was corrected. </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> PartialSimpleMedium<br>
						PartialSimpleIdealGasMedium </td>
	  <td valign=\"top\"> BaseProperties.p was not defined as preferred state and BaseProperties.T was
						always defined as preferred state. This has been fixed by
						Defining p,T as preferred state if parameter preferredMediumState = true.
						This error had the effect that mass m is selected as state instead of p
						and if default initialization is used then m=0 could give not the expected
						behavior. This means, simulation is not wrong but the numerics is not as good
						and if a model relies on default initial values, the result could be not
						as expected. </td>
</tr>

</table>


<p><br>
The following <b style=\"color:red\">uncritical errors</b> have been fixed (i.e. errors
that do <b style=\"color:red\">not</b> lead to wrong simulation results, but, e.g.,
units are wrong or errors in documentation):
</p>

<table border=\"1\" cellspacing=0 cellpadding=2 style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><b>Blocks.Math.</b></td></tr>
<tr><td valign=\"top\"> InverseBlockConstraint </td>
	  <td valign=\"top\"> Changed annotation preserveAspectRatio from true to false.</td>
</tr>

<tr><td colspan=\"2\"><b>Blocks.Sources.</b></td></tr>
<tr><td valign=\"top\"> RealExpression<br>
						IntegerExpression<br>
						BooleanExpression </td>
	  <td valign=\"top\"> Changed annotation preserveAspectRatio from true to false.</td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Analog.Basic.</b></td></tr>
<tr><td valign=\"top\"> SaturatingInductor</td>
	  <td valign=\"top\"> Replaced non-standard \"arctan\" by \"atan\" function.</td>
</tr>

<tr><td colspan=\"2\"><b>Modelica.Electrical.Digital.</b></td></tr>
<tr><td valign=\"top\"> UsersGuide</td>
	  <td valign=\"top\"> Removed empty documentation placeholders and added the missing
						  release comment for version 1.0.7</td>
</tr>


<tr><td colspan=\"2\"><b>Modelica.Mechanics.Translational.Components.</b></td></tr>
<tr><td valign=\"top\"> MassWithStopAndFriction </td>
	  <td valign=\"top\"> Changed usage of reinit(..), in order that it appears
						only once for one variable according to the language specification
						(if a tool could simulate the model, there is no difference).</td>
</tr>

<tr><td colspan=\"2\"><b>Media.Interfaces.PartialSimpleMedium</b></td></tr>
<tr><td valign=\"top\"> pressure<br>
						temperature<br>
						density<br>
						specificEnthalpy </td>
	  <td valign=\"top\"> Missing functions added.</td>
</tr>

</table>


</html>"));
end Version_3_0_1;

 annotation (Documentation(info="<html>

<p>
This section summarizes the changes that have been performed
on the Modelica standard library.
</p>

<ul>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_3_0_1\">Version 3.0.1</a> (Jan., 2009)</li>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_3_0\">Version 3.0</a> (Feb., 2008)</li>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_2_2_2\">Version 2.2.2</a> (Aug. 31, 2007)</li>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_2_2_1\">Version 2.2.1</a> (March 24, 2006)</li>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_2_2\">Version 2.2</a> (April 6, 2005)</li>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_2_1\">Version 2.1</a> (Nov. 11, 2004)</li>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_1_6\">Version 1.6</a> (June 21, 2004)</li>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_1_5\">Version 1.5</a> (Dec. 16, 2002)</li>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_1_4\">Version 1.4</a> (June 28, 2001
	 and previous versions)</li>
</ul>

<p>
Maintenance of the Modelica Standard Library is performed with
three branches on the subversion server of the Modelica Association:
</p>

<h4>Released branch</h4>
<p>
Example: \"Modelica/tags/V2_2_1/Modelica\"
</p>

<p>
This branch contains the released Modelica versions (e.g. version 2.2.1),
where all available test cases and compatibility checks with other Modelica
libraries have been performed on the respective release. This version is
usually shipped with a Modelica modelling and simulation environment and
utilized by a Modelica user.
</p>

<h4>Development branch</h4>
<p>
Example: \"Modelica/trunk/Modelica\"
</p>

<p>
This branch contains the actual development version, i.e., all bug fixes
and new features based on the last Modelica release.
New features should have been tested before including them.
However, the exhaustive tests for a new version are (usually) not performed.
This version is usually only be used by the developers of the
Modelica Standard Library and is not utilized by Modelica users.
</p>


<h4>Maintenance branch</h4>
<p>
Example: \"Modelica/branches/maintenance/2.2.1/Modelica\"
</p>

<p>
This branch contains the released Modelica version (e.g. version 2.2.1)
where all bug fixes since this release date are included (up to a  new release,
when becoming available; i.e., after a new release, the previous maintenance
versions are no longer changed).
These bug fixes might be not yet tested with all test cases or with
other Modelica libraries. The goal is that a vendor may take this version at
any time for a new release of its software, in order to incorporate the latest
bug fixes, without changing the version number of the Modelica Standard Library.
</p>

<p>
Incorporation of bug fixes (subversion \"commit\") shall be performed in the following way:
</p>

<ul>
<li> One person is fixing the bug and another person is checking whether the
	 fix is fine.</li>
<li> It is up to the library developer, whether he opens a new branch for
	 testing and then merges it with the \"head\" maintenance branch or not.</li>
<li> Every change to the maintenance branch has to be done at the development
	 branch (see above) as well.</li>
<li> Every change to the maintenance branch requires introducing a
	 description of the bug fix under
	 Modelica.UsersGuide.ReleaseNotes.Version_<release-number>_BugFixes.</li>
<li> Every change to the maintenance branch requires changing the date
	 and the subversion build number in the version annotation. This is automatically
	 performed once a committ of file Modelica\\package.mo is performed.
	 Example:<br>
	 <pre>annotation(version=\"3.0\", versionBuild=\"$Rev$\",versionDate=\"$Date::                            $\").</pre></li>
<li> If time does not permit, a vendor makes the bug fix in its local version
	 and then has to include it in the maintenance version. It would be best to make these
	 changes at a new branch in order to get a unique release number.</li>
</ul>

<p>
A valid \"commit\" to the maintenance branch may contain one or
more of the following changes.
</p>

<ul>
<li> Correcting an equation.</li>
<li> Correcting attributes quantity/unit/defaultUnit in a declaration.</li>
<li> Improving/fixing the documentation.</li>
<li> Introducing a new name in the public section of a class
	 (model, package, ...) or in any section of a partial class is <b>not</b> allowed.
	 Since otherwise, a user might use this new name and when storing its model
	 and loading it with an older build-version, an error would occur.</li>
<li> Introducing a new name in the protected section of a non-partial
	 class should only be done if absolutely necessary to fix a bug.
	 The problem is that this might be non-backward compatible,
	 because a user might already extend from this class and already using the same name.</li>
</ul>
</html>
"));

class Version_3_0 "Version 3.0 (Feb., 2008)"

   annotation (Documentation(info="<html>
<p>
Version 3.0 is <b>not</b> backward compatible to previous versions.
A conversion script is provided to transform models and libraries
of previous versions to the new version. Therefore, conversion
should be automatic.
</p>

<p>
The following changes are present for the whole library:
</p>

<ul>
<li> In the Modelican language version 3.0, several restrictions have been
	 introduced to allow better checking, e.g., models on all levels must be balanced
	 (number of equations = number of unknown variables - unknown variables that have
	 to be defined when using the component). A few models of the Modelica
	 Standard Library did not fulfill these new restrictions and had
	 either to be moved to library ObsoleteModelica3 (e.g. Blocks.Math.TwoInputs)
	 or had to be differently implemented
	 (e.g. Media.Interfaces.PartialMedium.BaseProperties).
	 The Modelica Standard Library version 3.0 fulfills all the restrictions of
	 the Modelica Language version 3.0.<br>&nbsp;
	 </li>

<li> The graphical annotations describing the layout of icon and diagram layer
	 are changed from Modelica language version 1 to Modelica language version 3.
	 This gives several significant improvements:<br>Especially, the coordinate systems
	 of icon and diagram layers are no longer coupled and therefore the size of the
	 icon layer can be changed independently of the size of the diagram layer.
	 Also it can be defined that the aspect ratio of a component icon is kept when changing
	 its size in a model. This flag is set so that all icons of the Modelica
	 Standard Library keep its aspect ratios. This is slightly non-backward compatible:
	 If the aspect ratio was not kept when using a component from the Modelica
	 Standard Library, it is now resized so that the aspect ratio is maintained.<br>&nbsp; </li>

<li> All non-standard annotations removed by:<br>
	 (1) Removing the annotation since without effect
		 (e.g., \"experimentSetupOutput\", \"Window\", \"Terminal\" removed).<br>
	 (2) Renaming the annotation to a standard name (e.g., \"Hide\" renamed to \"HideResult\").<br>
	 (3) Renaming the annotation to a vendor specific name
		 (e.g., \"checkBox\" renamed to \"__Dymola_checkBox\").<br>&nbsp; </li>

<li> All emulated enumerations (defined via packages and constants) have been
	 replaced by \"real\" enumerations. User models are automatically correctly
	 converted, provided the user models used the package constants previously.
	 <b>Existing models that use directly literal values for enumerations, might give in
	 some cases wrong results</b> (if the first constant of the emulated enumeration
	 had value zero, whereas the first value of an enumeration is one).<br>&nbsp; </li>

<li> The operator \"cardinality\" will be removed in one of the next versions of the
	 Modelica language, since it is a reflective operator and its usage significantly
	 reduces the possibilities of advanced model checks (e.g. to guarantee that a model
	 is \"balanced\", i.e., the number of equations and unknowns is identical,
	 for all valid usages of the component). As a preparation for this change, all
	 models that contain the \"cardinality(..)\" operator are rewritten: If possible
	 the operator is removed. If this is not possible, it is only used in asserts to
	 check that, e.g., a connector is connected at least once or is connected exactly
	 once. In the next Modelica language version new language elements will be introduced
	 to specifiy such a property check without the cardinality operator. Once these
	 language elements are available, the cardinality operator will be removed completely
	 from the Modelica Standard Library.<br>
	 The changes with respect to the cardinality(..) operator are usually not backward
	 compatible. This is the reason for the changes of the
	 Rotational and Translational library (see below).<br>&nbsp;</li>

<li> The design of the <b>Rotational</b> and <b>Translational</b> libraries have been changed
	 (especially to remove the cardinality(..) operator, see above):
	 <ul>
	 <li> Components have a <b>useSupport</b> flag to enable or disable a support flange.
		  If the support flange is enabled, it must be connected. If it is disabled, it must
		  not be connected and the component is then internally grounded. The grounding
		  is visualized in the icon.</li>
	 <li> The relative angle/distance and the relative speed of all force/torque elements
		  (that need the relative speed) are by default defined with \"StateSelect.prefer\", i.e.,
		  to use these variables as preferred states. This improves the numerics if the
		  absolute angle or the absolute distance are continuously increasing during
		  operation (e.g. driving shaft of the wheels of a car). The effect is that relative
		  angles/distances and speeds are used as states and the size of these variables is
		  limited. Previously, the default was to use the absolute angle/distance
		  and absolute speed of every inertia/mass which has the disadvantage that the absolute
		  angle and or distance are state variables that grow in size continuously.<br>
		  A significant advantage is also, that default initialization is usually better,
		  because a default value of zero for a relative angle/distance is usually what the
		  user would like to have. Previously, say, the load was initialized to a non-zero
		  angle and then the elastically coupled motor inertia had to be explicitly
		  also initialized with this value. This is now, no longer needed. Since the default
		  nominal value of 1 is usually too large for a relative quantity, the nominal
		  values of the relative angle/distance was changed to 1e-4.</li>
	 <li> The two libraries have been restructured in sublibraries to cope
		  with the growing number of components.</li>
	 <li> Finally, the Translational library has been
		  made as similar as possible to the Rotational library by, e.g., adding missing
		  components.<br>&nbsp;</li>
	 </ul></li>

<li> The initialization of the MultiBody, Rotational and Translational libraries have
	 been signficantly simplified by removing the \"initType\" parameters and only
	 using start/fixed values. This design assumes that a tool has special support
	 for start/fixed values in the parameter menu.<br>&nbsp;</li>

<li> Nearly all parameters defined in the Modelica Standard Library had been
	 defined with a default equation, e.g.,
	 <pre>   <b>parameter</b> Modelica.SIunits.Resistance R=1; </pre>
	 Physical parameters, such as a resistance, mass, gear ratio, do not have a meaningful
	 default and in nearly all cases, the user of the corresponding component has to
	 provide values for such parameters. If the user forgets this, a tool
	 cannot provide diagnostics, since a default value is present in the library
	 (such as 1 Ohm for the resistance). In most cases the model will simulate but will
	 give wrong results due to wrong parameter values. To improve this situation, all physical
	 parameter declarations in the Modelica Standard Library have been changed, so
	 that the previous default becomes a start value. For example, the above
	 declaration is changed to:
	 <pre>   <b>parameter</b> Modelica.SIunits.Resistance R(start=1);  </pre>
	 This is a backward compatible change and completely equivalent from the perspective
	 of the Modelica language. It is, however, advised that tools will print a warning
	 or optionally an error message, if the start value of a parameter is defined, but
	 no value for the parameter is given via a modification. Furthermore, it is expected,
	 that the input field of a parameter menu is empty, if no default equation is defined,
	 but only a start value. This shows clearly to the modeler that a value has to
	 be provided.</li>
</ul>

<p><br>
The following <b style=\"color:blue\">new components</b> have been added
to <b style=\"color:blue\">existing</b> libraries (note, the names in paranthesis
are the new sublibrary names that are introduced in version 3.0):
</p>

<table border=\"1\" cellspacing=0 cellpadding=2 style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><b>Blocks.Examples.</b></td></tr>
<tr><td valign=\"top\">InverseModel</td>
	  <td valign=\"top\"> Demonstrates the construction of an inverse model.</td> </tr>

<tr><td colspan=\"2\"><b>Blocks.Math.</b></td></tr>
<tr><td valign=\"top\">InverseBlockConstraints</td>
	  <td valign=\"top\"> Construct inverse model by requiring that two inputs
						and two outputs are identical (replaces the previously,
						unbalanced, TwoInputs and TwoOutputs blocks).</td> </tr>

<tr><td colspan=\"2\"><b>Electrical.Machines.Utilities</b></td></tr>
<tr><td valign=\"top\">TransformerData</td>
	  <td valign=\"top\"> A record that calculates required impedances (parameters) from nominal data of transformers.</td> </tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Examples.Rotational3DEffects</b></td></tr>
<tr><td valign=\"top\"> GyroscopicEffects<br>
						ActuatedDrive<br>
						MovingActuatedDrive<br>
						GearConstraint </td>
	  <td valign=\"top\"> New examples to demonstrate the usage of the Rotational library
						in combination with multi-body components. </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Sensors</b></td></tr>
<tr><td valign=\"top\"> AbsolutePosition<br>
						AbsoluteVelocity<br>
						AbsoluteAngles<br>
						AbsoluteAngularVelocity<br>
						RelativePosition<br>
						RelativeVelocity<br>
						RelativeAngles<br>
						RelativeAngularVelocity</td>
	  <td valign=\"top\"> New sensors to measure one vector. </td>
</tr>
<tr><td valign=\"top\"> TransformAbsoluteVector<br>
						TransformRelativeVector</td>
	  <td valign=\"top\"> Transform absolute and/or relative vector into another frame. </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.Rotational.(Components)</b></td></tr>
<tr><td valign=\"top\"> Disc </td>
	  <td valign=\"top\"> Right flange is rotated by a fixed angle with respect to left flange</td> </tr>
<tr><td valign=\"top\"> IdealRollingWheel </td>
	  <td valign=\"top\"> Simple 1-dim. model of an ideal rolling wheel without inertia</td> </tr>


<tr><td colspan=\"2\"><b>Mechanics.Translational.Sensors</b></td></tr>
<tr><td valign=\"top\">RelPositionSensor<br>RelSpeedSensor<br>RelAccSensor<br>PowerSensor</td>
	  <td valign=\"top\"> Relative position sensor, i.e. distance between two flanges<br>
						Relative speed sensor<br>
						Relative acceleration sensor<br>
						Ideal power sensor</td> </tr>
<tr><td colspan=\"2\"><b>Mechanics.Translational(.Components)</b></td></tr>
<tr><td valign=\"top\">SupportFriction<br>Brake<br>InitializeFlange</td>
	  <td valign=\"top\"> Model of friction due to support<br>
						Model of a brake, base on Coulomb friction<br>
						Initializes a flange with pre-defined postion, speed and acceleration .</td> </tr>
<tr><td colspan=\"2\"><b>Mechanics.Translational(.Sources)</b></td></tr>
<tr><td valign=\"top\">Force2<br>LinearSpeedDependentForce<br>QuadraticSpeedDependentForce<br>
					   ConstantForce<br>ConstantSpeed<br>ForceStep</td>
	  <td valign=\"top\"> Force acting on 2 flanges<br>
						Force linearly dependent on flange speed<br>
						Force quadratic dependent on flange speed<br>
						Constant force source<br>
						Constant speed source<br>
						Force step</td> </tr>
</tr>
</table>


<p><br>
The following <b style=\"color:blue\">existing components</b>
have been <b style=\"color:blue\">changed</b> in a
<b style=\"color:blue\">non-backward compatible</b> way
(the conversion script transforms models and libraries
of previous versions to the new version. Therefore, conversion
should be automatic):
</p>

<table border=\"1\" cellspacing=0 cellpadding=2 style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><b>Blocks.Continuous.</b></td></tr>
<tr><td valign=\"top\"> CriticalDamping </td>
	  <td valign=\"top\"> New parameter \"normalized\" to define whether filter is provided
						in normalized or non-normalized form. Default is \"normalized = true\".
						The previous implementation was a non-normalized filter.
						The conversion script automatically introduces the modifier
						\"normalized=false\" for existing models.</td> </tr>

<tr><td colspan=\"2\"><b>Blocks.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> RealInput<br>
						RealOutput</td>
	  <td valign=\"top\"> Removed \"SignalType\", since extending from a replaceable class
						and this is not allowed in Modelica 3.<br>The conversion script
						removes modifiers to SignalType.</td> </tr>

<tr><td valign=\"top\"> RealSignal<br>
						IntegerSignal<br>
						BooleanSignal</td>
	  <td valign=\"top\"> Moved to library ObsoleteModelica3, since these connectors
						are no longer allowed in Modelica 3<br>
						(prefixes input and/or output are required). </td> </tr>

<tr><td colspan=\"2\"><b>Blocks.Interfaces.Adaptors.</b></td></tr>
<tr><td valign=\"top\"> AdaptorReal<br>
						AdaptorBoolean<br>
						AdaptorInteger</td>
	  <td valign=\"top\"> Moved to library ObsoleteModelica3, since the models are not \"balanced\".
						These are completely obsolete adaptors<br>between the Real, Boolean, Integer
						signal connectors of version 1.6 and version &ge; 2.1 of the Modelica
						Standard Library. </td> </tr>


<tr><td colspan=\"2\"><b>Blocks.Math.</b></td></tr>
<tr><td valign=\"top\"> ConvertAllUnits</td>
	  <td valign=\"top\"> Moved to library ObsoleteModelica3, since extending from a replaceable class
						and this is not allowed in Modelica 3.<br> It would be possible to rewrite this
						model to use a replaceable component. However, the information about the
						conversion<br> cannot be visualized in the icon in this case.</td> </tr>

<tr><td colspan=\"2\"><b>Blocks.Math.UnitConversions.</b></td></tr>
<tr><td valign=\"top\"> TwoInputs<br>
						TwoOutputs</td>
	  <td valign=\"top\"> Moved to library ObsoleteModelica3, since the models are not \"balanced\".
						A new component<br>\"InverseBlockConstraints\"
						is provided instead that has the same feature, but is \"balanced\".</td> </tr>

<tr><td colspan=\"2\"><b>Electrical.Analog.Baisc.</b></td></tr>
<tr><td valign=\"top\"> HeatingResistor</td>
	  <td valign=\"top\"> The heatPort has to be connected; otherwise the component Resistor (without heatPort) has to be used.<br>
						cardinality() is only used to check whether the heatPort is connected.</td> </tr>

<tr><td colspan=\"2\"><b>Electrical.MultiPhase.Examples.</b></td></tr>
<tr><td valign=\"top\"> </td>
	  <td valign=\"top\"> Changed the instance names of components used in the examples to more up-to-date style.</td> </tr>

<tr><td colspan=\"2\"><b>Electrical.Machines.</b></td></tr>
<tr><td valign=\"top\"> </td>
	  <td valign=\"top\"> Moved package <tt>Machines.Examples.Utilities</tt> to <tt>Machines.Utilities</tt></td> </tr>
<tr><td valign=\"top\"> </td>
	  <td valign=\"top\"> Removed all nonSIunits; especially in DCMachines<br>
						parameter NonSIunits.AngularVelocity_rpm rpmNominal was replaced by<br>
						parameter SIunits.AngularVelocity wNominal</td> </tr>
<tr><td valign=\"top\"> </td>
	  <td valign=\"top\"> Changed the following component variable and parameter names to be more concise:<br>
						Removed suffix \"DamperCage\" from all synchronous induction machines
						since the user can choose whether the damper cage is present or not.<br><tt>
						RotorAngle ... RotorDisplacementAngle<br>
						J_Rotor ... Jr<br>
						Rr ........ Rrd (damper of synchronous induction machines)<br>
						Lrsigma ... Lrsigmad (damper of synchronous induction machines)<br>
						phi_mechanical ... phiMechanical<br>
						w_mechanical ..... wMechanical<br>
						rpm_mechanical ... rpmMechanical<br>
						tau_electrical ... tauElectrical<br>
						tau_shaft ........ tauShaft<br>
						TurnsRatio ....... turnsRatio    (AIMS)<br>
						VsNom ............ VsNominal     (AIMS)<br>
						Vr_Lr ............ VrLockedRotor (AIMS)<br>
						DamperCage ....... useDamperCage (synchronous induction machines)<br>
						V0 ............... VsOpenCicuit  (SMPM)<br>
						Ie0 .............. IeOpenCicuit  (SMEE)
						</tt></td> </tr>
<tr><td valign=\"top\">Interfaces.</td>
	  <td valign=\"top\"> Moved as much code as possible from specific machine models to partials to reduce redundant code.</td> </tr>
<tr><td valign=\"top\">Interfaces.Adapter</td>
	  <td valign=\"top\"> Removed to avoid cardinality; instead, the following solution has been implemented:</td> </tr>
<tr><td valign=\"top\">Sensors.RotorDisplacementAngle<br>Interfaces.PartialBasicMachine</td>
	  <td valign=\"top\"> Introduced <tt>parameter Boolean useSupport=false \"enable / disable (=fixed stator) support\"</tt><br>
						The rotational support connector is only present with <tt>useSupport = true;</tt><br>
						otherwise the stator is fixed internally.</td> </tr>

<tr><td colspan=\"2\"><b>Electrical.Machines.Examples.</b></td></tr>
<tr><td valign=\"top\"> </td>
	  <td valign=\"top\"> Changed the names of the examples to more meaninglful names.<br>
						Changed the instance names of components used in the examples to more up-to-date style.</td> </tr>
<tr><td valign=\"top\">SMEE_Generator</td>
	  <td valign=\"top\"> Initialization of <tt>smee.phiMechanical</tt> with <tt>fixed=true</tt></td> </tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.</b></td></tr>
<tr><td valign=\"top\"> World</td>
	  <td valign=\"top\"> Changed default value of parameter driveTrainMechanics3D from false to true.<br>
						3-dim. effects in Rotor1D, Mounting1D and BevelGear1D are therefore taken<br>
						into account by default (previously this was only the case, if
						world.driveTrainMechanics3D was explicitly set).</td> </tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Forces.</b></td></tr>
<tr><td valign=\"top\"> FrameForce<br>
						FrameTorque<br>
						FrameForceAndTorque</td>
	  <td valign=\"top\"> Models removed, since functionality now available via Force, Torque, ForceAndTorque</td> </tr>
<tr><td valign=\"top\"> WorldForce<br>
						WorldTorque<br>
						WorldForceAndTorque<br>
						Force<br>
						Torque<br>
						ForceAndTorque</td>
	  <td valign=\"top\"> Connector frame_resolve is optionally enabled via parameter resolveInFrame<br>.
						Forces and torques and be resolved in all meaningful frames defined
						by enumeration resolveInFrame.</td> </tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Frames.</b></td></tr>
<tr><td valign=\"top\"> length<br>
						normalize</td>
	  <td valign=\"top\"> Removed functions, since available also in Modelica.Math.Vectors
						<br>The conversion script changes the references correspondingly.</td> </tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Joints.</b></td></tr>
<tr><td valign=\"top\"> Prismatic<br>
						ActuatedPrismatic<br>
						Revolute<br>
						ActuatedRevolute<br>
						Cylindrical<br>
						Universal<br>
						Planar<br>
						Spherical<br>
						FreeMotion</td>
	  <td valign=\"top\"> Changed initialization, by replacing initial value parameters with
						start/fixed attributes.<br>
						When start/fixed attributes are properly supported
						in the parameter menu by a Modelica tool,<br>
						the initialization is considerably simplified for the
						user and the implementation is much simpler.<br>
						Replaced parameter \"enforceStates\" by the more general
						built-in enumeration stateSelect=StateSelection.xxx.<br>
						The conversion script automatically
						transforms from the \"old\" to the \"new\" forms.</td> </tr>
<tr><td valign=\"top\"> Revolute<br>
						ActuatedRevolute</td>
	  <td valign=\"top\"> Parameter \"planarCutJoint\" in the \"Advanced\" menu of \"Revolute\" and of
						\"ActuatedRevolute\" removed.<br>
						A new joint \"RevolutePlanarLoopConstraint\" introduced that defines the constraints
						of a revolute joint<br> as cut-joint in a planar loop.
						This change was needed in order that the revolute joint can be
						properly used<br>in advanced model checking.<br>
						ActuatedRevolute joint removed. Flange connectors of Revolute joint<br>
						can be enabled with parameter useAxisFlange.</td> </tr>
<tr><td valign=\"top\"> Prismatic<br>
						ActuatedPrismatic</td>
	  <td valign=\"top\"> ActuatedPrismatic joint removed. Flange connectors of Prismatic joint<br>
						can be enabled with parameter useAxisFlange.</td> </tr>
<tr><td valign=\"top\"> Assemblies</td>
	  <td valign=\"top\"> Assembly joint implementation slightly changed, so that
						annotation \"structurallyIncomplete\" <br>could be removed
						(all Assembly joint models are now \"balanced\").</td> </tr>


<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Joints.Internal</b></td></tr>
<tr><td valign=\"top\"> RevoluteWithLengthConstraint<br>
						PrismaticWithLengthConstraint</td>
	  <td valign=\"top\"> These joints should not be used by a user of the MultiBody library.
						They are only provided to built-up the
						MultiBody.Joints.Assemblies.JointXYZ joints.
						These two joints have been changed in a slightly not backward compatible
						way, in order that the usage in the Assemblies.JointXYZ joints results in
						balanced models (<b>no conversion is provided for this change since the
						user should not have used these joints and the conversion would be too
						complicated</b>):
						In releases before version 3.0 of the Modelica Standard Library,
						it was possible to activate the torque/force projection equation
						(= cut-torque/-force projected to the rotation/translation
						axis must be identical to
						the drive torque/force of flange axis) via parameter <b>axisTorqueBalance</b>.
						This is no longer possible, since otherwise this model would not be
						\"balanced\" (= same number of unknowns as equations). Instead, when
						using this model in version 3.0 and later versions, the torque/force
						projection equation must be provided in the Advanced menu of joints
						Joints.SphericalSpherical and Joints.UniversalSpherical
						via the new parameter \"constraintResidue\".</td> </tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Parts.</b></td></tr>
<tr><td valign=\"top\"> BodyBox<br>
						BodyCylinder</td>
	  <td valign=\"top\"> Changed unit of parameter density from g/cm3 to the SI unit kg/m3
						in order to allow stricter unit checking.<br>The conversion script multiplies
						previous density values with 1000.</td> </tr>
<tr><td valign=\"top\"> Body<br>
						BodyShape<br>
						BodyBox<br>
						BodyCylinder<br>
						PointMass
						Rotor1D</td>
	  <td valign=\"top\"> Changed initialization, by replacing initial value parameters with
						start/fixed attributes.<br>
						When start/fixed attributes are properly supported
						in the parameter menu by a Modelica tool,<br>
						the initialization is considerably simplified for the
						user and the implementation is much simpler.<br>The conversion script automatically
						transforms from the \"old\" to the \"new\" form of initialization.</td> </tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Sensors.</b></td></tr>
<tr><td valign=\"top\"> AbsoluteSensor<br>
						RelativeSensor<br>
						CutForceAndTorque</td>
	  <td valign=\"top\"> New design of sensor components: Via Boolean parameters<br>
						signal connectors for the respective vectors are enabled/disabled.<br>
						It is not possible to automatically convert models to this new design.<br>
						Instead, references in existing models are changed to ObsoleteModelice3.<br>
						This means that these models must be manually adapted.</td> </tr>
<tr><td valign=\"top\"> CutForce<br>
						CutTorque</td>
	  <td valign=\"top\"> Slightly new design. The force and/or torque component can be
						resolved in world, frame_a, or frame_resolved.<br>
						Existing models are automatically converted.</td> </tr>

<tr><td colspan=\"2\"><b>Mechanics.Rotational.</b></td></tr>
<tr><td valign=\"top\"> </td>
	  <td valign=\"top\"> Moved components to structured sub-packages (Sources, Components)</td> </tr>
<tr><td valign=\"top\"> Inertia<br>
						SpringDamper<br>
						RelativeStates</td>
	  <td valign=\"top\"> Changed initialization, by replacing initial value parameters with
						start/fixed attributes.<br>
						When start/fixed attributes are properly supported
						in the parameter menu by a Modelica tool,<br>
						the initialization is considerably simplified for the
						user and the implementation is much simpler.<br>
						Parameter \"stateSelection\" in \"Inertia\" and \"SpringDamper\" replaced
						by the built-in enumeration<br>stateSelect=StateSelection.xxx.
						Introduced the \"stateSelect\" enumeration in \"RelativeStates\".<br>
						The conversion script automatically
						transforms from the \"old\" to the \"new\" forms.</td> </tr>
<tr><td valign=\"top\"> LossyGear<br>
						GearBox</td>
	  <td valign=\"top\"> Renamed gear ratio parameter \"i\" to \"ratio\", in order to have a
						consistent naming convention.<br>
						Existing models are automatically converted. </td> </tr>
<tr><td valign=\"top\"> SpringDamper<br>
						ElastoBacklash<br>
						Clutch<br>
						OneWayClutch</td>
	  <td valign=\"top\"> Relative quantities (phi_rel, w_rel) are used as states, if possible
						(due to StateSelect.prefer). <br>
						In most cases, relative states in drive trains are better suited as
						absolute states. <br> This change might give changes in the selected states
						of existing models.<br>
						This might give rise to problems if, e.g., the initialization was not
						completely defined in a user model,<br> since the default
						initialization heuristic may give different initial values.</td> </tr>

<tr><td colspan=\"2\"><b>Mechanics.Translational.</b></td></tr>
<tr><td valign=\"top\"> </td>
	  <td valign=\"top\"> Moved components to structured sub-packages (Sources, Components)</td> </tr>
<tr><td valign=\"top\"> </td>
	  <td valign=\"top\"> Adaptions corresponding to Rotational</td> </tr>
<tr><td valign=\"top\"> Stop</td>
	  <td valign=\"top\"> Renamed to Components.MassWithStopAndFriction to be more concise.<br>
						MassWithStopAndFriction is not available with a support connector, <br>
						since the reaction force can't be modeled in a meaningful way due to reinit of velocity v.<br>
						Until a sound implementation of a hard stop is available, the old model may be used.</td> </tr>
<tr><td colspan=\"" + "2\"><b>Media.</b></td></tr>
<tr><td valign=\"top\"> constant nX <br>
						constant nXi <br>
						constant reference_X<br>
						BaseProperties</td>
	  <td valign=\"top\"> The package constant nX = nS, now always, even for single species media. This also allows to define mixtures with only 1 element. The package constant nXi=if fixedX then 0 else if reducedX or nS==1 then nS - 1 else nS. This required that all BaseProperties for single species media get an additional equation to define the composition X as {1.0} (or reference_X, which is {1.0} for single species). This will also mean that all user defined single species media need to be updated by that equation.</td> </tr>

<tr><td colspan=\"2\"><b>SIunits.</b></td></tr>
<tr><td valign=\"top\"> CelsiusTemperature </td>
	  <td valign=\"top\"> Removed, since no SI unit. The conversion script changes references to
						SIunits.Conversions.NonSIunits.Temperature_degC </td> </tr>
<tr><td valign=\"top\"> ThermodynamicTemperature <br>
						TemperatureDifference</td>
	  <td valign=\"top\"> Added annotation \"__Dymola_absoluteValue=true/false\"
						in order that unit checking is possible<br>
						(the unit checker needs to know for a unit that has an offset,
						whether it is used as absolute or as a relative number)</td> </tr>

<tr><td colspan=\"2\"><b>SIunits.Conversions.NonSIunits.</b></td></tr>
<tr><td valign=\"top\"> Temperature_degC<br>
						Temperature_degF<br>
						Temperature_degRk </td>
	  <td valign=\"top\"> Added annotation \"__Dymola_absoluteValue=true\"
						in order that unit checking is possible<br>
						(the unit checker needs to know for a unit that has an offset,
						whether it is used as absolute or as a relative number)</td> </tr>

<tr><td colspan=\"2\"><b>StateGraph.Examples.</b></td></tr>
<tr><td valign=\"top\"> ControlledTanks </td>
	  <td valign=\"top\"> The connectors of the ControlledTanks did not fulfill the new
						restrictions of Modelica 3. This has been fixed.</td> </tr>
<tr><td valign=\"top\"> Utilities </td>
	  <td valign=\"top\"> Replacing inflow, outflow by connectors inflow1, inflow2,
						outflow1, outflow2 with appropriate input/output prefixes in
						order to fufill the restrictions of Modelica 3 to arrive
						at balanced models. No conversion is provided, since
						too difficult and since the non-backward compatible change is in
						an example. </td> </tr>

<tr><td colspan=\"2\"><b>Thermal.FluidHeatFlow.Sensors.</b></td></tr>
<tr><td valign=\"top\"> <br>
						pSensor<br>TSensor<br>dpSensor<br>dTSensor<br>m_flowSensor<br>V_flowSensor<br>H_flowSensor</td>
	  <td valign=\"top\"> renamed to:<br>
						PressureSensor<br>TemperatureSensor<br>RelPressureSensor<br>RelTemperatureSensor<br>MassFlowSensor<br>VolumeFlowSensor<br>EnthalpyFlowSensor
						</td> </tr>

<tr><td colspan=\"2\"><b>Thermal.FluidHeatFlow.Sources.</b></td></tr>
<tr><td valign=\"top\"> Ambient<br>PrescribedAmbient</td>
	  <td valign=\"top\"> available as one combined component Ambient<br>
						Boolean parameters usePressureInput and useTemperatureInput decide
						whether pressure and/or temperature are constant or prescribed</td> </tr>
<tr><td valign=\"top\"> ConstantVolumeFlow<br>PrescribedVolumeFlow</td>
	  <td valign=\"top\"> available as one combined component VolumeFlow<br>
						Boolean parameter useVolumeFlowInput decides
						whether volume flow is constant or prescribed</td> </tr>
<tr><td valign=\"top\"> ConstantPressureIncrease<br>PrescribedPressureIncrease</td>
	  <td valign=\"top\"> available as one combined component PressureIncrease<br>
						Boolean parameter usePressureIncreaseInput decides
						whether pressure increase is constant or prescribed</td> </tr>

<tr><td colspan=\"2\"><b>Thermal.FluidHeatFlow.Examples.</b></td></tr>
<tr><td valign=\"top\"> </td>
	  <td valign=\"top\"> Changed the instance names of components used in the examples to more up-to-date style.</td> </tr>

<tr><td colspan=\"2\"><b>Thermal.HeatTransfer.(Components)</b></td></tr>
<tr><td valign=\"top\"> HeatCapacitor</td>
	  <td valign=\"top\"> Initialization changed: SteadyStateStart removed. Instead
						start/fixed values for T and der_T<br>(initial temperature and its derivative).</td> </tr>

<tr><td valign=\"top\"> <br><br>HeatCapacitor<br>ThermalConductor<br>ThermalConvection<br>BodyRadiation<br><br>
						TemperatureSensor<br>RelTemperatureSensor<br>HeatFlowSensor<br><br>
						FixedTemperature<br>PrescribedTemperature<br>FixedHeatFlow<br>PrescribedHeatFlow</td>
	  <td valign=\"top\"> Moved components to sub-packages:<br><br>
						Components.HeatCapacitor<br>Components.ThermalConductor<br>Components.ThermalConvection<br>Components.BodyRadiation<br><br>
						Sensors.TemperatureSensor<br>Sensors.RelTemperatureSensor<br>Sensors.HeatFlowSensor<br><br>
						Sources.FixedTemperature<br>Sources.PrescribedTemperature<br>Sources.FixedHeatFlow<br>Sources.PrescribedHeatFlow
						</tt></td> </tr>

<tr><td colspan=\"2\"><b>Thermal.FluidHeatFlow.Examples.</b></td></tr>
<tr><td valign=\"top\"> </td>
	  <td valign=\"top\"> Changed the instance names of components used in the examples to more up-to-date style.</td> </tr>
</table>



<p><br>
The following <b style=\"color:blue\">existing components</b>
have been <b style=\"color:blue\">improved</b> in a
<b style=\"color:blue\">backward compatible</b> way:
</p>

<table border=\"1\" cellspacing=0 cellpadding=2 style=\"border-collapse:collapse;\">
<tr><td valign=\"top\"> <b>Modelica.*</b> </td>
	  <td valign=\"top\"> Parameter declarations, input and output function arguments without description
						strings improved<br> by providing meaningful description texts.
						</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Blocks.Continuous.</b></td></tr>
<tr><td valign=\"top\"> TransferFunction </td>
	  <td valign=\"top\"> Internal scaling of the controller canonical states introduced
						in order to enlarge the range of transfer functions where the default
						relative tolerance of the simulator is sufficient.</td>
</tr>

<tr><td valign=\"top\"> Butterworth<br>CriticalDamping </td>
	  <td valign=\"top\"> Documentation improved and plots of the filter characteristics added.</td> </tr>

<tr><td colspan=\"2\"><b>Electrical.Analog.Basic.</b></td></tr>
<tr><td valign=\"top\"> EMF </td>
	  <td valign=\"top\"> New parameter \"useSupport\" to optionally enable a support connector.</td> </tr>


<tr><td colspan=\"2\"><b>Icons.</b></td></tr>
<tr><td valign=\"top\"> TranslationalSensor<br>
						RotationalSensor</td>
	  <td valign=\"top\"> Removed drawing from the diagram layer (kept drawing only in
						icon layer),<br> in order that this icon can be used in situations
						where components are dragged in the diagram layer.</td> </tr>

<tr><td colspan=\"2\"><b>Math.Vectors.</b></td></tr>
<tr><td valign=\"top\"> normalize</td>
	  <td valign=\"top\"> Implementation changed, so that the result is awalys continuous<br>
						(previously, this was not the case for small vectors: normalize(eps,eps)).
						</td> </tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.</b></td></tr>
<tr><td valign=\"top\"> </td>
	  <td valign=\"top\"> Renamed non-standard keywords defineBranch, defineRoot, definePotentialRoot,
						isRooted to the standard names:<br>
						Connections.branch/.root/.potentialRoot/.isRooted.</td> </tr>
<tr><td valign=\"top\"> Frames </td>
	  <td valign=\"top\"> Added annotation \"Inline=true\" to all one-line functions
						(which should be all inlined).</td> </tr>
<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Parts.</b></td></tr>
<tr><td valign=\"top\"> Mounting1D<br>
						Rotor1D<br>
						BevelGear1D</td>
	  <td valign=\"top\"> Changed implementation so that no longer modifiers for connector
						variables are used,<br>because this violates the restrictions on
						\"balanced models\" of Modelica 3. </td> </tr>

<tr><td colspan=\"2\"><b>Mechanics.Rotational.</b></td></tr>
<tr><td valign=\"top\"> InitializeFlange</td>
	  <td valign=\"top\"> Changed implementation so that counting unknowns and
						equations is possible without actual values of parameters.</td> </tr>

<tr><td colspan=\"2\"><b>Thermal.FluidHeatFlow.Interfaces.Partials.</b></td></tr>
<tr><td valign=\"top\">TwoPort</td>
	  <td valign=\"top\"> Introduced <tt>parameter Real tapT(final min=0, final max=1)=1</tt> <br> that defines the temperature of the heatPort
						betwen inlet and outlet.</td> </tr>

<tr><td colspan=\"2\"><b>StateGraph.</b></td></tr>
<tr><td valign=\"top\"> InitialStep<br>
						InitialStepWithSignal<br>
						Step<br>
						StepWithSignal</td>
	  <td valign=\"top\"> Changed implementation so that no longer modifiers for output
						variables are used,<br>because this violates the restrictions on
						\"balanced models\" of Modelica 3. </td> </tr>

</table>


<p><br>
The following <b style=\"color:red\">critical errors</b> have been fixed (i.e. errors
that can lead to wrong simulation results):
</p>

<table border=\"1\" cellspacing=0 cellpadding=2 style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><b>Electrical.Analog.Examples.</b></td></tr>
<tr><td valign=\"top\"> CauerLowPassSC </td>
	  <td valign=\"top\"> Wrong calculation of Capacitor1 both in Rn and Rp corrected
						(C=clock/R instead of C=clock*R) </td>
</tr>


<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Parts.</b></td></tr>
<tr><td valign=\"top\"> Rotor1D </td>
	  <td valign=\"top\"> The 3D reaction torque was not completely correct and gave in
						some situations a wrong result. This bug should not influence the
						movement of a multi-body system, but only the constraint torques
						are sometimes not correct. </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.Rotational.</b></td></tr>
<tr><td valign=\"top\"> ElastoBacklash </td>
	  <td valign=\"top\"> If the damping torque was too large, the reaction torque
						could \"pull\" which is unphysical. The component was
						newly written by limiting the damping torque in such a case
						so that \"pulling\" torques can no longer occur. Furthermore,
						during initialization the characteristics is made continuous
						to reduce numerical errors. The relative angle and relative
						angular velocities are used as states, if possible
						(StateSelect.prefer), since relative quantities lead usually
						to better behavior.  </td>
</tr>
<tr><td valign=\"top\"> Position<br>Speed<br>Accelerate<br>Move</td>
	  <td valign=\"top\"> The movement of the flange was wrongly defined as absolute;
						this is corrected as relative to connector support.<br>
						For Accelerate, it was necessary to rename
						RealInput a to a_ref, as well as the start values
						phi_start to phi.start and w_start to w.start.
						The conversion script performs the necessary conversion of
						existing models automatically.</td>
</tr>
<tr><td colspan=\"2\"><b>Media.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> PartialSimpleIdealGasMedium </td>
	  <td valign=\"top\"> Inconsisteny in reference temperature corrected. This may give
						different results for functions:<br>
						specificEnthalpy, specificInternalEnergy, specificGibbsEnergy,
						specificHelmholtzEnergy. </td>
</tr>
<tr><td colspan=\"2\"><b>Media.Air.</b></td></tr>
<tr><td valign=\"top\"> specificEntropy </td>
	  <td valign=\"top\"> Small bug in entropy computation of ideal gas mixtures corrected.</td>
</tr>
<tr><td colspan=\"2\"><b>Media.IdealGases.Common.MixtureGasNasa</b></td></tr>
<tr><td valign=\"top\"> specificEntropy </td>
	  <td valign=\"top\"> Small bug in entropy computation of ideal gas mixtures corrected.</td>
</tr>
</table>


<p><br>
The following <b style=\"color:red\">uncritical errors</b> have been fixed (i.e. errors
that do <b style=\"color:red\">not</b> lead to wrong simulation results, but, e.g.,
units are wrong or errors in documentation):
</p>

<table border=\"1\" cellspacing=0 cellpadding=2 style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><b>Blocks.Tables.</b></td></tr>
<tr><td valign=\"top\"> CombiTable2D</td>
	  <td valign=\"top\"> Documentation improved.</td>
</tr>

<tr><td colspan=\"2\"><b>Electrica.Digital.Gates</b></td></tr>
<tr><td valign=\"top\"> AndGate<br>
						NandGate<br>
						OrGate<br>
						NorGate<br>
						XorGate<br>
						XnorGate</td>
	  <td valign=\"top\"> The number of inputs was not correctly propagated
						to the included base model.<br>
						This gave a translation error, if the number
						of inputs was changed (and not the default used).</td>
</tr>

<tr><td colspan=\"2\"><b>Electrica.Digital.Sources</b></td></tr>
<tr><td valign=\"top\"> Pulse </td>
	  <td valign=\"top\"> Model differently implemented, so that
						warning message about \"cannot properly initialize\" is gone.</td>
</tr>


<tr><td colspan=\"2\"><b>Mechanics.Rotational.</b></td></tr>
<tr><td valign=\"top\"> BearingFriction<br>
						Clutch<br>
						OneWayClutch<br>
						Brake <br>
						Gear </td>
	  <td valign=\"top\"> Declaration of table parameter changed from
						table[:,:] to table[:,2].</td>
</tr>

<tr><td colspan=\"2\"><b>Modelica.Mechanics.MultiBody.Examples.Loops.Utilities.</b></td></tr>
<tr><td valign=\"top\"> GasForce </td>
	  <td valign=\"top\"> Unit of variable \"press\" corrected (from Pa to bar)</td>
</tr>

<tr><td colspan=\"2\"><b>StateGraph.Examples.</b></td></tr>
<tr><td valign=\"top\">SimpleFriction</td>
	  <td valign=\"top\"> The internal parameter k is defined and calculated with the appropriate unit.</td> </tr>


<tr><td colspan=\"2\"><b>Thermal.FluidHeatFlow.Interfaces.Partials.</b></td></tr>
<tr><td valign=\"top\">SimpleFriction</td>
	  <td valign=\"top\"> The internal parameter k is defined and calculated with the appropriate unit.</td> </tr>

</table>

</html>"));
end Version_3_0;

class Version_2_2_2 "Version 2.2.2 (Aug. 31, 2007)"

   annotation (Documentation(info="<html>
<p>
Version 2.2.2 is backward compatible to version 2.2.1 and 2.2 with
the following exceptions:
</p>
<ul>
<li> Removal of package Modelica.Media.Interfaces.PartialTwoPhaseMediumWithCache
	 (this was not yet utilized).</li>
<li> Removal of the media packages in
	 Modelica.Media.IdealGases.SingleGases that are not type compatible
	 to Modelica.Media.Interfaces.PartialMedium, because a FluidConstants
	 record definition is missing,
	 for details, see
	  <a href=\"Modelica://Modelica.Media.IdealGases\">Modelica.Media.IdealGases</a>
	 (this is seen as a bug fix).
</ul>

<p>
An overview of the differences between version 2.2.2 and the previous
version 2.2.1 is given below. The exact differences (but without
differences in the documentation) are available
<a href=\"../help/Documentation/Differences-Modelica-221-222.html\">here</a>.
This comparison file was generated automatically with Dymolas
ModelManagement.compare function.
</p>

<p>
In this version, <b>no</b> new libraries have been added. The <b>documentation</b>
of the whole library was improved. Especially, the documentation is now also
available as
<a href=\"../help/Documentation/ModelicaStandardLibrary.pdf\">one pdf file</a>.
</p>


<p><br>
The following <b style=\"color:blue\">new components</b> have been added
to <b style=\"color:blue\">existing</b> libraries:
</p>

<table border=\"1\" cellspacing=0 cellpadding=2 style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><b>Blocks.Logical.</b></td></tr>
<tr><td valign=\"top\"> TerminateSimulation</td>
	  <td valign=\"top\"> Terminate a simulation by a given condition.</td>
</tr>

<tr><td colspan=\"2\"><b>Blocks.Routing.</b></td></tr>
<tr><td valign=\"top\"> RealPassThrough<br>
		   IntegerPassThrough<br>
		   BooleanPassThrough</td>
	  <td valign=\"top\"> Pass a signal from input to output
		   (useful in combination with a bus due to restrictions
		   of expandable connectors).</td>
</tr>

<tr><td colspan=\"2\"><b>Blocks.Sources.</b></td></tr>
<tr><td valign=\"top\"> KinematicPTP2 </td>
	  <td valign=\"top\"> Directly gives q,qd,qdd as output (and not just qdd as KinematicPTP).
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Machines.Examples.</b></td></tr>
<tr><td valign=\"top\"> TransformerTestbench </td>
	  <td valign=\"top\"> Transformer Testbench
	  </td>
<tr><td valign=\"top\"> Rectifier6pulse </td>
	  <td valign=\"top\"> 6-pulse rectifier with 1 transformer
	  </td>
</tr>
<tr><td valign=\"top\"> Rectifier12pulse </td>
	  <td valign=\"top\"> 12-pulse rectifier with 2 transformers
	  </td>
</tr>
<tr><td valign=\"top\"> AIMC_Steinmetz </td>
	  <td valign=\"top\"> Asynchronous induction machine squirrel cage with Steinmetz connection
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Machines.BasicMachines.Components.</b></td></tr>
<tr><td valign=\"top\"> BasicAIM </td>
	  <td valign=\"top\"> Partial model for asynchronous induction machine
	  </td>
<tr><td valign=\"top\"> BasicSM </td>
	  <td valign=\"top\"> Partial model for synchronous induction machine
	  </td>
<tr><td valign=\"top\"> PartialAirGap </td>
	  <td valign=\"top\"> Partial airgap model
	  </td>
<tr><td valign=\"top\"> BasicDCMachine </td>
	  <td valign=\"top\"> Partial model for DC machine
	  </td>
<tr><td valign=\"top\"> PartialAirGapDC </td>
	  <td valign=\"top\"> Partial airgap model of a DC machine
	  </td>
<tr><td valign=\"top\"> BasicTransformer </td>
	  <td valign=\"top\"> Partial model of threephase transformer
	  </td>
<tr><td valign=\"top\"> PartialCore </td>
	  <td valign=\"top\"> Partial model of transformer core with 3 windings
	  </td>
<tr><td valign=\"top\"> IdealCore </td>
	  <td valign=\"top\"> Ideal transformer with 3 windings
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Machines.BasicMachines.</b></td></tr>
<tr><td valign=\"top\"> Transformers </td>
	  <td valign=\"top\"> Sub-Library for technical 3phase transformers
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Machines.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> Adapter </td>
	  <td valign=\"top\"> Adapter to model housing of electrical machine
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Math.</b></td></tr>
<tr><td valign=\"top\"> Vectors </td>
	  <td valign=\"top\"> New library of functions operating on vectors
	  </td>
</tr>
<tr><td valign=\"top\"> atan3 </td>
	  <td valign=\"top\"> Four quadrant inverse tangens (select solution that is closest to given angle y0)
	  </td>
</tr>
<tr><td valign=\"top\"> asinh </td>
	  <td valign=\"top\"> Inverse of sinh (area hyperbolic sine)
	  </td>
</tr>
<tr><td valign=\"top\"> acosh </td>
	  <td valign=\"top\"> Inverse of cosh (area hyperbolic cosine)
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Math.Vectors</b></td></tr>
<tr><td valign=\"top\"> isEqual </td>
	  <td valign=\"top\"> Determine if two Real vectors are numerically identical
	  </td>
</tr>
<tr><td valign=\"top\"> norm </td>
	  <td valign=\"top\"> Return the p-norm of a vector
	  </td></tr>
<tr><td valign=\"top\"> length </td>
	  <td valign=\"top\"> Return length of a vector (better as norm(), if further symbolic processing is performed)
	  </td></tr>
<tr><td valign=\"top\"> normalize </td>
	  <td valign=\"top\"> Return normalized vector such that length = 1 and prevent zero-division for zero vector
	  </td></tr>
<tr><td valign=\"top\"> reverse </td>
	  <td valign=\"top\"> Reverse vector elements (e.g. v[1] becomes last element)
	  </td></tr>
<tr><td valign=\"top\"> sort </td>
	  <td valign=\"top\"> Sort elements of vector in ascending or descending order
	  </td></tr>

<tr><td colspan=\"2\"><b>Math.Matrices</b></td></tr>
<tr><td valign=\"top\"> solve2 </td>
	  <td valign=\"top\"> Solve real system of linear equations A*X=B with a B matrix
		   (Gaussian elemination with partial pivoting)
	  </td>
</tr>
<tr><td valign=\"top\"> LU_solve2 </td>
	  <td valign=\"top\"> Solve real system of linear equations P*L*U*X=B with a B matrix
		   and an LU decomposition (from LU(..))
	  </td></tr>


<tr><td colspan=\"2\"><b>Mechanics.Rotational.</b></td></tr>
<tr><td valign=\"top\"> InitializeFlange </td>
	  <td valign=\"top\"> Initialize a flange according to given signals
		   (useful if initialization signals are provided by a signal bus).
	  </td>
</tr>


<tr><td colspan=\"2\"><b>Media.Interfaces.PartialMedium.</b></td></tr>
<tr><td valign=\"top\"> density_pTX </td>
	  <td valign=\"top\"> Return density from p, T, and X or Xi
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Interfaces.PartialTwoPhaseMedium.</b></td></tr>
<tr><td valign=\"top\"> BaseProperties </td>
	  <td valign=\"top\"> Base properties (p, d, T, h, u, R, MM, x) of a two phase medium
	  </td>
</tr>
<tr><td valign=\"top\"> molarMass </td>
	  <td valign=\"top\"> Return the molar mass of the medium
	  </td>
</tr>
<tr><td valign=\"top\"> saturationPressure_sat </td>
	  <td valign=\"top\"> Return saturation pressure
	  </td>
</tr>
<tr><td valign=\"top\"> saturationTemperature_sat </td>
	  <td valign=\"top\"> Return saturation temperature
	  </td>
</tr>
<tr><td valign=\"top\"> saturationTemperature_derp_sat </td>
	  <td valign=\"top\"> Return derivative of saturation temperature w.r.t. pressure
	  </td>
</tr>  <tr><td valign=\"top\"> setState_px </td>
	  <td valign=\"top\"> Return thermodynamic state from pressure and vapour quality
	  </td>
</tr>  <tr><td valign=\"top\"> setState_Tx </td>
	  <td valign=\"top\"> Return thermodynamic state from temperature and vapour quality
	  </td>
</tr>  <tr><td valign=\"top\"> vapourQuality </td>
	  <td valign=\"top\"> Return vapour quality
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> PartialLinearFluid </td>
	  <td valign=\"top\"> Generic pure liquid model with constant cp,
		   compressibility and thermal expansion coefficients
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Air.MoistAir.</b></td></tr>
<tr><td valign=\"top\"> massFraction_pTphi </td>
	  <td valign=\"top\"> Return the steam mass fraction from relative humidity and T
	  </td>
</tr>
<tr><td valign=\"top\"> saturationTemperature </td>
	  <td valign=\"top\"> Return saturation temperature from (partial) pressure
		   via numerical inversion of function saturationPressure
	  </td>
</tr>
<tr><td valign=\"top\"> enthalpyOfWater </td>
	  <td valign=\"top\"> Return specific enthalpy of water (solid/liquid) near
		   atmospheric pressure from temperature
	  </td>
</tr>
<tr><td valign=\"top\"> enthalpyOfWater_der </td>
	  <td valign=\"top\"> Return derivative of enthalpyOfWater()\" function
	  </td>
</tr>
<tr><td valign=\"top\"> PsychrometricData </td>
	  <td valign=\"top\"> Model to generate plot data for psychrometric chart
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Media.CompressibleLiquids.</b><br>
	  New sub-library for simple compressible liquid models</td></tr>
<tr><td valign=\"top\"> LinearColdWater </td>
	  <td valign=\"top\"> Cold water model with linear compressibility
	  </td>
<tr><td valign=\"top\"> LinerWater_pT_Ambient </td>
	  <td valign=\"top\"> Liquid, linear compressibility water model at 1.01325 bar
		   and 25 degree Celsius
	  </td>

<tr><td colspan=\"2\"><b>SIunits.</b></td></tr>
<tr><td valign=\"top\"> TemperatureDifference </td>
	  <td valign=\"top\"> Type for temperature difference
	  </td>
</table>


<p><br>
The following <b style=\"color:blue\">existing components</b>
have been <b style=\"color:blue\">improved</b>:
</p>

<table border=\"1\" cellspacing=0 cellpadding=2 style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><b>Blocks.Examples.</b></td></tr>
<tr><td valign=\"top\"> BusUsage</td>
	  <td valign=\"top\"> Example changed from the \"old\" to the \"new\" bus concept with
		   expandable connectors.</td> </tr>

<tr><td colspan=\"2\"><b>Blocks.Discrete.</b></td></tr>
<tr><td valign=\"top\"> ZeroOrderHold</td>
	  <td valign=\"top\"> Sample output ySample moved from \"protected\" to \"public\"
		   section with new attributes (start=0, fixed=true).
	  </td>
</tr>
<tr><td valign=\"top\"> TransferFunction</td>
	  <td valign=\"top\"> Discrete state x with new attributes (each start=0, each fixed=0).
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.</b></td></tr>
<tr><td valign=\"top\"> Analog<br>MultiPhase</td>
	  <td valign=\"top\"> Improved some icons.
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Digital.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> MISO</td>
	  <td valign=\"top\"> Removed \"algorithm\" from this partial block.
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Digital.Delay.</b></td></tr>
<tr><td valign=\"top\"> DelayParams</td>
	  <td valign=\"top\"> Removed \"algorithm\" from this partial block.
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Digital.Delay.</b></td></tr>
<tr><td valign=\"top\"> DelayParams</td>
	  <td valign=\"top\"> Removed \"algorithm\" from this partial block.
	  </td>
</tr>
<tr><td valign=\"top\"> TransportDelay</td>
	  <td valign=\"top\">  If delay time is zero, an infinitely small delay is
			introduced via pre(x) (previously \"x\" was used).
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Digital.Sources.</b></td></tr>
<tr><td valign=\"top\"> Clock<br>Step</td>
	  <td valign=\"top\"> Changed if-conditions from \"xxx < time\" to \"time >= xxx\"
		   (according to the Modelica specification, in the second case
		   a time event should be triggered, i.e., this change leads
		   potentially to a faster simulation).
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Digital.Converters.</b></td></tr>
<tr><td valign=\"top\"> BooleanToLogic<br>
		   LogicToBoolean<br>
		   RealToLogic<br>
		   LogicToReal</td>
	  <td valign=\"top\"> Changed from \"algorithm\" to \"equation\" section
		   to allow better symbolic preprocessing
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.</b></td></tr>
<tr><td valign=\"top\"> Machines</td>
	  <td valign=\"top\"> Slightly improved documentation, typos in
		   documentation corrected
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Machines.Examples.</b></td></tr>
<tr><td valign=\"top\"> AIMS_start</td>
	  <td valign=\"top\"> Changed QuadraticLoadTorque1(TorqueDirection=true) to
		   QuadraticLoadTorque1(TorqueDirection=false) since more realistic
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Machines.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> PartialBasicMachine</td>
	  <td valign=\"top\"> Introduced support flange to model the
		   reaction torque to the housing
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Machines.Sensors.</b></td></tr>
<tr><td valign=\"top\"> Rotorangle</td>
	  <td valign=\"top\"> Introduced support flange to model the
		   reaction torque to the housing
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Examples.Elementary.</b></td></tr>
<tr><td valign=\"top\"> PointMassesWithGravity</td>
	  <td valign=\"top\"> Added two point masses connected by a line force to demonstrate
		   additionally how this works. Connections of point masses
		   with 3D-elements are demonstrated in the new example
		   PointMassesWithGravity (there is the difficulty that the orientation
		   is not defined in a PointMass object and therefore some
		   special handling is needed in case of a connection with
		   3D-elements, where the orientation of the point mass is not
		   determined by these elements.</td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Examples.Systems.</b></td></tr>
<tr><td valign=\"top\"> RobotR3</td>
	  <td valign=\"top\"> Changed from the \"old\" to the \"new\" bus concept with expandable connectors.
		   Replaced the non-standard Modelica function \"constrain()\" by
		   standard Modelica components. As a result, the non-standard function
		   constrain() is no longer used in the Modelica Standard Library.</td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Frames.Orientation.</b></td></tr>
<tr><td valign=\"top\"> equalityConstraint</td>
	  <td valign=\"top\"> Use a better residual for the equalityConstraint function.
		   As a result, the non-linear equation system of a kinematic
		   loop is formulated in a better way (the range where the
		   desired result is a unique solution of the non-linear
		   system of equations becomes much larger).</td>
</tr>


<tr><td colspan=\"2\"><b>Mechanics.MultiBody.</b></td></tr>
<tr><td valign=\"top\"> Visualizers.</td>
	  <td valign=\"top\"> Removed (misleading) annotation \"structurallyIncomplete\"
		   in the models of this sub-library
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.Rotational.</b></td></tr>
<tr><td valign=\"top\"> Examples</td>
	  <td valign=\"top\"> For all models in this sub-library:
		   <ul>
		   <li> Included a housing object in all examples to compute
				all support torques.</li>
		   <li> Replaced initialization by modifiers via the
				initialization menu parameters of Inertia components.</li>
		   <li> Removed \"encapsulated\" and unnecessary \"import\". </li>
		   <li> Included \"StopTime\" in the annotations.</li>
		   </ul>
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.Rotational.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> FrictionBase</td>
	  <td valign=\"top\"> Introduced \"fixed=true\" for Boolean variables startForward,
		   startBackward, mode.
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.Translational.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> FrictionBase</td>
	  <td valign=\"top\"> Introduced \"fixed=true\" for Boolean variables startForward,
		   startBackward, mode.
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Media.UsersGuide.MediumUsage.</b></td></tr>
<tr><td valign=\"top\"> TwoPhase</td>
	  <td valign=\"top\"> Improved documentation and demonstrating the newly introduced functions
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Examples.</b></td></tr>
<tr><td valign=\"top\"> WaterIF97</td>
	  <td valign=\"top\"> Provided (missing) units for variables V, dV, H_flow_ext, m, U.
	  </td>
</tr>

<tr><td colspan=\"2\"><b> Media.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> PartialMedium</td>
	  <td valign=\"top\"> Final modifiers are removed from nX and nXi, to allow
		   customized medium models such as mixtures of refrigerants with oil, etc.
	  </td>
</tr>
<tr><td valign=\"top\"> PartialCondensingGases</td>
	  <td valign=\"top\"> Included attributes \"min=1, max=2\" for input argument FixedPhase
		   for functions setDewState and setBubbleState (in order to guarantee
		   that input arguments are correct).
	  </td>
</tr>

<tr><td colspan=\"2\"><b> Media.Interfaces.PartialMedium.</b></td></tr>
<tr><td valign=\"top\"> BaseProperties</td>
	  <td valign=\"top\"> New Boolean parameter \"standardOrderComponents\".
		   If true, last element vector X is computed from 1-sum(Xi) (= default)
		   otherwise, no equation is provided for it in PartialMedium.
	  </td>
</tr>
<tr><td valign=\"top\"> IsentropicExponent</td>
	  <td valign=\"top\"> \"max\" value changed from 1.7 to 500000
	  </td>
</tr>
<tr><td valign=\"top\"> setState_pTX<br>
		   setState_phX<br>
		   setState_psX<br>
		   setState_dTX<br>
		   specificEnthalpy_pTX<br>
		   temperature_phX<br>
		   density_phX<br>
		   temperature_psX<br>
		   density_psX<br>
		   specificEnthalpy_psX</td>
	  <td valign=\"top\"> Introduced defaut value \"reference_X\" for input argument \"X\".
	  </td>
</tr>

<tr><td colspan=\"2\"><b> Media.Interfaces.PartialSimpleMedium.</b></td></tr>
<tr><td valign=\"top\"> setState_pTX<br>
		   setState_phX<br>
		   setState_psX<br>
		   setState_dTX</td>
	  <td valign=\"top\"> Introduced defaut value \"reference_X\" for input argument \"X\".
	  </td>
</tr>

<tr><td colspan=\"2\"><b> Media.Interfaces.PartialSimpleIdealGasMedium.</b></td></tr>
<tr><td valign=\"top\"> setState_pTX<br>
		   setState_phX<br>
		   setState_psX<br>
		   setState_dTX</td>
	  <td valign=\"top\"> Introduced defaut value \"reference_X\" for input argument \"X\".
	  </td>
</tr>

<tr><td colspan=\"2\"><b> Media.Air.MoistAir.</b></td></tr>
<tr><td valign=\"top\"> setState_pTX<br>
		   setState_phX<br>
		   setState_dTX</td>
	  <td valign=\"top\"> Introduced defaut value \"reference_X\" for input argument \"X\".
	  </td>
</tr>

<tr><td colspan=\"2\"><b> Media.IdealGases.Common.SingleGasNasa.</b></td></tr>
<tr><td valign=\"top\"> setState_pTX<br>
		   setState_phX<br>
		   setState_psX<br>
		   setState_dTX</td>
	  <td valign=\"top\"> Introduced defaut value \"reference_X\" for input argument \"X\".
	  </td>
</tr>

<tr><td colspan=\"2\"><b> Media.IdealGases.Common.MixtureGasNasa.</b></td></tr>
<tr><td valign=\"top\"> setState_pTX<br>
		   setState_phX<br>
		   setState_psX<br>
		   setState_dTX<br>
		   h_TX</td>
	  <td valign=\"top\"> Introduced defaut value \"reference_X\" for input argument \"X\".
	  </td>
</tr>

<tr><td colspan=\"2\"><b> Media.Common.</b></td></tr>
<tr><td valign=\"top\"> IF97PhaseBoundaryProperties<br>
		   gibbsToBridgmansTables </td>
	  <td valign=\"top\"> Introduced unit for variables vt, vp.
	  </td>
</tr>
<tr><td valign=\"top\"> SaturationProperties</td>
	  <td valign=\"top\"> Introduced unit for variable dpT.
	  </td>
</tr>
<tr><td valign=\"top\"> BridgmansTables</td>
	  <td valign=\"top\"> Introduced unit for dfs, dgs.
	  </td>
</tr>

<tr><td colspan=\"2\"><b> Media.Common.ThermoFluidSpecial.</b></td></tr>
<tr><td valign=\"top\"> gibbsToProps_ph<br>
		   gibbsToProps_ph  <br>
		   gibbsToBoundaryProps<br>
		   gibbsToProps_dT<br>
		   gibbsToProps_pT</td>
	  <td valign=\"top\"> Introduced unit for variables vt, vp.
	  </td>
<tr><td valign=\"top\"> TwoPhaseToProps_ph</td>
	  <td valign=\"top\"> Introduced unit for variables dht, dhd, detph.
	  </td>
</tr>

<tr><td colspan=\"2\"><b> Media.</b></td></tr>
<tr><td valign=\"top\"> MoistAir</td>
	  <td valign=\"top\"> Documentation of moist air model significantly improved.
	  </td>
</tr>

<tr><td colspan=\"2\"><b> Media.MoistAir.</b></td></tr>
<tr><td valign=\"top\"> enthalpyOfVaporization</td>
	  <td valign=\"top\"> Replaced by linear correlation since simpler and more
		   accurate in the entire region.
	  </td>
</tr>

<tr><td colspan=\"2\"><b> Media.Water.IF97_Utilities.BaseIF97.Regions.</b></td></tr>
<tr><td valign=\"top\"> drhovl_dp</td>
	  <td valign=\"top\"> Introduced unit for variable dd_dp.
	  </td>
</tr>

<tr><td colspan=\"2\"><b> Thermal.</b></td></tr>
<tr><td valign=\"top\"> FluidHeatFlow</td>
	  <td valign=\"top\"> Introduced new parameter tapT (0..1) to define the
		   temperature of the HeatPort as linear combination of the
		   flowPort_a (tapT=0) and flowPort_b (tapT=1) temperatures.
	  </td>
</tr>
</table>



<p><br>
The following <b style=\"color:red\">critical errors</b> have been fixed (i.e. errors
that can lead to wrong simulation results):
</p>

<table border=\"1\" cellspacing=0 cellpadding=2 style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><b>Electrical.Machines.BasicMachines.Components.</b></td></tr>
<tr><td valign=\"top\"> ElectricalExcitation</td>
	  <td valign=\"top\"> Excitation voltage ve is calculated as
		   \"spacePhasor_r.v_[1]*TurnsRatio*3/2\" instead of
		   \"spacePhasor_r.v_[1]*TurnsRatio
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Parts.</b></td></tr>
<tr><td valign=\"top\"> FixedRotation</td>
	  <td valign=\"top\"> Bug corrected that the torque balance was wrong in the
		   following cases (since vector r was not transformed
		   from frame_a to frame_b; note this special case occurs very seldomly in practice):
		   <ul><li> frame_b is in the spanning tree closer to the root
					(usually this is frame_a).</li>
			   <li> vector r from frame_a to frame_b is not zero.</li>
		   </ul>
	   </td>
</tr>

<tr><td valign=\"top\"> PointMass</td>
	 <td valign=\"top\"> If a PointMass model is connected so that no equations are present
		  to compute its orientation object, the orientation was arbitrarily
		  set to a unit rotation. In some cases this can lead to a wrong overall
		  model, depending on how the PointMass model is used. For this reason,
		  such cases lead now to an error (via an assert(..)) with an explanation
		  how to fix this.
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Interfaces.PartialPureSubstance.</b></td></tr>
<tr><td valign=\"top\"> pressure_dT<br>
		   specificEnthalpy_dT
	  </td>
	  <td valign=\"top\"> Changed wrong call from \"setState_pTX\" to \"setState_dTX\"
	   </td>
</tr>


<tr><td colspan=\"2\"><b>Media.Interfaces.PartialTwoPhaseMedium.</b></td></tr>
<tr><td valign=\"top\"> pressure_dT<br>
		   specificEnthalpy_dT
	  </td>
	  <td valign=\"top\"> Changed wrong call from \"setState_pTX\" to \"setState_dTX\"
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Common.ThermoFluidSpecial.</b></td></tr>
<tr><td valign=\"top\"> gibbsToProps_dT<br>
		   helmholtzToProps_ph<br>
		   helmholtzToProps_pT<br>
		   helmholtzToProps_dT</td>
	  <td valign=\"top\"> Bugs in equations corrected </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Common.</b></td></tr>
<tr><td valign=\"top\"> helmholtzToBridgmansTables<br>
		   helmholtzToExtraDerivs</td>
	  <td valign=\"top\"> Bugs in equations corrected </td>
</tr>

<tr><td colspan=\"2\"><b>Media.IdealGases.Common.SingleGasNasa.</b></td></tr>
<tr><td valign=\"top\"> density_derp_T</td>
	  <td valign=\"top\"> Bug in equation of partial derivative corrected </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Water.IF97_Utilities.</b></td></tr>
<tr><td valign=\"top\"> BaseIF97.Inverses.dtofps3<br>
		   isentropicExponent_props_ph<br>
		   isentropicExponent_props_pT<br>
		   isentropicExponent_props_dT</td>
	  <td valign=\"top\"> Bugs in equations corrected </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Air.MoistAir.</b></td></tr>
<tr><td valign=\"top\"> h_pTX</td>
	  <td valign=\"top\"> Bug in setState_phX due to wrong vector size in h_pTX corrected.
		   Furthermore, syntactical errors corrected:
		   <ul><li> In function massFractionpTphi an equation
					sign is used in an algorithm.</li>
			   <li> Two consecutive semicolons removed</li>
		   </ul>
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Water.</b></td></tr>
<tr><td valign=\"top\"> waterConstants</td>
	  <td valign=\"top\"> Bug in equation of criticalMolarVolume corrected.
	  </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Water.IF97_Utilities.BaseIF97.Regions.</b></td></tr>
<tr><td valign=\"top\"> region_ph<br>
		   region_ps</td>
	  <td valign=\"top\"> Bug in region determination corrected.
	  </td>
</tr>

<tr><td valign=\"top\"> boilingcurve_p<br>
		   dewcurve_p</td>
	  <td valign=\"top\"> Bug in equation of plim corrected.
	  </td>
</tr>
</table>


<p><br>
The following <b style=\"color:red\">uncritical errors</b> have been fixed (i.e. errors
that do <b style=\"color:red\">not</b> lead to wrong simulation results, but, e.g.,
units are wrong or errors in documentation):
</p>

<table border=\"1\" cellspacing=0 cellpadding=2 style=\"border-collapse:collapse;\">
<tr><td colspan=\"2\"><b>Blocks.</b></td></tr>
<tr><td valign=\"top\"> Examples</td>
	  <td valign=\"top\"> Corrected typos in description texts of bus example models.
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Blocks.Continuous.</b></td></tr>
<tr><td valign=\"top\"> LimIntegrator</td>
	  <td valign=\"top\"> removed incorrect smooth(0,..) because expression might be discontinuous.
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Blocks.Math.UnitConversions.</b></td></tr>
<tr><td valign=\"top\"> block_To_kWh<br>block_From_kWh</td>
	  <td valign=\"top\"> Corrected unit from \"kWh\" to (syntactically correct) \"kW.h\".
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Analog.Examples.</b></td></tr>
<tr><td valign=\"top\"> HeatingNPN_OrGate</td>
	  <td valign=\"top\"> Included start values, so that initialization is
						successful </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Analog.Lines.</b></td></tr>
<tr><td valign=\"top\"> OLine</td>
	  <td valign=\"top\"> Corrected unit from \"Siemens/m\" to \"S/m\".
	   </td>
<tr><td valign=\"top\"> TLine2</td>
	  <td valign=\"top\"> Changed wrong type of parameter NL (normalized length) from
		   SIunits.Length to Real.
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Digital.Delay.</b></td></tr>
<tr><td valign=\"top\"> TransportDelay</td>
	  <td valign=\"top\"> Syntax error corrected
		   (\":=\" in equation section is converted by Dymola silently to \"=\").
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.Digital</b></td></tr>
<tr><td valign=\"top\"> Converters</td>
	  <td valign=\"top\"> Syntax error corrected
		   (\":=\" in equation section is converted by Dymola silently to \"=\").
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.MultiPhase.Basic.</b></td></tr>
<tr><td valign=\"top\"> Conductor</td>
	  <td valign=\"top\"> Changed wrong type of parameter G from SIunits.Resistance to
		   SIunits.Conductance.
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.MultiPhase.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> Plug<br></td>
	  <td valign=\"top\"> Made used \"pin\" connectors non-graphical (otherwise,
		   there are difficulties to connect to Plug).
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Electrical.MultiPhase.Sources.</b></td></tr>
<tr><td valign=\"top\"> SineCurrent</td>
	  <td valign=\"top\"> Changed wrong type of parameter offset from SIunits.Voltage to
		   SIunits.Current.
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Examples.Loops.</b></td></tr>
<tr><td valign=\"top\"> EngineV6</td>
	  <td valign=\"top\"> Corrected wrong crankAngleOffset of some cylinders
		   and improved the example.
	   </td>
</tr>


<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Examples.Loops.Utilities.</b></td></tr>
<tr><td valign=\"top\"> GasForce</td>
	  <td valign=\"top\"> Wrong units corrected:
		   \"SIunitsPosition x,y\" to \"Real x,y\";
" + "           \"SIunits.Pressure press\" to \"SIunits.Conversions.NonSIunits.Pressure_bar\"
	   </td>
</tr>
<tr><td valign=\"top\"> GasForce2</td>
	  <td valign=\"top\"> Wrong unit corrected: \"SIunits.Position x\" to \"Real x\".
	   </td>
</tr>
<tr><td valign=\"top\"> EngineV6_analytic</td>
	  <td valign=\"top\"> Corrected wrong crankAngleOffset of some cylinders.
	   </td>
</tr>


<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> PartialLineForce</td>
	  <td valign=\"top\"> Corrected wrong unit: \"SIunits.Position eRod_a\" to \"Real eRod_a\";
	   </td>
</tr>
<tr><td valign=\"top\"> FlangeWithBearingAdaptor </td>
	  <td valign=\"top\"> If includeBearingConnector = false, connector \"fr\"
			   + \"ame\" was not
		   removed. As long as the connecting element to \"frame\" determines
		   the non-flow variables, this is fine. In the corrected version, \"frame\"
		   is conditionally removed in this case.</td>
</tr>


<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Forces.</b></td></tr>
<tr><td valign=\"top\"> ForceAndTorque</td>
	  <td valign=\"top\"> Corrected wrong unit: \"SIunits.Force t_b_0\" to \"SIunits.Torque t_b_0\".
	   </td>
</tr>
<tr><td valign=\"top\"> LineForceWithTwoMasses</td>
	  <td valign=\"top\"> Corrected wrong unit: \"SIunits.Position e_rel_0\" to \"Real e_rel_0\".
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Frames.</b></td></tr>
<tr><td valign=\"top\"> axisRotation</td>
	  <td valign=\"top\"> Corrected wrong unit: \"SIunits.Angle der_angle\" to
			\"SIunits.AngularVelocity der_angle\".
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Joints.Assemblies.</b></td></tr>
<tr><td valign=\"top\"> JointUSP<br>JointSSP</td>
	  <td valign=\"top\"> Corrected wrong unit: \"SIunits.Position aux\"  to \"Real\"
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Sensors.</b></td></tr>
<tr><td valign=\"top\"> AbsoluteSensor</td>
	  <td valign=\"top\"> Corrected wrong units: \"SIunits.Acceleration angles\" to
		   \"SIunits.Angle angles\" and
		   \"SIunits.Velocity w_abs_0\" to \"SIunits.AngularVelocity w_abs_0\"
	   </td>
</tr>
<tr><td valign=\"top\"> RelativeSensor</td>
	  <td valign=\"top\"> Corrected wrong units: \"SIunits.Acceleration angles\" to
		   \"SIunits.Angle angles\"
	   </td>
</tr>
<tr><td valign=\"top\"> Distance</td>
	  <td valign=\"top\"> Corrected wrong units: \"SIunits.Length L2\" to \"SIunits.Area L2\" and
		   SIunits.Length s_small2\" to \"SIunits.Area s_small2\"
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.MultiBody.Visualizers.Advanced.</b></td></tr>
<tr><td valign=\"top\"> Shape</td>
	  <td valign=\"top\"> Changed \"MultiBody.Types.Color color\" to \"Real color[3]\", since
		   \"Types.Color\" is \"Integer color[3]\" and there have been backward
		   compatibility problems with models using \"color\" before it was changed
		   to \"Types.Color\".
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.Rotational.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> FrictionBase</td>
	  <td valign=\"top\"> Rewrote equations with new variables \"unitAngularAcceleration\" and
		   \"unitTorque\" in order that the equations are correct with respect
		   to units (previously, variable \"s\" can be both a torque and an
		   angular acceleration and this lead to unit incompatibilities)
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.Rotational.</b></td></tr>
<tr><td valign=\"top\"> OneWayClutch<br>LossyGear</td>
	  <td valign=\"top\"> Rewrote equations with new variables \"unitAngularAcceleration\" and
		   \"unitTorque\" in order that the equations are correct with respect
		   to units (previously, variable \"s\" can be both a torque and an
		   angular acceleration and this lead to unit incompatibilities)
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.Translational.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> FrictionBase</td>
	  <td valign=\"top\"> Rewrote equations with new variables \"unitAngularAcceleration\" and
		   \"unitTorque\" in order that the equations are correct with respect
		   to units (previously, variable \"s\" can be both a torque and an
		   angular acceleration and this lead to unit incompatibilities)
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Mechanics.Translational.</b></td></tr>
<tr><td valign=\"top\"> Speed</td>
	  <td valign=\"top\"> Corrected unit of v_ref from SIunits.Position to SIunits.Velocity
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Examples.Tests.Components.</b></td></tr>
<tr><td valign=\"top\"> PartialTestModel<br>PartialTestModel2</td>
	  <td valign=\"top\"> Corrected unit of h_start from \"SIunits.Density\" to \"SIunits.SpecificEnthalpy\"
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Examples.SolveOneNonlinearEquation.</b></td></tr>
<tr><td valign=\"top\"> Inverse_sh_T
		   InverseIncompressible_sh_T<br>
		   Inverse_sh_TX</td>
	  <td valign=\"top\"> Rewrote equations so that dimensional (unit) analysis is correct\"
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Incompressible.Examples.</b></td></tr>
<tr><td valign=\"top\"> TestGlycol</td>
	  <td valign=\"top\"> Rewrote equations so that dimensional (unit) analysis is correct\"
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Interfaces.PartialTwoPhaseMedium.</b></td></tr>
<tr><td valign=\"top\"> dBubbleDensity_dPressure<br>dDewDensity_dPressure</td>
	  <td valign=\"top\"> Changed wrong type of ddldp from \"DerDensityByEnthalpy\"
		   to \"DerDensityByPressure\".
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Common.ThermoFluidSpecial.</b></td></tr>
<tr><td valign=\"top\"> ThermoProperties</td>
	  <td valign=\"top\"> Changed wrong units:
		   \"SIunits.DerEnergyByPressure dupT\" to \"Real dupT\" and
		   \"SIunits.DerEnergyByDensity dudT\" to \"Real dudT\"
	   </td>
</tr>
<tr><td valign=\"top\"> ThermoProperties_ph</td>
	  <td valign=\"top\"> Changed wrong unit from \"SIunits.DerEnergyByPressure duph\" to \"Real duph\"
	   </td>
</tr>
<tr><td valign=\"top\"> ThermoProperties_pT</td>
	  <td valign=\"top\"> Changed wrong unit from \"SIunits.DerEnergyByPressure dupT\" to \"Real dupT\"
	   </td>
</tr>
<tr><td valign=\"top\"> ThermoProperties_dT</td>
	  <td valign=\"top\">  Changed wrong unit from \"SIunits.DerEnergyByDensity dudT\" to \"Real dudT\"
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Media.IdealGases.Common.SingleGasNasa.</b></td></tr>
<tr><td valign=\"top\"> cp_Tlow_der</td>
	  <td valign=\"top\"> Changed wrong unit from \"SIunits.Temperature dT\" to \"Real dT\".
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Water.IF97_Utilities.BaseIF97.Basic.</b></td></tr>
<tr><td valign=\"top\"> p1_hs<br>
		   h2ab_s<br>
		   p2a_hs<br>
		   p2b_hs<br>
		   p2c_hs<br>
		   h3ab_p<br>
		   T3a_ph<br>
		   T3b_ph<br>
		   v3a_ph<br>
		   v3b_ph<br>
		   T3a_ps<br>
		   T3b_ps<br>
		   v3a_ps<br>
		   v3b_ps</td>
	  <td valign=\"top\"> Changed wrong unit of variables h/hstar, s, sstar from
		   \"SIunits.Enthalpy\" to \"SIunits.SpecificEnthalpy\",
		   \"SIunits.SpecificEntropy\", \"SIunits.SpecificEntropy
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Water.IF97_Utilities.BaseIF97.Transport.</b></td></tr>
<tr><td valign=\"top\"> cond_dTp</td>
	  <td valign=\"top\"> Changed wrong unit of TREL, rhoREL, lambdaREL from
		   \"SIunits.Temperature\", \"SIunit.Density\", \"SIunits.ThermalConductivity\"
		   to \"Real\".
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Water.IF97_Utilities.BaseIF97.Inverses.</b></td></tr>
<tr><td valign=\"top\"> tofps5<br>tofpst5</td>
	  <td valign=\"top\"> Changed wrong unit of pros from \"SIunits.SpecificEnthalpy\" to
		   \"SIunits.SpecificEntropy\".
	   </td>
</tr>

<tr><td colspan=\"2\"><b>Media.Water.IF97_Utilities.</b></td></tr>
<tr><td valign=\"top\"> waterBaseProp_ph</td>
	  <td valign=\"top\"> Improved calculation at the limits of the validity.
	   </td>
</tr>

	<tr><td colspan=\"2\"><b>Thermal.</b></td></tr>
<tr><td valign=\"top\"> FluidHeatFlow<br>HeatTransfer</td>
	  <td valign=\"top\"> Corrected wrong unit \"SIunits.Temperature\" of difference temperature
			variables with \"SIunits.TemperatureDifference\".
	   </td>
</tr>

</table>

</html>"));
end Version_2_2_2;

class Version_2_2_1 "Version 2.2.1 (March 24, 2006)"

   annotation (Documentation(info="<html>

<p>
Version 2.2.1 is backward compatible to version 2.2.
</p>

<p>
In this version, <b>no</b> new libraries have been added.
The following major improvements have been made:
</p>

<ul>
<li> The <b>Documentation</b> of the Modelica standard library was
	 considerably improved:<br>
	 In Dymola 6, the new feature was introduced to automatically add tables
	 for class content and component interface definitions (parameters and
	 connectors) to the info layer. For this reason, the corresponding (partial)
	 tables previously present in the Modelica Standard Library have been
	 removed. The new feature of Dymola 6 has the significant advantage that
	 all tables are now guaranteed to be up-to-date.<br>
	 Additionally, the documentation has been improved by adding appropriate
	 description texts to parameters, connector instances, function input
	 and output arguments etc., in order that the automatically generated
	 tables do not have empty entries. Also new User's Guides for sublibraries
	 Rotational and SIunits have been added and the User's Guide on top
	 level (Modelica.UsersGuide) has been improved.<br>&nbsp;</li>

<li> Initialization options have been added to the Modelica.Blocks.<b>Continuous</b>
	 blocks (NoInit, SteadyState, InitialState, InitialOutput). If InitialOutput
	 is selected, the block output is provided as initial condition. The states
	 of the block are then initialized as close as possible to steady state.
	 Furthermore, the Continuous.LimPID block has been significantly
	 improved and much better documented.<br>&nbsp;</li>

<li> The Modelica.<b>Media</b> library has been significantly improved:<br>
	 New functions setState_pTX, setState_phX, setState_psX, setState_dTX
	 have been added to PartialMedium to compute the independent medium variables
	 (= state of medium) from p,T,X, or from p,h,X or from p,s,X or from
	 d,T,X. Then functions are provided for all interesting medium variables
	 to compute them from its medium state. All these functions are
	 implemented in a robust way for all media (with a few exceptions, if the
	 generic function does not make sense for a particular medium).</li>
</ul>

<p>
The following <b>new components</b> have been added to <b>existing</b> libraries:
</p>

<table border=\"1\" cellspacing=0 cellpadding=2>
<tr><td colspan=\"2\"><b>Modelica.Blocks.Examples.</b></td></tr>
<tr><td valign=\"top\"> PID_Controller</td>
	  <td valign=\"top\"> Example to demonstrate the usage of the
		   Blocks.Continuous.LimPID block.</td> </tr>
<tr><td colspan=\"2\"><b>Modelica.Blocks.Math.</b></td></tr>
<tr><td valign=\"top\"> UnitConversions.*</td>
	  <td valign=\"top\"> New package that provides blocks for unit conversions.
		   UnitConversions.ConvertAllBlocks allows to select all
		   available conversions from a menu.</td> </tr>
<tr><td colspan=\"2\"><b>Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.</b></td></tr>
<tr><td valign=\"top\"> SM_ElectricalExcitedDamperCage</td>
	  <td valign=\"top\"> Electrical excited synchronous induction machine with damper cage</td> </tr>
<tr><td colspan=\"2\"><b>Modelica.Electrical.Machines.BasicMachines.Components.</b></td></tr>
<tr><td valign=\"top\"> ElectricalExcitation </td>
	  <td valign=\"top\"> Electrical excitation for electrical excited synchronous
		   induction machines</td> </tr>
<tr><td valign=\"top\"> DamperCage</td>
	  <td valign=\"top\"> Unsymmetrical damper cage for electrical excited synchronous
		   induction machines. At least the user has to specify the dampers
		   resistance and stray inductance in d-axis; if he omits the
		   parameters of the q-axis, the same values as for the d.axis
		   are used, assuming a symmetrical damper.</td> </tr>
<tr><td colspan=\"2\"><b>Modelica.Electrical.Machines.Examples.</b></td></tr>
<tr><td valign=\"top\"> SMEE_Gen </td>
	  <td valign=\"top\"> Test example 7: ElectricalExcitedSynchronousInductionMachine
		   as Generator</td> </tr>
<tr><td valign=\"top\"> Utilities.TerminalBox</td>
	  <td valign=\"top\"> Terminal box for three-phase induction machines to choose
		   either star (wye) ? or delta ? connection</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Math.Matrices.</b></td></tr>
<tr><td valign=\"top\"> equalityLeastSquares</td>
	  <td valign=\"top\"> Solve a linear equality constrained least squares problem:<br>
		  min|A*x-a|^2 subject to B*x=b</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Mechanics.MultiBody.</b></td></tr>
<tr><td valign=\"top\"> Parts.PointMass</td>
	  <td valign=\"top\"> Point mass, i.e., body where inertia tensor is neglected.</td> </tr>
<tr><td valign=\"top\"> Interfaces.FlangeWithBearing</td>
	  <td valign=\"top\"> Connector consisting of 1-dim. rotational flange and its
		   3-dim. bearing frame.</td> </tr>
<tr><td valign=\"top\"> Interfaces.FlangeWithBearingAdaptor</td>
	  <td valign=\"top\"> Adaptor to allow direct connections to the sub-connectors
		   of FlangeWithBearing.</td> </tr>
<tr><td valign=\"top\"> Types.SpecularCoefficient</td>
	  <td valign=\"top\"> New type to define a specular coefficient.</td> </tr>
<tr><td valign=\"top\"> Types.ShapeExtra</td>
	  <td valign=\"top\"> New type to define the extra data for visual shape objects and to
		   have a central place for the documentation of this data.</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Mechanics.MultiBody.Examples.Elementary</b></td></tr>
<tr><td valign=\"top\"> PointGravityWithPointMasses</td>
	  <td valign=\"top\"> Example of two point masses in a central gravity field.</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Mechanics.Rotational.</b></td></tr>
<tr><td valign=\"top\">UsersGuide</td>
	  <td valign=\"top\"> A User's Guide has been added by using the documentation previously
		   present in the package documentation of Rotational.</td> </tr>
<tr><td valign=\"top\">Sensors.PowerSensor</td>
	  <td valign=\"top\"> New component to measure the energy flow between two connectors
		   of the Rotational library.</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Mechanics.Translational.</b></td></tr>
<tr><td valign=\"top\">Speed</td>
	  <td valign=\"top\"> New component to move a translational flange
		   according to a reference speed</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Media.Interfaces.PartialMedium.</b></td></tr>
<tr><td valign=\"top\">specificEnthalpy_pTX</td>
	  <td valign=\"top\"> New function to compute specific enthalpy from pressure, temperature
		   and mass fractions.</td> </tr>
<tr><td valign=\"top\">temperature_phX</td>
	  <td valign=\"top\"> New function to compute temperature from pressure, specific enthalpy,
		   and mass fractions.</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Icons.</b></td></tr>
<tr><td valign=\"top\"> SignalBus</td>
	  <td valign=\"top\"> Icon for signal bus</td> </tr>
<tr><td valign=\"top\"> SignalSubBus</td>
	  <td valign=\"top\"> Icon for signal sub-bus</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.SIunits.</b></td></tr>
<tr><td valign=\"top\">UsersGuide</td>
	  <td valign=\"top\"> A User's Guide has been added that describes unit handling.</td> </tr>
<tr><td valign=\"top\"> Resistance<br>
		   Conductance</td>
	  <td valign=\"top\"> Attribute 'min=0' removed from these types.</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Thermal.FluidHeatFlow.</b></td></tr>
<tr><td valign=\"top\"> Components.Valve</td>
	  <td valign=\"top\"> Simple controlled valve with either linear or
		   exponential characteristic.</td> </tr>
<tr><td valign=\"top\"> Sources. IdealPump </td>
	  <td valign=\"top\"> Simple ideal pump (resp. fan)  dependent on the shaft?s speed;
		   pressure increase versus volume flow is defined as a linear
		   function. Torque * Speed = Pressure invrease * Volume flow
		   (without losses).</td> </tr>
<tr><td valign=\"top\"> Examples.PumpAndValve </td>
	  <td valign=\"top\"> Test example for valves.</td> </tr>
<tr><td valign=\"top\"> Examples.PumpDropOut </td>
	  <td valign=\"top\"> Drop out of 1 pump to test behavior of semiLinear.</td> </tr>
<tr><td valign=\"top\"> Examples.ParallelPumpDropOut </td>
	  <td valign=\"top\"> Drop out of 2 parallel pumps to test behavior of semiLinear.</td> </tr>
<tr><td valign=\"top\"> Examples.OneMass </td>
	  <td valign=\"top\"> Cooling of 1 hot mass to test behavior of semiLinear.</td> </tr>
<tr><td valign=\"top\"> Examples.TwoMass </td>
	  <td valign=\"top\"> Cooling of 2 hot masses to test behavior of semiLinear.</td> </tr>
</table>

<p>
The following <b>components</b> have been improved:
</p>

<table border=\"1\" cellspacing=0 cellpadding=2>
<tr><td colspan=\"2\"><b>Modelica.</b></td></tr>
<tr><td valign=\"top\"> UsersGuide</td>
	  <td valign=\"top\"> User's Guide and package description of Modelica Standard Library improved.</td> </tr>
<tr><td colspan=\"2\"><b>Modelica.Blocks.Interfaces.</b></td></tr>
<tr><td valign=\"top\"> RealInput<br>
		   BooleanInput<br>
		   IntegerInput</td>
	  <td valign=\"top\"> When dragging one of these connectors the width and height
		   is a factor of 2 larger as a standard icon. Previously,
		   these connectors have been dragged and then manually enlarged
		   by a factor of 2 in the Modelica standard library.</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Blocks.</b></td></tr>
<tr><td valign=\"top\"> Continuous.*</td>
	  <td valign=\"top\"> Initialization options added to all blocks
		   (NoInit, SteadyState, InitialState, InitialOutput).
		   New parameter limitsAtInit to switch off the limits
		   of LimIntegrator or LimPID during initialization</td> </tr>
<tr><td valign=\"top\"> Continuous.LimPID</td>
	  <td valign=\"top\"> Option to select P, PI, PD, PID controller.
		   Documentation significantly improved.</td> </tr>
<tr><td valign=\"top\"> Nonlinear.Limiter<br>
		   Nonlinear.VariableLimiter<br>
		   Nonlinear.Deadzone</td>
	  <td valign=\"top\"> New parameter limitsAtInit/deadZoneAtInit to switch off the limits
		   or the dead zone during initialization</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Electrical.Analog. </b></td></tr>
<tr><td valign=\"top\"> Sources</td>
	  <td valign=\"top\"> Icon improved (+/- added to voltage sources, arrow added to
		   current sources).</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Electrical.Analog.Semiconductors. </b></td></tr>
<tr><td valign=\"top\"> Diode</td>
	  <td valign=\"top\"> smooth() operator included to improve numerics.</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines. </b></td></tr>
<tr><td valign=\"top\"> SM_PermanentMagnetDamperCage<br>
		   SM_ElectricalExcitedDamperCage<br>
		   SM_ReluctanceRotorDamperCage</td>
	  <td valign=\"top\"> The user can choose \"DamperCage = false\" (default: true)
		   to remove all equations for the damper cage from the model.</td> </tr>
<tr><td colspan=\"2\"><b>Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines. </b></td></tr>
<tr><td valign=\"top\"> AIM_SlipRing</td>
	  <td valign=\"top\"> Easier parameterization: if the user selects \"useTrunsRatio = false\"
		   (default: true, this is the same behavior as before),
			parameter TurnsRatio is calculated internally from
			Nominal stator voltage and Locked-rotor voltage.</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Math.Matrices.</b></td></tr>
<tr><td valign=\"top\">leastSquares</td>
	  <td valign=\"top\">The A matrix in the least squares problem might be rank deficient.
		  Previously, it was required that A has full rank.</td>

<tr><td colspan=\"2\"><b>Modelica.Mechanics.MultiBody.</b></td></tr>
<tr><td valign=\"top\">all models</td>
	  <td valign=\"top\"> <ul>
		   <li> All components with animation information have a new variable
				<b>specularCoefficient</b> to define the reflection of ambient light.
				The default value is world.defaultSpecularCoefficient which has
				a default of 0.7. By changing world.defaultSpecularCoefficient, the
				specularCoefficient of all components is changed that are not
				explicitly set differently. Since specularCoefficient is a variable
				(and no parameter), it can be changed during simulation. Since
				annotation(Dialog) is set, this variable still appears in the
				parameter menus.<br>
				Previously, a constant specularCoefficient of 0.7 was used
				for all components.</li>
		   <li> Variable <b>color</b> of all components is no longer a parameter
				but an input variable. Also all parameters in package <b>Visualizers</b>,
				with the exception of <b>shapeType</b> are no longer parameters but
				defined as input variables with annotation(Dialog). As a result,
				all these variables appear still in parameter menus, but they can
				be changed during simulation (e.g., color might be used to
				display the temperature of a part).</li>
		   <li> All menus have been changed to follow the Modelica 2.2 annotations
				\"Dialog, group, tab, enable\" (previously, a non-standard Dymola
				definition for menus was used). Also, the \"enable\" annotation
				is used in all menus
				to disable input fields if the input would be ignored.</li>
		   <li> All visual shapes are now defined with conditional declarations
				(to remove them, if animation is switched off). Previously,
				these (protected) objects have been defined by arrays with
				dimension 0 or 1.</li>
		   </ul></td></tr>

<tr><td valign=\"top\">Frames.resolveRelative</td>
	  <td valign=\"top\"> The derivative of this function added as function and defined via
		   an annotation. In certain situations, tools had previously
		   difficulties to differentiate the inlined function automatically.</td>


<tr><td valign=\"top\">Forces.*</td>
	  <td valign=\"top\"> The scaling factors N_to_m and Nm_to_m have no longer a default
		   value of 1000 but a default value of world.defaultN_to_m (=1000)
		   and world.defaultNm_to_m (=1000). This allows to change the
		   scaling factors for all forces and torques in the world
		   object.</td>
<tr><td valign=\"top\">Interfaces.Frame.a<br>
		  Interfaces.Frame.b<br>
		  Interfaces.Frame_resolve</td>
	  <td valign=\"top\"> The Frame connectors are now centered around the origin to ease
		   the usage. The shape was changed, such that the icon is a factor
		   of 1.6 larger as a standard icon (previously, the icon had a
		   standard size when dragged and then the icon was manually enlarged
		   by a factor of 1.5 in the y-direction in the MultiBody library;
		   the height of 16 allows easy positioning on the standard grid size of 2).
		   The double line width of the border in icon and diagram layer was changed
		   to a single line width and when making a connection the connection
		   line is dark grey and no longer black which looks better.</td>
<tr><td valign=\"top\">Joints.Assemblies.*</td>
	  <td valign=\"top\"> When dragging an assembly joint, the icon is a factor of 2
		   larger as a standard icon. Icon texts and connectors have a
		   standard size in this enlarged icon (and are not a factor of 2
		   larger as previously). </td>
<tr><td valign=\"top\">Types.*</td>
	  <td valign=\"top\"> All types have a corresponding icon now to visualize the content
		   in the package browser (previously, the types did not have an icon).</td>

<tr><td colspan=\"2\"><b>Modelica.Mechanics.Rotational.</b></td></tr>
<tr><td valign=\"top\"> Inertia</td>
	  <td valign=\"top\"> Initialization and state selection added.</td> </tr>
<tr><td valign=\"top\"> SpringDamper</td>
	  <td valign=\"top\"> Initialization and state selection added.</td> </tr>
<tr><td valign=\"top\"> Move</td>
	  <td valign=\"top\"> New implementation based solely on Modelica 2.2 language
		   (previously, the Dymola specific constrain(..) function was used).</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Mechanics.Translational.</b></td></tr>
<tr><td valign=\"top\"> Move</td>
	  <td valign=\"top\"> New implementation based solely on Modelica 2.2 language
		   (previously, the Dymola specific constrain(..) function was used).</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.</b></td></tr>
<tr><td valign=\"top\"> SimpleFriction</td>
	  <td valign=\"top\"> Calculates friction losses from pressure drop and volume flow.</td> </tr>
<tr><td colspan=\"2\"><b>Modelica.Thermal.FluidHeatFlow.Components.</b></td></tr>
<tr><td valign=\"top\"> IsolatedPipe <br>
		   HeatedPipe</td>
	  <td valign=\"top\"> Added geodetic height as a source of pressure change;
		   feeds friction losses as calculated by simple friction to
		   the energy balance of the medium.</td> </tr>
<tr><td colspan=\"2\"><b>Modelica.Media.Interfaces.PartialMedium.FluidConstants.</b></td></tr>
<tr><td valign=\"top\">HCRIT0</td><td valign=\"top\">Critical specifc enthalpy of the fundamental
		  equation (base formulation of the fluid medium model). </td></tr>
<tr><td valign=\"top\">SCRIT0</td><td valign=\"top\">Critical specifc entropy of the fundamental
		  equation (base formulation of the fluid medium model). </td></tr>
<tr><td valign=\"top\">deltah</td><td valign=\"top\">Enthalpy offset (default: 0) between the
		  specific enthalpy of the fluid model and the user-visible
		  specific enthalpy in the model: deltah = h_model - h_fundamentalEquation.
</td></tr>
<tr><td valign=\"top\">deltas</td><td valign=\"top\">Entropy offset (default: 0) between the
		  specific entropy of the fluid model and the user-visible
		  specific entropy in the model: deltas = s_model - s_fundamentalEquation.</td></tr>
<tr><td valign=\"top\">T_default</td><td valign=\"top\">Default value for temperature of medium (for initialization)</td></tr>
<tr><td valign=\"top\">h_default</td><td valign=\"top\">Default value for specific enthalpy of medium (for initialization)</td></tr>
<tr><td valign=\"top\">p_default</td><td valign=\"top\">Default value for pressure of medium (for initialization)</td></tr>
<tr><td valign=\"top\">X_default</td><td valign=\"top\">Default value for mass fractions of medium (for initialization)</td></tr>
</table>
<p>
The following <b>errors</b> have been fixed:
</p>

<table border=\"1\" cellspacing=0 cellpadding=2>
<tr><td colspan=\"2\"><b>Modelica.Blocks.Tables.</b></td></tr>
<tr><td valign=\"top\">CombiTable1D<br>
		  CombiTable1Ds<br>
		  CombiTable2D</td>
	  <td valign=\"top\"> Parameter \"tableOnFile\" determines now whether a table is read from
		   file or used from parameter \"table\". Previously, if \"fileName\" was not
		   \"NoName\", a table was always read from file \"fileName\", independently
		   of the setting of \"tableOnFile\". This has been corrected.<br>
		   Furthermore, the initialization of a table is now performed in a
		   when-clause and no longer in a parameter declaration, because some
		   tools evaluate the parameter declaration in some situation more than
		   once and then the table is unnecessarily read several times
		   (and occupies also more memory).</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Blocks.Sources.</b></td></tr>
<tr><td valign=\"top\">CombiTimeTable</td>
	  <td valign=\"top\"> Same bug fix/improvement as for the tables from Modelica.Blocks.Tables
		   as outlined above.</td> </tr>

<tr><td colspan=\"2\"><b>Modelica.Electrical.Analog.Semiconductors. </b></td></tr>
<tr><td valign=\"top\"> PMOS<br>
		   NMOS<br>
		   HeatingPMOS<br>
		   HeatingNMOS</td>
	  <td valign=\"top\"> The Drain-Source-Resistance RDS had actually a resistance of
		   RDS/v, with v=Beta*(W+dW)/(L+dL). The correct formula is without
		   the divison by \"v\". This has now been corrected.<br>
		   This bug fix should not have an essential effect in most applications.
		   In the default case (Beta=1e-5), the Drain-Source-Resistance was
		   a factor of 1e5 too large and had in the default case the
		   wrong value 1e12, although it should have the value 1e7. The effect
		   was that this resistance had practically no effect.</td> </tr>

<tr><td colspan=\"2\"> <b>Modelica.Media.IdealGases.Common.SingleGasNasa.</b></td></tr>
<tr><td valign=\"top\"> dynamicViscosityLowPressure</td>
	  <td valign=\"top\"> Viscosity and thermal conductivity (which needs viscosity as input)
		   were computed wrong for polar gases and gas mixtures
		   (i.e. if dipole moment not 0.0). This has been fixed in version 2.2.1.</td> </tr>
<tr><td colspan=\"2\"><b>Modelica.Utilities.Streams.</b></td></tr>
<tr><td valign=\"top\">readLine</td>
	  <td valign=\"top\"> Depending on the C-implementation, the stream was not correctly closed.
		   This has been corrected by adding a \"Streams.close(..)\"
		   after reading the file content.</td> </tr>

</table>
</html>
"));
end Version_2_2_1;

class Version_2_2 "Version 2.2 (April 6, 2005)"

   annotation (Documentation(info="<html>

<p>
Version 2.2 is backward compatible to version 2.1.
</p>
The following <b>new libraries</b> have been added:
</p>
<table border=\"1\" cellspacing=0 cellpadding=2>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Media\">Modelica.Media</a></td>
	  <td valign=\"top\"> Property models of liquids and gases, especially
		   <ul>
		   <li>1241 detailed gas models,</li>
		   <li> moist air,</li>
		   <li> high precision water model (according to IAPWS/IF97 standard), </li>
		   <li> incompressible media defined by tables (cp(T), rho(t), eta(T), etc. are defined by tables).</li>
		   </ul>
		   The user can conveniently define mixtures of gases between the
		   1241 gas models. The models are
		   designed to work well in dynamic simulations. They
		   are based on a new standard interface for media with
		   single and multiple substances and one or multiple phases
		   with the following features:
		   <ul>
		   <li> The independent variables of a medium model do not influence the
				definition of a fluid connector port or how the
				balance equations have to be implemented.<br>
				Used independent variables: \"p,T\", \"p,T,X\", \"p,h\", \"d,T\".</li>
		   <li> Optional variables, e.g., dynamic viscosity, are only computed
				if needed.<li>
		   <li> The medium models are implemented with regards to efficient
				dynamic simulation.</li>
		   </ul>
	  </td><tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Thermal.FluidHeatFlow\">Modelica.Thermal.FluidHeatFlow</a></td>
	  <td valign=\"top\"> Simple components for 1-dim., incompressible thermo-fluid flow
		   to model coolant flows, e.g., of electrical machines.
		   Components can be connected arbitrarily together (= ideal mixing
		   at connection points) and fluid may reverse direction of flow.
</td><tr>
</table>
<p>
The following <b>changes</b> have been performed in the
<b>Modelica.Mechanics.MultiBody</b> library:
</p>
<ul>
<li> Component MultiBody.World has a new parameter
	 <b>driveTrainMechanics3D</b>. If set to <b>true</b>, 3D mechanical effects
	 of MultiBody.Parts.Mounting1D/Rotor1D/BevelGear1D are taken into account. If set to
	 <b>false</b> (= default), 3D mechanical effects in these elements
	 are not taken into account and the
	 frame connectors to connect to 3D parts are disabled (all
	 connections to such a disabled connector are also disabled, due to the
	 new feature of conditional declarations in Modelica language 2.2)</li>
<li> All references to \"MultiBody.xxx\" have
	 been changed to \"Modelica.Mechanics.MultiBodys.xxx\" in order that after
	 copying of a component outside of the Modelica library, the references
	 still remain valid.</li>
</ul>
</html>
"));
end Version_2_2;

class Version_2_1 "Version 2.1 (Nov. 11, 2004)"

   annotation (Documentation(info="<html>

<p> This is a major change with respect to previous versions of the
	Modelica Standard Library, because <b>many new libraries</b> and components
	are included and because the input/output blocks (Modelica.Blocks)
	have been considerably simplified:
</p>
<ul>
<li> An input/output connector is defined <b>without</b> a hierarchy (this is possible
	 due to new features of the Modelica language). For example, the input
	 signal of a block \"FirstOrder\" was previously accessed as \"FirstOrder.inPort.signal[1]\".
	 Now it is accessed as \"FirstOrder.u\". This simplifies the understanding and usage
	 especially for beginners.</li>
<li> De-vectorized the <b>Modelica.Blocks</b> library. All blocks in the
	 Modelica.Blocks library are now scalar blocks. As a result,
	 the parameters of the Blocks are scalars and no vectors any
	 more. For example, a parameter \"amplitude\" that might had
	 a value of \"{1}\" previously, has now a value of \"1\". This simplifies
	 the understanding and usage especially for beginners.<br>
	 If a vector of blocks is needed, this can be easily
	 accomplished by adding a dimension to the instance. For example
	 \"Constant const[3](k={1,2,3}\" defines three Constant blocks.
	 An additional advantage of the new approach is that
	 the implementation of Modelica.Blocks is much simpler and is easier to
	 understand.
</li>
</ul>

<p>
The discussed changes of Modelica.Blocks are not backward compatible.
A script to <b>automatically</b> convert models to this new version is
provided. There might be rare cases, where this script does not convert.
In this case models have to be manually converted.
In any case you should make a back-up copy of your model
before automatic conversion is performed.
</p>
<p>
The following <b>new libraries</b> have been added:
</p>
<table border=\"1\" cellspacing=0 cellpadding=2>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Electrical.Digital\">Modelica.Electrical.Digital</a></td>
	  <td valign=\"top\">Digital electrical components based on 2-,3-,4-, and 9-valued logic<br>
		  according to the VHDL standard</td><tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Electrical.Machines\">Modelica.Electrical.Machines</a></td>
	  <td valign=\"top\">Asynchronous, synchronous and DC motor and generator models</td><tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Math.Matrices\">Modelica.Math.Matrices</a></td>
	  <td valign=\"top\">Functions operatinng on matrices such as solve() (A*x=b), leastSquares(),<br>
		  norm(), LU(), QR(),  eigenValues(), singularValues(), exp(), ...</td><tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.StateGraph\">Modelica.StateGraph</a></td>
	  <td valign=\"top\"> Modeling of <b>discrete event</b> and <b>reactive</b> systems in a convenient way using<br>
		   <b>hierarchical state machines</b> and <b>Modelica</b> as <b>action language</b>. <br>
		   It is based on JGraphChart and Grafcet and  has a similar modeling power as <br>
		   StateCharts. It avoids deficiences of usually used action languages. <br>
		   This library makes the ModelicaAdditions.PetriNets library obsolet.</td></tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Utilities.Files\">Modelica.Utilities.Files</a></td>
	  <td valign=\"top\">Functions to operate on files and directories (copy, move, remove files etc.)</td></tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Utilities.Streams\">Modelica.Utilities.Streams</a></td>
	  <td valign=\"top\">Read from files and write to files (print, readLine, readFile, error, ...)</td></tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Utilities.Strings\">Modelica.Utilities.Strings</a></td>
	  <td valign=\"top\">Operations on strings (substring, find, replace, sort, scanToken, ...)</td></tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Utilities.System\">Modelica.Utilities.System</a></td>
	  <td valign=\"top\">Get/set current directory, get/set environment variable, execute shell command, etc.</td></tr>
</table>
<p>
The following existing libraries outside of the Modelica standard library
have been improved and added as <b>new libraries</b>
(models using the previous libraries are automatically converted
to the new sublibraries inside package Modelica):
</p>
<table border=\"1\" cellspacing=0 cellpadding=2>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Blocks.Discrete\">Modelica.Blocks.Discrete</a></td>
	  <td valign=\"top\"> Discrete input/output blocks with fixed sample period<br>
		   (from ModelicaAdditions.Blocks.Discrete)</td></tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Blocks.Logical\">Modelica.Blocks.Logical</a></td>
	  <td valign=\"top\"> Logical components with Boolean input and output signals<br>
		   (from ModelicaAdditions.Blocks.Logical)</td></tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Blocks.Nonlinear\">Modelica.Blocks.Nonlinear</a></td>
	  <td valign=\"top\"> Discontinuous or non-differentiable algebraic control blocks such as variable limiter,<br>
		   fixed, variable and Pade delay etc. (from ModelicaAdditions.Blocks.Nonlinear)</td></tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Blocks.Routing\">Modelica.Blocks.Routing</a></td>
	  <td valign=\"top\"> Blocks to combine and extract signals, such as multiplexer<br>
		   (from ModelicaAdditions.Blocks.Multiplexer)</td></tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Blocks.Tables\">Modelica.Blocks.Tables</a></td>
	  <td valign=\"top\"> One and two-dimensional interpolation in tables. CombiTimeTable is available<br>
		   in Modelica.Blocks.Sources (from ModelicaAdditions.Tables)</td></tr>
<tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody\">Modelica.Mechanics.MultiBody</a></td>
	  <td valign=\"top\"> Components to model the movement of 3-dimensional mechanical systems. Contains <br>
		   body, joint, force and sensor components, analytic handling of kinematic loops,<br>
		   force elements with mass, series/parallel connection of 3D force elements etc.<br>
		   (from MultiBody 1.0 where the new signal connectors are used;<br>
		   makes the ModelicaAdditions.MultiBody library obsolet)</td></tr>
</table>
<p>
As a result, the ModelicaAdditions library is obsolet, because all components
are either included in the Modelica library or are replaced by much more
powerful libraries (MultiBody, StateGraph).
</p>
<p>
The following <b>new components</b> have been added to <b>existing</b> libraries.
</p>
<table border=\"1\" cellspacing=0 cellpadding=2>
<tr><td colspan=\"2\"><b>Modelica.Blocks.Logical.</b></td></tr>
<tr><td valign=\"top\">Pre</td>
	  <td valign=\"top\">y = pre(u): Breaks algebraic loops by an infinitesimal small <br>
		  time delay (event iteration continues until u = pre(u))</td></tr>
<tr><td valign=\"top\">Edge</td>
	  <td valign=\"top\">y = edge(u): Output y is true, if the input u has a rising edge </td></tr>
<tr><td valign=\"top\">FallingEdge</td>
	  <td valign=\"top\">y = edge(not u): Output y is true, if the input u has a falling edge </td></tr>
<tr><td valign=\"top\">Change</td>
	  <td valign=\"top\">y = change(u): Output y is true, if the input u has a rising or falling edge </td></tr>
<tr><td valign=\"top\">GreaterEqual</td>
	  <td valign=\"top\">Output y is true, if input u1 is greater or equal as input u2 </td></tr>
<tr><td valign=\"top\">Less</td>
	  <td valign=\"top\">Output y is true, if input u1 is less as input u2 </td></tr>
<tr><td valign=\"top\">LessEqual</td>
	  <td valign=\"top\">Output y is true, if input u1 is less or equal as input u2 </td></tr>
<tr><td valign=\"top\">Timer</td>
	  <td valign=\"top\">Timer measuring the time from the time instant where the <br>
		  Boolean input became true </td></tr>
<tr><td colspan=\"2\"><b>Modelica.Blocks.Math.</b></td></tr>
<tr><td valign=\"top\">BooleanToReal</td>
	  <td valign=\"top\">Convert Boolean to Real signal</td></tr>
<tr><td valign=\"top\">BooleanToInteger</td>
	  <td valign=\"top\">Convert Boolean to Integer signal</td></tr>
<tr><td valign=\"top\">RealToBoolean</td>
	  <td valign=\"top\">Convert Real to Boolean signal</td></tr>
<tr><td valign=\"top\">IntegerToBoolean</td>
	  <td valign=\"top\">Convert Integer to Boolean signal</td></tr>
<tr><td colspan=\"2\"><b>Modelica.Blocks.Sources.</b></td></tr>
<tr><td valign=\"top\">RealExpression</td>
	  <td valign=\"top\">Set output signal to a time varying Real expression</td></tr>
<tr><td valign=\"top\">IntegerExpression</td>
	  <td valign=\"top\">Set output signal to a time varying Integer expression</td></tr>
<tr><td valign=\"top\">BooleanExpression</td>
	  <td valign=\"top\">Set output signal to a time varying Boolean expression</td></tr>
<tr><td valign=\"top\">BooleanTable</td>
	  <td valign=\"top\">Generate a Boolean output signal based on a vector of time instants</td></tr>
<tr><td colspan=\"2\"><b>Modelica.Mechanics.MultiBody.</b></td></tr>
<tr><td valign=\"top\">Frames.from_T2</td>
	  <td valign=\"top\">Return orientation object R from transformation matrix T and its derivative der(T)</td></tr>
<tr><td colspan=\"2\"><b>Modelica.Mechanics.Rotational.</b></td></tr>
<tr><td valign=\"top\">LinearSpeedDependentTorque</td>
	  <td valign=\"top\">Linear dependency of torque versus speed (acts as load torque)</td></tr>
<tr><td valign=\"top\">QuadraticSpeedDependentTorque</td>
	  <td valign=\"top\">Quadratic dependency of torque versus speed (acts as load torque)</td></tr>
<tr><td valign=\"top\">ConstantTorque</td>
	  <td valign=\"top\">Constant torque, not dependent on speed (acts as load torque)</td></tr>
<tr><td valign=\"top\">ConstantSpeed</td>
	  <td valign=\"top\">Constant speed, not dependent on torque (acts as load torque)</td></tr>
<tr><td valign=\"top\">TorqueStep</td>
	  <td valign=\"top\">Constant torque, not dependent on speed (acts as load torque)</td></tr>
</table>
<p>
The following <b>bugs</b> have been <b>corrected</b>:
</p>
<table border=\"1\" cellspacing=0 cellpadding=2>
<tr><td colspan=\"2\"><b>Modelica.Mechanics.MultiBody.Forces.</b></td></tr>
<tr><td valign=\"top\">LineForceWithMass<br>
		  Spring</td>
	  <td valign=\"top\">If mass of the line force or spring component is not zero, the<br>
		  mass was (implicitly) treated as \"mass*mass\" instead of as \"mass\"</td></tr>
<tr><td colspan=\"2\"><b>Modelica.Mechanics.Rotational.</b></td></tr>
<tr><td valign=\"top\">Speed</td>
	  <td valign=\"top\">If parameter exact=<b>false</b>, the filter was wrong<br>
		  (position was filtered and not the speed input signal)</td></tr>
</table>
<p>
Other changes:
</p>
<ul>
<li> All connectors are now smaller in the diagram layer. This gives
	 a nicer layout when connectors and components are used together
	 in a diagram</li>
<li> Default instance names are defined for all connectors, according
	 to a new annotation introduced in Modelica 2.1. For example,
	 when dragging connector \"Flange_a\" from the Rotational library to
	 the diagram layer, the default connector instance name is
	 \"flange_a\" and not \"Flange_a1\".</li>
<li> The Modelica.Mechanics.Rotational connectors are changed from
	 a square to a circle</li>
<li> The Modelica.Mechanics.Translational connectors are changed from a
	 green to a dark green color in order that connection lines
	 can be better seen, especially when printed.</li>
<li> The Modelica.Blocks connectors for Real signals are changed from
	 blue to dark blue in order to distinguish them from electrical signals.</li>
</ul>
</html>
"));
end Version_2_1;

class Version_1_6 "Version 1.6 (June 21, 2004)"

   annotation (Documentation(info="<html>

<p> Added 1 new library (Electrical.MultiPhase), 17 new components,
	improved 3 existing components
	in the Modelica.Electrical library and improved 3 types
	in the Modelica.SIunits library. Furthermore,
	this User's Guide has been started. The improvements
	in more detail:
</p>
<p>
<b>New components</b>
</p>
<table border=\"1\" cellspacing=0 cellpadding=2>
<tr><td colspan=\"2\"><b>Modelica.Electrical.Analog.Basic.</b></td></tr>
<tr><td valign=\"top\">SaturatingInductor</td>
	  <td valign=\"top\">Simple model of an inductor with saturation</td></tr>
<tr><td valign=\"top\">VariableResistor</td>
	  <td valign=\"top\">Ideal linear electrical resistor with variable resistance</td></tr>
<tr><td valign=\"top\">VariableConductor</td>
	  <td valign=\"top\">Ideal linear electrical conductor with variable conductance</td></tr>
<tr><td valign=\"top\">VariableCapacitor</td>
	  <td valign=\"top\">Ideal linear electrical capacitor with variable capacitance</td></tr>
<tr><td valign=\"top\">VariableInductor</td>
	  <td valign=\"top\">Ideal linear electrical inductor with variable inductance</td></tr>
<tr><td colspan=\"2\"><b>Modelica.Electrical.Analog.Semiconductors.</b></td></tr>
<tr><td valign=\"top\">HeadingDiode</td>
	  <td valign=\"top\">Simple diode with heating port</td></tr>
<tr><td valign=\"top\">HeadingNMOS</td>
	  <td valign=\"top\">Simple MOS Transistor with heating port</td></tr>
<tr><td valign=\"top\">HeadingPMOS</td>
	  <td valign=\"top\">Simple PMOS Transistor with heating port</td></tr>
<tr><td valign=\"top\">HeadingNPN</td>
	  <td valign=\"top\">Simple NPN BJT according to Ebers-Moll with heating port</td></tr>
<tr><td valign=\"top\">HeadingPNP</td>
	  <td valign=\"top\">Simple PNP BJT according to Ebers-Moll with heating port</td></tr>
<tr><td colspan=\"2\"><b>Modelica.Electrical.MultiPhase</b><br>
	  A new library for multi-phase electrical circuits</td></tr>
</table>
<p>
<b>New examples</b>
</p>
<p>
The following new examples have been added to
Modelica.Electrical.Analog.Examples:
</p>
<p>
CharacteristicThyristors,
CharacteristicIdealDiodes,
HeatingNPN_OrGate,
HeatingMOSInverter,
HeatingRectifier,
Rectifier,
ShowSaturatingInductor
ShowVariableResistor
</p>
<p>
<b>Improved existing components</b>
</p>
<p>In the library Modelica.Electrical.Analog.Ideal,
a knee voltage has been introduced for the components
IdealThyristor, IdealGTOThyristor, IdealDiode in order
that the approximation of these ideal elements is improved
with not much computational effort.</p>
<p> In the Modelica.SIunits library, the following changes
	have been made:</p>
<table border=\"1\" cellspacing=0 cellpadding=2>
<tr><td valign=\"top\">Inductance</td>
	  <td valign=\"top\">min=0 removed</td></tr>
<tr><td valign=\"top\">SelfInductance</td>
	  <td valign=\"top\">min=0 added</td></tr>
<tr><td valign=\"top\">ThermodynamicTemperature</td>
	  <td valign=\"top\">min=0 added</td></tr>
</table>
</html>
"));
end Version_1_6;

class Version_1_5 "Version 1.5 (Dec. 16, 2002)"

   annotation (Documentation(info="<html>

<p> Added 55 new components. In particular, added new package
	<b>Thermal.HeatTransfer</b> for modeling of lumped
	heat transfer, added model <b>LossyGear</b> in Mechanics.Rotational
	to model gear efficiency and bearing friction according to a new
	theory in a robust way, added 10 new models in Electrical.Analog and
	added several other new models and improved existing models.
</p>
<p>
<b>New components</b>
</p>
<table border=\"1\" cellspacing=0 cellpadding=2>
<tr><td colspan=\"2\"><b>Modelica.Blocks.</b></td></tr>
<tr><td valign=\"top\">Continuous.Der</td><td valign=\"top\">Derivative of input (= analytic differentations)</td></tr>
<tr><td valign=\"top\"><b><i>Examples</i></b></td><td valign=\"top\">Demonstration examples of the components of this package</td></tr>
<tr><td valign=\"top\">Nonlinear.VariableLimiter</td><td valign=\"top\">Limit the range of a signal with variable limits</td></tr>
<tr><td colspan=\"2\"><b>Modelica.Blocks.Interfaces.</b></td></tr>
<tr><td valign=\"top\">RealPort</td><td valign=\"top\">Real port (both input/output possible)</td></tr>
<tr><td valign=\"top\">IntegerPort</td><td valign=\"top\">Integer port (both input/output possible)</td></tr>
<tr><td valign=\"top\">BooleanPort</td><td valign=\"top\">Boolean port (both input/output possible)</td></tr>
<tr><td valign=\"top\">SIMO</td><td valign=\"top\">Single Input Multiple Output continuous control block</td></tr>
<tr><td valign=\"top\">IntegerBlockIcon</td><td valign=\"top\">Basic graphical layout of Integer block</td></tr>
<tr><td valign=\"top\">IntegerMO</td><td valign=\"top\">Multiple Integer Output continuous control block</td></tr>
<tr><td valign=\"top\">IntegerSignalSource</td><td valign=\"top\">Base class for continuous Integer signal source</td></tr>
<tr><td valign=\"top\">IntegerMIBooleanMOs</td><td valign=\"top\">Multiple Integer Input Multiple Boolean Output continuous control block with same number of inputs and outputs</td></tr>
<tr><td valign=\"top\">BooleanMIMOs</td><td valign=\"top\">Multiple Input Multiple Output continuous control block with same number of inputs and outputs of boolean type</td></tr>
<tr><td valign=\"top\"><b><i>BusAdaptors</i></b></td><td valign=\"top\">Components to send signals to the bus or receive signals from the bus</td></tr>
<tr><td colspan=\"2\"><b>Modelica.Blocks.Math.</b></td></tr>
<tr><td valign=\"top\">RealToInteger</td><td valign=\"top\">Convert real to integer signals</td></tr>
<tr><td valign=\"top\">IntegerToReal</td><td valign=\"top\">Convert integer to real signals</td></tr>
<tr><td valign=\"top\">Max</td><td valign=\"top\">Pass through the largest signal</td></tr>
<tr><td valign=\"top\">Min</td><td valign=\"top\">Pass through the smallest signal</td></tr>
<tr><td valign=\"top\">Edge</td><td valign=\"top\">Indicates rising edge of boolean signal</td></tr>
<tr><td valign=\"top\">BooleanChange</td><td valign=\"top\">Indicates boolean signal changing</td></tr>
<tr><td valign=\"top\">IntegerChange</td><td valign=\"top\">Indicates integer signal changing</td></tr>
<tr><td colspan=\"2\"><b>Modelica.Blocks.Sources.</b></td></tr>
<tr><td valign=\"top\">IntegerConstant</td><td valign=\"top\">Generate constant signals of type Integer</td></tr>
<tr><td valign=\"top\">IntegerStep</td><td valign=\"top\">Generate step signals of type Integer</td></tr>
<tr><td colspan=\"2\"><b>Modelica.Electrical.Analog.Basic.</b></td></tr>
<tr><td valign=\"top\">HeatingResistor</td><td valign=\"top\">Temperature dependent electrical resistor</td></tr>
<tr><td valign=\"top\">OpAmp</td><td valign=\"top\">Simple nonideal model of an OpAmp with limitation</td></tr>
<tr><td colspan=\"2\"><b>Modelica.Electrical.Analog.Ideal.</b></td></tr>
<tr><td valign=\"top\">IdealCommutingSwitch</td><td valign=\"top\">Ideal commuting switch</td></tr>
<tr><td valign=\"top\">IdealIntermediateSwitch</td><td valign=\"top\">Ideal intermediate switch</td></tr>
<tr><td valign=\"top\">ControlledIdealCommutingSwitch</td><td valign=\"top\">Controlled ideal commuting switch</td></tr>
<tr><td valign=\"top\">ControlledIdealIntermediateSwitch</td><td valign=\"top\">Controlled ideal intermediate switch</td></tr>
<tr><td valign=\"top\">IdealOpAmpLimited</td><td valign=\"top\">Ideal operational amplifier with limitation</td></tr>
<tr><td valign=\"top\">IdealOpeningSwitch</td><td valign=\"top\">Ideal opener</td></tr>
<tr><td valign=\"top\">IdealClosingSwitch</td><td valign=\"top\">Ideal closer</td></tr>
<tr><td valign=\"top\">ControlledIdealOpeningSwitch</td><td valign=\"top\">Controlled ideal opener</td></tr>
<tr><td valign=\"top\">ControlledIdealClosingSwitch</td><td valign=\"top\">Controlled ideal closer</td></tr>

<tr><td colspan=\"2\"><b>Modelica.Electrical.Analog.Lines.</b></td></tr>
<tr><td valign=\"top\">TLine1</td><td valign=\"top\">Lossless transmission line (Z0, TD)</td></tr>
<tr><td valign=\"top\">TLine2</td><td valign=\"top\">Lossless transmission line (Z0, F, NL)</td></tr>
<tr><td valign=\"top\">TLine2</td><td valign=\"top\">Lossless transmission line (Z0, F)</td></tr>
<tr><td colspan=\"2\"><b>Modelica.Icons.</b></td></tr>
<tr><td valign=\"top\">Function</td><td valign=\"top\">Icon for a function</td></tr>
<tr><td valign=\"top\">Record</td><td valign=\"top\">Icon for a record</td></tr>
<tr><td valign=\"top\">Enumeration</td><td valign=\"top\">Icon for an enumeration</td></tr>
<tr><td colspan=\"2\"><b>Modelica.Math.</b></td></tr>
<tr><td valign=\"top\">tempInterpol2</td><td valign=\"top\">temporary routine for vectorized linear interpolation (will be removed)</td></tr>
<tr><td colspan=\"2\"><b>Modelica.Mechanics.Rotational.</b></td></tr>
<tr><td valign=\"top\">Examples.LossyGearDemo1</td><td valign=\"top\">Example to show that gear efficiency may lead to stuck motion</td></tr>
<tr><td valign=\"top\">Examples.LossyGearDemo2</td><td valign=\"top\">Example to show combination of LossyGear and BearingFriction</td></tr>
<tr><td valign=\"top\">LossyGear</td><td valign=\"top\">Gear with mesh efficiency and bearing friction (stuck/rolling possible)</td></tr>
<tr><td valign=\"top\">Gear2</td><td valign=\"top\">Realistic model of a gearbox (based on LossyGear)</td></tr>
<tr><td colspan=\"2\"><b>Modelica.SIunits.</b></td></tr>
<tr><td valign=\"top\"><b><i>Conversions</i></b></td><td valign=\"top\">Conversion functions to/from non SI units and type definitions of non SI units</td></tr>
<tr><td valign=\"top\">EnergyFlowRate</td><td valign=\"top\">Same definition as <i>Power</i></td></tr>
<tr><td valign=\"top\">EnthalpyFlowRate</td><td valign=\"top\"><tt>Real (final quantity=\"EnthalpyFlowRate\", final unit=\"W\")</tt></td></tr>
<tr><td colspan=\"2\"><b>Modelica.</b></td></tr>
<tr><td valign=\"top\"><b><i>Thermal.HeatTransfer</i></b></td><td valign=\"top\">1-dimensional heat transfer with lumped elements</td></tr>
<tr><td colspan=\"2\"><b>ModelicaAdditions.Blocks.Discrete.</b></td></tr>
<tr><td valign=\"top\">TriggeredSampler</td><td valign=\"top\">Triggered sampling of continuous signals</td></tr>
<tr><td valign=\"top\">TriggeredMax</td><td valign=\"top\">Compute maximum, absolute value of continuous signal at trigger instants</td></tr>
<tr><td colspan=\"2\"><b>ModelicaAdditions.Blocks.Logical.Interfaces.</b></td></tr>
<tr><td valign=\"top\">BooleanMIRealMOs</td><td valign=\"top\">Multiple Boolean Input Multiple Real Output continuous control block with same number of inputs and outputs</td></tr>
<tr><td valign=\"top\">RealMIBooleanMOs</td><td valign=\"top\">Multiple Real Input Multiple Boolean Output continuous control block with same number of inputs and outputs</td></tr>
<tr><td colspan=\"2\"><b>ModelicaAdditions.Blocks.Logical.</b></td></tr>
<tr><td valign=\"top\">TriggeredTrapezoid</td><td valign=\"top\">Triggered trapezoid generator</td></tr>
<tr><td valign=\"top\">Hysteresis</td><td valign=\"top\">Transform Real to Boolean with Hysteresis</td></tr>
<tr><td valign=\"top\">OnOffController</td><td valign=\"top\">On-off controller</td></tr>
<tr><td valign=\"top\">Compare</td><td valign=\"top\">True, if signal of inPort1 is larger than signal of inPort2</td></tr>
<tr><td valign=\"top\">ZeroCrossing</td><td valign=\"top\">Trigger zero crossing of input signal</td></tr>
<tr><td colspan=\"2\"><b>ModelicaAdditions.</b></td></tr>
<tr><td valign=\"top\">Blocks.Multiplexer.Extractor</td><td valign=\"top\">Extract scalar signal out of signal vector dependent on IntegerRealInput index</td></tr>
<tr><td valign=\"top\">Tables.CombiTable1Ds</td><td valign=\"top\">Table look-up in one dimension (matrix/file) with only single input</td></tr>
</table>
<p>
<b>Package-specific Changes</b>
</p>
<ul>
<li>All example models made <b>encapsulated</b></li>
<li>Upper case constants changed to lower case (cf. Modelica.Constants)</li>
<li>Introduced Modelica.SIunits.Wavelength due to typo \"Wavelenght\"</li>
<li>Introduced ModelicaAdditions.Blocks.Logical.Interfaces.Comparison due to typo \"Comparision\"</li>
<li>Changed these components of *.Blocks to <tt>block</tt> class, which have not been already of block type</li>
<li>Changed *.Interfaces.RelativeSensor to <tt>partial</tt> models</li>
</ul>
<p>
<b>Class-specific Changes</b>
</p>
<p>
<i>Modelica.SIunits</i>
</p>
<p>Removed <tt>final</tt> from quantity attribute for <i>Mass</i> and <i>MassFlowRate</i>.</p>
<p>
<i>Modelica.Blocks.Math.Sum</i>
</p>
<p>Implemented avoiding algorithm section, which would lead to expensive function calls.</p>
<p><i>Modelica.Blocks.Sources.Step</i></p>
<pre>
block Step \"Generate step signals of type Real\"
	parameter Real height[:]={1} \"Heights of steps\";
<b> // parameter Real offset[:]={0} \"Offsets of output signals\";
// parameter SIunits.Time startTime[:]={0} \"Output = offset for time < startTime\";
// extends Interfaces.MO          (final nout=max([size(height, 1); size(offset, 1); size(startTime, 1)]));
	extends Interfaces.SignalSource(final nout=max([size(height, 1); size(offset, 1); size(startTime, 1)]));</b>
</pre>
<p><i>Modelica.Blocks.Sources.Exponentials</i></p>
<p>Replaced usage of built-in function <tt>exp</tt> by Modelica.Math.exp.</p>
<p><i>Modelica.Blocks.Sources.TimeTable</i></p>
<p>Interface definition changed from</p>
<pre>    parameter Real table[:, :]=[0, 0; 1, 1; 2, 4] \"Table matrix (time = first column)\";
</pre>
<p>to</p>
<pre>    parameter Real table[:, <b>2</b>]=[0, 0; 1, 1; 2, 4] \"Table matrix (time = first column)\";
</pre>
<p>Did the same for subfunction <i>getInterpolationCoefficients</i>.</p>
<p>Bug in <i>getInterpolationCoefficients</i> for startTime <> 0 fixed:</p>
<pre>        ...
		end if;
	  end if;
	  <b>// Take into account startTime \"a*(time - startTime) + b\"
	  b := b - a*startTime;</b>
	end getInterpolationCoefficients;
</pre>
<p><i>Modelica.Blocks.Sources.BooleanStep</i></p>
<pre>
block BooleanStep \"Generate step signals of type Boolean\"
	parameter SIunits.Time startTime[:]={0} \"Time instants of steps\";
	<b>parameter Boolean startValue[size(startTime, 1)]=fill(false, size(startTime, 1)) \"Output before startTime\";</b>
	extends Interfaces.BooleanSignalSource(final nout=size(startTime, 1));
equation
	for i in 1:nout loop
<b>//   outPort.signal[i] = time >= startTime[i];
	  outPort.signal[i] = if time >= startTime[i] then not startValue[i] else startValue[i];</b>
	end for;
end BooleanStep;
</pre>
<p>
<i>Modelica.Electrical.Analog</i></p>
<p>Corrected table of values and default for Beta by dividing them by 1000
(consistent with the values used in the NAND-example model):
</p>
<ul>
<li>Semiconductors.PMOS</li>
<li>Semiconductors.NMOS</li>
</ul>
<p>Corrected parameter defaults, unit and description for TrapezoidCurrent.
This makes the parameters consistent with their use in the model.
Models specifying parameter values are not changed.
Models not specifying parameter values did not generate trapezoids previously.
</p>
<p>Icon layer background changed from transparent to white:</p>
<ul>
<li>Basic.Gyrator</li>
<li>Basic.EMF</li>
<li>Ideal.Idle</li>
<li>Ideal.Short</li>
</ul>
<p>Basic.Transformer: Replaced invalid escape characters '\\ ' and '\\[newline]' in documentation by '|'.</p>
<p><i>Modelica.Mechanics.Rotational</i></p>
<p>Removed arrows and names documentation from flanges in diagram layer</p>
<p><i>Modelica.Mechanics.Rotational.Interfaces.FrictionBase</i></p>
<p><i>Modelica.Mechanics.Rotational.Position</i></p>
<p>Replaced <tt>reinit</tt> by <tt>initial equation</tt></p>
<p><i>Modelica.Mechanics.Rotational.RelativeStates</i></p>
<p>Bug corrected by using modifier <tt>stateSelect = StateSelect.prefer</tt> as implementation</p>
<p><i>Modelica.Mechanics.Translational.Interfaces.flange_b</i></p>
<p>Attribute <b>fillColor=7</b> added to Rectangle on Icon layer, i.e. it is now
filled with white and not transparent any more.</p>
<p><i>Modelica.Mechanics.Translational.Position</i></p>
<p>Replaced <tt>reinit</tt> by <tt>initial equation</tt></p>
<p><i>Modelica.Mechanics.Translational.RelativeStates</i></p>
<p>Bug corrected by using modifier <tt>stateSelect = StateSelect.prefer</tt> as implementation</p>
<p><i>Modelica.Mechanics.Translational.Stop</i></p>
<p>Use <tt>stateSelect = StateSelect.prefer</tt>.</p>
<p><i>Modelica.Mechanics.Translational.Examples.PreLoad</i></p>
<p>Improved documentation and coordinate system used for example.</p>
<p><i>ModelicaAdditions.Blocks.Nonlinear.PadeDelay</i></p>
<p>Replaced <tt>reinit</tt> by <tt>initial equation</tt></p>
<p><i>ModelicaAdditions.HeatFlow1D.Interfaces</i></p>
<p>Definition of connectors <i>Surface_a</i> and <i>Surface_b</i>:<br>
<tt>flow SIunits.HeatFlux q;</tt> changed to <tt>flow SIunits.HeatFlowRate q;</tt></p>
<p><i>MultiBody.Parts.InertialSystem</i></p>
<p>Icon corrected.</p>
</html>
"));
end Version_1_5;

class Version_1_4 "Version 1.4 (June 28, 2001)"

annotation (Documentation(info="<html>

<ul>
<li>Several minor bugs fixed. </li>
<li>New models:<br>
	Modelica.Blocks.Interfaces.IntegerRealInput/IntegerRealOutput,<br>
	Modelica.Blocks.Math.TwoInputs/TwoOutputs<br>
	Modelica.Electrical.Analog.Ideal.IdealOpAmp3Pin,<br>
	Modelica.Mechanics.Rotational.Move,<br>
	Modelica.Mechanics.Translational.Move.<br>
	</li>
</ul>
<hr>
<h4>Version 1.4.1beta1 (February 12, 2001)</h4>
<p> Adapted to Modelica 1.4</p>
<hr>
<h4>Version 1.3.2beta2 (June 20, 2000)</h4>
<ul>
	<li>New subpackage Modelica.Mechanics.<b>Translational</b></li>
	<li>Changes to Modelica.Mechanics.<b>Rotational</b>:<br>
	   New elements:
<pre>
IdealGearR2T    Ideal gear transforming rotational in translational motion.
Position        Forced movement of a flange with a reference angle
				   given as input signal
RelativeStates  Definition of relative state variables
</pre>
</li>
	<li>Changes to Modelica.<b>SIunits</b>:<br>
	  Introduced new types:<br>
	  type Temperature = ThermodynamicTemperature;<br>
	  types DerDensityByEnthalpy, DerDensityByPressure,
	  DerDensityByTemperature, DerEnthalpyByPressure,
	  DerEnergyByDensity, DerEnergyByPressure<br>
	  Attribute \"final\" removed from min and max values
	  in order that these values can still be changed to narrow
	  the allowed range of values.<br>
	  Quantity=\"Stress\" removed from type \"Stress\", in order
	  that a type \"Stress\" can be connected to a type \"Pressure\".</li>
	<li>Changes to Modelica.<b>Icons</b>:<br>
	   New icons for motors and gearboxes.</li>
	<li>Changes to Modelica.<b>Blocks.Interfaces</b>:<br>
	   Introduced a replaceable signal type into
	   Blocks.Interfaces.RealInput/RealOutput:
<pre>
replaceable type SignalType = Real
</pre>
	   in order that the type of the signal of an input/output block
	   can be changed to a physical type, for example:
<pre>
Sine sin1(outPort(redeclare type SignalType=Modelica.SIunits.Torque))
</pre>
</li>
</ul>
<hr>
<h4>Version 1.3.1 (Dec. 13, 1999)</h4>
<p>
First official release of the library.
</p>
</html>
"));
end Version_1_4;
end ReleaseNotes;

class ModelicaLicense2 "Modelica License 2"

 annotation (Documentation(info="<html>

<P STYLE=\"text-indent: 0pt; font-weight: medium\">
This page contains the &ldquo;Modelica License 2&rdquo; which was
released by the Modelica Association on Nov. 19, 2008. It is used for
all material from the Modelica Association provided to the public
after this date. It is recommended that other providers of free
Modelica packages license their library also under &ldquo;Modelica
License 2&rdquo;. Additionally, this document contains a description
how to apply the license and has a &ldquo;Frequently Asked Questions&rdquo;
section.</P>

<P STYLE=\"text-indent: 0pt; line-height: 150%\">
<A HREF=\"#1. The Modelica License 2|outline\">             The Modelica License 2</A>
(in other formats:
<A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2.html\">standalone html</A>,
<A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2.pdf\">pdf</A>,
<A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2.odt\">odt</A>,
<A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2.doc\">doc</A>)<br>
<A HREF=\"#2. How to Apply the Modelica License 2|outline\">How to Apply the Modelica License 2</A><br>
<A HREF=\"#3. Frequently Asked Questions|outline\">         Frequently Asked Questions</A><br>&nbsp;</P>

<hr>
<H4><A NAME=\"_Ref208223390\"></A><A NAME=\"1. The Modelica License 2|outline\"></A>
The Modelica License 2</H4>

<P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
<B>Preamble. </B>The goal of this license is that Modelica related
model libraries, software, images, documents, data files etc. can be
used freely in the original or a modified form, in open source and in
commercial environments (as long as the license conditions below are
fulfilled, in particular sections 2c) and 2d). The Original Work is
provided free of charge and the use is completely at your own risk.
Developers of free Modelica packages are encouraged to utilize this
license for their work.</P>
<P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
The Modelica License applies to any Original Work that contains the
following licensing notice adjacent to the copyright notice(s) for
this Original Work:</P>
<P ALIGN=CENTER STYLE=\"text-indent: 0pt\"><B>Licensed
by &lt;name of Licensor&gt; under the Modelica License 2</B></P>
<P STYLE=\"text-indent: 0pt; widows: 2; orphans: 2\"><B>1.
Definitions.</B></P>
<OL style=\"list-style-type:lower-latin\">
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
	&ldquo;License&rdquo; is this Modelica License.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
	&ldquo;Original Work&rdquo; is any work of authorship, including
	software, images, documents, data files, that contains the above
	licensing notice or that is packed together with a licensing notice
	referencing it.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
	&ldquo;Licensor&rdquo; is the provider of the Original Work who has
	placed this licensing notice adjacent to the copyright notice(s) for
	the Original Work. The Original Work is either directly provided by
	the owner of the Original Work, or by a licensee of the owner.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
	&ldquo;Derivative Work&rdquo; is any modification of the Original
	Work which represents, as a whole, an original work of authorship.
	For the matter of clarity and as examples:
	</P>
	<OL style=\"list-style-type:upper-latin\">
		<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
		Derivative Work shall not include work that remains separable from
		the Original Work, as well as merely extracting a part of the
		Original Work without modifying it.</P>
		<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
		Derivative Work shall not include (a) fixing of errors and/or (b)
		adding vendor specific Modelica annotations and/or (c) using a
		subset of the classes of a Modelica package, and/or (d) using a
		different representation, e.g., a binary representation.</P>
		<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
		Derivative Work shall include classes that are copied from the
		Original Work where declarations, equations or the documentation
		are modified.
		</P>
		<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
		Derivative Work shall include executables to simulate the models
		that are generated by a Modelica translator based on the Original
		Work (of a Modelica package).</P>
	</OL>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
	&ldquo;Modified Work&rdquo; is any modification of the Original Work
	with the following exceptions: (a) fixing of errors and/or (b)
	adding vendor specific Modelica annotations and/or (c) using a
	subset of the classes of a Modelica package, and/or (d) using a
	different representation, e.g., a binary representation.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
	&quot;Source Code&quot; means the preferred form of the Original
	Work for making modifications to it and all available documentation
	describing how to modify the Original Work.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
	&ldquo;You&rdquo; means an individual or a legal entity exercising
	rights under, and complying with all of the terms of, this License.
	</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
	&ldquo;Modelica package&rdquo; means any Modelica library that is
	defined with the<BR>&ldquo;<FONT FACE=\"Courier New, monospace\"><FONT SIZE=2 STYLE=\"font-size: 9pt\"><B>package</B></FONT></FONT><FONT FACE=\"Courier New, monospace\"><FONT SIZE=2 STYLE=\"font-size: 9pt\">
	&lt;Name&gt; ... </FONT></FONT><FONT FACE=\"Courier New, monospace\"><FONT SIZE=2 STYLE=\"font-size: 9pt\"><B>end</B></FONT></FONT><FONT FACE=\"Courier New, monospace\"><FONT SIZE=2 STYLE=\"font-size: 9pt\">
	&lt;Name&gt;;</FONT></FONT>&ldquo; Modelica language element.</P>
</OL>

<P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
<B>2. </B><B>Grant of Copyright License. </B>Licensor grants You a
worldwide, royalty-free, non-exclusive, sublicensable license, for
the duration of the copyright, to do the following:</P>
<OL style=\"list-style-type:lower-latin\">
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
	To reproduce the Original Work in copies, either alone or as part of
	a collection.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
	To create Derivative Works according to Section 1d) of this License.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
	To distribute or communicate to the public copies of the <U>Original
	Work</U> or a <U>Derivative Work</U> under <U>this License</U>. No
	fee, neither as a copyright-license fee, nor as a selling fee for
	the copy as such may be charged under this License. Furthermore, a
	verbatim copy of this License must be included in any copy of the
	Original Work or a Derivative Work under this License.<BR>      For
	the matter of clarity, it is permitted A) to distribute or
	communicate such copies as part of a (possible commercial)
	collection where other parts are provided under different licenses
	and a license fee is charged for the other parts only and B) to
	charge for mere printing and shipping costs.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
	To distribute or communicate to the public copies of a <U>Derivative
	Work</U>, alternatively to Section 2c), under <U>any other license</U>
	of your choice, especially also under a license for
	commercial/proprietary software, as long as You comply with Sections
	3, 4 and 8 below. <BR>      For the matter of clarity, no
	restrictions regarding fees, either as to a copyright-license fee or
	as to a selling fee for the copy as such apply.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
	To perform the Original Work publicly.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
	To display the Original Work publicly.</P>
</OL>

<P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
<B>3. </B><B>Acceptance. </B>Any use of the Original Work or a
Derivative Work, or any action according to either Section 2a) to 2f)
above constitutes Your acceptance of this License.</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
<B>4. </B><B>Designation of Derivative Works and of Modified Works.
</B>The identifying designation of Derivative Work and of Modified
Work must be different to the corresponding identifying designation
of the Original Work. This means especially that the (root-level)
name of a Modelica package under this license must be changed if the
package is modified (besides fixing of errors, adding vendor specific
Modelica annotations, using a subset of the classes of a Modelica
package, or using another representation, e.g. a binary
representation).</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
<B>5. </B><B>Grant of Patent License.</B>
Licensor grants You a worldwide, royalty-free, non-exclusive, sublicensable license,
under patent claims owned by the Licensor or licensed to the Licensor by
the owners of the Original Work that are embodied in the Original Work
as furnished by the Licensor, for the duration of the patents,
to make, use, sell, offer for sale, have made, and import the Original Work
and Derivative Works under the conditions as given in Section 2.
For the matter of clarity, the license regarding Derivative Works covers
patent claims to the extent as they are embodied in the Original Work only.</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
<B>6. Provision of </B><B>Source Code. </B>Licensor agrees to provide
You with a copy of the Source Code of the Original Work but reserves
the right to decide freely on the manner of how the Original Work is
provided.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;For the matter of clarity, Licensor might provide only a binary
representation of the Original Work. In that case, You may (a) either
reproduce the Source Code from the binary representation if this is
possible (e.g., by performing a copy of an encrypted Modelica
package, if encryption allows the copy operation) or (b) request the
Source Code from the Licensor who will provide it to You.</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
<B>7. </B><B>Exclusions from License Grant. </B>Neither the names of
Licensor, nor the names of any contributors to the Original Work, nor
any of their trademarks or service marks, may be used to endorse or
promote products derived from this Original Work without express
prior permission of the Licensor. Except as otherwise expressly
stated in this License and in particular in Sections 2 and 5, nothing
in this License grants any license to Licensor&rsquo;s trademarks,
copyrights, patents, trade secrets or any other intellectual
property, and no patent license is granted to make, use, sell, offer
for sale, have made, or import embodiments of any patent claims.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No license is granted to the trademarks of
Licensor even if such trademarks are included in the Original Work,
except as expressly stated in this License. Nothing in this License
shall be interpreted to prohibit Licensor from licensing under terms
different from this License any Original Work that Licensor otherwise
would have a right to license.</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
<B>8. </B><B>Attribution Rights. </B>You must retain in the Source
Code of the Original Work and of any Derivative Works that You
create, all author, copyright, patent, or trademark notices, as well
as any descriptive text identified therein as an &quot;Attribution
Notice&quot;. The same applies to the licensing notice of this
License in the Original Work. For the matter of clarity, &ldquo;author
notice&rdquo; means the notice that identifies the original
author(s). <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You must cause the Source Code for any Derivative
Works that You create to carry a prominent Attribution Notice
reasonably calculated to inform recipients that You have modified the
Original Work. <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In case the Original Work or Derivative Work is not provided in
Source Code, the Attribution Notices shall be appropriately
displayed, e.g., in the documentation of the Derivative Work.</P>

<P STYLE=\"text-indent: 0pt\"><B>9. </B><B>Disclaimer
of Warranty. <BR></B><U><B>The Original Work is provided under this
License on an &quot;as is&quot; basis and without warranty, either
express or implied, including, without limitation, the warranties of
non-infringement, merchantability or fitness for a particular
purpose. The entire risk as to the quality of the Original Work is
with You.</B></U><B> </B>This disclaimer of warranty constitutes an
essential part of this License. No license to the Original Work is
granted by this License except under this disclaimer.</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
<B>10. </B><B>Limitation of Liability. </B>Under no circumstances and
under no legal theory, whether in tort (including negligence),
contract, or otherwise, shall the Licensor, the owner or a licensee
of the Original Work be liable to anyone for any direct, indirect,
general, special, incidental, or consequential damages of any
character arising as a result of this License or the use of the
Original Work including, without limitation, damages for loss of
goodwill, work stoppage, computer failure or malfunction, or any and
all other commercial damages or losses. This limitation of liability
shall not apply to the extent applicable law prohibits such
limitation.</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
<B>11. </B><B>Termination. </B>This License conditions your rights to
undertake the activities listed in Section 2 and 5, including your
right to create Derivative Works based upon the Original Work, and
doing so without observing these terms and conditions is prohibited
by copyright law and international treaty. Nothing in this License is
intended to affect copyright exceptions and limitations. This License
shall terminate immediately and You may no longer exercise any of the
rights granted to You by this License upon your failure to observe
the conditions of this license.</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
<B>12. </B><B>Termination for Patent Action. </B>This License shall
terminate automatically and You may no longer exercise any of the
rights granted to You by this License as of the date You commence an
action, including a cross-claim or counterclaim, against Licensor,
any owners of the Original Work or any licensee alleging that the
Original Work infringes a patent. This termination provision shall
not apply for an action alleging patent infringement through
combinations of the Original Work under combination with other
software or hardware.</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
<B>13. </B><B>Jurisdiction. </B>Any action or suit relating to this
License may be brought only in the courts of a jurisdiction wherein
the Licensor resides and under the laws of that jurisdiction
excluding its conflict-of-law provisions. The application of the
United Nations Convention on Contracts for the International Sale of
Goods is expressly excluded. Any use of the Original Work outside the
scope of this License or after its termination shall be subject to
the requirements and penalties of copyright or patent law in the
appropriate jurisdiction. This section shall survive the termination
of this License.</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
<B>14. </B><B>Attorneys&rsquo; Fees. </B>In any action to enforce the
terms of this License or seeking damages relating thereto, the
prevailing party shall be entitled to recover its costs and expenses,
including, without limitation, reasonable attorneys' fees and costs
incurred in connection with such action, including any appeal of such
action. This section shall survive the termination of this License.</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium; widows: 2; orphans: 2\">
<B>15. </B><B>Miscellaneous. </B>
</P>
<OL style=\"list-style-type:lower-latin\">
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium\">If any
	provision of this License is held to be unenforceable, such
	provision shall be reformed only to the extent necessary to make it
	enforceable.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium\">No verbal
	ancillary agreements have been made. Changes and additions to this
	License must appear in writing to be valid. This also applies to
	changing the clause pertaining to written form.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium\">You may use the
	Original Work in all ways not otherwise restricted or conditioned by
	this License or by law, and Licensor promises not to interfere with
	or be responsible for such uses by You.</P>
</OL>

<hr>

<H4><A NAME=\"2. How to Apply the Modelica License 2|outline\"></A>
How to Apply the Modelica License 2</H4>

<P STYLE=\"text-indent: 0pt; font-weight: medium\">
At the top level of your Modelica package and at every important
subpackage, add the following notices in the info layer of the
package:</P>

<table border=\"0\"><tr><td>&nbsp;&nbsp;&nbsp;</td><td>
Licensed by &lt;Licensor&gt; under the Modelica License 2<br>
Copyright &copy; &lt;year1&gt;-&lt;year2&gt;, &lt;name of copyright
holder(s)&gt;.
</td></tr></table>

<table border=\"0\"><tr><td>&nbsp;&nbsp;&nbsp;</td><td>
<I>This Modelica package is <U>free</U> software and
the use is completely at <U>your own risk</U>;
it can be redistributed and/or modified under the terms of the
Modelica license 2, see the license conditions (including the
disclaimer of warranty)
<A HREF=\"modelica://Library.UsersGuide.ModelicaLicense2\">here</A></U>
or at
<A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2\">
http://www.modelica.org/licenses/ModelicaLicense2</A>.
</td></tr></table>

<P STYLE=\"text-indent: 0pt; font-weight: medium\">Include
a copy of the Modelica License 2 under
<B>&lt;library&gt;.UsersGuide.ModelicaLicense2</B>
(use <A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2.mo\">
http://www.modelica.org/licenses/ModelicaLicense2.mo</A>). Furthermore, add
the list of authors and contributors under
<B>&lt;library&gt;.UsersGuide.Contributors</B> or
<B>&lt;library&gt;.UsersGuide.Contact</B>.</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium\">For
example, sublibrary Modelica.Blocks of the Modelica Standard Library
may have the following notices:</P>

<table border=\"0\"><tr><td>&nbsp;&nbsp;&nbsp;</td><td>
Licensed by Modelica Association under the Modelica License 2<br>
Copyright &copy; 1998-2009, Modelica Association.
</td></tr></table>

<table border=\"0\"><tr><td>&nbsp;&nbsp;&nbsp;</td><td>
<I>This Modelica package is <U>free</U> software and
the use is completely at <U>your own risk</U>;
it can be redistributed and/or modified under the terms of the
Modelica license 2, see the license conditions (including the
disclaimer of warranty)
<A HREF=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">here</A></U>
or at
<A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2\">
http://www.modelica.org/licenses/ModelicaLicense2</A>.</I>
</td></tr></table>


<P STYLE=\"text-indent: 0pt; font-weight: medium\">For
C-source code and documents, add similar notices in the corresponding
file.</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium\">For
images, add a &ldquo;readme.txt&rdquo; file to the directories where
the images are stored and include a similar notice in this file.</P>


<P STYLE=\"text-indent: 0pt; font-weight: medium\">In
these cases, save a copy of the Modelica License 2 in one directory
of the distribution, e.g.,
<A HREF=\"http://www.modelica.org/licenses/ModelicaLicense2.html\">
http://www.modelica.org/licenses/ModelicaLicense2.html</A>
in directory <B>&lt;library&gt;/help/documentation/ModelicaLicense2.html</B>.</P>


<hr>
<H4><A NAME=\"_Ref202857474\"></A><A NAME=\"3. Frequently Asked Questions|outline\"></A>
Frequently Asked Questions</H4>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">
This section contains questions/answer to users and/or distributors of
Modelica packages and/or documents under Modelica License 2. Note,
the answers to the questions below are not a legal interpretation of
the Modelica License 2. In case of a conflict, the language of the
license shall prevail.</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium\"><BR>
</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium; color: green; font-size:140%\">
<b>Using or Distributing a Modelica <U>Package</U> under the Modelica License 2</b></P>

<P STYLE=\"text-indent: 0pt\"><B>What are the main
differences to the previous version of the Modelica License?</B></P>
<OL>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium\">
	Modelica License 1 is unclear whether the licensed Modelica package
	can be distributed under a different license. Version 2 explicitly
	allows that &ldquo;Derivative Work&rdquo; can be distributed under
	any license of Your choice, see examples in Section 1d) as to what
	qualifies as Derivative Work (so, version 2 is clearer).</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium\">
	If You modify a Modelica package under Modelica License 2 (besides
	fixing of errors, adding vendor specific Modelica annotations, using
	a subset of the classes of a Modelica package, or using another
	representation, e.g., a binary representation), you must rename the
	root-level name of the package for your distribution. In version 1
	you could keep the name (so, version 2 is more restrictive). The
	reason of this restriction is to reduce the risk that Modelica
	packages are available that have identical names, but different
	functionality.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium\">
	Modelica License 1 states that &ldquo;It is not allowed to charge a
	fee for the original version or a modified version of the software,
	besides a reasonable fee for distribution and support<SPAN LANG=\"en-GB\">&ldquo;.
	Version 2 has a </SPAN>similar intention for all Original Work under
	<U>Modelica License 2</U> (to remain free of charge and open source)
	but states this more clearly as &ldquo;No fee, neither as a
	copyright-license fee, nor as a selling fee for the copy as such may
	be charged&rdquo;. Contrary to version 1, Modelica License 2 has no
	restrictions on fees for Derivative Work that is provided under a
	different license (so, version 2 is clearer and has fewer
	restrictions).</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium\">
	Modelica License 2 introduces several useful provisions for the
	licensee (articles 5, 6, 12), and for the licensor (articles 7, 12,
	13, 14) that have no counter part in version 1.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium\">
	Modelica License 2 can be applied to all type of work, including
	documents, images and data files, contrary to version 1 that was
	dedicated for software only (so, version 2 is more general).</P>
</OL>

<P STYLE=\"text-indent: 0pt\"><B>Can I distribute a
Modelica package (under Modelica License 2) as part of my commercial
Modelica modeling and simulation environment?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">Yes,
according to Section 2c). However, you are not allowed to charge a
fee for this part of your environment. Of course, you can charge for
your part of the environment.
</P>

<P STYLE=\"text-indent: 0pt\"><B>Can I distribute a
Modelica package (under Modelica License 2) under a different
license?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">No.
The license of an unmodified Modelica package cannot be changed
according to Sections 2c) and 2d). This means that you cannot <U>sell</U>
copies of it, any distribution has to be free of charge.</P>

<P STYLE=\"text-indent: 0pt\"><B>Can I distribute a
Modelica package (under Modelica License 2) under a different license
when I first encrypt the package?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">No.
Merely encrypting a package does not qualify for Derivative Work and
therefore the encrypted package has to stay under Modelica License 2.</P>


<P STYLE=\"text-indent: 0pt\"><B>Can I distribute a
Modelica package (under Modelica License 2) under a different license
when I first add classes to the package?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">No.
The package itself remains unmodified, i.e., it is Original Work, and
therefore the license for this part must remain under Modelica
License 2. The newly added classes can be, however, under a different
license.
</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium\"><B>Can
I copy a class out of a Modelica package (under Modelica License 2)
and include it </B><U><B>unmodified</B></U><B> in a Modelica package
under a </B><U><B>commercial/proprietary license</B></U><B>?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">No,
according to article 2c). However, you can include model, block,
function, package, record and connector classes in your Modelica
package under <U>Modelica License 2</U>. This means that your
Modelica package could be under a commercial/proprietary license, but
one or more classes of it are under Modelica License 2.<BR>Note, a
&ldquo;type&rdquo; class (e.g., type Angle = Real(unit=&rdquo;rad&rdquo;))
can be copied and included unmodified under a commercial/proprietary
license (for details, see the next question).</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium\"><B>Can
I copy a type class or </B><U><B>part</B></U><B> of a model, block,
function, record, connector class, out of a Modelica package (under
Modelica License 2) and include it modified or unmodified in a
Modelica package under a </B><U><B>commercial/proprietary</B></U><B>
license</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">Yes,
according to article 2d), since this will in the end usually qualify
as Derivative Work. The reasoning is the following: A type class or
part of another class (e.g., an equation, a declaration, part of a
class description) cannot be utilized &ldquo;by its own&rdquo;. In
order to make this &ldquo;usable&rdquo;, you have to add additional
code in order that the class can be utilized. This is therefore
usually Derivative Work and Derivative Work can be provided under a
different license. Note, this only holds, if the additional code
introduced is sufficient to qualify for Derivative Work. Merely, just
copying a class and changing, say, one character in the documentation
of this class would be no Derivative Work and therefore the copied
code would have to stay under Modelica License 2.</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium\"><B>Can
I copy a class out of a Modelica package (under Modelica License 2)
and include it in </B><U><B>modified </B></U><B>form in a
</B><U><B>commercial/proprietary</B></U><B> Modelica package?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">Yes.
If the modification can be seen as a &ldquo;Derivative Work&rdquo;,
you can place it under your commercial/proprietary license. If the
modification does not qualify as &ldquo;Derivative Work&rdquo; (e.g.,
bug fixes, vendor specific annotations), it must remain under
Modelica License 2. This means that your Modelica package could be
under a commercial/proprietary license, but one or more parts of it
are under Modelica License 2.</P>

<P STYLE=\"text-indent: 0pt\"><B>Can I distribute a
&ldquo;save total model&rdquo; under my commercial/proprietary
license, even if classes under Modelica License 2 are included?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">Your
classes of the &ldquo;save total model&rdquo; can be distributed
under your commercial/proprietary license, but the classes under
Modelica License 2 must remain under Modelica License 2. This means
you can distribute a &ldquo;save total model&rdquo;, but some parts
might be under Modelica License 2.</P>

<P STYLE=\"text-indent: 0pt\"><B>Can I distribute a
Modelica package (under Modelica License 2) in encrypted form?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">Yes.
Note, if the encryption does not allow &ldquo;copying&rdquo; of
classes (in to unencrypted Modelica source code), you have to send
the Modelica source code of this package to your customer, if he/she
wishes it, according to article&nbsp;6.</P>

<P STYLE=\"text-indent: 0pt\"><B>Can I distribute an
executable under my commercial/proprietary license, if the model from
which the executable is generated uses models from a Modelica package
under Modelica License 2?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">Yes,
according to article 2d), since this is seen as Derivative Work. The
reasoning is the following: An executable allows the simulation of a
concrete model, whereas models from a Modelica package (without
pre-processing, translation, tool run-time library) are not able to
be simulated without tool support. By the processing of the tool and
by its run-time libraries, significant new functionality is added (a
model can be simulated whereas previously it could not be simulated)
and functionality available in the package is removed (e.g., to build
up a new model by dragging components of the package is no longer
poss"   + "ible with the executable).</P>

<P STYLE=\"text-indent: 0pt\"><B>Is my modification to
a Modelica package (under Modelica License 2) a Derivative Work?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">It
is not possible to give a general answer to it. To be regarded as &quot;an
original work of authorship&quot;, a derivative work must be
different enough from the original or must contain a substantial
amount of new material. Making minor changes or additions of little
substance to a preexisting work will not qualify the work as a new
version for such purposes.
</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium\"><BR>
</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium; color: green; font-size:140%\">
<b>Using or Distributing a Modelica <U>Document</U> under the Modelica License 2</b></P>

<P STYLE=\"text-indent: 0pt; font-weight: medium\">This
section is devoted especially for the following applications:</P>
<OL>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium\">
	A Modelica tool extracts information out of a Modelica package and
	presents the result in form of a &ldquo;manual&rdquo; for this
	package in, e.g., html, doc, or pdf format.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium\">
	The Modelica language specification is a document defining the
	Modelica language. It will be licensed under Modelica License 2.</P>
	<LI><P STYLE=\"text-indent: 0pt; font-weight: medium\">
	Someone writes a book about the Modelica language and/or Modelica
	packages and uses information which is available in the Modelica
	language specification and/or the corresponding Modelica package.</P>
</OL>

<P STYLE=\"text-indent: 0pt\"><B>Can I sell a manual
that was basically derived by extracting information automatically
from a Modelica package under Modelica License 2 (e.g., a &ldquo;reference
guide&rdquo; of the Modelica Standard Library):</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">Yes.
Extracting information from a Modelica package, and providing it in a
human readable, suitable format, like html, doc or pdf format, where
the content is significantly modified (e.g. tables with interface
information are constructed from the declarations of the public
variables) qualifies as Derivative Work and there are no restrictions
to charge a fee for Derivative Work under alternative 2d).</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium\"><B>Can
I copy a text passage out of a Modelica document (under Modelica
License 2) and use it </B><U><B>unmodified</B></U><B> in my document
(e.g. the Modelica syntax description in the Modelica Specification)?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">Yes.
In case you distribute your document, the copied parts are still
under Modelica License 2 and you are not allowed to charge a license
fee for this part. You can, of course, charge a fee for the rest of
your document.</P>

<P STYLE=\"text-indent: 0pt; font-weight: medium\"><B>Can
I copy a text passage out of a Modelica document (under Modelica
License 2) and use it in </B><U><B>modified</B></U><B> form in my
document?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">Yes,
the creation of Derivative Works is allowed. In case the content is
significantly modified this qualifies as Derivative Work and there
are no restrictions to charge a fee for Derivative Work under
alternative 2d).</P>

<P STYLE=\"text-indent: 0pt\"><B>Can I sell a printed
version of a Modelica document (under Modelica License 2), e.g., the
Modelica Language Specification?</B></P>
<P STYLE=\"text-indent: 0pt; font-weight: medium\">No,
if you are not the copyright-holder, since article 2c) does not allow
a selling fee for a (in this case physical) copy. However, mere
printing and shipping costs may be recovered.</P>
</html>
"));

end ModelicaLicense2;

class Contact "Contact"

 annotation (Documentation(info="<html>

<dl>
<dt>The Modelica Standard Library (this Modelica package)
	is developed by many people from different organizations (see list below).
	It is licensed under the
	<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica License 2</a>
	by:<br>&nbsp;</dt>
<dd>Modelica Association<br>
	(Ideella F&ouml;reningar 822003-8858 in Link&ouml;ping) <br>
	c/o PELAB, IDA, Link&ouml;pings Universitet<br>
	S-58183 Link&ouml;ping<br>
	Sweden<br>
	email: <a href=\"mailto:Board@Modelica.org\">Board@Modelica.org</a><br>
	web: <a href=\"http://www.Modelica.org\">http://www.Modelica.org</a><br>&nbsp;<br>&nbsp;</dd>
</dl>

<dl>
<dt>The development of this Modelica package is organized by<br>&nbsp;</dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
	Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
	Institut f&uuml;r Robotik und Mechatronik<br>
	Abteilung f&uuml;r Systemdynamik und Regelungstechnik<br>
	Postfach 1116<br>
	D-82230 Wessling<br>
	Germany<br>
	email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br></dd>
</dl>

<p>
Since end of 2007, the development of the sublibraries of package Modelica
is organized by personal and/or organizational <b>library officers</b> assigned by the
Modelica Association. They are responsible for the maintenance and
for the further organization of the development. Other persons may
also contribute, but the final decision for library improvements and/or changes
is performed by the responsible library officer(s). In order that a new
sublibrary or a new version of a sublibrary is ready to be released,
the responsible library officers report the changes to the members of
the Modelica Association and the library is made available for beta testing to
interested parties before a final decision. A new release of a sublibrary
is formally decided by voting of the Modelica Association members.
</p>

<p>
The following library officers are currently assigned:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><td valign=\"top\"><b>Sublibrary</b> </td
	  <td valign=\"top\"><b>Library officers</td>
</tr>

<tr><td valign=\"top\"> Blocks <br> Constants </td>
	  <td valign=\"top\"> DLR Institute of Robotics and Mechatronics, Oberpfaffenhofen, Germany<br>
					   (Martin Otter)</td>
</tr>

<tr><td valign=\"top\"> Electrical.Analog, <br> Electrical.Digital </td>
	  <td valign=\"top\"> Fraunhofer Institute for Integrated Circuits, Dresden, Germany<br>
						(Christoph Clauss)</td>
</tr>

<tr><td valign=\"top\"> Electrical.Machines<br>
						Electrical.MultiPhase </td>
	  <td valign=\"top\"> Anton Haumer, Consultant, St.Andrae-Woerdern, Austria, and<br>
						arsenal research, Vienna, Austria (Christian Kral)</td>
</tr>

<tr><td valign=\"top\"> Icons </td>
	  <td valign=\"top\"> Modelon AB, Lund, Sweden (Johan Andreasson) </td>
</tr>

<tr><td valign=\"top\"> Math </td>
	  <td valign=\"top\"> DLR Institute of Robotics and Mechatronics, Oberpfaffenhofen, Germany<br>
						(Martin Otter)</td>
</tr>

<tr><td valign=\"top\"> Mechanics.MultiBody </td>
	  <td valign=\"top\"> DLR Institute of Robotics and Mechatronics, Oberpfaffenhofen, Germany<br>
						(Martin Otter),<br>
						 Modelon AB, Lund, Sweden (Johan Andreasson) </td>
</tr>

<tr><td valign=\"top\"> Mechanics.Rotational </td>
	  <td valign=\"top\"> DLR Institute of Robotics and Mechatronics, Oberpfaffenhofen, Germany<br>
						(Martin Otter)<br>
						Anton Haumer, Consultant, St.Andrae-Woerdern, Austria,<br>
						arsenal research, Vienna, Austria (Christian Kral),<br>
						Modelon AB, Lund, Sweden (Johan Andreasson)</td>
</tr>

<tr><td valign=\"top\"> Mechanics.Translational </td>
	  <td valign=\"top\"> Anton Haumer, Consultant, St.Andrae-Woerdern, Austria,<br>
						arsenal research, Vienna, Austria (Christian Kral), <br>
						DLR Institute of Robotics and Mechatronics, Oberpfaffenhofen, Germany<br>
						(Martin Otter)<br>
						 Modelon AB, Lund, Sweden (Johan Andreasson)</td>
</tr>


<tr><td valign=\"top\"> Media </td>
	  <td valign=\"top\"> Modelon AB, Lund, Sweden (Hubertus Tummescheit) </td>
</tr>

<tr><td valign=\"top\"> SIunits <br>
						StateGraph </td>
	  <td valign=\"top\"> DLR Institute of Robotics and Mechatronics, Oberpfaffenhofen, Germany<br>
						(Martin Otter)</td>
</tr>

<tr><td valign=\"top\"> Thermal.FluidHeatFlow <br>
						Thermal.HeatTransfer </td>
	  <td valign=\"top\"> Anton Haumer, Consultant, St.Andrae-Woerdern, Austria, and<br>
						arsenal research, Vienna, Austria (Christian Kral)</td>

<tr><td valign=\"top\"> Utilities </td>
	  <td valign=\"top\"> DLR Institute of Robotics and Mechatronics, Oberpfaffenhofen, Germany<br>
						(Martin Otter)<br>
						Dynasim AB, Lund, Sweden (Hans Olsson)</td>
</tr>
</table>


<p>
The following people have directly contributed to the implementation
of the Modelica package (many more people have contributed to the design):
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><td valign=\"top\"><b>Peter Beater</b> </td
	  <td valign=\"top\"> University of Paderborn, Germany</td>
	  <td valign=\"top\"> Modelica.Mechanics.Translational </td>
</tr>
<tr><td valign=\"top\"><b>Dag Br&uuml;ck</b> </td
	  <td valign=\"top\"> Dynasim AB, Lund, Sweden</td>
	  <td valign=\"top\"> Modelica.Utilities</td>
</tr>

<tr><td valign=\"top\"><b>Francesco Casella</b> </td
	  <td valign=\"top\"> Politecnico di Milano, Milano, Italy</td>
	  <td valign=\"top\"> Modelica.Media</td>
</tr>

<tr><td valign=\"top\"><b>Christoph Clauss</b> </td
	  <td valign=\"top\"> Fraunhofer Institute for Integrated Circuits,<br> Dresden, Germany</td>
	  <td valign=\"top\"> Modelica.Electrical.Analog<br>
		   Modelica.Electrical.Digital</td>
</tr>

<tr><td valign=\"top\"><b>Jonas Eborn</b> </td
	  <td valign=\"top\"> Modelon AB, Lund, Sweden</td>
	  <td valign=\"top\"> Modelica.Media</td>
</tr>

<tr><td valign=\"top\"><b>Hilding Elmqvist</b> </td
	  <td valign=\"top\"> Dynasim AB, Lund, Sweden</td>
	  <td valign=\"top\"> Modelica.Mechanics.MultiBody<br>
		   Modelica.Media<br>
		   Modelica.StateGraph<br>
		   Modelica.Utilities<br>
		   Conversion from 1.6 to 2.0</td>
</tr>

<tr><td valign=\"top\"><b>R&uuml;diger Franke</b> </td
	  <td valign=\"top\"> ABB Corporate Research,<br>Ladenburg, German</td>
	  <td valign=\"top\"> Modelica.Media</td>
</tr>

<tr><td valign=\"top\"><b>Anton Haumer</b> </td
	  <td valign=\"top\"> Consultant, St.Andrae-Woerdern,<br>Austria</td>
	  <td valign=\"top\"> Modelica.Electrical.Machines<br>
		   Modelica.Electrical.Multiphase<br>
		   Modelica.Mechanics.Rotational<br>
		   Modelica.Mechanics.Translational<br>
		   Modelica.Thermal.FluidHeatFlow<br>
		   Modelica.Thermal.HeatTransfer<br>
		   Conversion from 1.6 to 2.0<br>
		   Conversion from 2.2 to 3.0</td>
</tr>

<tr><td valign=\"top\"><b>Hans-Dieter Joos</b> </td
	  <td valign=\"top\"> Institute of Robotics and Mechatronics<br>
		   DLR, German Aerospace Center, <br>
		   Oberpfaffenhofen, Germany</td>
	  <td valign=\"top\"> Modelica.Math.Matrices</td>
</tr>

<tr><td valign=\"top\"><b>Christian Kral</b> </td
	  <td valign=\"top\"> arsenal research, Vienna, Austria</td>
	  <td valign=\"top\"> Modelica.Electrical.Machines<br>
		   Modelica.Thermal.FluidHeatFlow</td>
</tr>

<tr><td valign=\"top\"><b>Sven Erik Mattsson</b> </td
	  <td valign=\"top\"> Dynasim AB, Lund, Sweden</td>
	  <td valign=\"top\"> Modelica.Mechanics.MultiBody</td>
</tr>
<tr><td valign=\"top\"><b>Hans Olsson</b> </td
	  <td valign=\"top\"> Dynasim AB, Lund, Sweden</td>
	  <td valign=\"top\"> Modelica.Blocks<br>
		   Modelica.Math.Matrices<br>
		   Modelica.Utilities<br>
		   Conversion from 1.6 to 2.0<br>
		   Conversion from 2.2 to 3.0</td>
</tr>
<tr><td valign=\"top\"><b>Martin Otter</b> </td
	  <td valign=\"top\"> Institute of Robotics and Mechatronics<br>
		   DLR, German Aerospace Center, <br>
		   Oberpfaffenhofen, Germany</td>
	  <td valign=\"top\"> Modelica.Blocks<br>
		   Modelica.Mechanics.MultiBody<br>
		   Modelica.Mechanics.Rotational<br>
		   Modelica.Mechanics.Translational<br>
		   Modelica.Math<br>
		   Modelica.Media<br>
		   Modelica.SIunits<br>
		   Modelica.StateGraph<br>
		   Modelica.Thermal.HeatTransfer<br>
		   Modelica.Utilities<br>
		   ModelicaReference<br>
		   Conversion from 1.6 to 2.0<br>
		   Conversion from 2.2 to 3.0</td>
</tr>

<tr><td valign=\"top\"><b>Katrin Pr&ouml;l&szlig;</b> </td
	  <td valign=\"top\"> Department of Technical Thermodynamics,<br>
		   Technical University Hamburg-Harburg,<br>Germany</td>
	  <td valign=\"top\"> Modelica.Media</td>
</tr>

<tr><td valign=\"top\"><b>Christoph C. Richter</b> </td
	  <td valign=\"top\"> Institut f&uuml;r Thermodynamik, <br>
		   Technische Universit&auml;t Braunschweig, <br>
		   Germany</td>
	  <td valign=\"top\"> Modelica.Media</td>
</tr>

<tr><td valign=\"top\"><b>Andr&eacute; Schneider</b> </td
	  <td valign=\"top\"> Fraunhofer Institute for Integrated Circuits,<br> Dresden, Germany</td>
	  <td valign=\"top\"> Modelica.Electrical.Analog<br>
		   Modelica.Electrical.Digital</td>
</tr>
<tr><td valign=\"top\"><b>Christian Schweiger</b> </td
	  <td valign=\"top\"> Until 2006:<br>
		   Institute of Robotics and Mechatronics,<br>
		   DLR, German Aerospace Center,<br>
		   Oberpfaffenhofen, Germany</td>
	  <td valign=\"top\"> Modelica.Mechanics.Rotational<br>
		   ModelicaReference<br>
		   Conversion from 1.6 to 2.0</td>
</tr>
<tr><td valign=\"top\"><b>Michael Tiller</b> </td
	  <td valign=\"top\"> Emmeskay, Inc., Dearborn, MI, U.S.A, <br>
		   (previously Ford Motor Company, Dearborn) </td>
	  <td valign=\"top\"> Modelica.Media<br>
		   Modelica.Thermal.HeatTransfer</td>
</tr>
<tr><td valign=\"top\"><b>Hubertus Tummescheit</b> </td
	  <td valign=\"top\"> Modelon AB, Lund, Sweden </td>
	  <td valign=\"top\"> Modelica.Media<br>
		   Modelica.Thermal.HeatTransfer</td>
</tr>
<tr><td valign=\"top\"><b>Nico Walter</b> </td
	  <td valign=\"top\"> Master thesis at HTWK Leipzig<br>
		   (Prof. R. M&uuml;ller) and<br>
		   DLR Oberpfaffenhofen, Germany</td>
	  <td valign=\"top\"> Modelica.Math.Matrices</td>
</tr>
</table>
</html>
"));

end Contact;

end UsersGuide;
end Modelica;
