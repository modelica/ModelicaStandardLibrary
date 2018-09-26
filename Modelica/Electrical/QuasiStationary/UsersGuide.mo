within Modelica.Electrical.QuasiStationary;
package UsersGuide "User's guide"
  extends Modelica.Icons.Information;

  package Overview "Overview"
    extends Modelica.Icons.Information;

    class Introduction "Introduction to phasors"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>

<p>
The purely sinusoidal voltage
</p>

<p>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Introduction/img1.png\"
 alt=\"v=\\sqrt{2}V_{\\mathrm{RMS}}\\cos(\\omega t+\\varphi_{v})\">
</p>

<p>
in the time domain can be represented by a complex
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Glossar\">rms</a> phasor
</p>

<p>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Introduction/img2.png\"
 alt=\"\\underline{v}=V_{\\mathrm{RMS}}e^{j\\varphi_{v}}.\">
</p>

<p>For these quasi stationary
phasor the following relationship applies:</p>

<p>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Introduction/img3.png\"
 alt=\"\\begin{displaymath}
v=\\mathrm{Re}(\\sqrt{2}\\underline{v}e^{j\\omega t})\\end{displaymath}\">
</p>

<p>
This equation is also illustrated in Fig. 1.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Introduction/phasor_voltage.png\"
           alt=\"phasor_voltage.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 1: Relationship between voltage phasor and time domain voltage</caption>
</table>

<p>
From the above equation it is obvious that for <em>t</em> = 0
the time domain voltage is <em>v</em> = cos(<em>&phi;<sub>v</sub></em>).
The complex representation of the phasor corresponds with this instance, too, since
the phasor is leading the real axis by the angle <em>&phi;<sub>v</sub></em>.
</p>

<p>
The explanation given for sinusoidal voltages can certainly also be applied
to sinusoidal currents.</p>

<h4>See also</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.ACCircuit\">
          AC circuit</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.Power\">
          Power</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.ReferenceSystem\">
          Reference system</a>

</html>"));
    end Introduction;

    class ACCircuit "AC circuit"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
A simple
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Examples.SeriesResonance\">
          example</a> of a series connection of a resistor, an inductor and a capacitor
as depicted in Fig. 1 should be explained in the following. For various frequencies,
the voltage drops across the resistor, the inductor and the capacitor should be determined.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/ACCircuit/resonance_circuit.png\"
           alt=\"resonance_circuit.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 1: Series AC circuit of a resistor and an inductor at variable frequency</caption>
</table>

<p>
The voltage drop across the resistor
</p>

<p>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/ACCircuit/img1.png\"
 alt=\"
\\underline{v}_{r}=R\\underline{i}\">
</p>

<p>
and the inductor
</p>

<p>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/ACCircuit/img2.png\"
 alt=\"
\\underline{v}_{l}=j\\omega L\\underline{i}\">
</p>

<p>
and the capacitor
</p>

<p>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/ACCircuit/img3.png\"
 alt=\"
\\underline{v}_{l}=j\\omega L\\underline{i}\">
</p>

<p>
add up to the total voltage
</p>

<p>
<img
 border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/ACCircuit/img4.png\"
 alt=\"
\\underline{v}=\\underline{v}_{r}+\\underline{v}_{l}\">
</p>

<p>
as illustrated in the phasor diagram of Fig. 2.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/ACCircuit/phasor_diagram.png\"
           alt=\"phasor_diagram.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 2: Phasor diagram of a resistor and inductance series connection</caption>
</table>

<p>Due to the series connection of the resistor, inductor and capacitor, the three currents are all equal:</p>

<p>
<img border=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/ACCircuit/img5.png\"
 alt=\"img5.png\">
</p>

<h4>See also</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.Introduction\">
          Introduction</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.Power\">
          Power</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.ReferenceSystem\">
          Reference system</a>

</html>"));
    end ACCircuit;

    class Power "Real and reactive power"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>

<p>For periodic waveforms, the average value of the instantaneous power is <strong>real power</strong> <em>P</em>.
<strong>Reactive power</strong> <em>Q</em> is a term
associated with inductors and capacitors. For pure inductors and capacitors, real power is equal to zero.
Yet, there is instantaneous power exchanged with connecting network.
</p>

