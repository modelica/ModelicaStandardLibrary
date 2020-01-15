within Modelica.ComplexBlocks.Interfaces;
partial block ComplexMIMO
  "Multiple Input Multiple Output continuous control block"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  parameter Integer nin=1 "Number of inputs";
  parameter Integer nout=1 "Number of outputs";
  ComplexInput u[nin] "Connector of Complex input signals" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}})));
  ComplexOutput y[nout] "Connector of Complex output signals" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Boolean useConjugateInput[nin]=fill(false, nin)
    "If true, inputs are processed conjugate complex";
protected
  Complex uInternal[nin]={if useConjugateInput[k] then
      Modelica.ComplexMath.conj(u[k]) else u[k] for k in 1:nin}
    "Equals either u or conjugate complex input u if useComplexInput = true";

  annotation (Documentation(info="<html>
<p>
Block has a continuous Complex input vector and a continuous Complex output signal vector.
The signal sizes of the input and output vector may be different.
</p>
</html>"));
end ComplexMIMO;
