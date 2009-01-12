within Modelica.Electrical.Analog;
package Lines
  "Lossy and lossless segmented transmission lines, and LC distributed line models"
  extends Modelica.Icons.Library;
  annotation (
    Documentation(info="<html>
<p>
This package contains lossy and lossless segmented transmission lines,
and LC distributed line models.
</p>
 
</HTML>
", revisions="<html>
<dl>
<dt>
<b>Main Authors:</b>
<dd>
<a href=\"http://people.eas.iis.fhg.de/Christoph.Clauss/\">Christoph Clau&szlig;</a>
    &lt;<a href=\"mailto:clauss@eas.iis.fhg.de\">clauss@eas.iis.fhg.de</a>&gt;<br>
    <a href=\"http://people.eas.iis.fhg.de/Joachim.Haase/\">Joachim Haase;</a> 
    &lt;<a href=\"mailto:haase@eas.iis.fhg.de\">haase@eas.iis.fhg.de</a>&gt;<br>
    <a href=\"http://people.eas.iis.fhg.de/Andre.Schneider/\">Andr&eacute; Schneider</a> 
    &lt;<a href=\"mailto:schneider@eas.iis.fhg.de\">schneider@eas.iis.fhg.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden<br>
<p>
<dt>
<b>Copyright:</b>
<dd>
Copyright &copy; 1998-2006, Modelica Association and Fraunhofer-Gesellschaft.<br>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".</i><br>
<p>
</dl>
</html>"));

  model OLine "Lossy Transmission Line"
    //extends Interfaces.ThreePol;
    Interfaces.Pin p1 annotation (Placement(transformation(extent={{-110,-10},{
              -90,10}}, rotation=0)));
    Interfaces.Pin p2 annotation (Placement(transformation(extent={{90,-10},{
              110,10}}, rotation=0)));
    Interfaces.Pin p3 annotation (Placement(transformation(extent={{-10,-110},{
              10,-90}}, rotation=0)));
    SI.Voltage v13;
    SI.Voltage v23;
    SI.Current i1;
    SI.Current i2;
    parameter Real r(
      final min=Modelica.Constants.small,
      unit="Ohm/m", start=1) "Resistance per meter";
    parameter Real l(
      final min=Modelica.Constants.small,
      unit="H/m", start=1) "Inductance per meter";
    parameter Real g(
      final min=Modelica.Constants.small,
      unit="S/m", start=1) "Conductance per meter";
    parameter Real c(
      final min=Modelica.Constants.small,
      unit="F/m", start=1) "Capacitance per meter";
    parameter SI.Length length(final min=Modelica.Constants.small, start=1)
      "Length of line";
    parameter Integer N(final min=1, start=1) "Number of lumped segments";
  protected
    Basic.Resistor R[N + 1](R=fill(r*length/(N + 1), N + 1));
    Basic.Inductor L[N + 1](L=fill(l*length/(N + 1), N + 1));
    Basic.Capacitor C[N](C=fill(c*length/(N), N));
    Basic.Conductor G[N](G=fill(g*length/(N), N));
    annotation (
      Documentation(info="<html>
<P>
Lossy Transmission Line.
  The lossy transmission line OLine consists of segments of
  lumped resistances and inductances in series
  and conductances and capacitances that are
  connected with the reference pin p3. The precision
  of the model depends on the number N of
  lumped segments.
</P>
<DL>
<DT>
<b>References:</b>
<DD>
  Johnson, B.; Quarles, T.; Newton, A. R.; Pederson, D. O.;
  Sangiovanni-Vincentelli, A.: SPICE3 Version 3e User's Manual
  (April 1, 1991). Department of Electrical Engineering and
  Computer Sciences, University of California, Berkley
  p. 12, p. 106 - 107
</DL>
</P>
</HTML>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-60,60},{60,-60}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{0,-60},{0,-90}}, color={0,0,255}),
          Line(points={{60,0},{90,0}}, color={0,0,255}),
          Line(points={{-60,0},{-90,0}}, color={0,0,255}),
          Line(points={{30,30},{-30,30}}, color={0,0,255}),
          Line(points={{-30,40},{-30,20}}, color={0,0,255}),
          Line(points={{30,40},{30,20}}, color={0,0,255}),
          Text(
            extent={{-100,100},{100,70}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(points={{0,-60},{0,-96}}, color={0,0,255}),
          Line(points={{60,0},{96,0}}, color={0,0,255}),
          Line(points={{-60,0},{-96,0}}, color={0,0,255}),
          Line(points={{30,30},{-30,30}}, color={0,0,255}),
          Line(points={{-30,40},{-30,20}}, color={0,0,255}),
          Line(points={{30,40},{30,20}}, color={0,0,255})}));
  equation
    v13 = p1.v - p3.v;
    v23 = p2.v - p3.v;
    i1 = p1.i;
    i2 = p2.i;
    connect(p1, R[1].p);
    for i in 1:N loop
      connect(R[i].n, L[i].p);
      connect(L[i].n, C[i].p);
      connect(L[i].n, G[i].p);
      connect(C[i].n, p3);
      connect(G[i].n, p3);
      connect(L[i].n, R[i + 1].p);
    end for;
    connect(R[N + 1].n, L[N + 1].p);
    connect(L[N + 1].n, p2);
  end OLine;

