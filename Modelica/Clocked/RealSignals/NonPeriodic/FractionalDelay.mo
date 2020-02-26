within Modelica.Clocked.RealSignals.NonPeriodic;
block FractionalDelay
  "Delay the clocked input signal for a fractional multiple of the sample period"
extends Clocked.RealSignals.Interfaces.PartialClockedSISO;

  parameter Integer shift(min=0) = 0
    "Delay = interval() * shift/resolution";
  parameter Integer resolution(min=1) = 1
    "Time quantization resolution of sample interval";
protected
  parameter Integer n = div(shift,resolution);
  Real u_buffer[n+1](each start=0.0)
    "The previous values of the inputs; u_last[1] = u, u_last[2] = previous(u_last[1]); u_last[3] = previous(u_last[2])";
  Boolean first(start=true) "Used to identify the first clock tick";
equation
 first = false;
 u_buffer = if previous(first) then fill(u,n+1) else cat(1, {u}, previous(u_buffer[1:n]));
 y = shiftSample(u_buffer[n+1], shift, resolution);

  annotation (    Icon(graphics={
        Line(
          points={{-100,0},{-80,0},{-80,40},{-20,40},{-20,-40},{40,-40},{40,0},{
              100,0}},
          color={215,215,215},
          pattern=LinePattern.Dot),
        Line(
          points={{-100,0},{-50,0},{-50,40},{10,40},{10,-40},{70,-40},{70,-0.3125},
              {100,0}},
          pattern=LinePattern.Dot,
          color={0,0,127}),
        Text(
          extent={{-150,-110},{150,-150}},
          textString="%shift/%resolution"),
        Ellipse(
          extent={{-90,50},{-70,30}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-30,-30},{-10,-50}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{30,10},{50,-10}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,50},{-40,30}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{0,-30},{20,-50}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{60,10},{80,-10}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This block delays a signal. Similar to the <a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.ShiftSample\">ShiftSample</a> block the first activation of the clock of the output y is delayed by <strong>shiftCounter</strong>/<strong>resolution</strong>*interval(u) relative to the input u (interval(u) is the sample period of the clock associated to input u). However, in contrast to ShiftSample, the block provides a buffer for the input values and truly delays the input signal.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.FractionalDelay\">example</a>
shows how a sample sine signal is delayed.
<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/FractionalDelay_Model.png\" alt=\"FractionalDelay_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/FractionalDelay_Result.png\" alt=\"FractionalDelay_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
The parameter values <strong>shiftCounter</strong>=3 and <strong>resolution</strong>=2 are visible at the bottom of the fractionalDelay block.
</p>
</html>"));
end FractionalDelay;
