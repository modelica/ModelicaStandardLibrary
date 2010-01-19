within Modelica.Mechanics.MultiBody;
package Parts
  "Rigid components such as bodies with mass and inertia and massless rods"

  import SI = Modelica.SIunits;
  extends Modelica.Icons.Library;

  model Fixed "Frame fixed in the world frame at a given position"
    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;

    Interfaces.Frame_b frame_b "Coordinate system fixed in the world frame"
      annotation (Placement(transformation(extent={{84,-16},{116,16}}, rotation=
             0)));

    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.Position r[3]={0,0,0}
      "Position vector from world frame to frame_b, resolved in world frame";
    parameter Types.ShapeType shapeType="cylinder" " Type of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Position r_shape[3]={0,0,0}
      " Vector from world frame to shape origin, resolved in world frame"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Position lengthDirection[3]=r - r_shape
      " Vector in length direction of shape, resolved in world frame"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Position widthDirection[3]={0,1,0}
      " Vector in width direction of shape, resolved in world frame"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Length length=Modelica.Math.Vectors.length(
                                             r - r_shape) " Length of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Distance width=length/world.defaultWidthFraction
      " Width of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Distance height=width " Height of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter Types.ShapeExtra extra=0.0
      " Additional parameter for cone, pipe etc. (see docu of Visualizers.Advanced.Shape)"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor
      " Color of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));

  protected
    outer Modelica.Mechanics.MultiBody.World world;
    Visualizers.Advanced.Shape shape(
      shapeType=shapeType,
      color=color,
      specularCoefficient=specularCoefficient,
      length=length,
      width=width,
      height=height,
      lengthDirection=lengthDirection,
      widthDirection=widthDirection,
      extra=extra,
      r_shape=r_shape,
      r=zeros(3),
      R=Frames.nullRotation()) if world.enableAnimation and animation;
  equation
    Connections.root(frame_b.R);
    frame_b.r_0 = r;
    frame_b.R = Frames.nullRotation();
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-90,90},{90,-90}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{150,170},{-142,106}},
            textString="%name",
            lineColor={0,0,255}),
          Line(points={{0,100},{0,-100}}, color={0,0,0}),
          Line(points={{0,-80},{-100,-20}}, color={0,0,0}),
          Line(points={{0,-40},{-100,20}}, color={0,0,0}),
          Line(points={{0,0},{-100,60}}, color={0,0,0}),
          Line(points={{0,40},{-100,100}}, color={0,0,0}),
          Line(points={{0,0},{100,0}}, color={0,0,0}),
          Text(
            extent={{-146,-104},{154,-148}},
            lineColor={0,0,0},
            textString="r=%r")}),
      Documentation(info="<html>
<p>
Element consisting of a frame (frame_b) that is fixed in the world
frame at a given position defined by parameter vector <b>r</b>
(vector from origin of world frame to frame_b, resolved in the
world frame).
</p>
<p>
By default, this component is visualized by a cylinder connecting the
world frame and frame_b of this components, as shown in the figure below.
Note, that the visualized world frame on the left side and
Fixed.frame_b on the right side are not part of the
component animation and that the animation may be switched off via parameter
animation = <b>false</b>.
</p>
<IMG SRC=\"../Images/MultiBody/Fixed.png\" ALT=\"Parts.Fixed\">
</HTML>
"),   Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{0,100},{0,-100}}, color={0,0,0}),
          Line(points={{0,-80},{-100,-20}}, color={0,0,0}),
          Line(points={{0,-40},{-100,20}}, color={0,0,0}),
          Line(points={{0,0},{-100,60}}, color={0,0,0}),
          Line(points={{0,40},{-100,100}}, color={0,0,0}),
          Line(points={{0,0},{100,0}}, color={0,0,0})}));
  end Fixed;

  model FixedTranslation "Fixed translation of frame_b with respect to frame_a"

    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    Interfaces.Frame_a frame_a
      "Coordinate system fixed to the component with one cut-force and cut-torque"
                               annotation (Placement(transformation(extent={{
              -116,-16},{-84,16}}, rotation=0)));
    Interfaces.Frame_b frame_b
      "Coordinate system fixed to the component with one cut-force and cut-torque"
                               annotation (Placement(transformation(extent={{84,
              -16},{116,16}}, rotation=0)));

    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.Position r[3](start={0,0,0})
      "Vector from frame_a to frame_b resolved in frame_a";
    parameter Types.ShapeType shapeType="cylinder" " Type of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Position r_shape[3]={0,0,0}
      " Vector from frame_a to shape origin, resolved in frame_a"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter Types.Axis lengthDirection=r - r_shape
      " Vector in length direction of shape, resolved in frame_a"
      annotation (Evaluate=true, Dialog(tab="Animation", group=
            "if animation = true", enable=animation));
    parameter Types.Axis widthDirection={0,1,0}
      " Vector in width direction of shape, resolved in frame_a"
      annotation (Evaluate=true, Dialog(tab="Animation", group=
            "if animation = true", enable=animation));
    parameter SI.Length length=Modelica.Math.Vectors.length(
                                             r - r_shape) " Length of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Distance width=length/world.defaultWidthFraction
      " Width of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Distance height=width " Height of shape."
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter Types.ShapeExtra extra=0.0
      " Additional parameter depending on shapeType (see docu of Visualizers.Advanced.Shape)."
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor
      " Color of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));

  protected
    outer Modelica.Mechanics.MultiBody.World world;
    Visualizers.Advanced.Shape shape(
      shapeType=shapeType,
      color=color,
      specularCoefficient=specularCoefficient,
      r_shape=r_shape,
      lengthDirection=lengthDirection,
      widthDirection=widthDirection,
      length=length,
      width=width,
      height=height,
      extra=extra,
      r=frame_a.r_0,
      R=frame_a.R) if world.enableAnimation and animation;
  equation
    Connections.branch(frame_a.R, frame_b.R);
    assert(cardinality(frame_a) > 0 or cardinality(frame_b) > 0,
      "Neither connector frame_a nor frame_b of FixedTranslation object is connected");

    frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, r);
    frame_b.R = frame_a.R;

    /* Force and torque balance */
    zeros(3) = frame_a.f + frame_b.f;
    zeros(3) = frame_a.t + frame_b.t + cross(r, frame_b.f);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-99,5},{101,-5}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-131,101},{129,41}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{127,-72},{-133,-22}},
            lineColor={0,0,0},
            textString="%=r"),
          Text(
            extent={{-89,38},{-53,13}},
            lineColor={128,128,128},
            textString="a"),
          Text(
            extent={{57,39},{93,14}},
            lineColor={128,128,128},
            textString="b")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,5},{100,-5}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-95,20},{-58,20}},
            color={128,128,128},
            arrow={Arrow.None,Arrow.Filled}),
          Line(
            points={{-94,18},{-94,50}},
            color={128,128,128},
            arrow={Arrow.None,Arrow.Filled}),
          Text(
            extent={{-72,35},{-58,24}},
            lineColor={128,128,128},
            textString="x"),
          Text(
            extent={{-113,57},{-98,45}},
            lineColor={128,128,128},
            textString="y"),
          Line(points={{-100,-4},{-100,-69}}, color={128,128,128}),
          Line(points={{-100,-63},{90,-63}}, color={128,128,128}),
          Text(
            extent={{-22,-39},{16,-63}},
            lineColor={128,128,128},
            textString="r"),
          Polygon(
            points={{88,-59},{88,-68},{100,-63},{88,-59}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{100,-3},{100,-68}}, color={128,128,128}),
          Line(
            points={{69,20},{106,20}},
            color={128,128,128},
            arrow={Arrow.None,Arrow.Filled}),
          Line(
            points={{70,18},{70,50}},
            color={128,128,128},
            arrow={Arrow.None,Arrow.Filled}),
          Text(
            extent={{92,35},{106,24}},
            lineColor={128,128,128},
            textString="x"),
          Text(
            extent={{51,57},{66,45}},
            lineColor={128,128,128},
            textString="y")}),
      Documentation(info="<HTML>
<p>
Component for a <b>fixed translation</b> of frame_b with respect
to frame_a, i.e., the relationship between connectors frame_a and frame_b
remains constant and frame_a is always <b>parallel</b> to frame_b.
</p>
<p>
By default, this component is visualized by a cylinder connecting
frame_a and frame_b, as shown in the figure below. Note, that the
two visualized frames are not part of the component animation and that
the animation may be switched off via parameter animation = <b>false</b>.
</p>
<IMG SRC=\"../Images/MultiBody/FixedTranslation.png\" ALT=\"Parts.FixedTranslation\">
</HTML>"));
  end FixedTranslation;

  model FixedRotation
    "Fixed translation followed by a fixed rotation of frame_b with respect to frame_a"

    import Modelica.Mechanics.MultiBody.Frames;
    import Modelica.Mechanics.MultiBody.Types;
    import SI = Modelica.SIunits;
    import Cv = Modelica.SIunits.Conversions;
    Interfaces.Frame_a frame_a
      "Coordinate system fixed to the component with one cut-force and cut-torque"
                               annotation (Placement(transformation(extent={{
              -116,-16},{-84,16}}, rotation=0)));
    Interfaces.Frame_b frame_b
      "Coordinate system fixed to the component with one cut-force and cut-torque"
                               annotation (Placement(transformation(extent={{84,
              -16},{116,16}}, rotation=0)));

    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.Position r[3]={0,0,0}
      "Vector from frame_a to frame_b resolved in frame_a";
    parameter Modelica.Mechanics.MultiBody.Types.RotationTypes rotationType=
              Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis
      "Type of rotation description"
      annotation (Evaluate=true);
    parameter Types.Axis n={1,0,0}
      " Axis of rotation in frame_a (= same as in frame_b)"
      annotation (Evaluate=true, Dialog(group="if rotationType = RotationAxis",
                  enable=rotationType==Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis));
    parameter Cv.NonSIunits.Angle_deg angle=0
      " Angle to rotate frame_a around axis n into frame_b"
      annotation (Dialog(group="if rotationType = RotationAxis",
                  enable=rotationType==Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis));

    parameter Types.Axis n_x={1,0,0}
      " Vector along x-axis of frame_b resolved in frame_a"
      annotation (Evaluate=true, Dialog(group="if rotationType = TwoAxesVectors",
                  enable=rotationType==Types.RotationTypes.TwoAxesVectors));
    parameter Types.Axis n_y={0,1,0}
      " Vector along y-axis of frame_b resolved in frame_a"
      annotation (Evaluate=true, Dialog(group="if rotationType = TwoAxesVectors",
                  enable=rotationType==Types.RotationTypes.TwoAxesVectors));

    parameter Types.RotationSequence sequence(
      min={1,1,1},
      max={3,3,3}) = {1,2,3} " Sequence of rotations"
      annotation (Evaluate=true, Dialog(group=
                  "if rotationType = PlanarRotationSequence",
                  enable=rotationType==Types.RotationTypes.PlanarRotationSequence));
    parameter Cv.NonSIunits.Angle_deg angles[3]={0,0,0}
      " Rotation angles around the axes defined in 'sequence'"
      annotation (Dialog(group="if rotationType = PlanarRotationSequence",
                  enable=rotationType==Types.RotationTypes.PlanarRotationSequence));
    parameter Types.ShapeType shapeType="cylinder" " Type of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Position r_shape[3]={0,0,0}
      " Vector from frame_a to shape origin, resolved in frame_a"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter Types.Axis lengthDirection=r - r_shape
      " Vector in length direction of shape, resolved in frame_a"
      annotation (Evaluate=true, Dialog(tab="Animation", group=
            "if animation = true", enable=animation));
    parameter Types.Axis widthDirection={0,1,0}
      " Vector in width direction of shape, resolved in frame_a"
      annotation (Evaluate=true, Dialog(tab="Animation", group=
            "if animation = true", enable=animation));
    parameter SI.Length length=Modelica.Math.Vectors.length(
                                             r - r_shape) " Length of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Distance width=length/world.defaultWidthFraction
      " Width of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Distance height=width " Height of shape."
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter Types.ShapeExtra extra=0.0
      " Additional parameter depending on shapeType (see docu of Visualizers.Advanced.Shape)."
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  /*
  parameter Boolean checkTotalPower=false
    "= true, if total power flowing into this component shall be determined (must be zero)"
    annotation (Dialog(tab="Advanced"));
*/

    input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor
      " Color of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    final parameter Frames.Orientation R_rel=if rotationType == 1 then
        Frames.planarRotation(Modelica.Math.Vectors.normalize(
                                               n), Cv.from_deg(angle), 0) else
        if rotationType == 2 then Frames.from_nxy(n_x, n_y) else
        Frames.axesRotations(sequence, Cv.from_deg(angles), zeros(3))
      "Fixed rotation object from frame_a to frame_b";
  /*
  SI.Power totalPower
    "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";
*/
  protected
    outer Modelica.Mechanics.MultiBody.World world;

    /*
  parameter Frames.Orientation R_rel_inv=
      Frames.inverseRotation(R_rel)
*/
    parameter Frames.Orientation R_rel_inv=Frames.from_T(transpose(R_rel.T),
        zeros(3)) "Inverse of R_rel (rotate from frame_b to frame_a)";
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape shape(
      shapeType=shapeType,
      color=color,
      specularCoefficient=specularCoefficient,
      r_shape=r_shape,
      lengthDirection=lengthDirection,
      widthDirection=widthDirection,
      length=length,
      width=width,
      height=height,
      extra=extra,
      r=frame_a.r_0,
      R=frame_a.R) if world.enableAnimation and animation;

  equation
    Connections.branch(frame_a.R, frame_b.R);
    assert(cardinality(frame_a) > 0 or cardinality(frame_b) > 0,
      "Neither connector frame_a nor frame_b of FixedRotation object is connected");

    /* Relationships between quantities of frame_a and frame_b */
    frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, r);
    if rooted(frame_a.R) then
      frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
      zeros(3) = frame_a.f + Frames.resolve1(R_rel, frame_b.f);
      zeros(3) = frame_a.t + Frames.resolve1(R_rel, frame_b.t) - cross(r, frame_a.f);
    else
      frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel_inv);
      zeros(3) = frame_b.f + Frames.resolve1(R_rel_inv, frame_a.f);
      zeros(3) = frame_b.t + Frames.resolve1(R_rel_inv, frame_a.t) + cross(Frames.resolve1(R_rel_inv,r), frame_b.f);
    end if;

  /*
  if checkTotalPower then
    totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) +
                 frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) +
                 frame_a.t*Frames.angularVelocity2(frame_a.R) +
                 frame_b.t*Frames.angularVelocity2(frame_b.R);
  else
    totalPower = 0;
  end if;
*/
    annotation (
      Documentation(info="<HTML>
<p>
Component for a <b>fixed translation</b> and <b>fixed rotation</b> of frame_b with respect
to frame_a, i.e., the relationship between connectors frame_a and frame_b
remains constant. There are several possibilities to define the
orientation of frame_b with respect to frame_a:
</p>
<ul>
<li><b>Planar rotation</b> along axis 'n' (that is fixed and resolved
    in frame_a) with a fixed angle 'angle'.</li>
<li><b>Vectors n_x</b> and <b>n_y</b> that are directed along the corresponding axes
    direction of frame_b and are resolved in frame_a (if n_y is not
    orthogonal to n_x, the y-axis of frame_b is selected such that it is
    orthogonal to n_x and in the plane of n_x and n_y).</li>
<li><b>Sequence</b> of <b>three planar axes rotations</b>.
    For example, \"sequence = {1,2,3}\" and \"angles = {90, 45, -90}\"
    means to rotate frame_a around the x axis with 90 degrees, around the new
    y axis with 45 degrees and around the new z axis around -90 degrees to
    arrive at frame_b. Note, that sequence={1,2,3}
    is the Cardan angle sequence and sequence = {3,1,3} is the Euler angle
    sequence.</li>
</ul>
<p>
By default, this component is visualized by a cylinder connecting
frame_a and frame_b, as shown in the figure below. In this figure
frame_b is rotated along the z-axis of frame_a with 60 degree. Note, that the
two visualized frames are not part of the component animation and that
the animation may be switched off via parameter animation = <b>false</b>.
</p>
<IMG SRC=\"../Images/MultiBody/FixedRotation.png\" ALT=\"Parts.FixedRotation\">
</HTML>", revisions="<HTML><p><b>Release Notes:</b></p>
<ul>
  <li><i>July 28, 2003</i><br>
         Bug fixed: if rotationType = PlanarRotationSequence, then 'angles'
         was used with unit [rad] instead of [deg].</li>
</ul>
</HTML>"),
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Text(
            extent={{-136,79},{132,139}},
            textString="%name",
            lineColor={0,0,255}),
          Rectangle(
            extent={{-100,5},{100,-4}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{80,20},{129,50}}, color={0,0,0}),
          Line(points={{80,20},{57,59}}, color={0,0,0}),
          Polygon(
            points={{144,60},{117,59},{132,37},{144,60}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{43,80},{46,50},{68,65},{43,80}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-144,-52},{143,-89}},
            lineColor={0,0,0},
            textString="r=%r"),
          Text(
            extent={{-117,51},{-81,26}},
            lineColor={128,128,128},
            textString="a"),
          Text(
            extent={{84,-24},{120,-49}},
            lineColor={128,128,128},
            textString="b")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-100,-1},{-100,-66}}, color={128,128,128}),
          Line(points={{100,0},{100,-65}}, color={128,128,128}),
          Line(points={{-100,-60},{89,-60}}, color={128,128,128}),
          Text(
            extent={{-22,-36},{16,-60}},
            lineColor={128,128,128},
            textString="r"),
          Rectangle(
            extent={{-100,5},{100,-5}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{69,29},{97,45}},
            color={128,128,128},
            arrow={Arrow.None,Arrow.Filled}),
          Line(
            points={{70,27},{55,54}},
            color={128,128,128},
            arrow={Arrow.None,Arrow.Filled}),
          Text(
            extent={{95,42},{109,31}},
            lineColor={128,128,128},
            textString="x"),
          Text(
            extent={{42,70},{57,58}},
            lineColor={128,128,128},
            textString="y"),
          Line(
            points={{-95,22},{-58,22}},
            color={128,128,128},
            arrow={Arrow.None,Arrow.Filled}),
          Line(
            points={{-94,20},{-94,52}},
            color={128,128,128},
            arrow={Arrow.None,Arrow.Filled}),
          Text(
            extent={{-72,37},{-58,26}},
            lineColor={128,128,128},
            textString="x"),
          Text(
            extent={{-113,59},{-98,47}},
            lineColor={128,128,128},
            textString="y"),
          Polygon(
            points={{88,-56},{88,-65},{100,-60},{88,-56}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}));
  end FixedRotation;

  model Body
    "Rigid body with mass, inertia tensor and one frame connector (12 potential states)"

    import SI = Modelica.SIunits;
    import C = Modelica.Constants;
    import Modelica.Math.*;
    import Modelica.Mechanics.MultiBody.Types;
    import Modelica.Mechanics.MultiBody.Frames;
    Interfaces.Frame_a frame_a "Coordinate system fixed at body"
      annotation (Placement(transformation(extent={{-116,-16},{-84,16}},
            rotation=0)));
    parameter Boolean animation=true
      "= true, if animation shall be enabled (show cylinder and sphere)";
    parameter SI.Position r_CM[3](start={0,0,0})
      "Vector from frame_a to center of mass, resolved in frame_a";
    parameter SI.Mass m(min=0, start = 1) "Mass of rigid body";
    parameter SI.Inertia I_11(min=0) = 0.001 " (1,1) element of inertia tensor"
      annotation (Dialog(group=
            "Inertia tensor (resolved in center of mass, parallel to frame_a)"));
    parameter SI.Inertia I_22(min=0) = 0.001 " (2,2) element of inertia tensor"
      annotation (Dialog(group=
            "Inertia tensor (resolved in center of mass, parallel to frame_a)"));
    parameter SI.Inertia I_33(min=0) = 0.001 " (3,3) element of inertia tensor"
      annotation (Dialog(group=
            "Inertia tensor (resolved in center of mass, parallel to frame_a)"));
    parameter SI.Inertia I_21(min=-C.inf)=0 " (2,1) element of inertia tensor" annotation (
        Dialog(group=
            "Inertia tensor (resolved in center of mass, parallel to frame_a)"));
    parameter SI.Inertia I_31(min=-C.inf)=0 " (3,1) element of inertia tensor" annotation (
        Dialog(group=
            "Inertia tensor (resolved in center of mass, parallel to frame_a)"));
    parameter SI.Inertia I_32(min=-C.inf)=0 " (3,2) element of inertia tensor" annotation (
        Dialog(group=
            "Inertia tensor (resolved in center of mass, parallel to frame_a)"));

    SI.Position r_0[3](start={0,0,0}, stateSelect=if enforceStates then
                StateSelect.always else StateSelect.avoid)
      "Position vector from origin of world frame to origin of frame_a"
      annotation(Dialog(tab="Initialization", __Dymola_initialDialog=true));
    SI.Velocity v_0[3](start={0,0,0}, stateSelect=if enforceStates then StateSelect.always else
                StateSelect.avoid)
      "Absolute velocity of frame_a, resolved in world frame (= der(r_0))"
      annotation(Dialog(tab="Initialization", __Dymola_initialDialog=true));
    SI.Acceleration a_0[3](start={0,0,0})
      "Absolute acceleration of frame_a resolved in world frame (= der(v_0))"
      annotation(Dialog(tab="Initialization", __Dymola_initialDialog=true));

    parameter Boolean angles_fixed = false
      "= true, if angles_start are used as initial values, else as guess values"
      annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(tab="Initialization"));
    parameter SI.Angle angles_start[3]={0,0,0}
      "Initial values of angles to rotate frame_a around 'sequence_start' axes into frame_b"
      annotation (Dialog(tab="Initialization"));
    parameter Types.RotationSequence sequence_start={1,2,3}
      "Sequence of rotations to rotate frame_a into frame_b at initial time"
      annotation (Evaluate=true, Dialog(tab="Initialization"));

    parameter Boolean w_0_fixed = false
      "= true, if w_0_start are used as initial values, else as guess values"
      annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(tab="Initialization"));
    parameter SI.AngularVelocity w_0_start[3]={0,0,0}
      "Initial or guess values of angular velocity of frame_a resolved in world frame"
      annotation (Dialog(tab="Initialization"));

    parameter Boolean z_0_fixed = false
      "= true, if z_0_start are used as initial values, else as guess values"
      annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(tab="Initialization"));
    parameter SI.AngularAcceleration z_0_start[3]={0,0,0}
      "Initial values of angular acceleration z_0 = der(w_0)"
      annotation (Dialog(tab="Initialization"));

    parameter SI.Diameter sphereDiameter=world.defaultBodyDiameter
      "Diameter of sphere" annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor
      "Color of sphere" annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    parameter SI.Diameter cylinderDiameter=sphereDiameter/Types.Defaults.
        BodyCylinderDiameterFraction "Diameter of cylinder"
      annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    input Types.Color cylinderColor=sphereColor "Color of cylinder"
      annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    parameter Boolean enforceStates=false
      " = true, if absolute variables of body object shall be used as states (StateSelect.always)"
      annotation (Evaluate=true,Dialog(tab="Advanced"));
    parameter Boolean useQuaternions=true
      " = true, if quaternions shall be used as potential states otherwise use 3 angles as potential states"
      annotation (Evaluate=true,Dialog(tab="Advanced"));
    parameter Types.RotationSequence sequence_angleStates={1,2,3}
      " Sequence of rotations to rotate world frame into frame_a around the 3 angles used as potential states"
       annotation (Evaluate=true, Dialog(tab="Advanced", enable=not
            useQuaternions));

    final parameter SI.Inertia I[3, 3]=[I_11, I_21, I_31; I_21, I_22, I_32;
        I_31, I_32, I_33] "inertia tensor";
    final parameter Frames.Orientation R_start=Modelica.Mechanics.MultiBody.Frames.axesRotations(
        sequence_start, angles_start, zeros(3))
      "Orientation object from world frame to frame_a at initial time";
    final parameter SI.AngularAcceleration z_a_start[3]=Frames.resolve2(R_start, z_0_start)
      "Initial values of angular acceleration z_a = der(w_a), i.e., time derivative of angular velocity resolved in frame_a";

    SI.AngularVelocity w_a[3](start=Frames.resolve2(R_start, w_0_start),
                              fixed=fill(w_0_fixed,3),
                              stateSelect=if enforceStates then (if useQuaternions then
                              StateSelect.always else StateSelect.never) else StateSelect.avoid)
      "Absolute angular velocity of frame_a resolved in frame_a";
    SI.AngularAcceleration z_a[3](start=Frames.resolve2(R_start, z_0_start),fixed=fill(z_0_fixed,3))
      "Absolute angular acceleration of frame_a resolved in frame_a";
    SI.Acceleration g_0[3] "Gravity acceleration resolved in world frame";

  protected
    outer Modelica.Mechanics.MultiBody.World world;

    // Declarations for quaternions (dummies, if quaternions are not used)
    parameter Frames.Quaternions.Orientation Q_start=Frames.to_Q(R_start)
      "Quaternion orientation object from world frame to frame_a at initial time";
    Frames.Quaternions.Orientation Q(start=Q_start, stateSelect=if
          enforceStates then (if useQuaternions then StateSelect.prefer else
          StateSelect.never) else StateSelect.avoid)
      "Quaternion orientation object from world frame to frame_a (dummy value, if quaternions are not used as states)";

    // Declaration for 3 angles
    parameter SI.Angle phi_start[3]=if sequence_start[1] ==
        sequence_angleStates[1] and sequence_start[2] == sequence_angleStates[2]
         and sequence_start[3] == sequence_angleStates[3] then angles_start else
         Frames.axesRotationsAngles(R_start, sequence_angleStates)
      "Potential angle states at initial time";
    SI.Angle phi[3](start=phi_start, stateSelect=if enforceStates then (if
          useQuaternions then StateSelect.never else StateSelect.always) else
          StateSelect.avoid)
      "Dummy or 3 angles to rotate world frame into frame_a of body";
    SI.AngularVelocity phi_d[3](stateSelect=if enforceStates then (if
          useQuaternions then StateSelect.never else StateSelect.always) else
          StateSelect.avoid) "= der(phi)";
    SI.AngularAcceleration phi_dd[3] "= der(phi_d)";

    // Declarations for animation
    Visualizers.Advanced.Shape cylinder(
      shapeType="cylinder",
      color=cylinderColor,
      specularCoefficient=specularCoefficient,
      length=if Modelica.Math.Vectors.length(r_CM) > sphereDiameter/2 then
                Modelica.Math.Vectors.length(r_CM) - (if cylinderDiameter > 1.1*
          sphereDiameter then sphereDiameter/2 else 0) else 0,
      width=cylinderDiameter,
      height=cylinderDiameter,
      lengthDirection=r_CM,
      widthDirection={0,1,0},
      r=frame_a.r_0,
      R=frame_a.R) if world.enableAnimation and animation;
    Visualizers.Advanced.Shape sphere(
      shapeType="sphere",
      color=sphereColor,
      specularCoefficient=specularCoefficient,
      length=sphereDiameter,
      width=sphereDiameter,
      height=sphereDiameter,
      lengthDirection={1,0,0},
      widthDirection={0,1,0},
      r_shape=r_CM - {1,0,0}*sphereDiameter/2,
      r=frame_a.r_0,
      R=frame_a.R) if world.enableAnimation and animation and sphereDiameter > 0;
  initial equation
    if angles_fixed then
      // Initialize positional variables
      if not Connections.isRoot(frame_a.R) then
        // frame_a.R is computed somewhere else
        zeros(3) = Frames.Orientation.equalityConstraint(frame_a.R, R_start);
      elseif useQuaternions then
        // frame_a.R is computed from quaternions Q
        zeros(3) = Frames.Quaternions.Orientation.equalityConstraint(Q, Q_start);
      else
        // frame_a.R is computed from the 3 angles 'phi'
        phi = phi_start;
      end if;
    end if;

  equation
    if enforceStates then
      Connections.root(frame_a.R);
    else
      Connections.potentialRoot(frame_a.R);
    end if;
    r_0 = frame_a.r_0;

    if not Connections.isRoot(frame_a.R) then
      // Body does not have states
      // Dummies
      Q = {0,0,0,1};
      phi = zeros(3);
      phi_d = zeros(3);
      phi_dd = zeros(3);
    elseif useQuaternions then
      // Use Quaternions as states (with dynamic state selection)
      frame_a.R = Frames.from_Q(Q, Frames.Quaternions.angularVelocity2(Q, der(Q)));
      {0} = Frames.Quaternions.orientationConstraint(Q);

      // Dummies
      phi = zeros(3);
      phi_d = zeros(3);
      phi_dd = zeros(3);
    else
      // Use Cardan angles as states
      phi_d = der(phi);
      phi_dd = der(phi_d);
      frame_a.R = Frames.axesRotations(sequence_angleStates, phi, phi_d);

      // Dummies
      Q = {0,0,0,1};
    end if;

    // gravity acceleration at center of mass resolved in world frame
    g_0 = world.gravityAcceleration(frame_a.r_0 + Frames.resolve1(frame_a.R,
      r_CM));

    // translational kinematic differential equations
    v_0 = der(frame_a.r_0);
    a_0 = der(v_0);

    // rotational kinematic differential equations
    w_a = Frames.angularVelocity2(frame_a.R);
    z_a = der(w_a);

    /* Newton/Euler equations with respect to center of mass
            a_CM = a_a + cross(z_a, r_CM) + cross(w_a, cross(w_a, r_CM));
            f_CM = m*(a_CM - g_a);
            t_CM = I*z_a + cross(w_a, I*w_a);
       frame_a.f = f_CM
       frame_a.t = t_CM + cross(r_CM, f_CM);
    Inserting the first three equations in the last two results in:
  */
    frame_a.f = m*(Frames.resolve2(frame_a.R, a_0 - g_0) + cross(z_a, r_CM) +
      cross(w_a, cross(w_a, r_CM)));
    frame_a.t = I*z_a + cross(w_a, I*w_a) + cross(r_CM, frame_a.f);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,30},{-3,-31}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255}),
          Text(
            extent={{131,-123},{-129,-73}},
            lineColor={0,0,0},
            textString="m=%m"),
          Text(
            extent={{-128,132},{132,72}},
            textString="%name",
            lineColor={0,0,255}),
          Ellipse(
            extent={{-20,60},{100,-60}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={0,127,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      Documentation(info="<HTML>
<p>
<b>Rigid body</b> with mass and inertia tensor.
All parameter vectors have to be resolved in frame_a.
The <b>inertia tensor</b> has to be defined with respect to a
coordinate system that is parallel to frame_a with the
origin at the center of mass of the body.
</p>
<p>
By default, this component is visualized by a <b>cylinder</b> located
between frame_a and the center of mass and by a <b>sphere</b> that has
its center at the center of mass. If the cylinder length is smaller as
the radius of the sphere, e.g., since frame_a is located at the
center of mass, the cylinder is not displayed. Note, that
the animation may be switched off via parameter animation = <b>false</b>.
</p>
<IMG SRC=\"../Images/MultiBody/Body.png\" ALT=\"Parts.Body\">
<p>
<b>States of Body Components</b>
</p>
<p>
Every body has potential states. If possible a tool will select
the states of joints and not the states of bodies because this is
usually the most efficient choice. In this case the position, orientation,
velocity and angular velocity of frame_a of the body will be computed
by the component that is connected to frame_a. However, if a body is moving
freely in space, variables of the body have to be used as states. The potential
states of the body are:
</p>
<ul>
<li> The <b>position vector</b> frame_a.r_0 from the origin of the
     world frame to the origin of frame_a of the body, resolved in
     the world frame and the <b>absolute velocity</b> v_0 of the origin of
     frame_a, resolved in the world frame (= der(frame_a.r_0)).</li>
</li>
<li> If parameter <b>useQuaternions</b> in the \"Advanced\" menu
     is <b>true</b> (this is the default), then <b>4 quaternions</b>
     are potential states. Additionally, the coordinates of the
     absolute angular velocity vector of the
     body are 3 potential states.<br>
     If <b>useQuaternions</b> in the \"Advanced\" menu
     is <b>false</b>, then <b>3 angles</b> and the derivatives of
     these angles are potential states. The orientation of frame_a
     is computed by rotating the world frame along the axes defined
     in parameter vector \"sequence_angleStates\" (default = {1,2,3}, i.e.,
     the Cardan angle sequence) around the angles used as potential states.
     For example, the default is to rotate the x-axis of the world frame
     around angles[1], the new y-axis around angles[2] and the new z-axis
     around angles[3], arriving at frame_a.
 </li>
</ul>
<p>
The quaternions have the slight disadvantage that there is a
non-linear constraint equation between the 4 quaternions.
Therefore, at least one non-linear equation has to be solved
during simulation. A tool might, however, analytically solve this
simple constraint equation. Using the 3 angles as states has the
disadvantage that there is a singular configuration in which a
division by zero will occur. If it is possible to determine in advance
for an application class that this singular configuration is outside
of the operating region, the 3 angles might be used as potential
states by setting <b>useQuaternions</b> = <b>false</b>.
</p>
<p>
In text books about 3-dimensional mechanics often 3 angles and the
angular velocity are used as states. This is not the case here, since
3 angles and their derivatives are used as potential states
(if useQuaternions = false). The reason
is that for real-time simulation the discretization formula of the
integrator might be \"inlined\" and solved together with the body equations.
By appropriate symbolic transformation the performance is
drastically increased if angles and their
derivatives are used as states, instead of angles and the angular
velocity.
</p>
<p>
Whether or not variables of the body are used as states is usually
automatically selected by the Modelica translator. If parameter
<b>enforceStates</b> is set to <b>true</b> in the \"Advanced\" menu,
then body variables are forced to be used as states according
to the setting of parameters \"useQuaternions\" and
\"sequence_angleStates\".
</p>
</HTML>"));
  end Body;

  model BodyShape
    "Rigid body with mass, inertia tensor, different shapes for animation, and two frame connectors (12 potential states)"

    import SI = Modelica.SIunits;
    import C = Modelica.Constants;
    import Modelica.Mechanics.MultiBody.Types;

    Interfaces.Frame_a frame_a
      "Coordinate system fixed to the component with one cut-force and cut-torque"
                               annotation (Placement(transformation(extent={{
              -116,-16},{-84,16}}, rotation=0)));
    Interfaces.Frame_b frame_b
      "Coordinate system fixed to the component with one cut-force and cut-torque"
                               annotation (Placement(transformation(extent={{84,
              -16},{116,16}}, rotation=0)));

    parameter Boolean animation=true
      "= true, if animation shall be enabled (show shape between frame_a and frame_b and optionally a sphere at the center of mass)";
    parameter Boolean animateSphere=true
      "= true, if mass shall be animated as sphere provided animation=true";
    parameter SI.Position r[3](start={0,0,0})
      "Vector from frame_a to frame_b resolved in frame_a";
    parameter SI.Position r_CM[3](start={0,0,0})
      "Vector from frame_a to center of mass, resolved in frame_a";
    parameter SI.Mass m(min=0, start = 1) "Mass of rigid body";
    parameter SI.Inertia I_11(min=0) = 0.001 " (1,1) element of inertia tensor"
      annotation (Dialog(group=
            "Inertia tensor (resolved in center of mass, parallel to frame_a)"));
    parameter SI.Inertia I_22(min=0) = 0.001 " (2,2) element of inertia tensor"
      annotation (Dialog(group=
            "Inertia tensor (resolved in center of mass, parallel to frame_a)"));
    parameter SI.Inertia I_33(min=0) = 0.001 " (3,3) element of inertia tensor"
      annotation (Dialog(group=
            "Inertia tensor (resolved in center of mass, parallel to frame_a)"));
    parameter SI.Inertia I_21(min=-C.inf) = 0
      " (2,1) element of inertia tensor"
      annotation (Dialog(group=
            "Inertia tensor (resolved in center of mass, parallel to frame_a)"));
    parameter SI.Inertia I_31(min=-C.inf) = 0
      " (3,1) element of inertia tensor"
      annotation (Dialog(group=
            "Inertia tensor (resolved in center of mass, parallel to frame_a)"));
    parameter SI.Inertia I_32(min=-C.inf) = 0
      " (3,2) element of inertia tensor"
      annotation (Dialog(group=
            "Inertia tensor (resolved in center of mass, parallel to frame_a)"));

    SI.Position r_0[3](start={0,0,0}, stateSelect=if enforceStates then
                StateSelect.always else StateSelect.avoid)
      "Position vector from origin of world frame to origin of frame_a"
      annotation(Dialog(tab="Initialization", __Dymola_initialDialog=true));
    SI.Velocity v_0[3](start={0,0,0}, stateSelect=if enforceStates then StateSelect.always else
                StateSelect.avoid)
      "Absolute velocity of frame_a, resolved in world frame (= der(r_0))"
      annotation(Dialog(tab="Initialization", __Dymola_initialDialog=true));
    SI.Acceleration a_0[3](start={0,0,0})
      "Absolute acceleration of frame_a resolved in world frame (= der(v_0))"
      annotation(Dialog(tab="Initialization", __Dymola_initialDialog=true));

    parameter Boolean angles_fixed = false
      "= true, if angles_start are used as initial values, else as guess values"
      annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(tab="Initialization"));
    parameter SI.Angle angles_start[3]={0,0,0}
      "Initial values of angles to rotate frame_a around 'sequence_start' axes into frame_b"
      annotation (Dialog(tab="Initialization"));
    parameter Types.RotationSequence sequence_start={1,2,3}
      "Sequence of rotations to rotate frame_a into frame_b at initial time"
      annotation (Evaluate=true, Dialog(tab="Initialization"));

    parameter Boolean w_0_fixed = false
      "= true, if w_0_start are used as initial values, else as guess values"
      annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(tab="Initialization"));
    parameter SI.AngularVelocity w_0_start[3]={0,0,0}
      "Initial or guess values of angular velocity of frame_a resolved in world frame"
      annotation (Dialog(tab="Initialization"));

    parameter Boolean z_0_fixed = false
      "= true, if z_0_start are used as initial values, else as guess values"
      annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(tab="Initialization"));
    parameter SI.AngularAcceleration z_0_start[3]={0,0,0}
      "Initial values of angular acceleration z_0 = der(w_0)"
      annotation (Dialog(tab="Initialization"));

    parameter Types.ShapeType shapeType="cylinder" " Type of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Position r_shape[3]={0,0,0}
      " Vector from frame_a to shape origin, resolved in frame_a"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter Types.Axis lengthDirection=r - r_shape
      " Vector in length direction of shape, resolved in frame_a"
      annotation (Evaluate=true, Dialog(tab="Animation", group=
            "if animation = true", enable=animation));
    parameter Types.Axis widthDirection={0,1,0}
      " Vector in width direction of shape, resolved in frame_a"
      annotation (Evaluate=true, Dialog(tab="Animation", group=
            "if animation = true", enable=animation));
    parameter SI.Length length=Modelica.Math.Vectors.length(
                                             r - r_shape) " Length of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Distance width=length/world.defaultWidthFraction
      " Width of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Distance height=width " Height of shape."
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter Types.ShapeExtra extra=0.0
      " Additional parameter depending on shapeType (see docu of Visualizers.Advanced.Shape)."
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor
      " Color of shape"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Diameter sphereDiameter=2*width " Diameter of sphere"
      annotation (Dialog(tab="Animation", group=
            "if animation = true and animateSphere = true",
            enable=animation and animateSphere));
    input Types.Color sphereColor=color " Color of sphere of mass"
      annotation (Dialog(tab="Animation", group=
            "if animation = true and animateSphere = true", enable=animation and animateSphere));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(tab="Animation", group=
            "if animation = true", enable=animation));
    parameter Boolean enforceStates=false
      " = true, if absolute variables of body object shall be used as states (StateSelect.always)"
      annotation (Dialog(tab="Advanced"));
    parameter Boolean useQuaternions=true
      " = true, if quaternions shall be used as potential states otherwise use 3 angles as potential states"
      annotation (Dialog(tab="Advanced"));
    parameter Types.RotationSequence sequence_angleStates={1,2,3}
      " Sequence of rotations to rotate world frame into frame_a around the 3 angles used as potential states"
       annotation (Evaluate=true, Dialog(tab="Advanced", enable=not
            useQuaternions));

    FixedTranslation frameTranslation(r=r, animation=false)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=
             0)));
    Body body(
      r_CM=r_CM,
      m=m,
      I_11=I_11,
      I_22=I_22,
      I_33=I_33,
      I_21=I_21,
      I_31=I_31,
      I_32=I_32,
      animation=false,
      sequence_start=sequence_start,
      angles_fixed=angles_fixed,
      angles_start=angles_start,
      w_0_fixed=w_0_fixed,
      w_0_start=w_0_start,
      z_0_fixed=z_0_fixed,
      z_0_start=z_0_start,
      useQuaternions=useQuaternions,
      enforceStates=enforceStates,
      sequence_angleStates=sequence_angleStates)
      annotation (Placement(transformation(extent={{-27.3333,-70.3333},{13,-30}},
            rotation=0)));
  protected
    outer Modelica.Mechanics.MultiBody.World world;
    Visualizers.Advanced.Shape shape1(
      shapeType=shapeType,
      color=color,
      specularCoefficient=specularCoefficient,
      length=length,
      width=width,
      height=height,
      lengthDirection=lengthDirection,
      widthDirection=widthDirection,
      r_shape=r_shape,
      extra=extra,
      r=frame_a.r_0,
      R=frame_a.R) if world.enableAnimation and animation;
    Visualizers.Advanced.Shape shape2(
      shapeType="sphere",
      color=sphereColor,
      specularCoefficient=specularCoefficient,
      length=sphereDiameter,
      width=sphereDiameter,
      height=sphereDiameter,
      lengthDirection={1,0,0},
      widthDirection={0,1,0},
      r_shape=r_CM - {1,0,0}*sphereDiameter/2,
      r=frame_a.r_0,
      R=frame_a.R) if world.enableAnimation and animation and animateSphere;
  equation
    r_0 = frame_a.r_0;
    v_0 = der(r_0);
    a_0 = der(v_0);
    connect(frame_a, frameTranslation.frame_a)
      annotation (Line(
        points={{-100,0},{-20,0}},
        color={95,95,95},
        thickness=0.5));
    connect(frame_b, frameTranslation.frame_b)
      annotation (Line(
        points={{100,0},{20,0}},
        color={95,95,95},
        thickness=0.5));
    connect(frame_a, body.frame_a) annotation (Line(
        points={{-100,0},{-60,0},{-60,-50.1666},{-27.3333,-50.1666}},
        color={95,95,95},
        thickness=0.5));
    annotation (
      Documentation(info="<HTML>
<p>
<b>Rigid body</b> with mass and inertia tensor and <b>two frame connectors</b>.
All parameter vectors have to be resolved in frame_a.
The <b>inertia tensor</b> has to be defined with respect to a
coordinate system that is parallel to frame_a with the
origin at the center of mass of the body. The coordinate system <b>frame_b</b>
is always parallel to <b>frame_a</b>.
</p>
<p>
By default, this component is visualized by any <b>shape</b> that can be
defined with Modelica.Mechanics.MultiBody.Visualizers.FixedShape. This shape is placed
between frame_a and frame_b (default: length(shape) = Frames.length(r)).
Additionally a <b>sphere</b> may be visualized that has
its center at the center of mass.
Note, that
the animation may be switched off via parameter animation = <b>false</b>.
</p>
<IMG SRC=\"../Images/MultiBody/BodyShape.png\" ALT=\"Parts.BodyShape\">
<p>
The following shapes can be defined via parameter <b>shapeType</b>,
e.g., shapeType=\"cone\":
</p>
<IMG SRC=\"../Images/MultiBody/FixedShape.png\" ALT=\"Visualizers.FixedShape\">
<p>
A BodyShape component has potential states. For details of these
states and of the \"Advanced\" menu parameters, see model
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Parts.Body\">MultiBody.Parts.Body</a>.
</p>
</HTML>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Text(
            extent={{-134,126},{126,66}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{122,-123},{-138,-73}},
            lineColor={0,0,0},
            textString="%=r"),
          Rectangle(
            extent={{-100,31},{101,-30}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255}),
          Ellipse(
            extent={{-60,60},{60,-60}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={0,127,255}),
          Text(
            extent={{-50,24},{55,-27}},
            lineColor={0,0,0},
            textString="%m"),
          Text(
            extent={{55,12},{91,-13}},
            lineColor={0,0,0},
            textString="b"),
          Text(
            extent={{-92,13},{-56,-12}},
            lineColor={0,0,0},
            textString="a")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Line(points={{-100,9},{-100,43}}, color={128,128,128}),
          Line(points={{100,0},{100,44}}, color={128,128,128}),
          Line(points={{-100,40},{90,40}}, color={135,135,135}),
          Polygon(
            points={{90,44},{90,36},{100,40},{90,44}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-22,68},{20,40}},
            lineColor={128,128,128},
            textString="r"),
          Line(points={{-100,-10},{-100,-90}}, color={128,128,128}),
          Line(points={{-100,-84},{-10,-84}}, color={128,128,128}),
          Polygon(
            points={{-10,-80},{-10,-88},{0,-84},{-10,-80}},
            lineColor={128,128,128},
            fillColor={128,128,128},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-82,-66},{-56,-84}},
            lineColor={128,128,128},
            textString="r_CM"),
          Line(points={{0,-46},{0,-90}}, color={128,128,128})}));
  end BodyShape;

  model BodyBox
    "Rigid body with box shape. Mass and animation properties are computed from box data and density (12 potential states)"

    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;

    Interfaces.Frame_a frame_a
      "Coordinate system fixed to the component with one cut-force and cut-torque"
                               annotation (Placement(transformation(extent={{
              -116,-16},{-84,16}}, rotation=0)));
    Interfaces.Frame_b frame_b
      "Coordinate system fixed to the component with one cut-force and cut-torque"
                               annotation (Placement(transformation(extent={{84,
              -16},{116,16}}, rotation=0)));
    parameter Boolean animation=true
      "= true, if animation shall be enabled (show box between frame_a and frame_b)";
    parameter SI.Position r[3](start={0.1,0,0})
      "Vector from frame_a to frame_b resolved in frame_a";
    parameter SI.Position r_shape[3]={0,0,0}
      "Vector from frame_a to box origin, resolved in frame_a";
    parameter Modelica.Mechanics.MultiBody.Types.Axis lengthDirection=r - r_shape
      "Vector in length direction of box, resolved in frame_a"
      annotation (Evaluate=true);
    parameter Modelica.Mechanics.MultiBody.Types.Axis widthDirection={0,1,0}
      "Vector in width direction of box, resolved in frame_a"
      annotation (Evaluate=true);
    parameter SI.Length length=Modelica.Math.Vectors.length(
                                             r - r_shape) "Length of box";
    parameter SI.Distance width=length/world.defaultWidthFraction
      "Width of box";
    parameter SI.Distance height=width "Height of box";
    parameter SI.Distance innerWidth=0
      "Width of inner box surface (0 <= innerWidth <= width)";
    parameter SI.Distance innerHeight=innerWidth
      "Height of inner box surface (0 <= innerHeight <= height)";
    parameter SI.Density density = 7700
      "Density of cylinder (e.g., steel: 7700 .. 7900, wood : 400 .. 800)";
    input Modelica.Mechanics.MultiBody.Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor
      "Color of box"
      annotation (Dialog(enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(enable=animation));

    SI.Position r_0[3](start={0,0,0}, stateSelect=if enforceStates then
                StateSelect.always else StateSelect.avoid)
      "Position vector from origin of world frame to origin of frame_a"
      annotation(Dialog(tab="Initialization", __Dymola_initialDialog=true));
    SI.Velocity v_0[3](start={0,0,0}, stateSelect=if enforceStates then StateSelect.always else
                StateSelect.avoid)
      "Absolute velocity of frame_a, resolved in world frame (= der(r_0))"
      annotation(Dialog(tab="Initialization", __Dymola_initialDialog=true));
    SI.Acceleration a_0[3](start={0,0,0})
      "Absolute acceleration of frame_a resolved in world frame (= der(v_0))"
      annotation(Dialog(tab="Initialization", __Dymola_initialDialog=true));

    parameter Boolean angles_fixed = false
      "= true, if angles_start are used as initial values, else as guess values"
      annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(tab="Initialization"));
    parameter SI.Angle angles_start[3]={0,0,0}
      "Initial values of angles to rotate frame_a around 'sequence_start' axes into frame_b"
      annotation (Dialog(tab="Initialization"));
    parameter Types.RotationSequence sequence_start={1,2,3}
      "Sequence of rotations to rotate frame_a into frame_b at initial time"
      annotation (Evaluate=true, Dialog(tab="Initialization"));

    parameter Boolean w_0_fixed = false
      "= true, if w_0_start are used as initial values, else as guess values"
      annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(tab="Initialization"));
    parameter SI.AngularVelocity w_0_start[3]={0,0,0}
      "Initial or guess values of angular velocity of frame_a resolved in world frame"
      annotation (Dialog(tab="Initialization"));

    parameter Boolean z_0_fixed = false
      "= true, if z_0_start are used as initial values, else as guess values"
      annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(tab="Initialization"));
    parameter SI.AngularAcceleration z_0_start[3]={0,0,0}
      "Initial values of angular acceleration z_0 = der(w_0)"
      annotation (Dialog(tab="Initialization"));

    parameter Boolean enforceStates=false
      " = true, if absolute variables of body object shall be used as states (StateSelect.always)"
      annotation (Dialog(tab="Advanced"));
    parameter Boolean useQuaternions=true
      " = true, if quaternions shall be used as potential states otherwise use 3 angles as potential states"
      annotation (Dialog(tab="Advanced"));
    parameter Types.RotationSequence sequence_angleStates={1,2,3}
      " Sequence of rotations to rotate world frame into frame_a around the 3 angles used as potential states"
       annotation (Evaluate=true, Dialog(tab="Advanced", enable=not
            useQuaternions));

    final parameter SI.Mass mo(min=0)=density*length*width*height
      "Mass of box without hole";
    final parameter SI.Mass mi(min=0)=density*length*innerWidth*innerHeight
      "Mass of hole of box";
    final parameter SI.Mass m(min=0)=mo - mi "Mass of box";
    final parameter Frames.Orientation R=Frames.from_nxy(r, widthDirection)
      "Orientation object from frame_a to coordinates system spanned by r and widthDirection";
    final parameter SI.Position r_CM[3]=Modelica.Math.Vectors.normalize(
                                                         r)*length/2
      "Position vector from origin of frame_a to center of mass, resolved in frame_a";
    final parameter SI.Inertia I[3, 3]=Frames.resolveDyade1(R, diagonal({mo*(
        width*width + height*height) - mi*(innerWidth*innerWidth + innerHeight*
        innerHeight),mo*(length*length + height*height) - mi*(length*length +
        innerHeight*innerHeight),mo*(length*length + width*width) - mi*(length*
        length + innerWidth*innerWidth)}/12))
      "Inertia tensor of body box with respect to center of mass, parallel to frame_a";
    Body body(
      animation=false,
      r_CM=r_CM,
      m=m,
      I_11=I[1, 1],
      I_22=I[2, 2],
      I_33=I[3, 3],
      I_21=I[2, 1],
      I_31=I[3, 1],
      I_32=I[3, 2],
      sequence_start=sequence_start,
      angles_fixed=angles_fixed,
      angles_start=angles_start,
      w_0_fixed=w_0_fixed,
      w_0_start=w_0_start,
      z_0_fixed=z_0_fixed,
      z_0_start=z_0_start,
      useQuaternions=useQuaternions,
      enforceStates=enforceStates,
      sequence_angleStates=sequence_angleStates)
      annotation (Placement(transformation(extent={{-30,-80},{10,-40}},
            rotation=0)));
    FixedTranslation frameTranslation(
      r=r,
      animation=animation,
      shapeType="box",
      r_shape=r_shape,
      lengthDirection=lengthDirection,
      widthDirection=widthDirection,
      length=length,
      width=width,
      height=height,
      color=color,
     specularCoefficient=specularCoefficient) annotation (Placement(
          transformation(extent={{-30,-20},{10,20}}, rotation=0)));

  protected
    outer Modelica.Mechanics.MultiBody.World world;
  equation
    r_0 = frame_a.r_0;
    v_0 = der(r_0);
    a_0 = der(v_0);

    assert(innerWidth <= width,
      "parameter innerWidth is greater as parameter width");
    assert(innerHeight <= height,
      "parameter innerHeight is greater as paraemter height");
    connect(frameTranslation.frame_a, frame_a) annotation (Line(
        points={{-30,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(frameTranslation.frame_b, frame_b) annotation (Line(
        points={{10,0},{100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(frame_a, body.frame_a) annotation (Line(
        points={{-100,0},{-70,0},{-70,-60},{-30,-60}},
        color={95,95,95},
        thickness=0.5));
    annotation (
      Documentation(info="<HTML>
<p>
<b>Rigid body</b> with <b>box</b> shape.
The mass properties of the body (mass, center of mass,
inertia tensor) are computed
from the box data. Optionally, the box may be hollow.
The (outer) box shape is by default used in the animation.
The hollow part is not shown in the animation.
The two connector frames <b>frame_a</b> and <b>frame_b</b>
are always parallel to each other. Example of component
animation (note, that
the animation may be switched off via parameter animation = <b>false</b>):
</p>
<IMG SRC=\"../Images/MultiBody/BodyBox.png\" ALT=\"Parts.BodyBox\">
<p>
A BodyBox component has potential states. For details of these
states and of the \"Advanced\" menu parameters, see model
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Parts.Body\">MultiBody.Parts.Body</a>.</p>
</HTML>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Polygon(
            points={{100,40},{100,-30},{90,-40},{90,30},{100,40}},
            lineColor={0,95,191},
            fillColor={0,95,191},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,30},{90,-40}},
            lineColor={0,127,255},
            pattern=LinePattern.None,
            fillColor={0,127,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-100,30},{-90,40},{100,40},{90,30},{-100,30}},
            lineColor={0,95,191},
            fillColor={0,95,191},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-129,100},{131,40}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{130,-98},{-130,-48}},
            lineColor={0,0,0},
            textString="%=r"),
          Text(
            extent={{52,8},{88,-17}},
            lineColor={0,0,0},
            textString="b"),
          Text(
            extent={{-87,12},{-51,-13}},
            lineColor={0,0,0},
            textString="a")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics));
  end BodyBox;

  model BodyCylinder
    "Rigid body with cylinder shape. Mass and animation properties are computed from cylinder data and density (12 potential states)"

    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    import Modelica.Mechanics.MultiBody.Types;
    Interfaces.Frame_a frame_a
      "Coordinate system fixed to the component with one cut-force and cut-torque"
                               annotation (Placement(transformation(extent={{
              -116,-16},{-84,16}}, rotation=0)));
    Interfaces.Frame_b frame_b
      "Coordinate system fixed to the component with one cut-force and cut-torque"
                               annotation (Placement(transformation(extent={{84,
              -16},{116,16}}, rotation=0)));
    parameter Boolean animation=true
      "= true, if animation shall be enabled (show cylinder between frame_a and frame_b)";
    parameter SI.Position r[3](start={0.1,0,0})
      "Vector from frame_a to frame_b, resolved in frame_a";
    parameter SI.Position r_shape[3]={0,0,0}
      "Vector from frame_a to cylinder origin, resolved in frame_a";
    parameter Modelica.Mechanics.MultiBody.Types.Axis lengthDirection=r - r_shape
      "Vector in length direction of cylinder, resolved in frame_a"
      annotation (Evaluate=true);
    parameter SI.Length length=Modelica.Math.Vectors.length(
                                             r - r_shape) "Length of cylinder";
    parameter SI.Distance diameter=length/world.defaultWidthFraction
      "Diameter of cylinder";
    parameter SI.Distance innerDiameter=0
      "Inner diameter of cylinder (0 <= innerDiameter <= Diameter)";
    parameter SI.Density density = 7700
      "Density of cylinder (e.g., steel: 7700 .. 7900, wood : 400 .. 800)";
    input Modelica.Mechanics.MultiBody.Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor
      "Color of cylinder" annotation (Dialog(enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(enable=animation));

    SI.Position r_0[3](start={0,0,0}, stateSelect=if enforceStates then
                StateSelect.always else StateSelect.avoid)
      "Position vector from origin of world frame to origin of frame_a"
      annotation(Dialog(tab="Initialization", __Dymola_initialDialog=true));
    SI.Velocity v_0[3](start={0,0,0}, stateSelect=if enforceStates then StateSelect.always else
                StateSelect.avoid)
      "Absolute velocity of frame_a, resolved in world frame (= der(r_0))"
      annotation(Dialog(tab="Initialization", __Dymola_initialDialog=true));
    SI.Acceleration a_0[3](start={0,0,0})
      "Absolute acceleration of frame_a resolved in world frame (= der(v_0))"
      annotation(Dialog(tab="Initialization", __Dymola_initialDialog=true));

    parameter Boolean angles_fixed = false
      "= true, if angles_start are used as initial values, else as guess values"
      annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(tab="Initialization"));
    parameter SI.Angle angles_start[3]={0,0,0}
      "Initial values of angles to rotate frame_a around 'sequence_start' axes into frame_b"
      annotation (Dialog(tab="Initialization"));
    parameter Types.RotationSequence sequence_start={1,2,3}
      "Sequence of rotations to rotate frame_a into frame_b at initial time"
      annotation (Evaluate=true, Dialog(tab="Initialization"));

    parameter Boolean w_0_fixed = false
      "= true, if w_0_start are used as initial values, else as guess values"
      annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(tab="Initialization"));
    parameter SI.AngularVelocity w_0_start[3]={0,0,0}
      "Initial or guess values of angular velocity of frame_a resolved in world frame"
      annotation (Dialog(tab="Initialization"));

    parameter Boolean z_0_fixed = false
      "= true, if z_0_start are used as initial values, else as guess values"
      annotation(Evaluate=true, choices(__Dymola_checkBox=true), Dialog(tab="Initialization"));
    parameter SI.AngularAcceleration z_0_start[3]={0,0,0}
      "Initial values of angular acceleration z_0 = der(w_0)"
      annotation (Dialog(tab="Initialization"));

    parameter Boolean enforceStates=false
      " = true, if absolute variables of body object shall be used as states (StateSelect.always)"
      annotation (Dialog(tab="Advanced"));
    parameter Boolean useQuaternions=true
      " = true, if quaternions shall be used as potential states otherwise use 3 angles as potential states"
      annotation (Dialog(tab="Advanced"));
    parameter Types.RotationSequence sequence_angleStates={1,2,3}
      " Sequence of rotations to rotate world frame into frame_a around the 3 angles used as potential states"
       annotation (Evaluate=true, Dialog(tab="Advanced", enable=not
            useQuaternions));

    constant Real pi=Modelica.Constants.pi;
    final parameter SI.Distance radius=diameter/2 "Radius of cylinder";
    final parameter SI.Distance innerRadius=innerDiameter/2
      "Inner-Radius of cylinder";
    final parameter SI.Mass mo(min=0)=density*pi*length*radius*radius
      "Mass of cylinder without hole";
    final parameter SI.Mass mi(min=0)=density*pi*length*innerRadius*innerRadius
      "Mass of hole of cylinder";
    final parameter SI.Inertia I22=(mo*(length*length + 3*radius*radius) - mi*(
        length*length + 3*innerRadius*innerRadius))/12
      "Inertia with respect to axis through center of mass, perpendicular to cylinder axis";
    final parameter SI.Mass m(min=0)=mo - mi "Mass of cylinder";
    final parameter Frames.Orientation R=Frames.from_nxy(r, {0,1,0})
      "Orientation object from frame_a to frame spanned by cylinder axis and axis perpendicular to cylinder axis";
    final parameter SI.Position r_CM[3]=Modelica.Math.Vectors.normalize(
                                                         r)*length/2
      "Position vector from frame_a to center of mass, resolved in frame_a";
    final parameter SI.Inertia I[3, 3]=Frames.resolveDyade1(R, diagonal({(mo*
        radius*radius - mi*innerRadius*innerRadius)/2,I22,I22}))
      "Inertia tensor of cylinder with respect to center of mass, resolved in frame parallel to frame_a";

    Body body(
      r_CM=r_CM,
      m=m,
      I_11=I[1, 1],
      I_22=I[2, 2],
      I_33=I[3, 3],
      I_21=I[2, 1],
      I_31=I[3, 1],
      I_32=I[3, 2],
      animation=false,
      sequence_start=sequence_start,
      angles_fixed=angles_fixed,
      angles_start=angles_start,
      w_0_fixed=w_0_fixed,
      w_0_start=w_0_start,
      z_0_fixed=z_0_fixed,
      z_0_start=z_0_start,
      useQuaternions=useQuaternions,
      enforceStates=enforceStates,
      sequence_angleStates=sequence_angleStates)
      annotation (Placement(transformation(extent={{-30,-80},{10,-40}},
            rotation=0)));
    FixedTranslation frameTranslation(
      r=r,
      animation=animation,
      shapeType="pipecylinder",
      r_shape=r_shape,
      lengthDirection=lengthDirection,
      length=length,
      width=diameter,
      height=diameter,
      extra=innerDiameter/diameter,
      color=color,
      specularCoefficient=specularCoefficient,
      widthDirection={0,1,0}) annotation (Placement(transformation(extent={{-30,
              -20},{10,20}}, rotation=0)));

  protected
    outer Modelica.Mechanics.MultiBody.World world;
  equation
    r_0 = frame_a.r_0;
    v_0 = der(r_0);
    a_0 = der(v_0);

    assert(innerDiameter < diameter,
      "parameter innerDiameter is greater as parameter diameter.");
    connect(frameTranslation.frame_a, frame_a) annotation (Line(
        points={{-30,0},{-100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(frameTranslation.frame_b, frame_b) annotation (Line(
        points={{10,0},{100,0}},
        color={95,95,95},
        thickness=0.5));
    connect(frame_a, body.frame_a) annotation (Line(
        points={{-100,0},{-70,0},{-70,-60},{-30,-60}},
        color={95,95,95},
        thickness=0.5));
    annotation (
      Documentation(info="<HTML>
<p>
<b>Rigid body</b> with <b>cylinder</b> shape.
The mass properties of the body (mass, center of mass,
inertia tensor) are computed
from the cylinder data. Optionally, the cylinder may be hollow.
The cylinder shape is by default used in the animation.
The two connector frames <b>frame_a</b> and <b>frame_b</b>
are always parallel to each other. Example of component
animation (note, that
the animation may be switched off via parameter animation = <b>false</b>):
</p>
<IMG SRC=\"../Images/MultiBody/BodyCylinder.png\" ALT=\"Parts.BodyCylinder\">
<p>
A BodyCylinder component has potential states. For details of these
states and of the \"Advanced\" menu parameters, see model
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Parts.Body\">MultiBody.Parts.Body</a>.</HTML>
"),   Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Text(
            extent={{-129,100},{131,40}},
            textString="%name",
            lineColor={0,0,255}),
          Text(
            extent={{130,-98},{-130,-48}},
            lineColor={0,0,0},
            textString="%=r"),
          Rectangle(
            extent={{-100,40},{100,-40}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={0,127,255}),
          Text(
            extent={{-87,13},{-51,-12}},
            lineColor={0,0,0},
            textString="a"),
          Text(
            extent={{51,12},{87,-13}},
            lineColor={0,0,0},
            textString="b")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics));
  end BodyCylinder;

  model PointMass
    "Rigid body where body rotation and inertia tensor is neglected (6 potential states)"

    import SI = Modelica.SIunits;
    import Modelica.Mechanics.MultiBody.Types;
    Interfaces.Frame_a frame_a
      "Coordinate system fixed at center of mass point"
      annotation (Placement(transformation(extent={{-16,-16},{16,16}}, rotation=
             0)));
    parameter Boolean animation=true
      "= true, if animation shall be enabled (show sphere)";
    parameter SI.Mass m(min=0) "Mass of mass point";
    input SI.Diameter sphereDiameter=world.defaultBodyDiameter
      "Diameter of sphere" annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor
      "Color of sphere" annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    parameter StateSelect stateSelect=StateSelect.avoid
      "Priority to use frame_a.r_0, v_0 (= der(frame_a.r_0)) as states" annotation(Dialog(tab="Advanced"));

    SI.Position r_0[3](start={0,0,0}, stateSelect=stateSelect)
      "Position vector from origin of world frame to origin of frame_a, resolved in world frame"
      annotation(Dialog(group="Initialization", __Dymola_initialDialog=true));
    SI.Velocity v_0[3](start={0,0,0}, stateSelect=stateSelect)
      "Absolute velocity of frame_a, resolved in world frame (= der(r_0))"
      annotation(Dialog(group="Initialization", __Dymola_initialDialog=true));
    SI.Acceleration a_0[3](start={0,0,0})
      "Absolute acceleration of frame_a resolved in world frame (= der(v_0))"
      annotation(Dialog(group="Initialization", __Dymola_initialDialog=true));

  protected
    outer Modelica.Mechanics.MultiBody.World world;

    // Declarations for animation
    Visualizers.Advanced.Shape sphere(
      shapeType="sphere",
      color=sphereColor,
      specularCoefficient=specularCoefficient,
      length=sphereDiameter,
      width=sphereDiameter,
      height=sphereDiameter,
      lengthDirection={1,0,0},
      widthDirection={0,1,0},
      r_shape= - {1,0,0}*sphereDiameter/2,
      r=frame_a.r_0,
      R=frame_a.R) if world.enableAnimation and animation;
  equation
    // If any possible, do not use the connector as root
    Connections.potentialRoot(frame_a.R, 10000);

    if Connections.isRoot(frame_a.R) then
       assert(cardinality(frame_a)==0, "
A Modelica.Mechanics.MultiBody.Parts.PointMass model is connected in
a way, so that no equations are present to compute frame_a.R
(the orientation object in the connector). Setting frame_a.R to
an arbitrary value in the PointMass model, might lead to a wrong
overall model, depending on how the PointMass model is used.
   You can avoid this message, by providing equations that
compute the orientation object, e.g., by using the
Modelica.Mechanics.MultiBody.Joints.FreeMotion joint.
   If a PointMass model is not connected at all, the
orientation object is set to a unit rotation. But this is
the only case where this is done.
");
       frame_a.R = Frames.nullRotation();
    else
       frame_a.t = zeros(3);
    end if;

    // Newton equation: f = m*(a-g)
    r_0 = frame_a.r_0;
    v_0 = der(r_0);
    a_0 = der(v_0);
    frame_a.f = m*Frames.resolve2(frame_a.R, a_0 - world.gravityAcceleration(r_0));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Text(
            extent={{132,-102},{-129,-56}},
            lineColor={0,0,0},
            textString="m=%m"),
          Text(
            extent={{-128,110},{132,55}},
            textString="%name",
            lineColor={0,0,255}),
          Ellipse(
            extent={{-50,50},{50,-50}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={0,127,255})}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      Documentation(info="<HTML>
<p>
<b>Rigid body</b> where the inertia tensor is neglected.
This body is
solely defined by its mass.
By default, this component is visualized by a <b>sphere</b> that has
its center at frame_a. Note, that
the animation may be switched off via parameter animation = <b>false</b>.
</p>

<p>
Every PointMass has potential states. If possible a tool will select
the states of joints and not the states of PointMasss because this is
usually the most efficient choice. In this case the position and
velocity of frame_a of the body will be computed
by the component that is connected to frame_a. However, if a PointMass is moving
freely in space, variables of the PointMass have to be used as states. The potential
states are: The <b>position vector</b> frame_a.r_0 from the origin of the
world frame to the origin of frame_a of the body, resolved in
the world frame and the <b>absolute velocity</b> v_0 of the origin of
frame_a, resolved in the world frame (= der(frame_a.r_0)).
</p>

<p>
Whether or not variables of the body are used as states is usually
automatically selected by the Modelica translator. If parameter
<b>enforceStates</b> is set to <b>true</b> in the \"Advanced\" menu,
then PointMass variables frame_a.r_0 and der(frame_a.r_0)
are forced to be used as states.
</p>
</HTML>"));
  end PointMass;

  model Mounting1D
    "Propagate 1-dim. support torque to 3-dim. system (provided world.driveTrainMechanics3D=true)"
    parameter Modelica.SIunits.Angle phi0=0 "Fixed offset angle of housing";
    parameter Modelica.Mechanics.MultiBody.Types.Axis n={1,0,0}
      "Axis of rotation = axis of support torque (resolved in frame_a)";

    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
      "(right) flange fixed in housing" annotation (Placement(transformation(
            extent={{110,10},{90,-10}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a if world.driveTrainMechanics3D
      "Frame in which housing is fixed (connector is removed, if world.driveTrainMechanics3D=false)"
      annotation (Placement(transformation(
          origin={0,-100},
          extent={{-20,-20},{20,20}},
          rotation=90)));
  protected
    outer Modelica.Mechanics.MultiBody.World world;

    encapsulated model Housing
      import Modelica;
      input Modelica.SIunits.Torque t[3];
      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
                                 annotation (Placement(transformation(extent={{
                -116,-16},{-84,16}}, rotation=0)));
    equation
      frame_a.f=zeros(3);
      frame_a.t=t;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-150,110},{150,150}},
              lineColor={0,0,255},
              textString="%name")}));
    end Housing;
    Housing housing(t=-n*flange_b.tau) if world.driveTrainMechanics3D
                    annotation (Placement(transformation(extent={{20,-60},{40,-40}},
            rotation=0)));
  equation
    flange_b.phi = phi0;
    connect(housing.frame_a, frame_a) annotation (Line(
        points={{20,-50},{0,-50},{0,-100}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Rectangle(
            extent={{-80,-60},{80,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-146,60},{154,20}},
            lineColor={0,0,255},
            textString="%name"),
          Line(points={{80,-60},{40,-100}}, color={0,0,0}),
          Line(points={{40,-60},{0,-100}}, color={0,0,0}),
          Line(points={{0,-60},{-40,-100}}, color={0,0,0}),
          Line(points={{-40,-60},{-80,-100}}, color={0,0,0}),
          Line(points={{0,-60},{0,0}}, color={0,0,0}),
          Line(points={{0,0},{90,0}}, color={0,0,0})}),
      Documentation(info="<html>
<p>This component is used to acquire support torques from a 1-dim.-rotational
mechanical system (e.g., components from Modelica.Mechanics.Rotational)
and to propagate them to a carrier body.</p>
<p>The 1-dim. support torque at <tt>flange_b</tt> is transformed into 3-dim. space under
consideration of the rotation axis, parameter <tt>n</tt>, which has to be given in the
local coordinate system of <tt>frame_a</tt>.</p>
<p>All components of a 1-dim.-rotational mechanical system that are connected to <b>a</b> common
<b>Mounting1D</b> element need to have the same axis of rotation
along parameter vector <tt>n</tt>. This means that, e.g., bevel
gears where the axis of rotation of <tt>flange_a</tt> and
<tt>flange_b</tt> are different cannot be described properly by
connecting to the <b>Mounting1D</b> component. In this case, a combination of several
<b>Mounting1D</b> components or the component <b>BevelGear1D</b> should be used.</p>
<p><b>Reference</b><br>
<span style=\"font-variant:small-caps\">Schweiger</span>, Christian ;
<span style=\"font-variant:small-caps\">Otter</span>, Martin:
<a href=\"http://www.modelica.org/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling
3D Mechanical Effects of 1-dim. Powertrains</a>. In: <i>Proceedings of the 3rd International
Modelica Conference</i>. Link&ouml;ping : The Modelica Association and Link&ouml;ping University,
November 3-4, 2003, pp. 149-158</p>
</HTML>
"),   Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics));
  end Mounting1D;

  model Rotor1D
    "1D inertia attachable on 3-dim. bodies (3D dynamic effects are taken into account if world.driveTrainMechanics3D=true)"

    import SI = Modelica.SIunits;
    import Cv = Modelica.SIunits.Conversions;

    parameter Boolean animation=true
      "= true, if animation shall be enabled (show rotor as cylinder)";
    parameter SI.Inertia J(min=0,start=1)
      "Moment of inertia of rotor around its axis of rotation";
    parameter Modelica.Mechanics.MultiBody.Types.Axis n={1,0,0}
      "Axis of rotation resolved in frame_a";
    parameter SI.Position r_center[3]=zeros(3)
      "Position vector from origin of frame_a to center of cylinder"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Distance cylinderLength=2*world.defaultJointLength
      "Length of cylinder representing the rotor"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Distance cylinderDiameter=2*world.defaultJointWidth
      "Diameter of cylinder representing the rotor"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Modelica.Mechanics.MultiBody.Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor
      "Color of cylinder representing the rotor"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient
      specularCoefficient=world.defaultSpecularCoefficient
      "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter StateSelect stateSelect=StateSelect.default
      "Priority to use rotor angle (phi) and rotor speed (w) as states" annotation(Dialog(tab="Advanced"));
    parameter Boolean exact=true
      "= true, if exact calculations; false if influence of bearing on rotor acceleration is neglected to avoid an algebraic loop"
      annotation (Dialog(tab="Advanced"));

    SI.Angle phi(start=0, stateSelect=stateSelect)
      "Rotation angle of rotor with respect to frame_a (= flange_a.phi = flange_b.phi)";
    SI.AngularVelocity w(start=0, stateSelect=stateSelect)
      "Angular velocity of rotor with respect to frame_a";
    SI.AngularAcceleration a(start=0)
      "Angular acceleration of rotor with respect to frame_a";

    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
      "(left) driving flange (flange axis directed INTO cut plane)"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
             0)));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
      "(right) driven flange (flange axis directed OUT OF cut plane)"
      annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a if world.driveTrainMechanics3D
      "Frame in which rotor housing is fixed (connector is removed, if world.driveTrainMechanics3D=false)"
      annotation (Placement(transformation(
          origin={0,-100},
          extent={{-20,-20},{20,20}},
          rotation=90)));

  encapsulated model RotorWith3DEffects
      "1D inertia attachable on 3-dim. bodies (3D dynamic effects are taken into account)"

      import Modelica;
      import Modelica.Mechanics.MultiBody.Frames;
      import Modelica.Mechanics.MultiBody.Types;
      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;

    parameter Boolean animation=true
        "= true, if animation shall be enabled (show rotor as cylinder)";
    parameter SI.Inertia J(min=0)=1
        "Moment of inertia of rotor around its axis of rotation";
    parameter Types.Axis n={1,0,0} "Axis of rotation resolved in frame_a";
    parameter SI.Position r_center[3]=zeros(3)
        "Position vector from origin of frame_a to center of cylinder"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Distance cylinderLength=2*world.defaultJointLength
        "Length of cylinder representing the rotor"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter SI.Distance cylinderDiameter=2*world.defaultJointWidth
        "Diameter of cylinder representing the rotor"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor
        "Color of cylinder representing the rotor"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    input Types.SpecularCoefficient specularCoefficient =                              world.defaultSpecularCoefficient
        "Reflection of ambient light (= 0: light is completely absorbed)"
      annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
    parameter StateSelect stateSelect=StateSelect.default
        "Priority to use rotor angle (phi) and rotor speed (w) as states"
                                                                        annotation(Dialog(tab="Advanced"));
    parameter Boolean exact=true
        "= true, if exact calculations; false if influence of bearing on rotor acceleration is neglected to avoid an algebraic loop"
      annotation (Dialog(tab="Advanced"));

    SI.AngularVelocity w_a[3]
        "Angular velocity of frame_a, resolved in frame_a";
    SI.Angle phi(start=0, final stateSelect=stateSelect)
        "Rotation angle of rotor with respect to frame_a (= flange_a.phi = flange_b.phi)"
      annotation(Dialog(__Dymola_initialDialog=true));

    SI.AngularVelocity w(start=0, stateSelect=stateSelect)
        "Angular velocity of rotor with respect to frame_a"
      annotation(Dialog(__Dymola_initialDialog=true));
    SI.AngularAcceleration a(start=0)
        "Angular acceleration of rotor with respect to frame_a"
      annotation(Dialog(__Dymola_initialDialog=true));

    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
        "(left) driving flange (flange axis directed INTO cut plane)"
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
               0)));
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
        "(right) driven flange (flange axis directed OUT OF cut plane)"
      annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
    Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
        "Frame in which rotor housing is fixed"
      annotation (Placement(transformation(
            origin={0,-100},
            extent={{-20,-20},{20,20}},
            rotation=90)));

    protected
    outer Modelica.Mechanics.MultiBody.World world;
    parameter Real e[3](each final unit="1")=Modelica.Math.Vectors.normalize(
                                         n)
        "Unit vector in direction of rotor axis, resolved in frame_a";
    parameter SI.Inertia nJ[3]=J*e;
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape cylinder(
      shapeType="cylinder",
      color=cylinderColor,
      specularCoefficient=specularCoefficient,
      length=cylinderLength,
      width=cylinderDiameter,
      height=cylinderDiameter,
      lengthDirection=n,
      widthDirection={0,1,0},
      extra=1,
      r_shape=r_center - e*(cylinderLength/2),
      r=frame_a.r_0,
      R=Frames.absoluteRotation(frame_a.R, Frames.planarRotation(e, phi, 0))) if
         world.enableAnimation and animation;
  equation
    phi = flange_a.phi;
    phi = flange_b.phi;
    w = der(phi);
    a = der(w);

    w_a = Modelica.Mechanics.MultiBody.Frames.angularVelocity2(frame_a.R);
    if exact then
      J*a = flange_a.tau + flange_b.tau - nJ*der(w_a);
    else
      J*a = flange_a.tau + flange_b.tau;
    end if;

   /* Reaction torque:
        t = n*(J*a - flange_a.tau - flange_b.tau) + cross(w_a, nJ*w)

     Since
        J*a = flange_a.tau + flange_b.tau - nJ*der(w_a);

     the reaction torque can be simplified to
        t = n*(- nJ*der(w_a)) + cross(w_a, nJ*w)

  */
    frame_a.f = zeros(3);
    frame_a.t = cross(w_a, nJ*w)-e*(nJ*der(w_a));
    annotation (
      Documentation(info="<html>
<p>
This component is used to model the gyroscopic torques exerted by a 1-dim.
inertia (so called <i>rotor</i>) on its 3-dim. carrier body. Gyroscopic torques
appear, if the vector of the carrier body's angular velocity is not parallel
to the vector of the rotor's axis. The axis of rotation of the rotor is defined by
the parameter <tt>n</tt>, which has to be given in the local coordinate system
of <tt>frame_a</tt>. The default animation of this component is
shown in the figure below. </p>
      <IMG SRC=\"../Images/MultiBody/Parts/Rotor1D.png\" ALT=\"model Parts.Rotor1D\">
<p>This component is a replacement for
<a href=\"Modelica://Modelica.Mechanics.Rotational.Components.Inertia\">Modelica.Mechanics.Rotational.Components.Inertia</a>
for the case, that a 1-dim.-rotational mechanical system should be attached with a 3-dim.
carrier body.</p>
<p>The Boolean parameter <tt>exact</tt> was introduced due to performance
reasons. If <tt>exact</tt> is set to <b>false</b>, the influence of the carrier body
motion on the angular velocity of the rotor is neglected. This influence is usually
negligible if the 1-dim.-rotational mechanical system accelerates much faster as the base body (this is,
e.g., the case in vehicle powertrains). The essential advantage is
that an algebraic loop is removed since then there is only an
action on acceleration level from the powertrain to the base body
but not vice versa.</p>
<p><b>Reference</b><br>
<span style=\"font-variant:small-caps\">Schweiger</span>, Christian ;
<span style=\"font-variant:small-caps\">Otter</span>, Martin:
<a href=\"http://www.modelica.org/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling
3D Mechanical Effects of 1-dim. Powertrains</a>. In: <i>Proceedings of the 3rd International
Modelica Conference</i>. Link&ouml;ping : The Modelica Association and Link&ouml;ping University,
November 3-4, 2003, pp. 149-158</p>
</HTML>
"),   Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Line(points={{-80,-25},{-60,-25}}, color={0,0,0}),
            Line(points={{60,-25},{80,-25}}, color={0,0,0}),
            Line(points={{-70,-25},{-70,-70}}, color={0,0,0}),
            Line(points={{70,-25},{70,-70}}, color={0,0,0}),
            Line(points={{-80,25},{-60,25}}, color={0,0,0}),
            Line(points={{60,25},{80,25}}, color={0,0,0}),
            Line(points={{-70,45},{-70,25}}, color={0,0,0}),
            Line(points={{70,45},{70,25}}, color={0,0,0}),
            Line(points={{-70,-70},{70,-70}}, color={0,0,0}),
            Rectangle(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{-100,10},{-50,-10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{50,10},{100,-10}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Text(
              extent={{-148,112},{152,72}},
              textString="%name=%J",
              lineColor={0,0,255}),
            Line(points={{0,-70},{0,-100}}, color={0,0,0})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}),
                          graphics));
  end RotorWith3DEffects;

  protected
    outer Modelica.Mechanics.MultiBody.World world;
    parameter Real e[3](each final unit="1")=Modelica.Math.Vectors.normalize(
                                         n)
      "Unit vector in direction of rotor axis, resolved in frame_a";
    Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape cylinder(
      shapeType="cylinder",
      color=cylinderColor,
      specularCoefficient=specularCoefficient,
      length=cylinderLength,
      width=cylinderDiameter,
      height=cylinderDiameter,
      lengthDirection=n,
      widthDirection={0,1,0},
      extra=1,
      r_shape=r_center - e*(cylinderLength/2),
      r=zeros(3),
      R=Modelica.Mechanics.MultiBody.Frames.planarRotation(
          e,
          phi,
          0)) if world.enableAnimation and animation and not world.driveTrainMechanics3D;

    Modelica.Mechanics.Rotational.Components.Inertia inertia(
      J=J) if
          not world.driveTrainMechanics3D
      annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=0)));
    RotorWith3DEffects rotorWith3DEffects(
      animation=animation,
      J=J,
      n=n,
      r_center=r_center,
      cylinderLength=cylinderLength,
      cylinderDiameter=cylinderDiameter,
      cylinderColor=cylinderColor,
      specularCoefficient=specularCoefficient,
      exact=exact) if world.driveTrainMechanics3D annotation (Placement(
          transformation(extent={{-20,-80},{20,-40}}, rotation=0)));
  equation
    phi = flange_a.phi;
    w = der(phi);
    a = der(w);

    connect(inertia.flange_a, flange_a) annotation (Line(
        points={{-20,0},{-100,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(inertia.flange_b, flange_b) annotation (Line(
        points={{20,0},{100,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(rotorWith3DEffects.flange_b, flange_b) annotation (Line(
        points={{20,-60},{60,-60},{60,0},{100,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(rotorWith3DEffects.flange_a, flange_a) annotation (Line(
        points={{-20,-60},{-60,-60},{-60,0},{-100,0}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(rotorWith3DEffects.frame_a, frame_a) annotation (Line(
        points={{0,-80},{0,-100}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (
      Documentation(info="<html>
<p>This component is used to model the gyroscopic torques exerted by a 1-dim.
inertia (so called <i>rotor</i>) on its 3-dim. carrier body. Gyroscopic torques
appear, if the vector of the carrier body's angular velocity is not parallel
to the vector of the rotor's axis. The axis of rotation of the rotor is defined by
the parameter <tt>n</tt>, which has to be given in the local coordinate system
of <tt>frame_a</tt>. The default animation of this component is
shown in the figure below. </p>
      <IMG SRC=\"../Images/MultiBody/Parts/Rotor1D.png\" ALT=\"model Parts.Rotor1D\">
<p>This component is a replacement for
<a href=\"Modelica://Modelica.Mechanics.Rotational.Components.Inertia\">Modelica.Mechanics.Rotational.Components.Inertia</a>
for the case, that a 1-dim.-rotational mechanical system should be attached with a 3-dim.
carrier body.</p>
<p>The Boolean parameter <tt>exact</tt> was introduced due to performance
reasons. If <tt>exact</tt> is set to <b>false</b>, the influence of the carrier body
motion on the angular velocity of the rotor is neglected. This influence is usually
negligible if the 1-dim.-rotational mechanical system accelerates much faster as the base body (this is,
e.g., the case in vehicle powertrains). The essential advantage is
that an algebraic loop is removed since then there is only an
action on acceleration level from the powertrain to the base body
but not vice versa.</p>
<p><b>Reference</b><br>
<span style=\"font-variant:small-caps\">Schweiger</span>, Christian ;
<span style=\"font-variant:small-caps\">Otter</span>, Martin:
<a href=\"http://www.modelica.org/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling
3D Mechanical Effects of 1-dim. Powertrains</a>. In: <i>Proceedings of the 3rd International
Modelica Conference</i>. Link&ouml;ping : The Modelica Association and Link&ouml;ping University,
November 3-4, 2003, pp. 149-158</p>
</HTML>
"),   Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
              100}}), graphics={
          Line(points={{-80,-25},{-60,-25}}, color={0,0,0}),
          Line(points={{60,-25},{80,-25}}, color={0,0,0}),
          Line(points={{-70,-25},{-70,-70}}, color={0,0,0}),
          Line(points={{70,-25},{70,-70}}, color={0,0,0}),
          Line(points={{-80,25},{-60,25}}, color={0,0,0}),
          Line(points={{60,25},{80,25}}, color={0,0,0}),
          Line(points={{-70,45},{-70,25}}, color={0,0,0}),
          Line(points={{70,45},{70,25}}, color={0,0,0}),
          Line(points={{-70,-70},{70,-70}}, color={0,0,0}),
          Rectangle(
            extent={{-50,50},{50,-50}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{-100,10},{-50,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{50,10},{100,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Text(
            extent={{-148,112},{152,72}},
            textString="%name=%J",
            lineColor={0,0,255}),
          Line(points={{0,-70},{0,-100}}, color={0,0,0})}),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics));
  end Rotor1D;

  model BevelGear1D
    "1D gearbox with arbitrary shaft directions and 3-dim. bearing frame (3D dynamic effects are taken into account provided world.driveTrainMechanics3D=true)"
    extends Modelica.Mechanics.Rotational.Interfaces.PartialTwoFlanges;

    parameter Real ratio(start=1) "Gear speed ratio";
    parameter Modelica.Mechanics.MultiBody.Types.Axis n_a={1,0,0}
      "Axis of rotation of flange_a, resolved in frame_a";
    parameter Modelica.Mechanics.MultiBody.Types.Axis n_b={1,0,0}
      "Axis of rotation of flange_b, resolved in frame_a";

    Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a if world.driveTrainMechanics3D
      "Bearing frame"
      annotation (Placement(transformation(
          origin={0,-100},
          extent={{-20,-20},{20,20}},
          rotation=90)));

  protected
    outer World world;
    parameter Real e_a[3](each final unit="1")=Modelica.Math.Vectors.normalize(              n_a)
      "Unit vector in direction of flange_a rotation axis";
    parameter Real e_b[3](each final unit="1")=Modelica.Math.Vectors.normalize(              n_b)
      "Unit vector in direction of flange_b rotation axis";
    encapsulated model Housing
      import Modelica;
      input Modelica.SIunits.Torque t[3];
      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
                                 annotation (Placement(transformation(extent={{
                -116,-16},{-84,16}}, rotation=0)));
    equation
      frame_a.f=zeros(3);
      frame_a.t=t;
      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-150,110},{150,150}},
              lineColor={0,0,255},
              textString="%name")}));
    end Housing;
    Housing housing(t=-flange_a.tau*e_a - flange_b.tau*e_b) if world.driveTrainMechanics3D
                    annotation (Placement(transformation(extent={{20,-60},{40,-40}},
            rotation=0)));

  equation
    flange_a.phi = ratio*flange_b.phi;
    0 = ratio*flange_a.tau + flange_b.tau;
    connect(housing.frame_a, frame_a) annotation (Line(
        points={{20,-50},{0,-50},{0,-100}},
        color={95,95,95},
        thickness=0.5,
        smooth=Smooth.None));
    annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Rectangle(
            extent={{-40,20},{-20,-20}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{-40,140},{-20,20}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{20,100},{40,60}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{20,60},{40,-60}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{40,10},{100,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{-20,90},{20,70}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Rectangle(
            extent={{-100,10},{-40,-10}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={192,192,192}),
          Text(
            extent={{-150,178},{150,138}},
            textString="%name=%ratio",
            lineColor={0,0,255}),
          Line(points={{-80,20},{-60,20}}, color={0,0,0}),
          Line(points={{-80,-20},{-60,-20}}, color={0,0,0}),
          Line(points={{-10,100},{10,100}}, color={0,0,0}),
          Line(points={{-10,60},{10,60}}, color={0,0,0}),
          Line(points={{60,20},{80,20}}, color={0,0,0}),
          Line(points={{60,-20},{80,-20}}, color={0,0,0}),
          Line(points={{-70,-20},{-70,-70},{70,-70},{70,-20}}, color={0,0,0}),
          Line(points={{0,60},{0,-70},{0,-100}}, color={0,0,0})}),
        Documentation(
          info="<html>
<p>This component is used to model a 1-dim. gearbox
with non-parallel axes (defined by parameters <tt>n_a</tt>, <tt>n_b</tt>).
A 3-dim. <tt>bearing</tt> frame is necessary to reflect the
correct support torque, as the axes of rotation of <tt>flange_a</tt> and
<tt>flange_b</tT> and the direction of the support torque vector
are different in general.</p>
<p>Note: The name BevelGear1D is kept only for simplicity. Regardless,
this component could be used to model any kind of gearbox with non-parallel axes.</p>
<p><b>Reference</b><br>
<span style=\"font-variant:small-caps\">Schweiger</span>, Christian ;
<span style=\"font-variant:small-caps\">Otter</span>, Martin:
<a href=\"http://www.modelica.org/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling
3D Mechanical Effects of 1-dim. Powertrains</a>. In: <i>Proceedings of the 3rd International
Modelica Conference</i>. Link&ouml;ping : The Modelica Association and Link&ouml;ping University,
November 3-4, 2003, pp. 149-158</p>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
              100,100}}), graphics));
  end BevelGear1D;

    model RollingWheel
    "Ideal rolling wheel on flat surface z=0 (5 positional, 3 velocity degrees of freedom)"
      import SI = Modelica.SIunits;

      parameter Boolean animation=true
      "= true, if animation of wheel shall be enabled";

      parameter SI.Radius wheelRadius "Radius of wheel";
      parameter SI.Mass wheelMass "Mass of wheel";
      parameter SI.Inertia wheel_I_axis "Inertia along the wheel axis";
      parameter SI.Inertia wheel_I_long
      "Inertia perpendicular to the wheel axis";
      parameter StateSelect stateSelect=StateSelect.always
      "Priority to use generalized coordinates as states"   annotation(HideResult=true,Evaluate=true);

      SI.Position x(start=0, fixed = true, stateSelect=stateSelect)
      "x-coordinate of wheel axis";

      SI.Position y(start=0, fixed = true, stateSelect=stateSelect)
      "y-coordinate of wheel axis";

      SI.Angle angles[3](start={0,0,0}, fixed = true, stateSelect=stateSelect)
      "Angles to rotate world-frame in to frame_a around z-, y-, x-axis"
        annotation(Dialog(group="Initialization", __Dymola_initialDialog=true));

      SI.AngularVelocity der_angles[3](start={0,0,0}, fixed = true, stateSelect=stateSelect)
      "Derivative of angles"
        annotation(Dialog(group="Initialization", __Dymola_initialDialog=true));

      parameter SI.Distance width = 0.035 "Width of wheel" annotation (Dialog(
          tab="Animation",
          group="if animation = true", enable=animation));
      parameter Real hollowFraction = 0.8
      "1.0: Completely hollow, 0.0: rigid cylinder"     annotation (Dialog(
          tab="Animation",
          group="if animation = true", enable=animation));
      parameter Modelica.Mechanics.MultiBody.Types.Color wheelColor={30,30,30}
      "Color of wheel"    annotation (Dialog(
          tab="Animation",
          group="if animation = true",
          enable=animation));

      Modelica.Mechanics.MultiBody.Parts.Body body(
        final r_CM={0,0,0},
        final m=wheelMass,
        final I_11=wheel_I_long,
        final I_22=wheel_I_axis,
        final I_33=wheel_I_long,
        final I_21=0,
        final I_31=0,
        final I_32=0,
        animation=false)
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));

      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
      "Frame fixed in wheel center point. y-axis: along wheel axis, z-Axis: upwards, "
        annotation (Placement(transformation(extent={{-16,-16},{16,16}})));
      Modelica.Mechanics.MultiBody.Joints.RollingWheel rollingWheel(wheelRadius=wheelRadius,
          stateSelect=StateSelect.avoid)
        annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
      Modelica.Mechanics.MultiBody.Visualizers.FixedShape fixedShape(
        final animation=animation,
        final r_shape={0,-width,0},
        final lengthDirection={0,1,0},
        final widthDirection={1,0,0},
        final length=2*width,
        final width=2*wheelRadius,
        final height=2*wheelRadius,
        final color=wheelColor,
        final extra=hollowFraction,
        final shapeType="pipe") if
                      animation annotation (Placement(transformation(extent={{20,20},{40,40}})));

    equation
      rollingWheel.x = x;
      rollingWheel.y = y;
      rollingWheel.angles = angles;
      rollingWheel.der_angles = der_angles;

      connect(body.frame_a, frame_a) annotation (Line(
          points={{20,0},{0,0}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(rollingWheel.frame_a, frame_a)      annotation (Line(
          points={{-50,-50},{-25,-50},{-25,0},{0,0}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(fixedShape.frame_a, frame_a) annotation (Line(
          points={{20,30},{0,30},{0,0}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (defaultComponentName="wheel",Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}),        graphics), Icon(coordinateSystem(
              preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
          graphics={
          Rectangle(
            extent={{-100,-80},{100,-100}},
            lineColor={0,0,0},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-80,80},{80,-80}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-150,122},{150,82}},
            textString="%name",
            lineColor={0,0,255})}));
    end RollingWheel;

    model RollingWheelSet
    "Ideal rolling wheel set consisting of two ideal rolling wheels connected together by an axis"
      import SI = Modelica.SIunits;
     Modelica.Mechanics.MultiBody.Interfaces.Frame_a frameMiddle
      "Frame fixed in middle of axis connecting both wheels (y-axis: along wheel axis, z-Axis: upwards)"
        annotation (Placement(transformation(extent={{-16,16},{16,-16}}),
            iconTransformation(extent={{-16,-16},{16,16}})));

      parameter Boolean animation=true
      "= true, if animation of wheel set shall be enabled";

      parameter SI.Radius wheelRadius "Radius of one wheel";
      parameter SI.Mass wheelMass "Mass of one wheel";
      parameter SI.Inertia wheel_I_axis "Inertia along one wheel axis";
      parameter SI.Inertia wheel_I_long
      "Inertia perpendicular to one wheel axis";
      parameter SI.Distance wheelDistance "Distance between the two wheels";
       parameter StateSelect stateSelect = StateSelect.always
      "Priority to use the generalized coordinates as states";

      Modelica.SIunits.Position x(start=0, fixed=true, stateSelect=stateSelect)
      "x coordinate of center between wheels";
      Modelica.SIunits.Position y(start=0, fixed=true, stateSelect=stateSelect)
      "y coordinate of center between wheels";
      Modelica.SIunits.Angle phi(start=0, fixed=true, stateSelect=stateSelect)
      "Orientation angle of wheel axis along z-axis";
      Modelica.SIunits.Angle theta1(start=0, fixed=true, stateSelect=stateSelect)
      "Angle of wheel 1";
      Modelica.SIunits.Angle theta2(start=0, fixed=true, stateSelect=stateSelect)
      "Angle of wheel 2";
      Modelica.SIunits.AngularVelocity der_theta1(start=0, fixed=true, stateSelect=stateSelect)
      "Derivative of theta 1";
      Modelica.SIunits.AngularVelocity der_theta2(start=0, fixed=true, stateSelect=stateSelect)
      "Derivative of theta 2";

      parameter SI.Distance wheelWidth = 0.01 "Width of one wheel" annotation (Dialog( tab="Animation",
          group="if animation = true", enable=animation));
      parameter Real hollowFraction = 0.8
      "1.0: Completely hollow, 0.0: rigid cylinder"     annotation (Dialog(
          tab="Animation",
          group="if animation = true", enable=animation));
      parameter Modelica.Mechanics.MultiBody.Types.Color wheelColor={30,30,30}
      "Color of wheels"    annotation (Dialog(
          tab="Animation",
          group="if animation = true",
          enable=animation));

      Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame1
      "Frame fixed in center point of left wheel (y-axis: along wheel axis, z-Axis: upwards)"
        annotation (Placement(transformation(extent={{-96,16},{-64,-16}}),
            iconTransformation(extent={{-96,16},{-64,-16}})));
      Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame2
      "Frame fixed in center point of right wheel (y-axis: along wheel axis, z-Axis: upwards)"
        annotation (Placement(transformation(extent={{64,16},{96,-16}})));
      Modelica.Mechanics.MultiBody.Parts.Body body2(
        final r_CM={0,0,0},
        final I_21=0,
        final I_31=0,
        final I_32=0,
        animation=false,
        final m=wheelMass,
        final I_11=wheel_I_long,
        final I_22=wheel_I_axis,
        final I_33=wheel_I_long)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=-90,
            origin={60,30})));
      Modelica.Mechanics.MultiBody.Visualizers.FixedShape shape2(
        final animation=animation,
        final lengthDirection={0,1,0},
        final widthDirection={1,0,0},
        final color=wheelColor,
        final extra=hollowFraction,
        final shapeType="pipe",
        final r_shape={0,-wheelWidth,0},
        final length=2*wheelWidth,
        final width=2*wheelRadius,
        final height=2*wheelRadius) if
                      animation annotation (Placement(transformation(extent={{10,-10},
                {-10,10}},
            rotation=90,
            origin={60,-38})));
      Modelica.Mechanics.MultiBody.Parts.Body body1(
        final r_CM={0,0,0},
        final I_21=0,
        final I_31=0,
        final I_32=0,
        animation=false,
        final m=wheelMass,
        final I_11=wheel_I_long,
        final I_22=wheel_I_axis,
        final I_33=wheel_I_long)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,30})));
      Modelica.Mechanics.MultiBody.Visualizers.FixedShape shape1(
        final animation=animation,
        final lengthDirection={0,1,0},
        final widthDirection={1,0,0},
        final color=wheelColor,
        final extra=hollowFraction,
        final shapeType="pipe",
        final r_shape={0,-wheelWidth,0},
        final length=2*wheelWidth,
        final width=2*wheelRadius,
        final height=2*wheelRadius) if
                      animation annotation (Placement(transformation(extent={{-10,-10},
                {10,10}},
            rotation=-90,
            origin={-60,-40})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis1
      "1-dim. rotational flange that drives the left wheel"
        annotation (Placement(transformation(extent={{-110,90},{-90,110}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis2
      "1-dim. rotational flange that drives the right wheel"
        annotation (Placement(transformation(extent={{90,90},{110,110}})));
      Modelica.Mechanics.MultiBody.Joints.RollingWheelSet wheelSetJoint(
        animation=false,
        wheelRadius=wheelRadius,
        wheelDistance=wheelDistance,
        stateSelect=StateSelect.default,
        x(fixed=false),
        y(fixed=false),
        phi(fixed=false),
        theta1(fixed=false),
        theta2(fixed=false),
        der_theta1(fixed=false),
        der_theta2(fixed=false))
        annotation (Placement(transformation(extent={{-10,-42},{10,-22}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_b support
      "Support of 1D axes"   annotation (Placement(transformation(extent={{-10,
                70},{10,90}}), iconTransformation(extent={{-10,72},{10,92}})));
    equation
      wheelSetJoint.x      = x;
      wheelSetJoint.y      = y;
      wheelSetJoint.phi    = phi;
      wheelSetJoint.theta1 = theta1;
      wheelSetJoint.theta2 = theta2;
      der_theta1 = der(theta1);
      der_theta2 = der(theta2);

      connect(body2.frame_a,frame2)  annotation (Line(
          points={{60,20},{60,0},{80,0}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(body1.frame_a, frame1) annotation (Line(
          points={{-60,20},{-60,0},{-80,0}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(shape1.frame_a, frame1) annotation (Line(
          points={{-60,-30},{-60,0},{-80,0}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(shape2.frame_a, frame2) annotation (Line(
          points={{60,-28},{60,0},{80,0}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(wheelSetJoint.frame2, frame2) annotation (Line(
          points={{8,-32},{40,-32},{40,0},{80,0}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(wheelSetJoint.frame1, frame1) annotation (Line(
          points={{-8,-32},{-40,-32},{-40,0},{-80,0}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      connect(wheelSetJoint.axis1, axis1) annotation (Line(
          points={{-10,-22},{-20,-22},{-20,50},{-80,50},{-80,100},{-100,100}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(wheelSetJoint.axis2, axis2) annotation (Line(
          points={{10,-22},{24,-22},{24,50},{80,50},{80,100},{100,100}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(wheelSetJoint.support, support) annotation (Line(
          points={{0,-24},{0,-14},{16,-14},{16,58},{0,58},{0,80}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(wheelSetJoint.frameMiddle, frameMiddle) annotation (Line(
          points={{0,-32},{-4,-32},{-4,0},{0,0}},
          color={95,95,95},
          thickness=0.5,
          smooth=Smooth.None));
      annotation (defaultComponentName="wheelSet",Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
              -100},{100,100}}), graphics={
          Rectangle(
            extent={{-100,-80},{100,-100}},
            lineColor={0,0,0},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-146,-98},{154,-138}},
            textString="%name",
            lineColor={0,0,255}),
          Ellipse(
            extent={{42,80},{118,-80}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Sphere),
          Rectangle(
            extent={{-62,2},{64,-6}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-118,80},{-42,-80}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Sphere),
          Line(
            points={{86,24},{64,24},{64,10},{56,10}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{86,-24},{64,-24},{64,-12},{56,-12}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-96,100},{-80,100},{-80,4}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{100,100},{80,100},{80,-2}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{0,72},{0,40},{-20,40},{-20,2}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{0,40},{20,40},{20,2}},
            color={0,0,0},
            smooth=Smooth.None)}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
              {100,100}}), graphics={
          Line(
            points={{0,-106},{0,-78}},
            color={0,0,255},
            smooth=Smooth.None),
          Polygon(
            points={{0,-60},{-6,-78},{6,-78},{0,-60}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{12,-68},{30,-80}},
            lineColor={0,0,255},
            textString="x"),
          Line(
            points={{6,-100},{-26,-100}},
            color={0,0,255},
            smooth=Smooth.None),
          Polygon(
            points={{-22,-94},{-22,-106},{-40,-100},{-22,-94}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-46,-80},{-28,-92}},
            lineColor={0,0,255},
            textString="y")}),
        Documentation(info="<html>
<p>
Two wheels are connected by an axis and can rotate around this axis.
The wheels are rolling on the x-y plane. The coordinate system attached
to the center of the wheel axis (frameMiddle) is constrained so that it
is always parallel to the x-y plane. If all generalized coordinates are zero,
frameMiddle is parallel to the world frame.
</p>
</html>"));
    end RollingWheelSet;
  annotation ( Documentation(info="<HTML>
<p>
Package <b>Parts</b> contains <b>rigid components</b> of a
multi-body system. These components may be used to build up
more complicated structures. For example, a part may be built up of
a \"Body\" and of several \"FixedTranslation\" components.
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Model</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Parts.Fixed\">Fixed</a></td>
      <td valign=\"top\">Frame fixed in world frame at a given position.
          It is visualized with a shape, see <b>shapeType</b> below
         (the frames on the two
          sides do not belong to the component):<br>&nbsp;<br>
      <IMG SRC=\"../Images/MultiBody/Fixed.png\" ALT=\"model Parts.Fixed\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Parts.FixedTranslation\">FixedTranslation</a></td>
      <td valign=\"top\">Fixed translation of frame_b with respect to frame_a.
          It is visualized with a shape, see <b>shapeType</b> below
          (the frames on the two sides do not belong to the component):<br>&nbsp;<br>
      <IMG SRC=\"../Images/MultiBody/FixedTranslation.png\" ALT=\"model Parts.FixedTranslation\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Parts.FixedRotation\">FixedRotation</a></td>
      <td valign=\"top\">Fixed translation and fixed rotation of frame_b with respect to frame_a
          It is visualized with a shape, see <b>shapeType</b>  below
          (the frames on the two sides do not belong to the component):<br>&nbsp;<br>
      <IMG SRC=\"../Images/MultiBody/FixedRotation.png\" ALT=\"model Parts.FixedRotation\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Body</a></td>
      <td valign=\"top\">Rigid body with mass, inertia tensor and one frame connector.
          It is visualized with a cylinder and a sphere at the
          center of mass:<br>&nbsp;<br>
      <IMG SRC=\"../Images/MultiBody/Body.png\" ALT=\"model Parts.Body\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Parts.BodyShape\">BodyShape</a></td>
      <td valign=\"top\">Rigid body with mass, inertia tensor, different shapes
          (see <b>shapeType</b> below)
          for animation, and two frame connectors:<br>&nbsp;<br>
      <IMG SRC=\"../Images/MultiBody/BodyShape.png\" ALT=\"model Parts.BodyShape\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Parts.Fixed\">Fixed</a>
BodyBox</b></td>
      <td valign=\"top\">Rigid body with box shape (mass and animation properties are computed
          from box data and from density):<br>&nbsp;<br>
      <IMG SRC=\"../Images/MultiBody/BodyBox.png\" ALT=\"model Parts.BodyBox\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Parts.BodyCylinder\">BodyCylinder</a></td>
      <td valign=\"top\">Rigid body with cylinder shape (mass and animation properties
          are computed from cylinder data and from density):<br>&nbsp;<br>
      <IMG SRC=\"../Images/MultiBody/BodyCylinder.png\" ALT=\"model Parts.BodyCylinder\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Parts.PointMass\">PointMass</a></td>
      <td valign=\"top\">Rigid body where inertia tensor and rotation is neglected:<br>&nbsp;<br>
      <IMG SRC=\"../Images/MultiBody/Parts/PointMass.png\" ALT=\"model Parts.PointMass\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Parts.Mounting1D\">Mounting1D</a></td>
      <td valign=\"top\"> Propagate 1-dim. support torque to 3-dim. system
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Parts.Rotor1D\">Rotor1D</a></td>
      <td valign=\"top\">1D inertia attachable on 3-dim. bodies (without neglecting dynamic effects)<br>
      <IMG SRC=\"../Images/MultiBody/Parts/Rotor1D.png\" ALT=\"model Parts.Rotor1D\">
      </td>
  </tr>
  <tr><td valign=\"top\"><a href=\"Modelica://Modelica.Mechanics.MultiBody.Parts.BevelGear1D\">BevelGear1D</a></td>
      <td valign=\"top\">1D gearbox with arbitrary shaft directions (3D bearing frame)
      </td>
  </tr>
</table>
<p>
Components <b>Fixed</b>, <b>FixedTranslation</b>, <b>FixedRotation</b>
and <b>BodyShape</b> are visualized according to parameter
<b>shapeType</b>, that may have the following values (e.g., shapeType = \"box\"): <br>&nbsp;<br>
</p>
<IMG SRC=\"../Images/MultiBody/FixedShape.png\" ALT=\"model Visualizers.FixedShape\">
<p>
All the details of the visualization shape parameters are
given in
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Visualizers.FixedShape\">Visualizers.FixedShape</a>
</p>
<p>
Colors in all animation parts are defined via parameter <b>color</b>.
This is an Integer vector with 3 elements, {r, g, b}, and specifies the
color of the shape. {r,g,b} are the \"red\", \"green\" and \"blue\" color parts,
given in the ranges 0 .. 255, respectively. The predefined type
<b>MultiBody.Types.Color</b> contains a menu
definition of the colors used in the MultiBody library
(this will be replaced by a color editor).
</p>
</HTML>
"));
end Parts;