model M_OLine "multiple OLine"

  parameter Modelica.SIunits.Length length(final min=Modelica.Constants.small) = 0.1
      "Length of line";
  parameter Integer N(final min=1) = 5 "Number of lumped segments";
  parameter Integer lines(final min=2) = 4 "Number of lines";
  protected
  parameter Integer dim_vector_lgc=div(lines*(lines+1),2);
  public
  parameter Real r[lines](
    final min=Modelica.Constants.small,
    unit="Ohm/m") = {4.76e5,1.72e5,1.72e5,1.72e5} "Resistance per meter";

  parameter Real l[dim_vector_lgc](
    final min=Modelica.Constants.small,
    unit="H/m") = {5.98e-7,4.44e-7,4.39e-7,3.99e-7,5.81e-7,4.09e-7,4.23e-7,5.96e-7,4.71e-7,
        6.06e-7} "Inductance per meter";

  parameter Real g[dim_vector_lgc](
    final min=Modelica.Constants.small,
    unit="S/m") = {8.05e-6,3.42e-5,2 - 91e-5,1.76e-6,9.16e-6,7.12e-6,2.43e-5,5.93e-6,
        4.19e-5,6.64e-6} "Conductance per meter";

  parameter Real c[dim_vector_lgc](
    final min=Modelica.Constants.small,
    unit="F/m") = {2.38e-11,1.01e-10,8.56e-11,5.09e-12,2.71e-11,2.09e-11,7.16e-11,1.83e-11,
        1.23e-10,2.07e-11} "Capacitance per meter";

model segment

  parameter Integer lines(final min=1)=3;       //number of lines
  parameter Integer dim_vector_lgc=div(lines*(lines+1),2);
  Modelica.Electrical.Analog.Interfaces.PositivePin p[lines] "Positive pin" 
              annotation (Placement(transformation(extent={{-60,-10},{-40,10}},
            rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n[lines] "Negative pin" 
              annotation (Placement(transformation(extent={{40,-10},{60,10}},
            rotation=0)));

  parameter Real Cl[dim_vector_lgc]=fill(1,dim_vector_lgc);
  parameter Real Rl[lines]=fill(7,lines);
  parameter Real Ll[dim_vector_lgc]=fill(2,dim_vector_lgc);
  parameter Real Gl[dim_vector_lgc]= fill(1,dim_vector_lgc);

  Modelica.Electrical.Analog.Basic.Capacitor C[dim_vector_lgc](C=Cl);
  Modelica.Electrical.Analog.Basic.Resistor R[lines](R=Rl);
  Modelica.Electrical.Analog.Basic.Conductor G[dim_vector_lgc](G=Gl);
  Modelica.Electrical.Analog.Basic.M_Transformer inductance(N=lines, L=Ll);
  Modelica.Electrical.Analog.Basic.Ground M;

equation
  for j in 1:lines-1 loop

    connect(R[j].p,p[j]);
    connect(R[j].n,inductance.p[j]);
    connect(inductance.n[j],n[j]);
    connect(inductance.n[j],C[((1+(j-1)*lines)-((j-2)*(j-1))*0.5)].p);
    connect(C[((1+(j-1)*lines)-((j-2)*(j-1))*0.5)].n,M.p);
    connect(inductance.n[j],G[((1+(j-1)*lines)-((j-2)*(j-1))*0.5)].p);
    connect(G[((1+(j-1)*lines)-((j-2)*(j-1))*0.5)].n,M.p);

    for i in j+1:lines loop
      connect(inductance.n[j],C[((1+(j-1)*lines)-((j-2)*(j-1))*0.5)+1+i-(j+1)].p);
      connect(C[((1+(j-1)*lines)-((j-2)*(j-1))*0.5)+1+i-(j+1)].n,inductance.n[i]);
      connect(inductance.n[j],G[((1+(j-1)*lines)-((j-2)*(j-1))*0.5)+1+i-(j+1)].p);
      connect(G[((1+(j-1)*lines)-((j-2)*(j-1))*0.5)+1+i-(j+1)].n,inductance.n[i]);
    end for;
  end for;
    connect(R[lines].p,p[lines]);
    connect(R[lines].n,inductance.p[lines]);
    connect(inductance.n[lines],n[lines]);
    connect(inductance.n[lines],C[dim_vector_lgc].p);
    connect(C[dim_vector_lgc].n,M.p);
    connect(inductance.n[lines],G[dim_vector_lgc].p);
    connect(G[dim_vector_lgc].n,M.p);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(extent={{40,-40},{-40,40}},
                lineColor={0,0,255})}),
                            Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}),
                                    graphics),
    uses(Modelica(version="2.2.1")));
