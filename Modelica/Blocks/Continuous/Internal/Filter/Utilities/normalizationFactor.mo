within Modelica.Blocks.Continuous.Internal.Filter.Utilities;
function normalizationFactor
  "Compute correction factor of low pass filter such that amplitude at cut-off frequency is -3db (=10^(-3/20) = 0.70794...)"
  extends Modelica.Icons.Function;

  import Modelica.Utilities.Streams;

  input Real c1[:]
    "[p] coefficients of denominator polynomials (c1[i}*p + 1)";
  input Real c2[:,2]
    "[p^2, p] coefficients of denominator polynomials (c2[i,1]*p^2 + c2[i,2]*p + 1)";
  output Real alpha "Correction factor (replace p by alpha*p)";
protected
  Real alpha_min;
  Real alpha_max;

  function normalizationResidue
    "Residue of correction factor computation"
    extends Modelica.Icons.Function;
    input Real c1[:]
      "[p] coefficients of denominator polynomials (c1[i]*p + 1)";
    input Real c2[:,2]
      "[p^2, p] coefficients of denominator polynomials (c2[i,1]*p^2 + c2[i,2]*p + 1)";
    input Real alpha;
    output Real residue;
  protected
    constant Real beta= 10^(-3/20)
      "Amplitude of -3db required, i.e., -3db = 20*log(beta)";
    Real cc1;
    Real cc2;
    Real p;
    Real alpha2=alpha*alpha;
    Real alpha4=alpha2*alpha2;
    Real A2=1.0;
  algorithm
    assert(size(c1,1) <= 1, "Internal error 2 (should not occur)");
    if size(c1, 1) == 1 then
      cc1 := c1[1]*c1[1];
      p := 1 + cc1*alpha2;
      A2 := A2*p;
    end if;
    for i in 1:size(c2, 1) loop
      cc1 := c2[i, 2]*c2[i, 2] - 2*c2[i, 1];
      cc2 := c2[i, 1]*c2[i, 1];
      p := 1 + cc1*alpha2 + cc2*alpha4;
      A2 := A2*p;
    end for;
    residue := 1/sqrt(A2) - beta;
  end normalizationResidue;

  function findInterval "Find interval for the root"
    extends Modelica.Icons.Function;
    input Real c1[:]
      "[p] coefficients of denominator polynomials (a*p + 1)";
    input Real c2[:,2]
      "[p^2, p] coefficients of denominator polynomials (b*p^2 + a*p + 1)";
    output Real alpha_min;
    output Real alpha_max;
  protected
    Real alpha = 1.0;
    Real residue;
  algorithm
    alpha_min :=0;
    residue := normalizationResidue(c1, c2, alpha);
    if residue < 0 then
       alpha_max :=alpha;
    else
       while residue >= 0 loop
          alpha := 1.1*alpha;
          residue := normalizationResidue(c1, c2, alpha);
       end while;
       alpha_max :=alpha;
    end if;
  end findInterval;

function solveOneNonlinearEquation
    "Solve f(u) = 0; f(u_min) and f(u_max) must have different signs"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Streams.error;

  input Real c1[:]
      "[p] coefficients of denominator polynomials (c1[i]*p + 1)";
  input Real c2[:,2]
      "[p^2, p] coefficients of denominator polynomials (c2[i,1]*p^2 + c2[i,2]*p + 1)";
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
  fa := normalizationResidue(c1,c2,u_min);
  fb := normalizationResidue(c1,c2,u_max);
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
      fb := normalizationResidue(c1,c2,b);

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
   // Find interval for alpha
   (alpha_min, alpha_max) :=findInterval(c1, c2);

   // Compute alpha, so that abs(G(p)) = -3db
   alpha :=solveOneNonlinearEquation(
    c1,
    c2,
    alpha_min,
    alpha_max);
end normalizationFactor;
