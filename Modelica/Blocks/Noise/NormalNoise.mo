within Modelica.Blocks.Noise;
block NormalNoise "Noise generator with normal distribution"
  import distribution = Modelica.Math.Distributions.Normal.quantile;
  extends Modelica.Blocks.Interfaces.PartialNoise;

  // Main dialog menu
  parameter Real mu=0 "Expectation (mean) value of the normal distribution" annotation(Dialog(enable=enableNoise));
  parameter Real sigma(start=1)
    "Standard deviation of the normal distribution" annotation(Dialog(enable=enableNoise));

initial equation
   r = distribution(r_raw, mu, sigma);

equation
  // Draw random number at sample times
  when generateNoise and sample(startTime, samplePeriod) then
    r = distribution(r_raw, mu, sigma);
  end when;

    annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
            Text(visible=enableNoise,
             extent={{-66,92},{94,66}},
             textColor={175,175,175},
             textString="mu=%mu"),
            Text(visible=enableNoise,
             extent={{-70,-68},{94,-96}},
             textColor={175,175,175},
             textString="sigma=%sigma")}),
    Documentation(info="<html>
<p>
A summary of the common properties of the noise blocks is provided in the documentation of package
<a href=\"modelica://Modelica.Blocks.Noise\">Blocks.Noise</a>.
This NormalNoise block generates reproducible, random noise at its output according to a normal distribution.
This means that random values are normally distributed with expectation value mu and standard deviation sigma.
(see example <a href=\"modelica://Modelica.Blocks.Examples.NoiseExamples.NormalNoiseProperties\">NoiseExamples.NormalNoiseProperties</a>).
By default, two or more instances produce different, uncorrelated noise at the same time instant.
The block can only be used if on the same or a higher hierarchical level,
model <a href=\"modelica://Modelica.Blocks.Noise.GlobalSeed\">Blocks.Noise.GlobalSeed</a>
is dragged to provide global settings for all instances.
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
end NormalNoise;
