package Icons "Icon definitions" 
  
  annotation (
    Coordsys(
      extent=[0, 0; 606, 355], 
      grid=[2, 2], 
      component=[20, 20]), 
    Window(
      x=0.17, 
      y=0.09, 
      width=0.6, 
      height=0.6, 
      library=1, 
      autolayout=1), 
    Icon(
      Rectangle(extent=[-100, -100; 80, 50], style(fillColor=30, fillPattern=1
          )), 
      Polygon(points=[-100, 50; -80, 70; 100, 70; 80, 50; -100, 50], style(
            fillColor=30, fillPattern=1)), 
      Polygon(points=[100, 70; 100, -80; 80, -100; 80, 50; 100, 70], style(
            fillColor=30, fillPattern=1)), 
      Text(
        extent=[-120, 135; 120, 70], 
        string="%name", 
        style(color=1)), 
      Text(
        extent=[-90, 40; 70, 10], 
        string="Library", 
        style(
          color=9, 
          fillColor=0, 
          fillPattern=1)), 
      Rectangle(extent=[-100, -100; 80, 50], style(fillColor=30, fillPattern=1
          )), 
      Polygon(points=[-100, 50; -80, 70; 100, 70; 80, 50; -100, 50], style(
            fillColor=30, fillPattern=1)), 
      Polygon(points=[100, 70; 100, -80; 80, -100; 80, 50; 100, 70], style(
            fillColor=30, fillPattern=1)), 
      Text(
        extent=[-90, 40; 70, 10], 
        string="Library", 
        style(
          color=9, 
          fillColor=0, 
          fillPattern=1)), 
      Polygon(points=[-64, -20; -50, -4; 50, -4; 36, -20; -64, -20; -64, -20]
          , style(
          color=0, 
          fillColor=8, 
          fillPattern=1)), 
      Rectangle(extent=[-64, -20; 36, -84], style(
          color=0, 
          fillColor=8, 
          fillPattern=1)), 
      Text(
        extent=[-60, -24; 32, -38], 
        string="Library", 
        style(
          color=10, 
          fillColor=10, 
          fillPattern=1)), 
      Polygon(points=[50, -4; 50, -70; 36, -84; 36, -20; 50, -4], style(
          color=0, 
          fillColor=8, 
          fillPattern=1))), 
    Documentation(info="
<HTML>
<p>
This package contains definitions for the graphical layout of
components which may be used in different libraries.
The icons can be utilized by inheriting them in the desired class
using \"extends\".
</p>


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
       Renaming package Icon to Icons.
       Model Advanced removed (icon not accepted on the Modelica meeting).
       New model Library2, which is the Library icon with enough place
       to add library specific elements in the icon. Icon also used in diagram
       level for models Info, TranslationalSensor, RotationalSensor.</li>
<li><i>July 15, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Model Caution renamed to Advanced, model Sensor renamed to 
       TranslationalSensor, new model RotationalSensor.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.op.dlr.de/~otter/\">Martin Otter</a>:<br>
       Realized a first version.</li>
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
  model Info "Icon for an information class" annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[-100, 80; 80, -90], style(color=3)), 
        Polygon(points=[-100, 80; -90, 90; 90, 90; 80, 80; -100, 80], style(
              fillColor=3)), 
        Polygon(points=[80, -90; 90, -80; 90, 90; 80, 80; 80, -90], style(
              fillColor=3)), 
        Text(extent=[-80, 70; 60, -70], string="Info")), 
      Diagram(
        Rectangle(extent=[-100, 80; 80, -90], style(color=3)), 
        Polygon(points=[-100, 80; -90, 90; 90, 90; 80, 80; -100, 80], style(
              fillColor=3)), 
        Polygon(points=[80, -90; 90, -80; 90, 90; 80, 80; 80, -90], style(
              fillColor=3)), 
        Text(extent=[-80, 70; 60, -70], string="Info")));  end Info;
  model Library "Icon for library" annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.33, 
        y=0.34, 
        width=0.6, 
        height=0.55), 
      Icon(
        Rectangle(extent=[-100, -100; 80, 50], style(fillColor=30, fillPattern
              =1)), 
        Polygon(points=[-100, 50; -80, 70; 100, 70; 80, 50; -100, 50], style(
              fillColor=30, fillPattern=1)), 
        Polygon(points=[100, 70; 100, -80; 80, -100; 80, 50; 100, 70], style(
              fillColor=30, fillPattern=1)), 
        Text(
          extent=[-85, 35; 65, -85], 
          string="Library", 
          style(color=3)), 
        Text(
          extent=[-120, 135; 120, 70], 
          string="%name", 
          style(color=1))));  end Library;
  model Library2 
    "Icon for library where additional icon elements shall be added" 
      annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.29, 
        y=0.29, 
        width=0.6, 
        height=0.6), 
      Icon(
        Rectangle(extent=[-100, -100; 80, 50], style(fillColor=30, fillPattern
              =1)), 
        Polygon(points=[-100, 50; -80, 70; 100, 70; 80, 50; -100, 50], style(
              fillColor=30, fillPattern=1)), 
        Polygon(points=[100, 70; 100, -80; 80, -100; 80, 50; 100, 70], style(
              fillColor=30, fillPattern=1)), 
        Text(
          extent=[-120, 135; 120, 70], 
          string="%name", 
          style(color=1)), 
        Text(
          extent=[-90, 40; 70, 10], 
          string="Library", 
          style(
            color=9, 
            fillColor=0, 
            fillPattern=1))));  end Library2;
  model Example "Icon for an example model" annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.35, 
        y=0.28, 
        width=0.6, 
        height=0.6), 
      Icon(
        Rectangle(extent=[-100, -100; 80, 50]), 
        Polygon(points=[-100, 50; -80, 70; 100, 70; 80, 50; -100, 50]), 
        Polygon(points=[100, 70; 100, -80; 80, -100; 80, 50; 100, 70]), 
        Text(
          extent=[-84, 34; 64, -84], 
          string="Example", 
          style(color=3)), 
        Text(
          extent=[-120, 135; 120, 70], 
          string="%name", 
          style(color=1))));  end Example;
  model TranslationalSensor 
    "Icon representing translational measurement device" annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Rectangle(extent=[-70, -60; 70, 20], style(color=0, fillColor=7)), 
        Polygon(points=[0, -40; -10, -16; 10, -16; 0, -40], style(
            color=0, 
            fillColor=0, 
            fillPattern=1)), 
        Line(points=[0, 0; 0, -16], style(color=0)), 
        Line(points=[-70, 0; 0, 0], style(color=0)), 
        Line(points=[-50, -40; -50, -60], style(color=0)), 
        Line(points=[-30, -40; -30, -60], style(color=0)), 
        Line(points=[-10, -40; -10, -60], style(color=0)), 
        Line(points=[10, -40; 10, -60], style(color=0)), 
        Line(points=[30, -40; 30, -60], style(color=0)), 
        Line(points=[50, -40; 50, -60], style(color=0))), 
      Diagram(
        Rectangle(extent=[-70, -60; 70, 20], style(color=0, fillColor=7)), 
        Polygon(points=[0, -40; -10, -16; 10, -16; 0, -40], style(
            color=0, 
            fillColor=0, 
            fillPattern=1)), 
        Line(points=[0, 0; 0, -16], style(color=0)), 
        Line(points=[-70, 0; 0, 0], style(color=0)), 
        Line(points=[-50, -40; -50, -60], style(color=0)), 
        Line(points=[-30, -40; -30, -60], style(color=0)), 
        Line(points=[-10, -40; -10, -60], style(color=0)), 
        Line(points=[10, -40; 10, -60], style(color=0)), 
        Line(points=[30, -40; 30, -60], style(color=0)), 
        Line(points=[50, -40; 50, -60], style(color=0))));  end 
    TranslationalSensor;
  model RotationalSensor "Icon representing rotational measurement device" 
      annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Icon(
        Ellipse(extent=[-70, 70; 70, -70], style(color=0, fillColor=7)), 
        Line(points=[0, 70; 0, 40], style(color=0)), 
        Line(points=[22.9, 32.8; 40.2, 57.3], style(color=0)), 
        Line(points=[-22.9, 32.8; -40.2, 57.3], style(color=0)), 
        Line(points=[37.6, 13.7; 65.8, 23.9], style(color=0)), 
        Line(points=[-37.6, 13.7; -65.8, 23.9], style(color=0)), 
        Line(points=[0, 0; 9.02, 28.6], style(color=0)), 
        Polygon(points=[-0.48, 31.6; 18, 26; 18, 57.2; -0.48, 31.6], style(
            color=0, 
            fillColor=0, 
            fillPattern=1)), 
        Ellipse(extent=[-5, 5; 5, -5], style(
            color=0, 
            gradient=0, 
            fillColor=0, 
            fillPattern=1))), 
      Diagram(
        Ellipse(extent=[-70, 70; 70, -70], style(color=0, fillColor=7)), 
        Line(points=[0, 70; 0, 40], style(color=0)), 
        Line(points=[22.9, 32.8; 40.2, 57.3], style(color=0)), 
        Line(points=[-22.9, 32.8; -40.2, 57.3], style(color=0)), 
        Line(points=[37.6, 13.7; 65.8, 23.9], style(color=0)), 
        Line(points=[-37.6, 13.7; -65.8, 23.9], style(color=0)), 
        Line(points=[0, 0; 9.02, 28.6], style(color=0)), 
        Polygon(points=[-0.48, 31.6; 18, 26; 18, 57.2; -0.48, 31.6], style(
            color=0, 
            fillColor=0, 
            fillPattern=1)), 
        Ellipse(extent=[-5, 5; 5, -5], style(
            color=0, 
            gradient=0, 
            fillColor=0, 
            fillPattern=1))));  end RotationalSensor;
end Icons;
