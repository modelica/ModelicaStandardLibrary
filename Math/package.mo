package Math "Mathematical functions"

import SI = Modelica.SIunits;


extends Modelica.Icons.Library2;


annotation(
    Window(
      x=0.04,
      y=0.05,
      width=0.44,
      height=0.68,
      library=1,
      autolayout=1),
  Invisible=true,
  Icon(Text(
      extent=[-59, -9; 42, -56],
      string="f(x)",
      style(color=0))),
  Documentation(info="<HTML>
<p>
This package contains the following basic mathematical functions:
</p>

<pre>
   <b>sin</b>(u)        sine
   <b>cos</b>(u)        cosine
   <b>tan</b>(u)        tangent     (u shall not be -pi/2, pi/2, 3*pi/2, ...)
   <b>asin</b>(u)       inverse sine    (-1 <= u <= 1)
   <b>acos</b>(u)       inverse cosine  (-1 <= u <= 1)
   <b>atan</b>(u)       inverse tangent
   <b>atan2</b>(u1,u2)  four quadrant inverse tangent
   <b>sinh</b>(u)       hyperbolic sine
   <b>cosh</b>(u)       hyperbolic cosine
   <b>tanh</b>(u)       hyperbolic tangent
   <b>exp</b>(u)        exponential, base e
   <b>log</b>(u)        natural (base e) logarithm (u > 0)
   <b>log10</b>(u)      base 10 logarithm (u > 0)
</pre>

<p>
These functions are used by calling them directly
with a full name (e.g. y = Modelica.Math.asin(0.5)).
</p>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<br>

<p><b>Release Notes:</b></p>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Function tempInterpol2 added.</li>
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Icons for icon and diagram level introduced.</li>

<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
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


partial function baseIcon1 
  "Basic icon for mathematical function with y-axis on left side" 
  annotation( Icon(
      Rectangle(extent=[-100, 100; 100, -100], style(color=0, fillColor=7)),
      Line(points=[-80, -80; -80, 68], style(color=8)),
      Polygon(points=[-80, 90; -88, 68; -72, 68; -80, 90], style(color=8,
            fillColor=8)),
      Text(extent=[-150, 150; 150, 110], string="%name")), Diagram(
      Line(points=[-80, 80; -88, 80], style(color=8)),
      Line(points=[-80, -80; -88, -80], style(color=8)),
      Line(points=[-80, -90; -80, 84], style(color=8)),
      Text(
        extent=[-75, 110; -55, 90],
        string="y",
        style(color=9)),
      Polygon(points=[-80, 100; -86, 84; -74, 84; -80, 100], style(color=8,
            fillColor=8))));
end baseIcon1;


partial function baseIcon2 
  "Basic icon for mathematical function with y-axis in middle" 
  annotation( Icon(
      Rectangle(extent=[-100, 100; 100, -100], style(color=0, fillColor=7)),
      Line(points=[0, -80; 0, 68], style(color=8)),
      Polygon(points=[0, 90; -8, 68; 8, 68; 0, 90], style(color=8, fillColor=8)),
      Text(extent=[-150, 150; 150, 110], string="%name")), Diagram(
      Line(points=[0, 80; -8, 80], style(color=8)),
      Line(points=[0, -80; -8, -80], style(color=8)),
      Line(points=[0, -90; 0, 84], style(color=8)),
      Text(
        extent=[5, 110; 25, 90],
        string="y",
        style(color=9)),
      Polygon(points=[0, 100; -6, 84; 6, 84; 0, 100], style(color=8, fillColor=
              8))));
end baseIcon2;


function sin "sine" 
  extends baseIcon1;
  input SI.Angle u;
  output Real y;
  annotation(
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.02,
      y=0.21,
      width=0.6,
      height=0.6),
    Icon(
      Line(points=[-90, 0; 68, 0], style(color=8)),
      Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=8)),
      Line(points=[-80, 0; -68.7, 34.2; -61.5, 53.1; -55.1, 66.4; -49.4, 74.6;
            -43.8, 79.1; -38.2, 79.8; -32.6, 76.6; -26.9, 69.7; -21.3, 59.4; -
            14.9, 44.1; -6.83, 21.2; 10.1, -30.8; 17.3, -50.2; 23.7, -64.2;
            29.3, -73.1; 35, -78.4; 40.6, -80; 46.2, -77.6; 51.9, -71.5; 57.5,
            -61.9; 63.9, -47.2; 72, -24.8; 80, 0], style(color=0)),
      Text(
        extent=[12, 84; 84, 36],
        string="sin",
        style(color=8))),
    Diagram(
      Line(points=[-100, 0; 84, 0], style(color=8)),
      Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8, fillColor=
              8)),
      Line(points=[-80, 0; -68.7, 34.2; -61.5, 53.1; -55.1, 66.4; -49.4, 74.6;
            -43.8, 79.1; -38.2, 79.8; -32.6, 76.6; -26.9, 69.7; -21.3, 59.4; -
            14.9, 44.1; -6.83, 21.2; 10.1, -30.8; 17.3, -50.2; 23.7, -64.2;
            29.3, -73.1; 35, -78.4; 40.6, -80; 46.2, -77.6; 51.9, -71.5; 57.5,
            -61.9; 63.9, -47.2; 72, -24.8; 80, 0], style(color=0)),
      Text(extent=[-105, 72; -85, 88], string="1"),
      Text(extent=[70, 25; 90, 5], string="2*pi"),
      Text(extent=[-105, -72; -85, -88], string="-1"),
      Text(
        extent=[92, -2; 112, -22],
        string="u",
        style(color=9))));
