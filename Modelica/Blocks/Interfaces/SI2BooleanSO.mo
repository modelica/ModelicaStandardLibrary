within Modelica.Blocks.Interfaces;
partial block SI2BooleanSO "2 Single Input / Boolean Single Output block"

  extends Modelica.Blocks.Icons.BooleanBlock;
  BooleanInput u1 "Connector 1 of Boolean input signals" annotation (
      Placement(transformation(extent={{-140,40},{-100,80}})));
  BooleanInput u2 "Connector 2 of Boolean input signals" annotation (
      Placement(transformation(extent={{-140,-80},{-100,-40}})));
  BooleanOutput y "Connector of Boolean output signals" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
Block has two Boolean input signals u1 and u2 and one Boolean output signal y.
</p>
</html>"));

end SI2BooleanSO;
