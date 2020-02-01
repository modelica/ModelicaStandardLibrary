within Modelica.Electrical.Machines.Utilities;
record TransformerData "Calculates Impedances from nominal values"
  extends Modelica.Icons.Record;
  parameter SI.Frequency f(start=50) "Nominal frequency";
  parameter SI.Voltage V1(start=100)
    "Primary nominal line-to-line voltage (RMS)";
  parameter String C1(start="Y") "Choose primary connection" annotation (
      choices(choice="Y" "Star connection", choice="D" "Delta connection"));
  parameter SI.Voltage V2(start=100)
    "Secondary open circuit line-to-line voltage (RMS) @ primary nominal voltage";
  parameter String C2(start="y") "Choose secondary connection" annotation (
      choices(
      choice="y" "Star connection",
      choice="d" "Delta connection",
      choice="z" "Zig-zag connection"));
  parameter SI.ApparentPower SNominal(start=30E3)
    "Nominal apparent power";
  parameter Real v_sc(
    final min=0,
    final max=1,
    start=0.05) "Impedance voltage drop pu";
  parameter SI.Power P_sc(start=300)
    "Short-circuit (copper) losses";
  parameter Real n=V1/V2
    "Ratio primary voltage (line-to-line) / secondary voltage (line-to-line)"
    annotation (Dialog(tab="Result",enable=false));
  final parameter SI.Voltage V1ph=V1/(if C1 == "D" then 1
       else sqrt(3)) "Primary phase voltage (RMS)";
  final parameter SI.Current I1ph=SNominal/(3*V1ph)
    "Primary phase current (RMS)";
  final parameter SI.Voltage V2ph=V2/(if C2 == "d" then 1
       else sqrt(3)) "Secondary phase voltage (RMS)";
  final parameter SI.Current I2ph=SNominal/(3*V2ph)
    "Secondary phase current (RMS)";
  final parameter SI.Impedance Z1ph=0.5*v_sc*V1ph/I1ph
    "Primary impedance per phase";
  parameter SI.Resistance R1=0.5*P_sc/(3*I1ph^2)
    "Warm primary resistance per phase"
    annotation (Dialog(tab="Result",enable=false));
  parameter SI.Inductance L1sigma=sqrt(Z1ph^2 - R1^2)/(2*
      Modelica.Constants.pi*f) "Primary stray inductance per phase"
    annotation (Dialog(tab="Result",enable=false));
  final parameter SI.Impedance Z2ph=0.5*v_sc*V2ph/I2ph
    "Secondary impedance per phase";
  parameter SI.Resistance R2=0.5*P_sc/(3*I2ph^2)
    "Warm secondary resistance per phase"
    annotation (Dialog(tab="Result",enable=false));
  parameter SI.Inductance L2sigma=sqrt(Z2ph^2 - R2^2)/(2*
      Modelica.Constants.pi*f) "Secondary stray inductance per phase"
    annotation (Dialog(tab="Result",enable=false));
  annotation (defaultComponentPrefixes="parameter",Documentation(info="<html>
<p>The parameters of the transformer models are calculated from parameters normally given in a technical description.</p>
</html>"));
end TransformerData;
