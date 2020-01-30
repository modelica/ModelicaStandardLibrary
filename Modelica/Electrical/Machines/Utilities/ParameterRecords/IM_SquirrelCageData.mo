within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record IM_SquirrelCageData
  "Common parameters for induction machines with squirrel cage"
  extends InductionMachineData;
  import Modelica.Constants.pi;
  parameter SI.Inductance Lm=3*sqrt(1 - 0.0667)/(2*pi*
      fsNominal) "Stator main field inductance per phase"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Inductance Lrsigma=3*(1 - sqrt(1 - 0.0667))/
      (2*pi*fsNominal)
    "Rotor stray inductance per phase (equivalent three-phase winding)"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Resistance Rr=0.04
    "Rotor resistance per phase (equivalent three-phase winding) at TRef"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature TrRef=293.15
    "Reference temperature of rotor resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r=0
    "Temperature coefficient of rotor resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  annotation (
    defaultComponentName="imcData",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>Basic parameters of induction machines with squirrel cage are predefined with default values.</p>
</html>"));
end IM_SquirrelCageData;