external "C" y = sin(u);
end sin;


function cos "cosine" 
  extends baseIcon1;
  input SI.Angle u;
  output Real y;
  annotation(
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.28,
      y=0.06,
      width=0.6,
      height=0.6),
    Icon(
      Line(points=[-90, 0; 68, 0], style(color=8)),
      Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=8)),
      Line(points=[-80, 80; -74.4, 78.1; -68.7, 72.3; -63.1, 63; -56.7, 48.7; -
            48.6, 26.6; -29.3, -32.5; -22.1, -51.7; -15.7, -65.3; -10.1, -73.8;
              -4.42, -78.8; 1.21, -79.9; 6.83, -77.1; 12.5, -70.6; 18.1, -60.6;
              24.5, -45.7; 32.6, -23; 50.3, 31.3; 57.5, 50.7; 63.9, 64.6; 69.5,
              73.4; 75.2, 78.6; 80, 80], style(color=0)),
      Text(
        extent=[-36, 82; 36, 34],
        string="cos",
        style(color=8))),
    Diagram(
      Text(extent=[-105, 72; -85, 88], string="1"),
      Text(extent=[-105, -72; -85, -88], string="-1"),
      Text(extent=[70, 25; 90, 5], string="2*pi"),
      Line(points=[-100, 0; 84, 0], style(color=8)),
      Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8, fillColor=
              8)),
      Line(points=[-80, 80; -74.4, 78.1; -68.7, 72.3; -63.1, 63; -56.7, 48.7; -
            48.6, 26.6; -29.3, -32.5; -22.1, -51.7; -15.7, -65.3; -10.1, -73.8;
              -4.42, -78.8; 1.21, -79.9; 6.83, -77.1; 12.5, -70.6; 18.1, -60.6;
              24.5, -45.7; 32.6, -23; 50.3, 31.3; 57.5, 50.7; 63.9, 64.6; 69.5,
              73.4; 75.2, 78.6; 80, 80], style(color=0)),
      Text(
        extent=[92, -2; 112, -22],
        string="u",
        style(color=9))));
external "C" y = cos(u);
end cos;


