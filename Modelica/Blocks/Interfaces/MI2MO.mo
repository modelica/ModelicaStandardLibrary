within Modelica.Blocks.Interfaces;
partial block MI2MO
  "2 Multiple Input / Multiple Output continuous control block"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer n=1 "Dimension of input and output vectors.";

  RealInput u1[n] "Connector 1 of Real input signals" annotation (Placement(
        transformation(extent={{-140,40},{-100,80}})));
  RealInput u2[n] "Connector 2 of Real input signals" annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}})));
  RealOutput y[n] "Connector of Real output signals" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
Block has two continuous Real input vectors u1 and u2 and one
continuous Real output vector y.
All vectors have the same number of elements.
</p>
</html>"));

end MI2MO;
