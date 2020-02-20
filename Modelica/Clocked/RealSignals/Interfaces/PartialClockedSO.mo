within Modelica.Clocked.RealSignals.Interfaces;
partial block PartialClockedSO
  "Block with clocked single output Real signal"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

  Modelica.Blocks.Interfaces.RealOutput y
    "Connector of clocked, Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

end PartialClockedSO;
