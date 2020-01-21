within Modelica.Electrical.Polyphase.Blocks;
block QuasiRMS
  extends Modelica.Blocks.Interfaces.SO;
  parameter Integer m(min=2) = 3 "Number of phases" annotation(Evaluate=true);
  Modelica.Blocks.Interfaces.RealInput u[m]
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  y = Polyphase.Functions.quasiRMS(u);

  annotation (defaultComponentName="rms", Documentation(info="<html>
<p>
This block determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> value of a polyphase system, representing an equivalent RMS vector or phasor. If the waveform of the input deviates from a sine curve, the output of the sensor will not be exactly the average RMS value.
</p>
<blockquote><pre>
y = sqrt(sum(u[k]^2 for k in 1:m)/m)
</pre></blockquote>
</html>"));
end QuasiRMS;
