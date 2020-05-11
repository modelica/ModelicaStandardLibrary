within Modelica.Mechanics.MultiBody.Joints;
model UniversalSpherical
  "Universal - spherical joint aggregation (1 constraint, no potential states)"

  import Modelica.Mechanics.MultiBody.Types;

  extends Interfaces.PartialTwoFrames;
  Interfaces.Frame_a frame_ia
    "Coordinate system at the origin of frame_a, fixed at the rod connecting the universal with the spherical joint"
    annotation (Placement(transformation(
        origin={-40,100},
        extent={{-16,-16},{16,16}},
        rotation=270)));
  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter Boolean showUniversalAxes=true
    "= true, if universal joint shall be visualized with two cylinders, otherwise with a sphere (provided animation=true)";
  parameter Boolean computeRodLength=false
    "= true, if distance between frame_a and frame_b shall be computed during initialization (see info)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n1_a={0,0,1}
    "Axis 1 of universal joint resolved in frame_a (axis 2 is orthogonal to axis 1 and to rod)"
    annotation (Evaluate=true);
  parameter SI.Position rRod_ia[3]={1,0,0}
    "Vector from origin of frame_a to origin of frame_b, resolved in frame_ia (if computeRodLength=true, rRod_ia is only an axis vector along the connecting rod)"
    annotation (Evaluate=true);
  parameter SI.Diameter sphereDiameter=world.defaultJointLength
    "Diameter of spheres representing the universal and the spherical joint"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color sphereColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor
    "Color of spheres representing the universal and the spherical joint"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  parameter Types.ShapeType rodShapeType="cylinder"
    "Shape type of rod connecting the universal and the spherical joint"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Distance rodWidth=sphereDiameter/Types.Defaults.JointRodDiameterFraction
    "Width of rod shape in direction of axis 2 of universal joint."
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Distance rodHeight=rodWidth
    "Height of rod shape in direction that is orthogonal to rod and to axis 2"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter Types.ShapeExtra rodExtra=0.0
    "Additional parameter depending on rodShapeType"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color rodColor=Modelica.Mechanics.MultiBody.Types.Defaults.RodColor
    "Color of rod shape connecting the universal and the spherical joints"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
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
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));

  parameter Boolean kinematicConstraint=true
    "= false, if no constraint shall be defined, due to analytically solving a kinematic loop"
    annotation (Dialog(tab="Advanced"));
  Real constraintResidue = rRod_0*rRod_0 - rodLength*rodLength
    "Constraint equation of joint in residue form: Either length constraint (= default) or equation to compute rod force (for analytic solution of loops in combination with Internal.RevoluteWithLengthConstraint/PrismaticWithLengthConstraint)"
    annotation (Dialog(tab="Advanced", enable=not kinematicConstraint));
  parameter Boolean checkTotalPower=false
    "= true, if total power flowing into this component shall be determined (must be zero)"
    annotation (Dialog(tab="Advanced"));
  SI.Force f_rod
    "Constraint force in direction of the rod (positive, if rod is pressed)";
  final parameter SI.Distance rodLength(fixed=false, start=Modelica.Math.Vectors.length(rRod_ia))
    "Length of rod (distance between origin of frame_a and origin of frame_b)";
  final parameter Real eRod_ia[3](each final unit="1")=Modelica.Math.Vectors.normalizeWithAssert(rRod_ia)
    "Unit vector from origin of frame_a to origin of frame_b, resolved in frame_ia";
  final parameter Real e2_ia[3](each final unit="1")=Modelica.Math.Vectors.normalize(
                                                 cross(n1_a, eRod_ia))
    "Unit vector in direction of axis 2 of universal joint, resolved in frame_ia (orthogonal to n1_a and eRod_ia; note: frame_ia is parallel to frame_a when the universal joint angles are zero)";
  final parameter Real e3_ia[3](each final unit="1")=cross(eRod_ia, e2_ia)
    "Unit vector perpendicular to eRod_ia and e2_ia, resolved in frame_ia";
  SI.Power totalPower
    "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";
  SI.Force f_b_a1[3]
    "frame_b.f without f_rod part, resolved in frame_a (needed for analytic loop handling)";
  Real eRod_a[3](each final unit="1")
    "Unit vector in direction of rRod_a, resolved in frame_a (needed for analytic loop handling)";
  SI.Position rRod_0[3](start=rRod_ia)
    "Position vector from origin of frame_a to origin of frame_b resolved in world frame";
  SI.Position rRod_a[3](start=rRod_ia)
    "Position vector from origin of frame_a to origin of frame_b resolved in frame_a";

