package Nonlinear 
  "Discontinuous or non-differentiable algebraic control blocks" 
  
  extends Modelica.Icons.Library;
  
  annotation( Window(
      x=0.05,
      y=0.1,
      width=0.21,
      height=0.23,
      library=1,
      autolayout=1),Documentation(info="<html>
<p>
This package contains <b>discontinuous</b> and
<b>non-differentiable, algebraic</b> input/output blocks.
In particular the following blocks are provided:
</p>

<pre>
   <b>Limiter</b>           Limit the range of a signal to fixed limits.
   <b>VariableLimiter</b>   Limit the range of a signal to variable limits.
   <b>DeadZone</b>          Provide a region of zero output.
</pre>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<br>

<p><b>Release Notes:</b></p>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       New block VariableLimiter added.
<li><i>August 22, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.
</li>
</ul>
<br>


<p><b>Copyright &copy; 1999-2002, Modelica Association and DLR.</b></p>

<p><i>
The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
  block Limiter "Limit the range of a signal" 
    parameter Real uMax[:]={1} "Upper limits of input signals";
    parameter Real uMin[size(uMax, 1)](max=uMax)=  -uMax 
      "Lower limits of input signals";
    extends Interfaces.MIMOs(final n=size(uMax, 1));
    
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.22,
        y=0.06,
        width=0.43,
        height=0.51),
      Documentation(info="<html>
<p>
The Limiter block passes its input signal as output signal
as long as the input is within the specified upper and lower
limits. If this is not the case, the corresponding limit is passed
as output.
</p>
</HTML>
"),   Icon(
        Line(points=[0, -90; 0, 68], style(color=8)),
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8)),
        Line(points=[-90, 0; 68, 0], style(color=8)),
        Polygon(points=[90, 0; 68, -8; 68, 8; 90, 0], style(color=8, fillColor=
                8)),
        Line(points=[-80, -70; -50, -70; 50, 70; 80, 70], style(color=0)),
        Text(
          extent=[-150, -150; 150, -110],
          string="uMax=%uMax",
          style(color=0)),
        Text(extent=[-150, 150; 150, 110], string="%name")),
      Diagram(
        Line(points=[0, -60; 0, 50], style(color=8)),
        Polygon(points=[0, 60; -5, 50; 5, 50; 0, 60], style(color=8, fillColor=
                8)),
        Line(points=[-60, 0; 50, 0], style(color=8)),
        Polygon(points=[60, 0; 50, -5; 50, 5; 60, 0], style(color=8, fillColor=
                8)),
        Line(points=[-50, -40; -30, -40; 30, 40; 50, 40], style(color=0)),
        Text(
          extent=[46, -6; 68, -18],
          string="inPort",
          style(color=10)),
        Text(
          extent=[-30, 70; -5, 50],
          string="outPort",
          style(color=10)),
        Text(
          extent=[-58, -54; -28, -42],
          string="uMin",
          style(color=10)),
        Text(
          extent=[26, 40; 66, 56],
          string="uMax",
          style(color=10))));
  equation 
    for i in 1:n loop
      y[i] = if u[i] > uMax[i] then uMax[i] else if u[i] < uMin[i] then uMin[i] else 
              u[i];
    end for;
  end Limiter;
  
  block VariableLimiter "Limit the range of a signal with variable limits" 
    extends Interfaces.MIMOs;
    
    Interfaces.InPort limit1(final n=n) annotation( extent=[-140, 60; -100, 100]);
    Interfaces.InPort limit2(final n=n) annotation( extent=[-140, -100; -100, -
          60]);
  protected 
    Real uMax[n];
    Real uMin[n];
    
    annotation(
      Documentation(info="<html>
<p>
The Limiter block passes its input signal as output signal
as long as the input is within the upper and lower
limits specified by the two additional inputs limit1 and
limit2. If this is not the case, the corresponding limit
is passed as output.
</p>
</HTML>
"),   Icon(
        Line(points=[0, -90; 0, 68], style(color=8)),
        Line(points=[-90, 0; 68, 0], style(color=8)),
        Polygon(points=[90, 0; 68, -8; 68, 8; 90, 0], style(color=8, fillColor=
                8)),
        Line(points=[-80, -70; -50, -70; 50, 70; 80, 70], style(color=0)),
        Text(extent=[-150, 150; 150, 110], string="%name"),
        Line(points=[-100, 80; 66, 80; 66, 70], style(fillPattern=1)),
        Line(points=[-100, -80; -64, -80; -64, -70], style(fillPattern=1)),
        Polygon(points=[-64, -70; -66, -74; -62, -74; -64, -70], style(
              fillPattern=1)),
        Polygon(points=[66, 70; 64, 74; 68, 74; 66, 70], style(fillPattern=1)),
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8))),
      Diagram(
        Line(points=[0, -60; 0, 50], style(color=8)),
        Polygon(points=[0, 60; -5, 50; 5, 50; 0, 60], style(color=8, fillColor=
                8)),
        Line(points=[-60, 0; 50, 0], style(color=8)),
        Polygon(points=[60, 0; 50, -5; 50, 5; 60, 0], style(color=8, fillColor=
                8)),
        Line(points=[-50, -40; -30, -40; 30, 40; 50, 40], style(color=0)),
        Text(
          extent=[46, -6; 68, -18],
          string="inPort",
          style(color=10)),
        Text(
          extent=[-30, 70; -5, 50],
          string="outPort",
          style(color=10)),
        Text(
          extent=[-66, -40; -26, -20],
          string="uMin",
          style(color=10)),
        Text(
          extent=[30, 20; 70, 40],
          string="uMax",
          style(color=10)),
        Line(points=[-100, 80; 40, 80; 40, 40]),
        Line(points=[-100, -80; -40, -80; -40, -40]),
        Polygon(points=[40, 40; 35, 50; 45, 50; 40, 40], style(fillPattern=1)),
        Polygon(points=[-40, -40; -45, -50; -35, -50; -40, -40], style(
              fillPattern=1))));
  equation 
    for i in 1:n loop
      uMax[i] = max(limit1.signal[i], limit2.signal[i]);
      uMin[i] = min(limit1.signal[i], limit2.signal[i]);
      y[i] = if u[i] > uMax[i] then uMax[i] else if u[i] < uMin[i] then uMin[i] else 
              u[i];
    end for;
  end VariableLimiter;
  
  block DeadZone "Provide a region of zero output" 
    parameter Real uMax[:]={1} "Upper limits of dead zones";
    parameter Real uMin[size(uMax, 1)](max=uMax)=  -uMax 
      "Lower limits of dead zones";
    extends Interfaces.MIMOs(final n=size(uMax, 1));
    
    annotation(
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.39,
        y=0.18,
        width=0.56,
        height=0.6),
      Documentation(info="<html>
<p>
The DeadZone block defines a region of zero output.
</p>

<p>
If the input is within uMin ... uMax, the output
is zero. Outside of this zone, the output is a linear
function of the input with a slope of 1.
</p>
</HTML>
"),   Icon(
        Line(points=[0, -90; 0, 68], style(color=8)),
        Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=
                8)),
        Line(points=[-90, 0; 68, 0], style(color=8)),
        Polygon(points=[90, 0; 68, -8; 68, 8; 90, 0], style(color=8, fillColor=
                8)),
        Line(points=[-80, -60; -20, 0; 20, 0; 80, 60], style(color=0)),
        Text(
          extent=[-150, -150; 150, -110],
          string="uMax=%uMax",
          style(color=9)),
        Text(extent=[-150, 150; 150, 110], string="%name")),
      Diagram(
        Line(points=[0, -60; 0, 50], style(color=8)),
        Polygon(points=[0, 60; -5, 50; 5, 50; 0, 60], style(color=8, fillColor=
                8)),
        Line(points=[-76, 0; 74, 0], style(color=8)),
        Polygon(points=[84, 0; 74, -5; 74, 5; 84, 0], style(color=8, fillColor=
                8)),
        Line(points=[-81, -40; -38, 0; 40, 0; 80, 40], style(color=0)),
        Text(
          extent=[62, -7; 88, -25],
          string="inPort",
          style(color=10)),
        Text(
          extent=[-36, 72; -5, 50],
          string="outPort",
          style(color=10)),
        Text(
          extent=[-51, 1; -28, 19],
          string="uMin",
          style(color=10)),
        Text(
          extent=[27, 21; 52, 5],
          string="uMax",
          style(color=10))));
  equation 
    for i in 1:n loop
      y[i] = if u[i] > uMax[i] then u[i] - uMax[i] else if u[i] < uMin[i] then 
        u[i] - uMin[i] else 0;
    end for;
  end DeadZone;
end Nonlinear;
