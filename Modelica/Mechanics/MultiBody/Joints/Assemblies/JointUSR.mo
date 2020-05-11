within Modelica.Mechanics.MultiBody.Joints.Assemblies;
model JointUSR
  "Universal - spherical - revolute joint aggregation (no constraints, no potential states)"

  import Modelica.Mechanics.MultiBody.Types;

  extends Interfaces.PartialTwoFramesDoubleSize;
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_ia
    "Coordinate system at origin of frame_a fixed at connecting rod of universal and spherical joint"
    annotation (Placement(transformation(
        origin={-80,100},
        extent={{-8,-8},{8,8}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_ib
    "Coordinate system at origin of frame_b fixed at connecting rod of spherical and revolute joint"
    annotation (Placement(transformation(
        origin={80,100},
        extent={{-8,8},{8,-8}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_im
    "Coordinate system at origin of spherical joint fixed at connecting rod of spherical and revolute joint"
    annotation (Placement(transformation(
        origin={0,100},
        extent={{8,-8},{-8,8}},
        rotation=270)));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis
    "1-dim. rotational flange that drives the revolute joint"
    annotation (Placement(transformation(extent={{105,85},{95,75}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b bearing
    "1-dim. rotational flange of the drive bearing of the revolute joint"
    annotation (Placement(transformation(extent={{95,45},{105,35}})));

  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter Boolean showUniversalAxes=true
    "= true, if universal joint shall be visualized with two cylinders, otherwise with a sphere (provided animation=true)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n1_a={0,0,1}
    "Axis 1 of universal joint fixed and resolved in frame_a (axis 2 is orthogonal to axis 1 and to rod 1)"
    annotation (Evaluate=true);
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_b={0,0,1}
    "Axis of revolute joint fixed and resolved in frame_b"
    annotation (Evaluate=true);
  parameter SI.Position rRod1_ia[3]={1,0,0}
    "Vector from origin of frame_a to spherical joint, resolved in frame_ia"
    annotation (Evaluate=true);
  parameter SI.Position rRod2_ib[3]={-1,0,0}
    "Vector from origin of frame_ib to spherical joint, resolved in frame_ib";
  parameter Modelica.Units.NonSI.Angle_deg phi_offset=0
    "Relative angle offset of revolute joint (angle = phi(t) + from_deg(phi_offset))";
  parameter Modelica.Units.NonSI.Angle_deg phi_guess=0
    "Select the configuration such that at initial time |phi(t0) - from_deg(phi_guess)| is minimal";
  parameter SI.Diameter sphereDiameter=world.defaultJointLength
    "Diameter of the spheres representing the universal and the spherical joint"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.
       JointColor
    "Color of the spheres representing the universal and the spherical joint"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Diameter rod1Diameter=sphereDiameter/Types.Defaults.
      JointRodDiameterFraction
    "Diameter of rod 1 connecting the universal and the spherical joint"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color rod1Color=Modelica.Mechanics.MultiBody.Types.Defaults.
      RodColor
    "Color of rod 1 connecting the universal and the spherical joint"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));

  parameter SI.Diameter rod2Diameter=rod1Diameter
    "Diameter of rod 2 connecting the revolute and the spherical joint"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color rod2Color=rod1Color
    "Color of rod 2 connecting the revolute and the spherical joint"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Diameter revoluteDiameter=world.defaultJointWidth
    "Diameter of cylinder representing the revolute joint"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Distance revoluteLength=world.defaultJointLength
    "Length of cylinder representing the revolute joint"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color revoluteColor=Modelica.Mechanics.MultiBody.Types.
      Defaults.JointColor
    "Color of cylinder representing the revolute joint"
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
  SI.Power totalPower
    "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";
  SI.Position aux
    "Denominator used to compute force in rod connecting universal and spherical joint";
  SI.Force f_rod
    "Constraint force in direction of the rod (positive, if rod is pressed)";

  Modelica.Mechanics.MultiBody.Joints.Internal.RevoluteWithLengthConstraint revolute(
    animation=animation,
    lengthConstraint=rod1Length,
    n=n_b,
    phi_offset=phi_offset,
    phi_guess=phi_guess,
    cylinderDiameter=revoluteDiameter,
    cylinderLength=revoluteLength,
    cylinderColor=revoluteColor,
    specularCoefficient=specularCoefficient) annotation (Placement(transformation(extent={{75,-20},{35,20}})));
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
    cylinderLength=cylinderLength,
    cylinderDiameter=cylinderDiameter,
    cylinderColor=cylinderColor,
    specularCoefficient=specularCoefficient,
    kinematicConstraint=false,
    constraintResidue=rod1.f_rod - f_rod) annotation (Placement(transformation(extent={{-92,-20},{-52,20}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation rod2(
    animation=animation,
    width=rod2Diameter,
    height=rod2Diameter,
    color=rod2Color,
    specularCoefficient=specularCoefficient,
    r=rRod2_ib) annotation (Placement(transformation(extent={{15,-20},{-25,
            20}})));
  Sensors.RelativePosition relativePosition(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameAB.frame_a)
    annotation (Placement(transformation(extent={{60,-70},{40,-90}})));
  Modelica.Blocks.Sources.Constant position_b[3](k=rRod2_ib)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
equation
 // Connections.root(frame_ib.R);

  /* Compute the unknown force in the rod of the rod1 joint
     by a torque balance at the revolute joint:
       0 = revolute.frame_b.t + frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
           + cross(r_ib, -rod1.f_b_a1)
           + cross(r_ib, Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod1_ia))
     The condition is that the projection of the torque in the revolute
     joint along the axis of the revolute joint is equal to the driving
     axis torque in the flange:
       -revolute.tau = revolute.e*frame_b.t
     Therefore, we have
        tau = e*(frame_ib.t  + frame_im.t + cross(rRod2_ib, frame_im.f)
              + cross(rRod2_ib, -rod1.f_b_a1))
              + e*cross(rRod2_ib, Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod_a))
            = e*(frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
              + cross(rRod2_ib, -rod.f_b_a1))
              + rod1.f_rod*e*cross(rRod2_ib, Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     Solving this equation for f_rod results in
       f_rod = (-tau - e*(frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
               + cross(rRod2_ib, -rod1.f_b_a1)))
               / (cross(e,rRod2_ib)*Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     Additionally, a guard against division by zero is introduced

     f_rod is passed to component JointsUSR.rod1 via variable "constraintResidue" in the Advanced menu
  */
  aux = cross(revolute.e, rRod2_ib)*Frames.resolveRelative(rod1.eRod_a,
    rod1.frame_a.R, rod1.frame_b.R);
  f_rod = (-revolute.tau - revolute.e*(frame_ib.t + frame_im.t + cross(
    rRod2_ib, frame_im.f) - cross(rRod2_ib, Frames.resolveRelative(rod1.
    f_b_a1, rod1.frame_a.R, rod1.frame_b.R))))/noEvent(if abs(aux) < 1e-10 then
          1e-10 else aux);

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
      Frames.angularVelocity2(frame_im.R) + axis.tau*der(axis.phi) +
      bearing.tau*der(bearing.phi);
  else
    totalPower = 0;
  end if;

  connect(revolute.frame_b, rod2.frame_a) annotation (Line(
      points={{35,0},{15,0}},
      color={95,95,95},
      thickness=0.5));
  connect(rod2.frame_b, rod1.frame_b) annotation (Line(
      points={{-25,0},{-52,0}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_a, frame_b) annotation (Line(
      points={{75,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(rod2.frame_a, frame_ib) annotation (Line(
      points={{15,0},{26,0},{26,70},{80,70},{80,100}},
      color={95,95,95},
      thickness=0.5));
  connect(rod1.frame_a, frame_a) annotation (Line(
      points={{-92,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativePosition.frame_b, frame_a)
                                           annotation (Line(
      points={{40,-80},{-96,-80},{-96,0},{-100,0}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(relativePosition.frame_a, frame_b)
                                           annotation (Line(
      points={{60,-80},{96,-80},{96,0},{100,0}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(position_b.y, revolute.position_b) annotation (Line(
      points={{1,-40},{20,-40},{20,-12},{31,-12}}, color={0,0,127}));
  connect(rod2.frame_b, frame_im) annotation (Line(
      points={{-25,0},{-40,0},{-40,80},{0,80},{0,100}},
      color={95,95,95},
      thickness=0.5));
  connect(rod1.frame_ia, frame_ia) annotation (Line(
      points={{-80,20},{-80,100}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.axis, axis) annotation (Line(points={{55,20},{55,60},{90,
          60},{90,80},{100,80}}));
  connect(relativePosition.r_rel, revolute.position_a) annotation (Line(
      points={{50,-69},{50,-40},{90,-40},{90,-12},{79,-12}}, color={0,0,127}));
  connect(revolute.bearing, bearing) annotation (Line(
      points={{67,20},{67,40},{100,40}}));
  annotation (
    Documentation(info="<html>
<p>
This component consists of a <strong>universal</strong> joint at frame_a, a <strong>revolute</strong>
joint at frame_b and a <strong>spherical</strong> joint which is connected via <strong>rod1</strong>
to the universal and via <strong>rod2</strong> to the revolute joint, see the default
animation in the following figure (the axes vectors are not part of the
default animation):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointUSR.png\" alt=\"model Joints.Assemblies.JointUSR\">
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
<li> The position of the spherical joint with respect to the revolute
     joint is defined by vector <strong>rRod2_ib</strong>. This vector is directed from
     the inner frame of the revolute joint (frame_ib or revolute.frame_a)
     to the spherical joint and is resolved in frame_ib (note, that frame_ib
     and frame_b are parallel to each other).</li>
<li> The axis of rotation of the revolute joint is defined by axis
     vector <strong>n_b</strong>. It is fixed and resolved in frame_b.</li>
<li> When specifying this joint aggregation with the definitions above, <strong>two</strong>
     different <strong>configurations</strong> are possible. Via parameter <strong>phi_guess</strong>
     a guess value for revolute.phi(t0) at the initial time t0 is given. The configuration is selected that is closest to phi_guess (|revolute.phi - phi_guess| is minimal).</li>
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
connecting the revolute and the spherical joint at the side of the revolute
joint that is connected to this rod (= rod2.frame_a = revolute.frame_a).
</p>
<p>
An additional <strong>frame_im</strong> is present. It is <strong>fixed</strong> in the rod
connecting the revolute and the spherical joint at the side of the spherical
joint that is connected to this rod (= rod2.frame_b).
It is always parallel to <strong>frame_ib</strong>.
</p>
<p>
The easiest way to define the parameters of this joint is by moving the
MultiBody system in a <strong>reference configuration</strong> where <strong>all frames</strong>
of all components are <strong>parallel</strong> to each other (alternatively,
at least frame_a and frame_ia of the JointUSR joint
should be parallel to each other when defining an instance of this
component).
</p>
<p>
In the public interface of the JointUSR joint, the following
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
  Modelica.Mechanics.MultiBody.Joints.Assemblies.JointUSP jointUSR(rRod1_ia={1.2, 1, 0.2});
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape     shape(shapeType       = \"box\",
                                             lengthDirection = jointUSR.eRod1_ia,
                                             widthDirection  = jointUSR.e2_ia,
                                             length          = jointUSR.rod1Length/2,
                                             width           = jointUSR.rod1Length/10);
<strong>equation</strong>
  <strong>connect</strong>(jointUSP.frame_ia, shape.frame_a);
</pre></blockquote>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.2), graphics={
        Text(
          extent={{-140,-41},{140,-66}},
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
          extent={{19,6},{61,-6}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-50,5},{-21,-5}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{60,-30},{76,30}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{85,-30},{100,30}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{76,10},{85,-10}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{60,30},{76,-30}}),
        Rectangle(extent={{85,30},{100,-30}}),
        Text(
          extent={{40,109},{77,91}},
          textColor={128,128,128},
          textString="ib"),
        Text(
          extent={{-124,109},{-95,92}},
          textColor={128,128,128},
          textString="ia"),
        Line(
          points={{60,30},{60,80},{80,80},{80,100}},
          color={95,95,95},
          thickness=0.5),
        Text(
          extent={{-43,108},{-10,92}},
          textColor={128,128,128},
          textString="im"),
        Line(
          points={{19,6},{19,80},{0,80},{0,100}},
          color={95,95,95},
          thickness=0.5),
        Line(
          points={{80,80},{101,80}},
          color={128,128,128},
          thickness=0.5),
        Line(
          points={{90,30},{90,40},{95,40}},
          color={95,95,95},
          thickness=0.5)}));
end JointUSR;
