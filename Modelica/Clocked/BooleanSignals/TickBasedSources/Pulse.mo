within Modelica.Clocked.BooleanSignals.TickBasedSources;
block Pulse "Generate pulse signal of type Boolean"
  extends BooleanSignals.Interfaces.PartialClockedSO;
  parameter Integer widthTicks(min=1,max=periodTicks) = 1
  "Width of one pulse in clock ticks";
  parameter Integer periodTicks(min=1,start=1) = 2
  "Number of clock ticks for one period";
  parameter Integer startTick(min=1)=1
  "Clock tick at which the first pulse starts";

protected
  Integer counter(start=0);
  Boolean startOutput(start=false)
  "Flag whether counter >= startTick reached once";
equation
  // restart counter after reaching threshold to avoid integer overflow for long running simulations
  if previous(startOutput) then
      counter = if previous(counter) == (periodTicks-1) then 0 else previous(counter) + 1;
      startOutput = previous(startOutput);
  else
    startOutput = previous(counter) >= (startTick-1);
    counter = if startOutput then 0 else previous(counter) + 1;
  end if;

  y = startOutput and (counter < widthTicks);
  annotation (
    Icon(coordinateSystem(
      preserveAspectRatio=true,
      extent={{-100,-100},{100,100}}),
      graphics={Text(
        extent={{-150,-150},{150,-110}},
        textString="periodTicks=%periodTicks"),
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
        Line(points={{-80,-70},{-40,-70},{-40,44},{0,44},
              {0,-70},{40,-70},{40,44},{79,44}}, pattern=LinePattern.Dot),
        Ellipse(
          extent={{-86,-64},{-74,-76}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-46,49},{-34,37}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-6,-64},{6,-76}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{34,49},{46,37}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
Diagram(coordinateSystem(
      preserveAspectRatio=true,
      extent={{-100,-100},{100,100}}),
      graphics={
      Text(
        extent={{-60,-74},{-19,-82}},
        textString="startTick"),
      Line(
          points={{-78,-70},{-40,-70},{-40,20},{20,20},{20,-70},{50,-70},{50,20},
              {100,20}},
          color={255,0,255},
          thickness=0.5,
          pattern=LinePattern.Dot),
      Line(points={{-40,68},{-40,20}}, color={95,95,95}),
      Line(points={{-10,40},{-10,20}},
                                     color={95,95,95}),
      Line(points={{50,65},{50,27}}, color={95,95,95}),
      Line(points={{-40,60},{50,60}}, color={95,95,95}),
      Line(points={{-40,35},{-10,35}},color={95,95,95}),
      Text(
        extent={{-18,72},{28,62}},
        textString="periodTicks"),
      Text(
        extent={{-37,51},{10,41}},
        textString="widthTicks"),
      Line(points={{-70,20},{-41,20}}, color={95,95,95}),
      Polygon(
        points={{-40,35},{-31,37},{-31,33},{-40,35}},
        lineColor={95,95,95},
        fillColor={95,95,95},
        fillPattern=FillPattern.Solid),
      Polygon(
        points={{-10,35},{-18,37},{-18,33},{-10,35}},
        lineColor={95,95,95},
        fillColor={95,95,95},
        fillPattern=FillPattern.Solid),
      Polygon(
        points={{-40,60},{-31,62},{-31,58},{-40,60}},
        lineColor={95,95,95},
        fillColor={95,95,95},
        fillPattern=FillPattern.Solid),
      Polygon(
        points={{50,60},{42,62},{42,58},{50,60}},
        lineColor={95,95,95},
        fillColor={95,95,95},
        fillPattern=FillPattern.Solid),
      Text(
        extent={{-95,26},{-66,17}},
        textString="true"),
      Text(
        extent={{-96,-60},{-75,-69}},
        textString="false"),
        Ellipse(
          extent={{-46,26},{-34,14}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-16,26},{-4,14}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{14,-63},{26,-75}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{44,25},{56,13}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{74,26},{86,14}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-76,-64},{-64,-76}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>The block is similar to the block in <a href=\"modelica://Modelica.Blocks.Sources.BooleanPulse\">Modelica.Blocks.Sources.BooleanPulse</a>,
but adapted to work in clocked partitions (by internal sampling of the continuous <strong>time</strong> variable).
</p>
<p>
The Boolean output y is a pulse signal:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/BooleanSignals/TickBasedSources_Pulse.png\" alt=\"TickBasedSources_Pulse.png\">
</div>
<h4>Example</h4>
<p>
See model <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.TickBasedPulse\">Modelica.Clocked.Examples.Elementary.BooleanSignals.TickBasedPulse</a>.
</p>
</html>"));
end Pulse;
