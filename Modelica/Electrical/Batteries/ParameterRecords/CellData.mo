within Modelica.Electrical.Batteries.ParameterRecords;
record CellData "Parameters of a battery cell"
  extends Modelica.Electrical.Batteries.Icons.BaseCellRecord;
  parameter SI.ElectricCharge Qnom(displayUnit="A.h")
    "Nominal (maximum) charge";
  parameter Boolean useLinearSOCDependency=true
    "Use a linear SOC dependent OCV, otherwise table based"
    annotation(Dialog(group="OCV versus SOC"));
  parameter SI.Voltage OCVmax(final min=0) "OCV at SOC = SOCmax"
    annotation(Dialog(group="OCV versus SOC"));
  parameter SI.Voltage OCVmin(final min=0, start=0) "OCV at SOC = SOCmin"
    annotation(Dialog(group="OCV versus SOC", enable=useLinearSOCDependency));
  parameter Real SOCmax(final max=1)=1 "Maximum state of charge"
    annotation(Dialog(group="OCV versus SOC"));
  parameter Real SOCmin(final min=0)=0 "Minimum state of charge"
    annotation(Dialog(group="OCV versus SOC"));
  parameter Real OCV_SOC[:,2]=[SOCmin,OCVmin/OCVmax; SOCmax,1] "OCV/OCVmax versus SOC table"
    annotation(Dialog(group="OCV versus SOC", enable=not useLinearSOCDependency));
  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation"
    annotation(Dialog(group="OCV versus SOC", enable=not useLinearSOCDependency));
  final parameter Real OCV_SOC_internal[:,2]=
    if useLinearSOCDependency then [SOCmin,OCVmin/OCVmax; SOCmax,1] else OCV_SOC
    "OCV/OCVmax versus SOC used internal"
    annotation(Dialog(group="OCV versus SOC"));
  parameter SI.Resistance Ri "Total inner resistance (= OCVmax/Isc)";
  parameter SI.Temperature T_ref=293.15 "Reference temperature";
  parameter SI.LinearTemperatureCoefficient alpha=0 "Temperature coefficient of resistance at T_ref";
  parameter SI.Current Idis=0 "Self-discharge current at SOC = SOCmax"
    annotation(Evaluate=true);
  parameter SI.Resistance R0=Ri
    "Inner resistance without parallel C";
  annotation(defaultComponentPrefixes="parameter", Documentation(info="<html>
<p>Collects parameters of battery cells:</p>
<ul>
<li>Nominal charge</li>
<li>OCV versus SOC characteristic</li>
<li>Inner resistance; can be calculated from OCVmax / short-circuit current (at OCVmax)</li>
</ul>
<h4>Note</h4>
<p>
If <code>useLinearSOCDependency=true</code>, the OCV versus SOC table is built up internally from <code>OCVmax, OCVmin, SOCmax, SOCmin</code>.<br>
Otherwise, the OCV versus SOC table has to be specified: 1st column = SOC values in ascending order, 2nd column = corresponding OCV values with respect to OCVmax.
</p>
</html>"));
end CellData;
