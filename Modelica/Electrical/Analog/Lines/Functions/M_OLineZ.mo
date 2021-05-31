within Modelica.Electrical.Analog.Lines.Functions;
function M_OLineZ
  "Compute matrix of longitudinal impedance per metre of a multi-conductor line"
  import Modelica.Constants.*;
  import Modelica.ComplexMath;
  import Modelica.Utilities.Streams;
  input Integer n "number of conductors in line";
  input Real x[n] "horizontal abscissas of conductors (m)";
  input Real y[n] "vertical abscissas of conductors (m)";
  input Real r[n] "conductors radii (m)";
  input Real R1[n] "conductors lineic resistance (ohm/m)";
  input Real k_s=0.75 "ratio of equivalent tubular radius to radius for all conductors";
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
  Integer k;
algorithm
  //self impedances with ground return:
  for i in 1:n loop
    P := pi / 8 - sqrt(2) / 6 * a0 * 2 * y[i] + (a0 / 2 * y[i]) ^ 2 / 16 * (0.6728 + log(1 / (a0 * y[i])));
    Q := (-0.0386) + 0.5 * log(1 / (a0 * y[i])) + sqrt(2) / 3 * a0 * y[i];
    L :=Modelica.Constants.mu_0/(2*pi)*log(2*y[i]/(k_s*r[i]));
    Z[i, i] := R1[i] + 4 * w * P / 1.e7 + j * w * (L + 4 * Q / 1.e7);
  end for;
  //mutual impedances with ground return:
  for i in 1:n loop
    for jj in 1:i - 1 loop
      Theta := atan(abs((x[i] - x[jj]) / (y[i] + y[jj])));
      d := sqrt((x[i] - x[jj]) ^ 2 + (y[i] - y[jj]) ^ 2);
      D := sqrt((x[i] - x[jj]) ^ 2 + (y[i] + y[jj]) ^ 2);
      P := pi / 8 - sqrt(2) / 6 * a0 * 2 * y[i] * cos(Theta) + (a0 / 2 * y[i]) ^ 2 / 16 * (0.6728 + log(1 / (a0 * y[i]))) * cos(2 * Theta);
      Q := (-0.03860784) + 0.5 * log(1 / (a0 * y[i])) + sqrt(2) / 3 * a0 * y[i] * cos(Theta);
      L :=Modelica.Constants.mu_0/(2*pi)*log(D/d);
      Z[i, jj] := 4 * w * P / 1.e7 + j * w * (L + 4 * Q / 1.e7);
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
<p>This function computes resistances, reactances, inductances of multi-conductor transmission lines, taking into account ground characteristics according to John Carson&apos;s formulas as reported in [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Ceraolo2018</a>, Appendix].</p>
<p>When used in conjunction with M_Oline from its output just inductances are used; resistances could instead be used when ground resistance is to be taken into account.</p>
<p>The results obtained with this function have been checked with Fig. 4.1 of [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">EmtpTheoryBook</a>], in model Examples.TestM_OLineZ, with acceptable compliance. Small differences exist, since Carson&apos;s formulas can be approximated in different ways.</p>
<p>The output arrays contain the elements of the Z matrix ordered as described in the M_OLine model and is used in example Examples.Lines.PowerLineWithFence in conjunction ith M_OLine.</p>
</html>"));
end M_OLineZ;
