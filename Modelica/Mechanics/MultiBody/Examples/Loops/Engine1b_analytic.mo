within Modelica.Mechanics.MultiBody.Examples.Loops;
model Engine1b_analytic
  "Model of one cylinder engine with gas force and analytic loop handling"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Example;
  extends Utilities.Engine1bBase;
  Joints.Assemblies.JointRRP jointRRP(
    n_a={1,0,0},
    n_b={0,-1,0},
    animation=false,
    rRod1_ia={0,0.2,0},
    rRod2_ib={0,-0.1,0})
    annotation (Placement(transformation(
        origin={30,54},
        extent={{-20,20},{20,-20}},
        rotation=90)));
equation
  connect(Mid.frame_b, jointRRP.frame_a) annotation (Line(
      points={{50,-43},{58,-43},{58,-30},{30,-30},{30,34}},
      color={95,95,95},
      thickness=0.5));
  connect(jointRRP.frame_b, cylPosition.frame_b) annotation (Line(
      points={{30,74},{30,110},{-20.5,110}},
      color={95,95,95},
      thickness=0.5));
  connect(jointRRP.axis, gasForce.flange_b) annotation (Line(points={{46,74},{
          46,82},{119,82},{119,87}}, color={0,127,0}));
  connect(jointRRP.bearing, gasForce.flange_a) annotation (Line(points={{38,74},
          {38,114},{119,114},{119,107}}, color={0,127,0}));
  connect(jointRRP.frame_ib, Piston.frame_a) annotation (Line(
      points={{50,70},{120,70},{120,63}},
      color={95,95,95},
      thickness=0.5));
  connect(jointRRP.frame_ia, Rod2.frame_a) annotation (Line(
      points={{50,38},{80,38},{80,-10},{120,-10},{120,0}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=0.5),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-120},{150,120}},
        grid={1,1}), graphics),
    Documentation(info="<html>
<p>
This is the same model as
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b#diagram\">Loops.Engine1b</a>.
The only difference is that the central part of
the planar kinematic loop has been replaced by the
assembly joint \"Modelica.Mechanics.MultiBody.Joints.Assemblies.<b>JointRRP</b>\".
The advantage of using JointRRP is, that the
non-linear algebraic equation of this loop is solved analytically, and
not numerically as in
<a href=\"Modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b#diagram\">Loops.Engine1b</a>.
</p>
<p>
An animation of this example is shown in the figure below.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Loops/Engine.png\" ALT=\"model Examples.Loops.Engine\">
</p>
</html>"));
end Engine1b_analytic;