end segment;

model segment_last

  Modelica.Electrical.Analog.Interfaces.PositivePin p[lines] "Positive pin" 
              annotation (Placement(transformation(extent={{-40,-10},{-20,10}},
            rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n[lines] "Negative pin" 
              annotation (Placement(transformation(extent={{20,-10},{40,10}},
            rotation=0)));
  parameter Integer lines(final min=1)=3;
  parameter Integer dim_vector_lgc= div(lines*(lines+1),2);
  parameter Real Rl[lines]=fill(1,lines);
  parameter Real Ll[dim_vector_lgc]=fill(1,dim_vector_lgc);
  Modelica.Electrical.Analog.Basic.Resistor R[lines](R=Rl);
  Modelica.Electrical.Analog.Basic.M_Transformer inductance(  N=lines, L=Ll);
  Modelica.Electrical.Analog.Basic.Ground M;

equation
  for j in 1:lines-1 loop

    connect(p[j],inductance.p[j]);
    connect(inductance.n[j],R[j].p);
    connect(R[j].n,n[j]);
  end for;
    connect(p[lines],inductance.p[lines]);
    connect(inductance.n[lines],R[lines].p);
    connect(R[lines].n,n[lines]);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(extent={{20,-40},{-20,40}},
                lineColor={0,0,255})}),
                            uses(Modelica(version="2.2.1")));
