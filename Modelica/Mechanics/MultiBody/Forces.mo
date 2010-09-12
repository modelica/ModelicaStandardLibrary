within Modelica.Mechanics.MultiBody;
package Forces "Components that exert forces and/or torques between frames"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.SourcesPackage;

  model WorldForce
    "External force acting at frame_b, defined by 3 input signals and resolved in frame world, frame_b or frame_resolve"

    import SI = Modelica.SIunits;
    extends Interfaces.PartialOneFrame_b;
    Interfaces.Frame_resolve frame_resolve if
         resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve
      "The input signals are optionally resolved in this frame"
      annotation (Placement(transformation(
          origin={0,-100},
          extent={{-16,-16},{16,16}},
          rotation=270)));
    Modelica.Blocks.Interfaces.RealInput force[3](each final quantity="Force", each final unit=
                     "N")
      "x-, y-, z-coordinates of force resolved in frame defined by resolveInFrame"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
            rotation=0)));
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world
      "Frame in which input force is resolved (1: world, 2: frame_b, 3: frame_resolve)";
    parameter Real N_to_m(unit="N/m") = world.defaultN_to_m
      "Force arrow scaling (length = force/N_to_m)"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter diameter=world.defaultArrowDiameter
      "Diameter of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor
      "Color of arrow"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(group="if animation = true", enable=animation));

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

  public
    Internal.BasicWorldForce basicWorldForce(resolveInFrame=resolveInFrame)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  protected
    Interfaces.ZeroPosition zeroPosition if
         not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve)
      annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  equation
    connect(basicWorldForce.frame_b, frame_b) annotation (Line(
        points={{10,0},{100,0}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(basicWorldForce.force, force) annotation (Line(
        points={{-12,0},{-120,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(basicWorldForce.frame_resolve, frame_resolve) annotation (Line(
        points={{0,-10},{0,-100}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    connect(zeroPosition.frame_resolve, basicWorldForce.frame_resolve)
      annotation (Line(
        points={{20,-30},{0,-30},{0,-10}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    annotation (defaultComponentName="force",
      Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}), graphics),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            extent={{-100,-46},{100,-76}},
            lineColor={192,192,192},
            textString="resolve"),
          Polygon(
            points={{-100,10},{50,10},{50,31},{94,0},{50,-31},{50,-10},{-100,-10},
                {-100,10}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,85},{150,45}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            points={{0,-10},{0,-95}},
            color={95,95,95},
            pattern=LinePattern.Dot)}),
      Documentation(info="<HTML>

<p>
The <b>3</b> signals of the <b>force</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>force</b> acting at the frame
connector to which frame_b of this component is attached.
Via parameter <b>resolveInFrame</b> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.ResolveInFrameB.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">world</td>
    <td valign=\"top\">Resolve input force in world frame (= default)</td></tr>

<tr><td valign=\"top\">frame_b</td>
    <td valign=\"top\">Resolve input force in frame_b</td></tr>

<tr><td valign=\"top\">frame_resolve</td>
    <td valign=\"top\">Resolve input force in frame_resolve (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameB.frame_resolve, the force coordinates
are with respect to the frame, that is connected to <b>frame_resolve</b>.
<p>

<p>
If force={100,0,0}, and for all parameters the default setting is used,
then the interpretation is that a force of 100 N is acting along the positive
x-axis of frame_b.
</p>

<p>
Note, the cut-torque in frame_b (frame_b.t) is always set to zero.
Conceptually, a force and torque acts on the world frame in such a way that
the force and torque balance between world.frame_b and frame_b is fulfilled.
For efficiency reasons, this reaction torque is, however, not computed.
</p>

<p>
This force component is by default visualized as an arrow
acting at the connector to which it is connected. The diameter
and color of the arrow can be defined via
variables <b>diameter</b> and <b>color</b>. The arrow
points in the direction defined by the
force signal. The length of the arrow is proportional
to the length of the force vector using parameter
<b>N_to_m</b> as scaling factor. For example, if N_to_m = 100 N/m,
then a force of 350 N is displayed as an arrow of length 3.5 m.
</p>
<p>
An example how to use this model is given in the
following figure:
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/WorldForce1.png\">

<p>
This leads to the following animation
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/WorldForce2.png\">


</HTML>
"));
  end WorldForce;

  model WorldTorque
    "External torque acting at frame_b, defined by 3 input signals and resolved in frame world, frame_b or frame_resolve"

    extends Interfaces.PartialOneFrame_b;

    Interfaces.Frame_resolve frame_resolve if
         resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve
      "The input signals are optionally resolved in this frame"
      annotation (Placement(transformation(
          origin={0,100},
          extent={{16,-16},{-16,16}},
          rotation=270)));
    Modelica.Blocks.Interfaces.RealInput torque[3](each final quantity="Torque", each final unit=
                     "N.m")
      "x-, y-, z-coordiantes of torque resolved in frame defined by resolveInFrame"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
            rotation=0)));
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world
      "Frame in which input torque is resolved (1: world, 2: frame_b, 3: frame_resolve)";
    parameter Real Nm_to_m(unit="N.m/m") = world.defaultNm_to_m
      "Torque arrow scaling (length = torque/Nm_to_m)"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter diameter=world.defaultArrowDiameter
      "Diameter of torque arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor
      "Color of arrow"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(group="if animation = true", enable=animation));

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
  public
    Internal.BasicWorldTorque basicWorldTorque(resolveInFrame=resolveInFrame)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  protected
    Interfaces.ZeroPosition zeroPosition if
         not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve)
      annotation (Placement(transformation(extent={{20,10},{40,30}})));
  equation
    connect(basicWorldTorque.frame_b, frame_b) annotation (Line(
        points={{10,0},{100,0}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(basicWorldTorque.torque, torque) annotation (Line(
        points={{-12,0},{-120,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(frame_resolve, basicWorldTorque.frame_resolve) annotation (Line(
        points={{0,100},{0,10}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    connect(zeroPosition.frame_resolve, basicWorldTorque.frame_resolve)
      annotation (Line(
        points={{20,20},{0,20},{0,10}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    annotation (defaultComponentName="torque",
      Documentation(info="<HTML>

<p>
The <b>3</b> signals of the <b>torque</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>torque</b> acting at the frame
connector to which frame_b of this component is attached.
Via parameter <b>resolveInFrame</b> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.ResolveInFrameB.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">world</td>
    <td valign=\"top\">Resolve input torque in world frame (= default)</td></tr>

<tr><td valign=\"top\">frame_b</td>
    <td valign=\"top\">Resolve input torque in frame_b</td></tr>

<tr><td valign=\"top\">frame_resolve</td>
    <td valign=\"top\">Resolve input torque in frame_resolve (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameB.frame_resolve, the torque coordinates
are with respect to the frame, that is connected to <b>frame_resolve</b>.
<p>

<p>
If torque={100,0,0}, and for all parameters the default setting is used,
then the interpretation is that a torque of 100 N is acting along the positive
x-axis of frame_b.
</p>

<p>
Note, the cut-force in frame_b (frame_b.f) is always set to zero.
Conceptually, a force and torque acts on the world frame in such a way that
the force and torque balance between world.frame_b and frame_b is fulfilled.
For efficiency reasons, this reaction torque is, however, not computed.
</p>

<p>
This torque component is by default visualized as a <b>double arrow</b>
acting at the connector to which it is connected. The diameter
and color of the arrow can be defined via
variables <b>diameter</b> and <b>color</b>. The double arrow points
in the direction defined by the
torque vector. The length of the double arrow is proportional
to the length of the torque vector using parameter
<b>Nm_to_m</b> as scaling factor. For example, if Nm_to_m = 100 Nm/m,
then a torque of 350 Nm is displayed as an arrow of length 3.5 m.
</p>
<p>
An example how to use this model is given in the
following figure:
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/WorldTorque1.png\">

<p>
This leads to the following animation
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/WorldTorque2.png\">

</HTML>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Text(
            extent={{-61,64},{46,27}},
            lineColor={192,192,192},
            textString="resolve"),
          Text(
            extent={{-150,-40},{150,-80}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            points={{0,95},{0,82}},
            color={95,95,95},
            pattern=LinePattern.Dot),
          Line(
            points={{-100,0},{-94,13},{-86,28},{-74,48},{-65,60},{-52,72},{-35,
                81},{-22,84},{-8,84},{7,80},{19,73},{32,65},{44,55},{52,47},{58,
                40}},
            color={0,0,0},
            thickness=0.5),
          Polygon(
            points={{94,10},{75,59},{41,24},{94,10}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics));
  end WorldTorque;

  model WorldForceAndTorque
    "External force and torque acting at frame_b, defined by 3+3 input signals and resolved in frame world, frame_b or in frame_resolve"

    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    extends Interfaces.PartialOneFrame_b;
    Interfaces.Frame_resolve frame_resolve if
         resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve
      "The input signals are optionally resolved in this frame"
      annotation (Placement(transformation(
          origin={0,100},
          extent={{16,-16},{-16,16}},
          rotation=270)));
    Blocks.Interfaces.RealInput force[3](each final quantity="Force", each final unit=
                     "N")
      "x-, y-, z-coordinates of force resolved in frame defined by resolveInFrame"
      annotation (Placement(transformation(extent={{-140,-80},{-100,-40}},
            rotation=0)));
    Blocks.Interfaces.RealInput torque[3](each final quantity="Torque", each final unit=
                     "N.m")
      "x-, y-, z-coordiantes of torque resolved in frame defined by resolveInFrame"
      annotation (Placement(transformation(extent={{-140,40},{-100,80}},
            rotation=0)));

    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world
      "Frame in which input force and torque are resolved (1: world, 2: frame_b, 3: frame_resolve)";

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
    input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor
      " Color of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor
      " Color of torque arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(group="if animation = true", enable=animation));

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
  public
    Internal.BasicWorldForce basicWorldForce(resolveInFrame=resolveInFrame)
      annotation (Placement(transformation(extent={{18,-50},{38,-70}})));
    Internal.BasicWorldTorque basicWorldTorque(resolveInFrame=resolveInFrame)
      annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  protected
    Interfaces.ZeroPosition zeroPosition if
         not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_resolve)
      annotation (Placement(transformation(extent={{58,70},{78,90}})));
  equation
    connect(basicWorldForce.frame_b, frame_b) annotation (Line(
        points={{38,-60},{60,-60},{60,0},{100,0}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(basicWorldForce.force, force) annotation (Line(
        points={{16,-60},{-120,-60}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(basicWorldTorque.frame_b, frame_b)
                                      annotation (Line(
        points={{10,60},{60,60},{60,0},{100,0}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(basicWorldTorque.torque, torque)
                                    annotation (Line(
        points={{-12,60},{-120,60}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(basicWorldForce.frame_resolve, frame_resolve) annotation (Line(
        points={{28,-50},{28,80},{0,80},{0,100}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    connect(basicWorldTorque.frame_resolve, frame_resolve)
                                                  annotation (Line(
        points={{0,70},{0,100}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    connect(zeroPosition.frame_resolve, basicWorldTorque.frame_resolve)
                                                               annotation (Line(
        points={{58,80},{0,80},{0,70}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    connect(zeroPosition.frame_resolve, basicWorldForce.frame_resolve)
      annotation (Line(
        points={{58,80},{40,80},{40,-40},{28,-40},{28,-50}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    annotation (defaultComponentName="forceAndTorque",
      Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}), graphics),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Text(
            extent={{-63,56},{44,19}},
            lineColor={192,192,192},
            textString="resolve"),
          Text(
            extent={{-150,-75},{150,-115}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            points={{-100,60},{-86,68},{-80,72},{-70,78},{-64,82},{-46,86},{-34,
                88},{-16,88},{-2,86},{12,80},{24,74},{34,68},{46,58},{52,54},{
                58,48}},
            color={0,0,0},
            thickness=0.5),
          Polygon(
            points={{89,17},{64,76},{30,41},{89,17}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{0,95},{0,-26}},
            color={95,95,95},
            pattern=LinePattern.Dot),
          Line(
            points={{0,0},{96,0}},
            color={95,95,95},
            pattern=LinePattern.Dot),
          Polygon(
            points={{-104,-48},{54,0},{46,20},{96,0},{66,-42},{60,-22},{-96,-72},
                {-104,-48}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<HTML>
<p>
The <b>3</b> signals of the <b>force</b> and <b>torque</b>
connector are interpreted
as the x-, y- and z-coordinates of a <b>force</b> and
<b>torque</b> acting at the frame
connector to which frame_b of this component is attached.
Via parameter <b>resolveInFrame</b> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.ResolveInFrameB.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">world</td>
    <td valign=\"top\">Resolve input forceand torque in world frame (= default)</td></tr>

<tr><td valign=\"top\">frame_b</td>
    <td valign=\"top\">Resolve input force and torque in frame_b</td></tr>

<tr><td valign=\"top\">frame_resolve</td>
    <td valign=\"top\">Resolve input force and torque in frame_resolve
                    (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameB.frame_resolve, the force and
torque coordinates
are with respect to the frame, that is connected to <b>frame_resolve</b>.
<p>

<p>
If force={100,0,0}, and for all parameters the default setting is used,
then the interpretation is that a force of 100 N is acting along the positive
x-axis of frame_b.
</p>

<p>
Conceptually, a force and torque acts on the world frame in such a way that
the force and torque balance between world.frame_b and frame_b is fulfilled.
For efficiency reasons, this reaction torque is, however, not computed.
</p>

<p>
The force and torque are by default visualized as an arrow (force)
and as a double arrow (torque) acting at the connector to which
they are connected. The diameters
and colors of the arrows can be defined via
variables <b>forceDiameter</b>, <b>torqueDiameter</b>,
<b>forceColor</b> and <b>torqueColor</b>. The arrows
point in the directions defined by the
force and torque vectors. The lengths of the arrows are proportional
to the length of the force and torque vectors, respectively, using parameters
<b>N_to_m</b> and <b>Nm_to_m</b> as scaling factors. For example, if N_to_m = 100 N/m,
then a force of 350 N is displayed as an arrow of length 3.5 m.
</p>
<p>
An example how to use this model is given in the
following figure:
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/WorldForceAndTorque1.png\">

<p>
This leads to the following animation
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/WorldForceAndTorque2.png\">

</HTML>
"),   Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Documentation(info="
An external force element exerts the inport signal
as negative force on the connector frame (the force vector
is resolved in the world frame).
"),   Icon(Text(extent=[-132, 99; 128, 39], string="%name",
          lineColor={0,0,255}),                              Polygon(points=[-100,
               10; 49, 10; 49, 31; 100, 0; 49, -31; 49, -10; -100, -10; -100,
              10],
          lineColor={0,0,255})),
      Diagram(Polygon(points=[-90, 10; 40, 10; 40, 31; 91, 0; 40, -31; 40, -10;
               -90, -10; -90, 10],
          lineColor={0,0,255})));
  end WorldForceAndTorque;

  model Force
    "Force acting between two frames, defined by 3 input signals and resolved in frame world, frame_a, frame_b or frame_resolve"

    import SI = Modelica.SIunits;
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
    Interfaces.Frame_resolve frame_resolve if
         resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
      "The input signals are optionally resolved in this frame"
      annotation (Placement(transformation(
          origin={40,100},
          extent={{-16,-16},{16,16}},
          rotation=90)));
    Modelica.Blocks.Interfaces.RealInput force[3](each final quantity="Force", each final unit=
                     "N")
      "x-, y-, z-coordinates of force resolved in frame defined by resolveInFrame"
      annotation (Placement(transformation(
          origin={-60,120},
          extent={{-20,-20},{20,20}},
          rotation=270)));
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
      resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b
      "Frame in which input force is resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";
    parameter Real N_to_m(unit="N/m") = world.defaultN_to_m
      " Force arrow scaling (length = force/N_to_m)"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter forceDiameter=world.defaultArrowDiameter
      " Diameter of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter connectionLineDiameter=forceDiameter
      " Diameter of line connecting frame_a and frame_b"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor
      " Color of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color connectionLineColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor
      " Color of line connecting frame_a and frame_b"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(group="if animation = true", enable=animation));

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
      lengthDirection=basicForce.r_0,
      widthDirection={0,1,0},
      length=Modelica.Math.Vectors.length(basicForce.r_0),
      width=connectionLineDiameter,
      height=connectionLineDiameter,
      color=connectionLineColor,
      specularCoefficient=specularCoefficient,
      r=frame_a.r_0) if world.enableAnimation and animation;

  public
    MultiBody.Forces.Internal.BasicForce basicForce(resolveInFrame=resolveInFrame)
      annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  protected
    MultiBody.Interfaces.ZeroPosition zeroPosition if
         not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
      annotation (Placement(transformation(extent={{40,10},{60,30}})));
  equation
    connect(basicForce.frame_a, frame_a) annotation (Line(
        points={{0,0},{-100,0}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(basicForce.frame_b, frame_b) annotation (Line(
        points={{20,0},{100,0}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(force, basicForce.force) annotation (Line(
        points={{-60,120},{-60,40},{4,40},{4,12}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(basicForce.frame_resolve, frame_resolve) annotation (Line(
        points={{14,10},{14,40},{40,40},{40,100}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    connect(zeroPosition.frame_resolve, basicForce.frame_resolve) annotation (
        Line(
        points={{40,20},{27,20},{27,10},{14,10}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}),
              graphics),
      Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            extent={{-98,99},{99,-98}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-92,61},{87,35}},
            lineColor={192,192,192},
            textString="resolve"),
          Text(
            extent={{-150,-55},{150,-95}},
            textString="%name",
            lineColor={0,0,255}),
          Line(
            points={{40,100},{40,0}},
            color={95,95,95},
            pattern=LinePattern.Dot),
          Polygon(
            points={{-94,0},{-64,11},{-64,-10},{-94,0}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-60,100},{40,100}},
            color={95,95,95},
            pattern=LinePattern.Dot),
          Polygon(
            points={{94,0},{65,12},{65,-11},{94,0}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-64,0},{-20,0}}, color={0,0,0}),
          Line(points={{20,0},{65,0}}, color={0,0,0})}),
      Documentation(info="<html>
<p>
The <b>3</b> signals of the <b>force</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>force</b> acting at the frame
connector to which frame_b of this component is attached.
Via parameter <b>resolveInFrame</b> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.ResolveInFrameAB.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">world</td>
    <td valign=\"top\">Resolve input force in world frame</td></tr>

<tr><td valign=\"top\">frame_a</td>
    <td valign=\"top\">Resolve input force in frame_a</td></tr>

<tr><td valign=\"top\">frame_b</td>
    <td valign=\"top\">Resolve input force in frame_b (= default)</td></tr>

<tr><td valign=\"top\">frame_resolve</td>
    <td valign=\"top\">Resolve input force in frame_resolve (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = ResolveInFrameAB.frame_resolve, the force coordinates
are with respect to the frame, that is connected to <b>frame_resolve</b>.
<p>

<p>
If force={100,0,0}, and for all parameters the default setting is used,
then the interpretation is that a force of 100 N is acting along the positive
x-axis of frame_b.
</p>

<p>
Note, the cut-torque in frame_b (frame_b.t) is always set to zero.
Additionally, a force and torque acts on frame_a in such a way that
the force and torque balance between frame_a and frame_b is fulfilled.
</p>

<p>
An example how to use this model is given in the
following figure:
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/Force1.png\">

<p>
This leads to the following animation (the yellow cylinder
characterizes the line between frame_a and frame_b of the
Force component, i.e., the force acts with negative sign
also on the opposite side of this cylinder, but for
clarity this is not shown in the animation):
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/Force2.png\">

</html>
"));
  end Force;

  model Torque
    "Torque acting between two frames, defined by 3 input signals and resolved in frame world, frame_a, frame_b or frame_resolve"

    import SI = Modelica.SIunits;
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
    Interfaces.Frame_resolve frame_resolve if
         resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
      "The input signals are optionally resolved in this frame"
      annotation (Placement(transformation(
          origin={40,100},
          extent={{-16,-16},{16,16}},
          rotation=90)));

    Modelica.Blocks.Interfaces.RealInput torque[3](each final quantity="Torque", each final unit=
                     "N.m")
      "x-, y-, z-coordiantes of torque resolved in frame defined by resolveInFrame"
      annotation (Placement(transformation(
          origin={-60,120},
          extent={{-20,-20},{20,20}},
          rotation=270)));
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
      resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b
      "Frame in which input force is resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";
    parameter Real Nm_to_m(unit="N.m/m") = world.defaultNm_to_m
      " Torque arrow scaling (length = torque/Nm_to_m)"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter torqueDiameter=world.defaultArrowDiameter
      " Diameter of torque arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter connectionLineDiameter=torqueDiameter
      " Diameter of line connecting frame_a and frame_b"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor
      " Color of torque arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color connectionLineColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor
      " Color of line connecting frame_a and frame_b"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(group="if animation = true", enable=animation));

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
      lengthDirection=basicTorque.r_0,
      widthDirection={0,1,0},
      length=Modelica.Math.Vectors.length(
                           basicTorque.r_0),
      width=connectionLineDiameter,
      height=connectionLineDiameter,
      color=connectionLineColor,
      specularCoefficient=specularCoefficient,
      r=frame_a.r_0) if world.enableAnimation and animation;

  public
    Internal.BasicTorque basicTorque(resolveInFrame=resolveInFrame)
      annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  protected
    Interfaces.ZeroPosition zeroPosition if
         not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
      annotation (Placement(transformation(extent={{34,10},{54,30}})));
  equation
    connect(basicTorque.frame_a, frame_a) annotation (Line(
        points={{-8,0},{-100,0}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(basicTorque.frame_b, frame_b) annotation (Line(
        points={{12,0},{100,0}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(basicTorque.torque, torque) annotation (Line(
        points={{-4,12},{-4,60},{-60,60},{-60,120}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(basicTorque.frame_resolve, frame_resolve) annotation (Line(
        points={{6,10},{6,60},{40,60},{40,100}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    connect(zeroPosition.frame_resolve, basicTorque.frame_resolve) annotation (
        Line(
        points={{34,20},{20,20},{20,10},{6,10}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}}),
              graphics),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            extent={{-98,99},{99,-98}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-59,55},{72,30}},
            lineColor={192,192,192},
            textString="resolve"),
          Text(
            extent={{-150,-30},{150,-70}},
            textString="%name",
            lineColor={0,0,255}),
          Polygon(
            points={{100,20},{84,52},{69,39},{100,20}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{40,100},{76,46}},
            color={95,95,95},
            pattern=LinePattern.Dot),
          Polygon(
            points={{-99,20},{-86,53},{-70,42},{-99,20}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-60,100},{40,100}},
            color={95,95,95},
            pattern=LinePattern.Dot),
          Line(points={{-79,47},{-70,61},{-59,72},{-45,81},{-32,84},{-20,85}},
              color={0,0,0}),
          Line(points={{77,45},{66,60},{55,69},{49,74},{41,80},{31,84},{20,85}},
              color={0,0,0})}),
      Documentation(info="<HTML>
<p>
The <b>3</b> signals of the <b>torque</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>torque</b> acting at the frame
connector to which frame_b of this component is attached.
Via parameter <b>resolveInFrame</b> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.ResolveInFrameAB.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">world</td>
    <td valign=\"top\">Resolve input torque in world frame</td></tr>

<tr><td valign=\"top\">frame_a</td>
    <td valign=\"top\">Resolve input torque in frame_a</td></tr>

<tr><td valign=\"top\">frame_b</td>
    <td valign=\"top\">Resolve input torque in frame_b (= default)</td></tr>

<tr><td valign=\"top\">frame_resolve</td>
    <td valign=\"top\">Resolve input torque in frame_resolve (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = ResolveInFrameAB.frame_resolve, the torque coordinates
are with respect to the frame, that is connected to <b>frame_resolve</b>.
<p>

<p>
If torque={100,0,0}, and for all parameters the default setting is used,
then the interpretation is that a torque of 100 N.m is acting along the positive
x-axis of frame_b.
</p>

<p>
Note, the cut-forces in frame_a and frame_b (frame_a.f, frame_b.f) are
always set to zero and the cut-torque at frame_a (frame_a.t) is the same
as the cut-torque at frame_b (frame_b.t) but with opposite sign.
</p>

<p>
An example how to use this model is given in the
following figure:
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/Torque1.png\">

<p>
This leads to the following animation (the yellow cylinder
characterizes the line between frame_a and frame_b of the
Torque component, i.e., the torque acts with negative sign
also on the opposite side of this cylinder, but for
clarity this is not shown in the animation):
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/Torque2.png\">

</HTML>
"));
  end Torque;

  model ForceAndTorque
    "Force and torque acting between two frames, defined by 3+3 input signals and resolved in frame world, frame_a, frame_b or frame_resolve"

    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;

    Blocks.Interfaces.RealInput force[3](each final quantity="Force", each final unit=
                     "N")
      "x-, y-, z-coordinates of force resolved in frame defined by resolveInFrame"
      annotation (Placement(transformation(
          origin={-80,120},
          extent={{-20,-20},{20,20}},
          rotation=270)));
    Blocks.Interfaces.RealInput torque[3](each final quantity="Torque", each final unit=
                     "N.m")
      "x-, y-, z-coordiantes of torque resolved in frame defined by resolveInFrame"
      annotation (Placement(transformation(
          origin={0,120},
          extent={{-20,-20},{20,20}},
          rotation=270)));
    Interfaces.Frame_resolve frame_resolve if
         resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve
      "The input signals are optionally resolved in this frame"
      annotation (Placement(transformation(
          origin={80,100},
          extent={{-16,-16},{16,16}},
          rotation=90)));

    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
      resolveInFrame=
      Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b
      "Frame in which input force and torque are resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";
    parameter Real N_to_m(unit="N/m") = world.defaultN_to_m
      "Force arrow scaling (length = force/N_to_m)"
      annotation (Dialog(group="if animation = true", enable=animation));
    parameter Real Nm_to_m(unit="N.m/m") = world.defaultNm_to_m
      "Torque arrow scaling (length = torque/Nm_to_m)"
      annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter forceDiameter=world.defaultArrowDiameter
      "Diameter of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter torqueDiameter=forceDiameter " Diameter of torque arrow"
                                  annotation (Dialog(group="if animation = true", enable=animation));
    input SI.Diameter connectionLineDiameter=forceDiameter
      "Diameter of line connecting frame_a and frame_b"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color forceColor=Modelica.Mechanics.MultiBody.Types.Defaults.ForceColor
      "Color of force arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color torqueColor=Modelica.Mechanics.MultiBody.Types.Defaults.TorqueColor
      "Color of torque arrow" annotation (Dialog(group="if animation = true", enable=animation));
    input Types.Color connectionLineColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor
      "Color of line connecting frame_a and frame_b"
      annotation (Dialog(group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(group="if animation = true", enable=animation));

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
      lengthDirection=basicForce.r_0,
      widthDirection={0,1,0},
      length=Modelica.Math.Vectors.length(
                           basicForce.r_0),
      width=connectionLineDiameter,
      height=connectionLineDiameter,
      color=connectionLineColor,
      specularCoefficient=specularCoefficient,
      r=frame_a.r_0) if world.enableAnimation and animation;

  public
    Internal.BasicForce basicForce(resolveInFrame=resolveInFrame)
      annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
    Internal.BasicTorque basicTorque(resolveInFrame=resolveInFrame)
      annotation (Placement(transformation(extent={{-4,10},{16,30}})));
  protected
    Interfaces.ZeroPosition zeroPosition if
         not (resolveInFrame == Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_resolve)
      annotation (Placement(transformation(extent={{20,30},{40,50}})));
  equation
    connect(basicForce.frame_a, frame_a) annotation (Line(
        points={{-84,0},{-100,0}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(basicForce.frame_b, frame_b) annotation (Line(
        points={{-64,0},{100,0}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(basicTorque.frame_b, frame_b) annotation (Line(
        points={{16,20},{68,20},{68,0},{100,0}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(basicTorque.frame_a, frame_a) annotation (Line(
        points={{-4,20},{-90,20},{-90,0},{-100,0}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    connect(basicForce.force, force) annotation (Line(
        points={{-80,12},{-80,120}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(basicTorque.torque, torque) annotation (Line(
        points={{0,32},{0,120}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(basicTorque.frame_resolve, frame_resolve) annotation (Line(
        points={{10,30},{10,80},{80,80},{80,100}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    connect(basicForce.frame_resolve, frame_resolve) annotation (Line(
        points={{-70,10},{-70,80},{80,80},{80,100}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    connect(zeroPosition.frame_resolve, basicTorque.frame_resolve)  annotation (
        Line(
        points={{20,40},{10,40},{10,30}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    connect(zeroPosition.frame_resolve, basicForce.frame_resolve) annotation (
        Line(
        points={{20,40},{-70,40},{-70,10}},
        color={95,95,95},
        pattern=LinePattern.Dot,
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
              100,100}},
          grid={2,2}),
              graphics),
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}},
          grid={2,2}), graphics={
          Rectangle(
            extent={{-98,99},{99,-98}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-59,55},{72,30}},
            lineColor={192,192,192},
            textString="resolve"),
          Text(
            extent={{-150,-55},{150,-95}},
            textString="%name",
            lineColor={0,0,255}),
          Polygon(
            points={{100,21},{84,55},{69,39},{100,21}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{80,100},{80,0}},
            color={95,95,95},
            pattern=LinePattern.Dot),
          Polygon(
            points={{-95,1},{-64,11},{-64,-10},{-95,1}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,20},{-86,53},{-70,42},{-100,20}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-80,100},{80,100}},
            color={95,95,95},
            pattern=LinePattern.Dot),
          Polygon(
            points={{94,0},{65,12},{65,-11},{94,0}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-64,0},{-20,0}}, color={0,0,0}),
          Line(points={{20,0},{65,0}}, color={0,0,0}),
          Line(points={{-79,47},{-70,61},{-59,72},{-45,81},{-32,84},{-20,85}},
              color={0,0,0}),
          Line(points={{76,47},{66,60},{55,69},{49,74},{41,80},{31,84},{20,85}},
              color={0,0,0}),
          Text(
            extent={{-144,124},{-106,102}},
            lineColor={0,0,0},
            textString="f"),
          Text(
            extent={{20,124},{58,102}},
            lineColor={0,0,0},
            textString="t")}),
      Documentation(info="<HTML>
The <b>3</b> signals of the <b>force</b> connector and the
<b>3</b> signals of the <b>torque</b> connector
are interpreted
as the x-, y- and z-coordinates of a <b>force</b> and of a
<b>torque</b> acting at the frame
connector to which frame_b of this component is attached.
Via parameter <b>resolveInFrame</b> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.ResolveInFrameAB.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">world</td>
    <td valign=\"top\">Resolve input force/torque in world frame</td></tr>

<tr><td valign=\"top\">frame_a</td>
    <td valign=\"top\">Resolve input force/torque in frame_a</td></tr>

<tr><td valign=\"top\">frame_b</td>
    <td valign=\"top\">Resolve input force/torque in frame_b (= default)</td></tr>

<tr><td valign=\"top\">frame_resolve</td>
    <td valign=\"top\">Resolve input force/torque in frame_resolve (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = ResolveInFrameAB.frame_resolve, the force and torque coordinates
are with respect to the frame, that is connected to <b>frame_resolve</b>.
<p>

<p>
If force={100,0,0}, and for all parameters the default setting is used,
then the interpretation is that a force of 100 N is acting along the positive
x-axis of frame_b.
</p>

<p>
Note, a force and torque acts on frame_a in such a way that
the force and torque balance between frame_a and frame_b is fulfilled.
</p>

<p>
An example how to use this model is given in the
following figure:
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/ForceAndTorque1.png\">

<p>
This leads to the following animation (the yellow cylinder
characterizes the line between frame_a and frame_b of the
ForceAndTorque component, i.e., the force and torque acts with
negative sign
also on the opposite side of this cylinder, but for
clarity this is not shown in the animation):
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/ForceAndTorque2.png\">

</HTML>
"));
  end ForceAndTorque;

  model LineForceWithMass
    "General line force component with an optional point mass on the connection line"

    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    extends Interfaces.PartialTwoFrames;
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_b
      "1-dim. translational flange (connect force of Translational library between flange_a and flange_b)"
      annotation (Placement(transformation(
          origin={60,100},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange_a
      "1-dim. translational flange (connect force of Translational library between flange_a and flange_b)"
      annotation (Placement(transformation(
          origin={-60,100},
          extent={{-10,-10},{10,10}},
          rotation=90)));

    parameter Boolean animateLine=true
      "= true, if a line shape between frame_a and frame_b shall be visualized";
    parameter Boolean animateMass=true
      "= true, if point mass shall be visualized as sphere provided m > 0";
    parameter SI.Mass m(min=0)=0
      "Mass of point mass on the connetion line between the origin of frame_a and the origin of frame_b";
    parameter Real lengthFraction(
      unit="1",
      min=0,
      max=1) = 0.5
      "Location of point mass with respect to frame_a as a fraction of the distance from frame_a to frame_b";
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(tab="Animation"));
    parameter Types.ShapeType lineShapeType="cylinder"
      "Type of shape visualizing the line from frame_a to frame_b"
      annotation (Dialog(tab="Animation", group="if animateLine = true", enable=animateLine));
    input SI.Length lineShapeWidth=world.defaultArrowDiameter "Width of shape"
      annotation (Dialog(tab="Animation", group="if animateLine = true", enable=animateLine));
    input SI.Length lineShapeHeight=lineShapeWidth "Height of shape"
      annotation (Dialog(tab="Animation", group="if animateLine = true", enable=animateLine));
    parameter Types.ShapeExtra lineShapeExtra=0.0 "Extra parameter for shape"
      annotation (Dialog(tab="Animation", group="if animateLine = true", enable=animateLine));
    input Types.Color lineShapeColor=Modelica.Mechanics.MultiBody.Types.Defaults.SensorColor
      "Color of line shape"
      annotation (Dialog(tab="Animation", group="if animateLine = true", enable=animateLine));
    input Real massDiameter=world.defaultBodyDiameter
      "Diameter of point mass sphere"
      annotation (Dialog(tab="Animation", group="if animateMass = true", enable=animateMass));
    input Types.Color massColor=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor
      "Color of point mass"
      annotation (Dialog(tab="Animation", group="if animateMass = true", enable=animateMass));
    parameter SI.Position s_small=1.E-10
      "Prevent zero-division if distance between frame_a and frame_b is zero"
      annotation (Dialog(tab="Advanced"));
    parameter Boolean fixedRotationAtFrame_a=false
      "=true, if rotation frame_a.R is fixed (to directly connect line forces)"
       annotation (Evaluate=true, choices(__Dymola_checkBox=true),Dialog(tab="Advanced", group="If enabled, can give wrong results, see MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces"));
    parameter Boolean fixedRotationAtFrame_b=false
      "=true, if rotation frame_b.R is fixed (to directly connect line forces)"
       annotation (Evaluate=true, choices(__Dymola_checkBox=true),Dialog(tab="Advanced", group="If enabled, can give wrong results, see MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces"));

    SI.Distance length
      "Distance between the origin of frame_a and the origin of frame_b";
    SI.Position r_rel_0[3]
      "Position vector from frame_a to frame_b resolved in world frame";
    Real e_rel_0[3](each final unit="1")
      "Unit vector in direction from frame_a to frame_b, resolved in world frame";

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
    length = Modelica.Math.Vectors.length(
                           r_rel_0);
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
    if fixedRotationAtFrame_a then
      Connections.root(frame_a.R);
      frame_a.R = Frames.nullRotation();
    else
      frame_a.t = zeros(3);
    end if;

    if fixedRotationAtFrame_b then
      Connections.root(frame_b.R);
      frame_b.R = Frames.nullRotation();
    else
      frame_b.t = zeros(3);
    end if;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Ellipse(
            extent={{-95,-40},{-15,40}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Ellipse(
            extent={{-85,-30},{-25,30}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{15,-40},{95,40}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Ellipse(
            extent={{23,-30},{83,29}},
            lineColor={128,128,128},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,-55},{150,-95}},
            textString="%name",
            lineColor={0,0,255}),
          Rectangle(
            extent={{-40,41},{44,-40}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-70,15},{-41,-13}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Ellipse(
            extent={{40,14},{69,-14}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Line(points={{-56,0},{-56,23},{-30,23},{-30,70},{-60,70},{-60,101}},
              color={0,0,0}),
          Line(points={{55,-1},{55,20},{30,20},{30,70},{60,70},{60,100}}, color=
               {0,0,0}),
          Line(
            points={{-56,0},{55,-1}},
            color={0,0,0},
            pattern=LinePattern.Dot),
          Ellipse(
            extent={{-8,8},{8,-8}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(visible=fixedRotationAtFrame_a, extent={{-70,30},{-130,-30}}, lineColor={255,0,0}),
          Text(visible=fixedRotationAtFrame_a,
            extent={{-62,50},{-140,30}},
            lineColor={255,0,0},
            textString="R=0"),
          Ellipse(visible=fixedRotationAtFrame_b, extent={{70,30},{130,-30}}, lineColor={255,0,0}),
          Text(visible=fixedRotationAtFrame_b,
            extent={{62,50},{140,30}},
            lineColor={255,0,0},
            textString="R=0")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-60,80},{46,80}}, color={0,0,255}),
          Polygon(
            points={{60,80},{45,86},{45,74},{60,80}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-50,93},{32,78}},
            textString="length",
            lineColor={0,0,255}),
          Ellipse(
            extent={{-100,-40},{-20,40}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Ellipse(
            extent={{-90,-30},{-30,30}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{20,-40},{100,40}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Ellipse(
            extent={{31,-29},{91,30}},
            lineColor={128,128,128},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-50,39},{50,-41}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-74,15},{-45,-13}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Ellipse(
            extent={{45,15},{74,-13}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Line(points={{-60,0},{-60,24},{-40,24},{-40,60},{-60,60},{-60,100}},
              color={0,0,0}),
          Line(points={{60,1},{60,21},{40,21},{40,60},{60,60},{60,100}}, color=
                {0,0,0}),
          Line(
            points={{-60,0},{60,0}},
            color={0,0,0},
            pattern=LinePattern.Dot),
          Ellipse(
            extent={{-8,8},{8,-8}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-60,0},{-31,0}}, color={0,0,255}),
          Polygon(points={{-19,0},{-31,3},{-31,-3},{-19,0}}, lineColor={0,0,255}),
          Line(points={{-60,16},{0,16}}, color={0,0,255}),
          Line(points={{0,0},{0,20}}, color={0,0,255}),
          Text(
            extent={{-49,-11},{-8,-21}},
            lineColor={0,0,0},
            textString="e_rel_0"),
          Polygon(points={{0,16},{-12,19},{-12,13},{0,16}}, lineColor={0,0,255}),
          Text(
            extent={{-50,35},{51,26}},
            lineColor={0,0,0},
            textString="length*lengthFraction"),
          Line(
            points={{-17,26},{-26,16}},
            pattern=LinePattern.Dot,
            color={0,0,255}),
          Line(
            points={{-31,-13},{-40,0}},
            pattern=LinePattern.Dot,
            color={0,0,255})}),
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
  end LineForceWithMass;

  model LineForceWithTwoMasses
    "General line force component with two optional point masses on the connection line"

    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;

    extends Interfaces.PartialTwoFrames;
    Modelica.Mechanics.Translational.Interfaces.Flange_a flange_b
      "1-dim. translational flange (connect force of Translational library between flange_a and flange_b)"
      annotation (Placement(transformation(
          origin={60,110},
          extent={{-10,-10},{10,10}},
          rotation=90)));
    Modelica.Mechanics.Translational.Interfaces.Flange_b flange_a
      "1-dim. translational flange (connect force of Translational library between flange_a and flange_b)"
      annotation (Placement(transformation(
          origin={-60,110},
          extent={{-10,-10},{10,10}},
          rotation=90)));

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
    input Types.Color massColor=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor
      " Color of point masses"
      annotation (Dialog(tab="Animation", group="if animation = true and animateMasses = true", enable=animate and animateMasses));
    parameter SI.Position s_small=1.E-10
      " Prevent zero-division if distance between frame_a and frame_b is zero"
      annotation (Dialog(tab="Advanced"));
    parameter Boolean fixedRotationAtFrame_a=false
      "=true, if rotation frame_a.R is fixed (to directly connect line forces)"
       annotation (Evaluate=true, choices(__Dymola_checkBox=true),Dialog(tab="Advanced", group="If enabled, can give wrong results, see MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces"));
    parameter Boolean fixedRotationAtFrame_b=false
      "=true, if rotation frame_b.R is fixed (to directly connect line forces)"
       annotation (Evaluate=true, choices(__Dymola_checkBox=true),Dialog(tab="Advanced", group="If enabled, can give wrong results, see MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces"));

    SI.Distance length
      "Distance between the origin of frame_a and the origin of frame_b";
    SI.Position r_rel_0[3]
      "Position vector from frame_a to frame_b resolved in world frame";
    Real e_rel_0[3](each final unit="1")
      "Unit vector in direction from frame_a to frame_b, resolved in world frame";

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
    length = Modelica.Math.Vectors.length(
                           r_rel_0);
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
    if fixedRotationAtFrame_a then
      Connections.root(frame_a.R);
      frame_a.R = Frames.nullRotation();
    else
      frame_a.t = zeros(3);
    end if;

    if fixedRotationAtFrame_b then
      Connections.root(frame_b.R);
      frame_b.R = Frames.nullRotation();
    else
      frame_b.t = zeros(3);
    end if;

    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Ellipse(
            extent={{-100,-40},{-20,40}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Ellipse(
            extent={{-90,-30},{-30,30}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{20,-40},{100,40}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Ellipse(
            extent={{31,-29},{91,30}},
            lineColor={128,128,128},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,-55},{150,-95}},
            textString="%name",
            lineColor={0,0,255}),
          Rectangle(
            extent={{-52,40},{48,-40}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-74,15},{-45,-13}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Ellipse(
            extent={{45,14},{74,-14}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Line(points={{-60,0},{-60,23},{-30,23},{-30,70},{-60,70},{-60,101}},
              color={0,0,0}),
          Line(points={{60,0},{60,20},{30,20},{30,70},{60,70},{60,100}}, color=
                {0,0,0}),
          Line(
            points={{-23,0},{25,0}},
            color={0,0,0},
            pattern=LinePattern.Dot),
          Ellipse(
            extent={{23,8},{39,-8}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-39,8},{-23,-8}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-60,0},{-29,0}}, color={0,0,0}),
          Line(points={{29,0},{60,0}}, color={0,0,0}),
          Ellipse(visible=fixedRotationAtFrame_a, extent={{-70,30},{-130,-30}}, lineColor={255,0,0}),
          Text(visible=fixedRotationAtFrame_a,
            extent={{-62,50},{-140,30}},
            lineColor={255,0,0},
            textString="R=0"),
          Ellipse(visible=fixedRotationAtFrame_b, extent={{70,30},{130,-30}}, lineColor={255,0,0}),
          Text(visible=fixedRotationAtFrame_b,
            extent={{62,50},{140,30}},
            lineColor={255,0,0},
            textString="R=0")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-60,80},{46,80}}, color={0,0,255}),
          Polygon(
            points={{60,80},{45,86},{45,74},{60,80}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-42,91},{30,79}},
            textString="length",
            lineColor={0,0,255}),
          Ellipse(
            extent={{-100,-40},{-20,40}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Ellipse(
            extent={{-90,-30},{-30,30}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{20,-40},{100,40}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Ellipse(
            extent={{31,-29},{91,30}},
            lineColor={128,128,128},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-49,39},{51,-41}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-74,15},{-45,-13}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Ellipse(
            extent={{45,15},{74,-13}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={192,192,192}),
          Line(points={{-60,0},{-60,24},{-40,24},{-40,60},{-60,60},{-60,110}},
              color={0,0,0}),
          Line(points={{60,1},{60,21},{40,21},{40,60},{60,60},{60,110}}, color=
                {0,0,0}),
          Line(
            points={{-60,0},{60,0}},
            color={0,0,0},
            pattern=LinePattern.Dot),
          Ellipse(
            extent={{20,8},{36,-8}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-18,-18},{11,-18}}, color={0,0,255}),
          Polygon(points={{23,-18},{11,-15},{11,-21},{23,-18}}, lineColor={0,0,
                255}),
          Line(points={{-60,16},{-37,16}}, color={0,0,255}),
          Line(points={{-25,0},{-25,20}}, color={0,0,255}),
          Text(
            extent={{-38,-20},{33,-35}},
            lineColor={0,0,0},
            textString="e_rel_0"),
          Polygon(points={{-25,16},{-37,19},{-37,13},{-25,16}}, lineColor={0,0,
                255}),
          Text(
            extent={{-39,31},{-22,21}},
            lineColor={0,0,0},
            textString="L_a"),
          Ellipse(
            extent={{-33,7},{-17,-9}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{29,3},{29,22}}, color={0,0,255}),
          Line(points={{29,16},{60,16}}, color={0,0,255}),
          Polygon(points={{29,16},{41,19},{41,13},{29,16}}, lineColor={0,0,255}),
          Text(
            extent={{15,36},{32,26}},
            lineColor={0,0,0},
            textString="L_b"),
          Line(
            points={{37,18},{30,27}},
            pattern=LinePattern.Dot,
            color={0,0,255})}),
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
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Elementary.LineForceWithTwoMasses\">
MultiBody.Examples.Elementary.LineForceWithTwoMasses</a> the usage of this
line force element is shown and is compared with an alternative
implementation using a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUPS\">
MultiBody.Joints.Assemblies.JointUPS</a> component.
The composition diagram of this example
is displayed in the figure below.
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Examples/Elementary/LineForceWithTwoMasses1.png\">

<p>
The animation view at time = 0 is shown in the next figure.
The system on the left side in the front is the animation with
the LineForceWithTwoMasses component whereas the system on the right
side in the back is the animation with the JointUPS component.
Both implementations yield the same result. However, the implementation
with the LineForceWithTwoMasses component is simpler.
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Examples/Elementary/LineForceWithTwoMasses2.png\">

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
  end LineForceWithTwoMasses;

  model Spring "Linear translational spring with optional mass"
    import Modelica.Mechanics.MultiBody.Types;
    extends Interfaces.PartialTwoFrames;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Boolean showMass=true
      "= true, if point mass shall be visualized as sphere if animation=true and m>0";

    parameter SI.TranslationalSpringConstant c(final min=0) "Spring constant";
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
    input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.SpringColor
      " Color of spring"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input SIunits.Diameter massDiameter=max(0, (width - 2*coilWidth)*0.9)
      " Diameter of mass point sphere" annotation (Dialog(tab="Animation", group=
            "if animation = true and showMass = true", enable=animation and showMass));
    input Types.Color massColor=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor
      " Color of mass point" annotation (Dialog(tab="Animation", group=
            "if animation = true and showMass = true", enable=animation and showMass));
    parameter Boolean fixedRotationAtFrame_a=false
      "=true, if rotation frame_a.R is fixed (to directly connect line forces)"
       annotation (Evaluate=true, choices(__Dymola_checkBox=true),Dialog(tab="Advanced", group="If enabled, can give wrong results, see MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces"));
    parameter Boolean fixedRotationAtFrame_b=false
      "=true, if rotation frame_b.R is fixed (to directly connect line forces)"
       annotation (Evaluate=true, choices(__Dymola_checkBox=true),Dialog(tab="Advanced", group="If enabled, can give wrong results, see MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces"));

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
      massColor=massColor,
      fixedRotationAtFrame_a=fixedRotationAtFrame_a,
      fixedRotationAtFrame_b=fixedRotationAtFrame_b) annotation (Placement(transformation(extent={{-20,
              -20},{20,20}}, rotation=0)));
    Modelica.Mechanics.Translational.Components.Spring spring(
                                                   s_rel0=s_unstretched, c=c)
      annotation (Placement(transformation(extent={{-8,40},{12,60}}, rotation=0)));

  equation
    connect(lineForce.frame_a, frame_a)
      annotation (Line(
        points={{-20,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(lineForce.frame_b, frame_b)
      annotation (Line(
        points={{20,0},{100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(spring.flange_b, lineForce.flange_b)
      annotation (Line(points={{12,50},{12,20}}, color={0,191,0}));
    connect(spring.flange_a, lineForce.flange_a)
      annotation (Line(points={{-8,50},{-12,50},{-12,20}}, color={0,191,0}));

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                      graphics={
          Line(
            points={{-100,0},{-58,0},{-43,-30},{-13,30},{17,-30},{47,30},{62,0},
                {100,0}},
            color={0,0,0},
            pattern=LinePattern.Solid,
            thickness=0.25,
            arrow={Arrow.None,Arrow.None}),
          Text(
            extent={{-150,56},{150,96}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{-150,-80},{150,-50}},
            lineColor={0,0,0},
            textString="c=%c"),
          Ellipse(
            extent={{-8,8},{8,-8}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(visible=fixedRotationAtFrame_a, extent={{-70,30},{-130,-30}}, lineColor={255,0,0}),
          Text(visible=fixedRotationAtFrame_a,
            extent={{-62,50},{-140,30}},
            lineColor={255,0,0},
            textString="R=0"),
          Ellipse(visible=fixedRotationAtFrame_b, extent={{70,30},{130,-30}}, lineColor={255,0,0}),
          Text(visible=fixedRotationAtFrame_b,
            extent={{62,50},{140,30}},
            lineColor={255,0,0},
            textString="R=0")}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}),
              graphics),
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
spring characterizes the location of the point mass.
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Examples/Elementary/SpringWithMass.png\"
ALT=\"model Examples.Elementary.SpringWithMass\">

</HTML>"));
  end Spring;

  model Damper "Linear (velocity dependent) damper"
    import Modelica.Mechanics.MultiBody.Types;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.TranslationalDampingConstant d(final min=0, start = 0)
      "Damping constant";
    parameter SI.Distance length_a=world.defaultForceLength
      " Length of cylinder at frame_a side"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input SIunits.Diameter diameter_a=world.defaultForceWidth
      " Diameter of cylinder at frame_a side"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input SIunits.Diameter diameter_b=0.6*diameter_a
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
    extends
      Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
       final T=293.15);
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
    lossPower = f*der(s);
    annotation (
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

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/Damper.png\">

</HTML>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-101,0},{-60,0}}, color={0,0,0}),
          Line(points={{-60,-30},{-60,30}}, color={0,0,0}),
          Line(points={{-60,-30},{60,-30}}, color={0,0,0}),
          Line(points={{-60,30},{60,30}}, color={0,0,0}),
          Rectangle(
            extent={{-60,30},{30,-30}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{30,0},{100,0}}, color={0,0,0}),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{-150,-75},{150,-45}},
            lineColor={0,0,0},
            textString="d=%d"),
          Line(visible=useHeatPort,
            points={{-100,-99},{-100,-25},{-10,-25}},
            color={191,0,0},
            pattern=LinePattern.Dot,
            smooth=Smooth.None)}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-100,0},{-60,0}}, color={0,0,0}),
          Line(points={{-60,-30},{-60,30}}, color={0,0,0}),
          Line(points={{-60,-30},{60,-30}}, color={0,0,0}),
          Line(points={{-60,30},{60,30}}, color={0,0,0}),
          Rectangle(
            extent={{-60,30},{30,-30}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{30,0},{100,0}}, color={0,0,0}),
          Line(points={{-50,60},{50,60}}, color={128,128,128}),
          Text(
            extent={{-40,64},{23,77}},
            lineColor={128,128,128},
            textString="der(s)"),
          Polygon(
            points={{64,60},{42,68},{42,52},{62,60},{64,60}},
            lineColor={128,128,128},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid)}));
  end Damper;

  model SpringDamperParallel "Linear spring and linear damper in parallel"
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.TranslationalSpringConstant c(final min=0) "Spring constant";
    parameter SI.Length s_unstretched=0 "Unstretched spring length";
    parameter SI.TranslationalDampingConstant d(final min=0) = 0
      "Damping constant";
    input SI.Distance width=world.defaultForceWidth " Width of spring"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input SI.Distance coilWidth=width/10 " Width of spring coil"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter Integer numberOfWindings=5 " Number of spring windings"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.SpringColor
      " Color of spring"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    extends Interfaces.PartialLineForce;
    extends
      Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
       final T=293.15);

  protected
    Modelica.SIunits.Force f_d "Damping force";
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
    f_d = d*der(s);
    f = c*(s - s_unstretched) + f_d;
    lossPower = f_d*der(s);
    annotation (
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
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Text(
            extent={{-150,-150},{150,-110}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{-80,40},{-60,40},{-45,10},{-15,70},{15,10},{45,70},{60,
                40},{80,40}}, color={0,0,0}),
          Line(points={{-80,40},{-80,-70}}, color={0,0,0}),
          Line(points={{-80,-70},{-52,-70}}, color={0,0,0}),
          Rectangle(
            extent={{-52,-40},{38,-100}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-52,-40},{68,-40}}, color={0,0,0}),
          Line(points={{-52,-100},{68,-100}}, color={0,0,0}),
          Line(points={{38,-70},{80,-70}}, color={0,0,0}),
          Line(points={{80,40},{80,-70}}, color={0,0,0}),
          Line(points={{-100,0},{-80,0}}, color={0,0,0}),
          Line(points={{80,0},{100,0}}, color={0,0,0}),
          Text(
            extent={{-150,70},{150,100}},
            lineColor={0,0,0},
            textString="d=%d"),
          Line(visible=useHeatPort,
            points={{-100,-101},{-100,-80},{-6,-80}},
            color={191,0,0},
            pattern=LinePattern.Dot,
            smooth=Smooth.None),
          Text(
            extent={{-150,105},{150,135}},
            lineColor={0,0,0},
            textString="c=%c")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(
            points={{-80,32},{-58,32},{-43,2},{-13,62},{17,2},{47,62},{62,32},{
                80,32}},
            color={0,0,0},
            thickness=0.5),
          Line(points={{-68,32},{-68,97}}, color={128,128,128}),
          Line(points={{72,32},{72,97}}, color={128,128,128}),
          Line(points={{-68,92},{72,92}}, color={128,128,128}),
          Polygon(
            points={{62,95},{72,92},{62,89},{62,95}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-20,72},{20,97}},
            lineColor={0,0,255},
            textString="s"),
          Rectangle(
            extent={{-52,-20},{38,-80}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-52,-80},{68,-80}}, color={0,0,0}),
          Line(points={{-52,-20},{68,-20}}, color={0,0,0}),
          Line(points={{38,-50},{80,-50}}, color={0,0,0}),
          Line(points={{-80,-50},{-52,-50}}, color={0,0,0}),
          Line(points={{-80,32},{-80,-50}}, color={0,0,0}),
          Line(points={{80,32},{80,-50}}, color={0,0,0}),
          Line(points={{-100,0},{-80,0}}, color={0,0,0}),
          Line(points={{100,0},{80,0}}, color={0,0,0})}));
  end SpringDamperParallel;

  model SpringDamperSeries
    "Linear spring and linear damper in series connection"
    import SI = Modelica.SIunits;
    parameter SI.TranslationalSpringConstant c(final min=0) "Spring constant";
    parameter SI.Length s_unstretched=0 "Unstretched spring length";
    parameter SI.TranslationalDampingConstant d(final min=0) = 0
      "Damping constant";
    parameter SI.Length s_damper_start=0 "Initial length of damper";
    SI.Position s_damper(start=s_damper_start, fixed=true)
      "Actual length of damper (frame_a - damper - spring - frame_b)";
    extends Interfaces.PartialLineForce;
    extends
      Modelica.Thermal.HeatTransfer.Interfaces.PartialElementaryConditionalHeatPort(
       final T=293.15);
  equation
    f = c*(s - s_unstretched - s_damper);
    d*der(s_damper) = f;
    lossPower = f*der(s_damper);
    annotation (
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
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-100,0},{-15,0}}, color={0,0,0}),
          Line(points={{-60,-30},{-15,-30}}, color={0,0,0}),
          Line(points={{-60,30},{-15,30}}, color={0,0,0}),
          Rectangle(
            extent={{-60,30},{-30,-30}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-15,0},{-5,0},{5,-30},{25,30},{45,-30},{65,30},{75,0},{
                100,0}}, color={0,0,0}),
          Text(
            extent={{-150,50},{150,90}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{-150,-65},{150,-35}},
            lineColor={0,0,0},
            textString="c=%c"),
          Line(visible=useHeatPort,
            points={{-100,-99},{-100,-24},{-45,-24}},
            color={191,0,0},
            smooth=Smooth.None,
            pattern=LinePattern.Dot),
          Text(
            extent={{-150,-100},{150,-70}},
            lineColor={0,0,0},
            textString="d=%d")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-100,0},{-15,0}}, color={0,0,0}),
          Line(points={{-60,-30},{-15,-30}}, color={0,0,0}),
          Line(points={{-60,30},{-15,30}}, color={0,0,0}),
          Rectangle(
            extent={{-60,30},{-30,-30}},
            lineColor={0,0,0},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-15,0},{-5,0},{5,-30},{25,30},{45,-30},{65,30},{75,0},{
                99,0}}, color={0,0,0}),
          Line(points={{-75,0},{-75,85}}, color={160,160,164}),
          Line(points={{-10,0},{-10,65}}, color={160,160,164}),
          Line(points={{80,0},{80,85}}, color={160,160,164}),
          Line(points={{-75,80},{80,80}}, color={160,160,164}),
          Line(points={{-75,60},{-10,60}}, color={160,160,164}),
          Polygon(
            points={{-10,60},{-20,65},{-20,55},{-10,60}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{80,80},{70,85},{70,75},{80,80}},
            lineColor={160,160,164},
            fillColor={160,160,164},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-72,63},{-11,78}},
            lineColor={160,160,164},
            textString="s_damper"),
          Text(
            extent={{0,80},{20,100}},
            lineColor={160,160,164},
            textString="s")}));
  end SpringDamperSeries;

  package Internal "Internal package, should not be used by user"
    extends Modelica.Icons.Package;

    model BasicForce
      "Force acting between two frames, defined by 3 input signals"

      import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;
      extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
      Interfaces.Frame_resolve frame_resolve
        "The input signals are optionally resolved in this frame"
        annotation (Placement(transformation(
            origin={40,100},
            extent={{-16,-16},{16,16}},
            rotation=90)));
      Modelica.Blocks.Interfaces.RealInput force[3](each final quantity="Force", each final unit=
                     "N")
        "x-, y-, z-coordinates of force resolved in frame defined by resolveInFrame"
        annotation (Placement(transformation(
            origin={-60,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
        resolveInFrame=
        Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b
        "Frame in which force is resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";

      Modelica.SIunits.Position r_0[3]
        "Position vector from origin of frame_a to origin of frame_b resolved in world frame";
      Modelica.SIunits.Force f_b_0[3] "frame_b.f resoved in world frame";

    equation
      assert(cardinality(frame_resolve) > 0, "Connector frame_resolve must be connected at least once and frame_resolve.r_0/.R must be set");
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);

       if resolveInFrame == ResolveInFrameAB.frame_a then
          f_b_0     = -Frames.resolve1(frame_a.R, force);
          frame_b.f =  Frames.resolve2(frame_b.R, f_b_0);
       elseif resolveInFrame == ResolveInFrameAB.frame_b then
          f_b_0     = -Frames.resolve1(frame_b.R, force);
          frame_b.f = -force;
       elseif resolveInFrame == ResolveInFrameAB.world then
          f_b_0     = -force;
          frame_b.f =  Frames.resolve2(frame_b.R, f_b_0);
       elseif resolveInFrame == ResolveInFrameAB.frame_resolve then
          f_b_0     = -Frames.resolve1(frame_resolve.R, force);
          frame_b.f = Frames.resolve2(frame_b.R, f_b_0);
       else
          assert(false, "Wrong value for parameter resolveInFrame");
          f_b_0     = zeros(3);
          frame_b.f = zeros(3);
       end if;
       frame_b.t = zeros(3);

       // Force and torque balance
       r_0 = frame_b.r_0 - frame_a.r_0;
       zeros(3) = frame_a.f + Frames.resolve2(frame_a.R, f_b_0);
       zeros(3) = frame_a.t + Frames.resolve2(frame_a.R, cross(r_0, f_b_0));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-98,99},{99,-98}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-92,61},{87,35}},
              lineColor={192,192,192},
              textString="resolve"),
            Text(
              extent={{-136,-52},{149,-113}},
              textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{40,100},{40,0}},
              color={95,95,95},
              pattern=LinePattern.Dot),
            Polygon(
              points={{-94,0},{-64,11},{-64,-10},{-94,0}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-60,100},{40,100}},
              color={95,95,95},
              pattern=LinePattern.Dot),
            Polygon(
              points={{94,0},{65,12},{65,-11},{94,0}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(points={{-64,0},{-20,0}}, color={0,0,0}),
            Line(points={{20,0},{65,0}}, color={0,0,0})}),
        Documentation(info="<HTML>
<p>
The <b>3</b> signals of the <b>force</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>force</b> acting at the frame
connector to which frame_b of this component is attached.
Via parameter <b>resolveInFrame</b> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.ResolveInFrameAB.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">world</td>
    <td valign=\"top\">Resolve input force in world frame</td></tr>

<tr><td valign=\"top\">frame_a</td>
    <td valign=\"top\">Resolve input force in frame_a</td></tr>

<tr><td valign=\"top\">frame_b</td>
    <td valign=\"top\">Resolve input force in frame_b (= default)</td></tr>

<tr><td valign=\"top\">frame_resolve</td>
    <td valign=\"top\">Resolve input force in frame_resolve (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = ResolveInFrameAB.frame_resolve, the force coordinates
are with respect to the frame, that is connected to <b>frame_resolve</b>.
<p>

<p>
If resolveInFrame is not ResolveInFrameAB.frame_resolve, then the position
vector and the orientation object of frame_resolve must be set to constant
values from the outside in order that the model remains balanced
(these constant values are ignored).
</p>

</HTML>
"));
    end BasicForce;

    model BasicTorque
      "Torque acting between two frames, defined by 3 input signals"

      import SI = Modelica.SIunits;
      import Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB;
      extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
      Interfaces.Frame_resolve frame_resolve
        "The input signals are optionally resolved in this frame"
        annotation (Placement(transformation(
            origin={40,100},
            extent={{-16,-16},{16,16}},
            rotation=90)));

      Modelica.Blocks.Interfaces.RealInput torque[3](each final quantity="Torque", each final unit=
                     "N.m")
        "x-, y-, z-coordiantes of torque resolved in frame defined by resolveInFrame"
        annotation (Placement(transformation(
            origin={-60,120},
            extent={{-20,-20},{20,20}},
            rotation=270)));
      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB
        resolveInFrame=
        Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_b
        "Frame in which torque is resolved (1: world, 2: frame_a, 3: frame_b, 4: frame_resolve)";

      SI.Position r_0[3]
        "Position vector from origin of frame_a to origin of frame_b resolved in world frame";
      SI.Torque t_b_0[3] "frame_b.t resoved in world frame";

    equation
      assert(cardinality(frame_resolve) > 0, "Connector frame_resolve must be connected at least once and frame_resolve.r_0/.R must be set");
      frame_resolve.f = zeros(3);
      frame_resolve.t = zeros(3);

      r_0 = frame_b.r_0 - frame_a.r_0;
      frame_a.f = zeros(3);
      frame_b.f = zeros(3);

       if resolveInFrame == ResolveInFrameAB.frame_a then
          t_b_0     = -Frames.resolve1(frame_a.R, torque);
          frame_b.t =  Frames.resolve2(frame_b.R, t_b_0);
       elseif resolveInFrame == ResolveInFrameAB.frame_b then
          t_b_0     = -Frames.resolve1(frame_b.R, torque);
          frame_b.t = -torque;
       elseif resolveInFrame == ResolveInFrameAB.world then
          t_b_0     = -torque;
          frame_b.t =  Frames.resolve2(frame_b.R, t_b_0);
       elseif resolveInFrame == ResolveInFrameAB.frame_resolve then
          t_b_0     = -Frames.resolve1(frame_resolve.R, torque);
          frame_b.t =  Frames.resolve2(frame_b.R, t_b_0);
       else
          assert(false, "Wrong value for parameter resolveInFrame");
          t_b_0     = zeros(3);
          frame_b.t = zeros(3);
       end if;

       // torque balance
       zeros(3) = frame_a.t + Frames.resolve2(frame_a.R, t_b_0);
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}),
                graphics),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Rectangle(
              extent={{-98,99},{99,-98}},
              lineColor={255,255,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-59,55},{72,30}},
              lineColor={192,192,192},
              textString="resolve"),
            Text(
              extent={{-139,-27},{146,-88}},
              textString="%name",
              lineColor={0,0,255}),
            Polygon(
              points={{100,20},{84,52},{69,39},{100,20}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{40,100},{76,46}},
              color={95,95,95},
              pattern=LinePattern.Dot),
            Polygon(
              points={{-99,20},{-86,53},{-70,42},{-99,20}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-60,100},{40,100}},
              color={95,95,95},
              pattern=LinePattern.Dot),
            Line(points={{-79,47},{-70,61},{-59,72},{-45,81},{-32,84},{-20,85}},
                color={0,0,0}),
            Line(points={{77,45},{66,60},{55,69},{49,74},{41,80},{31,84},{20,85}},
                color={0,0,0})}),
        Documentation(info="<HTML>
<p>
The <b>3</b> signals of the <b>torque</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>torque</b> acting at the frame
connector to which frame_b of this component is attached.
Via parameter <b>resolveInFrame</b> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.ResolveInFrameAB.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">world</td>
    <td valign=\"top\">Resolve input torque in world frame</td></tr>

<tr><td valign=\"top\">frame_a</td>
    <td valign=\"top\">Resolve input torque in frame_a</td></tr>

<tr><td valign=\"top\">frame_b</td>
    <td valign=\"top\">Resolve input torque in frame_b (= default)</td></tr>

<tr><td valign=\"top\">frame_resolve</td>
    <td valign=\"top\">Resolve input torque in frame_resolve (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = ResolveInFrameAB.frame_resolve, the torque coordinates
are with respect to the frame, that is connected to <b>frame_resolve</b>.
<p>

<p>
If resolveInFrame is not ResolveInFrameAB.frame_resolve, then the position
vector and the orientation object of frame_resolve must be set to constant
values from the outside in order that the model remains balanced
(these constant values are ignored).
</p>
</HTML>
"));
    end BasicTorque;

    model BasicWorldForce
      "External force acting at frame_b, defined by 3 input signals"

      import SI = Modelica.SIunits;
      import Modelica.Mechanics.MultiBody.Types.ResolveInFrameB;
      extends Interfaces.PartialOneFrame_b;
      Interfaces.Frame_resolve frame_resolve
        "The input signals are optionally resolved in this frame"
        annotation (Placement(transformation(
            origin={0,-100},
            extent={{-16,-16},{16,16}},
            rotation=270)));

      Modelica.Blocks.Interfaces.RealInput force[3](each final quantity="Force", each final unit=
                     "N")
        "x-, y-, z-coordinates of force resolved in frame defined by resolveInFrame"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
              rotation=0)));
      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB
        resolveInFrame=
        Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world
        "Frame in which force is resolved (1: world, 2: frame_b, 3: frame_resolve)";

    equation
       assert(cardinality(frame_resolve) > 0, "Connector frame_resolve must be connected at least once and frame_resolve.r_0/.R must be set");
       frame_resolve.f = zeros(3);
       frame_resolve.t = zeros(3);

       if resolveInFrame == ResolveInFrameB.world then
          frame_b.f = -Frames.resolve2(frame_b.R, force);
       elseif resolveInFrame == ResolveInFrameB.frame_b then
          frame_b.f = -force;
       elseif resolveInFrame == ResolveInFrameB.frame_resolve then
          frame_b.f = -Frames.resolveRelative(force, frame_resolve.R, frame_b.R);
       else
          assert(false, "Wrong value for parameter resolveInFrame");
          frame_b.f = zeros(3);
       end if;
       frame_b.t = zeros(3);
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={Polygon(
              points={{-100,10},{50,10},{50,31},{97,0},{50,-31},{50,-10},{-100,
                  -10},{-100,10}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid), Line(
              points={{0,-10},{0,-97}},
              color={95,95,95},
              pattern=LinePattern.Dot)}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-89,-46},{91,-76}},
              lineColor={192,192,192},
              textString="resolve"),
            Polygon(
              points={{-100,10},{50,10},{50,31},{94,0},{50,-31},{50,-10},{-100,
                  -10},{-100,10}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-149,103},{136,42}},
              textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{0,-10},{0,-95}},
              color={95,95,95},
              pattern=LinePattern.Dot)}),
        Documentation(info="<HTML>
<p>
The 3 signals of the <b>force</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>force</b> acting at the frame
connector to which this component is attached.
Via parameter <b>resolveInFrame</b> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.ResolveInFrameB.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">world</td>
    <td valign=\"top\">Resolve input force in world frame (= default)</td></tr>

<tr><td valign=\"top\">frame_b</td>
    <td valign=\"top\">Resolve input force in frame_b</td></tr>

<tr><td valign=\"top\">frame_resolve</td>
    <td valign=\"top\">Resolve input force in frame_resolve (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameB.frame_resolve, the force coordinates
are with respect to the frame, that is connected to <b>frame_resolve</b>.
<p>

<p>
If resolveInFrame is not Types.ResolveInFrameB.frame_resolve, then the position
vector and the orientation object of frame_resolve must be set to constant
values from the outside in order that the model remains balanced
(these constant values are ignored).
</p>

</HTML>
"));
    end BasicWorldForce;

    model BasicWorldTorque
      "External torque acting at frame_b, defined by 3 input signals"

      import SI = Modelica.SIunits;
      import Modelica.Mechanics.MultiBody.Types.ResolveInFrameB;
      extends Interfaces.PartialOneFrame_b;
      Interfaces.Frame_resolve frame_resolve
        "The input signals are optionally resolved in this frame"
        annotation (Placement(transformation(
            origin={0,100},
            extent={{16,-16},{-16,16}},
            rotation=270)));

      Modelica.Blocks.Interfaces.RealInput torque[3](each final quantity="Torque", each final unit=
                     "N.m")
        "x-, y-, z-coordinates of torque resolved in frame defined by resolveInFrame"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
              rotation=0)));
      parameter Modelica.Mechanics.MultiBody.Types.ResolveInFrameB
        resolveInFrame=
        Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.world
        "Frame in which torque is resolved (1: world, 2: frame_b, 3: frame_resolve)";

    equation
       assert(cardinality(frame_resolve) > 0, "Connector frame_resolve must be connected at least once and frame_resolve.r_0/.R must be set");
       frame_resolve.f = zeros(3);
       frame_resolve.t = zeros(3);

       if resolveInFrame == ResolveInFrameB.world then
          frame_b.t = -Frames.resolve2(frame_b.R, torque);
       elseif resolveInFrame == ResolveInFrameB.frame_b then
          frame_b.t = -torque;
       elseif resolveInFrame == ResolveInFrameB.frame_resolve then
          frame_b.t = -Frames.resolveRelative(torque, frame_resolve.R, frame_b.R);
       else
          assert(false, "Wrong value for parameter resolveInFrame");
          frame_b.t = zeros(3);
       end if;
       frame_b.f = zeros(3);
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                {100,100}}), graphics={
            Line(
              points={{0,97},{0,82}},
              color={95,95,95},
              pattern=LinePattern.Dot),
            Line(
              points={{-100,0},{-94,13},{-86,28},{-74,48},{-65,60},{-52,72},{-35,
                  81},{-22,84},{-8,84},{7,80},{19,73},{32,65},{44,55},{52,47},{
                  58,40}},
              color={0,0,0},
              thickness=0.5),
            Polygon(
              points={{97,6},{75,59},{41,24},{97,6}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={
            Text(
              extent={{-61,64},{46,27}},
              lineColor={192,192,192},
              textString="resolve"),
            Text(
              extent={{-145,-28},{140,-89}},
              textString="%name",
              lineColor={0,0,255}),
            Line(
              points={{0,95},{0,82}},
              color={95,95,95},
              pattern=LinePattern.Dot),
            Line(
              points={{-100,0},{-94,13},{-86,28},{-74,48},{-65,60},{-52,72},{-35,
                  81},{-22,84},{-8,84},{7,80},{19,73},{32,65},{44,55},{52,47},{
                  58,40}},
              color={0,0,0},
              thickness=0.5),
            Polygon(
              points={{94,10},{75,59},{41,24},{94,10}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<HTML>
<p>
The 3 signals of the <b>torque</b> connector are interpreted
as the x-, y- and z-coordinates of a <b>torque</b> acting at the frame
connector to which this component is attached.
Via parameter <b>resolveInFrame</b> it is defined, in which frame these
coordinates shall be resolved:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>Types.ResolveInFrameB.</b></th><th><b>Meaning</b></th></tr>
<tr><td valign=\"top\">world</td>
    <td valign=\"top\">Resolve input torque in world frame (= default)</td></tr>

<tr><td valign=\"top\">frame_b</td>
    <td valign=\"top\">Resolve input torque in frame_b</td></tr>

<tr><td valign=\"top\">frame_resolve</td>
    <td valign=\"top\">Resolve input torque in frame_resolve (frame_resolve must be connected)</td></tr>
</table>

<p>
If resolveInFrame = Types.ResolveInFrameB.frame_resolve, the torque coordinates
are with respect to the frame, that is connected to <b>frame_resolve</b>.
<p>

<p>
If resolveInFrame is not Types.ResolveInFrameB.frame_resolve, then the position
vector and the orientation object of frame_resolve must be set to constant
values from the outside in order that the model remains balanced
(these constant values are ignored).
</p>

</HTML>
"));
    end BasicWorldTorque;

    function standardGravityAcceleration
      "Standard gravity fields (no/parallel/point field)"
      extends
        Modelica.Mechanics.MultiBody.Interfaces.partialGravityAcceleration;
      import Modelica.Mechanics.MultiBody.Types.GravityTypes;
      input GravityTypes gravityType "Type of gravity field" annotation(Dialog);
      input Modelica.SIunits.Acceleration g[3]
        "Constant gravity acceleration, resolved in world frame, if gravityType=UniformGravity"
                                                                                                annotation(Dialog);
      input Real mue(unit="m3/s2")
        "Field constant of point gravity field, if gravityType=PointGravity" annotation(Dialog);
    algorithm
    gravity := if gravityType == GravityTypes.UniformGravity then g else
               if gravityType == GravityTypes.PointGravity then
                  -(mue/(r*r))*(r/Modelica.Math.Vectors.length(r)) else zeros(3);
      annotation(Inline=true, Documentation(info="<html>
<p>
This function defines the standard gravity fields for the World object.
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><td><b><i>gravityType</i></b></td>
    <td><b><i>gravity [m/s2]</i></b></td>
    <td><b><i>description</i></b></td></tr>
<tr><td>Types.GravityType.NoGravity</td>
    <td>= {0,0,0}</td>
    <td>No gravity</td></tr>

<tr><td>Types.GravityType.UniformGravity</td>
    <td>= g</td>
    <td> Constant parallel gravity field</td></tr>

<tr><td>Types.GravityType.PointGravity</td>
    <td>= -(mue/(r*r))*r/|r|</td>
    <td> Point gravity field with spherical mass</td></tr>
</table>

</html>"));
    end standardGravityAcceleration;
  end Internal;
  annotation ( Documentation(info="<HTML>
<p>
This package contains components that exert forces and torques
between two frame connectors, e.g., between two parts.
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Model</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.WorldForce\">WorldForce</a></td>
      <td valign=\"top\"> External force acting at the frame to which this component
           is connected and defined by 3 input signals,
           that are interpreted as one vector resolved in frame world, frame_b or frame_resolve. <br>
           <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/ArrowForce.png\"></td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.WorldTorque\">WorldTorque</a></td>
      <td valign=\"top\"> External torque acting at the frame to which this component
           is connected and defined by 3 input signals,
           that are interpreted as one vector resolved in frame world, frame_b or frame_resolve. <br>
           <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/ArrowTorque.png\"></td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.WorldForceAndTorque\">WorldForceAndTorque</a></td>
      <td valign=\"top\"> External force and external torque acting at the frame
           to which this component
           is connected and defined by 3+3 input signals,
           that are interpreted as a force and as a torque vector
           resolved in frame world, frame_b or frame_resolve. <br>
           <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/ArrowForce.png\"><br>
           <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/ArrowTorque.png\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.Force\">Force</a></td>
      <td valign=\"top\"> Force acting between two frames defined by 3 input signals
           resolved in frame world, frame_a, frame_b or in frame_resolve. <br>
           <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/ArrowForce2.png\"></td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.Torque\">Torque</a></td>
      <td valign=\"top\"> Torque acting between two frames defined by 3 input signals
           resolved in frame world, frame_a, frame_b or in frame_resolve. <br>
           <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/ArrowTorque2.png\"></td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.ForceAndTorque\">ForceAndTorque</a></td>
      <td valign=\"top\"> Force and torque acting between two frames defined by 3+3 input signals
           resolved in frame world, frame_a, frame_b or in frame_resolve. <br>
           <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/ArrowForce2.png\"><br>
           <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/ArrowTorque2.png\"></td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.LineForceWithMass\">LineForceWithMass</a></td>
      <td valign=\"top\">  General line force component with an optional point mass
            on the connection line. The force law can be defined by a
            component of Modelica.Mechanics.Translational<br>
           <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/LineForceWithMass.png\"></td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.LineForceWithTwoMasses\">LineForceWithTwoMasses</a></td>
      <td valign=\"top\">  General line force component with two optional point masses
            on the connection line. The force law can be defined by a
            component of Modelica.Mechanics.Translational<br>
           <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/LineForceWithTwoMasses.png\"></td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.Spring\">Spring</a></td>
      <td valign=\"top\"> Linear translational spring with optional mass <br>
           <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/Spring2.png\"></td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.Damper\">Damper</a></td>
      <td valign=\"top\"> Linear (velocity dependent) damper <br>
           <IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Forces/Damper2.png\"></td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.SpringDamperParallel\">SpringDamperParallel</a></td>
      <td valign=\"top\"> Linear spring and damper in parallel connection </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.SpringDamperSeries\">SpringDamperSeries</a></td>
      <td valign=\"top\"> Linear spring and damper in series connection </td>
  </tr>
</table>
</HTML>"));
end Forces;
