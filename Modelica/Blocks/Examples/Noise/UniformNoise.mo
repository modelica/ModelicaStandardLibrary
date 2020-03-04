within Modelica.Blocks.Examples.Noise;
model UniformNoise
  "Demonstrates the most simple usage of the UniformNoise block"
  extends Modelica.Icons.Example;
  output Real uniformNoise2_y = uniformNoise2.y;

  inner Modelica.Blocks.Noise.GlobalSeed globalSeed
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Noise.UniformNoise uniformNoise1(
    samplePeriod=0.02,
    y_min=-1,
    y_max=3) annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Noise.UniformNoise uniformNoise2(
    samplePeriod=0.02, y_min=-1, y_max=3,
    useAutomaticLocalSeed=false,
    fixedLocalSeed=10)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
 annotation (experiment(StopTime=2), Documentation(info="<html>
<p>
This example demonstrates the most simple usage of the
<a href=\"modelica://Modelica.Blocks.Noise.UniformNoise\">Noise.UniformNoise</a>
block:
</p>

<ul>
<li> <strong>globalSeed</strong> is the <a href=\"modelica://Modelica.Blocks.Noise.GlobalSeed\">Noise.GlobalSeed</a>
     block with default options (just dragged from sublibrary Noise).</li>
<li> <strong>uniformNoise1</strong> is an instance of
     <a href=\"modelica://Modelica.Blocks.Noise.UniformNoise\">Noise.UniformNoise</a> with
     samplePeriod = 0.02 s and a Uniform distribution with limits y_min=-1, y_max=3.</li>
<li> <strong>uniformNoise2</strong> is identical to uniformNoise1 with the exception that
      useAutomaticLocalSeed=false and fixedLocalSeed=10.</li>
</ul>

<p>
At every 0.02 seconds a time event occurs and a uniform random number in the band between
-1 ... 3 is drawn. This random number is held constant until the next sample instant.
The result of a simulation is shown in the next diagram:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/NoiseExamples/UniformNoise.png\">
</blockquote>
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
end UniformNoise;
