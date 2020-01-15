within Modelica.ComplexBlocks.Interfaces;
partial block ComplexSISO
  "Single Input Single Output continuous control block"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  ComplexInput u "Connector of Complex input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  ComplexOutput y "Connector of Complex output signal" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Boolean useConjugateInput=false
    "If true, input is processed conjugate complex";
protected
  Complex uInternal=(if useConjugateInput then Modelica.ComplexMath.conj(u)
       else u)
    "Equals either u or conjugate complex input u if useComplexInput = true";
  annotation (Documentation(info="<html>
<p>
Block has one continuous Complex input and one continuous Complex output signal.
</p>
</html>"));
end ComplexSISO;
