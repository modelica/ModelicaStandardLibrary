within Modelica.Clocked.RealSignals.TickBasedSources;
block Sine "Generate sine signal"
  extends Interfaces.PartialClockedSO;
  parameter Real amplitude=1 "Amplitude of sine wave";
  parameter Real offset=0 "Offset of output signal";
  parameter Integer periodTicks = 10
"Number of clock ticks for one period";
  parameter Integer periodOffset=0
"Number of periods the sine signal is offset";
  parameter Integer startTick(min=1)=1
"Output = offset for clock tick < startTick";
protected
  constant Real pi=Modelica.Constants.pi;
  Real Ts = interval(y) "Sample time (periodic or non-periodic)";
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

  y = offset + (if startOutput then
  amplitude*Modelica.Math.sin(2*pi/periodTicks*(counter + periodOffset)) else 0);
  annotation (
    Icon(coordinateSystem(
    preserveAspectRatio=false,
    extent={{-100,-100},{100,100}}), graphics={
    Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
    Polygon(
      points={{-80,90},{-88,68},{-72,68},{-80,90}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(points={{-90,0},{68,0}}, color={192,192,192}),
    Polygon(
      points={{90,0},{68,8},{68,-8},{90,0}},
      lineColor={192,192,192},
      fillColor={192,192,192},
      fillPattern=FillPattern.Solid),
    Line(
      points={{-80,0},{-68.7,34.2},{-61.5,53.1},{-55.1,66.4},{-49.4,
          74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{-26.9,69.7},{-21.3,
          59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,-50.2},{
          23.7,-64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},{
          51.9,-71.5},{57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}},
      pattern=LinePattern.Dot,
      smooth=Smooth.Bezier),
    Text(
      extent={{-150,-150},{150,-110}},
      textString="periodTicks=%periodTicks"),
        Ellipse(
          extent={{-86,6},{-74,-6}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-59,72},{-47,60}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-31,72},{-19,60}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-7,6},{5,-6}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{19,-60},{31,-72}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{49,-60},{61,-72}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
    preserveAspectRatio=false,
    extent={{-100,-100},{100,100}}), graphics={
    Line(points={{-80,-90},{-80,84}}, color={95,95,95}),
    Polygon(
      points={{-80,97},{-84,81},{-76,81},{-80,97}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Line(points={{-99,-40},{85,-40}}, color={95,95,95}),
    Polygon(
      points={{97,-40},{81,-36},{81,-45},{97,-40}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Line(
      points={{-41,-2},{-31.6,34.2},{-26.1,53.1},{-21.3,66.4},{-17.1,
          74.6},{-12.9,79.1},{-8.64,79.8},{-4.42,76.6},{-0.201,69.7},{
          4.02,59.4},{8.84,44.1},{14.9,21.2},{27.5,-30.8},{33,-50.2},{
          37.8,-64.2},{42,-73.1},{46.2,-78.4},{50.5,-80},{54.7,-77.6},{
          58.9,-71.5},{63.1,-61.9},{67.9,-47.2},{74,-24.8},{80,0}},
      color={0,0,255},
      thickness=0.5,
      pattern=LinePattern.Dot),
    Text(
      extent={{-87,12},{-40,0}},
      textString="offset"),
    Line(points={{-41,-2},{-41,-40}}, color={95,95,95}),
    Text(
      extent={{-60,-43},{-14,-54}},
      textString="startTick"),
    Text(
      extent={{75,-47},{100,-60}},
      textString="tick"),
    Text(
      extent={{-80,99},{-40,82}},
      textString="y"),
    Line(points={{-9,79},{43,79}}, color={95,95,95}),
    Line(points={{-41,-2},{50,-2}}, color={95,95,95}),
    Polygon(
      points={{33,79},{30,66},{37,66},{33,79}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Text(
      extent={{37,57},{83,39}},
      textString="amplitude"),
    Polygon(
      points={{33,-2},{30,11},{36,11},{33,-2},{33,-2}},
      lineColor={95,95,95},
      fillColor={95,95,95},
      fillPattern=FillPattern.Solid),
    Line(points={{33,77},{33,-2}}, color={95,95,95}),
        Ellipse(
          extent={{-16,85},{-4,73}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{15,5},{27,-7}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{44,-74},{56,-86}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{74,5},{86,-7}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
    Line(
      points={{-80,-2},{-41,-2}},
      color={0,0,255},
      thickness=0.5,
      pattern=LinePattern.Dot),
        Ellipse(
          extent={{-86,4},{-74,-8}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-47,4},{-35,-8}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
Documentation(info="<html>
<p>
The Real output y is a sine signal. The signal is defined in terms of clock ticks instead of simulation time:
</p>

<div>
<img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/TickBasedSources_Sine.png\" alt=\"TickBasedSources_Sine.png\"/>
</div>
</html>"));
end Sine;