end segment_last;

  segment s[N - 1](
    lines=fill(lines, N - 1),
    dim_vector_lgc=fill(dim_vector_lgc, N - 1),
    Rl=fill(r*length/N, N - 1),
    Ll=fill(l*length/N, N - 1),
    Cl=fill(c*length/N, N - 1),
    Gl=fill(g*length/N, N - 1));
  segment s_first(
    lines=lines,
    dim_vector_lgc=dim_vector_lgc,
    Rl=r*length/(2*N),
    Cl=c*length/(N),
    Ll=l*length/(2*N),
    Gl=g*length/(N));
  segment_last s_last(
    lines=lines,
    Rl=r*length/(2*N),
    Ll=l*length/(2*N));
  Modelica.Electrical.Analog.Interfaces.PositivePin p[lines] "Positive pin" 
              annotation (Placement(transformation(extent={{-100,-80},{-80,80}},
          rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n[lines] "Negative pin" 
              annotation (Placement(transformation(extent={{80,-80},{100,80}},
          rotation=0)));

equation
    connect(p,s_first.p);
    connect(s_first.n,s[1].p);
  for i in 1:N-2 loop
    connect(s[i].n,s[i+1].p);
  end for;
    connect(s[N-1].n,s_last.p);
    connect(s_last.n,n);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(extent={{60,80},{-60,-80}}, lineColor={0,0,255}),
          Line(points={{40,60},{40,40}}),
          Line(points={{40,50},{-40,50}}),
          Line(points={{-40,60},{-40,40}}),
          Line(points={{40,-40},{40,-60}}),
          Line(points={{40,-50},{-40,-50}}),
          Line(points={{-40,-40},{-40,-60}}),
          Line(points={{40,30},{40,10}}),
          Line(points={{40,20},{-40,20}}),
          Line(points={{-40,30},{-40,10}}),
          Line(
            points={{0,6},{0,-34}},
            color={0,0,255},
            pattern=LinePattern.Dot),
          Text(
            extent={{-46,102},{38,80}},
            lineColor={0,0,255},
            pattern=LinePattern.Dot,
            textString="%name")}),
    Documentation(revisions="<HTML>
<ul>
 
<li><i> November 24, 2008   </i> docu added, cosmetic, K. Majetta
       </li>
<li><i>February 26, 2007</i>
       by Kristin Majetta<br>
       initially modelled.</li>
</ul>
</HTML>",
        info="<html>
<p>
The M_OLine is a multi line model  which consists of several segements and several single lines. 
Each segement consists of resistors and inductors that are connected in series in each single line, and of capacitors and conductors both between the lines and to the ground. The inductors are coupled to each other like in the M_Inductor model. The following picture shows the schematic of a segment with four single lines (lines=4):
<br>
<br>
<p align=\"center\">
<IMG SRC=\"../Images/Electrical/Analog/segment.png\" width=\"600\"  
ALT=\"model Analog.Lines.M_OLine\">
</p>
<br>
The complete multi line consists of N segments and an auxiliary segment_last:<br>
<br>
<center>
-- segment_1 -- segment_2 -- ... -- segment_N -- segment_last -- <br>
</center>
<br>
 
In the picture of the segment can be seen, that a single segment is unsymmetric. Connecting such unsymmetric segments in a series forces also an unsymmetric multi line. To get a symmetric model which
is useful for coupling and which guaranties the same pin properties, in the segment_1 only half valued resistors and inductors are used. The remaining resistors and inductors are at the other end of the line within the auxiliary segment_last. For the example with 4 lines the schematic of segment_last is like this:<br>
<br>
<p align=\"center\">
<IMG SRC=\"../Images/Electrical/Analog/segment_last.png\" width=\"200\"  
ALT=\"model Analog.Lines.M_OLine\">
</p>
<br>
 The number of the capacitors 
and conductors depends on the number of single lines that are used, because each line is connected to every other line by both a capacitor and a conductor. One line consists of <b>at least two segements</b>.
</p>

Inside the model M_OLine the model <i>segment</i> is used. This model represents one segment which is build as described above. For modelling the inductances and their mutual couplings the model M_Transformer is used.


To fill the resistance vector, resistance values as many as lines are needed, e.g. if there are four lines, 
four resistances are needed. For example for a microelectronic line of 0.1m lenght, a sensible resistance-vector 
would be R=[4.76e5, 1.72e5, 1.72e5, 1.72e5].

<p>
Filling the matrixes of the inductances, capacitances and conductances is a bit more complicated, because 
those components occur also between two lines and not only (like the resistor) in one line. The entries of 
the matrices are given by the user in form of a vector. The  vector length dim_vector_lgc is calculated by  <b>dim_vector_lgc = lines*(lines+1)/2</b>. Inside the model a symmetric inductance matrix, a symmetric capacitance matrix and 
a symmetric conductance matrix are build out of the entries of the vectors given by the user. The way of building 
is the same for each matrix, so the approach for filling one of the matrices will be shown at an example: 
<br>
The number of lines is assumed to be four. To build the matrix, the model needs the values from the main diagonal and from <br>the positions that are below the main diagonal. To get the following matrix  
<br>
<br>
<center>
<table>
  <tr>
    <td></td>
    <td></td>
    <td><b>1</b></td>
    <td>0.1</td>
    <td>0.2</td>
    <td>0.4</td> 
  </tr>
  <tr>
    <td>Matrix</td>
    <td>=</td>
    <td>0.1</td>
    <td><b>2</b></td>
    <td>0.3</td>
    <td>0.5</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td>0.2</td>
    <td>0.3</td>
    <td><b>3</b></td>
    <td>0.6</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td>0.4</td>
    <td>0.5</td>
    <td>0.6</td>
    <td><b>4</b></td>
  </tr>
</table>
</center>
the vector with dim_vector_lgc=4*5/2=10 has to appear in the following way: vector = [<b>1</b>, 0.1, 0.2, 0.4, <b>2</b>, 0.3 0.5, <b>3</b>, 0.6, <b>4</b>]
</p>
<p>
For the example of a microelectronic line of 0.1m lenght, which is used as default example for the M_OLine model, a sensible inductance-matrix would be 
<center>
<table>
  <tr>
    <td></td>
    <td></td>
    <td>5.98e-7</td>
    <td>4.44e-7</td>
    <td>4.39e-7</td>
    <td>3.99e-7</td>
  </tr>
  <tr>
    <td>L</td>
    <td>=</td>
    <td>4.44e-7</td>
    <td>5.81e-7</td>
    <td>4.09e-7</td>
    <td>4.23e-7</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td>4.39e-7</td>
    <td>4.09e-7</td>
    <td>5.96e-7</td>
    <td>4.71e-7</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td>3.99e-7</td>
    <td>4.23e-7</td>
    <td>4.71e-7</td>
    <td>6.06e-7</td>
  </tr>
</table>
</center>
</p>
<p>
For the example of a microelectronic line of 0.1m lenght, which is used as default example for the M_OLine model, a sensible capacitance-matrix would be 
<center>
<table>
  <tr>
    <td></td>
    <td></td>
    <td>2.38e-11</td>
    <td>1.01e-10</td>
    <td>8.56e-11</td>
    <td>5.09e-12</td>
  </tr>
  <tr>
    <td>C</td>
    <td>=</td>
    <td>1.01e-10</td>
    <td>2.71e-11</td>
    <td>2.09e-11</td>
    <td>7.16e-11</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td>8.56e-11</td>
    <td>2.09e-11</td>
    <td>1.83e-11</td>
    <td>1.23e-10</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td>5.09e-12</td>
    <td>7.16e-11</td>
    <td>1.23e-10</td>
    <td>2.07e-11</td>
  </tr>
</table>
</center>
</p>
<p>
For the example of a microelectronic line of 0.1m lenght, which is used as default example for the M_OLine model, a sensible conductance-matrix would be 
<center>
<table>
  <tr>
    <td></td>
    <td></td>
    <td>8.05e-6</td>
    <td>3.42e-5</td>
    <td>2.91e-5</td>
    <td>1.76e-5</td>
  </tr>
  <tr>
    <td>G</td>
    <td>=</td>
    <td>3.42e-5</td>
    <td>9.16e-6</td>
    <td>5.93e-6</td>
    <td>6.64e-6</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td>2.90e-5</td>
    <td>7.08e-6</td>
    <td>5.93e-6</td>
    <td>4.19e-5</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td>1.71e-6</td>
    <td>2.43e-5</td>
    <td>4.18e-5</td>
    <td>6.64e-6</td>
  </tr>
</table>
</center>
</p>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),
            graphics),
    experiment(
      StopTime=1e-009,
      NumberOfIntervals=2000,
      Tolerance=1e-009),
    experimentSetupOutput,
    uses(Modelica(version="3.0")),
    version="1",
    conversion(noneFromVersion=""));
