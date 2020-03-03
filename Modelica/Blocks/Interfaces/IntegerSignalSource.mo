within Modelica.Blocks.Interfaces;
partial block IntegerSignalSource
  "Base class for continuous Integer signal source"
  extends IntegerSO;
  parameter Integer offset=0 "Offset of output signal y";
  parameter SI.Time startTime=0 "Output y = offset for time < startTime";
  annotation (Documentation(info="<html>
<p>
Basic block for Integer sources of package Blocks.Sources.
This component has one continuous Integer output signal y
and two parameters (offset, startTime) to shift the
generated signal.
</p>
</html>"));
end IntegerSignalSource;
