within Modelica.Electrical.QuasiStatic.SinglePhase.Utilities;
model IdealACDCConverter "Ideal AC DC converter"
  parameter Real conversionFactor "Ratio of DC voltage / QS rms voltage";
  import Modelica.ComplexMath.real;
  import Modelica.ComplexMath.imag;
  import Modelica.ComplexMath.conj;
  import Modelica.ComplexMath.abs;
  import Modelica.ComplexMath.arg;
  SI.ComplexVoltage vQS=pin_pQS.v - pin_nQS.v "AC QS voltage";
  SI.ComplexCurrent iQS=pin_pQS.i "AC QS current";
  output SI.Voltage vQSabs=abs(vQS) "Abs(AC QS voltage)";
  output SI.Current iQSabs=abs(iQS) "Abs(AC QS current)";
  SI.ComplexPower sQS=vQS*conj(iQS) "AC QS apparent power";
  SI.ActivePower pQS=real(sQS) "AC QS active power";
  SI.ReactivePower qQS=imag(sQS) "AC QS reactive power";
  SI.Voltage vDC=pin_pDC.v - pin_nDC.v "DC voltage";
  SI.Current iDC=pin_pDC.i "DC current";
  SI.Power pDC=vDC*iDC "DC power";
  Interfaces.PositivePin pin_pQS annotation (Placement(transformation(
          extent={{-110,110},{-90,90}}), iconTransformation(extent={{-110,
            110},{-90,90}})));
  Interfaces.NegativePin pin_nQS annotation (Placement(transformation(
          extent={{-110,-110},{-90,-90}}), iconTransformation(extent={{-110,
            -110},{-90,-90}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_pDC annotation (
      Placement(transformation(extent={{90,110},{110,90}}), iconTransformation(
          extent={{90,110},{110,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_nDC annotation (
      Placement(transformation(extent={{90,-110},{110,-90}}),
        iconTransformation(extent={{90,-110},{110,-90}})));
equation
  //QS balances
  Connections.branch(pin_pQS.reference, pin_nQS.reference);
  pin_pQS.reference.gamma = pin_nQS.reference.gamma;
  pin_pQS.i + pin_nQS.i = Complex(0);
  //DC current balance
  pin_pDC.i + pin_nDC.i = 0;
  //voltage relation
  vDC = abs(vQS)*conversionFactor;
  //power balance
  pQS + pDC = 0;
  //define reactive power
  qQS = 0;
  annotation (defaultComponentName="rectifier", Icon(graphics={
        Line(
          points={{2,40},{70,40},{2,40},{70,-50},{2,-50},{2,40},{2,-50}},
          color={0,0,255}),
        Text(
          extent={{50,30},{100,0}},
          textColor={0,0,255},
          textString="DC"),
        Line(
          points={{-2,40},{-2,40},{-70,40},{-2,40},{-70,-50},{-2,-50},{-2,40},{-2,-50}},
          color={85,170,255}),
        Text(
          extent={{-90,30},{-40,0}},
          textColor={85,170,255},
          textString="QS"),
        Text(
          extent={{-150,90},{150,50}},
          textColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-150,-50},{150,-90}},
          textString="%conversionFactor")}), Documentation(info="<html>
<p>
This is an ideal AC DC converter, based on a power balance between QS circuit and DC side.
The parameter <em>conversionFactor</em> defines the ratio between averaged DC voltage and QS rms voltage.
Furthermore, reactive power at the QS side is set to 0.
</p>
<h4>Note</h4>
<p>
Of course no voltage or current ripple is present, neither at the QS side nor at the DC side.
At the QS side, only base harmonics of voltage and current are taken into account.
At the DC side, only the mean of voltage and current are taken into account.
</p>
</html>"));
end IdealACDCConverter;
