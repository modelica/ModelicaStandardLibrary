within Modelica.Mechanics.MultiBody.Examples.Elementary;
model InitPlanar "Initialize simple planar mechanism using freeMotionScalarInit joint"
  extends Modelica.Icons.Example;

  Modelica.Mechanics.MultiBody.Joints.Revolute revolute12(
    n={0,0,1},
    useAxisFlange=true,
    phi(start=0.1221730476396, fixed=true),
    w(start=0.7)) annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Joints.Revolute revolute23(
    n={0,0,1},
    useAxisFlange=false,
    phi(fixed=true, start=0.22689280275926),
    w(fixed=true)) annotation (Placement(transformation(extent={{30,10},{50,30}})));
  Joints.FreeMotionScalarInit freeMotionScalarInit(use_angle=true,
    angle_3(displayUnit="deg"),
    use_angle_d=true,
    angle_d_3(
      fixed=true,
      displayUnit="rad/s",
      start=0.14)) annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Sensors.RelativeSensor relativeSensor13(get_w_rel=true, get_angles=true) annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Mechanics.MultiBody.Parts.Body body1(m=1.0, r_CM={-0.3,0,0}) annotation (Placement(transformation(extent={{-70,10},{-90,30}})));
  Parts.BodyShape body2(
    r={0.4,0,0},
    r_CM=body2.r/2,
    m=0.6) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Parts.Body body3(
    m=1.0,
    r_CM={0.3,0,0},
    r_0(fixed=true),
    v_0(fixed=true),
    angles_fixed=true,
    w_0_fixed=true,
    enforceStates=true)
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(d=0.05)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  inner Modelica.Mechanics.MultiBody.World world
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
equation
  connect(damper.flange_b, revolute12.axis) annotation (Line(points={{-30,60},{-30,40},{-40,40},{-40,30}}));
  connect(revolute12.support, damper.flange_a) annotation (Line(points={{-46,30},{-46,40},{-50,40},{-50,60}}));
  connect(body1.frame_a, revolute12.frame_a) annotation (Line(
      points={{-70,20},{-50,20}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute23.frame_b, body3.frame_a) annotation (Line(
      points={{50,20},{70,20}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeSensor13.frame_a, body1.frame_a) annotation (Line(
      points={{-10,-20},{-60,-20},{-60,20},{-70,20}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeSensor13.frame_b, body3.frame_a) annotation (Line(
      points={{10,-20},{60,-20},{60,20},{70,20}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute12.frame_b, body2.frame_a) annotation (Line(
      points={{-30,20},{-10,20}},
      color={95,95,95},
      thickness=0.5));
  connect(body2.frame_b, revolute23.frame_a) annotation (Line(
      points={{10,20},{30,20}},
      color={95,95,95},
      thickness=0.5));
  connect(body1.frame_a, freeMotionScalarInit.frame_a) annotation (Line(
      points={{-70,20},{-60,20},{-60,-50},{-10,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(body3.frame_a, freeMotionScalarInit.frame_b) annotation (Line(
      points={{70,20},{60,20},{60,-50},{10,-50}},
      color={95,95,95},
      thickness=0.5));

  annotation (
    experiment(StopTime=1),
    Documentation(info="<html>
<p>
This model demonstrates a&nbsp;possible usage of the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.FreeMotionScalarInit\">FreeMotionScalarInit</a>.
It is a&nbsp;planar mechanism consisting of three bodies
connected by two revolute joints enabling rotating about
z axis of the world.
</p>
<p>
While the initial orientation of the mechanism is given
by initial angles of the two joints, the initial rotational
velocity is set by <code>revolute23.w</code> and, additionally,
by <code>freeMotionScalarInit.angle_d_3</code> which
connects bodies <code>body1</code> and <code>body3</code>.
Thus, the rotational velocity of the outer bodies to each other
is used for initalization.
</p>
<p>
Proper initialization can be checked by outputs of sensor
<code>relativeSensor13</code>.
</p>
</html>"));
end InitPlanar;
