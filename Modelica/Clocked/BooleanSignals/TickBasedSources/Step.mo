within Modelica.Clocked.BooleanSignals.TickBasedSources;
block Step "Generate step signal of type Boolean"
  extends BooleanSignals.Interfaces.PartialClockedSO;

  parameter Integer startTick = 0
    "Output y = startValue for clock tick < startTick";
  parameter Boolean startValue = false "Output before startTick";

protected
  Integer counter(start=0);
equation
  // stop counter after counter = startTick to avoid integer overflow for long running simulations
  counter = if previous(counter) < startTick then previous(counter) + 1 else previous(counter);
  y = if counter >= startTick then not startValue else startValue;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={
        Text(
          extent={{-150,-150},{150,-110}},
          textString="startTick=%startTick"),
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
          textString="tick"),
        Text(
          extent={{-74,92},{-56,74}},
          textString="y"),
      Line(
          points={{-80,-70},{0,-70},{0,50},{80,50}},
          color={255,0,255},
          thickness=0.5,
          pattern=LinePattern.Dot),
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
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-21,-76},{26,-88}},
          textString="startTick")}),
    Documentation(info="<html>
<p>
The Boolean output y is a step signal. The signal is defined in terms of clock ticks instead of simulation time:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/BooleanSignals/TickBasedSources_Step.png\" alt=\"TickBasedSources_Step\">
</div>

<h4>Example</h4>
<p>
See model <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.TickBasedStep\">Modelica.Clocked.Examples.Elementary.BooleanSignals.TickBasedStep</a>.
</p>
</html>"));
end Step;
