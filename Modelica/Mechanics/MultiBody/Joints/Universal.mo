within Modelica.Mechanics.MultiBody.Joints;
model Universal "Universal joint (2 degrees-of-freedom, 4 potential states)"

  extends Modelica.Mechanics.MultiBody.Interfaces.PartialTwoFrames;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_a={1,0,0}
    "Axis of revolute joint 1 resolved in frame_a" annotation (Evaluate=true);
  parameter Modelica.Mechanics.MultiBody.Types.Axis n_b={0,1,0}
    "Axis of revolute joint 2 resolved in frame_b" annotation (Evaluate=true);

  parameter SI.Distance cylinderLength=world.defaultJointLength
    "Length of cylinders representing the joint axes"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter SI.Distance cylinderDiameter=world.defaultJointWidth
    "Diameter of cylinders representing the joint axes"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  input Types.Color cylinderColor=Modelica.Mechanics.MultiBody.Types.Defaults.JointColor
    "Color of cylinders representing the joint axes"
    annotation (Dialog(colorSelector=true, tab="Animation", group="if animation = true", enable=animation));
  input Types.SpecularCoefficient specularCoefficient = world.defaultSpecularCoefficient
    "Reflection of ambient light (= 0: light is completely absorbed)"
    annotation (Dialog(tab="Animation", group="if animation = true", enable=animation));
  parameter StateSelect stateSelect=StateSelect.prefer
    "Priority to use joint coordinates (phi_a, phi_b, w_a, w_b) as states" annotation(Dialog(tab="Advanced"));

  Modelica.Mechanics.MultiBody.Joints.Revolute revolute_a(
    n=n_a,
    stateSelect=StateSelect.never,
    cylinderDiameter=cylinderDiameter,
    cylinderLength=cylinderLength,
    cylinderColor=cylinderColor,
    specularCoefficient=specularCoefficient,
    animation=animation) annotation (Placement(transformation(extent={{-60,-25},{-10,25}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute_b(
    n=n_b,
    stateSelect=StateSelect.never,
    animation=animation,
    cylinderDiameter=cylinderDiameter,
    cylinderLength=cylinderLength,
    cylinderColor=cylinderColor,
    specularCoefficient=specularCoefficient) annotation (Placement(transformation(
        origin={35,45},
        extent={{-25,-25},{25,25}},
        rotation=90)));

  SI.Angle phi_a(start=0, stateSelect=stateSelect)
    "Relative rotation angle from frame_a to intermediate frame";
  SI.Angle phi_b(start=0, stateSelect=stateSelect)
    "Relative rotation angle from intermediate frame to frame_b";
  SI.AngularVelocity w_a(start=0, stateSelect=stateSelect)
    "First derivative of angle phi_a (relative angular velocity a)";
  SI.AngularVelocity w_b(start=0, stateSelect=stateSelect)
    "First derivative of angle phi_b (relative angular velocity b)";
  SI.AngularAcceleration a_a(start=0)
    "Second derivative of angle phi_a (relative angular acceleration a)";
  SI.AngularAcceleration a_b(start=0)
    "Second derivative of angle phi_b (relative angular acceleration b)";

equation
  phi_a = revolute_a.phi;
  phi_b = revolute_b.phi;
  w_a = der(phi_a);
  w_b = der(phi_b);
  a_a = der(w_a);
  a_b = der(w_b);
  connect(frame_a, revolute_a.frame_a)
    annotation (Line(
      points={{-100,0},{-60,0}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute_b.frame_b, frame_b) annotation (Line(
      points={{35,70},{35,90},{70,90},{70,0},{100,0}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute_a.frame_b, revolute_b.frame_a) annotation (Line(
      points={{-10,0},{35,0},{35,20}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    Documentation(info="<html>
<p>
Joint where frame_a rotates around axis n_a which is fixed in frame_a
and frame_b rotates around axis n_b which is fixed in frame_b.
The two frames coincide when
\"revolute_a.phi=0\" and \"revolute_b.phi=0\". This joint
has the following potential states;
</p>
<ul>
<li> The relative angle phi_a = revolute_a.phi [rad] around axis n_a,</li>
<li> the relative angle phi_b = revolute_b.phi [rad] around axis n_b,</li>
<li> the relative angular velocity w_a (= der(phi_a))  and</li>
<li> the relative angular velocity w_b (= der(phi_b)).</li>
</ul>
<p>
They are used as candidates for automatic selection of states
from the tool. This may be enforced by setting \"stateSelect=StateSelect.<strong>always</strong>\"
in the <strong>Advanced</strong> menu. The states are usually selected automatically.
In certain situations, especially when closed kinematic loops are present,
it might be slightly more efficient, when using the \"StateSelect.always\" setting.
</p>

<p>
In the following figure the animation of a universal
joint is shown. The light blue coordinate system is
frame_a and the dark blue coordinate system is
frame_b of the joint
(here: n_a = {0,0,1}, n_b = {0,1,0}, phi_a.start = 90<sup>o</sup>,
phi_b.start = 45<sup>o</sup>).
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Joints/Universal.png\">
</div>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,15},{-65,-15}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={235,235,235}),
        Ellipse(
          extent={{-80,-80},{80,80}},
          lineColor={160,160,164},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,-60},{60,60}},
          lineColor={160,160,164},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-80},{150,-120}},
          textString="%name",
          textColor={0,0,255}),
        Rectangle(
          extent={{12,82},{80,-82}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{56,15},{100,-15}},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={235,235,235}),
        Line(
          points={{12,78},{12,-78}},
          thickness=0.5),
        Ellipse(
          extent={{-52,-40},{80,40}},
          lineColor={160,160,164},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-32,-20},{60,26}},
          lineColor={160,160,164},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-22,-54},{-60,0},{-22,50},{40,52},{-22,-54}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Line(
          points={{12,78},{12,-20}},
          thickness=0.5),
        Line(
          points={{32,38},{-12,-36}},
          thickness=0.5)}));
end Universal;
