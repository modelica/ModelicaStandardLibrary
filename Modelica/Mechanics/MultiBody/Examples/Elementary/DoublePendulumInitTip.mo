within Modelica.Mechanics.MultiBody.Examples.Elementary;
model DoublePendulumInitTip
  "Demonstrate how to initialize a double pendulum so that its tip starts at a predefined position"
  extends Modelica.Icons.Example;
  inner World world annotation (Placement(
        transformation(extent={{-100,-10},{-80,10}})));
  Joints.Revolute revolute1(useAxisFlange=true)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Rotational.Components.Damper damper(d=0.1)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Parts.BodyBox boxBody1(r={0.5,0,0}, width=0.06)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Joints.Revolute revolute2(phi(start=Modelica.Constants.pi/2))
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Parts.BodyBox boxBody2(r={0.5,0,0}, width=0.06)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Mechanics.MultiBody.Joints.FreeMotionScalarInit freeMotionScalarInit(
    use_r=true,
    r_rel_a_1(start=0.7, fixed=true),
    r_rel_a_2(start=0.3, fixed=true),
    use_v=true,
    v_rel_a_1(fixed=true),
    v_rel_a_2(fixed=true))
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
equation
  connect(damper.flange_b,revolute1. axis) annotation (Line(points={{-40,40},{-40,20},{-50,20},{-50,10}}));
  connect(revolute1.support,damper. flange_a) annotation (Line(points={{-56,10},{-56,20},{-60,20},{-60,40}}));
  connect(revolute1.frame_b,boxBody1. frame_a)
    annotation (Line(
      points={{-40,0},{-20,0}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute2.frame_b,boxBody2. frame_a)
    annotation (Line(
      points={{40,0},{60,0}},
      color={95,95,95},
      thickness=0.5));
  connect(boxBody1.frame_b,revolute2. frame_a)
    annotation (Line(
      points={{0,0},{20,0}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b,revolute1. frame_a)
    annotation (Line(
      points={{-80,0},{-60,0}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, freeMotionScalarInit.frame_a) annotation (Line(
      points={{-80,0},{-70,0},{-70,-40},{-20,-40}},
      color={95,95,95},
      thickness=0.5));
  connect(freeMotionScalarInit.frame_b, boxBody2.frame_b) annotation (Line(
      points={{0,-40},{90,-40},{90,0},{80,0}},
      color={95,95,95},
      thickness=0.5));
  annotation (
    experiment(StopTime=5),
    Documentation(info="<html>
<p>
This example demonstrates at hand of a double pendulum,
how non-standard initialization can be defined:
The absolute position of the pendulum tip, and its absolute speed
shall be initially defined. This can be performed with the
<a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.FreeMotionScalarInit\">Joints.FreeMotionScalarInit</a>
joint that allows to initialize individual elements of its relative vectors.
In this case, the x-, and y-coordinates of the relative position vector
(visualized by the yellow arrow in the figure below) and of its
derivative shall have a defined value at initial time.
The configuration of the double pendulum at the initial time is
shown below, where the tip position is required to have the coordinates
x=0.7, y=0.3.
</p>
<p>
Setting only the tip&#39;s start position results in an ambiguous initialization since
two valid solutions for <code>revolute1.phi</code> and <code>revolute2.phi</code> exist.
Moreover, the calculated angles <code>revolute1.phi</code> and <code>revolute2.phi</code>
can be a multiple of expected solution <code>phi1</code> and <code>phi2</code>,
</p>
<ul>
<li>revolute1.phi(k1) = phi1 + 2 &pi; k1,</li>
<li>revolute2.phi(k2) = phi2 + 2 &pi; k2.</li>
</ul>
<p>
To clearly indicate the preferred solution, guess initial angles can be additionally given.
In this example, it is simply done by <code>revolute2.phi.start&nbsp;=&nbsp;Modelica.Constants.pi/2</code>.
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/DoublePendulumInitTip.png\">
</blockquote>
</html>"));
end DoublePendulumInitTip;
