within Modelica.Mechanics.MultiBody.Joints;
model SphericalSpherical
  "Spherical - spherical joint aggregation (1 constraint, no potential states) with an optional point mass in the middle"

  import Modelica.Mechanics.MultiBody.Types;
  extends Interfaces.PartialTwoFrames;

  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter Boolean showMass=true
    "= true, if mass shall be shown (provided animation = true and m > 0)";
  parameter Boolean computeRodLength=false
    "= true, if rodLength shall be computed during initialization (see info)";
  parameter SI.Length rodLength(
    min=Modelica.Constants.eps,
    fixed=not computeRodLength, start = 1)
    "Distance between the origins of frame_a and frame_b (if computeRodLength=true, guess value)";
  parameter SI.Mass m(min=0)=0
    "Mass of rod (= point mass located in middle of rod)";
  parameter SI.Diameter sphereDiameter=world.defaultJointLength
    "Diameter of spheres representing the spherical joints"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor
    "Color of spheres representing the spherical joints"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Diameter rodDiameter=sphereDiameter/Types.Defaults.JointRodDiameterFraction
    "Diameter of rod connecting the two spherical joint"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color rodColor=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor
    "Color of rod connecting the two spherical joints"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Diameter massDiameter=sphereDiameter
    "Diameter of sphere representing the mass point"
    annotation (Dialog(tab=
          "Animation", group="if animation = true and showMass = true and m > 0",
          enable=animation and showMass and m > 0));
  input Types.Color massColor=Modelica.Mechanics.MultiBody.Types.Defaults.BodyColor
    "Color of sphere representing the mass point" annotation (
      Dialog(colorSelector=true, tab="Animation", group=
          "if animation = true and showMass = true and m > 0",
          enable=animation and showMass and m > 0));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));

  parameter Boolean kinematicConstraint=true
    "= false, if no constraint shall be defined, due to analytically solving a kinematic loop (\"false\" should not be used by user, but only by MultiBody.Joints.Assemblies joints)"
    annotation (Dialog(tab="Advanced"));
  Real constraintResidue = rRod_0*rRod_0 - rodLength*rodLength
    "Constraint equation of joint in residue form: Either length constraint (= default) or equation to compute rod force (for analytic solution of loops in combination with Internal.RevoluteWithLengthConstraint/PrismaticWithLengthConstraint)"
    annotation (Dialog(tab="Advanced", enable=not kinematicConstraint));
  parameter Boolean checkTotalPower=false
    "= true, if total power flowing into this component shall be determined (must be zero)"
    annotation (Dialog(tab="Advanced"));

  SI.Force f_rod
    "Constraint force in direction of the rod (positive on frame_a, when directed from frame_a to frame_b)";
  SI.Position rRod_0[3]
    "Position vector from frame_a to frame_b resolved in world frame";
  SI.Position rRod_a[3]
    "Position vector from frame_a to frame_b resolved in frame_a";
  Real eRod_a[3](each final unit="1")
    "Unit vector in direction from frame_a to frame_b, resolved in frame_a";
  SI.Position r_CM_0[3]
    "Dummy if m==0, or position vector from world frame to mid-point of rod, resolved in world frame";
  SI.Velocity v_CM_0[3] "First derivative of r_CM_0";
  SI.Force f_CM_a[3]
    "Dummy if m==0, or inertial force acting at mid-point of rod due to mass point acceleration, resolved in frame_a";
  SI.Force f_CM_e[3]
    "Dummy if m==0, or projection of f_CM_a onto eRod_a, resolved in frame_a";
  SI.Force f_b_a1[3]
    "Force acting at frame_b, but without force in rod, resolved in frame_a";
  SI.Power totalPower
    "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";