The
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Examples.SeriesResonance\">
          series resonance circuit</a> which was also addressed in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.ACCircuit\">
          AC circuit</a>
will be investigated.

<h5>Power of a resistor</h5>

<p>
The instantaneous voltage and current are in phase:
</p>
<p>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/v_r.png\"
                   alt=\"v_r.png\"><br>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/i_r.png\"
                   alt=\"i_r.png\">
</p>

<p>
Therefore, the instantaneous power is
</p>
<p>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_r.png\"
                   alt=\"power_r.png\">
</p>

<p>A graphical representation of these equations is depicted in Fig. 1</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_resistor.png\"
           alt=\"power_resistor.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 1: Instantaneous voltage, current of power of a resistor</caption>
</table>

<p>Real power of the resistor is the average of instantaneous power:</p>
<p>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/p_r.png\"
                   alt=\"p_r.png\">
</p>

<h5>Power of an inductor</h5>

<p>
The instantaneous voltage leads the current by a quarter of the period:
</p>
<p>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/v_l.png\"
                   alt=\"v_l.png\"><br>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/i_l.png\"
                   alt=\"i_l.png\">
</p>

<p>
Therefore, the instantaneous power is
</p>
<p>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_l.png\"
                   alt=\"power_l.png\">
</p>

<p>A graphical representation of these equations is depicted in Fig. 2</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_inductor.png\"
           alt=\"power_inductor.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 2: Instantaneous voltage, current of power of an inductor</caption>
</table>

<p>Reactive power of the inductor is:</p>
<p>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/q_l.png\"
                   alt=\"q_l.png\">
</p>

<h5>Power of a capacitor</h5>

<p>
The instantaneous voltage lags the current by a quarter of the period:
</p>
<p>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/v_c.png\"
                   alt=\"v_c.png\"><br>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/i_c.png\"
                   alt=\"i_c.png\">
</p>

<p>
Therefore, the instantaneous power is
</p>
<p>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_c.png\"
                   alt=\"power_c.png\">
</p>

<p>A graphical representation of these equations is depicted in Fig. 3</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_capacitor.png\"
           alt=\"power_capacitor.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 3: Instantaneous voltage, current of power of a capacitor</caption>
</table>

<p>Reactive power of the capacitor is:</p>
<p>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/q_c.png\"
                   alt=\"q_c.png\">
</p>

<h5>Complex apparent power</h5>

<p>For an arbitrary component with two pins, real and reactive power can be determined by the complex phasors:</p>
<p>
<img border=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/s.png\"
                   alt=\"s.png\">
</p>

<p>
In this equation <sup>*</sup> represents the conjugate complex operator
</p>

<h4>See also</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.Introduction\">
          Introduction</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.ACCircuit\">
          AC circuit</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.ReferenceSystem\">
          Reference system</a>
