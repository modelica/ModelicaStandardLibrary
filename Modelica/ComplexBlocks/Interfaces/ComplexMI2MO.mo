within Modelica.ComplexBlocks.Interfaces;
partial block ComplexMI2MO
  "2 Multiple Input / Multiple Output continuous control block"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  parameter Integer n=1 "Dimension of input and output vectors.";
  ComplexInput u1[n] "Connector 1 of Complex input signals" annotation (
      Placement(transformation(extent={{-140,40},{-100,80}})));
  ComplexInput u2[n] "Connector 2 of Complex input signals" annotation (
      Placement(transformation(extent={{-140,-80},{-100,-40}})));
  ComplexOutput y[n] "Connector of Complex output signals" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));

  parameter Boolean useConjugateInput1[n]=fill(false, n)
    "If true, inputs 1 are processed conjugate complex";
  parameter Boolean useConjugateInput2[n]=fill(false, n)
    "If true, inputs 2 are processed conjugate complex";
protected
  Complex u1Internal[n]={if useConjugateInput1[k] then
      Modelica.ComplexMath.conj(u1[k]) else u1[k] for k in 1:n}
    "Equals either u1 or conjugate complex input u1 if useComplexInput = true";
  Complex u2Internal[n]={if useConjugateInput2[k] then
      Modelica.ComplexMath.conj(u2[k]) else u2[k] for k in 1:n}
    "Equals either u1 or conjugate complex input u1 if useComplexInput = true";

  annotation (Documentation(info="<html>
<p>
Block has two continuous Complex input vectors u1 and u2 and one
continuous Complex output vector y.
All vectors have the same number of elements.
</p>
</html>"));
end ComplexMI2MO;
