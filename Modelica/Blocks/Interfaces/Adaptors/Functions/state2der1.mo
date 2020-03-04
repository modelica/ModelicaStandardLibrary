within Modelica.Blocks.Interfaces.Adaptors.Functions;
function state2der1 "Return 1st derivative (der of state2)"
  extends Modelica.Icons.Function;
  input Real u[3] "Required values for state and der(s)";
  input Real dummy
    "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
  input Real dummy_der;
  output Real sder1;
algorithm
  sder1 := u[2];
  annotation (derivative(noDerivative=u, order=2) = state2der2,
      InlineAfterIndexReduction=true);
end state2der1;
