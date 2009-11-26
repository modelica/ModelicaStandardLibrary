within Modelica.Mechanics.MultiBody.Examples.Elementary;
model PendulumWithSpringDamper "Simple spring/damper/mass system"
  extends Modelica.Icons.Example;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  inner Modelica.Mechanics.MultiBody.World world(axisLength=0.6)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    m=1,
    animation=animation,
    I_11=1,
    I_22=1,
    I_33=1,
    r_CM={0,0,0},
    cylinderDiameter=0.05,
    sphereDiameter=0.2) annotation (Placement(transformation(
        origin={72,30},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar1(animation=animation, r={0.3,0,0})
    annotation (Placement(transformation(extent={{-46,20},{-26,40}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Forces.Spring spring1(
    coilWidth=0.01,
    numberOfWindings=5,
    c=20,
    s_unstretched=0.2) annotation (Placement(transformation(extent={{0,-46},{20,
            -26}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Forces.Damper damper1(
    d=1,
    length_a=0.1,
    diameter_a=0.08,
    animation=false) annotation (Placement(transformation(extent={{0,-20},{20,0}},
          rotation=0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute(phi(fixed=true), w(
        fixed=true))      annotation (Placement(transformation(extent={{-12,20},
            {8,40}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(
    boxWidth=0.04,
    boxColor={255,65,65},
    s(fixed=true, start=0.5),
    v(fixed=true))
    annotation (Placement(transformation(extent={{20,20},{40,40}}, rotation=0)));
equation
  connect(world.frame_b, bar1.frame_a)
    annotation (Line(
      points={{-60,30},{-46,30}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_a, bar1.frame_b)
    annotation (Line(
      points={{-12,30},{-26,30}},
      color={95,95,95},
      thickness=0.5));
  connect(prismatic.frame_a, revolute.frame_b)
    annotation (Line(
      points={{20,30},{8,30}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1.frame_a, bar1.frame_b) annotation (Line(
      points={{0,-10},{-18,-10},{-18,30},{-26,30}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1.frame_b, prismatic.frame_b) annotation (Line(
      points={{20,-10},{44,-10},{44,30},{40,30}},
      color={95,95,95},
      thickness=0.5));
  connect(spring1.frame_a, bar1.frame_b) annotation (Line(
      points={{0,-36},{-18,-36},{-18,30},{-26,30}},
      color={95,95,95},
      thickness=0.5));
  connect(spring1.frame_b, prismatic.frame_b) annotation (Line(
      points={{20,-36},{44,-36},{44,30},{40,30}},
      color={95,95,95},
      thickness=0.5));
  connect(body1.frame_a, prismatic.frame_b)
    annotation (Line(
      points={{62,30},{40,30}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=10),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Documentation(info="<html>
<p>
A body is attached on a revolute and prismatic joint.
A 3-dim. spring and a 3-dim. damper are connected between the body
and a point fixed in the world frame:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/PendulumWithSpringDamper.png\"
ALT=\"model Examples.Elementary.PendulumWithSpringDamper\">
</p>
</html>"));
end PendulumWithSpringDamper;
