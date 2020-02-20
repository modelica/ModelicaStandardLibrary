within Modelica.Clocked.BooleanSignals.Interfaces;
partial block PartialSISOSampler
  "Basic block used for sampling of Boolean signals"
extends Clocked.BooleanSignals.Interfaces.SamplerIcon;
  Modelica.Blocks.Interfaces.BooleanInput u
    "Connector of continuous-time, Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    "Connector of clocked, Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
end PartialSISOSampler;
