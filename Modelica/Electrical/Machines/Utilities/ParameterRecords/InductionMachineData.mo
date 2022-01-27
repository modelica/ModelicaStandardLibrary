within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record InductionMachineData "Common parameters for induction machines"
  extends Modelica.Icons.Record;
  import Modelica.Constants.pi;
  parameter Integer m=3 "Number of phases" annotation(Evaluate=true);
  parameter SI.Inertia Jr=0.29 "Rotor's moment of inertia";
  parameter SI.Inertia Js=Jr "Stator's moment of inertia";
  parameter Integer p(min=1) = 2 "Number of pole pairs (Integer)";
  parameter SI.Frequency fsNominal=50 "Nominal frequency";
  parameter SI.Resistance Rs=0.03
    "Stator resistance per phase at TRef"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature TsRef=293.15
    "Reference temperature of stator resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20s=0
    "Temperature coefficient of stator resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Real effectiveStatorTurns=1 "Effective number of stator turns";
  parameter SI.Inductance Lszero=Lssigma
    "Stator zero sequence inductance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Inductance Lssigma=3*(1 - sqrt(1 - 0.0667))/
      (2*pi*fsNominal) "Stator stray inductance per phase"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Real ratioCommonStatorLeakage(final min=0, final max=1)=1
    "Ratio of common stray inductance / total stray inductance of stator winding"
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
