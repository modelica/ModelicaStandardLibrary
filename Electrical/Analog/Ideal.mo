package Ideal 
  
  extends Modelica.Icons.Library;
  
  annotation (Window(
       x=0.03, 
       y=0.04, 
       width=0.50, 
       height=0.36, 
       library=1,
       autolayout=1),Documentation(info="<html>
<p>
This package contains electrical components with idealized behaviour:
</p>
<ul>
<li>thyristor</li>
<li>GTO thyristor</li>
<li>switches (basic, commuting, intermediate, controlled, 
    controlled commuting, controlled intermediate)</li>
<li>operational amplifier</li>
<li>operational amplifier (3 Pins)</li>
<li>operational amplifier with limits</li>
<li>diode</li>
<li>transformer</li>
<li>gyrator</li>
<li>idle branch</li>
<li>short cut</li>
<li>opener</li>
<li>closer</li>
<li>controlled opener</li>
<li>controlled closer</li>
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
Copyright &copy; 1998-2002, Modelica Association and Fraunhofer-Gesellschaft.<br>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".</i><br>
<p>
</dl>
</HTML>
"));
  
  model IdealThyristor "Ideal thyristor" 
    extends Interfaces.OnePort;
    parameter SI.Resistance Roff(final min=0) = 1.E-5 
      "Closed thyristor resistance";
    parameter SI.Conductance Gon(final min=0) = 1.E-5 
      "Opened thyristor conductance";
  protected 
    Real s "Auxiliary variable";
    Boolean off(start=true);
    Boolean fire(start=true);
    annotation (
      Documentation(info="<html>
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
    extends Interfaces.OnePort;
    parameter SI.Resistance Roff(final min=0) = 1.E-5 
      "Closed thyristor resistance";
    parameter SI.Conductance Gon(final min=0) = 1.E-5 
      "Opened thyristor conductance";
  protected 
    Real s "Auxiliary variable";
    Boolean off(start=true) "Position of switch";
    Boolean fire;
    annotation (
      Documentation(info="<html>
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
    extends Interfaces.OnePort;
    parameter SI.Resistance Roff(final min=0) = 1.E-5 
      "Closed switch resistance";
    parameter SI.Conductance Gon(final min=0) = 1.E-5 
      "Opened switch conductance";
  protected 
    Real s "Auxiliary variable";
    Boolean off;
  public 
    Modelica.Blocks.Interfaces.BooleanInPort control(final n=1, signal(start={
            false})) "true/false opened/closed switch" annotation (extent=[-10
          , 50; 10, 70], rotation=-90);
    annotation (
      Documentation(info="<html>
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
infinite). Note, there are circuits, where a description
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
  
  model IdealCommutingSwitch "Ideal commuting switch" 
    parameter SI.Resistance Ron(final min=0) = 1.E-5 "Closed switch resistance"
      ;
    parameter SI.Conductance Goff(final min=0) = 1.E-5 
      "Opened switch conductance";
    annotation (
      Documentation(info="<HTML>
<P>
The commuting switch has a positive pin p and two negative pins n1 and n2. 
The switching behaviour is controlled
by the control signal. If the control signal is true, the pin p is connected 
with the negative pin n2. Otherwise, the pin p is connected to the negative pin n1.
</P>
<P>
In order to prevent singularities during switching, the opened 
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron. 
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits, 
where a description with zero Ron or zero Goff is not possible. 
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Ellipse(extent=[-44, 4; -36, -4]), 
        Text(extent=[-80, 0; -60, 22], string="p"), 
        Text(extent=[60, 50; 80, 72], string="n1"), 
        Text(extent=[60, 0; 80, 22], string="n2"), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-37, 2; 40, 50]), 
        Line(points=[40, 50; 90, 50]), 
        Line(points=[0, 90; 0, 25]), 
        Line(points=[40, 0; 90, 0]), 
        Text(extent=[-100, -70; 100, -100], string="%name")), 
      Diagram(
        Ellipse(extent=[-44, 4; -36, -4]), 
        Text(extent=[-80, 0; -60, 22], string="p"), 
        Text(extent=[60, 50; 80, 72], string="n1"), 
        Text(extent=[60, 0; 80, 22], string="n2"), 
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
    Interfaces.PositivePin p annotation (extent=[-110, -10; -90, 10]);
    Interfaces.NegativePin n2 annotation (extent=[90, -10; 110, 10]);
    Interfaces.NegativePin n1 annotation (extent=[90, 40; 110, 60]);
    Modelica.Blocks.Interfaces.BooleanInPort control(final n=1) 
      "true => p--n2 connected, false => p--n1 connected" annotation (extent=[-
          10, 70; 10, 90], rotation=-90);
  protected 
    Real s1;
    Real s2 "Auxiliary variables";
    Boolean off;
  equation 
    off = control.signal[1];
    0 = p.i + n2.i + n1.i;
    
    p.v - n1.v = s1*(if (off) then 1 else Ron);
    n1.i = -s1*(if (off) then Goff else 1);
    p.v - n2.v = s2*(if (off) then Ron else 1);
    n2.i = -s2*(if (off) then 1 else Goff);
  end IdealCommutingSwitch;
  
  model IdealIntermediateSwitch "Ideal intermediate switch" 
    parameter SI.Resistance Ron(final min=0) = 1.E-5 "Closed switch resistance"
      ;
    parameter SI.Conductance Goff(final min=0) = 1.E-5 
      "Opened switch conductance";
    annotation (
      Documentation(info="<HTML>
<P>
The intermediate switch has four switching contact pins p1, p2, n1, and n2. 
The switching behaviour is controlled by the control signal. If the control 
signal is true, the pin p1 is connected to pin n2, and the pin p2 is 
connected to the pin n2. Otherwise, the pin p1 is connected to n1, and
p2 is connected to n2.
</P>

<IMG SRC=\"../Images/IdealIntermediateSwitch1.png\" ALT=\"IdealIntermediateSwitch1\">

<P>
In order to prevent singularities during switching, the opened 
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron. 
</P>

<IMG SRC=\"../Images/IdealIntermediateSwitch2.png\" ALT=\"IdealIntermediateSwitch2\">

<P>
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits, 
where a description with zero Ron or zero Goff is not possible. 
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Ellipse(extent=[-4, 30; 4, 22]), 
        Text(extent=[-80, 50; -60, 72], string="p1"), 
        Text(extent=[-80, 0; -60, 22], string="p2"), 
        Text(extent=[60, 50; 80, 72], string="n1"), 
        Text(extent=[60, 0; 80, 22], string="n2"), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-90, 50; -44, 50]), 
        Line(points=[-44, 0; 40, 50]), 
        Line(points=[-44, 50; 40, 0]), 
        Line(points=[40, 50; 90, 50]), 
        Line(points=[0, 90; 0, 25]), 
        Line(points=[40, 0; 90, 0]), 
        Text(extent=[-100, -70; 100, -100], string="%name")), 
      Diagram(
        Ellipse(extent=[-4, 30; 4, 22]), 
        Text(extent=[-80, 50; -60, 72], string="p1"), 
        Text(extent=[-80, 0; -60, 22], string="p2"), 
        Text(extent=[60, 50; 80, 72], string="n1"), 
        Text(extent=[60, 0; 80, 22], string="n2"), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-90, 50; -44, 50]), 
        Line(points=[-44, 0; 40, 50]), 
        Line(points=[-44, 50; 40, 0]), 
        Line(points=[40, 50; 90, 50]), 
        Line(points=[0, 90; 0, 25]), 
        Line(points=[40, 0; 90, 0])), 
      Window(
        x=0.21, 
        y=0.05, 
        width=0.6, 
        height=0.6));
  public 
    Interfaces.PositivePin p1 annotation (extent=[-110, 40; -90, 60]);
    Interfaces.PositivePin p2 annotation (extent=[-110, -10; -90, 10]);
    Interfaces.NegativePin n1 annotation (extent=[90, 40; 110, 60]);
    Interfaces.NegativePin n2 annotation (extent=[90, -10; 110, 10]);
    Modelica.Blocks.Interfaces.BooleanInPort control(final n=1) "true => p1--n2, p2--n1 connected,
         otherwise p1--n1, p2--n2  connected" annotation (extent=[-10, 70; 10, 
          90], rotation=-90);
  protected 
    Real s1;
    Real s2;
    Real s3;
    Real s4 "Auxiliary variables";
    Boolean off;
  equation 
    off = control.signal[1];
    p1.v - n1.v = s1*(if (off) then 1 else Ron);
    p2.v - n2.v = s2*(if (off) then 1 else Ron);
    p1.v - n2.v = s3*(if (off) then Ron else 1);
    p2.v - n1.v = s4*(if (off) then Ron else 1);
    
    p1.i = if (off) then s1*Goff + s3 else s1 + s3*Goff;
    p2.i = if (off) then s2*Goff + s4 else s2 + s4*Goff;
    n1.i = if (off) then -s1*Goff - s4 else -s1 - s4*Goff;
    n2.i = if (off) then -s2*Goff - s3 else -s2 - s3*Goff;
  end IdealIntermediateSwitch;
  
  model ControlledIdealSwitch "Controlled ideal switch" 
    parameter SI.Voltage level=0.5 "Switch level";
    parameter SI.Resistance Roff(final min=0) = 1.E-5 
      "Closed switch resistance";
    parameter SI.Conductance Gon(final min=0) = 1.E-5 
      "Opened switch conductance";
  protected 
    Real s "Auxiliary variable";
    annotation (
      Documentation(info="<html>
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
    Interfaces.Pin p "Positive pin" annotation (extent=[-110, -10; -90, 10]);
    Interfaces.Pin n "Negative pin" annotation (extent=[90, -10; 110, 10]);
    Interfaces.Pin control 
      "Control pin: control.v > level open, otherwise closed" annotation (
        extent=[-10, 90; 10, 110], rotation=90);
  equation 
    control.i = 0;
    0 = p.i + n.i;
    p.v - n.v = s*(if (control.v < level) then Roff else 1);
    n.i = s*(if (control.v < level) then 1 else Gon);
  end ControlledIdealSwitch;
  
  model ControlledIdealCommutingSwitch "Controlled ideal commuting switch" 
    parameter SI.Voltage level=0.5 "Switch level";
    parameter SI.Resistance Ron(final min=0) = 1.E-5 "Closed switch resistance"
      ;
    parameter SI.Conductance Goff(final min=0) = 1.E-5 
      "Opened switch conductance";
    annotation (
      Documentation(info="<HTML>
<P>
The commuting switch has a positive pin p and two negative pins n1 and n2. 
The switching behaviour is controlled
by the control pin. If its voltage exceeds the value of the parameter level,
the pin p is connected with the negative pin n2. Otherwise, the pin p is 
connected the negative pin n1.
</P>
<P>
In order to prevent singularities during switching, the opened 
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron. 
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits, 
where a description with zero Ron or zero Goff is not possible. 
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Ellipse(extent=[-44, 4; -36, -4]), 
        Text(extent=[-80, 0; -60, 22], string="p"), 
        Text(extent=[60, 50; 80, 72], string="n1"), 
        Text(extent=[60, 0; 80, 22], string="n2"), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-37, 2; 40, 50]), 
        Line(points=[40, 50; 90, 50]), 
        Line(points=[0, 90; 0, 25]), 
        Line(points=[40, 0; 90, 0]), 
        Text(extent=[-100, -70; 100, -100], string="%name")), 
      Diagram(
        Ellipse(extent=[-44, 4; -36, -4]), 
        Text(extent=[-80, 0; -60, 22], string="p"), 
        Text(extent=[60, 50; 80, 72], string="n1"), 
        Text(extent=[60, 0; 80, 22], string="n2"), 
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
    Interfaces.PositivePin p annotation (extent=[-110, -10; -90, 10]);
    Interfaces.NegativePin n2 annotation (extent=[90, -10; 110, 10]);
    Interfaces.NegativePin n1 annotation (extent=[90, 40; 110, 60]);
    Interfaces.Pin control 
      "Control pin: if control.v > level p--n2 connected, otherwise p--n1 connected"
       annotation (extent=[-10, 90; 10, 110], rotation=90);
  protected 
    Real s1;
    Real s2 "Auxiliary variables";
  equation 
    control.i = 0;
    0 = p.i + n2.i + n1.i;
    
    p.v - n1.v = s1*(if (control.v > level) then 1 else Ron);
    n1.i = -s1*(if (control.v > level) then Goff else 1);
    p.v - n2.v = s2*(if (control.v > level) then Ron else 1);
    n2.i = -s2*(if (control.v > level) then 1 else Goff);
  end ControlledIdealCommutingSwitch;
  
  model ControlledIdealIntermediateSwitch 
    "Controlled ideal intermediate switch" 
    parameter SI.Voltage level=0.5 "Switch level";
    parameter SI.Resistance Ron(final min=0) = 1.E-5 "Closed switch resistance"
      ;
    parameter SI.Conductance Goff(final min=0) = 1.E-5 
      "Opened switch conductance";
    annotation (
      Documentation(info="<HTML>
<P>
The intermediate switch has four switching contact pins p1, p2, n1, and n2. 
The switching behaviour is controlled
by the control pin. If its voltage exceeds the value of the 
parameter level, the pin p1 is connected to pin n2, and the pin p2 is 
connected to the pin n2. Otherwise, the pin p1 is connected to n1, and
p2 is connected to n2.
</P>

<IMG SRC=\"../Images/ControlledIdealIntermediateSwitch1.png\" ALT=\"ControlledIdealIntermediateSwitch1\">

<P>
In order to prevent singularities during switching, the opened 
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron. 
</P>

<IMG SRC=\"../Images/ControlledIdealIntermediateSwitch2.png\" ALT=\"ControlledIdealIntermediateSwitch2\">

<P>
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits, 
where a description with zero Ron or zero Goff is not possible. 
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Ellipse(extent=[-4, 30; 4, 22]), 
        Text(extent=[-80, 50; -60, 72], string="p1"), 
        Text(extent=[-80, 0; -60, 22], string="p2"), 
        Text(extent=[60, 50; 80, 72], string="n1"), 
        Text(extent=[60, 0; 80, 22], string="n2"), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-90, 50; -44, 50]), 
        Line(points=[-44, 0; 40, 50]), 
        Line(points=[-44, 50; 40, 0]), 
        Line(points=[40, 50; 90, 50]), 
        Line(points=[0, 90; 0, 25]), 
        Line(points=[40, 0; 90, 0]), 
        Text(extent=[-100, -70; 100, -100], string="%name")), 
      Diagram(
        Ellipse(extent=[-4, 30; 4, 22]), 
        Text(extent=[-80, 50; -60, 72], string="p1"), 
        Text(extent=[-80, 0; -60, 22], string="p2"), 
        Text(extent=[60, 50; 80, 72], string="n1"), 
        Text(extent=[60, 0; 80, 22], string="n2"), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-90, 50; -44, 50]), 
        Line(points=[-44, 0; 40, 50]), 
        Line(points=[-44, 50; 40, 0]), 
        Line(points=[40, 50; 90, 50]), 
        Line(points=[0, 90; 0, 25]), 
        Line(points=[40, 0; 90, 0])), 
      Window(
        x=0.21, 
        y=0.05, 
        width=0.6, 
        height=0.6));
    
  public 
    Interfaces.PositivePin p1 annotation (extent=[-110, 40; -90, 60]);
    Interfaces.PositivePin p2 annotation (extent=[-110, -10; -90, 10]);
    Interfaces.NegativePin n1 annotation (extent=[90, 40; 110, 60]);
    Interfaces.NegativePin n2 annotation (extent=[90, -10; 110, 10]);
    Interfaces.Pin control "Control pin: if control.v > level p1--n2, p2--n1 connected,
         otherwise p1--n1, p2--n2  connected" annotation (extent=[-10, 90; 10, 
          110], rotation=90);
  protected 
    Real s1;
    Real s2;
    Real s3;
    Real s4 "Auxiliary variables";
  equation 
    control.i = 0;
    
    p1.v - n1.v = s1*(if (control.v > level) then 1 else Ron);
    p2.v - n2.v = s2*(if (control.v > level) then 1 else Ron);
    p1.v - n2.v = s3*(if (control.v > level) then Ron else 1);
    p2.v - n1.v = s4*(if (control.v > level) then Ron else 1);
    
    p1.i = if (control.v > level) then s1*Goff + s3 else s1 + s3*Goff;
    p2.i = if (control.v > level) then s2*Goff + s4 else s2 + s4*Goff;
    n1.i = if (control.v > level) then -s1*Goff - s4 else -s1 - s4*Goff;
    n2.i = if (control.v > level) then -s2*Goff - s3 else -s2 - s3*Goff;
  end ControlledIdealIntermediateSwitch;
  
  model IdealOpAmp "Ideal operational amplifier (norator-nullator pair)" 
    SI.Voltage v1 "Voltage drop over the left port";
    SI.Voltage v2 "Voltage drop over the right port";
    SI.Current i1 "Current flowing from pos. to neg. pin of the left port";
    SI.Current i2 "Current flowing from pos. to neg. pin of the right port";
    annotation (
      Documentation(info="<html>
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
        Polygon(points=[60, 0; -60, 70; -60, -70; 60, 0], style(fillColor=7)), 
        Line(points=[-90, 50; -60, 50]), 
        Line(points=[-90, -50; -60, -50]), 
        Line(points=[60, 0; 90, 0]), 
        Line(points=[0, -35; 0, -91]), 
        Line(points=[-48, 32; -28, 32]), 
        Line(points=[-39, -20; -39, -41]), 
        Line(points=[-50, -31; -28, -31])), 
      Diagram(
        Polygon(points=[60, 0; -60, 70; -60, -70; 60, 0], style(fillColor=7)), 
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
    Interfaces.PositivePin p1 "Positive pin of the left port" annotation (
        extent=[-110, -60; -90, -40]);
    Interfaces.NegativePin n1 "Negative pin of the left port" annotation (
        extent=[-110, 40; -90, 60]);
    Interfaces.PositivePin p2 "Positive pin of the right port" annotation (
        extent=[90, -10; 110, 10]);
    Interfaces.NegativePin n2 "Negative pin of the right port" annotation (
        extent=[-10, -90; 10, -110], rotation=-90);
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
  
  model IdealOpAmp3Pin 
    "Ideal operational amplifier (norator-nullator pair), but 3 pins" 
    annotation (
      Documentation(info="<html>
<P>
The ideal OpAmp with three pins is of exactly the same behaviour as the ideal
OpAmp with four pins. Only the negative output pin is left out.
Both the input voltage and current are fixed to zero (nullator).
At the output pin both any voltage <i>v2</i> and any current <i>i2</i>
are possible.
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Text(extent=[-100, 80; 100, 100], string="%name"), 
        Polygon(points=[60, 0; -60, 70; -60, -70; 60, 0], style(fillColor=7)), 
        Line(points=[-90, 50; -60, 50]), 
        Line(points=[-90, -50; -60, -50]), 
        Line(points=[60, 0; 90, 0]), 
        Line(points=[-48, 32; -28, 32]), 
        Line(points=[-39, -20; -39, -41]), 
        Line(points=[-50, -31; -28, -31])), 
      Diagram(
        Polygon(points=[60, 0; -60, 70; -60, -70; 60, 0], style(fillColor=7)), 
        Line(points=[-90, 50; -60, 50]), 
        Line(points=[-90, -50; -60, -50]), 
        Line(points=[60, 0; 90, 0]), 
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
          style(color=9, fillColor=9))), 
      Window(
        x=0.28, 
        y=0.19, 
        width=0.71, 
        height=0.59));
    Interfaces.PositivePin in_p "Positive pin of the input port" annotation (
        extent=[-110, -60; -90, -40]);
    Interfaces.NegativePin in_n "Negative pin of the input port" annotation (
        extent=[-110, 40; -90, 60]);
    Interfaces.PositivePin out "Output pin" annotation (extent=[90, -10; 110, 
          10]);
  equation 
    in_p.v = in_n.v;
    in_p.i = 0;
    in_n.i = 0;
  end IdealOpAmp3Pin;
  
  model IdealOpAmpLimited "Ideal operational amplifier with limitation" 
    annotation (
      Documentation(info="<HTML>
<P>
The ideal OpAmp with limitation behaves like an ideal OpAmp without limitation,
if the output voltage is within the limits (VMin < out.v < VMax). In this case
the input voltage vin=in_p.v - in_n.v is zero.
If the input voltage is vin < 0, the output voltage is out.v = VMin.
If the input voltage is vin > 0, the output voltage is out.v = VMax.
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Text(extent=[-110, 80; 100, 90], string="%name"), 
        Polygon(points=[60, 0; -60, 70; -60, -70; 60, 0], style(fillColor=7)), 
        Line(points=[-45, -10; -10, -10; -10, 10; 20, 10]), 
        Line(points=[0, 35; 0, 80]), 
        Line(points=[0, -35; 0, -80]), 
        Line(points=[-90, 50; -60, 50]), 
        Line(points=[-90, -50; -60, -50]), 
        Line(points=[60, 0; 90, 0]), 
        Line(points=[-48, 32; -28, 32]), 
        Line(points=[-39, -20; -39, -41]), 
        Line(points=[-50, -31; -28, -31])), 
      Diagram(
        Polygon(points=[60, 0; -60, 70; -60, -70; 60, 0], style(fillColor=7)), 
        Line(points=[-45, -10; -10, -10; -10, 10; 20, 10]), 
        Line(points=[0, 35; 0, 80]), 
        Line(points=[0, -35; 0, -80]), 
        Line(points=[-90, 50; -60, 50]), 
        Line(points=[-90, -50; -60, -50]), 
        Line(points=[60, 0; 90, 0]), 
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
          style(color=9, fillColor=9))), 
      Window(
        x=0.28, 
        y=0.19, 
        width=0.71, 
        height=0.59));
    Interfaces.PositivePin in_p "Positive pin of the input port" annotation (
        extent=[-110, -60; -90, -40]);
    Interfaces.NegativePin in_n "Negative pin of the input port" annotation (
        extent=[-110, 40; -90, 60]);
    Interfaces.PositivePin out "Output pin" annotation (extent=[90, -10; 110, 
          10]);
    Interfaces.PositivePin VMax "Positive output voltage limitation" 
      annotation (extent=[-10, 60; 10, 80]);
    Interfaces.NegativePin VMin "Negative output voltage limitation" 
      annotation (extent=[-10, -80; 10, -60]);
    SI.Voltage vin "input voltage";
  protected 
    Real s "Auxiliary variable";
  equation 
    in_p.i = 0;
    in_n.i = 0;
    VMax.i = 0;
    VMin.i = 0;
    vin = in_p.v - in_n.v;
    in_p.v - in_n.v = if (s < -1) then s + 1 else if (s > 1) then s - 1 else 0;
    out.v = if (s < -1) then VMin.v else if (s > 1) then VMax.v else (VMax.v - 
      VMin.v)*s/2 + (VMax.v + VMin.v)/2;
  end IdealOpAmpLimited;
  
  model IdealDiode "Ideal electrical diode" 
    extends Interfaces.OnePort;
    parameter SI.Resistance Roff(final min=0) = 1.E-5 "Closed diode resistance"
      ;
    parameter SI.Conductance Gon(final min=0) = 1.E-5 
      "Opened diode conductance";
    Boolean off(start=true) "Switching state of diode";
  protected 
    Real s "Auxiliary variable";
    annotation (
      Documentation(info="<html>
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
    extends Interfaces.TwoPort;
    parameter Real n=1 "Turns ratio";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Documentation(info="<html>
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
    extends Interfaces.TwoPort;
    annotation (
      Documentation(info="<html>
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
    parameter SI.Conductance G=1 "Gyration conductance";
  equation 
    i1 = G*v2;
    i2 = -G*v1;
  end IdealGyrator;
  
  model Idle "Idle branch" 
    extends Interfaces.OnePort;
    annotation (
      Documentation(info="<html>
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
        Rectangle(extent=[-60, 60; 60, -60], style(fillColor=7)), 
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
    extends Interfaces.OnePort;
    annotation (
      Documentation(info="<html>
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
        Rectangle(extent=[-60, 60; 60, -60], style(fillColor=7)), 
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
  
  model IdealOpener "Ideal electrical opener" 
    extends Interfaces.OnePort;
    parameter SI.Resistance Ron(final min=0) = 1.E-5 "Closed switch resistance"
       annotation (extent=[-56.6667, 10; -10, 56.6667]);
    parameter SI.Conductance Goff(final min=0) = 1.E-5 
      "Opened switch conductance" annotation (extent=[10, 10; 56.6667, 56.6667]
      );
    Modelica.Blocks.Interfaces.BooleanInPort control(final n=1) 
      "true => switch open, false => p--n connected" annotation (extent=[-10, 
          50; 10, 70], rotation=-90);
  protected 
    Real s "Auxiliary variable";
    Boolean off;
    
    annotation (
      Documentation(info="<HTML>
<P> 
The ideal opener has a positive pin p and a negative pin n. 
The switching behaviour is controlled by the control signal. 
If the control signal is true, pin p is not connected 
with negative pin n. Otherwise, pin p is connected 
with negative pin n.
</P>
<P>
In order to prevent singularities during switching, the opened 
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron. 
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits, 
where a description with zero Ron or zero Goff is not possible. 
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.45, 
        y=0.01, 
        width=0.44, 
        height=0.65), 
      Icon(
        Ellipse(extent=[-44, 4; -36, -4]), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-37, 2; 40, 50]), 
        Line(points=[40, 0; 90, 0]), 
        Text(extent=[-100, -70; 100, -100], string="%name"), 
        Line(points=[0, 51; 0, 26]), 
        Line(points=[40, 20; 40, 0])), 
      Diagram(
        Ellipse(extent=[-44, 4; -36, -4]), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-37, 2; 40, 50]), 
        Line(points=[40, 0; 90, 0]), 
        Text(extent=[-100, -40; 100, -79], string="%name"), 
        Line(points=[0, 51; 0, 26]), 
        Line(points=[40, 20; 40, 0])));
  equation 
    off = control.signal[1];
    v = s*(if off then 1 else Ron);
    i = s*(if off then Goff else 1);
  end IdealOpener;
  
  model IdealCloser "Ideal electrical closer" 
    extends Interfaces.OnePort;
    parameter SI.Resistance Ron(final min=0) = 1.E-5 "Closed switch resistance"
       annotation (extent=[-56.6667, 10; -10, 56.6667]);
    parameter SI.Conductance Goff(final min=0) = 1.E-5 
      "Opened switch conductance" annotation (extent=[10, 10; 56.6667, 56.6667]
      );
    Modelica.Blocks.Interfaces.BooleanInPort control(final n=1) 
      "true => switch open, false => p--n connected" annotation (extent=[-10, 
          50; 10, 70], rotation=-90);
  protected 
    Real s "Auxiliary variable";
    Boolean on;
    
    annotation (
      Documentation(info="<HTML>
<P> 
The ideal opener has a positive pin p and a negative pin n. 
The switching behaviour is controlled by the control signal. 
If the control signal is true, pin p is not connected 
with negative pin n. Otherwise, pin p is connected 
with negative pin n.
</P>
<P>
In order to prevent singularities during switching, the opened 
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron. 
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits, 
where a description with zero Ron or zero Goff is not possible. 
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.24, 
        y=0.01, 
        width=0.65, 
        height=0.77), 
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
    on = control.signal[1];
    v = s*(if not on then 1 else Ron);
    i = s*(if not on then Goff else 1);
  end IdealCloser;
  
  model ControlledIdealOpener "Controlled ideal electrical opener" 
    parameter SI.Voltage level=0.5 "Switch level" annotation (extent=[-56.6667
          , 10; -10, 56.6667]);
    parameter SI.Resistance Ron(final min=0) = 1.E-5 "Closed switch resistance"
       annotation (extent=[10, 10; 56.6667, 56.6667]);
    parameter SI.Conductance Goff(final min=0) = 1.E-5 
      "Opened switch conductance" annotation (extent=[-56.6667, -56.6667; -10, 
          -10]);
  protected 
    Real s "Auxiliary variable";
    annotation (
      Documentation(info="
<HTML>
<P>
The ideal switch has a positive pin p and a negative pin n. 
The switching behaviour is controlled by the control pin. 
If its voltage exceeds the voltage of the parameter level,
pin p is not connected with negative pin n. 
Otherwise, pin p is connected with negative pin n.
</P>
<P>
In order to prevent singularities during switching, the opened 
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron. 
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits, 
where a description with zero Ron or zero Goff is not possible. 
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.45, 
        y=0.01, 
        width=0.44, 
        height=0.65), 
      Icon(
        Ellipse(extent=[-44, 4; -36, -4]), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-37, 2; 40, 50]), 
        Line(points=[40, 0; 90, 0]), 
        Line(points=[0, 90; 0, 25]), 
        Text(extent=[-100, -70; 100, -100], string="%name"), 
        Line(points=[40, 20; 40, 0])), 
      Diagram(
        Ellipse(extent=[-44, 4; -36, -4]), 
        Line(points=[-90, 0; -44, 0]), 
        Line(points=[-37, 2; 40, 50]), 
        Line(points=[40, 0; 90, 0]), 
        Line(points=[0, 90; 0, 25]), 
        Line(points=[40, 20; 40, 0])));
  public 
    Interfaces.PositivePin p annotation (extent=[-110, -10; -90, 10]);
    Interfaces.NegativePin n annotation (extent=[90, -10; 110, 10]);
    Interfaces.Pin control 
      "Control pin: control.v > level switch open, otherwise p--n connected" 
      annotation (extent=[-10, 90; 10, 110], rotation=90);
  equation 
    control.i = 0;
    0 = p.i + n.i;
    p.v - n.v = s*(if (control.v > level) then 1 else Ron);
    p.i = s*(if (control.v > level) then Goff else 1);
  end ControlledIdealOpener;
  
  model ControlledIdealCloser "Controlled ideal electrical closer" 
    parameter SI.Voltage level=0.5 "Switch level" annotation (extent=[-56.6667
          , 10; -10, 56.6667]);
    parameter SI.Resistance Ron(final min=0) = 1.E-5 "Closed switch resistance"
       annotation (extent=[10, 10; 56.6667, 56.6667]);
    parameter SI.Conductance Goff(final min=0) = 1.E-5 
      "Opened switch conductance" annotation (extent=[-56.6667, -56.6667; -10, 
          -10]);
  protected 
    Real s "Auxiliary variable";
    annotation (
      Documentation(info="
<HTML>
<P>
The ideal switch has a positive pin p and a negative pin n. 
The switching behaviour is controlled by the control pin. 
If its voltage exceeds the voltage of the parameter level,
pin p is not connected with negative pin n. 
Otherwise, pin p is connected with negative pin n.
</P>
<P>
In order to prevent singularities during switching, the opened 
switch has a (very low) conductance Goff
and the closed switch has a (very low) resistance Ron. 
The limiting case is also allowed, i.e., the resistance Ron of the
closed switch could be exactly zero and the conductance Goff of the
open switch could be also exactly zero. Note, there are circuits, 
where a description with zero Ron or zero Goff is not possible. 
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.45, 
        y=0.01, 
        width=0.44, 
        height=0.65), 
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
    Interfaces.PositivePin p annotation (extent=[-110, -10; -90, 10]);
    Interfaces.NegativePin n annotation (extent=[90, -10; 110, 10]);
    Interfaces.Pin control 
      "Control pin: control.v > level switch open, otherwise p--n connected" 
      annotation (extent=[-10, 90; 10, 110], rotation=90);
  equation 
    control.i = 0;
    0 = p.i + n.i;
    p.v - n.v = s*(if (control.v > level) then Ron else 1);
    p.i = s*(if (control.v > level) then 1 else Goff);
  end ControlledIdealCloser;
  
end Ideal;
