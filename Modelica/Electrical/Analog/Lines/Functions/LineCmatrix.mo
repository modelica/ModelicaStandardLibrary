within Modelica.Electrical.Analog.Lines.Functions;
function LineCmatrix
  "Compute matrix of transverse capacitances per metre of a multi-conductor line"
  import Modelica.Constants.epsilon_0;
  import Modelica.Constants.pi;
  import Modelica.ComplexMath;
  import Modelica.Utilities.Streams;
  input Integer n "Number of conductors in bundle";
  input Modelica.Units.SI.Length x[n] "Horizontal abscissas of conductors";
  input Modelica.Units.SI.Length y[n] "Vertical abscissas of conductors";
  input Modelica.Units.SI.Radius r[n] "Conductors radii (m)";
  output Real Ccompact[div(n*(n + 1), 2)](each unit="F/m") "Vector of capacitances";
  output Real Pself(unit="F/m"), Pmutual(unit="F/m") "Transposed line self and mutual impedance";
protected
  constant Complex j = Complex(0, 1) "Imaginary unit";
  constant Real K(unit="V.m/(A.s)") = 1 / (2 * pi * epsilon_0);
  Real p[n, n](each unit="V.m/(A.s)") "Maxwell's potential matrix";
  Real C[n, n](each unit="F/m") "Computed matrix";
  Modelica.Units.SI.Distance D "Generic larger distance";
  Modelica.Units.SI.Distance d "Generic smaller distance";
  Integer k;
algorithm
  // Diagonal elements of the potential matrix:
  for i in 1:n loop
    p[i, i] := K * log(2 * y[i] / r[i]);
  end for;
  // Out-of diagonal elements of the potential matrix:
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
  // The capacitance function is the inverse of the matrix of potentials
  C := Modelica.Math.Matrices.inv(p);
  // Select the elements needed by _Oline in a vetor which it can use directly
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
<ul>
<li><em>May, 2021</em> 
        Massimo Ceraolo of the University of Pisa <br> 
        originally created</li> 
</ul>                
</html>"));
end LineCmatrix;
