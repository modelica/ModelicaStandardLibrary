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
  version="2.1 Beta1",
  versionDate="2004-07-07",
  conversion(
    from(version="1.6", script="Scripts/ConvertToModelica_2.1.mos")),
  Settings(NewStateSelection=true),
  Documentation(info="<HTML>
<p>
Package <b>Modelica</b> is a <b>standardized</b> and <b>pre-defined</b> package
that is developed together with the Modelica language from the
Modelica Association, see
<a href=\"http://www.Modelica.org\">http://www.Modelica.org</a>.
It is also called <b>Modelica Standard Library</b>.
It provides constants, types, connectors, partial models and model
components
in various disciplines.
</p>
<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"Modelica://Modelica.UsersGuide\">Modelica.UsersGuide</a>
     discusses the most important aspects of this library.</li>
<li><a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes\">Release Notes</a>
    summarizes the changes of new versions of this package.</li>
<li> Packages <b>Examples</b> in the various subpackages, provide
     demos of the corresponding subpackage.</li>
</ul>
<p>
The Modelica package consists currently of the following subpackages
</p>
<pre>
   <b>Blocks</b>      Input/output blocks.
   <b>Constants</b>   Mathematical and physical constants (pi, eps, h, ...)
   <b>Electrical</b>  Electric and electronic components
               (Analog, Digital, Machines, MultiPhase)
   <b>Icons</b>       Icon definitions of general interest
   <b>Math</b>        Mathematical functions 
               (such as sin, cos, solve, eigenValues)
   <b>Mechanics</b>   Mechanical components 
               (1D-rotational, 1D-translational, 3D multi-body)
   <b>SIunits</b>     SI-unit type definitions (such as Voltage, Torque)
   <b>StateGraph</b>  Hierarchical state machines (similiar power as StateCharts)
   <b>Thermal</b>     Thermal components
               (1-D heat transfer with lumped elements)
   <b>Utilities</b>   Utility functions especially for scripting 
               (Files, Streams, Strings, System)
</pre>
<p>
Copyright &copy; 1998-2004, Modelica Association.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
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
This package contains the <b>users guide</b> for 
the library and has the following content
(this users guide will be improved in the future):
</p>
<ol>
<li><a href=\"Modelica://Modelica.UsersGuide.OverView\">Overview of library</a>
     gives an overview of the library.</li>
<li><a href=\"Modelica://Modelica.UsersGuide.ReleaseNotes\">Release Notes</a>
    summarizes the differences between different versions of this library.</li>
<li><a href=\"Modelica://Modelica.UsersGuide.Contact\">Contact</a> 
    provides information about the authors of the library as well as
    acknowledgments.</li>
<li><a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">ModelicaLicense</a> 
    defines the license conditions for using this library.</li>
</ol>
</html>"));
  
  class OverView "Overview of library" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>Overview of Library Modelica</font></h3>

<p>
An overview of the Modelica Standard Library
will be given here.
</p>

<p>
<br><br><br>
</p>

<p>
In the Modelica package the following conventions are used:
</p>
<ul>
<li>
Class and instance names are written in upper and lower case
letters, e.g., \"ElectricCurrent\". An underscore is only used
at the end of a name to characterize a lower or upper index,
e.g., body_low_up.<br><br>
</li>
<li>
Type names start always with an upper case letter.
Instance names start always with a lower case letter with only
a few exceptions, such as \"T\" for a temperature instance,
if this is common sense.<br><br>
</li>
<li>
A package XXX has its interface definitions in subpackage
XXX.Interfaces, e.g., Electrical.Interfaces. <br><br>
</li>
<li>
Preferred instance names for connectors:
<pre>
  p,n: positive and negative side of a partial model.
  a,b: side \"a\" and side \"b\" of a partial model
       (= connectors are completely equivalent).
</pre>
</li>
</ul>

</html>
"));
  end OverView;
  
  class ReleaseNotes "Release notes" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>Release notes</font></h3>

<h3><font color=\"#008000\">Version 2.1 Beta1 (July 7, 2004)</font></h3>

<p> This is a major change with respect to previous versions of the
    Modelica Standard Library. The changes are not backward compatible.
    A script to automatically convert models to this new version is
    provided. There are cases, where this script does not convert
    correctly. In this case models have to be manually converted.
    In any case you should make a back-up copy of your model
    before automatic conversion is performed. 
    Note, conversion should work successfully for all models that
    are using components of the Modelica standard and ModelicaAdditions 
    library with the following exceptions:
</p>

<ul>
<li> Whenever an inPort or outPort connector has more than 1 signal,
     it is most likely that the conversion will fail. If a signal
     connector has only 1 signal (dimension n=1), the conversion should
     always be successful.</li>
<li> Conversion from ModelicaAdditions.MultiBody to Modelica.Mechanics.MultiBody
     is not completely defined.</li>
</ul>

<p>
    It is planned to improve the automatic conversion for the release version.   
    The major changes of Modelica 2.1 Beta1 with respect to Modelica 1.6 are:
</p>

<ul>
<li> Simplified the definition of the <b>signal connectors</b> in
     Modelica.Blocks.Interfaces. For example, an output signal
     \"FirstOrder.outPort.signal[1]\" is now named
     \"FirstOrder.y\". This simplifies the understanding and usage 
      especially for beginners.</li>
<li> De-vectorized the <b>Modelica.Blocks</b> library. All blocks in the
     Modelica.Blocks library are now scalar blocks. As a result,
     the parameters of the Blocks are scalars and no vectors any
     more. For example, a parameter \"amplitude\" that might had
     a value of \"{1}\" previously, has now a value of \"1\". This simplifies
     the understanding and usage especially for beginners.<br>
     If a vector of blocks is needed, this can be easily
     accomplished by adding a dimension to the instance.</li>
<li> All components of the <b>ModelicaAdditions</b> library are included
     in the Modelica Standard Library in an improved way:
     <ul>
     <li> ModelicaAdditions.Blocks is included in Modelica.Blocks.
          The logical blocks have a nicer icon layout now.</li>
     <li> ModelicaAdditions.Tables is included in Modelica.Blocks.Sources
          and Modelica.Blocks.Tables.</li>
     <li> ModelicaAdditions.MultiBody is obsolet and is replaced by the
          much more powerful library Modelica.Mechanics.MultiBody
          (this is version 1.0.1 of the MultiBody library where the
          signal connectors have been changed to the new signal connectors).
          </li>
     <li> ModelicaAdditions.HeatFlow1D is obsolet since a long time. It was
          replaced by the improved library Modelica.Thermal.HeatTransfer.</li>
     <li> ModelicaAdditions.PetriNets is obsolet and is replaced by the
          much more powerful library Modelica.StateGraph.</li> 
     </li>
     </ul>
<li> Added a new library <b>Modelica.StateGraph</b> to model <b>discrete event</b> 
     and <b>reactive</b> systems in a convenient way. It is based on the 
     JGraphChart method and takes advantage of Modelica features for
     the \"action\" language. JGraphChart is a further development of 
     Grafcet to include elements of StateCharts that are not present
     in Grafcet/Sequential Function Charts. Therefore, the StateGraph
     library has a similar modeling power as StateCharts but avoids
     some deficiences of action languages usually used together
     with StateCharts.</li>
</ul>

<p>
Additionally, the following 16 new components have been added:
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
</table>



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


<h3><font color=\"#008000\">Version 1.4.1beta1 (February 12, 2001)</font></h3>

<p> Adapted to Modelica 1.4</p>


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


<h3><font color=\"#008000\">Version 1.3.1 (Dec. 13, 1999)</font></h3>

<p>
First official release of the library.
</p>

</html>
"));
  equation 
    
  end ReleaseNotes;
  
  class Contact "Contact" 
    
    annotation (Documentation(info="<html>
<h3><font color=\"#008000\" size=5>Contact</font></h3>

<dl>
<dt>The development of the Modelica package is organized by</dt>
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
In particular, the following people have contributed:
</p>


<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Peter Beater</b> </td
      <td> University of Paderborn, Germany</td>
      <td> Modelica.Mechanics.Translational </td>
  </tr>

  <tr><td><b>Christoph Clau&szlig;</b> </td
      <td> Fraunhofer Institute for Integrated Circuits, Dresden, Germany</td>
      <td> Modelica.Electrical </td>
  </tr>

  <tr><td><b>Anton Haumer</b> </td
      <td> Consultant, St.Andrae-Woerdern, Austria</td>
      <td> Modelica.Electrical </td>
  </tr>

  <tr><td><b>Martin Otter</b> </td
      <td> DLR, German Aerospace Center, Oberpfaffenhofen, Germany</td>
      <td> Modelica.Blocks<br> 
           Modelica.Mechanics.Rotational<br>
           Modelica.Math<br>
           Modelica.SIunits<br>
           Modelica.Thermal</td>
  </tr>

  <tr><td><b>Andr&eacute; Schneider</b> </td
      <td> Fraunhofer Institute for Integrated Circuits, Dresden, Germany</td>
      <td> Modelica.Electrical </td>
  </tr>

  <tr><td><b>Christian Schweiger</b> </td
      <td> DLR, German Aerospace Center, Oberpfaffenhofen, Germany</td>
      <td> Modelica.Mechanics.Rotational</td>
  </tr>

  <tr><td><b>Michael Tiller</b> </td
      <td> Ford Motor Company, Dearborn, MI, U.S.A </td>
      <td> Modelica.Thermal</td>
  </tr>

  <tr><td><b>Hubertus Tummescheit</b> </td
      <td> Scynamics, Lund, Sweden</td>
      <td> Modelica.Thermal</td>
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
