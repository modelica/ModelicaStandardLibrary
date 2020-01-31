within Modelica.ComplexBlocks.Interfaces;
partial block ComplexSignalSource "Base class for continuous signal source"
  extends ComplexBlocks.Interfaces.ComplexSO;
  parameter Complex offset=Complex(0) "Offset of output signal y";
  parameter Modelica.Units.SI.Time startTime=0
    "Output y = offset for time < startTime";
  annotation (Documentation(info="<html>
<p>
Basic block for Complex sources.
This component has one continuous Complex output signal y
and two parameters (offset, startTime) to shift the
generated signal.
</p>
</html>"));
end ComplexSignalSource;
