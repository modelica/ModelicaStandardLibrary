within Modelica.Electrical.Analog.Lines.Functions;
function LineCmatrix
  "Compute matrix of transverse capacitances per metre of a multi-conductor line"
  import Modelica.Constants.epsilon_0;
  import Modelica.Constants.pi;
  import Modelica.ComplexMath;
  import Modelica.Utilities.Streams;
  input Integer n "Number of conductors";
  input Modelica.Units.SI.Length x[n] "Horizontal abscissas of conductors";
  input Modelica.Units.SI.Length y[n] "Vertical abscissas of conductors";
  input Modelica.Units.SI.Radius r[n] "Conductors radii (m)";
  output Real Ccompact[div(n*(n + 1), 2)](each final unit="F/m") "Vector of capacitances";
  output Real C[n, n](each final unit="F/m") "Capacitance matrix with negative off-diagonal conductances";
  // Poi la seguente riga andrà cancellata e commentata la corrispodente nella sezione protected
  output Real Cflat[n, n](each final unit="F/m") "Matrix with capacitances of a network reproducing the behaviour of C";
protected
  constant Complex j = Complex(0, 1) "Imaginary unit";
  constant Real K(final unit="F/m") = 1 / (2 * pi * epsilon_0);
  Real p[n, n](each final unit="m/F") "Maxwell's potential matrix";
//  Real Cflat[n, n](each final unit="F/m") "Matrix with capacitances of a network reproducing the behaviour of C";
  Modelica.Units.SI.Distance D "Generic larger distance";
  Modelica.Units.SI.Distance d "Generic smaller distance";
  Integer k;
  String sC;

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
// The off diagonal elements of Cflat are the opposite of corresponding elements of C.
// We first generate the opposite of C, then will redefine its diagonal elements:
  Cflat:=-C;
// The diagonal elements of Cflat contain the sum of all the values the corresponding row in C:
  for i in 1:n loop
    Cflat[i,i]:=sum(C[i,j] for j in 1:n);
  end for;
// Select the elements needed by M_Oline in a vector which it can use directly
  k := 0;
  for i in 1:n loop
    for j in i:n loop
      k := k + 1;
      Ccompact[k] := Cflat[i, j];
    end for;
  end for;
  annotation (
    Documentation(info="<html>
<p>This function computes Capacitances of multi-conductor transmission lines, according to the formulas as reported in [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Ceraolo2018</a>, Appendix].</p>
<p>The results obtained with this function have been checked with Fig. 4.1 of [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">EmtpTheoryBook</a>], with good compliance.</p>
<p>Internally, it computes the <b>C</b> matrix, which corresponds to the formulas <b>V=YI</b>,&nbsp;<b>Y=<span style=\"font-family: Symbol;\">w</span>C&nbsp;</b>where</p>
<p>- <b>V</b> is the vector of voltages between conductors and the reference (the return conductor, usually ground)</p>
<p>-&nbsp;<b>I</b>&nbsp;is the vector of transverse currents (between conductors and the return conductor, usually ground) due to the capacitive coupling between the conductors</p>
<p>- <b>Y</b> is the matrix of transverse admittances of the multiconductor line (S/m)</p>
<p>-&nbsp;<span style=\"font-family: Symbol;\">w</span>&nbsp;is the angular frequency when constant-frequency steady-state operation of the line is considered</p>
<p>This matrix&nbsp;<b>C</b>&nbsp;, has always negative off-diagonal values, and positive diagonal values.</p>
<p>From <b>C</b> matrix, the internal <b>Cflat</b> matrix &nbsp;is computed, containing physical capacitors that can be imagined between conductors to model capacitive effects. For instance C12 is the capacitance (per unit length) to be put between conducturors 1 and 2. This&nbsp;<b>Cflat</b>&nbsp;matrix &nbsp;contains the elements needed by M_OLine for its simulations.&nbsp; </p>
<p>The output array <b>Ccomp </b>contains the elements of the <b>Cflat</b> matrix ordered as described in the M_OLine model, and is used in example Examples.Lines.PowerLineWithFence in conjunction with M_OLine.</p>
<p>For an example on how to use this function, consider model Electrical.Analog.Examples.Lines.TestCmatrix.</p>
</html>",          revisions="<html>
<ul>
<li><em>May, 2021</em> 
      Massimo Ceraolo of the University of Pisa <br> 
      originally created</li> 
</ul>                
</html>"));
end LineCmatrix;
