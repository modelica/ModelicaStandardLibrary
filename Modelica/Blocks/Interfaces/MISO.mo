within Modelica.Blocks.Interfaces;
partial block MISO "Multiple Input Single Output continuous control block"

  extends Modelica.Blocks.Icons.Block;
  parameter Integer nin=1 "Number of inputs";
  RealInput u[nin] "Connector of Real input signals" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  RealOutput y "Connector of Real output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
Block has a vector of continuous Real input signals and
one continuous Real output signal.
</p>
</html>"));
end MISO;
