within Modelica.Electrical.Batteries.ParameterRecords;
record CellData "Parameters of a battery cell"
  extends Modelica.Icons.Record;
  parameter Modelica.SIunits.ElectricCharge Qnom(displayUnit="Ah")
    "Nominal (maximum) charge";
  parameter Boolean useLinearSOCDependency=true
    "Use a linear SOC dependent OCV, otherwise table based"
    annotation(Dialog(group="OCV versus SOC"));
  parameter Modelica.SIunits.Voltage OCVmax(final min=0) "OCV at SOC = SOCmax"
    annotation(Dialog(group="OCV versus SOC"));
  parameter Modelica.SIunits.Voltage OCVmin(final min=0, start=0) "OCV at SOC = SOCmin"
    annotation(Dialog(group="OCV versus SOC", enable=useLinearSOCDependency));
  parameter Real SOCmax(final max=1)=1 "Max. state of charge"
    annotation(Dialog(group="OCV versus SOC"));
  parameter Real SOCmin(final min=0)=0 "Min. state of charge"
    annotation(Dialog(group="OCV versus SOC"));
  final parameter Real LinearOCV_SOC[2,2]=[SOCmin,OCVmin/OCVmax; SOCmax,1]
    "Linear SOC dependent OV"
    annotation(Dialog(group="OCV versus SOC"));
  parameter Real OCV_SOC[:,2]=[SOCmin,OCVmin/OCVmax; SOCmax,1] "OCV/OCVmax versus SOC table"
    annotation(Dialog(group="OCV versus SOC", enable=not useLinearSOCDependency));
  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation"
    annotation(Dialog(group="OCV versus SOC", enable=not useLinearSOCDependency));
  parameter Modelica.SIunits.Current Isc "Short-circuit current at SOC = SOCmax";
  parameter Modelica.SIunits.Resistance Ri=OCVmax/Isc "Total inner resistance";
  parameter Modelica.SIunits.Temperature T_ref=293.15 "Reference temperature";
  parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0 "Temperature coefficient of resistance";
  parameter Modelica.SIunits.Current Idis=0 "Self-discharge current at SOC = SOCmax"
    annotation(Evaluate=true);
  parameter RCData rcData[:] "Parameter of optional RC-elements"
    annotation (Dialog(group="Optional RC-elements"),
      Placement(transformation(extent={{-10,0},{10,20}})));
  final parameter Integer nRC=size(rcData, 1) "Number of RC-elements"
    annotation (Dialog(group="Optional RC-elements"), Evaluate=true);
  parameter Modelica.SIunits.Resistance R0=Ri - sum(rcData.R)
    "Inner resistance without parallel C"
    annotation(Dialog(group="Optional RC-elements"));
  annotation(defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>Collects parameters of battery cells:</p>
<ul>
<li>Nominal charge</li>
<li>OCV versus SOC characteristic</li>
<li>Short-circuit current; used to calculate inner resistance, can be neglected if inner resistance is specified explicitly</li>
<li>Inner resistance; either calculated from short circuit current, or specified explicitly</li>
<li>array of records <code>rcData</code> for battery models comprising RC-elements<li>
</ul>
<h4>Note:</h4>
<p>
If <code>useLinearSOCDependency=true</code>, the OCV versus SOC table is built up internally from <code>OCVmax, OCVmin, SOCmax, SOCmin</code>.<br>
Otherwise, the OCV versus SOC table has to be specified: 1st column = SOC values in ascending order, 2nd column = corresponding OCV values with respect to OCVmax.
</p>
<p>
In a battery model not comprising RC-elements, parameter array <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.RCData\">rcData</a> can be ignored; it is set to a default value.<br>
For a battery model including RC-elements, the size of the array <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.RCData\">rcData</a> defines the count of used RC-elements
as well as the parameters of these.
</p>
<p>
If utilizing the parameter array <a href=\"modelica://Modelica.Electrical.Batteries.ParameterRecords.RCData\">rcData</a>,
the sum of the resistances <code>rcData.R</code> must not exceed the total inner resistance <cde>Ri</code>.
</p>
</html>"));
end CellData;
