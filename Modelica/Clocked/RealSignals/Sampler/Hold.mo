within Modelica.Clocked.RealSignals.Sampler;
block Hold
  "Hold the clocked, Real input signal and provide it as continuous-time output signal (zero order hold)"
extends Clocked.RealSignals.Interfaces.PartialSISOHold;

equation
    y = hold(u);

  annotation (
    defaultComponentName="hold1",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={
        Ellipse(
          extent={{-70,-30},{-50,-50}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-30,28},{-10,8}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{10,70},{30,50}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{50,10},{70,-10}},
          lineColor={0,0,127},
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
This block holds the clocked Real input signal u with a zero order hold
and provides it as continuous-time output signal y.
The clock of the input signal is inferred
(that is, it needs to be defined somewhere else in the clocked partition).
</p>

<p>
To be more precise: The input signal u(ti) must be a clocked signal.
The output signal y(t) is a piecewise constant continuous-time signal.
When the clock of u ticks at time ti, the block output y(ti) = u(ti). Otherwise y(t), t &ge;ti, is the value of
u(ti) from the last clock activation at time ti. Before the first clock activation of u,
the block outputs the value of parameter <strong>y_start</strong>. The value of
this parameter is displayed below the icon.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.Hold\">example</a>
samples a sine signal with a periodic clock of 20 ms period and delays it for 2 sample periods.
The resulting signal is hold with the Hold block. As a result, the clock of hold.u starts
ticking at 40 ms. The output hold.y of the block is a continuous-time signal that is present
from the start of the simulation. Before the first tick of the clock of hold.u, it is set
to -1.0 (= the value of parameter hold.y_start).<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Hold_Model.png\" alt=\"Hold_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Hold_Result.png\" alt=\"Hold_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
&nbsp;
</html>"));
end Hold;
