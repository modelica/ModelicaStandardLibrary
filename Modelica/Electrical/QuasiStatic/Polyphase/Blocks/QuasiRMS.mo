within Modelica.Electrical.QuasiStatic.Polyphase.Blocks;
block QuasiRMS
  extends Modelica.Blocks.Interfaces.SO;
  parameter Integer m(min=2) = 3 "Number of phases" annotation(Evaluate=true);
  Modelica.ComplexBlocks.Interfaces.ComplexInput u[m]
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  y = QuasiStatic.Polyphase.Functions.quasiRMS(u);

  annotation (defaultComponentName="rms", Documentation(info="<html>
<p>
This block determines the continuous quasi <a href=\"Modelica://Modelica.Blocks.Math.RootMeanSquare\">RMS</a> value of a polyphase system, representing an equivalent RMS vector or phasor.
</p>
<blockquote><pre>
y = sqrt(sum(u[k]^2 for k in 1:m)/m)
</pre></blockquote>
</html>"));
end QuasiRMS;
