within Modelica.Mechanics.MultiBody.Examples.Elementary;
model RollingWheelSetDriving
  "Rolling wheel set that is driven by torques driving the wheels"
   extends Modelica.Icons.Example;

  Modelica.Mechanics.MultiBody.Visualizers.Ground ground(
                length=3, groundColor={0,255,0})
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  inner Modelica.Mechanics.MultiBody.World world(label2="z", n={0,0,-1})
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
    annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Modelica.Mechanics.MultiBody.Parts.Body body(m=0.01, r_CM={0,0,0},
    animation=false)
    annotation (Placement(transformation(extent={{40,56},{60,76}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(
                       r={0.2,0,0},
    animation=true,
    width=0.04)
    annotation (Placement(transformation(extent={{0,56},{20,76}})));
  Modelica.Blocks.Sources.Sine sine1(freqHz=1, amplitude=2)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.Blocks.Sources.Sine sine2(
    freqHz=1,
    amplitude=2,
    phase=1.5707963267949)
    annotation (Placement(transformation(extent={{60,20},{40,40}})));
  Modelica.Mechanics.Rotational.Sources.Torque2 torque1
    annotation (Placement(transformation(extent={{-40,4},{-20,24}})));
  Modelica.Mechanics.Rotational.Sources.Torque2 torque2
    annotation (Placement(transformation(extent={{24,4},{4,24}})));
  Modelica.Mechanics.MultiBody.Visualizers.FixedShape shape(
    final lengthDirection={0,1,0},
    final widthDirection={1,0,0},
    final shapeType="pipe",
    final r_shape={0,-wheelSet.wheelWidth,0},
    final length=2*wheelSet.wheelWidth,
    final width=2*wheelSet.wheelRadius,
    final height=2*wheelSet.wheelRadius,
    final color={0,128,255},
    final extra=0.8)        annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},
        rotation=0,
        origin={50,90})));
equation
  connect(fixedTranslation.frame_a, wheelSet.frameMiddle) annotation (Line(
      points={{0,66},{-8,66},{-8,-6},{-10,-6},{-10,-10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{20,66},{40,66}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(wheelSet.axis1, torque1.flange_a) annotation (Line(
      points={{-20,0},{-40,0},{-40,14}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(torque1.flange_b, wheelSet.support) annotation (Line(
      points={{-20,14},{-10,14},{-10,-1.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(wheelSet.axis2, torque2.flange_a) annotation (Line(
      points={{0,0},{24,0},{24,14}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(wheelSet.support, torque2.flange_b) annotation (Line(
      points={{-10,-1.8},{-10,14},{4,14}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sine1.y, torque1.tau) annotation (Line(
      points={{-59,30},{-30,30},{-30,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sine2.y, torque2.tau) annotation (Line(
      points={{39,30},{14,30},{14,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(shape.frame_a, fixedTranslation.frame_b) annotation (Line(
      points={{40,90},{28,90},{28,66},{20,66}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(StopTime=3),
    Documentation(info="<html>

</html>"));
end RollingWheelSetDriving;
