within Modelica.Clocked.BooleanSignals.Sampler;
block BackSample
  "Shift clock of Boolean input signal backwards in time (and access the most recent value of the input at this new clock)"
  parameter Integer backCounter(min=0)=0 "Numerator of shifting formula"
        annotation(Evaluate=true, Dialog(group="Shift first clock activation backwards in time for 'shiftCounter/resolution*interval(u)' seconds"));
  parameter Integer resolution(min=1)=1 "Denominator of shifting formula"
        annotation(Evaluate=true, Dialog(group="Shift first clock activation backwards in time for 'shiftCounter/resolution*interval(u)' seconds"));
  parameter Boolean y_start=false
    "Value of output y before the first clock tick of the input u";

  Modelica.Blocks.Interfaces.BooleanInput
                                       u(start=y_start)
    "Connector of clocked, Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput
                                        y
    "Connector of clocked, Boolean output signal (clock of y is faster than clock of u)"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  y = backSample(u,backCounter,resolution);

  annotation (
   defaultComponentName="backSample1",
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
          extent={{-150,-150},{150,-190}},
          textColor={0,0,0},
          textString="%backCounter/%resolution"),
        Line(points={{-80,-50},{-40,-50},{-40,50}},
                                 color={255,0,255},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{-90,-40},{-70,-60}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-50,60},{-30,40}},
          lineColor={255,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-16,0},{4,20},{4,10},{34,10},{34,-10},{4,-10},{4,-20},{-16,0}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95}),
        Ellipse(
          extent={{10,-40},{30,-60}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{50,60},{70,40}},
          lineColor={255,0,255},
          fillColor={255,0,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-100},{150,-140}},
          textColor={0,0,0},
          textString="y_start=%y_start")}),
    Documentation(info="<html>
<p>
This block for Boolean signals works similarly as the corresponding block for Real signals (see <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.BackSample\">RealSignals.Sampler.BackSample</a>).
</p>
<p>
Analog to the corresponding Real signal block example there exists an elementary <a href=\"modelica://Modelica.Clocked.Examples.Elementary.BooleanSignals.BackSample\">example</a> for this Boolean block.
</p>
</html>"));
end BackSample;
