within Modelica.Blocks.Interfaces;
partial block IntegerMIBooleanMOs
  "Multiple Integer Input Multiple Boolean Output continuous control block with same number of inputs and outputs"

  extends Modelica.Blocks.Icons.BooleanBlock;
  parameter Integer n=1 "Number of inputs (= number of outputs)";
  IntegerInput u[n] "Connector of Integer input signals" annotation (
      Placement(transformation(extent={{-140,-20},{-100,20}})));
  BooleanOutput y[n] "Connector of Boolean output signals" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
Block has a continuous Integer input and a continuous Boolean output signal vector
where the signal sizes of the input and output vector are identical.
</p>
</html>"));
end IntegerMIBooleanMOs;
