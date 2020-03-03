within Modelica.Blocks.Logical;
block GreaterThreshold
  "Output y is true, if input u is greater than threshold"
  extends Blocks.Interfaces.partialBooleanThresholdComparison;
equation
  y = u > threshold;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Line(
          points={{-54,20},{-8,0},{-54,-20}},
          thickness=0.5)}), Documentation(info="<html>
<p>
The output is <strong>true</strong> if the Real input is greater than
parameter <strong>threshold</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
end GreaterThreshold;
