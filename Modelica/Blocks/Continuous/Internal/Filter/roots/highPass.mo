within Modelica.Blocks.Continuous.Internal.Filter.roots;
function highPass
    "Return high pass filter roots as needed for block for given cut-off frequency"
  extends Modelica.Icons.Function;

  input Real cr_in[:] "Coefficients of real poles of base filter";
  input Real c0_in[:]
      "Coefficients of s^0 term of base filter if conjugate complex pole";
  input Real c1_in[size(c0_in,1)]
      "Coefficients of s^1 term of base filter if conjugate complex pole";
  input SI.Frequency f_cut "Cut-off frequency";

  output Real r[size(cr_in,1)] "Real eigenvalues";
  output Real a[size(c0_in,1)]
      "Real parts of complex conjugate eigenvalues";
  output Real b[size(c0_in,1)]
      "Imaginary parts of complex conjugate eigenvalues";
  output Real ku[size(c0_in,1)] "Gains of input terms";
  output Real k1[size(c0_in,1)] "Gains of y = k1*x1 + k2*x + u";
  output Real k2[size(c0_in,1)] "Gains of y = k1*x1 + k2*x + u";
protected
  Real c0[size(c0_in,1)];
  Real c1[size(c0_in,1)];
  Real cr[size(cr_in,1)];
  Real ba2;
algorithm
  // Get coefficients of high pass filter at f_cut
  (cr, c0, c1) :=coefficients.highPass(cr_in, c0_in, c1_in, f_cut);

  // Transform coefficients in to roots
  for i in 1:size(cr_in,1) loop
    r[i] :=-cr[i];
  end for;

  for i in 1:size(c0_in,1) loop
    a[i]  := -c1[i]/2;
    b[i]  := sqrt(c0[i] - a[i]*a[i]);
    ku[i] := c0[i]/b[i];
    k1[i] := 2*a[i]/ku[i];
    ba2   := (b[i]/a[i])^2;
    k2[i] := (1-ba2)/(1+ba2);
  end for;

  annotation (Documentation(info="<html>

<p>
The goal is to implement the filter in the following form:
</p>

<blockquote><pre>
// real pole:
 der(x) = r*x - r*u
     y  = -x + u

// complex conjugate poles:
der(x1) = a*x1 - b*x2 + ku*u;
der(x2) = b*x1 + a*x2;
     y  = k1*x1 + k2*x2 + u;

          ku = (a^2 + b^2)/b
          k1 = 2*a/ku
          k2 = (a^2 - b^2) / (b*ku)
             = (a^2 - b^2) / (a^2 + b^2)
             = (1 - (b/a)^2) / (1 + (b/a)^2)
</pre></blockquote>
<p>
This representation has the following transfer function:
</p>
<blockquote><pre>
// real pole:
    s*x = r*x - r*u
  or
    (s-r)*x = -r*u   -> x = -r/(s-r)*u
  or
    y = r/(s-r)*u + (s-r)/(s-r)*u
      = (r+s-r)/(s-r)*u
      = s/(s-r)*u

// comparing coefficients with
    y = s/(s + cr)*u  ->  r = -cr      // r is the real eigenvalue

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
    y  = k1*x1 + k2*x2 + u
       = (k1*ku*(s-a) + k2*b*ku +  s^2 - 2*a*s + a^2 + b^2) /
         (s^2 - 2*a*s + a^2 + b^2)*u
       = (s^2 + (k1*ku - 2*a)*s + k2*b*ku - k1*ku*a + a^2 + b^2) /
         (s^2 - 2*a*s + a^2 + b^2)*u
       = (s^2 + (2*a-2*a)*s + a^2 - b^2 - 2*a^2 + a^2 + b^2) /
         (s^2 - 2*a*s + a^2 + b^2)*u
       = s^2 / (s^2 - 2*a*s + a^2 + b^2)*u

// comparing coefficients with
    y = s^2/(s^2 + c1*s + c0)*u  ->  a = -c1/2
                                     b = sqrt(c0 - a^2)

// comparing with eigenvalue representation:
    (s - (a+jb))*(s - (a-jb)) = s^2 -2*a*s + a^2 + b^2
// shows that:
//   a: real part of eigenvalue
//   b: imaginary part of eigenvalue
</pre></blockquote>

</html>"));
end highPass;
