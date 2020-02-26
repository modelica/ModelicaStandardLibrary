within Modelica.Clocked.Examples.Systems.Utilities.ComponentsMixingUnit;
model FilterOrder "Block to determine the minimum filter order"
   extends Modelica.Icons.Example;
  MixingUnit mixingUnit
    annotation (Placement(transformation(extent={{-20,-2},{0,18}})));
  Modelica.Blocks.Math.InverseBlockConstraints
    inverseBlockConstraints
    annotation (Placement(transformation(extent={{24,-8},{-42,30}})));
  Modelica.Blocks.Interfaces.RealInput c_ref
    annotation (Placement(transformation(extent={{70,-4},{40,26}})));
equation
  connect(inverseBlockConstraints.u1, c_ref) annotation (Line(
      points={{27.3,11},{55,11}},
      color={0,0,127}));
  connect(mixingUnit.T_c, inverseBlockConstraints.y2) annotation (
      Line(
      points={{-22,8},{-30,8},{-30,11},{-37.05,11}},
      color={0,0,127}));
  connect(mixingUnit.c, inverseBlockConstraints.u2) annotation (Line(
      points={{2,14},{10,14},{10,11},{17.4,11}},
      color={0,0,127}));
end FilterOrder;
