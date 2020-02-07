within Modelica.Mechanics.MultiBody.Examples.Rotational3DEffects;
model BevelGear1D
  "Demonstrates the usage of a BevelGear1D model and how to calculate the power of such an element"
  import Modelica.Mechanics.MultiBody.Frames;
  extends Modelica.Icons.Example;
  parameter Modelica.Mechanics.MultiBody.Types.Axis na={1,0,0}
    "Axis of rotation of left gear axis";
  parameter Modelica.Mechanics.MultiBody.Types.Axis nb={0,1,0}
    "Axis of rotation of right gear axis";

  inner Modelica.Mechanics.MultiBody.World world(final driveTrainMechanics3D=true) annotation (Placement(transformation(
          extent={{-100,-50},{-80,-30}})));
  Modelica.Mechanics.MultiBody.Parts.Rotor1D       inertia1(
    J=1.1,
    a(fixed=false),
    phi(fixed=true, start=0),
    w(fixed=true, start=0),
    n=na) annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
  Modelica.Mechanics.MultiBody.Parts.Rotor1D       inertia2(J=18.2, n=nb)
    annotation (Placement(transformation(extent={{50,60},{70,80}})));
  Modelica.Mechanics.MultiBody.Parts.BevelGear1D bevelGear(
    ratio=10,
    n_a=na,
    n_b=nb) annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(useAxisFlange=true, n={
        1,0,0},
    stateSelect=StateSelect.always,
    phi(fixed=true),
    w(fixed=true))
    annotation (Placement(transformation(extent={{-60,-30},{-40,-50}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(useAxisFlange=true, n={
        0,1,0},
    stateSelect=StateSelect.always,
    phi(fixed=true),
    w(fixed=true))
                annotation (Placement(transformation(extent={{-20,-30},{0,-50}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute3(useAxisFlange=true, n={
        0,0,1},
    stateSelect=StateSelect.always,
    phi(fixed=true),
    w(fixed=true))
                annotation (Placement(transformation(extent={{20,-30},{40,-50}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque1
    annotation (Placement(transformation(extent={{-66,-75},{-56,-65}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque2
    annotation (Placement(transformation(extent={{-24,-75},{-14,-65}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque3
    annotation (Placement(transformation(extent={{16,-75},{26,-65}})));
  Modelica.Blocks.Sources.Sine sine1(amplitude=110, f=5)
    annotation (Placement(transformation(extent={{-86,-76},{-74,-64}})));
  Modelica.Blocks.Sources.Sine sine2(amplitude=120, f=6)
    annotation (Placement(transformation(extent={{-44,-76},{-32,-64}})));
  Modelica.Blocks.Sources.Sine sine3(amplitude=130, f=7)
    annotation (Placement(transformation(extent={{-2,-76},{10,-64}})));
  Modelica.Mechanics.MultiBody.Parts.Mounting1D mounting1D(n=na)
    annotation (Placement(transformation(extent={{-70,36},{-50,56}})));
  Modelica.Mechanics.Rotational.Sources.Torque torque(useSupport=true)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Sources.Sine sine4(amplitude=140, f=8)
    annotation (Placement(transformation(extent={{-92,64},{-80,76}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox bodyBox(
    r={0.1,0.1,0.1},
    length=0.1,
    width=0.1)
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  Sensors.AbsoluteAngularVelocity sensor1(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Sensors.CutTorque sensor2(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a,
      animation=false)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={10,20})));
  SI.AngularVelocity ws[3] = sensor1.w;
  SI.Power bevelGearPower;
equation
  bevelGearPower = (ws + der(bevelGear.flange_a.phi)*na)*bevelGear.flange_a.tau*na +
                   (ws + der(bevelGear.flange_b.phi)*nb)*bevelGear.flange_b.tau*nb +
                   ws*sensor2.torque;
  assert(abs(bevelGearPower) < 1e-3, "Error, energy balance of bevel gear is wrong");

  connect(inertia1.flange_b, bevelGear.flange_a) annotation (Line(
      points={{-10,70},{0,70}}));
  connect(bevelGear.flange_b, inertia2.flange_a) annotation (Line(
      points={{20,70},{50,70}}));
  connect(world.frame_b, revolute1.frame_a) annotation (Line(
      points={{-80,-40},{-60,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute1.frame_b, revolute2.frame_a) annotation (Line(
      points={{-40,-40},{-20,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute2.frame_b, revolute3.frame_a) annotation (Line(
      points={{0,-40},{20,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(torque1.flange, revolute1.axis) annotation (Line(
      points={{-56,-70},{-50,-70},{-50,-50}}));
  connect(torque2.flange, revolute2.axis) annotation (Line(
      points={{-14,-70},{-10,-70},{-10,-50}}));
  connect(torque3.flange, revolute3.axis) annotation (Line(
      points={{26,-70},{30,-70},{30,-50}}));
  connect(sine1.y, torque1.tau) annotation (Line(
      points={{-73.4,-70},{-67,-70}}, color={0,0,127}));
  connect(torque2.tau, sine2.y) annotation (Line(
      points={{-25,-70},{-31.4,-70}},color={0,0,127}));
  connect(torque3.tau, sine3.y) annotation (Line(
      points={{15,-70},{10.6,-70}}, color={0,0,127}));
  connect(torque.flange, inertia1.flange_a) annotation (Line(
      points={{-40,70},{-30,70}}));
  connect(torque.support, mounting1D.flange_b) annotation (Line(
      points={{-50,60},{-50,46}}));
  connect(mounting1D.frame_a, revolute3.frame_b) annotation (Line(
      points={{-60,36},{-60,0},{50,0},{50,-40},{40,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(torque.tau, sine4.y) annotation (Line(
      points={{-62,70},{-79.4,70}}, color={0,0,127}));
  connect(revolute3.frame_b, bodyBox.frame_a) annotation (Line(
      points={{40,-40},{60,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(inertia1.frame_a, revolute3.frame_b) annotation (Line(
      points={{-20,60},{-20,0},{50,0},{50,-40},{40,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(inertia2.frame_a, revolute3.frame_b) annotation (Line(
      points={{60,60},{60,0},{50,0},{50,-40},{40,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(bevelGear.frame_a, sensor1.frame_a) annotation (Line(
      points={{10,60},{10,40},{20,40}},
      color={95,95,95},
      thickness=0.5));
  connect(bevelGear.frame_a, sensor2.frame_b) annotation (Line(
      points={{10,60},{10,30}},
      color={95,95,95},
      thickness=0.5));
  connect(sensor2.frame_a, revolute3.frame_b) annotation (Line(
      points={{10,10},{10,0},{50,0},{50,-40},{40,-40}},
      color={95,95,95},
      thickness=0.5));
  annotation (Documentation(info="<html>
<p>
This model consists of a drive train with two inertias that are coupled by a bevel gear
(with 90 degree angle between the two gear flanges).
This drive train is mounted on a body that is rotated along three axes.
The drive train is modeled with 1D rotational elements that take into account 3D effects.
</p>

<p>
The bevelGear component consists of two rotational flanges (for the gear flanges) and one 3D frame
(for the support/mounting).
Since the bevelGear does not store energy, the power balance must hold (the total sum
of inflowing and outflowing energy must be zero). One has to be careful, when
computing the energy flow of hybrid 1D/3D component: The angular velocities of rotational flanges
are with respect to the support frame (so the moving body on which the drive train
is mounted). Therefore, when computing the energy flow, first the absolute angular velocities
of the flanges have to be calculated. In this example model, this is performed in the following way
(na and nb are the axes of rotations of the gear flanges, and ws is the
angular velocity of the support frame):
</p>

<blockquote><pre>
  import Modelica.Mechanics.MultiBody.Frames;

  SI.Power           bevelGearPower;
  SI.AngularVelocity ws[3] = Frames.angularVelocity2(bevelGear.frame_a.R);
<strong>equation</strong>
  bevelGearPower = (ws + der(bevelGear.flange_a.phi)*na)*bevelGear.flange_a.tau*na +
                   (ws + der(bevelGear.flange_b.phi)*nb)*bevelGear.flange_b.tau*nb +
                   ws*bevelGear.frame_a.t;
</pre></blockquote>
<p>
The total energy flow bevelGearPower must be zero. If a relative tolerance of 1e-4 is used
for simulation, bevelGearPower is in the order of 1e-8 (and smaller for a smaller relative
tolerance).
</p>
</html>"),
    experiment(StopTime=1.0));
end BevelGear1D;
