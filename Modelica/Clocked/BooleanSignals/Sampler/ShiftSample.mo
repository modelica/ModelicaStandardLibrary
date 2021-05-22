within Modelica.Clocked.BooleanSignals.Sampler;
block ShiftSample
  "Shift the clocked Boolean input signal by a fraction of the last interval and provide it as clocked output signal"
  parameter Integer shiftCounter(min=0)=0 "Numerator of shifting formula"
        annotation(Evaluate=true, Dialog(group="Shift first clock activation for 'shiftCounter/resolution*interval(u)' seconds"));
  parameter Integer resolution(min=1)=1 "Denominator of shifting formula"
        annotation(Evaluate=true, Dialog(group="Shift first clock activation for 'shiftCounter/resolution*interval(u)' seconds"));

  Modelica.Blocks.Interfaces.BooleanInput u
    "Connector of clocked, Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    "Connector of clocked, Boolean output signal (clock of y is faster than clock of u)"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  y = shiftSample(u,shiftCounter,resolution);

  annotation (
   defaultComponentName="shiftSample1",
   Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={Line(points={{20,-50},{60,-50},{60,50}},
                                 color={255,0,255},
          pattern=LinePattern.Dot),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-100},{150,-140}},
          textString="%shiftCounter/%resolution"),
        Line(points={{-80,-50},{-40,-50},{-40,50}},
                                 color={255,0,255},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{10,-40},{30,-60}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{50,60},{70,40}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{34,0},{14,20},{14,10},{-16,10},{-16,-10},{14,-10},{14,-20},{34,
              0}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95}),
        Ellipse(
          extent={{-90,-40},{-70,-60}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-50,60},{-30,40}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.ShiftSample\">RealSignals.Sampler.ShiftSample</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.ShiftSample\">example</a> for this Boolean block.
</p>
</html>"));
end ShiftSample;
