within Modelica.Electrical.QuasiStationary.UsersGuide;
package Overview "Overview"


  annotation (Documentation(info="<html>
<p>
The <a href=\"Modelica://Modelica.Electrical.QuasiStationary\">Modelica.Electrical.QuasiStationary</a>
library addresses the analysis of electrical circuits with purely sinusoidal
voltages and currents. The main characteristics of the library are:
</p>

<ul>
  <li>Only pure sinusoidal voltages and currents are taken into account.
      Higher harmonic voltages and currents are not considered.</li>
  <li>Any electrical transient effects are negelcted.</li>
  <li>The electrical components of this library are strictly linear.</li>
  <li>The angular frequency <eq>omega</eq> of the voltages and currents of
      a circuit are
      determined from a reference angle <eq>gamma</eq> by means of
      <eq>omega = der(gamma)</eq>. </li>
  <li>The reference angle <eq>gamma</eq> is not a global quantity
      since it propagated through the connector.
      Therefore, independent circuits of different frequencies can be modeled in one model.</li>
  <li>The connectors contain the real and the imaginary part of the voltage and the current
      <a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.Phasor\">RMS phasors</a></li>

</ul>

<p>
The main intention of this library is the modeling of quasi stationary behavior
of single and multi phase
<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.ACCircuit\">AC circuits</a>
with fixed and variable frequency. Quasi stationary theory and applications can be
found in
[<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">Dorf1993</a>],
[<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">Burton1994</a>],
[<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">Landolt1936</a>],
[<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">Philippow1967</a>],
[<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">Weyh1967</a>],
[<a href=\"Modelica://Modelica.Electrical.QuasiStationary.UsersGuide.References\">Vaske1973</a>].
</p>


</html>"));
end Overview;