function tan "tangent (u shall not be -pi/2, pi/2, 3*pi/2, ...)" 
  extends baseIcon2;
  input SI.Angle u;
  output Real y;
  annotation(
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.31,
      y=0.01,
      width=0.6,
      height=0.6),
    Icon(
      Line(points=[-90, 0; 68, 0], style(color=8)),
      Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=8)),
      Line(points=[-80, -80; -78.4, -68.4; -76.8, -59.7; -74.4, -50; -71.2, -
            40.9; -67.1, -33; -60.7, -24.8; -51.1, -17.2; -35.8, -9.98; -4.42,
            -1.07; 33.4, 9.12; 49.4, 16.2; 59.1, 23.2; 65.5, 30.6; 70.4, 39.1;
            73.6, 47.4; 76, 56.1; 77.6, 63.8; 80, 80], style(color=0)),
      Text(
        extent=[-90, 72; -18, 24],
        string="tan",
        style(color=8))),
    Diagram(
      Text(extent=[-37, -72; -17, -88], string="-5.8"),
      Text(extent=[-33, 86; -13, 70], string=" 5.8"),
      Text(extent=[70, 25; 90, 5], string="1.4"),
      Line(points=[-100, 0; 84, 0], style(color=8)),
      Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8, fillColor=
              8)),
      Line(points=[-80, -80; -78.4, -68.4; -76.8, -59.7; -74.4, -50; -71.2, -
            40.9; -67.1, -33; -60.7, -24.8; -51.1, -17.2; -35.8, -9.98; -4.42,
            -1.07; 33.4, 9.12; 49.4, 16.2; 59.1, 23.2; 65.5, 30.6; 70.4, 39.1;
            73.6, 47.4; 76, 56.1; 77.6, 63.8; 80, 80], style(color=0)),
      Text(
        extent=[92, -2; 112, -22],
        string="u",
        style(color=9))));
external "C" y = tan(u);
end tan;


function asin "inverse sine (-1 <= u <= 1)" 
  extends baseIcon2;
  input Real u;
  output SI.Angle y;
  annotation(
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.29,
      y=0.02,
      width=0.6,
      height=0.6),
    Icon(
      Line(points=[-90, 0; 68, 0], style(color=8)),
      Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=8)),
      Line(points=[-80, -80; -79.2, -72.8; -77.6, -67.5; -73.6, -59.4; -66.3, -
            49.8; -53.5, -37.3; -30.2, -19.7; 37.4, 24.8; 57.5, 40.8; 68.7,
            52.7; 75.2, 62.2; 77.6, 67.5; 80, 80], style(color=0)),
      Text(
        extent=[-88, 78; -16, 30],
        string="asin",
        style(color=8))),
    Diagram(
      Text(extent=[-40, -72; -15, -88], string="-pi/2"),
      Text(extent=[-38, 88; -13, 72], string=" pi/2"),
      Text(extent=[70, 25; 90, 5], string="+1"),
      Text(extent=[-90, 21; -70, 1], string="-1"),
      Line(points=[-100, 0; 84, 0], style(color=8)),
      Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8, fillColor=
              8)),
      Line(points=[-80, -80; -79.2, -72.8; -77.6, -67.5; -73.6, -59.4; -66.3, -
            49.8; -53.5, -37.3; -30.2, -19.7; 37.4, 24.8; 57.5, 40.8; 68.7,
            52.7; 75.2, 62.2; 77.6, 67.5; 80, 80], style(color=0)),
      Text(
        extent=[92, -2; 112, -22],
        string="u",
        style(color=9))));
external "C" y = asin(u);
end asin;


