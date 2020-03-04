within Modelica.Blocks.Continuous.Internal.Filter.Utilities;
encapsulated function bandPassAlpha "Return alpha for band pass"
  extends Modelica.Icons.Function;

  import Modelica;
   input Real a "Coefficient of s^1";
   input Real b "Coefficient of s^0";
   input Modelica.Units.SI.AngularVelocity w
    "Bandwidth angular frequency";
   output Real alpha "Alpha factor to build up band pass";

protected
  Real alpha_min;
  Real alpha_max;
  Real z_min;
  Real z_max;
  Real z;

  function residue "Residue of non-linear equation"
    extends Modelica.Icons.Function;
    input Real a;
    input Real b;
    input Real w;
    input Real z;
    output Real res;
  algorithm
    res := z^2 + (a*w*z/(1+z))^2 - (2+b*w^2)*z + 1;
  end residue;

function solveOneNonlinearEquation
    "Solve f(u) = 0; f(u_min) and f(u_max) must have different signs"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Streams.error;

  input Real aa;
  input Real bb;
  input Real ww;
  input Real u_min "Lower bound of search interval";
  input Real u_max "Upper bound of search interval";
  input Real tolerance=100*Modelica.Constants.eps
      "Relative tolerance of solution u";
  output Real u "Value of independent variable so that f(u) = 0";

  protected
  constant Real eps=Modelica.Constants.eps "machine epsilon";
  Real a=u_min "Current best minimum interval value";
  Real b=u_max "Current best maximum interval value";
  Real c "Intermediate point a <= c <= b";
  Real d;
  Real e "b - a";
  Real m;
  Real s;
  Real p;
  Real q;
  Real r;
  Real tol;
  Real fa "= f(a)";
  Real fb "= f(b)";
  Real fc;
  Boolean found=false;
