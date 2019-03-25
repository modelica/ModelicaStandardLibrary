within Modelica.Math;
package Distributions "Library of distribution functions"
   extends Modelica.Icons.Package;

  package Uniform "Library of uniform distribution functions"
    extends Modelica.Icons.Package;

    function density "Density of uniform distribution"
      extends Modelica.Math.Distributions.Interfaces.partialDensity;
      input Real u_min=0 "Lower limit of u" annotation (Dialog);
      input Real u_max=1 "Upper limit of u" annotation (Dialog);
    algorithm
      y := if u < u_min or u > u_max then 0.0 else 1/(u_max - u_min);

      annotation (Inline=true,Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Uniform.<strong>density</strong>(u, u_min=0, u_max=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the probability density function according to a <strong>uniform</strong> distribution in a band.
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Uniform.density.png\">
</blockquote>

<p>
For more details, see
<a href=\"http://en.wikipedia.org/wiki/Uniform_distribution_(continuous)\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  density(0.5)    // = 1
  density(0,-1,1) // = 0.5
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Uniform.cumulative\">Uniform.cumulative</a>,
<a href=\"modelica://Modelica.Math.Distributions.Uniform.quantile\">Uniform.quantile</a>.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end density;

    function cumulative
      "Cumulative distribution function of uniform distribution"
      extends Modelica.Math.Distributions.Interfaces.partialCumulative;
      input Real u_min=0 "Lower limit of u" annotation (Dialog);
      input Real u_max=1 "Upper limit of u" annotation (Dialog);
    algorithm
      y := if u < u_min then 0.0 else
           if u > u_max then 1.0 else (u-u_min)/(u_max-u_min);

      annotation (Inline=true,Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Uniform.<strong>cumulative</strong>(u, u_min=0, u_max=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the cumulative distribution function
according to a <strong>uniform</strong> distribution in a band.
The returned value y is in the range:
</p>

<blockquote>
0 &le; y &le; 1
</blockquote>

<p>
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Uniform.cumulative.png\">
</blockquote>

<p>
For more details, see
<a href=\"http://en.wikipedia.org/wiki/Uniform_distribution_(continuous)\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  cumulative(0.5)    // = 0.5
  cumulative(0,-1,1) // = 0.5
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Uniform.density\">Uniform.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.Uniform.quantile\">Uniform.quantile</a>.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end cumulative;

    function quantile "Quantile of uniform distribution"
      extends Modelica.Math.Distributions.Interfaces.partialQuantile;
      input Real y_min=0 "Lower limit of y" annotation (Dialog);
      input Real y_max=1 "Upper limit of y" annotation (Dialog);
    algorithm
      y := u*(y_max - y_min) + y_min;
      annotation (Inline=true,Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Uniform.<strong>quantile</strong>(u, y_min=0, y_max=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the inverse cumulative distribution function (= quantile) according to a <strong>uniform</strong>
distribution in a band. Input argument u must be in the range:
</p>

<blockquote>
<p>
0 &le; u &le; 1
</p>
</blockquote>

<p>
The returned number y is in the range:
</p>

<blockquote>
<p>
y_min &le; y &le; y_max
</p>
</blockquote>

<p>
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Uniform.quantile.png\">
</blockquote>

<p>
For more details, see
<a href=\"http://en.wikipedia.org/wiki/Uniform_distribution_(continuous)\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  quantile(0.5)      // = 0.5
  quantile(0.5,-1,1) // = 0
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Uniform.density\">Uniform.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.Uniform.cumulative\">Uniform.cumulative</a>.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end quantile;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
          -100,-100},{100,100}}), graphics={Line(
        points={{-80,-60},{-40,-60},{-40,60},{40,60},{40,-60},{80,-60}})}), Documentation(info="<html>
<p>
This package provides
</p>
<ul>
<li> probability density function (= derivative of cumulative distribution function),</li>
<li> cumulative distribution function, and</li>
<li> quantile (= inverse cumulative distribution function).</li>
</ul>
<p>
of the <strong>uniform</strong> distribution. Examples:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Uniform.density.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Uniform.cumulative.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Uniform.quantile.png\">
</blockquote>

<p>
For more details of this distribution see
<a href=\"http://en.wikipedia.org/wiki/Uniform_distribution_(continuous)\">Wikipedia</a>.
</p>
</html>",   revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end Uniform;

  package Normal "Library of normal distribution functions"
     extends Modelica.Icons.Package;

    function density "Density of normal distribution"
      extends Modelica.Math.Distributions.Interfaces.partialDensity;
      input Real mu=0 "Expectation (mean) value of the normal distribution" annotation(Dialog);
      input Real sigma=1 "Standard deviation of the normal distribution" annotation(Dialog);
    algorithm
      y := exp(-(u-mu)^2/(2*sigma^2))/(sigma*sqrt(2*Modelica.Constants.pi));

      annotation (Inline=true, Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Normal.<strong>density</strong>(u, mu=0, sigma=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the probability density function according to a <strong>normal</strong> distribution
with mean value <strong>mu</strong> and standard deviation <strong>sigma</strong> (variance = sigma<sup>2</sup>).
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Normal.density.png\">
</blockquote>

<p>
For more details, see
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  density(0.5)     // = 0.3520653267642995
  density(3,1,0.5) // = 0.00026766045152977074
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Normal.cumulative\">Normal.cumulative</a>,
<a href=\"modelica://Modelica.Math.Distributions.Normal.quantile\">Normal.quantile</a>.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end density;

    function cumulative
      "Cumulative distribution function of normal distribution"
      import Modelica.Math.Special;
      extends Modelica.Math.Distributions.Interfaces.partialCumulative;
      input Real mu=0 "Expectation (mean) value of the normal distribution" annotation(Dialog);
      input Real sigma=1 "Standard deviation of the normal distribution" annotation(Dialog);
    algorithm
      y :=(1 + Special.erf((u - mu)/(sigma*sqrt(2))))/2;

      annotation (Inline=true,Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Normal.<strong>cumulative</strong>(u, mu=0, sigma=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the cumulative distribution function according to a <strong>normal</strong> distribution
with mean value <strong>mu</strong> and standard deviation <strong>sigma</strong> (variance = sigma<sup>2</sup>).
The returned value y is in the range:
</p>

<blockquote>
0 &le; y &le; 1
</blockquote>

<p>
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Normal.cumulative.png\">
</blockquote>

<p>
For more details, see
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  cumulative(0.5)      // = 0.6914624612740131
  cumulative(0,1,0.5)  // = 0.15865525393145707
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Normal.density\">Normal.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.Normal.quantile\">Normal.quantile</a>.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end cumulative;

    function quantile "Quantile of normal distribution"
      import Modelica.Math.Special;
      extends Modelica.Math.Distributions.Interfaces.partialQuantile;
      input Real mu=0 "Expectation (mean) value of the normal distribution" annotation(Dialog);
      input Real sigma=1 "Standard deviation of the normal distribution" annotation(Dialog);
    algorithm
      y :=mu + sigma*sqrt(2)*Special.erfInv(2*u-1);

      annotation (Inline=true, Documentation(info="<html>

<h4>Syntax</h4>
<blockquote><pre>
Normal.<strong>quantile</strong>(u, y_min=0, y_max=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the inverse cumulative distribution function (= quantile) according to a <strong>normal</strong> distribution
with mean value <strong>mu</strong> and standard deviation <strong>sigma</strong> (variance = sigma<sup>2</sup>).
Input argument u must be in the range:
</p>

<blockquote>
<p>
0 &lt; u &lt; 1
</p>
</blockquote>

<p>
If the input argument u is a uniformly distributed random number, then
99.7 % of the returned random numbers are in the range:
</p>

<blockquote>
<p>
mu-3*sigma &le; y &le; mu+3*sigma
</p>
</blockquote>

<p>
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Normal.quantile.png\">
</blockquote>

<p>
For more details, see
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  quantile(0.001)     // = -3.090232306167813;
  quantile(0.5,1,0.5) // = 1
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Normal.density\">Normal.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.Normal.cumulative\">Normal.cumulative</a>.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end quantile;
  annotation (Icon(graphics={Line(
            points={{-70,-63.953},{-66.5,-63.8975},{-63,-63.7852},{-59.5,
            -63.5674},{-56,-63.1631},{-52.5,-62.4442},{-49,-61.2213},{
            -45.5,-59.2318},{-42,-56.1385},{-38.5,-51.5468},{-35,-45.0467},
            {-31.5,-36.2849},{-28,-25.0617},{-24.5,-11.4388},{-21,4.16818},
            {-17.5,20.9428},{-14,37.695},{-10.5,52.9771},{-7,65.2797},{
            -3.5,73.2739},{0,76.047},{3.5,73.2739},{7,65.2797},{10.5,
            52.9771},{14,37.695},{17.5,20.9428},{21,4.16818},{24.5,
            -11.4388},{28,-25.0617},{31.5,-36.2849},{35,-45.0467},{38.5,
            -51.5468},{42,-56.1385},{45.5,-59.2318},{49,-61.2213},{52.5,
            -62.4442},{56,-63.1631},{59.5,-63.5674},{63,-63.7852},{66.5,
            -63.8975},{70,-63.953}},
            smooth=Smooth.Bezier)}), Documentation(info="<html>
<p>
This package provides
</p>
<ul>
<li> probability density function (= derivative of cumulative distribution function),</li>
<li> cumulative distribution function, and</li>
<li> quantile (= inverse cumulative distribution function).</li>
</ul>
<p>
of the <strong>normal</strong> distribution. Examples:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Normal.density.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Normal.cumulative.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Normal.quantile.png\">
</blockquote>

<p>
For more details of this distribution see
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>.
</p>
</html>",   revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end Normal;

  package TruncatedNormal "Library of truncated normal distribution functions"
    extends Modelica.Icons.Package;

    function density "Density of truncated normal distribution"
      import Modelica.Math.Distributions.Normal;
      extends Modelica.Math.Distributions.Interfaces.partialTruncatedDensity;
      input Real mu= (u_max + u_min)/2
        "Expectation (mean) value of the normal distribution" annotation(Dialog);
      input Real sigma=(u_max - u_min)/6
        "Standard deviation of the normal distribution" annotation(Dialog);
    protected
      Real pdf;
      Real cdf_min;
      Real cdf_max;
    algorithm
      if u >= u_min and u <= u_max then
         pdf :=Normal.density(u,mu,sigma);
         cdf_min :=Normal.cumulative(u_min,mu,sigma);
         cdf_max :=Normal.cumulative(u_max,mu,sigma);
         y := pdf / max(cdf_max - cdf_min, 10*Modelica.Constants.eps);
      else
         y := 0;
      end if;
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Normal.<strong>density</strong>(u, u_min=0, u_max=1, mu=0, sigma=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the probability density function according to a
<strong>truncated normal</strong> distribution with
minimum value <strong>u_min</strong>, maximum value <strong>u_max</strong>,
mean value of original distribution <strong>mu</strong> and
standard deviation of original distribution <strong>sigma</strong> (variance = sigma<sup>2</sup>).
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.density.png\">
</blockquote>

<p>
For more details<br>
of the normal distribution, see
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>,<br>
of truncated distributions, see
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  density(0.5)                // = 1.041828977196953
  density(0.5,-1.5,1.5,1,0.9) // = 0.5365495585520803
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.TruncatedNormal.cumulative\">TruncatedNormal.cumulative</a>,
<a href=\"modelica://Modelica.Math.Distributions.TruncatedNormal.quantile\">TruncatedNormal.quantile</a>.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end density;

    function cumulative
      "Cumulative distribution function of truncated normal distribution"
      import Modelica.Math.Distributions.Normal;
      extends Modelica.Math.Distributions.Interfaces.partialTruncatedCumulative;
      input Real mu= (u_max + u_min)/2
        "Expectation (mean) value of the normal distribution" annotation(Dialog);
      input Real sigma=(u_max - u_min)/6
        "Standard deviation of the normal distribution" annotation(Dialog);
    protected
      Real cdf;
      Real cdf_min;
      Real cdf_max;
    algorithm
      if u <= u_min then
         y := 0;
      elseif u < u_max then
         cdf     :=Normal.cumulative(u, mu, sigma);
         cdf_min :=Normal.cumulative(u_min, mu, sigma);
         cdf_max :=Normal.cumulative(u_max, mu, sigma);
         y := (cdf - cdf_min) / max(cdf_max - cdf_min, 10*Modelica.Constants.eps);
      else
         y := 1;
      end if;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Normal.<strong>cumulative</strong>(u, u_min=0, u_max=1, mu=0, sigma=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the cumulative distribution function according to a
<strong>truncated normal</strong> distribution with
minimum value <strong>u_min</strong>, maximum value <strong>u_max</strong>,
mean value of original distribution <strong>mu</strong> and
standard deviation of original distribution <strong>sigma</strong> (variance = sigma<sup>2</sup>).
The returned value y is in the range:
</p>

<blockquote>
0 &le; y &le; 1
</blockquote>

<p>
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.cumulative.png\">
</blockquote>

<p>
For more details<br>
of the normal distribution, see
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>,<br>
of truncated distributions, see
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  cumulative(0.5)                 // = 0.5
  cumulative(0.5,-1.5,1.5,1,0.9)  // = 0.4046868865634537
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Normal.density\">TruncatedNormal.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.Normal.quantile\">TruncatedNormal.quantile</a>.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end cumulative;

    function quantile "Quantile of truncated normal distribution"
      import Modelica.Math.Distributions.Normal;
      extends Modelica.Math.Distributions.Interfaces.partialTruncatedQuantile;
      input Real mu= (y_max + y_min)/2
        "Expectation (mean) value of the normal distribution" annotation(Dialog);
      input Real sigma=(y_max - y_min)/6
        "Standard deviation of the normal distribution" annotation(Dialog);
    protected
      Real cdf_min = Normal.cumulative(y_min, mu, sigma);
      Real cdf_max = Normal.cumulative(y_max, mu, sigma);
    algorithm
      y := Normal.quantile(cdf_min + u*(cdf_max-cdf_min), mu=mu, sigma=sigma);

      /* Close to u=0 and u=1, large errors in the numerical computation can
   occur. The following statement is a guard to still keep the property
     that y is within y_min/y_max
  */
      y := min(y_max,max(y_min,y));

      annotation (smoothOrder = 1,Documentation(info="<html>

<h4>Syntax</h4>
<blockquote><pre>
Normal.<strong>quantile</strong>(u, y_min=0, y_max=1, mu=0, sigma=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the inverse cumulative distribution function (= quantile) according to a
<strong>truncated normal</strong> distribution with
minimum value <strong>u_min</strong>, maximum value <strong>u_max</strong>,
mean value of original distribution <strong>mu</strong> and
standard deviation of original distribution <strong>sigma</strong> (variance = sigma<sup>2</sup>).
Input argument u must be in the range:
</p>

<blockquote>
<p>
0 &lt; u &lt; 1
</p>
</blockquote>

<p>
Output argument y is in the range:
</p>


<blockquote>
<p>
y_min &le; y &le; y_max
</p>
</blockquote>

<p>
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.quantile.png\">
</blockquote>

<p>
For more details<br>
of the normal distribution, see
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>,<br>
of truncated distributions, see
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  quantile(0.001)           // = 0.001087357613043849;
  quantile(0.5,0,1,0.5,0.9) // = 0.5
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.TruncatedNormal.density\">TruncatedNormal.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.TruncatedNormal.cumulative\">TruncatedNormal.cumulative</a>.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end quantile;
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}),
                     graphics={
          Line(
            points={{-32,-32},{-32,-80}}),
                             Line(
            points={{-32,-32},{-28,-21.0617},{-24.5,-7.4388},{-21,8.1682},{
                -17.5,24.9428},{-14,41.695},{-10.5,56.9771},{-7,69.2797},{-3.5,
                77.2739},{0,80.047},{3.5,77.2739},{7,69.2797},{10.5,56.9771},{
                14,41.695},{17.5,24.9428},{21,8.1682},{24.5,-7.4388},{28,
                -21.0617},{31.5,-32.2849},{35,-41.0467}},
            smooth=Smooth.Bezier),
          Line(
            points={{34.5,-40.5},{34.5,-78.5}}),
          Line(
            points={{34.5,-78.5},{70.5,-78.5}}),
          Line(
            points={{-68,-79},{-32,-79}})}),
      Documentation(info="<html>
<p>
This package provides
</p>
<ul>
<li> probability density function (= derivative of cumulative distribution function),</li>
<li> cumulative distribution function, and</li>
<li> quantile (= inverse cumulative distribution function).</li>
</ul>
<p>
of the <strong>truncated normal</strong> distribution. Examples:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.density.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.cumulative.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.quantile.png\">
</blockquote>

<p>
For more details<br>
of the normal distribution, see
<a href=\"http://en.wikipedia.org/wiki/Normal_distribution\">Wikipedia</a>,<br>
of truncated distributions, see
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>
</html>",   revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end TruncatedNormal;

  package Weibull "Library of Weibull distribution functions"
    extends Modelica.Icons.Package;

    function density "Density of Weibull distribution"
      extends Modelica.Math.Distributions.Interfaces.partialDensity;
      input Real lambda(min=0) = 1
        "Scale parameter of the Weibull distribution" annotation(Dialog);
      input Real k(min=0) "Shape parameter of the Weibull distribution" annotation(Dialog);
    algorithm
      y :=if u >= 0 then (k/lambda)*(u/lambda)^(k - 1)*exp(-(u/lambda)^k) else 0.0;

      annotation (Inline=true, Documentation(info="<html>

<h4>Syntax</h4>
<blockquote><pre>
Weibull.<strong>density</strong>(u, lambda=1, k=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the probability density function according to a <strong>Weibull</strong> distribution
with scale parameter <strong>lambda</strong> and shape parameter <strong>k</strong>. Equation:
</p>

<blockquote><pre>
y = if u >= 0 then (k/lambda)*(u/lambda)^(k - 1)*exp(-(u/lambda)^k) else 0.0;
</pre></blockquote>

<p>
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Weibull.density.png\">
</blockquote>

<p>
For more details, see
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  density(0.5)     // = 0.36787944117144233
  density(1,0.5,2) // = 0.14652511110987343
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Weibull.cumulative\">Weibull.cumulative</a>,
<a href=\"modelica://Modelica.Math.Distributions.Weibull.quantile\">Weibull.quantile</a>.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end density;

    function cumulative
      "Cumulative distribution function of Weibull distribution"
      import Modelica.Math.Special;
      extends Modelica.Math.Distributions.Interfaces.partialCumulative;
      input Real lambda(min=0) = 1
        "Scale parameter of the Weibull distribution" annotation(Dialog);
      input Real k(min=0) "Shape parameter of the Weibull distribution" annotation(Dialog);
    algorithm
      y := if u >= 0 then 1 - exp(-(u/lambda)^k) else 0.0;

      annotation (Inline=true,Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Weibull.<strong>cumulative</strong>(u, lambda=1, k=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the cumulative distribution function
according to a <strong>Weibull</strong> distribution
with scale parameter <strong>lambda</strong> and shape parameter <strong>k</strong>. Equation:
</p>

<blockquote><pre>
y := if u >= 0 then 1 - exp(-(u/lambda)^k) else 0.0;
</pre></blockquote>

<p>
The returned value y is in the range:
</p>

<blockquote>
0 &le; y &le; 1
</blockquote>

<p>
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Weibull.cumulative.png\">
</blockquote>

<p>
For more details, see
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  cumulative(0.5)       // = 0.3934693402873666
  cumulative(0.5,0.5,1) // = 0.6321205588285577
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Weibull.density\">Weibull.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.Weibull.quantile\">Weibull.quantile</a>.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end cumulative;

    function quantile "Quantile of Weibull distribution"
      extends Modelica.Math.Distributions.Interfaces.partialQuantile;
      input Real lambda(min=0) = 1
        "Scale parameter of the Weibull distribution" annotation(Dialog);
      input Real k(min=0) "Shape parameter of the Weibull distribution" annotation(Dialog);
    algorithm
      y := lambda * (-log( 1-u)) ^(1/k);

      annotation (Inline=true, Documentation(info="<html>

<h4>Syntax</h4>
<blockquote><pre>
Weibull.<strong>quantile</strong>(u, lambda=1, k=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the inverse cumulative distribution function (= quantile) according to a <strong>Weibull</strong> distribution
with scale parameter <strong>lambda</strong> and shape parameter <strong>k</strong>. Equation:
</p>

<blockquote><pre>
y := lambda * (-log( 1-u)) ^(1/k);
</pre></blockquote>

<p>
Input argument u must be in the range:
</p>
<blockquote>
<p>
0 &le; u &lt; 1
</p>
</blockquote>

<p>
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Weibull.quantile.png\">
</blockquote>

<p>
For more details, see
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  quantile(0)         // = 0
  quantile(0.5,1,0.5) // = 0.41627730557884884
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.Weibull.density\">Weibull.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.Weibull.cumulative\">Weibull.cumulative</a>.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end quantile;
    annotation (Icon(graphics={Line(
            points={{-72,-60},{-68.5,-60},{-65,-60},{-61.5,-60},{-58,-60},{-54.5,-60},{-51,-60},{-47.5,
                -60},{-44,-60},{-40.5,-60},{-37,-60},{-33.5,-60},{-30,-60},{-26.5,-60},{-23,-60},{-19.5,
                -60},{-16,-60},{-12.5,-60},{-9,-60},{-5.5,-60},{-2,-60},{1.5,43.1424},{5,71.1658},{8.5,
                80},{12,77.3585},{15.5,67.6645},{19,54.0082},{22.5,38.6157},{26,23.0458},{29.5,8.32389},
                {33,-4.9424},{36.5,-16.4596},{40,-26.1579},{43.5,-34.1153},{47,-40.4975},{50.5,-45.5133},
                {54,-49.3832},{57.5,-52.3187},{61,-54.5105},{64.5,-56.123},{68,-57.2928}},
            smooth=Smooth.Bezier)}), Documentation(info="<html>
<p>
This package provides
</p>
<ul>
<li> probability density function (= derivative of cumulative distribution function),</li>
<li> cumulative distribution function, and</li>
<li> quantile (= inverse cumulative distribution function).</li>
</ul>
<p>
of the <strong>Weibull</strong> distribution. Examples:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Weibull.density.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Weibull.cumulative.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/Weibull.quantile.png\">
</blockquote>

<p>
For more details of this distribution see
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>.
</p>
</html>",   revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end Weibull;

  package TruncatedWeibull
    "Library of truncated Weibull distribution functions"
    extends Modelica.Icons.Package;

    function density "Density of truncated Weibull distribution"
      import Modelica.Math.Distributions.Weibull;
      extends Modelica.Math.Distributions.Interfaces.partialTruncatedDensity;
      input Real lambda(min=0) = 1
        "Scale parameter of the Weibull distribution" annotation(Dialog);
      input Real k(min=0) "Shape parameter of the Weibull distribution" annotation(Dialog);
    protected
      Real pdf;
      Real cdf_min;
      Real cdf_max;
    algorithm
      if u >= u_min and u <= u_max then
         pdf :=Weibull.density(u, lambda=lambda, k=k);
         cdf_min :=Weibull.cumulative(u_min, lambda=lambda, k=k);
         cdf_max :=Weibull.cumulative(u_max, lambda=lambda, k=k);
         y := pdf / max(cdf_max - cdf_min, 10*Modelica.Constants.eps);
      else
         y := 0;
      end if;
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Weibull.<strong>density</strong>(u, u_min=0, u_max=1, lambda=1, k=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the probability density function according to a
<strong>truncated Weibull</strong> distribution with
minimum value <strong>u_min</strong>, maximum value <strong>u_max</strong>,
scale parameter of original distribution <strong>lambda</strong> and
shape parameter of original distribution <strong>k</strong>.
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedWeibull.density.png\">
</blockquote>

<p>
For more details<br>
of the Weibull distribution, see
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>,<br>
of truncated distributions, see
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  density(0.5)             // = 0.9595173756674719
  density(0.5,0,0.8,0.5,2) // = 1.5948036466479143
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.TruncatedWeibull.cumulative\">TruncatedWeibull.cumulative</a>,
<a href=\"modelica://Modelica.Math.Distributions.TruncatedWeibull.quantile\">TruncatedWeibull.quantile</a>.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end density;

    function cumulative
      "Cumulative distribution function of truncated Weibull distribution"
      import Modelica.Math.Distributions.Weibull;
      extends Modelica.Math.Distributions.Interfaces.partialTruncatedCumulative;
      input Real lambda(min=0) = 1
        "Scale parameter of the Weibull distribution" annotation(Dialog);
      input Real k(min=0) "Shape parameter of the Weibull distribution" annotation(Dialog);
    protected
      Real cdf;
      Real cdf_min;
      Real cdf_max;
    algorithm
      if u <= u_min then
         y := 0;
      elseif u < u_max then
         cdf     :=Weibull.cumulative(u, lambda=lambda, k=k);
         cdf_min :=Weibull.cumulative(u_min, lambda=lambda, k=k);
         cdf_max :=Weibull.cumulative(u_max, lambda=lambda, k=k);
         y := (cdf - cdf_min) / max(cdf_max - cdf_min, 10*Modelica.Constants.eps);
      else
         y := 1;
      end if;

      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Weibull.<strong>cumulative</strong>(u, u_min=0, u_max=1, lambda=1, k=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the cumulative distribution function according to a
<strong>truncated Weibull</strong> distribution with
minimum value <strong>u_min</strong>, maximum value <strong>u_max</strong>,
scale parameter of original distribution <strong>lambda</strong> and
shape parameter of original distribution <strong>k</strong>.
The returned value y is in the range:
</p>

<blockquote>
0 &le; y &le; 1
</blockquote>

<p>
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedWeibull.cumulative.png\">
</blockquote>

<p>
For more details<br>
of the Weibull distribution, see
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>,<br>
of truncated distributions, see
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  cumulative(0.5)             // = 0.6224593312018546
  cumulative(0.5,0,0.8,0.5,2) // = 0.6850805314988328
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.TruncatedWeibull.density\">TruncatedWeibull.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.TruncatedWeibull.quantile\">TruncatedWeibull.quantile</a>.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end cumulative;

    function quantile "Quantile of truncated Weibull distribution"
      import Modelica.Math.Distributions.Weibull;
      extends Modelica.Math.Distributions.Interfaces.partialTruncatedQuantile;
      input Real lambda(min=0) = 1
        "Scale parameter of the Weibull distribution" annotation(Dialog);
      input Real k(min=0) "Shape parameter of the Weibull distribution" annotation(Dialog);
    protected
      Real cdf_min = Weibull.cumulative(y_min, lambda=lambda, k=k)
        "Value of cdf at y_min";
      Real cdf_max = Weibull.cumulative(y_max, lambda=lambda, k=k)
        "Value of cdf at y_max";
    algorithm
      y := Weibull.quantile(cdf_min + u*(cdf_max-cdf_min), lambda=lambda,k=k);

      /* Close to u=1, large errors in the numerical computation can
   occur. The following statement is a guard to still keep the property
   that y is within y_min .. y_max
  */
      y := min(y_max,max(y_min,y));

      annotation (smoothOrder=1,Documentation(info="<html>

<h4>Syntax</h4>
<blockquote><pre>
Weibull.<strong>quantile</strong>(u, y_min=0, y_max=1, lambda=1, k=1);
</pre></blockquote>

<h4>Description</h4>
<p>
This function computes the inverse cumulative distribution function (= quantile) according to a
<strong>truncated Weibull</strong> distribution with
minimum value <strong>u_min</strong>, maximum value <strong>u_max</strong>,
scale parameter of original distribution <strong>lambda</strong> and
shape parameter of original distribution <strong>k</strong>.
Input argument u must be in the range:
</p>

<blockquote>
<p>
0 &le; u &le; 1
</p>
</blockquote>

<p>
Output argument y is in the range:
</p>

<blockquote>
<p>
y_min &le; y &le; y_max
</p>
</blockquote>

<p>
Plot of the function:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedWeibull.quantile.png\">
</blockquote>

<p>
For more details<br>
of the Weibull distribution, see
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>,<br>
of truncated distributions, see
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  quantile(0.001)           // = 0.0006323204312624211;
  quantile(0.5,0,1,0.5,0.9) // = 0.256951787882498
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Distributions.TruncatedWeibull.density\">TruncatedWeibull.density</a>,
<a href=\"modelica://Modelica.Math.Distributions.TruncatedWeibull.cumulative\">TruncatedWeibull.cumulative</a>.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end quantile;
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}),
                     graphics={Line(
            points={{-72,-62},{-68.5,-62},{-65,-62},{-61.5,-62},{-58,-62},{
                -54.5,-62},{-51,-62},{-47.5,-62},{-44,-62},{-40.5,-62},{-37,-62},
                {-33.5,-62},{-30,-62},{-26.5,-62},{-23,-62},{-19.5,-62},{-16,
                -62},{-12.5,-62},{-9,-62},{-5.5,-62},{-2,-62},{1.5,41.1424},{5,
                69.1658},{8.5,78},{12,75.3585},{15.5,65.6645},{19,52.0082},{
                22.5,36.6157},{26,21.0458},{29.5,6.3239},{33,-6.9424},{36.5,
                -18.4596},{40,-28.1579},{43.5,-36.1153}},
            smooth=Smooth.Bezier),
          Line(
            points={{43.5,-36},{43.5,-63}}),
          Line(
            points={{43.5,-63},{79.5,-63}})}),
      Documentation(info="<html>
<p>
This package provides
</p>
<ul>
<li> probability density function (= derivative of cumulative distribution function),</li>
<li> cumulative distribution function, and</li>
<li> quantile (= inverse cumulative distribution function).</li>
</ul>
<p>
of the <strong>truncated Weibull</strong> distribution. Examples:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedWeibull.density.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedWeibull.cumulative.png\">
</blockquote>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedWeibull.quantile.png\">
</blockquote>

<p>
For more details<br>
of the Weibull distribution, see
<a href=\"http://en.wikipedia.org/wiki/Weibull_distribution\">Wikipedia</a>,<br>
of truncated distributions, see
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>.
</p>
</html>",   revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end TruncatedWeibull;

  package Interfaces "Library of interfaces for distribution functions"
    extends Modelica.Icons.InterfacesPackage;

    partial function partialDensity
      "Common interface of probability density functions"
      extends Modelica.Icons.Function;
      input Real u "Random number over the real axis (-inf < u < inf)";
      output Real y "Density of u";
      annotation (Documentation(info="<html>
<p>
A partial function containing the common
arguments of the probability density functions.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end partialDensity;

    partial function partialCumulative
      "Common interface of cumulative distribution functions"
      extends Modelica.Icons.Function;
      input Real u "Value over the real axis (-inf < u < inf)";
      output Real y "Value in the range 0 <= y <= 1";
      annotation (Documentation(info="<html>
<p>
A partial function containing the common
arguments of the cumulative distribution functions.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end partialCumulative;

    partial function partialQuantile
      "Common interface of quantile functions (= inverse cumulative distribution functions)"
      extends Modelica.Icons.Function;
      input Real u(min=0, max=1) "Random number in the range 0 <= u <= 1";
      output Real y
        "Random number u transformed according to the given distribution";
      annotation (Documentation(info="<html>
<p>
A partial function containing the common
arguments of the quantile functions.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end partialQuantile;

    partial function partialTruncatedDensity
      "Common interface of truncated probability density functions"
      extends partialDensity;
      input Real u_min=0 "Lower limit of u" annotation(Dialog);
      input Real u_max=1 "Upper limit of u" annotation(Dialog);
      annotation (Documentation(info="<html>
<p>
A partial function containing the common
arguments of the probability density functions of truncated distributions.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end partialTruncatedDensity;

    partial function partialTruncatedCumulative
      "Common interface of truncated cumulative distribution functions"
      extends partialCumulative;
      input Real u_min=0 "Lower limit of u" annotation(Dialog);
      input Real u_max=1 "Upper limit of u" annotation(Dialog);
      annotation (Documentation(info="<html>
<p>
A partial function containing the common
arguments of the cumulative distribution functions for a truncated distribution.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end partialTruncatedCumulative;

    partial function partialTruncatedQuantile
      "Common interface of truncated quantile functions (= inverse cumulative distribution functions)"
      extends partialQuantile;
      input Real y_min=0 "Lower limit of y" annotation(Dialog);
      input Real y_max=1 "Upper limit of y" annotation(Dialog);
      annotation (Documentation(info="<html>
<p>
A partial function containing the common
arguments of the quantile functions for truncated distributions.
</p>
</html>",     revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
    end partialTruncatedQuantile;
  annotation (Documentation(info="<html>
<p>
This package contains partial functions that describe the
common interface arguments of the distribution and
truncated distribution functions.
</p>
</html>",   revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
  end Interfaces;
annotation (Icon(graphics={Line(
          points={{-70,-65.953},{-66.5,-65.8975},{-63,-65.7852},{-59.5,
          -65.5674},{-56,-65.1631},{-52.5,-64.4442},{-49,-63.2213},{-45.5,
          -61.2318},{-42,-58.1385},{-38.5,-53.5468},{-35,-47.0467},{-31.5,
          -38.2849},{-28,-27.0617},{-24.5,-13.4388},{-21,2.1682},{-17.5,
          18.9428},{-14,35.695},{-10.5,50.9771},{-7,63.2797},{-3.5,
          71.2739},{0,74.047},{3.5,71.2739},{7,63.2797},{10.5,50.9771},{
          14,35.695},{17.5,18.9428},{21,2.1682},{24.5,-13.4388},{28,
          -27.0617},{31.5,-38.2849},{35,-47.0467},{38.5,-53.5468},{42,
          -58.1385},{45.5,-61.2318},{49,-63.2213},{52.5,-64.4442},{56,
          -65.1631},{59.5,-65.5674},{63,-65.7852},{66.5,-65.8975},{70,
          -65.953}},
          smooth=Smooth.Bezier)}), Documentation(info="<html>
<p>
This package provides
</p>
<ul>
<li> <a href=\"http://en.wikipedia.org/wiki/Probability_density_function\">probability density functions</a>
     (= derivative of cumulative distribution function),</li>
<li> <a href=\"http://en.wikipedia.org/wiki/Cumulative_distribution_function\">cumulative distribution functions</a>,
     and</li>
<li> <a href=\"http://en.wikipedia.org/wiki/Quantile_function\">quantiles</a>
     (= inverse cumulative distribution functions).</li>
</ul>
<p>
of different distributions.
</p>

<p>
In particular also <strong>truncated distributions</strong> are provided (see below).
The main reason to introduce
truncated distributions is to make the modeling of measurement noise easier, in order to
limit the band in which the noise can occur. For example, if a sensor is used and the
sensor signal has a noise of &plusmn; 0.1 Volt (e.g. this can be determined by using a reference
value of 0 V and inspecting the measured signal), then the sensor signal will be often the input
to an Analog-Digital converter and this converter limits the signal, say to &plusmn; 5 Volt.
Typically, the user would like to model noise within the noise band (say &plusmn; 0.1 Volt),
and often uses a normal distribution. But a normal distribution is not limited and
for a small sample time and a long simulation there might be some sample time instants
where the noise values of the normal signal is outside the &plusmn; 0.1 Volt range.
For some sensor types this is completely unrealistic (e.g. an angle sensor might
measure &plusmn; 0.1 rad, but the sensor will never add, say one revolution (6.28 rad) to it.
However, the noise model with a pure normal distribution could give such a value.
If a modeler would like to guarantee (and not to hope), that the modeled noise is
always between &plusmn; 0.1 Volt, then there are two main possibilities: (a) The noise is computed
and the result is then limited to &plusmn; 0.1 Volt, or (b) the normal distribution is slightly modified,
so that it is within the band of &plusmn; 0.1 Volt. Approach (a) is a brute force method that
changes the statistical properties of the signal in an unknown way. Approach (b)
is a \"clean\" mathematical description. The blocks in package
<a href=\"modelica://Modelica.Blocks.Noise\">Blocks.Noise</a>
give the user the freedom to choose: Either compute a normal (unlimited) noise, or
a truncated normal noise (truncated distribution).
</p>

<h4>
Details of truncated distributions
</h4>

<p>
Truncated distributions are distributions that are transformed in such a way that
either the input is within a band u_min .. u_max, or the output is within
a band y_min .. y_max.
A truncated distribution is derived from a base
distribution (e.g. from the normal distribution), by truncating its
probability density function to the desired band and adding a constant
value over this band, in order that the integral over the truncated distribution
remains one. All other properties (such as cumulative distribution function) can then be determined
in a straightforward way, provided the properties of the underlying base distribution
are available.
More details can be found, for example, in
<a href=\"http://en.wikipedia.org/wiki/Truncated_distribution\">Wikipedia</a>
(the equations from the \"Truncated Distribution\" box in the right part
of this Wikipedia article are used for this package).
</p>

<p>
When using random numbers according to a given truncated distribution,
the output of the inverse cumulative distribution function (= quantile) is restricted
to the defined band.
</p>

<p>
The truncated distribution functions are derived from the underlying distribution
functions in the following way:
</p>

<blockquote>
<pre>
// Original distributions
    pdf = Distributions.XXX.density(u,..);
    cdf = Distributions.XXX.cumulative(u,...);
cdf_min = Distributions.XXX.cumulative(u_min,...);
cdf_max = Distributions.XXX.cumulative(u_max,...);

// Truncated distributions
</pre>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><strong><em>Function</em></strong></th><th><strong><em>Transformation</em></strong></th></tr>
  <tr><td>density(u,u_min,u_max,...)</td>
      <td>= <strong>if</strong> u &ge; u_min <strong>and</strong> u&le;u_max <strong>then</strong> pdf / (cdf_max - cdf_min) <strong>else</strong> 0</td>
  </tr>
  <tr><td>cumulative(u,u_min,u_max,...)</td>
      <td>= <strong>if</strong> u &le; u_min <strong>then</strong> 0
            <strong>else if</strong> u &lt; u_max <strong>then</strong>
              (cdf - cdf_min))/(cdf_max - cdf_min)
            <strong>else</strong> 1</td>
  </tr>
  <tr><td>quantile(u,u_min,u_max,...)</td>
      <td>= Distributions.XXX.quantile( cdf_min + u*(cdf_max - cdf_min), ... )</td>
  </tr>
</table>
</blockquote>

<p>
For an example of a truncated distribution, see the following
plot of the probability density function of a normal distribution
compared with its truncated distribution:
</p>

<blockquote>
<img src=\"modelica://Modelica/Resources/Images/Math/Distributions/TruncatedNormal.density.png\">
</blockquote>
</html>", revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td> June 22, 2015 </td>
    <td>

<table border=0>
<tr><td>
         <img src=\"modelica://Modelica/Resources/Images/Logos/dlr_logo.png\">
</td><td valign=\"bottom\">
         Initial version implemented by
         A. Kl&ouml;ckner, F. v.d. Linden, D. Zimmer, M. Otter.<br>
         <a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>
</td></tr></table>
</td></tr>

</table>
</html>"));
end Distributions;
