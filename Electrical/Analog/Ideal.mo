package Ideal 
  extends Modelica.Icons.Library;
  package SIunits = Modelica.SIunits ;
  
  annotation (
    Coordsys(
      extent=[0, 0; 400, 500], 
      grid=[1, 1], 
      component=[20, 20]), 
    Window(
      x=0.03, 
      y=0.04, 
      width=0.50, 
      height=0.36, 
      library=1, 
      autolayout=1), 
    Documentation(info="
<HTML>
<p>
This package contains ideal components:
<ul>
<li>thyristor</li>
<li>GTO thyristor</li>
<li>switches</li>
<li>diode</li>
<li>transformer</li>
<li>gyrator</li>
<li>operational amplifier</li>
<li>idle branch</li>
<li>short cut</li>
</ul>
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
  
  model IdealThyristor "Ideal thyristor" 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SIunits.Resistance Roff(final min=0) = 1.E-5 
      "Closed thyristor resistance";
    parameter SIunits.Conductance Gon(final min=0) = 1.E-5  
      "Opened thyristor conductance";
  protected 
    Real s "Auxiliary variable";
    Boolean off(start=true);
    Boolean fire(start=true);
    annotation (
      Documentation(info="
<HTML>
<P>
Ideal thyristor ... < description will be added >
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Polygon(points=[20, 0; -40, 40; -40, -40; 20, 0], style(
            color=3, 
            gradient=0, 
            fillColor=7)), 
        Line(points=[-90, 0; 40, 0]), 
        Line(points=[40, 0; 90, 0]), 
        Line(points=[20, 40; 20, -40], style(color=3)), 
        Line(points=[20, 20; 60, 60; 60, 90]), 
        Line(points=[30, 50; 50, 30]), 
        Text(extent=[-100, -70; 100, -100], string="%name")), 
      Diagram(
        Polygon(points=[20, 0; -40, 40; -40, -40; 20, 0], style(
            color=3, 
            gradient=0, 
            fillColor=1, 
            fillPattern=0)), 
        Line(points=[-90, 0; 40, 0]), 
        Line(points=[40, 0; 90, 0]), 
        Line(points=[20, 40; 20, -40], style(color=3)), 
        Line(points=[20, 20; 60, 60; 60, 90]), 
        Line(points=[30, 50; 50, 30])), 
      Window(
        x=0.27, 
        y=0.18, 
        width=0.6, 
        height=0.6));
  public 
    Modelica.Blocks.Interfaces.BooleanInPort firePort(final n=1) annotation (
        extent=[50, 90; 70, 110], rotation=-90);
  equation 
    fire = firePort.signal[1];
    off = s < 0 or pre(off) and not fire;
    v = s*(if off then 1 else Roff);
    i = s*(if off then Gon else 1);
  end IdealThyristor;
  model IdealGTOThyristor "Ideal GTO thyristor" 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SIunits.Resistance Roff(final min=0) = 1.E-5 
      "Closed thyristor resistance";
    parameter SIunits.Conductance Gon(final min=0) = 1.E-5
      "Opened thyristor conductance";
  protected 
    Real s "Auxiliary variable";
    Boolean off(start=true) "Position of switch";
    Boolean fire;
    annotation (
      Documentation(info="
<HTML>
<P>
Ideal GTO thyristor ...
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Polygon(points=[20, 0; -40, 40; -40, -40; 20, 0], style(
            color=3, 
            gradient=0, 
            fillColor=7)), 
        Line(points=[-90, 0; 40, 0]), 
        Line(points=[40, 0; 90, 0]), 
        Line(points=[20, 40; 20, -40], style(color=3)), 
        Line(points=[20, 20; 60, 60; 60, 90]), 
        Line(points=[30, 50; 50, 30]), 
        Text(extent=[-100, -70; 100, -100], string="%name")), 
      Diagram(
        Polygon(points=[20, 0; -40, 40; -40, -40; 20, 0], style(
            color=3, 
            gradient=0, 
            fillColor=1, 
            fillPattern=0)), 
        Line(points=[-90, 0; 40, 0]), 
        Line(points=[40, 0; 90, 0]), 
        Line(points=[20, 40; 20, -40], style(color=3)), 
        Line(points=[20, 20; 60, 60; 60, 90]), 
        Line(points=[30, 50; 50, 30])), 
      Window(
        x=0.27, 
        y=0.13, 
        width=0.6, 
        height=0.6));
  public 
    Modelica.Blocks.Interfaces.BooleanInPort firePort(final n=1) annotation (
        extent=[50, 90; 70, 110], rotation=-90);
  equation 
    fire = firePort.signal[1];
    off = s < 0 or not fire;
    v = s*(if off then 1 else Roff);
    i = s*(if off then Gon else 1);
  end IdealGTOThyristor;
  model IdealSwitch "Ideal electrical switch" 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SIunits.Resistance Roff(final min=0) = 1.E-5
      "Closed switch resistance";
    parameter SIunits.Conductance Gon(final min=0) = 1.E-5
      "Opened switch conductance";
  protected 
    Real s "Auxiliary variable";
    Boolean off;
  public 
    Modelica.Blocks.Interfaces.BooleanInPort control(final n=1, signal(start={
            false})) "true/false opened/closed switch" annotation (extent=[-10
          , 50; 10, 70], rotation=-90);
    annotation (
      Documentation(info="
<HTML>
<P>
Ideal electrical switch. In order to prevent singularities
during switching, the opened switch has a high resistance
and the closed switch has a low resistance. 
</P>
<P>
If the actual circuit has an appropriate structure, the 
limiting case is also allowed, i.e., the resistance of the
closed switch could be exactly zero and the conductance of the
open switch could be also exactly zero (i.e. the resistance is
infinity). Note, there are circuits, where a description
with zero/infinity resistances is not possible. 
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.28, 
        y=0.13, 
        width=0.56, 
        height=0.63), 
      Icon(
        Ellipse(extent=[-44, 4; -36, -4]), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-37, 2; 40, 50]), 
        Line(points=[40, 0; 90, 0]), 
        Text(extent=[-100, -70; 100, -100], string="%name"), 
        Line(points=[0, 51; 0, 26])), 
      Diagram(
        Ellipse(extent=[-44, 4; -36, -4]), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-37, 2; 40, 50]), 
        Line(points=[40, 0; 90, 0]), 
        Text(extent=[-100, -40; 100, -79], string="%name"), 
        Line(points=[0, 51; 0, 26])));
  equation 
    off = control.signal[1];
    v = s*(if off then 1 else Roff);
    i = s*(if off then Gon else 1);
  end IdealSwitch;
  model ControlledIdealSwitch 
    parameter SIunits.Voltage level "Switch level";
    parameter SIunits.Resistance Roff(final min=0) = 1.E-5
      "Closed switch resistance";
    parameter SIunits.Conductance Gon(final min=0) = 1.E-5
      "Opened switch conductance";
  protected 
    Real s "Auxiliary variable";
    annotation (
      Documentation(info="
<HTML>
<P>
The ideal switch is a three-pole. If the third pin voltage exceeds the given 
parameter Voltage, the pins <i>p</i> and <i>n</i> are open (no current flowing, any voltage
possible). Otherwise, <i>p</i> and <i>n</i> are short cut.
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.24, 
        y=0.27, 
        width=0.76, 
        height=0.57), 
      Icon(
        Ellipse(extent=[-44, 4; -36, -4]), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-37, 2; 40, 50]), 
        Line(points=[40, 0; 90, 0]), 
        Line(points=[0, 90; 0, 25]), 
        Text(extent=[-100, -70; 100, -100], string="%name")), 
      Diagram(
        Ellipse(extent=[-44, 4; -36, -4]), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-37, 2; 40, 50]), 
        Line(points=[40, 0; 90, 0]), 
        Line(points=[0, 90; 0, 25])));
  public 
    Modelica.Electrical.Analog.Interfaces.Pin p "Positive pin" annotation (
        extent=[-110, -10; -90, 10]);
    Modelica.Electrical.Analog.Interfaces.Pin n "Negative pin" annotation (
        extent=[90, -10; 110, 10]);
    Modelica.Electrical.Analog.Interfaces.Pin control 
      "Control pin: control.v > level open, otherwise closed" annotation (
        extent=[-10, 90; 10, 110], rotation=90);
  equation 
    control.i = 0;
    0 = p.i + n.i;
    p.v - n.v = s * (if (control.v < level) then Roff else 1);
    n.i = s * (if (control.v < level) then 1 else Gon);
  end ControlledIdealSwitch;
  model ControlledIdealCommutingSwitch "Ideal commuting switch" 
    parameter SIunits.Voltage level "Switch level";    
    parameter SIunits.Resistance Roff(final min=0) = 1.E-5
      "Closed switch resistance";
    parameter SIunits.Conductance Gon(final min=0) = 1.E-5
      "Opened switch conductance";
    annotation (
      Documentation(info="
<HTML>
<P>
The commuting switch is a four pole. The switching behaviour is controlled
by the fourth pin. If its voltage exceeds the parameter Voltage value,
the first pin p is chort cut to the second pin ng. Otherwise, the pin p
is short cut to the third pin n1.
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Ellipse(extent=[-44, 4; -36, -4]), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-37, 2; 40, 50]), 
        Line(points=[40, 50; 90, 50]), 
        Line(points=[0, 90; 0, 25]), 
        Line(points=[40, 0; 90, 0]), 
        Text(extent=[-100, -70; 100, -100], string="%name")), 
      Diagram(
        Ellipse(extent=[-44, 4; -36, -4]), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-37, 2; 40, 50]), 
        Line(points=[40, 50; 90, 50]), 
        Line(points=[0, 90; 0, 25]), 
        Line(points=[40, 0; 90, 0])), 
      Window(
        x=0.21, 
        y=0.05, 
        width=0.6, 
        height=0.6));
  public 
    Modelica.Electrical.Analog.Interfaces.Pin p "Positive pin" annotation (
        extent=[-110, -10; -90, 10]);
    Modelica.Electrical.Analog.Interfaces.Pin n2 "Negative pin 2" annotation (
        extent=[90, -10; 110, 10]);
    Modelica.Electrical.Analog.Interfaces.Pin n1 "Negative pin 1" annotation (
        extent=[90, 40; 110, 60]);
    Modelica.Electrical.Analog.Interfaces.Pin control 
      "Control pin: control.v > level p--n2, otherwise p--n1" annotation (
        extent=[-10, 90; 10, 110], rotation=90);
  protected
    Real s1, s2 "Auxiliary variables";
  equation 
    control.i = 0;
    0 = p.i + n2.i + n1.i;

    p.v - n1.v = s1 * (if (control.v > level) then 1 else Roff);
    n1.i = s1 * (if (control.v > level) then Gon else 1);
    p.v - n2.v = s2 * (if (control.v > level) then Roff else 1);
    n2.i = s2 * (if (control.v > level) then 1 else Gon);
  end ControlledIdealCommutingSwitch;
  model IdealOpAmp "Ideal opamp (norator-nullator pair)" 
    SIunits.Voltage v1 "Voltage drop over the left port";
    SIunits.Voltage v2 "Voltage drop over the right port";
    SIunits.Current i1 
      "Current flowing from pos. to neg. pin of the left port";
    SIunits.Current i2 
      "Current flowing from pos. to neg. pin of the right port";
    annotation (
      Documentation(info="
<HTML>
<P>
The ideal OpAmp is a two-port. The left port is fixed to <i>v1=0</i> and <i>i1=0</i>
(nullator). At the right port both any voltage <i>v2</i> and any current <i>i2</i> 
are possible (norator).
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Text(extent=[-100, 80; 100, 100], string="%name"), 
        Polygon(points=[60, 0; -60, 70; -60, -70; 60, 0], style(fillColor=7))
          , 
        Line(points=[-90, 50; -60, 50]), 
        Line(points=[-90, -50; -60, -50]), 
        Line(points=[60, 0; 90, 0]), 
        Line(points=[0, -35; 0, -91]), 
        Line(points=[-48, 32; -28, 32]), 
        Line(points=[-39, -20; -39, -41]), 
        Line(points=[-50, -31; -28, -31])), 
      Diagram(
        Polygon(points=[60, 0; -60, 70; -60, -70; 60, 0], style(fillColor=7))
          , 
        Line(points=[-90, 50; -60, 50]), 
        Line(points=[-90, -50; -60, -50]), 
        Line(points=[60, 0; 90, 0]), 
        Line(points=[0, -35; 0, -91]), 
        Line(points=[-55, 50; -45, 50]), 
        Line(points=[-50, -45; -50, -55]), 
        Line(points=[-55, -50; -45, -50]), 
        Text(
          extent=[-111, -39; -90, -19], 
          string="p1.i=0", 
          style(color=9, fillColor=9)), 
        Polygon(points=[120, 3; 110, 0; 120, -3; 120, 3], style(
            color=9, 
            gradient=2, 
            fillColor=9, 
            fillPattern=1)), 
        Line(points=[111, 0; 136, 0], style(
            color=9, 
            gradient=2, 
            fillColor=9)), 
        Text(
          extent=[118, 2; 135, 17], 
          string="i2", 
          style(
            color=9, 
            gradient=2, 
            fillColor=9)), 
        Text(
          extent=[-111, 60; -90, 80], 
          string="n1.i=0", 
          style(color=9, fillColor=9)), 
        Line(points=[18, -111; 18, -86], style(color=9, fillColor=9)), 
        Polygon(points=[21, -101; 18, -111; 15, -101; 21, -101], style(
            color=9, 
            fillColor=9, 
            fillPattern=1)), 
        Text(
          extent=[22, -100; 39, -85], 
          string="i2", 
          style(
            color=9, 
            gradient=2, 
            fillColor=9))), 
      Window(
        x=0.28, 
        y=0.19, 
        width=0.71, 
        height=0.59));
    Modelica.Electrical.Analog.Interfaces.PositivePin p1 
      "Positive pin of the left port" annotation (extent=[-110, -60; -90, -40])
      ;
    Modelica.Electrical.Analog.Interfaces.NegativePin n1 
      "Negative pin of the left port" annotation (extent=[-110, 40; -90, 60]);
    Modelica.Electrical.Analog.Interfaces.PositivePin p2 
      "Positive pin of the right port" annotation (extent=[90, -10; 110, 10]);
    Modelica.Electrical.Analog.Interfaces.NegativePin n2 
      "Negative pin of the right port" annotation (extent=[-10, -90; 10, -110]
        , rotation=-90);
  equation 
    v1 = p1.v - n1.v;
    v2 = p2.v - n2.v;
    0 = p1.i + n1.i;
    0 = p2.i + n2.i;
    i1 = p1.i;
    i2 = p2.i;
    v1 = 0;
    i1 = 0;
  end IdealOpAmp;
  model IdealDiode "Ideal electrical diode" 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SIunits.Resistance Roff(final min=0) = 1.E-5 
      "Closed diode resistance";
    parameter SIunits.Conductance Gon(final min=0) = 1.E-5  
      "Opened diode conductance";
    Boolean off(start=true) "Switching state of diode";
  protected 
    Real s "Auxiliary variable";
    annotation (
      Documentation(info="
<HTML>
<P>
Ideal electrical diode. This is an ideal switch which is
open, when it is reversed biased (voltage drop < 0) and
which is closed, when it is conducting (current > 0).
In order to prevent singularities during switching, the opened
diode has a high resistance and the closed diode has a low 
resistance. 
</P>
<P>
If the actual circuit has an appropriate structure, the 
limiting case is also allowed, i.e., the resistance of the
closed diode could be exactly zero and the conductance of the
open diode could be also exactly zero (i.e. the resistance is
infinity). Note, there are circuits, where a description
with zero/infinity resistances is not possible. 
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Polygon(points=[30, 0; -30, 40; -30, -40; 30, 0], style(
            color=3, 
            gradient=0, 
            fillColor=7)), 
        Line(points=[-90, 0; 40, 0]), 
        Line(points=[40, 0; 90, 0]), 
        Line(points=[30, 40; 30, -40], style(color=3)), 
        Text(extent=[-100, 100; 100, 70], string="%name")), 
      Diagram(
        Polygon(points=[30, 0; -30, 40; -30, -40; 30, 0], style(
            color=3, 
            gradient=0, 
            fillColor=1, 
            fillPattern=0)), 
        Line(points=[-90, 0; 40, 0]), 
        Line(points=[40, 0; 90, 0]), 
        Line(points=[30, 40; 30, -40], style(color=3))), 
      Window(
        x=0.26, 
        y=0.11, 
        width=0.6, 
        height=0.6));
  equation 
    off = s < 0;
    v = s*(if off then 1 else Roff);
    i = s*(if off then Gon else 1);
  end IdealDiode;
  model IdealTransformer "Ideal electrical transformer" 
    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    parameter Real n=1 "Turns ratio";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Documentation(info="
<HTML>
<P>
The ideal transformer is an ideal two-port resistive circuit element
which is characterized by the following two equations:
</P>
<PRE>
    v1 =  n * v2
    i2 = -n * i1
</PRE>
<P>
where <i>n</i> is a real number called the turns ratio.
</P>
</HTML>
"), 
      Coordsys(extent=[-100, -100; 100, 100], grid=[1, 1]), 
      Icon(
        Text(extent=[-100, 100; 100, 80], string="%name"), 
        Ellipse(extent=[-45, -50; -20, -25]), 
        Ellipse(extent=[-45, -25; -20, 0]), 
        Ellipse(extent=[-45, 0; -20, 25]), 
        Ellipse(extent=[-45, 25; -20, 50]), 
        Rectangle(extent=[-72, -60; -33, 60], style(color=7, fillColor=7)), 
        Line(points=[-90, 50; -32, 50]), 
        Line(points=[-90, -50; -32, -50]), 
        Ellipse(extent=[20, -50; 45, -25]), 
        Ellipse(extent=[20, -25; 45, 0]), 
        Ellipse(extent=[20, 0; 45, 25]), 
        Ellipse(extent=[20, 25; 45, 50]), 
        Rectangle(extent=[33, -60; 72, 60], style(color=7, fillColor=7)), 
        Line(points=[32, 50; 90, 50]), 
        Line(points=[32, -50; 90, -50]), 
        Text(extent=[-100, -80; 100, -100], string="n=%n")), 
      Diagram(
        Ellipse(extent=[-45, -50; -20, -25]), 
        Ellipse(extent=[-45, -25; -20, 0]), 
        Ellipse(extent=[-45, 0; -20, 25]), 
        Ellipse(extent=[-45, 25; -20, 50]), 
        Rectangle(extent=[-72, -60; -33, 60], style(color=7, fillColor=7)), 
        Line(points=[-90, 50; -32, 50]), 
        Line(points=[-90, -50; -32, -50]), 
        Ellipse(extent=[20, -50; 45, -25]), 
        Ellipse(extent=[20, -25; 45, 0]), 
        Ellipse(extent=[20, 0; 45, 25]), 
        Ellipse(extent=[20, 25; 45, 50]), 
        Rectangle(extent=[33, -60; 72, 60], style(color=7, fillColor=7)), 
        Line(points=[32, 50; 90, 50]), 
        Line(points=[32, -50; 90, -50])), 
      Window(
        x=0.29, 
        y=0.07, 
        width=0.6, 
        height=0.6));
  equation 
    v1 = n*v2;
    i2 = -n*i1;
  end IdealTransformer;
  model IdealGyrator "Ideal gyrator" 
    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    annotation (
      Documentation(info="
<HTML>
<P>    
A gyrator is an ideal two-port element defined by the following equations:
</P>
<PRE>
    i1 =  G * v2
    i2 = -G * v1
</PRE>
<P>
where the constant <i>G</i> is called the gyration conductance.
</P>
</HTML>
"), 
      Coordsys(extent=[-100, -100; 100, 100], grid=[1, 1]), 
      Icon(
        Ellipse(extent=[-70, -30; -10, 30]), 
        Rectangle(extent=[-80, -40; -41, 40], style(
            color=7, 
            pattern=1, 
            thickness=1, 
            arrow=0, 
            fillColor=7)), 
        Line(points=[-90, 50; -40, 50; -40, -50; -90, -50]), 
        Text(extent=[-100, 100; 100, 70], string="%name"), 
        Line(points=[-30, 60; 20, 60]), 
        Polygon(points=[20, 63; 30, 60; 20, 57; 20, 63], style(
            pattern=1, 
            thickness=1, 
            arrow=0, 
            fillColor=3, 
            fillPattern=1)), 
        Ellipse(extent=[10, -30; 70, 30]), 
        Rectangle(extent=[80, -40; 40, 40], style(
            color=7, 
            pattern=1, 
            thickness=1, 
            arrow=0, 
            fillColor=7)), 
        Line(points=[90, 50; 40, 50; 40, -50; 90, -50])), 
      Diagram(
        Ellipse(extent=[-70, -30; -10, 30]), 
        Rectangle(extent=[-80, -40; -41, 40], style(color=7, fillColor=7)), 
        Line(points=[-90, 50; -40, 50; -40, -50; -90, -50]), 
        Line(points=[-30, 60; 20, 60]), 
        Polygon(points=[20, 63; 30, 60; 20, 57; 20, 63], style(fillColor=3, 
              fillPattern=1)), 
        Ellipse(extent=[10, -30; 70, 30]), 
        Rectangle(extent=[80, -40; 40, 40], style(color=7, fillColor=7)), 
        Line(points=[90, 50; 40, 50; 40, -50; 90, -50])));
    parameter SIunits.Conductance G=1 "Gyration conductance";
  equation 
    i1 = G*v2;
    i2 = -G*v1;
  end IdealGyrator;
  model Idle "Idle branch" 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    annotation (
      Documentation(info="
<HTML>
<P>
The model Idle is a simple idle running branch.
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[-60, 60; 60, -60]), 
        Line(points=[-90, 0; -41, 0]), 
        Line(points=[91, 0; 40, 0]), 
        Text(extent=[-100, 100; 100, 70], string="%name")), 
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60]), 
        Line(points=[-90, 0; -41, 0]), 
        Line(points=[91, 0; 40, 0])), 
      Window(
        x=0.36, 
        y=0.16, 
        width=0.6, 
        height=0.6));
  equation 
    
    i = 0;
    
  end Idle;
  model Short "Short cut branch" 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    annotation (
      Documentation(info="
<HTML>
<P>
The model Short is a simple short cut branch.
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[-60, 60; 60, -60]), 
        Line(points=[91, 0; -90, 0]), 
        Text(extent=[-100, 100; 100, 70], string="%name")), 
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60]), 
        Line(points=[91, 0; -90, 0]), 
        Text(extent=[-100, 100; 100, 70], string="Short")), 
      Window(
        x=0.31, 
        y=0.14, 
        width=0.6, 
        height=0.6));
  equation 
    v = 0;
  end Short;
end Ideal;
