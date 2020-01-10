within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record SM_ReluctanceRotorData
  "Common parameters for synchronous machines with reluctance rotor"
  extends InductionMachineData(Lssigma=0.1/(2*pi*fsNominal));
  import Modelica.Constants.pi;
  parameter Modelica.SIunits.Inductance Lmd=2.9/(2*pi*fsNominal)
    "Stator main field inductance per phase in d-axis"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Modelica.SIunits.Inductance Lmq=0.9/(2*pi*fsNominal)
    "Stator main field inductance per phase in q-axis"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Boolean useDamperCage=true "Enable / disable damper cage"
    annotation (Evaluate=true,Dialog(tab=
          "Nominal resistances and inductances", group="Damper cage"));
  parameter Modelica.SIunits.Inductance Lrsigmad=0.05/(2*pi*fsNominal)
    "Damper stray inductance in d-axis" annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
    "Damper stray inductance in q-axis" annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter Modelica.SIunits.Resistance Rrd=0.04
    "Damper resistance in d-axis at TRef" annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter Modelica.SIunits.Resistance Rrq=Rrd
    "Damper resistance in q-axis at TRef" annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter Modelica.SIunits.Temperature TrRef=293.15
    "Reference temperature of damper resistances in d- and q-axis"
    annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20r=0
    "Temperature coefficient of damper resistances in d- and q-axis"
    annotation (Dialog(
      tab="Nominal resistances and inductances",
      group="Damper cage",
      enable=useDamperCage));
  annotation (
    defaultComponentName="smrData",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>Basic parameters of synchronous machines with reluctance rotor are predefined with default values.</p>
</html>"));
end SM_ReluctanceRotorData;
