within Modelica.Mechanics.MultiBody.Examples.Elementary;
model PendulumWithSpringDamper "Simple spring/damper/mass system"
  extends Modelica.Icons.Example;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  inner Modelica.Mechanics.MultiBody.World world(axisLength=0.6)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    m=1,
    animation=animation,
    I_11=1,
    I_22=1,
    I_33=1,
    r_CM={0,0,0},
    cylinderDiameter=0.05,
    sphereDiameter=0.2) annotation (Placement(transformation(
        origin={70,0},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar1(animation=animation, r={0.3,0,0})
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Mechanics.MultiBody.Forces.Spring spring1(
    coilWidth=0.01,
    numberOfWindings=5,
    c=20,
    s_unstretched=0.2) annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Mechanics.MultiBody.Forces.Damper damper1(
    d=1,
    length_a=0.1,
    diameter_a=0.08,
    animation=false) annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute(phi(fixed=true), w(
        fixed=true)) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(
    boxWidth=0.04,
    boxColor={255,65,65},
    s(fixed=true, start=0.5),
    v(fixed=true))
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(world.frame_b, bar1.frame_a)
    annotation (Line(
      points={{-60,0},{-50,0}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_a, bar1.frame_b)
    annotation (Line(
      points={{-10,0},{-30,0}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_a, revolute.frame_b)
    annotation (Line(
      points={{20,0},{10,0}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1.frame_a, bar1.frame_b) annotation (Line(
      points={{0,-30},{-20,-30},{-20,0},{-30,0}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1.frame_b, prismatic.frame_b) annotation (Line(
      points={{20,-30},{50,-30},{50,0},{40,0}},
      color={95,95,95},
      thickness=0.5));
  connect(spring1.frame_a, bar1.frame_b) annotation (Line(
      points={{0,-50},{-20,-50},{-20,0},{-30,0}},
      color={95,95,95},
      thickness=0.5));
  connect(spring1.frame_b, prismatic.frame_b) annotation (Line(
      points={{20,-50},{50,-50},{50,0},{40,0}},
      color={95,95,95},
      thickness=0.5));
  connect(body1.frame_a, prismatic.frame_b)
    annotation (Line(
      points={{60,0},{40,0}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=10),
    Documentation(info="<html>
<p>
A body is attached on a revolute and prismatic joint.
A 3-dim. spring and a 3-dim. damper are connected between the body
and a point fixed in the world frame:
</p>

<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/PendulumWithSpringDamper.png\"
alt=\"model Examples.Elementary.PendulumWithSpringDamper\">
</html>"));
end PendulumWithSpringDamper;
