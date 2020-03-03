within Modelica.Blocks.Continuous.Internal.Filter.base;
function CriticalDamping
    "Return base filter coefficients of CriticalDamping filter (= low pass filter with w_cut = 1 rad/s)"
  extends Modelica.Icons.Function;

  input Integer order(min=1) "Order of filter";
  input Boolean normalized=true
      "= true, if amplitude at f_cut = -3db, otherwise unmodified filter";

  output Real cr[order] "Coefficients of real poles";
protected
  Real alpha=1.0 "Frequency correction factor";
  Real alpha2 "= alpha*alpha";
  Real den1[order]
      "[p] coefficients of denominator first order polynomials (a*p + 1)";
  Real den2[0,2]
      "[p^2, p] coefficients of denominator second order polynomials (b*p^2 + a*p + 1)";
  Real c0[0] "Coefficients of s^0 term if conjugate complex pole";
  Real c1[0] "Coefficients of s^1 term if conjugate complex pole";
algorithm
  if normalized then
     // alpha := sqrt(2^(1/order) - 1);
     alpha := sqrt(10^(3/10/order)-1);
  else
     alpha := 1.0;
  end if;

  for i in 1:order loop
     den1[i] := alpha;
  end for;

  // Determine polynomials with highest power of s equal to one
    (cr,c0,c1) :=
      Modelica.Blocks.Continuous.Internal.Filter.Utilities.toHighestPowerOne(
      den1, den2);
end CriticalDamping;
