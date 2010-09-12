within Modelica.Mechanics.MultiBody.Examples.Loops;
model Engine1b
  "Model of one cylinder engine with gas force and preparation for assembly joint JointRRP"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Example;
  extends Utilities.Engine1bBase;
  Joints.RevolutePlanarLoopConstraint B2(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05) annotation (Placement(transformation(extent={{40,20},
            {60,40}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute B1(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05)
                         annotation (Placement(transformation(extent={{40,-20},
            {60,0}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic Cylinder(useAxisFlange=true,
    boxWidth=0.02, n={0,-1,0})
                   annotation (Placement(transformation(
        origin={50,97},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Parts.FixedTranslation Rod1(r={0,0.2,0}, animation=false)
    annotation (Placement(transformation(
        origin={70,10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Parts.FixedTranslation Rod3(r={0,-0.1,0}, animation=false)
    annotation (Placement(transformation(
        origin={50,58},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  connect(B1.frame_b, Rod1.frame_a) annotation (Line(
      points={{60,-10},{70,-10},{70,-5.55112e-16}},
      color={95,95,95},
      thickness=0.5));
  connect(Rod1.frame_b, B2.frame_b) annotation (Line(
      points={{70,20},{70,30},{60,30}},
      color={95,95,95},
      thickness=0.5));
  connect(Cylinder.frame_b, Rod3.frame_a) annotation (Line(
      points={{50,87},{50,68}},
      color={95,95,95},
      thickness=0.5));
  connect(B2.frame_a, Rod3.frame_b) annotation (Line(
      points={{40,30},{30,30},{30,44},{50,44},{50,48}},
      color={95,95,95},
      thickness=0.5));
  connect(cylPosition.frame_b, Cylinder.frame_a) annotation (Line(
      points={{-20.5,110},{50,110},{50,107}},
      color={95,95,95},
      thickness=0.5));
  connect(gasForce.flange_a, Cylinder.support) annotation (Line(points={{119,
          107},{119,112},{70,112},{70,101},{56,101}}, color={0,127,0}));
  connect(Cylinder.axis, gasForce.flange_b) annotation (Line(points={{56,89},{
          71,89},{71,80},{119,80},{119,87}}, color={0,127,0}));
  connect(Piston.frame_a, Rod3.frame_a) annotation (Line(
      points={{120,63},{120,75},{50,75},{50,68}},
      color={95,95,95},
      thickness=0.5));
  connect(B1.frame_b, Rod2.frame_a) annotation (Line(
      points={{60,-10},{120,-10},{120,-5.55112e-16}},
      color={95,95,95},
      thickness=0.5));
  connect(Mid.frame_b, B1.frame_a) annotation (Line(
      points={{50,-43},{57,-43},{57,-28},{30,-28},{30,-10},{40,-10}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=0.5),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-120},{150,120}},
        grid={1,1}), graphics={
        Rectangle(
          extent={{3,117},{88,-23}},
          lineColor={255,0,0},
          lineThickness=0.5),
        Text(
          extent={{65,-30},{145,-39}},
          lineColor={255,0,0},
          lineThickness=0.5,
          textString="jointRRP in model"),
        Text(
          extent={{66,-34},{141,-52}},
          lineColor={255,0,0},
          lineThickness=0.5,
          textString="Loops.Engine1b_analytic")}),
    Documentation(info="<html>
<p>
This is a model of the mechanical part of one cylinder of an engine.
It is similiar to
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1a#diagram\">Loops.Engine1a</a>.
The difference is that a simple
model for the gas force in the cylinder is added and that the
model is restructured in such a way, that the central part of
the planar kinematic loop can be easily replaced by the
assembly joint \"Modelica.Mechanics.MultiBody.Joints.Assemblies.<b>JointRRP</b>\".
This exchange of the kinematic loop is shown in
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b_analytic#diagram\">Loops.Engine1b_analytic</a>.
The advantage of using JointRRP is, that the
non-linear algebraic equation of this loop is solved analytically, and
not numerically as in this model (Engine1b).
</p>
<p>
An animation of this example is shown in the figure below.
</p>

<IMG src=\"modelica://Modelica/Resources/Images/MultiBody/Examples/Loops/Engine.png\" ALT=\"model Examples.Loops.Engine\">
</html>"));
end Engine1b;
