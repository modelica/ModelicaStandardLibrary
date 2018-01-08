within Modelica.Mechanics.MultiBody.Examples.Elementary;
model RollingWheelSetPulling "Rolling wheel set that is pulled by a force"
   extends Modelica.Icons.Example;

  Modelica.Mechanics.MultiBody.Forces.WorldForce force(animation=false)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Mechanics.MultiBody.Visualizers.Ground ground(
                length=3)
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
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=[0,1,0,0; 1,1,
        0,0; 2,0,2,0; 3,0,2,0])
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation fixedTranslation(
                       r={0.2,0,0},
    animation=true,
    width=0.04)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
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
        origin={50,40})));
equation
  connect(combiTimeTable.y, force.force) annotation (Line(
      points={{-39,40},{-22,40}},                   color={0,0,127}));
  connect(fixedTranslation.frame_a, wheelSet.frameMiddle) annotation (Line(
      points={{0,10},{-6,10},{-6,-8},{-10,-8},{-10,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(fixedTranslation.frame_b, body.frame_a) annotation (Line(
      points={{20,10},{40,10}},
      color={95,95,95},
      thickness=0.5));
  connect(force.frame_b, fixedTranslation.frame_b) annotation (Line(
      points={{0,40},{30,40},{30,10},{20,10}},
      color={95,95,95},
      thickness=0.5));
  connect(shape.frame_a, fixedTranslation.frame_b) annotation (Line(
      points={{40,40},{30,40},{30,10},{20,10}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=3),
    Documentation(info="<html>
<p>
Demonstrates how a RollingWheelSet (two wheels rigidly coupled together) is rolling
on ground when pulled by an external force..
</p>
</html>"));
end RollingWheelSetPulling;
