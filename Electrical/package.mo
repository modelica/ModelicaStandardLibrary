package Electrical "Library for electrical models"
extends Modelica.Icons.Library2;

annotation (
  Documentation(info="
<HTML>
<p>
This library contains electrical components to build up analog and digital circuits.
The library is currently structured in the following sublibraries:
</p>
<ul>
<li>Analog</li>
<li>Digital (not available yet)</li>
</ul>
<p>
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
"), 
  Coordsys(
    extent=[0, 0; 120, 175], 
    grid=[2, 2], 
    component=[20, 20]), 
  Window(
    x=0.03, 
    y=0.03, 
    width=0.13, 
    height=0.29, 
    library=1, 
    autolayout=1), 
  Icon(
    Rectangle(extent=[-29, -13; 3, -27], style(color=0)), 
    Line(points=[37, -58; 62, -58], style(color=0)), 
    Line(points=[36, -49; 61, -49], style(color=0)), 
    Line(points=[-78, -50; -43, -50], style(color=0)), 
    Line(points=[-67, -55; -55, -55], style(color=0)), 
    Line(points=[-61, -50; -61, -20; -29, -20], style(color=0)), 
    Line(points=[3, -20; 48, -20; 48, -49], style(color=0)), 
    Line(points=[48, -58; 48, -78; -61, -78; -61, -55], style(color=0))));
end Electrical;
