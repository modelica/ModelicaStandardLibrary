within Modelica.Magnetic.FundamentalWave;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;

  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
This library contains components for modelling of electromagnetic fundamental wave
models for the application in polyphase
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
<li>In machines with <strong>more than three-phases</strong> only effects of currents and voltages on the magnetic <strong>fundamental waves</strong> are considered. Other magnetic effects due to higher harmonic are not taken into account.</li>
</ul>

</html>"));
end UsersGuide;
