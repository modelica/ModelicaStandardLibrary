within Modelica.Blocks.Interfaces.Adaptors.Functions;
function state1der1 "Return 1st derivative (der of state1)"
  extends Modelica.Icons.Function;
  input Real u[2] "Required values for state and der(s)";
  input Real dummy
    "Just to have one input signal that should be differentiated to avoid possible problems in the Modelica tool (is not used)";
  input Real dummy_der;
  output Real sder1;
algorithm
  sder1 := u[2];
  annotation (InlineAfterIndexReduction=true);
end state1der1;
