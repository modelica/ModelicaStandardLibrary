package Lines 
  extends Modelica.Icons.Library;
  package SIunits = Modelica.SIunits;

  annotation (
    Coordsys(
      extent=[0, 0; 400, 500], 
      grid=[1, 1], 
      component=[20, 20]), 
    Window(
      x=0.03, 
      y=0.04, 
      width=0.50, 
      height=0.24, 
      library=1, 
      autolayout=1), 
    Documentation(info="
<HTML>
<p>
This package contains lossy and lossless tranmission lines.
</p>

<dl>
<dt>
<b>Main Authors:</b>
<dd>
<a href=\"http://www.eas.iis.fhg.de/~clauss/\">Christoph Clau&szlig;</a> 
    &lt;<a href=\"mailto:clauss@eas.iis.fhg.de\">clauss@eas.iis.fhg.de</a>&gt;<br>
    <a href=\"http://www.eas.iis.fhg.de/~schneider/\">Andr&eacute; Schneider</a> 
    &lt;<a href=\"mailto:schneider@eas.iis.fhg.de\">schneider@eas.iis.fhg.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden<br>

<p>
<dt>
<b>Version:</b>
<dd>
$Id$<br>
<p>
<dt>
<b>Copyright:</b>
<dd>
Copyright (C) 1998-1999, Modelica Design Group and Fraunhofer-Gesellschaft.<br>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package 
Modelica in file \"Modelica/package.mo\".</i><br>
<p>
</dl>
</HTML>
"));
  

  model OLine "Lossy Transmission Line" 
    //extends Interfaces.ThreePol;
    Modelica.Electrical.Analog.Interfaces.Pin p1 annotation (extent=[-110, -10; -90, 10]);
    Modelica.Electrical.Analog.Interfaces.Pin p2 annotation (extent=[90, -10; 110, 10]);
    Modelica.Electrical.Analog.Interfaces.Pin p3 annotation (extent=[-10, -110; 10, -90]);
    SIunits.Voltage v13;
    SIunits.Voltage v23;
    SIunits.Current i1;
    SIunits.Current i2;
    parameter Real r(
      final min=Modelica.Constants.SMALL, 
      unit="Ohm/m") = 1 "Resistance per meter";
    parameter Real l(
      final min=Modelica.Constants.SMALL, 
      unit="H/m") = 1 "Inductance per meter";
    parameter Real g(
      final min=Modelica.Constants.SMALL, 
      unit="Siemens/m") = 1 "Conductance per meter";
    parameter Real c(
      final min=Modelica.Constants.SMALL, 
      unit="F/m") = 1 "Capacitance per meter";
    parameter SIunits.Length length(final min=Modelica.Constants.SMALL)
       = 1 "Length of line";
    parameter Integer N(final min=1) = 1 "Number of lumped segments";
  protected 
    Modelica.Electrical.Analog.Basic.Resistor R[N + 1](R=r*length/(N+1));
    Modelica.Electrical.Analog.Basic.Inductor L[N + 1](L=l*length/(N+1));
    Modelica.Electrical.Analog.Basic.Capacitor C[N](C=c*length/(N+1));
    Modelica.Electrical.Analog.Basic.Conductor G[N](G=g*length/(N+1));
    annotation (
      Documentation(info="
<HTML>
<P>
Lossy Transmission Line

  The lossy transmission line OLine consists of segments of
  lumped resistances and inductances in series
  and conductances and capacitances that are
  connected with the reference pin g. The precision
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
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[-60, 60; 60, -60], style(fillColor=7)), 
        Line(points=[0, -60; 0, -90]), 
        Line(points=[60, 0; 90, 0]), 
        Line(points=[-60, 0; -90, 0]), 
        Line(points=[30, 30; -30, 30]), 
        Line(points=[-30, 40; -30, 20]), 
        Line(points=[30, 40; 30, 20]), 
        Text(extent=[-100, 100; 100, 70], string="%name")), 
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60]), 
        Line(points=[0, -60; 0, -90]), 
        Line(points=[60, 0; 90, 0]), 
        Line(points=[-60, 0; -90, 0]), 
        Line(points=[30, 30; -30, 30]), 
        Line(points=[-30, 40; -30, 20]), 
        Line(points=[30, 40; 30, 20])), 
      Window(
        x=0.24, 
        y=0.07, 
        width=0.6, 
        height=0.6));
  equation 
    v13 = p1.v - p3.v;
    v23 = p2.v - p3.v;
    i1 = p1.i;
    i2 = p2.i;
    // other models if gg = 0 ...
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
  model ULine "Lossy RC Line" 
    //extends Interfaces.ThreePol;
    Modelica.Electrical.Analog.Interfaces.Pin p1 annotation (extent=[-110, -10; -90, 10]);
    Modelica.Electrical.Analog.Interfaces.Pin p2 annotation (extent=[90, -10; 110, 10]);
    Modelica.Electrical.Analog.Interfaces.Pin p3 annotation (extent=[-10, -110; 10, -90]);
    SIunits.Voltage v13;
    SIunits.Voltage v23;
    SIunits.Current i1;
    SIunits.Current i2;
    parameter Real r(
      final min=Modelica.Constants.SMALL, 
      unit="Ohm/m") = 1 "Resistance per meter";
    parameter Real c(
      final min=Modelica.Constants.SMALL, 
      unit="F/m") = 1 "Capacitance per meter";
    parameter SIunits.Length length(final min=Modelica.Constants.SMALL) = 
      1 "Length of line";
    parameter Integer N(final min=1) = 1 "Number of lumped segments";
  protected 
    Modelica.Electrical.Analog.Basic.Resistor R[N + 1](R=r*length/(N+1));
    Modelica.Electrical.Analog.Basic.Capacitor C[N](C=c*length/(N+1));
    annotation (
      Documentation(info="
<HTML>
<P>
The lossy RC line ULine consists of segments of 
lumped series resistances and capacitances that are
connected with the reference pin g. The precision
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
  p. 22, p. 124
</DL>
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.2, 
        y=0.21, 
        width=0.6, 
        height=0.6), 
      Icon(
        Rectangle(extent=[-60, 60; 60, -60], style(fillColor=7)), 
        Line(points=[0, -60; 0, -90]), 
        Line(points=[60, 0; 90, 0]), 
        Line(points=[-60, 0; -90, 0]), 
        Line(points=[30, 30; -30, 30]), 
        Line(points=[-30, 40; -30, 20]), 
        Line(points=[30, 40; 30, 20]), 
        Text(extent=[-100, 100; 100, 70], string="%name")), 
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60]), 
        Line(points=[0, -60; 0, -90]), 
        Line(points=[60, 0; 90, 0]), 
        Line(points=[-60, 0; -90, 0]), 
        Line(points=[30, 30; -30, 30]), 
        Line(points=[-30, 40; -30, 20]), 
        Line(points=[30, 40; 30, 20])));
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
  
end Lines;
