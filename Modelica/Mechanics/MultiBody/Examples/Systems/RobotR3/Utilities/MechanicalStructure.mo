within Modelica.Mechanics.MultiBody.Examples.Systems.RobotR3.Utilities;
model MechanicalStructure
  "Model of the mechanical part of the r3 robot (without animation)"
  import Modelica.Units.Conversions.to_unit1;

  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter SI.Mass mLoad(min=0)=15 "Mass of load";
  parameter SI.Position rLoad[3]={0,0.25,0}
    "Distance from last flange to load mass";
  parameter SI.Acceleration g=9.81 "Gravity acceleration";
  SI.Angle q[6] "Joint angles";
  SI.AngularVelocity qd[6] "Joint speeds";
  SI.AngularAcceleration qdd[6] "Joint accelerations";
  SI.Torque tau[6] "Joint driving torques";
  //r0={0,0.351,0},

  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis1
    annotation (Placement(transformation(extent={{-210,-160},{-190,-140}}), iconTransformation(extent={{-210,-160},{-190,-140}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis2
    annotation (Placement(transformation(extent={{-210,-100},{-190,-80}}), iconTransformation(extent={{-210,-100},{-190,-80}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis3
    annotation (Placement(transformation(extent={{-210,-40},{-190,-20}}), iconTransformation(extent={{-210,-40},{-190,-20}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis4
    annotation (Placement(transformation(extent={{-210,20},{-190,40}}), iconTransformation(extent={{-210,20},{-190,40}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis5
    annotation (Placement(transformation(extent={{-210,80},{-190,100}}), iconTransformation(extent={{-210,80},{-190,100}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a axis6
    annotation (Placement(transformation(extent={{-210,140},{-190,160}}), iconTransformation(extent={{-210,140},{-190,160}})));
  inner Modelica.Mechanics.MultiBody.World world(
    g=(g)*Modelica.Math.Vectors.length(({0,-1,0})),
    n={0,-1,0},
    animateWorld=false,
    animateGravity=false,
    enableAnimation=animation)
    annotation (Placement(transformation(extent={{40,-170},{20,-150}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute r1(
    n={0,1,0},
    useAxisFlange=true,
    animation=animation)
    annotation (Placement(transformation(
        origin={-80,-140},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute r2(
    n={1,0,0},
    useAxisFlange=true,
    animation=animation)
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute r3(
    n={1,0,0},
    useAxisFlange=true,
    animation=animation)
    annotation (Placement(transformation(
        origin={-50,-50},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Mechanics.MultiBody.Joints.Revolute r4(
    n={0,1,0},
    useAxisFlange=true,
    animation=animation)
    annotation (Placement(transformation(
        origin={-80,0},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute r5(
    n={1,0,0},
    useAxisFlange=true,
    animation=animation)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute r6(
    n={0,1,0},
    useAxisFlange=true,
    animation=animation)
    annotation (Placement(transformation(
        origin={-20,100},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape b0(
    r={0,0.351,0},
    shapeType="modelica://Modelica/Resources/Data/Shapes/RobotR3/b0.dxf",
    r_shape={0,0,0},
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    length=0.225,
    width=0.3,
    height=0.3,
    color={0,0,255},
    animation=animation,
    animateSphere=false,
    r_CM={0,0,0},
    m=1)
    annotation (Placement(transformation(
        extent={{-20,-170},{-40,-150}})));
  Modelica.Mechanics.MultiBody.Parts.BodyShape b1(
    r={0,0.324,0.3},
    I_22=1.16,
    shapeType="modelica://Modelica/Resources/Data/Shapes/RobotR3/b1.dxf",
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    length=0.25,
    width=0.15,
    height=0.2,
    animation=animation,
    animateSphere=false,
    color={255,0,0},
    r_CM={0,0,0},
    m=1) annotation (Placement(transformation(
        origin={-80,-110},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape b2(
    r={0,0.65,0},
    r_CM={0.172,0.205,0},
    m=56.5,
    I_11=2.58,
    I_22=0.64,
    I_33=2.73,
    I_21=-0.46,
    shapeType="modelica://Modelica/Resources/Data/Shapes/RobotR3/b2.dxf",
    r_shape={0,0,0},
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    length=0.5,
    width=0.2,
    height=0.15,
    animation=animation,
    animateSphere=false,
    color={255,178,0}) annotation (Placement(transformation(
        origin={-20,-70},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape b3(
    r={0,0.414,-0.155},
    r_CM={0.064,-0.034,0},
    m=26.4,
    I_11=0.279,
    I_22=0.245,
    I_33=0.413,
    I_21=-0.070,
    shapeType="modelica://Modelica/Resources/Data/Shapes/RobotR3/b3.dxf",
    r_shape={0,0,0},
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    length=0.15,
    width=0.15,
    height=0.15,
    animation=animation,
    animateSphere=false,
    color={255,0,0}) annotation (Placement(transformation(
        origin={-80,-30},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape b4(
    r={0,0.186,0},
    r_CM={0,0,0},
    m=28.7,
    I_11=1.67,
    I_22=0.081,
    I_33=1.67,
    shapeType="modelica://Modelica/Resources/Data/Shapes/RobotR3/b4.dxf",
    r_shape={0,0,0},
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    length=0.73,
    width=0.1,
    height=0.1,
    animation=animation,
    animateSphere=false,
    color={255,178,0}) annotation (Placement(transformation(
        origin={-80,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape b5(
    r={0,0.125,0},
    r_CM={0,0,0},
    m=5.2,
    I_11=1.25,
    I_22=0.81,
    I_33=1.53,
    shapeType="modelica://Modelica/Resources/Data/Shapes/RobotR3/b5.dxf",
    r_shape={0,0,0},
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    length=0.225,
    width=0.075,
    height=0.1,
    animation=animation,
    animateSphere=false,
    color={0,0,255}) annotation (Placement(transformation(
        origin={-20,70},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape b6(
    r={0,0,0},
    r_CM={0.05,0.05,0.05},
    m=0.5,
    shapeType="modelica://Modelica/Resources/Data/Shapes/RobotR3/b6.dxf",
    r_shape={0,0,0},
    lengthDirection={1,0,0},
    widthDirection={0,1,0},
    animation=animation,
    animateSphere=false,
    color={0,0,255}) annotation (Placement(transformation(
        origin={-20,130},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape load(
    r={0,0,0},
    r_CM=rLoad,
    m=mLoad,
    r_shape={0,0,0},
    widthDirection={1,0,0},
    width=0.05,
    height=0.05,
    color={255,0,0},
    lengthDirection = to_unit1(rLoad),
    length=Modelica.Math.Vectors.length(rLoad),
    animation=animation)
    annotation (Placement(transformation(
        origin={-20,160},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  q = {r1.phi,r2.phi,r3.phi,r4.phi,r5.phi,r6.phi};
  qd = der(q);
  qdd = der(qd);
  tau = {r1.tau, r2.tau, r3.tau, r4.tau, r5.tau, r6.tau};

  connect(load.frame_a, b6.frame_b)
    annotation (Line(
      points={{-20,150},{-20,140}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, b0.frame_a) annotation (Line(
      points={{20,-160},{-20,-160}},
      color={95,95,95},
      thickness=0.5));
  connect(b0.frame_b, r1.frame_a) annotation (Line(
      points={{-40,-160},{-80,-160},{-80,-150}},
      color={95,95,95},
      thickness=0.5));
  connect(b1.frame_b, r2.frame_a) annotation (Line(
      points={{-80,-100},{-80,-90},{-60,-90}},
      color={95,95,95},
      thickness=0.5));
  connect(r1.frame_b, b1.frame_a) annotation (Line(
      points={{-80,-130},{-80,-120}},
      color={95,95,95},
      thickness=0.5));
  connect(r2.frame_b, b2.frame_a) annotation (Line(
      points={{-40,-90},{-20,-90},{-20,-80}},
      color={95,95,95},
      thickness=0.5));
  connect(b2.frame_b, r3.frame_a) annotation (Line(
      points={{-20,-60},{-20,-50},{-40,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(r2.axis, axis2) annotation (Line(points={{-50,-80},{-50,-76},{-180,-76},{-180,-90},{-200,-90}}));
  connect(r1.axis, axis1) annotation (Line(points={{-90,-140},{-180,-140},{-180,-150},{-200,-150}}));
  connect(r3.frame_b, b3.frame_a) annotation (Line(
      points={{-60,-50},{-80,-50},{-80,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(b3.frame_b, r4.frame_a) annotation (Line(
      points={{-80,-20},{-80,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(r3.axis, axis3)
    annotation (Line(points={{-50,-60},{-50,-64},{-180,-64},{-180,-30},{-200,-30}}));
  connect(r4.axis, axis4)
    annotation (Line(points={{-90,0},{-180,0},{-180,30},{-200,30}}));
  connect(r4.frame_b, b4.frame_a)
    annotation (Line(
      points={{-80,10},{-80,20}},
      color={95,95,95},
      thickness=0.5));
  connect(b4.frame_b, r5.frame_a) annotation (Line(
      points={{-80,40},{-80,50},{-60,50}},
      color={95,95,95},
      thickness=0.5));
  connect(r5.axis, axis5) annotation (Line(points={{-50,60},{-50,90},{-200,90}}));
  connect(r5.frame_b, b5.frame_a) annotation (Line(
      points={{-40,50},{-20,50},{-20,60}},
      color={95,95,95},
      thickness=0.5));
  connect(b5.frame_b, r6.frame_a) annotation (Line(
      points={{-20,80},{-20,90}},
      color={95,95,95},
      thickness=0.5));
  connect(r6.axis, axis6)
    annotation (Line(points={{-30,100},{-180,100},{-180,150},{-200,150}}));
  connect(r6.frame_b, b6.frame_a)
    annotation (Line(
      points={{-20,110},{-20,120}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    Documentation(info="<html>
<p>
This model contains the mechanical components of the r3 robot
(multibody system).
</p>
</html>"),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-200,-200},{200,200}}), graphics={
        Rectangle(
          extent={{-200,200},{200,-200}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-200,250},{200,210}},
          textString="%name",
          textColor={0,0,255}),
        Bitmap(extent={{-130,-195},{195,195}},
          fileName="modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Systems/RobotR3/robot_kr15.png"),
        Text(
          extent={{-190,-130},{-130,-170}},
          textString="1"),
        Text(
          extent={{-190,-70},{-130,-110}},
          textString="2"),
        Text(
          extent={{-190,-10},{-130,-50}},
          textString="3"),
        Text(
          extent={{-190,48},{-130,8}},
          textString="4"),
        Text(
          extent={{-190,110},{-130,70}},
          textString="5"),
        Text(
          extent={{-190,170},{-130,130}},
          textString="6")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-200,-200},{200,200}})));
end MechanicalStructure;
