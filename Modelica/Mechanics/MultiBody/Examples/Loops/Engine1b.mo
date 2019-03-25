within Modelica.Mechanics.MultiBody.Examples.Loops;
model Engine1b
  "Model of one cylinder engine with gas force and preparation for assembly joint JointRRP"
  extends Modelica.Icons.Example;
  extends Utilities.Engine1bBase(Inertia(w(start=0)));
  Joints.RevolutePlanarLoopConstraint B2(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05) annotation (Placement(transformation(extent={{20,20},{40,0}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute B1(
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.05) annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Modelica.Mechanics.MultiBody.Joints.Prismatic Cylinder(
    useAxisFlange=true,
    boxWidth=0.02,
    n={0,-1,0}) annotation (Placement(transformation(
        origin={30,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Parts.FixedTranslation Rod1(r={0,0.2,0}, animation=false) annotation (
      Placement(transformation(
        origin={50,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Parts.FixedTranslation Rod3(r={0,-0.1,0}, animation=false) annotation (
      Placement(transformation(
        origin={30,40},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  connect(B1.frame_b, Rod1.frame_a) annotation (Line(
      points={{40,-30},{50,-30},{50,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(Rod1.frame_b, B2.frame_b) annotation (Line(
      points={{50,0},{50,10},{40,10}},
      color={95,95,95},
      thickness=0.5));
  connect(Cylinder.frame_b, Rod3.frame_a) annotation (Line(
      points={{30,60},{30,50}},
      color={95,95,95},
      thickness=0.5));
  connect(B2.frame_a, Rod3.frame_b) annotation (Line(
      points={{20,10},{10,10},{10,24},{30,24},{30,30}},
      color={95,95,95},
      thickness=0.5));
  connect(cylPosition.frame_b, Cylinder.frame_a) annotation (Line(
      points={{-40,80},{30,80}},
      color={95,95,95},
      thickness=0.5));
  connect(gasForce.flange_a, Cylinder.support) annotation (Line(points={{80,80},{40,80},{40,74},{36,74}},
                                                      color={0,127,0}));
  connect(Cylinder.axis, gasForce.flange_b) annotation (Line(points={{36,62},{40,62},{40,60},{80,60}}, color={0,127,0}));
  connect(Piston.frame_a, Rod3.frame_a) annotation (Line(
      points={{80,40},{80,55},{30,55},{30,50}},
      color={95,95,95},
      thickness=0.5));
  connect(B1.frame_b, Rod2.frame_a) annotation (Line(
      points={{40,-30},{80,-30},{80,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(Mid.frame_b, B1.frame_a) annotation (Line(
      points={{30,-54},{30,-44},{10,-44},{10,-30},{20,-30}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=0.5),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Rectangle(
          extent={{-28,100},{60,-42}},
          lineColor={255,0,0},
          lineThickness=0.5),Text(
          extent={{-25,100},{55,91}},
          lineColor={255,0,0},
          textString="jointRRP in model"),Text(
          extent={{-24,96},{51,78}},
          lineColor={255,0,0},
          textString="Loops.Engine1b_analytic")}),
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
</p>

<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Engine.png\" alt=\"model Examples.Loops.Engine\">
</html>"));
end Engine1b;
