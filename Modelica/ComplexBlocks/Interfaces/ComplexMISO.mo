within Modelica.ComplexBlocks.Interfaces;
partial block ComplexMISO
  "Multiple Input Single Output continuous control block"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  parameter Integer nin=1 "Number of inputs";
  ComplexInput u[nin] "Connector of Complex input signals" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}})));
  ComplexOutput y "Connector of Complex output signal" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));

  parameter Boolean useConjugateInput[nin]=fill(false, nin)
    "If true, inputs are processed conjugate complex";
protected
  Complex uInternal[nin]={if useConjugateInput[k] then
      Modelica.ComplexMath.conj(u[k]) else u[k] for k in 1:nin}
    "Equals either u or conjugate complex input u if useComplexInput = true";

  annotation (Documentation(info="<html>
<p>
Block has a vector of continuous Complex input signals and
one continuous Complex output signal.
</p>
</html>"));
end ComplexMISO;
