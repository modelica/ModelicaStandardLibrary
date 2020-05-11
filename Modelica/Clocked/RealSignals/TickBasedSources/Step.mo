within Modelica.Clocked.RealSignals.TickBasedSources;
block Step "Generate step signal of type Real based on counted clock ticks"
  extends Interfaces.PartialClockedSO;
  parameter Real height = 1 "Height of step";
  parameter Real offset = 0 "Offset of output signal y";
  parameter Integer startTick(min=1) = 1
"Output y = offset for clock tick < startTick";
protected
  Integer counter(start=0);
equation
  // stop counter after counter = startTick to avoid integer overflow for long running simulations
  counter = if previous(counter) < startTick then previous(counter) + 1 else previous(counter);
  y = offset + (if counter < startTick then 0 else height);
  annotation (
    Icon(coordinateSystem(
    preserveAspectRatio=true,
    extent={{-100,-100},{100,100}}), graphics={
    Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
    Polygon(
      points={{-80,90},{-88,68},{-72,68},{-80,90}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
    Polygon(
      points={{90,-70},{68,-62},{68,-78},{90,-70}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-80,-70},{0,-70},{0,50},{80,50}}, pattern=LinePattern.Dot),
    Text(
      extent={{-150,-150},{150,-110}},
      textString="startTick=%startTick"),
        Ellipse(
          extent={{-86,-63},{-74,-75}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-45,-63},{-33,-75}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-5,56},{7,44}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{32,56},{44,44}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{71,57},{83,45}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
    preserveAspectRatio=true,
    extent={{-100,-100},{100,100}}), graphics={
    Polygon(
      points={{-80,90},{-86,68},{-74,68},{-80,90}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
    Line(
      points={{-80,-18},{0,-18},{0,50},{80,50}},
      color={0,0,255},
      thickness=0.5,
          pattern=LinePattern.Dot),
    Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
    Polygon(
      points={{90,-70},{68,-64},{68,-76},{90,-70}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Text(
      extent={{70,-80},{94,-100}},
      textString="tick"),
    Text(
      extent={{-21,-72},{25,-90}},
      textString="startTick"),
    Line(points={{0,-17},{0,-71}}, color={95,95,95}),
    Text(
      extent={{-68,-36},{-22,-54}},
      textString="offset"),
    Line(points={{-13,50},{-13,-17}}, color={95,95,95}),
    Polygon(
      points={{2,50},{-19,50},{2,50}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Polygon(
      points={{-13,-17},{-16,-4},{-10,-4},{-13,-17},{-13,-17}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Polygon(
      points={{-13,50},{-16,37},{-9,37},{-13,50}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Text(
      extent={{-68,26},{-22,8}},
      textString="height"),
    Polygon(
      points={{-13,-69},{-16,-56},{-10,-56},{-13,-69},{-13,-69}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Line(points={{-13,-18},{-13,-70}}, color={95,95,95}),
    Polygon(
      points={{-13,-18},{-16,-31},{-9,-31},{-13,-18}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Text(
      extent={{-72,100},{-31,80}},
      textString="y"),
        Ellipse(
          extent={{-6,55},{6,43}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-47,-12},{-35,-24}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-86,-12},{-74,-24}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{33,56},{45,44}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{72,56},{84,44}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
Documentation(info="<html>
<p>
The Real output y is a step signal. The signal is defined in terms of clock ticks instead of simulation time:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/TickBasedSources_Step.png\" alt=\"TickBasedSources_Step.png\"/>
</div>

</html>"));
end Step;
