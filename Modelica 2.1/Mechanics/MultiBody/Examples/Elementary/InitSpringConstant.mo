model InitSpringConstant
  "Determine spring constant such that system is in steady state at given position"

  extends Modelica.Icons.Example;
  inner MultiBody.World world(gravityType=MultiBody.Types.GravityTypes.
        UniformGravity) annotation (extent=[-80, 0; -60, 20]);
  MultiBody.Joints.ActuatedRevolute rev(n={0,0,1}, initType=MultiBody.Types.
        Init.PositionVelocityAcceleration) annotation (extent=[-40, 0; -20, 20]);
  Modelica.Mechanics.Rotational.Damper damper(d=0.1)
    annotation (extent=[-40, 40; -20, 60]);
  MultiBody.Parts.BodyShape body(
    r={1,0,0},
    r_CM={0.5,0,0},
    m=1) annotation (extent=[0, 0; 20, 20]);
  MultiBody.Parts.Fixed fixed(r={1,0.2,0}, width=0.02)
    annotation (extent=[40, 60; 60, 80], rotation=-90);
  MultiBody.Forces.Spring spring(s_unstretched=0.1, c(fixed=false) = 100)
    annotation (extent=[40, 20; 60, 40], rotation=-90);

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
component is defined with attribute \"fixed = <b>false</b>\", i.e.,
the value of this parameter is computed during initialization.
Therefore, there is one additional equation required during
initialization. The 3 initial equations are the rotational
angle of the revolute joint and its first and second
derivative. The latter one are zero, in order to initialize
in steady state. By setting parameter initType of the revolute
joint \"rev\" to
\"MultiBody.Types.Init.PositionVelocityAcceleration\", the required
3 initial equations are defined.
</p>
<p>
After translation, this model is initialized in steady-state.
The spring constant is computed as c = 49.05 N/m.
An animation of this simulation is shown in the figure below.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/MultiBody/Examples/Elementary/InitSpringConstant.png\"
ALT=\"model Examples.Elementary.InitSpringConstant\">
</p>
</html>"));
equation

  connect(world.frame_b, rev.frame_a)
    annotation (points=[-59, 10; -41, 10], style(color=0, thickness=2));
  connect(damper.flange_b, rev.axis) annotation (points=[-20, 50; -16, 50; -16,
         26; -30, 26; -30, 20], style(color=0));
  connect(rev.bearing, damper.flange_a) annotation (points=[-36, 20; -36, 26; -48,
         26; -48, 50; -40, 50], style(color=0));
  connect(rev.frame_b, body.frame_a)
    annotation (points=[-19, 10; -1, 10], style(color=0, thickness=2));
  connect(fixed.frame_b, spring.frame_a)
    annotation (points=[50, 59; 50, 41], style(color=0, thickness=2));
  connect(body.frame_b, spring.frame_b)
    annotation (points=[21, 10; 50, 10; 50, 19], style(color=0, thickness=2));
end InitSpringConstant;
