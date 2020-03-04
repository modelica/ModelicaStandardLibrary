within Modelica.Blocks.Interfaces;
partial block IntegerSO "Single Integer Output continuous control block"
  extends Modelica.Blocks.Icons.IntegerBlock;

  IntegerOutput y "Connector of Integer output signal" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
Block has one continuous Integer output signal.
</p>
</html>"));
end IntegerSO;
