within Modelica.Mechanics.MultiBody.Joints.Internal;
model PrismaticWithLengthConstraint
  "Prismatic joint where the translational distance is computed from a length constraint (1 degree-of-freedom, no potential state)"

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  Modelica.Mechanics.Translational.Interfaces.Flange_a axis
    "1-dim. translational flange that drives the joint"
    annotation (Placement(transformation(extent={{70,80},{90,60}})));
  Modelica.Mechanics.Translational.Interfaces.Flange_b bearing
    "1-dim. translational flange of the drive bearing"
    annotation (Placement(transformation(extent={{-30,80},{-50,60}})));
  Modelica.Blocks.Interfaces.RealInput position_a[3](each final quantity="Length", each final unit="m")
    "Position vector from frame_a to frame_a side of length constraint, resolved in frame_a of prismatic joint"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput position_b[3](each final quantity="Length", each final unit="m")
    "Position vector from frame_b to frame_b side of length constraint, resolved in frame_b of prismatic joint"
    annotation (Placement(transformation(extent={{140,-80},{100,-40}})));

  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter SI.Position length(start=1) "Fixed length of length constraint";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={1,0,0}
    "Axis of translation resolved in frame_a (= same as in frame_b)"
    annotation (Evaluate=true);
  parameter SI.Position s_offset=0
    "Relative distance offset (distance between frame_a and frame_b = s(t) + s_offset)";
  parameter SI.Position s_guess=0
    "Select the configuration such that at initial time |s(t0)-s_guess| is minimal";
  parameter Types.Axis boxWidthDirection={0,1,0}
    "Vector in width direction of box, resolved in frame_a"
    annotation (Evaluate=true, Dialog(tab="Animation", group=
          "if animation = true", enable=animation));
  parameter SI.Distance boxWidth=world.defaultJointWidth
    "Width of prismatic joint box"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Distance boxHeight=boxWidth "Height of prismatic joint box"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color boxColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor
    "Color of prismatic joint box"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));

  final parameter Boolean positiveBranch(fixed=false)
    "Selection of one of the two solutions of the non-linear constraint equation";
  final parameter Real e[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(n)
    "Unit vector in direction of translation axis, resolved in frame_a";
  SI.Position s
    "Relative distance between frame_a and frame_b along axis n = s + s_offset)";
  SI.Position distance
    "Relative distance between frame_a and frame_b along axis n";
  SI.Position r_rel_a[3]
    "Position vector from frame_a to frame_b resolved in frame_a";
  SI.Force f "= axis.f (driving force in the axis)";

protected
  SI.Position r_a[3]=position_a
    "Position vector from frame_a to frame_a side of length constraint, resolved in frame_a of prismatic joint";
  SI.Position r_b[3]=position_b
    "Position vector from frame_b to frame_b side of length constraint, resolved in frame_b of prismatic joint";
  SI.Position rbra[3] "= rb - ra";
  Real B "Coefficient B of equation: s*s + B*s + C = 0";
  Real C "Coefficient C of equation: s*s + B*s + C = 0";
  Real k1 "Constant of quadratic equation solution";
  Real k2 "Constant of quadratic equation solution";
  Real k1a(start=1);
  Real k1b;

  Visualizers.Advanced.Shape box(
    shapeType="box",
    color=boxColor,
    specularCoefficient=specularCoefficient,
    length=if noEvent(abs(s + s_offset) > 1.e-6) then s + s_offset else 1.e-6,
    width=boxWidth,
    height=boxHeight,
    lengthDirection=e,
    widthDirection=boxWidthDirection,
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation;

  function selectBranch
    "Determine branch which is closest to initial angle=0"
    extends Modelica.Icons.Function;
    input SI.Length L "Length of length constraint";
    input Real e[3](each final unit="1")
      "Unit vector along axis of translation, resolved in frame_a (= same in frame_b)";
    input SI.Position d_guess
      "Select the configuration such that at initial time |d-d_guess| is minimal (d: distance between origin of frame_a and origin of frame_b)";
    input SI.Position r_a[3]
      "Position vector from frame_a to frame_a side of length constraint, resolved in frame_a of prismatic joint";
    input SI.Position r_b[3]
      "Position vector from frame_b to frame_b side of length constraint, resolved in frame_b of prismatic joint";
    output Boolean positiveBranch "Branch of the initial solution";
  protected
    SI.Position rbra[3] "= rb - ra";
    Real B "Coefficient B of equation: d*d + B*d + C = 0";
    Real C "Coefficient C of equation: d*d + B*d + C = 0";
    Real k1 "Constant of quadratic equation solution";
    Real k2 "Constant of quadratic equation solution";
    Real k1a;
    Real k1b;
    Real d1 "Solution 1 of quadratic equation";
    Real d2 "Solution 2 of quadratic equation";
  algorithm
    /* The position vector r_rel from frame_a to frame_b of the length constraint
       element, resolved in frame_b of the prismatic joint (frame_a and frame_b
       of the prismatic joint are parallel to each other) is given by:
          r_rel = d*e + r_b - r_a
       The length constraint can therefore be formulated as:
          r_rel*r_rel = L*L
       with
          (d*e + r_b - r_a)*(d*e + r_b - r_a)
                   = d*d + 2*d*e*(r_b - r_a) + (r_b - r_a)*(r_b - r_a)
       follows
          (1)  0 = d*d + d*2*e*(r_b - r_a) + (r_b - r_a)*(r_b - r_a) - L*L
       The vectors r_a, r_b and parameter L are NOT a function of
       the distance d of the prismatic joint. Therefore, (1) is a quadratic
       equation in the single unknown "d":
          (2) d*d + B*d + C = 0
              with   B = 2*e*(r_b - r_a)
                     C = (r_b - r_a)*(r_b - r_a) - L*L
       The solution is
          (3) d = - B/2 +/- sqrt(B*B/4 - C)
    */
    rbra := r_b - r_a;
    B := 2*(e*rbra);
    C := rbra*rbra - L*L;
    k1 := B/2;
    k1a :=k1*k1 - C;
  assert(noEvent(k1a > 1e-10), "
Singular position of loop (either no or two analytic solutions;
the mechanism has lost one-degree-of freedom in this position).
Try first to use another Modelica.Mechanics.MultiBody.Joints.Assemblies.JointXXX component.
If this also lead to singular positions, it could be that this
kinematic loop cannot be solved analytically with a fixed state
selection. In this case you have to build up the loop with
basic joints (NO aggregation JointXXX components) and rely on
dynamic state selection, i.e., during simulation the states will
be dynamically selected in such a way that in no position a
degree of freedom is lost.
"); k1b :=max(k1a, 1.0e-12);
    k2 :=sqrt(k1b);
    d1 := -k1 + k2;
    d2 := -k1 - k2;
    if abs(d1 - d_guess) <= abs(d2 - d_guess) then
      positiveBranch := true;
    else
      positiveBranch := false;
    end if;
  end selectBranch;
initial equation
  positiveBranch = selectBranch(length, e, s_offset + s_guess, r_a, r_b);
equation
  Connections.branch(frame_a.R, frame_b.R);

  axis.f = f;
  axis.s = s;
  bearing.s = 0;
  distance = s_offset + s;

  // relationships of frame_a and frame_b quantities
  r_rel_a = e*distance;
  frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, r_rel_a);
  frame_b.R = frame_a.R;
  zeros(3) = frame_a.f + frame_b.f;
  zeros(3) = frame_a.t + frame_b.t + cross(r_rel_a, frame_b.f);

  // Compute translational distance (details, see function "selectBranch")
  rbra = r_b - r_a;
  B = 2*(e*rbra);
  C = rbra*rbra - length*length;
  k1 = B/2;
  k1a = k1*k1 - C;
  assert(noEvent(k1a > 1e-10), "
Singular position of loop (either no or two analytic solutions;
the mechanism has lost one-degree-of freedom in this position).
Try first to use another Modelica.Mechanics.MultiBody.Joints.Assemblies.JointXXX component.
If this also lead to singular positions, it could be that this
kinematic loop cannot be solved analytically with a fixed state
selection. In this case you have to build up the loop with
basic joints (NO aggregation JointXXX components) and rely on
dynamic state selection, i.e., during simulation the states will
be dynamically selected in such a way that in no position a
degree of freedom is lost.
");
  k1b = Frames.Internal.maxWithoutEvent(k1a, 1.0e-12);
  k2 = sqrt(k1b);
  distance = -k1 + (if positiveBranch then k2 else -k2);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-30,-40},{100,30}},
          pattern=LinePattern.None,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Rectangle(extent={{-30,40},{100,-40}}),
        Rectangle(
          extent={{-100,-60},{-30,50}},
          pattern=LinePattern.None,
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Rectangle(
          extent={{-100,50},{-30,60}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Rectangle(
          extent={{-30,30},{100,40}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Text(
          extent={{-136,-170},{140,-113}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(extent={{-100,60},{-30,-60}}),
        Line(points={{100,-40},{100,-60}}, color={0,0,255}),
        Rectangle(
          extent={{100,40},{90,80}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-136,-116},{153,-77}},
          textString="n=%n")}),
    Documentation(info="<html>
<p>
Joint where frame_b is translated along axis n which is fixed in frame_a.
The two frames coincide when \"s + s_offset = 0\", where
\"s_offset\" is a parameter with a zero default
and \"s\" is the relative distance.
</p>
<p>
This variant of the prismatic joint is designed to work together
with a length constraint in a kinematic loop. This means that the
relative distance \"s\" of the joint is computed such that the
length constraint is fulfilled.
</p>
<p>
<strong>Usually, this joint should not be used by a user of the MultiBody
library. It is only provided to built-up the Modelica.Mechanics.MultiBody.Joints.Assemblies.JointXYZ
joints.</strong>
</p>

<p>
In releases before version 3.0 of the Modelica Standard Library, it was possible
to activate the force projection equation (= cut-force projected to the translation
axis must be identical to the driving force of flange axis) via parameter
<strong>axisForceBalance</strong>. This is no longer possible, since otherwise this
model would not be \"balanced\" (= same number of unknowns as equations).
Instead, when using this model in version 3.0 and later versions,
the force in the length constraint component (Joints.SphericalSpherical or
Joints.UniversalSpherical) must be calculated such that the driving force
in direction of the translation
axis is (RC shall be the name of the instance of PrismaticWithLengthConstraint):
</p>
<blockquote><pre>
0 = RC.axis.f + RC.e*RC.frame_b.f;
</pre></blockquote>
<p>
If this equation is used, usually the force in the length constraint
and the second derivative of the prismatic distance will be part of a linear
algebraic system of equations. In some cases it is possible to solve
this system of equations locally, i.e., provide the rod force directly
as function of the prismatic constraint force. In any case, this projection
equation or an equivalent one has to be provided via variable \"constraintResidue\" in the \"Advanced\"
menu of \"Joints.SphericalSpherical\" or \"Joints.UniversalSpherical\".
</p>

</html>"));
end PrismaticWithLengthConstraint;
