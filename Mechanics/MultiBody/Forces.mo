package Forces "Components that exert forces and/or torques between frames" 
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Library;
  
  annotation (preferedView="info", Documentation(info="<HTML>
<p>
This package contains components that exert forces and torques
between two frame connectors, e.g., between two parts.
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Model</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.WorldForce\">WorldForce</a></b></td>
      <td> External force acting at the frame to which this component
           is connected and defined by 3 input signals,
           that are interpreted as one vector resolved in the world frame. <br>
           <IMG SRC=\"../Images/MultiBody/Forces/ArrowForce.png\"></td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.WorldTorque\">WorldTorque</a></b></td>
      <td> External torque acting at the frame to which this component
           is connected and defined by 3 input signals,
           that are interpreted as one vector resolved in the world frame. <br>
           <IMG SRC=\"../Images/MultiBody/Forces/ArrowTorque.png\"></td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.WorldForceAndTorque\">WorldForceAndTorque</a></b></td>
      <td> External force and external torque acting at the frame 
           to which this component
           is connected and defined by 6 input signals,
           that are interpreted as a force and as a torque vector 
           resolved in the world frame. <br>
           <IMG SRC=\"../Images/MultiBody/Forces/ArrowForce.png\"><br>
           <IMG SRC=\"../Images/MultiBody/Forces/ArrowTorque.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.FrameForce\">FrameForce</a></b></td>
      <td> External force acting at the frame to which this component
           is connected and defined by 3 input signals,
           that are interpreted as one vector resolved in the local frame
           or in \"frame_resolve\", if connected. <br>
           <IMG SRC=\"../Images/MultiBody/Forces/ArrowForce.png\"></td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.FrameTorque\">FrameTorque</a></b></td>
      <td> External torque acting at the frame to which this component
           is connected and defined by 3 input signals,
           that are interpreted as one vector resolved in the local frame
           or in \"frame_resolve\", if connected. <br>
           <IMG SRC=\"../Images/MultiBody/Forces/ArrowTorque.png\"></td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.FrameForceAndTorque\">FrameForceAndTorque</a></b></td>
      <td> External force and torque acting at the frame to which this component
           is connected and defined by 6 input signals,
           that are interpreted as one force and one torque vector 
           resolved in the local frame
           or in \"frame_resolve\", if connected. <br>
           <IMG SRC=\"../Images/MultiBody/Forces/ArrowForce.png\"><br>
           <IMG SRC=\"../Images/MultiBody/Forces/ArrowTorque.png\">
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.Force\">Force</a></b></td>
      <td> Force acting between two frames defined by 3 input signals
           resolved in the local frame
           or in \"frame_resolve\", if connected. <br>
           <IMG SRC=\"../Images/MultiBody/Forces/ArrowForce2.png\"></td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.Torque\">Torque</a></b></td>
      <td> Torque acting between two frames defined by 3 input signals
           resolved in the local frame
           or in \"frame_resolve\", if connected. <br>
           <IMG SRC=\"../Images/MultiBody/Forces/ArrowTorque2.png\"></td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.ForceAndTorque\">ForceAndTorque</a></b></td>
      <td> Force and torque acting between two frames defined by 6 input signals
           resolved in the local frame
           or in \"frame_resolve\", if connected. <br>
           <IMG SRC=\"../Images/MultiBody/Forces/ArrowForce2.png\"><br>
           <IMG SRC=\"../Images/MultiBody/Forces/ArrowTorque2.png\"></td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.LineForceWithMass\">LineForceWithMass</a></b></td>
      <td>  General line force component with an optional point mass 
            on the connection line. The force law can be defined by a 
            component of Modelica.Mechanics.Translational<br>
           <IMG SRC=\"../Images/MultiBody/Forces/LineForceWithMass.png\"></td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.LineForceWithTwoMasses\">LineForceWithTwoMasses</a></b></td>
      <td>  General line force component with two optional point masses 
            on the connection line. The force law can be defined by a 
            component of Modelica.Mechanics.Translational<br>
           <IMG SRC=\"../Images/MultiBody/Forces/LineForceWithTwoMasses.png\"></td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.Spring\">Spring</a></b></td>
      <td> Linear translational spring with optional mass <br>
           <IMG SRC=\"../Images/MultiBody/Forces/Spring2.png\"></td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.Damper\">Damper</a></b></td>
      <td> Linear (velocity dependent) damper <br>
           <IMG SRC=\"../Images/MultiBody/Forces/Damper2.png\"></td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.SpringDamperParallel\">SpringDamperParallel</a></b></td>
      <td> Linear spring and damper in parallel connection </td>
  </tr>
  <tr><td><b><a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.SpringDamperSeries\">SpringDamperSeries</a></b></td>
      <td> Linear spring and damper in series connection </td>
  </tr>
</table>
</HTML>"));
  
  model WorldForce 
    "External force acting at frame_b, defined by 3 input signals and resolved in world frame" 
    
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    extends Interfaces.PartialOneFrame_b;
    Modelica.Blocks.Interfaces.RealInput force[3](redeclare type SignalType = 
                     SI.Force) 
      "x-, y-, z-coordinates of force resolved in world frame" 
      annotation (extent=[-140, -20; -100, 20]);
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Real N_to_m(unit="N/m") = world.defaultN_to_m 
      " Force arrow scaling (length = force/N_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter diameter=world.defaultArrowDiameter 
      " Diameter of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color color=Types.Defaults.ForceColor " Color of arrow" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    
    annotation (
      preferedView="info",
      Diagram(Polygon(points=[-100,10; 50,10; 50,31; 97,0; 50,-31; 50,-10; -100,
              -10; -100,10],         style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))),
      Icon(
        Text(
          extent=[-100, -30; 50, -70],
          string="world",
          style(color=8)),
        Polygon(points=[-100,10; 50,10; 50,31; 94,0; 50,-31; 50,-10; -100,-10;
              -100,10],        style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1)),
        Text(extent=[-149, 103; 136, 42], string="%name")),
      Documentation(info="<HTML>
<p>
The <b>3</b> signals of the <b>force</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>force</b> resolved in the
<b>world frame</b> and acting at the frame connector to which this
component is attached.
</p>
<p>
This force component is by default visualized as an arrow
acting at the connector to which it is connected. The diameter
and color of the arrow are fixed and can be defined via
parameters <b>diameter</b> and <b>color</b>. The arrow
points in the direction defined by the
inPort.signal signals. The length of the arrow is proportional
to the length of the force vector using parameter
<b>N_to_m</b> as scaling factor. For example, if N_to_m = 100 N/m,
then a force of 350 N is displayed as an arrow of length 3.5 m.
</p>
<p>
An example how to use this model is given in the 
following figure:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/WorldForce1.png\">
</p>
<p>
This leads to the following animation
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/WorldForce2.png\">
</p>
</HTML>
"));
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.18,
        y=0.01,
        width=0.8,
        height=0.82),
      Documentation(info="
An external force element exerts the inport signal
as negative force on the connector frame (the force vector
is resolved in the world frame).
"),   Icon(Text(extent=[-132, 99; 128, 39], string="%name"), Polygon(points=[-100,
               10; 49, 10; 49, 31; 100, 0; 49, -31; 49, -10; -100, -10; -100,
              10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))),
      Diagram(Polygon(points=[-90, 10; 40, 10; 40, 31; 91, 0; 40, -31; 40, -10;
               -90, -10; -90, 10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))));
    
  protected 
    SI.Position f_in_m[3]=frame_b.f/N_to_m 
      "Force mapped from N to m for animation";
    Visualizers.Advanced.Arrow arrow(
      diameter=diameter,
      color=color,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=f_in_m,
      r_head=-f_in_m) if world.enableAnimation and animation;
  equation 
    frame_b.f = -Frames.resolve2(frame_b.R, force);
    frame_b.t = zeros(3);
  end WorldForce;
  
  model WorldTorque 
    "External torque acting at frame_b, defined by 3 input signals and resolved in world frame" 
    
    extends Interfaces.PartialOneFrame_b;
    import Modelica.Mechanics.MultiBody.Types;
    
    Modelica.Blocks.Interfaces.RealInput torque[3](redeclare type SignalType = 
                     SI.Torque) 
      "x-, y-, z-coordinates of torque resolved in world frame" 
      annotation (extent=[-140, -20; -100, 20]);
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Real Nm_to_m(unit="N.m/m") = world.defaultNm_to_m 
      " Torque arrow scaling (length = torque/Nm_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter diameter=world.defaultArrowDiameter 
      " Diameter of torque arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color color=Types.Defaults.TorqueColor " Color of arrow" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    
    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.18,
        y=0.17,
        width=0.64,
        height=0.74),
      Documentation(info="<HTML>
<p>
The <b>3</b> signals of the <b>torque</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>torque</b> resolved in the
<b>world frame</b> and acting at the frame connector to which this
component is attached.
</p>
<p>
This torque component is by default visualized as a <b>double arrow</b>
acting at the connector to which it is connected. The diameter
and color of the arrow are fixed and can be defined via
parameters <b>diameter</b> and <b>color</b>. The double arrow points
in the direction defined by the
inPort.signal signals. The length of the double arrow is proportional
to the length of the torque vector using parameter
<b>Nm_to_m</b> as scaling factor. For example, if Nm_to_m = 100 Nm/m,
then a torque of 350 Nm is displayed as an arrow of length 3.5 m.
</p>
<p>
An example how to use this model is given in the 
following figure:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/WorldTorque1.png\">
</p>
<p>
This leads to the following animation
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/WorldTorque2.png\">
</p>
</HTML>
"),   Icon(
        Text(extent=[-124, -27; 136, -87], string="%name"),
        Text(
          extent=[-103, 127; 60, 87],
          string="world",
          style(color=8)),
        Line(points=[-100, 0; -94, 13; -86, 28; -74, 48; -65, 60; -52, 72; -35,
               81; -22, 84; -8, 84; 7, 80; 19, 73; 32, 65; 44, 55; 52, 47; 58,
              40], style(color=0, thickness=2)),
        Polygon(points=[94,0; 75,59; 41,24; 94,0],       style(
            color=0,
            fillColor=0,
            fillPattern=1))),
      Diagram(Line(points=[-100, 0; -94, 13; -86, 28; -74, 48; -65, 60; -52, 72;
               -35, 81; -22, 84; -8, 84; 7, 80; 19, 73; 32, 65; 44, 55; 52, 47;
               58, 40], style(color=0, thickness=2)), Polygon(points=[97,0; 75,59;
              41,24; 97,0],            style(
            color=0,
            fillColor=0,
            fillPattern=1))));
    
  protected 
    SI.Position t_in_m[3]=frame_b.t/Nm_to_m 
      "Torque mapped from Nm to m for animation";
    Visualizers.Advanced.DoubleArrow arrow(
      diameter=diameter,
      color=color,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=t_in_m,
      r_head=-t_in_m) if world.enableAnimation and animation;
  equation 
    frame_b.f = zeros(3);
    frame_b.t = -Frames.resolve2(frame_b.R, torque);
  end WorldTorque;
  
  model WorldForceAndTorque 
    "External force and torque acting at frame_b, defined by 6 input signals and resolved in world frame" 
    
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    extends Interfaces.PartialOneFrame_b;
    
    Modelica.Blocks.Interfaces.RealInput load[6] 
      "[1:6] = x-, y-, z-coordinates of force and x-, y-, z-coordiantes of torque resolved in world frame"
      annotation (extent=[-140, -20; -100, 20]);
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Real N_to_m(unit="N/m") = world.defaultN_to_m 
      " Force arrow scaling (length = force/N_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    parameter Real Nm_to_m(unit="N.m/m") = world.defaultNm_to_m 
      " Torque arrow scaling (length = torque/Nm_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter forceDiameter=world.defaultArrowDiameter 
      " Diameter of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter torqueDiameter=forceDiameter " Diameter of torque arrow" 
                                  annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color forceColor=Types.Defaults.ForceColor 
      " Color of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color torqueColor=Types.Defaults.TorqueColor 
      " Color of torque arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    
    annotation (
      preferedView="info",
      Diagram(
        Polygon(points=[-100,10; 50,10; 50,31; 97,0; 50,-31; 50,-10; -100,-10;
              -100,10],        style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-100, 11; -94, 24; -86, 39; -74, 59; -65, 71; -52, 83; -35,
               92; -22, 95; -8, 95; 7, 91; 19, 84; 32, 76; 44, 66; 52, 58; 58,
              51], style(color=0, thickness=2)),
        Polygon(points=[97, 18; 72, 77; 38, 42; 97, 18], style(
            color=0,
            fillColor=0,
            fillPattern=1))),
      Icon(
        Text(
          extent=[-74, 62; 44, 24],
          string="world",
          style(color=8)),
        Polygon(points=[-100,10; 50,10; 50,31; 94,0; 50,-31; 50,-10; -100,-10;
              -100,10],        style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1)),
        Text(extent=[-137, -47; 148, -108], string="%name"),
        Line(points=[-98, 14; -92, 27; -84, 42; -72, 62; -63, 74; -50, 86; -33,
               95; -20, 98; -6, 98; 9, 94; 21, 87; 34, 79; 46, 69; 54, 61; 60,
              54], style(color=0, thickness=2)),
        Polygon(points=[99, 21; 74, 80; 40, 45; 99, 21], style(
            color=0,
            fillColor=0,
            fillPattern=1))),
      Documentation(info="<HTML>
<p>
The <b>6</b> signals of the <b>load</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>force</b> and as
the x-, y-, and z-coordinates of a <b>torque</b> resolved in the
<b>world frame</b> and acting at the frame connector to which this
component is attached. The input signals are mapped to the force
and torque in the following way:
</p>
<pre>
   force  = load[1:3]
   torque = load[4:6]
</pre>
<p>
The force and torque are by default visualized as an arrow (force)
and as a double arrow (torque) acting at the connector to which
they are connected. The diameters
and colors of the arrows are fixed and can be defined via
parameters <b>forceDiameter</b>, <b>torqueDiameter</b>,
<b>forceColor</b> and <b>torqueColor</b>. The arrows
point in the directions defined by the
inPort.signal signals. The lengths of the arrows are proportional
to the length of the force and torque vectors, respectively, using parameters
<b>N_to_m</b> and <b>Nm_to_m</b> as scaling factors. For example, if N_to_m = 100 N/m,
then a force of 350 N is displayed as an arrow of length 3.5 m.
</p>
<p>
An example how to use this model is given in the 
following figure:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/WorldForceAndTorque1.png\">
</p>
<p>
This leads to the following animation
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/WorldForceAndTorque2.png\">
</p>
</HTML>
"));
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.18,
        y=0.01,
        width=0.8,
        height=0.82),
      Documentation(info="
An external force element exerts the inport signal
as negative force on the connector frame (the force vector
is resolved in the world frame).
"),   Icon(Text(extent=[-132, 99; 128, 39], string="%name"), Polygon(points=[-100,
               10; 49, 10; 49, 31; 100, 0; 49, -31; 49, -10; -100, -10; -100,
              10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))),
      Diagram(Polygon(points=[-90, 10; 40, 10; 40, 31; 91, 0; 40, -31; 40, -10;
               -90, -10; -90, 10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))));
    
  protected 
    SI.Position f_in_m[3]=frame_b.f/N_to_m 
      "Force mapped from N to m for animation";
    SI.Position t_in_m[3]=frame_b.t/Nm_to_m 
      "Torque mapped from Nm to m for animation";
    Visualizers.Advanced.Arrow forceArrow(
      diameter=forceDiameter,
      color=forceColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=f_in_m,
      r_head=-f_in_m) if world.enableAnimation and animation;
    Visualizers.Advanced.DoubleArrow torqueArrow(
      diameter=torqueDiameter,
      color=torqueColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=t_in_m,
      r_head=-t_in_m) if world.enableAnimation and animation;
  equation 
    frame_b.f = -Frames.resolve2(frame_b.R, load[1:3]);
    frame_b.t = -Frames.resolve2(frame_b.R, load[4:6]);
  end WorldForceAndTorque;
  
  model FrameForce 
    "External force acting at frame_b, defined by 3 input signals and resolved in frame_b or in frame_resolve" 
    
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    extends Interfaces.PartialOneFrame_b;
    Interfaces.Frame_resolve frame_resolve 
      "If connected, the input signals are resolved in this frame" 
      annotation (extent=[-16,-116; 16,-84], rotation=-90);
    
    Modelica.Blocks.Interfaces.RealInput force[3](redeclare type SignalType = 
                     SI.Force) 
      "x-, y-, z-coordinates of force resolved in frame_b or frame_resolve (if connected)"
      annotation (extent=[-140, -20; -100, 20]);
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Real N_to_m(unit="N/m") = world.defaultN_to_m 
      " Force arrow scaling (length = force/N_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter diameter=world.defaultArrowDiameter 
      " Diameter of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color color=Types.Defaults.ForceColor " Color of arrow" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    
    annotation (
      preferedView="info",
      Diagram(Polygon(points=[-100,10; 50,10; 50,31; 97,0; 50,-31; 50,-10;
              -100,-10; -100,10],    style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1)), Line(points=[0,-10; 0,-97], style(
            color=10,
            rgbcolor={95,95,95},
            pattern=3))),
      Icon(
        Text(
          extent=[-89,-46; 91,-76],
          string="resolve",
          style(color=8)),
        Polygon(points=[-100,10; 50,10; 50,31; 94,0; 50,-31; 50,-10; -100,-10;
              -100,10],        style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1)),
        Text(extent=[-149, 103; 136, 42], string="%name"),
        Line(points=[0,-10; 0,-95], style(
            color=10,
            rgbcolor={95,95,95},
            pattern=3))),
      Documentation(info="<HTML>
<p>
The 3 signals of the <b>force</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>force</b> acting at the frame
connector to which this component is attached. If connector
<b>frame_resolve</b> is <b>not</b> connected, the force coordinates
are with respect to <b>frame_b</b>. If connector
<b>frame_resolve</b> is connected, the force coordinates
are with respect to <b>frame_resolve</b>. In this case the
force and torque in connector frame_resolve are set to zero,
i.e., this connector is solely used to provide the information
of the coordinate system, in which the force coordinates
are defined.
</p>
<p>
This force component is by default visualized as an arrow
acting at the connector to which it is connected. The diameter
and color of the arrow are fixed and can be defined via
parameters <b>diameter</b> and <b>color</b>. The arrow
points in the direction defined by the
inPort.signal signals. The length of the arrow is proportional
to the length of the force vector using parameter
<b>N_to_m</b> as scaling factor. For example, if N_to_m = 100 N/m,
then a force of 350 N is displayed as an arrow of length 3.5 m.
</p>
<p>
An example how to use this model is given in the 
following figure:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/FrameForce1.png\">
</p>
<p>
This leads to the following animation
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/FrameForce2.png\">
</p>
</HTML>
"));
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.18,
        y=0.01,
        width=0.8,
        height=0.82),
      Documentation(info="
An external force element exerts the inport signal
as negative force on the connector frame (the force vector
is resolved in the world frame).
"),   Icon(Text(extent=[-132, 99; 128, 39], string="%name"), Polygon(points=[-100,
               10; 49, 10; 49, 31; 100, 0; 49, -31; 49, -10; -100, -10; -100,
              10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))),
      Diagram(Polygon(points=[-90, 10; 40, 10; 40, 31; 91, 0; 40, -31; 40, -10;
               -90, -10; -90, 10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))));
    
  protected 
    SI.Position f_in_m[3]=frame_b.f/N_to_m 
      "Force mapped from N to m for animation";
    Visualizers.Advanced.Arrow arrow(
      diameter=diameter,
      color=color,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=f_in_m,
      r_head=-f_in_m) if world.enableAnimation and animation;
  equation 
    if cardinality(frame_resolve) == 0 then
      frame_b.f = -force;
      frame_resolve.r_0 = zeros(3);
      frame_resolve.R = Frames.nullRotation();
    else
      frame_b.f = -Frames.resolve2(Frames.relativeRotation(frame_resolve.R,
        frame_b.R), force);
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);
    end if;
    frame_b.t = zeros(3);
  end FrameForce;
  
  model FrameTorque 
    "External torque acting at frame_b, defined by 3 input signals and resolved in frame_b or in frame_resolve" 
    
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    extends Interfaces.PartialOneFrame_b;
    Interfaces.Frame_resolve frame_resolve 
      "If connected, the input signals are resolved in this frame" 
      annotation (extent=[-16,116; 16,84], rotation=-90);
    
    Modelica.Blocks.Interfaces.RealInput torque[3](redeclare type SignalType = 
                     SI.Torque) 
      "x-, y-, z-coordinates of torque resolved in frame_b or frame_resolve (if connected)"
      annotation (extent=[-140, -20; -100, 20]);
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Real Nm_to_m(unit="N.m/m") = world.defaultNm_to_m 
      " Torque arrow scaling (length = torque/Nm_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter diameter=world.defaultArrowDiameter 
      " Diameter of torque arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color color=Types.Defaults.TorqueColor " Color of arrow" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    annotation (
      preferedView="info",
      Diagram(
        Line(points=[0,97; 0,82], style(
            color=10,
            rgbcolor={95,95,95},
            pattern=3)),
        Line(points=[-100, 0; -94, 13; -86, 28; -74, 48; -65, 60; -52, 72; -35,
               81; -22, 84; -8, 84; 7, 80; 19, 73; 32, 65; 44, 55; 52, 47; 58,
              40], style(color=0, thickness=2)),
        Polygon(points=[97,6; 75,59; 41,24; 97,6],       style(
            color=0,
            fillColor=0,
            fillPattern=1))),
      Icon(
        Text(
          extent=[-61,64; 46,27],
          string="resolve",
          style(color=8)),
        Text(extent=[-145, -28; 140, -89], string="%name"),
        Line(points=[0,95; 0,82], style(
            color=10,
            rgbcolor={95,95,95},
            pattern=3)),
        Line(points=[-100, 0; -94, 13; -86, 28; -74, 48; -65, 60; -52, 72; -35,
               81; -22, 84; -8, 84; 7, 80; 19, 73; 32, 65; 44, 55; 52, 47; 58,
              40], style(color=0, thickness=2)),
        Polygon(points=[94,10; 75,59; 41,24; 94,10],     style(
            color=0,
            fillColor=0,
            fillPattern=1))),
      Documentation(info="<HTML>
<p>
The 3 signals of the <b>torque</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>torque</b> acting at the frame
connector to which this component is attached. If connector
<b>frame_resolve</b> is <b>not</b> connected, the torque coordinates
are with respect to <b>frame_b</b>. If connector
<b>frame_resolve</b> is connected, the torque coordinates
are with respect to <b>frame_resolve</b>. In this case the
force and torque in connector frame_resolve are set to zero,
i.e., this connector is solely used to provide the information
of the coordinate system, in which the force coordinates
are defined.
</p>
<p>
This torque component is by default visualized as an arrow
acting at the connector to which it is connected. The diameter
and color of the arrow are fixed and can be defined via
parameters <b>diameter</b> and <b>color</b>. The arrow
points in the direction defined by the
inPort.signal signals. The length of the arrow is proportional
to the length of the torque vector using parameter
<b>Nm_to_m</b> as scaling factor. For example, if Nm_to_m = 100 N/m,
then a torque of 350 Nm is displayed as an arrow of length 3.5 m.
</p>
<p>
An example how to use this model is given in the 
following figure:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/FrameTorque1.png\">
</p>
<p>
This leads to the following animation
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/FrameTorque2.png\">
</p>
</HTML>
"));
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.18,
        y=0.01,
        width=0.8,
        height=0.82),
      Documentation(info="
An external force element exerts the inport signal
as negative force on the connector frame (the force vector
is resolved in the world frame).
"),   Icon(Text(extent=[-132, 99; 128, 39], string="%name"), Polygon(points=[-100,
               10; 49, 10; 49, 31; 100, 0; 49, -31; 49, -10; -100, -10; -100,
              10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))),
      Diagram(Polygon(points=[-90, 10; 40, 10; 40, 31; 91, 0; 40, -31; 40, -10;
               -90, -10; -90, 10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))));
    
  protected 
    SI.Position t_in_m[3]=frame_b.t/Nm_to_m 
      "Torque mapped from Nm to m for animation";
    Visualizers.Advanced.DoubleArrow arrow(
      diameter=diameter,
      color=color,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=t_in_m,
      r_head=-t_in_m) if world.enableAnimation and animation;
  equation 
    frame_b.f = zeros(3);
    if cardinality(frame_resolve) == 0 then
      frame_b.t = -torque;
      frame_resolve.r_0 = zeros(3);
      frame_resolve.R = Frames.nullRotation();
    else
      frame_b.t = -Frames.resolve2(Frames.relativeRotation(frame_resolve.R,
        frame_b.R), torque);
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);
    end if;
  end FrameTorque;
  
  model FrameForceAndTorque 
    "External force and torque acting at frame_b, defined by 6 input signals and resolved in frame_b or in frame_resolve" 
    
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    extends Interfaces.PartialOneFrame_b;
    Interfaces.Frame_resolve frame_resolve 
      "If connected, the input signals are resolved in this frame" 
      annotation (extent=[-16,116; 16,84], rotation=-90);
    Modelica.Blocks.Interfaces.RealInput load[6] 
      "[1:6] = x-, y-, z-coordinates of force and x-, y-, z-coordiantes of torque resolved in frame_b or frame_resolved (if connected)"
      annotation (extent=[-140, -20; -100, 20]);
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Real N_to_m(unit="N/m") = world.defaultN_to_m 
      " Force arrow scaling (length = force/N_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    parameter Real Nm_to_m(unit="N.m/m") = world.defaultNm_to_m 
      " Torque arrow scaling (length = torque/Nm_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter forceDiameter=world.defaultArrowDiameter 
      " Diameter of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter torqueDiameter=forceDiameter " Diameter of torque arrow" 
                                  annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color forceColor=Types.Defaults.ForceColor 
      " Color of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color torqueColor=Types.Defaults.TorqueColor 
      " Color of torque arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    annotation (
      preferedView="info",
      Diagram(
        Polygon(points=[-100,10; 50,10; 50,31; 97,0; 50,-31; 50,-10; -100,-10;
              -100,10],        style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-100, 11; -94, 24; -86, 39; -74, 59; -65, 71; -52, 83; -35,
               92; -22, 95; -8, 95; 7, 91; 19, 84; 32, 76; 44, 66; 52, 58; 58,
              51], style(color=0, rgbcolor={0,0,0})),
        Polygon(points=[97, 18; 72, 77; 38, 42; 97, 18], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[0,97; 0,10], style(
            color=10,
            rgbcolor={95,95,95},
            pattern=3))),
      Icon(
        Text(
          extent=[-74, 62; 44, 24],
          style(color=8),
          string="resolve"),
        Polygon(points=[-100,10; 50,10; 50,31; 94,0; 50,-31; 50,-10; -100,-10;
              -100,10],        style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1)),
        Text(extent=[-137, -47; 148, -108], string="%name"),
        Line(points=[-100,10; -92,26; -84,42; -76,52; -60,68; -46,76; -31,82;
              -17,85; -2,87; 14,86; 26,82; 37,75; 46,69; 54,61; 60,54], style(
              color=0, rgbcolor={0,0,0})),
        Polygon(points=[99, 21; 74, 80; 40, 45; 99, 21], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[0,95; 0,10], style(
            color=10,
            rgbcolor={95,95,95},
            pattern=3))),
      Documentation(info="<HTML>
<p>
The <b>6</b> signals of the <b>load</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>force</b> and as
the x-, y-, and z-coordinates of a <b>torque</b> acting at the frame
connector to which this component is attached. If connector
<b>frame_resolve</b> is <b>not</b> connected, the force and torque coordinates
are with respect to <b>frame_b</b>. If connector
<b>frame_resolve</b> is connected, the force and torque coordinates
are with respect to <b>frame_resolve</b>. In this case the
force and torque in connector frame_resolve are set to zero,
i.e., this connector is solely used to provide the information
of the coordinate system, in which the force coordinates
are defined. The input signals are mapped to the force
and torque in the following way:
</p>
<pre>
   force  = load[1:3]
   torque = load[4:6]
</pre>
<p>
The force and torque are by default visualized as an arrow (force)
and as a double arrow (torque) acting at the connector to which
they are connected. The diameters
and colors of the arrows are fixed and can be defined via
parameters <b>forceDiameter</b>, <b>torqueDiameter</b>,
<b>forceColor</b> and <b>torqueColor</b>. The arrows
point in the directions defined by the
inPort.signal signals. The lengths of the arrows are proportional
to the length of the force and torque vectors, respectively, using parameters
<b>N_to_m</b> and <b>Nm_to_m</b> as scaling factors. For example,
if N_to_m = 100 N/m,
then a force of 350 N is displayed as an arrow of length 3.5 m.
</p>
<p>
An example how to use this model is given in the 
following figure:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/FrameForceAndTorque1.png\">
</p>
<p>
This leads to the following animation
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/FrameForceAndTorque2.png\">
</p>
</HTML>
"));
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.18,
        y=0.01,
        width=0.8,
        height=0.82),
      Documentation(info="
An external force element exerts the inport signal
as negative force on the connector frame (the force vector
is resolved in the world frame).
"),   Icon(Text(extent=[-132, 99; 128, 39], string="%name"), Polygon(points=[-100,
               10; 49, 10; 49, 31; 100, 0; 49, -31; 49, -10; -100, -10; -100,
              10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))),
      Diagram(Polygon(points=[-90, 10; 40, 10; 40, 31; 91, 0; 40, -31; 40, -10;
               -90, -10; -90, 10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))));
    
  protected 
    SI.Position f_in_m[3]=frame_b.f/N_to_m 
      "Force mapped from N to m for animation";
    SI.Position t_in_m[3]=frame_b.t/Nm_to_m 
      "Torque mapped from Nm to m for animation";
    Visualizers.Advanced.Arrow forceArrow(
      diameter=forceDiameter,
      color=forceColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=f_in_m,
      r_head=-f_in_m) if world.enableAnimation and animation;
    Visualizers.Advanced.DoubleArrow torqueArrow(
      diameter=torqueDiameter,
      color=torqueColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=t_in_m,
      r_head=-t_in_m) if world.enableAnimation and animation;
  equation 
    if cardinality(frame_resolve) == 0 then
      frame_b.f = -load[1:3];
      frame_b.t = -load[4:6];
      frame_resolve.r_0 = zeros(3);
      frame_resolve.R = Frames.nullRotation();
    else
      frame_b.f = -Frames.resolveRelative(load[1:3], frame_resolve.R,
        frame_b.R);
      frame_b.t = -Frames.resolveRelative(load[4:6], frame_resolve.R,
        frame_b.R);
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);
    end if;
  end FrameForceAndTorque;
  
  model Force 
    "Force acting between two frames, defined by 3 input signals and resolved in frame_b or in frame_resolve" 
    
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
    Interfaces.Frame_resolve frame_resolve 
      "If connected, the input signals are resolved in this frame" 
      annotation (extent=[24,84; 56,116], rotation=90);
    Modelica.Blocks.Interfaces.RealInput force[3]( redeclare type SignalType = 
                     SI.Force) 
      "x-, y-, z-coordinates of force resolved in frame_b or frame_resolved (if connected)"
      annotation (extent=[-80, 100; -40, 140], rotation=-90);
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Real N_to_m(unit="N/m") = world.defaultN_to_m 
      " Force arrow scaling (length = force/N_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter forceDiameter=world.defaultArrowDiameter 
      " Diameter of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter connectionLineDiameter=forceDiameter 
      " Diameter of line connecting frame_a and frame_b" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color forceColor=Types.Defaults.ForceColor 
      " Color of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color connectionLineColor=Types.Defaults.SensorColor 
      " Color of line connecting frame_a and frame_b" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    SI.Position r_0[3] 
      "Position vector from origin of frame_a to origin of frame_b resolved in world frame";
    SI.Force f_b_0[3] "frame_b.f resoved in world frame";
    
    annotation (
      preferedView="info",
      Diagram,
      Icon(
        Rectangle(extent=[-98, 99; 99, -98], style(color=7, fillColor=7)),
        Text(
          extent=[-92,61; 87,35],
          style(color=8),
          string="resolve"),
        Text(extent=[-136, -52; 149, -113], string="%name"),
        Line(points=[40, 100; 40, 0], style(
            color=10,
            rgbcolor={95,95,95},
            pattern=3)),
        Polygon(points=[-94,0; -64,11; -64,-10; -94,0],     style(color=0,
              fillColor=0)),
        Line(points=[-60, 100; 40, 100], style(
            color=10,
            rgbcolor={95,95,95},
            pattern=3)),
        Polygon(points=[94,0; 65,12; 65,-11; 94,0],       style(color=0,
              fillColor=0)),
        Line(points=[-64, 0; -20, 0], style(color=0)),
        Line(points=[20, 0; 65, 0], style(color=0))),
      Documentation(info="<HTML>
<p>
The <b>3</b> signals of the <b>force</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>force</b> acting at the frame
connector to which frame_b of this component is attached. If connector
<b>frame_resolve</b> is <b>not</b> connected, the force coordinates
of the inPort connector are with respect to <b>frame_b</b>. If connector
<b>frame_resolve</b> is connected, the force coordinates of the inPort 
connector are with respect to <b>frame_resolve</b>. In this case the
force in connector frame_resolve is set to zero,
i.e., this connector is solely used to provide the information
of the coordinate system, in which the force coordinates
are defined. 
</p>
<p>
Note, the cut-torque in frame_b (frame_b.t) is set to zero.
Additionally, a force and torque acts on frame_a in such a way that
the force and torque balance between frame_a and frame_b is fulfilled.
</p>
<p>
An example how to use this model is given in the 
following figure:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/Force1.png\">
</p>
<p>
This leads to the following animation (the yellow cylinder
characterizes the line between frame_a and frame_b of the
Force component, i.e., the force acts with negative sign
also on the opposite side of this cylinder, but for
clarity this is not shown in the animation):
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/Force2.png\">
</p>
</HTML>
"));
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.18,
        y=0.01,
        width=0.8,
        height=0.82),
      Documentation(info="
An external force element exerts the inport signal
as negative force on the connector frame (the force vector
is resolved in the world frame).
"),   Icon(Text(extent=[-132, 99; 128, 39], string="%name"), Polygon(points=[-100,
               10; 49, 10; 49, 31; 100, 0; 49, -31; 49, -10; -100, -10; -100,
              10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))),
      Diagram(Polygon(points=[-90, 10; 40, 10; 40, 31; 91, 0; 40, -31; 40, -10;
               -90, -10; -90, 10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))));
    
  protected 
    SI.Position f_in_m[3]=frame_b.f/N_to_m 
      "Force mapped from N to m for animation";
    Visualizers.Advanced.Arrow forceArrow(
      diameter=forceDiameter,
      color=forceColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=f_in_m,
      r_head=-f_in_m) if world.enableAnimation and animation;
    Visualizers.Advanced.Shape connectionLine(
      shapeType="cylinder",
      lengthDirection=r_0,
      widthDirection={0,1,0},
      length=Frames.length(r_0),
      width=connectionLineDiameter,
      height=connectionLineDiameter,
      color=connectionLineColor,
      specularCoefficient=specularCoefficient,
      r=frame_a.r_0) if world.enableAnimation and animation;
  equation 
    if cardinality(frame_resolve) == 0 then
      f_b_0 = Frames.resolve1(frame_b.R, frame_b.f);
      frame_b.f = -force;
      frame_resolve.r_0 = zeros(3);
      frame_resolve.R = Frames.nullRotation();
    else
      f_b_0 = -Frames.resolve1(frame_resolve.R, force);
      frame_b.f = Frames.resolve2(frame_b.R, f_b_0);
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);
    end if;
    frame_b.t = zeros(3);
    
    // Force and torque balance
    r_0 = frame_b.r_0 - frame_a.r_0;
    zeros(3) = frame_a.f + Frames.resolve2(frame_a.R, f_b_0);
    zeros(3) = frame_a.t + Frames.resolve2(frame_a.R, cross(r_0, f_b_0));
  end Force;
  
  model Torque 
    "Torque acting between two frames, defined by 3 input signals and resolved in frame_b or in frame_resolve" 
    
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
    Interfaces.Frame_resolve frame_resolve 
      "If connected, the input signals are resolved in this frame" 
      annotation (extent=[24,84; 56,116], rotation=90);
    
    Modelica.Blocks.Interfaces.RealInput torque[3]( redeclare type SignalType 
        =            SI.Torque) 
      "x-, y-, z-coordiantes of torque resolved in frame_b or frame_resolved (if connected)"
      annotation (extent=[-80, 100; -40, 140], rotation=-90);
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Real Nm_to_m(unit="N.m/m") = world.defaultNm_to_m 
      " Torque arrow scaling (length = torque/Nm_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter torqueDiameter=world.defaultArrowDiameter 
      " Diameter of torque arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter connectionLineDiameter=torqueDiameter 
      " Diameter of line connecting frame_a and frame_b" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color torqueColor=Types.Defaults.TorqueColor 
      " Color of torque arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color connectionLineColor=Types.Defaults.SensorColor 
      " Color of line connecting frame_a and frame_b" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    SI.Position r_0[3] 
      "Position vector from origin of frame_a to origin of frame_b resolved in world frame";
    SI.Torque t_b_0[3] "frame_b.t resoved in world frame";
    
    annotation (
      preferedView="info",
      Diagram,
      Icon(
        Rectangle(extent=[-98, 99; 99, -98], style(color=7, fillColor=7)),
        Text(
          extent=[-59, 55; 72, 30],
          style(color=8),
          string="resolve"),
        Text(extent=[-139, -27; 146, -88], string="%name"),
        Polygon(points=[100,20; 84,52; 69,39; 100,20],   style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[40, 100; 76, 46], style(
            color=10,
            rgbcolor={95,95,95},
            pattern=3)),
        Polygon(points=[-99,20; -86,53; -70,42; -99,20],     style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-60, 100; 40, 100], style(
            color=10,
            rgbcolor={95,95,95},
            pattern=3)),
        Line(points=[-79, 47; -70, 61; -59, 72; -45, 81; -32, 84; -20, 85],
            style(color=0)),
        Line(points=[77, 45; 66, 60; 55, 69; 49, 74; 41, 80; 31, 84; 20, 85],
            style(color=0))),
      Documentation(info="<HTML>
<p>
The <b>3</b> signals of the <b>torque</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>torque</b> acting at the frame
connector to which frame_b of this component is attached. If connector
<b>frame_resolve</b> is <b>not</b> connected, the torque coordinates
of the inPort connector are with respect to <b>frame_b</b>. If connector
<b>frame_resolve</b> is connected, the torque coordinates of
the inPort connector
are with respect to <b>frame_resolve</b>. In this case the
torque in connector frame_resolve is set to zero,
i.e., this connector is solely used to provide the information
of the coordinate system, in which the torque coordinates
are defined.
</p>
<p>
Note, the cut-forces in frame_a and frame_b (frame_a.f, frame_b.f) are
set to zero and the cut-torque at frame_a (frame_a.t) is the same
as the cut-torque at frame_b (frame_b.t) but with opposite sign.
</p>
<p>
An example how to use this model is given in the 
following figure:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/Torque1.png\">
</p>
<p>
This leads to the following animation (the yellow cylinder
characterizes the line between frame_a and frame_b of the
Torque component, i.e., the torque acts with negative sign
also on the opposite side of this cylinder, but for
clarity this is not shown in the animation):
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/Torque2.png\">
</p>
</HTML>
"));
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.18,
        y=0.01,
        width=0.8,
        height=0.82),
      Documentation(info="
An external force element exerts the inport signal
as negative force on the connector frame (the force vector
is resolved in the world frame).
"),   Icon(Text(extent=[-132, 99; 128, 39], string="%name"), Polygon(points=[-100,
               10; 49, 10; 49, 31; 100, 0; 49, -31; 49, -10; -100, -10; -100,
              10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))),
      Diagram(Polygon(points=[-90, 10; 40, 10; 40, 31; 91, 0; 40, -31; 40, -10;
               -90, -10; -90, 10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))));
    
  protected 
    SI.Position t_in_m[3]=frame_b.t/Nm_to_m 
      "Torque mapped from Nm to m for animation";
    Visualizers.Advanced.DoubleArrow torqueArrow(
      diameter=torqueDiameter,
      color=torqueColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=t_in_m,
      r_head=-t_in_m) if world.enableAnimation and animation;
    Visualizers.Advanced.Shape connectionLine(
      shapeType="cylinder",
      lengthDirection=r_0,
      widthDirection={0,1,0},
      length=Frames.length(r_0),
      width=connectionLineDiameter,
      height=connectionLineDiameter,
      color=connectionLineColor,
      specularCoefficient=specularCoefficient,
      r=frame_a.r_0) if world.enableAnimation and animation;
  equation 
    r_0 = frame_b.r_0 - frame_a.r_0;
    frame_a.f = zeros(3);
    frame_b.f = zeros(3);
    if cardinality(frame_resolve) == 0 then
      t_b_0 = Frames.resolve1(frame_b.R, frame_b.t);
      frame_b.t = -torque;
      frame_resolve.r_0 = zeros(3);
      frame_resolve.R = Frames.nullRotation();
    else
      t_b_0 = -Frames.resolve1(frame_resolve.R, torque);
      frame_b.t = Frames.resolve2(frame_b.R, t_b_0);
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);
    end if;
    
    // torque balance
    zeros(3) = frame_a.t + Frames.resolve2(frame_a.R, t_b_0);
  end Torque;
  
  model ForceAndTorque 
    "Force and torque acting between two frames, defined by 6 input signals and resolved in frame_b or in frame_resolve" 
    
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
    Interfaces.Frame_resolve frame_resolve 
      "If connected, the input signals are resolved in this frame" 
      annotation (extent=[24,84; 56,116], rotation=90);
    
    Modelica.Blocks.Interfaces.RealInput load[6] 
      "[1:6] = x-, y-, z-coordinates of force and x-, y-, z-coordiantes of torque resolved in frame_b or frame_resolved (if connected)"
      annotation (extent=[-80, 100; -40, 140], rotation=-90);
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Real N_to_m(unit="N/m") = world.defaultN_to_m 
      " Force arrow scaling (length = force/N_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    parameter Real Nm_to_m(unit="N.m/m") = world.defaultNm_to_m 
      " Torque arrow scaling (length = torque/Nm_to_m)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter forceDiameter=world.defaultArrowDiameter 
      " Diameter of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter torqueDiameter=forceDiameter " Diameter of torque arrow" 
                                  annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter connectionLineDiameter=forceDiameter 
      " Diameter of line connecting frame_a and frame_b" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color forceColor=Types.Defaults.ForceColor 
      " Color of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color torqueColor=Types.Defaults.TorqueColor 
      " Color of torque arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color connectionLineColor=Types.Defaults.SensorColor 
      " Color of line connecting frame_a and frame_b" 
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(group="if animation = true", enable=animation));
    SI.Position r_0[3] 
      "Position vector from origin of frame_a to origin of frame_b resolved in world frame";
    SI.Force f_b_0[3] "frame_b.f resoved in world frame";
    SI.Force t_b_0[3] "frame_b.t resoved in world frame";
    
    annotation (
      preferedView="info",
      Diagram,
      Icon(
        Rectangle(extent=[-98, 99; 99, -98], style(color=7, fillColor=7)),
        Text(
          extent=[-59, 55; 72, 30],
          style(color=8),
          string="resolve"),
        Text(extent=[-136, -52; 149, -113], string="%name"),
        Polygon(points=[100, 21; 84, 55; 69, 39; 100, 21], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[40, 100; 40, 0], style(
            color=10,
            rgbcolor={95,95,95},
            pattern=3)),
        Polygon(points=[-95,1; -64,11; -64,-10; -95,1],     style(color=0,
              fillColor=0)),
        Polygon(points=[-100,20; -86,53; -70,42; -100,20],   style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-60, 100; 40, 100], style(
            color=10,
            rgbcolor={95,95,95},
            pattern=3)),
        Polygon(points=[94,0; 65,12; 65,-11; 94,0],       style(color=0,
              fillColor=0)),
        Line(points=[-64, 0; -20, 0], style(color=0)),
        Line(points=[20, 0; 65, 0], style(color=0)),
        Line(points=[-79, 47; -70, 61; -59, 72; -45, 81; -32, 84; -20, 85],
            style(color=0)),
        Line(points=[76, 47; 66, 60; 55, 69; 49, 74; 41, 80; 31, 84; 20, 85],
            style(color=0))),
      Documentation(info="<HTML>
<p>
The <b>6</b> signals of the <b>load</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>force</b> and as
the x-, y-, and z-coordinates of a <b>torque</b> acting at the frame
connector to which frame_b of this component is attached. If connector
<b>frame_resolve</b> is <b>not</b> connected, the force and torque coordinates
are with respect to <b>frame_b</b>. If connector
<b>frame_resolve</b> is connected, the force and torque coordinates
are with respect to <b>frame_resolve</b>. In this case the
force and torque in connector frame_resolve are set to zero,
i.e., this connector is solely used to provide the information
of the coordinate system, in which the force/torque coordinates
are defined. The input signals are mapped to the force
and torque in the following way:
</p>
<pre>
   force  = load[1:3]
   torque = load[4:6]
</pre>
<p>
Additionally, a force and torque acts on frame_a in such a way that
the force and torque balance between frame_a and frame_b is fulfilled.
</p>
<p>
An example how to use this model is given in the 
following figure:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/ForceAndTorque1.png\">
</p>
<p>
This leads to the following animation (the yellow cylinder
characterizes the line between frame_a and frame_b of the
ForceAndTorque component, i.e., the force and torque acts with 
negative sign
also on the opposite side of this cylinder, but for
clarity this is not shown in the animation):
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/ForceAndTorque2.png\">
</p>
</HTML>
"));
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.18,
        y=0.01,
        width=0.8,
        height=0.82),
      Documentation(info="
An external force element exerts the inport signal
as negative force on the connector frame (the force vector
is resolved in the world frame).
"),   Icon(Text(extent=[-132, 99; 128, 39], string="%name"), Polygon(points=[-100,
               10; 49, 10; 49, 31; 100, 0; 49, -31; 49, -10; -100, -10; -100,
              10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))),
      Diagram(Polygon(points=[-90, 10; 40, 10; 40, 31; 91, 0; 40, -31; 40, -10;
               -90, -10; -90, 10], style(
            color=0,
            gradient=0,
            fillColor=0,
            fillPattern=1))));
    
  protected 
    SI.Position f_in_m[3]=frame_b.f/N_to_m 
      "Force mapped from N to m for animation";
    SI.Position t_in_m[3]=frame_b.t/Nm_to_m 
      "Torque mapped from Nm to m for animation";
    Visualizers.Advanced.Arrow forceArrow(
      diameter=forceDiameter,
      color=forceColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=f_in_m,
      r_head=-f_in_m) if world.enableAnimation and animation;
    Visualizers.Advanced.DoubleArrow torqueArrow(
      diameter=torqueDiameter,
      color=torqueColor,
      specularCoefficient=specularCoefficient,
      R=frame_b.R,
      r=frame_b.r_0,
      r_tail=t_in_m,
      r_head=-t_in_m) if world.enableAnimation and animation;
    Visualizers.Advanced.Shape connectionLine(
      shapeType="cylinder",
      lengthDirection=r_0,
      widthDirection={0,1,0},
      length=Frames.length(r_0),
      width=connectionLineDiameter,
      height=connectionLineDiameter,
      color=connectionLineColor,
      specularCoefficient=specularCoefficient,
      r=frame_a.r_0) if world.enableAnimation and animation;
  equation 
    if cardinality(frame_resolve) == 0 then
      frame_b.f = -load[1:3];
      frame_b.t = -load[4:6];
      f_b_0 = Frames.resolve1(frame_b.R, frame_b.f);
      t_b_0 = Frames.resolve1(frame_b.R, frame_b.t);
      frame_resolve.r_0 = zeros(3);
      frame_resolve.R = Frames.nullRotation();
    else
      f_b_0 = -Frames.resolve1(frame_resolve.R, load[1:3]);
      t_b_0 = -Frames.resolve1(frame_resolve.R, load[4:6]);
      frame_b.f = Frames.resolve2(frame_b.R, f_b_0);
      frame_b.t = Frames.resolve2(frame_b.R, t_b_0);
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);
    end if;
    
    // Force and torque balance
    r_0 = frame_b.r_0 - frame_a.r_0;
    zeros(3) = frame_a.f + Frames.resolve2(frame_a.R, f_b_0);
    zeros(3) = frame_a.t + Frames.resolve2(frame_a.R, t_b_0 + cross(r_0, f_b_0));
  end ForceAndTorque;
  
  model LineForceWithMass 
    "General line force component with an optional point mass on the connection line" 
    
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    extends Interfaces.PartialTwoFrames;
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_b 
      "1-dim. translational flange (connect force of Translational library between flange_a and flange_b)"
      annotation (extent=[50,90; 70,110],    rotation=90);
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange_a 
      "1-dim. translational flange (connect force of Translational library between flange_a and flange_b)"
      annotation (extent=[-70,90; -50,110],    rotation=90);
    
    parameter Boolean animateLine=true 
      "= true, if a line shape between frame_a and frame_b shall be visualized";
    parameter Boolean animateMass=true 
      "= true, if point mass shall be visualized as sphere provided m > 0";
    parameter SI.Mass m(min=0)=0 
      "Mass of point mass on the connetion line between the origin of frame_a and the origin of frame_b";
    parameter Real lengthFraction(
      min=0,
      max=1) = 0.5 
      "Location of point mass with respect to frame_a as a fraction of the distance from frame_a to frame_b";
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(tab="Animation"));
    parameter Types.ShapeType lineShapeType="cylinder" 
      " Type of shape visualizing the line from frame_a to frame_b" 
      annotation (Dialog(tab="Animation", group="if animateLine = true", enable=animateLine));
    input SI.Length lineShapeWidth=world.defaultArrowDiameter " Width of shape"
      annotation (Dialog(tab="Animation", group="if animateLine = true", enable=animateLine));
    input SI.Length lineShapeHeight=lineShapeWidth " Height of shape" 
      annotation (Dialog(tab="Animation", group="if animateLine = true", enable=animateLine));
    parameter Types.ShapeExtra lineShapeExtra=0.0 " Extra parameter for shape" 
      annotation (Dialog(tab="Animation", group="if animateLine = true", enable=animateLine));
    input Types.Color lineShapeColor=Types.Defaults.SensorColor 
      " Color of line shape" 
      annotation (Dialog(tab="Animation", group="if animateLine = true", enable=animateLine));
    input Real massDiameter=world.defaultBodyDiameter 
      " Diameter of point mass sphere" 
      annotation (Dialog(tab="Animation", group="if animateMass = true", enable=animateMass));
    input Types.Color massColor=Types.Defaults.BodyColor " Color of point mass"
      annotation (Dialog(tab="Animation", group="if animateMass = true", enable=animateMass));
    parameter SI.Position s_small=1.E-10 
      " Prevent zero-division if distance between frame_a and frame_b is zero" 
      annotation (Dialog(tab="Advanced"));
    SI.Distance length 
      "Distance between the origin of frame_a and the origin of frame_b";
    SI.Position r_rel_0[3] 
      "Position vector from frame_a to frame_b resolved in world frame";
    SI.Position e_rel_0[3] 
      "Unit vector in direction from frame_a to frame_b, resolved in world frame";
    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.24,
        y=0.02,
        width=0.69,
        height=0.78),
      Icon(
        Ellipse(extent=[-95,-40; -15,40],    style(
            color=10,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[-85,-30; -25,30], style(
            color=0,
            rgbcolor={0,0,0},
            fillColor=7,
            rgbfillColor={255,255,255})),
        Ellipse(extent=[15,-40; 95,40],    style(
            color=10,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[23,-30; 83,29],   style(
            color=10,
            fillColor=7,
            fillPattern=1)),
        Text(extent=[-145, -53; 145, -113], string="%name"),
        Rectangle(extent=[-40,41; 44,-40],   style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[-70,15; -41,-13],   style(
            color=0,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[40,14; 69,-14],   style(
            color=0,
            gradient=3,
            fillColor=8)),
        Line(points=[-56,0; -56,23; -30,23; -30,70; -60,70; -60,101],
            style(color=0)),
        Line(points=[55,-1; 55,20; 30,20; 30,70; 60,70; 60,100],      style(
              color=0)),
        Line(points=[-56,0; 55,-1],  style(color=0, pattern=3)),
        Ellipse(extent=[-8, 8; 8, -8], style(color=0, fillColor=0))),
      Diagram(
        Line(points=[-60, 80; 46, 80]),
        Polygon(points=[60, 80; 45, 86; 45, 74; 60, 80], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Text(extent=[-22, 100; 20, 76], string="length"),
        Ellipse(extent=[-100, -40; -20, 40], style(
            color=10,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[-90, -30; -30, 30], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[20, -40; 100, 40], style(
            color=10,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[31, -29; 91, 30], style(
            color=10,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-50, 39; 50, -41], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[-74, 15; -45, -13], style(
            color=0,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[45, 15; 74, -13], style(
            color=0,
            gradient=3,
            fillColor=8)),
        Line(points=[-60, 0; -60, 24; -40, 24; -40, 60; -60, 60; -60, 100],
            style(color=0)),
        Line(points=[60, 1; 60, 21; 40, 21; 40, 60; 60, 60; 60, 100], style(
              color=0)),
        Line(points=[-60, 0; 60, 0], style(color=0, pattern=3)),
        Ellipse(extent=[-8, 8; 8, -8], style(color=0, fillColor=0)),
        Line(points=[-60, 0; -31, 0], style(fillColor=0, fillPattern=1)),
        Polygon(points=[-19, 0; -31, 3; -31, -3; -19, 0], style(
              fillPattern =                                                 7)),
        Line(points=[-60, 16; 0, 16], style(fillColor=0, fillPattern=1)),
        Line(points=[0, 0; 0, 20], style(fillColor=0, fillPattern=1)),
        Text(
          extent=[-43, -8; -7, -33],
          style(gradient=0, fillPattern=0),
          string="e_rel_0"),
        Polygon(points=[0, 16; -12, 19; -12, 13; 0, 16], style(
              fillPattern =                                                7)),
        Text(
          extent=[-50, 35; 51, 26],
          style(gradient=0, fillPattern=0),
          string="length*lengthFraction"),
        Line(points=[-17, 26; -26, 16], style(pattern=3)),
        Line(points=[-31, -13; -40, 0], style(pattern=3))),
      Documentation(info="<html>
<p>
This component is used to exert a <b>line force</b>
between the origin of frame_a and the origin of frame_b
by attaching components of the <b>1-dimensional translational</b>
mechanical library of Modelica (Modelica.Mechanics.Translational)
between the two flange connectors <b>flange_a</b> and
<b>flange_b</b>. Optionally, there is a <b>point mass</b> on the line
connecting the origin of frame_a and the origin of frame_b.
This point mass approximates the <b>mass</b> of the <b>force element</b>.
The distance of the point mass from frame_a as a fraction of the
distance between frame_a and frame_b is defined via
parameter <b>lengthFraction</b> (default is 0.5, i.e., the point
mass is in the middle of the line).
</p>
<p>
In the translational library there is the implicit assumption that
forces of components that have only one flange connector act with
opposite sign on the bearings of the component. This assumption
is also used in the LineForceWithMass component: If a connection
is present to only one of the flange connectors, then the force
in this flange connector acts implicitly with opposite sign also
in the other flange connector.
</p>
</html>"));
    
  protected 
    SI.Force fa "Force from flange_a";
    SI.Force fb "Force from flange_b";
    SI.Position r_CM_0[3](stateSelect=StateSelect.avoid) 
      "Position vector from world frame to point mass, resolved in world frame";
    SI.Velocity v_CM_0[3](stateSelect=StateSelect.avoid) 
      "First derivative of r_CM_0";
    SI.Acceleration ag_CM_0[3] "der(v_CM_0) - gravityAcceleration";
    
    Visualizers.Advanced.Shape lineShape(
      shapeType=lineShapeType,
      color=lineShapeColor,
      specularCoefficient=specularCoefficient,
      length=length,
      width=lineShapeWidth,
      height=lineShapeHeight,
      lengthDirection=e_rel_0,
      widthDirection=Frames.resolve1(frame_a.R, {0,1,0}),
      extra=lineShapeExtra,
      r=frame_a.r_0) if world.enableAnimation and animateLine;
    
    Visualizers.Advanced.Shape massShape(
      shapeType="sphere",
      color=massColor,
      specularCoefficient=specularCoefficient,
      length=massDiameter,
      width=massDiameter,
      height=massDiameter,
      lengthDirection=e_rel_0,
      widthDirection={0,1,0},
      r_shape=e_rel_0*(length*lengthFraction - massDiameter/2),
      r=frame_a.r_0) if world.enableAnimation and animateMass and m > 0;
  equation 
    definePotentialRoot(frame_a.R, 100);
    definePotentialRoot(frame_b.R, 100);
    assert(noEvent(length > s_small), "
The distance between the origin of frame_a and the origin of frame_b
of a LineForceWithMass component became smaller as parameter s_small
(= a small number, defined in the \"Advanced\" menu). The distance is
set to s_small, although it is smaller, to avoid a division by zero
when computing the direction of the line force. Possible reasons
for this situation:
- At initial time the distance may already be zero: Change the initial
  positions of the bodies connected by this element.
- Hardware stops are not modeled or are modeled not stiff enough.
  Include stops, e.g., stiff springs, or increase the stiffness
  if already present.
- Another error in your model may lead to unrealistically large forces
  and torques that would in reality destroy the stops.
- The flange_b connector might be defined by a pre-defined motion,
  e.g., with Modelica.Mechanics.Translational.Position and the
  predefined flange_b.s is zero or negative.
");
    
    // Determine relative position vector between the two frames
    r_rel_0 = frame_b.r_0 - frame_a.r_0;
    length = Frames.length(r_rel_0);
    flange_a.s = 0;
    flange_b.s = length;
    e_rel_0 = r_rel_0/Frames.Internal.maxWithoutEvent(length, s_small);
    
    // Determine translational flange forces
    if cardinality(flange_a) > 0 and cardinality(flange_b) > 0 then
      fa = flange_a.f;
      fb = flange_b.f;
    elseif cardinality(flange_a) > 0 and cardinality(flange_b) == 0 then
      fa = flange_a.f;
      fb = -fa;
    elseif cardinality(flange_a) == 0 and cardinality(flange_b) > 0 then
      fa = -fb;
      fb = flange_b.f;
    else
      fa = 0;
      fb = 0;
    end if;
    
    /* Force and torque balance of point mass
     - Kinematics for center of mass CM of point mass including gravity
       r_CM_0 = frame_a.r0 + r_rel_CM_0;
       v_CM_0 = der(r_CM_0);
       ag_CM_0 = der(v_CM_0) - world.gravityAcceleration(r_CM_0);
     - Power balance for the connection line
       (f1=force on frame_a side, f2=force on frame_b side, h=lengthFraction)
       0 = f1*va - m*ag_CM*(va+(vb-va)*h) + f2*vb
         = (f1 - m*ag_CM*(1-h))*va + (f2 - m*ag_CM*h)*vb
       since va and vb are completely indepedent from other
       the paranthesis must vanish:
         f1 := m*ag_CM*(1-h)
         f2 := m*ag_CM*h
     - Force balance on frame_a and frame_b finally results in
         0 = frame_a.f + e_rel_a*fa - f1_a
         0 = frame_b.f + e_rel_b*fb - f2_b
       and therefore
         frame_a.f = -e_rel_a*fa + m*ag_CM_a*(1-h)
         frame_b.f = -e_rel_b*fb + m*ag_CM_b*h
  */
    if m > 0 then
      r_CM_0 = frame_a.r_0 + r_rel_0*lengthFraction;
      v_CM_0 = der(r_CM_0);
      ag_CM_0 = der(v_CM_0) - world.gravityAcceleration(r_CM_0);
      frame_a.f = Frames.resolve2(frame_a.R, (m*(1 - lengthFraction))*ag_CM_0
         - e_rel_0*fa);
      frame_b.f = Frames.resolve2(frame_b.R, (m*lengthFraction)*ag_CM_0 -
        e_rel_0*fb);
    else
      r_CM_0 = zeros(3);
      v_CM_0 = zeros(3);
      ag_CM_0 = zeros(3);
      frame_a.f = -Frames.resolve2(frame_a.R, e_rel_0*fa);
      frame_b.f = -Frames.resolve2(frame_b.R, e_rel_0*fb);
    end if;
    
    // Provide appropriate equations, if direct connections of line forces
    if isRoot(frame_a.R) then
      frame_a.R = Frames.nullRotation();
    else
      frame_a.t = zeros(3);
    end if;
    
    if isRoot(frame_b.R) then
      frame_b.R = Frames.nullRotation();
    else
      frame_b.t = zeros(3);
    end if;
  end LineForceWithMass;
  
  model LineForceWithTwoMasses 
    "General line force component with two optional point masses on the connection line" 
    
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    
    extends Interfaces.PartialTwoFrames;
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_b 
      "1-dim. translational flange (connect force of Translational library between flange_a and flange_b)"
      annotation (extent=[50, 100; 70, 120], rotation=90);
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange_a 
      "1-dim. translational flange (connect force of Translational library between flange_a and flange_b)"
      annotation (extent=[-70, 100; -50, 120], rotation=90);
    
    parameter Boolean animate=true "= true, if animation shall be enabled";
    parameter Boolean animateMasses=true 
      "= true, if point masses shall be visualized provided animate=true and m_a, m_b > 0";
    parameter SI.Mass m_a(min=0)=0 
      "Mass of point mass a on the connetion line between the origin of frame_a and the origin of frame_b";
    parameter SI.Mass m_b(min=0)=0 
      "Mass of point mass b on the connetion line between the origin of frame_a and the origin of frame_b";
    parameter SI.Position L_a=0 
      "Distance between point mass a and frame_a (positive, if in direction of frame_b)";
    parameter SI.Position L_b=L_a 
      "Distance between point mass b and frame_b (positive, if in direction of frame_a)";
    input SI.Diameter cylinderDiameter_a=world.defaultForceWidth 
      " Diameter of cylinder at frame_a" 
      annotation (Dialog(tab="Animation", group="Cylinder at frame_a if animation = true", enable=animate));
    parameter SI.Length cylinderLength_a=2*L_a " Length of cylinder at frame_a"
      annotation (Dialog(tab="Animation", group="Cylinder at frame_a if animation = true", enable=animate));
    input Types.Color color_a={155,155,155} " Color of cylinder at frame_a" 
      annotation (Dialog(tab="Animation", group="Cylinder at frame_a if animation = true", enable=animate));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(tab="Animation", group="Cylinder at frame_a if animation = true", enable=animate));
    input Real diameterFraction=0.8 
      " Diameter of cylinder at frame_b with respect to diameter of cylinder at frame_a"
      annotation (Dialog(tab="Animation", group="Cylinder at frame_b if animation = true", enable=animate));
    parameter SI.Length cylinderLength_b=2*L_b " Length of cylinder at frame_b"
      annotation (Dialog(tab="Animation", group="Cylinder at frame_b if animation = true", enable=animate));
    input Types.Color color_b={100,100,100} " Color of cylinder at frame_b" 
      annotation (Dialog(tab="Animation", group="Cylinder at frame_b if animation = true", enable=animate));
    input Real massDiameterFaction=1.7 
      " Diameter of point mass spheres with respect to cylinderDiameter_a" 
      annotation (Dialog(tab="Animation", group="if animation = true and animateMasses = true", enable=animate and animateMasses));
    input Types.Color massColor=Types.Defaults.BodyColor 
      " Color of point masses" 
      annotation (Dialog(tab="Animation", group="if animation = true and animateMasses = true", enable=animate and animateMasses));
    parameter SI.Position s_small=1.E-10 
      " Prevent zero-division if distance between frame_a and frame_b is zero" 
      annotation (Dialog(tab="Advanced"));
    SI.Distance length 
      "Distance between the origin of frame_a and the origin of frame_b";
    SI.Position r_rel_0[3] 
      "Position vector from frame_a to frame_b resolved in world frame";
    SI.Position e_rel_0[3] 
      "Unit vector in direction from frame_a to frame_b, resolved in world frame";
    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.24,
        y=0.02,
        width=0.69,
        height=0.78),
      Icon(
        Ellipse(extent=[-100, -40; -20, 40], style(
            color=10,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[-90, -30; -30, 30], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[20, -40; 100, 40], style(
            color=10,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[31, -29; 91, 30], style(
            color=10,
            fillColor=7,
            fillPattern=1)),
        Text(extent=[-145, -53; 145, -113], string="%name"),
        Rectangle(extent=[-52, 40; 48, -40], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[-74, 15; -45, -13], style(
            color=0,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[45, 14; 74, -14], style(
            color=0,
            gradient=3,
            fillColor=8)),
        Line(points=[-60, 0; -60, 23; -30, 23; -30, 70; -60, 70; -60, 101],
            style(color=0)),
        Line(points=[60, 0; 60, 20; 30, 20; 30, 70; 60, 70; 60, 100], style(
              color=0)),
        Line(points=[-23, 0; 25, 0], style(color=0, pattern=3)),
        Ellipse(extent=[23, 8; 39, -8], style(color=0, fillColor=0)),
        Ellipse(extent=[-39, 8; -23, -8], style(color=0, fillColor=0)),
        Line(points=[-60, 0; -29, 0], style(color=0)),
        Line(points=[29, 0; 60, 0], style(color=0))),
      Diagram(
        Line(points=[-60, 80; 46, 80]),
        Polygon(points=[60, 80; 45, 86; 45, 74; 60, 80], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Text(extent=[-22, 100; 20, 76], string="length"),
        Ellipse(extent=[-100, -40; -20, 40], style(
            color=10,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[-90, -30; -30, 30], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[20, -40; 100, 40], style(
            color=10,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[31, -29; 91, 30], style(
            color=10,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-49, 39; 51, -41], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[-74, 15; -45, -13], style(
            color=0,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[45, 15; 74, -13], style(
            color=0,
            gradient=3,
            fillColor=8)),
        Line(points=[-60, 0; -60, 24; -40, 24; -40, 60; -60, 60; -60, 100],
            style(color=0)),
        Line(points=[60, 1; 60, 21; 40, 21; 40, 60; 60, 60; 60, 100], style(
              color=0)),
        Line(points=[-60, 0; 60, 0], style(color=0, pattern=3)),
        Ellipse(extent=[20, 8; 36, -8], style(color=0, fillColor=0)),
        Line(points=[-18, -18; 11, -18], style(fillColor=0, fillPattern=1)),
        Polygon(points=[23, -18; 11, -15; 11, -21; 23, -18], style(
              fillPattern=
                7)),
        Line(points=[-60, 16; -37, 16], style(fillColor=0, fillPattern=1)),
        Line(points=[-25, 0; -25, 20], style(fillColor=0, fillPattern=1)),
        Text(
          extent=[-16, -19; 20, -44],
          style(gradient=0, fillPattern=0),
          string="e_rel_0"),
        Polygon(points=[-25, 16; -37, 19; -37, 13; -25, 16], style(
              fillPattern=
                7)),
        Text(
          extent=[-39, 31; -22, 21],
          style(gradient=0, fillPattern=0),
          string="L_a"),
        Ellipse(extent=[-33, 7; -17, -9], style(color=0, fillColor=0)),
        Line(points=[29, 3; 29, 22], style(fillColor=0, fillPattern=1)),
        Line(points=[29, 16; 60, 16], style(fillColor=0, fillPattern=1)),
        Polygon(points=[29, 16; 41, 19; 41, 13; 29, 16], style(
              fillPattern =                                                7)),
        Text(
          extent=[15, 36; 32, 26],
          style(gradient=0, fillPattern=0),
          string="L_b"),
        Line(points=[37, 18; 30, 27], style(pattern=3))),
      Documentation(info="<html>
<p>
This component is used to exert a <b>line force</b>
between the origin of frame_a and the origin of frame_b
by attaching components of the <b>1-dimensional translational</b>
mechanical library of Modelica (Modelica.Mechanics.Translational)
between the two flange connectors <b>flange_a</b> and
<b>flange_b</b>. Optionally, there are <b>two point masses</b> on the line
connecting the origin of frame_a and the origin of frame_b.
These point masses approximate the <b>masses</b> of the <b>force element</b>.
The locations of the two point masses are defined by their 
(fixed) distances of L_a relative to frame_a and of L_b relative
to frame_b, respectively. 
</p>
<p>
In example 
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.LineForceWithTwoMasses\">
MultiBody.Examples.Elementary.LineForceWithTwoMasses</a> the usage of this
line force element is shown and is compared with an alternative 
implementation using a 
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS\">
MultiBody.Joints.Assemblies.JointUPS</a> component.
The composition diagram of this example
is displayed in the figure below.
</p>
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/LineForceWithTwoMasses1.png\">
<p>
The animation view at time = 0 is shown in the next figure.
The system on the left side in the front is the animation with
the LineForceWithTwoMasses component whereas the system on the right
side in the back is the animation with the JointUPS component.
Both implementations yield the same result. However, the implementation
with the LineForceWithTwoMasses component is simpler.
</p>
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/LineForceWithTwoMasses2.png\">
<p>
In the translational library there is the implicit assumption that
forces of components that have only one flange connector act with
opposite sign on the bearings of the component. This assumption
is also used in the LineForceWithTwoMasses component: If a connection
is present to only one of the flange connectors, then the force
in this flange connector acts implicitly with opposite sign also
in the other flange connector.
</p>
</html>"));
    
  protected 
    SI.Force fa "Force from flange_a";
    SI.Force fb "Force from flange_b";
    SI.Position r_CM1_0[3](stateSelect=StateSelect.avoid) 
      "Position vector from world frame to point mass 1, resolved in world frame";
    SI.Position r_CM2_0[3](stateSelect=StateSelect.avoid) 
      "Position vector from world frame to point mass 2, resolved in world frame";
    SI.Velocity v_CM1_0[3](stateSelect=StateSelect.avoid) 
      "der(r_CM_1_0) - velocity of point mass 1";
    SI.Velocity v_CM2_0[3](stateSelect=StateSelect.avoid) 
      "der(r_CM_2_0) - velocity of point mass 2";
    SI.Acceleration ag_CM1_0[3] "der(v_CM1_0) - gravityAcceleration(r_CM1_0)";
    SI.Acceleration ag_CM2_0[3] "der(v_CM2_0) - gravityAcceleration(r_CM2_0)";
    SI.Force aux1_0[3] "Auxiliary force 1";
    SI.Force aux2_0[3] "Auxiliary force 2";
    
    input SI.Length cylinderDiameter_b=cylinderDiameter_a*diameterFraction;
    input SI.Length massDiameter=cylinderDiameter_a*massDiameterFaction;
    parameter Boolean animateMasses2=world.enableAnimation and animate and animateMasses and m_a > 0 and m_b > 0;
    Visualizers.Advanced.Shape cylinder_a(
      shapeType="cylinder",
      color=color_a,
      specularCoefficient=specularCoefficient,
      length=cylinderLength_a,
      width=cylinderDiameter_a,
      height=cylinderDiameter_a,
      lengthDirection=e_rel_0,
      widthDirection={0,1,0},
      r=frame_a.r_0) if world.enableAnimation and animate;
    
    Visualizers.Advanced.Shape cylinder_b(
      shapeType="cylinder",
      color=color_b,
      specularCoefficient=specularCoefficient,
      length=cylinderLength_b,
      width=cylinderDiameter_b,
      height=cylinderDiameter_b,
      lengthDirection=-e_rel_0,
      widthDirection={0,1,0},
      r=frame_b.r_0) if world.enableAnimation and animate;
    
    Visualizers.Advanced.Shape sphere_a(
      shapeType="sphere",
      color=massColor,
      specularCoefficient=specularCoefficient,
      length=massDiameter,
      width=massDiameter,
      height=massDiameter,
      lengthDirection=e_rel_0,
      widthDirection={0,1,0},
      r_shape=e_rel_0*(L_a - massDiameter/2),
      r=frame_a.r_0) if animateMasses2;
    
    Visualizers.Advanced.Shape sphere_b(
      shapeType="sphere",
      color=massColor,
      specularCoefficient=specularCoefficient,
      length=massDiameter,
      width=massDiameter,
      height=massDiameter,
      lengthDirection=-e_rel_0,
      widthDirection={0,1,0},
      r_shape=-e_rel_0*(L_b - massDiameter/2),
      r=frame_b.r_0) if animateMasses2;
  equation 
    definePotentialRoot(frame_a.R, 100);
    definePotentialRoot(frame_b.R, 100);
    assert(noEvent(length > s_small), "
The distance between the origin of frame_a and the origin of frame_b
of a LineForceWithTwoMasses component became smaller as parameter s_small
(= a small number, defined in the \"Advanced\" menu). The distance is
set to s_small, although it is smaller, to avoid a division by zero
when computing the direction of the line force. Possible reasons
for this situation:
- At initial time the distance may already be zero: Change the initial
  positions of the bodies connected by this element.
- Hardware stops are not modeled or are modeled not stiff enough.
  Include stops, e.g., stiff springs, or increase the stiffness
  if already present.
- Another error in your model may lead to unrealistically large forces
  and torques that would in reality destroy the stops.
- The flange_b connector might be defined by a pre-defined motion,
  e.g., with Modelica.Mechanics.Translational.Position and the
  predefined flange_b.s is zero or negative.
");
    
    // Determine relative position vector between the two frames
    r_rel_0 = frame_b.r_0 - frame_a.r_0;
    length = Frames.length(r_rel_0);
    flange_a.s = 0;
    flange_b.s = length;
    e_rel_0 = r_rel_0/Frames.Internal.maxWithoutEvent(length, s_small);
    
    // Determine translational flange forces
    if cardinality(flange_a) > 0 and cardinality(flange_b) > 0 then
      fa = flange_a.f;
      fb = flange_b.f;
    elseif cardinality(flange_a) > 0 and cardinality(flange_b) == 0 then
      fa = flange_a.f;
      fb = -fa;
    elseif cardinality(flange_a) == 0 and cardinality(flange_b) > 0 then
      fa = -fb;
      fb = flange_b.f;
    else
      fa = 0;
      fb = 0;
    end if;
    
    /* Force and torque balance of the two point masses
     - Kinematics for center of masses CM1, CM2 of point masses including gravity
       (L = length, va = der(frame_a.r_0), vb = der(frame_b.r_0))
       r_CM1_0 = frame_a.r_0 + e_rel_0*L_a;
       r_CM2_0 = frame_b.r_0 - e_rel_0*L_b;
       v_CM1_0 = der(r_CM1_0);
       v_CM2_0 = der(r_CM2_0);
       ag_CM1_0 = der(v_CM1_0) - world.gravityAcceleration(r_CM1_0);
       ag_CM2_0 = der(v_CM2_0) - world.gravityAcceleration(r_CM2_0);
       der(e_rel_0) = der(r_rel_0/sqrt(r_rel_0*r_rel_0))
                    = 1/L*(I - e_rel_0*e_rel_0')*der(r_rel_0)
                    = 1/L*(I - e_rel_0*e_rel_0')*(vb - va)
       v_CM1_0 = va + L_a/L*(I - e_rel_0*e_rel_0')*(vb - va)
       v_CM2_0 = vb - L_b/L*(I - e_rel_0*e_rel_0')*(vb - va)
     - Power balance for the connection line
       (f1=force on frame_a side, f2=force on frame_b side)
       0 = f1*va - m_a*ag_CM1*v_CM1 + f2*vb - m_b*ag_CM2*v_CM2
         = f1*va - m_a*ag_CM1*(va + L_a/L*(I - e_rel*e_rel')*(vb - va)) +
           f2*vb - m_b*ag_CM2*(vb - L_b/L*(I - e_rel*e_rel')*(vb - va))
         = (f1 - m_a*ag_CM1*(I - L_a/L*(I - e_rel*e_rel'))
               - m_b*ag_CM2*(L_b/L*(I - e_rel*e_rel')))*va +
           (f2 - m_b*ag_CM2*(I - L_b/L*(I - e_rel_0*e_rel_0'))
               - m_a*ag_CM1*(L_a/L*(I - e_rel*e_rel')))*vb
         = va*(f1 - m_a*ag_CM1 + 
               (m_a*ag_CM1*L_a/L - m_b*ag_CM2*L_b/L)*(I - e_rel*e_rel')) +
           vb*(f2 - m_b*ag_CM2 +
               (m_b*ag_CM2*L_b/L - m_a*ag_CM1*L_a/L)*(I - e_rel*e_rel')) 
       since va and vb are completely independent from other
       the paranthesis must vanish:
         f1 := m_a*ag_CM1 - (m_a*ag_CM1*L_a/L - m_b*ag_CM2*L_b/L)*(I - e_rel*e_rel')
         f2 := m_b*ag_CM2 + (m_a*ag_CM1*L_a/L - m_b*ag_CM2*L_b/L)*(I - e_rel*e_rel')
       or
         aux1 := ag_CM1*(m_a*L_a/L) - ag_CM2*(m_b*L_b/L);
         aux2 := aux1 - (aux1'*e_rel)*e_rel
         f1 := m_a*ag_CM1 - aux2
         f2 := m_b*ag_CM2 + aux2
     - Force balance on frame_a and frame_b finally results in
         0 = frame_a.f + e_rel_a*fa - f1_a
         0 = frame_b.f + e_rel_b*fb - f2_b
       and therefore
         frame_a.f = -e_rel_a*fa + m_a*ag_CM1 - aux2
         frame_b.f = -e_rel_b*fb + m_b*ag_CM2 + aux2
  */
    if m_a > 0 or m_b > 0 then
      r_CM1_0 = frame_a.r_0 + e_rel_0*L_a;
      r_CM2_0 = frame_b.r_0 - e_rel_0*L_b;
      v_CM1_0 = der(r_CM1_0);
      v_CM2_0 = der(r_CM2_0);
      ag_CM1_0 = der(v_CM1_0) - world.gravityAcceleration(r_CM1_0);
      ag_CM2_0 = der(v_CM2_0) - world.gravityAcceleration(r_CM2_0);
      aux1_0 = ag_CM1_0*(m_a*L_a/length) - ag_CM2_0*(m_b*L_b/length);
      aux2_0 = aux1_0 - (aux1_0*e_rel_0)*e_rel_0;
      frame_a.f = Frames.resolve2(frame_a.R, m_a*ag_CM1_0 - aux2_0 - e_rel_0*fa);
      frame_b.f = Frames.resolve2(frame_b.R, m_b*ag_CM2_0 + aux2_0 - e_rel_0*fb);
    else
      r_CM1_0 = zeros(3);
      r_CM2_0 = zeros(3);
      v_CM1_0 = zeros(3);
      v_CM2_0 = zeros(3);
      ag_CM1_0 = zeros(3);
      ag_CM2_0 = zeros(3);
      aux1_0 = zeros(3);
      aux2_0 = zeros(3);
      frame_a.f = -Frames.resolve2(frame_a.R, e_rel_0*fa);
      frame_b.f = -Frames.resolve2(frame_b.R, e_rel_0*fb);
    end if;
    
    // Provide appropriate equations, if direct connections of line forces
    if isRoot(frame_a.R) then
      frame_a.R = Frames.nullRotation();
    else
      frame_a.t = zeros(3);
    end if;
    
    if isRoot(frame_b.R) then
      frame_b.R = Frames.nullRotation();
    else
      frame_b.t = zeros(3);
    end if;
  end LineForceWithTwoMasses;
  
  model Spring "Linear translational spring with optional mass" 
    import Modelica.Mechanics.MultiBody.Types;
    extends Interfaces.PartialTwoFrames;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Boolean showMass=true 
      "= true, if point mass shall be visualized as sphere if animation=true and m>0";
    
    parameter Real c(final unit="N/m", final min=0) "Spring constant";
    parameter SI.Length s_unstretched=0 "Unstretched spring length";
    parameter SI.Mass m(min=0)=0 
      "Spring mass located on the connetion line between the origin of frame_a and the origin of frame_b";
    parameter Real lengthFraction(
      min=0,
      max=1) = 0.5 
      "Location of spring mass with respect to frame_a as a fraction of the distance from frame_a to frame_b (=0: at frame_a; =1: at frame_b)";
    input SI.Distance width=world.defaultForceWidth " Width of spring" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input SI.Distance coilWidth=width/10 " Width of spring coil" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter Integer numberOfWindings=5 " Number of spring windings" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.Color color=Types.Defaults.SpringColor " Color of spring" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Real massDiameter=max(0, (width - 2*coilWidth)*0.9) 
      " Diameter of mass point sphere" annotation (Dialog(tab="Animation", group=
            "if animation = true and showMass = true", enable=animation and showMass));
    input Types.Color massColor=Types.Defaults.BodyColor " Color of mass point"
                             annotation (Dialog(tab="Animation", group=
            "if animation = true and showMass = true", enable=animation and showMass));
    
    Forces.LineForceWithMass lineForce(
      animateLine=animation,
      animateMass=showMass,
      m=m,
      lengthFraction=lengthFraction,
      lineShapeType="spring",
      lineShapeHeight=coilWidth*2,
      lineShapeWidth=width,
      lineShapeExtra=numberOfWindings,
      lineShapeColor=color,
      specularCoefficient=specularCoefficient,
      massDiameter=massDiameter,
      massColor=massColor) annotation (extent=[-20, -20; 20, 20]);
    Modelica.Mechanics.Translational.Spring spring(s_rel0=s_unstretched, c=c) 
      annotation (extent=[-8, 40; 12, 60]);
  equation 
    connect(lineForce.frame_a, frame_a) 
      annotation (points=[-20,0; -100,0], style(
        color=10,
        rgbcolor={95,95,95},
        thickness=2));
    connect(lineForce.frame_b, frame_b) 
      annotation (points=[20,0; 100,0], style(
        color=10,
        rgbcolor={95,95,95},
        thickness=2));
    connect(spring.flange_b, lineForce.flange_b) 
      annotation (points=[12,50; 12,20],   style(color=58));
    connect(spring.flange_a, lineForce.flange_a) 
      annotation (points=[-8,50; -12,50; -12,20],    style(color=58));
    annotation (
      preferedView="info",
      Icon(
        Line(points=[-100, 0; -58, 0; -43, -30; -13, 30; 17, -30; 47, 30; 62, 0;
               100, 0], style(
            color=0,
            pattern=1,
            thickness=1,
            arrow=0)),
        Text(extent=[-130, 49; 132, 109], string="%name"),
        Text(
          extent=[-141, -92; 125, -51],
          string="c=%c",
          style(color=0)),
        Ellipse(extent=[-8, 8; 8, -8], style(color=0, fillColor=0))),
      Diagram,
      Documentation(info="<HTML>
<p>
<b>Linear spring</b> acting as line force between frame_a and frame_b.
A <b>force f</b> is exerted on the origin of frame_b and with opposite sign
on the origin of frame_a along the line from the origin of frame_a to the origin
of frame_b according to the equation:
</p>
<pre>
   f = c*(s - s_unstretched);
</pre>
<p>
where \"c\" and \"s_unstretched\" are parameters and \"s\" is the
distance between the origin of frame_a and the origin of frame_b.
</p>
<p>
Optionally, the mass of the spring is taken into account by a
point mass located on the line between frame_a and frame_b
(default: middle of the line). If the spring mass is zero, the
additional equations to handle the mass are removed.
</p>
<p>
In the following figure a typical animation of the
spring is shown. The blue sphere in the middle of the
spring characterizes the the location of the point mass.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/SpringWithMass.png\" 
ALT=\"model Examples.Elementary.SpringWithMass\">
</p>
</HTML>"));
  end Spring;
  
  model Damper "Linear (velocity dependent) damper" 
    import Modelica.Mechanics.MultiBody.Types;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Real d(
      final unit="N.s/m",
      final min=0) = 0 "Damping constant";
    parameter SI.Distance length_a=world.defaultForceLength 
      " Length of cylinder at frame_a side" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input SI.Distance diameter_a=world.defaultForceWidth 
      " Diameter of cylinder at frame_a side" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Real diameter_b=0.6*diameter_a 
      " Diameter of cylinder at frame_b side" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.Color color_a={100,100,100} " Color at frame_a" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation, colorSelector));
    input Types.Color color_b={155,155,155} " Color at frame_b" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation, colorSelector));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    extends Interfaces.PartialLineForce;
    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.32,
        y=0.29,
        width=0.6,
        height=0.6),
      Documentation(info="<HTML>
<p>
<b>Linear damper</b> acting as line force between frame_a and frame_b.
A <b>force f</b> is exerted on the origin of frame_b and with opposite sign
on the origin of frame_a along the line from the origin of frame_a to the origin
of frame_b according to the equation:
</p>
<pre>
   f = d*<b>der</b>(s);
</pre>
<p>
where \"d\" is a parameter, \"s\" is the
distance between the origin of frame_a and the origin of frame_b
and der(s) is the time derivative of \"s\".
</p>
<p>
In the following figure a typical animation is shown
where a mass is hanging on a damper.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Forces/Damper.png\">
</p>
</HTML>"),
      Icon(
        Line(points=[-101, 0; -60, 0], style(color=0)),
        Line(points=[-60, -30; -60, 30], style(color=0)),
        Line(points=[-60, -30; 60, -30], style(color=0)),
        Line(points=[-60, 30; 60, 30], style(color=0)),
        Rectangle(extent=[-60, 30; 30, -30], style(color=0, fillColor=8)),
        Line(points=[30, 0; 100, 0], style(color=0)),
        Text(extent=[-140, 47; 145, 105], string="%name"),
        Text(
          extent=[-156, -96; 152, -53],
          style(color=0),
          string="d=%d")),
      Diagram(
        Line(points=[-100, 0; -60, 0], style(color=0)),
        Line(points=[-60, -30; -60, 30], style(color=0)),
        Line(points=[-60, -30; 60, -30], style(color=0)),
        Line(points=[-60, 30; 60, 30], style(color=0)),
        Rectangle(extent=[-60, 30; 30, -30], style(color=0, fillColor=8)),
        Line(points=[30, 0; 100, 0], style(color=0)),
        Line(points=[-50, 60; 50, 60], style(color=10)),
        Text(
          extent=[-20, 60; 10, 85],
          style(color=10),
          string="der(s)"),
        Polygon(points=[64, 60; 42, 68; 42, 52; 62, 60; 64, 60], style(
            color=10,
            fillColor=9,
            fillPattern=1))));
    
  protected 
    SI.Position r0_b[3]=e_a*noEvent(min(length_a, s));
    Visualizers.Advanced.Shape shape_a(
      shapeType="cylinder",
      color=color_a,
      specularCoefficient=specularCoefficient,
      length=noEvent(min(length_a, s)),
      width=diameter_a,
      height=diameter_a,
      lengthDirection=e_a,
      widthDirection={0,1,0},
      r=frame_a.r_0,
      R=frame_a.R) if 
                     world.enableAnimation and animation;
    Visualizers.Advanced.Shape shape_b(
      shapeType="cylinder",
      color=color_b,
      specularCoefficient=specularCoefficient,
      length=noEvent(max(s - length_a, 0)),
      width=diameter_b,
      height=diameter_b,
      lengthDirection=e_a,
      widthDirection={0,1,0},
      r_shape=r0_b,
      r=frame_a.r_0,
      R=frame_a.R) if world.enableAnimation and animation;
  equation 
    f = d*der(s);
  end Damper;
  
  model SpringDamperParallel "Linear spring and linear damper in parallel" 
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Real c(final unit="N/m", final min=0) "Spring constant";
    parameter SI.Length s_unstretched=0 "Unstretched spring length";
    parameter Real d(
      final unit="N.s/m",
      final min=0) = 0 "Damping constant";
    input SI.Distance width=world.defaultForceWidth " Width of spring" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input SI.Distance coilWidth=width/10 " Width of spring coil" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter Integer numberOfWindings=5 " Number of spring windings" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.Color color=Types.Defaults.SpringColor " Color of spring" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient 
      "Reflection of ambient light (= 0: light is completely absorbed)" 
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    extends Interfaces.PartialLineForce;
    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.34,
        y=0.26,
        width=0.6,
        height=0.6),
      Documentation(info="<HTML>
<p>
<b>Linear spring</b> and <b>dinear damper</b>
in parallel acting as line force between frame_a and frame_b.
A <b>force f</b> is exerted on the origin of frame_b and with opposite sign
on the origin of frame_a along the line from the origin of frame_a to the origin
of frame_b according to the equation:
</p>
<pre>
   f = c*(s - s_unstretched) + d*<b>der</b>(s);
</pre>
<p>
where \"c\", \"s_unstretched\" and \"d\" are parameters, \"s\" is the
distance between the origin of frame_a and the origin of frame_b
and der(s) is the time derivative of s.
</p>
</HTML>
"),   Icon(
        Text(extent=[-131, -166; 114, -108], string="%name"),
        Line(points=[-80, 40; -60, 40; -45, 10; -15, 70; 15, 10; 45, 70; 60, 40;
               80, 40], style(color=0)),
        Line(points=[-80, 40; -80, -70], style(color=0)),
        Line(points=[-80, -70; -52, -70], style(color=0)),
        Rectangle(extent=[-52, -40; 38, -100], style(color=0, fillColor=8)),
        Line(points=[-52, -40; 68, -40], style(color=0)),
        Line(points=[-52, -100; 68, -100], style(color=0)),
        Line(points=[38, -70; 80, -70], style(color=0)),
        Line(points=[80, 40; 80, -70], style(color=0)),
        Line(points=[-100, 0; -80, 0], style(color=0)),
        Line(points=[80, 0; 100, 0], style(color=0)),
        Text(
          extent=[-140, 72; 138, 108],
          style(color=0),
          string="c,d=%c,%d")),
      Diagram(
        Line(points=[-80, 32; -58, 32; -43, 2; -13, 62; 17, 2; 47, 62; 62, 32;
              80, 32], style(color=0, thickness=2)),
        Line(points=[-68, 32; -68, 97], style(color=10)),
        Line(points=[72, 32; 72, 97], style(color=10)),
        Line(points=[-68, 92; 72, 92], style(color=10)),
        Polygon(points=[62, 95; 72, 92; 62, 89; 62, 95], style(color=10,
              fillColor=10)),
        Text(
          extent=[-20, 72; 20, 97],
          string="s",
          style(color=3)),
        Rectangle(extent=[-52, -20; 38, -80], style(color=0, fillColor=8)),
        Line(points=[-52, -80; 68, -80], style(color=0)),
        Line(points=[-52, -20; 68, -20], style(color=0)),
        Line(points=[38, -50; 80, -50], style(color=0)),
        Line(points=[-80, -50; -52, -50], style(color=0)),
        Line(points=[-80, 32; -80, -50], style(color=0)),
        Line(points=[80, 32; 80, -50], style(color=0)),
        Line(points=[-100, 0; -80, 0], style(color=0)),
        Line(points=[100, 0; 80, 0], style(color=0))));
    
  protected 
    Visualizers.Advanced.Shape shape(
      shapeType="spring",
      color=color,
      length=s,
      width=width,
      height=coilWidth*2,
      lengthDirection=e_a,
      widthDirection={0,1,0},
      extra=numberOfWindings,
      r=frame_a.r_0,
      R=frame_a.R) if world.enableAnimation and animation;
  equation 
    f = c*(s - s_unstretched) + d*der(s);
  end SpringDamperParallel;
  
  model SpringDamperSeries 
    "Linear spring and linear damper in series connection" 
    import SI = Modelica.SIunits;
    parameter Real c(final unit="N/m", final min=0) "Spring constant";
    parameter SI.Length s_unstretched=0 "Unstretched spring length";
    parameter Real d(
      final unit="N.s/m",
      final min=0) = 0 "Damping constant";
    parameter SI.Length s_damper_start=0 "Initial length of damper";
    SI.Position s_damper(start=s_damper_start, fixed=true) 
      "Actual length of damper (frame_a - damper - spring - frame_b)";
    extends Interfaces.PartialLineForce;
    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.3,
        y=0.15,
        width=0.6,
        height=0.75),
      Documentation(info="<HTML>
<p>
<b>Linear spring</b> and <b>linear damper</b> in series connection
acting as line force between frame_a and frame_b:
</p>
<pre>
  frame_a --> damper ----> spring --> frame_b
          |              |
          |-- s_damper --|  (s_damper is the state variable of this system)
</pre>
<p>
A <b>force f</b> is exerted on the origin of frame_b and with opposite sign
on the origin of frame_a along the line from the origin of frame_a to the origin
of frame_b according to the equations:
</p>
<pre>
   f = c*(s - s_unstretched - s_damper);
   f = d*der(s_damper);
</pre>
<p>
where \"c\", \"s_unstretched\" and \"d\" are parameters, \"s\" is the
distance between the origin of frame_a and the origin of frame_b.
\"s_damper\" is the length of the damper (= an internal state of this
force element) and der(s_damper) is the time derivative of s_damper.
</p>
</HTML>
"),   Icon(
        Line(points=[-100, 0; -15, 0], style(color=0)),
        Line(points=[-60, -30; -15, -30], style(color=0)),
        Line(points=[-60, 30; -15, 30], style(color=0)),
        Rectangle(extent=[-60, 30; -30, -30], style(color=0, fillColor=8)),
        Line(points=[-15, 0; -5, 0; 5, -30; 25, 30; 45, -30; 65, 30; 75, 0; 100,
               0], style(color=0)),
        Text(extent=[-140, 47; 145, 105], string="%name"),
        Text(
          extent=[-148, -96; 160, -53],
          style(color=0),
          string="c,d=%c,%d")),
      Diagram(
        Line(points=[-100, 0; -15, 0], style(color=0)),
        Line(points=[-60, -30; -15, -30], style(color=0)),
        Line(points=[-60, 30; -15, 30], style(color=0)),
        Rectangle(extent=[-60, 30; -30, -30], style(color=0, fillColor=8)),
        Line(points=[-15, 0; -5, 0; 5, -30; 25, 30; 45, -30; 65, 30; 75, 0; 99,
               0], style(color=0)),
        Line(points=[-75, 0; -75, 85], style(color=9)),
        Line(points=[-10, 0; -10, 65], style(color=9)),
        Line(points=[80, 0; 80, 85], style(color=9)),
        Line(points=[-75, 80; 80, 80], style(color=9)),
        Line(points=[-75, 60; -10, 60], style(color=9)),
        Polygon(points=[-10, 60; -20, 65; -20, 55; -10, 60], style(
            color=9,
            fillColor=9,
            fillPattern=1)),
        Polygon(points=[80, 80; 70, 85; 70, 75; 80, 80], style(
            color=9,
            fillColor=9,
            fillPattern=1)),
        Text(
          extent=[-72, 63; -11, 78],
          style(color=9),
          string="s_damper"),
        Text(
          extent=[0, 80; 20, 100],
          string="s",
          style(color=9))));
  equation 
    f = c*(s - s_unstretched - s_damper);
    d*der(s_damper) = f;
  end SpringDamperSeries;
  
end Forces;
