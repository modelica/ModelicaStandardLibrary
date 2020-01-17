within Modelica.ComplexBlocks.Interfaces;
partial block ComplexSO "Single Output continuous control block"
  extends Modelica.ComplexBlocks.Icons.ComplexBlock;
  ComplexOutput y "Connector of Complex output signal" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
Block has one continuous Complex output signal.
</p>
</html>"));
end ComplexSO;
