within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record SM_PermanentMagnetData
  "Common parameters for synchronous machines with permanent magnet"
  extends SM_ReluctanceRotorData(Lmd=0.3/(2*pi*fsNominal), Lmq=0.3/(2*pi*
        fsNominal));
  import Modelica.Constants.pi;
  parameter SI.Voltage VsOpenCircuit=112.3
    "Open circuit RMS voltage per phase @ fsNominal";
  parameter Machines.Losses.PermanentMagnetLossParameters permanentMagnetLossParameters(
    PRef=0,
    IRef=100,
    wRef=2*pi*fsNominal/p) "Permanent magnet loss parameter record"
    annotation (Dialog(tab="Losses"));
  annotation (
    defaultComponentName="smpmData",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>Basic parameters of synchronous machines with permanent magnet are predefined with default values.</p>
</html>"));
end SM_PermanentMagnetData;
