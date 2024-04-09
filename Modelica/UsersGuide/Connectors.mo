within Modelica.UsersGuide;
class Connectors "Connectors"
  extends Modelica.Icons.Information;

 annotation (Documentation(info="<html>

<p>
The Modelica standard library defines the most important
<strong>elementary connectors</strong> in various domains. If any possible,
a user should utilize these connectors in order that components
from the Modelica Standard Library and from other libraries
can be combined without problems.
The following elementary connectors are defined
(the meaning of potential, flow, and stream
variables is explained in section \"Connector Equations\" below):
</p>

<table border=\"1\" cellspacing=\"0\" cellpadding=\"1\">
<tr><td><strong>domain</strong></td>
   <td><strong>potential<br>variables</strong></td>
   <td><strong>flow<br>variables</strong></td>
   <td><strong>stream<br>variables</strong></td>
   <td><strong>connector definition</strong></td>
   <td><strong>icons</strong></td></tr>

<tr><td><strong>electrical<br>analog</strong></td>
   <td>electrical potential</td>
   <td>electrical current</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Electrical.Analog.Interfaces\">Modelica.Electrical.Analog.Interfaces</a>
     <br>Pin, PositivePin, NegativePin</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/ElectricalPins.png\"></td></tr>

<tr><td><strong>electrical<br>polyphase</strong></td>
   <td colspan=\"3\">vector of electrical pins</td>
   <td><a href=\"modelica://Modelica.Electrical.Polyphase.Interfaces\">Modelica.Electrical.Polyphase.Interfaces</a>
     <br>Plug, PositivePlug, NegativePlug</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/ElectricalPlugs.png\"></td></tr>

<tr><td><strong>electrical<br>space phasor</strong></td>
   <td>2 electrical potentials</td>
   <td>2 electrical currents</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Electrical.Machines.Interfaces\">Modelica.Electrical.Machines.Interfaces</a>
     <br>SpacePhasor</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/SpacePhasor.png\"></td></tr>

<tr><td><strong>quasi-static<br>single-phase</strong></td>
   <td>complex electrical potential</td>
   <td>complex electrical current</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces\">
                                       Modelica.Electrical.QuasiStatic.SinglePhase.Interfaces</a>
     <br>Pin, PositivePin, NegativePin</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/QuasiStaticSinglePhasePins.png\"></td></tr>

<tr><td><strong>quasi-static<br>polyphase</strong></td>
   <td colspan=\"3\">vector of quasi-static single-phase pins</td>
   <td><a href=\"modelica://Modelica.Electrical.QuasiStatic.Polyphase.Interfaces\">Modelica.Electrical.QuasiStatic.Polyphase.Interfaces</a>
     <br>Plug, PositivePlug, NegativePlug</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/QuasiStaticPolyphasePlugs.png\"></td></tr>

<tr><td><strong>electrical<br>digital</strong></td>
   <td>Integer (1..9)</td>
   <td></td>
   <td></td>
   <td><a href=\"modelica://Modelica.Electrical.Digital.Interfaces\">Modelica.Electrical.Digital.Interfaces</a>
     <br>DigitalSignal, DigitalInput, DigitalOutput</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Digital.png\"></td></tr>

<tr><td><strong>magnetic<br>flux tubes</strong></td>
   <td>magnetic potential</td>
   <td>magnetic flux</td>
   <td></td>
   <td>
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Interfaces\">Modelica.Magnetic.FluxTubes.Interfaces</a>
     <br>MagneticPort, PositiveMagneticPort,<br>NegativeMagneticPort</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/MagneticPorts.png\"></td></tr>

<tr><td><strong>magnetic<br>fundamental<br>wave</strong></td>
   <td>complex magnetic potential</td>
   <td>complex magnetic flux</td>
   <td></td>
   <td>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces\">Modelica.Magnetic.FundamentalWave.Interfaces</a>
     <br>MagneticPort, PositiveMagneticPort,<br>NegativeMagneticPort</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/FundamentalWavePorts.png\"></td></tr>

<tr><td><strong>translational</strong></td>
   <td>distance</td>
   <td>cut-force</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Mechanics.Translational.Interfaces\">Modelica.Mechanics.Translational.Interfaces</a>
     <br>Flange_a, Flange_b</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/TranslationalFlanges.png\"></td></tr>

<tr><td><strong>rotational</strong></td>
   <td>angle</td>
   <td>cut-torque</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces\">Modelica.Mechanics.Rotational.Interfaces</a>
     <br>Flange_a, Flange_b</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/RotationalFlanges.png\"></td></tr>

<tr><td><strong>3-dim.<br>mechanics</strong></td>
   <td>position vector<br>
    orientation object</td>
   <td>cut-force vector<br>
    cut-torque vector</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Mechanics.MultiBody.Interfaces\">Modelica.Mechanics.MultiBody.Interfaces</a>
     <br>Frame, Frame_a, Frame_b, Frame_resolve</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/MultiBodyFrames.png\"></td></tr>

<tr><td><strong>simple<br>fluid flow</strong></td>
   <td>pressure<br>
    specific enthalpy</td>
   <td>mass flow rate<br>
    enthalpy flow rate</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Interfaces\">Modelica.Thermal.FluidHeatFlow.Interfaces</a>
     <br>FlowPort, FlowPort_a, FlowPort_b</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/FluidHeatFlowPorts.png\"></td></tr>

<tr><td><strong>thermo<br>fluid flow</strong></td>
   <td>pressure</td>
   <td>mass flow rate</td>
   <td>specific enthalpy<br>mass fractions</td>
   <td>
<a href=\"modelica://Modelica.Fluid.Interfaces\">Modelica.Fluid.Interfaces</a>
     <br>FluidPort, FluidPort_a, FluidPort_b</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/FluidPorts.png\"></td></tr>

<tr><td><strong>heat<br>transfer</strong></td>
   <td>temperature</td>
   <td>heat flow rate</td>
   <td></td>
   <td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces\">Modelica.Thermal.HeatTransfer.Interfaces</a>
     <br>HeatPort, HeatPort_a, HeatPort_b</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/ThermalHeatPorts.png\"></td></tr>

<tr><td><strong>blocks</strong></td>
   <td>
    Real variable<br>
    Integer variable<br>
    Boolean variable</td>
   <td></td>
   <td></td>
   <td><a href=\"modelica://Modelica.Blocks.Interfaces\">Modelica.Blocks.Interfaces</a>
     <br>
      RealSignal, RealInput, RealOutput<br>
      IntegerSignal, IntegerInput, IntegerOutput<br>
      BooleanSignal, BooleanInput, BooleanOutput</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/Signals.png\"></td></tr>

<tr><td><strong>complex<br>blocks</strong></td>
   <td>
    Complex variable</td>
   <td></td>
   <td></td>
   <td><a href=\"modelica://Modelica.ComplexBlocks.Interfaces\">Modelica.ComplexBlocks.Interfaces</a>
     <br>ComplexSignal, ComplexInput, ComplexOutput</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/ComplexSignals.png\"></td></tr>

<tr><td><strong>state<br>machine</strong></td>
   <td>Boolean variables<br>
    (occupied, set,<br>
     available, reset)</td>
   <td></td>
   <td></td>
   <td><a href=\"modelica://Modelica.StateGraph.Interfaces\">Modelica.StateGraph.Interfaces</a>
     <br>Step_in, Step_out, Transition_in, Transition_out</td>
   <td><img src=\"modelica://Modelica/Resources/Images/UsersGuide/StateGraphPorts.png\"></td></tr>
</table>

<p>
In all domains, usually 2 connectors are defined. The variable declarations
are <strong>identical</strong>, only the icons are different in order that it is easy
to distinguish connectors of the same domain that are attached at the same
component.
</p>

<h4>Hierarchical Connectors </h4>
<p>
Modelica supports also hierarchical connectors, in a similar way as hierarchical models.
As a result, it is, e.g., possible, to collect elementary connectors together.
For example, an electrical plug consisting of two electrical pins can be defined as:
</p>

<blockquote><pre>
<strong>connector</strong> Plug
   <strong>import</strong> Modelica.Electrical.Analog.Interfaces;
   Interfaces.PositivePin phase;
   Interfaces.NegativePin ground;
<strong>end</strong> Plug;
</pre></blockquote>

<p>
With one connect(..) equation, either two plugs can be connected
(and therefore implicitly also the phase and ground pins) or a
Pin connector can be directly connected to the phase or ground of
a Plug connector, such as \"connect(resistor.p, plug.phase)\".
</p>

<h4 id=\"ConnectorEquations\">Connector Equations</h4>

<p>
The connector variables listed above have been basically determined
with the following strategy:
</p>

<ol>
<li> State the relevant balance equations and boundary
     conditions of a volume for the particular physical domain.</li>
<li> Simplify the balance equations and boundary conditions
     of (1) by taking the
     limit of an infinitesimal small volume
     (e.g., thermal domain:
      temperatures are identical and heat flow rates
      sum up to zero).
</li>
<li> Use the variables needed for the balance equations
     and boundary conditions of (2)
     in the connector and select appropriate Modelica
     <strong>prefixes</strong>, so that these equations
     are generated by the Modelica connection semantics.
</li>
</ol>

<p>
The Modelica connection semantics is sketched at hand
of an example: Three connectors c1, c2, c3 with the definition
</p>

<blockquote><pre>
<strong>connector</strong> Demo
  Real        p;  // potential variable
  <strong>flow</strong>   Real f;  // flow variable
  <strong>stream</strong> Real s;  // stream variable
<strong>end</strong> Demo;
</pre></blockquote>

<p>
are connected together with
</p>

<blockquote><pre>
<strong>connect</strong>(c1,c2);
<strong>connect</strong>(c1,c3);
</pre></blockquote>

<p>
then this leads to the following equations:
</p>

<blockquote><pre>
// Potential variables are identical
c1.p = c2.p;
c1.p = c3.p;

// The sum of the flow variables is zero
0 = c1.f + c2.f + c3.f;

/* The sum of the product of flow variables and upstream stream variables is zero
   (this implicit set of equations is explicitly solved when generating code;
   the \"&lt;undefined&gt;\" parts are defined in such a way that
   inStream(..) is continuous).
*/
0 = c1.f*(<strong>if</strong> c1.f > 0 <strong>then</strong> s_mix <strong>else</strong> c1.s) +
    c2.f*(<strong>if</strong> c2.f > 0 <strong>then</strong> s_mix <strong>else</strong> c2.s) +
    c3.f*(<strong>if</strong> c3.f > 0 <strong>then</strong> s_mix <strong>else</strong> c3.s);

<strong>inStream</strong>(c1.s) = <strong>if</strong> c1.f > 0 <strong>then</strong> s_mix <strong>else</strong> &lt;undefined&gt;;
<strong>inStream</strong>(c2.s) = <strong>if</strong> c2.f > 0 <strong>then</strong> s_mix <strong>else</strong> &lt;undefined&gt;;
<strong>inStream</strong>(c3.s) = <strong>if</strong> c3.f > 0 <strong>then</strong> s_mix <strong>else</strong> &lt;undefined&gt;;
</pre></blockquote>

</html>"));
end Connectors;
