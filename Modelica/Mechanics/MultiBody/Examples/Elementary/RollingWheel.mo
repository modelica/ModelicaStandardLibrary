within Modelica.Mechanics.MultiBody.Examples.Elementary;
model RollingWheel
  "Single wheel rolling on ground starting from an initial speed"
   extends Modelica.Icons.Example;

  Modelica.Mechanics.MultiBody.Parts.RollingWheel wheel1(
    wheelRadius=0.3,
    wheelMass=2,
    wheel_I_axis=0.06,
    wheel_I_long=0.12,
    hollowFraction=0.6,
    x(start=0.2),
    y(start=0.2),
    der_angles(start={0,5,1}))
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  inner Modelica.Mechanics.MultiBody.World world(label2="z", n={0,0,-1})
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Mechanics.MultiBody.Visualizers.Ground ground(length=4)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}),      graphics),
    experiment(StopTime=4),
    Documentation(info="<html>

</html>"));
end RollingWheel;
