package Mechanics "Library for mechanical systems"


extends Modelica.Icons.Library2;


annotation(
  Window(
    x=0.03,
    y=0.05,
    width=0.36,
    height=0.26,
    library=1,
    autolayout=1),
  Icon(
    Rectangle(extent=[-5, -40; 45, -70], style(
        gradient=2,
        fillColor=8,
        fillPattern=1)),
    Ellipse(extent=[-90, -50; -80, -60], style(color=0)),
    Line(points=[-85, -55; -60, -21], style(color=0, thickness=2)),
    Ellipse(extent=[-65, -16; -55, -26], style(color=0)),
    Line(points=[-60, -21; 9, -55], style(color=0, thickness=2)),
    Ellipse(extent=[4, -50; 14, -60], style(
        color=0,
        fillColor=0,
        fillPattern=1)),
    Line(points=[-10, -34; 72, -34; 72, -76; -10, -76], style(color=0))),
  Documentation(info="<HTML>
<p>
This package contains components to model <b>mechanical systems</b>.
Currently, the following subpackages are available:</p>

<pre>
   <b>Rotational</b>     1-dimensional rotational mechanical components.
   <b>Translational</b>  1-dimensional translational mechanical components.
</pre>

<p>
It is planned to add a subpackage for multibody systems to
model 3-dimensional mechanical systems.
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
<li><i>Oct. 27, 2003</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Bearing torque computation added to package <b>Rotational</b>.</li>
<li><i>Oct. 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       New components and examples in package <b>Rotational</b>.</li>
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Changes according to the Twente meeting introduced. Especially,
       package Rotational1D renamed to Rotational and package
       Translational1D renamed to Translational. For the particular
       changes in these packages, see the corresponding package
       release notes.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version for 1-dimensional rotational mechanical
       systems based on an existing Dymola library of Martin Otter and
       Hilding Elmqvist.</li>
</ul>
<br>


<p><b>Copyright &copy; 1999-2003, Modelica Association and DLR.</b></p>

<p><i>
The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>
"));
end Mechanics;
