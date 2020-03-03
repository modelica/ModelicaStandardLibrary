within Modelica.Blocks.Examples.Noise;
model NormalNoiseProperties
  "Demonstrates the computation of properties for normally distributed noise"
  extends Modelica.Icons.Example;
  parameter Real mu = 3 "Mean value for normal distribution";
  parameter Real sigma = 1 "Standard deviation for normal distribution";
  parameter Real pMean = mu "Theoretical mean value of normal distribution";
  parameter Real var =  sigma^2
    "Theoretical variance of uniform distribution";
  parameter Real std =  sigma
    "Theoretical standard deviation of normal distribution";
  inner Modelica.Blocks.Noise.GlobalSeed globalSeed
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  output Real meanError_y = meanError.y;
  output Real sigmaError_y = sigmaError.y;

  Modelica.Blocks.Noise.NormalNoise noise(
    samplePeriod=0.001,
    mu=mu,
    sigma=sigma,
    useAutomaticLocalSeed=false)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Math.ContinuousMean mean
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.Blocks.Math.Variance variance
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Math.MultiProduct theoreticalVariance(nu=2)
    annotation (Placement(transformation(extent={{28,-36},{40,-24}})));
  Modelica.Blocks.Math.Feedback meanError
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Modelica.Blocks.Sources.Constant theoreticalMean(k=pMean)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Math.Feedback varianceError
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Modelica.Blocks.Sources.Constant theoreticalSigma(k=std)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Blocks.Math.StandardDeviation standardDeviation
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Math.Feedback sigmaError
    annotation (Placement(transformation(extent={{40,-60},{60,-80}})));
equation
  connect(noise.y, mean.u) annotation (Line(
      points={{-59,70},{-42,70}}, color={0,0,127}));
  connect(noise.y, variance.u) annotation (Line(
      points={{-59,70},{-52,70},{-52,10},{-42,10}}, color={0,0,127}));
  connect(mean.y, meanError.u1) annotation (Line(
      points={{-19,70},{42,70}}, color={0,0,127}));
  connect(theoreticalMean.y, meanError.u2) annotation (Line(
      points={{11,50},{50,50},{50,62}}, color={0,0,127}));
  connect(theoreticalSigma.y, theoreticalVariance.u[1]) annotation (Line(
      points={{11,-30},{24,-30},{24,-27.9},{28,-27.9}}, color={0,0,127}));
  connect(theoreticalSigma.y, theoreticalVariance.u[2]) annotation (Line(
      points={{11,-30},{24,-30},{24,-32.1},{28,-32.1}}, color={0,0,127}));
  connect(variance.y, varianceError.u1) annotation (Line(
      points={{-19,10},{42,10}}, color={0,0,127}));
  connect(theoreticalVariance.y, varianceError.u2) annotation (Line(
      points={{41.02,-30},{50,-30},{50,2}}, color={0,0,127}));
  connect(noise.y, standardDeviation.u) annotation (Line(
      points={{-59,70},{-52,70},{-52,-70},{-42,-70}}, color={0,0,127}));
  connect(standardDeviation.y, sigmaError.u1) annotation (Line(
      points={{-19,-70},{42,-70}}, color={0,0,127}));
  connect(theoreticalSigma.y, sigmaError.u2) annotation (Line(
      points={{11,-30},{18,-30},{18,-42},{50,-42},{50,-62}}, color={0,0,127}));
 annotation (experiment(StopTime=20, Interval=0.4e-2, Tolerance=1e-009),
Documentation(info="<html>
<p>
This example demonstrates statistical properties of the
<a href=\"modelica://Modelica.Blocks.Noise.NormalNoise\">Blocks.Noise.NormalNoise</a> block
using a <strong>normal</strong> random number distribution with mu=3, sigma=1.
From the generated noise the mean and the variance
is computed with blocks of package <a href=\"modelica://Modelica.Blocks.Math\">Blocks.Math</a>.
Simulation results are shown in the next diagram:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/NoiseExamples/NormalNoiseProperties1.png\">
</blockquote>

<p>
The mean value of a normal noise with mu=3 is 3 and the variance of normal noise
is sigma^2, so 1. The simulation results above show good agreement (after a short initial phase).
This demonstrates that the random number generator and the mapping to a normal
distribution have good statistical properties.
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
end NormalNoiseProperties;
