within Modelica.Blocks.Interfaces.Adaptors.Functions;
function state2der2 "Return 2nd derivative (der of state2der1)"
  extends Modelica.Icons.Function;
  input Real u[3] "Required values for state and der(s)";
  input Real dummy
    "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
  input Real dummy_der;
  input Real dummy_der2;
  output Real sder2;
algorithm
  sder2 := u[3];
  annotation (InlineAfterIndexReduction=true);
end state2der2;
