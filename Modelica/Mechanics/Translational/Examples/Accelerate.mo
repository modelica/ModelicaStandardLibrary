within Modelica.Mechanics.Translational.Examples;
model Accelerate "Use of model accelerate"

  extends Modelica.Icons.Example;
  Translational.Sources.Accelerate accelerate annotation (Placement(
        transformation(extent={{-10,-10},{10,10}})));
  Translational.Components.Mass mass(L=1, m=1) annotation (Placement(
        transformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.Sources.Constant constantAcc(k=1) annotation (Placement(
        transformation(extent={{-50,-10},{-30,10}})));
equation
  connect(accelerate.flange, mass.flange_a) annotation (Line(
      points={{10,0},{30,0}},   color={0,127,0}));
  connect(constantAcc.y, accelerate.a_ref) annotation (Line(
      points={{-29,0},{-12,0}},   color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
Demonstrate usage of component
<a href=\"modelica://Modelica.Mechanics.Translational.Sources.Accelerate\">Sources.Accelerate</a>
by moving a mass with a predefined acceleration.
</p>
</html>"),
       experiment(StopTime=1.0, Interval=0.001));
end Accelerate;
