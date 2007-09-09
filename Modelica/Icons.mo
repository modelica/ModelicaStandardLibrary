within Modelica;
package Icons "Library of icons" 
  
  annotation(preferedView="info",
    Window(
      x=0.08,
      y=0.08,
      width=0.28,
      height=0.51,
      library=1,
      autolayout=1),
    Icon(
      Rectangle(extent=[-100, -100; 80, 50], style(fillColor=30, fillPattern=1)),
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
      Rectangle(extent=[-100, -100; 80, 50], style(fillColor=30, fillPattern=1)),
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
      Polygon(points=[-64, -20; -50, -4; 50, -4; 36, -20; -64, -20; -64, -20],
          style(
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
          fillPattern=1))), Documentation(info="<html>
<p>
This package contains definitions for the graphical layout of
components which may be used in different libraries.
The icons can be utilized by inheriting them in the desired class
using \"extends\" or by directly copying the \"icon\" layer.
</p>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>

<p>
Copyright &copy; 1998-2007, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p><br>
</HTML>
", revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Added new icons <b>Function</b>, <b>Enumerations</b> and <b>Record</b>.</li>
<li><i>June 6, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Replaced <b>model</b> keyword by <b>package</b> if the main
       usage is for inheriting from a package.<br>
       New icons <b>GearIcon</b> and <b>MotorIcon</b>.</li>
<li><i>Sept. 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Renaming package Icon to Icons.
       Model Advanced removed (icon not accepted on the Modelica meeting).
       New model Library2, which is the Library icon with enough place
       to add library specific elements in the icon. Icon also used in diagram
       level for models Info, TranslationalSensor, RotationalSensor.</li>
<li><i>July 15, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Model Caution renamed to Advanced, model Sensor renamed to
       TranslationalSensor, new model RotationalSensor.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version.</li>
</ul>
<br>
</html>"));
  partial model Info "Icon for an information class" 
    
    annotation (
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
        Text(extent=[-80, 70; 60, -70], string="Info")),
      Documentation(info="<html>
<p>
This icon is designed for an <b>information</b> class.
</p>
</html>"));
  equation 
    
  end Info;
  
  partial package Library "Icon for library" 
    
    annotation (Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]), Icon(
        Rectangle(extent=[-100, -100; 80, 50], style(fillColor=30,
              fillPattern=
                1)),
        Polygon(points=[-100, 50; -80, 70; 100, 70; 80, 50; -100, 50], style(
              fillColor=30, fillPattern=1)),
        Polygon(points=[100, 70; 100, -80; 80, -100; 80, 50; 100, 70], style(
              fillColor=30, fillPattern=1)),
        Text(
          extent=[-85, 35; 65, -85],
          string="Library",
          style(color=3)),
        Text(
          extent=[-120, 122; 120, 73],
          string="%name",
          style(color=1))),
      Documentation(info="<html>
<p>
This icon is designed for a <b>library</b>.
</p>
</html>"));
  end Library;
  
  partial package Library2 
    "Icon for library where additional icon elements shall be added" 
    
    annotation (Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]), Icon(
        Rectangle(extent=[-100, -100; 80, 50], style(fillColor=30,
              fillPattern=
                1)),
        Polygon(points=[-100, 50; -80, 70; 100, 70; 80, 50; -100, 50], style(
              fillColor=30, fillPattern=1)),
        Polygon(points=[100, 70; 100, -80; 80, -100; 80, 50; 100, 70], style(
              fillColor=30, fillPattern=1)),
        Text(
          extent=[-120, 125; 120, 70],
          string="%name",
          style(color=1)),
        Text(
          extent=[-90, 40; 70, 10],
          string="Library",
          style(
            color=9,
            fillColor=0,
            fillPattern=1))),
      Documentation(info="<html>
<p>
This icon is designed for a <b>package</b> where a package
specific graphic is additionally included in the icon.
</p>
</html>"));
  end Library2;
  
  partial model Example "Icon for an example model" 
    
    annotation (Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]), Icon(
        Rectangle(extent=[-100, -100; 80, 50], style(fillColor=7)),
        Polygon(points=[-100, 50; -80, 70; 100, 70; 80, 50; -100, 50], style(
              fillColor=7)),
        Polygon(points=[100, 70; 100, -80; 80, -100; 80, 50; 100, 70], style(
              fillColor=7)),
        Text(
          extent=[-96, 3; 77, -49],
          string="Example",
          style(color=3)),
        Text(
          extent=[-120, 132; 120, 73],
          string="%name",
          style(color=1))),
      Documentation(info="<html>
<p>
This icon is designed for an <b>Example package</b>,
i.e. a package containing executable demo models.
</p>
</html>"));
  equation 
    
  end Example;
  
  partial function Function "Icon for a function" 
    
    annotation (Icon(
        Text(extent=[-140,162; 136,102],  string="%name"),
        Ellipse(extent=[-100,100; 100,-100],  style(color=45, fillColor=7)),
        Text(
          extent=[-100,100; 100,-100],
          style(color=45),
          string="f")), Documentation(info="<html>
<p>
This icon is designed for a <b>function</b>
</p>
</html>"));
  end Function;
  
  partial record Record "Icon for a record" 
    
    annotation (Icon(
        Rectangle(extent=[-100, 50; 100, -100], style(fillColor=51,
              fillPattern=
               1)),
        Text(extent=[-127, 115; 127, 55], string="%name"),
        Line(points=[-100, -50; 100, -50], style(color=0)),
        Line(points=[-100, 0; 100, 0], style(color=0)),
        Line(points=[0, 50; 0, -100], style(color=0))), Documentation(info="<html>
<p>
This icon is designed for a <b>record</b>
</p>
</html>"));
  end Record;
  
  partial class Enumeration "Icon for an enumeration (emulated by a package)" 
    
    annotation (Icon(
        Text(extent=[-138,164; 138,104],  string="%name"),
        Ellipse(extent=[-100,100; 100,-100],  style(color=85, fillColor=7)),
        Text(
          extent=[-100,100; 100,-100],
          style(color=85, fillColor=88),
          string="e")), Documentation(info="<html>
<p>
This icon is designed for an <b>enumeration</b>
(that is emulated by a package).
</p>
</html>"));
  end Enumeration;
  
  type TypeReal "Icon for a Real type" 
      extends Real;
      annotation(Icon(Rectangle(extent=[-100,100; 100,-100], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=8,
            rgbfillColor={181,181,181})), Text(
          extent=[-94,94; 94,-94],
          style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=8,
            rgbfillColor={181,181,181}),
          string="R")), Documentation(info="<html>
<p>
This icon is designed for a <b>Real</b> type.
</p>
</html>"));
  end TypeReal;
  
  type TypeInteger "Icon for an Integer type" 
      extends Integer;
      annotation(Icon(Rectangle(extent=[-100,100; 100,-100], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=8,
            rgbfillColor={181,181,181})), Text(
          extent=[-94,94; 94,-94],
          style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=8,
            rgbfillColor={181,181,181}),
          string="I")), Documentation(info="<html>
<p>
This icon is designed for an <b>Integer</b> type.
</p>
</html>"));
  end TypeInteger;
  
  type TypeBoolean "Icon for a Boolean type" 
      extends Boolean;
      annotation(Icon(Rectangle(extent=[-100,100; 100,-100], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=8,
            rgbfillColor={181,181,181})), Text(
          extent=[-94,94; 94,-94],
          style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=8,
            rgbfillColor={181,181,181}),
          string="B")), Documentation(info="<html>
<p>
This icon is designed for a <b>Boolean</b> type.
</p>
</html>"));
  end TypeBoolean;
  
  type TypeString "Icon for a String type" 
      extends String;
      annotation(Icon(Rectangle(extent=[-100,100; 100,-100], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=8,
            rgbfillColor={181,181,181})), Text(
          extent=[-94,94; 94,-94],
          style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=8,
            rgbfillColor={181,181,181}),
          string="S")), Documentation(info="<html>
<p>
This icon is designed for a <b>String</b> type.
</p>
</html>"));
  end TypeString;
  
  partial model TranslationalSensor 
    "Icon representing translational measurement device" 
    
    annotation (
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
        Line(points=[50, -40; 50, -60], style(color=0))),
      Documentation(info="<html>
<p>
This icon is designed for a <b>translational sensor</b> model.
</p>
</html>"));
  equation 
    
  end TranslationalSensor;
  
  partial model RotationalSensor 
    "Icon representing rotational measurement device" 
    
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
            fillPattern=1))),
      Documentation(info="<html>
<p>
This icon is designed for a <b>rotational sensor</b> model.
</p>
</html>"));
  equation 
    
  end RotationalSensor;
  
  partial model GearIcon "Icon for gearbox" 
    
    annotation (Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]), Icon(
        Rectangle(extent=[-90, 10; -60, -10], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[-60, 10; -60, 20; -40, 40; -40, -40; -60, -20; -60, 10],
              style(
            color=10,
            gradient=2,
            fillColor=10,
            fillPattern=1)),
        Rectangle(extent=[-40, 60; 40, -60], style(
            color=3,
            pattern=1,
            thickness=1,
            gradient=2,
            arrow=0,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[60, 20; 40, 40; 40, -40; 60, -20; 60, 20], style(
            color=10,
            fillColor=10,
            fillPattern=1)),
        Rectangle(extent=[60, 10; 90, -10], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[-60, -90; -50, -90; -20, -30; 20, -30; 48, -90; 60, -90;
                60, -100; -60, -100; -60, -90], style(
            color=0,
            fillColor=0,
            fillPattern=1))),
      Documentation(info="<html>
<p>
This icon is designed for a <b>gearbox</b> model.
</p>
</html>"));
  equation 
    
  end GearIcon;
  
  partial model MotorIcon "Icon for electrical motor" 
    
    annotation (Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]), Icon(
        Rectangle(extent=[-100, 50; 30, -50], style(
            color=1,
            gradient=2,
            fillColor=1,
            fillPattern=1)),
        Polygon(points=[-100, -90; -90, -90; -60, -20; -10, -20; 20, -90; 30, -
              90; 30, -100; -100, -100; -100, -90], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[30, 10; 90, -10], style(
            gradient=2,
            fillColor=8,
            fillPattern=1))),
      Documentation(info="<html>
<p>
This icon is designed for an <b>electrical motor</b> model.
</p>
</html>"));
  equation 
    
  end MotorIcon;
  
  connector SignalBus "Icon for signal bus" 
    
    annotation (
      Icon(
        Rectangle(extent=[-20,2; 20,-2], style(rgbcolor={255,204,51}, thickness=2)),
        Polygon(points=[-80,50; 80,50; 100,30; 80,-40; 60,-50; -60,-50; -80,-40;
              -100,30; -80,50],        style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=6,
            rgbfillColor={255,204,51})),
        Ellipse(extent=[-65, 25; -55, 15], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Ellipse(extent=[-5, 25; 5, 15], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Ellipse(extent=[55, 25; 65, 15],style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Ellipse(extent=[-35, -15; -25, -25], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Ellipse(extent=[25, -15; 35, -25], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0}))),
      Coordsys(grid=[2, 2],scale=0.2),
      Diagram(
        Polygon(points=[-40, 25; 40, 25; 50, 15; 40, -20; 30, -25; -30, -25; -40,
              -20; -50, 15; -40, 25], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=6,
            rgbfillColor={255,204,51})),
        Ellipse(extent=[-32.5, 7.5; -27.5, 12.5], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Ellipse(extent=[-2.5, 12.5; 2.5, 7.5], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Ellipse(extent=[27.5, 12.5; 32.5, 7.5],style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Ellipse(extent=[-17.5, -7.5; -12.5, -12.5], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Ellipse(extent=[12.5, -7.5; 17.5, -12.5], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Text(
          extent=[-150, 70; 150, 40],
          string="%name",
          style(color=0))),
      Documentation(info="<html>
<p>
This icon is designed for a <b>signal bus</b> connector.
</p>
</html>"));
    
  end SignalBus;
  
  connector SignalSubBus "Icon for signal sub-bus" 
    
    annotation (
      Icon(
        Line(points=[-16, 2; 16, 2], style(rgbcolor={255,204,51}, thickness=2)),
        Rectangle(extent=[-10, 8; 8, 0], style(
            color=79,
            rgbcolor={255,204,51},
            thickness=2)),
        Polygon(points=[-80, 50; 80, 50; 100, 30; 80, -40; 60, -50; -60, -50; -80,
              -40; -100, 30; -80, 50], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=6,
            rgbfillColor={255,204,51})),
        Ellipse(extent=[-55, 25; -45, 15], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Ellipse(extent=[45, 25; 55, 15],style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Ellipse(extent=[-5, -15; 5, -25], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Rectangle(extent=[-20,4; 20,0],  style(rgbcolor={255,204,51}, thickness=2))),
      Coordsys(grid=[2, 2],scale=0.1),
      Diagram(
        Polygon(points=[-40, 25; 40, 25; 50, 15; 40, -20; 30, -25; -30, -25; -40,
              -20; -50, 15; -40, 25], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=6,
            rgbfillColor={255,204,51})),
        Ellipse(extent=[-22.5, 7.5; -17.5, 12.5], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Ellipse(extent=[17.5, 12.5; 22.5, 7.5],style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Ellipse(extent=[-2.5, -7.5; 2.5, -12.5], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=0,
            rgbfillColor={0,0,0})),
        Text(
          extent=[-150, 70; 150, 40],
          string="%name",
          style(color=0))),
      Documentation(info="<html>
<p>
This icon is designed for a <b>sub-bus</b> in a signal connector.
</p>
</html>"));
    
  end SignalSubBus;
end Icons;
