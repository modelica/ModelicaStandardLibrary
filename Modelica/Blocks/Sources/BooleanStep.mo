within Modelica.Blocks.Sources;
block BooleanStep "Generate step signal of type Boolean"
  parameter SI.Time startTime=0 "Time instant of step start"
   annotation(Dialog(groupImage="modelica://Modelica/Resources/Images/Blocks/Sources/BooleanStep.png"));
  parameter Boolean startValue=false "Output before startTime";

  extends Interfaces.partialBooleanSource;
equation
  y = if time >= startTime then not startValue else startValue;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Line(
          visible=not startValue,
          points={{-80,-70},{0,-70},{0,50},{80,50}}),
        Line(
          visible=startValue,
          points={{-80,50},{0,50},{0,-70},{68,-70}}),
        Text(
          extent={{-150,-140},{150,-110}},
          textString="%startTime")}),
    Documentation(info="<html>
<p>
The Boolean output y is a step signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanStep.png\"
     alt=\"BooleanStep.png\">
</p>
</html>"));
end BooleanStep;
