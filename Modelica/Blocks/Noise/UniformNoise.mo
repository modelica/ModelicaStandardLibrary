within Modelica.Blocks.Noise;
block UniformNoise "Noise generator with uniform distribution"
  import distribution = Modelica.Math.Distributions.Uniform.quantile;
  extends Modelica.Blocks.Interfaces.PartialNoise;

  // Main dialog menu
  parameter Real y_min(start=0) "Lower limit of y" annotation(Dialog(enable=enableNoise));
  parameter Real y_max(start=1) "Upper limit of y" annotation(Dialog(enable=enableNoise));

initial equation
   r = distribution(r_raw, y_min, y_max);

equation
  // Draw random number at sample times
  when generateNoise and sample(startTime, samplePeriod) then
    r = distribution(r_raw, y_min, y_max);
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
          textString="%y_min")}),
    Documentation(info="<html>
<p>
A summary of the common properties of the noise blocks is provided in the documentation of package
<a href=\"modelica://Modelica.Blocks.Noise\">Blocks.Noise</a>.
This UniformNoise block generates reproducible, random noise at its output according to a uniform distribution.
This means that random values are uniformly distributed within the range defined by parameters
y_min and y_max (see example <a href=\"modelica://Modelica.Blocks.Examples.NoiseExamples.UniformNoiseProperties\">NoiseExamples.UniformNoiseProperties</a>).
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
end UniformNoise;
