encapsulated model PendulumWithSpringDamper "Simple spring/damper/mass system"
  import Modelica.Icons;
  import Modelica.Mechanics.MultiBody;
  import Modelica.Mechanics.Rotational;
  import Modelica;
  extends Icons.Example;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  annotation (
    experiment(StopTime=10),
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.29,
      y=0,
      width=0.71,
      height=0.85),
    Diagram,
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
  inner Modelica.Mechanics.MultiBody.World world(axisLength=0.6)
    annotation (extent=[-80, 20; -60, 40]);
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    m=1,
    animation=animation,
    I_11=1,
    I_22=1,
    I_33=1,
    r_CM={0,0,0},
    cylinderDiameter=0.05,
    sphereDiameter=0.2) annotation (extent=[82, 20; 62, 40], rotation=-180);
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar1(animation=animation, r={0.3,0,0})
    annotation (extent=[-46, 20; -26, 40]);
  Modelica.Mechanics.MultiBody.Forces.Spring spring1(
    coilWidth=0.01,
    numberOfWindings=5,
    c=20,
    s_unstretched=0.2) annotation (extent=[0, -46; 20, -26], rotation=0);
  Modelica.Mechanics.MultiBody.Forces.Damper damper1(
    d=1,
    length_a=0.1,
    diameter_a=0.08,
    animation=false) annotation (extent=[0, -20; 20, 0], rotation=0);
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute(initType=Modelica.Mechanics.MultiBody.Types.Init.
        PositionVelocity) annotation (extent=[-12, 20; 8, 40]);
  Modelica.Mechanics.MultiBody.Joints.Prismatic prismatic(
    s_start=0.5,
    boxWidth=0.04,
    boxColor={255,65,65},
    initType=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocity)
    annotation (extent=[20, 20; 40, 40]);
equation
  connect(world.frame_b, bar1.frame_a)
    annotation (points=[-59, 30; -47, 30], style(color=0, thickness=2));
  connect(revolute.frame_a, bar1.frame_b)
    annotation (points=[-13, 30; -25, 30], style(color=0, thickness=2));
  connect(prismatic.frame_a, revolute.frame_b)
    annotation (points=[19, 30; 9, 30], style(color=0, thickness=2));
  connect(damper1.frame_a, bar1.frame_b) annotation (points=[-1, -10; -18, -10;
         -18, 30; -25, 30], style(color=0, thickness=2));
  connect(damper1.frame_b, prismatic.frame_b) annotation (points=[21, -10; 44,
        -10; 44, 30; 41, 30], style(color=0, thickness=2));
  connect(spring1.frame_a, bar1.frame_b) annotation (points=[-1, -36; -18, -36;
         -18, 30; -25, 30], style(color=0, thickness=2));
  connect(spring1.frame_b, prismatic.frame_b) annotation (points=[21, -36; 44,
        -36; 44, 30; 41, 30], style(color=0, thickness=2));
  connect(body1.frame_a, prismatic.frame_b)
    annotation (points=[61, 30; 41, 30], style(color=0, thickness=2));
end PendulumWithSpringDamper;
