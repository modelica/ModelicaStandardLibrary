within Modelica.Electrical.Polyphase.Functions;
function quasiRMS "Calculate continuous quasi RMS value of input"
  extends Modelica.Icons.Function;
  input Real x[:];
  output Real y;
algorithm
  y := sqrt(sum(x .^ 2/size(x, 1)));
  annotation (Inline=true, Documentation(info="<html>
<p>
This function determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> value of a polyphase system, representing an equivalent RMS vector or phasor. If the waveform of the input deviates from a sine curve, the output of the sensor will not be exactly the average RMS value.
</p>
<blockquote><pre>
y = sqrt(sum(u[k]^2 for k in 1:m)/m)
</pre></blockquote>
</html>"));
end quasiRMS;
