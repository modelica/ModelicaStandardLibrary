within Modelica.Magnetic;
package FundamentalWave
  "Library for magnetic fundamental wave effects in electric machines"
  extends Modelica.Icons.Package;
  package UsersGuide "User's Guide"
    extends Modelica.Icons.Information;
    class Concept "Fundamental wave concept"
      extends Modelica.Icons.Information;
      annotation (Documentation(info="<html>

<h4>Overview of the concept of fundamental waves</h4>

<p>
The exact magnetic field in the air gap of an electric machine is usually determined by an electro magnetic finite element analysis. The waveform of the magnetic field, e.g., the magnetic potential difference <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m_phi.png\">, consists of a spatial fundamental wave - with respect to an equivalent two pole machine - and additional harmonic waves of different order. The fundamental wave is however dominant in the air gap of an electric machine.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1:</strong> Field lines of a four pole induction machine</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Concept/aimc_fem.png\">
    </td>
  </tr>
</table>

<p>
In the fundamental wave theory only a pure sinusoidal distribution of magnetic quantities is assumed. It is thus assumed that all other harmonic wave effects are not taken into account.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 2:</strong> Magnetic potential difference of a four pole machine, where <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/varphi.png\"> is the angle of the spatial domain with respect to one pole pair</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Concept/four_pole_V_m.png\">
    </td>
  </tr>
</table>

<p>
The waveforms of the magnetic field quantities, e.g., the magnetic potential difference <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m_phi.png\">, can be represented by complex phasor, e.g., <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m.png\"> according to:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m_real_complex.png\">
</p>

<p>It is important to note that the magnetic potential used in this library <strong>always</strong> refers to an equivalent two pole machine.</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 3:</strong> Spatial distribution of the magnetic potential difference (red shade = positive sine wave, blue shade = negative sine wave) including complex phasor representing this spatial distribution</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Concept/electrical_reference_V_m.png\">
    </td>
  </tr>
</table>

<p>
The potential and flow quantities of this library are the complex magnetic potential difference and the complex magnetic flux as defined in the basic <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">magnetic port</a>. Due to the sinusoidal distribution of magnetic potential and flux, such a complex phasor representation can be used. This way, the FundamentalWave library can be seen as a spatial extension of the <a href=\"modelica://Modelica.Magnetic.FluxTubes\">FluxTubes</a> library.
</p>

<p>
The specific arrangement of windings in electric machines with <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/p.png\"> pole pairs give rise to sinusoidal dominant magnetic potential wave. The spatial period of this wave is determined by one pole pair
[<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Mueller70</a>,
 <a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Spaeth73</a>].
</p>

<p>
The main components of an electric machine model based on the FundamentalWave library are <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding\">multi phase</a> and <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">single phase windings</a>, <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">air gap</a> as well as <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding\">symmetric</a> or <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding\">salient cage</a> models.
The electric machine models provided in this library are based on symmetrical windings in the stator and equivalent two or three phase windings in squirrel cage rotors. Slip ring induction machines may have different phase numbers in the stator and rotor.
</p>

<h4>Assumptions</h4>

<p>
The machine models of the FundamentalWave library are currently based on the following assumptions
</p>

<ul>
<li>The number of stator phases is greater or equal to three
    [<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Eckhardt82</a>]
    </li>
<li>The phase windings are assumed to be symmetrical; an extension to this approach can be considered</li>
<li>Only fundamental wave effects are taken into account</li>
<li>The magnetic potential difference refers to an equivalent two pole machine</li>
<li>There are no restrictions on the waveforms of voltages and currents</li>
<li>All resistances and inductances are modeled as constant quantities; saturation effects, cross coupling effects
    [<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Li07</a>], temperature dependency of resistances and deep bar effects could be considered in an extension to this library</li>
<li>Hysteresis losses are currently not considered [<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Haumer09</a>]</li>
<li>The losses dissipated in the electric machine models are
    <ul>
    <li>ohmic heat losses,</li>
    <li>eddy current losses in the stator core,</li>
    <li>stray load losses,</li>
    <li>friction losses.</li>
    </ul>
</li>
</ul>

<h4>Note</h4>

<p>
The term <strong>fundamental wave</strong> refers to spatial waves of the electro magnetic quantities. This library has no limitations with respect to the waveforms of the time domain signals of any voltages, currents, etc.
</p>
</html>"));
    end Concept;

    class MultiPhase "Multi phase windings"
      extends Modelica.Icons.Information;
      annotation (Documentation(info="<html>
<h4>Symmetrical three phase system</h4>

<p>
Symmetrical three phases systems of currents (or voltages) consists of three sinusoidal
sine waves with an angular displacement of
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/2pi_3.png\"/>.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/i123.png\"/>,
</p>

<p>
Electrical three phase machines have (usually) symmetrical three phase windings which
excite spatial magnetic potential with a spacial displacement of
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/2pi_3.png\"/>
- with respect to the fundamental wave,
see [<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Laughton02</a>].
Such a symmetrical three phase system of currents (or voltages) can be represented by
<a href=\"http://en.wikipedia.org/wiki/Phasor\">phasors</a>, as depicted in Fig. 1(a).
The associated three phase winding is depicted in Fig. 2(a). The winding axis are displaced by
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/2pi_3.png\"/>:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/orientationk_3.png\"/>
</p>

<p>
So there is a strong coherence between angular displacement in the time and
spatial domain which also applies to multi phase systems.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1: </strong>Symmetrical (a) three phase and (b) five phase current system</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/phase35.png\"
           alt=\"phase35.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 2: </strong>Symmetrical (a) three phase and (b) five phase winding</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/winding35.png\"
           alt=\"winding35.png\">
    </td>
  </tr>
</table>

<h4>Symmetrical multi phase system</h4>

<p>
In symmetrical multi phase systems odd and even phase numbers have to be distinguished.
</p>

<h5>Odd number of phases</h5>

<p>
For a symmetrical multi phase system with <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/m.png\"/>
phases the displacement in the time and spatial domain is
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/2pi_m.png\"/>,
as depicted in Fig. 1 and 2.
</p>

<p>
Mathematically, this symmetry is expressed in terms of phase currents by:
</p>

<p><img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/ik_odd.png\"/></p>

<p>
The orientation of the winding axis of such winding is given by:
</p>

<p><img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/orientationk_m.png\"/></p>

<h5>Even number of phases</h5>

<p>
In the current implementation of the FundamentalWave library, phase numbers equal
to the power of two are not supported. However, any other multi phase system with even
an phase number, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/m.png\"/>,
can be recursively split into various symmetrical systems with odd phase numbers, as depicted in Fig. 3 and 4.
The displacement between the two symmetrical systems is
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/pi_m.png\"/>.
A function for calculating the <a href=\"modelica://Modelica.Electrical.MultiPhase.Functions.symmetricOrientation\">symmetricOrientation</a> is available.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 3: </strong>Symmetrical (a) six and (b) ten phase current system</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/phase610.png\"
           alt=\"phase610.png\">
    </td>
  </tr>
</table>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 4: </strong>Symmetrical (a) six and (b) ten phase winding</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/MultiPhase/winding610.png\"
           alt=\"winding610.png\">
    </td>
  </tr>
</table>


<h4>Note</h4>

<p>
In a fully symmetrical machine, the orientation of the winding axes and the symmetrical currents (or voltages)
<a href=\"http://en.wikipedia.org/wiki/Phasor\">phasors</a> have different signs; see Fig. 1 and 2 for odd phase numbers
and Fig. 3 and 4 for even phase numbers.
</p>
</html>"));
    end MultiPhase;

    class Parameters "Parameters of equivalent machines models"
      extends Modelica.Icons.Information;
      annotation (Documentation(info="<html>

<h4>Stator main inductance</h4>

<p>
The stator main inductance
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lm_m.png\">
of an
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/m.png\">
phase induction machine is related with the self inductance of on stator phase,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lss.png\">,
by:</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lm_m_Lss.png\">
</p>

<h4>Parameters of equivalent multi phase induction machines models</h4>

<p>Assume a set parameters,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Rs_3.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lssigma_3.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/L0_3.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lm_3.png\">,
of a three phase induction machine and a set of parameters,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Rs_m.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lssigma_m.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/L0_m.png\">,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lm_m.png\">,
of an
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/m.png\">
phase induction machine. It is also assumed that</p>
<ul>
<li>the nominal phase voltages</li>
<li>the nominal stator frequencies</li>
</ul>
<p>of the three and
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/m.png\">
phase induction machine are equal. In this case the two parameter sets are related by:</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Rs_3m.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lssigma_3m.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/L0_3m.png\"><br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/Lm_3m.png\"></p>
<p>
This way the same torque is generated and the machine currents are related by:
</p>
<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/is_3m.png\">
</p>

<p>
The same applies for the rotor parameters of a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing\">
slip ring induction machine</a>, where the phase number
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/m.png\">
is simply replaced by
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/mr.png\">
for transforming equivalent three phase to
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/Parameters/mr.png\">
phase winding parameters -- at the same nominal rotor voltage and frequency.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.AIMC_DOL_MultiPhase\">AIMC_DOL_MultiPhase</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.AIMS_Start_MultiPhase\">AIMS_Start_MultiPhase</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SMPM_Inverter_MultiPhase\">SMPM_Inverter_MultiPhase</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SMEE_Generator_MultiPhase\">SMEE_Generator_MultiPhase</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Examples.BasicMachines.SMR_Inverter_MultiPhase\">SMR_Inverter_MultiPhase</a>
</p>

</html>"));
    end Parameters;

    class Contact "Contact"
      extends Modelica.Icons.Contact;
      annotation (Documentation(info="<html>
<h4>Library officers</h4>

<p>
<strong>Dr. Christian Kral</strong><br>
<a href=\"https://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
A-1060 Vienna, Austria<br>
email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a>
</p>

<p>
<strong>Anton Haumer</strong><br>
<a href=\"https://www.haumer.at\">Technical Consulting &amp; Electrical Engineering</a><br>
D-93049 Regensburg, Germany<br>
email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a><br>
</p>

<h4>Acknowledgements</h4>

<p>
Based on an original idea of Michael Beuschel this library was developed
[<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Beuschel00</a>].
The authors of the FundamentalWave library would like to thank Michael Beuschel
for contributing his source code to this library.
</p>

<p>
The research leading to version 2.0.0 has received funding from the ENIAC Joint Undertaking under grant
agreement no. 270693-2 and from the &Ouml;sterreichische
Forschungsf&ouml;rderungsgesellschaft mbH under project
no. 829420.
</p>
</html>"));
    end Contact;

    class ReleaseNotes "Release Notes"
      extends Modelica.Icons.ReleaseNotes;
      annotation (Documentation(info="<html>

<h5>Version 3.2.3, 2018-09-26</h5>

<ul>
  <li>Fixed propagation of excitation leakage factor, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2403\">#2403</a></li>
  <li>Added model of electrical excited synchronous machines, starting direct on line, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2388\">#2388</a></li>
  <li>Unified communication interval, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2279\">#2279</a></li>
  <li>Unified simulation tolerances, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2278\">#2278</a></li>
<li>Added more examples from
    <a href=\"modelica://Modelica.Electrical.Machines.Examples\">Machines.Examples</a>, see
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2276\">#2276</a></li>
<li>Replace wrong permeance image in documentation according to
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2208\">#2208</a></li>
<li>Added obsolete annotation to
    <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding_obsolete\">SymmetricMultiPhaseCageWinding_obsolete</a> and
    <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding_obsolete\">SaliencyCageWinding_obsolete</a>,
    see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1536\">#1536</a></li>
<li>Updated documentation of
    <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Short</a>,
    <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Idle\">Idle</a> and
    <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.PermanentMagnet\">PermanentMagnet</a>
    </li>
<li>Added new components:
<ul>
    <li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Crossing\">Crossing</a></li>
    <li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Permeance\">Permeance</a></li>
</ul></li>
<li>Removed parameter text from icon layer for reluctance and permeance model</li>
<li>Restructured cage models with reluctance instead of inductance model according to ticket
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1536\">#1536</a>;
the re-structuring of the model required to change the initial conditions of the included examples, since the number of rotor states is reduced by new implementation</li>
<li>Some more bug fixes according to
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1226\">#1226</a>,
since not all reference orientations have been correct</li>
<li>Added variables for magnitude and argument of complex magnetic potential difference and flux, see
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1405\">#1405</a></li>
</ul>

<h5>Version 3.2.1, 2013-07-31</h5>

<ul>
<li>Bug fix of wrong orientation of squirrel and damper cage models, see ticket
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1226\">#1226</a>;
this also includes the removal of the rotor cage heat sensor which previously has been used</li>
<li>Bug fix of conditional initialization of examples, see ticket
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1223\">#1223</a></li>
<li>Fixed missing default parameter TpmOperational in ambient of PM synchronous machine, see ticket
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1216\">#1216</a>#1216</li>
<li>Added voltages, currents, complex flux and magnetic potential difference as global variables in
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter\">multi phase converter</a></li>
<li>Added two more component examples, showing the equivalent nature of electrical and magnetic domain</li>
</ul>

<h5>Version 2.0.0, 2013-03-10</h5>

<ul>
<li>Corrected wrong parameter descriptions, see ticket
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/1003\">#1003</a></li>
<li>Extended machine models towards phase numbers to greater or equal than three, see ticket
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/990\">#990</a></li>
</ul>

<h5>Version 1.7.3, 2013-02-25</h5>

<ul>
<li>Corrected wrong parameter description</li>
</ul>


<h5>Version 1.7.2, 2011-06-28</h5>

<ul>
<li>Corrected bug in calculation of core conductance in
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding\">SymmetricMultiPhaseWinding</a>:
the wrong calculation <code>G=(m/2)*GcRef/effectiveTurns^2</code> is now replaced by <code>G=(m/2)*GcRef*effectiveTurns^2</code></li>
</ul>

<h5>Version 1.7.1, 2010-09-03</h5>

<ul>
<li>Naming and documentation of
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPort\">
PartialTwoPort</a> is exchanged by
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortElementary\">
PartialTwoPortElementary</a> to match the naming conventions of
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces\">
Rotational.Interfaces</a>
and <a href=\"modelica://Modelica.Mechanics.Translational.Interfaces\">
Translational.Interfaces</a></li>
<li>Fixed a broken link and updated documentation</li>
<li>Adaptions to Complex SIunits</li>
</ul>

<h5>Version 1.7.0, 2010-05-31</h5>

<ul>
<li>Changed <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding\">symmetric multi phase winding</a> model
  <ul>
      <li>Added zero sequence inductance based on
          <a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.ZeroInductor\">zero inductor</a></li>
      <li>Replaced electrical model of stray
          <a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.Inductor\">inductor</a> by stray
          <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Reluctance\">reluctance</a> model</li>
      <li>Integrated cores <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">losses</a>
          and <a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">heat port</a></li>
  </ul></li>
  <li>Added rotor core loss parameters in asynchronous induction machine with slip rings</li>
  <li>Renamed heat ports of <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">single phase winding</a> and <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding\">symmetric multi phase winding</a>
     </li>
  <li>Relocated core losses between zero inductor and stray reluctance model in the magnetic domain</li>
  <li>Renamed instances of stator and rotor (winding) models in each machines</li>
  <li>Added magnetic potential sensor</li>
  <li>Removed state selections</li>
  <li>Updates due to changed loss variable and heat port names in
      <a href=\"modelica://Modelica.Electrical.Machines\">Electrical.Machines</a></li>
  <li>Added machine specific output records to summarize power and loss balance</li>
  <li>Updated images of Users Guide</li>
  <li>Improved performance due to <code>annotation(Evaluate=true)</code> added to the parameters of the
      <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">single phase winding</a></li>
  <li>Reduced number of states in <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding\">symmetric cage</a> model by introducing an additional non-grounded star connection</li>
</ul>

<h5>Version 1.6.0, 2010-05-05</h5>

<ul>
<li>Renamed all parameters <code>windingAngle</code> to <code>orientation</code>. The following classes are affected:
<ul>
<li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">SinglePhaseElectroMagneticConverter</a></li>
<li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter\">MultiPhaseElectroMagneticConverter</a></li>
<li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">SinglePhaseWinding</a></li>
<li><a href=\"modelica://Modelica.Electrical.MultiPhase.Functions.symmetricOrientation\">symmetricOrientation</a></li>
</ul></li>
<li>Update due to changed class names in <a href=\"modelica://Modelica.Electrical.Machines.Icons\">Machines.Icons</a></li>
<li>Using <a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort\">HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort</a> instead of
    <a href=\"modelica://Modelica.Electrical.Analog.Interfaces.ConditionalHeatPort\">Analog.Interfaces.ConditionalHeatPort</a> in
    <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">EddyCurrent</a></li>
<li>Added <code>modelica://</code> to all Modelica hyper links</li>
<li>Fixed bug in displayed parameters of <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">EddyCurrent</a></li>
<li>Updated some images (and renamed image file <code>LossPower.png</code> to <code>lossPower.png</code>)</li>
<li>Exchanged positive and negative stator ports of <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
model, adapted equations accordingly and updated code documentation.</li>
</ul>

<h5>Version 1.5.0, 2010-04-28</h5>

<ul>
<li>Added stator core, friction, stray load and brush losses to all machine types based on
<a href=\"modelica://Modelica.Electrical.Machines.Losses\">loss models</a> of the <a href=\"modelica://Modelica.Electrical.Machines\">Machines</a> library.</li>
<li>Changed parameter of
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">EddyCurrent</a>
model from R to G</li>
<li>Fixed wrong sign of internal quantity <code>tauElectrical</code>, model behavior does not change</li>
<li>Rewrote equations of electromagnetic coupling to look more elegant</li>
</ul>

<h5>Version 1.4.0, 2010-04-22</h5>

<ul>
<li>Added eddy current model in accordance to <a href=\"modelica://Modelica.Magnetic.FluxTubes\">FluxTubes</a> library</li>
<li>Added thermal heat port to eddy current model</li>
<li>Minor updates due to dependencies of <a href=\"modelica://Modelica.Electrical.Machines\">Machines</a></li>
</ul>

<h5>Version 1.3.0, 2010-02-26</h5>

<ul>
<li>Changed some icon references</li>
<li>Added state selections for the machine models</li>
<li>Restructured partial machine model</li>
<li>Added copyright information</li>
</ul>

<h5>Version 1.2.0, 2010-02-17</h5>

<ul>
<li>Renamed Machines to BasicMachines</li>
<li>Updated dependencies due to renamed class
<a href=\"modelica://Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20\">LinearTemperatureCoefficient20</a></li>
<li>Added release notes in User's Guide</li>
</ul>

<h5>Version 1.1.0, 2010-02-15</h5>

<ul>
<li>Added thermal connectors and temperature dependent resistances</li>
</ul>

<h5>Version 1.0.0, 2010-02-04</h5>

<ul>
<li>Integrated the library into the MSL</li>
</ul>

<h5>Version 0.4.0, 2009-10-29</h5>

<ul>
<li>Corrected bug in magnetic potential calculation</li>
</ul>

<h5>Version 0.3.0, 2009-10-28</h5>

<ul>
<li>Renamed number of turns and winding angles</li>
</ul>

<h5>Version 0.2.0, 2009-10-20</h5>

<ul>
<li>Added idle model</li>
</ul>

<h5>Version 0.1.0, 2009-07-22</h5>

<ul>
<li>First version based on the concept of the FluxTubes library and the Magnetics library of Michael Beuschel
[<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.References\">Beuschel00</a>]</li>
</ul>
</html>"));
    end ReleaseNotes;

    class References "References"
      extends Modelica.Icons.References;
      annotation (Documentation(info="<html>
<h4>References</h4>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td>[Beuschel00]</td>
      <td>M. Beuschel,
        &quot;<a href=\"https://www.modelica.org/events/workshop2000/proceedings/Beuschel.pdf\">
        A uniform approach for modelling electrical machines</a>,&quot;
        <em>Modelica Workshop</em>,
        pp. 101-108, October 23-24, 2000.</td>
    </tr>

    <tr>
      <td>[Eckhardt82]</td>
      <td>H. Eckhardt,
        <em>Grundz&uuml;ge der elektrischen Maschinen</em> (in German),
        B. G. Teubner Verlag, Stuttgart, 1982.</td>
    </tr>

    <tr>
      <td>[Haumer09]</td>
      <td>A. Haumer, and C. Kral,
        &quot;<a href=\"https://www.modelica.org/events/modelica2009/Proceedings/memorystick/pages/papers/0103/0103.pdf\">The
        AdvancedMachines Library: Loss Models for Electric Machines</a>,&quot;
        <em>Modelica Conference</em>, 2009.</td>
    </tr>

    <tr>
      <td>[Lang84]</td>
      <td>W. Lang,
        <em>&Uuml;ber die Bemessung verlustarmer Asynchronmotoren mit K&auml;figl&auml;ufer f&uuml;r Pulsumrichterspeisung</em>
       (in German),
       Doctoral Thesis, Technical University of Vienna, 1984.</td>
    </tr>

    <tr>
      <td>[Laughton02]</td>
      <td>M.A. Laughton, D.F. Warne
        <em>Electrical Engineer's Reference Book</em>
        Butterworth Heinemann, 16th edition, ISBN 978-0750646376, 2002</td>
    </tr>

    <tr>
      <td>[Li07]</td>
      <td>Y. Li, Z. Q. Zhu, D. Howe, and C. M. Bingham,
        &quot;Modeling of Cross-Coupling Magnetic Saturation in Signal-Injection-Based
        Sensorless Control of Permanent-Magnet Brushless AC Motors,&quot;
        <em>IEEE Transactions on Magnetics</em>,
        vol. 43, no. 6, pp. 2552-2554, June 2007.</td>
    </tr>

    <tr>
      <td>[Mueller70]</td>
      <td>G, M&uuml;ller,
        <em>Elektrische Maschinen -- Grundlagen, Aufbau und Wirkungsweise</em> (in German),
        VEB Verlag Technik Berlin, 4th edition, 1970.</td>
    </tr>

    <tr>
      <td>[Spaeth73]</td>
      <td>H. Sp&auml;th,
        <em>Elektrische Maschinen -- Eine Einf&uuml;hrung in die Theorie des Betriebsverhaltens</em> (in German),
        Springer-Verlag, Berlin, Heidelberg, New York, 1973.</td>
    </tr>

</table>
</html>"));
    end References;
    annotation (DocumentationClass=true, Documentation(info="<html>
<p>
This library contains components for modelling of electromagnetic fundamental wave
models for the application in multi phase
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines\">electric machines</a>.
The number of phases is not restricted to three. DC machines are (currently) not included
in this library. The FundamentalWave library is an alternative approach to the
<a href=\"modelica://Modelica.Electrical.Machines\">Modelica.Electrical.Machines</a> library.
A great advantage of this library is the strict object orientation of the electrical and
magnetic components that the electric machines models are composed of.
From a didactic point of view this library is very beneficial for students in the
field of electrical engineering.
</p>

<p>
For more details see the <a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Concept\">concept.</a>
</p>

<h5>Note</h5>

<ul>
<li>All the machine models provided in this library are equivalent two pole machines.
The magnetic potential difference of the connector therefore also refers to an equivalent two pole machine</li>
<li>In machines with <strong>more than three phases</strong> only effects of currents and voltages on the magnetic <strong>fundamental waves</strong> are considered. Other magnetic effects due to higher harmonic are not taken into account.</li>
</ul>


</html>"));
  end UsersGuide;

  package Examples
    "Examples of electric machines based on the FundamentalWave concept"
    extends Modelica.Icons.ExamplesPackage;
    package Components "Examples of components of the FundamentalWave library"
      extends Modelica.Icons.ExamplesPackage;
      model EddyCurrentLosses
        "Comparison of equivalent circuits of eddy current loss models"
        extends Modelica.Icons.Example;
        parameter Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Resistance R=0.1
          "Resistance of leader cables";
        parameter Modelica.SIunits.Conductance Gc=1 "Loss conductance";
        parameter Modelica.SIunits.Reluctance R_m=1
          "Reluctance of the magnetic circuit";
        parameter Real N=1 "Number of turns";
        output Modelica.SIunits.Power lossPower_e=sum(loss_e.conductor.LossPower);
        output Modelica.SIunits.Power lossPower_m=loss_m.lossPower;
        Modelica.Electrical.Analog.Basic.Ground ground_e
          annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
        Modelica.Electrical.Analog.Basic.Ground ground_m
          annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
        Modelica.Electrical.MultiPhase.Basic.Star star_e(m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,30})));
        Modelica.Electrical.MultiPhase.Basic.Star star_m(m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,-60})));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage_e(
          m=m,
          V=fill(1, m),
          freqHz=fill(1, m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,60})));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage_m(
          m=m,
          V=fill(1, m),
          freqHz=fill(1, m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-80,-30})));
        Modelica.Electrical.MultiPhase.Basic.Resistor resistor_e(m=m, R=fill(R,
              m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={-60,70})));
        Modelica.Electrical.MultiPhase.Basic.Resistor resistor_m(m=m, R=fill(R,
              m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={-60,-20})));
        Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
          converter_e(
          m=m,
          effectiveTurns=fill(N, m),
          orientation=
              Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m))
          annotation (Placement(transformation(extent={{20,50},{40,70}})));
        Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
          converter_m(
          m=m,
          effectiveTurns=fill(N, m),
          orientation=
              Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m))
          annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
        Modelica.Magnetic.FundamentalWave.Components.Reluctance reluctance_e(
            R_m(d=R_m, q=R_m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={80,60})));
        Modelica.Magnetic.FundamentalWave.Components.Reluctance reluctance_m(
            R_m(d=R_m, q=R_m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={80,-30})));
        Modelica.Magnetic.FundamentalWave.Components.Ground mground_e
          annotation (Placement(transformation(extent={{30,0},{50,20}})));
        Modelica.Magnetic.FundamentalWave.Components.Ground mground_m
          annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
        Electrical.MultiPhase.Basic.Conductor loss_e(m=m, G=fill(Gc, m))
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-10,60})));
        Modelica.Magnetic.FundamentalWave.Components.EddyCurrent loss_m(G=m*N^2
              *Gc/2) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={60,-20})));
        Modelica.Electrical.MultiPhase.Sensors.PowerSensor powerb_e(m=m)
          annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
        Modelica.Electrical.MultiPhase.Sensors.PowerSensor powerb_m(m=m)
          annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
      initial equation
        reluctance_e.Phi = Complex(0, 0);
        reluctance_m.Phi = Complex(0, 0);
      equation
        connect(sineVoltage_e.plug_n, converter_e.plug_n) annotation (Line(
            points={{-80,50},{20,50}}, color={0,0,255}));
        connect(sineVoltage_e.plug_n, star_e.plug_p) annotation (Line(
            points={{-80,50},{-80,40}}, color={0,0,255}));
        connect(sineVoltage_m.plug_n, star_m.plug_p) annotation (Line(
            points={{-80,-40},{-80,-50}}, color={0,0,255}));
        connect(star_e.pin_n, ground_e.p) annotation (Line(
            points={{-80,20},{-80,20}}, color={0,0,255}));
        connect(star_m.pin_n, ground_m.p) annotation (Line(
            points={{-80,-70},{-80,-70}}, color={0,0,255}));
        connect(sineVoltage_m.plug_n, converter_m.plug_n) annotation (Line(
            points={{-80,-40},{20,-40}}, color={0,0,255}));
        connect(converter_e.port_p, reluctance_e.port_p) annotation (Line(
            points={{40,70},{80,70}}, color={255,128,0}));
        connect(converter_e.port_n, reluctance_e.port_n) annotation (Line(
            points={{40,50},{80,50}}, color={255,128,0}));
        connect(converter_e.port_n, mground_e.port_p) annotation (Line(
            points={{40,50},{40,20}}, color={255,128,0}));
        connect(converter_m.port_n, reluctance_m.port_n) annotation (Line(
            points={{40,-40},{80,-40}}, color={255,128,0}));
        connect(converter_m.port_p, loss_m.port_p) annotation (Line(
            points={{40,-20},{50,-20}}, color={255,128,0}));
        connect(loss_m.port_n, reluctance_m.port_p) annotation (Line(
            points={{70,-20},{80,-20}}, color={255,128,0}));
        connect(converter_m.port_n, mground_m.port_p) annotation (Line(
            points={{40,-40},{40,-70}}, color={255,128,0}));
        connect(resistor_e.plug_p, sineVoltage_e.plug_p) annotation (Line(
            points={{-70,70},{-80,70}}, color={0,0,255}));
        connect(sineVoltage_m.plug_p, resistor_m.plug_p) annotation (Line(
            points={{-80,-20},{-70,-20}}, color={0,0,255}));
        connect(resistor_e.plug_n, powerb_e.pc) annotation (Line(
            points={{-50,70},{-40,70}}, color={0,0,255}));
        connect(powerb_e.pv, powerb_e.pc) annotation (Line(
            points={{-30,80},{-40,80},{-40,70}}, color={0,0,255}));
        connect(powerb_e.nc, loss_e.plug_p) annotation (Line(
            points={{-20,70},{-10,70}}, color={0,0,255}));
        connect(powerb_e.nv, sineVoltage_e.plug_n) annotation (Line(
            points={{-30,60},{-30,50},{-80,50}}, color={0,0,255}));
        connect(resistor_m.plug_n, powerb_m.pc) annotation (Line(
            points={{-50,-20},{-40,-20}}, color={0,0,255}));
        connect(powerb_m.pc, powerb_m.pv) annotation (Line(
            points={{-40,-20},{-40,-10},{-30,-10}}, color={0,0,255}));
        connect(powerb_m.nc, converter_m.plug_p) annotation (Line(
            points={{-20,-20},{20,-20}}, color={0,0,255}));
        connect(powerb_m.nv, sineVoltage_m.plug_n) annotation (Line(
            points={{-30,-30},{-30,-40},{-80,-40}}, color={0,0,255}));
        connect(loss_e.plug_n, sineVoltage_e.plug_n) annotation (Line(
            points={{-10,50},{-80,50}}, color={0,0,255}));
        connect(loss_e.plug_p, converter_e.plug_p) annotation (Line(
            points={{-10,70},{20,70}}, color={0,0,255}));
        annotation (experiment(StopTime=40, Interval=0.01), Documentation(info="<html>
<p>
In this example the eddy current losses are implemented in two different ways. Compare the loss dissipation <code>powerb_e.power</code> and <code>powerb_m.power</code> of the two models indicated by power meters.</p>
</html>"));
      end EddyCurrentLosses;

      model SinglePhaseInductance "Single phase inductance"
        extends Modelica.Icons.Example;
        parameter Modelica.SIunits.Frequency f=1 "Supply frequency";
        parameter Modelica.SIunits.Voltage VRMS=100 "RMS supply voltage";
        parameter Modelica.SIunits.Resistance R=0.1 "Leader cable resistance";
        parameter Modelica.SIunits.Inductance L=1 "Load inductance";
        parameter Real effectiveTurns=5 "Effective number of turns";
        final parameter Modelica.SIunits.Reluctance R_m=effectiveTurns^2/L
          "Equivalent magnetic reluctance";
        Modelica.Electrical.Analog.Basic.Ground ground_e
          annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
        Modelica.Electrical.Analog.Basic.Ground ground_m
          annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));
        Modelica.Electrical.Analog.Sources.SineVoltage voltageSource_e(
          freqHz=f,
          V=sqrt(2)*VRMS,
          phase=Modelica.Constants.pi/2) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,70})));
        Modelica.Electrical.Analog.Sources.SineVoltage voltageSource_m(
          freqHz=f,
          V=sqrt(2)*VRMS,
          phase=Modelica.Constants.pi/2) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,-30})));
        Modelica.Electrical.Analog.Basic.Resistor resistor_e(R=R)
          annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
        Modelica.Electrical.Analog.Basic.Resistor resistor_m(R=R)
          annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
        Modelica.Electrical.Analog.Basic.Inductor inductor_e(L=L) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,70})));
        Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter
          converter_m(effectiveTurns=effectiveTurns, orientation=0)
          annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
        Modelica.Magnetic.FundamentalWave.Components.Reluctance reluctance_m(
            R_m(d=R_m, q=R_m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={60,-30})));
        Modelica.Magnetic.FundamentalWave.Components.Ground groundM_m
          annotation (Placement(transformation(extent={{10,-80},{30,-60}})));
      initial equation
        resistor_e.i = 0;
        resistor_m.i = 0;
      equation
        connect(converter_m.port_p, reluctance_m.port_p) annotation (Line(
            points={{20,-20},{60,-20}}, color={255,128,0}));
        connect(converter_m.port_n, reluctance_m.port_n) annotation (Line(
            points={{20,-40},{60,-40}}, color={255,128,0}));
        connect(converter_m.port_n, groundM_m.port_p) annotation (Line(
            points={{20,-40},{20,-60}}, color={255,128,0}));
        connect(voltageSource_e.n, inductor_e.n) annotation (Line(
            points={{-60,60},{0,60}}, color={0,0,255}));
        connect(voltageSource_e.n, ground_e.p) annotation (Line(
            points={{-60,60},{-60,40}}, color={0,0,255}));
        connect(voltageSource_m.n, converter_m.pin_n) annotation (Line(
            points={{-60,-40},{0,-40}}, color={0,0,255}));
        connect(voltageSource_m.n, ground_m.p) annotation (Line(
            points={{-60,-40},{-60,-60}}, color={0,0,255}));
        connect(voltageSource_e.p, resistor_e.p) annotation (Line(
            points={{-60,80},{-40,80}}, color={0,0,255}));
        connect(resistor_e.n, inductor_e.p) annotation (Line(
            points={{-20,80},{0,80}}, color={0,0,255}));
        connect(voltageSource_m.p, resistor_m.p) annotation (Line(
            points={{-60,-20},{-40,-20}}, color={0,0,255}));
        connect(resistor_m.n, converter_m.pin_p) annotation (Line(
            points={{-20,-20},{0,-20}}, color={0,0,255}));
        annotation (experiment(StopTime=100, Interval=0.01));
      end SinglePhaseInductance;

      model MultiPhaseInductance "Multi phase inductance"
        extends Modelica.Icons.Example;
        parameter Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Frequency f=1 "Supply frequency";
        parameter Modelica.SIunits.Voltage VRMS=100 "RMS supply voltage";
        parameter Modelica.SIunits.Resistance R=0.1 "Leader cable resistance";
        parameter Real effectiveTurns=5 "Effective number of turns";
        parameter Modelica.SIunits.Inductance L=1 "Load inductance";
        final parameter Modelica.SIunits.Reluctance R_m=m*effectiveTurns^2/2/L
          "Equivalent magnetic reluctance";
        Modelica.Electrical.Analog.Basic.Ground ground_e
          annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
        Modelica.Electrical.Analog.Basic.Ground ground_m
          annotation (Placement(transformation(extent={{-70,-90},{-50,-70}})));
        Modelica.Electrical.MultiPhase.Basic.Star star_e(m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,40})));
        Modelica.Electrical.MultiPhase.Basic.Star star_m(m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,-60})));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage voltageSource_e(
          m=m,
          freqHz=fill(f, m),
          V=fill(sqrt(2)*VRMS, m),
          phase=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
              m) + fill(Modelica.Constants.pi/2, m)) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,70})));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage voltageSource_m(
          m=m,
          freqHz=fill(f, m),
          V=fill(sqrt(2)*VRMS, m),
          phase=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
              m) + fill(Modelica.Constants.pi/2, m)) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,-30})));
        Modelica.Electrical.MultiPhase.Basic.Resistor resistor_e(m=m, R=fill(R,
              m))
          annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
        Modelica.Electrical.MultiPhase.Basic.Resistor resistor_m(m=m, R=fill(R,
              m))
          annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
        Modelica.Electrical.MultiPhase.Basic.Inductor inductor_e(m=m, L=fill(L,
              m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,70})));
        Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
          converter_m(
          m=m,
          orientation=
              Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m),
          effectiveTurns=fill(effectiveTurns, m))
          annotation (Placement(transformation(extent={{0,-40},{20,-20}})));

        Modelica.Magnetic.FundamentalWave.Components.Reluctance reluctance_m(
            R_m(d=R_m, q=R_m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={60,-30})));
        Modelica.Magnetic.FundamentalWave.Components.Ground groundM_m
          annotation (Placement(transformation(extent={{10,-90},{30,-70}})));
      initial equation
        resistor_e.i = zeros(m);
        resistor_m.i[1:2] = zeros(2);
      equation
        connect(star_e.plug_p, voltageSource_e.plug_n) annotation (Line(
            points={{-60,50},{-60,60}}, color={0,0,255}));
        connect(voltageSource_e.plug_n, inductor_e.plug_n) annotation (Line(
            points={{-60,60},{0,60}}, color={0,0,255}));
        connect(converter_m.port_p, reluctance_m.port_p) annotation (Line(
            points={{20,-20},{60,-20}}, color={255,128,0}));
        connect(converter_m.port_n, reluctance_m.port_n) annotation (Line(
            points={{20,-40},{60,-40}}, color={255,128,0}));
        connect(converter_m.port_n, groundM_m.port_p) annotation (Line(
            points={{20,-40},{20,-70}}, color={255,128,0}));
        connect(voltageSource_m.plug_n, star_m.plug_p) annotation (Line(
            points={{-60,-40},{-60,-50}}, color={0,0,255}));
        connect(voltageSource_m.plug_n, converter_m.plug_n) annotation (Line(
            points={{-60,-40},{0,-40}}, color={0,0,255}));
        connect(voltageSource_e.plug_p, resistor_e.plug_p) annotation (Line(
            points={{-60,80},{-40,80}}, color={0,0,255}));
        connect(resistor_e.plug_n, inductor_e.plug_p) annotation (Line(
            points={{-20,80},{0,80}}, color={0,0,255}));
        connect(voltageSource_m.plug_p, resistor_m.plug_p) annotation (Line(
            points={{-60,-20},{-40,-20}}, color={0,0,255}));
        connect(resistor_m.plug_n, converter_m.plug_p) annotation (Line(
            points={{-20,-20},{0,-20}}, color={0,0,255}));
        connect(star_e.pin_n, ground_e.p) annotation (Line(
            points={{-60,30},{-60,30}}, color={0,0,255}));
        connect(star_m.pin_n, ground_m.p) annotation (Line(
            points={{-60,-70},{-60,-70}}, color={0,0,255}));
        annotation (experiment(StopTime=100, Interval=0.01));
      end MultiPhaseInductance;
    end Components;

    package BasicMachines "Examples of machines of the FundamentalWave library"
      extends Modelica.Icons.ExamplesPackage;
      model AIMC_DOL
        "Direct on line (DOL) start of asynchronous induction machine with squirrel cage"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of stator phases";
        parameter Modelica.SIunits.Voltage VsNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=aimcData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.Time tOn=0.1 "Start time of machine";
        parameter Modelica.SIunits.Torque T_Load=161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity w_Load(displayUnit="rev/min")=
             1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
        parameter Modelica.SIunits.Inertia J_Load=0.29 "Load inertia";
        parameter Integer p=2 "Number of pole pairs";
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          freqHz=fill(fNominal, m),
          V=fill(sqrt(2.0/3.0)*VsNominal, m)) annotation (Placement(
              transformation(
              origin={-30,90},
              extent={{10,-10},{-10,10}})));
        Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
          final m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m)) annotation (Placement(transformation(
              origin={0,60},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Blocks.Sources.BooleanStep booleanStep[m](each startTime=tOn, each
            startValue=false) annotation (Placement(transformation(extent={{-60,
                  50},{-40,70}})));
        Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
          currentRMSsensorM annotation (Placement(transformation(
              origin={0,30},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
          currentRMSsensorE annotation (Placement(transformation(
              origin={-60,30},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
            terminalConnection="D") annotation (Placement(transformation(extent={{-10,-14},
                  {10,6}})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxE(
            terminalConnection="D") annotation (Placement(transformation(extent={{-10,-74},
                  {10,-54}})));
        Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
          aimcM(
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          Rs=aimcData.Rs,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Lssigma=aimcData.Lssigma,
          Lszero=aimcData.Lszero,
          frictionParameters=aimcData.frictionParameters,
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          Lm=aimcData.Lm,
          Lrsigma=aimcData.Lrsigma,
          Rr=aimcData.Rr,
          TrRef=aimcData.TrRef,
          alpha20r(displayUnit="1/K") = aimcData.alpha20r,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          TsOperational=293.15,
          effectiveStatorTurns=aimcData.effectiveStatorTurns,
          TrOperational=293.15) annotation (Placement(transformation(extent={{-10,
                  -30},{10,-10}})));
        Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
          aimcE(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          Rs=aimcData.Rs,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Lszero=aimcData.Lszero,
          Lssigma=aimcData.Lssigma,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          Lm=aimcData.Lm,
          Lrsigma=aimcData.Lrsigma,
          Rr=aimcData.Rr,
          alpha20r(displayUnit="1/K") = aimcData.alpha20r,
          TsOperational=293.15,
          TrRef=aimcData.TrRef,
          TrOperational=293.15) annotation (Placement(transformation(extent={{-10,
                  -90},{10,-70}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=J_Load)
          annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertiaE(J=J_Load)
          annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorqueM(
          w_nominal=w_Load,
          tau_nominal=-T_Load,
          TorqueDirection=false,
          useSupport=false) annotation (Placement(transformation(extent={{100,-30},
                  {80,-10}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorqueE(
          w_nominal=w_Load,
          tau_nominal=-T_Load,
          TorqueDirection=false,
          useSupport=false) annotation (Placement(transformation(extent={{100,-90},
                  {80,-70}})));
        parameter
          Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData
          aimcData
          annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
        Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor
          currentQuasiRMSSensor annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=270,
              origin={0,10})));
      initial equation
        aimcE.is = zeros(m);
        aimcE.ir = zeros(2);
        aimcM.is = zeros(m);
        aimcM.rotorCage.electroMagneticConverter.Phi = Complex(0, 0);

      equation
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(sineVoltage.plug_n, star.plug_p) annotation (Line(points={{-40,
                90},{-40,90},{-50,90}}, color={0,0,255}));
        connect(aimcM.flange, loadInertiaM.flange_a) annotation (Line(points={{
                10,-20},{10,-20},{50,-20}}));
        connect(loadInertiaM.flange_b, quadraticLoadTorqueM.flange)
          annotation (Line(points={{70,-20},{80,-20}}));
        connect(terminalBoxM.plug_sn, aimcM.plug_sn)
          annotation (Line(points={{-6,-10},{-6,-10}}, color={0,0,255}));
        connect(terminalBoxM.plug_sp, aimcM.plug_sp)
          annotation (Line(points={{6,-10},{6,-10}}, color={0,0,255}));
        connect(aimcE.flange, loadInertiaE.flange_a) annotation (Line(points={{
                10,-80},{10,-80},{50,-80}}));
        connect(loadInertiaE.flange_b, quadraticLoadTorqueE.flange)
          annotation (Line(points={{70,-80},{80,-80}}));
        connect(terminalBoxE.plug_sn, aimcE.plug_sn)
          annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
        connect(terminalBoxE.plug_sp, aimcE.plug_sp)
          annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
        connect(currentRMSsensorE.plug_n, terminalBoxE.plugSupply) annotation (
            Line(points={{-60,20},{-60,-60},{0,-60},{0,-68}}, color={0,0,255}));
        connect(sineVoltage.plug_p, idealCloser.plug_p) annotation (Line(
            points={{-20,90},{0,90},{0,70}},
            color={0,0,255}));
        connect(idealCloser.plug_n, currentRMSsensorM.plug_p) annotation (Line(
            points={{0,50},{0,47.5},{0,45},{0,
                40}},
            color={0,0,255}));
        connect(booleanStep.y, idealCloser.control) annotation (Line(
            points={{-39,60},{-12,60}},color={255,0,255}));
        connect(currentRMSsensorE.plug_p, idealCloser.plug_n) annotation (Line(
            points={{-60,40},{0,40},{0,50}},
            color={0,0,255}));
        connect(currentRMSsensorM.plug_n, currentQuasiRMSSensor.plug_p)
          annotation (Line(
            points={{0,20},{0,20}},
            color={0,0,255}));
        connect(terminalBoxM.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{0,-8},{0,0}},
            color={0,0,255}));
        annotation (experiment(
            StopTime=1.5,
            Interval=1E-4,
            Tolerance=1e-06), Documentation(info="<html>
<p>
At start time tStart three phase voltage is supplied to the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage\">asynchronous induction machine with squirrel cage</a>.
The machine starts from standstill, accelerating
inertias against load torque quadratic dependent on speed, finally reaching nominal speed.</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>currentRMSsensorM|E.I</code>: equivalent RMS stator current</li>
<li><code>aimcM|E.wMechanical</code>: machine speed</li>
<li><code>aimcM|E.tauElectrical</code>: machine torque</li>
</ul>
</html>"));
      end AIMC_DOL;

      model AIMC_DOL_MultiPhase
        "Direct on line start of multi phase asynchronous induction machine with squirrel cage"
        extends Modelica.Icons.Example;
        constant Integer m3=3 "Number of stator phases of threephase system";
        parameter Integer m=5 "Number of stator phases";
        parameter Modelica.SIunits.Voltage VsNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=aimcData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.Time tOn=0.1 "Start time of machine";
        parameter Modelica.SIunits.Torque T_Load=161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity w_Load(displayUnit="rev/min")=
             1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
        parameter Modelica.SIunits.Inertia J_Load=0.29 "Load inertia";
        parameter Integer p=2 "Number of pole pairs";
        Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
              transformation(
              origin={-90,50},
              extent={{-10,-10},{10,10}})));
        Modelica.Electrical.MultiPhase.Basic.Star starM(final m=m) annotation (
            Placement(transformation(extent={{-70,62},{-90,82}})));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltageM(
          final m=m,
          freqHz=fill(fNominal, m),
          V=fill(sqrt(2.0)*VsNominal, m),
          phase=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
              m)) annotation (Placement(transformation(
              origin={-50,72},
              extent={{10,-10},{-10,10}})));
        Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloserM(
          final m=m,
          Ron=fill(1e-5*m/m3, m),
          Goff=fill(1e-5*m3/m, m)) annotation (Placement(transformation(
              origin={-20,72},
              extent={{-10,10},{10,-10}})));
        Blocks.Sources.BooleanStep booleanStepM[m](each startTime=tOn, each
            startValue=false) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,40})));
        Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSsensorM(m=
             m) annotation (Placement(transformation(
              origin={10,72},
              extent={{-10,-10},{10,10}})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(m=m,
            terminalConnection="Y") annotation (Placement(transformation(extent={{20,56},
                  {40,76}})));
        Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
          aimcM(
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          frictionParameters=aimcData.frictionParameters,
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          TrRef=aimcData.TrRef,
          alpha20r(displayUnit="1/K") = aimcData.alpha20r,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          m=m,
          Rs=aimcData.Rs*m/3,
          Lssigma=aimcData.Lssigma*m/3,
          Lszero=aimcData.Lszero*m/3,
          Lm=aimcData.Lm*m/3,
          Lrsigma=aimcData.Lrsigma*m/3,
          Rr=aimcData.Rr*m/3,
          TsOperational=293.15,
          effectiveStatorTurns=aimcData.effectiveStatorTurns,
          TrOperational=293.15) annotation (Placement(transformation(extent={{
                  20,40},{40,60}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=J_Load)
          annotation (Placement(transformation(extent={{50,40},{70,60}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorqueM(
          w_nominal=w_Load,
          tau_nominal=-T_Load,
          TorqueDirection=false,
          useSupport=false) annotation (Placement(transformation(extent={{100,
                  40},{80,60}})));
        parameter
          Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData
          aimcData annotation (Placement(transformation(extent={{-100,-100},{-80,
                  -80}})));
        Modelica.Electrical.Analog.Basic.Ground ground3 annotation (Placement(
              transformation(
              origin={-90,-52},
              extent={{-10,-10},{10,10}})));
        Modelica.Electrical.MultiPhase.Basic.Star star3(final m=m3) annotation (
           Placement(transformation(extent={{-70,-40},{-90,-20}})));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage3(
          final m=m3,
          V=fill(sqrt(2.0)*VsNominal, m3),
          phase=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
              m3),
          freqHz=fill(fNominal, m3)) annotation (Placement(transformation(
              origin={-50,-30},
              extent={{10,-10},{-10,10}})));
        Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser3(
          final m=m3,
          Ron=fill(1e-5, m3),
          Goff=fill(1e-5, m3)) annotation (Placement(transformation(
              origin={-20,-30},
              extent={{-10,10},{10,-10}})));
        Blocks.Sources.BooleanStep booleanStep3[m3](each startTime=tOn, each
            startValue=false) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-20,-62})));
        Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentRMSsensor3(m=3)
          annotation (Placement(transformation(
              origin={10,-30},
              extent={{-10,10},{10,-10}})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox3(
            terminalConnection="Y", m=m3) annotation (Placement(transformation(
                extent={{20,-46},{40,-26}})));
        Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
          aimc3(
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          Rs=aimcData.Rs,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Lssigma=aimcData.Lssigma,
          Lszero=aimcData.Lszero,
          frictionParameters=aimcData.frictionParameters,
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          Lm=aimcData.Lm,
          Lrsigma=aimcData.Lrsigma,
          Rr=aimcData.Rr,
          TrRef=aimcData.TrRef,
          alpha20r(displayUnit="1/K") = aimcData.alpha20r,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          m=3,
          TsOperational=293.15,
          effectiveStatorTurns=aimcData.effectiveStatorTurns,
          TrOperational=293.15) annotation (Placement(transformation(extent={{
                  20,-62},{40,-42}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia3(J=J_Load)
          annotation (Placement(transformation(extent={{50,-62},{70,-42}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorque3(
          w_nominal=w_Load,
          tau_nominal=-T_Load,
          TorqueDirection=false,
          useSupport=false) annotation (Placement(transformation(extent={{100,-62},
                  {80,-42}})));
        Blocks.Math.Gain gain(k=(m/m3)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={10,32})));
        Blocks.Math.Feedback feedback
          annotation (Placement(transformation(extent={{80,10},{100,-10}})));
      initial equation
        aimc3.is[1:2] = zeros(2);
        aimc3.ir[1:2] = zeros(2);
        aimcM.is[1:2] = zeros(2);
        aimcM.rotorCage.electroMagneticConverter.Phi = Complex(0, 0);

      equation
        connect(starM.pin_n, groundM.p) annotation (Line(points={{-90,72},{-90,
                70},{-90,60}}, color={0,0,255}));
        connect(sineVoltageM.plug_n, starM.plug_p) annotation (Line(points={{-60,
                72},{-60,72},{-70,72}}, color={0,0,255}));
        connect(aimcM.flange, loadInertiaM.flange_a)
          annotation (Line(points={{40,50},{40,50},{50,50}}));
        connect(terminalBoxM.plug_sn, aimcM.plug_sn)
          annotation (Line(points={{24,60},{24,60}}, color={0,0,255}));
        connect(terminalBoxM.plug_sp, aimcM.plug_sp)
          annotation (Line(points={{36,60},{36,60}}, color={0,0,255}));
        connect(sineVoltageM.plug_p, idealCloserM.plug_p) annotation (Line(
            points={{-40,72},{-30,72}},
            color={0,0,255}));
        connect(idealCloserM.plug_n, currentRMSsensorM.plug_p) annotation (Line(
            points={{-10,72},{0,72}},
            color={0,0,255}));
        connect(booleanStepM.y, idealCloserM.control) annotation (Line(
            points={{-20,51},{-20,60}}, color={255,0,255}));
        connect(star3.pin_n, ground3.p)
          annotation (Line(points={{-90,-30},{-90,-42}}, color={0,0,255}));
        connect(sineVoltage3.plug_n, star3.plug_p) annotation (Line(points={{-60,
                -30},{-60,-30},{-70,-30}}, color={0,0,255}));
        connect(aimc3.flange, loadInertia3.flange_a) annotation (Line(points={{
                40,-52},{40,-52},{50,-52}}));
        connect(loadInertia3.flange_b, quadraticLoadTorque3.flange) annotation (
           Line(points={{70,-52},{74,-52},{76,-52},{80,-52}}));
        connect(terminalBox3.plug_sn, aimc3.plug_sn)
          annotation (Line(points={{24,-42},{24,-42}}, color={0,0,255}));
        connect(terminalBox3.plug_sp, aimc3.plug_sp)
          annotation (Line(points={{36,-42},{36,-42}}, color={0,0,255}));
        connect(terminalBox3.plugSupply, currentRMSsensor3.plug_n) annotation (
            Line(points={{30,-40},{30,-30},{20,-30}}, color={0,0,255}));
        connect(sineVoltage3.plug_p, idealCloser3.plug_p) annotation (Line(
            points={{-40,-30},{-30,-30}},
            color={0,0,255}));
        connect(idealCloser3.plug_n, currentRMSsensor3.plug_p) annotation (Line(
            points={{-10,-30},{0,-30}},
            color={0,0,255}));
        connect(booleanStep3.y, idealCloser3.control) annotation (Line(
            points={{-20,-51},{-20,-42}}, color={255,0,255}));
        connect(currentRMSsensorM.I, gain.u) annotation (Line(
            points={{10,61},{10,44}}, color={0,0,127}));
        connect(loadInertiaM.flange_b, quadraticLoadTorqueM.flange) annotation (
           Line(
            points={{70,50},{80,50}}));
        connect(currentRMSsensor3.I, feedback.u1) annotation (Line(
            points={{10,-19},{10,0},{82,0}},
            color={0,0,127}));
        connect(feedback.u2, gain.y) annotation (Line(
            points={{90,8},{90,16},{10,16},{10,21}},
            color={0,0,127}));
        connect(currentRMSsensorM.plug_n, terminalBoxM.plugSupply) annotation (
            Line(
            points={{20,72},{30,72},{30,62}},
            color={0,0,255}));
        annotation (
          experiment(
            StopTime=1.5,
            Interval=1E-4,
            Tolerance=1e-06),
          Documentation(info="<html>
<p>
At start time tStart voltages are supplied to the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage\">multi phase asynchronous induction machines with squirrel cage</a>.
The machines starts from standstill, accelerating
inertias against load torque quadratic dependent on speed, finally reaching nominal speed. Two equivalent machines with different numbers of phases are compared and their equal behavior is demonstrated.</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>aimcM|M3.tauElectrical</code>: machine torque</li>
<li><code>aimsM/M3.wMechanical</code>: machine speed</li>
<li><code>feedback.y</code>: zero since difference of three phase current phasor and scaled multi phase current phasor are equal</li>
</ul>
</html>"),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                               graphics={       Text(
                      extent={{20,88},{100,80}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      textString="%m phase machine",
                      textStyle={TextStyle.Bold}),Text(
                      extent={{20,-22},{100,-30}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      textString="3 phase machine",
                      textStyle={TextStyle.Bold})}));
      end AIMC_DOL_MultiPhase;

      model AIMC_YD "Asynchronous induction machine with squirrel cage starting Y-D"

        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=aimcData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.Time tStart1=0.1 "Start time";
        parameter Modelica.SIunits.Time tStart2=2.0 "Start time from Y to D";
        parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="rev/min")=
             1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          TrRef=aimcData.TrRef,
          Rs=aimcData.Rs*m/3,
          Lssigma=aimcData.Lssigma*m/3,
          Lszero=aimcData.Lszero*m/3,
          Lm=aimcData.Lm*m/3,
          Lrsigma=aimcData.Lrsigma*m/3,
          Rr=aimcData.Rr*m/3,
          TsOperational=293.15,
          effectiveStatorTurns=aimcData.effectiveStatorTurns,
          alpha20r=aimcData.alpha20r,
          TrOperational=293.15) annotation (Placement(transformation(extent={{20,10},{40,30}})));
        Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270,
              origin={30,70})));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          freqHz=fill(fNominal, m),
          V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
              origin={-30,90},
              extent={{10,10},{-10,-10}})));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=
              tStart1) annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
        Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
          final m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m)) annotation (Placement(transformation(
              origin={0,90},
              extent={{-10,10},{10,-10}})));
        Electrical.Machines.Utilities.SwitchYD switchYD(m=m) annotation (Placement(transformation(extent={{20,30},{40,50}})));
        Modelica.Blocks.Sources.BooleanStep booleanStepYD[m](each startTime=
              tStart2) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{50,10},{70,30}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorque(
          w_nominal=wLoad,
          TorqueDirection=false,
          tau_nominal=-TLoad,
          useSupport=false) annotation (Placement(transformation(extent={{100,10},{80,30}})));
        parameter Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData aimcData annotation (Placement(transformation(extent={{70,72},{90,92}})));
      initial equation
        aimc.is = zeros(3);
        aimc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);
      equation
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(sineVoltage.plug_n, star.plug_p)
          annotation (Line(points={{-40,90},{-50,90}},      color={0,0,255}));
        connect(sineVoltage.plug_p, idealCloser.plug_p) annotation (Line(points={{-20,90},{-20,90},{-10,90},{-10,90}},
                                              color={0,0,255}));
        connect(loadInertia.flange_b, quadraticLoadTorque.flange)
          annotation (Line(points={{70,20},{80,20}}));
        connect(booleanStep.y, idealCloser.control) annotation (Line(points={{-59,60},{0,60},{0,78}},
                                                color={255,0,255}));
        connect(booleanStepYD.y, switchYD.control)
          annotation (Line(points={{-19,40},{18,40}},    color={255,0,255}));
        connect(idealCloser.plug_n, currentQuasiRMSSensor.plug_p)
          annotation (Line(points={{10,90},{30,90},{30,90},{30,90},{30,80},{30,80}},
                                                          color={0,0,255}));
        connect(switchYD.plug_sn, aimc.plug_sn) annotation (Line(
            points={{24,30},{24,30}},     color={0,0,255}));
        connect(switchYD.plug_sp, aimc.plug_sp) annotation (Line(
            points={{36,30},{36,30}},   color={0,0,255}));
        connect(switchYD.plugSupply, currentQuasiRMSSensor.plug_n) annotation (
            Line(
            points={{30,50},{30,50},{30,56},{30,56},{30,60}},
                                        color={0,0,255}));
        connect(aimc.flange, loadInertia.flange_a) annotation (Line(
            points={{40,20},{50,20}}));
        annotation (experiment(
            StopTime=2.5,
            Interval=1E-4,
            Tolerance=1e-06),                                 Documentation(
              info="<html>
<p>At start time tStart three phase voltage is supplied to the asynchronous induction machine with squirrel cage,
first star-connected, then delta-connected; the machine starts from standstill,
accelerating inertias against load torque quadratic dependent on speed, finally reaching nominal speed.</p>

<p>Simulate for 2.5 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
      end AIMC_YD;

      model AIMC_Transformer "Asynchronous induction machine with squirrel cage starting with transformer"

        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=aimcData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.Time tStart1=0.1 "Start time";
        parameter Modelica.SIunits.Time tStart2=2.0
          "Start time of bypass transformer";
        parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="rev/min")=
             1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          TrRef=aimcData.TrRef,
          Rs=aimcData.Rs*m/3,
          Lssigma=aimcData.Lssigma*m/3,
          Lszero=aimcData.Lszero*m/3,
          Lm=aimcData.Lm*m/3,
          Lrsigma=aimcData.Lrsigma*m/3,
          Rr=aimcData.Rr*m/3,
          TsOperational=293.15,
          effectiveStatorTurns=aimcData.effectiveStatorTurns,
          alpha20r=aimcData.alpha20r,
          TrOperational=293.15) annotation (Placement(transformation(extent={{80,10},{60,30}})));
        Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (Placement(transformation(
              origin={-40,80},
              extent={{-10,10},{10,-10}})));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          freqHz=fill(fNominal, m),
          V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
              origin={-70,80},
              extent={{10,10},{-10,-10}})));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-80,50})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-80,20},
              extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Sources.BooleanStep booleanStep1[m](each startTime=
              tStart1) annotation (Placement(transformation(extent={{-60,40},{-40,
                  60}})));
        Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
          final m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m)) annotation (Placement(transformation(
              origin={-10,80},
              extent={{-10,10},{10,-10}})));
        Electrical.Machines.BasicMachines.Transformers.Yy.Yy00 transformer(
          n=transformerData.n,
          R1=transformerData.R1,
          L1sigma=transformerData.L1sigma,
          R2=transformerData.R2,
          L2sigma=transformerData.L2sigma,
          T1Ref=293.15,
          alpha20_1(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          T2Ref=293.15,
          alpha20_2(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          T1Operational=293.15,
          T2Operational=293.15) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={20,80})));

        Modelica.Electrical.Analog.Basic.Ground ground2 annotation (Placement(
              transformation(
              origin={20,50},
              extent={{-10,-10},{10,10}})));
        parameter Electrical.Machines.Utilities.TransformerData transformerData(
          f=fNominal,
          V1=VNominal,
          C1=Modelica.Utilities.Strings.substring(
              transformer.VectorGroup,
              1,
              1),
          V2=VNominal/sqrt(3),
          C2=Modelica.Utilities.Strings.substring(
              transformer.VectorGroup,
              2,
              2),
          SNominal=50E3,
          v_sc=0.06,
          P_sc=500) annotation (Placement(transformation(extent={{80,80},{100,100}})));
        Modelica.Blocks.Sources.BooleanStep booleanStep2[m](each startTime=
              tStart2) annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
        Modelica.Electrical.MultiPhase.Ideal.IdealCommutingSwitch
          idealCommutingSwitch(
          final m=m,
          Ron=fill(1e-5, m),
          Goff=fill(50E-5, m)) annotation (Placement(transformation(
              extent={{60,90},{40,70}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{50,10},{30,30}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorque(
          w_nominal=wLoad,
          TorqueDirection=false,
          tau_nominal=-TLoad,
          useSupport=false) annotation (Placement(transformation(extent={{0,10},{20,30}})));
        Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="D") annotation (Placement(transformation(extent={{80,26},{60,46}})));
        parameter Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData aimcData annotation (Placement(transformation(extent={{80,52},{100,72}})));
      initial equation
        aimc.is = zeros(3);
        aimc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);
        transformer.i1[1:2] = zeros(2);
      equation
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-80,40},{-80,40},{-80,34},{-80,34},{-80,30},{-80,30}},
                                                       color={0,0,255}));
        connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
            points={{76,30},{76,30}},     color={0,0,255}));
        connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
            points={{64,30},{64,30}},   color={0,0,255}));
        connect(loadInertia.flange_b, quadraticLoadTorque.flange) annotation (
            Line(
            points={{30,20},{20,20}}));
        connect(aimc.flange, loadInertia.flange_a) annotation (Line(
            points={{60,20},{50,20}}));
        connect(star.plug_p, sineVoltage.plug_n) annotation (Line(
            points={{-80,60},{-80,80}}, color={0,0,255}));
        connect(booleanStep2.y, idealCommutingSwitch.control) annotation (Line(
            points={{-39,20},{-30,20},{-30,20},{-10,20},{-10,40},{50,40},{50,68}},
                                     color={255,0,255}));
        connect(transformer.starpoint2, ground2.p) annotation (Line(
            points={{25,70},{25,60},{20,60}},    color={0,0,255}));
        connect(idealCommutingSwitch.plug_p, terminalBox.plugSupply)
          annotation (Line(
            points={{60,80},{60,80},{68,80},{68,80},{70,80},{70,32},{70,32}},
                                                  color={0,0,255}));
        connect(transformer.plug2, idealCommutingSwitch.plug_n1) annotation (
            Line(
            points={{30,80},{40,80},{40,76}},  color={0,0,255}));
        connect(sineVoltage.plug_p, currentQuasiRMSSensor.plug_p) annotation (
            Line(
            points={{-60,80},{-50,80}},
                                      color={0,0,255}));
        connect(booleanStep1.y, idealCloser.control) annotation (Line(
            points={{-39,50},{-10,50},{-10,68},{-10,68}},
                                       color={255,0,255}));
        connect(currentQuasiRMSSensor.plug_n, idealCloser.plug_p) annotation (
            Line(
            points={{-30,80},{-20,80}},
                                    color={0,0,255}));
        connect(transformer.plug1, idealCloser.plug_n) annotation (Line(
            points={{10,80},{0,80}},  color={0,0,255}));
        connect(idealCloser.plug_n, idealCommutingSwitch.plug_n2) annotation (
            Line(
            points={{0,80},{0,80},{0,100},{40,100},{40,80}},
                                    color={0,0,255}));
        annotation (experiment(StopTime=2.5, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>At start time tStart1 three phase voltage is supplied to the asynchronous induction machine with squirrel cage via the transformer;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed;
at start time tStart2 the machine is fed directly from the voltage source, finally reaching nominal speed.</p>

<p>Simulate for 2.5 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
      end AIMC_Transformer;

      model AIMC_Inverter "Asynchronous induction machine with squirrel cage and inverter"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=aimcData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.Frequency f=fNominal "Maximum operational frequency";
        Modelica.SIunits.Frequency fActual=ramp.y "Actual frequency";
        parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
        parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
        parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          TrRef=aimcData.TrRef,
          Rs=aimcData.Rs*m/3,
          Lssigma=aimcData.Lssigma*m/3,
          Lszero=aimcData.Lszero*m/3,
          Lm=aimcData.Lm*m/3,
          Lrsigma=aimcData.Lrsigma*m/3,
          Rr=aimcData.Rr*m/3,
          TsOperational=293.15,
          effectiveStatorTurns=aimcData.effectiveStatorTurns,
          alpha20r=aimcData.alpha20r,
          TrOperational=293.15) annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
        Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (Placement(transformation(extent={{-10,10},{10,-10}}, rotation=270)));
        Modelica.Blocks.Sources.Ramp ramp(height=f, duration=tRamp) annotation (
           Placement(transformation(extent={{-80,50},{-60,70}})));
        Electrical.Machines.Utilities.VfController vfController(
          final m=m,
          VNominal=VNominal,
          fNominal=fNominal) annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
        Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(
            final m=m) annotation (Placement(transformation(
              origin={0,60},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep loadTorqueStep(
          startTime=tStep,
          stepTorque=-TLoad,
          useSupport=false,
          offsetTorque=0) annotation (Placement(transformation(extent={{90,-50},
                  {70,-30}})));
        Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y") annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        parameter Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData aimcData annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
      initial equation
        aimc.is[1:2] = zeros(2);
        aimc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);
      equation
        connect(signalVoltage.plug_n, star.plug_p)
          annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(ramp.y, vfController.u)
          annotation (Line(points={{-59,60},{-42,60}}, color={0,0,255}));
        connect(vfController.y, signalVoltage.v)
          annotation (Line(points={{-19,60},{-12,60}},color={0,0,255}));
        connect(loadTorqueStep.flange, loadInertia.flange_b)
          annotation (Line(points={{70,-40},{60,-40}}));
        connect(signalVoltage.plug_p, currentQuasiRMSSensor.plug_p)
          annotation (Line(points={{0,50},{0,40},{0,10}}, color={0,0,255}));
        connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{-10,-28},{-10,-20},{0,-20},{0,-10}}, color={0,0,255}));
        connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}}, color={0,0,255}));
        connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}}, color={0,0,255}));
        connect(aimc.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        annotation (experiment(StopTime=1.5, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>An ideal frequency inverter is modeled by using a VfController and a three-phase SignalVoltage.
Frequency is raised by a ramp, causing the asynchronous induction machine with squirrel cage to start,
and accelerating inertias. At time tStep a load step is applied.</p>

<p>Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>
Default machine parameters are used.
</html>"));
      end AIMC_Inverter;

      model AIMC_Conveyor "Asynchronous induction machine with squirrel cage and inverter driving a conveyor"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        constant Modelica.SIunits.Frequency unitFrequency=1 annotation(HideResult=true);
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=aimcData.fsNominal
          "Nominal frequency";
        parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*fNominal/aimcData.p
          "Nominal speed";
        parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        parameter Modelica.SIunits.Length r=0.05 "Transmission radius";
        Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
                                                                                         aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          TrRef=aimcData.TrRef,
          Rs=aimcData.Rs*m/3,
          Lssigma=aimcData.Lssigma*m/3,
          Lszero=aimcData.Lszero*m/3,
          Lm=aimcData.Lm*m/3,
          Lrsigma=aimcData.Lrsigma*m/3,
          Rr=aimcData.Rr*m/3,
          TsOperational=293.15,
          effectiveStatorTurns=aimcData.effectiveStatorTurns,
          alpha20r=aimcData.alpha20r,
          TrOperational=293.15) annotation (Placement(transformation(extent={{60,10},{40,30}})));
        Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (Placement(transformation(extent={{20,100},{40,80}})));
        Blocks.Sources.CombiTimeTable
                                 dutyCycle(table=[0,0; 1,1; 4,1; 5,0; 10,0; 11,
              -1; 14,-1; 15,0; 20,0], extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
          annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
        Electrical.Machines.Utilities.VfController vfController(
          final m=m,
          VNominal=VNominal,
          fNominal=fNominal) annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
        Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(
            final m=m) annotation (Placement(transformation(
              origin={0,90},
              extent={{10,10},{-10,-10}})));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-40,80},{-60,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-70,70},
              extent={{-10,-10},{10,10}})));
        Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y") annotation (Placement(transformation(extent={{60,26},{40,46}})));
        parameter Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData aimcData annotation (Placement(transformation(extent={{70,72},{90,92}})));
        Blocks.Math.Gain gain(k=fNominal/unitFrequency)
          annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
        Mechanics.Translational.Components.IdealGearR2T idealGearR2T(ratio=1/r)
          annotation (Placement(transformation(extent={{32,10},{12,30}})));
        Mechanics.Translational.Components.Mass mass(m=JLoad/r^2)
          annotation (Placement(transformation(extent={{0,10},{-20,30}})));
        Mechanics.Translational.Sources.SignForce signForce(                           v0(
              displayUnit="m/s") = 0.01*wNominal*r, f_nominal=-TLoad/r)
          annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
      initial equation
        aimc.is[1:2] = zeros(2);
        aimc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);
      equation
        connect(signalVoltage.plug_n, star.plug_p)
          annotation (Line(points={{-10,90},{-40,90}},      color={0,0,255}));
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-60,90},{-70,90},{-70,80}},
                                                       color={0,0,255}));
        connect(vfController.y, signalVoltage.v)
          annotation (Line(points={{-9,50},{0,50},{0,78}},
                                                      color={0,0,255}));
        connect(signalVoltage.plug_p, currentQuasiRMSSensor.plug_p)
          annotation (Line(points={{10,90},{20,90}},      color={0,0,255}));
        connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{50,32},{50,90},{40,90}},             color={0,0,255}));
        connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
            points={{56,30},{56,30}},     color={0,0,255}));
        connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
            points={{44,30},{44,30}},   color={0,0,255}));
        connect(vfController.u, gain.y)
          annotation (Line(points={{-32,50},{-39,50}}, color={0,0,127}));
        connect(dutyCycle.y[1], gain.u)
          annotation (Line(points={{-79,50},{-62,50}}, color={0,0,127}));
        connect(aimc.flange, idealGearR2T.flangeR)
          annotation (Line(points={{40,20},{32,20}}));
        connect(idealGearR2T.flangeT, mass.flange_a)
          annotation (Line(points={{12,20},{0,20}},             color={0,127,0}));
        connect(mass.flange_b, signForce.flange)
          annotation (Line(points={{-20,20},{-30,20}},          color={0,127,0}));
        annotation (experiment(StopTime=20, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>An ideal frequency inverter is modeled by using a VfController and a three-phase SignalVoltage.
Frequency is driven by a load cycle of acceleration, constant speed, deceleration and standstill.
The mechanical load is a constant torque like a conveyor (with regularization around zero speed).</p>

<p>Simulate for 20 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>
<p>Default machine parameters are used.</p>
</html>"));
      end AIMC_Conveyor;

      model AIMC_Steinmetz "Asynchronous induction machine with squirrel cage and Steinmetz-connection"

        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=aimcData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.Time tStart1=0.1 "Start time";
        parameter Modelica.SIunits.Capacitance Cr=0.0035
          "Motor's running capacitor";
        parameter Modelica.SIunits.Capacitance Cs=5*Cr
          "Motor's (additional) starting capacitor";
        parameter Modelica.SIunits.AngularVelocity wSwitch(displayUnit="rev/min")=
             1350*2*Modelica.Constants.pi/60
          "Speed for switching off the starting capacitor";
        parameter Modelica.SIunits.Torque TLoad=2/3*161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="rev/min")=
             1462.5*2*Modelica.Constants.pi/60 "Nominal load speed";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
                                                                                         aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          TrRef=aimcData.TrRef,
          Rs=aimcData.Rs*m/3,
          Lssigma=aimcData.Lssigma*m/3,
          Lszero=aimcData.Lszero*m/3,
          Lm=aimcData.Lm*m/3,
          Lrsigma=aimcData.Lrsigma*m/3,
          Rr=aimcData.Rr*m/3,
          TsOperational=293.15,
          effectiveStatorTurns=aimcData.effectiveStatorTurns,
          alpha20r=aimcData.alpha20r,
          TrOperational=293.15) annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
        Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(freqHz=
              fNominal, V=sqrt(2)*VNominal) annotation (Placement(
              transformation(extent={{-50,90},{-70,70}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,80},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=tStart1)
          annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
        Modelica.Electrical.Analog.Ideal.IdealClosingSwitch idealCloser
          annotation (Placement(transformation(
              origin={-20,80},
              extent={{10,-10},{-10,10}},
              rotation=180)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorque(
          w_nominal=wLoad,
          TorqueDirection=false,
          tau_nominal=-TLoad,
          useSupport=false) annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
        Electrical.Machines.Utilities.TerminalBox TerminalBox1(terminalConnection="D") annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_p3(m=m, k=3)
          annotation (Placement(transformation(
              origin={-30,18},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_p2(m=m, k=2)
          annotation (Placement(transformation(
              origin={-10,18},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_p1(m=m, k=1)
          annotation (Placement(transformation(
              origin={10,18},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.Analog.Basic.Capacitor cRun(C=Cr) annotation (
            Placement(transformation(
              origin={10,40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Capacitor cStart(C=Cs) annotation (
            Placement(transformation(
              origin={30,40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch idealOpener
          annotation (Placement(transformation(
              origin={30,70},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=
              wSwitch) annotation (Placement(transformation(
              origin={60,40},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Mechanics.Rotational.Sensors.SpeedSensor relSpeedSensor annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={30,-20})));
        parameter Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData aimcData annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
        Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (Placement(transformation(
              origin={-10,-10},
              extent={{-10,10},{10,-10}},
              rotation=270)));
      initial equation
        aimc.is = zeros(3);
        aimc.rotorCage.electroMagneticConverter.V_m = Complex(0, 0);
        cStart.v = 0;
        cRun.v = 0;
      equation
        connect(ground.p, sineVoltage.n)
          annotation (Line(points={{-80,80},{-70,80}}, color={0,0,255}));
        connect(sineVoltage.p, idealCloser.p)
          annotation (Line(points={{-50,80},{-30,80}}, color={0,0,255}));
        connect(booleanStep.y, idealCloser.control) annotation (Line(points={{-29,50},{-20,50},{-20,68}},
                                        color={255,0,255}));
        connect(plugToPin_p3.pin_p, sineVoltage.n) annotation (Line(points={{-30,20},{-70,20},{-70,80}},
                                        color={0,0,255}));
        connect(idealCloser.n, plugToPin_p2.pin_p)
          annotation (Line(points={{-10,80},{-10,20}}, color={0,0,255}));
        connect(cRun.n, plugToPin_p1.pin_p)
          annotation (Line(points={{10,30},{10,20}}, color={0,0,255}));
        connect(loadInertia.flange_b, quadraticLoadTorque.flange)
          annotation (Line(points={{60,-40},{70,-40}}));
        connect(cRun.p, idealCloser.n) annotation (Line(points={{10,50},{10,80},{-10,80}},
                           color={0,0,255}));
        connect(plugToPin_p1.pin_p, cStart.n)
          annotation (Line(points={{10,20},{30,20},{30,30}}, color={0,0,255}));
        connect(idealOpener.n, cStart.p) annotation (Line(points={{30,60},{30,50}},
                                        color={0,0,255}));
        connect(idealOpener.p, idealCloser.n) annotation (Line(points={{30,80},{-10,80}},
                                   color={0,0,255}));
        connect(greaterThreshold.y, idealOpener.control) annotation (Line(
              points={{60,51},{60,70},{42,70}}, color={255,0,255}));
        connect(TerminalBox1.plug_sn, aimc.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}}, color={0,0,255}));
        connect(TerminalBox1.plug_sp, aimc.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}}, color={0,0,255}));
        connect(aimc.flange, loadInertia.flange_a) annotation (Line(
            points={{0,-40},{40,-40}}));
        connect(relSpeedSensor.flange, aimc.flange) annotation (Line(
            points={{20,-20},{20,-40},{0,-40}}));
        connect(relSpeedSensor.w, greaterThreshold.u) annotation (Line(
            points={{41,-20},{60,-20},{60,28}}, color={0,0,127}));
        connect(plugToPin_p3.plug_p, currentQuasiRMSSensor.plug_p) annotation (
            Line(
            points={{-30,16},{-30,0},{-10,0}}, color={0,0,255}));
        connect(plugToPin_p2.plug_p, currentQuasiRMSSensor.plug_p) annotation (
            Line(
            points={{-10,16},{-10,0}},         color={0,0,255}));
        connect(plugToPin_p1.plug_p, currentQuasiRMSSensor.plug_p) annotation (
            Line(
            points={{10,16},{10,0},{-10,0}}, color={0,0,255}));
        connect(currentQuasiRMSSensor.plug_n, TerminalBox1.plugSupply)
          annotation (Line(
            points={{-10,-20},{-10,-28}}, color={0,0,255}));
        annotation (experiment(Interval=0.0001, Tolerance=1e-06, StopTime=1),             Documentation(
              info="<html>
<p>At start time tStart single phase voltage is supplied to the asynchronous induction machine with squirrel cage;
the machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed,
finally reaching nominal speed.</p>

<p>Default machine parameters are used.</p>
</html>"));
      end AIMC_Steinmetz;

      model AIMC_withLosses "Asynchronous induction machine with squirrel cage and losses"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        import Modelica.Constants.pi;
        import Modelica.SIunits.Conversions.from_rpm;
        import Modelica.SIunits.Conversions.to_rpm;
        import Modelica.SIunits.Conversions.from_degC;
      protected
        parameter Modelica.SIunits.Power PNominal=18500 "Nominal output";
        parameter Modelica.SIunits.Voltage VNominal=400 "Nominal RMS voltage";
        parameter Modelica.SIunits.Current INominal=32.85 "Nominal RMS current";
        parameter Real pfNominal=0.898 "Nominal power factor";
        parameter Modelica.SIunits.Power PsNominal=sqrt(3)*VNominal*INominal*pfNominal "Nominal stator power";
        parameter Modelica.SIunits.Power lossNominal=PsNominal-PNominal "Nominal losses";
        parameter Real etaNominal=0.9049 "Nominal efficiency";
        parameter Modelica.SIunits.Frequency fNominal=aimcData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.AngularVelocity wNominal=from_rpm(1462.5)
          "Nominal speed";
        parameter Modelica.SIunits.Torque TNominal=PNominal/wNominal
          "Nominal torque";
        parameter Modelica.SIunits.Temperature TempNominal=from_degC(90)
          "Nominal temperature";
        Modelica.SIunits.Power Pel=electricalPowerSensor.P;
        Modelica.SIunits.ReactivePower Qel=electricalPowerSensor.Q;
        Modelica.SIunits.ApparentPower Sel=sqrt(Pel^2 + Qel^2);
        parameter Real Ptable[:]={1E-6,1845,3549,5325,7521,9372,11010,12930,
            14950,16360,18500,18560,20180,22170};
        parameter Real Itable[:]={11.0,11.20,12.27,13.87,16.41,18.78,21.07,
            23.92,27.05,29.40,32.85,32.95,35.92,39.35};
        parameter Real wtable[:]=from_rpm({1500,1496,1493,1490,1486,1482,1479,1475,1471,
            1467,1462,1462,1458,1453});
        parameter Real ctable[:]={0.085,0.327,0.506,0.636,0.741,0.797,0.831,
            0.857,0.875,0.887,0.896,0.896,0.902,0.906};
        parameter Real etable[:]={0,0.7250,0.8268,0.8698,0.8929,0.9028,0.9064,
            0.9088,0.9089,0.9070,0.9044,0.9043,0.9008,0.8972};
      public
        output Modelica.SIunits.Power Pmech=powerSensor.power "Mechanical output";
        output Modelica.SIunits.Power Ps_sim=sqrt(3)*VNominal*I_sim*pf_sim "Simulated stator power";
        output Modelica.SIunits.Power Ps_meas=sqrt(3)*VNominal*I_meas*pf_meas "Simulated stator power";
        output Modelica.SIunits.Power loss_sim=Ps_sim-Pmech "Simulated total losses";
        output Modelica.SIunits.Power loss_meas=Ps_meas-Pmech "Measured total losses";
        output Modelica.SIunits.Current I_sim=currentQuasiRMSSensor.I "Simulated current";
        output Modelica.SIunits.Current I_meas=combiTable1Ds.y[1] "Measured current";
        output Modelica.SIunits.AngularVelocity w_sim(displayUnit="rev/min")=aimc.wMechanical "Simulated speed";
        output Modelica.SIunits.AngularVelocity w_meas(displayUnit="rev/min")=combiTable1Ds.y[2] "Measured speed";
        output Real pf_sim=if noEvent(Sel > Modelica.Constants.small) then Pel/Sel else 0 "Simulated power factor";
        output Real pf_meas=combiTable1Ds.y[3] "Measured power factor";
        output Real eff_sim=if noEvent(abs(Pel) > Modelica.Constants.small) then Pmech/Pel else 0 "Simulated efficiency";
        output Real eff_meas=combiTable1Ds.y[4] "Measured efficiency";
        Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          phiMechanical(fixed=true),
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          TrRef=aimcData.TrRef,
          TsOperational=TempNominal,
          TrOperational=TempNominal,
          wMechanical(fixed=true, start=2*pi*aimcData.fsNominal/aimcData.p),
          Rs=aimcData.Rs*m/3,
          Lssigma=aimcData.Lssigma*m/3,
          Lszero=aimcData.Lszero*m/3,
          Lm=aimcData.Lm*m/3,
          Lrsigma=aimcData.Lrsigma*m/3,
          Rr=aimcData.Rr*m/3,
          effectiveStatorTurns=aimcData.effectiveStatorTurns,
          alpha20r=aimcData.alpha20r) annotation (Placement(transformation(extent={{-20,60},{0,80}})));
        Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="D") annotation (Placement(transformation(extent={{-20,76},{0,96}})));
        Electrical.Machines.Sensors.ElectricalPowerSensor electricalPowerSensor annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={-40,90})));
        Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (Placement(transformation(
              origin={-70,90},
              extent={{-10,10},{10,-10}})));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          freqHz=fill(fNominal, m),
          V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
              origin={-90,70},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-90,40})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,10},
              extent={{-10,-10},{10,10}})));
        Modelica.Mechanics.Rotational.Sensors.PowerSensor powerSensor
          annotation (Placement(transformation(extent={{10,60},{30,80}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=aimcData.Jr)
          annotation (Placement(transformation(extent={{40,60},{60,80}})));
        Modelica.Mechanics.Rotational.Sources.Torque torque
          annotation (Placement(transformation(extent={{90,60},{70,80}})));
        Modelica.Blocks.Math.Gain gain(k=-1)
          annotation (Placement(transformation(extent={{70,0},{90,20}})));
        Modelica.Blocks.Continuous.PI PI(
          k=0.01,
          T=0.01,
          initType=Modelica.Blocks.Types.Init.InitialState)
          annotation (Placement(transformation(extent={{40,0},{60,20}})));
        Modelica.Blocks.Math.Feedback feedback
          annotation (Placement(transformation(extent={{10,20},{30,0}})));
        Modelica.Blocks.Sources.Ramp ramp(
          height=1.2*PNominal,
          offset=0,
          startTime=4.5,
          duration=5.5)
          annotation (Placement(transformation(extent={{-20,0},{0,20}})));
        Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table={{Ptable[j],
              Itable[j],wtable[j],ctable[j],etable[j]} for j in 1:size(Ptable,
              1)}, smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
          annotation (Placement(transformation(extent={{40,30},{60,50}})));
        parameter Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData aimcData(
          statorCoreParameters(PRef=410, VRef=387.9),
          Jr=0.12,
          Rs=0.56,
          alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper,
          Lssigma=1.52/(2*pi*fNominal),
          frictionParameters(PRef=180, wRef=wNominal),
          strayLoadParameters(
            PRef=0.005*sqrt(3)*VNominal*INominal*pfNominal,
            IRef=INominal/sqrt(3),
            wRef=wNominal),
          Lm=66.4/(2*pi*fNominal),
          Lrsigma=2.31/(2*pi*fNominal),
          Rr=0.42,
          alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Aluminium) annotation (Placement(transformation(extent={{-60,12},{-40,32}})));

      initial equation
        sum(aimc.is) = 0;
        der(aimc.airGap.V_msr.re) = 0;
        der(aimc.airGap.V_msr.im) = 0;
        der(aimc.airGap.V_mrr.re) = 0;
        der(aimc.airGap.V_mrr.im) = 0;
      equation
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-90,30},{-90,20}}, color={0,0,255}));
        connect(sineVoltage.plug_n, star.plug_p)
          annotation (Line(points={{-90,60},{-90,50}}, color={0,0,255}));
        connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
            points={{-16,80},{-16,80}}, color={0,0,255}));
        connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
            points={{-4,80},{-4,80}},   color={0,0,255}));
        connect(currentQuasiRMSSensor.plug_n, electricalPowerSensor.plug_p)
          annotation (Line(
            points={{-60,90},{-60,90},{-54,90},{-54,90},{-50,90},{-50,90}},     color={0,0,255}));

        connect(electricalPowerSensor.plug_nv, star.plug_p) annotation (Line(
            points={{-40,80},{-40,80},{-40,50},{-90,50}},
                                        color={0,0,255}));
        connect(electricalPowerSensor.plug_ni, terminalBox.plugSupply)
          annotation (Line(
            points={{-30,90},{-30,90},{-10,90},{-10,90},{-10,90},{-10,82}},
                                        color={0,0,255}));
        connect(aimc.flange, powerSensor.flange_a) annotation (Line(
            points={{0,70},{10,70}}));
        connect(powerSensor.flange_b, loadInertia.flange_a) annotation (Line(
            points={{30,70},{40,70}}));
        connect(torque.flange, loadInertia.flange_b) annotation (Line(
            points={{70,70},{60,70}}));
        connect(gain.y, torque.tau) annotation (Line(
            points={{91,10},{100,10},{100,70},{92,70}}, color={0,0,127}));
        connect(sineVoltage.plug_p, currentQuasiRMSSensor.plug_p) annotation (
            Line(
            points={{-90,80},{-90,80},{-90,90},{-88,90},{-88,90},{-80,90}},
                                        color={0,0,255}));
        connect(powerSensor.power, feedback.u2) annotation (Line(
            points={{12,59},{12,40},{20,40},{20,18}},  color={0,0,127}));
        connect(feedback.y, PI.u) annotation (Line(
            points={{29,10},{38,10}},  color={0,0,127}));
        connect(PI.y, gain.u) annotation (Line(
            points={{61,10},{68,10}},   color={0,0,127}));
        connect(ramp.y, feedback.u1) annotation (Line(
            points={{1,10},{12,10}},     color={0,0,127}));
        connect(powerSensor.power, combiTable1Ds.u) annotation (Line(
            points={{12,59},{12,40},{38,40}},   color={0,0,127}));
        annotation (
          experiment(StopTime=5.0, Interval=1E-4, Tolerance=1e-06),
          Documentation(info="<html>
<ul>
<li>Simulate for 5 seconds: The machine is started at nominal speed, flux is build up in the machine.</li>
<li>Continue the simulation for additional 5 seconds: Subsequently a load ramp is applied.</li>
<li>Compare by plotting versus Pmech:</li>
</ul>
<table>
<tr><td>Current      </td><td>I_sim   </td><td>I_meas  </td></tr>
<tr><td>Speed        </td><td>w_sim   </td><td>w_meas  </td></tr>
<tr><td>Power factor </td><td>pf_sim  </td><td>pf_meas </td></tr>
<tr><td>Efficiency   </td><td>eff_sim </td><td>eff_meas</td></tr>
</table>
<p>Machine parameters are taken from a standard 18.5 kW 400 V 50 Hz motor, simulation results are compared with measurements.</p>
<table>
<tr><td>Nominal stator current            </td><td>     32.85  </td><td>A      </td></tr>
<tr><td>Power factor                      </td><td>      0.898 </td><td>       </td></tr>
<tr><td>Speed                             </td><td>   1462.5   </td><td>rpm    </td></tr>
<tr><td>Electrical input                  </td><td> 20,443.95  </td><td>W      </td></tr>
<tr><td>Stator copper losses              </td><td>    770.13  </td><td>W      </td></tr>
<tr><td>Stator core losses                </td><td>    410.00  </td><td>W      </td></tr>
<tr><td>Rotor  copper losses              </td><td>    481.60  </td><td>W      </td></tr>
<tr><td>Stray load losses                 </td><td>    102.22  </td><td>W      </td></tr>
<tr><td>Friction losses                   </td><td>    180.00  </td><td>W      </td></tr>
<tr><td>Mechanical output                 </td><td> 18,500.00  </td><td>W      </td></tr>
<tr><td>Efficiency                        </td><td>     90.49  </td><td>%      </td></tr>
<tr><td>Nominal torque                    </td><td>    120.79  </td><td>Nm     </td></tr>
</table>
<br>
<table>
<tr><td>Stator resistance per phase       </td><td>  0.56     </td><td>&Omega;</td></tr>
<tr><td>Temperature coefficient           </td><td> copper    </td><td>       </td></tr>
<tr><td>Reference temperature             </td><td> 20        </td><td>&deg;C </td></tr>
<tr><td>Operation temperature             </td><td> 90        </td><td>&deg;C </td></tr>
<tr><td>Stator leakage reactance at 50 Hz </td><td>  1.52     </td><td>&Omega;</td></tr>
<tr><td>Main  field    reactance at 50 Hz </td><td> 66.40     </td><td>&Omega;</td></tr>
<tr><td>Rotor  leakage reactance at 50 Hz </td><td>  2.31     </td><td>&Omega;</td></tr>
<tr><td>Rotor  resistance per phase       </td><td>  0.42     </td><td>&Omega;</td></tr>
<tr><td>Temperature coefficient           </td><td> aluminium </td><td>       </td></tr>
<tr><td>Reference temperature             </td><td> 20        </td><td>&deg;C </td></tr>
<tr><td>Operation temperature             </td><td> 90        </td><td>&deg;C </td></tr>
</table>
<p>See:<br>
Anton Haumer, Christian Kral, Hansj&ouml;rg Kapeller, Thomas B&auml;uml, Johannes V. Gragger<br>
<a href=\"https://www.modelica.org/events/modelica2009/Proceedings/memorystick/pages/papers/0103/0103.pdf\">
The AdvancedMachines Library: Loss Models for Electric Machines</a><br>
Modelica 2009, 7<sup>th</sup> International Modelica Conference</p>
</html>"),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}})));
      end AIMC_withLosses;

      model AIMC_Initialize "Steady-state initialization of asynchronous induction machine with squirrel cage"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=aimcData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.AngularVelocity wSync=2*pi*fNominal/aimc.p;
        parameter Modelica.SIunits.Time tStart=0.5 "Start time";
        parameter Modelica.SIunits.Torque TLoad=161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity wLoad(displayUnit="rev/min")=
             1440.45*2*Modelica.Constants.pi/60 "Nominal load speed";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage aimc(
          p=aimcData.p,
          fsNominal=aimcData.fsNominal,
          TsRef=aimcData.TsRef,
          alpha20s(displayUnit="1/K") = aimcData.alpha20s,
          Jr=aimcData.Jr,
          Js=aimcData.Js,
          frictionParameters=aimcData.frictionParameters,
          statorCoreParameters=aimcData.statorCoreParameters,
          strayLoadParameters=aimcData.strayLoadParameters,
          TrRef=aimcData.TrRef,
          phiMechanical(fixed=true),
          Rs=aimcData.Rs*m/3,
          Lssigma=aimcData.Lssigma*m/3,
          Lszero=aimcData.Lszero*m/3,
          Lm=aimcData.Lm*m/3,
          Lrsigma=aimcData.Lrsigma*m/3,
          Rr=aimcData.Rr*m/3,
          TsOperational=293.15,
          effectiveStatorTurns=aimcData.effectiveStatorTurns,
          alpha20r=aimcData.alpha20r,
          TrOperational=293.15) annotation (Placement(transformation(extent={{-20,40},{0,60}})));
        Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (Placement(transformation(
              origin={-40,80},
              extent={{-10,10},{10,-10}})));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          freqHz=fill(fNominal, m),
          V=fill(sqrt(2/3)*VNominal, m)) annotation (Placement(transformation(
              origin={-70,70},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-70,40})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-70,10},
              extent={{-10,-10},{10,10}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia(J=JLoad)
          annotation (Placement(transformation(extent={{10,40},{30,60}})));
        Mechanics.Rotational.Sources.TorqueStep torqueStep(
          useSupport=false,
          startTime=tStart,
          stepTorque=-TLoad,
          offsetTorque=0) annotation (Placement(transformation(extent={{60,40},{40,60}})));
        Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="D") annotation (Placement(transformation(extent={{-20,56},{0,76}})));
        parameter Electrical.Machines.Utilities.ParameterRecords.AIM_SquirrelCageData aimcData annotation (Placement(transformation(extent={{70,72},{90,92}})));
      initial equation
        aimc.wMechanical = wSync;
        sum(aimc.is) = 0;
        der(aimc.airGap.V_msr.re) = 0;
        der(aimc.airGap.V_msr.im) = 0;
        der(aimc.airGap.V_mrr.re) = 0;
        der(aimc.airGap.V_mrr.im) = 0;
      equation
        connect(star.pin_n, ground.p) annotation (Line(points={{-70,30},{-70,20}},
                            color={0,0,255}));
        connect(sineVoltage.plug_n, star.plug_p)
          annotation (Line(points={{-70,60},{-70,50}}, color={0,0,255}));
        connect(terminalBox.plug_sn, aimc.plug_sn) annotation (Line(
            points={{-16,60},{-16,60}},   color={0,0,255}));
        connect(terminalBox.plug_sp, aimc.plug_sp) annotation (Line(
            points={{-4,60},{-4,60}},   color={0,0,255}));
        connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{-10,62},{-10,80},{-30,80}},
                                          color={0,0,255}));
        connect(loadInertia.flange_b, torqueStep.flange) annotation (Line(
            points={{30,50},{40,50}}));
        connect(aimc.flange, loadInertia.flange_a) annotation (Line(
            points={{0,50},{10,50}}));
        connect(sineVoltage.plug_p, currentQuasiRMSSensor.plug_p) annotation (
            Line(
            points={{-70,80},{-50,80}},          color={0,0,255}));
        annotation (experiment(StopTime=1.5, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>
The asynchronous induction machine with squirrel cage is initialized in steady-state at no-load;
at time tStart a load torque step is applied.</p>

<p>Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li>currentQuasiRMSSensor.I: stator current RMS</li>
<li>aimc.wMechanical: motor's speed</li>
<li>aimc.tauElectrical: motor's torque</li>
</ul>

<p>Default machine parameters are used.</p>
</html>"));
      end AIMC_Initialize;

      model AIMS_Start
        "Starting of asynchronous induction machine with slip rings"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VsNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=aimsData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.Time tOn=0.1 "Start time of machine";
        parameter Modelica.SIunits.Resistance RStart=0.16/aimsData.turnsRatio^2
          "Starting resistance";
        parameter Modelica.SIunits.Time tRheostat=1.0
          "Time of shortening the rheostat";
        parameter Modelica.SIunits.Torque T_Load=161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity w_Load(displayUnit="rev/min")=
             Modelica.SIunits.Conversions.from_rpm(1440.45)
          "Nominal load speed";
        parameter Modelica.SIunits.Inertia J_Load=0.29 "Load inertia";
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          V=fill(sqrt(2.0/3.0)*VsNominal, m),
          freqHz=fill(fNominal, m)) annotation (Placement(transformation(
              origin={-30,90},
              extent={{10,-10},{-10,10}})));
        Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser(
          final m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m)) annotation (Placement(transformation(
              origin={0,60},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=tOn)
          annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
        Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSsensorM
          annotation (Placement(transformation(
              origin={0,20},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
          currentRMSsensorE annotation (Placement(transformation(
              origin={-60,20},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
            terminalConnection="D") annotation (Placement(transformation(extent={{-10,-14},
                  {10,6}})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxE(
            terminalConnection="D") annotation (Placement(transformation(extent={{-10,-74},
                  {10,-54}})));
        Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing
          aimsM(
          Jr=aimsData.Jr,
          Js=aimsData.Js,
          p=aimsData.p,
          fsNominal=aimsData.fsNominal,
          Rs=aimsData.Rs,
          TsRef=aimsData.TsRef,
          alpha20s(displayUnit="1/K") = aimsData.alpha20s,
          Lssigma=aimsData.Lssigma,
          Lszero=aimsData.Lszero,
          frictionParameters=aimsData.frictionParameters,
          statorCoreParameters=aimsData.statorCoreParameters,
          strayLoadParameters=aimsData.strayLoadParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          Lm=aimsData.Lm,
          Lrsigma=aimsData.Lrsigma,
          Lrzero=aimsData.Lrzero,
          Rr=aimsData.Rr,
          TrRef=aimsData.TrRef,
          alpha20r(displayUnit="1/K") = aimsData.alpha20r,
          useTurnsRatio=aimsData.useTurnsRatio,
          VsNominal=aimsData.VsNominal,
          VrLockedRotor=aimsData.VrLockedRotor,
          rotorCoreParameters=aimsData.rotorCoreParameters,
          TurnsRatio=aimsData.turnsRatio,
          TsOperational=293.15,
          effectiveStatorTurns=aimsData.effectiveStatorTurns,
          TrOperational=293.15) annotation (Placement(transformation(extent={{-10,
                  -30},{10,-10}})));
        Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing
          aimsE(
          p=aimsData.p,
          fsNominal=aimsData.fsNominal,
          Rs=aimsData.Rs,
          TsRef=aimsData.TsRef,
          alpha20s(displayUnit="1/K") = aimsData.alpha20s,
          Lszero=aimsData.Lszero,
          Lssigma=aimsData.Lssigma,
          Jr=aimsData.Jr,
          Js=aimsData.Js,
          frictionParameters=aimsData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimsData.statorCoreParameters,
          strayLoadParameters=aimsData.strayLoadParameters,
          Lm=aimsData.Lm,
          Lrsigma=aimsData.Lrsigma,
          Lrzero=aimsData.Lrzero,
          Rr=aimsData.Rr,
          TrRef=aimsData.TrRef,
          alpha20r(displayUnit="1/K") = aimsData.alpha20r,
          useTurnsRatio=aimsData.useTurnsRatio,
          VsNominal=aimsData.VsNominal,
          VrLockedRotor=aimsData.VrLockedRotor,
          rotorCoreParameters=aimsData.rotorCoreParameters,
          TsOperational=566.3,
          turnsRatio=aimsData.turnsRatio,
          TrOperational=566.3) annotation (Placement(transformation(extent={{-10,
                  -90},{10,-70}})));
        Electrical.Machines.Utilities.SwitchedRheostat rheostatM(
          RStart=RStart,
          tStart=tRheostat,
          m=m) annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
        Electrical.Machines.Utilities.SwitchedRheostat rheostatE(
          RStart=RStart,
          tStart=tRheostat,
          m=m) annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=J_Load)
          annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertiaE(J=J_Load)
          annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorqueM(
          tau_nominal=-T_Load,
          TorqueDirection=false,
          useSupport=false,
          w_nominal=w_Load) annotation (Placement(transformation(extent={{100,-30},
                  {80,-10}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorqueE(
          tau_nominal=-T_Load,
          TorqueDirection=false,
          useSupport=false,
          w_nominal=w_Load) annotation (Placement(transformation(extent={{100,-90},
                  {80,-70}})));
        parameter
          Electrical.Machines.Utilities.ParameterRecords.AIM_SlipRingData
          aimsData
          annotation (Placement(transformation(extent={{70,72},{90,92}})));
      initial equation
        aimsE.is = zeros(3);
        aimsE.ir = zeros(3);
        aimsM.is = zeros(3);
        aimsM.ir = zeros(3);
      equation
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(sineVoltage.plug_n, star.plug_p) annotation (Line(points={{-40,
                90},{-40,90},{-50,90}}, color={0,0,255}));
        connect(loadInertiaE.flange_b, quadraticLoadTorqueE.flange)
          annotation (Line(points={{70,-80},{80,-80}}));
        connect(aimsE.flange, loadInertiaE.flange_a)
          annotation (Line(points={{10,-80},{50,-80}}));
        connect(booleanStep.y, idealCloser.control)
          annotation (Line(points={{-39,60},{-12,60}},color={255,0,255}));
        connect(terminalBoxE.plug_sn, aimsE.plug_sn)
          annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
        connect(terminalBoxE.plug_sp, aimsE.plug_sp)
          annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
        connect(rheostatE.plug_p, aimsE.plug_rp) annotation (Line(points={{-20,
                -74},{-18,-74},{-10,-74}}, color={0,0,255}));
        connect(rheostatE.plug_n, aimsE.plug_rn) annotation (Line(points={{-20,
                -86},{-18,-86},{-10,-86}}, color={0,0,255}));
        connect(loadInertiaM.flange_b, quadraticLoadTorqueM.flange) annotation (
           Line(points={{70,-20},{70,-20},{80,-20}}));
        connect(aimsM.flange, loadInertiaM.flange_a) annotation (Line(points={{
                10,-20},{10,-20},{50,-20}}));
        connect(terminalBoxM.plug_sp, aimsM.plug_sp)
          annotation (Line(points={{6,-10},{6,-10}}, color={0,0,255}));
        connect(terminalBoxM.plug_sn, aimsM.plug_sn)
          annotation (Line(points={{-6,-10},{-6,-10}}, color={0,0,255}));
        connect(currentRMSsensorM.plug_n, terminalBoxM.plugSupply) annotation (
            Line(
            points={{0,10},{0,-8}},
            color={0,0,255}));
        connect(rheostatM.plug_p, aimsM.plug_rp) annotation (Line(
            points={{-20,-14},{-10,-14}},
            color={0,0,255}));
        connect(rheostatM.plug_n, aimsM.plug_rn) annotation (Line(
            points={{-20,-26},{-10,-26}},
            color={0,0,255}));
        connect(currentRMSsensorE.plug_n, terminalBoxE.plugSupply) annotation (
            Line(
            points={{-60,10},{-60,-60},{0,-60},{0,-68}},
            color={0,0,255}));
        connect(idealCloser.plug_n, currentRMSsensorM.plug_p) annotation (Line(
            points={{0,50},{0,45},{0,40},{0,30}},
            color={0,0,255}));

        connect(currentRMSsensorE.plug_p, idealCloser.plug_n) annotation (Line(
            points={{-60,30},{0,30},{0,50}},
            color={0,0,255}));
        connect(idealCloser.plug_p, sineVoltage.plug_p) annotation (Line(
            points={{0,70},{0,90},{-20,90}},
            color={0,0,255}));
        annotation (experiment(
            StopTime=1.5,
            Interval=1E-4,
            Tolerance=1e-06), Documentation(info="<html>
<p>
At start time <code>tOn</code> three phase voltage is supplied to the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing\">asynchronous induction machine with sliprings</a>.
The machine starts from standstill, accelerating inertias against load torque quadratic dependent on speed,
using a starting resistance. At time tRheostat external rotor resistance is shortened, finally reaching nominal speed.</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>currentRMSsensorM|E.I</code>: equivalent RMS stator current</li>
<li><code>aimsM/E.wMechanical</code>: machine speed</li>
<li><code>aimsM|E.tauElectrical</code>: machine torque</li>
</ul>
</html>"));
      end AIMS_Start;

      model AIMS_Start_MultiPhase
        "Starting of multi phase asynchronous induction machine with slip rings"

        extends Modelica.Icons.Example;
        constant Integer m3=3 "Number of stator phases of threephase system";
        parameter Integer m=5 "Number of stator phases";
        parameter Integer mr=5 "Number of rotor phases";
        parameter Modelica.SIunits.Voltage VsNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=aimsData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.Time tOn=0.1 "Start time of machine";
        parameter Modelica.SIunits.Resistance RStart=0.16/aimsData.turnsRatio^2
          "Starting resistance";
        parameter Modelica.SIunits.Time tRheostat=1.0
          "Time of shortening the rheostat";
        parameter Modelica.SIunits.Torque T_Load=161.4 "Nominal load torque";
        parameter Modelica.SIunits.AngularVelocity w_Load(displayUnit="rev/min")=
             Modelica.SIunits.Conversions.from_rpm(1440.45)
          "Nominal load speed";
        parameter Modelica.SIunits.Inertia J_Load=0.29 "Load inertia";
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(m=m,
            terminalConnection="Y") annotation (Placement(transformation(extent={{20,46},
                  {40,66}})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox3(
            terminalConnection="Y", m=m3) annotation (Placement(transformation(
                extent={{20,-54},{40,-34}})));
        Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing
          aimsM(
          Jr=aimsData.Jr,
          Js=aimsData.Js,
          p=aimsData.p,
          fsNominal=aimsData.fsNominal,
          TsRef=aimsData.TsRef,
          alpha20s(displayUnit="1/K") = aimsData.alpha20s,
          frictionParameters=aimsData.frictionParameters,
          statorCoreParameters=aimsData.statorCoreParameters,
          strayLoadParameters=aimsData.strayLoadParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          TrRef=aimsData.TrRef,
          alpha20r(displayUnit="1/K") = aimsData.alpha20r,
          useTurnsRatio=aimsData.useTurnsRatio,
          VsNominal=aimsData.VsNominal,
          VrLockedRotor=aimsData.VrLockedRotor,
          rotorCoreParameters=aimsData.rotorCoreParameters,
          TurnsRatio=aimsData.turnsRatio,
          mr=mr,
          m=m,
          Rs=aimsData.Rs*m/3,
          Lssigma=aimsData.Lssigma*m/3,
          Lszero=aimsData.Lszero*m/3,
          Lm=aimsData.Lm*m/3,
          Lrsigma=aimsData.Lrsigma*mr/3,
          Lrzero=aimsData.Lrzero*mr/3,
          Rr=aimsData.Rr*mr/3,
          TsOperational=293.15,
          effectiveStatorTurns=aimsData.effectiveStatorTurns,
          TrOperational=293.15) annotation (Placement(transformation(extent={{
                  20,30},{40,50}})));
        Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing
          aims3(
          p=aimsData.p,
          fsNominal=aimsData.fsNominal,
          Rs=aimsData.Rs,
          TsRef=aimsData.TsRef,
          alpha20s(displayUnit="1/K") = aimsData.alpha20s,
          Lszero=aimsData.Lszero,
          Lssigma=aimsData.Lssigma,
          Jr=aimsData.Jr,
          Js=aimsData.Js,
          frictionParameters=aimsData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=aimsData.statorCoreParameters,
          strayLoadParameters=aimsData.strayLoadParameters,
          Lm=aimsData.Lm,
          Lrsigma=aimsData.Lrsigma,
          Lrzero=aimsData.Lrzero,
          Rr=aimsData.Rr,
          TrRef=aimsData.TrRef,
          alpha20r(displayUnit="1/K") = aimsData.alpha20r,
          useTurnsRatio=aimsData.useTurnsRatio,
          VsNominal=aimsData.VsNominal,
          VrLockedRotor=aimsData.VrLockedRotor,
          rotorCoreParameters=aimsData.rotorCoreParameters,
          m=m3,
          TurnsRatio=aimsData.turnsRatio,
          TsOperational=566.3,
          effectiveStatorTurns=aimsData.effectiveStatorTurns,
          TrOperational=566.3)            annotation (Placement(transformation(
                extent={{20,-70},{40,-50}})));
        Electrical.Machines.Utilities.SwitchedRheostat rheostatM(
          tStart=tRheostat,
          m=mr,
          RStart=RStart*mr/m3) annotation (Placement(transformation(extent={{-10,
                  30},{10,50}})));
        Electrical.Machines.Utilities.SwitchedRheostat rheostat3(
          RStart=RStart,
          tStart=tRheostat,
          m=m3) annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=J_Load)
          annotation (Placement(transformation(extent={{50,30},{70,50}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia3(J=J_Load)
          annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorqueM(
          tau_nominal=-T_Load,
          TorqueDirection=false,
          useSupport=false,
          w_nominal=w_Load) annotation (Placement(transformation(extent={{100,
                  30},{80,50}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticLoadTorque3(
          tau_nominal=-T_Load,
          TorqueDirection=false,
          useSupport=false,
          w_nominal=w_Load) annotation (Placement(transformation(extent={{100,-70},
                  {80,-50}})));
        parameter
          Electrical.Machines.Utilities.ParameterRecords.AIM_SlipRingData
          aimsData annotation (Placement(transformation(extent={{-100,-100},{-80,
                  -80}})));
        Electrical.Analog.Basic.Ground groundM annotation (Placement(
              transformation(
              origin={-90,50},
              extent={{-10,-10},{10,10}})));
        Electrical.MultiPhase.Basic.Star starM(final m=m) annotation (Placement(
              transformation(extent={{-70,62},{-90,82}})));
        Electrical.MultiPhase.Sources.SineVoltage sineVoltageM(
          final m=m,
          freqHz=fill(fNominal, m),
          V=fill(sqrt(2.0)*VsNominal, m),
          phase=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
              m)) annotation (Placement(transformation(
              origin={-50,72},
              extent={{10,-10},{-10,10}})));
        Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloserM(
          final m=m,
          Ron=fill(1e-5*m/3, m),
          Goff=fill(1e-5*m3/m, m)) annotation (Placement(transformation(
              origin={-20,72},
              extent={{-10,10},{10,-10}})));
        Blocks.Sources.BooleanStep booleanStepM[m](each startTime=tOn, each
            startValue=false) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={-40,40})));
        Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor
          currentRMSsensorM(m=m) annotation (Placement(transformation(
              origin={10,72},
              extent={{-10,10},{10,-10}})));
        Electrical.Analog.Basic.Ground ground3 annotation (Placement(
              transformation(
              origin={-90,-52},
              extent={{-10,-10},{10,10}})));
        Electrical.MultiPhase.Basic.Star star3(final m=m3) annotation (
            Placement(transformation(extent={{-70,-40},{-90,-20}})));
        Electrical.MultiPhase.Sources.SineVoltage sineVoltage3(
          final m=m3,
          V=fill(sqrt(2.0)*VsNominal, m3),
          phase=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
              m3),
          freqHz=fill(fNominal, m3)) annotation (Placement(transformation(
              origin={-50,-30},
              extent={{10,-10},{-10,10}})));
        Electrical.MultiPhase.Ideal.IdealClosingSwitch idealCloser3(
          final m=m3,
          Ron=fill(1e-5, m3),
          Goff=fill(1e-5, m3)) annotation (Placement(transformation(
              origin={-20,-30},
              extent={{-10,10},{10,-10}})));
        Blocks.Sources.BooleanStep booleanStep3[m3](each startTime=tOn, each
            startValue=false) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={-40,-60})));
        Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
          currentRMSsensor3(m=3) annotation (Placement(transformation(
              origin={10,-30},
              extent={{-10,10},{10,-10}})));
        Blocks.Math.Gain gain(k=(m/m3))
          annotation (Placement(transformation(extent={{40,80},{60,100}})));
        Modelica.Blocks.Math.Feedback feedback
          annotation (Placement(transformation(extent={{80,10},{100,-10}})));
      initial equation
        aims3.is[1:2] = zeros(2);
        aims3.ir[1:3] = zeros(3);
        aimsM.is[1:2] = zeros(2);
        aimsM.ir[1:mr - 2] = zeros(mr - 2);
      equation
        connect(loadInertia3.flange_b, quadraticLoadTorque3.flange) annotation (
           Line(points={{70,-60},{76,-60},{80,-60}}));
        connect(aims3.flange, loadInertia3.flange_a) annotation (Line(points={{
                40,-60},{40,-60},{50,-60}}));
        connect(terminalBox3.plug_sn, aims3.plug_sn)
          annotation (Line(points={{24,-50},{24,-50}}, color={0,0,255}));
        connect(terminalBox3.plug_sp, aims3.plug_sp)
          annotation (Line(points={{36,-50},{36,-50}}, color={0,0,255}));
        connect(rheostat3.plug_p, aims3.plug_rp) annotation (Line(points={{10,-54},
                {10,-54},{20,-54}}, color={0,0,255}));
        connect(rheostat3.plug_n, aims3.plug_rn) annotation (Line(points={{10,-66},
                {10,-66},{20,-66}}, color={0,0,255}));
        connect(loadInertiaM.flange_b, quadraticLoadTorqueM.flange)
          annotation (Line(points={{70,40},{70,40},{80,40}}));
        connect(aimsM.flange, loadInertiaM.flange_a)
          annotation (Line(points={{40,40},{40,40},{50,40}}));
        connect(terminalBoxM.plug_sp, aimsM.plug_sp)
          annotation (Line(points={{36,50},{36,50}}, color={0,0,255}));
        connect(terminalBoxM.plug_sn, aimsM.plug_sn)
          annotation (Line(points={{24,50},{24,50}}, color={0,0,255}));
        connect(rheostatM.plug_p, aimsM.plug_rp) annotation (Line(
            points={{10,46},{20,46}},
            color={0,0,255}));
        connect(rheostatM.plug_n, aimsM.plug_rn) annotation (Line(
            points={{10,34},{20,34}},
            color={0,0,255}));
        connect(starM.pin_n, groundM.p) annotation (Line(points={{-90,72},{-90,
                72},{-90,60}}, color={0,0,255}));
        connect(sineVoltageM.plug_n, starM.plug_p) annotation (Line(points={{-60,
                72},{-60,72},{-70,72}}, color={0,0,255}));
        connect(sineVoltageM.plug_p, idealCloserM.plug_p) annotation (Line(
            points={{-40,72},{-30,72}},
            color={0,0,255}));
        connect(idealCloserM.plug_n, currentRMSsensorM.plug_p) annotation (Line(
            points={{-10,72},{0,72}},
            color={0,0,255}));
        connect(booleanStepM.y, idealCloserM.control) annotation (Line(
            points={{-29,40},{-20,40},{-20,60}},
            color={255,0,255}));
        connect(star3.pin_n, ground3.p)
          annotation (Line(points={{-90,-30},{-90,-42}}, color={0,0,255}));
        connect(sineVoltage3.plug_n, star3.plug_p) annotation (Line(points={{-60,
                -30},{-60,-30},{-70,-30}}, color={0,0,255}));
        connect(sineVoltage3.plug_p, idealCloser3.plug_p) annotation (Line(
            points={{-40,-30},{-30,-30}},
            color={0,0,255}));
        connect(idealCloser3.plug_n, currentRMSsensor3.plug_p) annotation (Line(
            points={{-10,-30},{0,-30}},
            color={0,0,255}));
        connect(booleanStep3.y, idealCloser3.control) annotation (Line(
            points={{-29,-60},{-20,-60},{-20,-42}},
            color={255,0,255}));
        connect(currentRMSsensorM.I, gain.u) annotation (Line(
            points={{10,83},{10,90},{38,90}},
            color={0,0,127}));
        connect(currentRMSsensor3.plug_n, terminalBox3.plugSupply) annotation (
            Line(
            points={{20,-30},{30,-30},{30,-48}},
            color={0,0,255}));
        connect(currentRMSsensorM.plug_n, terminalBoxM.plugSupply) annotation (
            Line(
            points={{20,72},{30,72},{30,52}},
            color={0,0,255}));
        connect(currentRMSsensor3.I, feedback.u1) annotation (Line(
            points={{10,-19},{10,0},{82,0}},
            color={0,0,127}));
        connect(feedback.u2, gain.y) annotation (Line(
            points={{90,8},{90,16},{100,16},{100,90},{61,90}},
            color={0,0,127}));
        annotation (
          experiment(
            StopTime=1.5,
            Interval=1E-4,
            Tolerance=1e-06),
          Documentation(info="<html>
<p>
At start time <code>tOn</code> voltages are supplied to the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing\">asynchronous induction machines with sliprings</a>.
The two machine start from standstill, accelerating inertias against load torque quadratic dependent on speed,
using a starting resistance. At time tRheostat external rotor resistance is shortened, finally reaching nominal speed. Two equivalent machines with different numbers of phases are compared and their equal behavior is demonstrated.</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>aimcM|M3.tauElectrical</code>: machine torque</li>
<li><code>aimsM|M3.wMechanical</code>: machine speed</li>
<li><code>feedback.y</code>: zero since difference of three phase current phasor and scaled multi phase current phasor are equal</li>
</ul>

</html>"),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                               graphics={       Text(
                      extent={{40,68},{100,60}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      textString="%m phase machine",
                      textStyle={TextStyle.Bold}),Text(
                      extent={{40,-32},{100,-40}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      textString="3 phase machine",
                      textStyle={TextStyle.Bold})}));
      end AIMS_Start_MultiPhase;

      model SMPM_Inverter
        "Starting of permanent magnet synchronous machine with inverter"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VsNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fsNominal=smpmData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.Frequency fKnee=50
          "Knee frequency of V/f curve";
        parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
        parameter Modelica.SIunits.Torque T_Load=181.4 "Nominal load torque";
        parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
        parameter Modelica.SIunits.Inertia J_Load=0.29 "Load inertia";
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(
            final m=m) annotation (Placement(transformation(
              origin={0,60},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Blocks.Sources.Ramp ramp(height=fKnee, duration=tRamp)
          annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
        Modelica.Electrical.Machines.Utilities.VfController vfController(
          final m=m,
          VNominal=VsNominal,
          fNominal=fsNominal,
          BasePhase=+Modelica.Constants.pi/2) annotation (Placement(
              transformation(extent={{-40,50},{-20,70}})));
        Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSsensorM
          annotation (Placement(transformation(
              origin={0,30},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
          currentRMSsensorE annotation (Placement(transformation(
              origin={-60,30},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
            terminalConnection="Y") annotation (Placement(transformation(extent={{-10,-14},
                  {10,6}})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxE(
            terminalConnection="Y") annotation (Placement(transformation(extent={{-10,-74},
                  {10,-54}})));
        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
          smpmM(
          Jr=smpmData.Jr,
          Js=smpmData.Js,
          p=smpmData.p,
          fsNominal=smpmData.fsNominal,
          Rs=smpmData.Rs,
          TsRef=smpmData.TsRef,
          alpha20s(displayUnit="1/K") = smpmData.alpha20s,
          Lssigma=smpmData.Lssigma,
          Lszero=smpmData.Lszero,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          Lmd=smpmData.Lmd,
          Lmq=smpmData.Lmq,
          useDamperCage=smpmData.useDamperCage,
          Lrsigmad=smpmData.Lrsigmad,
          Lrsigmaq=smpmData.Lrsigmaq,
          Rrd=smpmData.Rrd,
          Rrq=smpmData.Rrq,
          TrRef=smpmData.TrRef,
          alpha20r(displayUnit="1/K") = smpmData.alpha20r,
          VsOpenCircuit=smpmData.VsOpenCircuit,
          frictionParameters=smpmData.frictionParameters,
          statorCoreParameters=smpmData.statorCoreParameters,
          strayLoadParameters=smpmData.strayLoadParameters,
          permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
          ir(each fixed=true),
          TsOperational=293.15,
          effectiveStatorTurns=smpmData.effectiveStatorTurns,
          TrOperational=293.15)
                               annotation (Placement(transformation(extent={{-10,-30},
                  {10,-10}})));

        Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
          smpmE(
          p=smpmData.p,
          fsNominal=smpmData.fsNominal,
          Rs=smpmData.Rs,
          TsRef=smpmData.TsRef,
          alpha20s(displayUnit="1/K") = smpmData.alpha20s,
          Lszero=smpmData.Lszero,
          Lssigma=smpmData.Lssigma,
          Jr=smpmData.Jr,
          Js=smpmData.Js,
          frictionParameters=smpmData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=smpmData.statorCoreParameters,
          strayLoadParameters=smpmData.strayLoadParameters,
          VsOpenCircuit=smpmData.VsOpenCircuit,
          Lmd=smpmData.Lmd,
          Lmq=smpmData.Lmq,
          useDamperCage=smpmData.useDamperCage,
          Lrsigmad=smpmData.Lrsigmad,
          Lrsigmaq=smpmData.Lrsigmaq,
          Rrd=smpmData.Rrd,
          Rrq=smpmData.Rrq,
          TrRef=smpmData.TrRef,
          alpha20r(displayUnit="1/K") = smpmData.alpha20r,
          permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
          TsOperational=293.15,
          ir(each fixed=true),
          TrOperational=293.15) annotation (Placement(transformation(extent={{-10,
                  -90},{10,-70}})));

        Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleM(
            p=smpmM.p) annotation (Placement(transformation(
              origin={30,-20},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleE(
            p=smpmE.p) annotation (Placement(transformation(
              origin={30,-80},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=J_Load)
          annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertiaE(J=J_Load)
          annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepM(
          startTime=tStep,
          stepTorque=-T_Load,
          useSupport=false,
          offsetTorque=0) annotation (Placement(transformation(extent={{100,-30},
                  {80,-10}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepE(
          startTime=tStep,
          stepTorque=-T_Load,
          useSupport=false,
          offsetTorque=0) annotation (Placement(transformation(extent={{100,-90},
                  {80,-70}})));
        parameter
          Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
          smpmData
          annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
        Modelica.SIunits.Angle thetaM=rotorAngleM.rotorDisplacementAngle "Rotor displacement angle, FundamentalWave machine";
        Modelica.SIunits.Angle thetaE=rotorAngleE.rotorDisplacementAngle "Rotor displacement angle, Electrical machine";
      initial equation
        smpmE.is[1:2] = zeros(2);
        smpmM.is[1:2] = zeros(2);
        //conditional damper cage currents are defined as fixed start values
      equation
        connect(signalVoltage.plug_n, star.plug_p)
          annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(ramp.y, vfController.u)
          annotation (Line(points={{-59,60},{-42,60}}, color={0,0,255}));
        connect(vfController.y, signalVoltage.v)
          annotation (Line(points={{-19,60},{-12,60}},color={0,0,255}));
        connect(loadInertiaM.flange_b, torqueStepM.flange)
          annotation (Line(points={{70,-20},{80,-20}}));
        connect(signalVoltage.plug_p, currentRMSsensorM.plug_p)
          annotation (Line(points={{0,50},{0,50},{0,40}}, color={0,0,255}));
        connect(rotorAngleM.plug_n, smpmM.plug_sn) annotation (Line(points={{36,
                -10},{36,0},{-6,0},{-6,-10}}, color={0,0,255}));
        connect(rotorAngleM.plug_p, smpmM.plug_sp) annotation (Line(points={{24,
                -10},{15,-10},{6,-10}}, color={0,0,255}));
        connect(rotorAngleM.flange, smpmM.flange)
          annotation (Line(points={{20,-20},{10,-20}}));
        connect(smpmM.flange, loadInertiaM.flange_a)
          annotation (Line(points={{10,-20},{50,-20}}));
        connect(terminalBoxM.plug_sn, smpmM.plug_sn)
          annotation (Line(points={{-6,-10},{-6,-10}}, color={0,0,255}));
        connect(terminalBoxM.plug_sp, smpmM.plug_sp)
          annotation (Line(points={{6,-10},{6,-10}}, color={0,0,255}));
        connect(terminalBoxM.plugSupply, currentRMSsensorM.plug_n) annotation (
            Line(points={{0,-8},{0,-8},{0,6},{0,20}},              color={0,0,
                255}));
        connect(loadInertiaE.flange_b, torqueStepE.flange)
          annotation (Line(points={{70,-80},{80,-80}}));
        connect(rotorAngleE.plug_n, smpmE.plug_sn) annotation (Line(points={{36,
                -70},{36,-60},{-6,-60},{-6,-70}}, color={0,0,255}));
        connect(rotorAngleE.plug_p, smpmE.plug_sp)
          annotation (Line(points={{24,-70},{6,-70}}, color={0,0,255}));
        connect(rotorAngleE.flange, smpmE.flange)
          annotation (Line(points={{20,-80},{10,-80}}));
        connect(smpmE.flange, loadInertiaE.flange_a)
          annotation (Line(points={{10,-80},{50,-80}}));
        connect(terminalBoxE.plug_sn, smpmE.plug_sn)
          annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
        connect(terminalBoxE.plug_sp, smpmE.plug_sp)
          annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
        connect(currentRMSsensorE.plug_n, terminalBoxE.plugSupply) annotation (
            Line(points={{-60,20},{-60,-50},{0,-50},{0,-68}}, color={0,0,255}));
        connect(currentRMSsensorE.plug_p, signalVoltage.plug_p) annotation (
            Line(
            points={{-60,40},{0,40},{0,50}},
            color={0,0,255}));
        annotation (experiment(
            StopTime=1.5,
            Interval=1E-4,
            Tolerance=1e-006), Documentation(info="<html>
<h4>Permanent magnet synchronous induction machine fed by an ideal inverter</h4>
<p>

An ideal frequency inverter is modeled by using a
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.VfController\">VfController</a>
and a three-phase <a href=\"modelica://Modelica.Electrical.MultiPhase.Sources.SignalVoltage\">SignalVoltage</a>.
Frequency is raised by a ramp, causing the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet\">permanent magnet synchronous induction machine</a> to start,
and accelerate the inertias.</p>

<p>At time tStep a load step is applied. Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li><code>currentRMSsensorM|E.I</code>: equivalent RMS stator current</li>
<li><code>smpmM|E.wMechanical</code>: machine speed</li>
<li><code>smpmM|E.tauElectrical</code>: machine torque</li>
<li><code>rotorAnglepmsmM|E.rotorDisplacementAngle</code>: rotor displacement angle</li>
</ul>
</html>"));
      end SMPM_Inverter;

      model SMPM_Inverter_MultiPhase
        "Starting of multi phase permanent magnet synchronous machine with inverter"

        extends Modelica.Icons.Example;
        constant Integer m3=3 "Number of stator phases of threephase system";
        parameter Integer m=5 "Number of stator phases";
        parameter Modelica.SIunits.Voltage VsNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fsNominal=smpmData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.Frequency fKnee=50
          "Knee frequency of V/f curve";
        parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
        parameter Modelica.SIunits.Torque T_Load=181.4 "Nominal load torque";
        parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
        parameter Modelica.SIunits.Inertia J_Load=0.29 "Load inertia";
        Modelica.Electrical.Analog.Basic.Ground ground3 annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star3(final m=m3) annotation (
           Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage3(
            final m=m3) annotation (Placement(transformation(
              origin={0,70},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Blocks.Sources.Ramp ramp(height=fKnee, duration=tRamp)
          annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
        Modelica.Electrical.Machines.Utilities.VfController vfController3(
          VNominal=VsNominal,
          fNominal=fsNominal,
          BasePhase=+Modelica.Constants.pi/2,
          final m=m3,
          orientation=-
              Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m3))
          annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
        Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor
          currentRMSsensorM(m=m) annotation (Placement(transformation(
              origin={30,20},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
          currentRMSsensor3 annotation (Placement(transformation(
              origin={-80,0},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
            terminalConnection="Y", m=m) annotation (Placement(transformation(
                extent={{-10,-14},{10,6}})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox3(
            terminalConnection="Y", m=m3) annotation (Placement(transformation(
                extent={{-10,-74},{10,-54}})));
        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
          smpmM(
          Jr=smpmData.Jr,
          Js=smpmData.Js,
          p=smpmData.p,
          fsNominal=smpmData.fsNominal,
          TsRef=smpmData.TsRef,
          alpha20s(displayUnit="1/K") = smpmData.alpha20s,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          useDamperCage=smpmData.useDamperCage,
          Lrsigmad=smpmData.Lrsigmad,
          Lrsigmaq=smpmData.Lrsigmaq,
          Rrd=smpmData.Rrd,
          Rrq=smpmData.Rrq,
          TrRef=smpmData.TrRef,
          alpha20r(displayUnit="1/K") = smpmData.alpha20r,
          VsOpenCircuit=smpmData.VsOpenCircuit,
          frictionParameters=smpmData.frictionParameters,
          statorCoreParameters=smpmData.statorCoreParameters,
          strayLoadParameters=smpmData.strayLoadParameters,
          permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
          m=m,
          Rs=smpmData.Rs*m/3,
          Lssigma=smpmData.Lssigma*m/3,
          Lszero=smpmData.Lszero*m/3,
          Lmd=smpmData.Lmd*m/3,
          Lmq=smpmData.Lmq*m/3,
          ir(each fixed=true),
          TsOperational=293.15,
          effectiveStatorTurns=smpmData.effectiveStatorTurns,
          TrOperational=293.15)
                               annotation (Placement(transformation(extent={{-10,-30},
                  {10,-10}})));

        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
          smpm3(
          p=smpmData.p,
          fsNominal=smpmData.fsNominal,
          Rs=smpmData.Rs,
          TsRef=smpmData.TsRef,
          alpha20s(displayUnit="1/K") = smpmData.alpha20s,
          Lszero=smpmData.Lszero,
          Lssigma=smpmData.Lssigma,
          Jr=smpmData.Jr,
          Js=smpmData.Js,
          frictionParameters=smpmData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=smpmData.statorCoreParameters,
          strayLoadParameters=smpmData.strayLoadParameters,
          VsOpenCircuit=smpmData.VsOpenCircuit,
          Lmd=smpmData.Lmd,
          Lmq=smpmData.Lmq,
          useDamperCage=smpmData.useDamperCage,
          Lrsigmad=smpmData.Lrsigmad,
          Lrsigmaq=smpmData.Lrsigmaq,
          Rrd=smpmData.Rrd,
          Rrq=smpmData.Rrq,
          TrRef=smpmData.TrRef,
          alpha20r(displayUnit="1/K") = smpmData.alpha20r,
          permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
          m=m3,
          ir(each fixed=true),
          TsOperational=293.15,
          effectiveStatorTurns=smpmData.effectiveStatorTurns,
          TrOperational=293.15)
                               annotation (Placement(transformation(extent={{-10,-90},
                  {10,-70}})));

        Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngle3(
           p=smpm3.p) annotation (Placement(transformation(
              origin={30,-80},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=J_Load)
          annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia3(J=J_Load)
          annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepM(
          startTime=tStep,
          stepTorque=-T_Load,
          useSupport=false,
          offsetTorque=0) annotation (Placement(transformation(extent={{100,-30},
                  {80,-10}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep3(
          startTime=tStep,
          stepTorque=-T_Load,
          useSupport=false,
          offsetTorque=0) annotation (Placement(transformation(extent={{100,-90},
                  {80,-70}})));
        parameter
          Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData
          smpmData annotation (Placement(transformation(extent={{-100,-100},{-80,
                  -80}})));
        Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltageM(
            final m=m) annotation (Placement(transformation(
              origin={30,50},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star starM(final m=m) annotation (
            Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={60,90})));
        Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
              transformation(
              origin={90,90},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.Machines.Utilities.VfController vfController(
          VNominal=VsNominal,
          fNominal=fsNominal,
          BasePhase=+Modelica.Constants.pi/2,
          final m=m,
          orientation=-
              Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m))
          annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-30,50})));
        Modelica.Blocks.Math.Feedback feedback annotation (Placement(
              transformation(
              extent={{-10,10},{10,-10}},
              origin={-50,0})));
        Modelica.Blocks.Math.Gain gain(k=(m/m3))
          annotation (Placement(transformation(extent={{-20,10},{-40,30}})));
      initial equation
        smpm3.is[1:2] = zeros(2);
        smpmM.is[1:2] = zeros(2);
        //conditional damper cage currents are defined as fixed start values
      equation
        connect(signalVoltage3.plug_n, star3.plug_p)
          annotation (Line(points={{0,80},{0,90},{-50,90}}, color={0,0,255}));
        connect(star3.pin_n, ground3.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(ramp.y, vfController3.u)
          annotation (Line(points={{-59,70},{-42,70}}, color={0,0,255}));
        connect(vfController3.y, signalVoltage3.v)
          annotation (Line(points={{-19,70},{-12,70}},color={0,0,255}));
        connect(loadInertiaM.flange_b, torqueStepM.flange)
          annotation (Line(points={{70,-20},{80,-20}}));
        connect(smpmM.flange, loadInertiaM.flange_a)
          annotation (Line(points={{10,-20},{50,-20}}));
        connect(terminalBoxM.plug_sn, smpmM.plug_sn)
          annotation (Line(points={{-6,-10},{-6,-10}}, color={0,0,255}));
        connect(terminalBoxM.plug_sp, smpmM.plug_sp)
          annotation (Line(points={{6,-10},{6,-10}}, color={0,0,255}));
        connect(terminalBoxM.plugSupply, currentRMSsensorM.plug_n) annotation (
            Line(points={{0,-8},{0,-8},{0,10},{30,10}},        color={0,0,255}));
        connect(loadInertia3.flange_b, torqueStep3.flange)
          annotation (Line(points={{70,-80},{80,-80}}));
        connect(rotorAngle3.plug_n, smpm3.plug_sn) annotation (Line(points={{36,
                -70},{36,-64},{-6,-64},{-6,-70}}, color={0,0,255}));
        connect(rotorAngle3.plug_p, smpm3.plug_sp)
          annotation (Line(points={{24,-70},{6,-70}}, color={0,0,255}));
        connect(rotorAngle3.flange, smpm3.flange)
          annotation (Line(points={{20,-80},{10,-80}}));
        connect(smpm3.flange, loadInertia3.flange_a)
          annotation (Line(points={{10,-80},{50,-80}}));
        connect(terminalBox3.plug_sn, smpm3.plug_sn)
          annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
        connect(terminalBox3.plug_sp, smpm3.plug_sp)
          annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
        connect(currentRMSsensor3.plug_n, terminalBox3.plugSupply) annotation (
            Line(points={{-80,-10},{-80,-60},{0,-60},{0,-68}}, color={0,0,255}));
        connect(signalVoltage3.plug_p, currentRMSsensor3.plug_p) annotation (
            Line(
            points={{0,60},{0,34},{-80,34},{-80,10}},
            color={0,0,255}));
        connect(signalVoltageM.plug_n, starM.plug_p) annotation (Line(
            points={{30,60},{30,90},{50,90}},
            color={0,0,255}));
        connect(starM.pin_n, groundM.p) annotation (Line(
            points={{70,90},{80,90}},
            color={0,0,255}));
        connect(vfController.y, signalVoltageM.v) annotation (Line(
            points={{-19,50},{18,50}},
            color={0,0,127}));
        connect(vfController.u, ramp.y) annotation (Line(
            points={{-42,50},{-50,50},{-50,70},{-59,70}},
            color={0,0,127}));
        connect(signalVoltageM.plug_p, currentRMSsensorM.plug_p) annotation (
            Line(
            points={{30,40},{30,30}},
            color={0,0,255}));
        connect(currentRMSsensor3.I, feedback.u1) annotation (Line(
            points={{-69,0},{-64.5,0},{-64.5,0},{-58,0}},
            color={0,0,255}));
        connect(gain.y, feedback.u2) annotation (Line(
            points={{-41,20},{-50,20},{-50,8}},
            color={0,0,127}));
        connect(gain.u, currentRMSsensorM.I) annotation (Line(
            points={{-18,20},{19,20}},
            color={0,0,127}));
        annotation (
          experiment(
            StopTime=1.5,
            Interval=1E-4,
            Tolerance=1e-006),
          Documentation(info="<html>
<h4>Permanent magnet synchronous induction machine fed by an ideal inverter</h4>
<p>

An ideal frequency inverter is modeled by using
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.VfController\">VfController</a>s
and <a href=\"modelica://Modelica.Electrical.MultiPhase.Sources.SignalVoltage\">SignalVoltages</a>s.
Frequency is raised by a ramp, causing the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet\">permanent magnet synchronous induction machines</a> to start,
and accelerate the inertias. Two equivalent machines with different numbers of phases are compared and their equal behavior is demonstrated.</p>

<p>At time tStep a load step is applied. Simulate for 1.5 seconds and plot (versus time):</p>

<ul>
<li><code>aimcM|M3.tauElectrical</code>: machine torque</li>
<li><code>aimsM|M3.wMechanical</code>: machine speed</li>
<li><code>feedback.y</code>: zero since difference of three phase current phasor and scaled multi phase current phasor are equal</li>
</ul>

</html>"),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}),
                               graphics={Rectangle(
                      extent={{-20,0},{100,-40}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      pattern=LinePattern.Dash),Rectangle(
                      extent={{-20,-60},{100,-100}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      pattern=LinePattern.Dash),Text(
                      extent={{40,-54},{100,-62}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      textStyle={TextStyle.Bold},
                      textString="3 phase machine
"),           Text(
                extent={{40,-44},{100,-52}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      textStyle={TextStyle.Bold},
                      textString="%m phase machine
")}));
      end SMPM_Inverter_MultiPhase;

      model SMPM_CurrentSource "Test example: PermanentMagnetSynchronousInductionMachine fed by current source"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Current Idq[2]={-53.5, 84.6}
          "Desired d- and q-current";
        parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smpmData.fsNominal/smpmData.p
          "Nominal speed";
        parameter Modelica.SIunits.Torque TLoad=181.4 "Nominal load torque";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet smpm(
          p=smpmData.p,
          fsNominal=smpmData.fsNominal,
          TsRef=smpmData.TsRef,
          Jr=smpmData.Jr,
          Js=smpmData.Js,
          frictionParameters=smpmData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=smpmData.statorCoreParameters,
          strayLoadParameters=smpmData.strayLoadParameters,
          VsOpenCircuit=smpmData.VsOpenCircuit,
          useDamperCage=smpmData.useDamperCage,
          TrRef=smpmData.TrRef,
          permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
          Rs=smpmData.Rs*m/3,
          Lssigma=smpmData.Lssigma*m/3,
          Lszero=smpmData.Lszero*m/3,
          Lmd=smpmData.Lmd*m/3,
          Lmq=smpmData.Lmq*m/3,
          Lrsigmad=smpmData.Lrsigmad,
          Lrsigmaq=smpmData.Lrsigmaq,
          Rrd=smpmData.Rrd,
          Rrq=smpmData.Rrq,
          TsOperational=293.15,
          alpha20s=smpmData.alpha20s,
          effectiveStatorTurns=smpmData.effectiveStatorTurns,
          alpha20r=smpmData.alpha20r,
          TrOperational=293.15)                                                 annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
        Modelica.Electrical.MultiPhase.Sources.SignalCurrent signalCurrent(
            final m=m) annotation (Placement(transformation(
              origin={-10,50},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Electrical.Machines.Utilities.CurrentController currentController(p=smpm.p) annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
        Modelica.Blocks.Sources.Constant iq(k=Idq[2])
          annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
        Modelica.Blocks.Sources.Constant id(k=Idq[1])
          annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
        Electrical.Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=180,
              origin={-30,-10})));
        Modelica.Electrical.MultiPhase.Basic.Star starM(final m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-60,-10})));
        Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
              transformation(
              origin={-80,-28},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y") annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        Electrical.Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smpm.p) annotation (Placement(transformation(
              origin={20,-40},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={10,0})));
        Mechanics.Rotational.Sensors.TorqueSensor torqueSensor annotation (
            Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={40,-60})));
        Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={30,0})));
        Mechanics.Rotational.Components.Inertia inertiaLoad(J=JLoad)
          annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
        Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticSpeedDependentTorque(            tau_nominal=-TLoad,
            w_nominal(displayUnit="rad/s") = wNominal)
          annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
        parameter Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData smpmData(useDamperCage=false) annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
        Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (Placement(transformation(
              origin={-10,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.SIunits.Angle theta=rotorDisplacementAngle.rotorDisplacementAngle "Rotor displacement angle, FundamentalWave machine";
      equation
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(rotorDisplacementAngle.plug_n, smpm.plug_sn) annotation (Line(
              points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
        connect(rotorDisplacementAngle.plug_p, smpm.plug_sp)
          annotation (Line(points={{14,-30},{-4,-30}}, color={0,0,255}));
        connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}}, color={0,0,255}));
        connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}}, color={0,0,255}));
        connect(smpm.flange, rotorDisplacementAngle.flange) annotation (Line(
            points={{0,-40},{10,-40}}));
        connect(signalCurrent.plug_p, star.plug_p) annotation (Line(
            points={{-10,60},{-10,90},{-50,90}}, color={0,0,255}));
        connect(angleSensor.flange, rotorDisplacementAngle.flange) annotation (
            Line(
            points={{10,-10},{10,-40}}));
        connect(angleSensor.phi, currentController.phi) annotation (Line(
            points={{10,11},{10,30},{-40,30},{-40,38}}, color={0,0,127}));
        connect(id.y, currentController.id_rms) annotation (Line(
            points={{-69,70},{-60,70},{-60,56},{-52,56}}, color={0,0,127}));
        connect(iq.y, currentController.iq_rms) annotation (Line(
            points={{-69,30},{-60,30},{-60,44},{-52,44}}, color={0,0,127}));
        connect(groundM.p, terminalBox.starpoint) annotation (Line(
            points={{-70,-28},{-20,-28}}, color={0,0,255}));
        connect(smpm.flange, torqueSensor.flange_a) annotation (Line(
            points={{0,-40},{30,-40},{30,-60}}));
        connect(voltageQuasiRMSSensor.plug_p, terminalBox.plugSupply)
          annotation (Line(
            points={{-20,-10},{-10,-10},{-10,-28}}, color={0,0,255}));
        connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
            points={{-50,-10},{-40,-10}}, color={0,0,255}));
        connect(starM.pin_n, groundM.p) annotation (Line(
            points={{-70,-10},{-70,-28}}, color={0,0,255}));
        connect(currentController.y, signalCurrent.i) annotation (Line(
            points={{-29,50},{-22,50}}, color={0,0,127}));
        connect(speedSensor.flange, smpm.flange) annotation (Line(
            points={{30,-10},{30,-40},{0,-40}}));
        connect(quadraticSpeedDependentTorque.flange, inertiaLoad.flange_b)
          annotation (Line(
            points={{80,-40},{70,-40}}));
        connect(torqueSensor.flange_b, inertiaLoad.flange_a) annotation (Line(
            points={{50,-60},{50,-40}}));
        connect(signalCurrent.plug_n, currentQuasiRMSSensor.plug_p) annotation (
           Line(
            points={{-10,40},{-10,10}}, color={0,0,255}));
        connect(currentQuasiRMSSensor.plug_n, voltageQuasiRMSSensor.plug_p)
          annotation (Line(
            points={{-10,-10},{-20,-10}}, color={0,0,255}));
        annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>A synchronous induction machine with permanent magnets accelerates a quadratic speed dependent load from standstill.
The rms values of d- and q-current in rotor fixed coordinate system are converted to three-phase currents,
and fed to the machine. The result shows that the torque is influenced by the q-current,
whereas the stator voltage is influenced by the d-current.</p>

<p>Default machine parameters are used.</p>
</html>"));
      end SMPM_CurrentSource;

      model SMPM_VoltageSource "Test example: PermanentMagnetSynchronousInductionMachine fed by FOC"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Current Idq[2]={-53.5, 84.6}
          "Desired d- and q-current";
        parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smpmData.fsNominal/smpmData.p
          "Nominal speed";
        parameter Modelica.SIunits.Torque TLoad=181.4 "Nominal load torque";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet smpm(
          phiMechanical(start=0, fixed=true),
          wMechanical(start=0, fixed=true),
          useSupport=false,
          useThermalPort=false,
          p=smpmData.p,
          fsNominal=smpmData.fsNominal,
          TsRef=smpmData.TsRef,
          Jr=smpmData.Jr,
          Js=smpmData.Js,
          frictionParameters=smpmData.frictionParameters,
          statorCoreParameters=smpmData.statorCoreParameters,
          strayLoadParameters=smpmData.strayLoadParameters,
          VsOpenCircuit=smpmData.VsOpenCircuit,
          useDamperCage=smpmData.useDamperCage,
          Lrsigmad=smpmData.Lrsigmad,
          Lrsigmaq=smpmData.Lrsigmaq,
          Rrd=smpmData.Rrd,
          Rrq=smpmData.Rrq,
          TrRef=smpmData.TrRef,
          permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
          Rs=smpmData.Rs*m/3,
          Lssigma=smpmData.Lssigma*m/3,
          Lszero=smpmData.Lszero*m/3,
          Lmd=smpmData.Lmd*m/3,
          Lmq=smpmData.Lmq*m/3,
          TsOperational=293.15,
          alpha20s=smpmData.alpha20s,
          effectiveStatorTurns=smpmData.effectiveStatorTurns,
          alpha20r=smpmData.alpha20r,
          TrOperational=293.15)       annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));

        Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(
            final m=m) annotation (Placement(transformation(
              origin={-10,50},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Blocks.Sources.Constant iq(k=Idq[2])
          annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
        Modelica.Blocks.Sources.Constant id(k=Idq[1])
          annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
        Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y") annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={10,0})));
        Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=JLoad)
          annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
        Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque
          quadraticSpeedDependentTorque(            tau_nominal=-TLoad,
            w_nominal(displayUnit="rad/s") = wNominal)
          annotation (Placement(transformation(extent={{100,-50},{80,-30}})));
        Modelica.Electrical.MultiPhase.Sensors.CurrentSensor currentSensor(m=m)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-10,0})));
        Electrical.Machines.Utilities.VoltageController voltageController(
          p=smpm.p,
          Ld=smpm.Lssigma + smpm.Lmd,
          Lq=smpm.Lssigma + smpm.Lmq,
          Rs=Electrical.Machines.Thermal.convertResistance(
              smpm.Rs,
              smpm.TsRef,
              smpm.alpha20s,
              smpm.TsOperational),
          fsNominal=smpm.fsNominal,
          VsOpenCircuit=smpm.VsOpenCircuit) annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
        Modelica.Mechanics.Rotational.Sensors.TorqueSensor torqueSensor
          annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={40,-60})));
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={30,0})));
        Electrical.Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smpm.p) annotation (Placement(transformation(
              origin={20,-40},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
              transformation(
              origin={-80,-28},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star starM(final m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-60,-10})));
        Electrical.Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=180,
              origin={-30,-10})));
        parameter Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData smpmData(useDamperCage=false) annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
        Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (Placement(transformation(
              origin={-10,20},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.SIunits.Angle theta=rotorDisplacementAngle.rotorDisplacementAngle "Rotor displacement angle, FundamentalWave machine";

      initial equation
        smpm.is[1:2] = zeros(2);

      equation
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}}, color={0,0,255}));
        connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}}, color={0,0,255}));
        connect(quadraticSpeedDependentTorque.flange, inertiaLoad.flange_b)
          annotation (Line(
            points={{80,-40},{70,-40}}));
        connect(smpm.flange, angleSensor.flange) annotation (Line(
            points={{0,-40},{10,-40},{10,-10}}));
        connect(star.plug_p, signalVoltage.plug_n) annotation (Line(
            points={{-50,90},{-10,90},{-10,60}}, color={0,0,255}));
        connect(currentSensor.plug_n, terminalBox.plugSupply) annotation (Line(
            points={{-10,-10},{-10,-28}}, color={0,0,255}));
        connect(id.y, voltageController.id_rms) annotation (Line(
            points={{-69,70},{-60,70},{-60,56},{-52,56}}, color={0,0,127}));
        connect(iq.y, voltageController.iq_rms) annotation (Line(
            points={{-69,30},{-60,30},{-60,44},{-52,44}}, color={0,0,127}));
        connect(angleSensor.phi, voltageController.phi) annotation (Line(
            points={{10,11},{10,34},{-34,34},{-34,38}}, color={0,0,127}));
        connect(voltageController.y, signalVoltage.v) annotation (Line(
            points={{-29,50},{-22,50}}, color={0,0,127}));
        connect(currentSensor.i, voltageController.iActual) annotation (Line(
            points={{-21,1.9984e-015},{-46,1.9984e-015},{-46,38}}, color={0,0,127}));
        connect(inertiaLoad.flange_a, torqueSensor.flange_b) annotation (Line(
            points={{50,-40},{50,-60}}));
        connect(torqueSensor.flange_a, smpm.flange) annotation (Line(
            points={{30,-60},{30,-40},{0,-40}}));
        connect(speedSensor.flange, smpm.flange) annotation (Line(
            points={{30,-10},{30,-40},{0,-40}}));
        connect(rotorDisplacementAngle.flange, smpm.flange) annotation (Line(
            points={{10,-40},{0,-40}}));
        connect(rotorDisplacementAngle.plug_p, smpm.plug_sp) annotation (Line(
            points={{14,-30},{-4,-30}}, color={0,0,255}));
        connect(rotorDisplacementAngle.plug_n, smpm.plug_sn) annotation (Line(
            points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
        connect(voltageQuasiRMSSensor.plug_p, currentSensor.plug_n) annotation (
           Line(
            points={{-20,-10},{-10,-10}}, color={0,0,255}));
        connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
            points={{-50,-10},{-40,-10}}, color={0,0,255}));
        connect(groundM.p, starM.pin_n) annotation (Line(
            points={{-70,-28},{-70,-10}}, color={0,0,255}));
        connect(currentQuasiRMSSensor.plug_n, currentSensor.plug_p) annotation (
           Line(
            points={{-10,10},{-10,10}}, color={0,0,255}));
        connect(signalVoltage.plug_p, currentQuasiRMSSensor.plug_p) annotation (
           Line(
            points={{-10,40},{-10,30}}, color={0,0,255}));
        annotation (experiment(StopTime=2.0, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>
A synchronous induction machine with permanent magnets accelerates a quadratic speed dependent load from standstill.
The rms values of d- and q-current in rotor fixed coordinate system are controlled by the voltageController,
and the output voltages fed to the machine. The result shows that the torque is influenced by the q-current,
whereas the stator voltage is influenced by the d-current.</p>

<p>Default machine parameters are used</p>
</html>"));
      end SMPM_VoltageSource;

      model SMPM_Braking "Test example: PermanentMagnetSynchronousInductionMachine acting as brake"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        constant Real unitK( unit="rad/(s.Ohm)")=1 annotation(HideResult=true);
        parameter Modelica.SIunits.Resistance R=1 "Nominal braking resistance";
        parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smpmData.fsNominal/smpmData.p
          "Nominal speed";
        parameter Modelica.SIunits.Inertia JLoad=0.29
          "Load's moment of inertia";
        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet smpm(
          phiMechanical(start=0, fixed=true),
          useSupport=false,
          useThermalPort=false,
          p=smpmData.p,
          fsNominal=smpmData.fsNominal,
          TsRef=smpmData.TsRef,
          Jr=smpmData.Jr,
          Js=smpmData.Js,
          frictionParameters=smpmData.frictionParameters,
          statorCoreParameters=smpmData.statorCoreParameters,
          strayLoadParameters=smpmData.strayLoadParameters,
          VsOpenCircuit=smpmData.VsOpenCircuit,
          useDamperCage=smpmData.useDamperCage,
          Lrsigmad=smpmData.Lrsigmad,
          Lrsigmaq=smpmData.Lrsigmaq,
          Rrd=smpmData.Rrd,
          Rrq=smpmData.Rrq,
          TrRef=smpmData.TrRef,
          permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
          wMechanical(start=wNominal, fixed=true),
          Rs=smpmData.Rs*m/3,
          Lssigma=smpmData.Lssigma*m/3,
          Lszero=smpmData.Lszero*m/3,
          Lmd=smpmData.Lmd*m/3,
          Lmq=smpmData.Lmq*m/3,
          TsOperational=293.15,
          alpha20s=smpmData.alpha20s,
          effectiveStatorTurns=smpmData.effectiveStatorTurns,
          alpha20r=smpmData.alpha20r,
          TrOperational=293.15)       annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));

        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-80,60},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y") annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(J=JLoad)
          annotation (Placement(transformation(extent={{50,-50},{70,-30}})));
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={40,0})));
        parameter Electrical.Machines.Utilities.ParameterRecords.SM_PermanentMagnetData smpmData(useDamperCage=false) annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
        Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (Placement(transformation(
              origin={-10,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Electrical.PowerConverters.ACDC.DiodeBridge2mPulse diodeBridge2mPulse(m=m) annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=90,
              origin={-10,30})));
        Electrical.Analog.Basic.VariableResistor variableResistor annotation (Placement(transformation(extent={{0,50},{-20,70}})));
        Blocks.Math.Gain          gain(k=unitK*R/wNominal)
                                       annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={40,30})));
        Blocks.Nonlinear.Limiter          limiter(           uMin=0.1, uMax=10)
                                                          annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={40,60})));
        Blocks.Math.Gain          ac2dc(k=pi^2/8)
                                       annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=180,
              origin={10,80})));
        Electrical.MultiPhase.Basic.Star starM(final m=m) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-60,-10})));
        Electrical.Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=180,
              origin={-30,-10})));
        Electrical.Analog.Basic.Resistor grounding(R=1e6) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-70,30})));
      initial equation
        smpm.is[1:2] = zeros(2);
        sum(smpm.is) = 0;

      equation
        connect(terminalBox.plug_sn, smpm.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}}, color={0,0,255}));
        connect(terminalBox.plug_sp, smpm.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}}, color={0,0,255}));
        connect(currentQuasiRMSSensor.plug_n, terminalBox.plugSupply)
          annotation (Line(points={{-10,-10},{-10,-10},{-10,-28}}, color={0,0,255}));
        connect(diodeBridge2mPulse.ac, currentQuasiRMSSensor.plug_p)
          annotation (Line(points={{-10,20},{-10,15},{-10,10}}, color={0,0,255}));
        connect(variableResistor.p, diodeBridge2mPulse.dc_p) annotation (Line(points={{0,60},{
                0,50},{-4,50},{-4,40}}, color={0,0,255}));
        connect(variableResistor.n, diodeBridge2mPulse.dc_n)
          annotation (Line(points={{-20,60},{-20,50},{-16,50},{-16,40}}, color={0,0,255}));
        connect(smpm.flange, inertiaLoad.flange_a)
          annotation (Line(points={{0,-40},{50,-40}}));
        connect(gain.u, speedSensor.w)
          annotation (Line(points={{40,18},{40,11}}, color={0,0,127}));
        connect(limiter.u, gain.y)
          annotation (Line(points={{40,48},{40,41}}, color={0,0,127}));
        connect(limiter.y, ac2dc.u)
          annotation (Line(points={{40,71},{40,80},{22,80}}, color={0,0,127}));
        connect(ac2dc.y, variableResistor.R)
          annotation (Line(points={{-1,80},{-10,80},{-10,72}}, color={0,0,127}));
        connect(starM.plug_p, voltageQuasiRMSSensor.plug_n) annotation (Line(
              points={{-50,-10},{-48,-10},{-40,-10}}, color={0,0,255}));
        connect(voltageQuasiRMSSensor.plug_p, currentQuasiRMSSensor.plug_n)
          annotation (Line(points={{-20,-10},{-20,-10},{-10,-10}}, color={0,0,
                255}));
        connect(smpm.flange, speedSensor.flange)
          annotation (Line(points={{0,-40},{40,-40},{40,-10}}));
        connect(terminalBox.starpoint, starM.pin_n) annotation (Line(points={{-20,-28},{-20,-28},{-70,-28},{-70,-10}},
                                                color={0,0,255}));
        connect(ground.p, variableResistor.n)
          annotation (Line(points={{-70,60},{-46,60},{-20,60}}, color={0,0,255}));
        connect(ground.p, grounding.n)
          annotation (Line(points={{-70,60},{-70,60},{-70,40}}, color={0,0,255}));
        connect(starM.pin_n, grounding.p)
          annotation (Line(points={{-70,-10},{-70,5},{-70,20}}, color={0,0,255}));
        annotation (experiment(StopTime=0.8, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>
A synchronous induction machine with permanent magnets starts braking from nominal speed by feeding a diode bridge,
which in turn feeds a braking resistor.
Since induced voltage is reduced proportional to falling speed, the braking resistance is set proportional
to speed to achieve constant current and torque.</p>

<p>Default machine parameters are used</p>
</html>"));
      end SMPM_Braking;

      model SMEE_DOL "ElectricalExcitedSynchronousInductionMachine starting direct on line"
        extends Modelica.Icons.Example;
        parameter Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Voltage VNominal=100 "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=50 "Nominal frequency";
        parameter Modelica.SIunits.Voltage Ve=smeeData.Re*smeeData.IeOpenCircuit "Excitation current";
        parameter Modelica.SIunits.Angle gamma0(displayUnit="deg") = 0 "Initial rotor displacement angle";
        Modelica.SIunits.Current irRMS = sqrt(smee.ir[1]^2+smee.ir[2]^2)/sqrt(2) "Quasi RMS rotor current";
        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited smee(
          phiMechanical(start=-(Modelica.Constants.pi + gamma0)/smee.p, fixed=true),
          fsNominal=smeeData.fsNominal,
          TsRef=smeeData.TsRef,
          Lrsigmad=smeeData.Lrsigmad,
          Lrsigmaq=smeeData.Lrsigmaq,
          Rrd=smeeData.Rrd,
          Rrq=smeeData.Rrq,
          TrRef=smeeData.TrRef,
          VsNominal=smeeData.VsNominal,
          IeOpenCircuit=smeeData.IeOpenCircuit,
          Re=smeeData.Re,
          TeRef=smeeData.TeRef,
          p=2,
          Jr=0.29,
          Js=0.29,
          useDamperCage=true,
          statorCoreParameters(VRef=100),
          strayLoadParameters(IRef=100),
          brushParameters(ILinear=0.01),
          ir(each fixed=true),
          wMechanical(fixed=true),
          m=m,
          Rs=smeeData.Rs*m/3,
          Lssigma=smeeData.Lssigma*m/3,
          Lmd=smeeData.Lmd*m/3,
          Lmq=smeeData.Lmq*m/3,
          TsOperational=293.15,
          alpha20s=smeeData.alpha20s,
          alpha20r=smeeData.alpha20r,
          TrOperational=293.15,
          TeOperational=293.15,
          alpha20e=smeeData.alpha20e,
          sigmae=smeeData.sigmae*m/3)
            annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
        Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorDisplacementAngle(p=smee.p, m=m) annotation (Placement(transformation(
              origin={20,-40},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
            Placement(transformation(
              origin={-40,-70},
              extent={{-10,-10},{10,10}})));
        Modelica.Mechanics.Rotational.Sensors.MultiSensor mechanicalSensor annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
        Modelica.Electrical.MultiPhase.Sensors.MultiSensor electricalSensor(m=m) annotation (Placement(transformation(
              origin={40,30},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSSensor(m=m) annotation (Placement(transformation(
              origin={40,0},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          final V=fill(VNominal*sqrt(2), m),
          final freqHz=fill(fNominal, m)) annotation (Placement(transformation(
                extent={{-10,40},{-30,60}})));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-40,40},{-60,60}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-60,30},
              extent={{-10,-10},{10,10}})));
        Modelica.Electrical.Analog.Sources.RampVoltage rampVoltage(
          duration=0.1,
          V=Ve,
          offset=0,
          startTime=0.5) annotation (Placement(transformation(
              origin={-40,-40},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y", m=m) annotation (Placement(transformation(extent={{-20,-34},{0,-14}})));
        parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData(
          SNominal=30e3,
          VsNominal=100,
          fsNominal=50,
          IeOpenCircuit=10,
          x0=0.1,
          xd=1.6,
          xq=1.6,
          xdTransient=0.1375,
          xdSubtransient=0.121428571,
          xqSubtransient=0.148387097,
          Ta=0.014171268,
          Td0Transient=0.261177343,
          Td0Subtransient=0.006963029,
          Tq0Subtransient=0.123345081,
          alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TsSpecification=293.15,
          TsRef=293.15,
          TrSpecification=293.15,
          TrRef=293.15,
          TeSpecification=293.15,
          TeRef=293.15) annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));

        Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch switch(
          final m=m,
          Ron=fill(1e-5*m/3, m),
          Goff=fill(1e-5*m/3, m)) annotation (Placement(transformation(
              origin={10,50},
              extent={{-10,10},{10,-10}})));
        Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0) annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
        Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout=m) annotation (Placement(transformation(extent={{-20,20},{0,0}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep(
          offsetTorque=0,
          stepTorque=50,
          startTime=2) annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
      initial equation
        // sum(smee.is) = 0;
        smee.is[1:2] = zeros(2);
        smee.ie = 0;
        //conditional damper cage currents are defined as fixed start values
      equation
        connect(rotorDisplacementAngle.plug_n, smee.plug_sn) annotation (Line(
              points={{26,-30},{26,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
        connect(rotorDisplacementAngle.plug_p, smee.plug_sp)
          annotation (Line(points={{14,-30},{-4,-30}}, color={0,0,255}));
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-60,50},{-60,40}}, color={0,0,255}));
        connect(star.plug_p, sineVoltage.plug_n)
          annotation (Line(points={{-40,50},{-30,50}}, color={0,0,255}));
        connect(terminalBox.plugSupply, currentRMSSensor.plug_n) annotation (Line(points={{-10,-28},{-10,-10},{40,-10}}, color={0,0,255}));
        connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
            points={{-16,-30},{-16,-30}},
            color={0,0,255}));
        connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
            points={{-4,-30},{-4,-30}},
            color={0,0,255}));
        connect(smee.flange, rotorDisplacementAngle.flange) annotation (Line(
            points={{0,-40},{10,-40}}));
        connect(smee.flange, mechanicalSensor.flange_a) annotation (Line(points={{0,-40},{40,-40}}));
        connect(sineVoltage.plug_p, switch.plug_p) annotation (Line(points={{-10,50},{0,50}}, color={0,0,255}));
        connect(booleanReplicator.y, switch.control) annotation (Line(points={{1,10},{10,10},{10,38}}, color={255,0,255}));
        connect(booleanStep.y, booleanReplicator.u)
          annotation (Line(points={{-29,10},{-22,10}}, color={255,0,255}));
        connect(groundExcitation.p, rampVoltage.n)
          annotation (Line(points={{-40,-60},{-40,-60},{-40,-56},{-40,-56},{-40,-50},{-40,-50}},
                                                         color={0,0,255}));
        connect(rampVoltage.n, smee.pin_en) annotation (Line(points={{-40,-50},{-30,-50},{-30,-46},{-20,-46}},
                                                color={0,0,255}));
        connect(rampVoltage.p, smee.pin_ep) annotation (Line(points={{-40,-30},{-30,-30},{-30,-34},{-20,-34}},
                                                color={0,0,255}));
        connect(mechanicalSensor.flange_b, torqueStep.flange) annotation (Line(points={{60,-40},{70,-40}}));
        connect(switch.plug_n, electricalSensor.pc) annotation (Line(points={{20,50},{40,50},{40,40}}, color={0,0,255}));
        connect(electricalSensor.nv, terminalBox.plug_sn) annotation (Line(points={{30,30},{20,30},{20,-20},{-16,-20},{-16,-30}}, color={0,0,255}));
        connect(electricalSensor.nc, currentRMSSensor.plug_p) annotation (Line(points={{40,20},{40,10}}, color={0,0,255}));
        connect(electricalSensor.pv, electricalSensor.pc) annotation (Line(points={{50,30},{50,40},{40,40}}, color={0,0,255}));
        annotation (experiment(StopTime=3,Interval=0.0001,Tolerance=1e-006),
          Documentation(info="<html>
<p>An electrically excited synchronous generator is started direct on line utilizing the damper cage
(and the shorted excitation winding) at 0 seconds.</p>
<p>At t = 0.5 seconds, the excitation voltage is raised to achieve the no-load excitation current.
Note, that reactive power of the stator goes to zero.</p>
<p>At t = 2 second, a driving torque step is applied to the shaft (i.e. the turbine is activated).
Note, that the active (and the reactive) power of the stator change.
To drive at higher torque, i.e., produce more electric power, excitation has to be adapted.
</p>

<p>Simulate for 3 seconds and plot:</p>

<ul>
<li><code>smee.tauElectrical</code>: electric torque</li>
<li><code>smee.wMechanical</code>: mechanical speed</li>
<li><code>currentRMSSensor.I</code>: quasi RMS stator current</li>
<li><code>irRMS</code>: quasi RMS rotor current</li>
<li><code>smee.ie</code>: excitation current</li>
<li><code>rotorDisplacementAngle.rotorDisplacementAngle</code>: rotor displacement angle</li>
<li><code>electricalSensor.powerTotal</code>: total electric real power</li>
<li><code>mechanicalSensor.power</code>: mechanical power</li>
</ul>

<p>Default machine parameters are used.</p>

<h5>Note</h5>
<p>The mains switch is closed at time = 0 in order to avoid non physical noise calculated by the <code>rotorDisplacementAngle</code>.
This noise is caused by the interaction of the high resistance of the switch and the machine, see
<a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2388\">#2388</a>.
</p>
</html>"),Diagram(graphics={                      Text(
                        extent={{10,-72},{90,-80}},
                        fillColor={255,255,170},
                        fillPattern=FillPattern.Solid,
                        textStyle={TextStyle.Bold},
                textString="%m phase quasi static")}));
      end SMEE_DOL;

      model SMEE_Generator_MultiPhase
        "Electrical excited multi phase synchronous machine operating as generator"

        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m3=3 "Number of stator phases of threephase system";
        parameter Integer m=5 "Number of stator phases";
        parameter Modelica.SIunits.Voltage VsNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fsNominal=smeeData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.AngularVelocity w=
            Modelica.SIunits.Conversions.from_rpm(1499) "Nominal speed";
        parameter Modelica.SIunits.Current Ie=19 "Excitation current";
        parameter Modelica.SIunits.Current Ie0=10 "Initial excitation current";
        parameter Modelica.SIunits.Angle gamma0(displayUnit="deg") = 0
          "Initial rotor displacement angle";
        parameter Integer p=2 "Number of pole pairs";
        parameter Modelica.SIunits.Resistance Rs=0.03
          "Warm stator resistance per phase";
        parameter Modelica.SIunits.Inductance Lssigma=0.1/(2*Modelica.Constants.pi
            *fsNominal) "Stator stray inductance per phase";
        parameter Modelica.SIunits.Inductance Lmd=1.5/(2*Modelica.Constants.pi*
            fsNominal) "Main field inductance in d-axis";
        parameter Modelica.SIunits.Inductance Lmq=1.5/(2*Modelica.Constants.pi*
            fsNominal) "Main field inductance in q-axis";
        parameter Modelica.SIunits.Inductance Lrsigmad=0.05/(2*Modelica.Constants.pi
            *fsNominal)
          "Damper stray inductance (equivalent three phase winding) d-axis";
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Damper stray inductance (equivalent three phase winding) q-axis";
        parameter Modelica.SIunits.Resistance Rrd=0.04
          "Warm damper resistance (equivalent three phase winding) d-axis";
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Warm damper resistance (equivalent three phase winding) q-axis";
        Modelica.Electrical.MultiPhase.Basic.Star star3(final m=m3) annotation (
           Placement(transformation(extent={{-50,-30},{-70,-10}})));
        Modelica.Electrical.Analog.Basic.Ground ground3 annotation (Placement(
              transformation(
              origin={-90,-20},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage3(
          final m=m3,
          final V=fill(VsNominal*sqrt(2), m3),
          phase=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
              m3),
          final freqHz=fill(fsNominal, m3)) annotation (Placement(
              transformation(extent={{-20,-30},{-40,-10}})));
        Modelica.Electrical.MultiPhase.Sensors.PowerSensor
          electricalPowerSensorM(m=m) annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={-2,80})));
        Electrical.Machines.Sensors.ElectricalPowerSensor
          electricalPowerSensor3 annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              origin={0,-20})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
            terminalConnection="Y", m=m) annotation (Placement(transformation(
                extent={{-10,46},{10,66}})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox3(
            terminalConnection="Y", m=m3) annotation (Placement(transformation(
                extent={{-10,-74},{10,-54}})));
        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
          smeeM(
          phiMechanical(start=-(Modelica.Constants.pi + gamma0)/p, fixed=true),
          Jr=0.29,
          Js=0.29,
          p=2,
          fsNominal=smeeData.fsNominal,
          TsRef=smeeData.TsRef,
          alpha20s(displayUnit="1/K") = smeeData.alpha20s,
          useDamperCage=true,
          Lrsigmad=smeeData.Lrsigmad,
          Lrsigmaq=smeeData.Lrsigmaq,
          Rrd=smeeData.Rrd,
          Rrq=smeeData.Rrq,
          TrRef=smeeData.TrRef,
          alpha20r(displayUnit="1/K") = smeeData.alpha20r,
          VsNominal=smeeData.VsNominal,
          IeOpenCircuit=smeeData.IeOpenCircuit,
          Re=smeeData.Re,
          TeRef=smeeData.TeRef,
          alpha20e(displayUnit="1/K") = smeeData.alpha20e,
          m=m,
          Rs=smeeData.Rs*m/3,
          Lssigma=smeeData.Lssigma*m/3,
          Lmd=smeeData.Lmd*m/3,
          Lmq=smeeData.Lmq*m/3,
          statorCoreParameters(VRef=100),
          strayLoadParameters(IRef=100),
          brushParameters(ILinear=0.01),
          ir(each fixed=true),
          effectiveStatorTurns=smeeData.effectiveStatorTurns,
          TsOperational=293.15,
          TrOperational=293.15,
          TeOperational=293.15,
          sigmae=smeeData.sigmae*m/3)
                               annotation (Placement(transformation(extent={{-10,30},
                  {10,50}})));

        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
          smee3(
          phiMechanical(start=-(Modelica.Constants.pi + gamma0)/p, fixed=true),
          p=2,
          fsNominal=smeeData.fsNominal,
          Rs=smeeData.Rs,
          TsRef=smeeData.TsRef,
          alpha20s(displayUnit="1/K") = smeeData.alpha20s,
          Lssigma=smeeData.Lssigma,
          Jr=0.29,
          Js=0.29,
          frictionParameters(PRef=0),
          statorCoreParameters(PRef=0, VRef=100),
          strayLoadParameters(PRef=0, IRef=100),
          Lmd=smeeData.Lmd,
          Lmq=smeeData.Lmq,
          useDamperCage=true,
          Lrsigmad=smeeData.Lrsigmad,
          Rrd=smeeData.Rrd,
          Rrq=smeeData.Rrq,
          alpha20r(displayUnit="1/K") = smeeData.alpha20r,
          VsNominal=smeeData.VsNominal,
          IeOpenCircuit=smeeData.IeOpenCircuit,
          Re=smeeData.Re,
          TeRef=smeeData.TeRef,
          alpha20e(displayUnit="1/K") = smeeData.alpha20e,
          sigmae=smeeData.sigmae,
          brushParameters(V=0, ILinear=0.01),
          Lrsigmaq=smeeData.Lrsigmaq,
          TrRef=smeeData.TrRef,
          m=m3,
          ir(each fixed=true),
          TsOperational=293.15,
          effectiveStatorTurns=smeeData.effectiveStatorTurns,
          TrOperational=293.15,
          TeOperational=293.15)
                               annotation (Placement(transformation(extent={{-10,-90},
                  {10,-70}})));

        Modelica.Electrical.Analog.Basic.Ground groundRM annotation (Placement(
              transformation(
              origin={-20,20},
              extent={{-10,-10},{10,10}})));
        Modelica.Electrical.Analog.Basic.Ground groundR3 annotation (Placement(
              transformation(
              origin={-20,-100},
              extent={{-10,-10},{10,10}})));
        Modelica.Electrical.Analog.Sources.RampCurrent rampCurrentM(
          duration=0.1,
          I=Ie - Ie0,
          offset=Ie0) annotation (Placement(transformation(
              origin={-30,40},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.Analog.Sources.RampCurrent rampCurrent3(
          duration=0.1,
          I=Ie - Ie0,
          offset=Ie0) annotation (Placement(transformation(
              origin={-30,-80},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngle3(
           p=p) annotation (Placement(transformation(
              origin={30,-80},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
          mechanicalPowerSensorM annotation (Placement(transformation(extent={{
                  20,30},{40,50}})));
        Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
          mechanicalPowerSensor3 annotation (Placement(transformation(extent={{
                  50,-90},{70,-70}})));
        Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeedM(
            final w_fixed=w, useSupport=false) annotation (Placement(
              transformation(extent={{70,30},{50,50}})));
        Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed3(
            final w_fixed=w, useSupport=false) annotation (Placement(
              transformation(extent={{100,-90},{80,-70}})));
        parameter Electrical.Machines.Utilities.SynchronousMachineData smeeData(
          SNominal=30e3,
          VsNominal=100,
          fsNominal=50,
          IeOpenCircuit=10,
          x0=0.1,
          xd=1.6,
          xq=1.6,
          xdTransient=0.1375,
          xdSubtransient=0.121428571,
          xqSubtransient=0.148387097,
          Ta=0.014171268,
          Td0Transient=0.261177343,
          Td0Subtransient=0.006963029,
          Tq0Subtransient=0.123345081,
          alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TsSpecification=293.15,
          TsRef=293.15,
          TrSpecification=293.15,
          TrRef=293.15,
          TeSpecification=293.15,
          TeRef=293.15) annotation (Placement(transformation(extent={{-100,-100},
                  {-80,-80}})));

        Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor
          currentRMSsensorM(m=m) annotation (Placement(transformation(
              origin={30,80},
              extent={{-10,10},{10,-10}})));
        Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
          currentRMSsensor3 annotation (Placement(transformation(
              origin={30,-20},
              extent={{-10,10},{10,-10}})));
        Modelica.Blocks.Math.Gain gain(k=(m/m3)) annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={90,30})));
        Modelica.Blocks.Math.Feedback feedback annotation (Placement(
              transformation(
              extent={{-10,10},{10,-10}},
              origin={90,0})));
        Modelica.Electrical.MultiPhase.Basic.Star starM(final m=m) annotation (
            Placement(transformation(extent={{-50,70},{-70,90}})));
        Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
              transformation(
              origin={-90,80},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltageM(
          final V=fill(VsNominal*sqrt(2), m),
          final freqHz=fill(fsNominal, m),
          final m=m,
          phase=-Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(
              m)) annotation (Placement(transformation(extent={{-20,70},{-40,90}})));
      initial equation
        smee3.is[1:2] = zeros(2);
        smeeM.is[1:2] = zeros(2);
        //conditional damper cage currents are defined as fixed start values
      equation
        connect(rotorAngle3.plug_n, smee3.plug_sn) annotation (Line(points={{36,
                -70},{36,-60},{-6,-60},{-6,-70}}, color={0,0,255}));
        connect(rotorAngle3.plug_p, smee3.plug_sp)
          annotation (Line(points={{24,-70},{6,-70}}, color={0,0,255}));
        connect(rotorAngle3.flange, smee3.flange)
          annotation (Line(points={{20,-80},{10,-80}}));
        connect(star3.pin_n, ground3.p) annotation (Line(points={{-70,-20},{-75,
                -20},{-80,-20}}, color={0,0,255}));
        connect(star3.plug_p, sineVoltage3.plug_n) annotation (Line(points={{-50,
                -20},{-48,-20},{-46,-20},{-40,-20}}, color={0,0,255}));
        connect(smee3.flange, mechanicalPowerSensor3.flange_a)
          annotation (Line(points={{10,-80},{50,-80}}));
        connect(mechanicalPowerSensor3.flange_b, constantSpeed3.flange)
          annotation (Line(points={{70,-80},{80,-80}}));
        connect(rampCurrent3.p, groundR3.p) annotation (Line(points={{-30,-90},
                {-26,-90},{-20,-90}}, color={0,0,255}));
        connect(rampCurrent3.p, smee3.pin_en) annotation (Line(points={{-30,-90},
                {-20,-90},{-20,-86},{-10,-86}},color={0,0,255}));
        connect(rampCurrent3.n, smee3.pin_ep) annotation (Line(points={{-30,-70},
                {-20,-70},{-20,-74},{-10,-74}},color={0,0,255}));
        connect(smee3.plug_sn, terminalBox3.plug_sn)
          annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
        connect(smee3.plug_sp, terminalBox3.plug_sp)
          annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
        connect(smeeM.flange, mechanicalPowerSensorM.flange_a)
          annotation (Line(points={{10,40},{10,40},{20,40}}));
        connect(mechanicalPowerSensorM.flange_b, constantSpeedM.flange)
          annotation (Line(points={{40,40},{44,40},{46,40},{50,40}}, color={0,0,
                0}));
        connect(rampCurrentM.p, groundRM.p) annotation (Line(points={{-30,30},{
                -30,30},{-20,30}}, color={0,0,255}));
        connect(rampCurrentM.p, smeeM.pin_en) annotation (Line(points={{-30,30},
                {-20,30},{-20,34},{-10,34}}, color={0,0,255}));
        connect(rampCurrentM.n, smeeM.pin_ep) annotation (Line(points={{-30,50},
                {-20,50},{-20,46},{-10,46}}, color={0,0,255}));
        connect(smeeM.plug_sn, terminalBoxM.plug_sn)
          annotation (Line(points={{-6,50},{-6,50}}, color={0,0,255}));
        connect(smeeM.plug_sp, terminalBoxM.plug_sp)
          annotation (Line(points={{6,50},{6,50}}, color={0,0,255}));
        connect(electricalPowerSensor3.plug_p, sineVoltage3.plug_p) annotation (
           Line(
            points={{-10,-20},{-20,-20}},
            color={0,0,255}));
        connect(electricalPowerSensor3.plug_nv, star3.plug_p) annotation (Line(
            points={{0,-10},{0,-8},{-50,-8},{-50,-20}},
            color={0,0,255}));
        connect(gain.y, feedback.u2) annotation (Line(
            points={{90,19},{90,8}},
            color={0,0,127}));
        connect(electricalPowerSensor3.plug_ni, currentRMSsensor3.plug_p)
          annotation (Line(
            points={{10,-20},{20,-20}},
            color={0,0,255}));
        connect(currentRMSsensor3.plug_n, terminalBox3.plugSupply) annotation (
            Line(
            points={{40,-20},{40,-40},{0,-40},{0,-68}},
            color={0,0,255}));
        connect(currentRMSsensor3.I, feedback.u1) annotation (Line(
            points={{30,-9},{30,0},{82,0}},
            color={0,0,127}));
        connect(terminalBoxM.plugSupply, currentRMSsensorM.plug_n) annotation (
            Line(
            points={{0,52},{0,60},{40,60},{40,80}},
            color={0,0,255}));
        connect(currentRMSsensorM.I, gain.u) annotation (Line(
            points={{30,91},{30,100},{90,100},{90,42}},
            color={0,0,127}));
        connect(starM.pin_n, groundM.p) annotation (Line(points={{-70,80},{-75,
                80},{-80,80}}, color={0,0,255}));
        connect(starM.plug_p, sineVoltageM.plug_n) annotation (Line(points={{-50,
                80},{-48,80},{-40,80}}, color={0,0,255}));
        connect(sineVoltageM.plug_p, electricalPowerSensorM.pc) annotation (
            Line(
            points={{-20,80},{-12,80}},
            color={0,0,255}));
        connect(electricalPowerSensorM.pc, electricalPowerSensorM.pv)
          annotation (Line(
            points={{-12,80},{-12,70},{-2,70}},
            color={0,0,255}));
        connect(electricalPowerSensorM.nc, currentRMSsensorM.plug_p)
          annotation (Line(
            points={{8,80},{20,80}},
            color={0,0,255}));
        connect(electricalPowerSensorM.nv, starM.plug_p) annotation (Line(
            points={{-2,90},{-2,94},{-50,94},{-50,80}},
            color={0,0,255}));
        annotation (
          experiment(
            StopTime=30,
            Interval=0.001,
            Tolerance=1e-06),
          Documentation(info="<html>
<h4>Electrical excited synchronous induction machine as generator</h4>
<p>
Two
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited\">electrically excited synchronous generators</a> are connected to grids and driven with constant speed.
Since speed is slightly smaller than synchronous speed corresponding to mains frequency,
rotor angle is very slowly increased. Two equivalent machines with different numbers of phases are compared and their equal behavior is demonstrated.
</p>

<p>
Simulate for 30 seconds and plot (versus <code>rotorAngleM3.rotorDisplacementAngle</code>):
</p>

<ul>
<li><code>aimcM|M3.tauElectrical</code>: machine torque</li>
<li><code>aimsM|M3.wMechanical</code>: machine speed</li>
<li><code>feedback.y</code>: zero since difference of three phase current phasor and scaled multi phase current phasor are equal</li>
</ul>

</html>"),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={Rectangle(
                      extent={{-50,60},{70,20}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      pattern=LinePattern.Dash),Text(
                      extent={{10,16},{70,8}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      textStyle={TextStyle.Bold},
                      textString="%m phase machine
"),           Text(
                extent={{10,-52},{70,-60}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      textStyle={TextStyle.Bold},
                      textString="3 phase machine
"),           Rectangle(
                extent={{-50,-60},{100,-100}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      pattern=LinePattern.Dash)}));
      end SMEE_Generator_MultiPhase;

      model SMEE_Generator
        "Electrical excited synchronous machine operating as generator"
        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of stator phases";
        parameter Modelica.SIunits.Voltage VsNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fsNominal=smeeData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.AngularVelocity w=
            Modelica.SIunits.Conversions.from_rpm(1499) "Nominal speed";
        parameter Modelica.SIunits.Current Ie=19 "Excitation current";
        parameter Modelica.SIunits.Current Ie0=10 "Initial excitation current";
        parameter Modelica.SIunits.Angle gamma0(displayUnit="deg") = 0
          "Initial rotor displacement angle";
        parameter Integer p=2 "Number of pole pairs";
        parameter Modelica.SIunits.Resistance Rs=0.03
          "Warm stator resistance per phase";
        parameter Modelica.SIunits.Inductance Lssigma=0.1/(2*Modelica.Constants.pi
            *fsNominal) "Stator stray inductance per phase";
        parameter Modelica.SIunits.Inductance Lmd=1.5/(2*Modelica.Constants.pi*
            fsNominal) "Main field inductance in d-axis";
        parameter Modelica.SIunits.Inductance Lmq=1.5/(2*Modelica.Constants.pi*
            fsNominal) "Main field inductance in q-axis";
        parameter Modelica.SIunits.Inductance Lrsigmad=0.05/(2*Modelica.Constants.pi
            *fsNominal)
          "Damper stray inductance (equivalent three phase winding) d-axis";
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Damper stray inductance (equivalent three phase winding) q-axis";
        parameter Modelica.SIunits.Resistance Rrd=0.04
          "Warm damper resistance (equivalent three phase winding) d-axis";
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Warm damper resistance (equivalent three phase winding) q-axis";
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Sources.SineVoltage sineVoltage(
          final m=m,
          final V=fill(VsNominal*sqrt(2), m),
          final freqHz=fill(fsNominal, m)) annotation (Placement(transformation(
                extent={{-20,80},{-40,100}})));
        Electrical.Machines.Sensors.ElectricalPowerSensor
          electricalPowerSensorM annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,30})));
        Electrical.Machines.Sensors.ElectricalPowerSensor
          electricalPowerSensorE annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=270,
              origin={-60,30})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
            terminalConnection="Y") annotation (Placement(transformation(extent={{-10,-14},
                  {10,6}})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxE(
            terminalConnection="Y") annotation (Placement(transformation(extent={{-10,-74},
                  {10,-54}})));
        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
          smeeM(
          phiMechanical(start=-(Modelica.Constants.pi + gamma0)/p, fixed=true),
          Jr=0.29,
          Js=0.29,
          p=2,
          fsNominal=smeeData.fsNominal,
          Rs=smeeData.Rs,
          TsRef=smeeData.TsRef,
          alpha20s(displayUnit="1/K") = smeeData.alpha20s,
          Lssigma=smeeData.Lssigma,
          Lmd=smeeData.Lmd,
          Lmq=smeeData.Lmq,
          useDamperCage=true,
          Lrsigmad=smeeData.Lrsigmad,
          Lrsigmaq=smeeData.Lrsigmaq,
          Rrd=smeeData.Rrd,
          Rrq=smeeData.Rrq,
          TrRef=smeeData.TrRef,
          alpha20r(displayUnit="1/K") = smeeData.alpha20r,
          VsNominal=smeeData.VsNominal,
          IeOpenCircuit=smeeData.IeOpenCircuit,
          Re=smeeData.Re,
          TeRef=smeeData.TeRef,
          alpha20e(displayUnit="1/K") = smeeData.alpha20e,
          sigmae=smeeData.sigmae,
          statorCoreParameters(VRef=100),
          strayLoadParameters(IRef=100),
          brushParameters(ILinear=0.01),
          ir(each fixed=true),
          TsOperational=293.15,
          effectiveStatorTurns=smeeData.effectiveStatorTurns,
          TrOperational=293.15,
          TeOperational=293.15)
                               annotation (Placement(transformation(extent={{-10,-30},
                  {10,-10}})));

        Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
          smeeE(
          phiMechanical(start=-(Modelica.Constants.pi + gamma0)/p, fixed=true),
          p=2,
          fsNominal=smeeData.fsNominal,
          Rs=smeeData.Rs,
          TsRef=smeeData.TsRef,
          alpha20s(displayUnit="1/K") = smeeData.alpha20s,
          Lssigma=smeeData.Lssigma,
          Jr=0.29,
          Js=0.29,
          frictionParameters(PRef=0),
          statorCoreParameters(PRef=0, VRef=100),
          strayLoadParameters(PRef=0, IRef=100),
          Lmd=smeeData.Lmd,
          Lmq=smeeData.Lmq,
          useDamperCage=true,
          Lrsigmad=smeeData.Lrsigmad,
          Rrd=smeeData.Rrd,
          Rrq=smeeData.Rrq,
          alpha20r(displayUnit="1/K") = smeeData.alpha20r,
          VsNominal=smeeData.VsNominal,
          IeOpenCircuit=smeeData.IeOpenCircuit,
          Re=smeeData.Re,
          TeRef=smeeData.TeRef,
          alpha20e(displayUnit="1/K") = smeeData.alpha20e,
          sigmae=smeeData.sigmae,
          brushParameters(V=0, ILinear=0.01),
          Lrsigmaq=smeeData.Lrsigmaq,
          TrRef=smeeData.TrRef,
          TsOperational=293.15,
          ir(each fixed=true),
          TrOperational=293.15,
          TeOperational=293.15) annotation (Placement(transformation(extent={{-10,
                  -90},{10,-70}})));

        Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
              transformation(
              origin={-50,-30},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundE annotation (Placement(
              transformation(
              origin={-50,-90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Analog.Sources.RampCurrent rampCurrentM(
          duration=0.1,
          I=Ie - Ie0,
          offset=Ie0) annotation (Placement(transformation(
              origin={-30,-20},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.Analog.Sources.RampCurrent rampCurrentE(
          duration=0.1,
          I=Ie - Ie0,
          offset=Ie0) annotation (Placement(transformation(
              origin={-30,-80},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleM(
            p=p) annotation (Placement(transformation(
              origin={30,-20},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleE(
            p=p) annotation (Placement(transformation(
              origin={30,-80},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
          mechanicalPowerSensorM annotation (Placement(transformation(extent={{
                  50,-30},{70,-10}})));
        Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
          mechanicalPowerSensorE annotation (Placement(transformation(extent={{
                  50,-90},{70,-70}})));
        Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeedM(
            final w_fixed=w, useSupport=false) annotation (Placement(
              transformation(extent={{100,-30},{80,-10}})));
        Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeedE(
            final w_fixed=w, useSupport=false) annotation (Placement(
              transformation(extent={{100,-90},{80,-70}})));
        parameter Electrical.Machines.Utilities.SynchronousMachineData smeeData(
          SNominal=30e3,
          VsNominal=100,
          fsNominal=50,
          IeOpenCircuit=10,
          x0=0.1,
          xd=1.6,
          xq=1.6,
          xdTransient=0.1375,
          xdSubtransient=0.121428571,
          xqSubtransient=0.148387097,
          Ta=0.014171268,
          Td0Transient=0.261177343,
          Td0Subtransient=0.006963029,
          Tq0Subtransient=0.123345081,
          alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TsSpecification=293.15,
          TsRef=293.15,
          TrSpecification=293.15,
          TrRef=293.15,
          TeSpecification=293.15,
          TeRef=293.15)
          annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
        Modelica.SIunits.Angle thetaM=rotorAngleM.rotorDisplacementAngle "Rotor displacement angle, FundamentalWave machine";
        Modelica.SIunits.Angle thetaE=rotorAngleE.rotorDisplacementAngle "Rotor displacement angle, Electrical machine";

      initial equation
        smeeE.is[1:2] = zeros(2);
        smeeM.is[1:2] = zeros(2);
        //conditional damper cage currents are defined as fixed start values
      equation
        connect(rotorAngleE.plug_n, smeeE.plug_sn) annotation (Line(points={{36,
                -70},{36,-60},{-6,-60},{-6,-70}}, color={0,0,255}));
        connect(rotorAngleE.plug_p, smeeE.plug_sp)
          annotation (Line(points={{24,-70},{6,-70}}, color={0,0,255}));
        connect(rotorAngleE.flange, smeeE.flange)
          annotation (Line(points={{20,-80},{10,-80}}));
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(star.plug_p, sineVoltage.plug_n)
          annotation (Line(points={{-50,90},{-40,90}}, color={0,0,255}));
        connect(smeeE.flange, mechanicalPowerSensorE.flange_a)
          annotation (Line(points={{10,-80},{50,-80}}));
        connect(mechanicalPowerSensorE.flange_b, constantSpeedE.flange)
          annotation (Line(points={{70,-80},{80,-80}}));
        connect(rampCurrentE.p, groundE.p)
          annotation (Line(points={{-30,-90},{-40,-90}}, color={0,0,255}));
        connect(rampCurrentE.p, smeeE.pin_en) annotation (Line(points={{-30,-90},
                {-20,-90},{-20,-86},{-10,-86}},color={0,0,255}));
        connect(rampCurrentE.n, smeeE.pin_ep) annotation (Line(points={{-30,-70},
                {-20,-70},{-20,-74},{-10,-74}},color={0,0,255}));
        connect(smeeE.plug_sn, terminalBoxE.plug_sn)
          annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
        connect(smeeE.plug_sp, terminalBoxE.plug_sp)
          annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
        connect(rotorAngleM.plug_n, smeeM.plug_sn) annotation (Line(points={{36,
                -10},{36,0},{-6,0},{-6,-10}}, color={0,0,255}));
        connect(rotorAngleM.plug_p, smeeM.plug_sp) annotation (Line(points={{24,
                -10},{24,-10},{6,-10}}, color={0,0,255}));
        connect(rotorAngleM.flange, smeeM.flange) annotation (Line(points={{20,
                -20},{15,-20},{10,-20}}));
        connect(smeeM.flange, mechanicalPowerSensorM.flange_a)
          annotation (Line(points={{10,-20},{50,-20}}));
        connect(mechanicalPowerSensorM.flange_b, constantSpeedM.flange)
          annotation (Line(points={{70,-20},{80,-20}}));
        connect(rampCurrentM.p, groundM.p) annotation (Line(points={{-30,-30},{
                -35,-30},{-35,-30},{-40,-30}}, color={0,0,255}));
        connect(rampCurrentM.p, smeeM.pin_en) annotation (Line(points={{-30,-30},
                {-20,-30},{-20,-26},{-10,-26}}, color={0,0,255}));
        connect(rampCurrentM.n, smeeM.pin_ep) annotation (Line(points={{-30,-10},
                {-20,-10},{-20,-14},{-10,-14}}, color={0,0,255}));
        connect(smeeM.plug_sn, terminalBoxM.plug_sn)
          annotation (Line(points={{-6,-10},{-6,-10}}, color={0,0,255}));
        connect(smeeM.plug_sp, terminalBoxM.plug_sp)
          annotation (Line(points={{6,-10},{6,-10}}, color={0,0,255}));
        connect(electricalPowerSensorM.plug_p, sineVoltage.plug_p) annotation (
            Line(
            points={{0,40},{0,90},{-20,90}},
            color={0,0,255}));
        connect(electricalPowerSensorE.plug_p, sineVoltage.plug_p) annotation (
            Line(
            points={{-60,40},{0,40},{0,90},{-20,90}},
            color={0,0,255}));
        connect(electricalPowerSensorM.plug_ni, terminalBoxM.plugSupply)
          annotation (Line(
            points={{0,20},{0,-8}},
            color={0,0,255}));
        connect(electricalPowerSensorE.plug_ni, terminalBoxE.plugSupply)
          annotation (Line(
            points={{-60,20},{-60,-50},{0,-50},{0,-68}},
            color={0,0,255}));
        connect(electricalPowerSensorE.plug_nv, star.plug_p) annotation (Line(
            points={{-50,30},{-50,90}},
            color={0,0,255}));
        connect(electricalPowerSensorM.plug_nv, star.plug_p) annotation (Line(
            points={{-10,30},{-50,30},{-50,90}},
            color={0,0,255}));
        annotation (experiment(
            StopTime=30,
            Interval=0.001,
            Tolerance=1e-06), Documentation(info="<html>
<h4>Electrical excited synchronous induction machine as generator</h4>
<p>
An
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited\">electrically excited synchronous generator</a> is connected to the grid and driven with constant speed.
Since speed is slightly smaller than synchronous speed corresponding to mains frequency,
rotor angle is very slowly increased. This allows to see several characteristics dependent on rotor angle.
</p>

<p>
Simulate for 30 seconds and plot (versus <code>rotorAngleM.rotorDisplacementAngle</code>):
</p>

<ul>
<li><code>speedM|E.tauElectrical</code>: machine torque</li>
<li><code>mechanicalPowerSensorM|E.P</code>: mechanical power</li>
</ul>
</html>"));
      end SMEE_Generator;

      model SMEE_LoadDump "Test example: ElectricalExcitedSynchronousInductionMachine with voltage controller"

        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smeeData.fsNominal
            /smee.p "Nominal speed";
        parameter Modelica.SIunits.Impedance ZNominal=3*smeeData.VsNominal^2/
            smeeData.SNominal "Nominal load impedance";
        parameter Real powerFactor(
          min=0,
          max=1) = 0.8 "Load power factor";
        parameter Modelica.SIunits.Resistance RLoad=ZNominal*powerFactor
          "Load resistance";
        parameter Modelica.SIunits.Inductance LLoad=ZNominal*sqrt(1 -
            powerFactor^2)/(2*pi*smeeData.fsNominal) "Load inductance";
        parameter Modelica.SIunits.Voltage Ve0=smee.IeOpenCircuit*
            Electrical.Machines.Thermal.convertResistance(
                  smee.Re,
                  smee.TeRef,
                  smee.alpha20e,
                  smee.TeOperational) "No load excitation voltage";
        parameter Real k=2*Ve0/smeeData.VsNominal "Voltage controller: gain";
        parameter Modelica.SIunits.Time Ti=smeeData.Td0Transient/2
          "Voltage controller: integral time constant";
        output Real controlError=(setPointGain.y - voltageQuasiRMSSensor.V)/
            smeeData.VsNominal;
        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited smee(
          fsNominal=smeeData.fsNominal,
          TsRef=smeeData.TsRef,
          Lrsigmad=smeeData.Lrsigmad,
          Lrsigmaq=smeeData.Lrsigmaq,
          Rrd=smeeData.Rrd,
          Rrq=smeeData.Rrq,
          TrRef=smeeData.TrRef,
          VsNominal=smeeData.VsNominal,
          IeOpenCircuit=smeeData.IeOpenCircuit,
          Re=smeeData.Re,
          TeRef=smeeData.TeRef,
          sigmae=smeeData.sigmae,
          useDamperCage=true,
          p=2,
          Jr=0.29,
          Js=0.29,
          statorCoreParameters(VRef=100),
          strayLoadParameters(IRef=100),
          brushParameters(ILinear=0.01),
          Rs=smeeData.Rs*m/3,
          Lssigma=smeeData.Lssigma*m/3,
          Lmd=smeeData.Lmd*m/3,
          Lmq=smeeData.Lmq*m/3,
          TsOperational=293.15,
          alpha20s=smeeData.alpha20s,
          effectiveStatorTurns=smeeData.effectiveStatorTurns,
          alpha20r=smeeData.alpha20r,
          TrOperational=293.15,
          TeOperational=293.15,
          alpha20e=smeeData.alpha20e)
                                annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
        parameter Electrical.Machines.Utilities.SynchronousMachineData smeeData(
          SNominal=30e3,
          VsNominal=100,
          fsNominal=50,
          IeOpenCircuit=10,
          x0=0.1,
          xd=1.6,
          xq=1.6,
          xdTransient=0.1375,
          xdSubtransient=0.121428571,
          xqSubtransient=0.148387097,
          Ta=0.014171268,
          Td0Transient=0.261177343,
          Td0Subtransient=0.006963029,
          Tq0Subtransient=0.123345081,
          TsSpecification=293.15,
          TsRef=293.15,
          alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TrSpecification=293.15,
          TrRef=293.15,
          alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TeSpecification=293.15,
          TeRef=293.15,
          alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero) annotation (Placement(transformation(extent={{0,-70},{20,-50}})));

        Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y") annotation (Placement(transformation(extent={{0,-24},{20,-4}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,0},
              extent={{-10,-10},{10,10}})));
        Modelica.Mechanics.Rotational.Sources.Speed speed
          annotation (Placement(transformation(extent={{50,-40},{30,-20}})));
        Modelica.Blocks.Sources.Ramp speedRamp(height=wNominal, duration=1)
          annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={30,-50})));
        Modelica.Blocks.Math.Gain setPointGain(k=(smeeData.VsNominal/wNominal)/
              unitMagneticFlux)
          annotation (Placement(transformation(extent={{-50,-90},{-70,-70}})));
        Electrical.Machines.Sensors.VoltageQuasiRMSSensor voltageQuasiRMSSensor(ToSpacePhasor1(y(each start=1E-3, each fixed=true))) annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270)));
        Modelica.Blocks.Continuous.LimPID voltageController(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=k,
          Ti=Ti,
          yMax=2.5*Ve0,
          yMin=0,
          initType=Modelica.Blocks.Types.InitPID.InitialState,
          Td=0.001)
          annotation (Placement(transformation(extent={{-70,-20},{-50,-40}})));
        Modelica.Electrical.Analog.Sources.SignalVoltage excitationVoltage
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-30,-30})));
        Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
            Placement(transformation(
              origin={-30,-60},
              extent={{-10,-10},{10,10}})));
        Electrical.Machines.Sensors.CurrentQuasiRMSSensor currentQuasiRMSSensor annotation (Placement(transformation(
              origin={10,30},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Blocks.Sources.BooleanPulse loadControl(period=4, startTime=2)
          annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
        Modelica.Electrical.MultiPhase.Ideal.CloserWithArc switch(
          m=m,
          Ron=fill(1e-5, m),
          Goff=fill(1e-5, m),
          V0=fill(30, m),
          dVdt=fill(10e3, m),
          Vmax=fill(60, m),
          closerWithArc(off(start=fill(true, m), fixed=fill(true, m))))
          annotation (Placement(transformation(extent={{0,40},{-20,60}})));
        Modelica.Electrical.MultiPhase.Basic.Resistor loadResistor(m=m, R=fill(
              RLoad, m))
          annotation (Placement(transformation(extent={{-30,40},{-50,60}})));
        Modelica.Electrical.MultiPhase.Basic.Inductor loadInductor(m=m, L=fill(
              LLoad, m))
          annotation (Placement(transformation(extent={{-60,40},{-80,60}})));
        Modelica.Electrical.MultiPhase.Basic.Star star(m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-90,30})));
      protected
        constant Modelica.SIunits.MagneticFlux unitMagneticFlux=1
          annotation (HideResult=true);
      public
        Blocks.Routing.BooleanReplicator booleanReplicator(nout=m)
          annotation (Placement(transformation(extent={{-50,90},{-30,70}})));
      initial equation
        smee.airGap.V_msr = Complex(0, 0);
        //conditional damper cage currents are defined as fixed start values
        smee.ie = 0;
      equation
        connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
            points={{4,-20},{4,-20}}, color={0,0,255}));
        connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
            points={{16,-20},{16,-20}}, color={0,0,255}));
        connect(excitationVoltage.p, smee.pin_ep) annotation (Line(
            points={{-30,-20},{-20,-20},{-20,-24},{0,-24}}, color={0,0,255}));
        connect(excitationVoltage.n, smee.pin_en) annotation (Line(
            points={{-30,-40},{-20,-40},{-20,-36},{0,-36}}, color={0,0,255}));
        connect(excitationVoltage.n, groundExcitation.p) annotation (Line(
            points={{-30,-40},{-30,-50}}, color={0,0,255}));
        connect(voltageQuasiRMSSensor.plug_n, smee.plug_sn) annotation (Line(
            points={{0,-10},{4,-10},{4,-20}}, color={0,0,255}));
        connect(voltageQuasiRMSSensor.plug_p, smee.plug_sp) annotation (Line(
            points={{0,10},{16,10},{16,-20}}, color={0,0,255}));
        connect(terminalBox.plugSupply, currentQuasiRMSSensor.plug_n)
          annotation (Line(
            points={{10,-18},{10,20}}, color={0,0,255}));
        connect(smee.flange, speed.flange) annotation (Line(
            points={{20,-30},{30,-30}}));
        connect(speed.flange, speedSensor.flange) annotation (Line(
            points={{30,-30},{30,-40}}));
        connect(speedRamp.y, speed.w_ref) annotation (Line(
            points={{59,-30},{52,-30}}, color={0,0,127}));
        connect(setPointGain.y, voltageController.u_s) annotation (Line(
            points={{-71,-80},{-80,-80},{-80,-30},{-72,-30}}, color={0,0,127}));
        connect(speedSensor.w, setPointGain.u) annotation (Line(
            points={{30,-61},{30,-80},{-48,-80}}, color={0,0,127}));
        connect(voltageQuasiRMSSensor.V, voltageController.u_m) annotation (
            Line(
            points={{-11,0},{-60,0},{-60,-18}}, color={0,0,127}));
        connect(voltageController.y, excitationVoltage.v) annotation (Line(
            points={{-49,-30},{-42,-30}}, color={0,0,127}));
        connect(loadInductor.plug_p, loadResistor.plug_n) annotation (Line(
            points={{-60,50},{-50,50}}, color={0,0,255}));
        connect(loadResistor.plug_p, switch.plug_n) annotation (Line(
            points={{-30,50},{-20,50}}, color={0,0,255}));
        connect(switch.plug_p, currentQuasiRMSSensor.plug_p) annotation (Line(
            points={{0,50},{10,50},{10,40}}, color={0,0,255}));
        connect(star.plug_p, loadInductor.plug_n) annotation (Line(
            points={{-90,40},{-90,50},{-80,50}}, color={0,0,255}));
        connect(star.pin_n, ground.p) annotation (Line(
            points={{-90,20},{-90,10}}, color={0,0,255}));
        connect(loadControl.y, booleanReplicator.u) annotation (Line(points={{-59,80},{-52,80}}, color={255,0,255}));
        connect(booleanReplicator.y, switch.control) annotation (Line(points={{-29,80},{-10,80},{-10,62}}, color={255,0,255}));
        annotation (experiment(StopTime=10, Interval=1E-4, Tolerance=1e-06), Documentation(info="<html>
<p>An electrically excited synchronous generator is started with a speed ramp, then driven with constant speed.
Voltage is controlled, the set point depends on speed. After start-up the generator is loaded, the load is rejected.</p>

<p>Simulate for 10 seconds and plot:</p>

<ul>
<li>voltageQuasiRMSSensor.V</li>
<li>smee.tauElectrical</li>
<li>smee.ie</li>
</ul>

<p>Default machine parameters are used</p>
</html>"));
      end SMEE_LoadDump;

      model SMEE_Rectifier "Test example: ElectricalExcitedSynchronousInductionMachine with rectifier"

        extends Modelica.Icons.Example;
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        parameter Modelica.SIunits.AngularVelocity wNominal=2*pi*smeeData.fsNominal
            /smee.p "Nominal speed";
        parameter Modelica.SIunits.Voltage VDC0=sqrt(2*3)*smeeData.VsNominal
          "No-load DC voltage";
        parameter Modelica.SIunits.Resistance RLoad=VDC0^2/smeeData.SNominal
          "Load resistance";
        parameter Modelica.SIunits.Voltage Ve0=smee.IeOpenCircuit*
            Electrical.Machines.Thermal.convertResistance(
                  smee.Re,
                  smee.TeRef,
                  smee.alpha20e,
                  smee.TeOperational) "No load excitation voltage";
        parameter Real k=2*Ve0/smeeData.VsNominal "Voltage controller: gain";
        parameter Modelica.SIunits.Time Ti=smeeData.Td0Transient/2
          "Voltage controller: integral time constant";
        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited smee(
          fsNominal=smeeData.fsNominal,
          TsRef=smeeData.TsRef,
          Lrsigmad=smeeData.Lrsigmad,
          Lrsigmaq=smeeData.Lrsigmaq,
          Rrd=smeeData.Rrd,
          Rrq=smeeData.Rrq,
          TrRef=smeeData.TrRef,
          VsNominal=smeeData.VsNominal,
          IeOpenCircuit=smeeData.IeOpenCircuit,
          Re=smeeData.Re,
          TeRef=smeeData.TeRef,
          sigmae=smeeData.sigmae,
          useDamperCage=true,
          p=2,
          Jr=0.29,
          Js=0.29,
          statorCoreParameters(VRef=100),
          strayLoadParameters(IRef=100),
          brushParameters(ILinear=0.01),
          ir(each fixed=true),
          Rs=smeeData.Rs*m/3,
          Lssigma=smeeData.Lssigma*m/3,
          Lmd=smeeData.Lmd*m/3,
          Lmq=smeeData.Lmq*m/3,
          TsOperational=293.15,
          alpha20s=smeeData.alpha20s,
          effectiveStatorTurns=smeeData.effectiveStatorTurns,
          alpha20r=smeeData.alpha20r,
          TrOperational=293.15,
          TeOperational=293.15,
          alpha20e=smeeData.alpha20e)
                                annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
        parameter Electrical.Machines.Utilities.SynchronousMachineData smeeData(
          SNominal=30e3,
          VsNominal=100,
          fsNominal=50,
          IeOpenCircuit=10,
          x0=0.1,
          xd=1.6,
          xq=1.6,
          xdTransient=0.1375,
          xdSubtransient=0.121428571,
          xqSubtransient=0.148387097,
          Ta=0.014171268,
          Td0Transient=0.261177343,
          Td0Subtransient=0.006963029,
          Tq0Subtransient=0.123345081,
          TsSpecification=293.15,
          TsRef=293.15,
          alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TrSpecification=293.15,
          TrRef=293.15,
          alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TeSpecification=293.15,
          TeRef=293.15,
          alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero) annotation (Placement(transformation(extent={{0,-70},{20,-50}})));

        Electrical.Machines.Utilities.TerminalBox terminalBox(terminalConnection="Y") annotation (Placement(transformation(extent={{0,-24},{20,-4}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-20,60},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Mechanics.Rotational.Sources.Speed speed
          annotation (Placement(transformation(extent={{50,-40},{30,-20}})));
        Blocks.Sources.Constant constantSpeed(k=wNominal)
          annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={30,-50})));
        Modelica.Blocks.Math.Gain setPointGain(k=(smeeData.VsNominal/wNominal)/
              unitMagneticFlux)
          annotation (Placement(transformation(extent={{-50,-90},{-70,-70}})));
        Modelica.Blocks.Continuous.LimPID voltageController(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=k,
          Ti=Ti,
          yMax=2.5*Ve0,
          yMin=0,
          initType=Modelica.Blocks.Types.InitPID.InitialState,
          Td=0.001)
          annotation (Placement(transformation(extent={{-70,-20},{-50,-40}})));
        Modelica.Electrical.Analog.Sources.SignalVoltage excitationVoltage
          annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-30,-30})));
        Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
            Placement(transformation(
              origin={-30,-60},
              extent={{-10,-10},{10,10}})));
        Modelica.Electrical.MultiPhase.Basic.Star star1(m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-20,90})));
        Modelica.Electrical.MultiPhase.Ideal.IdealDiode idealDiode1(
          m=m,
          Ron=fill(1E-5, m),
          Goff=fill(1E-5, m),
          Vknee=fill(0, m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,80})));
        Modelica.Electrical.MultiPhase.Ideal.IdealDiode idealDiode2(
          m=m,
          Ron=fill(1E-5, m),
          Goff=fill(1E-5, m),
          Vknee=fill(0, m)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,40})));
        Modelica.Electrical.MultiPhase.Basic.Star star2(m=m) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-20,30})));
        Modelica.Electrical.Analog.Basic.Capacitor capacitor1(C=2*10E-6, v(
              fixed=true, start=0)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-40,80})));
        Modelica.Electrical.Analog.Basic.Capacitor capacitor2(C=2*10E-6, v(
              fixed=true, start=0)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-40,40})));
        Modelica.Electrical.Analog.Basic.Resistor resistor(R=RLoad) annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-50,60})));
        Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=270,
              origin={-80,60})));
        Modelica.Blocks.Continuous.Filter filter(
          analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
          filterType=Modelica.Blocks.Types.FilterType.LowPass,
          order=2,
          f_cut=20,
          gain=1/sqrt(2*3),
          normalized=true) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,0})));
      protected
        constant Modelica.SIunits.MagneticFlux unitMagneticFlux=1
          annotation (HideResult=true);
      initial equation
        smee.is[1:2] = zeros(2);
        //conditional damper cage currents are defined as fixed start values
        smee.ie = 0;
      equation
        connect(terminalBox.plug_sn, smee.plug_sn) annotation (Line(
            points={{4,-20},{4,-20}}, color={0,0,255}));
        connect(terminalBox.plug_sp, smee.plug_sp) annotation (Line(
            points={{16,-20},{16,-20}}, color={0,0,255}));
        connect(excitationVoltage.p, smee.pin_ep) annotation (Line(
            points={{-30,-20},{-20,-20},{-20,-24},{0,-24}}, color={0,0,255}));
        connect(excitationVoltage.n, smee.pin_en) annotation (Line(
            points={{-30,-40},{-20,-40},{-20,-36},{0,-36}}, color={0,0,255}));
        connect(excitationVoltage.n, groundExcitation.p) annotation (Line(
            points={{-30,-40},{-30,-50}}, color={0,0,255}));
        connect(smee.flange, speed.flange) annotation (Line(
            points={{20,-30},{30,-30}}));
        connect(speed.flange, speedSensor.flange) annotation (Line(
            points={{30,-30},{30,-40}}));
        connect(constantSpeed.y, speed.w_ref) annotation (Line(
            points={{59,-30},{52,-30}}, color={0,0,127}));
        connect(setPointGain.y, voltageController.u_s) annotation (Line(
            points={{-71,-80},{-80,-80},{-80,-30},{-72,-30}}, color={0,0,127}));
        connect(speedSensor.w, setPointGain.u) annotation (Line(
            points={{30,-61},{30,-80},{-48,-80}}, color={0,0,127}));
        connect(voltageController.y, excitationVoltage.v) annotation (Line(
            points={{-49,-30},{-42,-30}}, color={0,0,127}));
        connect(idealDiode1.plug_p, idealDiode2.plug_n) annotation (Line(
            points={{0,70},{0,50}}, color={0,0,255}));
        connect(idealDiode2.plug_p, star2.plug_p) annotation (Line(
            points={{0,30},{-10,30}}, color={0,0,255}));
        connect(idealDiode1.plug_n, star1.plug_p) annotation (Line(
            points={{0,90},{-10,90}}, color={0,0,255}));
        connect(capacitor2.n, star2.pin_n) annotation (Line(
            points={{-40,30},{-30,30}}, color={0,0,255}));
        connect(capacitor1.p, star1.pin_n) annotation (Line(
            points={{-40,90},{-30,90}}, color={0,0,255}));
        connect(capacitor1.n, capacitor2.p) annotation (Line(
            points={{-40,70},{-40,50}}, color={0,0,255}));
        connect(capacitor1.n, ground.p) annotation (Line(
            points={{-40,70},{-40,60},{-30,60}}, color={0,0,255}));
        connect(filter.y, voltageController.u_m) annotation (Line(
            points={{-60,-11},{-60,-18}}, color={0,0,127}));
        connect(voltageSensor.v, filter.u) annotation (Line(
            points={{-69,60},{-60,60},{-60,12}}, color={0,0,127}));
        connect(terminalBox.plugSupply, idealDiode2.plug_n) annotation (Line(
            points={{10,-18},{10,60},{0,60},{0,50}}, color={0,0,255}));
        connect(resistor.p, capacitor1.p) annotation (Line(
            points={{-50,70},{-50,90},{-40,90}}, color={0,0,255}));
        connect(resistor.n, capacitor2.n) annotation (Line(
            points={{-50,50},{-50,30},{-40,30}}, color={0,0,255}));
        connect(voltageSensor.n, capacitor2.n) annotation (Line(
            points={{-80,50},{-80,30},{-40,30}}, color={0,0,255}));
        connect(voltageSensor.p, capacitor1.p) annotation (Line(
            points={{-80,70},{-80,90},{-40,90}}, color={0,0,255}));
        annotation (experiment(StopTime=1.1, Interval=1E-4, Tolerance=1e-06), Documentation(
              info="<html>
<p>An electrically excited synchronous generator is driven with constant speed.
Voltage is controlled, the set point depends on speed. The generator is loaded with a rectifier.</p>

<p>Default machine parameters are used</p>

</html>"));
      end SMEE_Rectifier;

      model SMR_Inverter
        "Starting of synchronous reluctance machine with inverter"
        extends Modelica.Icons.Example;
        constant Integer m=3 "Number of stator phases";
        parameter Modelica.SIunits.Voltage VsNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fsNominal=smrData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.Frequency fKnee=50
          "Knee frequency of V/f curve";
        parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
        parameter Modelica.SIunits.Torque T_Load=46 "Nominal load torque";
        parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
        parameter Modelica.SIunits.Inertia J_Load=0.29 "Load inertia";
        Modelica.SIunits.Angle thetaM=rotorAngleM.rotorDisplacementAngle "Rotor displacement angle, FundamentalWave machine";
        Modelica.SIunits.Angle thetaE=rotorAngleE.rotorDisplacementAngle "Rotor displacement angle, Electrical machine";

        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage(
            final m=m) annotation (Placement(transformation(
              origin={0,60},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Blocks.Sources.Ramp ramp(height=fKnee, duration=tRamp)
          annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
        Modelica.Electrical.Machines.Utilities.VfController vfController(
          final m=m,
          VNominal=VsNominal,
          fNominal=fsNominal) annotation (Placement(transformation(extent={{-40,
                  50},{-20,70}})));
        Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor currentRMSsensorM
          annotation (Placement(transformation(
              origin={0,20},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
          currentRMSsensorE annotation (Placement(transformation(
              origin={-60,20},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
            terminalConnection="Y") annotation (Placement(transformation(extent={{-10,-14},
                  {10,6}})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxE(
            terminalConnection="Y") annotation (Placement(transformation(extent={{-10,-74},
                  {10,-54}})));
        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor
          smrM(
          Jr=smrData.Jr,
          Js=smrData.Js,
          p=smrData.p,
          fsNominal=smrData.fsNominal,
          Rs=smrData.Rs,
          TsRef=smrData.TsRef,
          alpha20s(displayUnit="1/K") = smrData.alpha20s,
          Lssigma=smrData.Lssigma,
          Lszero=smrData.Lszero,
          frictionParameters=smrData.frictionParameters,
          statorCoreParameters=smrData.statorCoreParameters,
          strayLoadParameters=smrData.strayLoadParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          Lmd=smrData.Lmd,
          Lmq=smrData.Lmq,
          useDamperCage=smrData.useDamperCage,
          Lrsigmad=smrData.Lrsigmad,
          Lrsigmaq=smrData.Lrsigmaq,
          Rrd=smrData.Rrd,
          Rrq=smrData.Rrq,
          TrRef=smrData.TrRef,
          alpha20r(displayUnit="1/K") = smrData.alpha20r,
          ir(each fixed=true),
          TsOperational=293.15,
          effectiveStatorTurns=smrData.effectiveStatorTurns,
          TrOperational=293.15)
                               annotation (Placement(transformation(extent={{-10,-30},
                  {10,-10}})));
        Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor
          smrE(
          p=smrData.p,
          fsNominal=smrData.fsNominal,
          Rs=smrData.Rs,
          TsRef=smrData.TsRef,
          alpha20s(displayUnit="1/K") = smrData.alpha20s,
          Lszero=smrData.Lszero,
          Lssigma=smrData.Lssigma,
          Jr=smrData.Jr,
          Js=smrData.Js,
          frictionParameters=smrData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=smrData.statorCoreParameters,
          strayLoadParameters=smrData.strayLoadParameters,
          Lmd=smrData.Lmd,
          Lmq=smrData.Lmq,
          useDamperCage=smrData.useDamperCage,
          Lrsigmad=smrData.Lrsigmad,
          Lrsigmaq=smrData.Lrsigmaq,
          Rrd=smrData.Rrd,
          Rrq=smrData.Rrq,
          TrRef=smrData.TrRef,
          alpha20r(displayUnit="1/K") = smrData.alpha20r,
          TsOperational=293.15,
          ir(each fixed=true),
          TrOperational=293.15) annotation (Placement(transformation(extent={{-10,
                  -90},{10,-70}})));
        Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleM(
            p=smrM.p) annotation (Placement(transformation(
              origin={30,-20},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngleE(
            p=smrE.p) annotation (Placement(transformation(
              origin={30,-80},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=J_Load)
          annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertiaE(J=J_Load)
          annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepM(
          startTime=tStep,
          stepTorque=-T_Load,
          useSupport=false,
          offsetTorque=0) annotation (Placement(transformation(extent={{100,-30},
                  {80,-10}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepE(
          startTime=tStep,
          stepTorque=-T_Load,
          useSupport=false,
          offsetTorque=0) annotation (Placement(transformation(extent={{100,-90},
                  {80,-70}})));
        parameter
          Electrical.Machines.Utilities.ParameterRecords.SM_ReluctanceRotorData
          smrData
          annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
      initial equation
        smrE.is[1:2] = zeros(2);
        smrM.is[1:2] = zeros(2);
        //conditional damper cage currents are defined as fixed start values
      equation
        connect(signalVoltage.plug_n, star.plug_p)
          annotation (Line(points={{0,70},{0,90},{-50,90}}, color={0,0,255}));
        connect(star.pin_n, ground.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(smrE.flange, loadInertiaE.flange_a)
          annotation (Line(points={{10,-80},{50,-80}}));
        connect(ramp.y, vfController.u)
          annotation (Line(points={{-59,60},{-42,60}}, color={0,0,255}));
        connect(vfController.y, signalVoltage.v)
          annotation (Line(points={{-19,60},{-12,60}},color={0,0,255}));
        connect(loadInertiaE.flange_b, torqueStepE.flange)
          annotation (Line(points={{70,-80},{80,-80}}));
        connect(smrE.plug_sn, rotorAngleE.plug_n) annotation (Line(points={{-6,
                -70},{-6,-60},{36,-60},{36,-70}}, color={0,0,255}));
        connect(smrE.plug_sp, rotorAngleE.plug_p)
          annotation (Line(points={{6,-70},{24,-70}}, color={0,0,255}));
        connect(smrE.flange, rotorAngleE.flange)
          annotation (Line(points={{10,-80},{20,-80}}));
        connect(terminalBoxE.plug_sp, smrE.plug_sp)
          annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
        connect(terminalBoxE.plug_sn, smrE.plug_sn)
          annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
        connect(terminalBoxE.plugSupply, currentRMSsensorE.plug_n) annotation (
            Line(points={{0,-68},{0,-50},{-60,-50},{-60,10}}, color={0,0,255}));
        connect(smrM.flange, loadInertiaM.flange_a) annotation (Line(points={{
                10,-20},{10,-20},{50,-20}}));
        connect(loadInertiaM.flange_b, torqueStepM.flange)
          annotation (Line(points={{70,-20},{80,-20}}));
        connect(smrM.plug_sn, rotorAngleM.plug_n) annotation (Line(points={{-6,
                -10},{-6,0},{36,0},{36,-10}}, color={0,0,255}));
        connect(smrM.plug_sp, rotorAngleM.plug_p) annotation (Line(points={{6,-10},
                {6,-10},{24,-10}}, color={0,0,255}));
        connect(smrM.flange, rotorAngleM.flange) annotation (Line(points={{10,-20},
                {10,-20},{20,-20}}));
        connect(terminalBoxM.plug_sp, smrM.plug_sp)
          annotation (Line(points={{6,-10},{6,-10}}, color={0,0,255}));
        connect(terminalBoxM.plug_sn, smrM.plug_sn)
          annotation (Line(points={{-6,-10},{-6,-10}}, color={0,0,255}));
        connect(currentRMSsensorM.plug_n, terminalBoxM.plugSupply) annotation (
            Line(points={{0,10},{0,-8}},                             color={0,0,
                255}));
        connect(signalVoltage.plug_p, currentRMSsensorM.plug_p) annotation (
            Line(points={{0,50},{0,45},{0,40},
                {0,30}}, color={0,0,255}));
        connect(signalVoltage.plug_p, currentRMSsensorE.plug_p) annotation (
            Line(points={{0,50},{0,50},{0,30},{-60,30}}, color={0,0,255}));
        annotation (experiment(
            StopTime=1.5,
            Interval=1E-4,
            Tolerance=1e-06), Documentation(info="<html>
<h4>Synchronous induction machine with reluctance rotor fed by an ideal inverter</h4>
<p>
An ideal frequency inverter is modeled by using a
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.VfController\">VfController</a>
and a three-phase <a href=\"modelica://Modelica.Electrical.MultiPhase.Sources.SignalVoltage\">SignalVoltage</a>.
Frequency is raised by a ramp, causing the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor\">reluctance machine</a> to start,
and accelerating inertias. At time <code>tStep</code> a load step is applied.
</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>currentRMSsensorM|E.I</code>: equivalent RMS stator current</li>
<li><code>smrM|E.wMechanical</code>: machine speed</li>
<li><code>smrM|E.tauElectrical</code>: machine torque</li>
<li><code>rotorAngleM|R.rotorDisplacementAngle</code>: rotor displacement angle</li>
</ul>
</html>"));
      end SMR_Inverter;

      model SMR_Inverter_MultiPhase
        "Starting of multi phase synchronous reluctance machine with inverter"

        extends Modelica.Icons.Example;
        constant Integer m3=3 "Number of stator phases of threephase system";
        parameter Integer m=5 "Number of stator phases";
        parameter Modelica.SIunits.Voltage VsNominal=100
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fsNominal=smrData.fsNominal "Nominal frequency";
        parameter Modelica.SIunits.Frequency fKnee=50
          "Knee frequency of V/f curve";
        parameter Modelica.SIunits.Time tRamp=1 "Frequency ramp";
        parameter Modelica.SIunits.Torque T_Load=46 "Nominal load torque";
        parameter Modelica.SIunits.Time tStep=1.2 "Time of load torque step";
        parameter Modelica.SIunits.Inertia J_Load=0.29 "Load inertia";
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBoxM(
            terminalConnection="Y", m=m) annotation (Placement(transformation(
                extent={{-10,-14},{10,6}})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox3(
            terminalConnection="Y", m=m3) annotation (Placement(transformation(
                extent={{-10,-74},{10,-54}})));
        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor
          smrM(
          Jr=smrData.Jr,
          Js=smrData.Js,
          p=smrData.p,
          fsNominal=smrData.fsNominal,
          TsRef=smrData.TsRef,
          alpha20s(displayUnit="1/K") = smrData.alpha20s,
          frictionParameters=smrData.frictionParameters,
          statorCoreParameters=smrData.statorCoreParameters,
          strayLoadParameters=smrData.strayLoadParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          useDamperCage=smrData.useDamperCage,
          Lrsigmad=smrData.Lrsigmad,
          Lrsigmaq=smrData.Lrsigmaq,
          Rrd=smrData.Rrd,
          Rrq=smrData.Rrq,
          TrRef=smrData.TrRef,
          alpha20r(displayUnit="1/K") = smrData.alpha20r,
          Rs=smrData.Rs*m/3,
          Lssigma=smrData.Lssigma*m/3,
          Lszero=smrData.Lszero*m/3,
          Lmd=smrData.Lmd*m/3,
          Lmq=smrData.Lmq*m/3,
          m=m,
          ir(each fixed=true),
          TsOperational=293.15,
          effectiveStatorTurns=smrData.effectiveStatorTurns,
          TrOperational=293.15)
                               annotation (Placement(transformation(extent={{-10,-30},
                  {10,-10}})));
        Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor
          smr3(
          p=smrData.p,
          fsNominal=smrData.fsNominal,
          Rs=smrData.Rs,
          TsRef=smrData.TsRef,
          alpha20s(displayUnit="1/K") = smrData.alpha20s,
          Lszero=smrData.Lszero,
          Lssigma=smrData.Lssigma,
          Jr=smrData.Jr,
          Js=smrData.Js,
          frictionParameters=smrData.frictionParameters,
          phiMechanical(fixed=true),
          wMechanical(fixed=true),
          statorCoreParameters=smrData.statorCoreParameters,
          strayLoadParameters=smrData.strayLoadParameters,
          Lmd=smrData.Lmd,
          Lmq=smrData.Lmq,
          useDamperCage=smrData.useDamperCage,
          Lrsigmad=smrData.Lrsigmad,
          Lrsigmaq=smrData.Lrsigmaq,
          Rrd=smrData.Rrd,
          Rrq=smrData.Rrq,
          TrRef=smrData.TrRef,
          alpha20r(displayUnit="1/K") = smrData.alpha20r,
          m=m3,
          ir(each fixed=true),
          TsOperational=293.15,
          effectiveStatorTurns=smrData.effectiveStatorTurns,
          TrOperational=293.15)
                               annotation (Placement(transformation(extent={{-10,-90},
                  {10,-70}})));
        Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle rotorAngle3(
           p=smr3.p) annotation (Placement(transformation(
              origin={30,-80},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertiaM(J=J_Load)
          annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
        Modelica.Mechanics.Rotational.Components.Inertia loadInertia3(J=J_Load)
          annotation (Placement(transformation(extent={{50,-90},{70,-70}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStepM(
          startTime=tStep,
          stepTorque=-T_Load,
          useSupport=false,
          offsetTorque=0) annotation (Placement(transformation(extent={{100,-30},
                  {80,-10}})));
        Modelica.Mechanics.Rotational.Sources.TorqueStep torqueStep3(
          startTime=tStep,
          stepTorque=-T_Load,
          useSupport=false,
          offsetTorque=0) annotation (Placement(transformation(extent={{100,-90},
                  {80,-70}})));
        parameter
          Electrical.Machines.Utilities.ParameterRecords.SM_ReluctanceRotorData
          smrData annotation (Placement(transformation(extent={{-100,-100},{-80,
                  -80}})));
        Modelica.Electrical.Analog.Basic.Ground ground3 annotation (Placement(
              transformation(
              origin={-90,90},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star star3(final m=m3) annotation (
           Placement(transformation(extent={{-50,80},{-70,100}})));
        Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltage3(
            final m=m3) annotation (Placement(transformation(
              origin={0,70},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Blocks.Sources.Ramp ramp(height=fKnee, duration=tRamp)
          annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
        Modelica.Electrical.Machines.Utilities.VfController vfController3(
          VNominal=VsNominal,
          fNominal=fsNominal,
          BasePhase=+Modelica.Constants.pi/2,
          final m=m3,
          orientation=-
              Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m3))
          annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
        Modelica.Electrical.MultiPhase.Sensors.CurrentQuasiRMSSensor
          currentRMSsensorM(m=m) annotation (Placement(transformation(
              origin={30,20},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.Machines.Sensors.CurrentQuasiRMSSensor
          currentRMSsensor3 annotation (Placement(transformation(
              origin={-80,0},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Sources.SignalVoltage signalVoltageM(
            final m=m) annotation (Placement(transformation(
              origin={30,50},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Star starM(final m=m) annotation (
            Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={60,90})));
        Modelica.Electrical.Analog.Basic.Ground groundM annotation (Placement(
              transformation(
              origin={90,90},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.Machines.Utilities.VfController vfControllerM(
          VNominal=VsNominal,
          fNominal=fsNominal,
          BasePhase=+Modelica.Constants.pi/2,
          final m=m,
          orientation=-
              Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m))
          annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-30,50})));
        Modelica.Blocks.Math.Feedback feedback annotation (Placement(
              transformation(
              extent={{-10,10},{10,-10}},
              origin={-50,0})));
        Modelica.Blocks.Math.Gain gain(k=(m/m3))
          annotation (Placement(transformation(extent={{-20,10},{-40,30}})));
      initial equation
        smr3.is[1:2] = zeros(2);
        smrM.is[1:2] = zeros(2);
        //conditional damper cage currents are defined as fixed start values
      equation
        connect(smr3.flange, loadInertia3.flange_a)
          annotation (Line(points={{10,-80},{50,-80}}));
        connect(loadInertia3.flange_b, torqueStep3.flange)
          annotation (Line(points={{70,-80},{80,-80}}));
        connect(smr3.plug_sn, rotorAngle3.plug_n) annotation (Line(points={{-6,
                -70},{-6,-60},{36,-60},{36,-70}}, color={0,0,255}));
        connect(smr3.plug_sp, rotorAngle3.plug_p)
          annotation (Line(points={{6,-70},{24,-70}}, color={0,0,255}));
        connect(smr3.flange, rotorAngle3.flange)
          annotation (Line(points={{10,-80},{20,-80}}));
        connect(terminalBox3.plug_sp, smr3.plug_sp)
          annotation (Line(points={{6,-70},{6,-70}}, color={0,0,255}));
        connect(terminalBox3.plug_sn, smr3.plug_sn)
          annotation (Line(points={{-6,-70},{-6,-70}}, color={0,0,255}));
        connect(smrM.flange, loadInertiaM.flange_a) annotation (Line(points={{
                10,-20},{10,-20},{50,-20}}));
        connect(loadInertiaM.flange_b, torqueStepM.flange)
          annotation (Line(points={{70,-20},{80,-20}}));
        connect(terminalBoxM.plug_sp, smrM.plug_sp)
          annotation (Line(points={{6,-10},{6,-10}}, color={0,0,255}));
        connect(terminalBoxM.plug_sn, smrM.plug_sn)
          annotation (Line(points={{-6,-10},{-6,-10}}, color={0,0,255}));
        connect(signalVoltage3.plug_n, star3.plug_p)
          annotation (Line(points={{0,80},{0,90},{-50,90}}, color={0,0,255}));
        connect(star3.pin_n, ground3.p)
          annotation (Line(points={{-70,90},{-80,90}}, color={0,0,255}));
        connect(ramp.y, vfController3.u)
          annotation (Line(points={{-59,70},{-42,70}}, color={0,0,255}));
        connect(vfController3.y, signalVoltage3.v)
          annotation (Line(points={{-19,70},{-12,70}},color={0,0,255}));
        connect(terminalBoxM.plugSupply, currentRMSsensorM.plug_n) annotation (
            Line(points={{0,-8},{0,-8},{0,10},{30,10}},        color={0,0,255}));
        connect(signalVoltage3.plug_p, currentRMSsensor3.plug_p) annotation (
            Line(
            points={{0,60},{0,34},{-80,34},{-80,10}},
            color={0,0,255}));
        connect(signalVoltageM.plug_n, starM.plug_p) annotation (Line(
            points={{30,60},{30,90},{50,90}},
            color={0,0,255}));
        connect(starM.pin_n, groundM.p) annotation (Line(
            points={{70,90},{80,90}},
            color={0,0,255}));
        connect(vfControllerM.y, signalVoltageM.v) annotation (Line(
            points={{-19,50},{18,50}},
            color={0,0,127}));
        connect(vfControllerM.u, ramp.y) annotation (Line(
            points={{-42,50},{-50,50},{-50,70},{-59,70}},
            color={0,0,127}));
        connect(signalVoltageM.plug_p, currentRMSsensorM.plug_p) annotation (
            Line(
            points={{30,40},{30,30}},
            color={0,0,255}));
        connect(gain.y, feedback.u2) annotation (Line(
            points={{-41,20},{-50,20},{-50,8}},
            color={0,0,127}));
        connect(gain.u, currentRMSsensorM.I) annotation (Line(
            points={{-18,20},{19,20}},
            color={0,0,127}));
        connect(currentRMSsensor3.plug_n, terminalBox3.plugSupply) annotation (
            Line(points={{-80,-10},{-80,-60},{0,-60},{0,-68}}, color={0,0,255}));
        connect(currentRMSsensor3.I, feedback.u1) annotation (Line(
            points={{-69,0},{-58,0}},
            color={0,0,127}));
        annotation (
          experiment(
            StopTime=1.5,
            Interval=1E-4,
            Tolerance=1e-06),
          Documentation(info="<html>
<h4>Synchronous induction machine with reluctance rotor fed by an ideal inverter</h4>
<p>
Ideal frequency inverters are modeled by using a
<a href=\"modelica://Modelica.Electrical.Machines.Utilities.VfController\">VfController</a>
and phase <a href=\"modelica://Modelica.Electrical.MultiPhase.Sources.SignalVoltage\">SignalVoltage</a>s.
Frequency is raised by a ramp, causing the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor\">reluctance machine</a> to start,
and accelerating inertias. At time <code>tStep</code> a load step is applied. Two equivalent machines with different numbers of phases are compared and their equal behavior is demonstrated.
</p>

<p>
Simulate for 1.5 seconds and plot (versus time):
</p>

<ul>
<li><code>aimcM|M3.tauElectrical</code>: machine torque</li>
<li><code>aimsM|M3.wMechanical</code>: machine speed</li>
<li><code>feedback.y</code>: zero since difference of three phase current phasor and scaled multi phase current phasor are equal</li>
</ul>

</html>"),Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={Rectangle(
                      extent={{-20,0},{100,-40}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      pattern=LinePattern.Dash),Text(
                      extent={{40,-44},{100,-52}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      textStyle={TextStyle.Bold},
                      textString="%m phase machine
"),           Text(
                extent={{40,-54},{100,-62}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      textStyle={TextStyle.Bold},
                      textString="3 phase machine
"),           Rectangle(
                extent={{-20,-60},{100,-100}},
                      fillColor={255,255,170},
                      fillPattern=FillPattern.Solid,
                      pattern=LinePattern.Dash)}));
      end SMR_Inverter_MultiPhase;

    end BasicMachines;
    annotation (Documentation(info="<html>
<p>Examples comparing the models of
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines\">Electrical.Machines.BasicMachines</a> with
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines\">Magnetic.FundamentalWave.BasicMachines</a>.
</p>
</html>"));
  end Examples;

  package Components "Basic fundamental wave components"
    extends Modelica.Icons.Package;
    model Ground "Magnetic ground"
      Interfaces.PositiveMagneticPort port_p "Complex magnetic port"
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
    equation
      port_p.V_m = Complex(0, 0);
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{0,100},{0,50}}, color={255,128,0}),
              Line(points={{-60,50},{60,50}}, color={255,128,0}),Line(
              points={{-40,30},{40,30}}, color={255,128,0}),Line(points={{-20,
              10},{20,10}}, color={255,128,0})}),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={
            Line(points={{0,100},{0,50}}, color={255,128,0}),
            Line(points={{-60,50},{60,50}}, color={255,128,0}),
            Line(points={{-40,30},{40,30}}, color={255,128,0}),
            Line(points={{-20,10},{20,10}}, color={255,128,0}),
            Text(
              extent={{-150,-10},{150,-50}},
              textString="%name",
              lineColor={0,0,255})}),
        Documentation(info="<html>

<p>
Grounding of the complex magnetic potential. Each magnetic circuit has to be grounded at least one point of the circuit.
</p>

</html>"));
    end Ground;

    model Reluctance "Salient reluctance"
      import Modelica.Constants.pi;
      extends
        Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortElementary;
      parameter Modelica.Magnetic.FundamentalWave.Types.SalientReluctance R_m(d(
            start=1), q(start=1)) "Magnetic reluctance in d=re and q=im axis";
    equation
      (pi/2)*V_m.re = R_m.d*Phi.re;
      (pi/2)*V_m.im = R_m.q*Phi.im;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={255,128,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-96,0},{-70,0}},
              color={255,128,0}),Line(points={{70,0},{96,0}}, color={255,128,0}),
              Text(
                  extent={{-150,50},{150,90}},
                  lineColor={0,0,255},
                  textString="%name")}), Documentation(info="<html>
<p>
The salient reluctance models the relationship between the complex magnetic potential difference
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m.png\" alt=\"V_m.png\"> and the complex magnetic flux <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Phi.png\">,
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/reluctance.png\"
      alt=\"reluctance.png\">
</blockquote>

<p>which can also be expressed in terms complex phasors:</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/reluctance_alt.png\"
     alt=\"reluctance_alt.png\">
</blockquote>

</html>"));
    end Reluctance;

    model Permeance "Salient Permeance"
      import Modelica.Constants.pi;
      extends
        Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortElementary;
      parameter Modelica.Magnetic.FundamentalWave.Types.SalientPermeance G_m(d(
            start=1), q(start=1)) "Magnetic permeance in d=re and q=im axis";
    equation
      (pi/2)*G_m.d*V_m.re = Phi.re;
      (pi/2)*G_m.q*V_m.im = Phi.im;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={255,128,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{-96,0},{-70,0}},
              color={255,128,0}),Line(points={{70,0},{96,0}}, color={255,128,0}),
              Text(
                  extent={{-150,50},{150,90}},
                  lineColor={0,0,255},
                  textString="%name")}), Documentation(info="<html>
<p>
The salient permeance models the relationship between the complex magnetic potential difference
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m.png\" alt=\"V_m.png\"> and the complex magnetic flux <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Phi.png\">:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/permeance.png\" alt=\"permeance.png\">
</blockquote>
</html>"));
    end Permeance;

    model EddyCurrent
      "Constant loss model under sinusoidal magnetic conditions"
      import Modelica.Constants.pi;
      extends
        Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortElementary;
      parameter Modelica.SIunits.Conductance G(min=0)
        "Equivalent symmetric loss conductance";
      extends
        Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
          final T=273.15);
    equation
      lossPower = (pi/2)*(V_m.re*der(Phi.re) + V_m.im*der(Phi.im));
      if G > 0 then
        (pi/2)*V_m.re = G*der(Phi.re);
        (pi/2)*V_m.im = G*der(Phi.im);
      else
        V_m.re = 0;
        V_m.im = 0;
      end if;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
                  extent={{-70,30},{70,-30}},
                  lineColor={255,128,0},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.Solid),Line(points={{-96,0},{-70,0}},
              color={255,128,0}),Line(points={{70,0},{96,0}}, color={255,128,0}),
                                      Text(
                  extent={{0,-40},{0,-80}},
                  textString="G=%G"),
              Text(
                  extent={{-150,50},{150,90}},
                  lineColor={0,0,255},
                  textString="%name")}),Documentation(info="<html>
<p>
The eddy current loss model with respect to fundamental wave effects is designed in accordance to
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.EddyCurrent\">FluxTubes.Basic.EddyCurrent</a>.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/eddycurrent.png\"
     alt=\"eddycurrent.png\">
</blockquote>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Fig. 1: equivalent models of eddy current losses</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/eddycurrent_electric.png\"
           alt=\"eddycurrent_electric.png\">
    </td>
  </tr>
</table>

<p>Due to the nature of eddy current losses, which can be represented by symmetric
conductors in an equivalent electric circuit (Fig. 1), the respective
number of phases <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\" alt=\"m\"> has to be taken into account.
Assume that the <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\" alt=\"m\"> conductances
of the equivalent circuit are <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/Gc.png\" alt=\"G_c\">,
the conductance for the eddy current loss model is determined by</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/GGc.png\"
     alt=\"GGc\">
</blockquote>

<p>
where <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/N.png\" alt=\"N\"> is the number of turns of the symmetric electro magnetic coupling.
</p>

<p>For such an <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\" alt=\"m\"> phase system
the relationship between the voltage and current <a href=\"https://www.haumer.at/refimg/SpacePhasors.pdf\">space phasors</a>
and the magnetic flux and magnetic potential difference phasor is
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/vPhi.png\" alt=\"vPhi\">,<br>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/iV_m.png\" alt=\"iV_m\">,
</blockquote>

<p>
where <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/v_k.png\" alt=\"v_k\">
and <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i_k.png\" alt=\"i_k\">
are the phase voltages and currents, respectively.
</p>

<p>
The dissipated loss power
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/lossPower.png\" alt=\"lossPower\">
</blockquote>
<p>
can be determined for the <a href=\"https://www.haumer.at/refimg/SpacePhasors.pdf\">space phasor</a>
relationship of the voltage and current space phasor.
</p>
<h4>See also</h4>

<p><a href=\"modelica://Modelica.Magnetic.FluxTubes.Basic.EddyCurrent\">FluxTubes.Basic.EddyCurrent</a></p>

</html>"));
    end EddyCurrent;

    model SinglePhaseElectroMagneticConverter
      "Single phase electro magnetic converter"
      import Modelica.Constants.pi;
      Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "Positive pin"
        annotation (Placement(transformation(
            origin={-100,100},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative pin"
        annotation (Placement(transformation(
            origin={-100,-100},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Interfaces.PositiveMagneticPort port_p "Positive complex magnetic port"
        annotation (Placement(transformation(extent={{90,90},{110,110}})));
      Interfaces.NegativeMagneticPort port_n "Negative complex magnetic port"
        annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
      parameter Real effectiveTurns "Effective number of turns"
        annotation (Evaluate=true);
      parameter Modelica.SIunits.Angle orientation
        "Orientation of the resulting fundamental wave V_m phasor"
        annotation (Evaluate=true);
      // Local electric single phase quantities
      Modelica.SIunits.Voltage v "Voltage";
      Modelica.SIunits.Current i "Current";

      // Local electromagnetic fundamental wave quantities
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m
        "Complex magnetic potential difference";
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";

      Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";
      Modelica.SIunits.MagneticPotentialDifference abs_Phi=
          Modelica.ComplexMath.'abs'(Phi) "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";

      final parameter Complex N=effectiveTurns*Modelica.ComplexMath.exp(Complex(
          0, orientation)) "Complex number of turns";
    equation
      // Magnetic flux and flux balance of the magnetic ports
      port_p.Phi = Phi;
      port_p.Phi + port_n.Phi = Complex(0, 0);
      // Magnetic potential difference of the magnetic ports
      port_p.V_m - port_n.V_m = V_m;
      // Voltage drop between the electrical pins
      v = pin_p.v - pin_n.v;
      // Current and current balance of the electric pins
      i = pin_p.i;
      pin_p.i + pin_n.i = 0;
      // Complex magnetic potential difference is determined from currents, number
      // of turns and angles of orientation of winding
      // V_m.re = (2/pi) * effectiveTurns*cos(orientation)*i;
      // V_m.im = (2/pi) * effectiveTurns*sin(orientation)*i;
      V_m = (2.0/pi)*N*i;
      // Induced voltages is determined from complex magnetic flux, number of turns
      // and angles of orientation of winding
      // -v = effectiveTurns*cos(orientation)*der(Phi.re)
      //    + effectiveTurns*sin(orientation)*der(Phi.im);
      -v = Modelica.ComplexMath.real(Modelica.ComplexMath.conj(N)*Complex(der(
        Phi.re), der(Phi.im)));
      annotation (
        defaultComponentName="converter",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={           Line(points={{100,-100},{94,-100},
              {84,-98},{76,-94},{64,-86},{50,-72},{42,-58},{36,-40},{30,-18},{
              30,0},{30,18},{34,36},{46,66},{62,84},{78,96},{90,100},{100,100}},
              color={255,128,0}),Line(points={{-20,60},{-20,100},{-100,100}},
              color={0,0,255}),Line(points={{-20,-60},{-20,-100},{-100,-100}},
              color={0,0,255}),
            Line(
              points={{-15,-7},{-9,43},{5,73},{25,73},{41,43},{45,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-13,45},
              rotation=270),
            Line(
              points={{-15,-7},{-9,43},{5,73},{25,73},{41,43},{45,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-13,-15},
              rotation=270),
              Text(
                  extent={{-150,120},{150,160}},
                  lineColor={0,0,255},
                  textString="%name")}),
        Documentation(info="<html>
<p>
The single phase winding has an effective number of turns, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns.png\"> and a respective orientation of the winding, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/orientation.png\">. The current in winding is <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i.png\">.
</p>

<p>
The total complex magnetic potential difference of the single phase winding is determined by:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/singlephaseconverter_vm.png\">
</p>

<p>
In this equation the magnetomotive force is aligned with the orientation of the winding.
</p>

<p>
The voltage <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/v.png\"> induced in the winding depends on the cosine between the orientation of the winding and the angle of the complex magnetic flux. Additionally, the magnitudes of the induced voltages are proportional to the respective number of turns. This relationship can be modeled by means of</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/singlephaseconverter_phi.png\">
</p>

<p>The single phase electromagnetic converter is a special case of the
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter\">MultiPhaseElectroMagneticConverter</a>
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter\">MultiPhaseElectroMagneticConverter</a>
</p>

</html>"));
    end SinglePhaseElectroMagneticConverter;

    model MultiPhaseElectroMagneticConverter
      "Multi phase electro magnetic converter"

      import Modelica.Constants.pi;

      // Global plug and port variables
      Modelica.SIunits.Voltage v[m]=plug_p.pin.v - plug_n.pin.v "Voltage";
      Modelica.SIunits.Current i[m]=plug_p.pin.i "Current";
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m=port_p.V_m -
          port_n.V_m "Magnetic potential difference";
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";

      Modelica.SIunits.ComplexMagneticFlux Phi=port_p.Phi "Magnetic flux";
      Modelica.SIunits.MagneticPotentialDifference abs_Phi=
          Modelica.ComplexMath.'abs'(Phi) "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";

      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
        "Positive plug" annotation (Placement(transformation(
            origin={-100,100},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
        "Negative plug" annotation (Placement(transformation(
            origin={-100,-100},
            extent={{-10,-10},{10,10}},
            rotation=180)));
      Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort port_p
        "Positive complex magnetic port" annotation (Placement(transformation(
              extent={{90,90},{110,110}})));
      Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort port_n
        "Negative complex magnetic port" annotation (Placement(transformation(
              extent={{90,-110},{110,-90}})));
      parameter Integer m=3 "Number of phases";
      parameter Real effectiveTurns[m] "Effective number of turns";
      parameter Modelica.SIunits.Angle orientation[m]
        "Orientation of the resulting fundamental wave field phasor";
      Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter
        singlePhaseElectroMagneticConverter[m](final effectiveTurns=
            effectiveTurns, final orientation=orientation)
        annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
    equation
      connect(plug_p.pin, singlePhaseElectroMagneticConverter.pin_p)
        annotation (Line(
          points={{-100,100},{-8,100},{-8,10}}, color={0,0,255}));
      connect(singlePhaseElectroMagneticConverter.pin_n, plug_n.pin)
        annotation (Line(
          points={{-8,-10},{-8,-100},{-100,-100}}, color={0,0,255}));
      connect(singlePhaseElectroMagneticConverter[1].port_p, port_p)
        annotation (Line(
          points={{12,10},{12,100},{100,100}}, color={255,128,0}));
      for k in 2:m loop
        connect(singlePhaseElectroMagneticConverter[k - 1].port_n,
          singlePhaseElectroMagneticConverter[k].port_p);
      end for;
      connect(singlePhaseElectroMagneticConverter[m].port_n, port_n)
        annotation (Line(
          points={{12,-10},{12,-100},{100,-100}}, color={255,128,0}));
      annotation (defaultComponentName="converter",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={           Line(points={{100,-100},{94,-100},{84,-98},{76,-94},{64,-86},{50,-72},{42,-58},{36,-40},{30,-18},{30,0},{30,18},{34,36},{46,66},{62,84},{78,96},{90,100},{100,100}},
              color={255,128,0}),Line(points={{-20,60},{-20,100},{-100,100}},
              color={0,0,255}),Line(points={{-20,-60},{-20,-100},{-100,-100}},
              color={0,0,255}),
            Line(
              points={{-15,-7},{-9,43},{5,73},{25,73},{41,43},{45,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-13,45},
              rotation=270),
            Line(
              points={{-15,-7},{-9,43},{5,73},{25,73},{41,43},{45,-7}},
              color={0,0,255},
              smooth=Smooth.Bezier,
              origin={-13,-15},
              rotation=270),
              Text(
                  extent={{-150,120},{150,160}},
                  lineColor={0,0,255},
                  textString="%name")}),
        Documentation(info="<html>
<p>
Each phase <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/k.png\"> of an <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\"> phase winding has an effective number of turns, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns_k.png\"> and an respective winging angle <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/orientation_k.png\"> and a phase current <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/i_k.png\">.
</p>

<p>
The total complex magnetic potential difference of the multi phase winding is determined by:
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/multiphaseconverter_vm.png\">
</p>

<p>
In this equation each contribution of a winding magnetomotive force on the total complex magnetic potential difference is aligned with the respective orientation of the winding.
</p>

<p>
The voltages <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/v_k.png\"> induced in each winding depend on the cosines between the orientation of the winding and the angle of the complex magnetic flux. Additionally, the magnitudes of the induced voltages are proportional to the respective number of turns. This relationship can be modeled by means of</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/multiphaseconverter_phi.png\">
</p>

<p>for <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/k_in_1_m.png\"> and is also illustrated by the following figure:</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig:</strong> Orientation of winding and location of complex magnetic flux</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Components/coupling.png\">
    </td>
  </tr>
</table>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">SinglePhaseElectroMagneticConverter</a>
</p>
</html>"));
    end MultiPhaseElectroMagneticConverter;

    model Idle "Idle running branch"
      extends
        Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortElementary;
    equation
      Phi = Complex(0, 0);
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={           Line(points={{-100,0},{-40,0}},
              color={255,128,0}),Line(points={{40,0},{100,0}}, color={255,128,0}),
              Text(
                  extent={{-150,20},{150,60}},
                  lineColor={0,0,255},
                  textString="%name")}),
        Documentation(info="<html>
<p>
This is a simple idle running branch.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Short</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Crossing\">Crossing</a>
</p>

</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Line(points={{-100,0},{-60,0}}, color={
              255,128,0}),Line(points={{60,0},{100,0}}, color={255,128,0}),Line(
              points={{-60,0},{-40,2},{-18,6},{0,14},{12,26}}, color={255,128,0}),
              Line(points={{60,0},{40,-2},{18,-6},{0,-14},{-12,-26}}, color={
              255,128,0})}));
    end Idle;

    model Short "Short cut branch"
      extends Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPort;
    equation
      connect(port_p, port_n) annotation (Line(points={{-100,0},{-1,0},{-1,0},{
              100,0}}, color={255,128,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={    Line(points={{-100,0},{100,0}},
              color={255,128,0}),
              Text(
                  extent={{-150,20},{150,60}},
                  lineColor={0,0,255},
                  textString="%name")}),
                                    Documentation(info="<html>
<p>
This is a simple short cut branch.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Idle\">Idle</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Crossing\">Crossing</a>
</p>

</html>"));
    end Short;

    model Crossing "Crossing of two branches"

      Interfaces.PositiveMagneticPort port_p1
        "Positive port_p1 connected with port_p2"
        annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
      Interfaces.PositiveMagneticPort port_p2
        "Positive port_p2 connected with port_p1"
        annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
      Interfaces.NegativeMagneticPort port_n1
        "Negative port_n1 connected with port_n2"
        annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
      Interfaces.NegativeMagneticPort port_n2
        "Negative port_n2 connected with port_n1"
        annotation (Placement(transformation(extent={{90,90},{110,110}})));

    equation
      connect(port_p1, port_p2) annotation (Line(
          points={{-100,100},{-100,20},{0,20},{0,-20},{100,-20},{100,-100}}, color={255,128,0}));
      connect(port_n1, port_n2) annotation (Line(
          points={{-100,-100},{-100,0},{100,0},{100,100}}, color={255,128,0}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Text(
                  extent={{-150,110},{150,150}},
                  lineColor={0,0,255},
                  textString="%name"),           Line(
                  points={{100,100},{40,100},{-40,-100},{-100,-100}},
                  color={255,128,0}),Line(
                  points={{-100,100},{-40,100},{40,-100},{100,-100}},
                  color={255,128,0})}),
        Documentation(info="<html>
<p>
This is a simple crossing of two branches. The ports <code>port_p1</code> and <code>port_p2</code> are connected, as well as <code>port_n1</code> and <code>port_n2</code>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Idle\">Idle</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Short\">Short</a>
</p>

</html>"));
    end Crossing;
    annotation (Documentation(info="<html>
<p>Basic components of the FundamentalWave library for modeling magnetic circuits. Machine specific components are
located at <a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components\">Machines.Components</a>.</p>
</html>"));
  end Components;

  package BasicMachines
    "Machine components and modelsElectric machine models based on FundamentalWave package"
    extends Modelica.Icons.Package;
    package AsynchronousInductionMachines "Asynchronous induction machines"
      extends Modelica.Icons.VariantsPackage;
      model AIM_SquirrelCage
        "Asynchronous induction machine with squirrel cage"
        extends
          Modelica.Magnetic.FundamentalWave.Interfaces.PartialBasicInductionMachine(
          is(start=zeros(m)),
          Rs(start=0.03),
          Lssigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal)),
          final L0(d=2.0*Lm/m/effectiveStatorTurns^2, q=2.0*Lm/m/
                effectiveStatorTurns^2),
          redeclare final
            Modelica.Electrical.Machines.Thermal.AsynchronousInductionMachines.ThermalAmbientAIMC
            thermalAmbient(final Tr=TrOperational),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortAIMC
            thermalPort,
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortAIMC
            internalThermalPort,
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceAIMC
            powerBalance(final lossPowerRotorWinding=sum(rotorCage.resistor.resistor.LossPower),
              final lossPowerRotorCore=0));
        parameter Modelica.SIunits.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi
              *fsNominal)) "Stator main field inductance" annotation (Dialog(
              tab="Nominal resistances and inductances", groupImage=
                "modelica://Modelica/Resources/Images/Electrical/Machines/IMC.png"));
        parameter Modelica.SIunits.Inductance Lrsigma(start=3*(1 - sqrt(1 -
              0.0667))/(2*pi*fsNominal))
          "Rotor leakage inductance of equivalent m phase winding w.r.t. stator side"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Resistance Rr(start=0.04)
          "Rotor resistance of equivalent m phase winding w.r.t. stator side"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of rotor resistance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20r(start=0)
          "Temperature coefficient of rotor resistance at 20 degC"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of rotor resistance" annotation (Dialog(
              group="Operational temperatures", enable=not useThermalPort));
        output Modelica.SIunits.Current ir[m]=rotorCage.i "Rotor cage currents";
        Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding
          rotorCage(
          final Lsigma=Lrsigma,
          final effectiveTurns=effectiveStatorTurns,
          final useHeatPort=true,
          final RRef=Rr,
          final TRef=TrRef,
          final TOperational=TrRef,
          final m=m,
          final alpha20=alpha20r)
          "Symmetric rotor cage winding including resistances and stray inductances"
          annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
      equation
        connect(rotorCage.heatPortWinding, internalThermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{0,-40},{-40,-40},{-40,-90}}, color={191,0,0}));
        connect(airGap.port_rn, rotorCage.port_p) annotation (Line(
            points={{-10,-10},{-10,-30}}, color={255,128,0}));
        connect(airGap.port_rp, rotorCage.port_n) annotation (Line(
            points={{10,-10},{10,-30}}, color={255,128,0}));
        annotation (
          defaultComponentName="aimc",
          Documentation(info="<html>
<p>
Resistances and stray inductances of the machine refer to an <code>m</code> phase stator. The symmetry of the stator and rotor is assumed. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>heat losses in the temperature dependent cage resistances</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SlipRing\">AIM_SlipRing</a>,
</p>
</html>"));
      end AIM_SquirrelCage;

      model AIM_SlipRing "Asynchronous induction machine with slip ring rotor"
        parameter Integer mr(min=3) = m "Number of rotor phases";
        extends
          Modelica.Magnetic.FundamentalWave.Interfaces.PartialBasicInductionMachine(
          is(start=zeros(m)),
          Rs(start=0.03),
          Lssigma(start=3*(1 - sqrt(1 - 0.0667))/(2*pi*fsNominal)),
          final L0(d=2.0*Lm/m/effectiveStatorTurns^2, q=2.0*Lm/m/
                effectiveStatorTurns^2),
          redeclare final
            Electrical.Machines.Thermal.AsynchronousInductionMachines.ThermalAmbientAIMS
            thermalAmbient(final Tr=TrOperational, final mr=mr),
          redeclare final
            Electrical.Machines.Interfaces.InductionMachines.ThermalPortAIMS
            thermalPort(final mr=mr),
          redeclare final
            Electrical.Machines.Interfaces.InductionMachines.ThermalPortAIMS
            internalThermalPort(final mr=mr),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceAIMS
            powerBalance(
            final lossPowerRotorWinding=sum(rotor.resistor.resistor.LossPower),
            final lossPowerRotorCore=rotor.core.lossPower,
            final lossPowerBrush=0,
            final powerRotor=
                Modelica.Electrical.MultiPhase.Functions.activePower(vr, ir)));

        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_rn(final m=
              mr) "Negative plug of rotor" annotation (Placement(transformation(
                extent={{-110,-50},{-90,-70}})));
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_rp(final m=
              mr) "Positive plug of rotor" annotation (Placement(transformation(
                extent={{-110,70},{-90,50}})));
        parameter Modelica.SIunits.Inductance Lm(start=3*sqrt(1 - 0.0667)/(2*pi
              *fsNominal)) "Stator main field inductance" annotation (Dialog(
              tab="Nominal resistances and inductances", groupImage=
                "modelica://Modelica/Resources/Images/Electrical/Machines/IMS.png"));
        parameter Modelica.SIunits.Inductance Lrsigma(start=3*(1 - sqrt(1 -
              0.0667))/(2*pi*fsNominal))
          "Rotor leakage inductance w.r.t. rotor side"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lrzero=Lrsigma
          "Rotor zero inductance w.r.t. rotor side"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Resistance Rr(start=0.04)
          "Rotor resistance per phase w.r.t. rotor side"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of rotor resistance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20r(start=0)
          "Temperature coefficient of rotor resistance at 20 degC"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of rotor resistance" annotation (Dialog(
              group="Operational temperatures", enable=not useThermalPort));
        parameter Boolean useTurnsRatio(start=true)
          "Use TurnsRatio or calculate from locked-rotor voltage?";
        parameter Real TurnsRatio(final min=Modelica.Constants.small, start=1)
          "Effective number of stator turns / effective number of rotor turns"
          annotation (Dialog(enable=useTurnsRatio));
        parameter Modelica.SIunits.Voltage VsNominal(start=100)
          "Nominal stator voltage per phase"
          annotation (Dialog(enable=not useTurnsRatio));
        parameter Modelica.SIunits.Voltage VrLockedRotor(start=100*(2*pi*
              fsNominal*Lm)/sqrt(Rs^2 + (2*pi*fsNominal*(Lm + Lssigma))^2))
          "Locked rotor voltage per phase"
          annotation (Dialog(enable=not useTurnsRatio));
        parameter Modelica.Electrical.Machines.Losses.CoreParameters
          rotorCoreParameters(
          final m=3,
          PRef=0,
          VRef(start=1) = 1,
          wRef(start=1) = 1)
          "Rotor core loss parameter record, all quantities refer to rotor side"
          annotation (Dialog(tab="Losses"));
        output Modelica.SIunits.Voltage vr[mr]=plug_rp.pin.v - plug_rn.pin.v
          "Rotor instantaneous voltages";
        output Modelica.SIunits.Current ir[mr]=plug_rp.pin.i
          "Rotor instantaneous currents";
      protected
        final parameter Real internalTurnsRatio=if useTurnsRatio then
            TurnsRatio else VsNominal/VrLockedRotor*(2*pi*fsNominal*Lm)/sqrt(Rs
            ^2 + (2*pi*fsNominal*(Lm + Lssigma))^2);
      public
        Components.SymmetricMultiPhaseWinding rotor(
          final Lsigma=Lrsigma,
          final effectiveTurns=effectiveStatorTurns/internalTurnsRatio,
          final useHeatPort=true,
          final RRef=Rr,
          final TRef=TrRef,
          final TOperational=TrOperational,
          final Lzero=Lrsigma,
          final GcRef=rotorCoreParameters.GcRef,
          final m=mr,
          final alpha20=alpha20r)
          "Symmetric rotor winding including resistances, zero and stray inductances and zero core losses"
          annotation (Placement(transformation(
              origin={0,-40},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        /* previously used: state selection, now commented
  FundamentalWave.Interfaces.StateSelector stateSelectorR(
    final m=m,
    final xi=ir,
    final gamma=0) "State selection of rotor currents"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,0})));
  */
      equation
        connect(rotor.plug_n, plug_rn) annotation (Line(points={{10,-50},{10,-60},
                {-100,-60}}, color={0,0,255}));
        connect(rotor.heatPortCore, internalThermalPort.heatPortRotorCore)
          annotation (Line(
            points={{10,-36},{16,-36},{16,-36},{20,-36},{20,-80},{-39.6,-80},{-39.6,-90.8}},
                       color={191,0,0}));

        connect(rotor.heatPortWinding, internalThermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{10,-44},{20,-44},{20,-80},{-40,-80},{-40,-90}}, color={191,0,0}));
        connect(plug_rp, rotor.plug_p) annotation (Line(
            points={{-100,60},{-80,60},{-80,-50},{-10,-50}}, color={0,0,255}));
        connect(airGap.port_rn, rotor.port_p) annotation (Line(
            points={{-10,-10},{-10,-30}}, color={255,128,0}));
        connect(airGap.port_rp, rotor.port_n) annotation (Line(
            points={{10,-10},{10,-30}}, color={255,128,0}));
        annotation (
          defaultComponentName="aims",
          Icon(graphics={Line(points={{-100,50},{-100,20},{-60,20}}, color={0,0,255}),
                     Line(points={{-100,-50},{-100,-20},{-60,-20}}, color=
                   {0,0,255})}),
          Documentation(info="<html>
<p>
Resistances and stray inductances of the machine always refer to either stator or rotor. The symmetry of the stator and rotor is assumed. The number of stator and rotor phases may be different. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>heat losses in the temperature dependent rotor winding resistances</li>
<li>friction losses</li>
<li>stator and rotor core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage\">AIM_SquirrelCage</a>,
</p>
</html>"));
      end AIM_SlipRing;
      annotation (Documentation(info="<html>
<p>This package provides squirrel cage and slip ring induction machine models.</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines\">SynchronousInductionMachines</a>
</p>
</html>"));
    end AsynchronousInductionMachines;

    package SynchronousInductionMachines "Synchronous machines"
      extends Modelica.Icons.VariantsPackage;
      model SM_PermanentMagnet
        "Permanent magnet synchronous machine with optional damper cage"
        extends
          Modelica.Magnetic.FundamentalWave.Interfaces.PartialBasicInductionMachine(
          is(start=zeros(m)),
          Rs(start=0.03),
          Lssigma(start=0.1/(2*pi*fsNominal)),
          final L0(d=2.0*Lmd/m/effectiveStatorTurns^2, q=2.0*Lmq/m/
                effectiveStatorTurns^2),
          redeclare final
            Modelica.Electrical.Machines.Thermal.SynchronousInductionMachines.ThermalAmbientSMPM
            thermalAmbient(
            final useDamperCage=useDamperCage,
            final Tr=TrOperational,
            final Tpm=TpmOperational),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMPM
            thermalPort(final useDamperCage=useDamperCage),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMPM
            internalThermalPort(final useDamperCage=useDamperCage),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceSMPM
            powerBalance(
            final lossPowerRotorWinding=damperCageLossPower,
            final lossPowerRotorCore=0,
            final lossPowerPermanentMagnet=permanentMagnet.lossPower));
        // Main field parameters
        parameter Modelica.SIunits.Inductance Lmd(start=0.3/(2*pi*fsNominal))
          "Stator main field inductance, d-axis" annotation (Dialog(tab=
                "Nominal resistances and inductances", groupImage=
                "modelica://Modelica/Resources/Images/Electrical/Machines/SMPM.png"));
        parameter Modelica.SIunits.Inductance Lmq(start=0.3/(2*pi*fsNominal))
          "Stator main field inductance, q-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        // Rotor cage parameters
        parameter Boolean useDamperCage(start=true)
          "Enable/disable damper cage" annotation (Dialog(tab=
                "Nominal resistances and inductances", group="Damper cage"));
        parameter Modelica.SIunits.Inductance Lrsigmad(start=0.05/(2*pi*
              fsNominal))
          "Rotor leakage inductance, d-axis, w.r.t. stator side" annotation (
            Dialog(
            tab="Nominal resistances and inductances",
            group="Damper cage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Rotor leakage inductance, q-axis, w.r.t. stator side" annotation (
            Dialog(
            tab="Nominal resistances and inductances",
            group="Damper cage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrd(start=0.04)
          "Rotor resistance, d-axis, w.r.t. stator side" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="Damper cage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Rotor resistance , q-axis, w.r.t. stator side" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="Damper cage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="Damper cage",
            enable=useDamperCage));
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20r(start=0)
          "Temperature coefficient of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="Damper cage",
            enable=useDamperCage));
        // Operational parameters
        final parameter Modelica.SIunits.Temperature TpmOperational=293.15
          "Operational temperature of permanent magnet"
          annotation (Dialog(group="Operational temperatures"));
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of (optional) damper cage" annotation (
            Dialog(group="Operational temperatures", enable=not useThermalPort
                 and useDamperCage));
        // Permanent magnet parameters
        parameter Modelica.SIunits.Voltage VsOpenCircuit(start=112.3)
          "Open circuit RMS voltage per phase @ fsNominal";
        parameter
          Modelica.Electrical.Machines.Losses.PermanentMagnetLossParameters
          permanentMagnetLossParameters(IRef(start=100), wRef(start=2*pi*
                fsNominal/p)) "Permanent magnet loss parameter record"
          annotation (Dialog(tab="Losses"));
        // Rotor cage components
        Modelica.Blocks.Interfaces.RealOutput ir[2](
          start=zeros(2),
          each final quantity="ElectricCurrent",
          each final unit="A") if useDamperCage "Damper cage currents"
          annotation (Placement(visible=false),Dialog(showStartAttribute=true));
        Modelica.Magnetic.FundamentalWave.Components.Short short if not
          useDamperCage
          "Magnetic connection in case the damper cage is not present"
          annotation (Placement(transformation(
              origin={10,-40},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding
          rotorCage(
          final RRef(d=Rrd, q=Rrq),
          final Lsigma(d=Lrsigmad, q=Lrsigmaq),
          final effectiveTurns=sqrt(3.0/2.0)*effectiveStatorTurns,
          final useHeatPort=true,
          final TRef=TrRef,
          final alpha20=alpha20r,
          final TOperational=TrOperational) if useDamperCage
          "Symmetric rotor cage winding including resistances and stray inductances"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={30,-40})));
        // Permanent magnet components
        Components.PermanentMagnet permanentMagnet(
          final V_m=Complex(V_mPM, 0),
          final m=m,
          final permanentMagnetLossParameters=permanentMagnetLossParameters,
          final useHeatPort=true,
          final is=is) "Magnetic potential difference of permanent magnet"
          annotation (Placement(transformation(
              origin={-10,-40},
              extent={{-10,-10},{10,10}},
              rotation=270)));
      protected
        final parameter Modelica.SIunits.MagneticPotentialDifference V_mPM=(2/
            pi)*sqrt(2)*(m/2)*VsOpenCircuit/effectiveStatorTurns/(Lmd/
            effectiveStatorTurns^2*2*pi*fsNominal)
          "Equivalent excitation magnetic potential difference";
        Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
            quantity="Power", final unit="W") "Damper losses";
      equation
        connect(ir, rotorCage.i);
        connect(damperCageLossPower, rotorCage.lossPower);
        if not useDamperCage then
          damperCageLossPower = 0;
        end if;
        connect(permanentMagnet.port_p, airGap.port_rn) annotation (Line(
            points={{-10,-30},{-10,-10}}, color={255,128,0}));
        connect(permanentMagnet.support, airGap.support) annotation (Line(
            points={{-20,-40},{-50,-40},{-50,0},{-10,0}}));
        connect(permanentMagnet.heatPort, internalThermalPort.heatPortPermanentMagnet)
          annotation (Line(
            points={{-20,-30},{-40,-30},{-40,-90}}, color={191,0,0}));
        connect(permanentMagnet.flange, inertiaRotor.flange_b) annotation (Line(
            points={{0,-40},{0,-20},{90,-20},{90,0}}));
        connect(airGap.port_rp, rotorCage.port_n) annotation (Line(
            points={{10,-10},{10,-30},{30,-30}},                                     color={255,128,0}));

        connect(short.port_n, airGap.port_rp) annotation (Line(
            points={{10,-30},{10,-10}}, color={255,128,0}));
        connect(short.port_p, permanentMagnet.port_n) annotation (Line(
            points={{10,-50},{-10,-50}}, color={255,128,0}));
        connect(rotorCage.port_p, permanentMagnet.port_n) annotation (Line(
            points={{30,-50},{-10,-50}}, color={255,128,0}));
        connect(rotorCage.heatPortWinding, internalThermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{40,-40},{40,-80},{-40,-80},{-40,-90}},          color={191,0,0}));
        annotation (
          defaultComponentName="smpm",
          Icon(graphics={
              Rectangle(
                extent={{-130,10},{-100,-10}},
                fillColor={0,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-100,10},{-70,-10}},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255})}),
          Documentation(info="<html>
<p>
Resistances and stray inductances of the machine refer to an <code>m</code> phase stator. The symmetry of the stator is assumed. For rotor asymmetries can be taken into account by different resistances and stray inductances in the d- and q-axis. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>optional, when enabled: heat losses in the temperature dependent damper cage resistances</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
<li>permanent magnet losses</li>
</ul>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited\">SM_ElectricalExcited</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor\">SM_ReluctanceRotor</a>,
</p>
</html>"));
      end SM_PermanentMagnet;

      model SM_ElectricalExcited
        "Electrical excited synchronous machine with optional damper cage"
        extends
          Modelica.Magnetic.FundamentalWave.Interfaces.PartialBasicInductionMachine(
          is(start=zeros(m)),
          Rs(start=0.03),
          Lssigma(start=0.1/(2*pi*fsNominal)),
          final L0(d=2.0*Lmd/m/effectiveStatorTurns^2, q=2.0*Lmq/m/
                effectiveStatorTurns^2),
          redeclare final
            Modelica.Electrical.Machines.Thermal.SynchronousInductionMachines.ThermalAmbientSMEE
            thermalAmbient(
            final useDamperCage=useDamperCage,
            final Te=TeOperational,
            final Tr=TrOperational),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMEE
            thermalPort(final useDamperCage=useDamperCage),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMEE
            internalThermalPort(final useDamperCage=useDamperCage),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceSMEE
            powerBalance(
            final lossPowerRotorWinding=damperCageLossPower,
            final powerExcitation=ve*ie,
            final lossPowerExcitation=excitation.resistor.LossPower,
            final lossPowerBrush=brush.lossPower,
            final lossPowerRotorCore=0));
        // Main field parameters
        parameter Modelica.SIunits.Inductance Lmd(start=1.5/(2*pi*fsNominal))
          "Stator main field inductance, d-axis" annotation (Dialog(tab=
                "Nominal resistances and inductances", groupImage=
                "modelica://Modelica/Resources/Images/Electrical/Machines/SMEE.png"));
        parameter Modelica.SIunits.Inductance Lmq(start=1.5/(2*pi*fsNominal))
          "Stator main field inductance, q-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        // Rotor cage parameters
        parameter Boolean useDamperCage(start=true)
          "Enable/disable damper cage" annotation (Dialog(tab=
                "Nominal resistances and inductances", group="DamperCage"));
        parameter Modelica.SIunits.Inductance Lrsigmad(start=0.05/(2*pi*
              fsNominal))
          "Rotor leakage inductance, d-axis, w.r.t. stator side" annotation (
            Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Rotor leakage inductance, q-axis, w.r.t. stator side" annotation (
            Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrd(start=0.04)
          "Rotor resistance, d-axis, w.r.t. stator side" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Rotor resistance , q-axis, w.r.t. stator side" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20r(start=0)
          "Temperature coefficient of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        // Operational temperature
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of (optional) damper cage" annotation (
            Dialog(group="Operational temperatures", enable=not useThermalPort
                 and useDamperCage));
        parameter Modelica.SIunits.Temperature TeOperational(start=293.15)
          "Operational excitation temperature" annotation (Dialog(group=
                "Operational temperatures", enable=not useThermalPort));
        // Excitation parameters
        parameter Modelica.SIunits.Voltage VsNominal(start=100)
          "Nominal stator voltage" annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Current IeOpenCircuit(start=10)
          "Open circuit excitation current @ nominal voltage and frequency"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Resistance Re(start=2.5)
          "Warm excitation resistance" annotation (Dialog(tab="Excitation"));
        parameter Modelica.SIunits.Temperature TeRef(start=293.15)
          "Reference temperature of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20e(start=0) "Temperature coefficient of excitation resistance"
          annotation (Dialog(tab="Excitation"));
        parameter Real sigmae(
          min=0,
          max=1,
          start=0.025) "Stray fraction of total excitation inductance"
          annotation (Dialog(tab="Excitation"));
        parameter Modelica.Electrical.Machines.Losses.BrushParameters
          brushParameters "Brush loss parameter record"
          annotation (Dialog(tab="Losses"));
        output Modelica.SIunits.Voltage ve=pin_ep.v - pin_en.v
          "Excitation voltage";
        output Modelica.SIunits.Current ie=pin_ep.i "Excitation current";
        // Rotor cage components
        Modelica.Blocks.Interfaces.RealOutput ir[2](
          start=zeros(2),
          each final quantity="ElectricCurrent",
          each final unit="A") if useDamperCage "Damper cage currents"
          annotation (Placement(visible=false),Dialog(showStartAttribute=true));
        FundamentalWave.Components.Short short if not useDamperCage
          "Magnetic connection in case the damper cage is not present"
          annotation (Placement(transformation(
              origin={10,-40},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Components.SaliencyCageWinding rotorCage(
          final Lsigma(d=Lrsigmad, q=Lrsigmaq),
          final effectiveTurns=sqrt(3.0/2.0)*effectiveStatorTurns,
          final useHeatPort=true,
          final TRef=TrRef,
          final TOperational=TrOperational,
          final RRef(d=Rrd, q=Rrq),
          final alpha20=alpha20r) if useDamperCage
          "Symmetric rotor cage winding including resistances and stray inductances"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={30,-40})));
        // Excitation components
        Components.SinglePhaseWinding excitation(
          final orientation=0,
          final RRef=Re,
          final TRef=TeRef,
          final Lsigma=Lesigma,
          final effectiveTurns=effectiveStatorTurns*turnsRatio*m/2,
          final useHeatPort=true,
          final TOperational=TeOperational,
          final alpha20=alpha20e)
          "Excitation winding including resistance and stray inductance"
          annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
        Modelica.Electrical.Analog.Interfaces.PositivePin pin_ep
          "Positive pin of excitation" annotation (Placement(transformation(
                extent={{-110,70},{-90,50}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_en
          "Negative pin of excitation" annotation (Placement(transformation(
                extent={{-90,-50},{-110,-70}})));
        Electrical.Machines.Losses.DCMachines.Brush brush(final brushParameters=
             brushParameters, final useHeatPort=true) annotation (Placement(
              transformation(
              extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-80,40})));
      protected
        final parameter Real turnsRatio=sqrt(2)*VsNominal/(2*pi*fsNominal*Lmd*
            IeOpenCircuit) "Stator current / excitation current";
        final parameter Modelica.SIunits.Inductance Lesigma=Lmd*turnsRatio^2*3/
            2*sigmae/(1 - sigmae)
          "Leakage inductance of the excitation winding";
        Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
            quantity="Power", final unit="W") "Damper losses";
      equation
        connect(ir, rotorCage.i);
        connect(damperCageLossPower, rotorCage.lossPower);
        if not useDamperCage then
          damperCageLossPower = 0;
        end if;
        connect(pin_en, excitation.pin_n) annotation (Line(points={{-100,-60},{
                -100,-60},{-100,-50},{-30,-50}}, color={0,0,255}));
        connect(airGap.port_rn, excitation.port_p) annotation (Line(
            points={{-10,-10},{-10,-20},{-10,-20},{-10,-30}}, color={255,128,0}));
        connect(pin_ep, brush.p) annotation (Line(
            points={{-100,60},{-80,60},{-80,50}}, color={0,0,255}));
        connect(brush.n, excitation.pin_p) annotation (Line(
            points={{-80,30},{-80,-30},{-30,-30}}, color={0,0,255}));
        connect(brush.heatPort, internalThermalPort.heatPortBrush) annotation (
            Line(
            points={{-70,50},{-40,50},{-40,-90}}, color={191,0,0}));
        connect(excitation.heatPortWinding, internalThermalPort.heatPortExcitation)
          annotation (Line(
            points={{-20,-50},{-20,-80},{-40,-80},{-40,-90}}, color={191,0,0}));
        connect(airGap.port_rp, rotorCage.port_n) annotation (Line(
            points={{10,-10},{10,-30},{30,-30}}, color={255,128,0}));
        connect(short.port_n, airGap.port_rp) annotation (Line(
            points={{10,-30},{10,-10}}, color={255,128,0}));
        connect(rotorCage.port_p, excitation.port_n) annotation (Line(
            points={{30,-50},{-10,-50}}, color={255,128,0}));
        connect(short.port_p, excitation.port_n) annotation (Line(
            points={{10,-50},{-10,-50}}, color={255,128,0}));
        connect(rotorCage.heatPortWinding, internalThermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{40,-40},{40,-80},{-40,-80},{-40,-90}},          color={191,0,0}));
        annotation (
          defaultComponentName="smee",
          Icon(graphics={
              Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255}),
              Line(points={{-100,50},{-100,20},{-130,20},{-130,-4}}, color={0,0,255}),
              Line(points={{-130,-4},{-129,1},{-125,5},{-120,6},{-115,5},{-111,
                    1},{-110,-4}}, color={0,0,255}),
              Line(points={{-110,-4},{-109,1},{-105,5},{-100,6},{-95,5},{-91,1},
                    {-90,-4}}, color={0,0,255}),
              Line(points={{-90,-4},{-89,1},{-85,5},{-80,6},{-75,5},{-71,1},{-70,
                    -4}}, color={0,0,255}),
              Line(points={{-100,-50},{-100,-20},{-70,-20},{-70,-2}}, color={0,
                    0,255})}),
          Documentation(info="<html>
<p>
The symmetry of the stator is assumed. For rotor asymmetries can be taken into account by different resistances and stray inductances in the d- and q-axis. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>heat losses in the temperature dependent excitation winding resistance</li>
<li>optional, when enabled: heat losses in the temperature dependent damper cage resistances</li>
<li>brush losses in the excitation circuit</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet\">SM_PermanentMagnet</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ReluctanceRotor\">SM_ReluctanceRotor</a>,
</p>
</html>"));
      end SM_ElectricalExcited;

      model SM_ReluctanceRotor "Reluctance machine with optional damper cage"
        extends
          Modelica.Magnetic.FundamentalWave.Interfaces.PartialBasicInductionMachine(
          is(start=zeros(m)),
          Rs(start=0.03),
          Lssigma(start=0.1/(2*pi*fsNominal)),
          final L0(d=2.0*Lmd/m/effectiveStatorTurns^2, q=2.0*Lmq/m/
                effectiveStatorTurns^2),
          redeclare final
            Modelica.Electrical.Machines.Thermal.SynchronousInductionMachines.ThermalAmbientSMR
            thermalAmbient(final useDamperCage=useDamperCage, final Tr=
                TrOperational),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMR
            thermalPort(final useDamperCage=useDamperCage),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.ThermalPortSMR
            internalThermalPort(final useDamperCage=useDamperCage),
          redeclare final
            Modelica.Electrical.Machines.Interfaces.InductionMachines.PowerBalanceSMR
            powerBalance(final lossPowerRotorWinding=damperCageLossPower,
              final lossPowerRotorCore=0));

        // Main field parameters
        parameter Modelica.SIunits.Temperature TrOperational(start=293.15)
          "Operational temperature of (optional) damper cage" annotation (
            Dialog(group="Operational temperatures", enable=not useThermalPort
                 and useDamperCage));
        parameter Modelica.SIunits.Inductance Lmd(start=2.9/(2*pi*fsNominal))
          "Stator main field inductance, d-axis" annotation (Dialog(tab=
                "Nominal resistances and inductances", groupImage=
                "modelica://Modelica/Resources/Images/Electrical/Machines/SMR.png"));
        parameter Modelica.SIunits.Inductance Lmq(start=0.9/(2*pi*fsNominal))
          "Stator main field inductance, q-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        // Rotor cage parameters
        parameter Boolean useDamperCage(start=true)
          "Enable/disable damper cage" annotation (Dialog(tab=
                "Nominal resistances and inductances", group="DamperCage"));
        parameter Modelica.SIunits.Inductance Lrsigmad(start=0.05/(2*pi*
              fsNominal))
          "Rotor leakage inductance, d-axis, w.r.t. stator side" annotation (
            Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Rotor leakage inductance, q-axis, w.r.t. stator side" annotation (
            Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrd(start=0.04)
          "Rotor resistance, d-axis, w.r.t. stator side" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Rotor resistance , q-axis, w.r.t. stator side" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Temperature TrRef(start=293.15)
          "Reference temperature of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20r(start=0)
          "Temperature coefficient of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        // Rotor cage components
        Modelica.Blocks.Interfaces.RealOutput ir[2](
          start=zeros(2),
          each final quantity="ElectricCurrent",
          each final unit="A") if useDamperCage "Damper cage currents"
          annotation (Placement(visible=false),Dialog(showStartAttribute=true));
        Modelica.Magnetic.FundamentalWave.Components.Short short if not
          useDamperCage
          "Magnetic connection in case the damper cage is not present"
          annotation (Placement(transformation(
              origin={10,-40},
              extent={{10,10},{-10,-10}},
              rotation=270)));
        Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding
          rotorCage(
          final RRef(d=Rrd, q=Rrq),
          final Lsigma(d=Lrsigmad, q=Lrsigmaq),
          final effectiveTurns=sqrt(3.0/2.0)*effectiveStatorTurns,
          final useHeatPort=true,
          final TRef=TrRef,
          final alpha20=alpha20r,
          final TOperational=TrOperational) if useDamperCage
          "Symmetric rotor cage winding including resistances and stray inductances"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={30,-40})));
      protected
        Modelica.Blocks.Interfaces.RealOutput damperCageLossPower(final
            quantity="Power", final unit="W") "Damper losses";
      equation
        connect(ir, rotorCage.i);
        connect(damperCageLossPower, rotorCage.lossPower);
        if not useDamperCage then
          damperCageLossPower = 0;
        end if;
        connect(rotorCage.port_n, airGap.port_rp) annotation (Line(
            points={{30,-30},{10,-30},{10,-10}},                                     color={255,128,0}));

        connect(short.port_n, airGap.port_rp) annotation (Line(
            points={{10,-30},{10,-10}}, color={255,128,0}));
        connect(rotorCage.port_p, airGap.port_rn) annotation (Line(
            points={{30,-50},{-10,-50},{-10,-10}},                               color={255,128,0}));

        connect(short.port_p, airGap.port_rn) annotation (Line(
            points={{10,-50},{-10,-50},{-10,-10}}, color={255,128,0}));
        connect(rotorCage.heatPortWinding, internalThermalPort.heatPortRotorWinding)
          annotation (Line(
            points={{40,-40},{40,-80},{-40,-80},{-40,-90}},          color={191,0,0}));
        annotation (
          defaultComponentName="smr",
          Icon(graphics={
              Rectangle(extent={{-130,10},{-100,-10}}),
              Rectangle(extent={{-100,10},{-70,-10}}),
              Ellipse(extent={{-134,34},{-66,-34}}, lineColor={0,0,255})}),
          Documentation(info="<html>
<p>
The symmetry of the stator is assumed. For rotor asymmetries can be taken into account by different resistances and stray inductances in the d- and q-axis. The machine models take the following loss effects into account:
</p>

<ul>
<li>heat losses in the temperature dependent stator winding resistances</li>
<li>optional, when enabled: heat losses in the temperature dependent damper cage resistances</li>
<li>friction losses</li>
<li>core losses (only eddy current losses, no hysteresis losses)</li>
<li>stray load losses</li>
</ul>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited\">SM_ElectricalExcited</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet\">SM_PermanentMagnet</a>,
</p>
</html>"));
      end SM_ReluctanceRotor;
      annotation (Documentation(info="<html>
<p>This package contains various synchronous induction machine models.</p>

<h4>See also</h4>

<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.AsynchronousInductionMachines\">AsynchronousInductionMachines</a>
</p>
</html>"));
    end SynchronousInductionMachines;

    package Components "Components specially for electric machines"
      extends Modelica.Icons.Package;

      model SinglePhaseWinding
        "Symmetric winding model coupling electrical and magnetic domain"

        Modelica.Electrical.Analog.Interfaces.PositivePin pin_p "Positive pin"
          annotation (Placement(transformation(
              origin={-100,100},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Modelica.Electrical.Analog.Interfaces.NegativePin pin_n "Negative pin"
          annotation (Placement(transformation(
              origin={-100,-100},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort
          port_n "Negative complex magnetic port" annotation (Placement(
              transformation(extent={{90,-110},{110,-90}})));
        Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort
          port_p "Positive complex magnetic port" annotation (Placement(
              transformation(extent={{90,90},{110,110}})));
        parameter Boolean useHeatPort=false
          "Enable / disable (=fixed temperatures) thermal port"
          annotation (Evaluate=true);
        parameter Modelica.SIunits.Resistance RRef
          "Winding resistance per phase at TRef";
        parameter Modelica.SIunits.Temperature TRef(start=293.15)
          "Reference temperature of winding";
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20(start=0) "Temperature coefficient of winding at 20 degC";
        final parameter Modelica.SIunits.LinearTemperatureCoefficient alphaRef=
            Modelica.Electrical.Machines.Thermal.convertAlpha(
                  alpha20,
                  TRef,
                  293.15);
        parameter Modelica.SIunits.Temperature TOperational(start=293.15)
          "Operational temperature of winding"
          annotation (Dialog(enable=not useHeatPort));
        parameter Modelica.SIunits.Inductance Lsigma
          "Winding stray inductance per phase";
        parameter Real effectiveTurns=1 "Effective number of turns per phase";
        parameter Modelica.SIunits.Angle orientation
          "Orientation of the resulting fundamental wave field phasor";

        Modelica.SIunits.Voltage v=pin_p.v - pin_n.v "Voltage";
        Modelica.SIunits.Current i=pin_p.i "Current";

        Modelica.SIunits.ComplexMagneticPotentialDifference V_m=port_p.V_m -
            port_n.V_m "Complex magnetic potential difference";
        Modelica.SIunits.MagneticPotentialDifference abs_V_m=
            Modelica.ComplexMath.'abs'(V_m)
          "Magnitude of complex magnetic potential difference";
        Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
          "Argument of complex magnetic potential difference";
        Modelica.SIunits.ComplexMagneticFlux Phi=port_p.Phi
          "Complex magnetic flux";
        Modelica.SIunits.MagneticFlux abs_Phi=
            Modelica.ComplexMath.'abs'(Phi)
          "Magnitude of complex magnetic flux";
        Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
          "Argument of complex magnetic flux";

        Modelica.Electrical.Analog.Basic.Resistor resistor(
          final useHeatPort=useHeatPort,
          final R=RRef,
          final T_ref=TRef,
          final alpha=alphaRef,
          final T=TOperational) annotation (Placement(transformation(
              origin={-10,70},
              extent={{10,10},{-10,-10}},
              rotation=90)));
        Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter
          electroMagneticConverter(final effectiveTurns=effectiveTurns, final
            orientation=orientation) "Winding" annotation (Placement(
              transformation(extent={{-10,-10},{10,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding if
          useHeatPort "Heat ports of winding resistor"
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
        Modelica.Magnetic.FundamentalWave.Components.Reluctance reluctance(
            final R_m(d=effectiveTurns^2/Lsigma, q=effectiveTurns^2/Lsigma))
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={30,0})));
      equation
        connect(pin_p, resistor.p) annotation (Line(points={{-100,100},{-10,100},
                {-10,80}}, color={0,0,255}));
        connect(electroMagneticConverter.pin_n, pin_n) annotation (Line(points=
                {{-10,-10},{-10,-100},{-100,-100}}, color={0,0,255}));
        connect(electroMagneticConverter.port_p, port_p) annotation (Line(
              points={{10,10},{10,100},{100,100}}, color={255,128,0}));
        connect(electroMagneticConverter.port_n, port_n) annotation (Line(
              points={{10,-10},{10,-100},{100,-100}}, color={255,128,0}));
        connect(heatPortWinding, resistor.heatPort) annotation (Line(
            points={{0,-100},{0,-60},{-40,-60},{-40,70},{-20,70}}, color={191,0,0}));
        connect(resistor.n, electroMagneticConverter.pin_p) annotation (Line(
            points={{-10,60},{-10,10}}, color={0,0,255}));
        connect(electroMagneticConverter.port_p, reluctance.port_p) annotation (
           Line(
            points={{10,10},{30,10}}, color={255,128,0}));
        connect(electroMagneticConverter.port_n, reluctance.port_n) annotation (
           Line(
            points={{10,-10},{30,-10}}, color={255,128,0}));
        annotation (defaultComponentName="winding", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={      Line(points={{100,-100},{
                94,-100},{84,-98},{76,-94},{64,-86},{50,-72},{42,-58},{36,-40},
                {30,-18},{30,0},{30,18},{34,36},{46,66},{62,84},{78,96},{90,100},
                {100,100}}, color={255,128,0}),Line(points={{40,60},{-100,60},{
                -100,100}}, color={0,0,255}),Line(points={{40,-60},{-100,-60},{
                -100,-98}}, color={0,0,255}),Line(points={{40,60},{100,20},{40,
                -20},{0,-20},{-40,0},{0,20},{40,20},{100,-20},{40,-60}}, color=
                {0,0,255}),
                Text(
                    extent={{-150,110},{150,150}},
                    lineColor={0,0,255},
                    textString="%name")}),   Documentation(info="<html>
<p>
The single phase winding consists of a winding
<a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">resistor</a>, a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.SinglePhaseElectroMagneticConverter\">single phase electromagnetic coupling</a> and a <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Reluctance\">stray reluctance</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding\">SymmetricMultiPhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding\">SymmetricMultiPhaseCageWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding\">SaliencyCageWinding</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
</p>
</html>"));
      end SinglePhaseWinding;

      model SymmetricMultiPhaseWinding
        "Symmetric winding model coupling electrical and magnetic domain"
        // Orientation changed
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(final m=m)
          "Positive plug" annotation (Placement(transformation(
              origin={-100,100},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_n(final m=m)
          "Negative plug" annotation (Placement(transformation(
              origin={-100,-100},
              extent={{-10,-10},{10,10}},
              rotation=180)));
        Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort
          port_n "Negative complex magnetic port" annotation (Placement(
              transformation(extent={{90,-110},{110,-90}})));
        Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort
          port_p "Positive complex magnetic port" annotation (Placement(
              transformation(extent={{90,90},{110,110}})));
        parameter Integer m=3 "Number of phases";
        parameter Boolean useHeatPort=false
          "Enable / disable (=fixed temperatures) thermal port"
          annotation (Evaluate=true);
        // Resistor model
        parameter Modelica.SIunits.Resistance RRef
          "Winding resistance per phase at TRef";
        parameter Modelica.SIunits.Temperature TRef(start=293.15)
          "Reference temperature of winding";
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20(start=0) "Temperature coefficient of winding at 20 degC";
        final parameter Modelica.SIunits.LinearTemperatureCoefficient alphaRef=
            Modelica.Electrical.Machines.Thermal.convertAlpha(
                  alpha20,
                  TRef,
                  293.15);
        parameter Modelica.SIunits.Temperature TOperational(start=293.15)
          "Operational temperature of winding"
          annotation (Dialog(enable=not useHeatPort));
        parameter Modelica.SIunits.Inductance Lsigma
          "Winding stray inductance per phase";
        parameter Modelica.SIunits.Inductance Lzero
          "Zero sequence inductance of winding";
        parameter Real effectiveTurns=1 "Effective number of turns per phase";
        parameter Modelica.SIunits.Conductance GcRef
          "Electrical reference core loss reluctance";
        final parameter Integer nBase=Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m)
          "Number of base systems";
        final parameter Integer mBase=integer(m/nBase)
          "Number of phase of the base systems";

        Modelica.SIunits.Voltage v[m]=plug_p.pin.v - plug_n.pin.v "Voltage";
        Modelica.SIunits.Current i[m]=plug_p.pin.i "Current";

        Modelica.SIunits.ComplexMagneticPotentialDifference V_m=port_p.V_m -
            port_n.V_m "Complex magnetic potential difference";
        Modelica.SIunits.MagneticPotentialDifference abs_V_m=
            Modelica.ComplexMath.'abs'(V_m)
          "Magnitude of complex magnetic potential difference";
        Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
          "Argument of complex magnetic potential difference";
        Modelica.SIunits.ComplexMagneticFlux Phi=port_p.Phi
          "Complex magnetic flux";
        Modelica.SIunits.MagneticFlux abs_Phi=
            Modelica.ComplexMath.'abs'(Phi)
          "Magnitude of complex magnetic flux";
        Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
          "Argument of complex magnetic flux";

        Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
          electroMagneticConverter(
          final m=m,
          final effectiveTurns=fill(effectiveTurns, m),
          final orientation=
              Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m))
          "Symmetric winding" annotation (Placement(transformation(extent={{-10,
                  -40},{10,-20}})));
        Modelica.Electrical.MultiPhase.Basic.ZeroInductor zeroInductor(final m=m, final Lzero=Lzero) if
             mBase<>2 "Zero sequence inductance of winding"
          annotation (Placement(transformation(
              origin={-30,30},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Electrical.MultiPhase.Ideal.Short short(final m=m) if mBase==2
          annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-10,30})));
        Modelica.Electrical.MultiPhase.Basic.Resistor resistor(
          final m=m,
          final useHeatPort=useHeatPort,
          final R=fill(RRef, m),
          final T_ref=fill(TRef, m),
          final alpha=fill(alphaRef, m),
          final T=fill(TOperational, m)) "Winding resistor" annotation (
            Placement(transformation(
              origin={-20,70},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding[m] if
          useHeatPort "Heat ports of winding resistors"
          annotation (Placement(transformation(extent={{-50,-110},{-30,-90}})));
        Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCore if useHeatPort
          "Heat port of core"
          annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
        Modelica.Magnetic.FundamentalWave.Components.EddyCurrent core(final
            useHeatPort=useHeatPort, final G=(m/2)*GcRef*effectiveTurns^2)
          "Core loss model (currently eddy currents only)" annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={50,-40})));
        Modelica.Magnetic.FundamentalWave.Components.Reluctance strayReluctance(
            final R_m(d=m*effectiveTurns^2/2/Lsigma, q=m*effectiveTurns^2/2/
                Lsigma))
          "Stray reluctance equivalent to ideally coupled stray inductances"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={80,30})));

      equation
        connect(plug_p, resistor.plug_p) annotation (Line(points={{-100,100},{-20,
                100},{-20,80}}, color={0,0,255}));
        connect(resistor.plug_n, zeroInductor.plug_p) annotation (Line(points={{-20,60},
                {-20,55},{-20,40},{-30,40}}, color={0,0,255}));
        connect(electroMagneticConverter.plug_n, plug_n) annotation (Line(
              points={{-10,-40},{-10,-40},{-100,-40},{-100,-100}}, color={0,0,
                255}));
        connect(electroMagneticConverter.port_p, port_p) annotation (Line(
              points={{10,-20},{10,100},{100,100}}, color={255,128,0}));
        connect(resistor.heatPort, heatPortWinding) annotation (Line(
            points={{-30,70},{-40,70},{-40,-100}}, color={191,0,0}));
        connect(electroMagneticConverter.port_n, core.port_p) annotation (Line(
            points={{10,-40},{40,-40}}, color={255,128,0}));
        connect(core.port_n, port_n) annotation (Line(
            points={{60,-40},{100,-40},{100,-100}}, color={255,128,0}));
        connect(core.heatPort, heatPortCore) annotation (Line(
            points={{40,-50},{40,-100}}, color={191,0,0}));
        connect(strayReluctance.port_n, core.port_n) annotation (Line(
            points={{80,20},{80,-40},{60,-40}}, color={255,128,0}));
        connect(strayReluctance.port_p, electroMagneticConverter.port_p)
          annotation (Line(
            points={{80,40},{80,100},{10,100},{10,-20}}, color={255,128,0}));
        connect(zeroInductor.plug_n, electroMagneticConverter.plug_p) annotation (
            Line(points={{-30,20},{-20,20},{-20,-20},{-10,-20}}, color={0,0,255}));
        connect(resistor.plug_n, short.plug_p)
          annotation (Line(points={{-20,60},{-20,40},{-10,40}}, color={0,0,255}));
        connect(electroMagneticConverter.plug_p, short.plug_n) annotation (Line(
              points={{-10,-20},{-20,-20},{-20,20},{-10,20}}, color={0,0,255}));
        annotation (defaultComponentName="winding", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={
              Line(points={{100,-100},{94,-100},{84,-98},{76,-94},{64,-86},{50,
                    -72},{42,-58},{36,-40},{30,-18},{30,0},{30,18},{34,36},{46,
                    66},{62,84},{78,96},{90,100},{100,100}}, color={255,128,0}),
              Line(points={{40,60},{-100,60},{-100,100}}, color={0,0,255}),
              Line(points={{40,-60},{-100,-60},{-100,-98}}, color={0,0,255}),
              Line(points={{40,60},{100,20},{40,-20},{0,-20},{-40,0},{0,20},{40,
                    20},{100,-20},{40,-60}}, color={0,0,255}),
                Text(
                    extent={{-150,110},{150,150}},
                    lineColor={0,0,255},
                    textString="%name")}),
                                       Documentation(info="<html>
<p>
The symmetrical multi phase winding consists of a symmetrical winding
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.Resistor\">resistor</a>, a
<a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.ZeroInductor\">zero inductor</a> as well as a symmetrical
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter\">multi phase electromagnetic coupling</a> and a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.Reluctance\">stray reluctance</a> and a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Components.EddyCurrent\">core loss</a> model including
heat <a href=\"modelica://Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">port</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding\">SymmetricMultiPhaseCageWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding\">SaliencyCageWinding</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
</p>
</html>"));
      end SymmetricMultiPhaseWinding;

      model RotorSaliencyAirGap "Air gap model with rotor saliency"
        import Modelica.Constants.pi;
        Interfaces.PositiveMagneticPort port_sp
          "Positive complex magnetic stator port" annotation (Placement(
              transformation(extent={{-110,-110},{-90,-90}})));
        Interfaces.NegativeMagneticPort port_sn
          "Negative complex magnetic stator port" annotation (Placement(
              transformation(extent={{-110,90},{-90,110}})));
        Interfaces.PositiveMagneticPort port_rp
          "Positive complex magnetic rotor port" annotation (Placement(
              transformation(extent={{90,90},{110,110}})));
        Interfaces.NegativeMagneticPort port_rn
          "Negative complex magnetic rotor port" annotation (Placement(
              transformation(extent={{90,-110},{110,-90}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
          "Flange of the rotor" annotation (Placement(transformation(extent={{-10,
                  110},{10,90}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a support
          "Support at which the reaction torque is acting" annotation (
            Placement(transformation(extent={{-10,-110},{10,-90}})));
        parameter Integer p "Number of pole pairs";
        parameter Modelica.Magnetic.FundamentalWave.Types.SalientInductance L0(
            d(start=1), q(start=1))
          "Salient inductance of a single unchorded coil w.r.t. the fundamental wave";
        final parameter Modelica.Magnetic.FundamentalWave.Types.SalientReluctance R_m(
          d=1/L0.d,q=1/L0.q) "Reluctance of the air gap model";
        // Complex phasors of magnetic potential differences
        Modelica.SIunits.ComplexMagneticPotentialDifference V_mss
          "Complex magnetic potential difference of stator w.r.t. stator fixed frame";
        Modelica.SIunits.ComplexMagneticPotentialDifference V_msr
          "Complex magnetic potential difference of stator w.r.t. rotor fixed frame";
        Modelica.SIunits.ComplexMagneticPotentialDifference V_mrr
          "Complex magnetic potential difference of rotor w.r.t. rotor fixed frame";
        // Complex phasors of magnetic fluxes
        Modelica.SIunits.ComplexMagneticFlux Phi_ss
          "Complex magnetic flux of stator w.r.t. stator fixed frame";
        Modelica.SIunits.ComplexMagneticFlux Phi_sr
          "Complex magnetic flux of stator w.r.t. rotor fixed frame";
        Modelica.SIunits.ComplexMagneticFlux Phi_rr
          "Complex magnetic flux of rotor w.r.t. rotor fixed frame";
        // Electrical torque and mechanical angle
        Modelica.SIunits.Torque tauElectrical "Electrical torque";
        Modelica.SIunits.Angle gamma
          "Electrical angle between rotor and stator";
        Complex rotator "Equivalent vector representation of orientation";
      equation
        port_sp.Phi = Phi_ss "Stator flux into positive stator port";
        port_sp.Phi + port_sn.Phi = Complex(0, 0) "Balance of stator flux";
        port_rp.Phi = Phi_rr "Rotor flux into positive rotor port";
        port_rp.Phi + port_rn.Phi = Complex(0, 0) "Balance of rotor flux";
        port_sp.V_m - port_sn.V_m = V_mss "Magnetomotive force of stator";
        port_rp.V_m - port_rn.V_m = V_mrr "Magnetomotive force of rotor";
        // Transformations between stator and rotor fixed frame
        V_msr = V_mss*Modelica.ComplexMath.conj(rotator);
        Phi_sr = Phi_ss*Modelica.ComplexMath.conj(rotator);
        // Stator flux and rotor flux are equal
        Phi_sr = Phi_rr;
        // Local balance of magnetomotive force
        (pi/2.0)*(V_mrr.re + V_msr.re) = Phi_rr.re*R_m.d;
        (pi/2.0)*(V_mrr.im + V_msr.im) = Phi_rr.im*R_m.q;
        // Torque
        tauElectrical = -(pi*p/2.0)*(Phi_ss.im*V_mss.re - Phi_ss.re*V_mss.im);
        flange_a.tau = -tauElectrical;
        support.tau = tauElectrical;
        // Electrical angle between stator and rotor
        gamma = p*(flange_a.phi - support.phi);
        rotator = Modelica.ComplexMath.exp(Complex(0, gamma));
        annotation (defaultComponentName="airGap", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={
              Ellipse(
                extent={{-100,100},{100,-100}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-100,90},{-100,60},{-80,60}}, color={255,128,0}),
              Line(points={{-100,-90},{-100,-60},{-80,-60}}, color={255,128,0}),
              Line(points={{40,60},{100,60},{100,90}}, color={255,128,0}),
              Line(points={{40,-60},{100,-60},{100,-90}}, color={255,128,0}),
              Ellipse(
                extent={{-60,80},{60,-80}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{0,80},{0,90}})}), Documentation(info="<html>
<p>
This salient air gap model can be used for machines with uniform air gaps and for machines with rotor saliency. The air gap model is not symmetrical towards stator and rotor since it is assumed the saliency always refers to the rotor. The saliency of the air gap is represented by a main field inductance in the d- and q-axis.
</p>

<p>
For the mechanical interaction of the air gap model with the stator and the rotor is equipped with two
<a href=\"modelica://Modelica.Mechanics.Rotational.Interfaces.Flange_a\">rotational connectors</a>. The torques acting on both connectors have the same absolute values but different signs. The difference between the stator and the rotor angle,
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/gamma.png\">, is required for the transformation of the magnetic stator quantities to the rotor side.</p>

<p>
The air gap model has two magnetic stator and two magnetic rotor
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">ports</a>. The magnetic potential difference and the magnetic flux of the stator (superscript s) are transformed to the rotor fixed reference frame (superscript r). The effective reluctances of the main field with respect to the d- and q-axis are considered then in the balance equations
</p>

<p>
&nbsp;&nbsp;<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Machines/Components/airgap.png\">
</p>

<p>
according to the following figure.
</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig:</strong> Magnetic equivalent circuit of the air gap model</caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Machines/Components/airgap_phasors.png\">
    </td>
  </tr>
</table>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding\">SymmetricMultiPhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding\">SymmetricMultiPhaseCageWinding</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding\">SaliencyCageWinding</a>
</p>

</html>"));
      end RotorSaliencyAirGap;

      model SymmetricMultiPhaseCageWinding "Symmetrical rotor cage"
        import Modelica.Constants.pi;
        extends
          Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortExtended;
        parameter Integer m=3 "Number of phases";
        parameter Boolean useHeatPort=false
          "Enable / disable (=fixed temperatures) thermal port"
          annotation (Evaluate=true);
        parameter Modelica.SIunits.Resistance RRef
          "Winding resistance per phase at TRef";
        parameter Modelica.SIunits.Temperature TRef(start=293.15)
          "Reference temperature of winding";
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20(start=0) "Temperature coefficient of winding at 20 degC";
        final parameter Modelica.SIunits.LinearTemperatureCoefficient alphaRef=
            Modelica.Electrical.Machines.Thermal.convertAlpha(
                  alpha20,
                  TRef,
                  293.15);
        parameter Modelica.SIunits.Temperature TOperational(start=293.15)
          "Operational temperature of winding"
          annotation (Dialog(enable=not useHeatPort));
        parameter Modelica.SIunits.Inductance Lsigma "Cage stray inductance";
        parameter Real effectiveTurns=1 "Effective number of turns";
        final parameter Integer nBase=Modelica.Electrical.MultiPhase.Functions.numberOfSymmetricBaseSystems(m)
          "Number of base systems";
        Modelica.SIunits.Current i[m]=electroMagneticConverter.i
          "Cage currents";
        Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
          electroMagneticConverter(
          final m=m,
          final effectiveTurns=fill(effectiveTurns, m),
          final orientation=
              Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m))
          "Symmetric winding" annotation (Placement(transformation(
              origin={0,-10},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Resistor resistor(
          final useHeatPort=useHeatPort,
          final m=m,
          final R=fill(RRef, m),
          final T_ref=fill(TRef, m),
          final alpha=fill(alphaRef, m),
          final T=fill(TOperational, m)) annotation (Placement(transformation(
              origin={-20,-50},
              extent={{10,10},{-10,-10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=nBase)
                                                                  annotation (
            Placement(transformation(extent={{50,-30},{70,-10}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={90,-20},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding if
          useHeatPort "Heat ports of winding resistor"
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
        Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(
            final m=m) if useHeatPort
          "Connector of thermal rotor resistance heat ports"
          annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
        Modelica.Magnetic.FundamentalWave.Components.Reluctance strayReluctance(
            final R_m(d=m*effectiveTurns^2/2/Lsigma, q=m*effectiveTurns^2/2/
                Lsigma))
          "Stray reluctance equivalent to ideally coupled stray inductances"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={0,20})));
        Modelica.Electrical.MultiPhase.Basic.MultiStar multiStar(final m=m)
          annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
      equation
        connect(port_p, electroMagneticConverter.port_p)
          annotation (Line(points={{-100,0},{-10,0}}, color={255,128,0}));
        connect(electroMagneticConverter.port_n, port_n) annotation (Line(
              points={{10,0},{100,0}}, color={255,
                128,0}));
        connect(ground.p, star.pin_n) annotation (Line(points={{80,-20},{70,-20}}, color={0,0,255}));
        connect(thermalCollector.port_a, resistor.heatPort) annotation (Line(
            points={{-40,-70},{-40,-70},{-40,-50},{-30,-50}}, color={191,0,0}));
        connect(thermalCollector.port_b, heatPortWinding) annotation (Line(
            points={{-40,-90},{-40,-100},{0,-100}}, color={191,0,0}));
        connect(strayReluctance.port_p, port_p) annotation (Line(
            points={{-10,20},{-30,20},{-30,0},{-100,0}}, color={255,128,0}));
        connect(strayReluctance.port_n, port_n) annotation (Line(
            points={{10,20},{30,20},{30,0},{100,0}}, color={255,128,0}));
        connect(electroMagneticConverter.plug_p, resistor.plug_p) annotation (
            Line(
            points={{-10,-20},{-20,-20},{-20,-40}}, color={0,0,255}));
        connect(electroMagneticConverter.plug_n, multiStar.plug_p)
          annotation (Line(points={{10,-20},{15,-20},{20,-20}}, color={0,0,255}));
        connect(multiStar.starpoints, star.plug_p)
          annotation (Line(points={{40,-20},{45,-20},{50,-20}}, color={0,0,255}));
        connect(resistor.plug_n, multiStar.plug_p)
          annotation (Line(points={{-20,-60},{20,-60},{20,-20}}, color={0,0,255}));
        annotation (defaultComponentName="cage",
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={
              Ellipse(
                extent={{-80,80},{80,-80}},
                fillColor={175,175,175},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-20,76},{20,36}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{28,46},{68,6}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{28,-8},{68,-48}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-20,-36},{20,-76}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-68,-6},{-28,-46}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-66,50},{-26,10}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,0},{-100,0}}, color={255,128,0}),
              Line(points={{100,0},{80,0}}, color={255,128,0}),
                Text(
                    extent={{-150,100},{150,140}},
                    lineColor={0,0,255},
                    textString="%name")}),
          Documentation(info="<html>
<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Machines/Components/rotorcage.png\">
</p>
<p>
The symmetric rotor cage model of this library does not consist of rotor bars and end rings. Instead the symmetric cage is modeled by an equivalent symmetrical winding. The rotor cage model consists of
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\"> phases. If the cage is modeled by equivalent stator winding parameters, the number of effective turns, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns.png\">, has to be chosen equivalent to the effective number of stator turns.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding\">SymmetricMultiPhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding\">SaliencyCageWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
</p>
</html>"));
      end SymmetricMultiPhaseCageWinding;

      model SaliencyCageWinding "Rotor cage with saliency in d- and q-axis"
        extends
          Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortExtended;
        parameter Boolean useHeatPort=false
          "Enable / disable (=fixed temperatures) thermal port"
          annotation (Evaluate=true);
        parameter Modelica.Magnetic.FundamentalWave.Types.SalientResistance
          RRef(d(start=1), q(start=1)) "Salient cage resistance";
        parameter Modelica.SIunits.Temperature TRef(start=293.15)
          "Reference temperature of winding";
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20(start=0) "Temperature coefficient of winding at 20 degC";
        final parameter Modelica.SIunits.LinearTemperatureCoefficient alphaRef=
            Modelica.Electrical.Machines.Thermal.convertAlpha(
                  alpha20,
                  TRef,
                  293.15);
        parameter Modelica.SIunits.Temperature TOperational(start=293.15)
          "Operational temperature of winding"
          annotation (Dialog(enable=not useHeatPort));
        parameter Modelica.Magnetic.FundamentalWave.Types.SalientInductance
          Lsigma(d(start=1), q(start=1)) "Salient cage stray inductance";
        parameter Real effectiveTurns=1 "Effective number of turns";
        Modelica.Blocks.Interfaces.RealOutput i[2](
          each final quantity="ElectricCurrent",
          each final unit="A") = electroMagneticConverter.i
          "Currents out from damper";
        Modelica.Blocks.Interfaces.RealOutput lossPower(
          final quantity="Power",
          final unit="W") = sum(resistor.resistor.LossPower) "Damper losses";
        Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
          electroMagneticConverter(
          final m=2,
          final orientation={0,Modelica.Constants.pi/2},
          final effectiveTurns=fill(effectiveTurns, 2)) annotation (Placement(
              transformation(
              origin={0,-10},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Resistor resistor(
          final useHeatPort=useHeatPort,
          final m=2,
          final R={RRef.d,RRef.q},
          final T_ref=fill(TRef, 2),
          final alpha=fill(alphaRef, 2),
          final T=fill(TOperational, 2)) annotation (Placement(transformation(
              origin={-20,-50},
              extent={{10,10},{-10,-10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=2) annotation (
            Placement(transformation(extent={{20,-30},{40,-10}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={60,-20},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding if
          useHeatPort "Heat ports of winding resistor"
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
        Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(
            final m=2) if useHeatPort
          "Connector of thermal rotor resistance heat ports"
          annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
        Modelica.Magnetic.FundamentalWave.Components.Reluctance strayReluctance(
            final R_m(d=effectiveTurns^2/Lsigma.d, q=effectiveTurns^2/Lsigma.q))
          "Stray reluctance equivalent to ideally coupled stray inductances"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              origin={0,20})));
      equation
        connect(port_p, electroMagneticConverter.port_p)
          annotation (Line(points={{-100,0},{-10,0}}, color={255,128,0}));
        connect(electroMagneticConverter.port_n, port_n)
          annotation (Line(points={{10,0},{100,0}}, color={255,128,0}));
        connect(ground.p, star.pin_n)
          annotation (Line(points={{50,-20},{40,-20}}, color={0,0,255}));
        connect(electroMagneticConverter.plug_n, resistor.plug_n) annotation (
            Line(
            points={{10,-20},{20,-20},{20,-60},{-20,-60}}, color={0,0,255}));
        connect(star.plug_p, electroMagneticConverter.plug_n) annotation (Line(
            points={{20,-20},{20,-20},{10,-20}}, color={0,0,255}));
        connect(thermalCollector.port_b, heatPortWinding) annotation (Line(
            points={{-40,-90},{-40,-100},{0,-100}}, color={191,0,0}));
        connect(resistor.heatPort, thermalCollector.port_a) annotation (Line(
            points={{-30,-50},{-40,-50},{-40,-70}}, color={191,0,0}));
        connect(electroMagneticConverter.plug_p, resistor.plug_p) annotation (
            Line(
            points={{-10,-20},{-20,-20},{-20,-40}}, color={0,0,255}));
        connect(strayReluctance.port_p, port_p) annotation (Line(
            points={{-10,20},{-30,20},{-30,0},{-100,0}}, color={255,128,0}));
        connect(strayReluctance.port_n, port_n) annotation (Line(
            points={{10,20},{30,20},{30,0},{100,0}}, color={255,128,0}));
        annotation (defaultComponentName="cage",
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={Ellipse(
                      extent={{-80,80},{80,-80}},
                      fillColor={175,175,175},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-20,76},{20,36}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{28,46},{68,6}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{28,-8},{68,-48}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-20,-36},{20,-76}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-68,-6},{-28,-46}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-66,50},{-26,10}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Line(points={{-80,0},{-100,
                0}}, color={255,128,0}),Line(points={{100,0},{80,0}}, color={
                255,128,0}),
                Text(
                    extent={{-150,100},{150,140}},
                    lineColor={0,0,255},
                    textString="%name")}),
          Documentation(info="<html>

<p>
The salient cage model is a two axis model with two phases. The electromagnetic coupling therefore is also two phase coupling model. The angles of the two orientations are 0 and <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/pi_over_2.png\">. This way an asymmetrical rotor cage with different resistances and stray inductances in d- and q-axis can be modeled.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding\">SymmetricMultiPhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding\">SymmetricMultiPhaseCageWinding</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
</p>
</html>"));
      end SaliencyCageWinding;

      model PermanentMagnet
        "Permanent magnet represented by magnetic potential difference"
        extends
          Modelica.Magnetic.FundamentalWave.Sources.ConstantMagneticPotentialDifference;
        extends
          Modelica.Electrical.Machines.Losses.InductionMachines.PermanentMagnetLosses;
        annotation (defaultComponentName="pm", Documentation(info="<html>
<p>
Simple model of a permanent magnet, containing:
</p>
<ul>
<li><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.ConstantMagneticPotentialDifference\">constant magnetomotive force</a></li>
<li><a href=\"modelica://Modelica.Electrical.Machines.Losses.InductionMachines.PermanentMagnetLosses\">loss model</a></li>
</ul>
<p>
The permanent magnet is modeled by a magnetic potential difference. The internal reluctance of the permanent magnet is not taken into account. The internal reluctance needs to be modeled outside the permanent magnet model, e.g., by the total machine reluctance considered in the air gap model.
</p>
</html>"));
      end PermanentMagnet;

      model SymmetricMultiPhaseCageWinding_obsolete "Symmetrical rotor cage"
        import Modelica.Constants.pi;
        extends Modelica.Icons.ObsoleteModel;
        extends
          Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortExtended;
        parameter Integer m=3 "Number of phases";
        parameter Boolean useHeatPort=false
          "Enable / disable (=fixed temperatures) thermal port"
          annotation (Evaluate=true);
        parameter Modelica.SIunits.Resistance RRef
          "Winding resistance per phase at TRef";
        parameter Modelica.SIunits.Temperature TRef(start=293.15)
          "Reference temperature of winding";
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20(start=0) "Temperature coefficient of winding at 20 degC";
        final parameter Modelica.SIunits.LinearTemperatureCoefficient alphaRef=
            Modelica.Electrical.Machines.Thermal.convertAlpha(
                  alpha20,
                  TRef,
                  293.15);
        parameter Modelica.SIunits.Temperature TOperational(start=293.15)
          "Operational temperature of winding"
          annotation (Dialog(enable=not useHeatPort));
        parameter Modelica.SIunits.Inductance Lsigma "Cage stray inductance";
        parameter Real effectiveTurns=1 "Effective number of turns";
        Modelica.SIunits.Current i[m]=strayInductor.i "Cage currents";
        Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
          winding(
          final m=m,
          final effectiveTurns=fill(effectiveTurns, m),
          final orientation=
              Modelica.Electrical.MultiPhase.Functions.symmetricOrientation(m))
          "Symmetric winding" annotation (Placement(transformation(
              origin={0,-10},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Inductor strayInductor(final m=m,
            final L=fill(Lsigma, m)) annotation (Placement(transformation(
              origin={-20,-30},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Resistor resistor(
          final useHeatPort=useHeatPort,
          final m=m,
          final R=fill(RRef, m),
          final T_ref=fill(TRef, m),
          final alpha=fill(alphaRef, m),
          final T=fill(TOperational, m)) annotation (Placement(transformation(
              origin={-20,-70},
              extent={{10,10},{-10,-10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=m) annotation (
            Placement(transformation(extent={{30,-30},{50,-10}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={70,-20},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding if
          useHeatPort "Heat ports of winding resistor"
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
        Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(
            final m=m) if useHeatPort
          "Connector of thermal rotor resistance heat ports"
          annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
        Modelica.Electrical.MultiPhase.Basic.Star starAuxiliary(final m=m)
          annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
      equation
        connect(port_p, winding.port_p)
          annotation (Line(points={{-100,0},{-10,0}}, color={255,128,0}));
        connect(winding.port_n, port_n) annotation (Line(points={{10,0},
                {100,0}}, color={255,128,0}));
        connect(ground.p, star.pin_n) annotation (Line(points={{60,-20},{56,-20},
                {50,-20}}, color={0,0,255}));
        connect(strayInductor.plug_n, resistor.plug_p)
          annotation (Line(points={{-20,-40},{-20,-60}}, color={0,0,255}));
        connect(strayInductor.plug_p, winding.plug_p) annotation (Line(
            points={{-20,-20},{-10,-20}}, color={0,0,255}));
        connect(star.plug_p, winding.plug_n) annotation (Line(
            points={{30,-20},{10,-20}}, color={0,0,255}));
        connect(thermalCollector.port_a, resistor.heatPort) annotation (Line(
            points={{-40,-70},{-30,-70}}, color={191,0,0}));
        connect(thermalCollector.port_b, heatPortWinding) annotation (Line(
            points={{-40,-90},{-40,-100},{0,-100}}, color={191,0,0}));
        connect(resistor.plug_n, starAuxiliary.plug_p) annotation (Line(
            points={{-20,-80},{30,-80}}, color={0,0,255}));
        annotation (defaultComponentName="cage", obsolete="Wrong structure of multi phase cage, see #1536 (https://github.com/modelica/ModelicaStandardLibrary/issues/1536)",
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}), graphics={Ellipse(
                      extent={{-80,80},{80,-80}},
                      fillColor={175,175,175},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-20,76},{20,36}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{28,46},{68,6}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{28,-8},{68,-48}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-20,-36},{20,-76}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-68,-6},{-28,-46}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-66,50},{-26,10}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Line(points={{-80,0},{-100,
                0}}, color={255,128,0}),Line(points={{100,0},{80,0}}, color={
                255,128,0}),Text(
                      extent={{0,100},{0,140}},
                      lineColor={0,0,255},
                      textString="%name")}),
          Documentation(info="<html>
<p>
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Machines/Components/rotorcage.png\">
</p>
<p>
The symmetric rotor cage model of this library does not consist of rotor bars and end rings. Instead the symmetric cage is modeled by an equivalent symmetrical winding. The rotor cage model consists of
<img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/m.png\"> phases. If the cage is modeled by equivalent stator winding parameters, the number of effective turns, <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/effectiveTurns.png\">, has to be chosen equivalent to the effective number of stator turns.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding\">SymmetricMultiPhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SaliencyCageWinding\">SaliencyCageWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
</p>
</html>"));
      end SymmetricMultiPhaseCageWinding_obsolete;

      model SaliencyCageWinding_obsolete
        "Rotor cage with saliency in d- and q-axis"
        extends Modelica.Icons.ObsoleteModel;
        extends
          Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortExtended;
        parameter Boolean useHeatPort=false
          "Enable / disable (=fixed temperatures) thermal port"
          annotation (Evaluate=true);
        parameter Modelica.Magnetic.FundamentalWave.Types.SalientResistance
          RRef(d(start=1), q(start=1)) "Salient cage resistance";
        parameter Modelica.SIunits.Temperature TRef(start=293.15)
          "Reference temperature of winding";
        parameter
          Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20(start=0) "Temperature coefficient of winding at 20 degC";
        final parameter Modelica.SIunits.LinearTemperatureCoefficient alphaRef=
            Modelica.Electrical.Machines.Thermal.convertAlpha(
                  alpha20,
                  TRef,
                  293.15);
        parameter Modelica.SIunits.Temperature TOperational(start=293.15)
          "Operational temperature of winding"
          annotation (Dialog(enable=not useHeatPort));
        parameter Modelica.Magnetic.FundamentalWave.Types.SalientInductance
          Lsigma(d(start=1), q(start=1)) "Salient cage stray inductance";
        parameter Real effectiveTurns=1 "Effective number of turns";
        Modelica.Blocks.Interfaces.RealOutput i[2](
          each final quantity="ElectricCurrent",
          each final unit="A") = resistor.i "Currents out from damper";
        Modelica.Blocks.Interfaces.RealOutput lossPower(
          final quantity="Power",
          final unit="W") = sum(resistor.resistor.LossPower) "Damper losses";
        Modelica.Magnetic.FundamentalWave.Components.MultiPhaseElectroMagneticConverter
          winding(
          final m=2,
          final orientation={0,Modelica.Constants.pi/2},
          final effectiveTurns=fill(effectiveTurns, 2)) "Symmetric winding"
          annotation (Placement(transformation(
              origin={0,-10},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Inductor strayInductor(final m=2,
            final L={Lsigma.d,Lsigma.q}) annotation (Placement(transformation(
              origin={-20,-30},
              extent={{10,-10},{-10,10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Resistor resistor(
          final useHeatPort=useHeatPort,
          final m=2,
          final R={RRef.d,RRef.q},
          final T_ref=fill(TRef, 2),
          final alpha=fill(alphaRef, 2),
          final T=fill(TOperational, 2)) annotation (Placement(transformation(
              origin={-20,-70},
              extent={{10,10},{-10,-10}},
              rotation=90)));
        Modelica.Electrical.MultiPhase.Basic.Star star(final m=2) annotation (
            Placement(transformation(extent={{30,-90},{50,-70}})));
        Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(
              transformation(
              origin={70,-80},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortWinding if
          useHeatPort "Heat ports of winding resistor"
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
        Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(
            final m=2) if useHeatPort
          "Connector of thermal rotor resistance heat ports"
          annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
      equation
        connect(port_p, winding.port_p)
          annotation (Line(points={{-100,0},{-10,0}}, color={255,128,0}));
        connect(winding.port_n, port_n)
          annotation (Line(points={{10,0},{100,0}}, color={255,128,0}));
        connect(ground.p, star.pin_n)
          annotation (Line(points={{60,-80},{50,-80}}, color={0,0,255}));
        connect(strayInductor.plug_n, resistor.plug_p)
          annotation (Line(points={{-20,-40},{-20,-60}}, color={0,0,255}));
        connect(winding.plug_n, resistor.plug_n) annotation (Line(
            points={{10,-20},{20,-20},{20,-80},{-20,-80}}, color={0,0,255}));
        connect(star.plug_p, winding.plug_n) annotation (Line(
            points={{30,-80},{20,-80},{20,-20},{10,-20}}, color={0,0,255}));
        connect(strayInductor.plug_p, winding.plug_p) annotation (Line(
            points={{-20,-20},{-10,-20}}, color={0,0,255}));
        connect(thermalCollector.port_b, heatPortWinding) annotation (Line(
            points={{-40,-90},{-40,-100},{0,-100}}, color={191,0,0}));
        connect(resistor.heatPort, thermalCollector.port_a) annotation (Line(
            points={{-30,-70},{-40,-70}}, color={191,0,0}));
        annotation (defaultComponentName="cage", obsolete="Wrong structure of saliency cage, see #1536 (https://github.com/modelica/ModelicaStandardLibrary/issues/1536)",
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics={Ellipse(
                      extent={{-80,80},{80,-80}},
                      fillColor={175,175,175},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-20,76},{20,36}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{28,46},{68,6}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{28,-8},{68,-48}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-20,-36},{20,-76}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-68,-6},{-28,-46}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Ellipse(
                      extent={{-66,50},{-26,10}},
                      fillColor={255,255,255},
                      fillPattern=FillPattern.Solid),Line(points={{-80,0},{-100,
                0}}, color={255,128,0}),Line(points={{100,0},{80,0}}, color={
                255,128,0}),Text(
                      extent={{0,100},{0,140}},
                      lineColor={0,0,255},
                      textString="%name")}), Documentation(info="<html>

<p>
The salient cage model is a two axis model with two phases. The electromagnetic coupling therefore is also two phase coupling model. The angles of the two orientations are 0 and <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/pi_over_2.png\">. This way an asymmetrical rotor cage with different resistances and stray inductances in d- and q-axis can be modeled.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SinglePhaseWinding\">SinglePhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseWinding\">SymmetricMultiPhaseWinding</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.SymmetricMultiPhaseCageWinding\">SymmetricMultiPhaseCageWinding</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap\">RotorSaliencyAirGap</a>
</p>
</html>"));
      end SaliencyCageWinding_obsolete;
    end Components;
    annotation (Documentation(info="<html>
<p>
This package contains electric machine models and
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.BasicMachines.Components\">components</a>
for electric machines.
</p>
</html>"));
  end BasicMachines;

  package Sources "Sources"
    extends Modelica.Icons.SourcesPackage;
    model ConstantMagneticPotentialDifference
      "Source with constant magnetic potential difference"
      extends Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPort;
      parameter Modelica.SIunits.ComplexMagneticPotentialDifference V_m=Complex(
          re=1, im=0) "Complex magnetic potential difference";
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";

      Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";
      Modelica.SIunits.MagneticPotentialDifference abs_Phi=
          Modelica.ComplexMath.'abs'(Phi) "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";
    equation
      // Flux into positive port
      port_p.V_m - port_n.V_m = V_m;
      // Magnetomotive force
      port_p.Phi = Phi;
      // Local flux balance
      port_p.Phi + port_n.Phi = Complex(0, 0);
      annotation (defaultComponentName="magVoltageSource", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
                                  Ellipse(
                  extent={{-50,-50},{50,50}},
                  lineColor={255,128,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{100,0},{50,0}},
              color={255,128,0}),Line(points={{-50,0},{-100,0}}, color={255,128,0}),
              Line(points={{-50,0},{50,0}}, color={255,128,0}),
              Text(
                  extent={{-150,70},{150,110}},
                  lineColor={0,0,255},
                  textString="%name"),
            Line(points={{-80,20},{-60,20}}, color={255,128,0}),
            Line(points={{-70,30},{-70,10}}, color={255,128,0}),
            Line(points={{60,20},{80,20}}, color={255,128,0})}),
                                          Documentation(info="<html>
<p>
Source of constant magnetomotive force.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.SignalMagneticPotentialDifference\">SignalMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.ConstantFlux\">ConstantFlux</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.SignalFlux\">SignalFlux</a>
</p>
</html>"));
    end ConstantMagneticPotentialDifference;

    model SignalMagneticPotentialDifference
      "Source of magnetic potential difference with signal input"
      extends Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPort;
      Modelica.ComplexBlocks.Interfaces.ComplexInput V_m
        "Complex signal input of magnetic potential difference" annotation (
          Placement(transformation(
            origin={0,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";

      Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";
      Modelica.SIunits.MagneticPotentialDifference abs_Phi=
          Modelica.ComplexMath.'abs'(Phi) "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";
    equation
      // Flux into positive port
      port_p.V_m - port_n.V_m = V_m;
      // Magnetomotive force
      port_p.Phi = Phi;
      // Local flux balance
      port_p.Phi + port_n.Phi = Complex(0, 0);
      annotation (defaultComponentName="magVoltageSource", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
                                  Ellipse(
                  extent={{-50,-50},{50,50}},
                  lineColor={255,128,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{100,0},{50,0}},
              color={255,128,0}),Line(points={{-50,0},{-100,0}}, color={255,128,0}),
              Line(points={{-50,0},{50,0}}, color={255,128,0}),Line(points=
              {{0,100},{0,50}}, color={255,128,0}),
              Text(
                  extent={{-150,-100},{150,-60}},
                  lineColor={0,0,255},
                  textString="%name"),
            Line(points={{-80,20},{-60,20}}, color={255,128,0}),
            Line(points={{-70,30},{-70,10}}, color={255,128,0}),
            Line(points={{60,20},{80,20}}, color={255,128,0})}),
                                          Documentation(info="<html>
<p>
Source of magnetomotive force with complex signal input.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.ConstantMagneticPotentialDifference\">ConstantMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.ConstantFlux\">ConstantFlux</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.SignalFlux\">SignalFlux</a>
</p>

</html>"));
    end SignalMagneticPotentialDifference;

    model ConstantFlux "Source of constant magnetic flux"
      extends Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPort;
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m
        "Complex magnetic potential difference";
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";
      parameter Modelica.SIunits.ComplexMagneticFlux Phi=Complex(re=1, im=0)
        "Complex magnetic flux";
      Modelica.SIunits.MagneticPotentialDifference abs_Phi=
          Modelica.ComplexMath.'abs'(Phi) "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";

    equation
      // Flux into positive port
      port_p.V_m - port_n.V_m = V_m;
      // Magnetomotive force
      port_p.Phi = Phi;
      // Local flux balance
      port_p.Phi + port_n.Phi = Complex(0, 0);
      annotation (defaultComponentName="magFluxSource", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Ellipse(
                  extent={{-50,-50},{50,50}},
                  lineColor={255,128,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{100,0},{50,0}},
              color={255,128,0}),Line(points={{-50,0},{-100,0}}, color={255,128,0}),
              Line(points={{0,50},{0,-50}}, color={255,128,0}),Polygon(
                  points={{80,0},{60,6},{60,-6},{80,0}},
                  lineColor={255,128,0},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.Solid),
              Text(
                  extent={{-150,70},{150,110}},
                  lineColor={0,0,255},
                  textString="%name")}),  Documentation(info="<html>
<p>
Source of constant magnetic flux.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.ConstantMagneticPotentialDifference\">
   ConstantMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.SignalMagneticPotentialDifference\">
   SignalMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.SignalFlux\">SignalFlux</a>
</p>

</html>"));
    end ConstantFlux;

    model SignalFlux "Source of time varying magnetic flux"
      extends Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPort;
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m
        "Complex magnetic potential difference";
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";

      Modelica.ComplexBlocks.Interfaces.ComplexInput Phi
        "Complex signal input of magnetic flux" annotation (Placement(
            transformation(
            origin={0,100},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      Modelica.SIunits.MagneticPotentialDifference abs_Phi=
          Modelica.ComplexMath.'abs'(Phi) "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";

    equation
      // Flux into positive port
      port_p.V_m - port_n.V_m = V_m;
      // Magnetomotive force
      port_p.Phi = Phi;
      // Local flux balance
      port_p.Phi + port_n.Phi = Complex(0, 0);
      annotation (defaultComponentName="magFluxSource", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Ellipse(
                  extent={{-50,-50},{50,50}},
                  lineColor={255,128,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{100,0},{50,0}},
              color={255,128,0}),Line(points={{-50,0},{-100,0}}, color={255,128,0}),
              Line(points={{0,50},{0,-50}}, color={255,128,0}),Polygon(
                  points={{80,0},{60,6},{60,-6},{80,0}},
                  lineColor={255,128,0},
                  fillColor={255,128,0},
                  fillPattern=FillPattern.Solid),Line(points={{0,100},{0,50}},
              color={255,128,0}),
              Text(
                  extent={{-150,-100},{150,-60}},
                  lineColor={0,0,255},
                  textString="%name")}),  Documentation(info="<html>
<p>
Source of magnetic flux with complex signal input.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.ConstantMagneticPotentialDifference\">
   ConstantMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.SignalMagneticPotentialDifference\">
   SignalMagneticPotentialDifference</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sources.ConstantFlux\">ConstantFlux</a>,
</p>

</html>"));
    end SignalFlux;
    annotation (Documentation(info="<html>
<p>This package provides sources of magnetic potential difference and magnetic flux.</p>
</html>"));
  end Sources;

  package Sensors "Sensors to measure variables in magnetic networks"
    extends Modelica.Icons.SensorsPackage;
    model MagneticFluxSensor "Sensor to measure magnetic flux"
      extends Modelica.Icons.RotationalSensor;
      extends Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPort;
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m
        "Complex magnetic potential difference";
      Modelica.ComplexBlocks.Interfaces.ComplexOutput Phi
        "Complex magnetic flux from por_ p to port_n as output signal"
        annotation (Placement(transformation(
            origin={0,-100},
            extent={{10,-10},{-10,10}},
            rotation=90)));
    equation
      // Flux into positive port
      port_p.V_m - port_n.V_m = V_m;
      // Magnetomotive force
      port_p.Phi = Phi;
      // Local flux balance
      port_p.Phi + port_n.Phi = Complex(0, 0);
      // No magnetic potential difference at sensor
      V_m = Complex(0, 0);
      annotation (defaultComponentName="magFluxSensor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-29,-11},{30,-70}},
                  textString="Phi"),Line(points={{-72,0},{-90,0}}),
              Text(
                  extent={{-140,120},{140,80}},
                  textString="%name",
                  lineColor={0,0,255}),Line(points={{70,0},{90,0}}),
              Line(points={{0,-90},{0,-70}})}), Documentation(info="<html>
<p>Sensor for magnetic flux.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sensors.MagneticPotentialDifferenceSensor\">MagneticPotentialDifferenceSensor</a>
</p>
</html>"));
    end MagneticFluxSensor;

    model MagneticPotentialDifferenceSensor
      "Sensor to measure magnetic potential difference"
      extends Modelica.Icons.RotationalSensor;
      extends Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPort;
      Modelica.ComplexBlocks.Interfaces.ComplexOutput V_m
        "Complex magnetic potential difference between port_p and port_n as output signal"
        annotation (Placement(transformation(
            origin={0,-100},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";
    equation
      // Flux into positive port
      port_p.V_m - port_n.V_m = V_m;
      // Magnetomotive force
      port_p.Phi = Phi;
      // Local flux balance
      port_p.Phi + port_n.Phi = Complex(0, 0);
      // No magnetic flux through sensor
      Phi = Complex(0, 0);
      annotation (defaultComponentName="magVoltageSensor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-52,1},{48,-57}},
                  textString="V_m"),Line(points={{-70,0},{-90,0}}),
              Line(points={{70,0},{90,0}}),Line(points={{0,-90},
              {0,-70}}),Text(
                  extent={{-140,120},{140,80}},
                  textString="%name",
                  lineColor={0,0,255})}), Documentation(info="<html>
<p>Sensor for magnetic potential difference.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sensors.MagneticFluxSensor\">MagneticFluxSensor</a>
</p></html>"));
    end MagneticPotentialDifferenceSensor;

    model MagneticPotentialSensor "Sensor to measure magnetic potential"
      extends Modelica.Icons.RotationalSensor;
      Modelica.ComplexBlocks.Interfaces.ComplexOutput V_m
        "Complex magnetic potential as output signal" annotation (Placement(
            transformation(
            origin={0,-100},
            extent={{10,-10},{-10,10}},
            rotation=90)));
      Interfaces.PositiveMagneticPort port_p "Magnetic connector of sensor"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    equation
      // No magnetic flux through sensor
      port_p.Phi = Complex(0, 0);
      // Magnetic potential
      V_m = port_p.V_m;
      annotation (defaultComponentName="magPotentialSensor", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Text(
                  extent={{-52,1},{48,-57}},
                  textString="V_m"),Line(points={{-70,0},{-90,0}}),
              Line(points={{0,-90},{0,-70}}),Text(
                  extent={{-140,120},{140,80}},
                  textString="%name",
                  lineColor={0,0,255})}), Documentation(info="<html>
<p>Sensor for magnetic potential difference.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Sensors.MagneticFluxSensor\">MagneticFluxSensor</a>
</p></html>"));
    end MagneticPotentialSensor;
    annotation (Documentation(info="<html>
<p>
This package provides sensors for the magnetic potential difference and the magnetic flux in magnetic circuit.
</p>
</html>"));
  end Sensors;

  package Interfaces "Interfaces and partial models"
    extends Modelica.Icons.InterfacesPackage;
    connector MagneticPort "Magnetic port of fundamental wave machines"
      Modelica.SIunits.ComplexMagneticPotential V_m
        "Complex magnetic potential at the port";
      flow Modelica.SIunits.ComplexMagneticFlux Phi
        "Complex magnetic flux into the port";
      annotation (Documentation(info="<html>
<p>
The potential quantity of the magnetic port is the complex magnetic potential difference <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/V_m.png\">. The corresponding flow quantity is the magnetic flux <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/Phi.png\">.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>
</p>

</html>"));
    end MagneticPort;

    connector NegativeMagneticPort "Negative magnetic port of fundamental wave machines"
      extends Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort;
      annotation (
        defaultComponentName="port_n",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{-60,100},{-60,60}},
              lineColor={255,128,0},
              textString="%name"), Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={255,128,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
Negative magnetic <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">port</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">MagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>
</p>
</html>"));
    end NegativeMagneticPort;

    connector PositiveMagneticPort "Positive magnetic port of fundamental wave machines"
      extends Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort;
      annotation (
        defaultComponentName="port_p",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Text(
              extent={{-60,100},{-60,60}},
              lineColor={255,128,0},
              textString="%name"), Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={255,128,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
Positive magnetic <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">port</a>.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.MagneticPort\">MagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>
</p>

</html>"));
    end PositiveMagneticPort;

    partial model PartialTwoPort "Two magnetic ports for graphical modeling"
      PositiveMagneticPort port_p "Positive magnetic port of fundamental wave machines" annotation (
          Placement(transformation(extent={{-110,-10},{-90,10}})));
      NegativeMagneticPort port_n "Negative magnetic port of fundamental wave machines" annotation (
          Placement(transformation(extent={{90,-10},{110,10}})));
      annotation (Documentation(info="<html>
<p>
This magnetic two port element consists of a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">positive</a> and a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">negative magnetic port</a> and
considers the flux balance of the two ports. Additionally the magnetic potential difference (of the positive and the negative port) and the magnetic flux (into the positive magnetic port) are defined. This model is mainly to used to extend from in order build more complex - graphical - models.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortExtended\">PartialTwoPortExtended</a>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortElementary\">PartialTwoPortElementary</a>
</p></html>"));
    end PartialTwoPort;

    partial model PartialTwoPortExtended
      "Two magnetic ports for graphical modeling with additional variables"
      extends Interfaces.PartialTwoPort;
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m=port_p.V_m -
          port_n.V_m "Complex magnetic potential difference";
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";

      Modelica.SIunits.ComplexMagneticFlux Phi=port_p.Phi
        "Complex magnetic flux";
      Modelica.SIunits.MagneticFlux abs_Phi=Modelica.ComplexMath.'abs'(Phi)
        "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";

      annotation (Documentation(info="<html>
<p>This magnetic two port element consists of a <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">positive</a> and a <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">negative magnetic port</a> and some additionally variables, but no physical balance equations.</p>
<h4>See also</h4>
<p><a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>, <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>, <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPort\">PartialTwoPort</a>, <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortElementary\">PartialTwoPortElementary</a></p>
</html>"));
    end PartialTwoPortExtended;

    partial model PartialTwoPortElementary
      "Two magnetic ports for textual modeling"
      extends Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPort;
      Modelica.SIunits.ComplexMagneticPotentialDifference V_m
        "Complex magnetic potential difference";
      Modelica.SIunits.MagneticPotentialDifference abs_V_m=
          Modelica.ComplexMath.'abs'(V_m)
        "Magnitude of complex magnetic potential difference";
      Modelica.SIunits.Angle arg_V_m=Modelica.ComplexMath.arg(V_m)
        "Argument of complex magnetic potential difference";

      Modelica.SIunits.ComplexMagneticFlux Phi "Complex magnetic flux";
      Modelica.SIunits.MagneticFlux abs_Phi=Modelica.ComplexMath.'abs'(Phi)
        "Magnitude of complex magnetic flux";
      Modelica.SIunits.Angle arg_Phi=Modelica.ComplexMath.arg(Phi)
        "Argument of complex magnetic flux";
    equation
      // Flux into positive port
      V_m = port_p.V_m - port_n.V_m;
      // Magnetomotive force
      port_p.Phi = Phi;
      // Local flux balance
      port_p.Phi + port_n.Phi = Complex(0, 0);
      annotation (Documentation(info="<html>
<p>
This magnetic two port element only consists of a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">positive</a> and a
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">negative magnetic port</a>.
This model is mainly used to extend from in order build more complex - equation based - models.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort\">PositiveMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort\">NegativeMagneticPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPort\">PartialTwoPort</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Interfaces.PartialTwoPortExtended\">PartialTwoPortExtended</a>
</p>
</html>"));
    end PartialTwoPortElementary;

    partial model PartialBasicInductionMachine
      "Partial model for induction machine"
      constant Modelica.SIunits.Angle pi = Modelica.Constants.pi;
      extends Modelica.Electrical.Machines.Icons.FundamentalWaveMachine;
      parameter Integer m(min=3) = 3 "Number of stator phases";
      // Mechanical parameters
      parameter Modelica.SIunits.Inertia Jr(start=0.29) "Rotor inertia";
      parameter Boolean useSupport=false
        "Enable / disable (=fixed stator) support" annotation (Evaluate=true);
      parameter Modelica.SIunits.Inertia Js(start=Jr) "Stator inertia"
        annotation (Dialog(enable=useSupport));
      parameter Boolean useThermalPort=false
        "Enable / disable (=fixed temperatures) thermal port"
        annotation (Evaluate=true);
      parameter Integer p(min=1, start=2) "Number of pole pairs (Integer)";
      parameter Modelica.SIunits.Frequency fsNominal(start=50)
        "Nominal frequency";
      parameter Modelica.SIunits.Temperature TsOperational(start=293.15)
        "Operational temperature of stator resistance" annotation (Dialog(group=
             "Operational temperatures", enable=not useThermalPort));
      parameter Modelica.SIunits.Resistance Rs(start=0.03)
        "Stator resistance per phase at TRef"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Temperature TsRef(start=293.15)
        "Reference temperature of stator resistance"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter
        Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
        alpha20s(start=0)
        "Temperature coefficient of stator resistance at 20 degC"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Real effectiveStatorTurns=1 "Effective number of stator turns";
      parameter Modelica.SIunits.Inductance Lssigma(start=3*(1 - sqrt(1 -
            0.0667))/(2*pi*fsNominal)) "Stator stray inductance"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.SIunits.Inductance Lszero=Lssigma
        "Stator zero inductance"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.Magnetic.FundamentalWave.Types.SalientInductance L0(d(
            start=1), q(start=1)) "Salient inductance of an unchorded coil"
        annotation (Dialog(tab="Nominal resistances and inductances"));
      parameter Modelica.Electrical.Machines.Losses.FrictionParameters
        frictionParameters(wRef=2*pi*fsNominal/p)
        "Friction loss parameter record" annotation (Dialog(tab="Losses"));
      parameter Modelica.Electrical.Machines.Losses.CoreParameters
        statorCoreParameters(
        final m=m,
        wRef=2*pi*fsNominal/p,
        VRef(start=100))
        "Stator core loss parameter record; all parameters refer to stator side"
        annotation (Dialog(tab="Losses"));
      parameter Modelica.Electrical.Machines.Losses.StrayLoadParameters
        strayLoadParameters(IRef(start=100), wRef=2*pi*fsNominal/p)
        "Stray load loss parameter record" annotation (Dialog(tab="Losses"));
      // Mechanical quantities
      output Modelica.SIunits.Angle phiMechanical(start=0) = flange.phi -
        internalSupport.phi "Mechanical angle of rotor against stator";
      output Modelica.SIunits.AngularVelocity wMechanical(
        start=0,
        displayUnit="rev/min") = der(phiMechanical)
        "Mechanical angular velocity of rotor against stator";
      output Modelica.SIunits.Torque tauElectrical=inertiaRotor.flange_a.tau
        "Electromagnetic torque";
      output Modelica.SIunits.Torque tauShaft=-flange.tau "Shaft torque";
      replaceable output
        Modelica.Electrical.Machines.Interfaces.InductionMachines.PartialPowerBalanceInductionMachines
        powerBalance(
        final powerStator=Modelica.Electrical.MultiPhase.Functions.activePower(
            vs, is),
        final powerMechanical=wMechanical*tauShaft,
        final powerInertiaStator=inertiaStator.J*inertiaStator.a*inertiaStator.w,
        final powerInertiaRotor=inertiaRotor.J*inertiaRotor.a*inertiaRotor.w,
        final lossPowerStatorWinding=sum(stator.resistor.resistor.LossPower),
        final lossPowerStatorCore=stator.core.lossPower,
        final lossPowerStrayLoad=strayLoad.lossPower,
        final lossPowerFriction=friction.lossPower) "Power balance";

      // Stator voltages and currents
      output Modelica.SIunits.Voltage vs[m]=plug_sp.pin.v - plug_sn.pin.v
        "Stator instantaneous voltages";
      output Modelica.SIunits.Current is[m]=plug_sp.pin.i
        "Stator instantaneous currents";
      Modelica.Mechanics.Rotational.Interfaces.Flange_a flange "Shaft"
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertiaRotor(final J=Jr)
        annotation (Placement(transformation(
            origin={80,0},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a support if useSupport
        "Support at which the reaction torque is acting" annotation (Placement(
            transformation(extent={{90,-110},{110,-90}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertiaStator(final J=Js)
        annotation (Placement(transformation(
            origin={80,-100},
            extent={{10,10},{-10,-10}},
            rotation=180)));
      Modelica.Mechanics.Rotational.Components.Fixed fixed if (not useSupport)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={70,-90})));
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_sp(final m=m)
        "Positive plug of stator" annotation (Placement(transformation(extent={
                {50,90},{70,110}})));
      Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_sn(final m=m)
        "Negative plug of stator" annotation (Placement(transformation(extent={
                {-70,90},{-50,110}})));
      BasicMachines.Components.SymmetricMultiPhaseWinding stator(
        final useHeatPort=true,
        final m=m,
        final RRef=Rs,
        final TRef=TsRef,
        final Lsigma=Lssigma,
        final effectiveTurns=effectiveStatorTurns,
        final TOperational=TsOperational,
        final GcRef=statorCoreParameters.GcRef,
        final alpha20=alpha20s,
        final Lzero=Lszero)
        "Symmetric stator winding including resistances, zero and stray inductances and core losses"
        annotation (Placement(transformation(
            origin={0,40},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      replaceable
        Modelica.Electrical.Machines.Interfaces.InductionMachines.PartialThermalAmbientInductionMachines
        thermalAmbient(
        final useTemperatureInputs=false,
        final Ts=TsOperational,
        final m=m) if not useThermalPort annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-70,-90})));
      replaceable
        Modelica.Electrical.Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines
        thermalPort(final m=m) if useThermalPort
        "Thermal port of induction machines"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
      Modelica.Magnetic.FundamentalWave.Components.Ground groundS
        "Ground of stator magnetic circuit" annotation (Placement(
            transformation(extent={{-40,30},{-20,10}})));
      Modelica.Magnetic.FundamentalWave.BasicMachines.Components.RotorSaliencyAirGap
        airGap(final p=p, final L0=L0) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Magnetic.FundamentalWave.Components.Ground groundR
        "Ground of rotor magnetic circuit" annotation (Placement(transformation(
              extent={{-40,-30},{-20,-10}})));
      /* previously used: state selection, now commented
  FundamentalWave.Interfaces.StateSelector stateSelectorS(
    final m=m,
    final xi=is,
    final gamma=p*phiMechanical) "State selection of stator currents"
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  */
      Electrical.Machines.Losses.InductionMachines.StrayLoad strayLoad(
        final strayLoadParameters=strayLoadParameters,
        final useHeatPort=true,
        final m=m)
        annotation (Placement(transformation(extent={{60,60},{40,80}})));
      Electrical.Machines.Losses.Friction friction(final frictionParameters=
            frictionParameters, final useHeatPort=true) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            origin={90,-30})));
      replaceable
        Modelica.Electrical.Machines.Interfaces.InductionMachines.PartialThermalPortInductionMachines
        internalThermalPort(final m=m)
        annotation (Placement(transformation(extent={{-44,-94},{-36,-86}})));
      Modelica.Mechanics.Rotational.Interfaces.Support internalSupport
        annotation (Placement(transformation(extent={{56,-104},{64,-96}})));
    initial algorithm
      assert(not Modelica.Math.isPowerOf2(m), String(m) +
        " phases are currently not supported in this version of FundametalWave");

    equation
      connect(stator.plug_n, plug_sn) annotation (Line(
          points={{-10,50},{-10,70},{-60,70},{-60,100}}, color={0,0,255}));
      connect(inertiaRotor.flange_b, flange)
        annotation (Line(points={{90,0},{100,0},{100,0}}));
      connect(internalSupport, inertiaStator.flange_a) annotation (Line(
          points={{60,-100},{70,-100}}));
      connect(internalSupport, fixed.flange) annotation (Line(
          points={{60,-100},{60,-90},{70,-90}}));
      connect(inertiaStator.flange_b, support) annotation (Line(points={{90,-100},
              {90,-100},{100,-100}}));
      connect(airGap.flange_a, inertiaRotor.flange_a) annotation (Line(
          points={{10,0},{25,0},{25,0},{40,0},{40,0},{70,0}}));
      connect(airGap.support, internalSupport) annotation (Line(
          points={{-10,0},{-50,0},{-50,-70},{60,-70},{60,-100}}));
      connect(groundR.port_p, airGap.port_rn)
        annotation (Line(points={{-30,-10},{-10,-10}}, color={255,128,0}));
      connect(stator.plug_p, strayLoad.plug_n) annotation (Line(
          points={{10,50},{10,70},{40,70}}, color={0,0,255}));
      connect(plug_sp, strayLoad.plug_p) annotation (Line(
          points={{60,100},{60,70}}, color={0,0,255}));
      connect(strayLoad.support, internalSupport) annotation (Line(
          points={{50,60},{50,50},{60,50},{60,-100}}));
      connect(strayLoad.heatPort, internalThermalPort.heatPortStrayLoad)
        annotation (Line(
          points={{60,60},{60,50},{50,50},{50,-80},{-39.6,-80},{-39.6,-90}}, color={191,0,0}));
      connect(friction.support, internalSupport) annotation (Line(
          points={{90,-40},{90,-70},{60,-70},{60,-100}}));
      connect(strayLoad.flange, inertiaRotor.flange_b) annotation (Line(
          points={{50,80},{90,80},{90,0}}));
      connect(friction.flange, inertiaRotor.flange_b) annotation (Line(
          points={{90,-20},{90,0}}));
      connect(friction.heatPort, internalThermalPort.heatPortFriction)
        annotation (Line(
          points={{80,-40},{50,-40},{50,-80},{-40,-80},{-40,-91.6}}, color={191,0,0}));
      connect(groundS.port_p, airGap.port_sp) annotation (Line(
          points={{-30,10},{-10,10}}, color={255,128,0}));
      connect(stator.port_n, airGap.port_sp) annotation (Line(
          points={{-10,30},{-10,10}}, color={255,128,0}));
      connect(stator.port_p, airGap.port_sn) annotation (Line(
          points={{10,30},{10,10}}, color={255,128,0}));
      connect(stator.heatPortWinding, internalThermalPort.heatPortStatorWinding)
        annotation (Line(
          points={{-10,44},{-40.4,44},{-40.4,-89.2}}, color={191,0,0}));
      connect(stator.heatPortCore, internalThermalPort.heatPortStatorCore)
        annotation (Line(
          points={{-10,36},{-39.6,36},{-39.6,-89.2}}, color={191,0,0}));
      connect(thermalAmbient.thermalPort, internalThermalPort) annotation (Line(
            points={{-60,-90},{-50,-90},{-40,-90}}, color={191,0,0}));
      connect(internalThermalPort, thermalPort) annotation (Line(points={{-40,
              -90},{0,-90},{0,-100}}, color={191,0,0}));
      annotation (Documentation(info="<html>
<p>This partial model for induction machines contains elements common in all machine models.</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),graphics={
            Rectangle(
              extent={{80,-80},{120,-120}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-50,100},{-20,100},{-20,70}}, color={0,0,255}),
            Line(points={{50,100},{20,100},{20,70}}, color={0,0,255}),
            Text(
              extent={{-150,-120},{150,-160}},
              lineColor={0,0,255},
              textString="%name"),
            Line(
              visible=not useSupport,
              points={{80,-100},{120,-100}}),
            Line(
              visible=not useSupport,
              points={{90,-100},{80,-120}}),
            Line(
              visible=not useSupport,
              points={{100,-100},{90,-120}}),
            Line(
              visible=not useSupport,
              points={{110,-100},{100,-120}}),
            Line(
              visible=not useSupport,
              points={{120,-100},{110,-120}})}));
    end PartialBasicInductionMachine;

    model StateSelector
      "Transform instantaneous values to space phasors and select states"
      import Modelica.Constants.pi;
      parameter Integer m(min=3) = 3 "Number of phases";
      input Real xi[m](each stateSelect=StateSelect.avoid)
        "Instantaneous values" annotation (Dialog);
      input Modelica.SIunits.Angle gamma "Angle of rotation" annotation (Dialog);
      parameter StateSelect x0StateSelect=StateSelect.prefer
        "Priority to use zero systems as states";
      parameter StateSelect xrStateSelect=StateSelect.prefer
        "Priority to use space phasors w.r.t. rotating frame as states";
      Real x0(stateSelect=x0StateSelect) = 1/sqrt(m)*sum(xi) "Zero system";
      Real x00(stateSelect=x0StateSelect) = 1/sqrt(m)*sum({xi[2*l - 1] - xi[2*l]
        for l in 1:integer(m/2)}) if m == 2*integer(m/2)
        "Second zero system, if present (mp even)";
      final parameter Integer np=integer((m - 1)/2) "Number of space phasors";
      Complex xf[np](each re(stateSelect=StateSelect.avoid), each im(
            stateSelect=StateSelect.avoid)) "Space phasors w.r.t. fixed frame";
      Complex xr[np](each re(stateSelect=xrStateSelect), each im(stateSelect=
              xrStateSelect)) "Space phasors w.r.t. rotating frame";
    equation
      //space phasor transformations
      for k in 1:np loop
        xf[k].re = 1/sqrt(m)*sum({cos(k*(l - 1)*2*pi/m)*xi[l] for l in 1:m});
        xf[k].im = 1/sqrt(m)*sum({sin(k*(l - 1)*2*pi/m)*xi[l] for l in 1:m});
        xr[k] = xf[k]*Modelica.ComplexMath.conj(Modelica.ComplexMath.exp(
          Complex(0, gamma)));
      end for;
      annotation (Documentation(info="<html>
<p>
Transforms instantaneous values into space phasors and zero system currents,
rotates space phasors and sets stateSelect modifiers in order to choose states w.r.t. rotating frame,
i.e., with small derivatives.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={Ellipse(
                  extent={{-60,60},{60,-60}},
                  lineColor={170,213,255},
                  fillColor={170,213,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-60,60},{60,-60}},
                  textString="S",
                  lineColor={0,0,255}), Text(
                  extent={{0,-60},{0,-100}},
                  lineColor={0,0,255},
                  textString="%name")}));
    end StateSelector;

    model PositivePortInterface "Positive port interface to FluxTubes"

      Modelica.Magnetic.FundamentalWave.Interfaces.PositiveMagneticPort port
        "Magnetic port of fundamental wave machines"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_re
        "Magnetic port, real part"
        annotation (Placement(transformation(extent={{90,90},{110,110}})));
      Modelica.Magnetic.FluxTubes.Interfaces.PositiveMagneticPort port_im
        "Magnetic port, imaginary part"
        annotation (Placement(transformation(extent={{90,-108},{110,-88}})));
    equation
      port.V_m.re = port_re.V_m;
      port.V_m.im = port_im.V_m;
      port.Phi.re + port_re.Phi = 0;
      port.Phi.im + port_im.Phi = 0;

      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Line(
                  points={{-100,0},{0,0},{100,100}},
                  color={255,128,0}),Line(
                  points={{0,0},{100,-100}},
                  color={255,128,0}),Text(
                  extent={{80,80},{120,40}},
                  lineColor={255,128,0},
                  textString="re"),Text(
                  extent={{80,-40},{120,-80}},
                  lineColor={255,128,0},
                  textString="im")}),
        Documentation(info="<html>
<p>Connects a FundamentalWave port with a real and imaginary part FluxTube port.</p>
</html>"));
    end PositivePortInterface;

    model NegativePortInterface "Negative port interface to FluxTubes"

      Modelica.Magnetic.FundamentalWave.Interfaces.NegativeMagneticPort port
        "Magnetic port of fundamental wave machines"
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort port_re
        "Magnetic port, real part"
        annotation (Placement(transformation(extent={{90,90},{110,110}})));
      Modelica.Magnetic.FluxTubes.Interfaces.NegativeMagneticPort port_im
        "Magnetic port, imaginary part"
        annotation (Placement(transformation(extent={{90,-108},{110,-88}})));
    equation
      port.V_m.re = port_re.V_m;
      port.V_m.im = port_im.V_m;
      port.Phi.re + port_re.Phi = 0;
      port.Phi.im + port_im.Phi = 0;

      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}}), graphics={Line(
                  points={{-100,0},{0,0},{100,100}},
                  color={255,128,0}),Line(
                  points={{0,0},{100,-100}},
                  color={255,128,0}),Text(
                  extent={{80,80},{120,40}},
                  lineColor={255,128,0},
                  textString="re"),Text(
                  extent={{80,-40},{120,-80}},
                  lineColor={255,128,0},
                  textString="im")}),
        Documentation(info="<html>
<p>Connects a FundamentalWave port with a real and imaginary part FluxTube port.</p>
</html>"));
    end NegativePortInterface;
    annotation (Documentation(info="<html>
<p>
This package contains interface definitions of the magnetic ports as well as partial models.
</p>
</html>"));
  end Interfaces;

  package Types "Definition of salient types"
    extends Modelica.Icons.TypesPackage;
    record Salient "Base record of saliency with d and q component"
      replaceable Real d "Component of d (direct) axis, aligned to real part";
      replaceable Real q
        "Component of q (quadrature) axis, aligned to imaginary part";
      annotation (Documentation(info="<html>
<p>
Definition of saliency with respect to the orthogonal d- and q-axis. Saliency, however, refers to different properties in d- and q-axis and thus considers the anisotropic behavior.
</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientCurrent\">SalientCurrent</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientVoltage\">SalientVoltage</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientInductance\">SalientInductance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientReluctance\">SalientReluctance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientResistance\">SalientResistance</a>
</p>

</html>"));
    end Salient;

    record SalientCurrent = Salient (redeclare Modelica.SIunits.Current d,
          redeclare Modelica.SIunits.Current q) "Salient current" annotation (
        Documentation(info="<html>
<p>Type representing the d- and q-axis of a current phasor.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.Salient\">Salient</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientVoltage\">SalientVoltage</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientResistance\">SalientResistance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientInductance\">SalientInductance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientReluctance\">SalientReluctance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientPermeance\">SalientPermeance</a>
</p>

</html>"));
    record SalientVoltage = Salient (redeclare Modelica.SIunits.Voltage d,
          redeclare Modelica.SIunits.Voltage q) "Salient voltage" annotation (
        Documentation(info="<html>
<p>Type representing the d- and q-axis of a voltage phasor.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.Salient\">Salient</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientCurrent\">SalientCurrent</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientResistance\">SalientResistance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientInductance\">SalientInductance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientReluctance\">SalientReluctance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientPermeance\">SalientPermeance</a>
</p>

</html>"));
    record SalientResistance = Salient (redeclare Modelica.SIunits.Resistance d,
          redeclare Modelica.SIunits.Resistance q) "Salient resistance"
      annotation (Documentation(info="<html>
<p>Type representing the d- and q-axis of an resistance with respect to the fundamental wave.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.Salient\">Salient</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientCurrent\">SalientCurrent</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientVoltage\">SalientVoltage</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientInductance\">SalientInductance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientReluctance\">SalientReluctance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientPermeance\">SalientPermeance</a>
</p>

</html>"));
    record SalientInductance = Salient (redeclare Modelica.SIunits.Inductance d,
          redeclare Modelica.SIunits.Inductance q) "Salient inductance"
      annotation (Documentation(info="<html>
<p>Type representing the d- and q-axis of an inductance with respect to the fundamental wave.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.Salient\">Salient</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientCurrent\">SalientCurrent</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientVoltage\">SalientVoltage</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientResistance\">SalientResistance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientReluctance\">SalientReluctance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientPermeance\">SalientPermeance</a>
</p>

</html>"));
    record SalientReluctance = Salient (redeclare Modelica.SIunits.Reluctance d,
          redeclare Modelica.SIunits.Reluctance q) "Salient reluctance"
      annotation (Documentation(info="<html>
<p>Type representing the d- and q-axis of an reluctance with respect to the fundamental wave.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.Salient\">Salient</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientCurrent\">SalientCurrent</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientVoltage\">SalientVoltage</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientResistance\">SalientResistance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientInductance\">SalientInductance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientPermeance\">SalientPermeance</a>
</p>

</html>"));
    record SalientPermeance = Salient (redeclare Modelica.SIunits.Permeance d,
          redeclare Modelica.SIunits.Permeance q) "Salient permeance"
      annotation (Documentation(info="<html>
<p>Type representing the d- and q-axis of an reluctance with respect to the fundamental wave.</p>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.Salient\">Salient</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientCurrent\">SalientCurrent</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientVoltage\">SalientVoltage</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientResistance\">SalientResistance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientInductance\">SalientInductance</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.SalientReluctance\">SalientReluctance</a>
</p>

</html>"));
    annotation (Documentation(info="<html>
<p>This package provides types for modeling anisotropic saliency effects in electric machines. These saliencies are usually considered by a d- (direct) and q-axis (quadrature) components in the respective axis (of the rotor).</p>
</html>"));
  end Types;
  annotation (preferredView="info", Documentation(revisions="<html>

<p>A detailed list of changes is summarized in the <a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.ReleaseNotes\">release notes</a>.</p>

</html>", info="<html>
  <p><strong>For a discrimination of various machine models, see <a href=\"modelica://Modelica.Electrical.Machines.UsersGuide.Discrimination\">discrimination</a></strong>.</p>
<p>
Copyright &copy; 2009-2018, Modelica Association, <a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Contact\">Christian Kral</a>,
<a href=\"modelica://Modelica.Magnetic.FundamentalWave.UsersGuide.Contact\">Anton Haumer</a> and AIT
</p>
<p>
<em>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the 3-Clause BSD license. For license conditions (including the disclaimer of warranty) visit <a href=\"https://modelica.org/licenses/modelica-3-clause-bsd\">https://modelica.org/licenses/modelica-3-clause-bsd</a>.</em>
</p>
</html>"),
    Icon(graphics={
        Rectangle(
          extent={{-40,60},{-60,-60}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={128,128,128}),
        Rectangle(
          extent={{-40,70},{40,50}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,60},{80,-60}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,128,0}),
        Rectangle(
          extent={{80,10},{100,-10}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={95,95,95}),
        Polygon(
          points={{-50,-90},{-40,-90},{-10,-20},{40,-20},{70,-90},{80,-90},
              {80,-100},{-50,-100},{-50,-90}},
          fillPattern=FillPattern.Solid)}));
end FundamentalWave;
