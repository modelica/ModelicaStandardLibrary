within Modelica.Electrical.QuasiStatic.UsersGuide;
package Overview "Overview"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<p>
The <a href=\"modelica://Modelica.Electrical.QuasiStatic\">Modelica.Electrical.QuasiStatic</a>
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
      <a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.Introduction\">RMS phasors</a></li>

</ul>

<p>
The main intention of this library is the modeling of quasi-static behavior
of single-phase and polyphase
<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.Overview.ACCircuit\">AC circuits</a>
with fixed and variable frequency. Quasi-static theory and applications can be
found in
[<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">Dorf1993</a>],
[<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">Burton1994</a>],
[<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">Landolt1936</a>],
[<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">Philippow1967</a>],
[<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">Weyh1967</a>],
[<a href=\"modelica://Modelica.Electrical.QuasiStatic.UsersGuide.References\">Vaske1973</a>].
</p>

<h4>Note</h4>
<p>
A general electrical circuit can be a DC circuit, an AC circuit with periodic sinusoidal or non-sinusoidal voltages and currents
or a transient circuit without particular waveform of voltages and currents.
Therefore a coupling model between a quasi-static circuit and a general (transient) electrical circuit
has to be designed carefully taking the specific application into account.
As an example, you may look at the <a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Utilities.IdealACDCConverter\">
ideal AC DC converter</a>, which is used in the
<a href=\"modelica://Modelica.Electrical.QuasiStatic.SinglePhase.Examples.Rectifier\">rectifier example</a>.
</p>

</html>"));
end Overview;
