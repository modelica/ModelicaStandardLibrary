within Modelica.Clocked.RealSignals.Interfaces;
partial block PartialClockedSISO
  "Block with clocked single input and clocked single output Real signals"
  extends Clocked.ClockSignals.Interfaces.ClockedBlockIcon;

  Modelica.Blocks.Interfaces.RealInput u
    "Connector of clocked, Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    "Connector of clocked, Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

end PartialClockedSISO;
