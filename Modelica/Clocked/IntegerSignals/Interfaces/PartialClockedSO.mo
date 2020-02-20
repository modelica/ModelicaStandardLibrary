within Modelica.Clocked.IntegerSignals.Interfaces;
partial block PartialClockedSO
  "Block with clocked single output Integer signal"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

  Modelica.Blocks.Interfaces.IntegerOutput y
    "Connector of clocked, Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

end PartialClockedSO;
