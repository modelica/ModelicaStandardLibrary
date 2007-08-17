within Modelica;
package Mechanics "Library of 1-dim. and 3-dim. mechanical components (multi-body, rotational, translational)"
extends Modelica.Icons.Library2;

annotation(preferedView="info",
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
This package contains components to model the movement
of 1-dim. rotational, 1-dim. translational, and
3-dim. <b>mechanical systems</b>.
</p>
</HTML>
", revisions="<html>
<ul>
<li><i>June 23, 2004</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       included the Mechanics.MultiBody library 1.0 and adapted it to the new
       Blocks connectors.</li>
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
</html>"));
end Mechanics;
