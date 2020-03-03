within Modelica.Blocks.Interfaces;
partial block MIMOs
  "Multiple Input Multiple Output continuous control block with same number of inputs and outputs"

  extends Modelica.Blocks.Icons.Block;
  parameter Integer n=1 "Number of inputs (= number of outputs)";
  RealInput u[n] "Connector of Real input signals" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  RealOutput y[n] "Connector of Real output signals" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
Block has a continuous Real input and a continuous Real output signal vector
where the signal sizes of the input and output vector are identical.
</p>
</html>"));
end MIMOs;
