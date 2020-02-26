within Modelica.Clocked.RealSignals.Sampler;
block SampleClocked
  "Sample the continuous-time, Real input signal and provide it as clocked output signal. The clock is provided as input signal"
  extends Clocked.RealSignals.Interfaces.SamplerIcon;
  Modelica.Blocks.Interfaces.RealInput u
    "Connector of continuous-time, Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    "Connector of clocked, Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Clocked.ClockSignals.Interfaces.ClockInput clock
    "Output signal y is associated with this clock input" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));

equation
  y = sample(u,clock);

  annotation (
   defaultComponentName="sample1",
   Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.06),
                     graphics={
        Line(
          points={{0,-100},{0,18}},
          color={175,175,175},
          pattern=LinePattern.Dot,
          thickness=0.5),
    Text(
        extent={{-150,90},{150,50}},
        textString="%name",
        textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This block is similar to the
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.Sample\">Sample</a>
block. The only difference is that a clock signal is provided via a second
input and the output is associated to this clock.
</p>

<p>
Note, it does not make much sense to vectorize this block, because then
also the clock input is vectorized. Instead, if the input signal is a vector, use block
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleVectorizedAndClocked\">SampleVectorizedAndClocked</a>
that has a <strong>vector</strong> Real input and output, as well as a <strong>scalar</strong> clock input.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.SampleClocked\">example</a>
samples a sine signal with a periodic clock of 20 ms period:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SampleClocked_Model.png\" alt=\"SampleClocked_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SampleClocked_Result.png\" alt=\"SampleClocked_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result<br></td>
   </tr>
</table>
</html>"));
end SampleClocked;
