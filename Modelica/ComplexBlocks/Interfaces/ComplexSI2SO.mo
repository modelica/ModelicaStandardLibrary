within Modelica.ComplexBlocks.Interfaces;
partial block ComplexSI2SO
  "2 Single Input / 1 Single Output continuous control block"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  ComplexInput u1 "Connector of Complex input signal 1" annotation (
      Placement(transformation(extent={{-140,40},{-100,80}})));
  ComplexInput u2 "Connector of Complex input signal 2" annotation (
      Placement(transformation(extent={{-140,-80},{-100,-40}})));
  ComplexOutput y "Connector of Complex output signal" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Boolean useConjugateInput1=false
    "If true, input 1 is processed conjugate complex";
  parameter Boolean useConjugateInput2=false
    "If true, input 2 is processed conjugate complex";
protected
  Complex u1Internal=(if useConjugateInput1 then Modelica.ComplexMath.conj(
      u1) else u1)
    "Equals either u1 or conjugate complex input u1 if useComplexInput1 = true";
  Complex u2Internal=(if useConjugateInput2 then Modelica.ComplexMath.conj(
      u2) else u2)
    "Equals either u2 or conjugate complex input u2 if useComplexInput2 = true";
  annotation (Documentation(info="<html>
<p>
Block has two continuous Complex input signals u1 and u2 and one
continuous Complex output signal y.
</p>
</html>"));
end ComplexSI2SO;