algorithm
  // Check that f(u_min) and f(u_max) have different sign
  fa := residue(aa,bb,ww,u_min);
  fb := residue(aa,bb,ww,u_max);
  fc := fb;
  if fa > 0.0 and fb > 0.0 or fa < 0.0 and fb < 0.0 then
    error(
      "The arguments u_min and u_max to solveOneNonlinearEquation(..)\n" +
      "do not bracket the root of the single non-linear equation:\n" +
      "  u_min  = " + String(u_min) + "\n" + "  u_max  = " + String(u_max)
       + "\n" + "  fa = f(u_min) = " + String(fa) + "\n" +
      "  fb = f(u_max) = " + String(fb) + "\n" +
      "fa and fb must have opposite sign which is not the case");
  end if;

  // Initialize variables
  c := a;
  fc := fa;
  e := b - a;
  d := e;

  // Search loop
  while not found loop
    if abs(fc) < abs(fb) then
      a := b;
      b := c;
      c := a;
      fa := fb;
      fb := fc;
      fc := fa;
    end if;

    tol := 2*eps*abs(b) + tolerance;
    m := (c - b)/2;

    if abs(m) <= tol or fb == 0.0 then
      // root found (interval is small enough)
      found := true;
      u := b;
    else
      // Determine if a bisection is needed
      if abs(e) < tol or abs(fa) <= abs(fb) then
        e := m;
        d := e;
      else
        s := fb/fa;
        if a == c then
          // linear interpolation
          p := 2*m*s;
          q := 1 - s;
        else
          // inverse quadratic interpolation
          q := fa/fc;
          r := fb/fc;
          p := s*(2*m*q*(q - r) - (b - a)*(r - 1));
          q := (q - 1)*(r - 1)*(s - 1);
        end if;

        if p > 0 then
          q := -q;
        else
          p := -p;
        end if;

        s := e;
        e := d;
        if 2*p < 3*m*q - abs(tol*q) and p < abs(0.5*s*q) then
          // interpolation successful
          d := p/q;
        else
          // use bi-section
          e := m;
          d := e;
        end if;
      end if;

      // Best guess value is defined as "a"
      a := b;
      fa := fb;
      b := b + (if abs(d) > tol then d else if m > 0 then tol else -tol);
      fb := residue(aa,bb,ww,b);

      if fb > 0 and fc > 0 or fb < 0 and fc < 0 then
        // initialize variables
        c := a;
        fc := fa;
        e := b - a;
        d := e;
      end if;
    end if;
  end while;

  annotation (Documentation(info="<html>

<p>
This function determines the solution of <strong>one non-linear algebraic equation</strong> \"y=f(u)\"
in <strong>one unknown</strong> \"u\" in a reliable way. It is one of the best numerical
algorithms for this purpose. As input, the nonlinear function f(u)
has to be given, as well as an interval u_min, u_max that
contains the solution, i.e., \"f(u_min)\" and \"f(u_max)\" must
have a different sign. If possible, a smaller interval is computed by
inverse quadratic interpolation (interpolating with a quadratic polynomial
through the last 3 points and computing the zero). If this fails,
bisection is used, which always reduces the interval by a factor of 2.
The inverse quadratic interpolation method has superlinear convergence.
This is roughly the same convergence rate as a globally convergent Newton
method, but without the need to compute derivatives of the non-linear
function. The solver function is a direct mapping of the Algol 60 procedure
\"zero\" to Modelica, from:
</p>

<dl>
<dt> Brent R.P.:</dt>
<dd> <strong>Algorithms for Minimization without derivatives</strong>.
     Prentice Hall, 1973, pp. 58-59.</dd>
</dl>

</html>"));
end solveOneNonlinearEquation;

algorithm
  assert( a^2/4 - b <= 0,  "Band pass transformation cannot be computed");
  z :=solveOneNonlinearEquation(a, b, w, 0, 1);
  alpha := sqrt(z);

  annotation (Documentation(info="<html>
<p>
A band pass with bandwidth \"w\" is determined from a low pass
</p>

<blockquote><pre>
1/(p^2 + a*p + b)
</pre></blockquote>

<p>
with the transformation
</p>

<blockquote><pre>
new(p) = (p + 1/p)/w
</pre></blockquote>

<p>
This results in the following derivation:
</p>

<blockquote><pre>
1/(p^2 + a*p + b) -> 1/( (p+1/p)^2/w^2 + a*(p + 1/p)/w + b )
                   = 1 /( ( p^2 + 1/p^2 + 2)/w^2 + (p + 1/p)*a/w + b )
                   = w^2*p^2 / (p^4 + 2*p^2 + 1 + (p^3 + p)a*w + b*w^2*p^2)
                   = w^2*p^2 / (p^4 + a*w*p^3 + (2+b*w^2)*p^2 + a*w*p + 1)
</pre></blockquote>

<p>
This 4th order transfer function shall be split in to two transfer functions of order 2 each
for numerical reasons. With the following formulation, the fourth order
polynomial can be represented (with the unknowns \"c\" and \"alpha\"):
</p>

<blockquote><pre>
g(p) = w^2*p^2 / ( (p*alpha)^2 + c*(p*alpha) + 1) * ( (p/alpha)^2 + c*(p/alpha) + 1)
     = w^2*p^2 / ( p^4 + c*(alpha + 1/alpha)*p^3 + (alpha^2 + 1/alpha^2 + c^2)*p^2
                                                 + c*(alpha + 1/alpha)*p + 1 )
</pre></blockquote>

<p>
Comparison of coefficients:
</p>

<blockquote><pre>
c*(alpha + 1/alpha) = a*w           -> c = a*w / (alpha + 1/alpha)
alpha^2 + 1/alpha^2 + c^2 = 2+b*w^2 -> equation to determine alpha

alpha^4 + 1 + a^2*w^2*alpha^4/(1+alpha^2)^2 = (2+b*w^2)*alpha^2
  or z = alpha^2
z^2 + a^2*w^2*z^2/(1+z)^2 - (2+b*w^2)*z + 1 = 0
</pre></blockquote>

<p>
Therefore the last equation has to be solved for \"z\" (basically, this means to compute
a real zero of a fourth order polynomial):
</p>

<blockquote><pre>
solve: 0 = f(z)  = z^2 + a^2*w^2*z^2/(1+z)^2 - (2+b*w^2)*z + 1  for \"z\"
           f(0)  = 1  &gt; 0
           f(1)  = 1 + a^2*w^2/4 - (2+b*w^2) + 1
                 = (a^2/4 - b)*w^2  &lt; 0
                 // since b - a^2/4 > 0 requirement for complex conjugate poles
-> 0 &lt; z &lt; 1
</pre></blockquote>

<p>
This function computes the solution of this equation and returns \"alpha = sqrt(z)\";
</p>

</html>"));
end bandPassAlpha;
