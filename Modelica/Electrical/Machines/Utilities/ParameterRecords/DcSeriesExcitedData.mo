within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record DcSeriesExcitedData "Common parameters for DC machines"
  extends DcPermanentMagnetData(wNominal=1410*2*pi/60);
  import Modelica.Constants.pi;
  parameter Modelica.SIunits.Resistance Re=0.01
    "Series excitation resistance at TeRef"
    annotation (Dialog(tab="Excitation"));
  parameter Modelica.SIunits.Temperature TeRef=293.15
    "Reference temperature of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e=0
    "Temperature coefficient of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter Modelica.SIunits.Inductance Le=0.0005
    "Total field excitation inductance"
    annotation (Dialog(tab="Excitation"));
  parameter Real sigmae(
    min=0,
    max=0.99) = 0 "Stray fraction of total excitation inductance"
    annotation (Dialog(tab="Excitation"));
  parameter Modelica.SIunits.Temperature TeNominal=293.15
    "Nominal series excitation temperature"
    annotation (Dialog(tab="Nominal parameters"));
  annotation (
    defaultComponentName="dcseData",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>Basic parameters of DC machines are predefined with default values.</p>
</html>"));
end DcSeriesExcitedData;
