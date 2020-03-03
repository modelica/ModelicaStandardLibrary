within Modelica.Blocks.Interfaces;
partial block SI2SO
  "2 Single Input / 1 Single Output continuous control block"
  extends Modelica.Blocks.Icons.Block;

  RealInput u1 "Connector of Real input signal 1" annotation (Placement(
        transformation(extent={{-140,40},{-100,80}})));
  RealInput u2 "Connector of Real input signal 2" annotation (Placement(
        transformation(extent={{-140,-80},{-100,-40}})));
  RealOutput y "Connector of Real output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));

  annotation (Documentation(info="<html>
<p>
Block has two continuous Real input signals u1 and u2 and one
continuous Real output signal y.
</p>
</html>"));

end SI2SO;
