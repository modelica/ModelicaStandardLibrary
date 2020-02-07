within Modelica.Mechanics.MultiBody.Examples.Loops.Utilities;
model EngineV6_analytic "V6 engine with analytic loop handling"
  parameter Boolean animation=true "= true, if animation shall be enabled";
  replaceable model Cylinder = Cylinder_analytic_CAD constrainedby CylinderBase
                 "Cylinder type"
       annotation(Documentation(info="<html>
<p>
Model of one cylinder of an engine with analytic loop handling of the slider crank mechanism.
</p>
</html>"));

  Cylinder cylinder1(
    crankAngleOffset=-30,
    cylinderInclinationAngle=-30,
    animation=animation) annotation (Placement(transformation(extent={{-90,
            -10},{-70,10}})));
  Cylinder cylinder2(
    crankAngleOffset=90,
    cylinderInclinationAngle=30,
    animation=animation) annotation (Placement(transformation(extent={{-60,
            -10},{-40,10}})));
  Cylinder cylinder3(
    cylinderInclinationAngle=-30,
    animation=animation,
    crankAngleOffset=210)
                         annotation (Placement(transformation(extent={{-30,
            -10},{-10,10}})));
  Cylinder cylinder4(
    cylinderInclinationAngle=30,
    animation=animation,
    crankAngleOffset=210)
                         annotation (Placement(transformation(extent={{0,-10},
            {20,10}})));
  Cylinder cylinder5(
    cylinderInclinationAngle=-30,
    animation=animation,
    crankAngleOffset=90) annotation (Placement(transformation(extent={{30,-10},
            {50,10}})));
  Cylinder cylinder6(
    cylinderInclinationAngle=30,
    animation=animation,
    crankAngleOffset=-30)
                         annotation (Placement(transformation(extent={{60,-10},
            {80,10}})));
  Joints.Revolute bearing(useAxisFlange=true,
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.06,
    animation=true) annotation (Placement(transformation(extent={{-90,-40},{
            -70,-60}})));
  Parts.BodyShape crank(
    animation=false,
    r={0,0,0},
    r_CM={6*0.1/2,0,0},
    I_22=1.e-5,
    I_33=1.e-5,
    m=6*30,
    I_11=0.1) annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Interfaces.Frame_a frame_a
    annotation (Placement(transformation(
        origin={0,-101},
        extent={{-16,-16},{16,16}},
        rotation=270)));
equation
  connect(cylinder1.crank_b, cylinder2.crank_a)
    annotation (Line(
      points={{-70,-10},{-60,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder2.cylinder_a, cylinder1.cylinder_b) annotation (Line(
      points={{-60,10},{-70,10}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder3.cylinder_a, cylinder2.cylinder_b) annotation (Line(
      points={{-30,10},{-40,10}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder3.crank_a, cylinder2.crank_b)
    annotation (Line(
      points={{-30,-10},{-40,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder3.cylinder_b, cylinder4.cylinder_a) annotation (Line(
      points={{-10,10},{0,10}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder3.crank_b, cylinder4.crank_a)
    annotation (Line(
      points={{-10,-10},{0,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder4.cylinder_b, cylinder5.cylinder_a) annotation (Line(
      points={{20,10},{30,10}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder4.crank_b, cylinder5.crank_a)
    annotation (Line(
      points={{20,-10},{30,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder5.cylinder_b, cylinder6.cylinder_a) annotation (Line(
      points={{50,10},{60,10}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder5.crank_b, cylinder6.crank_a)
    annotation (Line(
      points={{50,-10},{60,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(bearing.frame_b, crank.frame_a)
    annotation (Line(
      points={{-70,-50},{-50,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(crank.frame_b, cylinder1.crank_a) annotation (Line(
      points={{-30,-50},{-20,-50},{-20,-30},{-90,-30},{-90,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(bearing.axis, flange_b) annotation (Line(points={{-80,-60},{-80,-70},{90,-70},{90,0},{110,0}}));
  connect(frame_a, bearing.frame_a) annotation (Line(
      points={{0,-101},{0,-80},{-98,-80},{-98,-50},{-90,-50}},
      color={95,95,95},
      thickness=0.5));
  connect(bearing.frame_a, cylinder1.cylinder_a) annotation (Line(
      points={{-90,-50},{-98,-50},{-98,10},{-90,10}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,145},{150,105}},
          textColor={0,0,255},
          textString="%name"),
        Bitmap(extent={{-97,-39},{99,75}}, fileName=
              "modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/EngineV6_CAD.png")}),
      Documentation(info="<html>
<p>
Model of an engine with 6 cylinders where the algebraic loops of the slider crank mechanisms are
solved analytically.
</p>
</html>"));
end EngineV6_analytic;
