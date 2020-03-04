within Modelica.Blocks.Sources;
block SampleTrigger "Generate sample trigger signal"
  parameter SI.Time period(final min=Modelica.Constants.small,
      start=0.01) "Sample period"
    annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/SampleTrigger.png"));
  parameter SI.Time startTime=0
    "Time instant of first sample trigger";
  extends Interfaces.partialBooleanSource;

equation
  y = sample(startTime, period);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-60,-70},{-60,70}}),
        Line(points={{-20,-70},{-20,70}}),
        Line(points={{20,-70},{20,70}}),
        Line(points={{60,-70},{60,70}}),
        Text(
          extent={{-150,-140},{150,-110}},
          textString="%period")}),
      Documentation(info="<html>
<p>
The Boolean output y is a trigger signal where the output y is only <strong>true</strong>
at sample times (defined by parameter <strong>period</strong>) and is otherwise
<strong>false</strong>.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/SampleTrigger.png\"
     alt=\"SampleTrigger.png\">
</p>
</html>"));
end SampleTrigger;
