within Modelica.Blocks.Continuous.Internal.Filter.base;
function Butterworth
    "Return base filter coefficients of Butterworth filter (= low pass filter with w_cut = 1 rad/s)"
  import Modelica.Constants.pi;
  extends Modelica.Icons.Function;

  input Integer order(min=1) "Order of filter";
  input Boolean normalized=true
      "= true, if amplitude at f_cut = -3db, otherwise unmodified filter";

  output Real cr[mod(order, 2)] "Coefficient of real pole";
  output Real c0[integer(order/2)]
      "Coefficients of s^0 term if conjugate complex pole";
  output Real c1[integer(order/2)]
      "Coefficients of s^1 term if conjugate complex pole";
protected
  Real alpha=1.0 "Frequency correction factor";
  Real alpha2 "= alpha*alpha";
  Real den1[size(cr,1)]
      "[p] coefficients of denominator first order polynomials (a*p + 1)";
  Real den2[size(c0, 1),2]
      "[p^2, p] coefficients of denominator second order polynomials (b*p^2 + a*p + 1)";
algorithm
  for i in 1:size(c0, 1) loop
    den2[i, 1] := 1.0;
    den2[i, 2] := -2*Modelica.Math.cos(pi*(0.5 + (i - 0.5)/order));
  end for;
  if size(cr,1) == 1 then
    den1[1] := 1.0;
  end if;

  /* Transformation of filter transfer function with "new(p) = alpha*p"
     in order that the filter transfer function has an amplitude of
     -3 db at the cutoff frequency
  */
  /*
    if normalized then
      alpha := Internal.normalizationFactor(den1, den2);
      alpha2 := alpha*alpha;
      for i in 1:size(c0, 1) loop
        den2[i, 1] := den2[i, 1]*alpha2;
        den2[i, 2] := den2[i, 2]*alpha;
      end for;
      if size(cr,1) == 1 then
        den1[1] := den1[1]*alpha;
      end if;
    end if;
  */

  // Determine polynomials with highest power of s equal to one
    (cr,c0,c1) :=
      Modelica.Blocks.Continuous.Internal.Filter.Utilities.toHighestPowerOne(
      den1, den2);
end Butterworth;
