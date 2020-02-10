within Modelica.Mechanics.MultiBody.Examples.Elementary;
model InitPlanar "Initialize simple planar mechanism using freeMotion joint"
  extends Modelica.Icons.Example;
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(
    n={0,0,1},
    useAxisFlange=true,
    phi(start=0.1221730476396, fixed=true),
    w(start=0.7))             annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Joints.Revolute revolute2(
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
      start=0.14))              annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Sensors.RelativeSensor relativeSensor(get_w_rel=true, get_angles=true) annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Mechanics.MultiBody.Parts.Body body(m=1.0, r_CM={-0.3,0,0})
    annotation (Placement(transformation(extent={{-70,10},{-90,30}})));
  Parts.Body                              body1(
    m=1.0,
    r_CM={0.3,0,0},
    r_0(fixed=true),
    v_0(fixed=true),
    angles_fixed=true,
    w_0_fixed=true,
    enforceStates=true)
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
  Parts.BodyShape bodyShape(
    r={0.4,0,0},
    r_CM=bodyShape.r/2,
    m=0.6) annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(d=0.05)
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
  inner Modelica.Mechanics.MultiBody.World world
                        annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
equation
  connect(damper.flange_b, revolute1.axis) annotation (Line(points={{-30,60},{-30,40},{-40,40},{-40,30}}));
  connect(revolute1.support, damper.flange_a) annotation (Line(points={{-46,30},{-46,40},{-50,40},{-50,60}}));
  connect(body.frame_a, revolute1.frame_a) annotation (Line(
      points={{-70,20},{-50,20}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute2.frame_b, body1.frame_a) annotation (Line(
      points={{50,20},{70,20}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeSensor.frame_a, body.frame_a) annotation (Line(
      points={{-10,-20},{-60,-20},{-60,20},{-70,20}},
      color={95,95,95},
      thickness=0.5));
  connect(relativeSensor.frame_b, body1.frame_a) annotation (Line(
      points={{10,-20},{60,-20},{60,20},{70,20}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute1.frame_b, bodyShape.frame_a) annotation (Line(
      points={{-30,20},{-10,20}},
      color={95,95,95},
      thickness=0.5));
  connect(bodyShape.frame_b, revolute2.frame_a) annotation (Line(
      points={{10,20},{30,20}},
      color={95,95,95},
      thickness=0.5));
  connect(body.frame_a, freeMotionScalarInit.frame_a) annotation (Line(
      points={{-70,20},{-60,20},{-60,-50},{-10,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(body1.frame_a, freeMotionScalarInit.frame_b) annotation (Line(
      points={{70,20},{60,20},{60,-50},{10,-50}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(__Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>
This model demonstrates a&nbsp;possible usage of the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.FreeMotionScalarInit\">FreeMotionScalarInit</a>


that by just dragging components default animation is defined that shows the structure of the assembled system. </p>
<blockquote><img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/Pendulum.png\" alt=\"model Examples.Elementary.Pendulum\"/> </blockquote>
</html>"));
end InitPlanar;
