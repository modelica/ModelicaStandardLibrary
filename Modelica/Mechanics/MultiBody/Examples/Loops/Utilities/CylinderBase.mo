within Modelica.Mechanics.MultiBody.Examples.Loops.Utilities;
model CylinderBase "One cylinder with analytic handling of kinematic loop"
  parameter Boolean animation=true "= true, if animation shall be enabled";
  parameter SI.Length cylinderTopPosition=0.42
    "Length from crank shaft to end of cylinder.";
  parameter SI.Length crankLength=0.14 "Length of crank shaft in x direction";
  parameter SI.Length crankPinOffset=0.05
    "Offset of crank pin from center axis";
  parameter SI.Length crankPinLength=0.1
    "Offset of crank pin from center axis";
  parameter Modelica.Units.NonSI.Angle_deg cylinderInclinationAngle=0
    "Inclination of cylinder";
  parameter Modelica.Units.NonSI.Angle_deg crankAngleOffset=0
    "Offset for crank angle";
  parameter SI.Length pistonLength=0.1 "Length of cylinder"
    annotation (Dialog(group="Piston"));
  parameter SI.Length pistonCenterOfMass=pistonLength/2
    "Distance from frame_a to center of mass of piston"
    annotation (Dialog(group="Piston"));
  parameter SI.Mass pistonMass(min=0) = 6 "Mass of piston"
    annotation (Dialog(group="Piston"));
  parameter SI.Inertia pistonInertia_11(min=0) = 0.0088
    "Inertia 11 of piston with respect to center of mass frame, parallel to frame_a"
    annotation (Dialog(group="Piston"));
  parameter SI.Inertia pistonInertia_22(min=0) = 0.0076
    "Inertia 22 of piston with respect to center of mass frame, parallel to frame_a"
    annotation (Dialog(group="Piston"));
  parameter SI.Inertia pistonInertia_33(min=0) = 0.0088
    "Inertia 33 of piston with respect to center of mass frame, parallel to frame_a"
    annotation (Dialog(group="Piston"));

  parameter SI.Length rodLength=0.175 "Length of rod"
    annotation (Dialog(group="Rod"));
  parameter SI.Length rodCenterOfMass=rodLength/2
    "Distance from frame_a to center of mass of piston"
    annotation (Dialog(group="Rod"));
  parameter SI.Mass rodMass(min=0) = 1 "Mass of rod"
    annotation (Dialog(group="Rod"));
  parameter SI.Inertia rodInertia_11(min=0) = 0.006
    "Inertia 11 of rod with respect to center of mass frame, parallel to frame_a"
    annotation (Dialog(group="Rod"));
  parameter SI.Inertia rodInertia_22(min=0) = 0.0005
    "Inertia 22 of rod with respect to center of mass frame, parallel to frame_a"
    annotation (Dialog(group="Rod"));
  parameter SI.Inertia rodInertia_33(min=0) = 0.006
    "Inertia 33 of rod with respect to center of mass frame, parallel to frame_a"
    annotation (Dialog(group="Rod"));
  final parameter SI.Length cylinderLength=cylinderTopPosition - (
      pistonLength + rodLength - crankPinOffset)
    "Maximum length of cylinder volume";

  Modelica.Mechanics.MultiBody.Parts.FixedTranslation mid(animation=false, r={crankLength -
        crankPinLength/2,crankPinOffset,0})
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation mounting(r={crankLength,0,0}, animation=
        false) annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Mechanics.MultiBody.Parts.FixedRotation cylinderInclination(
    r={crankLength - crankPinLength/2,0,0},
    animation=false,
    rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis,
    n={1,0,0},
    angle=cylinderInclinationAngle) annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Mechanics.MultiBody.Parts.FixedRotation crankAngle(
    animation=false,
    rotationType=Modelica.Mechanics.MultiBody.Types.RotationTypes.RotationAxis,
    n={1,0,0},
    angle=crankAngleOffset) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-70})));
  Joints.Assemblies.JointRRP jointRRP(
    n_a={1,0,0},
    n_b={0,-1,0},
    rRod1_ia={0,rodLength,0},
    animation=false,
    rRod2_ib=-{0,pistonLength,0},
    s_offset=-cylinderTopPosition)
    annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape connectingRod(
    animation=animation,
    r={0,rodLength,0},
    r_CM={0,rodLength/2,0},
    shapeType="modelica://Modelica/Resources/Data/Shapes/Engine/rod.dxf",
    lengthDirection={1,0,0},
    widthDirection={0,0,-1},
    length=rodLength/1.75,
    width=rodLength/1.75,
    height=rodLength/1.75,
    color={155,155,155},
    extra=1,
    r_shape={0,0,0},
    animateSphere=false,
    m=rodMass,
    I_11=rodInertia_11,
    I_22=rodInertia_22,
    I_33=rodInertia_33) annotation (Placement(transformation(
        origin={50,0},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.BodyShape piston(
    animation=animation,
    r={0,pistonLength,0},
    r_CM={0,pistonLength/2,0},
    shapeType="modelica://Modelica/Resources/Data/Shapes/Engine/piston.dxf",
    length=0.08,
    width=0.08,
    height=0.08,
    extra=1,
    lengthDirection={1,0,0},
    widthDirection={0,0,-1},
    color={180,180,180},
    animateSphere=false,
    m=pistonMass,
    I_11=pistonInertia_11,
    I_22=pistonInertia_22,
    I_33=pistonInertia_33) annotation (Placement(transformation(
        origin={50,30},
        extent={{10,10},{-10,-10}},
        rotation=270)));
  GasForce2 gasForce(L=cylinderLength, d=0.1)
    annotation (Placement(transformation(
        origin={10,60},
        extent={{10,10},{-10,-10}},
        rotation=180)));

  Modelica.Mechanics.MultiBody.Parts.FixedTranslation crank(animation=false, r={crankLength,0,0})
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Interfaces.Frame_a cylinder_a annotation (Placement(transformation(extent={{-116,84},
            {-84,116}})));
  Interfaces.Frame_a cylinder_b annotation (Placement(transformation(extent={{84,84},
            {116,116}})));
  Interfaces.Frame_a crank_a annotation (Placement(transformation(extent={{-116,
            -116},{-84,-84}})));
  Interfaces.Frame_a crank_b annotation (Placement(transformation(extent={{84,-116},
            {116,-84}})));
equation

  connect(jointRRP.frame_ia, connectingRod.frame_a) annotation (Line(
      points={{20,-16},{50,-16},{50,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(mid.frame_b, jointRRP.frame_a) annotation (Line(
      points={{-40,-30},{-1.33227e-015,-30},{-1.33227e-015,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(jointRRP.frame_ib, piston.frame_b) annotation (Line(
      points={{20,16},{30,16},{30,50},{50,50},{50,40}},
      color={95,95,95},
      thickness=0.5));
  connect(jointRRP.frame_b, cylinderInclination.frame_b) annotation (Line(
      points={{1.22125e-015,20},{0,20},{0,30},{-40,30}},
      color={95,95,95},
      thickness=0.5));
  connect(crankAngle.frame_b, mid.frame_a) annotation (Line(
      points={{-70,-60},{-70,-30},{-60,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder_a, cylinderInclination.frame_a) annotation (Line(
      points={{-100,100},{-70,100},{-70,30},{-60,30}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder_a, mounting.frame_a) annotation (Line(
      points={{-100,100},{-10,100}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder_b, mounting.frame_b) annotation (Line(
      points={{100,100},{10,100}},
      color={95,95,95},
      thickness=0.5));
  connect(crankAngle.frame_a, crank_a) annotation (Line(
      points={{-70,-80},{-70,-100},{-100,-100}},
      color={95,95,95},
      thickness=0.5));
  connect(crank_a, crank.frame_a) annotation (Line(
      points={{-100,-100},{-10,-100}},
      color={95,95,95},
      thickness=0.5));
  connect(crank.frame_b, crank_b) annotation (Line(
      points={{10,-100},{100,-100}},
      color={95,95,95},
      thickness=0.5));
  connect(gasForce.flange_a, jointRRP.bearing) annotation (Line(points={{0,60},{0,40},{8,40},{8,20}}, color={0,127,0}));
  connect(gasForce.flange_b, jointRRP.axis) annotation (Line(points={{20,60},{20,40},{16,40},{16,20}}, color={0,127,0}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
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
          thickness=1),
        Text(
          extent={{-150,160},{150,120}},
          textString="%name",
          textColor={0,0,255}),
        Line(
          points={{-100,-100},{100,-100}},
          thickness=0.5)}), Documentation(info="<html>
<p>
Slider-crank mechanism with analytic handling of kinematic loop to model one cylinder in an engine.
</p>
</html>"));
end CylinderBase;
