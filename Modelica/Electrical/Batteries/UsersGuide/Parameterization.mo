within Modelica.Electrical.Batteries.UsersGuide;
class Parameterization "Parameterization of battery models"
  extends Modelica.Icons.Information;
  annotation (DocumentationClass=true, Documentation(info="<html>
<p>
A <strong>stack</strong> from <a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacks\">BatteryStacks</a> is built from <code>Ns*Np</code> <strong>identical cells</strong>,
where <code>Np</code> describes the number of parallel connected cells and <code>Ns</code> the number of series connected cells.
</p>
<p>
The parameters of a stack built from <code>Np*Ns</code> identical cells are calculated as follows:
</p>
<table>
<tr><td>Description</td>             <td>Cell</td>         <td>Stack</td></tr>
<tr><td>Nominal OCV</td>             <td><code>OCVmax</code></td> <td><code>OCVmax*Ns</code></td></tr>
<tr><td>End of discharge voltage</td><td><code>OCVmmin</code></td><td><code>OCVmin*Ns</code></td></tr>
<tr><td>Capacity</td>                <td><code>Qnom</code></td>   <td><code>Qnom*Np</code></td></tr>
<tr><td>Inner resistance</td>        <td><code>Ri</code></td>     <td><code>Ri*Ns/Np</code></td></tr>
</table>
<h4>Cell parameters</h4>
<p>
The parameters of one cell are summarized in the parameter record <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">cellData</a>.
Dependency of OCV on SOC can be chosen either linear (<code>useLinearSOCDependency=true</code>) or based on a look-up table.<br>
By default, a linear OCV versus SOC characteristic is defined (like a capacitor), i.e. <code>OCV_SOC[:,2]=[SOCmin,OCVmin/OCVmax; SOCmax,1]</code>.<br>
The OCV versus SOC table has to be specified with 1st column = SOC values in ascending order, 2nd column = corresponding OCV values with respect to OCVmax.<br>
Be careful using parameter <code>smoothness</code> for table interpolation, check the resulting characteristic.<br>
Further dependencies of OVC (e.g. on temperature) are not taken into account, this would require a 2-dimensional table look-up.
</p>
<p>
Self-discharge is specified as discharge current <code>Idis</code> at <code>SOC = SOCmax</code>. From that values, a self-discharge conductance is calculated.<br>
If self-discharge should be neglected, set <code>Idis=0</code>.
</p>
<p>
Linear temperature dependency of inner resistance can be specified by reference temperature <code>T_ref</code> and temperature coefficient <code>alpha</code>: <br>
<code>R = R_ref*(1 + alpha*(T - T_ref))</code>.
</p>
<h4>Transient parameters</h4>
<p>
The parameter record for one cell of a transient battery model <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.TransientData.CellData\">cellData</a>
extends from the <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">basic cellData</a> record, and adds the parameters of the additional RC-elements.
These are specified by an array of parameter records <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData\">rcData</a>:
</p>
<ul>
<li><code>R</code> .. Resistance of RC-element</li>
<li><code>C</code> .. Capacitance of RC-element</li>
</ul>
<p>
The size of the array <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData\">rcData</a> has to be defined as parameter <code>nRC</code>.
The parameters of these RC-elements are results of sophisticated measurements, e.g. cell impedance spectroscopy.<br>
Temperature dependency of the resistors is assumed to be the same as inner resistance <code>Ri</code>.
</p>
<h4>Typical parameters of a Li-Ion cell</h4>
<table>
<tr><td>End of charge voltage</td>   <td>&nbsp;</td>              <td>4.2 V</td></tr>
<tr><td>Nominal voltage</td>         <td>&nbsp;</td>              <td>3.6 V</td></tr>
<tr><td>End of discharge voltage</td><td><code>OCVmmin</code></td><td>2.5 V</td></tr>
</table>
<p>
Capacity (i.e. nominal charge) <code>Qnom</code>, inner resistance <code>Ri</code> and short-circuit current <code>Isc</code> depend on the cell size.<br>
Typical (estimated) values for a certain cell size are, as an example:
</p>
<table>
<tr><td>Capacity</td>             <td><code>Qnom</code></td><td>5 A.h</td></tr>
<tr><td>Inner resistance</td>     <td><code>Ri</code></td>  <td>3 m&Omega;</td></tr>
</table>
<p>
Self-discharge rate is typically 1%/month.
</p>
<h4>Parameters of stacks built from a matrix of <code>Ns</code> x <code>Np</code> cells:</h4>
<p>
A <strong>stack</strong> from <a href=\"modelica://Modelica.Electrical.Batteries.BatteryStacksWithSensors\">BatteryStacksWithSensors</a> is built from <code>Ns*Np</code> cells
arranged in a matrix, where <code>Np</code> describes the number of parallel connected cells and <code>Ns</code> the number of series connected cells.
The parameters of such a stack are summarized in the parameter record <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.StackData\">stackData</a>.
Here the matrix of <code>Ns</code> x <code>Np</code> cell parameters records is compiled.
The parameters of <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">original cell data</a> are propagated to all cells except those
whose indices are specified in the array <code>kDegraded[:,2]</code>. For these degraded cells the parameters of
<a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.CellData\">degraded cell data</a> are propagated.<br>
<strong>Note:</strong> Any members of the parameter array <code>kDegraded[:,2]</code> outside the range <code>1&le;kDegraded[:,1]&le;Ns</code> and <code>1&le;kDegraded[:,2]&le;Np</code> are ignored.
</p>
</html>"));
end Parameterization;
