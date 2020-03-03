within Modelica.Blocks.Continuous.Internal.Filter.Utilities;
function toHighestPowerOne
  "Transform filter to form with highest power of s equal 1"
  extends Modelica.Icons.Function;

  input Real den1[:] "[s] coefficients of polynomials (den1[i]*s + 1)";
  input Real den2[:,2]
    "[s^2, s] coefficients of polynomials (den2[i,1]*s^2 + den2[i,2]*s + 1)";
  output Real cr[size(den1, 1)]
    "[s^0] coefficients of polynomials cr[i]*(s+1/cr[i])";
  output Real c0[size(den2, 1)]
    "[s^0] coefficients of polynomials (s^2 + (den2[i,2]/den2[i,1])*s + (1/den2[i,1]))";
  output Real c1[size(den2, 1)]
    "[s^1] coefficients of polynomials (s^2 + (den2[i,2]/den2[i,1])*s + (1/den2[i,1]))";
algorithm
  for i in 1:size(den1, 1) loop
    cr[i] := 1/den1[i];
  end for;

  for i in 1:size(den2, 1) loop
    c1[i] := den2[i, 2]/den2[i, 1];
    c0[i] := 1/den2[i, 1];
  end for;
end toHighestPowerOne;
