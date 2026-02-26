within Modelica.Electrical.Analog.Lines.Functions;
function lineZmatrix
  "Compute matrix of longitudinal impedances per metre of a multi-conductor line"
  extends Modelica.Icons.Function;
  import Modelica.ComplexMath;
  import Modelica.Utilities.Streams;
  import Modelica.Constants.pi;
  import Modelica.Constants.mu_0;
  import Modelica.ComplexMath.j;

  input Integer n "Number of conductors in line";
  input Modelica.Units.SI.Length x[n] "Horizontal abscissas of conductors";
  input Modelica.Units.SI.Length y[n] "Vertical abscissas of conductors";
  input Modelica.Units.SI.Length r[n] "Conductors radii";
  input Modelica.Units.SI.ResistancePerUnitLength R1[n] "Conductors lineic resistance";
  input Real k_s[n]=fill(0.7,n) "Ratio of equivalent shell radius to actual radius";
  //  in case of cylindric conductor this is equal to exp(-mu_r/4)=exp(-0.25)
  input Modelica.Units.SI.Resistivity rho=100 "Ground resistivity";
  input Modelica.Units.SI.Frequency f=50 "Frequency";
  output Modelica.Units.SI.ResistancePerUnitLength Rcomp[div(n * (n + 1), 2)] "Compact resistance matrix";
  output Modelica.Units.SI.ReactancePerUnitLength Xcomp[div(n * (n + 1), 2)] "Compact reactance matrix";
  output Modelica.Units.SI.InductancePerUnitLength Lcomp[div(n * (n + 1), 2)] "Compact inductance)";
protected
  Modelica.Units.SI.Distance D "Generic larger distance";
  Modelica.Units.SI.Distance d "Generic smaller distance";
  Real Theta "Theta angle for Carson's formulas";
  Real L "generic inductance";
  Real P "P coefficient from Carson's original paper";
  Real Q "Q coefficient from Carson's original paper";

  Complex Z[n, n] "Computed matrix (ohm/m)";

  final parameter Real w=2*pi*f;
  parameter Real a0=sqrt(w*mu_0/rho) "multiplies D in a-parameter from EMTPs Theory Book";
  // a0 is written, equivalently, as 4*pi*sqrt(5)*1e-4*sqrt(f/rho) in EMTP Theory book
  //(reference available in Electrical.Analog.References)
  //
  //  a0*D=a; a is the same as "r" in Carson's paper
  // where D=2h for self impedance, D=Dik for mutual impedance
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
      d := sqrt((x[i] - x[jj])^2 + (y[i] - y[jj])^2); //distance between conductors i and jj
      D := sqrt((x[i] - x[jj])^2 + (y[i] + y[jj])^2);  //distance between conductor i and the image of conductor jj
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
    for jj in i:n loop
      k := k + 1;
      Rcomp[k] := Z[jj, i].re;
      Xcomp[k] := Z[jj, i].im;
      Lcomp[k] := Xcomp[k]/w;
    end for;
  end for;
  annotation (Documentation(info="<html>
<p>This function computes resistances, reactances, inductances of multi-conductor transmission lines, taking into account ground characteristics according to John Carson&apos;s formulas as reported in [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Cerolo2018</a>, Appendix], but upgraded in accuracy (more digits in constants and more added terms in the evaluation of Q). </p>
<p>When used in conjunction with <a href=\"modelica://Modelica.Electrical.Analog.Lines.M_OLine\">M_OLine</a> from its output just the inductances are used; the resistances could instead be used when ground resistance is to be taken into account. </p>
<p>The results obtained with this function have been checked with Fig. 4.11 of [<a href=\"modelica://Modelica.Electrical.Analog.UsersGuide.References\">Theory Book</a>], in model <a href=\"modelica://Modelica.Electrical.Analog.Examples.Lines.PowerLineWithFence\">PowerLineWithFence</a>, with good agreement. </p>
<p>The output arrays contain the elements of the Z matrix ordered as described in the <a href=\"modelica://Modelica.Electrical.Analog.Lines.M_OLine\">M_OLine</a> model and are used in example Examples.Lines.PowerLineWithFence in conjunction with M_OLine. </p>
<p>Parameter <span style=\"font-family: Courier New;\">k_s</span> takes into account the conductor&apos;s skin effect; it is 0.778 for a solid non-magnetic conductor, can be between 0.35 and 0.8 for real-life power line conductors (they are stranded and often have an iron core). </p>
<p>According to Carson&apos;s theory the line impedances depend on the frequency of signal, and therefore this function is run for the input given frequency. This is mainly because <span style=\"font-family: MS Shell Dlg 2;\">there is an important skin effect of the ground that causes ground return resistances and inductances to respectively increase and decrease as frequency increases. Nevertheless, values such as those obtained from these formulas are commonly used in power system transients, the steady-state frequency (e.g. 50 or 60 Hz) being used to compute Z matrix from this function.</span></p>
<p>The formulas inside have adequate precision only if the requested computation frequency is within given limits (up to several hundred Hertz); if a larger than acceptable frequency is requested, given the line geometry, a warning is issued. </p>
</html>", revisions="<html>
<p><em>July, 2023</em> </p>
<p>Original implementation by Massimo Ceraolo of the University of Pisa </p>
</html>"));
end lineZmatrix;
