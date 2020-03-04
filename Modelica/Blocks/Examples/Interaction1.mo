within Modelica.Blocks.Examples;
model Interaction1
  "Demonstrates the usage of blocks from Modelica.Blocks.Interaction.Show"

  extends Modelica.Icons.Example;

  Interaction.Show.IntegerValue integerValue
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Sources.IntegerTable integerTable(table=[0, 0; 1, 2; 2, 4; 3, 6; 4, 4; 6, 2])
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Sources.TimeTable timeTable(table=[0, 0; 1, 2.1; 2, 4.2; 3, 6.3; 4, 4.2; 6,
        2.1; 6, 2.1])
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Interaction.Show.RealValue realValue
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Sources.BooleanTable booleanTable(table={1,2,3,4,5,6,7,8,9})
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Interaction.Show.BooleanValue booleanValue
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Sources.RadioButtonSource start(buttonTimeTable={1,3}, reset={stop.on})
    annotation (Placement(transformation(extent={{24,64},{36,76}})));
  Sources.RadioButtonSource stop(buttonTimeTable={2,4}, reset={start.on})
    annotation (Placement(transformation(extent={{48,64},{60,76}})));
equation
  connect(integerTable.y, integerValue.numberPort) annotation (Line(
      points={{-59,30},{-41.5,30}}, color={255,127,0}));
  connect(timeTable.y, realValue.numberPort) annotation (Line(
      points={{-59,70},{-41.5,70}}, color={0,0,127}));
  connect(booleanTable.y, booleanValue.activePort) annotation (Line(
      points={{-59,-10},{-41.5,-10}}, color={255,0,255}));
  annotation (experiment(StopTime=10), Documentation(info="<html>
<p>
This example demonstrates a network of blocks
from package <a href=\"modelica://Modelica.Blocks.Interaction\">Modelica.Blocks.Interaction</a>
to show how diagram animations can be constructed.
</p>

</html>"));
end Interaction1;
