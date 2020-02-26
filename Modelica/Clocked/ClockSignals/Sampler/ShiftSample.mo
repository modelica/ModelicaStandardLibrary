within Modelica.Clocked.ClockSignals.Sampler;
block ShiftSample
  "Shift the input clock by a fraction of the last interval and provide it as output clock"
  parameter Integer shiftCounter(min=0)=0 "Numerator of shifting formula"
        annotation(Dialog(group="Shift first clock activation for 'shiftCounter/resolution*interval(u)' seconds"));
  parameter Integer resolution(min=1)=1 "Denominator of shifting formula"
        annotation(Dialog(group="Shift first clock activation for 'shiftCounter/resolution*interval(u)' seconds"));

  Interfaces.ClockInput                u "Connector of clock input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Interfaces.ClockOutput                y
    "Connector of clock output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  y = shiftSample(u,shiftCounter,resolution);

  annotation (
   defaultComponentName="shiftSample1",
   Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={Line(points={{20,-50},{60,-50},{60,50}},
                                 color={95,95,95},
          pattern=LinePattern.Dot),
                               Line(points={{-80,-50},{-40,-50},{-40,50}},
                                 color={95,95,95},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{10,-40},{30,-60}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{50,60},{70,40}},
          lineColor={95,95,95},
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
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-50,60},{-30,40}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
        Text(
          extent={{-150,-90},{150,-130}},
          textColor={0,0,0},
          textString="%shiftCounter/%resolution")}),
    Documentation(info="<html>
<p>
This block shifts the first activation of clock output y by
fraction shiftCounter/resolution of the period (or for a non-periodic signal by a fraction of the last interval).
Here, <strong>shiftCounter</strong> and <strong>resolution</strong> are positive Integer parameters.
</p>

<p>
To be more precise:
The block constructs (conceptually) a clock &ldquo;cBase&rdquo;
</p>

<blockquote><pre>
<strong>Clock</strong> cBase = <strong>subSample</strong>(<strong>superSample</strong>(u, resolution), shiftCounter)
</pre></blockquote>

<p>
and clock y starts at the second clock tick of cBase.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.ClockSignals.ShiftSample\">example</a>
generates a periodic clock of 20 ms period, and
then shifts it with shiftCounter = 4 and resolution = 3:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/ClockSignals/ShiftSample_Model.png\" alt=\"ShiftSample_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/ClockSignals/ShiftSample_Result.png\" alt=\"ShiftSample_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
The first activation of clock output y of block shiftSample1 is shifted in time (4/3*20ms). The parameter values <strong>shiftCounter</strong> = 4 and <strong>resolution</strong> = 3 are visible at the bottom of the icon.
</p>

</html>"));
end ShiftSample;
