within Modelica.Mechanics.MultiBody.Examples.Elementary;
model DoublePendulumInitTip
  "Demonstrate how to initialize a double pendulum so that its tip starts at a predefined position"
  extends Modelica.Icons.Example;
  inner World world                              annotation (Placement(
        transformation(extent={{-100,0},{-80,20}},rotation=0)));
  Joints.Revolute revolute1(                             useAxisFlange=true)
                                                                 annotation (Placement(transformation(extent={{-60,0},
            {-40,20}}, rotation=0)));
  Rotational.Components.Damper damper(        d=0.1)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}}, rotation=0)));
  Parts.BodyBox boxBody1(                             r={0.5,0,0}, width=0.06)
    annotation (Placement(transformation(extent={{-22,0},{-2,20}}, rotation=0)));
  Joints.Revolute revolute2                              annotation (Placement(transformation(extent={{20,0},{
            40,20}}, rotation=0)));
  Parts.BodyBox boxBody2(                             r={0.5,0,0}, width=0.06)
    annotation (Placement(transformation(extent={{62,0},{82,20}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Joints.FreeMotionScalarInit freeMotionScalarInit(
    use_r=true,
    r_rel_a_1(start=0.7, fixed=true),
    r_rel_a_2(start=0.3, fixed=true),
    use_v=true,
    v_rel_a_1(fixed=true),
    v_rel_a_2(fixed=true))
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
equation
  connect(damper.flange_b,revolute1. axis) annotation (Line(points={{-40,50},{
          -36,50},{-36,28},{-50,28},{-50,20}}, color={0,0,0}));
  connect(revolute1.support,damper. flange_a) annotation (Line(points={{-56,20},
          {-56,28},{-70,28},{-70,50},{-60,50}}, color={0,0,0}));
  connect(revolute1.frame_b,boxBody1. frame_a)
    annotation (Line(
      points={{-40,10},{-22,10}},
      color={95,95,95},
      thickness=0.5));
  connect(revolute2.frame_b,boxBody2. frame_a)
    annotation (Line(
      points={{40,10},{62,10}},
      color={95,95,95},
      thickness=0.5));
  connect(boxBody1.frame_b,revolute2. frame_a)
    annotation (Line(
      points={{-2,10},{20,10}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b,revolute1. frame_a)
    annotation (Line(
      points={{-80,10},{-60,10}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, freeMotionScalarInit.frame_a) annotation (Line(
      points={{-80,10},{-66,10},{-66,-30},{-20,-30}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  connect(freeMotionScalarInit.frame_b, boxBody2.frame_b) annotation (Line(
      points={{0,-30},{88,-30},{88,10},{82,10}},
      color={95,95,95},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=5),
    experimentSetupOutput,
    Documentation(info="<html>
<p>
This example demonstrates at hand of a double pendulum,
how no-standard initialization can be defined:
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

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/MultiBody/Examples/Elementary/DoublePendulumInitTip.png\">
</blockquote>

</html>"));
end DoublePendulumInitTip;
