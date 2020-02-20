within Modelica.Clocked.RealSignals.Interfaces;
partial block PartialSISOSampler
  "Basic block used for sampling of Real signals"
extends Clocked.RealSignals.Interfaces.SamplerIcon;
  Modelica.Blocks.Interfaces.RealInput u
    "Connector of continuous-time, Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    "Connector of clocked, Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

end PartialSISOSampler;