function acos "inverse cosine (-1 <= u <= 1)" 
  extends baseIcon2;
  input Real u;
  output SI.Angle y;
  annotation(
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.37,
      y=0.09,
      width=0.6,
      height=0.6),
    Icon(
      Line(points=[-90, -80; 68, -80], style(color=8)),
      Polygon(points=[90, -80; 68, -72; 68, -88; 90, -80], style(color=8,
            fillColor=8)),
      Line(points=[-80, 80; -79.2, 72.8; -77.6, 67.5; -73.6, 59.4; -66.3, 49.8;
              -53.5, 37.3; -30.2, 19.7; 37.4, -24.8; 57.5, -40.8; 68.7, -52.7;
            75.2, -62.2; 77.6, -67.5; 80, -80], style(color=0)),
      Text(
        extent=[-86, -14; -14, -62],
        string="acos",
        style(color=8))),
    Diagram(
      Line(points=[-100, -80; 84, -80], style(color=8)),
      Polygon(points=[100, -80; 84, -74; 84, -86; 100, -80], style(color=8,
            fillColor=8)),
      Line(points=[-80, 80; -79.2, 72.8; -77.6, 67.5; -73.6, 59.4; -66.3, 49.8;
              -53.5, 37.3; -30.2, 19.7; 37.4, -24.8; 57.5, -40.8; 68.7, -52.7;
            75.2, -62.2; 77.6, -67.5; 80, -80], style(color=0)),
      Text(extent=[-30, 88; -5, 72], string=" pi"),
      Text(extent=[-94, -57; -74, -77], string="-1"),
      Text(extent=[80, -45; 100, -65], string="+1"),
      Text(
        extent=[90, -82; 110, -102],
        string="u",
        style(color=9))));
external "C" y = acos(u);
end acos;


function atan "inverse tangent" 
  extends baseIcon2;
  input Real u;
  output SI.Angle y;
  annotation(
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.36,
      y=0.07,
      width=0.6,
      height=0.6),
    Icon(
      Line(points=[-90, 0; 68, 0], style(color=8)),
      Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=8)),
      Line(points=[-80, -80; -52.7, -75.2; -37.4, -69.7; -26.9, -63; -19.7, -
            55.2; -14.1, -45.8; -10.1, -36.4; -6.03, -23.9; -1.21, -5.06; 5.23,
              21; 9.25, 34.1; 13.3, 44.2; 18.1, 52.9; 24.5, 60.8; 33.4, 67.6;
            47, 73.6; 69.5, 78.6; 80, 80], style(color=0)),
      Text(
        extent=[-86, 68; -14, 20],
        string="atan",
        style(color=8))),
    Diagram(
      Line(points=[-100, 0; 84, 0], style(color=8)),
      Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8, fillColor=
              8)),
      Line(points=[-80, -80; -52.7, -75.2; -37.4, -69.7; -26.9, -63; -19.7, -
            55.2; -14.1, -45.8; -10.1, -36.4; -6.03, -23.9; -1.21, -5.06; 5.23,
              21; 9.25, 34.1; 13.3, 44.2; 18.1, 52.9; 24.5, 60.8; 33.4, 67.6;
            47, 73.6; 69.5, 78.6; 80, 80], style(color=0)),
      Text(extent=[-32, 91; -12, 71], string="1.4"),
      Text(extent=[-32, -71; -12, -91], string="-1.4"),
      Text(extent=[73, 26; 93, 10], string=" 5.8"),
      Text(extent=[-103, 20; -83, 4], string="-5.8"),
      Text(
        extent=[92, -2; 112, -22],
        string="u",
        style(color=9))));
external "C" y = atan(u);
end atan;


