within Modelica.Mechanics.MultiBody.Joints.Assemblies;
model JointSSR
  "Spherical - spherical - revolute joint aggregation with mass (no constraints, no potential states)"

  import Modelica.Mechanics.MultiBody.Types;

  extends Interfaces.PartialTwoFramesDoubleSize;
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_ib
    "Coordinate system at origin of frame_b fixed at connecting rod of spherical and revolute joint"
    annotation (Placement(transformation(
        origin={80,100},
        extent={{-8,8},{8,-8}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Interfaces.Frame_b frame_im
    "Coordinate system at origin of spherical joint in the middle fixed at connecting rod of spherical and revolute joint"
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
  parameter Boolean showMass=true
    "= true, if point mass on rod 1 shall be shown (provided animation = true and rod1Mass > 0)";
  parameter SI.Length rod1Length(min=Modelica.Constants.eps, start = 1)
    "Distance between the origins of the two spherical joints";
  parameter SI.Mass rod1Mass(min=0)=0
    "Mass of rod 1 (= point mass located in middle of rod connecting the two spherical joints)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_b={0,0,1}
    "Axis of revolute joint fixed and resolved in frame_b";
  parameter SI.Position rRod2_ib[3]={1,0,0}
    "Vector from origin of frame_ib to spherical joint in the middle, resolved in frame_ib";
  parameter Modelica.Units.NonSI.Angle_deg phi_offset=0
    "Relative angle offset of revolute joint (angle = phi(t) + from_deg(phi_offset))";
  parameter Modelica.Units.NonSI.Angle_deg phi_guess=0
    "Select the configuration such that at initial time |phi(t0) - from_deg(phi_guess)| is minimal";
  parameter SI.Diameter sphereDiameter=world.defaultJointLength
    "Diameter of the spheres representing the two spherical joints"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.
       JointColor
    "Color of the spheres representing the two spherical joints"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Diameter rod1Diameter=sphereDiameter/Types.Defaults.
      JointRodDiameterFraction
    "Diameter of rod 1 connecting the two spherical joints"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color rod1Color=Modelica.Mechanics.MultiBody.Types.Defaults.
      RodColor "Color of rod 1 connecting the two spherical joint"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Diameter rod2Diameter=rod1Diameter
    "Diameter of rod 2 connecting the revolute joint and spherical joint 2"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color rod2Color=rod1Color
    "Color of rod 2 connecting the revolute joint and spherical joint 2"
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
  parameter Boolean checkTotalPower=false
    "= true, if total power flowing into this component shall be determined (must be zero)"
    annotation (Dialog(tab="Advanced"));
  SI.Position aux
    "Denominator used to compute force in rod connecting universal and spherical joint";
  SI.Force f_rod
    "Constraint force in direction of the rod (positive, if rod is pressed)";
  SI.Power totalPower
    "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";

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
  Modelica.Mechanics.MultiBody.Joints.SphericalSpherical rod1(
    animation=animation,
    showMass=showMass,
    m=rod1Mass,
    rodLength=rod1Length,
    rodDiameter=rod1Diameter,
    sphereDiameter=sphereDiameter,
    rodColor=rod1Color,
    specularCoefficient=specularCoefficient,
    kinematicConstraint=false,
    sphereColor=sphereColor,
    constraintResidue=rod1.f_rod - f_rod) annotation (Placement(transformation(extent={{-89,-20},{-49,20}})));
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
  /* Compute the unknown force in the rod of the rod1 joint
     by a torque balance at the revolute joint:
       0 = frame_b.t + frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
           + cross(rRod2_ib, -rod1.f_b_a1)
           + cross(rRod2_ib, Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod_a))
     The condition is that the projection of the torque in the revolute
     joint along the axis of the revolute joint is equal to the driving
     axis torque in the flange:
       -revolute.tau = revolute.e*frame_b.t
     Therefore, we have with e=revolute.e and tau=revolute.tau
        tau = e*(frame_ib.t  + frame_im.t + cross(rRod2_ib, frame_im.f)
              + cross(rRod2_ib, -rod1.f_b_a1))
              + e*cross(rRod2_ib, Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod_a))
            = e*(frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
              + cross(rRod2_ib, -rod.f_b_a1))
              + rod1.f_rod*e*cross(rRod2_ib, Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     Solving this equation for f_rod results in
       rod1.f_rod = (tau - e*(frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
                   + cross(rRod2_ib, -rod1.f_b_a1)))
                   / (cross(e,rRod2_ib)*Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     Additionally, a guard against division by zero is introduced
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
      frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + frame_ib.f*
      Frames.resolve2(frame_ib.R, der(frame_ib.r_0)) + frame_im.f*
      Frames.resolve2(frame_im.R, der(frame_im.r_0)) + frame_a.t*
      Frames.angularVelocity2(frame_a.R) + frame_b.t*
      Frames.angularVelocity2(frame_b.R) + frame_ib.t*
      Frames.angularVelocity2(frame_ib.R) + frame_im.t*
      Frames.angularVelocity2(frame_im.R) + axis.tau*der(axis.phi) +
      bearing.tau*der(bearing.phi) + (-rod1Mass)*(der(rod1.v_CM_0) -
      world.gravityAcceleration(rod1.r_CM_0))*rod1.v_CM_0;
  else
    totalPower = 0;
  end if;

  connect(revolute.frame_b, rod2.frame_a) annotation (Line(
      points={{35,0},{15,0}},
      color={95,95,95},
      thickness=0.5));
  connect(rod2.frame_b, rod1.frame_b) annotation (Line(
      points={{-25,0},{-49,0}},
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
      points={{-89,0},{-100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(relativePosition.frame_b, frame_a)
                                           annotation (Line(
      points={{40,-80},{-95,-80},{-95,0},{-100,0}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(relativePosition.frame_a, frame_b)
                                           annotation (Line(
      points={{60,-80},{96,-80},{96,0},{100,0}},
      color={95,95,95},
      pattern=LinePattern.Dot));
  connect(position_b.y, revolute.position_b) annotation (Line(
      points={{1,-40},{20,-40},{20,-12},{31,-12}}, color={0,0,127}));
  connect(revolute.axis, axis) annotation (Line(points={{55,20},{55,60},{90,
          60},{90,80},{100,80}}));
  connect(rod2.frame_b, frame_im) annotation (Line(
      points={{-25,0},{-35,0},{-35,60},{0,60},{0,100}},
      color={95,95,95},
      thickness=0.5));
  connect(relativePosition.r_rel, revolute.position_a)
                                                     annotation (Line(
      points={{50,-69},{50,-50},{90,-50},{90,-12},{79,-12}}, color={0,0,127}));
  connect(revolute.bearing, bearing) annotation (Line(
      points={{67,20},{67,40},{100,40}}));
  annotation (
    Documentation(info="<html>
<p>
This component consists of a <strong>spherical</strong> joint 1 at frame_a, a <strong>revolute</strong>
joint at frame_b and a <strong>spherical</strong> joint 2 which is connected via rod 1
to the spherical joint 1 and via rod 2 to the revolute joint, see the default
animation in the following figure (the axes vectors are not part of the
default animation):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Assemblies/JointSSR.png\" alt=\"model Joints.Assemblies.JointSSR\">
</div>

<p>
Besides an optional point mass in the middle of rod 1,
this joint aggregation has no mass and no inertia,
and introduces neither constraints nor potential state variables.
It should be used in kinematic loops whenever possible since
the non-linear system of equations introduced by this joint aggregation
is solved <strong>analytically</strong> (i.e., a solution is always computed, if a
unique solution exists).
</p>
<p>
An additional <strong>frame_ib</strong> is present. It is <strong>fixed</strong> in rod 2
connecting the revolute and the spherical joint at the side of the revolute
joint that is connected to this rod (= rod2.frame_a = revolute.frame_a).
</p>
<p>
An additional <strong>frame_im</strong> is present. It is <strong>fixed</strong> in rod 2
connecting the revolute and the spherical joint at the side of spherical
joint 2 that is connected to this rod (= rod2.frame_b).
It is always parallel to <strong>frame_ib</strong>.
</p>
<p>
The easiest way to define the parameters of this joint is by moving the
MultiBody system in a <strong>reference configuration</strong> where <strong>all frames</strong>
of all components are <strong>parallel</strong> to each other (alternatively,
at least frame_b and frame_ib of the JointSSR joint
should be parallel to each other when defining an instance of this
component).
</p>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.2), graphics={
        Text(
          extent={{-141,-41},{139,-66}},
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
          extent={{-63,33},{-39,-33}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
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
          extent={{-44,31},{-19,-30}},
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
          extent={{88,112},{127,92}},
          textColor={128,128,128},
          textString="ib"),
        Ellipse(
          extent={{-80,11},{-60,-9}},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-62,6},{-21,-5}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Line(
          points={{80,80},{100,80}},
          color={95,95,95},
          thickness=0.5),
        Line(
          points={{19,6},{19,80},{0,80},{0,100}},
          color={95,95,95},
          thickness=0.5),
        Text(
          extent={{-47,111},{-8,92}},
          textColor={128,128,128},
          textString="im"),
        Line(
          points={{68,30},{68,80},{80,80},{80,98}},
          color={95,95,95},
          thickness=0.5),
        Line(
          points={{90,30},{90,40},{95,40}},
          color={95,95,95},
          thickness=0.5)}));
end JointSSR;
