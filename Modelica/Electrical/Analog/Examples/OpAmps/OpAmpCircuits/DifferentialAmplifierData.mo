within Modelica.Electrical.Analog.Examples.OpAmps.OpAmpCircuits;
record DifferentialAmplifierData "Data record for differential amplifier"
  extends Modelica.Icons.Record;
  parameter SI.Voltage VSource=400 "Source RMS voltage line-to-line"
    annotation(Dialog(group="Source"));
  parameter SI.Frequency fSource=50 "Source frequency"
    annotation(Dialog(group="Source"));
  parameter SI.Resistance RLoad=10 "Load resistance of source"
    annotation(Dialog(group="Source"));
  parameter SI.Resistance RGround=100e3 "Resistance of ground connection"
    annotation(Dialog(group="Source"));
  parameter Real V0=10e3 "No-load differential amplification"
    annotation(Dialog(group="OpAmp"));
  parameter SI.Voltage VSupply=15 "Supply voltage"
    annotation(Dialog(group="OpAmp"));
  parameter Real k=100 "Attenuation factor"
    annotation(Dialog(group="OpAmp"));
  parameter SI.Resistance R1=100e3 "Resistor 1"
    annotation(Dialog(group="OpAmp"));
  parameter SI.Resistance R2=R1 "Resistor 2"
    annotation(Dialog(group="OpAmp"));
  parameter SI.Resistance R3=R1/k "Resistor 3"
    annotation(Dialog(group="OpAmp"));
  parameter SI.Resistance R4=R3 "Resistor 4"
    annotation(Dialog(group="OpAmp"));
  parameter SI.Resistance RInstrument=100e3 "Input resistance of instrument"
    annotation(Dialog(group="Measurement"));
  annotation (defaultComponentPrefixes="parameter", defaultComponentName="data",
    Documentation(info="<html>
<p>
Summarizes parameters for:
</p>
<ul>
<li>Source</li>
<li>Differential amplifier</li>
<li>Measurement instrument</li>
</ul>
</html>"));
end DifferentialAmplifierData;
