within Modelica.Mechanics.MultiBody.Examples.Loops;
model Engine1b
  "Model of one cylinder engine with gas force and preparation for assembly joint JointRRP"
  extends Modelica.Icons.Example;
  extends Utilities.Engine1bBase;
  Modelica.Mechanics.MultiBody.Joints.Revolute b1(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Joints.RevolutePlanarLoopConstraint b2(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05) annotation (Placement(transformation(extent={{40,-30},{60,-50}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic cylinder(
    useAxisFlange=true,
    boxWidth=0.02,
    n={0,-1,0}) annotation (Placement(transformation(
        origin={50,80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Parts.FixedTranslation rod1(r={0,-0.2,0},animation=false) annotation (
      Placement(transformation(
        origin={70,-20},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Parts.FixedTranslation rod3(r={0,-0.1,0}, animation=false) annotation (
      Placement(transformation(
        origin={50,40},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  connect(cylinder.frame_b, rod3.frame_a) annotation (Line(
      points={{50,70},{50,50}},
      color={95,95,95},
      thickness=0.5));
  connect(cylPosition.frame_b, cylinder.frame_a) annotation (Line(
      points={{-70,50},{-70,94},{50,94},{50,90}},
      color={95,95,95},
      thickness=0.5));
  connect(gasForce.flange_a, cylinder.support)
    annotation (Line(
      points={{90,90},{74,90},{74,84},{56,84}},
      color={0,127,0}));
  connect(gasForce.flange_b, cylinder.axis)
    annotation (Line(
      points={{90,70},{74,70},{74,72},{56,72}},
      color={0,127,0}));
  connect(piston.frame_a, cylinder.frame_b) annotation (Line(
      points={{90,50},{90,60},{50,60},{50,70}},
      color={95,95,95},
      thickness=0.5));
  connect(rod3.frame_b, b1.frame_a) annotation (Line(
      points={{50,30},{50,20},{30,20},{30,0},{40,0}},
      color={95,95,95},
      thickness=0.5));
  connect(mid.frame_b, b2.frame_a) annotation (Line(
      points={{30,-40},{40,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(b2.frame_b, connectingRod.frame_b) annotation (Line(
      points={{60,-40},{90,-40},{90,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(b2.frame_b, rod1.frame_b) annotation (Line(
      points={{60,-40},{70,-40},{70,-30}},
      color={95,95,95},
      thickness=0.5));
  connect(b1.frame_b, rod1.frame_a) annotation (Line(
      points={{60,0},{70,0},{70,-10}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=0.5),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}),
      graphics={
        Text(
          extent={{-18,-6},{42,-26}},
          textColor={255,0,0},
          textString="jointRRP in model
Loops.Engine1b_analytic"),
        Polygon(
          points={{-20,100},{78,100},{78,-52},{36,-52},{36,-28},{-20,-28},{-20,100}},
          lineColor={255,0,0},
          lineThickness=0.5)}),
    Documentation(info="<html>
<p>
This is a model of the mechanical part of one cylinder of an engine.
It is similar to
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1a#diagram\">Loops.Engine1a</a>.
The difference is that a simple
model for the gas force in the cylinder is added and that the
model is restructured in such a way, that the central part of
the planar kinematic loop can be easily replaced by the
assembly joint \"Modelica.Mechanics.MultiBody.Joints.Assemblies.<strong>JointRRP</strong>\".
This exchange of the kinematic loop is shown in
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b_analytic#diagram\">Loops.Engine1b_analytic</a>.
The advantage of using JointRRP is, that the
non-linear algebraic equation of this loop is solved analytically, and
not numerically as in this model (Engine1b).
</p>
<p>
An animation of this example is shown in the figure below.
</p><div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Engine.png\" alt=\"model Examples.Loops.Engine\">
</div></html>"));
end Engine1b;
