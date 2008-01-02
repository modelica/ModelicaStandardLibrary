package Electrical "Library for electrical models"
extends Modelica.Icons.Library2;

annotation(preferedView="info",
  Documentation(info="<html>
<p>
This library contains electrical components to build up analog and digital circuits.
The library is currently structured in the following sublibraries:
</p>
<ul>
<li>Package <b>Analog</b> for basic analog electrical components.</li>
<li>Package <b>Digital</b> for 2-, 3-, 4-, and 9-value logic of digital circuits.</li>
<li>Package <b>MultiPhase</b> for electrical
    components with 2, 3 or more phases.</li>
<li>Package <b>Machines</b> to model electrical motors and generators,
    especially three phase induction machines such as an
    asynchronous motor.</li>
</ul>
<p>
</HTML>
"),Window(
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
