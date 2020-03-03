within Modelica.Blocks.Interfaces;
partial block BooleanSISO
  "Single Input Single Output control block with signals of type Boolean"

  extends Modelica.Blocks.Icons.BooleanBlock;

public
  BooleanInput u "Connector of Boolean input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  BooleanOutput y "Connector of Boolean output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));

  annotation (Documentation(info="<html>
<p>
Block has one continuous Boolean input and one continuous Boolean output signal.
</p>
</html>"));
end BooleanSISO;
