package Modelica "Modelica Standard Library"
extends Icons.Library;


annotation(preferedView="info",
  Window(
    x=0.02,
    y=0.01,
    width=0.2,
    height=0.57,
    library=1,
    autolayout=1),
  version="2.2.2",
  versionDate="2007-06-12",
  conversion(
    from(version="1.6",
         ModelicaAdditions(version="1.5"),
         MultiBody(version="1.0.1"),
         MultiBody(version="1.0"),
         Matrices(version="0.8"),
         script="Scripts/ConvertModelica_from_1.6_to_2.1.mos"),
    from(version="2.1 Beta1", script="Scripts/ConvertModelica_from_2.1Beta1_to_2.1.mos"),
    noneFromVersion="2.1",
    noneFromVersion="2.2",
    noneFromVersion="2.2.1",
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
<li> <a href=\"Modelica://Modelica.UsersGuide\">Users Guide</a>
     discusses some aspects of the Modelica Standard Library, such as
     interface definitions and used conventions.</li>
<li><a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes\">Release Notes</a>
    summarizes the changes of new versions of this package.</li>
<li> Packages <b>Examples</b> in the various subpackages, demonstrate
     how to use the components of the corresponding sublibrary.</li>
</ul>
 
<p>
Copyright &copy; 1998-2006, Modelica Association.
</p>
<p>
<i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p><br>
</HTML>
"));


package UsersGuide "Users Guide" 
  
  annotation (DocumentationClass=true, Documentation(info="<html>
<h3><font color=\"#008000\" size=5>Users Guide of the Modelica Standard Library</font></h3>
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
This package contains a short <b>users guide</b> for 
the overall library. Some of the main sublibraries have their own
users guides that can be accessed by the following links:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><a href=\"Modelica://Modelica.Electrical.Digital.UsersGuide\">Digital</a><
             </td>
      <td>Library for digital electrical components based on the VHDL standard 
         (2-,3-,4-,9-valued logic)\"</td>
  </tr>
  <tr><td><a href=\"Modelica://Modelica.Mechanics.MultiBody.UsersGuide\">MultiBody</a>
             </td>
      <td>Library to model 3-dimensional mechanical systems</td>
  </tr>

  <tr><td><a href=\"Modelica://Modelica.Mechanics.Rotational.UsersGuide\">Rotational</a>
             </td>
      <td>Library to model 1-dimensional mechanical systems</td>
  </tr>

  <tr><td><a href=\"Modelica://Modelica.Media.UsersGuide\">Media</a>
             </td>
      <td>Property models of media</td>
  </tr>
  <tr><td><a href=\"Modelica://Modelica.SIunits.UsersGuide\">SIunits.</a> </td>
      <td>Type definitions based on SI units according to ISO 31-1992</td>
  </tr>

  <tr><td><a href=\"Modelica://Modelica.StateGraph.UsersGuide\">StateGraph</a>
             </td>
      <td>Library to model discrete event and reactive systems by hierarchical state machines</td>
  </tr>


  <tr><td><a href=\"Modelica://Modelica.Utilities.UsersGuide\">Utilities</a>
             </td>
      <td>Utility functions especially for scripting (Files, Streams, Strings, System)</td>
  </tr>
</table>

</html>"));
  
  class Connectors "Connectors" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>Connectors</font></h3>
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
  <tr><td><b>domain</b></td>
      <td><b>pot. variables</b></td>
      <td><b>flow variables</b></td>
      <td><b>connector definition</b></td>
      <td><b>icons</b></td></tr>
 
  <tr><td><b>electrical<br>analog</b></td>
      <td>electrical potential</td>
      <td>electrical current</td>
      <td><a href=\"Modelica://Modelica.Electrical.Analog.Interfaces\">Modelica.Electrical.Analog.Interfaces</a>
           <br>Pin, PositivePin, NegativePin</td>
      <td><img src=\"../Images/UsersGuide/ElectricalPins.png\"></td></tr>

  <tr><td><b>electrical<br>multi-phase</b></td>
      <td colspan=\"2\">vector of electrical pins</td>
      <td><a href=\"Modelica://Modelica.Electrical.MultiPhase.Interfaces\">Modelica.Electrical.MultiPhase.Interfaces</a>
           <br>Plug, PositivePlug, NegativePlug</td>
      <td><img src=\"../Images/UsersGuide/ElectricalPlugs.png\"></td></tr>
  
  <tr><td><b>electrical <br>sphace phasor</b></td>
      <td>2 electrical potentials</td>
      <td>2 electrical currents</td>
      <td><a href=\"Modelica://Modelica.Electrical.Machines.Interfaces\">Modelica.Electrical.Machines.Interfaces</a>
           <br>SpacePhasor</td>
      <td><img src=\"../Images/UsersGuide/SpacePhasor.png\"></td></tr>
  
  <tr><td><b>electrical <br>digital</b></td>
      <td>Integer (1..9)</td>
      <td>---</td>
      <td><a href=\"Modelica://Modelica.Electrical.Digital.Interfaces\">Modelica.Electrical.Digital.Interfaces</a>
           <br>DigitalSignal, DigitalInput, DigitalOutput</td>
      <td><img src=\"../Images/UsersGuide/Digital.png\"></td></tr>
  
  <tr><td><b>translational</b></td>
      <td>distance</td>
      <td>cut-force</td>
      <td><a href=\"Modelica://Modelica.Mechanics.Translational.Interfaces\">Modelica.Mechanics.Translational.Interfaces</a>
           <br>Flange_a, Flange_b</td>
      <td><img src=\"../Images/UsersGuide/TranslationalFlanges.png\"></td></tr>
 
  <tr><td><b>rotational</b></td>
      <td>angle</td>
      <td>cut-torque</td>
      <td><a href=\"Modelica://Modelica.Mechanics.Rotational.Interfaces\">Modelica.Mechanics.Rotational.Interfaces</a>
           <br>Flange_a, Flange_b</td>
      <td><img src=\"../Images/UsersGuide/RotationalFlanges.png\"></td></tr>

  <tr><td><b>3-dim.<br>mechanics</b></td>
      <td>position vector<br>
          orientation object</td>
      <td>cut-force vector<br>
          cut-torque vector</td>
      <td><a href=\"Modelica://Modelica.Mechanics.MultiBody.Interfaces\">Modelica.Mechanics.MultiBody.Interfaces</a>
           <br>Frame, Frame_a, Frame_b, Frame_resolve</td>
      <td><img src=\"../Images/UsersGuide/MultiBodyFrames.png\"></td></tr>

  <tr><td><b>simple<br>fluid flow</b></td>
      <td>pressure<br>
          specific enthalpy</td>
      <td>mass flow rate<br>
          enthalpy flow rate</td>
      <td><a href=\"Modelica://Modelica.Thermal.FluidHeatFlow.Interfaces\">Modelica.Thermal.FluidHeatFlow.Interfaces</a>
           <br>FlowPort, FlowPort_a, FlowPort_b</td>
      <td><img src=\"../Images/UsersGuide/FluidHeatFlowPorts.png\"></td></tr>

  <tr><td><b>heat<br>transfer</b></td>
      <td>temperature</td>
      <td>heat flow rate</td>
      <td><a href=\"Modelica://Modelica.Thermal.HeatTransfer.Interfaces\">Modelica.Thermal.HeatTransfer.Interfaces</a>
           <br>HeatPort, HeatPort_a, HeatPort_b</td>
      <td><img src=\"../Images/UsersGuide/ThermalHeatPorts.png\"></td></tr>
 
  <tr><td><b>block<br>diagram</b></td>
      <td>Real variable<br>
          Integer variable<br>
          Boolean variable</td>
      <td>---</td>
      <td><a href=\"Modelica://Modelica.Blocks.Interfaces\">Modelica.Blocks.Interfaces</a>
           <br>RealSignal, RealInput, RealOutput<br>
               IntegerSignal, IntegerInput, IntegerOutput<br>
               BooleanSignal, BooleanInput, BooleanOutput</td>
      <td><img src=\"../Images/UsersGuide/Signals.png\"></tr>

  <tr><td><b>state<br>machine</b></td>
      <td>Boolean variables<br>
          (occupied, set, <br>
           available, reset)</td>
      <td>---</td>
      <td><a href=\"Modelica://Modelica.StateGraph.Interfaces\">Modelica.StateGraph.Interfaces</a>
           <br>Step_in, Step_out, Transition_in, Transition_out</td>
      <td><img src=\"../Images/UsersGuide/StateGraphPorts.png\"></td></tr>

  <tr><td colspan=\"5\">&nbsp;<br><b>Connectors from libraries that will be included in one of 
                                   the next releases of package Modelica</b></td></tr>

  <tr><td><b>thermo<br>fluid flow</b></td>
      <td>pressure<br>
          specific enthalpy<br>
          mass fractions</td>
      <td>mass flow rate<br>
          enthalpy flow rate<br>
          subst. mass flow rates</td>
      <td><a href=\"Modelica://Modelica_Fluid.Interfaces\">Modelica_Fluid.Interfaces</a>
           <br>FluidPort, FluidPort_a, FluidPort_b</td>
      <td><img src=\"../Images/UsersGuide/FluidPorts.png\"></td></tr>

  <tr><td><b>magnetic</b></td>
      <td>magnetic potential</td>
      <td>magnetic flux</td>
      <td><a href=\"Modelica://Magnetic.Interfaces\">Magnetic.Interfaces</a>
           <br>MagneticPort, PositiveMagneticPort, <br>NegativeMagneticPort</td>
      <td><img src=\"../Images/UsersGuide/MagneticPorts.png\"></td></tr>


  <tr><td colspan=\"5\">&nbsp;<br><b>Connectors from other libraries</b></td></tr>

  <tr><td><b>hydraulic</b></td>
      <td>pressure</td>
      <td>volume flow rate</td>
      <td><a href=\"Modelica://HyLibLight.Interfaces\">HyLibLight.Interfaces</a>
           <br>Port_A, Port_b</td>
      <td><img src=\"../Images/UsersGuide/HydraulicPorts.png\"></td></tr>

  <tr><td><b>pneumatic</b></td>
      <td>pressure</td>
      <td>mass flow rate</td>
      <td><a href=\"Modelica://PneuLibLight.Interfaces\">PneuLibLight.Interfaces</a>
           <br>Port_1, Port_2</td>
      <td><img src=\"../Images/UsersGuide/PneumaticPorts.png\"></td></tr>
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
<h3><font color=\"#008000\" size=5>Conventions</font></h3>

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

<p>
&nbsp;<br>
<b>Enumerations</b> are defined in the Modelica language since release 2.0.
However, they are not yet supported in the most important Modelica
simulation environment Dymola. For this reason, this language element
is not used in the Modelica standard library. Instead, enumerations
are emulated with packages and constants. For example, the enumeration
</p>

<pre>   <b>type</b> Init = <b>enumeration</b> (NoInit, InitializeStates, SteadyState);

   <b>parameter</b> Init initType = Init.NoInit \"Type of initialization\";
</pre>

<p>
is emulated in the following way:
</p>

<pre>   <b>package</b>  Init \"Enumeration emulation\" 
      <b>extends</b>  Modelica.Icons.Enumeration;
  
      <b>constant</b>  Integer NoInit=1;
      <b>constant</b>  Integer InitializeStates=2;
      <b>constant</b>  Integer SteadyState=3;
  
      <b>type</b>  Temp  
         <b>extends</b>  Modelica.Icons.TypeInteger;
         <b>annotation</b>  (choices(
             choice=Init.NoInit           \"NoInit (no initialization)\",
             choice=Init.InitializeStates \"InitializeStates (initialize states)\",
             choice=Init.SteadyState      \"SteadyState (initialize in steady state)\"));
      <b>end</b>  Temp;
   <b>end</b>  Init;

   <b>parameter</b> Init.Temp initType = Init.NoInit;
</pre>
</html>
"));
  end Conventions;
  
  class ReleaseNotes "Release notes" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>Release notes</font></h3>
<p>
This section summarizes the changes that have been performed
on the Modelica standard library.
</p>
<ul>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_2_2_2\">Version 2.2.2</a> (June 12, 2007)</li>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_2_2_1\">Version 2.2.1</a> (March 24, 2006)</li>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_2_2\">Version 2.2</a> (April 6, 2005)</li>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_2_1\">Version 2.1</a> (Nov. 11, 2004)</li>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_1_6\">Version 1.6</a> (June 21, 2004)</li>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_1_5\">Version 1.5</a> (Dec. 16, 2002)</li>
<li> <a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes.Version_1_4\">Version 1.4</a> (June 28, 2001
     and previous versions)</li>
</ul>
</html>
"));
    
  class Version_2_2_2 "Version 2.2.2" 
      
      annotation (Documentation(info="<html>
<h3><font color=\"#008000\">Version 2.2.2</font></h3>
<p>
Version 2.2.2 is backward compatible to version 2.2.1 and 2.2.
</p>
 
<p>
In this version, <b>no</b> new libraries have been added.
The following major improvements have been made:
</p>
 
<ul>
<li> xxx </li>
</ul>
 
<p>
The following <b>new components</b> have been added to <b>existing</b> libraries:
</p>
 
<table border=\"1\" cellspacing=0 cellpadding=2>
  <tr><td colspan=\"2\"><b>Modelica.xxx.</b></td></tr>
  <tr><td> xx</td>
      <td> xxx.</td> </tr>
</table> 
 
<p>
The following <b>components</b> have been improved:
</p>
 
<table border=\"1\" cellspacing=0 cellpadding=2>
  <tr><td colspan=\"2\"><b>Modelica.xxx.</b></td></tr>
  <tr><td> xxx</td>
      <td> xxx</td> </tr>
</table> 

<p>
The following <b>errors</b> have been fixed:
</p>
 
<table border=\"1\" cellspacing=0 cellpadding=2>
  <tr><td colspan=\"2\"><b>Modelica.xxx.</b></td></tr>
  <tr><td> xxx</td>
      <td> xxx</td> </tr>
</table> 
                               
</html>
"));
  end Version_2_2_2;

  class Version_2_2_1 "Version 2.2.1" 
      
      annotation (Documentation(info="<html>
<h3><font color=\"#008000\">Version 2.2.1</font></h3>
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
     tables do not have empty entries. Also new users guides for sublibraries
     Rotational and SIunits have been added and the users guide on top
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
  <tr><td> PID_Controller</td>
      <td> Example to demonstrate the usage of the
           Blocks.Continuous.LimPID block.</td> </tr>
  <tr><td colspan=\"2\"><b>Modelica.Blocks.Math.</b></td></tr>
  <tr><td> UnitConversions.*</td>
      <td> New package that provides blocks for unit conversions.
           UnitConversions.ConvertAllBlocks allows to select all
           available conversions from a menu.</td> </tr>
  <tr><td colspan=\"2\"><b>Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.</b></td></tr>
  <tr><td> SM_ElectricalExcitedDamperCage</td>
      <td> Electrical excited synchronous induction machine with damper cage</td> </tr>
  <tr><td colspan=\"2\"><b>Modelica.Electrical.Machines.BasicMachines.Components.</b></td></tr>
  <tr><td> ElectricalExcitation </td>
      <td> Electrical excitation for electrical excited synchronous 
           induction machines</td> </tr>
  <tr><td> DamperCage</td>
      <td> Unsymmetrical damper cage for electrical excited synchronous 
           induction machines. At least the user has to specify the dampers
           resistance and stray inductance in d-axis; if he omits the
           parameters of the q-axis, the same values as for the d.axis 
           are used, assuming a symmetrical damper.</td> </tr>
  <tr><td colspan=\"2\"><b>Modelica.Electrical.Machines.Examples.</b></td></tr>
  <tr><td> SMEE_Gen </td>
      <td> Test example 7: ElectricalExcitedSynchronousInductionMachine 
           as Generator</td> </tr>
  <tr><td> Utilities.TerminalBox</td>
      <td> Terminal box for three-phase induction machines to choose  
           either star (wye) ? or delta ? connection</td> </tr>

  <tr><td colspan=\"2\"><b>Modelica.Math.Matrices.</b></td></tr>
  <tr><td> equalityLeastSquares</td>
      <td> Solve a linear equality constrained least squares problem:<br>
          min|A*x-a|^2 subject to B*x=b</td> </tr>

  <tr><td colspan=\"2\"><b>Modelica.Mechanics.MultiBody.</b></td></tr>
  <tr><td> Parts.PointMass</td>
      <td> Point mass, i.e., body where inertia tensor is neglected.</td> </tr>
  <tr><td> Interfaces.FlangeWithBearing</td>
      <td> Connector consisting of 1-dim. rotational flange and its 
           3-dim. bearing frame.</td> </tr>
  <tr><td> Interfaces.FlangeWithBearingAdaptor</td>
      <td> Adaptor to allow direct connections to the sub-connectors 
           of FlangeWithBearing.</td> </tr>
  <tr><td> Types.SpecularCoefficient</td>
      <td> New type to define a specular coefficient.</td> </tr>
  <tr><td> Types.ShapeExtra</td>
      <td> New type to define the extra data for visual shape objects and to
           have a central place for the documentation of this data.</td> </tr>
 
  <tr><td colspan=\"2\"><b>Modelica.Mechanics.MultiBody.Examples.Elementary</b></td></tr>
  <tr><td> PointGravityWithPointMasses</td>
      <td> Example of two point masses in a central gravity field.</td> </tr>
 
  <tr><td colspan=\"2\"><b>Modelica.Mechanics.Rotational.</b></td></tr>
  <tr><td>UsersGuide</td>
      <td> A users guide has been added by using the documentation previously
           present in the package documentation of Rotational.</td> </tr>
  <tr><td>Sensors.PowerSensor</td>
      <td> New component to measure the energy flow between two connectors
           of the Rotational library.</td> </tr>
 
  <tr><td colspan=\"2\"><b>Modelica.Mechanics.Translational.</b></td></tr>
  <tr><td>Speed</td>
      <td> New component to move a translational flange 
           according to a reference speed</td> </tr>

  <tr><td colspan=\"2\"><b>Modelica.Media.Interfaces.PartialMedium.</b></td></tr>
  <tr><td>specificEnthalpy_pTX</td>
      <td> New function to compute specific enthalpy from pressure, temperature
           and mass fractions.</td> </tr>
  <tr><td>temperature_phX</td>
      <td> New function to compute temperature from pressure, specific enthalpy,
           and mass fractions.</td> </tr>

  <tr><td colspan=\"2\"><b>Modelica.Icons.</b></td></tr>
  <tr><td> SignalBus</td>
      <td> Icon for signal bus</td> </tr>
  <tr><td> SignalSubBus</td>
      <td> Icon for signal sub-bus</td> </tr>

  <tr><td colspan=\"2\"><b>Modelica.SIunits.</b></td></tr>
  <tr><td>UsersGuide</td>
      <td> A users guide has been added that describes unit handling.</td> </tr>
  <tr><td> Resistance<br>
           Conductance</td>
      <td> Attribute 'min=0' removed from these types.</td> </tr>
 
  <tr><td colspan=\"2\"><b>Modelica.Thermal.FluidHeatFlow.</b></td></tr>
  <tr><td> Components.Valve</td>
      <td> Simple controlled valve with either linear or 
           exponential characteristic.</td> </tr>
  <tr><td> Sources. IdealPump </td>
      <td> Simple ideal pump (resp. fan)  dependent on the shaft?s speed;
           pressure increase versus volume flow is defined as a linear 
           function. Torque * Speed = Pressure invrease * Volume flow 
           (without losses).</td> </tr>
  <tr><td> Examples.PumpAndValve </td>
      <td> Test example for valves.</td> </tr>
  <tr><td> Examples.PumpDropOut </td>
      <td> Drop out of 1 pump to test behavior of semiLinear.</td> </tr>
  <tr><td> Examples.ParallelPumpDropOut </td>
      <td> Drop out of 2 parallel pumps to test behavior of semiLinear.</td> </tr>
  <tr><td> Examples.OneMass </td>
      <td> Cooling of 1 hot mass to test behavior of semiLinear.</td> </tr>
  <tr><td> Examples.TwoMass </td>
      <td> Cooling of 2 hot masses to test behavior of semiLinear.</td> </tr>
</table> 
 
<p>
The following <b>components</b> have been improved:
</p>
 
<table border=\"1\" cellspacing=0 cellpadding=2>
  <tr><td colspan=\"2\"><b>Modelica.</b></td></tr>
  <tr><td> UsersGuide</td>
      <td> Users guide and package description of Modelica Standard Library improved.</td> </tr>
  <tr><td colspan=\"2\"><b>Modelica.Blocks.Interfaces.</b></td></tr>
  <tr><td> RealInput<br>
           BooleanInput<br>
           IntegerInput</td>
      <td> When dragging one of these connectors the width and height
           is a factor of 2 larger as a standard icon. Previously,
           these connectors have been dragged and then manually enlarged
           by a factor of 2 in the Modelica standard library.</td> </tr>

  <tr><td colspan=\"2\"><b>Modelica.Blocks.</b></td></tr>
  <tr><td> Continuous.*</td>
      <td> Initialization options added to all blocks
           (NoInit, SteadyState, InitialState, InitialOutput).
           New parameter limitsAtInit to switch off the limits
           of LimIntegrator or LimPID during initialization</td> </tr>
  <tr><td> Continuous.LimPID</td>
      <td> Option to select P, PI, PD, PID controller.
           Documentation significantly improved.</td> </tr>
  <tr><td> Nonlinear.Limiter<br>
           Nonlinear.VariableLimiter<br>
           Nonlinear.Deadzone</td>
      <td> New parameter limitsAtInit/deadZoneAtInit to switch off the limits
           or the dead zone during initialization</td> </tr>

  <tr><td colspan=\"2\"><b>Modelica.Electrical.Analog. </b></td></tr>
  <tr><td> Sources</td>
      <td> Icon improved (+/- added to voltage sources, arrow added to
           current sources).</td> </tr>

  <tr><td colspan=\"2\"><b>Modelica.Electrical.Analog.Semiconductors. </b></td></tr>
  <tr><td> Diode</td>
      <td> smooth() operator included to improve numerics.</td> </tr>

  <tr><td colspan=\"2\"><b>Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines. </b></td></tr>
  <tr><td> SM_PermanentMagnetDamperCage<br>
           SM_ElectricalExcitedDamperCage<br>
           SM_ReluctanceRotorDamperCage</td>
      <td> The user can choose \"DamperCage = false\" (default: true) 
           to remove all equations for the damper cage from the model.</td> </tr>
  <tr><td colspan=\"2\"><b>Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines. </b></td></tr>
  <tr><td> AIM_SlipRing</td>
      <td> Easier parameterization: if the user selects \"useTrunsRatio = false\" 
           (default: true, this is the same behavior as before), 
            parameter TurnsRatio is calculated internally from 
            Nominal stator voltage and Locked-rotor voltage.</td> </tr>
 
  <tr><td colspan=\"2\"><b>Modelica.Math.Matrices.</b></td></tr>
  <tr><td>leastSquares</td>
      <td>The A matrix in the least squares problem might be rank deficient.
          Previously, it was required that A has full rank.</td>

  <tr><td colspan=\"2\"><b>Modelica.Mechanics.MultiBody.</b></td></tr>
  <tr><td>all models</td>
      <td> <ul> 
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

  <tr><td>Frames.resolveRelative</td>
      <td> The derivative of this function added as function and defined via
           an annotation. In certain situations, tools had previously
           difficulties to differentiate the inlined function automatically.</td>


  <tr><td>Forces.*</td>
      <td> The scaling factors N_to_m and Nm_to_m have no longer a default
           value of 1000 but a default value of world.defaultN_to_m (=1000) 
           and world.defaultNm_to_m (=1000). This allows to change the
           scaling factors for all forces and torques in the world
           object.</td>
  <tr><td>Interfaces.Frame.a<br>
          Interfaces.Frame.b<br>
          Interfaces.Frame_resolve</td>
      <td> The Frame connectors are now centered around the origin to ease
           the usage. The shape was changed, such that the icon is a factor
           of 1.6 larger as a standard icon (previously, the icon had a 
           standard size when dragged and then the icon was manually enlarged
           by a factor of 1.5 in the y-direction in the MultiBody library;
           the height of 16 allows easy positioning on the standard grid size of 2).
           The double line width of the border in icon and diagram layer was changed
           to a single line width and when making a connection the connection
           line is dark grey and no longer black which looks better.</td>
  <tr><td>Joints.Assemblies.*</td>
      <td> When dragging an assembly joint, the icon is a factor of 2
           larger as a standard icon. Icon texts and connectors have a 
           standard size in this enlarged icon (and are not a factor of 2
           larger as previously). </td>
  <tr><td>Types.*</td>
      <td> All types have a corresponding icon now to visualize the content
           in the package browser (previously, the types did not have an icon).</td>
 
  <tr><td colspan=\"2\"><b>Modelica.Mechanics.Rotational.</b></td></tr>
  <tr><td> Inertia</td>
      <td> Initialization and state selection added.</td> </tr>
  <tr><td> SpringDamper</td>
      <td> Initialization and state selection added.</td> </tr>
  <tr><td> Move</td>
      <td> New implementation based solely on Modelica 2.2 language
           (previously, the Dymola specific constrain(..) function was used).</td> </tr>

  <tr><td colspan=\"2\"><b>Modelica.Mechanics.Translational.</b></td></tr>
  <tr><td> Move</td>
      <td> New implementation based solely on Modelica 2.2 language
           (previously, the Dymola specific constrain(..) function was used).</td> </tr>

  <tr><td colspan=\"2\"><b>Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.</b></td></tr>
  <tr><td> SimpleFriction</td>
      <td> Calculates friction losses from pressure drop and volume flow.</td> </tr>
  <tr><td colspan=\"2\"><b>Modelica.Thermal.FluidHeatFlow.Components.</b></td></tr>
  <tr><td> IsolatedPipe <br>
           HeatedPipe</td>
      <td> Added geodetic height as a source of pressure change;
           feeds friction losses as calculated by simple friction to  
           the energy balance of the medium.</td> </tr>
  <tr><td colspan=\"2\"><b>Modelica.Media.Interfaces.PartialMedium.FluidConstants.</b></td></tr>
  <tr><td>HCRIT0</td><td>Critical specifc enthalpy of the fundamental
          equation (base formulation of the fluid medium model). </td></tr>
  <tr><td>SCRIT0</td><td>Critical specifc entropy of the fundamental
          equation (base formulation of the fluid medium model). </td></tr>
  <tr><td>deltah</td><td>Enthalpy offset (default: 0) between the
          specific enthalpy of the fluid model and the user-visible
          specific enthalpy in the model: deltah = h_model - h_fundamentalEquation.
</td></tr>
  <tr><td>deltas</td><td>Entropy offset (default: 0) between the
          specific entropy of the fluid model and the user-visible
          specific entropy in the model: deltas = s_model - s_fundamentalEquation.</td></tr>
  <tr><td>T_default</td><td>Default value for temperature of medium (for initialization)</td></tr>
  <tr><td>h_default</td><td>Default value for specific enthalpy of medium (for initialization)</td></tr>
  <tr><td>p_default</td><td>Default value for pressure of medium (for initialization)</td></tr>
  <tr><td>X_default</td><td>Default value for mass fractions of medium (for initialization)</td></tr>
</table> 
<p>
The following <b>errors</b> have been fixed:
</p>
 
<table border=\"1\" cellspacing=0 cellpadding=2>
  <tr><td colspan=\"2\"><b>Modelica.Blocks.Tables.</b></td></tr>
  <tr><td>CombiTable1D<br>
          CombiTable1Ds<br>
          CombiTable2D</td>
      <td> Parameter \"tableOnFile\" determines now whether a table is read from
           file or used from parameter \"table\". Previously, if \"fileName\" was not
           \"NoName\", a table was always read from file \"fileName\", independently
           of the setting of \"tableOnFile\". This has been corrected.<br>
           Furthermore, the initialization of a table is now performed in a 
           when-clause and no longer in a parameter declaration, because some
           tools evaluate the parameter declaration in some situation more than
           once and then the table is unnecessarily read several times    
           (and occupies also more memory).</td> </tr>

  <tr><td colspan=\"2\"><b>Modelica.Blocks.Sources.</b></td></tr>
  <tr><td>CombiTimeTable</td>
      <td> Same bug fix/improvement as for the tables from Modelica.Blocks.Tables 
           as outlined above.</td> </tr>

  <tr><td colspan=\"2\"><b>Modelica.Electrical.Analog.Semiconductors. </b></td></tr>
  <tr><td> PMOS<br>
           NMOS<br>
           HeatingPMOS<br>
           HeatingNMOS</td>
      <td> The Drain-Source-Resistance RDS had actually a resistance of
           RDS/v, with v=Beta*(W+dW)/(L+dL). The correct formula is without
           the divison by \"v\". This has now been corrected.<br>
           This bug fix should not have an essential effect in most applications.
           In the default case (Beta=1e-5), the Drain-Source-Resistance was
           a factor of 1e5 too large and had in the default case the
           wrong value 1e12, although it should have the value 1e7. The effect
           was that this resistance had practically no effect.</td> </tr>

  <tr><td colspan=\"2\"> <b>Modelica.Media.IdealGases.Common.SingleGasNasa.</b></td></tr>
  <tr><td> dynamicViscosityLowPressure</td>
      <td> Viscosity and thermal conductivity (which needs viscosity as input) 
           were computed wrong for polar gases and gas mixtures 
           (i.e. if dipole moment not 0.0). This has been fixed in version 2.2.1.</td> </tr>
  <tr><td colspan=\"2\"><b>Modelica.Utilities.Streams.</b></td></tr>
  <tr><td>readLine</td>
      <td> Depending on the C-implementation, the stream was not correctly closed.
           This has been corrected by adding a \"Streams.close(..)\" 
           after reading the file content.</td> </tr>

</table>                                 
</html>
"));
  end Version_2_2_1;
    
  class Version_2_2 "Version 2.2" 
      
      annotation (Documentation(info=
                               "<html>
<h3><font color=\"#008000\">Version 2.2 (April 6, 2005)</font></h3>
<p>
Version 2.2 is backward compatible to version 2.1.
</p>
The following <b>new libraries</b> have been added:
</p>
<table border=\"1\" cellspacing=0 cellpadding=2>
  <tr><td><a href=\"Modelica://Modelica.Media\">Modelica.Media</a></td>
      <td> Property models of liquids and gases, especially
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
  <tr><td><a href=\"Modelica://Modelica.Thermal.FluidHeatFlow\">Modelica.Thermal.FluidHeatFlow</a></td>
      <td> Simple components for 1-dim., incompressible thermo-fluid flow 
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
    
  class Version_2_1 "Version 2.1" 
      annotation (Documentation(info=
                               "<html>
<h3><font color=\"#008000\">Version 2.1 (November 11, 2004)</font></h3>
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
  <tr><td><a href=\"Modelica://Modelica.Electrical.Digital\">Modelica.Electrical.Digital</a></td>
      <td>Digital electrical components based on 2-,3-,4-, and 9-valued logic<br>
          according to the VHDL standard</td><tr>
  <tr><td><a href=\"Modelica://Modelica.Electrical.Machines\">Modelica.Electrical.Machines</a></td>
      <td>Asynchronous, synchronous and DC motor and generator models</td><tr>
  <tr><td><a href=\"Modelica://Modelica.Math.Matrices\">Modelica.Math.Matrices</a></td>
      <td>Functions operatinng on matrices such as solve() (A*x=b), leastSquares(),<br>
          norm(), LU(), QR(),  eigenValues(), singularValues(), exp(), ...</td><tr>
  <tr><td><a href=\"Modelica://Modelica.StateGraph\">Modelica.StateGraph</a></td>
      <td> Modeling of <b>discrete event</b> and <b>reactive</b> systems in a convenient way using<br>
           <b>hierarchical state machines</b> and <b>Modelica</b> as <b>action language</b>. <br>
           It is based on JGraphChart and Grafcet and  has a similar modeling power as <br>
           StateCharts. It avoids deficiences of usually used action languages. <br>
           This library makes the ModelicaAdditions.PetriNets library obsolet.</td></tr>
  <tr><td><a href=\"Modelica://Modelica.Utilities.Files\">Modelica.Utilities.Files</a></td>
      <td>Functions to operate on files and directories (copy, move, remove files etc.)</td></tr>
  <tr><td><a href=\"Modelica://Modelica.Utilities.Streams\">Modelica.Utilities.Streams</a></td>
      <td>Read from files and write to files (print, readLine, readFile, error, ...)</td></tr>
  <tr><td><a href=\"Modelica://Modelica.Utilities.Strings\">Modelica.Utilities.Strings</a></td>
      <td>Operations on strings (substring, find, replace, sort, scanToken, ...)</td></tr>
  <tr><td><a href=\"Modelica://Modelica.Utilities.System\">Modelica.Utilities.System</a></td>
      <td>Get/set current directory, get/set environment variable, execute shell command, etc.</td></tr>
</table>
<p>
The following existing libraries outside of the Modelica standard library
have been improved and added as <b>new libraries</b>
(models using the previous libraries are automatically converted
to the new sublibraries inside package Modelica):
</p>
<table border=\"1\" cellspacing=0 cellpadding=2>
  <tr><td><a href=\"Modelica://Modelica.Blocks.Discrete\">Modelica.Blocks.Discrete</a></td>
      <td> Discrete input/output blocks with fixed sample period<br>
           (from ModelicaAdditions.Blocks.Discrete)</td></tr>
  <tr><td><a href=\"Modelica://Modelica.Blocks.Logical\">Modelica.Blocks.Logical</a></td>
      <td> Logical components with Boolean input and output signals<br>
           (from ModelicaAdditions.Blocks.Logical)</td></tr>
  <tr><td><a href=\"Modelica://Modelica.Blocks.Nonlinear\">Modelica.Blocks.Nonlinear</a></td>
      <td> Discontinuous or non-differentiable algebraic control blocks such as variable limiter,<br>
           fixed, variable and Pade delay etc. (from ModelicaAdditions.Blocks.Nonlinear)</td></tr>
  <tr><td><a href=\"Modelica://Modelica.Blocks.Routing\">Modelica.Blocks.Routing</a></td>
      <td> Blocks to combine and extract signals, such as multiplexer<br>
           (from ModelicaAdditions.Blocks.Multiplexer)</td></tr>
  <tr><td><a href=\"Modelica://Modelica.Blocks.Tables\">Modelica.Blocks.Tables</a></td>
      <td> One and two-dimensional interpolation in tables. CombiTimeTable is available<br>
           in Modelica.Blocks.Sources (from ModelicaAdditions.Tables)</td></tr>
  <tr><td><a href=\"Modelica://Modelica.Mechanics.MultiBody\">Modelica.Mechanics.MultiBody</a></td>
      <td> Components to model the movement of 3-dimensional mechanical systems. Contains <br>
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
  <tr><td>Pre</td>
      <td>y = pre(u): Breaks algebraic loops by an infinitesimal small <br>
          time delay (event iteration continues until u = pre(u))</td></tr>
  <tr><td>Edge</td>
      <td>y = edge(u): Output y is true, if the input u has a rising edge </td></tr>
  <tr><td>FallingEdge</td>
      <td>y = edge(not u): Output y is true, if the input u has a falling edge </td></tr>
  <tr><td>Change</td>
      <td>y = change(u): Output y is true, if the input u has a rising or falling edge </td></tr>
  <tr><td>GreaterEqual</td>
      <td>Output y is true, if input u1 is greater or equal as input u2 </td></tr>
  <tr><td>Less</td>
      <td>Output y is true, if input u1 is less as input u2 </td></tr>
  <tr><td>LessEqual</td>
      <td>Output y is true, if input u1 is less or equal as input u2 </td></tr>
  <tr><td>Timer</td>
      <td>Timer measuring the time from the time instant where the <br>
          Boolean input became true </td></tr>
  <tr><td colspan=\"2\"><b>Modelica.Blocks.Math.</b></td></tr>
  <tr><td>BooleanToReal</td>
      <td>Convert Boolean to Real signal</td></tr>
  <tr><td>BooleanToInteger</td>
      <td>Convert Boolean to Integer signal</td></tr>
  <tr><td>RealToBoolean</td>
      <td>Convert Real to Boolean signal</td></tr>
  <tr><td>IntegerToBoolean</td>
      <td>Convert Integer to Boolean signal</td></tr>
  <tr><td colspan=\"2\"><b>Modelica.Blocks.Sources.</b></td></tr>
  <tr><td>RealExpression</td>
      <td>Set output signal to a time varying Real expression</td></tr>
  <tr><td>IntegerExpression</td>
      <td>Set output signal to a time varying Integer expression</td></tr>
  <tr><td>BooleanExpression</td>
      <td>Set output signal to a time varying Boolean expression</td></tr>
  <tr><td>BooleanTable</td>
      <td>Generate a Boolean output signal based on a vector of time instants</td></tr>
  <tr><td colspan=\"2\"><b>Modelica.Mechanics.MultiBody.</b></td></tr>
  <tr><td>Frames.from_T2</td>
      <td>Return orientation object R from transformation matrix T and its derivative der(T)</td></tr>
  <tr><td colspan=\"2\"><b>Modelica.Mechanics.Rotational.</b></td></tr>
  <tr><td>LinearSpeedDependentTorque</td>
      <td>Linear dependency of torque versus speed (acts as load torque)</td></tr>
  <tr><td>QuadraticSpeedDependentTorque</td>
      <td>Quadratic dependency of torque versus speed (acts as load torque)</td></tr>
  <tr><td>ConstantTorque</td>
      <td>Constant torque, not dependent on speed (acts as load torque)</td></tr>
  <tr><td>ConstantSpeed</td>
      <td>Constant speed, not dependent on torque (acts as load torque)</td></tr>
  <tr><td>TorqueStep</td>
      <td>Constant torque, not dependent on speed (acts as load torque)</td></tr>
</table>
<p>
The following <b>bugs</b> have been <b>corrected</b>:
</p>
<table border=\"1\" cellspacing=0 cellpadding=2>
  <tr><td colspan=\"2\"><b>Modelica.Mechanics.MultiBody.Forces.</b></td></tr>
  <tr><td>LineForceWithMass<br>
          Spring</td>
      <td>If mass of the line force or spring component is not zero, the<br>
          mass was (implicitly) treated as \"mass*mass\" instead of as \"mass\"</td></tr>
  <tr><td colspan=\"2\"><b>Modelica.Mechanics.Rotational.</b></td></tr>
  <tr><td>Speed</td>
      <td>If parameter exact=<b>false</b>, the filter was wrong<br>
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
    
  class Version_1_6 "Version 1.6" 
      annotation (Documentation(info=
                               "<html>
<h3><font color=\"#008000\">Version 1.6 (June 21, 2004)</font></h3>
<p> Added 1 new library (Electrical.MultiPhase), 17 new components, 
    improved 3 existing components
    in the Modelica.Electrical library and improved 3 types
    in the Modelica.SIunits library. Furthermore,
    this Users Guide has been started. The improvements
    in more detail:
</p>
<p>
<b>New components</b>
</p>
<table border=\"1\" cellspacing=0 cellpadding=2>
  <tr><td colspan=\"2\"><b>Modelica.Electrical.Analog.Basic.</b></td></tr>
  <tr><td>SaturatingInductor</td>
      <td>Simple model of an inductor with saturation</td></tr>
  <tr><td>VariableResistor</td>
      <td>Ideal linear electrical resistor with variable resistance</td></tr>
  <tr><td>VariableConductor</td>
      <td>Ideal linear electrical conductor with variable conductance</td></tr>
  <tr><td>VariableCapacitor</td>
      <td>Ideal linear electrical capacitor with variable capacitance</td></tr>
  <tr><td>VariableInductor</td>
      <td>Ideal linear electrical inductor with variable inductance</td></tr>
  <tr><td colspan=\"2\"><b>Modelica.Electrical.Analog.Semiconductors.</b></td></tr>
  <tr><td>HeadingDiode</td>
      <td>Simple diode with heating port</td></tr>
  <tr><td>HeadingNMOS</td>
      <td>Simple MOS Transistor with heating port</td></tr>
  <tr><td>HeadingPMOS</td>
      <td>Simple PMOS Transistor with heating port</td></tr>
  <tr><td>HeadingNPN</td>
      <td>Simple NPN BJT according to Ebers-Moll with heating port</td></tr>
  <tr><td>HeadingPNP</td>
      <td>Simple PNP BJT according to Ebers-Moll with heating port</td></tr>
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
  <tr><td>Inductance</td>
      <td>min=0 removed</td></tr>
  <tr><td>SelfInductance</td>
      <td>min=0 added</td></tr>
  <tr><td>ThermodynamicTemperature</td>
      <td>min=0 added</td></tr>
</table>
</html>
"));
  end Version_1_6;
    
  class Version_1_5 "Version 1.5" 
      annotation (Documentation(info=
                               "<html>
<h3><font color=\"#008000\">Version 1.5 (December 16, 2002)</font></h3>
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
  <tr><td>Continuous.Der</td><td>Derivative of input (= analytic differentations)</td></tr>
  <tr><td><b><i>Examples</i></b></td><td>Demonstration examples of the components of this package</td></tr>
  <tr><td>Nonlinear.VariableLimiter</td><td>Limit the range of a signal with variable limits</td></tr>
  <tr><td colspan=\"2\"><b>Modelica.Blocks.Interfaces.</b></td></tr>
  <tr><td>RealPort</td><td>Real port (both input/output possible)</td></tr>
  <tr><td>IntegerPort</td><td>Integer port (both input/output possible)</td></tr>
  <tr><td>BooleanPort</td><td>Boolean port (both input/output possible)</td></tr>
  <tr><td>SIMO</td><td>Single Input Multiple Output continuous control block</td></tr>
  <tr><td>IntegerBlockIcon</td><td>Basic graphical layout of Integer block</td></tr>
  <tr><td>IntegerMO</td><td>Multiple Integer Output continuous control block</td></tr>
  <tr><td>IntegerSignalSource</td><td>Base class for continuous Integer signal source</td></tr>
  <tr><td>IntegerMIBooleanMOs</td><td>Multiple Integer Input Multiple Boolean Output continuous control block with same number of inputs and outputs</td></tr>
  <tr><td>BooleanMIMOs</td><td>Multiple Input Multiple Output continuous control block with same number of inputs and outputs of boolean type</td></tr>
  <tr><td><b><i>BusAdaptors</i></b></td><td>Components to send signals to the bus or receive signals from the bus</td></tr>
  <tr><td colspan=\"2\"><b>Modelica.Blocks.Math.</b></td></tr>
  <tr><td>RealToInteger</td><td>Convert real to integer signals</td></tr>
  <tr><td>IntegerToReal</td><td>Convert integer to real signals</td></tr>
  <tr><td>Max</td><td>Pass through the largest signal</td></tr>
  <tr><td>Min</td><td>Pass through the smallest signal</td></tr>
  <tr><td>Edge</td><td>Indicates rising edge of boolean signal</td></tr>
  <tr><td>BooleanChange</td><td>Indicates boolean signal changing</td></tr>
  <tr><td>IntegerChange</td><td>Indicates integer signal changing</td></tr>
  <tr><td colspan=\"2\"><b>Modelica.Blocks.Sources.</b></td></tr>
  <tr><td>IntegerConstant</td><td>Generate constant signals of type Integer</td></tr>
  <tr><td>IntegerStep</td><td>Generate step signals of type Integer</td></tr>
  <tr><td colspan=\"2\"><b>Modelica.Electrical.Analog.Basic.</b></td></tr>
  <tr><td>HeatingResistor</td><td>Temperature dependent electrical resistor</td></tr>
  <tr><td>OpAmp</td><td>Simple nonideal model of an OpAmp with limitation</td></tr>
  <tr><td colspan=\"2\"><b>Modelica.Electrical.Analog.Ideal.</b></td></tr>
  <tr><td>IdealCommutingSwitch</td><td>Ideal commuting switch</td></tr>
  <tr><td>IdealIntermediateSwitch</td><td>Ideal intermediate switch</td></tr>
  <tr><td>ControlledIdealCommutingSwitch</td><td>Controlled ideal commuting switch</td></tr>
  <tr><td>ControlledIdealIntermediateSwitch</td><td>Controlled ideal intermediate switch</td></tr>
  <tr><td>IdealOpAmpLimited</td><td>Ideal operational amplifier with limitation</td></tr>
  <tr><td>IdealOpeningSwitch</td><td>Ideal opener</td></tr>
  <tr><td>IdealClosingSwitch</td><td>Ideal closer</td></tr>
  <tr><td>ControlledIdealOpeningSwitch</td><td>Controlled ideal opener</td></tr>
  <tr><td>ControlledIdealClosingSwitch</td><td>Controlled ideal closer</td></tr>
  
  <tr><td colspan=\"2\"><b>Modelica.Electrical.Analog.Lines.</b></td></tr>
  <tr><td>TLine1</td><td>Lossless transmission line (Z0, TD)</td></tr>
  <tr><td>TLine2</td><td>Lossless transmission line (Z0, F, NL)</td></tr>
  <tr><td>TLine2</td><td>Lossless transmission line (Z0, F)</td></tr>
  <tr><td colspan=\"2\"><b>Modelica.Icons.</b></td></tr>
  <tr><td>Function</td><td>Icon for a function</td></tr>
  <tr><td>Record</td><td>Icon for a record</td></tr>
  <tr><td>Enumeration</td><td>Icon for an enumeration</td></tr>
  <tr><td colspan=\"2\"><b>Modelica.Math.</b></td></tr>
  <tr><td>tempInterpol2</td><td>temporary routine for vectorized linear interpolation (will be removed)</td></tr>
  <tr><td colspan=\"2\"><b>Modelica.Mechanics.Rotational.</b></td></tr>
  <tr><td>Examples.LossyGearDemo1</td><td>Example to show that gear efficiency may lead to stuck motion</td></tr>
  <tr><td>Examples.LossyGearDemo2</td><td>Example to show combination of LossyGear and BearingFriction</td></tr>
  <tr><td>LossyGear</td><td>Gear with mesh efficiency and bearing friction (stuck/rolling possible)</td></tr>
  <tr><td>Gear2</td><td>Realistic model of a gearbox (based on LossyGear)</td></tr>
  <tr><td colspan=\"2\"><b>Modelica.SIunits.</b></td></tr>
  <tr><td><b><i>Conversions</i></b></td><td>Conversion functions to/from non SI units and type definitions of non SI units</td></tr>
  <tr><td>EnergyFlowRate</td><td>Same definition as <i>Power</i></td></tr>
  <tr><td>EnthalpyFlowRate</td><td><tt>Real (final quantity=\"EnthalpyFlowRate\", final unit=\"W\")</tt></td></tr>
  <tr><td colspan=\"2\"><b>Modelica.</b></td></tr>
  <tr><td><b><i>Thermal.HeatTransfer</i></b></td><td>1-dimensional heat transfer with lumped elements</td></tr>
  <tr><td colspan=\"2\"><b>ModelicaAdditions.Blocks.Discrete.</b></td></tr>
  <tr><td>TriggeredSampler</td><td>Triggered sampling of continuous signals</td></tr>
  <tr><td>TriggeredMax</td><td>Compute maximum, absolute value of continuous signal at trigger instants</td></tr>
  <tr><td colspan=\"2\"><b>ModelicaAdditions.Blocks.Logical.Interfaces.</b></td></tr>
  <tr><td>BooleanMIRealMOs</td><td>Multiple Boolean Input Multiple Real Output continuous control block with same number of inputs and outputs</td></tr>
  <tr><td>RealMIBooleanMOs</td><td>Multiple Real Input Multiple Boolean Output continuous control block with same number of inputs and outputs</td></tr>
  <tr><td colspan=\"2\"><b>ModelicaAdditions.Blocks.Logical.</b></td></tr>
  <tr><td>TriggeredTrapezoid</td><td>Triggered trapezoid generator</td></tr>
  <tr><td>Hysteresis</td><td>Transform Real to Boolean with Hysteresis</td></tr>
  <tr><td>OnOffController</td><td>On-off controller</td></tr>
  <tr><td>Compare</td><td>True, if signal of inPort1 is larger than signal of inPort2</td></tr>
  <tr><td>ZeroCrossing</td><td>Trigger zero crossing of input signal</td></tr>
  <tr><td colspan=\"2\"><b>ModelicaAdditions.</b></td></tr>
  <tr><td>Blocks.Multiplexer.Extractor</td><td>Extract scalar signal out of signal vector dependent on IntegerRealInput index</td></tr>
  <tr><td>Tables.CombiTable1Ds</td><td>Table look-up in one dimension (matrix/file) with only single input</td></tr>
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
<p><i>Modelica.Mechanics.Rotational.RelativeStates/i></p>
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
    
  class Version_1_4 "Version 1.4" 
  annotation (Documentation(info="<html>
<h3><font color=\"#008000\">Version 1.4.1 (June 28, 2001)</font></h3>
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
<h3><font color=\"#008000\">Version 1.4.1beta1 (February 12, 2001)</font></h3>
<p> Adapted to Modelica 1.4</p>
<hr>
<h3><font color=\"#008000\">Version 1.3.2beta2 (June 20, 2000)</font></h3>
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
      </li></ul>
</li>
</ul>
<hr>
<h3><font color=\"#008000\">Version 1.3.1 (Dec. 13, 1999)</font></h3>
<p>
First official release of the library.
</p>
</html>
"));
  end Version_1_4;
  end ReleaseNotes;
  
  class Contact "Contact" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>Contact</font></h3>
<dl>
<dt>The development of the Modelica package is organized by<br>&nbsp;</dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik<br> 
    Abteilung f&uuml;r Entwurfsorientierte Regelungstechnik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br></dd>
</dl>
<p>
This library is developed by several people from
the Modelica Association, see
<a href=\"http://www.Modelica.org\">http://www.Modelica.org</a>.
In particular, the following people have directly contributed
(many more people have contributed to the design):
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Peter Beater</b> </td
      <td> University of Paderborn, Germany</td>
      <td> Modelica.Mechanics.Translational </td>
  </tr>
  <tr><td><b>Dag Br&uuml;ck</b> </td
      <td> Dynasim AB, Lund, Sweden</td>
      <td> Modelica.Utilities</td>
  </tr>

  <tr><td><b>Francesco Casella</b> </td
      <td> Politecnico di Milano, Milano, Italy</td>
      <td> Modelica.Media</td>
  </tr>

  <tr><td><b>Christoph Clauss</b> </td
      <td> Fraunhofer Institute for Integrated Circuits,<br> Dresden, Germany</td>
      <td> Modelica.Electrical.Analog<br> 
           Modelica.Electrical.Digital</td>
  </tr>

  <tr><td><b>Jonas Eborn</b> </td
      <td> Modelon AB, Lund, Sweden</td>
      <td> Modelica.Media</td>
  </tr>

  <tr><td><b>Hilding Elmqvist</b> </td
      <td> Dynasim AB, Lund, Sweden</td>
      <td> Modelica.Mechanics.MultiBody<br>
           Modelica.Media<br>
           Modelica.StateGraph<br>
           Modelica.Utilities<br>
           Conversion from 1.6 to 2.0</td>
  </tr>

  <tr><td><b>R&uuml;diger Franke</b> </td
      <td> ABB Corporate Research,<br>Ladenburg, German</td>
      <td> Modelica.Media</td>
  </tr>

  <tr><td><b>Anton Haumer</b> </td
      <td> Consultant, St.Andrae-Woerdern,<br>Austria</td>
      <td> Modelica.Electrical.Machines<br>
           Modelica.Electrical.Multiphase<br>
           Modelica.Mechanics.Rotational<br>
           Modelica.Thermal.FluidHeatFlow</td>
  </tr>

  <tr><td><b>Hans-Dieter Joos</b> </td
      <td> Institute of Robotics and Mechatronics<br>
           DLR, German Aerospace Center, <br>
           Oberpfaffenhofen, Germany</td>
      <td> Modelica.Math.Matrices</td>
  </tr>

  <tr><td><b>Christian Kral</b> </td
      <td> arsenal research, Vienna, Austria</td>
      <td> Modelica.Electrical.Machines<br>
           Modelica.Thermal.FluidHeatFlow</td>
  </tr>

  <tr><td><b>Sven Erik Mattsson</b> </td
      <td> Dynasim AB, Lund, Sweden</td>
      <td> Modelica.Mechanics.MultiBody</td>
  </tr>
  <tr><td><b>Hans Olsson</b> </td
      <td> Dynasim AB, Lund, Sweden</td>
      <td> Modelica.Blocks<br>
           Modelica.Math.Matrices<br>
           Modelica.Utilities<br>
           Conversion from 1.6 to 2.0</td>
  </tr>
  <tr><td><b>Martin Otter</b> </td
      <td> Institute of Robotics and Mechatronics<br>
           DLR, German Aerospace Center, <br>
           Oberpfaffenhofen, Germany</td>
      <td> Modelica.Blocks<br> 
           Modelica.Mechanics.MultiBody<br>
           Modelica.Mechanics.Rotational<br>
           Modelica.Math<br>
           Modelica.Media<br>
           Modelica.SIunits<br>
           Modelica.StateGraph<br>
           Modelica.Thermal<br>
           Modelica.Utilities<br>
           ModelicaReference<br>
           Conversion from 1.6 to 2.0</td>
  </tr>

  <tr><td><b>Katrin Pr&ouml;l&szlig;</b> </td
      <td> Department of Technical Thermodynamics,<br>
           Technical University Hamburg-Harburg,<br>Germany</td>
      <td> Modelica.Media</td>
  </tr>

  <tr><td><b>Christoph C. Richter</b> </td
      <td> Institut für Thermodynamik, <br>
           Technische Universit&auml;t Braunschweig, <br>
           Germany</td>
      <td> Modelica.Media</td>
  </tr>

  <tr><td><b>Andr&eacute; Schneider</b> </td
      <td> Fraunhofer Institute for Integrated Circuits,<br> Dresden, Germany</td>
      <td> Modelica.Electrical.Analog<br> 
           Modelica.Electrical.Digital</td>
  </tr>
  <tr><td><b>Christian Schweiger</b> </td
      <td> Institute of Robotics and Mechatronics,<br>
           DLR, German Aerospace Center,<br> 
           Oberpfaffenhofen, Germany</td>
      <td> Modelica.Mechanics.Rotational<br>
           ModelicaReference<br>
           Conversion from 1.6 to 2.0</td>
  </tr>
  <tr><td><b>Michael Tiller</b> </td
      <td> Emmeskay, Inc., Dearborn, MI, U.S.A, <br>
           (previously Ford Motor Company, Dearborn) </td>
      <td> Modelica.Media<br>
           Modelica.Thermal</td>
  </tr>
  <tr><td><b>Hubertus Tummescheit</b> </td
      <td> Modelon AB, Lund, Sweden </td>
      <td> Modelica.Media<br>
           Modelica.Thermal</td>
  </tr>
  <tr><td><b>Nico Walter</b> </td
      <td> Master thesis at HTWK Leipzig<br>
           (Prof. R. M&uuml;ller) and<br>
           DLR Oberpfaffenhofen, Germany</td>
      <td> Modelica.Math.Matrices</td>
  </tr>
</table>
</html>
"));
    
  end Contact;
  
  class ModelicaLicense "Modelica License" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>The Modelica License 
(Version 1.1 of June 30, 2000) </font></h3>
<p>Redistribution and use in source and binary forms, with or without
modification are permitted, provided that the following conditions are met:
<ol>
<li>
The author and copyright notices in the source files, these license conditions
and the disclaimer below are (a) retained and (b) reproduced in the documentation
provided with the distribution.</li>
<li>
Modifications of the original source files are allowed, provided that a
prominent notice is inserted in each changed file and the accompanying
documentation, stating how and when the file was modified, and provided
that the conditions under (1) are met.</li>
<li>
It is not allowed to charge a fee for the original version or a modified
version of the software, besides a reasonable fee for distribution and support.
Distribution in aggregate with other (possibly commercial) programs
as part of a larger (possibly commercial) software distribution is permitted,
provided that it is not advertised as a product of your own.</li>
</ol>
<h4><font color=\"#008000\">Disclaimer</font></h4>
<p>The software (sources, binaries, etc.) in their original or in a modified
form are provided
\"as is\" and the copyright holders assume no responsibility for its contents
what so ever. Any express or implied warranties, including, but not
limited to, the implied warranties of merchantability and fitness for a
particular purpose are <b>disclaimed</b>. <b>In no event</b> shall the
copyright holders, or any party who modify and/or redistribute the package,
<b>be liable</b> for any direct, indirect, incidental, special, exemplary, or
consequential damages, arising in any way out of the use of this software,
even if advised of the possibility of such damage.
</p>
</html>
"));
    
  end ModelicaLicense;
end UsersGuide;
end Modelica;
