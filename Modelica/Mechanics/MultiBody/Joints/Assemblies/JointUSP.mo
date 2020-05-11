within Modelica.Mechanics.MultiBody.Joints.Assemblies;
model JointUSP
  "Universal - spherical - prismatic joint aggregation (no constraints, no potential states)"

  import Modelica.Mechanics.MultiBody.Types;

  extends Interfaces.PartialTwoFramesDoubleSize;
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_ia
    "Coordinate system at origin of frame_a fixed at connecting rod of universal and spherical joint"
    annotation (Placement(transformation(
        origin={-80,100},
        extent={{-8,-8},{8,8}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_ib
    "Coordinate system at origin of frame_b fixed at connecting rod of spherical and prismatic joint"
    annotation (Placement(transformation(
        origin={80,100},
        extent={{-8,8},{8,-8}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_im
    "Coordinate system at origin of spherical joint fixed at connecting rod of spherical and prismatic joint"
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
  parameter Boolean showUniversalAxes=true
    "= true, if universal joint shall be visualized with two cylinders, otherwise with a sphere (provided animation=true)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n1_a={0,0,1}
    "Axis 1 of universal joint fixed and resolved in frame_a (axis 2 is orthogonal to axis 1 and to rod 1)"
    annotation (Evaluate=true);
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_b={-1,0,0}
    "Axis of prismatic joint fixed and resolved in frame_b"
    annotation (Evaluate=true);
  parameter SI.Position rRod1_ia[3]={1,0,0}
    "Vector from origin of frame_a to spherical joint, resolved in frame_ia"
    annotation (Evaluate=true);
  parameter SI.Position rRod2_ib[3]={-1,0,0}
    "Vector from origin of frame_ib to spherical joint, resolved in frame_ib (frame_ib is parallel to frame_b)"
    annotation (Evaluate=true);
  parameter SI.Position s_offset=0
    "Relative distance offset of prismatic joint (distance between the prismatic joint frames = s(t) + s_offset)";
  parameter SI.Position s_guess=0
    "Select the configuration such that at initial time |s(t0)-s_guess| is minimal";
  parameter SI.Diameter sphereDiameter=world.defaultJointLength
    "Diameter of the spheres representing the universal and the spherical joint"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor
    "Color of the spheres representing the universal and the spherical joint"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Diameter rod1Diameter=sphereDiameter/Types.Defaults.
      JointRodDiameterFraction
    "Diameter of rod 1 connecting the universal and the spherical joint"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color rod1Color=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor
    "Color of rod 1 connecting the universal and the spherical joint"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Diameter rod2Diameter=rod1Diameter
    "Diameter of rod 2 connecting the prismatic and the spherical joint"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color rod2Color=rod1Color
    "Color of rod 2 connecting the prismatic and the spherical joint"
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
  input Types.Color boxColor=sphereColor "Color of prismatic joint box"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Distance cylinderLength=world.defaultJointLength
    "Length of cylinders representing the two universal joint axes" annotation (
     Dialog(tab="Animation", group="if animation = true and showUniversalAxes",
            enable=animation and showUniversalAxes));
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth
    "Diameter of cylinders representing the two universal joint axes"
    annotation (Dialog(tab="Animation", group=
          "if animation = true and showUniversalAxes",
            enable=animation and showUniversalAxes));
  input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor
    "Color of cylinders representing the two universal joint axes" annotation (
      Dialog(colorSelector=true, tab="Animation", group="if animation = true and showUniversalAxes",
            enable=animation and showUniversalAxes));
  parameter Boolean checkTotalPower=false
    "= true, if total power flowing into this component shall be determined (must be zero)"
    annotation (Dialog(tab="Advanced"));
  final parameter Real eRod1_ia[3](each final unit="1")=rod1.eRod_ia
    "Unit vector from origin of frame_a to origin of spherical joint, resolved in frame_ia";
  final parameter Real e2_ia[3](each final unit="1")=rod1.e2_ia
    "Unit vector in direction of axis 2 of universal joint, resolved in frame_ia";
  final parameter SI.Distance rod1Length=rod1.rodLength
    "Length of rod 1 (= distance between universal and spherical joint)";
  SI.Force f_rod
    "Constraint force in direction of the rod (positive, if rod is pressed)";
  SI.Power totalPower
    "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";

  Modelica.Mechanics.MultiBody.Joints.Internal.PrismaticWithLengthConstraint prismatic(
    animation=animation,
    length=rod1.rodLength,
    n=n_b,
    s_offset=s_offset,
    s_guess=s_guess,
    boxWidthDirection=boxWidthDirection,
    boxWidth=boxWidth,
    boxHeight=boxHeight,
    boxColor=boxColor,
    specularCoefficient=specularCoefficient) annotation (Placement(transformation(extent={{76,-20},{36,20}})));
  Modelica.Mechanics.MultiBody.Joints.UniversalSpherical rod1(
    animation=animation,
    showUniversalAxes=showUniversalAxes,
    rRod_ia=rRod1_ia,
    n1_a=n1_a,
    sphereDiameter=sphereDiameter,
    sphereColor=sphereColor,
    rodWidth=rod1Diameter,
    rodHeight=rod1Diameter,
    rodColor=rod1Color,
    specularCoefficient=specularCoefficient,
    cylinderLength=cylinderLength,
    cylinderDiameter=cylinderDiameter,
    cylinderColor=cylinderColor,
    kinematicConstraint=false,
    constraintResidue=rod1.f_rod - f_rod) annotation (Placement(transformation(extent={{-92,-20},{-52,20}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod2(
    animation=animation,
    r=rRod2_ib,
    width=rod2Diameter,
    height=rod2Diameter,
    specularCoefficient=specularCoefficient,
    color=rod2Color) annotation (Placement(transformation(extent={{0,20},{
            -40,-20}})));
  Sensors.RelativePosition relativePosition(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a)
    annotation (Placement(transformation(extent={{50,-70},{30,-90}})));
  Modelica.Blocks.Sources.Constant position_b[3](k=rRod2_ib)
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
protected
  Real aux
    "Denominator used to compute force in rod connecting universal and spherical joint";
equation
  /* Compute the unknown force in rod1 connecting the universal and
     the spherical joint by a force balance at the prismatic joint
        0 = -prismatic.frame_b.f + frame_ib.f + frame_im.f - rod1.frame_b.f
     The force at rod1.frame_b is split into two parts:
        rod1.frame_b.f = Frames.resolve2(rod1.R_rel, rod1.f_b_a1 - rod1.f_rod*rod1.eRod_a)
     where rod1.f_rod is the unknown force in rod1.
     The condition is that the projection of the force in the prismatic
     joint along the axis of its translation axis is equal to the driving
     axis force in the flange:
       -prismatic.f = prismatic.e*prismatic.frame_b.f
     Therefore, we have with e=prismatic.e and f=prismatic.f
       -f = e*(frame_ib.f + frame_im.f
               - Frames.resolve2(rod1.R_rel, rod1.f_b_a1 - rod1.f_rod*rod1.eRod_a))
          = e*(frame_ib.f + frame_im.f - Frames.resolve2(rod1.R_rel, rod1.f_b_a1)
              + rod1.f_rod*Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     Solving this equation for f_rod results in
       rod1.f_rod = -(f+e*(frame_ib.f + frame_im.f - Frames.resolve2(rod1.R_rel, rod1.f_b_a1)))
                   /(e*Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     Additionally, a guard against division by zero is introduced
  */
  aux = prismatic.e*Frames.resolveRelative(rod1.eRod_a, rod1.frame_a.R,
    rod1.frame_b.R);
  f_rod = (-prismatic.f - prismatic.e*(frame_ib.f + frame_im.f -
    Frames.resolveRelative(rod1.f_b_a1, rod1.frame_a.R, rod1.frame_b.R)))/
    noEvent(if abs(aux) < 1e-10 then 1e-10 else aux);
  // Measure power for test purposes
  if checkTotalPower then
    totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) +
      frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + frame_ia.f*
      Frames.resolve2(frame_ia.R, der(frame_ia.r_0)) + frame_ib.f*
      Frames.resolve2(frame_ib.R, der(frame_ib.r_0)) + frame_im.f*
      Frames.resolve2(frame_im.R, der(frame_im.r_0)) + frame_a.t*
      Frames.angularVelocity2(frame_a.R) + frame_b.t*
      Frames.angularVelocity2(frame_b.R) + frame_ia.t*
      Frames.angularVelocity2(frame_ia.R) + frame_ib.t*
      Frames.angularVelocity2(frame_ib.R) + frame_im.t*
      Frames.angularVelocity2(frame_im.R) + axis.f*der(axis.s) + bearing.f*
      der(bearing.s);
  else
    totalPower = 0;
  end if;

  connect(prismatic.frame_b, rod2.frame_a) annotation (Line(
      points={{36,0},{0,0}},
      color={95,95,95},
      thickness=0.5));
  connect(rod2.frame_b, rod1.frame_b) annotation (Line(
      points={{-40,0},{-52,0}},
      thickness=0.5));
  connect(prismatic.frame_a, frame_b) annotation (Line(
      points={{76,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(rod2.frame_a, frame_ib) annotation (Line(
      points={{0,0},{7,0},{7,70},{80,70},{80,100}},
      color={95,95,95},
      thickness=0.5));
  connect(rod1.frame_a, frame_a) annotation (Line(
      points={{-92,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativePosition.frame_b, frame_a)
                                           annotation (Line(
      points={{30,-80},{-97,-80},{-97,0},{-100,0}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(relativePosition.frame_a, frame_b)
                                           annotation (Line(
      points={{50,-80},{95,-80},{95,0},{100,0}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(rod2.frame_b, frame_im) annotation (Line(
      points={{-40,0},{-46,0},{-46,80},{0,80},{0,100}},
      color={95,95,95},
      thickness=0.5));
  connect(rod1.frame_ia, frame_ia) annotation (Line(
      points={{-80,20},{-80,100}},
      color={95,95,95},
      thickness=0.5));
  connect(position_b.y, prismatic.position_b) annotation (Line(
      points={{1,-50},{10,-50},{10,-12},{32,-12}}, color={0,0,127}));
  connect(prismatic.axis, axis) annotation (Line(points={{40,14},{40,56},{
          90,56},{90,80},{100,80}}, color={0,191,0}));
  connect(prismatic.bearing, bearing)
    annotation (Line(points={{64,14},{64,40},{100,40}}, color={0,191,0}));
  connect(relativePosition.r_rel, prismatic.position_a)
                                                      annotation (Line(
      points={{40,-69},{40,-50},{90,-50},{90,-12},{80,-12}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
This component consists of a <strong>universal</strong> joint at frame_a, a <strong>prismatic</strong>
joint at frame_b and a <strong>spherical</strong> joint which is connected via <strong>rod1</strong>
to the universal and via <strong>rod2</strong> to the prismatic joint, see the default
animation in the following figure (the axes vectors are not part of the
default animation):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointUSP.png\" alt=\"model Joints.Assemblies.JointUSP\">
</div>

<p>
This joint aggregation has no mass and no inertia and
introduces neither constraints nor potential state variables.
It should be used in kinematic loops whenever possible since
the non-linear system of equations introduced by this joint aggregation
is solved <strong>analytically</strong> (i.e., a solution is always computed, if a
unique solution exists).
</p>
<p>
The universal joint is defined in the following way:
</p>
<ul>
<li> The rotation <strong>axis</strong> of revolute joint <strong>1</strong> is along parameter
     vector n1_a which is fixed in frame_a.</li>
<li> The rotation <strong>axis</strong> of revolute joint <strong>2</strong> is perpendicular to
     axis 1 and to the line connecting the universal and the spherical joint
     (= rod 1).</li>
</ul>
<p>
The definition of axis 2 of the universal joint is performed according
to the most often occurring case for the sake of simplicity. Otherwise, the treatment is much more
complicated and the number of operations is considerably higher,
if axis 2 is not orthogonal to axis 1 and to the connecting rod.
</p>
<p>
Note, there is a <strong>singularity</strong> when axis 1 and the connecting rod are parallel
to each other. Therefore, if possible n1_a should be selected in such a way that it
is perpendicular to rRod1_ia in the initial configuration (i.e., the
distance to the singularity is as large as possible).
</p>
<p>
The rest of this joint aggregation is defined by the following parameters:
</p>
<ul>
<li> The position of the spherical joint with respect to the universal
     joint is defined by vector <strong>rRod1_ia</strong>. This vector is directed from
     frame_a to the spherical joint and is resolved in frame_ia
     (it is most simple to select frame_ia such that it is parallel to
     frame_a in the reference or initial configuration).</li>
<li> The position of the spherical joint with respect to the prismatic
     joint is defined by vector <strong>rRod2_ib</strong>. This vector is directed from
     the inner frame of the prismatic joint (frame_ib or prismatic.frame_a)
     to the spherical joint and is resolved in frame_ib (note, that frame_ib
     and frame_b are parallel to each other).</li>
<li> The axis of translation of the prismatic joint is defined by axis
     vector <strong>n_b</strong>. It is fixed and resolved in frame_b.</li>
<li> The two frames of the prismatic joint, i.e., frame_b and frame_ib,
     are parallel to each other.
     The distance between the origins of these two frames along axis n_b
     is equal to \"prismatic.s(t) + s_offset\", where \"prismatic.s(t)\" is
     a time varying variable and \"s_offset\" is a fixed, constant offset
     parameter.</li>
<li> When specifying this joint aggregation with the definitions above, <strong>two</strong>
     different <strong>configurations</strong> are possible. Via parameter <strong>s_guess</strong>
     a guess value for prismatic.s(t0) at the initial time t0 is given. The configuration
     is selected that is closest to s_guess (|prismatic.s - s_guess| is minimal).</li>
</ul>
<p>
An additional <strong>frame_ia</strong> is present. It is <strong>fixed</strong> in the rod
connecting the universal and the spherical joint at the
origin of <strong>frame_a</strong>. The placement of frame_ia on the rod
is implicitly defined by the universal joint (frame_a and frame_ia coincide
when the angles of the two revolute joints of the universal joint are zero)
and by parameter vector <strong>rRod1_ia</strong>, the position vector
from the origin of frame_a to the spherical joint, resolved in frame_<strong>ia</strong>.
</p>
<p>
An additional <strong>frame_ib</strong> is present. It is <strong>fixed</strong> in the rod
connecting the prismatic and the spherical joint at the side of the prismatic
joint that is connected to this rod (= rod2.frame_a = prismatic.frame_a).
It is always parallel to <strong>frame_b</strong>.
</p>
<p>
An additional <strong>frame_im</strong> is present. It is <strong>fixed</strong> in the rod
connecting the prismatic and the spherical joint at the side of the spherical
joint that is connected to this rod (= rod2.frame_b).
It is always parallel to <strong>frame_b</strong>.
</p>
<p>
The easiest way to define the parameters of this joint is by moving the
MultiBody system in a <strong>reference configuration</strong> where <strong>all frames</strong>
of all components are <strong>parallel</strong> to each other (alternatively,
at least frame_a and frame_ia of the JointUSP joint
should be parallel to each other when defining an instance of this
component).
</p>
<p>
In the public interface of the JointUSP joint, the following
(final) <strong>parameters</strong> are provided:
</p>
<blockquote><pre>
<strong>parameter</strong> Real rod1Length(unit=\"m\")  \"Length of rod 1\";
<strong>parameter</strong> Real eRod1_ia[3] \"Unit vector along rod 1, resolved in frame_ia\";
<strong>parameter</strong> Real e2_ia  [3]  \"Unit vector along axis 2, resolved in frame_ia\";
</pre></blockquote>
<p>
This allows a more convenient definition of data which is related to rod 1.
For example, if a box shall be connected at frame_ia directing from
the origin of frame_a to the middle of rod 1, this might be defined as:
</p>
<blockquote><pre>
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUSP jointUSP(rRod1_ia={1.2, 1, 0.2});
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape     shape(shapeType       = \"box\",
                                             lengthDirection = jointUSP.eRod1_ia,
                                             widthDirection  = jointUSP.e2_ia,
                                             length          = jointUSP.rod1Length/2,
                                             width           = jointUSP.rod1Length/10);
<strong>equation</strong>
  <strong>connect</strong>(jointUSP.frame_ia, shape.frame_a);
</pre></blockquote>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.2), graphics={
        Rectangle(
          extent={{50,20},{80,-20}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,30},{100,-30}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-140,-45},{140,-70}},
          textColor={0,0,255},
          textString="%name"),
        Ellipse(
          extent={{-100,-30},{-40,30}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Ellipse(
          extent={{-93,-22},{-48,23}},
          lineColor={160,160,164},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-70,40},{-39,-33}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-70,28},{-70,-30}},
          thickness=0.5),
        Ellipse(
          extent={{-89,-18},{-48,18}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Ellipse(
          extent={{-84,-12},{-53,13}},
          lineColor={160,160,164},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-81,-17},{-92,-1},{-83,16},{-57,24},{-81,-17}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(
          points={{-70,30},{-70,-10}},
          thickness=0.5),
        Line(
          points={{-61,16},{-79,-15}},
          thickness=0.5),
        Line(
          points={{-50,0},{-50,80},{-80,80},{-80,100}},
          color={95,95,95},
          thickness=0.5),
        Ellipse(
          extent={{-40,-30},{20,30}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Ellipse(
          extent={{-33,-22},{12,23}},
          lineColor={192,192,192},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-44,31},{-14,-30}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-23,10},{-3,-10}},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{19,6},{50,-6}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-50,5},{-21,-5}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Text(
          extent={{37,109},{68,90}},
          textColor={128,128,128},
          textString="ib"),
        Text(
          extent={{-124,110},{-93,90}},
          textColor={128,128,128},
          textString="ia"),
        Line(
          points={{50,6},{50,80},{80,80},{80,100}},
          color={95,95,95},
          thickness=0.5),
        Text(
          extent={{-44,111},{-8,91}},
          textColor={128,128,128},
          textString="im"),
        Line(
          points={{19,6},{19,80},{0,80},{0,100}},
          color={95,95,95},
          thickness=0.5),
        Rectangle(
          extent={{80,24},{100,30}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Rectangle(
          extent={{50,14},{80,20}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(
          points={{95,80},{79,80}},
          color={135,135,135},
          thickness=0.5),
        Line(
          points={{95,40},{90,40},{90,30}},
          color={135,135,135},
          thickness=0.5)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.2), graphics={
        Line(
          points={{-78,30},{-50,30}},
          color={128,128,128},
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-76,39},{-49,32}},
          textColor={128,128,128},
          textString="rRod1_ia"),
        Text(
          extent={{-27,40},{0,33}},
          textColor={128,128,128},
          textString="rRod2_ib"),
        Line(
          points={{3,30},{-43,30}},
          color={128,128,128},
          arrow={Arrow.None,Arrow.Filled})}));
end JointUSP;
