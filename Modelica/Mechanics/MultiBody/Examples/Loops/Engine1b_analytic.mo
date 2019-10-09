within Modelica.Mechanics.MultiBody.Examples.Loops;
model Engine1b_analytic
  "Model of one cylinder engine with gas force and analytic loop handling"
  extends Modelica.Icons.Example;
  extends Utilities.Engine1bBase(inertia(w(start=0)));
  Joints.Assemblies.JointRRP jointRRP(
    n_a={1,0,0},
    n_b={0,-1,0},
    animation=false,
    rRod1_ia={0,0.2,0},
    rRod2_ib={0,-0.1,0}) annotation (Placement(transformation(
        origin={40,20},
        extent={{-20,20},{20,-20}},
        rotation=90)));
  Utilities.GasForce2 gasForce(d=0.1, L=0.35)
    annotation (Placement(transformation(
        origin={90,80},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation
  connect(mid.frame_b, jointRRP.frame_a) annotation (Line(
      points={{30,-40},{40,-40},{40,0}},
      color={95,95,95},
      thickness=0.5));
  connect(jointRRP.frame_b, cylPosition.frame_b) annotation (Line(
      points={{40,40},{40,60},{-70,60},{-70,50}},
      color={95,95,95},
      thickness=0.5));
  connect(jointRRP.axis, gasForce.flange_b)
    annotation (Line(points={{56,40},{56,70},{90,70}}, color={0,127,0}));
  connect(jointRRP.bearing, gasForce.flange_a)
    annotation (Line(points={{48,40},{48,90},{90,90}}, color={0,127,0}));
  connect(jointRRP.frame_ib, piston.frame_a) annotation (Line(
      points={{60,36},{60,60},{90,60},{90,50}},
      color={95,95,95},
      thickness=0.5));
  connect(connectingRod.frame_b, jointRRP.frame_ia) annotation (Line(
      points={{90,-30},{90,-40},{60,-40},{60,4}},
      color={95,95,95},
      thickness=0.5));
  annotation (experiment(StopTime=5), Documentation(info="<html>
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
