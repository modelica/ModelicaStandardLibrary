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
  parameter Real resolution = if quantized then ((yMax - yMin)/(2^bits-1)) else 0;
equation

  if quantized then
    y = resolution*floor(((u-yMin)/resolution) + 0.5)+yMin;
  else
    y = u;
  end if;
  annotation (Documentation(info="<html>
<p>
The clocked Real input signal is value discretized
(the discretization is defined by parameter <strong>bits</strong>).

This is a mid-riser quantization, which for a symmetric interval imply that it will not output zero.
</p>
</html>", revisions="<html>
<p>2024-09-04: Corrected off-by-one error in number of output levels, and handle non-symmetric limits.</p>
</html>"));
end Quantization;
