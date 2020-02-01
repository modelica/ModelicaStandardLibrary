within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record SM_ElectricalExcitedData
  "Common parameters for synchronous machines with electrical excitation"
  extends SM_ReluctanceRotorData(Lmd=1.5/(2*pi*fsNominal), Lmq=1.5/(2*pi*
        fsNominal));
  import Modelica.Constants.pi;
  parameter SI.Voltage VsNominal=100
    "Nominal stator RMS voltage per phase"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Current IeOpenCircuit=10
    "Open circuit excitation current @ nominal voltage and frequency"
    annotation (Dialog(tab="Excitation"));
  parameter SI.Resistance Re=2.5
    "Excitation resistance at TRef" annotation (Dialog(tab="Excitation"));
  parameter SI.Temperature TeRef=293.15
    "Reference temperature of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20e=0
    "Temperature coefficient of excitation resistance"
    annotation (Dialog(tab="Excitation"));
  parameter Real sigmae(
    min=0,
    max=0.99) = 0.025 "Stray fraction of total excitation inductance"
    annotation (Dialog(tab="Excitation"));
  parameter Machines.Losses.BrushParameters brushParameters(V=0, ILinear=0.01)
    "Brush loss parameter record" annotation (Dialog(tab="Losses"));
  annotation (
    defaultComponentName="smeeData",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>Basic parameters of synchronous machines with electrical excitation are predefined with default values.</p>
</html>"));
end SM_ElectricalExcitedData;