function atan2 "four quadrant inverse tangent" 
  extends baseIcon2;
  input Real u1;
  input Real u2;
  output SI.Angle y;
  annotation(
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.36,
      y=0.07,
      width=0.6,
      height=0.6),
    Icon(
      Line(points=[-90, 0; 68, 0], style(color=8)),
      Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=8)),
      Line(points=[0, -80; 8.93, -67.2; 17.1, -59.3; 27.3, -53.6; 42.1, -49.4;
            69.9, -45.8; 80, -45.1], style(color=0)),
      Line(points=[-80, -34.9; -46.1, -31.4; -29.4, -27.1; -18.3, -21.5; -10.3,
              -14.5; -2.03, -3.17; 7.97, 11.6; 15.5, 19.4; 24.3, 25; 39, 30;
            62.1, 33.5; 80, 34.9], style(color=0)),
      Line(points=[-80, 45.1; -45.9, 48.7; -29.1, 52.9; -18.1, 58.6; -10.2,
            65.8; -1.82, 77.2; 0, 80], style(color=0)),
      Text(
        extent=[-90, -46; -18, -94],
        string="atan2",
        style(color=8))),
    Diagram(
      Line(points=[-100, 0; 84, 0], style(color=8)),
      Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8, fillColor=
              8)),
      Line(points=[0, -80; 8.93, -67.2; 17.1, -59.3; 27.3, -53.6; 42.1, -49.4;
            69.9, -45.8; 80, -45.1], style(color=0)),
      Line(points=[-80, -34.9; -46.1, -31.4; -29.4, -27.1; -18.3, -21.5; -10.3,
              -14.5; -2.03, -3.17; 7.97, 11.6; 15.5, 19.4; 24.3, 25; 39, 30;
            62.1, 33.5; 80, 34.9], style(color=0)),
      Line(points=[-80, 45.1; -45.9, 48.7; -29.1, 52.9; -18.1, 58.6; -10.2,
            65.8; -1.82, 77.2; 0, 80], style(color=0)),
      Text(extent=[-30, 89; -10, 70], string="pi"),
      Text(extent=[-30, -69; -10, -88], string="-pi"),
      Text(extent=[-30, 49; -10, 30], string="pi/2"),
      Line(points=[0, 40; -8, 40], style(color=8)),
      Line(points=[0, -40; -8, -40], style(color=8)),
      Text(extent=[-30, -31; -10, -50], string="-pi/2"),
      Text(
        extent=[92, -2; 112, -22],
        string="u",
        style(color=9))),
    Documentation(info="<HTML>
y = atan2(u1,u2) computes y such that tan(y) = u1/u2 and
y is in the range -pi < y < pi. u2 may be zero, provided
u1 is not zero.
</HTML>
"));
external "C" y = atan2(u1, u2);
end atan2;


function sinh "hyperbolic sine" 
  extends baseIcon2;
  input Real u;
  output Real y;
  annotation(
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.36,
      y=0.07,
      width=0.6,
      height=0.6),
    Icon(
      Line(points=[-90, 0; 68, 0], style(color=8)),
      Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=8)),
      Line(points=[-80, -80; -76, -65.4; -71.2, -51.4; -65.5, -38.8; -59.1, -
            28.1; -51.1, -18.7; -41.4, -11.4; -27.7, -5.5; -4.42, -0.653; 24.5,
              4.57; 39, 10.1; 49.4, 17.2; 57.5, 25.9; 63.9, 35.8; 69.5, 47.4;
            74.4, 60.4; 78.4, 73.8; 80, 80], style(color=0)),
      Text(
        extent=[-88, 80; -16, 32],
        string="sinh",
        style(color=8))),
    Diagram(
      Line(points=[-100, 0; 84, 0], style(color=8)),
      Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8, fillColor=
              8)),
      Line(points=[-80, -80; -76, -65.4; -71.2, -51.4; -65.5, -38.8; -59.1, -
            28.1; -51.1, -18.7; -41.4, -11.4; -27.7, -5.5; -4.42, -0.653; 24.5,
              4.57; 39, 10.1; 49.4, 17.2; 57.5, 25.9; 63.9, 35.8; 69.5, 47.4;
            74.4, 60.4; 78.4, 73.8; 80, 80], style(color=0)),
      Text(extent=[-31, 72; -11, 88], string="27"),
      Text(extent=[-35, -88; -15, -72], string="-27"),
      Text(extent=[70, 25; 90, 5], string="4"),
      Text(extent=[-98, 21; -78, 1], string="-4"),
      Text(
        extent=[92, -2; 112, -22],
        string="u",
        style(color=9))));
external "C" y = sinh(u);
end sinh;


