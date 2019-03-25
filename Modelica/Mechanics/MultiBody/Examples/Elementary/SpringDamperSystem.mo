within Modelica.Mechanics.MultiBody.Examples.Elementary;
model SpringDamperSystem "Simple spring/damper/mass system"
  extends Modelica.Icons.Example;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-80,20},{-60,40}})));
  Modelica.Mechanics.MultiBody.Parts.Body body1(
    m=1,
    animation=animation,
    r_CM={0,-0.2,0},
    cylinderDiameter=0.05,
    sphereDiameter=0.15,
    I_11=0.1,
    I_22=0.1,
    I_33=0.1,
    r_0(start={0.3,-0.2,0}, each fixed=true),
    v_0(each fixed=true),
    angles_fixed=true,
    w_0_fixed=true,
    w_0_start(each displayUnit="deg/s") = {0,0,0.03490658503988659})
              annotation (Placement(transformation(
        origin={-20,-50},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar1(animation=animation, r={0.3,0,0})
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation bar2(animation=animation, r={0.6,0,0})
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Mechanics.MultiBody.Parts.Body body2(
    m=1,
    animation=animation,
    cylinderDiameter=0.05,
    sphereDiameter=0.15,
    r_CM={0,0,0}) annotation (Placement(transformation(
        origin={40,-50},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Joints.Prismatic p2(useAxisFlange=true,
    n={0,-1,0},
    animation=animation,
    boxWidth=0.05,
    stateSelect=StateSelect.always,
    v(fixed=true),
    s(fixed=true, start=0.1))
                   annotation (Placement(transformation(
        origin={40,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Forces.Spring spring2(
    c=30,
    s_unstretched=0.1,
    coilWidth=0.01,
    width=0.1) annotation (Placement(transformation(
        origin={60,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Forces.Spring spring1(
    s_unstretched=0.1,
    coilWidth=0.01,
    c=30,
    numberOfWindings=10,
    width=0.1) annotation (Placement(transformation(
        origin={-10,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Forces.Damper damper1(d=2)
    annotation (Placement(transformation(
        origin={-30,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(world.frame_b, bar1.frame_a)
    annotation (Line(
      points={{-60,30},{-50,30}},
      color={95,95,95},
      thickness=0.5));
  connect(bar1.frame_b, bar2.frame_a)
    annotation (Line(
      points={{-30,30},{0,30}},
      color={95,95,95},
      thickness=0.5));
  connect(bar2.frame_b, p2.frame_a)
    annotation (Line(
      points={{20,30},{40,30},{40,0}},
      color={95,95,95},
      thickness=0.5));
  connect(p2.frame_b, body2.frame_a)
    annotation (Line(
      points={{40,-20},{40,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(bar2.frame_b, spring2.frame_a)
    annotation (Line(
      points={{20,30},{40,30},{40,10},{60,10},{60,0}},
      color={95,95,95},
      thickness=0.5));
  connect(body2.frame_a, spring2.frame_b) annotation (Line(
      points={{40,-40},{40,-30},{60,-30},{60,-20}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1.frame_a, bar1.frame_b) annotation (Line(
      points={{-30,0},{-30,10},{-20,10},{-20,30},{-30,30}},
      color={95,95,95},
      thickness=0.5));
  connect(spring1.frame_a, bar1.frame_b) annotation (Line(
      points={{-10,0},{-10,10},{-20,10},{-20,30},{-30,30}},
      color={95,95,95},
      thickness=0.5));
  connect(damper1.frame_b, body1.frame_a) annotation (Line(
      points={{-30,-20},{-30,-30},{-20,-30},{-20,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(spring1.frame_b, body1.frame_a) annotation (Line(
      points={{-10,-20},{-10,-30},{-20,-30},{-20,-40}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=10),
    Documentation(info="<html>
<p>
This example demonstrates:
</p>
<ul>
<li>The animation of spring and damper components</li>
<li>A body can be freely moving without any connection to a joint.
    In this case body coordinates are used automatically as
    states (whenever joints are present, it is first tried to
    use the generalized coordinates of the joints as states).</li>
<li>If a body is freely moving, the initial position and velocity of the body
    can be defined with the \"Initialization\" menu as shown with the
    body \"body1\" in the left part (click on \"Initialization\").</li>
</ul>

<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/SpringDamperSystem.png\"
alt=\"model Examples.Elementary.SpringDamperSystem\">

</html>"));
end SpringDamperSystem;
