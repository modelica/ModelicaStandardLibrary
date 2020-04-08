within Modelica.Blocks;
package Noise "Library of noise blocks"
  extends Modelica.Icons.Package;

  model GlobalSeed
    "Defines global settings for the blocks of sublibrary Noise, especially a global seed value is defined"
    parameter Boolean enableNoise = true
      "= true, if noise blocks generate noise as output; = false, if they generate a constant output"
      annotation(choices(checkBox=true));
    parameter Boolean useAutomaticSeed = false
      "= true, choose a seed by system time and process id; = false, use fixedSeed"
      annotation(choices(checkBox=true));
    parameter Integer fixedSeed = 67867967
      "Fixed global seed for random number generators (if useAutomaticSeed = false)"
        annotation(Dialog(enable=not useAutomaticSeed));
    final parameter Integer seed(fixed=false) "Actually used global seed";
    final parameter Integer id_impure(fixed=false)
      "ID for impure random number generators Modelica.Math.Random.Utilities.impureXXX" annotation(HideResult=true);
  initial equation
    seed = if useAutomaticSeed then Modelica.Math.Random.Utilities.automaticGlobalSeed() else fixedSeed;
    id_impure = Modelica.Math.Random.Utilities.initializeImpureRandom(seed);

    annotation (
      defaultComponentName="globalSeed",
      defaultComponentPrefixes="inner",
      missingInnerMessage="
Your model is using an outer \"globalSeed\" component but
an inner \"globalSeed\" component is not defined and therefore
a default inner \"globalSeed\" component is introduced by the tool.
To change the default setting, drag Noise.GlobalSeed
into your model and specify the seed.
", Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                           graphics={Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
                                          Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          textColor={0,0,255}),
          Line(visible = enableNoise,
               points={{-73,-15},{-59,-15},{-59,1},{-51,1},{-51,-47},{-43,-47},{-43,
                -25},{-35,-25},{-35,59},{-27,59},{-27,27},{-27,27},{-27,-33},{-17,-33},{-17,-15},{-7,-15},{-7,-43},{3,
                -43},{3,39},{9,39},{9,53},{15,53},{15,-3},{25,-3},{25,9},{31,9},{31,
                -21},{41,-21},{41,51},{51,51},{51,17},{59,17},{59,-49},{69,-49}},
              color={215,215,215}),
          Text(visible=enableNoise and not useAutomaticSeed,
            extent={{-90,-4},{88,-30}},
            textColor={255,0,0},
            textString="%fixedSeed"),
          Line(visible = not enableNoise,
            points={{-80,-4},{84,-4}},
            color={215,215,215}),
          Text(visible=enableNoise and not useAutomaticSeed,
            extent={{-84,34},{94,8}},
            textColor={255,0,0},
            textString="fixedSeed =")}),
      Documentation(revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>",   info="<html>
<p>
When using one of the blocks of sublibrary <a href=\"modelica://Modelica.Blocks.Noise\">Noise</a>,
on the same or a higher hierarchical level, Noise.GlobalSeed
must be dragged resulting in a declaration
</p>

<blockquote><pre>
<strong>inner</strong> Modelica.Blocks.Noise.GlobalSeed globalSeed;
</pre></blockquote>

<p>
The GlobalSeed block provides global options for all Noise blocks of the same or a lower
hierarchical level. The following options can be selected:
</p>

<blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Icon</th>
    <th>Description</th></tr>

<tr><td> <img src=\"modelica://Modelica/Resources/Images/Blocks/Noise/GlobalSeed_FixedSeed.png\"> </td>
    <td> <strong>useAutomaticSeed=false</strong> (= default):<br>
         A fixed global seed is defined with Integer parameter fixedSeed. The value of fixedSeed
         is displayed in the icon. By default all Noise blocks use fixedSeed for initialization of their
         pseudo random number generators, in combination with a local seed defined for every instance
         separately. Therefore, whenever a simulation is performed with the
         same fixedSeed exactly the same noise is generated in all instances of the Noise
         blocks (provided the settings of these blocks are not changed as well).<br>
         This option can be used (a) to design a control system (e.g. by parameter optimization) and keep the same
         noise for all simulations, or (b) perform Monte Carlo Simulations where
         fixedSeed is changed from the environment for every simulation, in order to
         produce different noise at every simulation run.</td></tr>

<tr><td> <img src=\"modelica://Modelica/Resources/Images/Blocks/Noise/GlobalSeed_AutomaticSeed.png\"> </td>
    <td> <strong>useAutomaticSeed=true</strong>:<br>
         An automatic global seed is computed by using the ID of the process in which the
         simulation takes place and the current local time. As a result, the global seed
         is changed automatically for every new simulation, including parallelized
         simulation runs. This option can be used to perform Monte Carlo Simulations
         with minimal effort (just performing many simulation runs) where
         every simulation run uses a different noise.</td></tr>

<tr><td> <img src=\"modelica://Modelica/Resources/Images/Blocks/Noise/GlobalSeed_NoNoise.png\"> </td>
    <td> <strong>enableNoise=false</strong>:<br>
         The noise in all Noise instances is switched off and the blocks output a constant
         signal all the time (usually zero). This option is useful, if a model shall be
         tested without noise and the noise shall be quickly turned off or on.</td></tr>
</table>
</blockquote>

<p>
Additionally, the globalSeed instance calls function
<a href=\"modelica://Modelica.Math.Random.Utilities.initializeImpureRandom\">initializeImpureRandom</a>
to initialize the impure random number generators
(<a href=\"modelica://Modelica.Math.Random.Utilities.impureRandom\">impureRandom</a> and
<a href=\"modelica://Modelica.Math.Random.Utilities.impureRandomInteger\">impureRandomInteger</a>).
The return value of this function is stored in parameter <strong>id_impure</strong>. Whenever one of the impure
random number generators need to be called, \"globalSeed.id_impure\" has to be given as input argument.
</p>

<p>
Note, the usage of this block is demonstrated with examples
<a href=\"modelica://Modelica.Blocks.Examples.Noise.AutomaticSeed\">AutomaticSeed</a> and
<a href=\"modelica://Modelica.Blocks.Examples.Noise.ImpureGenerator\">ImpureGenerator</a>.
</p>

<p>
Please note that only one globalSeed instance may be defined in the model due to the initialization
of the impure random number generators with <a href=\"modelica://Modelica.Math.Random.Utilities.initializeImpureRandom\">initializeImpureRandom</a>!
So, the block will usually reside on the top level of the model.
</p>
</html>"));
  end GlobalSeed;

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
y_min and y_max (see example <a href=\"modelica://Modelica.Blocks.Examples.Noise.UniformNoiseProperties\">Noise.UniformNoiseProperties</a>).
By default, two or more instances produce different, uncorrelated noise at the same time instant.
The block can only be used if on the same or a higher hierarchical level,
model <a href=\"modelica://Modelica.Blocks.Noise.GlobalSeed\">Blocks.Noise.GlobalSeed</a>
is dragged to provide global settings for all instances.
</p>
</html>",   revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end UniformNoise;

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
(see example <a href=\"modelica://Modelica.Blocks.Examples.Noise.NormalNoiseProperties\">Examples.Noise.NormalNoiseProperties</a>).
By default, two or more instances produce different, uncorrelated noise at the same time instant.
The block can only be used if on the same or a higher hierarchical level,
model <a href=\"modelica://Modelica.Blocks.Noise.GlobalSeed\">Blocks.Noise.GlobalSeed</a>
is dragged to provide global settings for all instances.
</p>
</html>",   revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end NormalNoise;

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
For an example see <a href=\"modelica://Modelica.Blocks.Examples.Noise.Distributions\">Examples.Noise.Distributions</a>.
By default, two or more instances produce different, uncorrelated noise at the same time instant.
The block can only be used if on the same or a higher hierarchical level,
model <a href=\"modelica://Modelica.Blocks.Noise.GlobalSeed\">Blocks.Noise.GlobalSeed</a>
is dragged to provide global settings for all instances.
</p>
</html>",   revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end TruncatedNormalNoise;

  block BandLimitedWhiteNoise
    "Noise generator to produce band-limited white noise with normal distribution"
    import distribution = Modelica.Math.Distributions.Normal.quantile;
    extends Modelica.Blocks.Interfaces.PartialNoise;

    // Main dialog menu
    parameter Real noisePower = 1 "Power of white noise signal" annotation(Dialog(enable=enableNoise));

  protected
    parameter Real mu=0;
    parameter Real sigma=sqrt(noisePower/samplePeriod);

  initial equation
     r = distribution(r_raw, mu, sigma);

  equation
    // Draw random number at sample times
    when generateNoise and sample(startTime, samplePeriod) then
      r = distribution(r_raw, mu, sigma);
    end when;
                                                                                        annotation(Dialog(enable=enableNoise), Icon(
          graphics={Text(
            extent={{-70,96},{92,60}},
            textColor={175,175,175},
            textString="%noisePower"),
          Text(
            extent={{-96,11},{96,-11}},
            textColor={175,175,175},
            origin={-87,0},
            rotation=90,
            textString="white noise")}),
                Documentation(info="<html>
<p>
A summary of the common properties of the noise blocks is provided in the documentation of package
<a href=\"modelica://Modelica.Blocks.Noise\">Blocks.Noise</a>.
This BandLimitedWhiteNoise block generates reproducible, random noise at its output according to a
band-limited white noise distribution. This is performed by using a normal distribution with mu=0 and
sigma = sqrt(noisePower/samplePeriod).
</p>

<p>
In order for this block to produce meaningful results, you should set the following
parameters:
</p>

<ul>
<li> The <strong>samplePeriod</strong> of the block should be much faster (say by a factor of 100)
     than the fastest dynamics of the system fed by the block&#39;s outputs.</li>
<li> The <strong>noisePower</strong> of the signal should be set to the expected power per frequency
     of the white noise. Since many system models assume a noise power of 1,
     this preset may be a reasonable first choice (= default).</li>
</ul>

<h4>About sampling frequencies</h4>

<p>
Ideal white noise contains all frequencies, including infinitely high ones.
However, these usually cannot be observed in physical systems, since all physical systems in
one way or the other contain low-pass filters. It is thus sufficient to generate a
limited range of frequency content in the noise signal, as long as it exceeds the frequencies of
the subsequent dynamics by a sufficiently high factor (of e.g. 100).
</p>

<h4>About noise power</h4>

<p>
Ideal white noise has a flat, i.e. constant, power spectral density for all frequencies.
It has thus infinitely high power, because the total power of a signal can be obtained by
integrating the power spectral density over all frequencies. The following three ways to
think of the power of a signal may be helpful:
</p>

<ul>
<li> The energy of a signal is the integral of its squared absolute value over time.
     The signal&#39;s power is this integral divided by the time span of the integral.</li>
<li> The total power of a signal can also be obtained by integrating its (two-sided)
     power spectral density over all frequencies.</li>
<li> The total power of a signal is finally also equal to its variance.</li>
</ul>

<p>
In order to set the correct level of the band-limited white noise power spectral density,
the variance of its normal distribution can thus be influenced directly.
Recalling that the samplePeriod of the noise signal generates frequency content in the
range &plusmn;0.5/samplePeriod, the variance must be increased to generate sufficient
total signal power. The total power must match the product of the noisePower and its
frequency bandwidth 1/samplePeriod: <code>signal power = signal variance = noisePower / samplePeriod</code>.
</p>

<p>
Example <a href=\"modelica://Modelica.Blocks.Examples.Noise.DrydenContinuousTurbulence\">Examples.Noise.DrydenContinuousTurbulence</a>
demonstrates how to utilize this block to model wind gust.
</p>
</html>"));
  end BandLimitedWhiteNoise;
  annotation (Icon(graphics={Line(
      points={{-84,0},{-54,0},{-54,40},{-24,40},{-24,-70},{6,-70},{6,80},
          {36,80},{36,-20},{66,-20},{66,60}})}), Documentation(info="<html>
<p>
This sublibrary contains blocks that generate <strong>reproducible noise</strong> with pseudo random
numbers. Reproducibility is important when designing control systems,
either manually or with optimization methods (for example when changing a parameter or a component
of a control system and re-simulating, it is important that the noise does not change, because
otherwise it is hard to determine whether the changed control system or the differently
computed noise has changed the behaviour of the controlled system).
Many examples how to use the Noise blocks are provided in sublibrary
<a href=\"modelica://Modelica.Blocks.Examples.Noise\">Blocks.Examples.Noise</a>.
</p>

<h4>Global Options</h4>

<p>
When using one of the blocks of this sublibrary, on the same or a higher level,
block <a href=\"modelica://Modelica.Blocks.Noise.GlobalSeed\">Noise.GlobalSeed</a>
must be dragged resulting in a declaration
</p>

<blockquote><pre>
<strong>inner</strong> Modelica.Blocks.Noise.GlobalSeed globalSeed;
</pre></blockquote>

<p>
This block is used to define global options that hold for all Noise block
instances (such as a global seed for initializing the random number generators,
and a flag to switch off noise). Furthermore, the impure random number generator
<a href=\"modelica://Modelica.Math.Random.Utilities.impureRandom\">impureRandom</a> is initialized here.
</p>

<p>
Please note that only one globalSeed instance may be defined in the model due to the initialization
of the impureRandom(..) random number generator! So, the block will usually reside on the top level of the model.
</p>

<h4>Parameters that need to be defined</h4>

<p>
When using a noise block of this package, at a minimum the following parameters must be defined:
</p>

<blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Parameter</th>
    <th>Description</th></tr>

<tr><td> samplePeriod </td>
    <td> Random values are drawn periodically at the sample rate in [s]
         defined with this parameter (time events are generated at the sample instants).
         Between sample instants, the output y is kept constant.</td></tr>

<tr><td> distribution data </td>
    <td> Every noise block in this package needs additional data to describe the respective
         distribution. A random number distribution maps the drawn random numbers
         from the range 0.0 ... 1.0, to the desired range and distribution.
         </td></tr>
</table>
</blockquote>

<p>
As a simple demonstration, see example <a href=\"modelica://Modelica.Blocks.Examples.Noise.UniformNoise\">Blocks.Examples.Noise.UniformNoise</a>.
In the next diagram, a simulation result is shown for samplePeriod=0.02 s and uniform distribution with
y_min=-1, y_max=3:
</p>
<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Examples/Noise/UniformNoise.png\">
</blockquote>

<h4>Advanced tab: General settings</h4>
<p>
In the <strong>Advanced</strong> tab of the parameter menu, further options can be set in the noise blocks
as shown in the next table:
</p>

<blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Parameter</th>
    <th>Description</th></tr>

<tr><td> enableNoise </td>
    <td> = true, if noise is generated at the output of the block (this is the default).<br>
         = false, if noise generation is switched off and the constant value
         y_off is provided as output.</td></tr>
<tr><td> y_off </td>
    <td> If enableNoise = false, the output of the block instance has the
         value y_off. Default is y_off = 0.0.
         Furthermore, if enableNoise = true and time&lt;startTime, the output of the block is also
         y_off (see description of parameter startTime below).</td></tr>
</table>
</blockquote>

<h4>Advanced tab: Initialization</h4>

<p>
For every block instance, the internally used pseudo random number generator
has its own state. This state must be properly initialized, depending on
the desired situation. For this purpose the following parameters can be defined:
</p>

<blockquote>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Parameter</th>
    <th>Description</th></tr>

<tr><td> useGlobalSeed </td>
    <td> = true, if the seed (= Integer number) defined in the \"inner GlobalSeed globalSeed\"
         component is used for the initialization of the random number generator used in this
         instance of the noise block.
         Therefore, whenever the globalSeed defines a different number, the noise at every
         instance is changing. This is the default setting and therefore the globalSeed component
         defines whether every new simulation run shall provide the same noise
         (e.g. for a parameter optimization of controller parameters), or
         whether every new simulation run shall provide different noise
         (e.g. for a Monte Carlo simulation).<br>
         = false, if the seed defined by globalSeed is ignored. For example, if
         aerodynamic turbulence is modelled with a noise block and this turbulence
         model shall be used for all simulation runs of a Monte Carlo simulation, then
         useGlobalSeed has to be set to false.</td></tr>

<tr><td> useAutomaticLocalSeed </td>
    <td> An Integer number, called local seed, is needed to initialize the random number
         generator for a specific block instance. Instances using the same local seed
         produce exactly the same random number values (so the same noise, if the other settings
         of the instances are the same).<br>
         If <strong>useAutomaticLocalSeed = true</strong>, the
         local seed is determined automatically using a hash value of the instance name of the model that is
         inquired with the Modelica built-in operator <a href=\"https://specification.modelica.org/v3.4/Ch3.html#getinstancename\">getInstanceName()</a>.
         Note, this means that the noise changes if the component is renamed.<br>
         If <strong>useAutomaticLocalSeed = false</strong>, the local seed is defined
         explicitly by parameter fixedLocalSeed. It is then guaranteed that the generated noise
         remains always the same (provided the other parameter values are the same).</td></tr>

<tr><td> fixedLocalSeed </td>
    <td> If useAutomaticLocalSeed = false, the local seed to be used.
         fixedLocalSeed can be any Integer number (including zero or a negative number).
         The initialization algorithm produces a meaningful initial state of the random
         number generator from fixedLocalSeed and (if useAutomaticGlobalSeed=true) from globalSeed even for
         bad seeds such as 0 or 1, so the subsequently drawing of random numbers produces always statistically
         meaningful numbers.</td></tr>

<tr><td> startTime </td>
    <td> The time instant at which noise shall be generated at the output y. The default
         startTime = 0.
         For time&lt;startTime, y = y_off. In some cases it is meaningful to simulate
         a certain duration until an approximate steady-state is reached. In such a case
         startTime should be set to a time instant after this duration.</td></tr>
</table>
</blockquote>

<h4>Random Number Generators</h4>

<p>
The core of the noise generation is the computation of uniform random
numbers in the range 0.0 .. 1.0 (and these random numbers are transformed
afterwards, see below). This sublibrary uses the xorshift random number generation
suite developed in 2014 by Sebastiano Vigna (for details see
<a href=\"http://xorshift.di.unimi.it\">http://xorshift.di.unimi.it</a> and
<a href=\"modelica://Modelica.Math.Random.Generators\">Math.Random.Generators</a>).
These random number generators have excellent
statistical properties, produce quickly statistically relevant random numbers, even if
starting from a bad initial seed, and have a reasonable length of the internal state
vector of 2, 4, and 33 Integer elements. The random number generator with an internal
state vector of length 2 is used to initialize the other two random number generators.
The length 4 random number generator is used in the noise blocks of this package, and every
such block has its own internal state vector, as needed for reproducible noise blocks.
The random number generator with a length of 33 Integer is used from the impure random number
generator. It is suited even for massively parallel simulations where every simulation
computes a large number of random values. More details of the random number
generators are described in the documentation of package
<a href=\"modelica://Modelica.Math.Random.Generators\">Math.Random.Generators</a>.
</p>

<h4>Distributions</h4>

<p>
The uniform random numbers in the range 0.0 .. 1.0 are transformed to a desired
random number distribution by selecting an appropriate <strong>distribution</strong> or
<strong>truncated distribution</strong>. For an example of a truncated distribution, see the following
diagram of the probability density function of a normal distribution
compared with its truncated version:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.density.png\">
</blockquote>

<p>
The corresponding inverse cumulative distribution functions are shown in the next diagram:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.quantile.png\">
</blockquote>

<p>
When providing an x-value between 0.0 .. 1.0 from a random number generator, then the truncated
inverse cumulative probability density function of a normal distribution transforms this value into the
desired band (in the diagram above to the range: -1.5 .. 1.5). Contrary to a standard distribution,
truncated distributions have the advantage that the resulting random values are guaranteed
to be in the defined band (whereas a standard normal distribution might also result in any value;
when modeling noise that is known to be in a particular range, say &plusmn; 0.1 Volt,
then with the TruncatedNormal distribution it is guaranteed that random values are only
generated in this band). More details of truncated
distributions are given in the documentation of package
<a href=\"modelica://Modelica.Math.Distributions\">Math.Distributions</a>.
</p>
</html>", revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=\"0\">
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\" alt=\"DLR logo\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
end Noise;
