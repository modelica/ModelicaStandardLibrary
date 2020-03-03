within Modelica.Blocks.Interfaces;
partial block IntegerSIBooleanSO
  "Integer Input Boolean Output continuous control block"

  extends Modelica.Blocks.Icons.BooleanBlock;
  IntegerInput u "Connector of Integer input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  BooleanOutput y "Connector of Boolean output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
Block has a continuous Integer input and a continuous Boolean output signal.
</p>
</html>"));
end IntegerSIBooleanSO;
