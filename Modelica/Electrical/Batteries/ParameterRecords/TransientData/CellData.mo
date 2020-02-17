within Modelica.Electrical.Batteries.ParameterRecords.TransientData;
record CellData "Parameters of a transient battery cell"
  extends Modelica.Electrical.Batteries.ParameterRecords.CellData(
    R0=Ri - sum(rcData.R));
  extends Modelica.Electrical.Batteries.Icons.TransientCellRecord;
  parameter Integer nRC=1 "Number of RC-elements"
    annotation (Dialog(group="RC-elements"), Evaluate=true);
  parameter RCData rcData[nRC]=
    {Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData(R=0, C=0)} "Parameters of RC-elements"
    annotation (Dialog(group="RC-elements"),
      Placement(transformation(extent={{-10,0},{10,20}})));
  annotation(defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>Collects parameters of battery cells:</p>
<ul>
<li>Nominal charge</li>
<li>OCV versus SOC characteristic</li>
<li>Inner resistance; can be calculated from OCVmax / short-circuit current (at OCVmax)</li>
<li>Array of records <code>rcData</code> for battery models comprising RC-elements</li>
</ul>
<h4>Note</h4>
<p>
If <code>useLinearSOCDependency=true</code>, the OCV versus SOC table is built up internally from <code>OCVmax, OCVmin, SOCmax, SOCmin</code>.<br>
Otherwise, the OCV versus SOC table has to be specified: 1st column = SOC values in ascending order, 2nd column = corresponding OCV values with respect to OCVmax.
</p>
<p>
The size of the array <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.TransientData.RCData\">rcData</a> has to be defined as parameter <code>nRC</code>.
The sum of the resistances <code>rcData.R</code> must not exceed the total inner resistance <code>Ri</code>.
</p>
</html>"));
end CellData;
