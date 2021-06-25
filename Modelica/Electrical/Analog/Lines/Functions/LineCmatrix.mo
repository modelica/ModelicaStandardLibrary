within Modelica.Electrical.Analog.Lines.Functions;
function LineCmatrix
  "Compute matrix of transverse capacitances per metre of a multi-conductor line"
  // Function created by Massimo Ceraolo from the University of Pisa on May 2021
  import Modelica.Constants.*;
  import Modelica.ComplexMath;
  import Modelica.Utilities.Streams;
  input Integer n "number of conductors in bundle";
  input Real x[n] "horizontal abscissas of conductors (m)";
  input Real y[n] "vertical abscissas of conductors (m)";
  input Real r[n] "conductors radii (m)";
  output Real Ccompact[div(n*(n + 1), 2)] "Vector of capacitances (F/m)";
  output Real Pself, Pmutual "Transposed line self and mutual impedance";
protected
  constant Complex j = Complex(0, 1) "Imaginary unit";
  constant Real K = 1 / (2 * pi * epsilon_0);
  Real p[n, n] "Maxwell's potential matrix";
  Real C[n, n] "Computed matrix (F/m)";
  Real D "generic larger distance";
  Real d "generic smaller distance";
  Integer k;
algorithm
//Diagonal elements of the potential matrix:
  for i in 1:n loop
    p[i, i] := K * log(2 * y[i] / r[i]);
  end for;
//Out-of Diagonal elements of the potential matrix:
  for i in 1:n loop
    for jj in 1:i - 1 loop
      d := sqrt((x[i] - x[jj]) ^ 2 + (y[i] - y[jj]) ^ 2);
      D := sqrt((x[i] - x[jj]) ^ 2 + (y[i] + y[jj]) ^ 2);
      p[i, jj] := K * log(D / d);
    end for;
  end for;
  for i in 1:n loop
    for jj in i + 1:n loop
      p[i, jj] := p[jj, i];
    end for;
  end for;
//The capacitance function is the inverse of the matrix of potentials
  C := Modelica.Math.Matrices.inv(p);
//Select the elements needed by _Oline in a vetor which it can use directly
  k := 0;
  for i in 1:n loop
    for j in i:n loop
      k := k + 1;
      Ccompact[k] := C[i, j];
    end for;
  end for;

  if n == 3 then
    Pself := 1 / 3 * (p[1, 1] + p[2, 2] + p[3, 3]);
    Pmutual := 1 / 3 * (p[1, 2] + p[2, 3] + p[3, 1]);
  else
    Pself := 0;
    Pmutual := 0;
  end if;
  annotation (
    Documentation(info="<html>
<p>This function computes Capacitances of multi-conductor transmission lines, according to John Carson&apos;s formulas as reported in [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Ceraolo2018</a>, Appendix].</p>
<p>The results obtained with this function have been checked with Fig. 4.1 of [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">EmtpTheoryBook</a>], with good compliance.</p>
<p>The output array contains the elements of the C matrix ordered as described in the M_OLine model, and is used in example Examples.Lines.PowerLineWithFence in conjunction with M_OLine.</p>
</html>", revisions="<html>
<li><em>May, 2021</em> 
        Massimo Ceraolo of the University of Pisa <br> 
        originally created</li> 
</html>"));
end LineCmatrix;
