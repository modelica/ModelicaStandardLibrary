within Modelica.Blocks.Interfaces;
partial block SISO "Single Input Single Output continuous control block"
  extends Modelica.Blocks.Icons.Block;

  RealInput u "Connector of Real input signal" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}})));
  RealOutput y "Connector of Real output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
Block has one continuous Real input and one continuous Real output signal.
</p>
</html>"));
end SISO;
