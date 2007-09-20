within Modelica.Electrical.Analog;
package Interfaces 
  "Connectors and partial models for Analog electrical components" 
  extends Modelica.Icons.Library;
  annotation(preferedView="info", Window(
      x=0.03,
      y=0.04,
      width=0.21,
      height=0.49,
      library=1,
      autolayout=1),Documentation(info="<html>
<p>
This package contains connectors and interfaces (partial models) for
analog electrical components.
</p>

</HTML>
", revisions="<html>
<dl>
<dt>
<b>Main Authors:</b>
<dd>
<a href=\"http://people.eas.iis.fhg.de/Christoph.Clauss/\">Christoph Clau&szlig;</a>
    &lt;<a href=\"mailto:clauss@eas.iis.fhg.de\">clauss@eas.iis.fhg.de</a>&gt;<br>
    <a href=\"http://people.eas.iis.fhg.de/Andre.Schneider/\">Andr&eacute; Schneider</a>
    &lt;<a href=\"mailto:schneider@eas.iis.fhg.de\">schneider@eas.iis.fhg.de</a>&gt;<br>
    Fraunhofer Institute for Integrated Circuits<br>
    Design Automation Department<br>
    Zeunerstra&szlig;e 38<br>
    D-01069 Dresden<br>
<p>
<dt>
</dl>

<b>Copyright:</b>
<dl>
<dd>
Copyright &copy; 1998-2006, Modelica Association and Fraunhofer-Gesellschaft.<br>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".</i><br>
<p>
</dl>

<ul>
<li><i> 1998</i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
  
  connector Pin "Pin of an electrical component" 
    SI.Voltage v "Potential at the pin";
    flow SI.Current i "Current flowing into the pin";
    annotation (defaultComponentName="pin",
      Icon(Rectangle(extent=[-100, 100; 100, -100], style(color=3, fillColor=3))),
      Diagram(Rectangle(extent=[-40,40; 40,-40], style(color=3, fillColor=
               3)), Text(
          extent=[-160,110; 40,50],
          string="%name",
          style(color=3))),
      Documentation(revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
  end Pin;
  
  connector PositivePin "Positive pin of an electric component" 
    SI.Voltage v "Potential at the pin";
    flow SI.Current i "Current flowing into the pin";
    annotation (defaultComponentName="pin_p",
      Documentation(info="<html><p>Connectors PositivePin
and NegativePin are nearly identical.
The only difference is that the icons are different in order
to identify more easily the pins of a component. Usually,
connector PositivePin is used for the positive and
connector NegativePin for the negative pin of an electrical
component.</p></html>", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(Rectangle(extent=[-100, 100; 100, -100], style(color=3, fillColor=3))),
      Diagram(Rectangle(extent=[-40,40; 40,-40], style(color=3, fillColor=
               3)), Text(
          extent=[-160,110; 40,50],
          string="%name",
          style(color=3))));
  end PositivePin;
  
  connector NegativePin "Negative pin of an electric component" 
    SI.Voltage v "Potential at the pin";
    flow SI.Current i "Current flowing into the pin";
    annotation (defaultComponentName="pin_n",
      Documentation(info="<html><p>Connectors PositivePin
and NegativePin are nearly identical.
The only difference is that the icons are different in order
to identify more easily the pins of a component. Usually,
connector PositivePin is used for the positive and
connector NegativePin for the negative pin of an electrical
component.</p></html>", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"),
      Icon(Rectangle(extent=[-100, 100; 100, -100], style(
            color=3,
            gradient=0,
            fillColor=7,
            fillPattern=1))),
      Diagram(Rectangle(extent=[-40,40; 40,-40], style(
            color=3,
            fillColor=7,
            fillPattern=1)), Text(extent=[-40,110; 160,50], string=
              "%name")),
      Terminal(Rectangle(extent=[-100, 100; 100, -100], style(color=3))));
  end NegativePin;
  
  partial model TwoPin "Component with one electrical port" 
    SI.Voltage v "Voltage drop between the two pins (= p.v - n.v)";
    PositivePin p 
      "Positive pin Positive pin (potential p.v > n.v for positive voltage drop v)"
                                                                                                annotation (extent=[-110, -10; -90, 10]);
    NegativePin n "Negative pin" annotation (extent=[90, -10; 110, 10]);
    annotation (
      Diagram(
        Polygon(points=[-120, 3; -110, 0; -120, -3; -120, 3], style(
            color=9,
            fillColor=9,
            fillPattern=1)),
        Line(points=[-136, 0; -111, 0], style(color=9, fillColor=9)),
        Text(
          extent=[-134, 5; -117, 20],
          string="p.i",
          style(color=9, fillColor=9)),
        Line(points=[110, 0; 135, 0], style(color=9, fillColor=9)),
        Polygon(points=[120, 3; 110, 0; 120, -3; 120, 3], style(
            color=9,
            fillColor=9,
            fillPattern=1)),
        Text(
          extent=[117, 3; 134, 18],
          string="n.i",
          style(color=9, fillColor=9))),
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.11,
        y=0.14,
        width=0.55,
        height=0.64),
      Documentation(revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
  equation 
    v = p.v - n.v;
  end TwoPin;
  
  partial model OnePort 
    "Component with two electrical pins p and n and current i from p to n" 
    
    SI.Voltage v "Voltage drop between the two pins (= p.v - n.v)";
    SI.Current i "Current flowing from pin p to pin n";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Documentation(info="<HTML>
<P>
Superclass of elements which have <b>two</b> electrical pins:
the positive pin connector <i>p</i>, and the negative pin
connector <i>n</i>. It is assumed that the current flowing
into pin p is identical to the current flowing out of pin n.
This current is provided explicitly as current i.
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
          style(color=9))),
      Window(
        x=0.33,
        y=0.04,
        width=0.63,
        height=0.67));
    PositivePin p 
      "Positive pin (potential p.v > n.v for positive voltage drop v)"             annotation (extent=[-110, -10; -90, 10]);
    NegativePin n "Negative pin" annotation (extent=[110, -10; 90, 10]);
  equation 
    v = p.v - n.v;
    0 = p.i + n.i;
    i = p.i;
  end OnePort;
  
  partial model TwoPort 
    "Component with two electrical ports, including current" 
    SI.Voltage v1 "Voltage drop over the left port";
    SI.Voltage v2 "Voltage drop over the right port";
    SI.Current i1 "Current flowing from pos. to neg. pin of the left port";
    SI.Current i2 "Current flowing from pos. to neg. pin of the right port";
    PositivePin p1 
      "Positive pin of the left port (potential p1.v > n1.v for positive voltage drop v1)"
                                                                                                        annotation (extent=[-110, 40;
            -90, 60]);
    NegativePin n1 "Negative pin of the left port" annotation (extent=[-90,-60;
          -110,-40]);
    PositivePin p2 
      "Positive pin of the right port (potential p2.v > n2.v for positive voltage drop v2)"
                                                                                                         annotation (extent=[110,40;
          90,60]);
    NegativePin n2 "Negative pin of the right port" annotation (extent=[90, -60;
            110, -40]);
    annotation (
      Diagram(
        Polygon(points=[-120, 53; -110, 50; -120, 47; -120, 53], style(
            color=9,
            fillColor=9,
            fillPattern=1)),
        Line(points=[-136, 50; -111, 50], style(color=9, fillColor=9)),
        Polygon(points=[127, -47; 137, -50; 127, -53; 127, -47], style(
            color=9,
            fillColor=9,
            fillPattern=1)),
        Line(points=[111, -50; 136, -50], style(color=9, fillColor=9)),
        Text(
          extent=[112, -44; 128, -29],
          string="i2",
          style(color=9, fillColor=9)),
        Text(
          extent=[118, 52; 135, 67],
          string="i2",
          style(
            color=9,
            gradient=2,
            fillColor=9)),
        Polygon(points=[120, 53; 110, 50; 120, 47; 120, 53], style(
            color=9,
            gradient=2,
            fillColor=9,
            fillPattern=1)),
        Line(points=[111, 50; 136, 50], style(
            color=9,
            gradient=2,
            fillColor=9)),
        Line(points=[-136, -49; -111, -49], style(color=9, fillColor=9)),
        Polygon(points=[-126, -46; -136, -49; -126, -52; -126, -46], style(
            color=9,
            fillColor=9,
            fillPattern=1)),
        Text(
          extent=[-127, -46; -110, -31],
          string="i1",
          style(color=9, fillColor=9)),
        Text(
          extent=[-136, 53; -119, 68],
          string="i1",
          style(color=9, fillColor=9))),
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.16,
        y=0.12,
        width=0.6,
        height=0.6),
      Documentation(revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>", info="<html>
 
</html>"));
  equation 
    v1 = p1.v - n1.v;
    v2 = p2.v - n2.v;
    0 = p1.i + n1.i;
    0 = p2.i + n2.i;
    i1 = p1.i;
    i2 = p2.i;
  end TwoPort;
  
  partial model AbsoluteSensor 
    "Base class to measure the absolute value of a pin variable" 
    extends Modelica.Icons.RotationalSensor;
    
    Interfaces.PositivePin p "Pin to be measured" annotation (extent=[-110, -10; -90, 10]);
    Modelica.Blocks.Interfaces.RealOutput y 
      "Measured quantity as Real output signal"                                       annotation (extent=[100, -10; 120, 10]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.31,
        y=0.04,
        width=0.6,
        height=0.6),
      Icon(
        Line(points=[-70, 0; -90, 0], style(color=0)),
        Line(points=[70, 0; 100, 0]),
        Text(extent=[-150, 80; 150, 120], string="%name")),
      Diagram(Line(points=[-70,0; -96,0],   style(color=0)), Line(points=[70, 0;
                100, 0])),
      Documentation(revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
  end AbsoluteSensor;
  
  partial model RelativeSensor 
    "Base class to measure a relative variable between two pins" 
    extends Modelica.Icons.RotationalSensor;
    
    Interfaces.PositivePin p "Positive pin" annotation (extent=[-110, -10; -90, 10]);
    Interfaces.NegativePin n "Negative pin" annotation (extent=[90, -10; 110, 10]);
    Modelica.Blocks.Interfaces.RealOutput y 
      "Measured quantity as Real output signal"                                       annotation (extent=[-10, -90; 10, -110],
        rotation=90);
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Icon(
        Line(points=[-70, 0; -90, 0], style(color=0)),
        Line(points=[70, 0; 90, 0], style(color=0)),
        Line(points=[0, -90; 0, -70]),
        Text(extent=[-150, 80; 150, 120], string="%name")),
      Diagram(
        Line(points=[-70,0; -96,0],   style(color=0)),
        Line(points=[0, -90; 0, -70]),
        Line(points=[70,0; 96,0],   style(color=0))),
      Documentation(revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
    
  end RelativeSensor;
  
  partial model VoltageSource "Interface for voltage sources" 
    extends OnePort;
    
    parameter SI.Voltage offset=0 "Voltage offset";
    parameter SI.Time startTime=0 "Time offset";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Icon(
        Ellipse(extent=[-50, 50; 50, -50], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=7,
            rgbfillColor={255,255,255})),
        Text(extent=[-150,80; 150,120], string="%name"),
        Line(points=[-90,0; 90,0], style(color=0, rgbcolor={0,0,0})),
        Text(
          extent=[-120,50; -20,0],
          style(color=3, rgbcolor={0,0,255}),
          string="+"),
        Text(
          extent=[20,50; 120,0],
          style(color=3, rgbcolor={0,0,255}),
          string="-")),
      Window(
        x=0.31,
        y=0.09,
        width=0.6,
        height=0.6),
      Documentation(revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
    replaceable Modelica.Blocks.Interfaces.SignalSource signalSource(
        final offset = offset, final startTime=startTime) 
    annotation (extent=[70, 70; 90, 90]);
  equation 
    v = signalSource.y;
  end VoltageSource;
  
  partial model CurrentSource "Interface for current sources" 
    extends OnePort;
    
    parameter SI.Current offset=0 "Current offset";
    parameter SI.Time startTime=0 "Time offset";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Icon(
        Ellipse(extent=[-50, 50; 50, -50], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=7,
            rgbfillColor={255,255,255})),
        Line(points=[-90, 0; -50, 0], style(color=0, rgbcolor={0,0,0})),
        Line(points=[50, 0; 90, 0], style(color=0, rgbcolor={0,0,0})),
        Line(points=[0, -50; 0, 50], style(color=0, rgbcolor={0,0,0})),
        Text(extent=[-150, 120; 150, 80], string="%name"),
        Polygon(points=[90,0; 60,10; 60,-10; 90,0],      style(
            color=3,
            rgbcolor={0,0,255},
            fillColor=3,
            rgbfillColor={0,0,255}))),
      Window(
        x=0.33,
        y=0.24,
        width=0.6,
        height=0.6),
      Documentation(revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>"));
    replaceable Modelica.Blocks.Interfaces.SignalSource signalSource(
        final offset = offset, final startTime=startTime) annotation (extent=[70,
          69; 91,89]);
  equation 
    i = signalSource.y;
  end CurrentSource;
end Interfaces;
