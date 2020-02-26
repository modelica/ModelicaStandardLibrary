within Modelica.Clocked.RealSignals.Sampler;
block Sample
  "Sample the continuous-time, Real input signal and provide it as clocked output signal (clock is inferred)"
  extends Clocked.RealSignals.Interfaces.PartialSISOSampler;

equation
  y = sample(u);

  annotation (
   defaultComponentName="sample1",
   Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={
   Text(extent={{-150,90},{150,50}},
        textString="%name",
        textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This block samples the continuous-time, Real input signal u and provides it as
clocked output signal y. The clock of the output signal is inferred
(that is, it needs to be defined somewhere else in the clocked partition).
If this is not desired, use block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleClocked\">SampleClocked</a>
instead, to explicitly assign a clock to the output signal.
</p>

<p>
To be more precise: The input signal u(t) must be a continuous-time signal.
The output signal y(ti) is associated to a clock (defined somewhere else).
At a clock tick, the left limit of u is assigned to y:
<code>y(ti) = u(ti-eps)</code> (= the value of u just before the clock
became active). Since the operator returns the left limit of u, it introduces an
infinitesimal small delay between the continuous-time and the clocked partition.
This corresponds to the reality, where a sampled data system cannot act infinitely
fast and even for a very idealized simulation, an infinitesimal small delay is present.
As a result, algebraic loops between clocked and continuous-time partitions cannot
occur.
</p>

<h4>Examples</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.Sample1\">example</a>
samples a sine signal with a periodic clock of 20 ms period:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Sample1_Model.png\" alt=\"Sample1_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Sample1_Result.png\" alt=\"Sample1_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
<br>In the following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.Sample2\">example</a>
the continuous-time input signal contains a discontinuous value change at the 0.1 s
clock tick. It can be seen that the Sample block samples the left limit of the
step signal:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Sample2_Model.png\" alt=\"Sample2_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Sample2_Result.png\" alt=\"Sample2_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
<br>In the following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.Sample3\">example</a>
a direct feedthrough in the continuous-time and in the clocked partition is present.
Without a time-delay, this would result in an algebraic loop. However, since block
Sample samples the left limit of a continuous-time signal, sampling introduces a
delay of one sample period that breaks the algebraic loop:
<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Sample3_Model.png\" alt=\"Sample3_Model.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model<br></td>
   </tr>
<tr><td></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/Sample3_Result.png\" alt=\"Sample3_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
Note, the reason for the delay is that sample2.y (= the green, clocked signal)
is the left limit of hold.y (= the red, continuous-time signal).
</p>
</html>"));
end Sample;
