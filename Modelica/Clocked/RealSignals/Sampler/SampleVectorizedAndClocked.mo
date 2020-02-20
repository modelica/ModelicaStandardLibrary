within Modelica.Clocked.RealSignals.Sampler;
block SampleVectorizedAndClocked
  "Sample the continuous-time, Real input signal vector and provide it as clocked output signal vector. The clock is provided as input signal"
  extends Clocked.RealSignals.Interfaces.SamplerIcon;
  parameter Integer n(min=1)=1
    "Size of input signal vector u (= size of output signal vector y)";
  Modelica.Blocks.Interfaces.RealInput u[n]
    "Connector of continuous-time, Real input signal vector"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}), iconTransformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y[n]
    "Connector of clocked, Real output signal vector"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
   Clocked.ClockSignals.Interfaces.ClockInput clock
    "Output signal vector y is associated with this clock input"
    annotation (Placement(transformation(
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
          extent={{-150,-40},{20,-90}},
          textColor={0,0,0},
          textString="n=%n"),
    Text(
        extent={{-150,90},{150,50}},
        textString="%name",
        textColor={0,0,255})}),
    Documentation(info="<html>
<p>
This block is similar to the
<a href=\"modelica://Modelica.Clocked.RealSignals.Sampler.SampleClocked\">SampleClocked</a>
block. The only difference is that the continuous-time input signal is a vector: All input
signals are sampled and are associated with the
scalar clock signal provided via the second input.
</p>

<h4>Example</h4>

<p>
The following
<a href=\"modelica://Modelica.Clocked.Examples.Elementary.RealSignals.SampleVectorizedAndClocked\">example</a>
has a vector as input, consisting of two different sine signals. These
signals are sampled with a periodic clock of 20 ms period:<br>
</p>

<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SampleVectorizedAndClocked_Model.png\" alt=\"SampleVectorizedAndClocked_Model.png\"></td>
    <td valign=\"bottom\">&nbsp;&nbsp;&nbsp;
                        <img src=\"modelica://Modelica/Resources/Images/Clocked/RealSignals/SampleVectorizedAndClocked_Result.png\" alt=\"SampleVectorizedAndClocked_Result.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">model</td>
    <td align=\"center\">simulation result<br></td>
   </tr>
</table>
</html>"));
end SampleVectorizedAndClocked;
