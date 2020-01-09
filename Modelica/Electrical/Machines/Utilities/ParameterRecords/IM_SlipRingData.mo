within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record IM_SlipRingData
  "Common parameters for induction machines with slip ring"
  extends InductionMachineData;
  import Modelica.Constants.pi;
  parameter Modelica.SIunits.Inductance Lm=3*sqrt(1 - 0.0667)/(2*pi*
      fsNominal) "Stator main field inductance per phase"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance Lrsigma=3*(1 - sqrt(1 - 0.0667))/
      (2*pi*fsNominal)/turnsRatio^2
    "Rotor stray inductance per phase w.r.t. rotor side"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance Lrzero=Lrsigma/turnsRatio^2
    "Rotor zero sequence inductance w.r.t. rotor side"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Resistance Rr=0.04/turnsRatio^2
    "Rotor resistance per phase at TRef w.r.t. rotor side"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Temperature TrRef=293.15
    "Reference temperature of rotor resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r=0
    "Temperature coefficient of rotor resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Boolean useTurnsRatio=true
    "Use turnsRatio or calculate from locked-rotor voltage?";
  parameter Real turnsRatio(final min=Modelica.Constants.small)=
    VsNominal/VrLockedRotor*(2*pi*fsNominal*Lm)/sqrt(Rs^2 + (2*pi*
    fsNominal*(Lm + Lssigma))^2)
    "Effective number of stator turns / effective number of rotor turns"
    annotation (Dialog(enable=useTurnsRatio));
  parameter Modelica.SIunits.Voltage VsNominal=100
    "Nominal stator voltage per phase"
    annotation (Dialog(enable=not useTurnsRatio));
  parameter Modelica.SIunits.Voltage VrLockedRotor=100*(2*pi*fsNominal*Lm)
      /sqrt(Rs^2 + (2*pi*fsNominal*(Lm + Lssigma))^2)
    "Locked-rotor voltage per phase"
    annotation (Dialog(enable=not useTurnsRatio));
  parameter Machines.Losses.CoreParameters rotorCoreParameters(
    final m=3,
    PRef=0,
    VRef=1,
    wRef=1)
    "Rotor core loss parameter record; all parameters refer to rotor side"
    annotation (Dialog(tab="Losses"));
  annotation (
    defaultComponentName="imsData",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>Basic parameters of induction machines with slip ring are predefined with default values.</p>
</html>"));
end IM_SlipRingData;