protected
  Visualizers.Advanced.Shape shape_rod(
    shapeType="cylinder",
    color=rodColor,
    specularCoefficient=specularCoefficient,
    length=rodLength,
    width=rodDiameter,
    height=rodDiameter,
    lengthDirection=eRod_a,
    widthDirection={0,1,0},
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_a(
    shapeType="sphere",
    color=sphereColor,
    specularCoefficient=specularCoefficient,
    length=sphereDiameter,
    width=sphereDiameter,
    height=sphereDiameter,
    lengthDirection=eRod_a,
    widthDirection={0,1,0},
    r_shape=-eRod_a*(sphereDiameter/2),
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_b(
    shapeType="sphere",
    color=sphereColor,
    specularCoefficient=specularCoefficient,
    length=sphereDiameter,
    width=sphereDiameter,
    height=sphereDiameter,
    lengthDirection=eRod_a,
    widthDirection={0,1,0},
    r_shape=eRod_a*(rodLength - sphereDiameter/2),
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape shape_mass(
    shapeType="sphere",
    color=massColor,
    specularCoefficient=specularCoefficient,
    length=massDiameter,
    width=massDiameter,
    height=massDiameter,
    lengthDirection=eRod_a,
    widthDirection={0,1,0},
    r_shape=eRod_a*(rodLength/2 - sphereDiameter/2),
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation and showMass and m > 0;
equation
  // Determine relative position vector between the two frames
  if kinematicConstraint then
    rRod_0 = transpose(frame_b.R.T)*(frame_b.R.T*frame_b.r_0) - transpose(
      frame_a.R.T)*(frame_a.R.T*frame_a.r_0);
  else
    rRod_0 = frame_b.r_0 - frame_a.r_0;
  end if;

  //rRod_0 = frame_b.r_0 - frame_a.r_0;
  rRod_a = Frames.resolve2(frame_a.R, rRod_0);
  eRod_a = rRod_a/rodLength;

  // Constraint equation
  constraintResidue = 0;

  // Cut-torques at frame_a and frame_b
  frame_a.t = zeros(3);
  frame_b.t = zeros(3);

  /* Force and torque balance of rod
     - Kinematics for center of mass CM of mass point
       r_CM_0 = frame_a.r_0 + rRod_0/2;
       v_CM_0 = der(r_CM_0);
       a_CM_a = resolve2(frame_a.R, der(v_CM_0) - world.gravityAcceleration(r_CM_0));
     - Inertial and gravity force in direction (f_CM_e) and orthogonal (f_CM_n) to rod
       f_CM_a = m*a_CM_a
       f_CM_e = f_CM_a*eRod_a;           // in direction of rod
       f_CM_n = rodLength(f_CM_a - f_CM_e);  // orthogonal to rod
     - Force balance in direction of rod
       f_CM_e = fa_rod_e + fb_rod_e;
     - Force balance orthogonal to rod
       f_CM_n = fa_rod_n + fb_rod_n;
     - Torque balance with respect to frame_a
       0 = (-f_CM_n)*rodLength/2 + fb_rod_n*rodLength
     The result is:
     fb_rod_n = f_CM_n/2;
     fa_rod_n = fb_rod_n;
     fb_rod_e = f_CM_e - fa_rod_e;
     fa_rod_e is the unknown computed from loop
  */

    // f_b_a1 is needed in aggregation joints to solve kinematic loops analytically
  if m > 0 then
    r_CM_0 = frame_a.r_0 + rRod_0/2;
    v_CM_0 = der(r_CM_0);
    f_CM_a = m*Frames.resolve2(frame_a.R, der(v_CM_0) -
      world.gravityAcceleration(r_CM_0));
    f_CM_e = (f_CM_a*eRod_a)*eRod_a;
    frame_a.f = (f_CM_a - f_CM_e)/2 + f_rod*eRod_a;
    f_b_a1 = (f_CM_a + f_CM_e)/2;
    frame_b.f = Frames.resolveRelative(f_b_a1 - f_rod*eRod_a, frame_a.R,
      frame_b.R);
  else
    r_CM_0 = zeros(3);
    v_CM_0 = zeros(3);
    f_CM_a = zeros(3);
    f_CM_e = zeros(3);
    f_b_a1 = zeros(3);
    frame_a.f = f_rod*eRod_a;
    frame_b.f = -Frames.resolveRelative(frame_a.f, frame_a.R, frame_b.R);
  end if;

  if checkTotalPower then
    totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) +
      frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + (-m)*(der(
      v_CM_0) - world.gravityAcceleration(r_CM_0))*v_CM_0 + frame_a.t*
      Frames.angularVelocity2(frame_a.R) + frame_b.t*Frames.angularVelocity2(
      frame_b.R);
  else
    totalPower = 0;
  end if;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-95,-40},{-15,40}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Ellipse(
          extent={{-84,-30},{-24,30}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{15,-40},{95,40}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Ellipse(
          extent={{25,-29},{85,30}},
          lineColor={128,128,128},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,90},{150,50}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{-40,40},{41,-41}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-51,6},{48,-4}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Ellipse(
          extent={{-68,15},{-39,-13}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Ellipse(
          extent={{39,14},{68,-14}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Text(
          extent={{-150,-60},{150,-90}},
          textString="%rodLength")}),
    Documentation(info="<html>
<p>
Joint that has a spherical joint on each of its two ends.
The rod connecting the two spherical joints is approximated by a
point mass that is located in the middle of the rod. When the mass
is set to zero (default), special code for a massless body is generated.
In the following default animation figure, the two spherical joints are
represented by two red spheres, the connecting rod by a grey cylinder
and the point mass in the middle of the rod by a light blue sphere:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/SphericalSpherical.png\" alt=\"model Joints.SphericalSpherical\">
</div>

<p>
This joint introduces <strong>one constraint</strong> defining that the distance between
the origin of frame_a and the origin of frame_b is constant (= rodLength).
It is highly recommended to use this joint in loops
whenever possible, because this enhances the efficiency
considerably due to smaller systems of non-linear algebraic
equations.
</p>
<p>
It is sometimes desirable to <strong>compute</strong> the <strong>rodLength</strong>
of the connecting rod during initialization. For this, parameter
<strong>computeLength</strong> has to be set to <strong>true</strong> and instead <strong>one</strong> other,
easier to determine, position variable in the same loop
needs to have a fixed attribute of <strong>true</strong>. For example,
if a loop consists of one Revolute joint, one Prismatic joint and
a SphericalSpherical joint, one may fix the start values of the revolute
joint angle and of the relative distance of the prismatic joint
in order to compute the rodLength of the rod.
</p>
<p>
It is not possible to connect other components, such as a body with mass
properties or a special visual shape object to the rod connecting
the two spherical joints. If this is needed, use instead joint Joints.<strong>UniversalSpherical</strong>
that has this property.
</p>
</html>"));
end SphericalSpherical;
