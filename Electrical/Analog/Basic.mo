package Basic 
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
      height=0.24, 
      library=1, 
      autolayout=1), 
    Documentation(info="
<HTML>
<p>
This package contains basic analog electrical components:
<ul>
<li>Ground</li>
<li>Resistor</li>
<li>Conductor</li>
<li>Capacitor</li>
<li>Inductor</li>
<li>Transformer</li>
<li>Gyrator</li>
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
  model Ground "Ground node" 
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Documentation(info="
<HTML>
<P>
Ground of an electrical circuit. The potential at the
ground node is zero. Every electrical circuit has to contain
at least one ground object.
</P>
</HTML>
"), 
      Icon(
        Line(points=[-60, 50; 60, 50]), 
        Line(points=[-40, 30; 40, 30]), 
        Line(points=[-20, 10; 20, 10]), 
        Line(points=[0, 90; 0, 50]), 
        Text(extent=[-100, -40; 100, -10], string="%name")), 
      Diagram(
        Line(points=[-60, 50; 60, 50], style(thickness=2)), 
        Line(points=[-40, 30; 40, 30], style(thickness=2)), 
        Line(points=[-20, 10; 20, 10], style(thickness=2)), 
        Line(points=[0, 90; 0, 50], style(thickness=2)), 
        Text(extent=[-24, -38; 22, -6], string="p.v=0")), 
      Window(
        x=0.23, 
        y=0.23, 
        width=0.59, 
        height=0.63));
    Modelica.Electrical.Analog.Interfaces.Pin p annotation (extent=[-10, 110; 
          10, 90], rotation=-90);
  equation 
    p.v = 0;
  end Ground;
  model Resistor "Ideal linear electrical resistor" 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SIunits.Resistance R=1 "Resistance";
    annotation (
      Documentation(info="
<HTML>
<P>
The linear resistor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by <i>i*R = v</i>. 
The Resistance <i>R</i> is allowed to be positive, zero, or negative.
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[-70, 30; 70, -30], style(
            color=3, 
            fillColor=7, 
            fillPattern=1)), 
        Line(points=[-90, 0; -70, 0]), 
        Line(points=[70, 0; 90, 0]), 
        Text(
          extent=[-100, -60; 100, -80], 
          string="R=%R", 
          style(color=0)), 
        Text(extent=[-100, 60; 100, 80], string="%name")), 
      Diagram(
        Rectangle(extent=[-70, 30; 70, -30]), 
        Line(points=[-90, 0; -70, 0]), 
        Line(points=[70, 0; 90, 0])), 
      Window(
        x=0.2, 
        y=0.06, 
        width=0.62, 
        height=0.69));
  equation 
    R*i = v;
  end Resistor;
  model Conductor "Ideal linear electrical conductor" 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SIunits.Conductance G=1 "Conductance";
    annotation (
      Documentation(info="
<HTML>
<P>
The linear conductor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by <i>i = v*G</i>. 
The Conductance <i>G</i> is allowed to be positive, zero, or negative.
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[-70, 30; 70, -30], style(fillColor=7, fillPattern=1)
          ), 
        Rectangle(extent=[-70, 30; 70, -30]), 
        Line(points=[-90, 0; -70, 0]), 
        Line(points=[70, 0; 90, 0]), 
        Text(
          extent=[-100, -60; 100, -80], 
          string="G=%G", 
          style(color=0, pattern=0)), 
        Text(extent=[-100, 60; 100, 80], string="%name")), 
      Diagram(Line(points=[-90, 0; -70, 0]), Line(points=[70, 0; 90, 0])), 
      Window(
        x=0.17, 
        y=0.29, 
        width=0.6, 
        height=0.6));
  equation 
    i = G*v;
  end Conductor;
  model Capacitor "Ideal linear electrical capacitor" 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SIunits.Capacitance C=1 "Capacitance";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.32, 
        y=0.33, 
        width=0.48, 
        height=0.58), 
      Documentation(info="
<HTML>
<p>
The linear capacitor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by <i>i = C * dv/dt</i>. 
The Capacitance <i>C</i> is allowed to be positive, zero, or negative.
</p>
</HTML>
"), 
      Icon(
        Line(points=[-14, 28; -14, -28], style(thickness=2)), 
        Line(points=[14, 28; 14, -28], style(thickness=2)), 
        Line(points=[-90, 0; -14, 0]), 
        Line(points=[14, 0; 90, 0]), 
        Text(
          extent=[-100, -60; 100, -80], 
          string="C=%C", 
          style(color=0)), 
        Text(extent=[-100, 60; 100, 80], string="%name")), 
      Diagram(
        Line(points=[-20, 40; -20, -40], style(thickness=2)), 
        Line(points=[20, 40; 20, -40], style(thickness=2)), 
        Line(points=[-90, 0; -20, 0]), 
        Line(points=[20, 0; 90, 0])));
  equation 
    i = C*der(v);
  end Capacitor;
  model Inductor "Ideal linear electrical inductor" 
    extends Modelica.Electrical.Analog.Interfaces.OnePort;
    parameter SIunits.Inductance L=1 "Inductance";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Documentation(info="
<HTML>
<P>
The linear inductor connects the branch voltage <i>v</i> with the
branch current <i>i</i> by  <i>v = L * di/dt</i>. 
The Inductance <i>L</i> is allowed to be positive, zero, or negative.
</p>
</HTML>
"), 
      Icon(
        Ellipse(extent=[-60, -15; -30, 15]), 
        Ellipse(extent=[-30, -15; 0, 15]), 
        Ellipse(extent=[0, -15; 30, 15]), 
        Ellipse(extent=[30, -15; 60, 15]), 
        Rectangle(extent=[-60, -30; 60, 0], style(color=7, fillColor=7)), 
        Line(points=[60, 0; 90, 0]), 
        Line(points=[-90, 0; -60, 0]), 
        Text(
          extent=[-100, -60; 100, -80], 
          string="L=%L", 
          style(color=0)), 
        Text(extent=[-100, 60; 100, 80], string="%name")), 
      Diagram(
        Ellipse(extent=[-60, -15; -30, 15]), 
        Ellipse(extent=[-30, -15; 0, 15]), 
        Ellipse(extent=[0, -15; 30, 15]), 
        Ellipse(extent=[30, -15; 60, 15]), 
        Rectangle(extent=[-60, -30; 60, 0], style(color=7, fillColor=7)), 
        Line(points=[60, 0; 90, 0]), 
        Line(points=[-90, 0; -60, 0])), 
      Window(
        x=0.3, 
        y=0.12, 
        width=0.6, 
        height=0.6));
  equation 
    L*der(i) = v;
  end Inductor;
  model Transformer "Transformer with two ports" 
    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    parameter SIunits.Inductance L1=1 "Primary inductance";
    parameter SIunits.Inductance L2=1 "Secondary inductance";
    parameter SIunits.Inductance M=1 "Coupling inductance";
    annotation (
      Documentation(info="
<HTML>
<P>
The transformer is a two port. The left port voltage <i>v1</i>, left port current <i>i1</i>,
right port voltage <i>v2</i> and right port current <i>i2</i> are connected by the following
relation:
</P>
<PRE>

         / v1 \          / L1   M  \  / i1' \
         |    |    =     |         |  |     |
         \ v2 /          \ M    L2 /  \ i2' /

</PRE>
<P>
<i>L1</i>, <i>L2</i>, and <i>M</i> are the primary, secondary, and coupling inductances resp..
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
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
        Text(extent=[-80, 10; -60, -10], string="L1"), 
        Text(extent=[60, 10; 80, -10], string="L2"), 
        Text(extent=[-10, -70; 10, -90], string="M")), 
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
        x=0.28, 
        y=0.13, 
        width=0.6, 
        height=0.6));
  equation 
    v1 = L1*der(i1) + M*der(i2);
    v2 = M*der(i1) + L2*der(i2);
  end Transformer;
  model Gyrator "Gyrator" 
    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    annotation (
      Documentation(info="
<HTML>
<P>    
A gyrator is a two-port element defined by the following equations:
</P>
<PRE>
    i1 =  G2 * v2
    i2 = -G1 * v1
</PRE>
<P>
where the constants <i>G1</i>, <i>G2</i> are called the gyration conductance.
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[-60, 60; 60, -60]), 
        Line(points=[-90, 50; -60, 50]), 
        Line(points=[-90, -50; -60, -50]), 
        Line(points=[60, 50; 90, 50]), 
        Line(points=[60, -50; 90, -50]), 
        Line(points=[-40, 30; 40, 30]), 
        Line(points=[-20, -30; 20, -30]), 
        Polygon(points=[30, 34; 40, 30; 30, 26; 30, 34], style(fillColor=3, 
              fillPattern=1)), 
        Polygon(points=[-20, -30; -10, -26; -10, -34; -20, -30], style(
              fillColor=3, fillPattern=1)), 
        Line(points=[-4, 5; -6, -5], style(thickness=2)), 
        Line(points=[3, 5; 1, -5], style(thickness=2)), 
        Line(points=[-8, 5; 7, 5], style(thickness=2)), 
        Text(extent=[-100, 100; 100, 70], string="%name"), 
        Text(extent=[-20, 50; 20, 35], string="G1"), 
        Text(extent=[-20, -35; 20, -50], string="G2")), 
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60]), 
        Line(points=[-90, 50; -60, 50]), 
        Line(points=[-90, -50; -60, -50]), 
        Line(points=[60, 50; 90, 50]), 
        Line(points=[60, -50; 90, -50]), 
        Line(points=[-40, 30; 40, 30]), 
        Line(points=[-20, -30; 20, -30]), 
        Polygon(points=[30, 34; 40, 30; 30, 26; 30, 34], style(fillColor=3, 
              fillPattern=1)), 
        Polygon(points=[-20, -30; -10, -26; -10, -34; -20, -30], style(
              fillColor=3, fillPattern=1)), 
        Line(points=[-4, 5; -6, -5], style(thickness=4)), 
        Line(points=[3, 5; 1, -5], style(thickness=4)), 
        Line(points=[-8, 5; 7, 5], style(thickness=4)), 
        Text(extent=[-20, 50; 20, 35], string="G1"), 
        Text(extent=[-20, -35; 20, -50], string="G2")));
    parameter SIunits.Conductance G1=1 "Gyration conductance";
    parameter SIunits.Conductance G2=1 "Gyration conductance";
  equation 
    i1 = G2*v2;
    i2 = -G1*v1;
  end Gyrator;
  model EMF "Electromotoric force (electric/mechanic transformer)" 
    parameter Real k(final unit="N.m/A") = 1 "Transformation coefficient";
    
    SIunits.Voltage v "Voltage drop between the two pins";
    SIunits.Current i "Current flowing from positive to negative pin";
    SIunits.AngularVelocity w "Angular velocity of flange_b";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Line(points=[0, 90; 0, 40]), 
        Rectangle(extent=[40, 10; 90, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Ellipse(extent=[-40, 40; 40, -40]), 
        Line(points=[0, -90; 0, -40]), 
        Text(extent=[20, -40; 100, -100], string="%name"), 
        Text(
          extent=[40, 79; 119, 50], 
          string="k=%k", 
          style(color=9))), 
      Diagram(
        Polygon(points=[-17, 95; -20, 85; -23, 95; -17, 95], style(
            color=9, 
            fillColor=9, 
            fillPattern=1)), 
        Line(points=[-20, 110; -20, 85], style(color=9, fillColor=9)), 
        Text(
          extent=[-40, 110; -30, 90], 
          string="i", 
          style(color=9, fillColor=9)), 
        Line(points=[9, 75; 19, 75], style(color=8)), 
        Line(points=[0, 90; 0, 40]), 
        Ellipse(extent=[-40, 40; 40, -40]), 
        Rectangle(extent=[40, 10; 90, -10], style(
            gradient=2, 
            fillColor=8, 
            fillPattern=1)), 
        Line(points=[-20, -110; -20, -85], style(color=9, fillColor=9)), 
        Polygon(points=[-17, -100; -20, -110; -23, -100; -17, -100], style(
            color=9, 
            fillColor=9, 
            fillPattern=1)), 
        Text(
          extent=[-40, -110; -30, -90], 
          string="i", 
          style(color=9)), 
        Line(points=[8, -79; 18, -79], style(color=8)), 
        Line(points=[0, -90; 0, -40]), 
        Line(points=[14, 80; 14, 70], style(color=8)), 
        Line(points=[140, 0; 110, 0], style(color=0, fillColor=0)), 
        Text(extent=[114, -4; 148, -14], string="flange_b.phi"), 
        Polygon(points=[140, 3; 150, 0; 140, -3; 140, 3; 140, 3], style(color=
                0, fillColor=0)), 
        Text(extent=[112, 16; 148, 6], string="flange_b.tau"), 
        Polygon(points=[120, 35; 100, 40; 100, 30; 120, 35], style(color=10, 
              fillColor=10)), 
        Line(points=[30, 35; 101, 35], style(color=10, fillColor=10)), 
        Text(
          extent=[37, 59; 105, 46], 
          string="rotation axis", 
          style(color=10))), 
      Window(
        x=0.21, 
        y=0, 
        width=0.65, 
        height=0.66), 
      Documentation(info="<HTML>
<p>
Transforms electrical energy into rotational mechanical energy.
Is used as basic building block of an electrical motor. The mechanical
connector flange_b can be connected to elements of the 
Modelica.Mechanics.Rotational library.
</p>
<HTML>
"));
    Modelica.Electrical.Analog.Interfaces.PositivePin p annotation (extent=[-
          10, 90; 10, 110], rotation=90);
    Modelica.Electrical.Analog.Interfaces.NegativePin n annotation (extent=[-
          10, -110; 10, -90], rotation=90);
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b annotation (
        extent=[90, -10; 110, 10]);
  equation 
    v = p.v - n.v;
    0 = p.i + n.i;
    i = p.i;
    
    w = der(flange_b.phi);
    k*w = v;
    flange_b.tau = -k*i;
  end EMF;
  model VCV "Linear voltage-controlled voltage source" 
    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    parameter Real gain=1 "Voltage gain";
    annotation (
      Documentation(info="

Linear voltage-controlled voltage source

  The linear voltage-controlled voltage source is a TwoPort. 
  The right port voltage vr is controlled by the left port voltage vl
  via      v2 = v1 * gain.
  The left port current is zero. Any voltage gain can be chosen. 

"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.28, 
        y=0.02, 
        width=0.56, 
        height=0.83), 
      Icon(
        Rectangle(extent=[-70, 70; 70, -70], style(fillColor=7)), 
        Text(extent=[-100, -80; 100, -100], string="%name"), 
        Line(points=[-90, 50; -30, 50]), 
        Line(points=[-30, -50; -90, -50]), 
        Line(points=[90, 50; 30, 50; 30, -50; 90, -50]), 
        Ellipse(extent=[10, 20; 50, -20]), 
        Line(points=[-20, 60; 20, 60]), 
        Polygon(points=[20, 60; 10, 63; 10, 57; 20, 60], style(fillColor=3, 
              fillPattern=1))), 
      Diagram(
        Line(points=[-90, 50; -30, 50]), 
        Line(points=[-30, -50; -90, -50]), 
        Line(points=[90, 50; 30, 50; 30, -50; 90, -50]), 
        Ellipse(extent=[10, 20; 50, -20]), 
        Rectangle(extent=[-70, 70; 70, -70]), 
        Line(points=[-20, 60; 20, 60]), 
        Polygon(points=[20, 60; 10, 63; 10, 57; 20, 60], style(fillColor=3, 
              fillPattern=1))));
  equation 
    v2 = v1*gain;
    i1 = 0;
  end VCV;
  model VCC "Linear voltage-controlled current source" 
    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    parameter Modelica.SIunits.Conductance transConductance=1 
      "Transconductance";
    annotation (
      Documentation(info="

Linear voltage-controlled current source

  The linear voltage-controlled current source is a TwoPort. 
  The right port current ir is controlled by the left port voltage vl
  via      i2 = v1 * transConductance.
  The left port current is zero. Any transConductance can be chosen. 

"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[-70, 70; 70, -70], style(fillColor=7)), 
        Text(extent=[-100, -80; 100, -100], string="%name"), 
        Line(points=[-90, 50; -30, 50]), 
        Line(points=[-30, -50; -90, -50]), 
        Ellipse(extent=[10, 20; 50, -20]), 
        Line(points=[-20, 60; 20, 60]), 
        Polygon(points=[20, 60; 10, 63; 10, 57; 20, 60], style(fillColor=3, 
              fillPattern=1)), 
        Line(points=[90, 50; 30, 50; 30, 20]), 
        Line(points=[91, -50; 30, -50; 30, -20]), 
        Line(points=[10, 0; 50, 0])), 
      Diagram(
        Line(points=[-90, 50; -30, 50]), 
        Line(points=[-30, -50; -90, -50]), 
        Ellipse(extent=[10, 20; 50, -20]), 
        Rectangle(extent=[-70, 70; 70, -70]), 
        Line(points=[-20, 60; 20, 60]), 
        Polygon(points=[20, 60; 10, 63; 10, 57; 20, 60], style(fillColor=3, 
              fillPattern=1)), 
        Line(points=[90, 50; 30, 50; 30, 20]), 
        Line(points=[91, -50; 30, -50; 30, -20]), 
        Line(points=[10, 0; 50, 0])), 
      Window(
        x=0.34, 
        y=0.05, 
        width=0.6, 
        height=0.6));
  equation 
    i2 = v1*transConductance;
    i1 = 0;
  end VCC;
  model CCV "Linear current-controlled voltage source" 
    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    
    parameter Modelica.SIunits.Resistance transResistance=1 "Transresistance";
    annotation (
      Documentation(info="

Linear current-controlled voltage source

  The linear current-controlled voltage source is a TwoPort. 
  The right port voltage vr is controlled by the left port current i1
  via      v2 = i1 * transResistance.
  The left port voltage is zero. Any transResistance can be chosen. 

"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[-70, 70; 70, -70], style(fillColor=7)), 
        Text(extent=[-100, -80; 100, -100], string="%name"), 
        Ellipse(extent=[10, 20; 50, -20]), 
        Line(points=[-20, 60; 20, 60]), 
        Polygon(points=[20, 60; 10, 63; 10, 57; 20, 60], style(fillColor=3, 
              fillPattern=1)), 
        Line(points=[90, 50; 30, 50; 30, -50; 90, -50]), 
        Line(points=[-90, 50; -30, 50; -30, -50; -90, -50])), 
      Diagram(
        Ellipse(extent=[10, 20; 50, -20]), 
        Rectangle(extent=[-70, 70; 70, -70]), 
        Line(points=[-20, 60; 20, 60]), 
        Polygon(points=[20, 60; 10, 63; 10, 57; 20, 60], style(fillColor=3, 
              fillPattern=1)), 
        Line(points=[90, 50; 30, 50; 30, -50; 90, -50]), 
        Line(points=[-90, 50; -30, 50; -30, -50; -90, -50])), 
      Window(
        x=0.3, 
        y=0.13, 
        width=0.6, 
        height=0.6));
  equation 
    v2 = i1*transResistance;
    v1 = 0;
  end CCV;
  model CCC "Linear current-controlled current source" 
    extends Modelica.Electrical.Analog.Interfaces.TwoPort;
    parameter Real gain=1 "Current gain";
    annotation (
      Documentation(info="

Linear current-controlled current source

  The linear current-controlled current source is a TwoPort. 
  The right port current ir is controlled by the left port current il
  via      ir = il * gain.
  The left port voltage is zero. Any current gain can be chosen. 

"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[-70, 70; 70, -70], style(fillColor=7)), 
        Text(extent=[-100, -80; 100, -100], string="%name"), 
        Ellipse(extent=[10, 20; 50, -20]), 
        Line(points=[-20, 60; 20, 60]), 
        Polygon(points=[20, 60; 10, 63; 10, 57; 20, 60], style(fillColor=3, 
              fillPattern=1)), 
        Line(points=[90, 50; 30, 50; 30, 20]), 
        Line(points=[91, -50; 30, -50; 30, -20]), 
        Line(points=[10, 0; 50, 0]), 
        Line(points=[-90, 50; -30, 50; -30, -50; -91, -50])), 
      Diagram(
        Ellipse(extent=[10, 20; 50, -20]), 
        Rectangle(extent=[-70, 70; 70, -70]), 
        Line(points=[-20, 60; 20, 60]), 
        Polygon(points=[20, 60; 10, 63; 10, 57; 20, 60], style(fillColor=3, 
              fillPattern=1)), 
        Line(points=[90, 50; 30, 50; 30, 20]), 
        Line(points=[91, -50; 30, -50; 30, -20]), 
        Line(points=[10, 0; 50, 0]), 
        Line(points=[-90, 50; -30, 50; -30, -50; -91, -50])), 
      Window(
        x=0.31, 
        y=0.09, 
        width=0.6, 
        height=0.6));
  equation 
    i2 = i1*gain;
    v1 = 0;
  end CCC;
end Basic;