end M_OLine;

  model ULine "Lossy RC Line"
    //extends Interfaces.ThreePol;
    Interfaces.Pin p1 annotation (Placement(transformation(extent={{-110,-10},{
              -90,10}}, rotation=0)));
    Interfaces.Pin p2 annotation (Placement(transformation(extent={{90,-10},{
              110,10}}, rotation=0)));
    Interfaces.Pin p3 annotation (Placement(transformation(extent={{-10,-110},{
              10,-90}}, rotation=0)));
    SI.Voltage v13;
    SI.Voltage v23;
    SI.Current i1;
    SI.Current i2;
    parameter Real r(
      final min=Modelica.Constants.small,
      unit="Ohm/m", start=1) "Resistance per meter";
    parameter Real c(
      final min=Modelica.Constants.small,
      unit="F/m", start=1) "Capacitance per meter";
    parameter SI.Length length(final min=Modelica.Constants.small, start=1)
      "Length of line";
    parameter Integer N(final min=1, start=1) "Number of lumped segments";
  protected
    Basic.Resistor R[N + 1](R=fill(r*length/(N + 1), N + 1));
    Basic.Capacitor C[N](C=fill(c*length/(N), N));
    annotation (
      Documentation(info="<html>
<P>
The lossy RC line ULine consists of segments of
lumped series resistances and capacitances that are
connected with the reference pin p3. The precision
of the model depends on the number N of
lumped segments.
</P>
 
<p>
<b>References</b></dt>
</p>
<dl>
<dt> Johnson, B.; Quarles, T.; Newton, A. R.; Pederson, D. O.;
    Sangiovanni-Vincentelli, A.</dt>
<dd> SPICE3 Version 3e User's Manual
    (April 1, 1991). Department of Electrical Engineering and
    Computer Sciences, University of California, Berkley
    p. 22, p. 124</dd>
</dl>
</HTML>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-60,60},{60,-60}},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            lineColor={0,0,255}),
          Line(points={{0,-60},{0,-90}}, color={0,0,255}),
          Line(points={{60,0},{90,0}}, color={0,0,255}),
          Line(points={{-60,0},{-90,0}}, color={0,0,255}),
          Line(points={{30,30},{-30,30}}, color={0,0,255}),
          Line(points={{-30,40},{-30,20}}, color={0,0,255}),
          Line(points={{30,40},{30,20}}, color={0,0,255}),
          Text(
            extent={{-100,100},{100,70}},
            textString="%name",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(points={{0,-60},{0,-96}}, color={0,0,255}),
          Line(points={{60,0},{96,0}}, color={0,0,255}),
          Line(points={{-60,0},{-96,0}}, color={0,0,255}),
          Line(points={{30,30},{-30,30}}, color={0,0,255}),
          Line(points={{-30,40},{-30,20}}, color={0,0,255}),
          Line(points={{30,40},{30,20}}, color={0,0,255})}));
  equation
    v13 = p1.v - p3.v;
    v23 = p2.v - p3.v;
    i1 = p1.i;
    i2 = p2.i;
    connect(p1, R[1].p);
    for i in 1:N loop
      connect(R[i].n, R[i + 1].p);
    end for;
    for i in 1:N loop
      connect(R[i].n, C[i].p);
    end for;
    for i in 1:N loop
      connect(C[i].n, p3);
    end for;
    connect(R[N + 1].n, p2);
  end ULine;

   model TLine1
    "Lossless transmission line with characteristic impedance Z0 and transmission delay TD"

     extends Modelica.Electrical.Analog.Interfaces.TwoPort;
     parameter Modelica.SIunits.Resistance Z0(start=1)
      "Characteristic impedance";
     parameter Modelica.SIunits.Time TD(start=1) "Transmission delay";
  protected
     Modelica.SIunits.Voltage er;
     Modelica.SIunits.Voltage es;
    annotation (
      Documentation(info="<html>
<p>
Lossless transmission line with characteristic impedance Z0 and transmission delay TD
  The lossless transmission line TLine1 is a two Port. Both port branches
  consist of a resistor with characteristic impedance Z0 and a controled voltage
  source that takes into consideration the transmission delay TD.
  For further details see Branin's article below.
  The model parameters can be derived from inductance and 
  capacitance per length (L' resp. C'), i. e.
  Z0 = sqrt(L'/C') and TD = sqrt(L'*C')*length_of_line. Resistance R'
  and conductance C' per meter are assumed to be zero.
</p>
 
 
<p>
<b>References:</b>
</p>
<dl>
<dt>Branin Jr., F. H.</dt>
<dd> Transient Analysis of Lossless Transmission Lines.
     Proceedings of the IEEE 55(1967), 2012 - 2013<dd>
<dt> Hoefer, E. E. E.; Nielinger, H.</dt>
<dd> SPICE : Analyseprogramm fuer elektronische
  Schaltungen. Springer-Verlag, Berlin, Heidelberg, New York, Tokyo, 1985.
</dd>
</dl>
 
</html>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Joachim Haase<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(points={{60,-50},{90,-50}}, color={0,0,255}),
          Line(points={{60,50},{90,50}}, color={0,0,255}),
          Line(points={{-60,50},{-90,50}}, color={0,0,255}),
          Line(points={{-60,-50},{-90,-50}}, color={0,0,255}),
          Line(points={{30,30},{-30,30}}, color={0,0,255}),
          Line(points={{-30,40},{-30,20}}, color={0,0,255}),
          Line(points={{30,40},{30,20}}, color={0,0,255}),
          Text(
            extent={{-100,100},{100,70}},
            textString="TLine1",
            lineColor={0,0,255}),
          Text(
            extent={{-30,10},{30,-20}},
            textString="TLine1",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(points={{60,-50},{96,-50}}, color={0,0,255}),
          Line(points={{60,50},{96,50}}, color={0,0,255}),
          Line(points={{-60,50},{-96,50}}, color={0,0,255}),
          Line(points={{-60,-50},{-96,-50}}, color={0,0,255}),
          Line(points={{30,30},{-30,30}}, color={0,0,255}),
          Line(points={{-30,40},{-30,20}}, color={0,0,255}),
          Line(points={{30,40},{30,20}}, color={0,0,255}),
          Text(
            extent={{-100,100},{100,70}},
            textString="TLine1",
            lineColor={0,0,255}),
          Text(
            extent={{-30,0},{31,-31}},
            textString="TLine1",
            lineColor={0,0,255})}));
   equation
     assert(Z0 > 0, "Z0 has to be positive");
     assert(TD > 0, "TD has to be positive");
     i1 = (v1 - es)/Z0;
     i2 = (v2 - er)/Z0;
     es = 2*delay(v2, TD) - delay(er, TD);
     er = 2*delay(v1, TD) - delay(es, TD);
   end TLine1;

  model TLine2
    "Lossless transmission line with characteristic impedance Z0, frequency F and normalized length NL"

    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    parameter Modelica.SIunits.Resistance Z0(start=1)
      "Characteristic impedance";
    parameter Modelica.SIunits.Frequency F(start=1) "Frequency";
    parameter Real NL(start=1) "Normalized length";
  protected
    Modelica.SIunits.Voltage er;
    Modelica.SIunits.Voltage es;
    Modelica.SIunits.Time TD;
    annotation (
      Documentation(info="<html>
<p>
Lossless transmission line with characteristic impedance Z0, frequency F and normalized length NL
  The lossless transmission line TLine2 is a two Port. Both port branches
  consist of a resistor with the value of the characteristic impedance Z0 
  and a controled voltage source that takes into consideration 
  the transmission delay.
  For further details see Branin's article below.
  Resistance R' and conductance C' per meter are assumed to be zero.
  The characteristic impedance Z0 can be derived from inductance and 
  capacitance per length (L' resp. C'), i. e. Z0 = sqrt(L'/C').   
  The normalized length NL is equal to the length of the line divided
  by the wavelength corresponding to the frequency F, i. e. the
  transmission delay TD is the quotient of NL and F.
</p>
 
 
<p>
<b>References:</b>
</p>
<dl>
<dt>Branin Jr., F. H.</dt>
<dd> Transient Analysis of Lossless Transmission Lines.
     Proceedings of the IEEE 55(1967), 2012 - 2013<dd>
<dt> Hoefer, E. E. E.; Nielinger, H.</dt>
<dd> SPICE : Analyseprogramm fuer elektronische
  Schaltungen. Springer-Verlag, Berlin, Heidelberg, New York, Tokyo, 1985.
</dd>
</dl>
 
</html>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Joachim Haase<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(points={{60,-50},{90,-50}}, color={0,0,255}),
          Line(points={{60,50},{90,50}}, color={0,0,255}),
          Line(points={{-60,50},{-90,50}}, color={0,0,255}),
          Line(points={{-60,-50},{-90,-50}}, color={0,0,255}),
          Line(points={{30,30},{-30,30}}, color={0,0,255}),
          Line(points={{-30,40},{-30,20}}, color={0,0,255}),
          Line(points={{30,40},{30,20}}, color={0,0,255}),
          Text(
            extent={{-100,100},{100,70}},
            textString="TLine2",
            lineColor={0,0,255}),
          Text(
            extent={{-30,10},{30,-20}},
            textString="TLine2",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(points={{60,-50},{96,-50}}, color={0,0,255}),
          Line(points={{60,50},{96,50}}, color={0,0,255}),
          Line(points={{-60,50},{-96,50}}, color={0,0,255}),
          Line(points={{-60,-50},{-96,-50}}, color={0,0,255}),
          Line(points={{30,30},{-30,30}}, color={0,0,255}),
          Line(points={{-30,40},{-30,20}}, color={0,0,255}),
          Line(points={{30,40},{30,20}}, color={0,0,255}),
          Text(
            extent={{-100,100},{100,70}},
            textString="TLine2",
            lineColor={0,0,255})}));
  equation
    assert(Z0 > 0, "Z0 has to be positive");
    assert(NL > 0, "NL has to be positive");
    assert(F > 0, "F  has to be positive");
    TD = NL/F;
    i1 = (v1 - es)/Z0;
    i2 = (v2 - er)/Z0;
    es = 2*delay(v2, TD) - delay(er, TD);
    er = 2*delay(v1, TD) - delay(es, TD);
  end TLine2;

  model TLine3
    "Lossless transmission line with characteristic impedance Z0 and frequency F"
    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    parameter Modelica.SIunits.Resistance Z0(start=1) "Natural impedance";
    parameter Modelica.SIunits.Frequency F(start=1) "Frequency";
  protected
    Modelica.SIunits.Voltage er;
    Modelica.SIunits.Voltage es;
    Modelica.SIunits.Time TD;
    annotation (
      Documentation(info="<html>
<p>
Lossless transmission line with characteristic impedance Z0 and frequency F
  The lossless transmission line TLine3 is a two Port. Both port branches
  consist of a resistor with value of the characteristic impedance Z0 
  and a controled voltage source that takes into consideration 
  the transmission delay.
  For further details see Branin's article below.
  Resistance R' and conductance C' per meter are assumed to be zero.
  The characteristic impedance Z0 can be derived from inductance and 
  capacitance per length (L' resp. C'), i. e. Z0 = sqrt(L'/C').   
  The length of the line is equal to a quarter of the wavelength
  corresponding to the frequency F, i. e. the
  transmission delay is the quotient of 4 and F.
  In this case, the caracteristic impedance is called natural impedance.
</p>
 
 
<p>
<b>References:</b>
</p>
<dl>
<dt>Branin Jr., F. H.</dt>
<dd> Transient Analysis of Lossless Transmission Lines.
     Proceedings of the IEEE 55(1967), 2012 - 2013<dd>
<dt> Hoefer, E. E. E.; Nielinger, H.</dt>
<dd> SPICE : Analyseprogramm fuer elektronische
  Schaltungen. Springer-Verlag, Berlin, Heidelberg, New York, Tokyo, 1985.
</dd>
</dl>
 
</html>
", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Joachim Haase<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(points={{60,-50},{90,-50}}, color={0,0,255}),
          Line(points={{60,50},{90,50}}, color={0,0,255}),
          Line(points={{-60,50},{-90,50}}, color={0,0,255}),
          Line(points={{-60,-50},{-90,-50}}, color={0,0,255}),
          Line(points={{30,30},{-30,30}}, color={0,0,255}),
          Line(points={{-30,40},{-30,20}}, color={0,0,255}),
          Line(points={{30,40},{30,20}}, color={0,0,255}),
          Text(
            extent={{-100,100},{100,70}},
            textString="TLine3",
            lineColor={0,0,255}),
          Text(
            extent={{-29,-1},{30,-31}},
            textString="TLine3",
            lineColor={0,0,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
          Line(points={{60,-50},{96,-50}}, color={0,0,255}),
          Line(points={{60,50},{96,50}}, color={0,0,255}),
          Line(points={{-60,50},{-96,50}}, color={0,0,255}),
          Line(points={{-60,-50},{-96,-50}}, color={0,0,255}),
          Line(points={{30,30},{-30,30}}, color={0,0,255}),
          Line(points={{-30,40},{-30,20}}, color={0,0,255}),
          Line(points={{30,40},{30,20}}, color={0,0,255}),
          Text(
            extent={{-100,100},{100,70}},
            textString="TLine3",
            lineColor={0,0,255})}));
  equation
    assert(Z0 > 0, "Z0 has to be positive");
    assert(F > 0, "F  has to be positive");
    TD = 1/F/4;
    i1 = (v1 - es)/Z0;
    i2 = (v2 - er)/Z0;
    es = 2*delay(v2, TD) - delay(er, TD);
    er = 2*delay(v1, TD) - delay(es, TD);
  end TLine3;
end Lines;
