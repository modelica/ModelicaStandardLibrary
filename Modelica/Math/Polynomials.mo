within Modelica.Math;
    package Polynomials
      "Library of functions operating on polynomials (including polynomial fitting)"
      extends Modelica.Icons.FunctionsPackage;

      function evaluate "Evaluate polynomial at a given abscissa value"
        extends Modelica.Icons.Function;
        input Real p[:]
          "Polynomial coefficients (p[1] is coefficient of highest power)";
        input Real u "Abscissa value";
        output Real y "Value of polynomial at u";
      algorithm
        y := p[1];
        for j in 2:size(p, 1) loop
          y := p[j] + u*y;
        end for;
        annotation(derivative(zeroDerivative=p)=evaluate_der);
      end evaluate;

      function evaluateWithRange
        "Evaluate polynomial at a given abscissa value with linear extrapolation outside of the defined range"
        extends Modelica.Icons.Function;
        input Real p[:]
          "Polynomial coefficients (p[1] is coefficient of highest power)";
        input Real uMin "Polynomial valid in the range uMin .. uMax";
        input Real uMax "Polynomial valid in the range uMin .. uMax";
        input Real u "Abscissa value";
        output Real y
          "Value of polynomial at u. Outside of uMin,uMax, linear extrapolation is used";
      algorithm
        if u < uMin then
          y := evaluate(p, uMin) - evaluate_der(
                  p,
                  uMin,
                  uMin - u);
        elseif u > uMax then
          y := evaluate(p, uMax) + evaluate_der(
                  p,
                  uMax,
                  u - uMax);
        else
          y := evaluate(p, u);
        end if;
        annotation (derivative(
            zeroDerivative=p,
            zeroDerivative=uMin,
            zeroDerivative=uMax) = evaluateWithRange_der);
      end evaluateWithRange;

      function derivative "Derivative of polynomial"
        extends Modelica.Icons.Function;
        input Real p1[:]
          "Polynomial coefficients (p1[1] is coefficient of highest power)";
        output Real p2[size(p1, 1) - 1] "Derivative of polynomial p1";
      protected
        Integer n=size(p1, 1);
      algorithm
        for j in 1:n-1 loop
          p2[j] := p1[j]*(n - j);
        end for;
      end derivative;

      function derivativeValue
        "Value of derivative of polynomial at abscissa value u"
        extends Modelica.Icons.Function;
        input Real p[:]
          "Polynomial coefficients (p[1] is coefficient of highest power)";
        input Real u "Abscissa value";
        output Real y "Value of derivative of polynomial at u";
      protected
        Integer n=size(p, 1);
      algorithm
        y := p[1]*(n - 1);
        for j in 2:size(p, 1)-1 loop
          y := p[j]*(n - j) + u*y;
        end for;
        annotation(derivative(zeroDerivative=p)=derivativeValue_der);
      end derivativeValue;

      function secondDerivativeValue
        "Value of 2nd derivative of polynomial at abscissa value u"
        extends Modelica.Icons.Function;
        input Real p[:]
          "Polynomial coefficients (p[1] is coefficient of highest power)";
        input Real u "Abscissa value";
        output Real y "Value of 2nd derivative of polynomial at u";
      protected
        Integer n=size(p, 1);
      algorithm
        y := p[1]*(n - 1)*(n - 2);
        for j in 2:size(p, 1)-2 loop
          y := p[j]*(n - j)*(n - j - 1) + u*y;
        end for;
      end secondDerivativeValue;

      function integral "Indefinite integral of polynomial p(u)"
        extends Modelica.Icons.Function;
        input Real p1[:]
          "Polynomial coefficients (p1[1] is coefficient of highest power)";
        output Real p2[size(p1, 1) + 1]
          "Polynomial coefficients of indefinite integral of polynomial p1 (polynomial p2 + C is the indefinite integral of p1, where C is an arbitrary constant)";
      protected
        Integer n=size(p1, 1) + 1 "Degree of output polynomial";
      algorithm
        for j in 1:n-1 loop
          p2[j] := p1[j]/(n-j);
        end for;
        p2[n] := 0.0;
      end integral;

      function integralValue "Integral of polynomial p(u) from u_low to u_high"
        extends Modelica.Icons.Function;
        input Real p[:] "Polynomial coefficients";
        input Real u_high "High integrand value";
        input Real u_low=0 "Low integrand value, default 0";
        output Real integral=0.0
          "Integral of polynomial p from u_low to u_high";
      protected
        Integer n=size(p, 1) "Degree of integrated polynomial";
        Real y_low=0 "Value at lower integrand";
      algorithm
        for j in 1:n loop
          integral := u_high*(p[j]/(n - j + 1) + integral);
          y_low := u_low*(p[j]/(n - j + 1) + y_low);
        end for;
        integral := integral - y_low;
        annotation(derivative(zeroDerivative=p)=integralValue_der);
      end integralValue;

      function fitting
        "Computes the coefficients of a polynomial that fits a set of data points in a least-squares sense"
        extends Modelica.Icons.Function;
        input Real u[:] "Abscissa data values";
        input Real y[size(u, 1)] "Ordinate data values";
        input Integer n(min=1)
          "Order of desired polynomial that fits the data points (u,y)";
        output Real p[n + 1]
          "Polynomial coefficients of polynomial that fits the date points";
      protected
        Real V[size(u, 1), n + 1] "Vandermonde matrix";
      algorithm
        // Construct Vandermonde matrix
        V[:, n + 1] := ones(size(u, 1));
        for j in n:-1:1 loop
          V[:, j] := {u[i] * V[i, j + 1] for i in 1:size(u,1)};
        end for;

        // Solve least squares problem
        p :=Modelica.Math.Matrices.leastSquares(V, y);
        annotation (Documentation(info="<html>
<p>
Polynomials.fitting(u,y,n) computes the coefficients of a polynomial
p(u) of degree \"n\" that fits the data \"p(u[i]) - y[i]\"
in a least squares sense. The polynomial is
returned as a vector p[n+1] that has the following definition:
</p>
<pre>
  p(u) = p[1]*u^n + p[2]*u^(n-1) + ... + p[n]*u + p[n+1];
</pre>
</html>"));
      end fitting;

      function evaluate_der
        "Evaluate derivative of polynomial at a given abscissa value"
        extends Modelica.Icons.Function;
        input Real p[:]
          "Polynomial coefficients (p[1] is coefficient of highest power)";
        input Real u "Abscissa value";
        input Real du "Delta of abscissa value";
        output Real dy "Value of derivative of polynomial at u";
      protected
        Integer n=size(p, 1);
      algorithm
        dy := p[1]*(n - 1);
        for j in 2:size(p, 1)-1 loop
          dy := p[j]*(n - j) + u*dy;
        end for;
        dy := dy*du;
      end evaluate_der;

      function evaluateWithRange_der
        "Evaluate derivative of polynomial at a given abscissa value with extrapolation outside of the defined range"
        extends Modelica.Icons.Function;
        input Real p[:]
          "Polynomial coefficients (p[1] is coefficient of highest power)";
        input Real uMin "Polynomial valid in the range uMin .. uMax";
        input Real uMax "Polynomial valid in the range uMin .. uMax";
        input Real u "Abscissa value";
        input Real du "Delta of abscissa value";
        output Real dy "Value of derivative of polynomial at u";
      algorithm
        if u < uMin then
          dy := evaluate_der(
                  p,
                  uMin,
                  du);
        elseif u > uMax then
          dy := evaluate_der(
                  p,
                  uMax,
                  du);
        else
          dy := evaluate_der(
                  p,
                  u,
                  du);
        end if;
      end evaluateWithRange_der;

      function integralValue_der
        "Time derivative of integral of polynomial p(u) from u_low to u_high, assuming only u_high as time-dependent (Leibniz rule)"
        extends Modelica.Icons.Function;
        input Real p[:] "Polynomial coefficients";
        input Real u_high "High integrand value";
        input Real u_low=0 "Low integrand value, default 0";
        input Real du_high "High integrand value";
        input Real du_low=0 "Low integrand value, default 0";
        output Real dintegral=0.0
          "Integral of polynomial p from u_low to u_high";
      algorithm
        dintegral := evaluate(p,u_high)*du_high;
      end integralValue_der;

      function derivativeValue_der
        "Time derivative of derivative of polynomial"
        extends Modelica.Icons.Function;
        input Real p[:]
          "Polynomial coefficients (p[1] is coefficient of highest power)";
        input Real u "Abscissa value";
        input Real du "Delta of abscissa value";
        output Real dy
          "Time-derivative of derivative of polynomial w.r.t. input variable at u";
      protected
        Integer n=size(p, 1);
      algorithm
        dy := secondDerivativeValue(p,u)*du;
      end derivativeValue_der;
      annotation (Documentation(info="<html>
<p>
This package contains functions to operate on polynomials,
in particular to determine the derivative and the integral
of a polynomial and to use a polynomial to fit a given set
of data points.
</p>

<p>
Copyright &copy; 2004-2019, Modelica Association and contributors
</p>
</html>",     revisions="<html>
<ul>
<li><em>Oct. 22, 2004</em> by Martin Otter (DLR):<br>
       Renamed functions to not have abbreviations.<br>
       Based fitting on LAPACK<br>
       New function to return the polynomial of an indefinite integral</li>
<li><em>Sept. 3, 2004</em> by Jonas Eborn (Scynamics):<br>
       polyderval, polyintval added</li>
<li><em>March 1, 2004</em> by Martin Otter (DLR):<br>
       first version implemented</li>
</ul>
</html>"));
    end Polynomials;