function cosh "hyperbolic cosine" 
  extends baseIcon2;
  input Real u;
  output Real y;
  annotation(
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.4,
      y=0.05,
      width=0.6,
      height=0.6),
    Icon(
      Line(points=[-90, -86.083; 68, -86.083], style(color=8)),
      Polygon(points=[90, -86.083; 68, -78.083; 68, -94.083; 90, -86.083],
          style(color=8, fillColor=8)),
      Line(points=[-80, 80; -77.6, 61.1; -74.4, 39.3; -71.2, 20.7; -67.1, 1.29;
              -63.1, -14.6; -58.3, -29.8; -52.7, -43.5; -46.2, -55.1; -39, -
            64.3; -30.2, -71.7; -18.9, -77.1; -4.42, -79.9; 10.9, -79.1; 23.7,
            -75.2; 34.2, -68.7; 42.2, -60.6; 48.6, -51.2; 54.3, -40; 59.1, -
            27.5; 63.1, -14.6; 67.1, 1.29; 71.2, 20.7; 74.4, 39.3; 77.6, 61.1;
            80, 80], style(color=0)),
      Text(
        extent=[4, 66; 66, 20],
        string="cosh",
        style(color=8))),
    Diagram(
      Line(points=[-100, -86.083; 84, -86.083], style(color=8)),
      Polygon(points=[100, -86.083; 84, -80.083; 84, -92.083; 100, -86.083],
          style(color=8, fillColor=8)),
      Line(points=[-80, 80; -77.6, 61.1; -74.4, 39.3; -71.2, 20.7; -67.1, 1.29;
              -63.1, -14.6; -58.3, -29.8; -52.7, -43.5; -46.2, -55.1; -39, -
            64.3; -30.2, -71.7; -18.9, -77.1; -4.42, -79.9; 10.9, -79.1; 23.7,
            -75.2; 34.2, -68.7; 42.2, -60.6; 48.6, -51.2; 54.3, -40; 59.1, -
            27.5; 63.1, -14.6; 67.1, 1.29; 71.2, 20.7; 74.4, 39.3; 77.6, 61.1;
            80, 80], style(color=0)),
      Text(extent=[-31, 72; -11, 88], string="27"),
      Text(extent=[76, -61; 96, -81], string="4"),
      Text(extent=[-104, -63; -84, -83], string="-4"),
      Text(
        extent=[90, -88; 110, -108],
        string="u",
        style(color=9))));
external "C" y = cosh(u);
end cosh;


function tanh "hyperbolic tangent" 
  extends baseIcon2;
  input Real u;
  output Real y;
  annotation(
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.36,
      y=0.07,
      width=0.6,
      height=0.6),
    Icon(
      Line(points=[-90, 0; 68, 0], style(color=8)),
      Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=8)),
      Line(points=[-80, -80; -47.8, -78.7; -35.8, -75.7; -27.7, -70.6; -22.1, -
            64.2; -17.3, -55.9; -12.5, -44.3; -7.64, -29.2; -1.21, -4.82; 6.83,
              26.3; 11.7, 42; 16.5, 54.2; 21.3, 63.1; 26.9, 69.9; 34.2, 75;
            45.4, 78.4; 72, 79.9; 80, 80], style(color=0)),
      Text(
        extent=[-88, 72; -16, 24],
        string="tanh",
        style(color=8))),
    Diagram(
      Line(points=[-100, 0; 84, 0], style(color=8)),
      Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8, fillColor=
              8)),
      Line(points=[-80, -80; -47.8, -78.7; -35.8, -75.7; -27.7, -70.6; -22.1, -
            64.2; -17.3, -55.9; -12.5, -44.3; -7.64, -29.2; -1.21, -4.82; 6.83,
              26.3; 11.7, 42; 16.5, 54.2; 21.3, 63.1; 26.9, 69.9; 34.2, 75;
            45.4, 78.4; 72, 79.9; 80, 80], style(color=0)),
      Text(extent=[70, 25; 90, 5], string="4"),
      Text(extent=[-106, 21; -86, 1], string="-4"),
      Text(extent=[-29, 72; -9, 88], string="1"),
      Text(extent=[3, -72; 23, -88], string="-1"),
      Text(
        extent=[92, -2; 112, -22],
        string="u",
        style(color=9))));
external "C" y = tanh(u);
end tanh;


