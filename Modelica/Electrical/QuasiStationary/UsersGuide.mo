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
<IMG
 BORDER=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Introduction/img1.png\"
 ALT=\"
v=\\sqrt{2}V_{\\mathrm{RMS}}\\cos(\\omega t+\\varphi_{v})\">
</p>

<p>
in the time domain can be represented by a complex
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Glossar\">rms</a> phasor
</p>

<p>
<IMG
 BORDER=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Introduction/img2.png\"
 ALT=\"
\\underline{v}=V_{\\mathrm{RMS}}e^{j\\varphi_{v}}.\">
</p>

<p>For these quasi stationary
phasor the following relationship applies:</p>

<p>
<IMG
 BORDER=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Introduction/img3.png\"
 ALT=\"\\begin{displaymath}
v=\\mathrm{Re}(\\sqrt{2}\\underline{v}e^{j\\omega t})\\end{displaymath}\">
</p>

<p>
This equation is also illustrated in Fig. 1.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Introduction/phasor_voltage.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 1: Relationship between voltage phasor and time domain voltage</caption>
</table>

<p>
From the above equation it is obvious that for <i>t</i> = 0
the time domain voltage is <i>v</i> = cos(<i>&phi;<sub>v</sub></i>).
The complex representation of the phasor corresponds with this instance, too, since
the phasor is leading the real axis by the angle <i>&phi;<sub>v</sub></i>.
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
<a href=\"modelica://Modelica.Electrical.QuasiStationary.Examples.SeriesResonance\">
          example</a> of a series connection of a resistor, an inductor and a capacitor
as depicted in Fig. 1 should be explained in the following. For various frequencies,
the voltage drops across the resistor, the inductor and the capacitor should be determined.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/ACCircuit/resonance_circuit.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 1: Series AC circuit of a resistor and an inductor at variable frequency</caption>
</table>

<p>
The voltage drop across the resistor
</p>

<p>
<IMG
 BORDER=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/ACCircuit/img1.png\"
 ALT=\"
\\underline{v}_{r}=R\\underline{i}\">
</p>

<p>
and the inductor
</p>

<p>
<IMG
 BORDER=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/ACCircuit/img2.png\"
 ALT=\"
\\underline{v}_{l}=j\\omega L\\underline{i}\">
</p>

<p>
and the capacitor
</p>

<p>
<IMG
 BORDER=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/ACCircuit/img3.png\"
 ALT=\"
\\underline{v}_{l}=j\\omega L\\underline{i}\">
</p>

<p>
add up to the total voltage
</p>

<p>
<IMG
 BORDER=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/ACCircuit/img4.png\"
 ALT=\"
\\underline{v}=\\underline{v}_{r}+\\underline{v}_{l}\">
</p>

<p>
as illustraed in the phasor diagram of Fig. 2.
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/ACCircuit/phasor_diagram.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 2: Phasor diagram of a resistor and inductance series connection</caption>
</table>

<p>Due to the series connection of the resistor, inductor and capacitor, the three currents are all equal:</p>

<IMG BORDER=\"0\"
 src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/ACCircuit/img5.png\">
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

<p>For periodic waveforms, the average value of the instantaneous power is <b>real power</b> <i>P</i>.
<b>Reactive power</b> <i>Q</i> is a term
associated with inductors and capacitors. For pure inductors and capacitors, real power is equal to zero.
Yet, there is instantaneous power exchanged with connecting network.
</p>

The
<a href=\"modelica://Modelica.Electrical.QuasiStationary.Examples.SeriesResonance\">
          series resonance circuit</a> which was also adressed in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Overview.ACCircuit\">
          AC circuit</a>
will be investigated.

<h5>Power of a resistor</h5>

<p>
The instantaneous voltage and current are in phase:
</p>
<p>
<IMG BORDER=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/v_r.png\"> <br>
<IMG BORDER=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/i_r.png\">
</p>

<p>
Therefore, the instantaneous power is
</p>
<p>
<IMG BORDER=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_r.png\">
</p>

<p>A graphical representation of these equations is depicted in Fig. 1</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_resistor.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 1: Instantaneous voltage, current of power of a resistor</caption>
</table>

<p>Real power of the resistor is the average of instantaneous power:</p>
<p>
<IMG BORDER=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/p_r.png\">
</p>

<h5>Power of an inductor</h5>

<p>
The instantaneous voltage leads the current by a quarter of the period:
</p>
<p>
<IMG BORDER=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/v_l.png\"> <br>
<IMG BORDER=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/i_l.png\">
</p>

<p>
Therefore, the instantaneous power is
</p>
<p>
<IMG BORDER=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_l.png\">
</p>

<p>A graphical representation of these equations is depicted in Fig. 2</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_inductor.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 2: Instantaneous voltage, current of power of an inductor</caption>
</table>

<p>Reqactive power of the inductor is:</p>
<p>
<IMG BORDER=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/q_l.png\">
</p>

<h5>Power of a capacitor</h5>

<p>
The instantaneous voltage lags the current by a quarter of the period:
</p>
<p>
<IMG BORDER=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/v_c.png\"> <br>
<IMG BORDER=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/i_c.png\">
</p>

<p>
Therefore, the instantaneous power is
</p>
<p>
<IMG BORDER=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_c.png\">
</p>

<p>A graphical representation of these equations is depicted in Fig. 3</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/power_capacitor.png\">
    </td>
  </tr>
  <caption align=\"bottom\">Fig. 3: Instantaneous voltage, current of power of a capacitor</caption>
</table>

