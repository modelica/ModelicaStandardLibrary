within Modelica.Blocks.Continuous.Internal.Filter.roots;
function bandPass
    "Return band pass filter roots as needed for block for given cut-off frequency"
  extends Modelica.Icons.Function;

  input Real cr_in[:] "Coefficients of real poles of base filter";
  input Real c0_in[:]
      "Coefficients of s^0 term of base filter if conjugate complex pole";
  input Real c1_in[size(c0_in,1)]
      "Coefficients of s^1 term of base filter if conjugate complex pole";
  input SI.Frequency f_min
      "Band of band pass filter is f_min (A=-3db) .. f_max (A=-3db)";
  input SI.Frequency f_max "Upper band frequency";

  output Real a[size(cr_in,1) + 2*size(c0_in,1)]
      "Real parts of complex conjugate eigenvalues";
  output Real b[size(cr_in,1) + 2*size(c0_in,1)]
      "Imaginary parts of complex conjugate eigenvalues";
  output Real ku[size(cr_in,1) + 2*size(c0_in,1)] "Gains of input terms";
  output Real k1[size(cr_in,1) + 2*size(c0_in,1)]
      "Gains of y = k1*x1 + k2*x";
  output Real k2[size(cr_in,1) + 2*size(c0_in,1)]
      "Gains of y = k1*x1 + k2*x";
protected
  Real cr[0];
  Real c0[size(a,1)];
  Real c1[size(a,1)];
  Real cn;
  Real bb;
algorithm
  // Get coefficients of band pass filter at f_cut
  (cr, c0, c1, cn) :=coefficients.bandPass(cr_in, c0_in, c1_in, f_min, f_max);

  // Transform coefficients in to roots
  for i in 1:size(a,1) loop
    a[i]  := -c1[i]/2;
    bb    := c0[i] - a[i]*a[i];
    assert(bb >= 0, "\nNot possible to use band pass filter, since transformation results in\n"+
                    "system that does not have conjugate complex poles.\n" +
                    "Try to use another analog filter for the band pass.\n");
    b[i]  := sqrt(bb);
    ku[i] := c0[i]/b[i];
    k1[i] := cn/ku[i];
    k2[i] := cn*a[i]/(b[i]*ku[i]);
  end for;

  annotation (Documentation(info="<html>

<p>
The goal is to implement the filter in the following form:
</p>

<blockquote><pre>
// complex conjugate poles:
der(x1) = a*x1 - b*x2 + ku*u;
der(x2) = b*x1 + a*x2;
     y  = k1*x1 + k2*x2;

          ku = (a^2 + b^2)/b
          k1 = cn/ku
          k2 = cn*a/(b*ku)
</pre></blockquote>
<p>
This representation has the following transfer function:
</p>
<blockquote><pre>
// complex conjugate poles
    s*x2 =  a*x2 + b*x1
    s*x1 = -b*x2 + a*x1 + ku*u
  or
    (s-a)*x2               = b*x1  ->  x2 = b/(s-a)*x1
    (s + b^2/(s-a) - a)*x1 = ku*u  ->  (s(s-a) + b^2 - a*(s-a))*x1  = ku*(s-a)*u
                                   ->  (s^2 - 2*a*s + a^2 + b^2)*x1 = ku*(s-a)*u
  or
    x1 = ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
    x2 = b/(s-a)*ku*(s-a)/(s^2 - 2*a*s + a^2 + b^2)*u
       = b*ku/(s^2 - 2*a*s + a^2 + b^2)*u
    y  = k1*x1 + k2*x2
       = (k1*ku*(s-a) + k2*b*ku) / (s^2 - 2*a*s + a^2 + b^2)*u
       = (k1*ku*s + k2*b*ku - k1*ku*a) / (s^2 - 2*a*s + a^2 + b^2)*u
       = (cn*s + cn*a - cn*a) / (s^2 - 2*a*s + a^2 + b^2)*u
       = cn*s / (s^2 - 2*a*s + a^2 + b^2)*u

  comparing coefficients with
    y = cn*s / (s^2 + c1*s + c0)*u  ->  a = -c1/2
                                        b = sqrt(c0 - a^2)

  comparing with eigenvalue representation:
    (s - (a+jb))*(s - (a-jb)) = s^2 -2*a*s + a^2 + b^2
  shows that:
    a: real part of eigenvalue
    b: imaginary part of eigenvalue
</pre></blockquote>

</html>"));
end bandPass;
