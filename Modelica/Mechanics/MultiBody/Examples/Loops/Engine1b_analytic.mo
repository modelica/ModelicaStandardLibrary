within Modelica.Mechanics.MultiBody.Examples.Loops;
model Engine1b_analytic
  "Model of one cylinder engine with gas force and analytic loop handling"
  extends Modelica.Icons.Example;
  extends Utilities.Engine1bBase(Inertia(w(start=0)));
  Joints.Assemblies.JointRRP jointRRP(
    n_a={1,0,0},
    n_b={0,-1,0},
    animation=false,
    rRod1_ia={0,0.2,0},
    rRod2_ib={0,-0.1,0}) annotation (Placement(transformation(
        origin={20,20},
        extent={{-20,20},{20,-20}},
        rotation=90)));
equation
  connect(Mid.frame_b, jointRRP.frame_a) annotation (Line(
      points={{30,-54},{30,-54},{30,-40},{20,-40},{20,0}},
      color={95,95,95},
      thickness=0.5));
  connect(jointRRP.frame_b, cylPosition.frame_b) annotation (Line(
      points={{20,40},{20,80},{-40,80}},
      color={95,95,95},
      thickness=0.5));
  connect(jointRRP.axis, gasForce.flange_b) annotation (Line(points={{36,40},{36,60},{80,60}},
                                     color={0,127,0}));
  connect(jointRRP.bearing, gasForce.flange_a) annotation (Line(points={{28,40},{28,80},{80,80}},
                                         color={0,127,0}));
  connect(jointRRP.frame_ib, Piston.frame_a) annotation (Line(
      points={{40,36},{60,36},{60,40},{80,40}},
      color={95,95,95},
      thickness=0.5));
  connect(jointRRP.frame_ia, Rod2.frame_a) annotation (Line(
      points={{40,4},{60,4},{60,-20},{80,-20},{80,-20}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=0.5), Documentation(info="<html>
<p>
This is the same model as
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b#diagram\">Loops.Engine1b</a>.
The only difference is that the central part of
the planar kinematic loop has been replaced by the
assembly joint \"Modelica.Mechanics.MultiBody.Joints.Assemblies.<strong>JointRRP</strong>\".
The advantage of using JointRRP is, that the
non-linear algebraic equation of this loop is solved analytically, and
not numerically as in
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b#diagram\">Loops.Engine1b</a>.
</p>
<p>
An animation of this example is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Engine.png\" alt=\"model Examples.Loops.Engine\">
</html>"));
end Engine1b_analytic;
