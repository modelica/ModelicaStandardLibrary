within Modelica.Magnetic.FundamentalWave.UsersGuide;
class Concept "Fundamental wave concept"

  annotation (Documentation(info="<html>

<h4>Overview of the concept of fundamental waves</h4>

<p>
The exact magnetic field in the air gap of an electric machine is usually determined by an electro magnetic finite element analysis. The waveform of the magnetic field, e.g. the magnetic potential difference <img src=\"../Images/Magnetic/FundamentalWave/V_m_phi.png\">, consists of a spatial fundamental wave - with respect to one pole pair - and additional harmonic waves of different order. The fundamental wave is however dominant in the air gap of an electric machine.
</p>

<p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Field lines of a four pole induction machine</caption>
  <tr>
    <td>
      <img src=\"../Images/Magnetic/FundamentalWave/UsersGuide/Concept/aimc_fem.png\">
    </td>
  </tr>
</table>

</p>

<p>
In the fundamental wave theory only a pure sinusoidal distribution of magnetic quantities is assumed. It is thus assumed that all other harmonic wave effects are not taken into account. </p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Magnetic potential difference of a four pole machine, where <img src=\"../Images/Magnetic/FundamentalWave/varphi.png\"> is the angle of the spatial domain with respect to one pole pair</caption>
  <tr>
    <td>
      <img src=\"../Images/Magnetic/FundamentalWave/UsersGuide/Concept/four_pole_V_m.png\">
    </td>
  </tr>
</table>

<p>
The waveforms of the magnetic field quantities, e.g. the magnetic potential difference <img src=\"../Images/Magnetic/FundamentalWave/V_m_phi.png\">, can be represented by complex phasor, e.g., <img src=\"../Images/Magnetic/FundamentalWave/V_m.png\">.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\">Spatial distribution of the magnetic potential difference (red shade = positive sine wave, blue shade = negative sine wave) including complex phasor representing this spatial distribution</caption>
  <tr>
    <td>
      <img src=\"../Images/Magnetic/FundamentalWave/UsersGuide/Concept/electrical_reference_V_m.png\">
    </td>
  </tr>
</table>

<p>
The potential and flow quantities of this library are the complex magnetic potential difference and the complex magnetic flux as defined in the basic <a href=\"Modelica_FundamentalWave.Interfaces.MagneticPort\">magnetic port</a>. Due to the sinusoidal distribution of magnetic potential and flux, such a complex phasor representation can be used. This way, the FundamentalWave library can be seen as a spatial extension of the <a href=\"Modelica.Magnetics.FluxTubes\">FluxTubes</a> library.
</p>

<p>
The specific arrangement of windings in electric machines with <img src=\"../Images/Magnetic/FundamentalWave/p.png\"> pole pairs give rise to sinusoidal dominant magnetic potential wave. The spatial period of this wave is determined by one pole pair
[<a href=\"Modelica_FundamentalWave.UsersGuide.References\">Mueller70</a>,
 <a href=\"Modelica_FundamentalWave.UsersGuide.References\">Spaeth73</a>].
</p>

<p>
The main components of an electric machine model based on the FundamentalWave library are <a href=\"Modelica_FundamentalWave.Machines.Components.SymmetricMultiPhaseWinding\">multi phase</a> and <a href=\"Modelica_FundamentalWave.Machines.Components.SinglePhaseWinding\">single phase windings</a>, <a href=\"Modelica_FundamentalWave.Machines.Components.RotorSaliencyAirGap\">air gap</a> as well as <a href=\"Modelica_FundamentalWave.Machines.Components.SymmetricMultiPhaseWinding\">symmetric</a> or <a href=\"Modelica_FundamentalWave.Machines.Components.SaliencyCageWinding\">salient cage</a> models.
The electric machine models provided in this library are based on symmetrical three phase windings in the stator and equivalent two or three phase windings in the rotor.
</p>

<h4>Assumptions</h4>

<p>
The machine models of the FundamentalWave library are currently based on the following assumptions
</p>

<ul>
<li>The number of stator phases is limited to three
    [<a href=\"Modelica_FundamentalWave.UsersGuide.References\">Eckhardt82</a>]
    </li>
<li>The phase windings are assumed to be symmetrical; an extension to this approach can be considererd</li>
<li>Only fundamental wave effects are taken into account</li>
<li>There are no restrictions on the waveforms of voltages and currents</li>
<li>All resistances and inductances are modeled as constant quantities; saturation effects, cross coupling effects
    [<a href=\"Modelica_FundamentalWave.UsersGuide.References\">Li07</a>], temperature dependency of resistances and deep bar effects could be considered in an extension to this library</li>
<li>Core losses, i.e., eddy current and hysteresis losses, friction losses and stray load losses are currently not considered [<a href=\"Modelica_FundamentalWave.UsersGuide.References\">Haumer09</a>]</li>
<li>The only dissipated losses in the electric machine models are currently ohmic heat losses</li>
</ul>

<h4>Note</h4>

<p>
The term <b>fundamental wave</b> refers to spatial waves of the electro magnetic quantities. This library has no limitations with respect to the waveforms of the time domain signals of any voltages, currents, etc.
</p>
</html>
"));
end Concept;