function exp "exponential, base e" 
  extends baseIcon2;
  input Real u;
  output Real y;
  annotation(
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.36,
      y=0.07,
      width=0.6,
      height=0.6),
    Icon(
      Line(points=[-90, -80.3976; 68, -80.3976], style(color=8)),
      Polygon(points=[90, -80.3976; 68, -72.3976; 68, -88.3976; 90, -80.3976],
          style(color=8, fillColor=8)),
      Line(points=[-80, -80; -31, -77.9; -6.03, -74; 10.9, -68.4; 23.7, -61;
            34.2, -51.6; 43, -40.3; 50.3, -27.8; 56.7, -13.5; 62.3, 2.23; 67.1,
              18.6; 72, 38.2; 76, 57.6; 80, 80], style(color=0)),
      Text(
        extent=[-86, 50; -14, 2],
        string="exp",
        style(color=8))),
    Diagram(
      Line(points=[-100, -80.3976; 84, -80.3976], style(color=8)),
      Polygon(points=[100, -80.3976; 84, -74.3976; 84, -86.3976; 100, -80.3976],
            style(color=8, fillColor=8)),
      Line(points=[-80, -80; -31, -77.9; -6.03, -74; 10.9, -68.4; 23.7, -61;
            34.2, -51.6; 43, -40.3; 50.3, -27.8; 56.7, -13.5; 62.3, 2.23; 67.1,
              18.6; 72, 38.2; 76, 57.6; 80, 80], style(color=0)),
      Text(extent=[-31, 72; -11, 88], string="20"),
      Text(extent=[-92, -83; -72, -103], string="-3"),
      Text(extent=[70, -83; 90, -103], string="3"),
      Text(extent=[-18, -53; 2, -73], string="1"),
      Text(
        extent=[96, -82; 116, -102],
        string="u",
        style(color=9))));
external "C" y = exp(u);
end exp;


function log "natural (base e) logarithm (u shall be > 0)" 
  extends baseIcon1;
  input Real u;
  output Real y;
  annotation(
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.36,
      y=0.07,
      width=0.6,
      height=0.6),
    Icon(
      Line(points=[-90, 0; 68, 0], style(color=8)),
      Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=8)),
      Line(points=[-80, -80; -79.2, -50.6; -78.4, -37; -77.6, -28; -76.8, -21.3;
              -75.2, -11.4; -72.8, -1.31; -69.5, 8.08; -64.7, 17.9; -57.5, 28;
            -47, 38.1; -31.8, 48.1; -10.1, 58; 22.1, 68; 68.7, 78.1; 80, 80],
          style(color=0)),
      Text(
        extent=[-6, -24; 66, -72],
        string="log",
        style(color=8))),
    Diagram(
      Line(points=[-100, 0; 84, 0], style(color=8)),
      Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8, fillColor=
              8)),
      Line(points=[-80, -80; -79.2, -50.6; -78.4, -37; -77.6, -28; -76.8, -21.3;
              -75.2, -11.4; -72.8, -1.31; -69.5, 8.08; -64.7, 17.9; -57.5, 28;
            -47, 38.1; -31.8, 48.1; -10.1, 58; 22.1, 68; 68.7, 78.1; 80, 80],
          style(color=0)),
      Text(extent=[-105, 72; -85, 88], string="3"),
      Text(extent=[-109, -88; -89, -72], string="-3"),
      Text(extent=[70, -3; 90, -23], string="20"),
      Text(extent=[-78, -1; -58, -21], string="1"),
      Text(
        extent=[92, -2; 112, -22],
        string="u",
        style(color=9))));
external "C" y = log(u);
end log;


