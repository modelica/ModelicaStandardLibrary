within Modelica.Mechanics.MultiBody.Examples.Elementary;
model RollingWheel
  "Single wheel rolling on ground starting from an initial speed"
   extends Modelica.Icons.Example;

  Modelica.Mechanics.MultiBody.Parts.RollingWheel wheel1(
    radius=0.3,
    m=2,
    I_axis=0.06,
    I_long=0.12,
    hollowFraction=0.6,
    x(start=0.2),
    y(start=0.2),
    der_angles(start={0,5,1}))
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  inner Modelica.Mechanics.MultiBody.World world(
    label2="z",
    n={0,0,-1},
    animateGround=true,
    groundLength_u=4,
    groundColor={130,200,130})
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  annotation (
    experiment(StopTime=4),
    Documentation(info="<html>
<p>
Demonstrates how a single wheel is rolling on ground
(starting with an initial velocity).
</p>
</html>",
      figures = {
        Figure(
          title = "Wheel position from above",
          identifier = "d1c70",
          preferred = true,
          plots = {
            Plot(
              curves = {
                Curve(x = wheel1.x, y = wheel1.y, legend = "Wheel position from above, in the x-y plane")
              }
            )
          }
        ),
        Figure(
          title = "Wheel forces",
          identifier = "134a8",
          plots = {
            Plot(
              curves = {
                Curve(y = wheel1.rollingWheel.f_n, legend = "Normal force acting on wheel")
              }
            ),
            Plot(
              curves = {
                Curve(y = wheel1.rollingWheel.f_lat, legend = "Contact force on wheel in lateral direction"),
                Curve(y = wheel1.rollingWheel.f_long, legend = "Contact force on wheel in longitudinal direction")
              }
            )
          }
        )
      }
    ));
end RollingWheel;
