within Modelica.Magnetic.FundamentalWave.UsersGuide;
class PermanentMagnets "Concept of permanent magnet modeling"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>

<h4>Concept of permanent magnet modeling</h4>

<p>
High performace permanent magnets (e.g. NdFeB) operate on their largest hysteresis loop. 
This characteristic is nearly linear in the second quadrant between remnant flux density B<sub>r</sub> and coercive field strength H<sub>c</sub>. 
As an example, typical values are B<sub>r</sub> = 1.3 T and H<sub>c</sub> = 1000 kA/m. 
This proves that the slope of the hysteresis loop is nearly fully saturated with a relative permeability &mu;<sub>r</sub> = B<sub>r</sub> / H<sub>c</sub> / &mu;<sub>0</sub> = 1.
</p>

<p>
At normal operational temperatures, the bend below that demagnetization could occur is left from coercive field strength at negative flux density. 
The permanent magnet's energy density is the maximum of the product B x H along this characteristic. 
It can be calculated as B<sub>r</sub> x H<sub>c</sub> / 4 = 325 kJ/m<sup>3</sup> for the above mentioned example.
</p>

<p>
Using geometry, flux density is proportional to magnetic flux and magnetic field strength is proportional to magnetomotive force. 
The point of operation can be found at the intersection (1) between the magnet's hysteresis loop and the characteristic of the rest of the machine's magnetic circuit in d-axis. 
The magnet can be represented as a linear source with open-circuit magnetomotive force mmf<sub>0</sub> resulting from H<sub>c</sub>, 
short-circuit flux &psi;<sub>sc</sub> resulting from B<sub>r</sub> and an inner magnetic resistance R<sub>i</sub> = &psi;<sub>sc</sub> / mmf<sub>0</sub> equivalent to that of air. 
If this inner magnetic resistance R<sub>i</sub> is added to the nonlinear characteristic of the rest of the machine's magnetic circuit R<sub>m</sub>, 
the permanent magnet can be characterized by its open-circuit mmf<sub>0</sub> (2).
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption><strong>Fig. 1:</strong> Magnetic characteristic and </caption>
  <tr>
    <td>
      <img src=\"modelica://Modelica/Resources/Images/Magnetic/FundamentalWave/UsersGuide/PermanentMagnets/PM.png\">
    </td>
  </tr>
</table>

<p>
In <a href=\"modelica://Modelica.Electrical.Machines\">Modelica.Electrical.Machines</a> this open-circuit mmf<sub>0</sub> is modeled as a constant equivalent excitation current source, 
in <a href=\"modelica://Modelica.Magnetic.FundamentalWave\">Modelica.Magnetic.FundamentalWave</a> as a constant magnetic potential difference. 
In both models, the permanent magnet's inner magnetic resistance R<sub>i</sub> is assumed to be comprised in the d-axis inductance L<sub>d</sub>.
</p>

<p>
The remnant flux density B<sub>r</sub> and coercive field strength H<sub>c</sub> are known to be dependent on temperature, 
with a relative temperature coefficient of approximately &alpha;<sub>B</sub> = - 0.1 &#37;/K for B<sub>r</sub> and &alpha;<sub>H</sub> = - 0.5 &#37;/K for H<sub>c</sub>. 
This results in a temperature dependency of the inner magnetic resistance R<sub>i</sub> = &psi;<sub>sc</sub> / mmf<sub>0</sub> 
and therefore a temperature dependency of d-axis inductance L<sub>d</sub>. 
</p>

<p>
Assuming the same temperature coefficient for B<sub>r</sub> and H<sub>c</sub>, the inner magnetic resistance R<sub>i</sub> 
and furthermore the d-axis inductance L<sub>d</sub> would be invariant with respect to temperature.
However, this temperature effects are not taken into account in the Modelica Standard Library.
</p>

<h4>Further reading</h4>

<p>
[VAC] Vacuumschmelze, <a href=\"https://vacuumschmelze.de/03_Documents/Brochures/VACODYM-VACOMAX%20en.pdf\"><em>Rare Earth Permanent Magnets</em></a>.
</p>

</html>"));
end PermanentMagnets;
