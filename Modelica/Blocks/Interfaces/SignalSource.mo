within Modelica.Blocks.Interfaces;
partial block SignalSource "Base class for continuous signal source"
  extends SO;
  parameter Real offset=0 "Offset of output signal y";
  parameter SI.Time startTime=0 "Output y = offset for time < startTime";
  annotation (Documentation(info="<html>
<p>
Basic block for Real sources of package Blocks.Sources.
This component has one continuous Real output signal y
and two parameters (offset, startTime) to shift the
generated signal.
</p>
</html>"));
end SignalSource;
