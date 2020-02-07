within Modelica.Mechanics.MultiBody.Examples.Rotational3DEffects;
model ActuatedDrive "Demonstrates usage of models Rotor1D and Mounting1D"
  extends Modelica.Icons.Example;
  Parts.BodyShape bodyCylinder(
    r={0.5,0,0},
    m=0,
    I_11=2,
    I_22=0,
    I_33=0,
    shapeType="cylinder",
    width=0.1,
    animateSphere=false,
    r_shape={0.1,0,0},
    r_CM={0,0,0}) annotation (Placement(transformation(extent={{30,60},{50,80}})));
  Joints.Revolute revolute(
    n={1,0,0},
    a(fixed=false),
    phi(fixed=true),
    w(fixed=true)) annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  inner World world(g=0, driveTrainMechanics3D=true) annotation (Placement(
        transformation(extent={{-60,60},{-40,80}})));
  Forces.Torque torque annotation (Placement(transformation(extent={{0,50},{20,30}})));
  Blocks.Sources.Sine sine[3](amplitude={1,0,0}, f={1,1,1}) annotation (
      Placement(transformation(extent={{-100,-10},{-80,10}})));
  inner Parts.Fixed fixed annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  Parts.Rotor1D rotor1D(
    J=2,
    phi(fixed=true),
    w(fixed=true)) annotation (Placement(transformation(extent={{30,-40},{50,-20}})));
  Rotational.Sources.Torque torque1(useSupport=true) annotation (Placement(
        transformation(extent={{0,-40},{20,-20}})));
  Parts.Mounting1D mounting1D annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
equation
  connect(world.frame_b, revolute.frame_a) annotation (Line(
      points={{-40,70},{-10,70}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute.frame_b, bodyCylinder.frame_a) annotation (Line(
      points={{10,70},{30,70}},
      color={95,95,95},
      thickness=0.5));
  connect(torque.frame_b, bodyCylinder.frame_b) annotation (Line(
      points={{20,40},{60,40},{60,70},{50,70}},
      color={95,95,95},
      thickness=0.5));
  connect(torque.frame_a, world.frame_b) annotation (Line(
      points={{0,40},{-20,40},{-20,70},{-40,70}},
      color={95,95,95},
      thickness=0.5));
  connect(sine.y, torque.torque) annotation (Line(
      points={{-79,0},{4,0},{4,28}},     color={0,0,127}));
  connect(fixed.frame_b, rotor1D.frame_a) annotation (Line(
      points={{-40,-80},{40,-80},{40,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(torque1.flange, rotor1D.flange_a) annotation (Line(
      points={{20,-30},{30,-30}}));
  connect(mounting1D.flange_b, torque1.support) annotation (Line(
      points={{10,-60},{10,-40}}));
  connect(mounting1D.frame_a, fixed.frame_b) annotation (Line(
      points={{0,-70},{0,-80},{-40,-80}},
      color={95,95,95},
      thickness=0.5));
  connect(sine[1].y, torque1.tau) annotation (Line(
      points={{-79,0},{-20,0},{-20,-30},{-2,-30}},                      color={0,0,127}));
  annotation (experiment(StopTime=1.1), Documentation(info="<html>
<p>
This example demonstrates how to utilize the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Rotor1D\">Rotor1D</a>
and <a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Mounting1D\">Mounting1D</a> models and
compares the implementation with a standard multi-body implementation.
Note, the solution with Rotor1D is much more efficient.
</p>
</html>"));
end ActuatedDrive;
