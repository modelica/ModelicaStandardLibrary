within Modelica.Mechanics.MultiBody.Examples.Loops.Utilities;
model Cylinder "Cylinder with rod and crank of a combustion engine"
  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter SI.Length cylinderTopPosition=0.42
    "Length from crank shaft to end of cylinder.";
  parameter SI.Length pistonLength=0.1 "Length of cylinder";
  parameter SI.Length rodLength=0.2 "Length of rod";
  parameter SI.Length crankLength=0.2 "Length of crank shaft in x direction";
  parameter SI.Length crankPinOffset=0.1
    "Offset of crank pin from center axis";
  parameter SI.Length crankPinLength=0.1
    "Offset of crank pin from center axis";
  parameter SI.Angle cylinderInclinationAngle=0 "Inclination of cylinder";
  parameter SI.Angle crankAngleOffset=0 "Offset for crank angle";
  parameter SI.Length cylinderLength=cylinderTopPosition - (pistonLength +
      rodLength - crankPinOffset) "Maximum length of cylinder volume";

  Modelica.Mechanics.MultiBody.Parts.BodyCylinder piston(
    diameter=0.1,
    r={0,pistonLength,0},
    color={180,180,180},
    animation=animation) annotation (Placement(transformation(
        origin={20,30},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.BodyBox connectingRod(
    widthDirection={1,0,0},
    height=0.06,
    color={0,0,200},
    width=0.02,
    r_shape={0,-0.02,0},
    r={0,rodLength,0},
    animation=animation) annotation (Placement(transformation(
        origin={60,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Joints.Revolute b2(
    n={1,0,0},
    cylinderLength=0.02,
    animation=animation,
    cylinderDiameter=0.055) annotation (Placement(transformation(extent={{30,0},{50,20}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox crank4(
    height=0.05,
    widthDirection={1,0,0},
    width=0.02,
    r={0,-crankPinOffset,0},
    animation=animation)
    annotation (Placement(transformation(
        origin={50,-70},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder crank3(
    r_shape={-0.01,0,0},
    length=0.12,
    diameter=0.03,
    r={crankPinLength,0,0},
    color={180,180,180},
    animation=animation) annotation (Placement(transformation(extent={{10.5,-60},{30.5,-40}})));
  Modelica.Mechanics.MultiBody.Parts.BodyCylinder crank1(
    diameter=0.05,
    r_shape={-0.01,0,0},
    length=0.12,
    r={crankLength - crankPinLength,0,0},
    color={180,180,180},
    animation=animation) annotation (Placement(transformation(extent={{-50,-100},{-30,-80}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox crank2(
    height=0.05,
    widthDirection={1,0,0},
    width=0.02,
    r={0,crankPinOffset,0},
    animation=animation) annotation (Placement(transformation(
        origin={-10,-70},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Joints.RevolutePlanarLoopConstraint b1(
    n={1,0,0},
    cylinderLength=0.02,
    animation=animation,
    cylinderDiameter=0.055) annotation (Placement(transformation(extent={{30,-20},{50,-40}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation mid(r={crankPinLength/2,0,0}, animation=
        false) annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic cylinder(useAxisFlange=true,
    s(start=-0.3),
    n={0,-1,0},
    boxWidth=0.02) annotation (Placement(transformation(
        origin={20,60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation mounting(r={crankLength,0,0}, animation=
        false) annotation (Placement(transformation(extent={{0,90},{20,110}})));
  Modelica.Mechanics.MultiBody.Parts.FixedRotation cylinderInclination(
    r={crankLength - crankPinLength/2,0,0},
    n_y={0,Modelica.Math.cos(cylinderInclinationAngle),Modelica.Math.sin(cylinderInclinationAngle)},
    animation=false,
    rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Modelica.Mechanics.MultiBody.Parts.FixedRotation crankAngle1(
    n_y={0,Modelica.Math.cos(crankAngleOffset),Modelica.Math.sin(crankAngleOffset)},
    animation=false,
    rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors)
    annotation (Placement(transformation(extent={{-90,-100},{-70,-80}})));
  Modelica.Mechanics.MultiBody.Parts.FixedRotation crankAngle2(
    n_y={0,Modelica.Math.cos(-crankAngleOffset),Modelica.Math.sin(-crankAngleOffset)},
    animation=false,
    rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.TwoAxesVectors)
    annotation (Placement(transformation(extent={{70,-100},{90,-80}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation cylinderTop(r={0,cylinderTopPosition,0},
      animation=false) annotation (Placement(transformation(
        origin={-30,60},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  GasForce2 gasForce(L=cylinderLength, d=0.1)
    annotation (Placement(transformation(
        origin={50,60},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Interfaces.Frame_a cylinder_a annotation (Placement(transformation(extent={{-116,84},{-84,116}})));
  Interfaces.Frame_a cylinder_b annotation (Placement(transformation(extent={{84,84},{116,116}})));
  Interfaces.Frame_a crank_a annotation (Placement(transformation(extent={{-116,-116},{-84,-84}})));
  Interfaces.Frame_a crank_b annotation (Placement(transformation(extent={{84,-116},{116,-84}})));
equation
  connect(b1.frame_a, mid.frame_b) annotation (Line(
      points={{30,-30},{20,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(connectingRod.frame_a, b1.frame_b) annotation (Line(
      points={{60,-20},{60,-30},{50,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder.frame_b, piston.frame_b) annotation (Line(
      points={{20,50},{20,40}},
      color={95,95,95},
      thickness=0.5));
  connect(crank1.frame_a, crankAngle1.frame_b)
    annotation (Line(
      points={{-50,-90},{-70,-90}},
      color={95,95,95},
      thickness=0.5));
  connect(b2.frame_a, piston.frame_a) annotation (Line(
      points={{30,10},{20,10},{20,20}},
      color={95,95,95},
      thickness=0.5));
  connect(connectingRod.frame_b, b2.frame_b) annotation (Line(
      points={{60,0},{60,10},{50,10}},
      color={95,95,95},
      thickness=0.5));
  connect(crank4.frame_b, crankAngle2.frame_a) annotation (Line(
      points={{50,-80},{50,-90},{70,-90}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinderInclination.frame_b, cylinderTop.frame_a)
    annotation (Line(
      points={{-50,40},{-30,40},{-30,50}},
      color={95,95,95},
      thickness=0.5));
  connect(crank1.frame_b, crank2.frame_a) annotation (Line(
      points={{-30,-90},{-10,-90},{-10,-80}},
      color={95,95,95},
      thickness=0.5));
  connect(crank3.frame_b, crank4.frame_a) annotation (Line(
      points={{30.5,-50},{50,-50},{50,-60}},
      color={95,95,95},
      thickness=0.5));
  connect(crank3.frame_a, crank2.frame_b) annotation (Line(
      points={{10.5,-50},{-10,-50},{-10,-60}},
      color={95,95,95},
      thickness=0.5));
  connect(crank2.frame_b, mid.frame_a) annotation (Line(
      points={{-10,-60},{-10,-30},{0,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinderTop.frame_b, cylinder.frame_a) annotation (Line(
      points={{-30,70},{-30,80},{20,80},{20,70}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinderInclination.frame_a, cylinder_a) annotation (Line(
      points={{-70,40},{-80,40},{-80,100},{-100,100}},
      color={95,95,95},
      thickness=0.5));
  connect(mounting.frame_a, cylinder_a) annotation (Line(
      points={{0,100},{-100,100}},
      color={95,95,95},
      thickness=0.5));
  connect(mounting.frame_b, cylinder_b) annotation (Line(
      points={{20,100},{100,100}},
      color={95,95,95},
      thickness=0.5));
  connect(crankAngle1.frame_a, crank_a) annotation (Line(
      points={{-90,-90},{-100,-90},{-100,-100}},
      color={95,95,95},
      thickness=0.5));
  connect(crankAngle2.frame_b, crank_b) annotation (Line(
      points={{90,-90},{100,-90},{100,-100}},
      color={95,95,95},
      thickness=0.5));

  connect(cylinder.axis, gasForce.flange_b) annotation (Line(points={{26,52},{30,52},{30,50},{50,50}},
                                                                                       color={0,127,0}));
  connect(cylinder.support, gasForce.flange_a) annotation (Line(points={{26,64},{30,64},{30,70},{50,70}},     color={0,127,0}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-150,160},{150,120}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{-100,-100},{100,-100}},
          thickness=0.5),
        Polygon(
          points={{-60,-60},{-60,64},{60,64},{60,-60},{100,-60},{100,114},{-100,114},{-100,-60},{-60,-60}},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-58,53},{58,-23}},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-60,45},{60,39}},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,31},{60,25}},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,19},{60,13}},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-57,-23},{-40,-11},{40,-11},{57,-23},{-57,-23}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,255}),
        Ellipse(
          extent={{-8,6},{4,-6}},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-40,-140},{40,-60}}, lineColor={192,192,192}),
        Line(
          points={{0,-100},{26,-70},{-2,0}},
          thickness=1)}),   Documentation(info="<html>
<p>
Cylinder with rod and crank of a combustion engine.
Used as submodel in <a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.EngineV6\">Loops.EngineV6</a>.
</p>
</html>"));
end Cylinder;