<p>Reqactive power of the capacitor is:</p>
<p>
<IMG BORDER=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/q_c.png\">
</p>

<h5>Complex apparent power</h5>

<p>For an arbitrary component with two pins, real and reactive power can be determined by the complex phasors:</p>
<p>
<IMG BORDER=\"0\"  src=\"modelica://Modelica/Resources/Images/Electrical/QuasiStationary/UsersGuide/Overview/Power/s.png\">
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
The reference angle <eq>gamma</eq>:
</p>
<ul>
  <li>defines the angular frequency <eq>omega</eq> of the voltages and currents
      of a circuit by means of <eq>omega = der(gamma)</eq>. </li>
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
  <li>Any electrical transient effects are negelcted.</li>
  <li>The electrical components of this library are strictly linear.</li>
  <li>The angular frequency <eq>omega</eq> of the voltages and currents of
      a circuit are determined from a reference angle <eq>gamma</eq> by means of
      <eq>omega = der(gamma)</eq>. </li>
  <li>The reference angle <eq>gamma</eq> is not a global quantity
      since it propagated through the connector.
      Therefore, independent circuits of different frequencies can be modeled in one model.</li>
  <li>The connectors contain the real and the imaginary part of the voltage and the current
      <a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Phasor\">RMS phasors</a></li>

</ul>

<p>
The main intention of this library is the modeling of quasi stationary behavior
of single and multi phase
<a href=\"modelica://Modelica.Electrical.QuasiStationary.UsersGuide.ACCircuit\">AC circuits</a>
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
A general electrical circuit can be a DC circuit, an AC circuit with periodic sinusoidal or non-sinusodial voltages and currents
or a transient circuit without particular waveform of voltages and currents.
Therefore a coupling model between a quasi stationary circuit and a general (transient) electrical circuit
has to be designed carefully taking the specific application into account.
As an exmaple, you may look at the <a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Utilities.IdealACDCConverter\">
ideal AC DC converter</a>, which is used in the
<a href=\"modelica://Modelica.Electrical.QuasiStationary.SinglePhase.Examples.Rectifier\">rectifier example</a>.
</p>

</html>"));
  end Overview;

  class ReleaseNotes "Release notes"
    extends Modelica.Icons.ReleaseNotes;

    annotation (Documentation(info="<html>
</html>",   revisions="<html>
<h4>Version 1.0.0</h4>

<p>First official release</p>
</html>"));
  end ReleaseNotes;

  class References "References"
    extends Modelica.Icons.References;

    annotation (Documentation(info="<html>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <td valign=\"top\">[Dorf1993]</td>
      <td valign=\"top\">R. C. Dorf
        <i>The Electrical Engineering</i>,
        VDE, 1993.</td>
    </tr>

    <tr>
      <td valign=\"top\">[Boas1966]</td>
      <td valign=\"top\">M. L. Boas
        <i>Mathematical Methods in the Physical Sciences</i>,
        J. Wiley & Sons, New York, 1966.</td>
    </tr>

    <tr>
      <td valign=\"top\">[Burton1994]</td>
      <td valign=\"top\">T. Burton
        <i>Introduction to Dynamic Systems Analysis</i>,
        McGraw Hill, New York, 1994.</td>
    </tr>

    <tr>
      <td valign=\"top\">[Landolt1936]</td>
      <td valign=\"top\">M. Landolt
        <i>Komplexe Zahlen und Zeiger in der Wechselstromlehre</i>,
        Springer Verlag, Berlin, 1936</td>
    </tr>

    <tr>
      <td valign=\"top\">[Philippow1967]</td>
      <td valign=\"top\">E. Philippow
        <i>Grundlagen der Elektrotechnik</i>,
       Akademischer Verlag, Leipzig, 1967.</td>
    </tr>

    <tr>
      <td valign=\"top\">[Weyh1967]</td>
      <td valign=\"top\">Weyh and Benzinger
        <i>Die Grundlagen der Wechselstromlehre</i>,
       R. Oldenbourg Verlag, 1967.</td>
    </tr>

    <tr>
      <td valign=\"top\">[Vaske1973]</td>
      <td valign=\"top\">P. Vaske
        <i>Berechnung von Drehstromschaltungen</i>,
       B.G. Teubner Verlag, 1973.</td>
    </tr>

</table>

</html>"));
  end References;

  class Contact "Contact"
    extends Modelica.Icons.Contact;

    annotation (Documentation(info="<html>

<p>This package is developed an maintained by the following contributors</p>

  <table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
    <tr>
      <th></th>
      <th>Name</th>
      <th>Affiliation</th>
    </tr>
    <tr>
      <td valign=\"top\">Library officer</td>
      <td valign=\"top\">
      <a href=\"mailto:a.haumer@haumer.at\">A. Haumer</a>
      </td>
      <td valign=\"top\">
        <a href=\"http://www.haumer.at\">Technical Consulting &amp; Electrical Engineering</a><br>
        3423 St.Andrae-Woerdern<br>
        Austria
      </td>
    </tr>
    <tr>
      <td valign=\"top\">Library officer</td>
      <td valign=\"top\">
        <a href=\"mailto:christian.kral@ait.ac.at\">C. Kral</a>
      </td>
      <td valign=\"top\">
        <a href=\"http://www.ait.ac.at\">Austrian Institute of Technology, AIT</a>, Mobility Department<br>
        1210 Vienna<br>
        Austria
      </td>
    </tr>
  </table>

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
  annotation (__Dymola_DocumentationClass=true, Documentation(info="<html>
</html>"));
end UsersGuide;
