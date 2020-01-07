within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record DcElectricalExcitedData "Common parameters for DC machines"
  extends DcPermanentMagnetData;
  parameter Modelica.SIunits.Current IeNominal=1
    "Nominal excitation current" annotation (Dialog(tab="Excitation"));
  parameter Modelica.SIunits.Resistance Re=100
    "Field excitation resistance at TeRef"
    annotation (Dialog(tab="Excitation"));
  parameter Modelica.SIunits.Temperature TeRef=293.15
    "Reference temperature of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e=0
    "Temperature coefficient of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter Modelica.SIunits.Inductance Le=1
    "Total field excitation inductance"
    annotation (Dialog(tab="Excitation"));
  parameter Real sigmae(
    min=0,
    max=0.99) = 0 "Stray fraction of total excitation inductance"
    annotation (Dialog(tab="Excitation"));
  annotation (
    defaultComponentName="dceeData",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>Basic parameters of DC machines are predefined with default values.</p>
</html>"));
end DcElectricalExcitedData;
