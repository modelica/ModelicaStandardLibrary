within Modelica.Blocks.Continuous.Internal.Filter.base;
function ChebyshevI
    "Return base filter coefficients of Chebyshev I filter (= low pass filter with w_cut = 1 rad/s)"
  import Modelica.Math.asinh;
  import Modelica.Constants.pi;

  extends Modelica.Icons.Function;

  input Integer order(min=1) "Order of filter";
  input Real A_ripple = 0.5 "Pass band ripple in [dB]";
  input Boolean normalized=true
      "= true, if amplitude at f_cut = -3db, otherwise unmodified filter";

  output Real cr[mod(order, 2)] "Coefficient of real pole";
  output Real c0[integer(order/2)]
      "Coefficients of s^0 term if conjugate complex pole";
  output Real c1[integer(order/2)]
      "Coefficients of s^1 term if conjugate complex pole";
protected
  Real epsilon;
  Real fac;
  Real alpha=1.0 "Frequency correction factor";
  Real alpha2 "= alpha*alpha";
  Real den1[size(cr,1)]
      "[p] coefficients of denominator first order polynomials (a*p + 1)";
  Real den2[size(c0, 1),2]
      "[p^2, p] coefficients of denominator second order polynomials (b*p^2 + a*p + 1)";
algorithm
    epsilon := sqrt(10^(A_ripple/10) - 1);
    fac := asinh(1/epsilon)/order;

    den1 := fill(1/sinh(fac),size(den1,1));
    if size(cr,1) == 0 then
       for i in 1:size(c0, 1) loop
          den2[i,1] :=1/(cosh(fac)^2 - cos((2*i - 1)*pi/(2*order))^2);
          den2[i,2] :=2*den2[i, 1]*sinh(fac)*cos((2*i - 1)*pi/(2*order));
       end for;
    else
       for i in 1:size(c0, 1) loop
          den2[i,1] :=1/(cosh(fac)^2 - cos(i*pi/order)^2);
          den2[i,2] :=2*den2[i, 1]*sinh(fac)*cos(i*pi/order);
       end for;
    end if;

    /* Transformation of filter transfer function with "new(p) = alpha*p"
       in order that the filter transfer function has an amplitude of
       -3 db at the cutoff frequency
    */
    if normalized then
      alpha :=
        Modelica.Blocks.Continuous.Internal.Filter.Utilities.normalizationFactor(
        den1, den2);
      alpha2 := alpha*alpha;
      for i in 1:size(c0, 1) loop
        den2[i, 1] := den2[i, 1]*alpha2;
        den2[i, 2] := den2[i, 2]*alpha;
      end for;
      den1 := den1*alpha;
    end if;

  // Determine polynomials with highest power of s equal to one
    (cr,c0,c1) :=
      Modelica.Blocks.Continuous.Internal.Filter.Utilities.toHighestPowerOne(
      den1, den2);
end ChebyshevI;
