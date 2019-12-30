within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record InductionMachineData "Common parameters for induction machines"
  extends Modelica.Icons.Record;
  import Modelica.Constants.pi;
  final parameter Integer m=3 "Number of phases";
  parameter Modelica.SIunits.Inertia Jr=0.29 "Rotor's moment of inertia";
  parameter Modelica.SIunits.Inertia Js=Jr "Stator's moment of inertia";
  parameter Integer p(min=1) = 2 "Number of pole pairs (Integer)";
  parameter Modelica.SIunits.Frequency fsNominal=50 "Nominal frequency";
  parameter Modelica.SIunits.Resistance Rs=0.03
    "Stator resistance per phase at TRef"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Temperature TsRef=293.15
    "Reference temperature of stator resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20s=0
    "Temperature coefficient of stator resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Real effectiveStatorTurns=1 "Effective number of stator turns";
  parameter Modelica.SIunits.Inductance Lszero=Lssigma
    "Stator zero sequence inductance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance Lssigma=3*(1 - sqrt(1 - 0.0667))/
      (2*pi*fsNominal) "Stator stray inductance per phase"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Machines.Losses.FrictionParameters frictionParameters(PRef=0, wRef=
        2*pi*fsNominal/p) "Friction loss parameter record"
    annotation (Dialog(tab="Losses"));
  parameter Machines.Losses.CoreParameters statorCoreParameters(
    final m=m,
    PRef=0,
    VRef=100,
    wRef=2*pi*fsNominal)
    "Stator core loss parameter record; all parameters refer to stator side"
    annotation (Dialog(tab="Losses"));
  parameter Machines.Losses.StrayLoadParameters strayLoadParameters(
    PRef=0,
    IRef=100,
    wRef=2*pi*fsNominal/p) "Stray load losses" annotation (Dialog(tab="Losses"));
  annotation (
    defaultComponentName="inductionMachineData",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>Basic parameters of induction machines are predefined with default values.</p>
</html>"));
end InductionMachineData;
