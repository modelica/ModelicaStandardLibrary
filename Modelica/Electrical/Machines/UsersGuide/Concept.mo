within Modelica.Electrical.Machines.UsersGuide;
class Concept "Concept"
  extends Modelica.Icons.Information;
  annotation (preferredView="info",Documentation(info="<html>
<p>This package contains electric machine models and components for modeling these machines.</p>
<strong>Limitations and assumptions:</strong>
<ul>
<li>number of phases (of induction machines) is limited to 3, therefore definition as a constant m=3</li>
<li>phase symmetric windings as well as symmetry of the whole machine structure</li>
<li>all values are used in physical units, no scaling to p.u. is done</li>
<li>only basic harmonics (in space) are taken into account</li>
<li>waveform (with respect to time) of voltages and currents is not restricted</li>
<li>constant parameters, i.e., no saturation, no skin effect</li>
</ul>
<p>
You may have a look at a short summary of space phasor theory at <a href=\"https://www.haumer.at/refimg/SpacePhasors.pdf\">https://www.haumer.at/refimg/SpacePhasors.pdf</a>
</p>
<strong>Further development:</strong>
<ul>
<li>generalizing space phasor theory to m phases with arbitrary spatial angle of the coils</li>
<li>generalizing space phasor theory to arbitrary number of windings and winding factor of the coils</li>
<li>MachineModels: other machine types</li>
<li>effects: saturation, skin-effect, ...</li>
</ul>
<p>
<strong>In memoriam Prof. Hans Kleinrath (1928-03-07 - 2010-04-05)</strong>
</p>

</html>"));
end Concept;
