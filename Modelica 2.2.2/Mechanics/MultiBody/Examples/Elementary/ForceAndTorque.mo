within Modelica.Mechanics.MultiBody.Examples.Elementary;
model ForceAndTorque "Demonstrate usage of ForceAndTorque element"
  extends Modelica.Icons.Example;
  inner World world(animateGravity=false) annotation (extent=[-90, 30; -70, 50]);
  annotation (
    Diagram,
    Coordsys(grid=[1, 1], component=[20, 20]),
    Documentation(info="<HTML>
In this example the usage of the general force element
\"<a href=\"Modelica://Modelica.Mechanics.MultiBody.Forces.ForceAndTorque\">ForceAndTorque</a>\"
is shown. A \"ForceAndTorque\" element is connected
between a body and a fixed point in the world system. The force and torque
is defined by the \"Constant\" block. The two vectors are resolved in the
coordinate system defined by the \"fixedRotation\" component that is
fixed in the world system:
</p>
<p>
The animation view at time = 0 is shown in the figure below.
The yellow line is directed from frame_a to frame_b of the
forceAndTorque component. The green arrow characterizes the
force acting at the body whereas the green double arrow characterizes
the torque acting at the body. The lengths of the two vectors
are proportional to the lengths of the force and torque vectors
(constant scaling factors are defined as parameters in the
forceAndTorque component):
</p>
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/ForceAndTorque.png\">
</HTML>
"),
    experiment(StopTime=1),
    experimentSetupOutput);
  Parts.BodyCylinder body(r={1,0,0}) annotation (extent=[0, 30; 20, 50]);
  Parts.Fixed fixed1(r={0,-0.5,0}, width=0.03)
    annotation (extent=[-90, -10; -70, 10]);
  Parts.FixedRotation fixedRotation(n={0,0,1}, angle=30)
    annotation (extent=[-8, -30; 12, -10]);
  Forces.ForceAndTorque forceAndTorque(Nm_to_m=120, N_to_m=1200)
    annotation (extent=[60, 50; 40, 30]);
  Joints.Revolute revolute2(n={0,1,0}, initType=Modelica.Mechanics.MultiBody.Types.Init.
        PositionVelocity) annotation (extent=[-30, 10; -10, 30], rotation=90);
  Modelica.Blocks.Sources.Constant Constant[6](k={0,1000,0,-100,100,0})
    annotation (extent=[80, 0; 60, -20], rotation=-90);
  Joints.Revolute revolute1(initType=Modelica.Mechanics.MultiBody.Types.Init.PositionVelocity)
    annotation (extent=[-60, -10; -40, 10]);
  Parts.Fixed fixed2(width=0.03, r={1.5,0.25,0})
    annotation (extent=[100, 30; 80, 50]);
equation
  connect(revolute2.frame_b, body.frame_a) annotation (points=[-20,30; -20,40;
        0,40], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(forceAndTorque.frame_b, body.frame_b)
    annotation (points=[40,40; 20,40], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixed1.frame_b, revolute1.frame_a)
    annotation (points=[-70,0; -60,0], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(revolute1.frame_b, revolute2.frame_a)
    annotation (points=[-40,0; -20,0; -20,10], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixed2.frame_b, forceAndTorque.frame_a)
    annotation (points=[80,40; 60,40], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(fixedRotation.frame_a, fixed1.frame_b) annotation (points=[-8,-20;
        -65,-20; -65,0; -70,0], style(
      color=10,
      rgbcolor={95,95,95},
      thickness=2));
  connect(forceAndTorque.frame_resolve, fixedRotation.frame_b) annotation (
      points=[46,30; 46,-20; 12,-20], style(
      color=10,
      rgbcolor={95,95,95},
      pattern=3));
  connect(Constant.y, forceAndTorque.load) annotation(points=[70,1; 70,13; 56,
        13; 56,28],  style(color=3, rgbcolor={0,0,255}));
end ForceAndTorque;
