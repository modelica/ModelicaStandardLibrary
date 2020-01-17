within Modelica.ComplexBlocks.Interfaces;
partial block ComplexMO "Multiple Output continuous control block"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  parameter Integer nout(min=1) = 1 "Number of outputs";
  ComplexOutput y[nout] "Connector of Complex output signals" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
Block has one continuous Complex output signal vector.
</p>
</html>"));
end ComplexMO;
