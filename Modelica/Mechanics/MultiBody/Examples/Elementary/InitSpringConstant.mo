within Modelica.Mechanics.MultiBody.Examples.Elementary;
model InitSpringConstant
  "Determine spring constant such that system is in steady state at given position"

  extends Modelica.Icons.Example;
  inner Modelica.Mechanics.MultiBody.World world(gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.UniformGravity)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Mechanics.MultiBody.Joints.Revolute rev(
    useAxisFlange=true,
    n={0,0,1},
    phi(fixed=true),
    w(fixed=true),
    a(fixed=true)) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Mechanics.Rotational.Components.Damper damper(d=0.1) annotation (
      Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Mechanics.MultiBody.Parts.BodyShape body(
    r={1,0,0},
    r_CM={0.5,0,0},
    m=1)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Mechanics.MultiBody.Parts.Fixed fixed(r={1,0.2,0}, width=0.02)
    annotation (Placement(transformation(
        origin={50,60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Mechanics.MultiBody.Forces.Spring spring(s_unstretched=0.1, c(fixed=
          false, start=100)) annotation (Placement(transformation(
        origin={50,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));

equation
  connect(world.frame_b, rev.frame_a) annotation (Line(
      points={{-60,0},{-40,0}},
      color={95,95,95},
      thickness=0.5));
  connect(damper.flange_b, rev.axis) annotation (Line(points={{-20,40},{-20,20},{-30,20},{-30,10}}));
  connect(rev.support, damper.flange_a) annotation (Line(points={{-36,10},{-36,20},{-40,20},{-40,40}}));
  connect(rev.frame_b, body.frame_a) annotation (Line(
      points={{-20,0},{0,0}},
      color={95,95,95},
      thickness=0.5));
  connect(fixed.frame_b, spring.frame_a) annotation (Line(
      points={{50,50},{50,30}},
      color={95,95,95},
      thickness=0.5));
  connect(body.frame_b, spring.frame_b) annotation (Line(
      points={{20,0},{50,0},{50,10}},
      color={95,95,95},
      thickness=0.5));
  annotation (Documentation(info="<html>
<p>
This example demonstrates a non-standard type of initialization
by calculating a spring constant such
that a simple pendulum is at a defined position in steady state.
</p>
<p>
The goal is that the pendulum should be in steady state
when the rotation angle of the pendulum is zero. The spring
constant of the spring shall be calculated during initialization
such that this goal is reached.
</p>
<p>
The pendulum has one degree of freedom, i.e., two states.
Therefore, two additional equations have to be provided
for initialization. However, parameter \"c\" of the spring
component is defined with attribute \"fixed = <strong>false</strong>\", i.e.,
the value of this parameter is computed during initialization.
Therefore, there is one additional equation required during
initialization. The 3 initial equations are the rotational
angle of the revolute joint and its first and second
derivative. The latter ones are zero, in order to initialize
in steady state. By setting the start values of phi, w, a to zero and
their fixed attributes to true, the required
3 initial equations are defined.
</p>
<p>
After translation, this model is initialized in steady-state.
The spring constant is computed as c = 49.05 N/m.
An animation of this simulation is shown in the figure below.
</p>

<img src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Elementary/InitSpringConstant.png\"
alt=\"model Examples.Elementary.InitSpringConstant\">
</html>"), experiment(StopTime=1.01));
end InitSpringConstant;
