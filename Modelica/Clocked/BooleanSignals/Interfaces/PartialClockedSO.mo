within Modelica.Clocked.BooleanSignals.Interfaces;
partial block PartialClockedSO
  "Block with clocked single output Boolean signals"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

  Modelica.Blocks.Interfaces.BooleanOutput y
    "Connector of clocked, Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

end PartialClockedSO;
