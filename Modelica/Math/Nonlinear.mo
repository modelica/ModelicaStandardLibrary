within Modelica.Math;
package Nonlinear "Library of functions operating on nonlinear equations"
  extends Modelica.Icons.Package;
  package Examples
    "Examples demonstrating the usage of the functions in package Nonlinear"
    extends Modelica.Icons.ExamplesPackage;

    function quadratureLobatto1 "Integrate integral with fixed inputs"
      input Real tolerance=1e-5 "Error tolerance of integral values";

      import Modelica.Utilities.Streams.print;

    protected
      Real I_numerical[3] "Numerical integral values";
      Real I_analytical[size(I_numerical, 1)] "Analytical integral values";
      Real I_err[size(I_numerical, 1)]
        "Absolute errors between numerical and analytical integral values";

    algorithm
      I_numerical[1] := Modelica.Math.Nonlinear.quadratureLobatto(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun4(),
          0,
          1,
          tolerance);
      I_analytical[1] := -cos(1) + cos(0);

      I_numerical[2] := Modelica.Math.Nonlinear.quadratureLobatto(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun5(w=5),
          0,
          13,
          tolerance);
      I_analytical[2] := -cos(5*13)/5 + cos(5*0)/5;

      I_numerical[3] := Modelica.Math.Nonlinear.quadratureLobatto(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun6(k=1/
          sqrt(2)),
          0,
          Modelica.Constants.pi/2,
          tolerance);
      I_analytical[3] := 1.8540746773013719184338503;

      I_err := abs(I_numerical - I_analytical);

      print("\n... Results of Modelica.Math.Nonlinear.Examples.quadratureLobatto1:");
      print("Function 1 ( integral(sin(x)*dx) from x=0 to x=1): ");
      print("Analytical integral value = " + String(I_analytical[1], format=
        "2.16f"));
      print("Numerical integral value  = " + String(I_numerical[1], format=
        "2.16f"));
      print("Absolute difference       = " + String(I_err[1], format="2.0e"));

      print("");
      print("Function 2 (integral(sin(5*x)*dx) from x=0 to x=13): ");
      print("Analytical integral value = " + String(I_analytical[2], format=
        "2.16f"));
      print("Numerical integral value  = " + String(I_numerical[2], format=
        "2.16f"));
      print("Absolute difference       = " + String(I_err[2], format="2.0e"));

      print("");
      print("Function 3 (Elliptic integral from x=0 to pi/2): ");
      print("Analytical integral value = " + String(I_analytical[3], format=
        "2.16f"));
      print("Numerical integral value  = " + String(I_numerical[3], format=
        "2.16f"));
      print("Absolute difference       = " + String(I_err[3], format="2.0e"));

      annotation (Documentation(info="<html>
<p>
This examples integrates the following integrands with function
<a href=\"Modelica.Math.Nonlinear.quadratureLobatto\">quadratureLobatto</a>
and compares the result with an analytical solution.
The examples also demonstrate how additional input arguments to the integrand
function can be passed as additional arguments.
The following integrals are computed:
</p>

<ul>
<li> integral(sin(x)*dx) from x=0 to x=1 </li>
<li> integral(sin(5*x)*dx) from x=0 to x=13 </li>
<li> elliptic integral from x=0 to pi/2 </li>
</ul>

</html>"));
    end quadratureLobatto1;

    function quadratureLobatto2 "Integrate integral with user dependent inputs"
      input Real Tolerance=1e-5 "Error tolerance of integral value"
        annotation (Dialog(group="General"));
      input Real a1=0 "Lower limit" annotation (Dialog(group="Sine"));
      input Real b1=1 "Upper limit" annotation (Dialog(group="Sine"));

      input Real a2=0 "Lower limit" annotation (Dialog(group="Sine w"));
      input Real b2=13 "Upper limit" annotation (Dialog(group="Sine w"));
      input Real w=5 "Angular velocity" annotation (Dialog(group="Sine w"));

      input Real a3=0 "Lower limit"
        annotation (Dialog(group="Elliptic integral"));
      input Real b3=Modelica.Constants.pi/2 "Upper limit"
        annotation (Dialog(group="Elliptic integral"));
      input Real k=1/sqrt(2) "Modul"
        annotation (Dialog(group="Elliptic integral"));

      import Modelica.Utilities.Streams.print;

    protected
      Real I[3] "Numerical integral values";

    algorithm
      I[1] := Modelica.Math.Nonlinear.quadratureLobatto(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun4(),
          a1,
          b1,
          Tolerance);

      I[2] := Modelica.Math.Nonlinear.quadratureLobatto(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun5(w=w),
          a2,
          b2,
          Tolerance);

      I[3] := Modelica.Math.Nonlinear.quadratureLobatto(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun6(k=k),
          a3,
          b3,
          Tolerance);

      print("\n... Results of Modelica.Math.Nonlinear.Examples.quadratureLobatto2:");
      print("Function 1 (integral(sin(x)*dx)): ");
      print("Numerical integral value  = " + String(I[1], format="2.16f"));

      print("");
      print("Function 2 (integral(sin(w*x)*dx)): ");
      print("Numerical integral value  = " + String(I[2], format="2.16f"));

      print("");
      print("Function 3 (Elliptic integral): ");
      print("Numerical integral value  = " + String(I[3], format="2.16f"));

      annotation (Documentation(info="<html>
<p>
This examples solves the following integrands with function
<a href=\"Modelica.Math.Nonlinear.quadratureLobatto\">quadratureLobatto</a>.
The user can set the parameters, like \"w\" or \"k\", and can experiment with
different integration intervals.
The following integrals are computed:
</p>

<ul>
<li> integral(sin(x)*dx) </li>
<li> integral(sin(w*x)*dx) </li>
<li> elliptic integral </li>
</ul>

</html>"));
    end quadratureLobatto2;

    function solveNonlinearEquations1
      "Solve nonlinear equations with fixed inputs"
      input Real tolerance=100*Modelica.Constants.eps
        "Relative tolerance of solution u";

    protected
      Real u_numerical[3];
      Real u_analytical[3];
      Real u_err[3];

      import Modelica.Utilities.Streams.print;

    algorithm
      u_numerical[1] := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun1(),
          -0.5,
          10,
          tolerance);
      u_analytical[1] := 1.0;

      u_numerical[2] := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun2(w=3),
          0,
          5,
          tolerance);
      u_analytical[2] := 0.6448544035840080891877538;

      u_numerical[3] := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun3(p={5,1},
          m=1),
          1,
          8,
          tolerance);
      u_analytical[3] := 6.9368474072202187221643182;

      u_err := abs(u_numerical - u_analytical);

      print("\n... Results of Modelica.Math.Nonlinear.Examples.solveNonlinearEquations1:");
      print("Solve 3 nonlinear equations with relative tolerance = " + String(tolerance) +"\n");
      print("Function 1 (u^2 - 1 = 0): ");
      print("Analytical zero     = " + String(u_analytical[1], format="2.16f"));
      print("Numerical zero      = " + String(u_numerical[1], format="2.16f"));
      print("Absolute difference = " + String(u_err[1], format="2.0e"));

      print("");
      print("Function 2 (3*u - sin(3*u) - 1 = 0): ");
      print("Analytical zero     = " + String(u_analytical[2], format="2.16f"));
      print("Numerical zero      = " + String(u_numerical[2], format="2.16f"));
      print("Absolute difference = " + String(u_err[2], format="2.0e"));

      print("");
      print("Function 3 (5 + ln(u) - u = 0): ");
      print("Analytical zero     = " + String(u_analytical[3], format="2.16f"));
      print("Numerical zero      = " + String(u_numerical[3], format="2.16f"));
      print("Absolute difference = " + String(u_err[3], format="2.0e"));

      annotation (Documentation(info="<html>
<p>
This examples solves the following nonlinear equations with function
<a href=\"Modelica.Math.Nonlinear.solveOneNonlinearEquation\">solveOneNonlinearEquation</a>
and compares the result with the available analytical solution.
The examples also demonstrate how additional input arguments to the nonlinear equation
function can be passes as additional arguments.
The following nonlinear equations are solved:
</p>

<ul>
<li> 0 = u^2 - 1 </li>
<li> 0 = 3*u - sin(3*u) - 1 </li>
<li> 0 = 5 + ln(u) - u </li>
</ul>

</html>"));
    end solveNonlinearEquations1;

    function solveNonlinearEquations2
      "Solve nonlinear equations with user dependent inputs"
        input Real tolerance=100*Modelica.Constants.eps
        "Relative tolerance of solution u"
        annotation (Dialog(group="General"));
      input Real u_min1=-0.5 "Lower limit" annotation (Dialog(group="u^2-1"));
      input Real u_max1=10 "Upper limit" annotation (Dialog(group="u^2-1"));
      input Real u_min2=0 "Lower limit"
        annotation (Dialog(group="3*u - sin(w*u) - 1"));
      input Real u_max2=5 "Upper limit"
        annotation (Dialog(group="3*u - sin(w*u) - 1"));
      input Real w=3 "Angular velocity "
        annotation (Dialog(group="3*u - sin(w*u) - 1"));
      input Real u_min3=1 "Lower limit"
        annotation (Dialog(group="p[1] + ln(p[2]*u) - m*u"));
      input Real u_max3=8 "Upper limit"
        annotation (Dialog(group="p[1] + ln(p[2]*u) - m*u"));
      input Real p[2]={5,1} "Parameter vector"
        annotation (Dialog(group="p[1] + ln(p[2]*u) - m*u"));
      input Real m=1 "Parameter"
        annotation (Dialog(group="p[1] + ln(p[2]*u) - m*u"));

    protected
      Real u[3];

      import Modelica.Utilities.Streams.print;

    algorithm
      u[1] := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun1(),
          u_min1,
          u_max1,
          tolerance);

      u[2] := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun2(w=w),
          u_min2,
          u_max2,
          tolerance);

      u[3] := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function Modelica.Math.Nonlinear.Examples.UtilityFunctions.fun3(p=p, m=
          m),
          u_min3,
          u_max3,
          tolerance);

      print("\n... Results of Modelica.Math.Nonlinear.Examples.solveNonlinearEquations2:");
      print("Solve 3 nonlinear equations with relative tolerance = " + String(tolerance) +"\n");

      print("Function 1 (u^2 - 1): ");
      print("Numerical zero = " + String(u[1], format="2.16f"));

      print("");
      print("Function 2 (3*u - sin(w*u) - 1): ");
      print("Numerical zero = " + String(u[2], format="2.16f"));

      print("");
      print("Function 3 (p[1] + ln(p[2]*u) - m*u): ");
      print("Numerical zero = " + String(u[3], format="2.16f"));

      annotation (Documentation(info="<html>
<p>
This examples solves the following nonlinear equations with function
<a href=\"Modelica.Math.Nonlinear.solveOneNonlinearEquation\">solveOneNonlinearEquation</a>.
The user can set the parameters, like \"w\" or \"m\", and can experiment with
different start intervals.
The following nonlinear equations are solved:
</p>

<ul>
<li> 0 = u^2 - 1 </li>
<li> 0 = 3*u - sin(w*u) - 1 </li>
<li> 0 = p[1] + ln(p[2]*u) - m*u </li>
</ul>

</html>"));
    end solveNonlinearEquations2;

    model quadratureLobatto3 "Integrate function in a model"
      extends Modelica.Icons.Example;
      parameter Real A=1 "Amplitude of integrand of s";
      parameter Real ws=2 "Angular frequency of integrand of s";
      parameter Real wq=3 "Angular frequency of q";
      Real q(start=1, fixed=true);
      Real qd(start=0, fixed=true);
      Real x;
      final parameter Real s = Modelica.Math.Nonlinear.quadratureLobatto(
                                  function UtilityFunctions.fun7(A=A, w=ws),
                                  0,1);
    equation
      qd = der(q);
      der(qd) + wq*q = 0;
      x = s*q;
      annotation (Documentation(info="<html>
<p>
This example demonstrates how to utilize a function as input argument
to a function in a model.
</p>
</html>"),
        experiment(StopTime=5),
        experimentSetupOutput);
    end quadratureLobatto3;

    package UtilityFunctions
      "Utility functions that are used as function arguments to the examples"
      extends Modelica.Icons.Package;

      function fun1 "y = u^2 - 1"
        extends Modelica.Math.Interfaces.partialScalarFunction;
      algorithm
        y := u^2 - 1;
      end fun1;

      function fun2 "y = 3*u - sin(w*u) - 1"
        extends Modelica.Math.Interfaces.partialScalarFunction;
        input Real w "Angular velocity";
      algorithm
        y := 3*u - sin(w*u) - 1;

      end fun2;

      function fun3 "y = p[1] + ln(p[2]*u) - m*u"
        extends Modelica.Math.Interfaces.partialScalarFunction;
        input Real p[2];
        input Real m;
      algorithm
        y := p[1] + ln(p[2]*u) - m*u;

      end fun3;

      function fun4 "y = sin(u)"
        extends Modelica.Math.Interfaces.partialScalarFunction;
      algorithm
        y := sin(u);
      end fun4;

      function fun5 "y = sin(w*u)"
        extends Modelica.Math.Interfaces.partialScalarFunction;
        input Real w "Angular velocity";
      algorithm
        y := sin(w*u);
      end fun5;

      function fun6 "y = sqrt(1/(1 - k^2*sin(u)^2))"
        extends Modelica.Math.Interfaces.partialScalarFunction;
        input Real k "Modul";
      algorithm
        y := sqrt(1/(1 - k^2*sin(u)^2));
      end fun6;

      function fun7 "y = A*sin(w*u)*q(t)"
        extends Modelica.Math.Interfaces.partialScalarFunction;
        input Real A "Amplitude";
        input Real w "Angular frequency";
      algorithm
        y := A*sin(w*u);
      end fun7;
      annotation (Documentation(info="<html>
<p>
This package provides utility functions that are used as input
arguments to the example functions.
</p>

</html>"));
    end UtilityFunctions;
  end Examples;

  function quadratureLobatto
    "Return the integral of an integrand function using an adaptive Lobatto rule"
    input Modelica.Math.Interfaces.partialScalarFunction f "Integrand function";
    input Real a "Lower limit of integration interval";
    input Real b "Upper limit of integration interval";
    input Real tolerance = 100*Modelica.Constants.eps
      "Relative tolerance for integral value";
    output Real integral "integral value";

  protected
    constant Real x1=0.942882415695480;
    constant Real x2=0.641853342345781;
    constant Real x3=0.236383199662150;
    constant Real eps=10*Modelica.Constants.eps;
    Real m;
    Real h;
    Real alpha;
    Real beta;
    Real x[13];
    Real y[13];
    Real fa;
    Real fb;
    Real i1;
    Real i2;
    Real is;
    Real erri1;
    Real erri2;
    Real R;
    Real tol;
    Integer s;

    function quadStep "Recursive function used by quadrature"
      input Modelica.Math.Interfaces.partialScalarFunction f;
      input Real a "Right interval end";
      input Real b "Left interval end";
      input Real fa "Function value at a";
      input Real fb "Function value at b";
      input Real is "First approximation of the integral";
      output Real I "integral value";
    protected
      Real m;
      Real h;
      Real alpha;
      Real beta;
      Real x[5];
      Real y[5];
      Real mll;
      Real ml;
      Real mr;
      Real mrr;
      Real fmll;
      Real fml;
      Real fm;
      Real fmr;
      Real fmrr;
      Real i1;
      Real i2;
    algorithm
      h := (b - a)/2;
      m := (a + b)/2;
      alpha := sqrt(2/3);
      beta := 1/sqrt(5);
      mll := m - alpha*h;
      ml := m - beta*h;
      mr := m + beta*h;
      mrr := m + alpha*h;
      x := {mll,ml,m,mr,mrr};
      for i in 1:size(x,1) loop
        y[i] := f(x[i]);
      end for;
      fmll := y[1];
      fml := y[2];
      fm := y[3];
      fmr := y[4];
      fmrr := y[5];
      i2 := (h/6)*(fa + fb + 5*(fml + fmr));
      i1 := (h/1470)*(77*(fa + fb) + 432*(fmll + fmrr) + 625*(fml + fmr) +
        672*fm);

      if (is + (i1 - i2) == is) or (mll <= a) or (b <= mrr) then
        I := i1;

      else
        I := quadStep(f, a, mll, fa, fmll, is) +
             quadStep(f, mll, ml, fmll, fml, is) +
             quadStep(f, ml, m, fml, fm, is) +
             quadStep(f, m, mr, fm, fmr, is) +
             quadStep(f, mr, mrr, fmr, fmrr, is) +
             quadStep(f, mrr, b, fmrr, fb, is);
      end if;
    end quadStep;

  algorithm
    /*
        Numerically evaluate integral using adaptive
        Lobatto rule.
        see Walter Gander: Adaptive Quadrature - Revisited, 1998
                        ftp.inf.ethz.ch in doc/tech-reports/1998/306.ps

        x[:] are the nodes
        y[:] = f(x[:]) are function values at the nodes
        */
    tol := tolerance;
    m := (a + b)/2;
    h := (b - a)/2;
    alpha := sqrt(2/3);
    beta := 1/sqrt(5);
    x := {a,
          m - x1*h,
          m - alpha*h,
          m - x2*h,
          m - beta*h,
          m - x3*h,
          m,
          m + x3*h,
          m + beta*h,
          m + x2*h,
          m + alpha*h,
          m + x1*h,
          b};
    for i in 1:size(x,1) loop
      y[i] := f(x[i]);
    end for;
    fa := y[1];
    fb := y[13];
    i2 := (h/6)*(y[1] + y[13] + 5*(y[5] + y[9]));
    i1 := (h/1470)*(77*(y[1] + y[13]) + 432*(y[3] + y[11]) + 625*(y[5] + y[9])
       + 672*y[7]);
    is := h*(.0158271919734802*(y[1] + y[13]) +.0942738402188500 *(y[2] + y[
      12]) +.155071987336585 *(y[3] + y[11]) +.188821573960182 *(y[4] + y[10])
       +.199773405226859 *(y[5] + y[9]) +.224926465333340 *(y[6] + y[8]) +.242611071901408
                      *y[7]);
    s := sign(is);
    if (s == 0) then
      s := 1;
    end if;
    erri1 := abs(i1 - is);
    erri2 := abs(i2 - is);
    R := 1;
    if (erri2 <> 0) then
      R := erri1/erri2;
    end if;
    if (R > 0 and R < 1) then
      tol := tol/R;
    end if;
    is := s*abs(is)*tol/eps;
    if (is == 0) then
      is := b - a;
    end if;
    integral := quadStep(
          f,
          a,
          b,
          fa,
          fb,
          is);

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<b>quadratureLobatto</b>(function f(), a, b);
<b>quadratureLobatto</b>(function f(), a, b, tolerance=100*Modelica.Constants.eps);
</pre></blockquote>

<h4>Description</h4>

<p>
Compute definite integral over function f(u,...) from u=a up to u=b
using the adaptive Lobatto rule according to:
</p>

<blockquote>
<dl>
<dt>Walter Gander:</dt>
<dd> <b>Adaptive Quadrature - Revisited</b>. 1998.
     <a href=\"ftp.inf.ethz.ch in doc/tech-reports/1998/306.ps\">ftp.inf.ethz.ch in doc/tech-reports/1998/306.ps</a>
     </dd>
</dl>
</blockquote>

<h4>Example</h4>

<p>
See the examples in <a href=\"modelica://Modelica.Math.Nonlinear.Examples\">Modelica.Math.Nonlinear.Examples</a>.
</p>

</html>"));
  end quadratureLobatto;

  function solveOneNonlinearEquation
    "Solve f(u) = 0 in a very reliable and efficient way (f(u_min) and f(u_max) must have different signs)"
    import Modelica.Utilities.Streams.error;

    input Modelica.Math.Interfaces.partialScalarFunction f
      "Function y = f(u); u is computed so that y=0";
    input Real u_min "Lower bound of search intervall";
    input Real u_max "Upper bound of search intervall";
    input Real tolerance=100*Modelica.Constants.eps
      "Relative tolerance of solution u";
    output Real u "Value of independent variable u so that f(u) = 0";

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
    fa := f(u_min);
    fb := f(u_max);
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
        fb := f(b);

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
<h4>Syntax</h4>
<blockquote><pre>
<b>solveOneNonlinearEquation</b>(function f(), u_min, u_max);
<b>solveOneNonlinearEquation</b>(function f(), u_min, u_max, tolerance=100*Modelica.Constants.eps);
</pre></blockquote>

<h4>Description</h4>

<p>
This function determines the solution of <b>one non-linear algebraic equation</b> \"y=f(u)\"
in <b>one unknown</b> \"u\" in a reliable way. It is one of the best numerical
algorithms for this purpose. As input, the nonlinear function f(u)
has to be given, as well as an interval u_min, u_max that
contains the solution, i.e., \"f(u_min)\" and \"f(u_max)\" must
have a different sign. The function computes a smaller interval
in which a sign change is present using the relative tolerance
\"tolerance\" that can be given as 4th input argument.
</p>

<p>
The interval reduction is performed using
inverse quadratic interpolation (interpolating with a quadratic polynomial
through the last 3 points and computing the zero). If this fails,
bisection is used, which always reduces the interval by a factor of 2.
The inverse quadratic interpolation method has superlinear convergence.
This is roughly the same convergence rate as a globally convergent Newton
method, but without the need to compute derivatives of the non-linear
function. The solver function is a direct mapping of the Algol 60 procedure
\"zero\" to Modelica, from:
</p>

<blockquote>
<dl>
<dt> Brent R.P.:</dt>
<dd> <b>Algorithms for Minimization without derivatives</b>.
     Prentice Hall, 1973, pp. 58-59.<br>
     Download: <a href=\"http://wwwmaths.anu.edu.au/~brent/pd/rpb011i.pdf\">http://wwwmaths.anu.edu.au/~brent/pd/rpb011i.pdf</a><br>
     Errata and new print: <a href=\"http://wwwmaths.anu.edu.au/~brent/pub/pub011.html\">http://wwwmaths.anu.edu.au/~brent/pub/pub011.html</a>
</dd>
</dl>
</blockquote>

<h4>Example</h4>

<p>
See the examples in <a href=\"modelica://Modelica.Math.Nonlinear.Examples\">Modelica.Math.Nonlinear.Examples</a>.
</p>
</html>"));
  end solveOneNonlinearEquation;

  annotation (Documentation(info="<html>
<p>
This package contains functions to perform tasks such as numerically integrating
a function, or solving a nonlinear algebraic equation system.
The common feature of the functions in this package is
that the nonlinear characteristics are passed as user defineable
functions.
</p>

<p>
For details about how to define and to use functions as input arguments
to functions, see
<a href=\"modelica://ModelicaReference.Classes.Function\">ModelicaReference.Classes.Function</a>
or the Modelica Language  Specification, Chapter 12.4.2.
</p>

</html>", revisions="<html>
<ul>
<li><i>July 2010 </i> by Martin Otter (DLR-RM): <br>
    Included in MSL3.2, adapted, and documentation improved</li>

<li><i>March 2010 </i> by Andreas Pfeiffer (DLR-RM): <br>
    Adapted the quadrature function from Gerhard Schillhuber and
    the solution of one non-linear equation in one unknown from
    Modelica.Media.Common.OneNonLinearEquation so that
    function objects are used.</li>

<li><i>June 2002 </i> by Gerhard Schillhuber (master thesis at DLR-RM):<br>
       Adaptive quadrature to compute the curve length of a Spline.</li>
</ul>
</html>"));
end Nonlinear;
