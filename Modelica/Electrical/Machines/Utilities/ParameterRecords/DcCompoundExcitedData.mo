within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record DcCompoundExcitedData "Common parameters for DC machines"
  extends DcPermanentMagnetData(wNominal=1410*2*pi/60);
  import Modelica.Constants.pi;
  parameter SI.Current IeNominal=1
    "Nominal excitation current" annotation (Dialog(tab="Excitation"));
  parameter SI.Resistance Ree=100
    "Shunt excitation resistance at TeRef"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Resistance Res=0.01
    "Series excitation resistance at TeRef"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Temperature TeRef=293.15
    "Reference temperature of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e=0
    "Temperature coefficient of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Inductance Le=1
    "Total field excitation inductance"
    annotation (Dialog(tab="Excitation"));
  parameter Real sigmae(
    min=0,
    max=0.99) = 0 "Stray fraction of total excitation inductance"
    annotation (Dialog(tab="Excitation"));
  parameter Real excitationTurnsRatio=-0.005 "Ratio of series excitation turns over shunt excitation turns"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Temperature TeNominal=293.15
    "Nominal series excitation temperature"
    annotation (Dialog(tab="Nominal parameters"));
  annotation (
    defaultComponentName="dcseData",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>Basic parameters of DC machines are predefined with default values.</p>
</html>"));
end DcCompoundExcitedData;
