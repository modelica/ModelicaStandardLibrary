package Sensors 
  
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
        Line(points=[100,0; 70,0])));
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
        Line(points=[0,-90; 0,-70])));
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
        Line(points=[0,-90; 0,-70])));
  equation 
    p.v = n.v;
    p.i = i;
    n.i = -i;
  end CurrentSensor;
  
end Sensors;
