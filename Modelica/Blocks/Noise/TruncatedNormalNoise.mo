within Modelica.Blocks.Noise;
block TruncatedNormalNoise
  "Noise generator with truncated normal distribution"
  import distribution =
    Modelica.Math.Distributions.TruncatedNormal.quantile;
  extends Modelica.Blocks.Interfaces.PartialNoise;

  // Main dialog menu
  parameter Real y_min(start=0) "Lower limit of y" annotation(Dialog(enable=enableNoise));
  parameter Real y_max(start=1) "Upper limit of y" annotation(Dialog(enable=enableNoise));
  parameter Real mu =    (y_max + y_min)/2
    "Expectation (mean) value of the normal distribution" annotation(Dialog(enable=enableNoise,tab="Advanced",group="Noise generation"));
  parameter Real sigma = (y_max - y_min)/6
    "Standard deviation of the normal distribution" annotation(Dialog(enable=enableNoise,tab="Advanced",group="Noise generation"));

initial equation
   r = distribution(r_raw, y_min, y_max, mu, sigma);

equation
  // Draw random number at sample times
  when generateNoise and sample(startTime, samplePeriod) then
    r = distribution(r_raw, y_min, y_max, mu, sigma);
  end when;

    annotation(Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Line(visible=enableNoise,
          points={{-76,60},{78,60}}, color={95,95,95},
          pattern=LinePattern.Dot),
        Line(visible=enableNoise,
          points={{-76,-60},{78,-60}}, color={95,95,95},
          pattern=LinePattern.Dot),
        Text(visible=enableNoise,
          extent={{-70,94},{95,64}},
          textColor={175,175,175},
          textString="%y_max"),
        Text(visible=enableNoise,
          extent={{-70,-64},{95,-94}},
          textColor={175,175,175},
          textString="%y_min"),
        Text(
          extent={{-71,12},{71,-12}},
          textColor={175,175,175},
          origin={-88,-11},
          rotation=90,
          textString="normal")}),
    Documentation(info="<html>
<p>
A summary of the common properties of the noise blocks is provided in the documentation of package
<a href=\"modelica://Modelica.Blocks.Noise\">Blocks.Noise</a>.
This TruncatedNormalNoise block generates reproducible, random noise at its output according to a truncated normal distribution.
This means that normally distributed random values are truncated to the band y_min ... y_max.
Measurement noise has often this distribution form.
By default, the standard parameters of the truncated normal distribution are derived from
y_min ... y_max:
</p>
<blockquote><p>
mean value = (y_max + y_min)/2,<br>
standard deviation = (y_max - y_min)/6 (= 99.7 % of the non-truncated normal distribution are within y_min ... y_max).
</p></blockquote>

<p>
For an example see <a href=\"modelica://Modelica.Blocks.Examples.NoiseExamples.Distributions\">NoiseExamples.Distributions</a>.
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
end TruncatedNormalNoise;
