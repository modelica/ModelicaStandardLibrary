within Modelica.Mechanics.MultiBody.Parts;
model FixedRotation
  "Fixed translation followed by a fixed rotation of frame_b with respect to frame_a"

  import Modelica.Mechanics.MultiBody.Frames;
  import Modelica.Units.Conversions.to_unit1;

  Interfaces.Frame_a frame_a
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{-116,-16},{-84,16}})));
  Interfaces.Frame_b frame_b
    "Coordinate system fixed to the component with one cut-force and cut-torque"
    annotation (Placement(transformation(extent={{84,-16},{116,16}})));

  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter SI.Position r[3]={0,0,0}
    "Vector from frame_a to frame_b resolved in frame_a";
  parameter Modelica.Mechanics.MultiBody.Types.RotationTypes rotationType=
      Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis
    "Type of rotation description" annotation (Evaluate=true);
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={1,0,0}
    "Axis of rotation in frame_a (= same as in frame_b)" annotation (
      Evaluate=true, Dialog(group="if rotationType = RotationAxis", enable=
          rotationType == Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis));
  parameter Modelica.Units.NonSI.Angle_deg angle=0
    "Angle to rotate frame_a around axis n into frame_b" annotation (Dialog(
        group="if rotationType = RotationAxis", enable=rotationType ==
          Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis));

  parameter Modelica.Mechanics.MultiBody.Types.Axis n_x={1,0,0}
    "Vector along x-axis of frame_b resolved in frame_a" annotation (
      Evaluate=true, Dialog(group="if rotationType = TwoAxesVectors", enable=
          rotationType == Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors));
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_y={0,1,0}
    "Vector along y-axis of frame_b resolved in frame_a" annotation (
      Evaluate=true, Dialog(group="if rotationType = TwoAxesVectors", enable=
          rotationType == Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors));

  parameter Modelica.Mechanics.MultiBody.Types.RotationSequence sequence(
    min={1,1,1},
    max={3,3,3}) = {1,2,3} "Sequence of rotations" annotation (Evaluate=true,
      Dialog(group="if rotationType = PlanarRotationSequence", enable=
          rotationType == Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence));
  parameter Modelica.Units.NonSI.Angle_deg angles[3]={0,0,0}
    "Rotation angles around the axes defined in 'sequence'" annotation (
      Dialog(group="if rotationType = PlanarRotationSequence", enable=
          rotationType == Modelica.Mechanics.MultiBody.Types.RotationTypes.PlanarRotationSequence));
  parameter Modelica.Mechanics.MultiBody.Types.ShapeType shapeType="cylinder"
    "Type of shape" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter SI.Position r_shape[3]={0,0,0}
    "Vector from frame_a to shape origin, resolved in frame_a" annotation (
      Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter Modelica.Mechanics.MultiBody.Types.Axis lengthDirection=
      to_unit1(r - r_shape)
    "Vector in length direction of shape, resolved in frame_a"
    annotation (Evaluate=true, Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter Modelica.Mechanics.MultiBody.Types.Axis widthDirection={0,1,0}
    "Vector in width direction of shape, resolved in frame_a" annotation (
      Evaluate=true, Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter SI.Length length=Modelica.Math.Vectors.length(r - r_shape)
    "Length of shape" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter SI.Distance width=length/world.defaultWidthFraction
    "Width of shape" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter SI.Distance height=width "Height of shape" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter Modelica.Mechanics.MultiBody.Types.ShapeExtra extra=0.0
    "Additional parameter depending on shapeType (see docu of Visualizers.Advanced.Shape)"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  /*
  parameter Boolean checkTotalPower=false
    "= true, if total power flowing into this component shall be determined (must be zero)"
    annotation (Dialog(tab="Advanced"));
*/

  input Modelica.Mechanics.MultiBody.Types.Color color=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor
    "Color of shape" annotation (Dialog(
      colorSelector=true,
      tab="Animation",
      group="if animation = true",
      enable=animation));
  input Modelica.Mechanics.MultiBody.Types.SpecularCoefficient
    specularCoefficient=world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  final parameter Frames.Orientation R_rel=if rotationType == Types.RotationTypes.RotationAxis
       then Frames.planarRotation(
        Modelica.Math.Vectors.normalizeWithAssert(n),
        Cv.from_deg(angle),
        0) else if rotationType == Types.RotationTypes.TwoAxesVectors then
      Frames.from_nxy(n_x, n_y) else Frames.axesRotations(
        sequence,
        Cv.from_deg(angles),
        zeros(3)) "Fixed rotation object from frame_a to frame_b";
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
  if Connections.rooted(frame_a.R) then
    frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
    zeros(3) = frame_a.f + Frames.resolve1(R_rel, frame_b.f);
    zeros(3) = frame_a.t + Frames.resolve1(R_rel, frame_b.t) - cross(r,
      frame_a.f);
  else
    frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel_inv);
    zeros(3) = frame_b.f + Frames.resolve1(R_rel_inv, frame_a.f);
    zeros(3) = frame_b.t + Frames.resolve1(R_rel_inv, frame_a.t) + cross(
      Frames.resolve1(R_rel_inv, r), frame_b.f);
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
    Documentation(info="<html>
<p>
Component for a <strong>fixed translation</strong> and <strong>fixed rotation</strong> of frame_b with respect
to frame_a, i.e., the relationship between connectors frame_a and frame_b
remains constant. There are several possibilities to define the
orientation of frame_b with respect to frame_a:
</p>
<ul>
<li><strong>Planar rotation</strong> along axis 'n' (that is fixed and resolved
    in frame_a) with a fixed angle 'angle'.</li>
<li><strong>Vectors n_x</strong> and <strong>n_y</strong> that are directed along the corresponding axes
    direction of frame_b and are resolved in frame_a (if n_y is not
    orthogonal to n_x, the y-axis of frame_b is selected such that it is
    orthogonal to n_x and in the plane of n_x and n_y).</li>
<li><strong>Sequence</strong> of <strong>three planar axes rotations</strong>.
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
the animation may be switched off via parameter animation = <strong>false</strong>.
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Parts/FixedRotation.png\" alt=\"Parts.FixedRotation\">
</div>
</html>",
        revisions="<html><p><strong>Release Notes:</strong></p>
<ul>
  <li><em>July 28, 2003</em><br>
         Bug fixed: if rotationType = PlanarRotationSequence, then 'angles'
         was used with unit [rad] instead of [deg].</li>
</ul>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,80},{150,120}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{-100,5},{100,-4}},
          fillPattern=FillPattern.Solid),
        Line(points={{80,20},{129,50}}),
        Line(points={{80,20},{57,59}}),
        Polygon(
          points={{144,60},{117,59},{132,37},{144,60}},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{43,80},{46,50},{68,65},{43,80}},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-50},{150,-80}},
          textString="r=%r"),
        Text(
          extent={{-117,51},{-81,26}},
          textColor={128,128,128},
          textString="a"),
        Text(
          extent={{84,-24},{120,-49}},
          textColor={128,128,128},
          textString="b")}));
end FixedRotation;
