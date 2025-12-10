within Modelica.Mechanics.MultiBody.Parts;
model RollingWheel
  "Ideal rolling wheel on flat surface z=0 (5 positional, 3 velocity degrees of freedom)"

  parameter Boolean animation=true
    "= true, if animation of wheel shall be enabled";

  parameter SI.Radius radius "Radius of wheel";
  parameter SI.Mass m "Mass of wheel";
  parameter SI.Inertia I_axis "Inertia along the wheel axis";
  parameter SI.Inertia I_long "Inertia perpendicular to the wheel axis";
  parameter StateSelect stateSelect=StateSelect.always
    "Priority to use generalized coordinates as states"
    annotation (HideResult=true, Evaluate=true);

  SI.Position x(
    start=0,
    fixed=true,
    stateSelect=stateSelect) "x-coordinate of wheel axis";

  SI.Position y(
    start=0,
    fixed=true,
    stateSelect=stateSelect) "y-coordinate of wheel axis";

  SI.Angle angles[3](
    start={0,0,0},
    each fixed=true,
    each stateSelect=stateSelect)
    "Angles to rotate world-frame in to frame_a around z-, y-, x-axis"
    annotation (Dialog(group="Initialization",showStartAttribute=true));

  SI.AngularVelocity der_angles[3](
    start={0,0,0},
    each fixed=true,
    each stateSelect=stateSelect) "Derivative of angles"
    annotation (Dialog(group="Initialization",showStartAttribute=true));

  parameter SI.Distance width=0.035 "Width of wheel" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter Real hollowFraction=0.8
    "For ring-like visualization: wheel radius / inner hole radius; i.e. 1.0: completely hollow, 0.0: full disc" annotation (Dialog(
      tab="Animation",
      group="if animation = true",
      enable=animation));
  parameter Types.Color color={30,30,30} "Color of wheel"
    annotation (Dialog(
      colorSelector=true,
      tab="Animation",
      group="if animation = true",
      enable=animation));

  Modelica.Mechanics.MultiBody.Parts.Body body(
    final r_CM={0,0,0},
    final m=m,
    final I_11=I_long,
    final I_22=I_axis,
    final I_33=I_long,
    final I_21=0,
    final I_31=0,
    final I_32=0,
    animation=false) annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a
    "Frame fixed in wheel center point (y-axis: along wheel axis, z-axis: upwards)"
    annotation (Placement(transformation(extent={{-16,-16},{16,16}})));
  Modelica.Mechanics.MultiBody.Joints.RollingWheel rollingWheel(
    radius=radius, stateSelect=StateSelect.avoid)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape fixedShape(
    final animation=animation,
    final r_shape={0,-width,0},
    final lengthDirection={0,1,0},
    final widthDirection={1,0,0},
    final length=2*width,
    final width=2*radius,
    final height=2*radius,
    final color=color,
    final extra=hollowFraction,
    final shapeType="pipe") if animation
    annotation (Placement(transformation(extent={{20,20},{40,40}})));

equation
  rollingWheel.x = x;
  rollingWheel.y = y;
  rollingWheel.angles = angles;
  rollingWheel.der_angles = der_angles;

  connect(body.frame_a, frame_a) annotation (Line(
      points={{20,0},{0,0}},
      color={95,95,95},
      thickness=0.5));
  connect(rollingWheel.frame_a, frame_a) annotation (Line(
      points={{-30,0},{0,0}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedShape.frame_a, frame_a) annotation (Line(
      points={{20,30},{0,30},{0,0}},
      color={95,95,95},
      thickness=0.5));
  annotation (defaultComponentName="wheel", Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,-80},{100,-100}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{-80,80},{80,-80}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Sphere,
          lineColor={175,175,175}),
        Text(
          extent={{-150,120},{150,80}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{-100,-80},{100,-80}}),
        Ellipse(extent={{-80,80},{80,-80}}, lineColor={64,64,64})}),
    Documentation(info="<html>
<p>
A wheel rolling on the x-y plane of the world frame including
wheel mass and simple visualization.
The rolling contact is considered being ideal, i.e. there is no
slip between the wheel and the ground.
The wheel can not take off but it can incline toward the ground.
The frame frame_a is placed in the wheel center point and rotates
with the wheel itself. Therefore, a
<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.Revolute\">rotational joint</a>
with rotation axis <code>n={0,1,0}</code> should be used to
connect the wheel to a carrier.
</p>

<h4>Note</h4>
<p>
To work properly, the gravity acceleration vector g of the world must point in the negative z-axis, i.e.
</p>
<blockquote><pre>
<span style=\"font-family:'Courier New',courier; color:#0000ff;\">inner</span> <span style=\"font-family:'Courier New',courier; color:#ff0000;\">Modelica.Mechanics.MultiBody.World</span> world(n={0,0,-1});
</pre></blockquote>
</html>"));
end RollingWheel;
