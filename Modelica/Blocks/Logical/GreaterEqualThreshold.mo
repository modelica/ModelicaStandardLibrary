within Modelica.Blocks.Logical;
block GreaterEqualThreshold
  "Output y is true, if input u is greater or equal than threshold"

  extends Blocks.Interfaces.partialBooleanThresholdComparison;
equation
  y = u >= threshold;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={
        Line(
          points={{-54,20},{-8,0},{-54,-20}},
          thickness=0.5),
        Line(points={{-54,-30},{-8,-30}}, thickness=0.5)}),
    Documentation(info="<html>
<p>
The output is <strong>true</strong> if the Real input is greater than or equal to
parameter <strong>threshold</strong>, otherwise
the output is <strong>false</strong>.
</p>
</html>"));
end GreaterEqualThreshold;
