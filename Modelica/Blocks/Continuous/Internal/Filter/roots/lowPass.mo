within Modelica.Blocks.Continuous.Internal.Filter.roots;
function lowPass
    "Return low pass filter roots as needed for block for given cut-off frequency"
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
  output Real ku[size(c0_in,1)] "Input gain";
protected
  Real c0[size(c0_in,1)];
  Real c1[size(c0_in,1)];
  Real cr[size(cr_in,1)];
algorithm
  // Get coefficients of low pass filter at f_cut
  (cr, c0, c1) :=coefficients.lowPass(cr_in, c0_in, c1_in, f_cut);

  // Transform coefficients in to root
  for i in 1:size(cr_in,1) loop
    r[i] :=-cr[i];
  end for;

  for i in 1:size(c0_in,1) loop
    a [i] :=-c1[i]/2;
    b [i] :=sqrt(c0[i] - a[i]*a[i]);
    ku[i] :=c0[i]/b[i];
  end for;

  annotation (Documentation(info="<html>

<p>
The goal is to implement the filter in the following form:
</p>

<blockquote><pre>
// real pole:
 der(x) = r*x - r*u
     y  = x

// complex conjugate poles:
der(x1) = a*x1 - b*x2 + ku*u;
der(x2) = b*x1 + a*x2;
     y  = x2;

          ku = (a^2 + b^2)/b
</pre></blockquote>
<p>
This representation has the following transfer function:
</p>
<blockquote><pre>
// real pole:
    s*y = r*y - r*u
  or
    (s-r)*y = -r*u
  or
    y = -r/(s-r)*u

  comparing coefficients with
    y = cr/(s + cr)*u  ->  r = -cr      // r is the real eigenvalue

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
    y  = x2

  comparing coefficients with
    y = c0/(s^2 + c1*s + c0)*u  ->  a  = -c1/2
                                    b  = sqrt(c0 - a^2)
                                    ku = c0/b
                                       = (a^2 + b^2)/b

  comparing with eigenvalue representation:
    (s - (a+jb))*(s - (a-jb)) = s^2 -2*a*s + a^2 + b^2
  shows that:
    a: real part of eigenvalue
    b: imaginary part of eigenvalue

  time -> infinity:
    y(s=0) = x2(s=0) = 1
             x1(s=0) = -ku*a/(a^2 + b^2)*u
                     = -(a/b)*u
</pre></blockquote>

</html>"));
end lowPass;
