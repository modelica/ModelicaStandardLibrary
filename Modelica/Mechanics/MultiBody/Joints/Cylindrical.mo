within Modelica.Mechanics.MultiBody.Joints;
model Cylindrical
  "Cylindrical joint (2 degrees-of-freedom, 4 potential states)"
  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  parameter Boolean animation=true
    "= true, if animation shall be enabled (show cylinder)";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n={1,0,0}
    "Cylinder axis resolved in frame_a (= same as in frame_b)"
    annotation (Evaluate=true);
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth
    "Diameter of cylinder"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor
    "Color of cylinder"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter StateSelect stateSelect=StateSelect.prefer
    "Priority to use joint coordinates (phi, s, w, v) as states" annotation(Dialog(tab="Advanced"));

  Prismatic prismatic(
    n=n,
    animation=false,
    stateSelect=StateSelect.never) annotation (Placement(transformation(extent={{-70,-25},{
            -15,25}})));
  Revolute revolute(
    n=n,
    animation=false,
    stateSelect=StateSelect.never) annotation (Placement(transformation(extent={{10,-25},{
            65,25}})));

  SI.Position s(start=0, stateSelect=stateSelect)
    "Relative distance between frame_a and frame_b";
  SI.Angle phi(start=0, stateSelect=stateSelect)
    "Relative rotation angle from frame_a to frame_b";
  SI.Velocity v(start=0, stateSelect=stateSelect)
    "First derivative of s (relative velocity)";
  SI.AngularVelocity w(start=0, stateSelect=stateSelect)
    "First derivative of angle phi (relative angular velocity)";
  SI.Acceleration a(start=0) "Second derivative of s (relative acceleration)";
  SI.AngularAcceleration wd(start=0)
    "Second derivative of angle phi (relative angular acceleration)";

protected
  Visualizers.Advanced.Shape cylinder(
    shapeType="cylinder",
    color=cylinderColor,
    specularCoefficient=specularCoefficient,
    length=prismatic.s,
    width=cylinderDiameter,
    height=cylinderDiameter,
    lengthDirection=prismatic.n,
    widthDirection={0,1,0},
    r=frame_a.r_0,
    R=frame_a.R) if world.enableAnimation and animation
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
equation
  phi = revolute.phi;
  w = der(phi);
  wd = der(w);
  s = prismatic.s;
  v = der(s);
  a = der(v);
  connect(frame_a, prismatic.frame_a)
    annotation (Line(
      points={{-100,0},{-70,0}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_b, revolute.frame_a)
    annotation (Line(
      points={{-15,0},{10,0}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, frame_b)
    annotation (Line(
      points={{65,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    Documentation(info="<html>
<p>
Joint where frame_b rotates around and translates along axis n
which is fixed in frame_a. The two frames coincide when
\"phi=revolute.phi=0\" and \"s=prismatic.s=0\". This joint
has the following potential states;
</p>
<ul>
<li> The relative angle phi [rad] around axis n,</li>
<li> the relative distance s [m] along axis n,</li>
<li> the relative angular velocity w [rad/s] (= der(phi))
     and</li>
<li> the relative velocity v [m/s] (= der(s)).</li>
</ul>
<p>
They are used as candidates for automatic selection of states
from the tool. This may be enforced by setting \"stateSelect=StateSelect.<strong>always</strong>\"
in the <strong>Advanced</strong> menu. The states are usually selected automatically.
In certain situations, especially when closed kinematic loops are present,
it might be slightly more efficient, when using the \"StateSelect.always\" setting.
</p>
<p>
In the following figure the animation of a cylindrical
joint is shown. The light blue coordinate system is
frame_a and the dark blue coordinate system is
frame_b of the joint. The black arrow is parameter
vector \"n\" defining the cylinder axis
(here: n = {0,0,1}).
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Cylindrical.png\">
</div>
</html>"),
         Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-30,-30},{100,30}},
          lineColor={64,64,64},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255},
          radius=10),
        Rectangle(
          extent={{-30,-30},{100,30}},
          lineColor={64,64,64},
          radius=10),
        Rectangle(
          extent={{-100,-50},{0,50}},
          lineColor={64,64,64},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255},
          radius=10),
        Rectangle(
          extent={{-100,-50},{0,50}},
          lineColor={64,64,64},
          radius=10),
        Text(
          extent={{-150,100},{150,60}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-65},{150,-95}},
          textString="n=%n")}));
end Cylindrical;
