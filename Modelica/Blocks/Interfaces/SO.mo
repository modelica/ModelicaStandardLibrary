within Modelica.Blocks.Interfaces;
partial block SO "Single Output continuous control block"
  extends Modelica.Blocks.Icons.Block;

  RealOutput y "Connector of Real output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
Block has one continuous Real output signal.
</p>
</html>"));

end SO;
