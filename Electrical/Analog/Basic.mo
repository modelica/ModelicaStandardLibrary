package Basic 
  
  extends Modelica.Icons.Library;
  
  annotation (Window(
       x=0.03, 
       y=0.04, 
       width=0.54, 
       height=0.35, 
       library=1, 
       autolayout=1),
Documentation(info="<HTML>
<p>
This package contains basic analog electrical components:
<ul>
<li>Ground</li>
<li>Resistor</li>
<li>HeatingResistor</li>
<li>Conductor</li>
<li>Capacitor</li>
<li>Inductor</li>
<li>Transformer</li>
<li>Gyrator</li>
<li>EMF (Electroc-Motoric-Force)</li>
<li>Linear controlled sources (VCV, VCC, CCV, CCC)</li>
<li>OpAmp</li>
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
  model Ground "Ground node" 
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Documentation(info="<HTML>
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
        Text(extent=[-100, -68; 100, -10], string="%name")), 
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
    Interfaces.Pin p annotation (extent=[-10, 110; 10, 90], rotation=-90);
  equation 
    p.v = 0;
  end Ground;
  
  model Resistor "Ideal linear electrical resistor" 
    extends Interfaces.OnePort;
    parameter SI.Resistance R=1 "Resistance";
    annotation (
      Documentation(info="<HTML>
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
          extent=[-98, -58; 102, -120], 
          string="R=%R", 
          style(color=0)), 
        Text(extent=[-100, 40; 100, 100], string="%name")), 
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
  
  model HeatingResistor "Temperature dependent electrical resistor" 
    extends Interfaces.OnePort;
    
    parameter SI.Resistance R_ref "Resistance at temperature T_ref";
    parameter SI.Temperature T_ref=300 "Reference temperature";
    parameter Real alpha(unit="1/K") = 0 
      "Temperature coefficient of resistance";
    
    SI.Resistance R "Resistance = R_ref*(1 + alpha*(heatPort.T - T_ref));";
    
    annotation (
      Diagram(
        Line(points=[-110, 20; -85, 20], style(color=9, fillColor=9)), 
        Polygon(points=[-95, 23; -85, 20; -95, 17; -95, 23], style(
            color=9, 
            fillColor=9, 
            fillPattern=1)), 
        Line(points=[90, 20; 115, 20], style(color=9, fillColor=9)), 
        Line(points=[-125, 0; -115, 0], style(color=9)), 
        Line(points=[-120, -5; -120, 5], style(color=9)), 
        Text(
          extent=[-110, 25; -90, 45], 
          string="i", 
          style(color=9)), 
        Polygon(points=[105, 23; 115, 20; 105, 17; 105, 23], style(
            color=9, 
            fillColor=9, 
            fillPattern=1)), 
        Line(points=[115, 0; 125, 0], style(color=9)), 
        Text(
          extent=[90, 45; 110, 25], 
          string="i", 
          style(color=9)), 
        Rectangle(extent=[-70, 30; 70, -30]), 
        Line(points=[-90, 0; -70, 0]), 
        Line(points=[70, 0; 90, 0]), 
        Line(points=[0, -30; 0, -90], style(color=42)), 
        Line(points=[-52, -50; 48, 50], style(color=73, fillColor=73)), 
        Polygon(points=[40, 52; 50, 42; 54, 56; 40, 52], style(color=73, 
              fillColor=73))), 
      Icon(
        Text(extent=[-143, 60; 143, 98], string="%name"), 
        Line(points=[-90, 0; -70, 0]), 
        Line(points=[70, 0; 90, 0]), 
        Rectangle(extent=[-70, 30; 70, -30], style(
            color=3, 
            fillColor=7, 
            fillPattern=1)), 
        Line(points=[0, -30; 0, -91], style(color=42)), 
        Line(points=[-52, -50; 48, 50], style(color=73, fillColor=73)), 
        Polygon(points=[40, 52; 50, 42; 54, 56; 40, 52], style(color=73, 
              fillColor=73))), 
      Documentation(info="<HTML>
<p>This is a model for an electrical resistor where the generated heat
is dissipated to the environment via connector <b>heatPort</b> and where
the resistance R is temperature dependent according to the following
equation:</p>

<pre>    R = R_ref*(1 + alpha*(heatPort.T - T_ref))
</pre>

<p><b>alpha</b> is the <b>temperature coefficient of resistance</b>, which
is often abbreviated as <b>TCR</b>. In resistor catalogues, it is usually
defined as <b>X [ppm/K]</b> (parts per million, similarly to per centage)
meaning <b>X*1.e-6 [1/K]</b>. Resistors are available for 1 .. 7000 ppm/K,
i.e., alpha = 1e-6 .. 7e-3 1/K;</p>

<p>When connector <b>heatPort</b> is <b>not</b> connected, the temperature
dependent behaviour is switched off by setting heatPort.T = T_ref.
Additionally, the equation <tt>heatPort.Q_dot = 0</tt> is implicitly present
due to a special rule in Modelica that flow variables of not connected
connectors are set to zero.</p>
</HTML>
"));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation (
        extent=[-10, -90; 10, -110], rotation=-90);
  equation 
    v = R*i;
    
    if cardinality(heatPort) > 0 then
      R = R_ref*(1 + alpha*(heatPort.T - T_ref));
      heatPort.Q_dot = -v*i;
    else
      /* heatPort is not connected resulting in the
         implicit equation 'heatPort.Q_dot = 0'
      */
      R = R_ref;
      heatPort.T = T_ref;
    end if;
  end HeatingResistor;
  
  model Conductor "Ideal linear electrical conductor" 
    extends Interfaces.OnePort;
    parameter SI.Conductance G=1 "Conductance";
    annotation (
      Documentation(info="<HTML>
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
        Rectangle(extent=[-70, 30; 70, -30], style(fillColor=7, fillPattern=1))
          , 
        Rectangle(extent=[-70, 30; 70, -30]), 
        Line(points=[-90, 0; -70, 0]), 
        Line(points=[70, 0; 90, 0]), 
        Text(
          extent=[-100, -60; 100, -122], 
          string="G=%G", 
          style(color=0, pattern=0)), 
        Text(extent=[-100, 40; 100, 98], string="%name")), 
      Diagram(Line(points=[-90, 0; -70, 0]), Line(points=[70, 0; 90, 0])), 
      Window(
        x=0, 
        y=0.2, 
        width=0.63, 
        height=0.68));
  equation 
    i = G*v;
  end Conductor;
  
  model Capacitor "Ideal linear electrical capacitor" 
    extends Interfaces.OnePort;
    parameter SI.Capacitance C=1 "Capacitance";
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
      Documentation(info="<HTML>
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
          extent=[-100, -60; 100, -120], 
          string="C=%C", 
          style(color=0)), 
        Text(extent=[-100, 40; 100, 100], string="%name")), 
      Diagram(
        Line(points=[-20, 40; -20, -40], style(thickness=2)), 
        Line(points=[20, 40; 20, -40], style(thickness=2)), 
        Line(points=[-90, 0; -20, 0]), 
        Line(points=[20, 0; 90, 0])));
  equation 
    i = C*der(v);
  end Capacitor;
  
  model Inductor "Ideal linear electrical inductor" 
    extends Interfaces.OnePort;
    parameter SI.Inductance L=1 "Inductance";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Documentation(info="<HTML>
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
          extent=[-100, -60; 100, -120], 
          string="L=%L", 
          style(color=0)), 
        Text(extent=[-100, 40; 100, 100], string="%name")), 
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
    extends Interfaces.TwoPort;
    parameter SI.Inductance L1=1 "Primary inductance";
    parameter SI.Inductance L2=1 "Secondary inductance";
    parameter SI.Inductance M=1 "Coupling inductance";
    annotation (
      Documentation(info="<HTML>
<p>The transformer is a two port. The left port voltage <i>v1</i>, left port current <i>i1</i>,
right port voltage <i>v2</i> and right port current <i>i2</i> are connected by the following
relation:</p>
<pre>         | v1 |         | L1   M  |  | i1' |
         |    |    =    |         |  |     |
         | v2 |         | M    L2 |  | i2' |</pre>
<p><i>L1</i>, <i>L2</i>, and <i>M</i> are the primary, secondary, and coupling inductances respectively.</p>
</html>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Text(extent=[-100, 128; 100, 70], string="%name"), 
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
        Text(extent=[-89, 18; -60, -10], string="L1"), 
        Text(extent=[64, 18; 90, -10], string="L2"), 
        Text(extent=[-18, -70; 20, -98], string="M")), 
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
        x=0.26, 
        y=0.43, 
        width=0.6, 
        height=0.6));
  equation 
    v1 = L1*der(i1) + M*der(i2);
    v2 = M*der(i1) + L2*der(i2);
  end Transformer;
  
  model Gyrator "Gyrator" 
    extends Interfaces.TwoPort;
    parameter SI.Conductance G1=1 "Gyration conductance";
    parameter SI.Conductance G2=1 "Gyration conductance";
    annotation (
      Documentation(info="<HTML>
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
        Rectangle(extent=[-60, 60; 60, -60], style(fillColor=7)), 
        Line(points=[-90, 50; -60, 50]), 
        Line(points=[-90, -50; -60, -50]), 
        Line(points=[60, 50; 90, 50]), 
        Line(points=[60, -50; 90, -50]), 
        Line(points=[-40, 30; 40, 30]), 
        Line(points=[-20, -20; 20, -20]), 
        Polygon(points=[30, 34; 40, 30; 30, 26; 30, 34], style(fillColor=3, 
              fillPattern=1)), 
        Polygon(points=[-26, -19; -16, -15; -16, -23; -26, -19], style(
              fillColor=3, fillPattern=1)), 
        Line(points=[-5, 10; -10, -10], style(thickness=2)), 
        Line(points=[9, 10; 4, -9], style(thickness=2)), 
        Line(points=[-14, 9; 16, 10], style(thickness=2)), 
        Text(extent=[-100, 130; 100, 69], string="%name"), 
        Text(extent=[-29, 59; 30, 30], string="G1"), 
        Text(extent=[-29, -29; 29, -58], string="G2")), 
      Diagram(
        Rectangle(extent=[-60, 60; 60, -60]), 
        Line(points=[-90, 50; -60, 50]), 
        Line(points=[-90, -50; -60, -50]), 
        Line(points=[60, 50; 90, 50]), 
        Line(points=[60, -50; 90, -50]), 
        Line(points=[-40, 30; 40, 30]), 
        Line(points=[-21, -22; 19, -22]), 
        Polygon(points=[30, 34; 40, 30; 30, 26; 30, 34], style(fillColor=3, 
              fillPattern=1)), 
        Polygon(points=[-20, -30; -10, -26; -10, -34; -20, -30], style(
              fillColor=3, fillPattern=1)), 
        Line(points=[-4, 5; -6, -5], style(thickness=4)), 
        Line(points=[3, 5; 1, -5], style(thickness=4)), 
        Line(points=[-8, 5; 7, 5], style(thickness=4)), 
        Text(extent=[-20, 50; 20, 35], string="G1"), 
        Text(extent=[-20, -35; 20, -50], string="G2")), 
      Window(
        x=0.4, 
        y=0.4, 
        width=0.6, 
        height=0.6));
  equation 
    i1 = G2*v2;
    i2 = -G1*v1;
  end Gyrator;
  
  model EMF "Electromotoric force (electric/mechanic transformer)" 
    parameter Real k(final unit="N.m/A") = 1 "Transformation coefficient";
    
    SI.Voltage v "Voltage drop between the two pins";
    SI.Current i "Current flowing from positive to negative pin";
    SI.AngularVelocity w "Angular velocity of flange_b";
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
        Ellipse(extent=[-40, 40; 40, -40], style(fillColor=7)), 
        Line(points=[0, -90; 0, -40]), 
        Text(extent=[20, -40; 100, -100], string="%name"), 
        Text(
          extent=[30, 100; 119, 40], 
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
        Polygon(points=[140, 3; 150, 0; 140, -3; 140, 3; 140, 3], style(color=0
              , fillColor=0)), 
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
EMF transforms electrical energy into rotational mechanical energy.
It is used as basic building block of an electrical motor. The mechanical
connector flange_b can be connected to elements of the
Modelica.Mechanics.Rotational library. flange_b.tau is the cut-torque,
flange_b.phi is the angle at the rotational connection.
</p>
</HTML>
"));
    Interfaces.PositivePin p annotation (extent=[-10, 90; 10, 110], rotation=90
      );
    Interfaces.NegativePin n annotation (extent=[-10, -110; 10, -90], rotation=
          90);
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
    extends Interfaces.TwoPort;
    parameter Real gain=1 "Voltage gain";
    annotation (
      Documentation(info="<HTML>
<p>
The linear voltage-controlled voltage source is a TwoPort.
The right port voltage v2 is controlled by the left port voltage v1
via
</p>

<pre>
    v2 = v1 * gain.
</pre>

<p>
The left port current is zero. Any voltage gain can be chosen.
</p>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.28, 
        y=0.02, 
        width=0.59, 
        height=0.92), 
      Icon(
        Rectangle(extent=[-70, 70; 70, -70], style(fillColor=7)), 
        Text(extent=[-99, -79; 100, -129], string="%name"), 
        Line(points=[-90, 50; -30, 50]), 
        Line(points=[-30, -50; -90, -50]), 
        Line(points=[100, 50; 30, 50; 30, -50; 100, -50]), 
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
    extends Interfaces.TwoPort;
    parameter SI.Conductance transConductance=1 "Transconductance";
    annotation (
      Documentation(info="<HTML>
<p>
The linear voltage-controlled current source is a TwoPort.
The right port current i2 is controlled by the left port voltage v1
via
</p>
<pre>
    i2 = v1 * transConductance.
</pre>
<p>
The left port current is zero. Any transConductance can be chosen.
</p>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[-70, 70; 70, -70], style(fillColor=7)), 
        Text(extent=[-99, -80; 100, -129], string="%name"), 
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
    extends Interfaces.TwoPort;
    
    parameter SI.Resistance transResistance=1 "Transresistance";
    annotation (
      Documentation(info="<HTML>
<p>
The linear current-controlled voltage source is a TwoPort.
The right port voltage v2 is controlled by the left port current i1
via
</p>
<pre>
    v2 = i1 * transResistance.
</pre>
<p>
The left port voltage is zero. Any transResistance can be chosen.
</p>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[-70, 70; 70, -70], style(fillColor=7)), 
        Text(extent=[-99, -80; 100, -130], string="%name"), 
        Line(points=[100, 50; 30, 50; 30, -50; 100, -50]), 
        Ellipse(extent=[10, 20; 50, -20]), 
        Line(points=[-20, 60; 20, 60]), 
        Polygon(points=[20, 60; 10, 63; 10, 57; 20, 60], style(fillColor=3, 
              fillPattern=1)), 
        Line(points=[-90, 50; -20, 50; -20, -50; -90, -50])), 
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
    extends Interfaces.TwoPort;
    parameter Real gain=1 "Current gain";
    annotation (
      Documentation(info="<HTML>
<p>
The linear current-controlled current source is a TwoPort.
The right port current i2 is controlled by the left port current i1
via
</p>

<pre>
    i2 = i1 * gain.
</pre>

<p>
The left port voltage is zero. Any current gain can be chosen.
</p>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[-70, 70; 70, -70], style(fillColor=7)), 
        Text(extent=[-104, -76; 97, -127], string="%name"), 
        Line(points=[-100, 50; -30, 50; -30, -50; -100, -50]), 
        Ellipse(extent=[10, 20; 50, -20]), 
        Line(points=[-20, 60; 20, 60]), 
        Polygon(points=[20, 60; 10, 63; 10, 57; 20, 60], style(fillColor=3, 
              fillPattern=1)), 
        Line(points=[90, 50; 30, 50; 30, 20]), 
        Line(points=[91, -50; 30, -50; 30, -20]), 
        Line(points=[10, 0; 50, 0])), 
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
  
  model OpAmp "Simple nonideal model of an OpAmp with limitation" 
    annotation (
      Documentation(info="<HTML>
<P>
The OpAmp is a simle nonideal model with a smooth out.v = f(vin) characteristic,
where \"vin = in_p.v - in_n.v\".
The characteristic is limited by VMax.v and VMin.v. Its slope at vin=0
is the parameter Slope, which must be positive. (Therefore, the absolute 
value of Slope is taken into calculation.)
</P>
</HTML>
"), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Text(extent=[-95, 88; 115, 146], string="%name"), 
        Polygon(points=[60, 0; -60, 70; -60, -70; 60, 0], style(fillColor=7)), 
        Line(points=[-45, -10; -20, -10; -14, -9; -11, -7; -9, 7; -6, 9; 0, 10
              ; 20, 10]), 
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
        Line(points=[-45, -10; -20, -10; -14, -9; -11, -7; -9, 7; -6, 9; 0, 10
              ; 20, 10]), 
        Line(points=[0, 35; 0, 80]), 
        Line(points=[0, -35; 0, -80]), 
        Line(points=[-90, 50; -60, 50]), 
        Line(points=[-90, -50; -60, -50]), 
        Line(points=[60, 0; 90, 0]), 
        Line(points=[-55, 50; -45, 50]), 
        Line(points=[-50, -45; -50, -55]), 
        Line(points=[-55, -50; -45, -50]), 
        Text(
          extent=[-112, -93; -91, -73], 
          style(color=9, fillColor=9), 
          string="in_p.i=0"), 
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
          extent=[-111, 60; -85, 80], 
          style(color=9, fillColor=9), 
          string="in_n.i=0"), 
        Line(points=[-100, -35; -100, 23; -100, 24], style(color=9, arrow=1)), 
        Text(
          extent=[-97, -16; -74, 4], 
          style(color=9, fillColor=9), 
          string="vin")), 
      Window(
        x=0.28, 
        y=0.19, 
        width=0.71, 
        height=0.59));
    parameter Real Slope=1 "Slope of the out.v/vin characteristic at vin=0";
    Modelica.Electrical.Analog.Interfaces.PositivePin in_p 
      "Positive pin of the input port" annotation (extent=[-110, -60; -90, -40]
      );
    Modelica.Electrical.Analog.Interfaces.NegativePin in_n 
      "Negative pin of the input port" annotation (extent=[-110, 40; -90, 60]);
    Modelica.Electrical.Analog.Interfaces.PositivePin out "Output pin" 
      annotation (extent=[90, -10; 110, 10]);
    Modelica.Electrical.Analog.Interfaces.PositivePin VMax 
      "Positive output voltage limitation" annotation (extent=[-10, 60; 10, 80]
      );
    Modelica.Electrical.Analog.Interfaces.NegativePin VMin 
      "Negative output voltage limitation" annotation (extent=[-10, -80; 10, -
          60]);
    SI.Voltage vin "input voltagae";
  protected 
    Real f "auxiliary variable";
    Real absSlope;
  equation 
    in_p.i = 0;
    in_n.i = 0;
    VMax.i = 0;
    VMin.i = 0;
    vin = in_p.v - in_n.v;
    f = 2/(VMax.v - VMin.v);
    absSlope = if (Slope < 0) then -Slope else Slope;
    out.v = (VMax.v + VMin.v)/2 + absSlope*vin/(1 + absSlope*noEvent(if (f*vin
       < 0) then -f*vin else f*vin));
  end OpAmp;
  
end Basic;
