within Modelica.Magnetic.FluxTubes.UsersGuide;
model ParameterFit "Fitting the parameters"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<p>The magnetisation characteristics of the originally included soft magnetic materials were compiled and measured respectively by Thomas Roschke. 
Provision of this data is highly appreciated. He also formulated the approximation function used for description of the magnetisation characteristics of these materials.</p>
<p>The workflow of parameter fitting for the approximation based on Smoothing Splines with Exponential Extrapolation can be recommended as follows: </p>
<p>
For smoothing splines routines e.g. in <a href=\"https://de.mathworks.com/help/curvefit/csaps.html\">Matlab</a> or 
<a href=\"https://pypi.org/project/csaps/\">Python</a> are avialable.<br>
The idea is to give up perfect hitting the nodes and adding a term smoothing the derivative. 
This leads to an optimization problem which is solved by the mentioned routines. The objective function is shown below.<br>
<code>p</code> is a smoothing factor to be choosen by the user to achieve the desired result.
</p>
<pre><code>
p&dot;&sum;(JD<sub>k</sub> - ss(HD<sub>k</sub>)<sup>2</sup> + (1 - p)&dot;&int;d<sup>2</sup>ss/dH<sup>2</sup>&dot;dH
  k
</code></pre>
<p>
Even if the origin <code>(0, 0)</code> is included in the raw data series, the constant coefficient of the first interval is likely not zero due to teh smoothing action. 
To ensure that the approximation hits the origin, subtract from the constant coefficients of all intervals the value of the constant coefficient of the first interval, 
i.e. shift the complete approximation to hit the origin.
</p>
<p>
The parameters for exponential extrapolation <code>J<sub>sat</sub></code> and <code>H<sub>par</sub></code> 
can be determined by minimizing the following objective function:
</p>
<pre><code>
&sum;(JD<sub>k</sub> - ee(HD<sub>k</sub>)<sup>2</sup>
k&ge;k0
</code></pre>
<p>
Functions which can be called from Octave or Matlab are provided in the repository 
<a href=\"https://github.com/AHaumer/AppMag\">Approximation of Magnetic characteristics</a> 
together with the used raw data RD.ods in OpenDocument format as well as the 
<a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE\">BaseData Modelica record</a>.
</p>
</html>"));
end ParameterFit;
