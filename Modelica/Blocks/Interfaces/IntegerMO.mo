within Modelica.Blocks.Interfaces;
partial block IntegerMO "Multiple Integer Output continuous control block"
  extends Modelica.Blocks.Icons.IntegerBlock;

  parameter Integer nout(min=1) = 1 "Number of outputs";
  IntegerOutput y[nout] "Connector of Integer output signals" annotation (
      Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (Documentation(info="<html>
<p>
Block has one continuous Integer output signal vector.
</p>
</html>"));
end IntegerMO;
