within Modelica.Mechanics.MultiBody.Joints.Assemblies;
model JointRRR
  "Planar revolute - revolute - revolute joint aggregation (no constraints, no potential states)"

  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Units.Conversions.to_unit1;

  extends Interfaces.PartialTwoFramesDoubleSize;

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_ia
    "Coordinate system at origin of frame_a fixed at connecting rod of left and middle revolute joint"
    annotation (Placement(transformation(
        origin={-80,100},
        extent={{-8,-8},{8,8}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_ib
    "Coordinate system at origin of frame_b fixed at connecting rod of middle and right revolute joint"
    annotation (Placement(transformation(
        origin={80,100},
        extent={{-8,8},{8,-8}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_im
    "Coordinate system at origin of revolute joint in the middle fixed at connecting rod of middle and right revolute joint"
    annotation (Placement(transformation(
        origin={0,100},
        extent={{8,-8},{-8,8}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis
    "1-dim. rotational flange that drives the right revolute joint at frame_b"
    annotation (Placement(transformation(extent={{105,85},{95,75}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b bearing
    "1-dim. rotational flange of the drive bearing of the right revolute joint at frame_b"
    annotation (Placement(transformation(extent={{95,45},{105,35}})));

  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_a={0,0,1}
    "Axes of revolute joints resolved in frame_a (all axes are parallel to each other)"
    annotation (Evaluate=true);
  final parameter Real n_b[3](each final unit="1",each fixed=false, start = {0,0,1})
    "Axis of revolute joint fixed and resolved in frame_b"
    annotation (Evaluate=true);
  parameter SI.Position rRod1_ia[3]={1,0,0}
    "Vector from origin of frame_a to revolute joint in the middle, resolved in frame_ia"
    annotation (Evaluate=true);
  parameter SI.Position rRod2_ib[3]={-1,0,0}
    "Vector from origin of frame_ib to revolute joint in the middle, resolved in frame_ib";
  parameter Modelica.Units.NonSI.Angle_deg phi_offset=0
    "Relative angle offset of revolute joint at frame_b (angle = phi(t) + from_deg(phi_offset))";
  parameter Modelica.Units.NonSI.Angle_deg phi_guess=0
    "Select the configuration such that at initial time |phi(t0) - from_deg(phi_guess)| is minimal";
  parameter SI.Distance cylinderLength=world.defaultJointLength
    "Length of cylinders representing the revolute joints"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth
    "Diameter of cylinders representing the revolute joints"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor
    "Color of cylinders representing the revolute joints"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Diameter rodDiameter=1.1*cylinderDiameter
    "Diameter of the two rods connecting the revolute joints"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color rodColor=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor
    "Color of the two rods connecting the revolute joint"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));

  parameter Boolean checkTotalPower=false
    "= true, if total power flowing into this component shall be determined (must be zero)"
    annotation (Dialog(tab="Advanced"));
  final parameter Real e_a[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(
                                               n_a)
    "Unit vector along axes of rotations, resolved in frame_a";
  final parameter Real e_ia[3](each final unit="1")=jointUSR.e2_ia
    "Unit vector along axes of rotations, resolved in frame_ia";
  final parameter Real e_b[3](each final unit="1")=jointUSR.revolute.e
    "Unit vector along axes of rotations, resolved in frame_b, frame_ib and frame_im";
  SI.Power totalPower=jointUSR.totalPower
    "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";

  JointUSR jointUSR(
    animation=false,
    n1_a=n_a,
    n_b=n_b,
    phi_offset=phi_offset,
    rRod2_ib=rRod2_ib,
    showUniversalAxes=false,
    rRod1_ia=rRod1_ia,
    checkTotalPower=checkTotalPower,
    phi_guess=phi_guess) annotation (Placement(transformation(extent={{-30,
            -20},{10,20}})));

protected
 Visualizers.Advanced.Shape shape_rev1(
    shapeType="cylinder",
    color=cylinderColor,
    specularCoefficient=specularCoefficient,
    length=cylinderLength,
    width=cylinderDiameter,
    height=cylinderDiameter,
    lengthDirection=e_a,
    widthDirection={0,1,0},
    r_shape=-e_a*(cylinderLength/2),
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_rev2(
    shapeType="cylinder",
    color=cylinderColor,
    specularCoefficient=specularCoefficient,
    length=cylinderLength,
    width=cylinderDiameter,
    height=cylinderDiameter,
    lengthDirection=e_b,
    widthDirection={0,1,0},
    r_shape=-e_b*(cylinderLength/2),
    r=frame_im.r_0,
    R=frame_im.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_rev3(
    shapeType="cylinder",
    color=cylinderColor,
    specularCoefficient=specularCoefficient,
    length=cylinderLength,
    width=cylinderDiameter,
    height=cylinderDiameter,
    lengthDirection=e_b,
    widthDirection={0,1,0},
    r_shape=-e_b*(cylinderLength/2),
    r=frame_b.r_0,
    R=frame_b.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_rod1(
    shapeType="cylinder",
    color=rodColor,
    specularCoefficient=specularCoefficient,
    length=Modelica.Math.Vectors.length(
                         rRod1_ia),
    width=rodDiameter,
    height=rodDiameter,
    lengthDirection = to_unit1(rRod1_ia),
    widthDirection=e_ia,
    r=frame_ia.r_0,
    R=frame_ia.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_rod2(
    shapeType="cylinder",
    color=rodColor,
    specularCoefficient=specularCoefficient,
    length=Modelica.Math.Vectors.length(
                         rRod2_ib),
    width=rodDiameter,
    height=rodDiameter,
    lengthDirection = to_unit1(rRod2_ib),
    widthDirection=e_b,
    r=frame_ib.r_0,
    R=frame_ib.R) if world.enableAnimation and animation;
initial equation
  n_b = Frames.resolve2(frame_b.R, Frames.resolve1(frame_a.R, n_a));

equation
  connect(jointUSR.frame_a, frame_a)
    annotation (Line(
      points={{-30,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(jointUSR.frame_b, frame_b)
    annotation (Line(
      points={{10,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(jointUSR.frame_ia, frame_ia) annotation (Line(
      points={{-26,20},{-26,70},{-80,70},{-80,100}},
      color={95,95,95},
      thickness=0.5));
  connect(jointUSR.frame_im, frame_im) annotation (Line(
      points={{-10,20},{-10,70},{0,70},{0,100}},
      color={95,95,95},
      thickness=0.5));
  connect(jointUSR.frame_ib, frame_ib) annotation (Line(
      points={{6,20},{6,50},{80,50},{80,100}},
      color={95,95,95},
      thickness=0.5));
  connect(jointUSR.axis, axis)
    annotation (Line(points={{10,16},{86,16},{86,80},{100,80}}));
  connect(jointUSR.bearing, bearing)
    annotation (Line(points={{10,8},{94,8},{94,40},{100,40}}));
  annotation (
    Documentation(info="<html>
<p>
This component consists of <strong>3 revolute</strong> joints with parallel
axes of rotation that are connected together by two rods, see the default
animation in the following figure (the axes vectors are not part of the
default animation):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointRRR.png\" alt=\"model Joints.Assemblies.JointRRR\">
</div>

<p>
This joint aggregation introduces neither constraints nor state variables and
should therefore be used in kinematic loops whenever possible to
avoid non-linear systems of equations. It is only meaningful to
use this component in <strong>planar loops</strong>. Basically, the position
and orientation of the 3 revolute joints as well as of frame_ia, frame_ib, and
frame_im are calculated by solving analytically a non-linear equation,
given the position and orientation at frame_a and at frame_b.
</p>
<p>
Connector <strong>frame_a</strong> is the \"left\" side of the first revolute joint
whereas <strong>frame_ia</strong> is the \"right side of this revolute joint, fixed in rod 1.
Connector <strong>frame_b</strong> is the \"right\" side of the third revolute joint
whereas <strong>frame_ib</strong> is the \"left\" side of this revolute joint, fixed in rod 2.
Finally, connector <strong>frame_im</strong> is the connector at the \"right\" side
of the revolute joint in the middle, fixed in rod 2.
</p>
<p>
The easiest way to define the parameters of this joint is by moving the
MultiBody system in a <strong>reference configuration</strong> where <strong>all frames</strong>
of all components are <strong>parallel</strong> to each other (alternatively,
at least frame_a, frame_ia, frame_im, frame_ib, frame_b of the JointRRR joint
should be parallel to each other when defining an instance of this
component).
</p>
<p>
Basically, the JointRRR model consists internally of a universal -
spherical - revolute joint aggregation (= JointUSR). In a planar
loop this will behave as if 3 revolute joints with parallel axes
are connected by rigid rods.
</p>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.2), graphics={
        Rectangle(
          extent={{-90,90},{90,-90}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-140,-55},{140,-80}},
          textColor={0,0,255},
          textString="%name"),
        Text(
          extent={{36,114},{71,92}},
          textColor={128,128,128},
          textString="ib"),
        Text(
          extent={{-126,115},{-87,90}},
          textColor={128,128,128},
          textString="ia"),
        Ellipse(
          extent={{-100,25},{-50,-25}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-85,10},{-65,-10}},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{50,25},{100,-25}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{65,10},{85,-10}},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-26,80},{24,30}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-10,66},{10,46}},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-71,9},{-24,45},{-19,39},{-66,3},{-71,9}},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{54,12},{5,47},{10,52},{59,18},{54,12}},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{100,-4},{83,-4},{84,3},{100,3},{100,-4}},
          fillPattern=FillPattern.Solid),
        Line(
          points={{80,24},{80,80},{80,80},{80,100}},
          color={95,95,95},
          thickness=0.5),
        Text(
          extent={{-128,-29},{136,-47}},
          textString="n_a=%n_a"),
        Line(
          points={{0,57},{0,86},{0,86},{0,100}},
          color={95,95,95},
          thickness=0.5),
        Text(
          extent={{-46,114},{-7,91}},
          textColor={128,128,128},
          textString="im"),
        Line(
          points={{-80,100},{-80,8}},
          color={95,95,95},
          thickness=0.5),
        Line(
          points={{80,80},{101,80}},
          color={95,95,95},
          thickness=0.5),
        Line(
          points={{100,40},{93,40},{93,3}},
          color={95,95,95},
          thickness=0.5)}));
end JointRRR;
