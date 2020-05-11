within Modelica.Mechanics.MultiBody.Joints.Assemblies;
model JointRRP
  "Planar revolute - revolute - prismatic joint aggregation (no constraints, no potential states)"

  import Modelica.Mechanics.MultiBody.Types;
  import Modelica.Units.Conversions.to_unit1;

  extends Interfaces.PartialTwoFramesDoubleSize;
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_ia
    "Coordinate system at origin of frame_a fixed at connecting rod of revolute joints"
    annotation (Placement(transformation(
        origin={-80,100},
        extent={{-8,-8},{8,8}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_ib
    "Coordinate system at origin of frame_b fixed at connecting rod of revolute and prismatic joint"
    annotation (Placement(transformation(
        origin={80,100},
        extent={{-8,8},{8,-8}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_im
    "Coordinate system at origin of revolute joint in the middle fixed at connecting rod of revolute and prismatic joint"
    annotation (Placement(transformation(
        origin={0,100},
        extent={{8,-8},{-8,8}},
        rotation=270)));
  Modelica.Mechanics.Translational.Interfaces.Flange_a axis
    "1-dim. translational flange that drives the prismatic joint"
    annotation (Placement(transformation(extent={{95,75},{105,85}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b bearing
    "1-dim. translational flange of the drive bearing of the prismatic joint"
    annotation (Placement(transformation(extent={{105,35},{95,45}})));

  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_a={0,0,1}
    "Axes of the two revolute joints resolved in frame_a (both axes are parallel to each other)"
    annotation (Evaluate=true);
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_b={-1,0,0}
    "Axis of prismatic joint fixed and resolved in frame_b (must be orthogonal to revolute joint axes)"
    annotation (Evaluate=true);
  parameter SI.Position rRod1_ia[3]={1,0,0}
    "Vector from origin of frame_a to revolute joint in the middle, resolved in frame_ia"
    annotation (Evaluate=true);
  parameter SI.Position rRod2_ib[3]={-1,0,0}
    "Vector from origin of frame_ib to revolute joint in the middle, resolved in frame_ib (frame_ib is parallel to frame_b)";
  parameter SI.Position s_offset=0
    "Relative distance offset of prismatic joint (distance between the prismatic joint frames = s(t) + s_offset)";
  parameter SI.Position s_guess=0
    "Select the configuration such that at initial time |s(t0)-s_guess| is minimal";
  parameter SI.Distance cylinderLength=world.defaultJointLength
    "Length of cylinders representing the revolute joints"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth
    "Diameter of cylinders representing the revolute joints"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor
    "Color of cylinders representing the revolute joints"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  parameter Types.Axis boxWidthDirection={0,1,0}
    "Vector in width direction of prismatic joint, resolved in frame_b"
    annotation (Evaluate=true, Dialog(tab="Animation", group=
          "if animation = true", enable=animation));
  parameter SI.Distance boxWidth=world.defaultJointWidth
    "Width of prismatic joint box"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Distance boxHeight=boxWidth "Height of prismatic joint box"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color boxColor=cylinderColor "Color of prismatic joint box"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Diameter rodDiameter=1.1*cylinderDiameter
    "Diameter of the two rods connecting the joints"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color rodColor=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor
    "Color of the two rods connecting the joints"
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
  final parameter Real e_ia[3](each final unit="1")=jointUSP.e2_ia
    "Unit vector along axes of rotations, resolved in frame_ia";
  final parameter Real e_im[3](each final unit="1", each fixed=false)
    "Unit vector along axes of rotations, resolved in frame_im";
  final parameter Real e_b[3](each final unit="1")=jointUSP.prismatic.e
    "Unit vector along axes of translation of the prismatic joint, resolved in frame_b and frame_ib";
  SI.Power totalPower=jointUSP.totalPower
    "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";

  JointUSP jointUSP(
    animation=false,
    showUniversalAxes=false,
    n1_a=n_a,
    n_b=n_b,
    s_offset=s_offset,
    s_guess=s_guess,
    rRod1_ia=rRod1_ia,
    rRod2_ib=rRod2_ib,
    checkTotalPower=checkTotalPower) annotation (Placement(transformation(
          extent={{-30,-20},{10,20}})));

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
    lengthDirection=e_im,
    widthDirection={0,1,0},
    r_shape=-e_im*(cylinderLength/2),
    r=frame_im.r_0,
    R=frame_im.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_prism(
    shapeType="box",
    color=boxColor,
    specularCoefficient=specularCoefficient,
    length=jointUSP.prismatic.distance,
    width=boxWidth,
    height=boxHeight,
    lengthDirection=e_b,
    widthDirection=e_im,
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
  e_im = Frames.resolve2(frame_im.R, Frames.resolve1(frame_a.R, e_a));

equation
  connect(jointUSP.frame_a, frame_a)
    annotation (Line(
      points={{-30,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(jointUSP.frame_b, frame_b)
    annotation (Line(
      points={{10,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(jointUSP.frame_ia, frame_ia) annotation (Line(
      points={{-26,20},{-26,70},{-80,70},{-80,100}},
      color={95,95,95},
      thickness=0.5));
  connect(jointUSP.frame_im, frame_im) annotation (Line(
      points={{-10,20},{-10,70},{0,70},{0,100}},
      color={95,95,95},
      thickness=0.5));
  connect(jointUSP.frame_ib, frame_ib) annotation (Line(
      points={{6,20},{6,50},{80,50},{80,100}},
      color={95,95,95},
      thickness=0.5));
  connect(jointUSP.axis, axis)
    annotation (Line(points={{10,16},{86,16},{86,80},{100,80}}));
  connect(jointUSP.bearing, bearing)
    annotation (Line(points={{10,8},{94,8},{94,40},{100,40}}));
  annotation (
    Documentation(info="<html>
<p>
This component consists of <strong>2 revolute</strong> joints with parallel
axes of rotation that and a <strong>prismatic</strong> joint with a translational
axis that is orthogonal to the revolute joint axes, see the default
animation in the following figure (the axes vectors are not part of the
default animation):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointRRP.png\" alt=\"model Joints.Assemblies.JointRRP\">
</div>

<p>
This joint aggregation introduces neither constraints nor state variables and
should therefore be used in kinematic loops whenever possible to
avoid non-linear systems of equations. It is only meaningful to
use this component in <strong>planar loops</strong>. Basically, the position
and orientation of the 3 joints as well as of frame_ia, frame_ib, and
frame_im are calculated by solving analytically a non-linear equation,
given the position and orientation at frame_a and at frame_b.
</p>
<p>
Connector <strong>frame_a</strong> is the \"left\" side of the first revolute joint
whereas <strong>frame_ia</strong> is the \"right side of this revolute joint, fixed in rod 1.
Connector <strong>frame_b</strong> is the \"right\" side of the prismatic joint
whereas <strong>frame_ib</strong> is the \"left\" side of this prismatic joint, fixed in rod 2.
Finally, connector <strong>frame_im</strong> is the connector at the \"right\" side
of the revolute joint in the middle, fixed in rod 2. The frames
frame_b, frame_ib, frame_im are always parallel to each other.
</p>
<p>
The easiest way to define the parameters of this joint is by moving the
MultiBody system in a <strong>reference configuration</strong> where <strong>all frames</strong>
of all components are <strong>parallel</strong> to each other (alternatively,
at least frame_a, frame_ia, frame_im, frame_ib, frame_b of the JointRRP joint
should be parallel to each other when defining an instance of this
component).
</p>
<p>
Basically, the JointRRP model consists internally of a universal -
spherical - prismatic joint aggregation (= JointUSP). In a planar
loop this will behave as if 2 revolute joints with parallel axes
and 1 prismatic joint are connected by rigid rods.
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
          extent={{-139,-53},{141,-78}},
          textColor={0,0,255},
          textString="%name"),
        Text(
          extent={{26,124},{68,93}},
          textColor={128,128,128},
          textString="ib"),
        Text(
          extent={{-134,128},{-94,94}},
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
          points={{54,5},{5,47},{8,53},{58,11},{54,5}},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-128,-29},{139,-47}},
          textString="n_a=%n_a"),
        Line(
          points={{0,57},{0,86},{0,86},{0,100}},
          color={95,95,95},
          thickness=0.5),
        Text(
          extent={{-55,126},{-15,92}},
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
          thickness=0.5),
        Rectangle(
          extent={{80,15},{100,21}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Rectangle(
          extent={{53,5},{80,11}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Rectangle(
          extent={{53,5},{80,-15}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,15},{100,-21}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{80,100},{80,80},{57,11}},
          color={95,95,95},
          thickness=0.5)}));
end JointRRP;
