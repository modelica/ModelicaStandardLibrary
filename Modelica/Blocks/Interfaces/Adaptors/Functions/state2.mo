within Modelica.Blocks.Interfaces.Adaptors.Functions;
function state2 "Return state (with two derivatives)"
  extends Modelica.Icons.Function;
  input Real u[3] "Required values for state and der(s)";
  input Real dummy
    "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
  output Real s;
algorithm
  s := u[1];
  annotation (derivative(noDerivative=u) = state2der1,
      InlineAfterIndexReduction=true);
end state2;
