package Blocks "Library for basic input/output control blocks"
extends Modelica.Icons.Library2;


annotation (
  Coordsys(
    extent=[0, 0; 302, 246], 
    grid=[2, 2], 
    component=[20, 20]), 
  Window(
    x=0.01, 
    y=0.22, 
    width=0.3, 
    height=0.38, 
    library=1, 
    autolayout=1), 
  Icon(
    Rectangle(extent=[-32, -6; 16, -35], style(color=0)), 
    Rectangle(extent=[-32, -56; 16, -85], style(color=0)), 
    Line(points=[16, -20; 49, -20; 49, -71; 16, -71], style(color=0)), 
    Line(points=[-32, -72; -64, -72; -64, -21; -32, -21], style(color=0)), 
    Polygon(points=[16, -71; 29, -67; 29, -74; 16, -71], style(
        color=0, 
        fillColor=0, 
        fillPattern=1)), 
    Polygon(points=[-32, -21; -46, -17; -46, -25; -32, -21], style(
        color=0, 
        fillColor=0, 
        fillPattern=1))), 
  Documentation(info="
<HTML>
<p>
This library contains input/output blocks to build up block diagrams.
The library is structured in the following sublibraries:
</p>

<pre>
  Interfaces    Connectors and partial models for block diagram components
  Continuous    Basic continuous input/output blocks
  Discrete      Discrete control blocks (not yet available)
  Logical       Logical and relational operations on Boolean signals
                (not yet available)
  Nonlinear     Discontinuous or non-differentiable algebraic
                control blocks
  Math          Mathematical functions as input/output blocks
  Sources       Sources such as signal generators
</pre>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a><br>
    Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<br>

<p><b>Release Notes:</b></p>
<ul>
<li><i>Sept. 18, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Renamed to Blocks. New subpackages Math, Nonlinear.
       Additional components in subpackages Interfaces, Continuous
       and Sources. </li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
<br>


<p><b>Copyright (C) 1999, Modelica Design Group and DLR.</b></p>

<p><i>
The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package 
Modelica in file \"Modelica/package.mo\".
</i></p>

</HTML>
"));
end Blocks;
