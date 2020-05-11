within Modelica.Clocked.BooleanSignals.TimeBasedSources;
block Step "Generate step signal of type Boolean"
  extends BooleanSignals.Interfaces.PartialClockedSO;
  parameter SI.Time startTime=0 "Time instant of step start";
  parameter Boolean startValue = false "Output before startTime";
protected
  SI.Time simTime;
equation
  simTime = sample(time);
  y = if simTime >= startTime then not startValue else startValue;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-150,-150},{150,-110}},
          textString="startTime=%startTime"),
        Polygon(
          points={{-80,88},{-88,66},{-72,66},{-80,88}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,66},{-80,-82}}, color={255,0,255}),
        Line(points={{-90,-70},{72,-70}}, color={255,0,255}),
        Polygon(
          points={{90,-70},{68,-62},{68,-78},{90,-70}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{71,7},{85,-7}},
          lineColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
          fillColor=DynamicSelect({235,235,235}, if y then {0,255,0} else {235,235,235}),
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-70},{0,-70},{0,50},{80,50}}, pattern=LinePattern.Dot),
        Ellipse(
          extent={{-86,-64},{-74,-76}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-6,56},{6,44}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{74,56},{86,44}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-46,-64},{-34,-76}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{34,56},{46,44}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
                          Diagram(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-80,92},{-86,70},{-74,70},{-80,92}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,70},{-80,-80}}, color={95,95,95}),
        Line(points={{-92,-70},{68,-70}}, color={95,95,95}),
        Polygon(
          points={{90,-70},{68,-64},{68,-76},{90,-70}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{54,-80},{106,-92}},
          textString="time"),
        Text(
          extent={{-74,92},{-56,74}},
          textString="y"),
      Line(
          points={{-80,-70},{0,-70},{0,50},{80,50}},
          color={255,0,255},
          thickness=0.5,
          pattern=LinePattern.Dot),
      Text(
        extent={{-15,-80},{20,-88}},
        textString="startTime"),
      Polygon(
        points={{-8,50},{-90,50},{-8,50}},
        lineColor={95,95,95},
        fillColor={95,95,95},
        fillPattern=FillPattern.Solid),
      Text(
        extent={{-76,62},{-32,48}},
        textString="not startValue"),
      Text(
        extent={{-78,-52},{-46,-66}},
        textString="startValue"),
        Ellipse(
          extent={{-86,-64},{-74,-76}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-6,56},{6,44}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-46,-64},{-34,-76}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{74,56},{86,44}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{34,56},{46,44}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>The block is similar to the block in <a href=\"modelica://Modelica.Blocks.Sources.BooleanStep\">Modelica.Blocks.Sources.BooleanStep</a>,
but adapted to work in clocked partitions (by internal sampling of the continuous <strong>time</strong> variable).</p>
<p>
The Boolean output y is a step signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanStep.png\" alt=\"BooleanStep.png\">
</div>

<h4>Example</h4>
<p>
See model <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.TimeBasedStep\">Modelica.Clocked.Examples.Elementary.BooleanSignals.TimeBasedStep</a>.
<br>
</p>
</html>"));
end Step;
