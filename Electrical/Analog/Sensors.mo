within Modelica.Electrical.Analog;
package Sensors "Potential, voltage, current, and power sensors" 
  
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
This package contains potential, voltage, and current sensors.
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
  
  model PotentialSensor "Sensor to measure the potential" 
    extends Modelica.Icons.RotationalSensor;
    
    Interfaces.PositivePin p "pin to be measured" annotation (extent=[-110, -10; -90, 10]);
    Modelica.Blocks.Interfaces.RealOutput phi(
        redeclare type SignalType = SI.ElectricPotential) 
      "Absolute voltage potential as output signal" 
        annotation (extent=[100, -10; 120, 10]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Icon(Text(
          extent=[-29, -11; 30, -70],
          string="V",
          style(color=0)),
        Line(points=[-70,0; -90,0],   style(color=0)),
        Line(points=[100,0; 70,0]),
        Text(extent=[-150,80; 150,120],   string="%name")),
      Window(
        x=0.4,
        y=0.32,
        width=0.6,
        height=0.6),
      Diagram(
        Line(points=[-70,0; -96,0],   style(color=0)),
        Line(points=[100,0; 70,0])),
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
    p.i = 0;
    phi = p.v;
  end PotentialSensor;
  
  model VoltageSensor "Sensor to measure the voltage between two pins" 
    extends Modelica.Icons.RotationalSensor;
    
    Interfaces.PositivePin p "positive pin" annotation (extent=[-110, -10; -90, 10]);
    Interfaces.NegativePin n "negative pin" annotation (extent=[90, -10; 110, 10]);
    Modelica.Blocks.Interfaces.RealOutput v(
        redeclare type SignalType = SI.Voltage) 
      "Voltage between pin p and n (= p.v - n.v) as output signal" 
       annotation (extent=[-10, -90; 10, -110],
        rotation=90);
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.28,
        y=0.29,
        width=0.6,
        height=0.6),
      Icon(Text(
          extent=[-29, -11; 30, -70],
          string="V",
          style(color=0)),
        Line(points=[-70,0; -90,0],   style(color=0)),
        Line(points=[70,0; 90,0],   style(color=0)),
        Line(points=[0,-90; 0,-70]),
        Text(extent=[-150,80; 150,120],   string="%name")),
      Diagram(
        Line(points=[-70,0; -96,0],   style(color=0)),
        Line(points=[70,0; 96,0],   style(color=0)),
        Line(points=[0,-90; 0,-70])),
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
    p.i = 0;
    n.i = 0;
    v = p.v - n.v;
  end VoltageSensor;
  
  model CurrentSensor "Sensor to measure the current in a branch" 
    extends Modelica.Icons.RotationalSensor;
    
    Interfaces.PositivePin p "positive pin" annotation (extent=[-110, -10; -90, 10]);
    Interfaces.NegativePin n "negative pin" annotation (extent=[90, -10; 110, 10]);
    Modelica.Blocks.Interfaces.RealOutput i(
        redeclare type SignalType = SI.Current) 
      "current in the branch from p to n as output signal" 
       annotation (extent=[-10, -90; 10, -110],
        rotation=90);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.23,
        y=0.07,
        width=0.6,
        height=0.6),
      Icon(Text(
          extent=[-29, -11; 30, -70],
          string="A",
          style(color=0)),
        Line(points=[-70,0; -90,0],   style(color=0)),
        Text(extent=[-150,80; 150,120],   string="%name"),
        Line(points=[70,0; 90,0],   style(color=0)),
        Line(points=[0,-90; 0,-70])),
      Diagram(
        Text(extent=[-153,79; 147,119],   string="%name"),
        Line(points=[-70,0; -96,0],   style(color=0)),
        Line(points=[70,0; 96,0],   style(color=0)),
        Line(points=[0,-90; 0,-70])),
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
    p.v = n.v;
    p.i = i;
    n.i = -i;
  end CurrentSensor;
  
