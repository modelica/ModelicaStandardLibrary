within Modelica.Blocks.Interfaces.Adaptors.Functions;
function state1 "Return state (with one derivative)"
  extends Modelica.Icons.Function;
  input Real u[2] "Required values for state and der(s)";
  input Real dummy
    "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
  output Real s;
algorithm
  s := u[1];
  annotation (derivative(noDerivative=u) = state1der1,
      InlineAfterIndexReduction=true);
end state1;
