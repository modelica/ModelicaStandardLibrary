within Modelica.Blocks.Examples.Noise;
model Distributions
  "Demonstrates noise with different types of distributions"
  extends Modelica.Icons.Example;
  parameter SI.Period samplePeriod=0.02
    "Sample period of all blocks";
  parameter Real y_min = -1 "Minimum value of band for random values";
  parameter Real y_max = 3 "Maximum value of band for random values";
  inner Modelica.Blocks.Noise.GlobalSeed globalSeed(useAutomaticSeed=
        false)
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  output Real uniformNoise_y =         uniformNoise.y;
  output Real truncatedNormalNoise_y = truncatedNormalNoise.y;

  Integer n=if time < 0.5 then 12 else 2;

  Modelica.Blocks.Noise.UniformNoise uniformNoise(
    useAutomaticLocalSeed=false,
    fixedLocalSeed=1,
    samplePeriod=samplePeriod,
    y_min=y_min,
    y_max=y_max)
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Noise.TruncatedNormalNoise truncatedNormalNoise(
    useAutomaticLocalSeed=false,
    fixedLocalSeed=1,
    samplePeriod=samplePeriod,
    y_min=y_min,
    y_max=y_max)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
 annotation (experiment(StopTime=2), Documentation(info="<html>
<p>
This example demonstrates different noise distributions methods that can be selected
for a Noise block. Both noise blocks use samplePeriod = 0.02 s, y_min=-1, y_max=3, and have
identical fixedLocalSeed. This means that the same random numbers are drawn for the blocks.
However, the random numbers are differently transformed according to the selected distributions
(uniform and truncated normal distribution), and therefore the blocks have different output values.
Simulation results are shown in the next diagram:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/NoiseExamples/Distributions.png\">
</blockquote>

<p>
As can be seen, uniform noise is distributed evenly between -1 and 3, and
truncated normal distribution has more values centered around the mean value 1.
</p>
</html>", revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Blocks/Noise/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
end Distributions;
