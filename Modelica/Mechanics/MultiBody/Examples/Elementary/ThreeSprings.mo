within Modelica.Mechanics.MultiBody.Examples.Elementary;
model ThreeSprings "3-dim. springs in series and parallel connection"
  extends Modelica.Icons.Example;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  inner Modelica.Mechanics.MultiBody.World world(animateWorld=animation)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    animation=animation,
    r_CM={0,-0.2,0},
    m=0.8,
    I_11=0.1,
    I_22=0.1,
    I_33=0.1,
    sphereDiameter=0.2,
    r_0(start={0.5,-0.3,0}, each fixed=true),
    v_0(each fixed=true),
    angles_fixed=true,
    w_0_fixed=true) annotation (Placement(transformation(
        origin={30,-70},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar1(animation=animation, r={0.3,0,0})
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Mechanics.MultiBody.Forces.Spring spring1(
    lineForce(r_rel_0(start={-0.2,-0.2,0.2})),
    s_unstretched=0.1,
    width=0.1,
    coilWidth=0.005,
    numberOfWindings=5,
    c=20,
    animation=animation) annotation (Placement(transformation(
        origin={30,0},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar2(animation=animation, r={0,0,0.3})
    annotation (Placement(transformation(
        origin={-30,0},
        extent={{10,-10},{-10,10}},
        rotation=90)));
  Modelica.Mechanics.MultiBody.Forces.Spring spring2(
    s_unstretched=0.1,
    width=0.1,
    coilWidth=0.005,
    numberOfWindings=5,
    c=40,
    animation=animation) annotation (Placement(transformation(
        origin={30,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Forces.Spring spring3(
    s_unstretched=0.1,
    width=0.1,
    coilWidth=0.005,
    numberOfWindings=5,
    c=20,
    animation=animation,
    fixedRotationAtFrame_b=true)
                         annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
equation
  connect(world.frame_b, bar1.frame_a)
    annotation (Line(
      points={{-40,30},{-10,30}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, bar2.frame_a) annotation (Line(
      points={{-40,30},{-30,30},{-30,10}},
      color={95,95,95},
      thickness=0.5));
  connect(bar1.frame_b, spring1.frame_a)
    annotation (Line(
      points={{10,30},{30,30},{30,10}},
      color={95,95,95},
      thickness=0.5));
  connect(bar2.frame_b, spring3.frame_a) annotation (Line(
      points={{-30,-10},{-30,-20},{-10,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(spring2.frame_b, body1.frame_a)
    annotation (Line(
      points={{30,-50},{30,-60}},
      thickness=0.5));
  connect(spring3.frame_b, spring1.frame_b)
    annotation (Line(
      points={{10,-20},{30,-20},{30,-10}},
      color={95,95,95},
      thickness=0.5));
  connect(spring2.frame_a, spring1.frame_b)
    annotation (Line(
      points={{30,-30},{30,-10}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=10),
    Documentation(info="<html>
<p>
This example demonstrates that <strong>3-dimensional line force</strong> elements
(here: Modelica.Mechanics.MultiBody.Forces.Spring elements) can be connected together
in <strong>series</strong> without having a body with mass at the
connection point (as usually required by multi-body programs).
This is advantageous since stiff systems can be avoided, say, due to
a stiff spring and a small mass at the connection point.
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/ThreeSprings.png\"
alt=\"model Examples.Elementary.ThreeSprings\">
</blockquote>

<p>
For a more thorough explanation, see
<a href=\"modelica://Modelica.Mechanics.MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces\">MultiBody.UsersGuide.Tutorial.ConnectionOfLineForces</a>.
</p>
</html>"));
end ThreeSprings;
