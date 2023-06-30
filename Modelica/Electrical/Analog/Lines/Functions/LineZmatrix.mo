within Modelica.Electrical.Analog.Lines.Functions;
function LineZmatrix
 "Compute matrix of longitudinal impedances per metre of a multi-conductor line"
  extends Modelica.Icons.Function;
  import Modelica.Constants.*;
  import Modelica.ComplexMath;
  import Modelica.Utilities.Streams;
  input Integer n "number of conductors in line";
  input Real x[n] "horizontal abscissas of conductors (m)";
  input Real y[n] "vertical abscissas of conductors (m)";
  input Real r[n] "conductors radii (m)";
  input Real R1[n] "conductors lineic resistance (ohm/m)";
  input Real k_s[n]=fill(0.7,n) "ratio of equivalent shell radius to actual radius";
  //  in case of cylindric conductor this is equal to exp(-mu_r/4)=exp(-0.25)
  input Real rho=100 "ground resistivity";
  input Real f=50 "frequency";
  output Real Rcomp[div(n * (n + 1), 2)] "Compact resistance matrix (ohm/m)";
  output Real Xcomp[div(n * (n + 1), 2)] "Compact reactance matrix (ohm/m)";
  output Real Lcomp[div(n * (n + 1), 2)] "Compact inductance (H/m)";
protected
  constant Complex j=Complex(0, 1) "Imaginary unit";
  Real D "generic larger distance";
  Real d "generic smaller distance";
  Real Theta "Theta angle for Carson's formulas";
  Real L "generic inductance";
  Real P "P coefficient from Carson's original paper";
  Real Q "Q coefficient from Carson's original paper";

  Complex Z[n, n] "Computed matrix (ohm/m)";

  parameter Real a0=4*pi*sqrt(5)*1e-4*sqrt(f/rho)
    "multiplies D in a-pameter from EMTPs Theory Book";
  //  a0*D=a; a is the same as "r" in Carson's paper
  // where D=2h for self impedanze, D=Dik for mutual impedance
  Real R_g=pi^2*f*1e-7;
  Real w=2*pi*f;
  Real a;
  Integer k;
algorithm
//self impedances with ground return:
  for i in 1:n loop
    a:=a0*2*y[i];
    assert(a<0.25,"parameter a="+String(a)+
                  " >0.25 will result in inadequate precision of Carson's formulas",
                  AssertionLevel.warning);
    P := pi/8 - sqrt(2)/6*a + a^2/16*(0.672784 + log(2/a));
    Q := (-0.03860784) + 0.5*log(2/a) + sqrt(2)/6*a-pi/64*a*a;
    L := mu_0/(2*pi)*log(2*y[i]/(k_s[i]*r[i])) "L when soil is pure conductive";
    Z[i, i] := R1[i] + 4*w*P/1.e7 + j*w*(L + 4*Q/1.e7); //Carson (25) and (30)
  end for;
//mutual impedances with ground return:
  for i in 1:n loop
    for jj in 1:i - 1 loop
      Theta := atan(abs((x[i] - x[jj])/(y[i] + y[jj])));
      d := sqrt((x[i] - x[jj])^2 + (y[i] - y[jj])^2); //distanza fra conduttore i e jj
      D := sqrt((x[i] - x[jj])^2 + (y[i] + y[jj])^2);  //distanza fra conduttore i e immagine di jj
      a:=a0*D;
      P := pi/8 - sqrt(2)/6*a*cos(Theta) + a^2/16*(0.672784
         + log(2/a))*cos(2*Theta)+a^2/16*Theta*sin(2*Theta);
      Q := (-0.03860784) + 0.5*log(2/a) + sqrt(2)/6*a*cos(Theta)-pi/64*a*a*cos(2*Theta);
      L := mu_0/(2*pi)*log(D/d) "L when soil is pure conductive";
      Z[i, jj] := 4*w*P/1.e7 + j*w*(L + 4*Q/1.e7); //Carson (26) and (31)
    end for;
  end for;
  k := 0;
  for i in 1:n loop
    for j in i:n loop
      k := k + 1;
      Rcomp[k] := Z[j, i].re;
      Xcomp[k] := Z[j, i].im;
      Lcomp[k] := Xcomp[k]/w;
    end for;
  end for;
  annotation (Documentation(info="<html>
<p>
This function computes resistances, reactances, inductances of multi-conductor transmission
lines, taking into account ground characteristics according to John Carson&apos;s formulas
as reported in
[<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Cerolo2018</a>, Appendix],
but upgraded in accuracy (more digits in constants and more added terms in the evaluation of Q).
</p>
<p>
When used in conjunction with <a href=\"modelica://Modelica.Electrical.Analog.Lines.M_OLine\">M_OLine</a>
from its output just the inductances are used;
the resistances could instead be used when ground resistance is to be taken into account.
</p>
<p>
The results obtained with this function have been checked with Fig. 4.1 of
[<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">EmtpTheoryBook</a>],
in model Examples.TestM_OLineZ, with good agreement.
</p>
<p>
The output arrays contain the elements of the Z matrix ordered as described in the
<a href=\"modelica://Modelica.Electrical.Analog.Lines.M_OLine\">M_OLine</a> model and are
used in example Examples.Lines.PowerLineWithFence in conjunction with M_OLine.
</p>
<p>
Parameter k_s is 0.778 for a solid non-magnetic conductor; can be between 0.35 and 0.8
for real-life power line conductors (they are stranded and often have an iron core).
</p>
<p>
Note that according to Carson&apos;s theory the line impedances depend on the frequency
of signal, and therefore this function is run for a given frequency. The formulas inside
have adequate precision only for a limited range of frequency (up to several hundred Hertz);
if a larger than acceptable frequency is requested, given the line geometry, a warning is
issued.
</p>
</html>", revisions="<html>
<p><i>July, 2023 </i> </p>
<p>Original implementation by Massimo Ceraolo of the University of Pisa </p>
</html>"));
end LineZmatrix;
