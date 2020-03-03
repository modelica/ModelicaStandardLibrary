within Modelica.Blocks.Interfaces;
partial block MI2BooleanMOs
  "2 Multiple Input / Boolean Multiple Output block with same signal lengths"

  extends Modelica.Blocks.Icons.BooleanBlock;
  parameter Integer n=1 "Dimension of input and output vectors.";
  RealInput u1[n] "Connector 1 of Boolean input signals" annotation (
      Placement(transformation(extent={{-140,40},{-100,80}})));
  RealInput u2[n] "Connector 2 of Boolean input signals" annotation (
      Placement(transformation(extent={{-140,-80},{-100,-40}})));
  BooleanOutput y[n] "Connector of Boolean output signals" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>Block has two Boolean input vectors u1 and u2 and one Boolean output
vector y. All vectors have the same number of elements.</p>
</html>"));
end MI2BooleanMOs;
