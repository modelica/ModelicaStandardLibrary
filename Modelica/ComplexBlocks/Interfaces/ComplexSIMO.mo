within Modelica.ComplexBlocks.Interfaces;
partial block ComplexSIMO
  "Single Input Multiple Output continuous control block"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  parameter Integer nout=1 "Number of outputs";

  ComplexInput u "Connector of Complex input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  ComplexOutput y[nout] "Connector of Complex output signals" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));

  parameter Boolean useConjugateInput=false
    "If true, input is processed conjugate complex";
protected
  Complex uInternal=(if useConjugateInput then Modelica.ComplexMath.conj(u)
       else u)
    "Equals either u or conjugate complex input u if useComplexInput = true";

  annotation (Documentation(info="<html>
<p>
 Block has one continuous Complex input signal and a
vector of continuous Complex output signals.
</p>
</html>"));
end ComplexSIMO;