</html>"));
    end Power;

    class ReferenceSystem "Reference system"
      extends Modelica.Icons.Information;

      annotation (Documentation(info="<html>
<p>
The reference angle <code>gamma</code>:
</p>
<ul>
  <li>defines the angular frequency <code>omega</code> of the voltages and currents
      of a circuit by means of <code>omega = der(gamma)</code>.</li>
  <li>is not a global quantity since it propagated through the connector.
      Therefore, independent circuits of different frequencies can be modeled in one model.</li>
  <li>is present only once in a multiphase connector;
      a multiphase component has only one reference angle common to all phases.</li>
  <li>can be either constant or variable, but it has to be consistent in one contiguous circuit.</li>
  <li>is defined by the sources.</li>
</ul>
<p>
Designing new components, the guidelines of the Modelica Specification dealing with
Overconstrained Equation Operators for Connection Graphs have to be taken into account.
</p>

<h4>See also</h4>
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.Introduction\">
          Introduction</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.ACCircuit\">
          AC circuit</a>,
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.Power\">
          Power</a>

</html>"));
    end ReferenceSystem;

    annotation (Documentation(info="<html>
<p>
The <a href=\"modelica://Modelica.Electrical.QuasiStationary\">Modelica.Electrical.QuasiStationary</a>
library addresses the analysis of electrical circuits with purely sinusoidal
voltages and currents. The main characteristics of the library are:
</p>

<ul>
  <li>Only pure sinusoidal voltages and currents are taken into account.
      Higher harmonic voltages and currents are not considered.</li>
  <li>Any electrical transient effects are neglected.</li>
  <li>The electrical components of this library are strictly linear.</li>
  <li>The angular frequency <code>omega</code> of the voltages and currents of
      a circuit are determined from a reference angle <code>gamma</code> by means of
      <code>omega = der(gamma)</code>.</li>
  <li>The reference angle <code>gamma</code> is not a global quantity
      since it propagated through the connector.
      Therefore, independent circuits of different frequencies can be modeled in one model.</li>
  <li>The connectors contain the real and the imaginary part of the voltage and the current
      <a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.Introduction\">RMS phasors</a></li>

</ul>

<p>
The main intention of this library is the modeling of quasi stationary behavior
of single and multi phase
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.ACCircuit\">AC circuits</a>
with fixed and variable frequency. Quasi stationary theory and applications can be
found in
[<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">Dorf1993</a>],
[<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">Burton1994</a>],
[<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">Landolt1936</a>],
[<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">Philippow1967</a>],
[<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">Weyh1967</a>],
[<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">Vaske1973</a>].
</p>

<h4>Note</h4>
<p>
A general electrical circuit can be a DC circuit, an AC circuit with periodic sinusoidal or non-sinusoidal voltages and currents
or a transient circuit without particular waveform of voltages and currents.
Therefore a coupling model between a quasi stationary circuit and a general (transient) electrical circuit
has to be designed carefully taking the specific application into account.
As an example, you may look at the <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Utilities.IdealACDCConverter\">
ideal AC DC converter</a>, which is used in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Examples.Rectifier\">rectifier example</a>.
</p>

</html>"));
  end Overview;

  class ReleaseNotes "Release notes"
    extends Modelica.Icons.ReleaseNotes;

    annotation (Documentation(info="<html>
<h5>Version 3.2.3, 2018-09-26</h5>
<ul>
    <li>Added frequency dependent behavior im impedance and admittance models, see
        <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2451\">#2451</a></li>
    <li>Added frequency sweep voltage and current sources, see
        <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2442\">#2442</a>
    <ul>
        <li>Single-phase <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.FrequencySweepVoltageSource\">FrequencySweepVoltageSource</a></li>
        <li>Single-phase <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Sources.FrequencySweepCurrentSource\">FrequencySweepCurrentSource</a></li>
        <li>Polyphase <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.FrequencySweepVoltageSource\">FrequencySweepVoltageSource</a></li>
        <li>Polyphase <a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Sources.FrequencySweepCurrentSource\">FrequencySweepCurrentSource</a></li>
    </ul></li>
    <li>Shortened default component names, see
      <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2301\">#2301</a></li>
    <li>Fixed missing <code>final useConjugateInput = false</code>, see
    <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2251\">#2251</a>
    <ul>
      <li><a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Blocks.SymmetricalComponents\">MultiPhase.Blocks.SymmetricalComponents</a></li>
      <li><a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Blocks.FromSymmetricalComponents\">MultiPhase.Blocks.FromSymmetricalComponents</a></li>
      <li><a href=\"modelica://Modelica.Electrical.QuasiStationary.MultiPhase.Blocks.SingleToMultiPhase\">MultiPhase.Blocks.SingleToMultiPhase</a></li>
    </ul></li>
<li>Updated icons of inductors and transformer models, see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2210\">#2210</a></li>
<li>Added polar and power quantities in ideal quasi stationary transformer model, see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2173\">#2173</a></li>
<li>Removed redundant (and not identical) parameter m from
    <a href=\"modelica://Modelica.Electrical.MultiPhase.Basic.MutualInductor\">MutualInductor</a>,
    see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2202\">#2202</a></li>
<li>Added linear multi phase mutual inductor model, see <a href=\"https://github.com/modelica/ModelicaStandardLibrary/issues/2200\">#2200</a></li>
<li>Added complex impedance and admittance models of single phase and multi phase package, see ticket
    <a href=\"https://trac.modelica.org/Modelica/ticket/1870\">#1870</a></li>
<li>Added magnitude and argument of complex voltages and currents in interface and sensor models, see ticket
    <a href=\"https://trac.modelica.org/Modelica/ticket/1405\">#1405</a></li>
<li>Added active, reactive and apparent power and power factor in interface models, see ticket
    <a href=\"https://trac.modelica.org/Modelica/ticket/1405\">#1405</a></li>
<li>Added complex single and multi phase impedance and admittance models (ticket
    <a href=\"https://trac.modelica.org/Modelica/ticket/1367\">#1367</a>)</li>
<li>Updated documentation on temperature dependency of resistance and conductance models</li>
<li>Rewrote source models to simplify initialization (
    <a href=\"https://trac.modelica.org/Modelica/changeset/7031\">r7031</a>)</li>
<li>Implementation of ideal transformer model</li>
</ul>

<h5>Version 1.0.0</h5>
<ul><li>First official release</li></ul>
</html>",   revisions="<html>
</html>"));
  end ReleaseNotes;

  class References "References"
    extends Modelica.Icons.References;

    annotation (Documentation(info="<html>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td>[Dorf1993]</td>
      <td>R. C. Dorf
        <em>The Electrical Engineering</em>,
        VDE, 1993.</td>
    </tr>

    <tr>
      <td>[Boas1966]</td>
      <td>M. L. Boas
        <em>Mathematical Methods in the Physical Sciences</em>,
        J. Wiley &amp; Sons, New York, 1966.</td>
    </tr>

    <tr>
      <td>[Burton1994]</td>
      <td>T. Burton
        <em>Introduction to Dynamic Systems Analysis</em>,
        McGraw Hill, New York, 1994.</td>
    </tr>

    <tr>
      <td>[Landolt1936]</td>
      <td>M. Landolt
        <em>Komplexe Zahlen und Zeiger in der Wechselstromlehre</em>,
        Springer Verlag, Berlin, 1936</td>
    </tr>

    <tr>
      <td>[Philippow1967]</td>
      <td>E. Philippow
        <em>Grundlagen der Elektrotechnik</em>,
       Akademischer Verlag, Leipzig, 1967.</td>
    </tr>

    <tr>
      <td>[Weyh1967]</td>
      <td>Weyh and Benzinger
        <em>Die Grundlagen der Wechselstromlehre</em>,
       R. Oldenbourg Verlag, 1967.</td>
    </tr>

    <tr>
      <td>[Vaske1973]</td>
      <td>P. Vaske
        <em>Berechnung von Drehstromschaltungen</em>,
       B.G. Teubner Verlag, 1973.</td>
    </tr>

</table>

</html>"));
  end References;

  class Contact "Contact"
    extends Modelica.Icons.Contact;

    annotation (Documentation(info="<html>
<h4>Library officers and main authors</h4>

<p>
<strong>Anton Haumer</strong><br>
<a href=\"https://www.haumer.at\">Technical Consulting &amp; Electrical Engineering</a><br>
D-93049 Regensburg, Germany<br>
email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
</p>

<p>
<strong>Dr. Christian Kral</strong><br>
<a href=\"https://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
A-1060 Vienna, Austria<br>
email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a>
</p>
</html>"));
  end Contact;

  class Glossar "Glossar"
    extends Modelica.Icons.Information;

    annotation (Documentation(info="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <th>Abbreviation</th>
    <th>Comment</th>
  </tr>
  <tr>
    <td>AC</td>
    <td>alternating current</td>
  </tr>
  <tr>
    <td>RMS</td>
    <td>root mean square</td>
  </tr>
</table>
</html>"));
  end Glossar;
  annotation (DocumentationClass=true, Documentation(info="<html>
</html>"));
end UsersGuide;
