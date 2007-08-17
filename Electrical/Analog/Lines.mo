within Modelica.Electrical.Analog;
package Lines 
  "Lossy and lossless segmented transmission lines, and LC distributed line models" 
  
  extends Modelica.Icons.Library;
  
  annotation(preferedView="info",
    Window(
      x=0.03,
      y=0.04,
      width=0.50,
      height=0.24,
      library=1,
      autolayout=1),
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
    Interfaces.Pin p1 annotation (extent=[-110, -10; -90, 10]);
    Interfaces.Pin p2 annotation (extent=[90, -10; 110, 10]);
    Interfaces.Pin p3 annotation (extent=[-10, -110; 10, -90]);
    SI.Voltage v13;
    SI.Voltage v23;
    SI.Current i1;
    SI.Current i2;
    parameter Real r(
      final min=Modelica.Constants.small,
      unit="Ohm/m") = 1 "Resistance per meter";
    parameter Real l(
      final min=Modelica.Constants.small,
      unit="H/m") = 1 "Inductance per meter";
    parameter Real g(
      final min=Modelica.Constants.small,
      unit="S/m") = 1 "Conductance per meter";
    parameter Real c(
      final min=Modelica.Constants.small,
      unit="F/m") = 1 "Capacitance per meter";
    parameter SI.Length length(final min=Modelica.Constants.small) = 1 
      "Length of line";
    parameter Integer N(final min=1) = 1 "Number of lumped segments";
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
        Line(points=[0,-60; 0,-96]),
        Line(points=[60,0; 96,0]),
        Line(points=[-60,0; -96,0]),
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
    Interfaces.Pin p1 annotation (extent=[-110, -10; -90, 10]);
    Interfaces.Pin p2 annotation (extent=[90, -10; 110, 10]);
    Interfaces.Pin p3 annotation (extent=[-10, -110; 10, -90]);
    SI.Voltage v13;
    SI.Voltage v23;
    SI.Current i1;
    SI.Current i2;
    parameter Real r(
      final min=Modelica.Constants.small,
      unit="Ohm/m") = 1 "Resistance per meter";
    parameter Real c(
      final min=Modelica.Constants.small,
      unit="F/m") = 1 "Capacitance per meter";
    parameter SI.Length length(final min=Modelica.Constants.small) = 1 
      "Length of line";
    parameter Integer N(final min=1) = 1 "Number of lumped segments";
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
        Line(points=[0,-60; 0,-96]),
        Line(points=[60,0; 96,0]),
        Line(points=[-60,0; -96,0]),
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
  
   model TLine1 
    "Lossless transmission line with characteristic impedance Z0 and transmission delay TD" 
    
    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    
    parameter Modelica.SIunits.Resistance Z0=1 "Characteristic impedance";
    parameter Modelica.SIunits.Time TD=1 "Transmission delay";
    
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
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-60, 60; 60, -60]),
        Line(points=[60, -50; 90, -50]),
        Line(points=[60, 50; 90, 50]),
        Line(points=[-60, 50; -90, 50]),
        Line(points=[-60, -50; -90, -50]),
        Line(points=[30, 30; -30, 30]),
        Line(points=[-30, 40; -30, 20]),
        Line(points=[30, 40; 30, 20]),
        Text(extent=[-100, 100; 100, 70], string="TLine1"),
        Text(extent=[-30, 10; 30, -20], string="TLine1")),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60]),
        Line(points=[60,-50; 96,-50]),
        Line(points=[60,50; 96,50]),
        Line(points=[-60,50; -96,50]),
        Line(points=[-60,-50; -96,-50]),
        Line(points=[30, 30; -30, 30]),
        Line(points=[-30, 40; -30, 20]),
        Line(points=[30, 40; 30, 20]),
        Text(extent=[-100, 100; 100, 70], string="TLine1"),
        Text(extent=[-30, 0; 31, -31], string="TLine1")),
      Window(
        x=0.45,
        y=0.01,
        width=0.51,
        height=0.83));
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
    
    parameter Modelica.SIunits.Resistance Z0=1 "Characteristic impedance";
    parameter Modelica.SIunits.Frequency F=1 "Frequency";
    parameter Real NL=1 "Normalized length";
    
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
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-60, 60; 60, -60]),
        Line(points=[60, -50; 90, -50]),
        Line(points=[60, 50; 90, 50]),
        Line(points=[-60, 50; -90, 50]),
        Line(points=[-60, -50; -90, -50]),
        Line(points=[30, 30; -30, 30]),
        Line(points=[-30, 40; -30, 20]),
        Line(points=[30, 40; 30, 20]),
        Text(extent=[-100, 100; 100, 70], string="TLine2"),
        Text(extent=[-30, 10; 30, -20], string="TLine2")),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60]),
        Line(points=[60,-50; 96,-50]),
        Line(points=[60,50; 96,50]),
        Line(points=[-60,50; -96,50]),
        Line(points=[-60,-50; -96,-50]),
        Line(points=[30, 30; -30, 30]),
        Line(points=[-30, 40; -30, 20]),
        Line(points=[30, 40; 30, 20]),
        Text(extent=[-100, 100; 100, 70], string="TLine2")),
      Window(
        x=0.01,
        y=0.03,
        width=0.78,
        height=0.89));
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
    
    parameter Modelica.SIunits.Resistance Z0=1 "Natural impedance";
    parameter Modelica.SIunits.Frequency F=1 "Frequency";
    
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
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Icon(
        Rectangle(extent=[-60, 60; 60, -60]),
        Line(points=[60, -50; 90, -50]),
        Line(points=[60, 50; 90, 50]),
        Line(points=[-60, 50; -90, 50]),
        Line(points=[-60, -50; -90, -50]),
        Line(points=[30, 30; -30, 30]),
        Line(points=[-30, 40; -30, 20]),
        Line(points=[30, 40; 30, 20]),
        Text(extent=[-100, 100; 100, 70], string="TLine3"),
        Text(extent=[-29, -1; 30, -31], string="TLine3")),
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60]),
        Line(points=[60,-50; 96,-50]),
        Line(points=[60,50; 96,50]),
        Line(points=[-60,50; -96,50]),
        Line(points=[-60,-50; -96,-50]),
        Line(points=[30, 30; -30, 30]),
        Line(points=[-30, 40; -30, 20]),
        Line(points=[30, 40; 30, 20]),
        Text(extent=[-100, 100; 100, 70], string="TLine3")),
      Window(
        x=0,
        y=0,
        width=0.7,
        height=0.92));
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
