within Modelica.Blocks.Interfaces;
partial block MIMO "Multiple Input Multiple Output continuous control block"

  extends Modelica.Blocks.Icons.Block;
  parameter Integer nin=1 "Number of inputs";
  parameter Integer nout=1 "Number of outputs";
  RealInput u[nin] "Connector of Real input signals" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  RealOutput y[nout] "Connector of Real output signals" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
Block has a continuous Real input and a continuous Real output signal vector.
The signal sizes of the input and output vector may be different.
</p>
</html>"));
end MIMO;
