within Modelica.Mechanics.MultiBody.Examples.Loops;
model Engine1b_analytic
  "Model of one cylinder engine with gas force and analytic loop handling"
  extends Modelica.Icons.Example;
  extends Utilities.Engine1bBase;
  Joints.Assemblies.JointRRP jointRRP(
    n_a={1,0,0},
    n_b={0,-1,0},
    animation=false,
    rRod1_ia={0,0.2,0},
    rRod2_ib={0,-0.1,0}) annotation (Placement(transformation(
        origin={40,20},
        extent={{-20,20},{20,-20}},
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
  connect(gasForce.flange_a, jointRRP.bearing)
    annotation (Line(
      points={{90,90},{48,90},{48,40}},
      color={0,127,0}));
  connect(gasForce.flange_b, jointRRP.axis)
    annotation (Line(
      points={{90,70},{56,70},{56,40}},
      color={0,127,0}));
  connect(jointRRP.frame_ib, piston.frame_a) annotation (Line(
      points={{60,36},{60,60},{90,60},{90,50}},
      color={95,95,95},
      thickness=0.5));
  connect(connectingRod.frame_b, jointRRP.frame_ia) annotation (Line(
      points={{90,-30},{90,-40},{60,-40},{60,4}},
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
</p><div>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/Engine.png\" alt=\"model Examples.Loops.Engine\">
</div>
</html>"));
end Engine1b_analytic;