model PowerSensor "Sensor to measure the power" 
    
  annotation (uses(Modelica(version="2.2")),
    Icon(
      Ellipse(extent=[-70,70; 70,-70],   style(color=0, fillColor=7)),
      Line(points=[0,100; 0,70], style(color=3, rgbcolor={0,0,255})),
      Line(points=[0,-70; 0,-100], style(color=3, rgbcolor={0,0,255})),
      Line(points=[-80,-100; -80,0],style(color=3, rgbcolor={0,0,255})),
      Line(points=[-100,0; 100,0], style(color=3, rgbcolor={0,0,255})),
      Text(extent=[150,120; -150,160], string="%name"),
      Line(points=[0,70; 0,40],   style(color=0)),
      Line(points=[22.9,32.8; 40.2,57.3],   style(color=0)),
      Line(points=[-22.9,32.8; -40.2,57.3],   style(color=0)),
      Line(points=[37.6,13.7; 65.8,23.9],   style(color=0)),
      Line(points=[-37.6,13.7; -65.8,23.9],   style(color=0)),
      Line(points=[0,0; 9.02,28.6],   style(color=0)),
      Polygon(points=[-0.48,31.6; 18,26; 18,57.2; -0.48,31.6],     style(
          color=0,
          fillColor=0,
          fillPattern=1)),
      Ellipse(extent=[-5,5; 5,-5],   style(
          color=0,
          gradient=0,
          fillColor=0,
          fillPattern=1)),
         Text(
        extent=[-29,-11; 30,-70],
        style(color=0),
        string="P")),
    Diagram,
    Coordsys(grid=[2,2], component=[20,20]),
    Documentation(info="<html><p>
This power sensor measures instantaneous electrical power of a singlephase system and has a separated voltage and current path. The pins of the voltage path are <code>pv</code> and <code>nv</code>, the pins of the current path are <code>pc</code> and <code>nc</code>. The internal resistance of the current path is zero, the internal resistance of the voltage path is infinite.
</p>
</html>", revisions="<html>
<ul>
<li><i>  </i>
       </li>
<li><i> January 12, 2006   </i>
       by Anton Haumer<br> implemented<br>
       </li>
</ul>
</html>"));
  Modelica.Electrical.Analog.Interfaces.PositivePin pc 
      "Positive pin, current path" 
    annotation (extent=[-90,-10; -110,10]);
  Modelica.Electrical.Analog.Interfaces.NegativePin nc 
      "Negative pin, current path" 
    annotation (extent=[110,-10; 90,10], rotation=0);
  Modelica.Electrical.Analog.Interfaces.PositivePin pv 
      "Positive pin, voltage path" 
    annotation (extent=[-10,110; 10,90]);
  Modelica.Electrical.Analog.Interfaces.NegativePin nv 
      "Negative pin, voltage path" 
    annotation (extent=[10,-110; -10,-90]);
  Modelica.Blocks.Interfaces.RealOutput power(redeclare type SignalType = 
        Modelica.SIunits.Power) 
    annotation (extent=[-70,-120; -90,-100],rotation=270);
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor 
    annotation (extent=[10,-20; -10,-40], rotation=90);
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor 
    annotation (extent=[-50,-10; -30,10],rotation=0);
  Modelica.Blocks.Math.Product product 
    annotation (extent=[-40,-60; -20,-40], rotation=270);
equation 
  connect(pv, voltageSensor.p) annotation (points=[0,100; 0,-20; 6.12303e-016,
          -20],
              style(color=3, rgbcolor={0,0,255}));
  connect(voltageSensor.n, nv) annotation (points=[-6.12303e-016,-40;
          -6.12303e-016,-63; 0,-63; 0,-100],
                                           style(color=3, rgbcolor={0,0,255}));
  connect(pc, currentSensor.p) 
    annotation (points=[-100,0; -50,0], style(color=3, rgbcolor={0,0,255}));
  connect(currentSensor.n, nc) 
    annotation (points=[-30,0; 100,0], style(color=3, rgbcolor={0,0,255}));
  connect(currentSensor.i, product.u2) annotation (points=[-40,-10; -40,-30;
        -36,-30; -36,-38], style(color=74, rgbcolor={0,0,127}));
  connect(voltageSensor.v, product.u1) annotation (points=[-10,-30; -24,-30;
        -24,-38], style(color=74, rgbcolor={0,0,127}));
  connect(product.y, power) annotation (points=[-30,-61; -30,-80; -80,-80; -80,
          -110],
               style(color=74, rgbcolor={0,0,127}));
end PowerSensor;
end Sensors;
