within Modelica.Blocks.Interfaces;
partial block MO "Multiple Output continuous control block"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer nout(min=1) = 1 "Number of outputs";
  RealOutput y[nout] "Connector of Real output signals" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
Block has one continuous Real output signal vector.
</p>
</html>"));

end MO;
