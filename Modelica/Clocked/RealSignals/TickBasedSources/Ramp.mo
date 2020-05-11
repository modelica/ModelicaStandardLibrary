within Modelica.Clocked.RealSignals.TickBasedSources;
block Ramp "Generate ramp signal based on counted clock ticks"
  extends Interfaces.PartialClockedSO;
  parameter Real height=1 "Height of ramps";
  parameter Integer durationTicks(min=1) = 1
"Durations of ramp in number of clock ticks";
  parameter Real offset=0 "Offset of output signal";

  parameter Integer startTick(min=1) = 1
"Output y = offset for clock tick < startTick";
protected
  Integer counter(start=0);
equation
  // stop counter after counter = startTick+durationTicks to avoid integer overflow for long running simulations
  counter = if previous(counter) < startTick+durationTicks then previous(counter) + 1 else previous(counter);

  y = offset + (if counter < startTick then 0 else if counter < (startTick +
    durationTicks) then (counter - startTick)*height/durationTicks else height);
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
    Line(points={{-80,-70},{-40,-70},{31,38}}, pattern=LinePattern.Dot),
    Text(
      extent={{-150,-150},{150,-110}},
      textString="duration ticks=%durationTicks"),
    Line(points={{31,38},{86,38}}, pattern=LinePattern.Dot),
        Ellipse(
          extent={{-86,-64},{-74,-76}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-34,-48},{-22,-60}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{13,27},{25,15}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{64,44},{76,32}},
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
      points={{-80,-20},{-20,-20},{50,50}},
      color={0,0,255},
      thickness=0.5,
      pattern=LinePattern.Dot),
    Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
    Polygon(
      points={{90,-70},{68,-64},{68,-76},{90,-70}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Polygon(
      points={{-40,-20},{-42,-30},{-37,-30},{-40,-20}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Line(
      points={{-40,-20},{-40,-70}},
      color={95,95,95},
      thickness=0.25),
    Polygon(
      points={{-40,-70},{-43,-60},{-38,-60},{-40,-70},{-40,-70}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Text(
      extent={{-72,-39},{-34,-50}},
      textString="offset"),
    Text(
      extent={{-38,-72},{6,-83}},
      textString="startTick"),
    Text(
      extent={{-78,92},{-37,72}},
      textString="y"),
    Text(
      extent={{70,-80},{94,-91}},
      textString="tick"),
    Line(points={{-20,-20},{-20,-70}}, color={95,95,95}),
    Line(
      points={{-19,-20},{50,-20}},
      color={95,95,95},
      thickness=0.25),
    Line(
      points={{50,50},{87,50}},
      color={0,0,255},
      thickness=0.5,
      pattern=LinePattern.Dot),
    Line(
      points={{50,50},{50,-20}},
      color={95,95,95},
      thickness=0.25),
    Polygon(
      points={{50,-20},{42,-18},{42,-22},{50,-20}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Polygon(
      points={{-20,-20},{-11,-18},{-11,-22},{-20,-20}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Polygon(
      points={{50,50},{48,40},{53,40},{50,50}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Polygon(
      points={{50,-20},{47,-10},{52,-10},{50,-20},{50,-20}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Text(
      extent={{53,23},{82,10}},
      textString="height"),
    Text(
      extent={{-8,-21},{42,-39}},
      textString="durationTicks"),
        Ellipse(
          extent={{-86,-14},{-74,-26}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-26,-14},{-14,-26}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{10,22},{22,10}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{44,56},{56,44}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{81,56},{93,44}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
Documentation(info="<html>
<p>
The Real output y is a ramp signal. The signal is defined in terms of clock ticks instead of simulation time:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/TickBasedSources_Ramp.png\" alt=\"TickBasedSources_Ramp.png\"/>
</div>
</html>"));
end Ramp;
