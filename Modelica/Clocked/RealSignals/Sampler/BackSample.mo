within Modelica.Clocked.RealSignals.Sampler;
block BackSample
  "Shift the clock of the Real input signal backwards in time (and access the most recent value of the input at this new clock)"
  parameter Integer backCounter(min=0)=0 "Numerator of shifting formula"
        annotation(Evaluate=true, Dialog(group="Shift first clock activation backwards in time for 'shiftCounter/resolution*interval(u)' seconds"));
  parameter Integer resolution(min=1)=1 "Denominator of shifting formula"
        annotation(Evaluate=true, Dialog(group="Shift first clock activation backwards in time for 'shiftCounter/resolution*interval(u)' seconds"));
  parameter Real y_start=0
    "Value of output y before the first clock tick of the input u";

  Modelica.Blocks.Interfaces.RealInput u(start=y_start)
    "Connector of clocked, Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    "Connector of clocked, Real output signal (clock of y is faster than clock of u)"
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
                                 color={0,0,127},
          pattern=LinePattern.Dot),
                               Line(points={{-80,-50},{-40,-50},{-40,50}},
                                 color={0,0,127},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{-90,-40},{-70,-60}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-50,60},{-30,40}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-16,0},{4,20},{4,10},{34,10},{34,-10},{4,-10},{4,-20},{-16,0}},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          lineColor={95,95,95}),
        Ellipse(
          extent={{10,-40},{30,-60}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{50,60},{70,40}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-100},{150,-140}},
          textColor={0,0,0},
          textString="y_start=%y_start"),
        Text(
          extent={{-150,-150},{150,-190}},
          textColor={0,0,0},
          textString="%backCounter/%resolution"),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This block shifts the first activation of the clock of the output y by
fraction backCounter/resolution of the period (or for a non-periodic signal by a fraction of the last interval)
before the first activation of the clock of u.
The output y is set to the last available value of the input u.
Here, <strong>backCounter</strong> and <strong>resolution</strong> are positive Integer parameters.
</p>

<p>
To be more precise:
The block constructs (conceptually) a clock &ldquo;cBase&rdquo;
</p>

<blockquote><pre>
<strong>Clock</strong> cBase = <strong>subSample</strong>(<strong>superSample</strong>(u, resolution), backCounter)
</pre></blockquote>

<p>
and the first clock tick of y is shifted before the first tick of the clock of u,
such that this duration is identical to the duration
between the first and second clock tick of cBase.
Before the first tick of the clock of u, the block outputs
the value of parameter <strong>y_start</strong>. After that, the block returns the last
available value of u.
</p>

<p>
Note, for
<a href=\"modelica://Modelica.Clocked.ClockSignals.Clocks.EventClock\">EventClock</a>s
there is the restriction that
block <strong>BackSample</strong> can only shift the number of ticks of the EventClock clock,
but cannot introduce new ticks, due to the restriction of operator <strong>superSample</strong> on
EventClocks.
</p>

<p>
Also note, that this block does not simply shift the signal in time,
since only the value of u from the last tick of the clock of u is used for the output.
In particular, a <strong>BackSample</strong> block following a <strong>ShiftSample</strong>
block cannot be used to recover the input signal of ShiftSample
(for a causal system this is impossible).
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.BackSample\">example</a>
samples a sine signal with a periodic clock of 20 ms period,
shift-samples it with shiftCounter = 4 and resolution = 3 and then back-samples it with backCounter=4 and resolution = 3:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/BackSample_Model.png\" alt=\"BackSample_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/BackSample_Result.png\" alt=\"BackSample_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
The first activation of output y of block backSample1 is shifted (4/3*20ms) before the first activation of output y of block shiftSample1. As a consequence, the activation times of the output y are coincident with the input signal of the shiftSample1 block. However, as described above, the output of block backSample1 <strong>does not</strong> recover the original sampled sine signal! For the first two ticks the output holds the value of the parameter <strong>y_start</strong> = 0.5. After that the output at a clock tick of block backSample1 is the <em>last</em> value of the output of the shiftSample1 block. The parameter values <strong>y_start</strong> = 0.5, <strong>shiftCounter</strong> = 4 and <strong>resolution</strong> = 3 are visible at the bottom of the icon.
</p>
</html>"));
end BackSample;
