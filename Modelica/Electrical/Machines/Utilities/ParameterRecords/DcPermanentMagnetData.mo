within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record DcPermanentMagnetData "Common parameters for DC machines"
  extends Modelica.Icons.Record;
  import Modelica.Constants.pi;
  parameter Modelica.SIunits.Inertia Jr=0.15 "Rotor's moment of inertia";
  parameter Modelica.SIunits.Inertia Js=Jr "Stator's moment of inertia";
  parameter Modelica.SIunits.Voltage VaNominal=100
    "Nominal armature voltage"
    annotation (Dialog(tab="Nominal parameters"));
  parameter Modelica.SIunits.Current IaNominal=100
    "Nominal armature current (>0..Motor, <0..Generator)"
    annotation (Dialog(tab="Nominal parameters"));
  parameter Modelica.SIunits.AngularVelocity wNominal(displayUnit="rev/min")=
       1425*2*pi/60 "Nominal speed"
    annotation (Dialog(tab="Nominal parameters"));
  parameter Modelica.SIunits.Temperature TaNominal=293.15
    "Nominal armature temperature"
    annotation (Dialog(tab="Nominal parameters"));
  parameter Modelica.SIunits.Resistance Ra=0.05
    "Armature resistance at TaRef"
    annotation (Dialog(tab="Armature"));
  parameter Modelica.SIunits.Temperature TaRef=293.15
    "Reference temperature of armature resistance"
    annotation (Dialog(tab="Armature"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20a=0
    "Temperature coefficient of armature resistance"
    annotation (Dialog(tab="Armature"));
  parameter Modelica.SIunits.Inductance La=0.0015 "Armature inductance"
    annotation (Dialog(tab="Armature"));
  parameter Machines.Losses.FrictionParameters frictionParameters(PRef=0, wRef=
        wNominal) "Friction loss parameter record"
    annotation (Dialog(tab="Losses"));
  parameter Modelica.SIunits.Voltage ViNominal=VaNominal -
      Machines.Thermal.convertResistance(
            Ra,
            TaRef,
            alpha20a,
            TaNominal)*IaNominal -
      Machines.Losses.DCMachines.brushVoltageDrop(brushParameters,
      IaNominal) "Induced voltage at nominal operating point";
  parameter Machines.Losses.CoreParameters coreParameters(
    final m=1,
    PRef=0,
    VRef=ViNominal,
    wRef=wNominal) "Armature core loss parameter record"
    annotation (Dialog(tab="Losses"));
  parameter Machines.Losses.StrayLoadParameters strayLoadParameters(
    PRef=0,
    IRef=IaNominal,
    wRef=wNominal) "Stray load losses" annotation (Dialog(tab="Losses"));
  parameter Machines.Losses.BrushParameters brushParameters(V=0, ILinear=0.01*
        IaNominal) "Brush loss parameter record"
    annotation (Dialog(tab="Losses"));
  annotation (
    defaultComponentName="dcpmData",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>Basic parameters of DC machines are predefined with default values.</p>
</html>"));
end DcPermanentMagnetData;
