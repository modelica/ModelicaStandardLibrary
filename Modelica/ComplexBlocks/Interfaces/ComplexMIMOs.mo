within Modelica.ComplexBlocks.Interfaces;
partial block ComplexMIMOs
  "Multiple Input Multiple Output continuous control block with same number of inputs and outputs"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  parameter Integer n=1 "Number of inputs (= number of outputs)";
  ComplexInput u[n] "Connector of Complex input signals" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}})));
  ComplexOutput y[n] "Connector of Complex output signals" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));

  parameter Boolean useConjugateInput[n]=fill(false, n)
    "If true, inputs are processed conjugate complex";
protected
  Complex uInternal[n]={if useConjugateInput[k] then
      Modelica.ComplexMath.conj(u[k]) else u[k] for k in 1:n}
    "Equals either u or conjugate complex input u if useComplexInput = true";

  annotation (Documentation(info="<html>
<p>
Block has a continuous Complex input vector and a continuous Complex output signal vector
where the signal sizes of the input and output vector are identical.
</p>
</html>"));
end ComplexMIMOs;
