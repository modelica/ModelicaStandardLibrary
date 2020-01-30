within Modelica.Electrical.Machines.Utilities.ParameterRecords;
record TransformerData "Common parameters for transformers"
  extends Modelica.Icons.Record;
  parameter Real n_phase=1
    "Ratio primary voltage per phase / secondary voltage per phase";
  parameter String C1="Y" "Choose primary connection" annotation (choices(
        choice="Y" "Star connection", choice="D" "Delta connection"));
  parameter String C2="y" "Choose secondary connection" annotation (
      choices(
      choice="y" "Star connection",
      choice="d" "Delta connection",
      choice="z" "Zig-zag connection"));
  parameter Real n=n_phase*(if C1 == "D" and (C2 == "y" or C2 == "z")
       then 1/sqrt(3) else if C1 == "Y" and C2 == "d" then sqrt(3) else 1)
    "Ratio primary voltage (line-to-line) / secondary voltage (line-to-line)"
    annotation (Dialog(enable=false));
  parameter SI.Resistance R1=5E-3/3
    "Primary resistance per phase at TRef"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature T1Ref=293.15
    "Reference temperature of primary resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20_1=0
    "Temperature coefficient of primary resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Inductance L1sigma=78E-6/3
    "Primary stray inductance per phase"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Resistance R2=5E-3/3
    "Secondary resistance per phase at TRef"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Temperature T2Ref=293.15
    "Reference temperature of secondary resistance"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter Machines.Thermal.LinearTemperatureCoefficient20 alpha20_2=0
    "Temperature coefficient of secondary resistance at 20 degC"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  parameter SI.Inductance L2sigma=78E-6/3
    "Secondary stray inductance per phase"
    annotation (Dialog(tab="Nominal resistances and inductances"));
  annotation (
    defaultComponentName="transformerData",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
<p>Basic parameters of transformers are predefined with default values.</p>
<p>Note: ratio n is defined between primary / secondary line-to-line voltage;
   therefore the user has to take into account primary and secondary connection!</p>
</html>"));
end TransformerData;