protected
  SI.Force f_b_a[3] "frame_b.f resolved in frame_a";
  SI.Force f_ia_a[3] "frame_ia.f resolved in frame_a";
  SI.Torque t_ia_a[3] "frame_ia.t resolved in frame_a";
  Real n2_a[3](each final unit="1")
    "Vector in direction of axis 2 of the universal joint (e2_ia), resolved in frame_a";
  Real length2_n2_a(start=1, unit="1") "Square of length of vector n2_a";
  Real length_n2_a(unit="1") "Length of vector n2_a";
  Real e2_a[3](each final unit="1")
    "Unit vector in direction of axis 2 of the universal joint (e2_ia), resolved in frame_a";
  Real e3_a[3](each final unit="1")
    "Unit vector perpendicular to eRod_ia and e2_a, resolved in frame_a";
  Real der_rRod_a_L[3](each unit="1/s") "= der(rRod_a)/rodLength";
  SI.AngularVelocity w_rel_ia1[3];
  Frames.Orientation R_rel_ia1;
  Frames.Orientation R_rel_ia2;
  // Real T_rel_ia[3, 3];
  Frames.Orientation R_rel_ia "Rotation from frame_a to frame_ia";

  Visualizers.Advanced.Shape rodShape(
    shapeType=rodShapeType,
    color=rodColor,
    specularCoefficient=specularCoefficient,
    length=rodLength,
    width=rodWidth,
    height=rodHeight,
    lengthDirection=eRod_ia,
    widthDirection=e2_ia,
    r=frame_ia.r_0,
    R=frame_ia.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape sphericalShape_b(
    shapeType="sphere",
    color=sphereColor,
    specularCoefficient=specularCoefficient,
    length=sphereDiameter,
    width=sphereDiameter,
    height=sphereDiameter,
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    r_shape={-0.5,0,0}*sphereDiameter,
    r=frame_b.r_0,
    R=frame_b.R) if world.enableAnimation and animation;
  Visualizers.Advanced.Shape sphericalShape_a(
    shapeType="sphere",
    color=sphereColor,
    specularCoefficient=specularCoefficient,
    length=sphereDiameter,
    width=sphereDiameter,
    height=sphereDiameter,
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    r_shape={-0.5,0,0}*sphereDiameter,
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation and not showUniversalAxes;
  Visualizers.Advanced.Shape universalShape1(
    shapeType="cylinder",
    color=cylinderColor,
    specularCoefficient=specularCoefficient,
    length=cylinderLength,
    width=cylinderDiameter,
    height=cylinderDiameter,
    lengthDirection=n1_a,
    widthDirection={0,1,0},
    r_shape=-n1_a*(cylinderLength/2),
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation and showUniversalAxes;
  Visualizers.Advanced.Shape universalShape2(
    shapeType="cylinder",
    color=cylinderColor,
    specularCoefficient=specularCoefficient,
    length=cylinderLength,
    width=cylinderDiameter,
    height=cylinderDiameter,
    lengthDirection=e2_ia,
    widthDirection={0,1,0},
    r_shape=-e2_ia*(cylinderLength/2),
    r=frame_ia.r_0,
    R=frame_ia.R) if world.enableAnimation and animation and showUniversalAxes;

initial equation
if not computeRodLength then
  rodLength = Modelica.Math.Vectors.length(rRod_ia);
end if;

equation
  Connections.branch(frame_a.R, frame_ia.R);
  if kinematicConstraint then
    rRod_0 = transpose(frame_b.R.T)*(frame_b.R.T*frame_b.r_0) - transpose(
      frame_a.R.T)*(frame_a.R.T*frame_a.r_0);
  else
    rRod_0 = frame_b.r_0 - frame_a.r_0;
  end if;
  //rRod_0 = frame_b.r_0 - frame_a.r_0;
  rRod_a = Frames.resolve2(frame_a.R, rRod_0);

  // Constraint equation
  constraintResidue = 0;

  /* Determine relative Rotation R_rel_ia from frame_a to frame_ia
     and absolute rotation of frame_a.R.
  */
  eRod_a = rRod_a/rodLength;
  n2_a = cross(n1_a, eRod_a);
  length2_n2_a = n2_a*n2_a;

  assert(length2_n2_a > 1e-10, "
A Modelica.Mechanics.MultiBody.Joints.UniversalSpherical joint (consisting of
a universal joint and a spherical joint connected together
by a rigid rod) is in the singular configuration of the
universal joint. This means that axis 1 of the universal
joint defined via parameter \"n1_a\" is parallel to vector
\"rRod_ia\" that is directed from the origin of frame_a to the
origin of frame_b.
   You may try to use another \"n1_a\" vector. If this fails,
use instead Modelica.Mechanics.MultiBody.Joints.SphericalSpherical, if this is
possible, because this joint aggregation does not have a
singular configuration.
");

  length_n2_a = sqrt(length2_n2_a);
  e2_a = n2_a/length_n2_a;
  e3_a = cross(eRod_a, e2_a);

  /* The statements below are an efficient implementation of the
   original equations:
     T_rel_ia = [eRod_ia, e2_ia, e3_ia]*transpose([eRod_a, e2_a, e3_a]);
     R_rel_ia = Frames.from_T(T_rel_ia,
                   Frames.TransformationMatrices.angularVelocity2(T_rel_ia, der(T_rel_ia)));
   To perform this, the rotation is split into two parts:
     R_rel_ia : Rotation object from frame_a to frame_ia
     R_rel_ia1: Rotation object from frame_a to frame_ia1
                (frame that is fixed in frame_ia such that x-axis
                is along the rod axis)
                T = transpose([eRod_a, e2_a, e3_a]; w = w_rel_ia1
     R_rel_ia2: Fixed rotation object from frame_ia1 to frame_ia
                T = [eRod_ia, e2_ia, e3_ia]; w = zeros(3)

   The difficult part is to compute w_rel_ia1:
      w_rel_ia1 = [  e3_a*der(e2_a);
                    -e3_a*der(eRod_a);
                     e2_a*der(eRod_a)]
   der(eRod_a) is directly given, since eRod_a is a function
   of translational quantities only.
      der(eRod_a) = (der(rRod_a) - eRod_a*(eRod_a*der(rRod_a)))/rodLength
      der(n2_a)   = cross(n1_a, der(eRod_a))
      der(e2_a)   = (der(n2_a) - e2_a*(e2_a*der(n2_a)))/length_n2_a
   Inserting these equations in w_rel_ia1 results in:
      e3_a*der(eRod_a) = e3_a*der(rRod_a)/rodLength       // e3_a*eRod_a = 0
      e2_a*der(eRod_a) = e2_a*der(rRod_a)/rodLength       // e2_a*eRod_a = 0
      e3_a*der(e2_a)   = e3_a*der(n2_a)/length_n2_a       // e3_a*e2_a = 0
                       = e3_a*cross(n1_a, der(eRod_a))/length_n2_a
                       = e3_a*cross(n1_a, der(rRod_a) - eRod_a*(eRod_a*der(rRod_a)))/(length_n2_a*rodLength)
                       = e3_a*cross(n1_a, der(rRod_a))/(length_n2_a*rodLength)
   Furthermore, we have:
     rRod_a            = resolve2(frame_a.R, rRod_0);
     der(rRod_a)       = resolve2(frame_a.R, der(rRod_0)) - cross(frame_a.R.w, rRod_a));
*/
  der_rRod_a_L = (Frames.resolve2(frame_a.R, der(rRod_0)) - cross(frame_a.R.w,
     rRod_a))/rodLength;
  w_rel_ia1 = {e3_a*cross(n1_a, der_rRod_a_L)/length_n2_a,-e3_a*der_rRod_a_L,
    e2_a*der_rRod_a_L};
  R_rel_ia1 = Frames.from_T(transpose([eRod_a, e2_a, e3_a]), w_rel_ia1);
  R_rel_ia2 = Frames.from_T([eRod_ia, e2_ia, e3_ia], zeros(3));
  R_rel_ia = Frames.absoluteRotation(R_rel_ia1, R_rel_ia2);
  /*
  T_rel_ia = [eRod_ia, e2_ia, e3_ia]*transpose([eRod_a, e2_a, e3_a]);
  R_rel_ia = Frames.from_T(T_rel_ia,
    Frames.TransformationMatrices.angularVelocity2(T_rel_ia, der(T_rel_ia)));
*/

  // Compute kinematic quantities of frame_ia
  frame_ia.r_0 = frame_a.r_0;
  frame_ia.R = Frames.absoluteRotation(frame_a.R, R_rel_ia);

  /* In the following formulas f_a, f_b, f_ia, t_a, t_b, t_ia are
     the forces and torques at frame_a, frame_b, frame_ia, respectively,
     resolved in frame_a. e_x, e_y, e_z are the unit vectors resolved in frame_a.
     Torque balance at the rod around the origin of frame_a:
       0 = t_a + t_ia + cross(rRod_a, f_b)
     with
         rRod_a = rodLength*e_x
         f_b     = -f_rod*e_x + f_b[2]*e_y + f_b[3]*e_z
     follows:
       0 = t_a + t_ia + rodLength*(f_b[2]*e_z - f_b[3]*e_y)
     The projection of t_a with respect to universal joint axes vanishes:
       n1_a*t_a = 0
       e_y*t_a = 0
     Therefore:
        0 = n1_a*t_ia + rodLength*f_b[2]*(n1_a*e_z)
        0 = e_y*t_ia - rodLength*f_b[3]
     or
        f_b = -f_rod*e_x - e_y*(n1_a*t_ia)/(rodLength*(n1_a*e_z)) + e_z*(e_y*t_ia)/rodLength
     Force balance:
        0 = f_a + f_b + f_ia
  */
  f_ia_a = Frames.resolve1(R_rel_ia, frame_ia.f);
  t_ia_a = Frames.resolve1(R_rel_ia, frame_ia.t);

    // f_b_a1 is needed in aggregation joints to solve kinematic loops analytically
  f_b_a1 = -e2_a*((n1_a*t_ia_a)/(rodLength*(n1_a*e3_a))) + e3_a*((e2_a*t_ia_a)
    /rodLength);
  f_b_a = -f_rod*eRod_a + f_b_a1;
  frame_b.f = Frames.resolveRelative(f_b_a, frame_a.R, frame_b.R);
  frame_b.t = zeros(3);
  zeros(3) = frame_a.f + f_b_a + f_ia_a;
  zeros(3) = frame_a.t + t_ia_a + cross(rRod_a, f_b_a);

  // Measure power for test purposes
  if checkTotalPower then
    totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) +
      frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + frame_ia.f*
      Frames.resolve2(frame_ia.R, der(frame_ia.r_0)) + frame_a.t*
      Frames.angularVelocity2(frame_a.R) + frame_b.t*Frames.angularVelocity2(
      frame_b.R) + frame_ia.t*Frames.angularVelocity2(frame_ia.R);
  else
    totalPower = 0;
  end if;
  annotation (
    Documentation(info="<html>
<p>
This component consists of a <strong>universal joint</strong> at frame_a and
a <strong>spherical joint</strong> at frame_b that are connected together with
a <strong>rigid rod</strong>, see default animation figure (the arrows are not
part of the default animation):
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/UniversalSpherical.png\" alt=\"model Joints.UniversalSpherical\">
</div>

<p>
This joint aggregation has no mass and no inertia and introduces the constraint
that the distance between the origin of frame_a and the origin of frame_b is constant
(= Frames.length(rRod_ia)). The universal joint is defined in the following way:
</p>

<ul>
<li> The rotation <strong>axis</strong> of revolute joint <strong>1</strong> is along parameter
     vector n1_a which is fixed in frame_a.</li>
<li> The rotation <strong>axis</strong> of revolute joint <strong>2</strong> is perpendicular to
     axis 1 and to the line connecting the universal and the spherical joint.</li>
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
is perpendicular to rRod_ia in the initial configuration (i.e., the
distance to the singularity is as large as possible).
</p>
<p>
An additional <strong>frame_ia</strong> is present. It is <strong>fixed</strong> in the connecting
<strong>rod</strong> at the origin of <strong>frame_a</strong>. The placement of frame_ia on the rod
is implicitly defined by the universal joint (frame_a and frame_ia coincide
when the angles of the two revolute joints of the universal joint are zero)
and by parameter vector <strong>rRod_ia</strong>, the position vector
from the origin of frame_a to the origin of frame_b, resolved in frame_<strong>ia</strong>.
</p>
<p>
The easiest way to define the parameters of this joint is by moving the
MultiBody system in a <strong>reference configuration</strong> where <strong>all frames</strong>
of all components are <strong>parallel</strong> to other (alternatively,
at least frame_a and frame_ia of the UniversalSpherical joint
should be parallel to other when defining an instance of this
component). Since frame_a and frame_ia are parallel to other,
vector <strong>rRod_ia</strong> from frame_a to frame_b resolved in frame_<strong>ia</strong> can be resolved
in frame_<strong>a</strong> (or the <strong>world frame</strong>, if all frames are parallel to other).
</p>
<p>
This joint aggregation can be used in cases where
in reality a rod with spherical joints at end are present.
Such a system has an additional degree of freedom to rotate
the rod along its axis. In practice this rotation is usually
of no interest and is mathematically removed by replacing one
of the spherical joints by a universal joint. Still, in most
cases the Joints.SphericalSpherical joint aggregation can be used instead
of the UniversalSpherical joint
since the rod is animated and its mass properties are approximated by
a point mass in the middle of the rod. The SphericalSpherical joint
has the advantage that it does not have a singular configuration.
</p>
<p>
In the public interface of the UniversalSpherical joint, the following
(final) <strong>parameters</strong> are provided:
</p>
<blockquote><pre>
<strong>parameter</strong> Real rodLength(unit=\"m\")  \"Length of rod\";
<strong>parameter</strong> Real eRod_ia[3] \"Unit vector along rod, resolved in frame_ia\";
<strong>parameter</strong> Real e2_ia  [3] \"Unit vector along axis 2, resolved in frame_ia\";
</pre></blockquote>
<p>
This allows a more convenient definition of data which is related to the rod.
For example, if a box shall be connected at frame_ia directing from
the origin of frame_a to the middle of the rod, this might be defined as:
</p>
<blockquote><pre>
  Modelica.Mechanics.MultiBody.Joints.UniversalSpherical jointUS(rRod_ia={1.2, 1, 0.2});
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape    shape(shapeType       = \"box\",
                                            lengthDirection = jointUS.eRod_ia,
                                            widthDirection  = jointUS.e2_ia,
                                            length          = jointUS.rodLength/2,
                                            width           = jointUS.rodLength/10);
<strong>equation</strong>
  <strong>connect</strong>(jointUS.frame_ia, shape.frame_a);
</pre></blockquote>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,-50},{150,-90}},
          textColor={0,0,255},
          textString="%name"),
        Ellipse(
          extent={{-100,-40},{-19,40}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Ellipse(
          extent={{-90,-30},{-29,29}},
          lineColor={160,160,164},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,41},{-9,-44}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,40},{-60,-40}},
          thickness=0.5),
        Ellipse(
          extent={{-83,-17},{-34,21}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Ellipse(
          extent={{-74,-12},{-40,15}},
          lineColor={160,160,164},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-72,-20},{-89,3},{-69,25},{-45,27},{-72,-20}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(
          points={{-60,40},{-60,-10}},
          thickness=0.5),
        Line(
          points={{-49,20},{-69,-15}},
          thickness=0.5),
        Ellipse(
          extent={{44,14},{73,-14}},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{20,-40},{100,40}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Ellipse(
          extent={{30,-30},{90,30}},
          lineColor={192,192,192},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-22,45},{40,-43}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{46,14},{75,-14}},
          fillPattern=FillPattern.Sphere,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-36,-8},{48,8}},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Text(
          extent={{-105,118},{-67,86}},
          textColor={128,128,128},
          textString="ia"),
        Text(
          extent={{-24,95},{167,65}},
          textString="%rRod_ia"),
        Line(
          points={{-40,101},{-40,60},{-60,1}},
          color={128,128,128},
          thickness=0.5)}));
end UniversalSpherical;