function log10 "base 10 logarithm (u shall be > 0)" 
  extends baseIcon1;
  input Real u;
  output Real y;
  annotation(
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.36,
      y=0.07,
      width=0.6,
      height=0.6),
    Icon(
      Line(points=[-90, 0; 68, 0], style(color=8)),
      Polygon(points=[90, 0; 68, 8; 68, -8; 90, 0], style(color=8, fillColor=8)),
      Line(points=[-79.8, -80; -79.2, -50.6; -78.4, -37; -77.6, -28; -76.8, -
            21.3; -75.2, -11.4; -72.8, -1.31; -69.5, 8.08; -64.7, 17.9; -57.5,
            28; -47, 38.1; -31.8, 48.1; -10.1, 58; 22.1, 68; 68.7, 78.1; 80, 80],
               style(color=0)),
      Text(
        extent=[-30, -22; 60, -70],
        string="log10",
        style(color=8))),
    Diagram(
      Line(points=[-100, 0; 84, 0], style(color=8)),
      Polygon(points=[100, 0; 84, 6; 84, -6; 100, 0], style(color=8, fillColor=
              8)),
      Line(points=[-79.8, -80; -79.2, -50.6; -78.4, -37; -77.6, -28; -76.8, -
            21.3; -75.2, -11.4; -72.8, -1.31; -69.5, 8.08; -64.7, 17.9; -57.5,
            28; -47, 38.1; -31.8, 48.1; -10.1, 58; 22.1, 68; 68.7, 78.1; 80, 80],
               style(color=0)),
      Text(extent=[70, -3; 90, -23], string="20"),
      Text(extent=[-78, -1; -58, -21], string="1"),
      Text(extent=[-109, 72; -89, 88], string=" 1.3"),
      Text(extent=[-109, -88; -89, -72], string="-1.3"),
      Text(
        extent=[92, -2; 112, -22],
        string="u",
        style(color=9))));
external "C" y = log10(u);
end log10;


function tempInterpol1 
  "temporary routine for linear interpolation (will be removed)" 
  input Real u "input value (first column of table)";
  input Real table[:, :] "table to be interpolated";
  input Integer icol "column of table to be interpolated";
  output Real y "interpolated input value (icol column of table)";
protected 
  Integer i;
  Integer n "number of rows of table";
  Real u1;
  Real u2;
  Real y1;
  Real y2;
algorithm 
  n := size(table, 1);
  if n <= 1 then
    y := table[1, icol];
  else
    // Search interval
    if u <= table[1, 1] then
      i := 1;
    else
      i := 2;
      // Supports duplicate table[i, 1] values
      // in the interior to allow discontinuities.
      // Interior means that
      // if table[i, 1] = table[i+1, 1] we require i>1 and i+1<n
      while i < n and u >= table[i, 1] loop
        i := i + 1;
      end while;
      i := i - 1;
    end if;
    
    // Get interpolation data
    u1 := table[i, 1];
    u2 := table[i + 1, 1];
    y1 := table[i, icol];
    y2 := table[i + 1, icol];
    
    assert(u2 > u1, "Table index must be increasing");
    // Interpolate
    y := y1 + (y2 - y1)*(u - u1)/(u2 - u1);
  end if;
end tempInterpol1;


function tempInterpol2 
  "temporary routine for vectorized linear interpolation (will be removed)" 
  input Real u "input value (first column of table)";
  input Real table[:, :] "table to be interpolated";
  input Integer icol[:] "column(s) of table to be interpolated";
  output Real y[1, size(icol, 1)] 
    "interpolated input value(s) (column(s) icol of table)";
protected 
  Integer i;
  Integer n "number of rows of table";
  Real u1;
  Real u2;
  Real y1[1, size(icol, 1)];
  Real y2[1, size(icol, 1)];
algorithm 
  n := size(table, 1);
  if n <= 1 then
    y := transpose([table[1, icol]]);
  else
    // Search interval
    if u <= table[1, 1] then
      i := 1;
    else
      i := 2;
      // Supports duplicate table[i, 1] values
      // in the interior to allow discontinuities.
      // Interior means that
      // if table[i, 1] = table[i+1, 1] we require i>1 and i+1<n
      while i < n and u >= table[i, 1] loop
        i := i + 1;
      end while;
      i := i - 1;
    end if;
    
    // Get interpolation data
    u1 := table[i, 1];
    u2 := table[i + 1, 1];
    y1 := transpose([table[i, icol]]);
    y2 := transpose([table[i + 1, icol]]);
    
    assert(u2 > u1, "Table index must be increasing");
    // Interpolate
    y := y1 + (y2 - y1)*(u - u1)/(u2 - u1);
  end if;
end tempInterpol2;
end Math;
