within Modelica.Clocked.IntegerSignals.Interfaces;
partial block PartialSISOSampler
  "Basic block used for sampling of Integer signals"
extends Clocked.IntegerSignals.Interfaces.SamplerIcon;
  Modelica.Blocks.Interfaces.IntegerInput u
    "Connector of continuous-time, Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.IntegerOutput y
    "Connector of clocked, Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
end PartialSISOSampler;
