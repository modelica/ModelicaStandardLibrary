within Modelica.Clocked.RealSignals.Sampler;
block ShiftSample
  "Shift the clocked Real input signal by a fraction of the last interval and provide it as clocked output signal"

  parameter Integer shiftCounter(min=0)=0 "Numerator of shifting formula"
        annotation(Evaluate=true, Dialog(group="Shift first clock activation for 'shiftCounter/resolution*interval(u)' seconds"));
  parameter Integer resolution(min=1)=1 "Denominator of shifting formula"
        annotation(Evaluate=true, Dialog(group="Shift first clock activation for 'shiftCounter/resolution*interval(u)' seconds"));

  Modelica.Blocks.Interfaces.RealInput u
    "Connector of clocked, Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    "Connector of clocked, Real output signal"
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
                                 color={0,0,127},
          pattern=LinePattern.Dot),
                               Line(points={{-80,-50},{-40,-50},{-40,50}},
                                 color={0,0,127},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{10,-40},{30,-60}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{50,60},{70,40}},
          lineColor={0,0,127},
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
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-50,60},{-30,40}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-100},{150,-140}},
          textString="%shiftCounter/%resolution"),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This block shifts the first activation of the clock of the output y by
fraction shiftCounter/resolution of the period (or for a non-periodic signal by a fraction of the last interval)
and the output y is set to the last available value of the input u.
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
and the clock of y starts at the second clock tick of cBase. At every tick of the clock of y,
the operator returns the value of u from the last tick of the clock of u.
</p>

<p>
Note, for
<a href=\"modelica://Modelica.Clocked.ClockSignals.Clocks.EventClock\">EventClock</a>s
there is the restriction that
block <strong>ShiftSample</strong> can only shift the number of ticks of the EventClock clock,
but cannot introduce new ticks, due to the restriction of operator <strong>superSample</strong> on
EventClocks.
</p>

<p>
Also note, that this block does not simply shift the signal in time,
since only the value of u from the last tick of the clock of u is used for the output.
If a time-delayed clock is desired, use instead block
<a href=\"modelica://Modelica.Clocked.RealSignals.NonPeriodic.FractionalDelay\">NonPeriodic.FractionalDelay</a>
where the input signal is delayed by a time period and old values of u are stored in a buffer.
If the time delay is less than one period, the two blocks, ShiftSample and FractionalDelay,
give the same result.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.ShiftSample\">example</a>
samples a sine signal with a periodic clock of 20 ms period, and
then shifts it with shiftCounter = 4 and resolution = 3:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/ShiftSample_Model.png\" alt=\"ShiftSample_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/ShiftSample_Result.png\" alt=\"ShiftSample_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
The first activation of output y of block shiftSample1 is shifted in time (4/3*20ms). The parameter values <strong>shiftCounter</strong> = 4 and <strong>resolution</strong> = 3 are visible at the bottom of the icon. Also note, that the signal is not simply a shift in time. The output of a ShiftSample block will always be the value from the <em>last</em> tick of the clock of its inputs.
</p>

</html>"));
end ShiftSample;
