within Modelica.Clocked.RealSignals.Sampler.Utilities.Internal;
model Quantization "DAC quantization effects"
extends Clocked.RealSignals.Interfaces.PartialClockedSISO;

  parameter Boolean quantized = false
    "= true, if quantization effects shall be computed";
  parameter Real yMax=1 "Upper limit of output";
  parameter Real yMin=-1 "Lower limit of output";
  parameter Integer bits(min=1)=8
    "Number of bits of quantization (if quantized = true)";
protected
  parameter Real resolution = if quantized then ((yMax - yMin)/2^bits) else 0;
equation

  if quantized then
    y = resolution*floor(abs(u/resolution) + 0.5)*
           (if u >= 0 then +1 else -1);
  else
    y = u;
  end if;
  annotation (Documentation(info="<html>
<p>
The clocked Real input signal is value discretized
(the discretization is defined by parameter <strong>bits</strong>).
</p>
</html>"));
end Quantization;
