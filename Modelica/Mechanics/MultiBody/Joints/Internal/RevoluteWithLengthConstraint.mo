within Modelica.Mechanics.MultiBody.Joints.Internal;
model RevoluteWithLengthConstraint
  "Revolute joint where the rotation angle is computed from a length constraint (1 degree-of-freedom, no potential state)"

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis
    "1-dim. rotational flange that drives the joint"
    annotation (Placement(transformation(extent={{10,90},{-10,110}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b bearing
    "1-dim. rotational flange of the drive bearing"
    annotation (Placement(transformation(extent={{-50,90},{-70,110}})));

  Modelica.Blocks.Interfaces.RealInput position_a[3](each final quantity="Length", each final unit="m")
    "Position vector from frame_a to frame_a side of length constraint, resolved in frame_a of revolute joint"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput position_b[3](each final quantity="Length", each final unit="m")
    "Position vector from frame_b to frame_b side of length constraint, resolved in frame_b of revolute joint"
    annotation (Placement(transformation(extent={{140,-80},{100,-40}})));

  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter SI.Position lengthConstraint(start=1)
    "Fixed length of length constraint";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={0,0,1}
    "Axis of rotation resolved in frame_a (= same as in frame_b)"
    annotation (Evaluate=true);
  parameter Modelica.Units.NonSI.Angle_deg phi_offset=0
    "Relative angle offset (angle = phi + from_deg(phi_offset))";
  parameter Modelica.Units.NonSI.Angle_deg phi_guess=0
    "Select the configuration such that at initial time |phi - from_deg(phi_guess)| is minimal";
  parameter SI.Distance cylinderLength=world.defaultJointLength
    "Length of cylinder representing the joint axis"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth
    "Diameter of cylinder representing the joint axis"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor
    "Color of cylinder representing the joint axis"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));

  final parameter Boolean positiveBranch(fixed=false)
    "Based on phi_guess, selection of one of the two solutions of the non-linear constraint equation";
  final parameter Real e[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(n)
    "Unit vector in direction of rotation axis, resolved in frame_a";

  SI.Angle phi "Rotation angle of revolute joint";
  Frames.Orientation R_rel
    "Relative orientation object from frame_a to frame_b";
  SI.Angle angle
    "= phi + from_deg(phi_offset) (relative rotation angle between frame_a and frame_b)";
  SI.Torque tau "= axis.tau (driving torque in the axis)";

protected
  SI.Position r_a[3]=position_a
    "Position vector from frame_a to frame_a side of length constraint, resolved in frame_a of revolute joint";
  SI.Position r_b[3]=position_b
    "Position vector from frame_b to frame_b side of length constraint, resolved in frame_b of revolute joint";
  Real e_r_a "Projection of r_a on e";
  Real e_r_b "Projection of r_b on e";
  Real A "Coefficient A of equation: A*cos(phi) + B*sin(phi) + C = 0";
  Real B "Coefficient B of equation: A*cos(phi) + B*sin(phi) + C = 0";
  Real C "Coefficient C of equation: A*cos(phi) + B*sin(phi) + C = 0";
  Real k1 "Constant of quadratic equation";
  Real k2 "Constant of quadratic equation";
  Real k1a(start=1);
  Real k1b;
  Real kcos_angle "= k1*cos(angle)";
  Real ksin_angle "= k1*sin(angle)";

  Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder",
    color=cylinderColor,
    specularCoefficient=specularCoefficient,
    length=cylinderLength,
    width=cylinderDiameter,
    height=cylinderDiameter,
    lengthDirection=e,
    widthDirection={0,1,0},
    r_shape=-e*(cylinderLength/2),
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;

  function selectBranch
    "Determine branch which is closest to initial angle=0"
    extends Modelica.Icons.Function;
    input SI.Length L "Length of length constraint";
    input Real e[3](each final unit="1")
      "Unit vector along axis of rotation, resolved in frame_a (= same in frame_b)";
    input SI.Angle angle_guess
      "Select the configuration such that at initial time |angle-angle_guess| is minimal (angle=0: frame_a and frame_b coincide)";
    input SI.Position r_a[3]
      "Position vector from frame_a to frame_a side of length constraint, resolved in frame_a of revolute joint";
    input SI.Position r_b[3]
      "Position vector from frame_b to frame_b side of length constraint, resolved in frame_b of revolute joint";
    output Boolean positiveBranch "Branch of the initial solution";
  protected
    Real e_r_a "Projection of r_a on e";
    Real e_r_b "Projection of r_b on e";
    Real A "Coefficient A of equation: A*cos(phi) + B*sin(phi) + C = 0";
    Real B "Coefficient B of equation: A*cos(phi) + B*sin(phi) + C = 0";
    Real C "Coefficient C of equation: A*cos(phi) + B*sin(phi) + C = 0";
    Real k1 "Constant of quadratic equation";
    Real k2 "Constant of quadratic equation";
    Real k1a;
    Real k1b;
    Real kcos1 "k1*cos(angle1)";
    Real ksin1 "k1*sin(angle1)";
    Real kcos2 "k2*cos(angle2)";
    Real ksin2 "k2*sin(angle2)";
    SI.Angle angle1 "Solution 1 of nonlinear equation";
    SI.Angle angle2 "Solution 2 of nonlinear equation";
  algorithm
    /* The position vector r_rel from frame_a to frame_b of the length constraint
       element, resolved in frame_b of the revolute joint is given by
       (T_rel is the planar transformation matrix from frame_a to frame_b of
        the revolute joint):
          r_rel = r_b - T_rel*r_a
       The length constraint can therefore be formulated as:
          r_rel*r_rel = L*L
       with
          (r_b - T_rel*r_a)*(r_b - T_rel*r_a)
             = r_b*r_b - 2*r_b*T_rel*r_a + r_a*transpose(T_rel)*T_rel*r_a
             = r_b*r_b + r_a*r_a - 2*r_b*T_rel*r_a
       follows
          (1) 0 = r_a*r_a + r_b*r_b - 2*r_b*T_rel*r_a - L*L
       The vectors r_a, r_b and parameter L are NOT a function of
       the angle of the revolute joint. Since T_rel = T_rel(angle) is a function
       of the unknown angle of the revolute joint, this is a non-linear
       equation in this angle.
          T_rel = [e]*transpose([e]) + (identity(3) - [e]*transpose([e]))*cos(angle)
                  - skew(e)*sin(angle);
       with
          r_b*T_rel*r_a
             = r_b*(e*(e*r_a) + (r_a - e*(e*r_a))*cos(angle) - cross(e,r_a)*sin(angle)
             = (e*r_b)*(e*r_a) + (r_b*r_a - (e*r_b)*(e*r_a))*cos(angle) - r_b*cross(e,r_a)*sin(angle)
       follows for the constraint equation (1)
          (2) 0 = r_a*r_a + r_b*r_b - L*L
                  - 2*(e*r_b)*(e*r_a)
                  - 2*(r_b*r_a - (e*r_b)*(e*r_a))*cos(angle)
                  + 2*r_b*cross(e,r_a)*sin(angle)
       or
          (3) A*cos(angle) + B*sin(angle) + C = 0
       with
              A = -2*(r_b*r_a - (e*r_b)*(e*r_a))
              B = 2*r_b*cross(e,r_a)
              C = r_a*r_a + r_b*r_b - L*L - 2*(e*r_b)*(e*r_a)
       Equation (3) is solved by computing sin(angle) and cos(angle)
       independently from each other. This allows to compute
       angle in the range: -180 deg <= angle <= 180 deg
    */
    e_r_a := e*r_a;
    e_r_b := e*r_b;
    A := -2*(r_b*r_a - e_r_b*e_r_a);
    B := 2*r_b*cross(e, r_a);
    C := r_a*r_a + r_b*r_b - L*L - 2*e_r_b*e_r_a;
    k1 := A*A + B*B;
    k1a :=k1 - C*C;
    assert(k1a > 1e-10, "
Singular position of loop (either no or two analytic solutions;
the mechanism has lost one-degree-of freedom in this position).
Try first to use another Modelica.Mechanics.MultiBody.Joints.Assemblies.JointXXX component.
In most cases it is best that the joints outside of the JointXXX
component are revolute and NOT prismatic joints. If this also
lead to singular positions, it could be that this kinematic loop
cannot be solved analytically. In this case you have to build
up the loop with basic joints (NO aggregation JointXXX components)
and rely on dynamic state selection, i.e., during simulation
the states will be dynamically selected in such a way that in no
position a degree of freedom is lost.
"); k1b := max(k1a, 1.0e-12);
    k2 := sqrt(k1b);

    kcos1 := -A*C + B*k2;
    ksin1 := -B*C - A*k2;
    angle1 := Modelica.Math.atan2(ksin1, kcos1);

    kcos2 := -A*C - B*k2;
    ksin2 := -B*C + A*k2;
    angle2 := Modelica.Math.atan2(ksin2, kcos2);

    if abs(angle1 - angle_guess) <= abs(angle2 - angle_guess) then
      positiveBranch := true;
    else
      positiveBranch := false;
    end if;
  end selectBranch;
initial equation
  positiveBranch = selectBranch(lengthConstraint, e, Cv.from_deg(phi_offset
     + phi_guess), r_a, r_b);
equation
  Connections.branch(frame_a.R, frame_b.R);
  axis.tau = tau;
  axis.phi = phi;
  bearing.phi = 0;

  angle = Cv.from_deg(phi_offset) + phi;

  // transform kinematic quantities from frame_a to frame_b
  frame_b.r_0 = frame_a.r_0;

  R_rel = Frames.planarRotation(e, angle, der(angle));
  frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);

  // Force and torque balance
  zeros(3) = frame_a.f + Frames.resolve1(R_rel, frame_b.f);
  zeros(3) = frame_a.t + Frames.resolve1(R_rel, frame_b.t);

  // Compute rotation angle (details, see function "selectBranch")
  e_r_a = e*r_a;
  e_r_b = e*r_b;
  A = -2*(r_b*r_a - e_r_b*e_r_a);
  B = 2*r_b*cross(e, r_a);
  C = r_a*r_a + r_b*r_b - lengthConstraint*lengthConstraint - 2*e_r_b*e_r_a;
  k1 = A*A + B*B;
  k1a = k1 - C*C;

  assert(k1a > 1e-10, "
Singular position of loop (either no or two analytic solutions;
the mechanism has lost one-degree-of freedom in this position).
Try first to use another Modelica.Mechanics.MultiBody.Joints.Assemblies.JointXXX component.
In most cases it is best that the joints outside of the JointXXX
component are revolute and NOT prismatic joints. If this also
lead to singular positions, it could be that this kinematic loop
cannot be solved analytically. In this case you have to build
up the loop with basic joints (NO aggregation JointXXX components)
and rely on dynamic state selection, i.e., during simulation
the states will be dynamically selected in such a way that in no
position a degree of freedom is lost.
");

  k1b = Frames.Internal.maxWithoutEvent(k1a, 1.0e-12);
  k2 = sqrt(k1b);
  kcos_angle = -A*C + (if positiveBranch then B else -B)*k2;
  ksin_angle = -B*C + (if positiveBranch then -A else A)*k2;

  angle = Modelica.Math.atan2(ksin_angle, kcos_angle);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-30,10},{10,-10}},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-60},{-30,60}},
          lineColor={64,64,64},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255},
          radius=10),
        Rectangle(
          extent={{30,-60},{100,60}},
          lineColor={64,64,64},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255},
          radius=10),
        Text(
          extent={{-139,-168},{137,-111}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(extent={{-100,60},{-30,-60}}, lineColor={64,64,64}, radius=10),
        Rectangle(extent={{30,60},{100,-60}}, lineColor={64,64,64}, radius=10),
        Text(
          extent={{-142,-108},{147,-69}},
          textString="n=%n"),
        Line(points={{-60,60},{-60,90}}),
        Line(points={{-20,70},{-60,70}}),
        Line(points={{-20,80},{-20,60}}),
        Line(points={{20,80},{20,60}}),
        Line(points={{20,70},{41,70}}),
        Polygon(
          points={{-9,30},{10,30},{30,50},{-29,50},{-9,30}},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{10,30},{30,50},{30,-51},{10,-31},{10,30}},
          lineColor={64,64,64},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,90},{10,50}},
          lineColor={64,64,64},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={192,192,192})}),
    Documentation(info="<html>
<p>
Joint where frame_b rotates around axis n which is fixed in frame_a.
The two frames coincide when \"phi + phi_offset = 0\", where
\"phi_offset\" is a parameter with a zero default
and \"phi\" is the rotation angle.
</p>
<p>
This variant of the revolute joint is designed to work together
with a length constraint in a kinematic loop. This means that the
angle of the revolute joint, phi, is computed such that the
length constraint is fulfilled.
</p>
<p>
<strong>Usually, this joint should not be used by a user of the MultiBody
library. It is only provided to built-up the Modelica.Mechanics.MultiBody.Joints.Assemblies.JointXYZ
joints.</strong>
</p>

<p>
In releases before version 3.0 of the Modelica Standard Library, it was possible
to activate the torque projection equation (= cut-torque projected to the rotation
axis must be identical to the drive torque of flange axis) via parameter
<strong>axisTorqueBalance</strong>. This is no longer possible, since otherwise this
model would not be \"balanced\" (= same number of unknowns as equations).
Instead, when using this model in version 3.0 and later versions,
the force in the length constraint component (Joints.SphericalSpherical or
Joints.UniversalSpherical) must be calculated such that the driving torque
in direction of the rotation
axis is (RC shall be the name of the instance of RevoluteWithLengthConstraint):
</p>
<blockquote><pre>
0 = RC.axis.tau + RC.e*RC.frame_b.t;
</pre></blockquote>
<p>
If this equation is used, usually the force in the length constraint
and the second derivative of the revolute angle will be part of a linear
algebraic system of equations. In some cases it is possible to solve
this system of equations locally, i.e., provide the rod force directly
as function of the revolute constraint torque. In any case, this projection
equation or an equivalent one has to be provided via variable \"constraintResidue\" in the \"Advanced\"
menu of \"Joints.SphericalSpherical\" or \"Joints.UniversalSpherical\".
</p>

</html>"));
end RevoluteWithLengthConstraint;
