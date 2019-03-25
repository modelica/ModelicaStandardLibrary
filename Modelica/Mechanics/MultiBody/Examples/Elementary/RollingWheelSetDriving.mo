within Modelica.Mechanics.MultiBody.Examples.Elementary;
model RollingWheelSetDriving
  "Rolling wheel set that is driven by torques driving the wheels"
   extends Modelica.Icons.Example;

  inner Modelica.Mechanics.MultiBody.World world(
    label2="z",
    n={0,0,-1},
    animateGround=true,
    groundLength_u=3,
    groundColor={130,200,130})
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Modelica.Mechanics.MultiBody.Parts.RollingWheelSet wheelSet(
    wheelRadius=0.1,
    wheelMass=0.5,
    wheel_I_axis=0.01,
    wheel_I_long=0.02,
    wheelDistance=0.5,
    x(start=0.1, fixed=true),
    y(start=0.1, fixed=true),
    phi(fixed=true),
    theta1(fixed=true),
    theta2(fixed=true),
    der_theta1(fixed=true),
    der_theta2(fixed=true))
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Mechanics.MultiBody.Parts.Body body(m=0.01, r_CM={0,0,0},
    animation=false)
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(
                       r={0.2,0,0},
    animation=true,
    width=0.04)
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Blocks.Sources.Sine sine1(freqHz=1, amplitude=2)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Sources.Sine sine2(
    freqHz=1,
    amplitude=2,
    phase=1.5707963267949)
    annotation (Placement(transformation(extent={{60,30},{40,50}})));
  Modelica.Mechanics.Rotational.Sources.Torque2 torque1
    annotation (Placement(transformation(extent={{-40,14},{-20,34}})));
  Modelica.Mechanics.Rotational.Sources.Torque2 torque2
    annotation (Placement(transformation(extent={{24,14},{4,34}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape shape(
    final lengthDirection={0,1,0},
    final widthDirection={1,0,0},
    final shapeType="pipe",
    final r_shape={0,-wheelSet.wheelWidth,0},
    final length=2*wheelSet.wheelWidth,
    final width=2*wheelSet.wheelRadius,
    final height=2*wheelSet.wheelRadius,
    final color={0,128,255},
    final extra=0.8) annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},
        origin={70,14})));
equation
  connect(fixedTranslation.frame_a, wheelSet.frameMiddle) annotation (Line(
      points={{20,-10},{10,-10},{10,-4},{-10,-4},{-10,-2}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{40,-10},{60,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(wheelSet.axis1, torque1.flange_a) annotation (Line(
      points={{-20,10},{-40,10},{-40,24}}));
  connect(torque1.flange_b, wheelSet.support) annotation (Line(
      points={{-20,24},{-10,24},{-10,8}}));
  connect(wheelSet.axis2, torque2.flange_a) annotation (Line(
      points={{0,10},{24,10},{24,24}}));
  connect(wheelSet.support, torque2.flange_b) annotation (Line(
      points={{-10,8},{-10,24},{4,24}}));
  connect(sine1.y, torque1.tau) annotation (Line(
      points={{-59,40},{-30,40},{-30,28}}, color={0,0,127}));
  connect(sine2.y, torque2.tau) annotation (Line(
      points={{39,40},{14,40},{14,28}}, color={0,0,127}));
  connect(shape.frame_a, fixedTranslation.frame_b) annotation (Line(
      points={{60,14},{48,14},{48,-10},{40,-10}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=3),
    Documentation(info="<html>
<p>
Demonstrates how a RollingWheelSet (two wheels rigidly coupled together) is rolling
on ground when driven by some external torques.
</p>
</html>"));
end RollingWheelSetDriving;
