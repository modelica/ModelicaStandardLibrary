within Modelica.Magnetic.FluxTubes.UsersGuide;
model ParameterFit "Fitting the parameters"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<p>The magnetisation characteristics of the originally included soft magnetic materials were compiled and measured respectively by Thomas Roschke. 
Provision of this data is highly appreciated. He also formulated the approximation function used for description of the magnetisation characteristics of these materials.</p>
<p>The workflow of paramter fitting for the approximation according to Macfadyen at al can be recommended as follows: </p>
<ul>
<li><code>N = 4</code> exponential terms is a good compromise between effort and accuracy.</li>
<li>Use a tool of your choice capable of nonlieanr optimization under nonlinear constraints, e.g. the Solver of Microsoft Excel or OpenOffice Calc, or fmincon of Matlab or Octave.</li>
<li>First, compare the characteristic <code>J(H)</code> of the formula without the correction term (index &quot;C&quot;, you may set <code>&chi;<sub>C</sub> = 0</code>) with measured data, 
    i.e. sum up the absolute of the differences.</li>
<li>Use as 1<sup>st</sup> constraint: <code>|1 + &sum; &chi;<sub>k</sub> - &micro;<sub>ra</sub>| &le; &epsilon;</code> 
    where &micro;<sub>ra</sub> is an extrapolation of the given relative permeability towards the origin neglecting the potential decline of this characteristics near the origin.</li>
<li>Use as 2<sup>nd</sup>  constraint <code>|&sum; &chi;<sub>k</sub>&sdot;H<sub>k</sub> - J<sub>sat</sub>| &le; &epsilon;</code> 
        where J<sub>sat</sub> is the saturation polarization as described in the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData\">raw data directory.</a></li>
<li>Since optimization is sensitive to the starting point, try to guess a good initial parameter set.</li>
<li>Try first with higher allowed deviation <code>&epsilon;</code>, then reduce &epsilon; step by step.</li>
<li>Check your solution in a diagram. If it looks good (except the region around the origin), proceed:</li>
<li>Try a good guess for <code>H<sub>C</sub></code> and <code>&chi;<sub>C</sub> &asymp; &micro;<sub>ra</sub> - &micro;<sub>ri</sub> </code> 
    where &micro;<sub>ri</sub> is the initial relative permeability as described in the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.RawData\">raw data directory</a>.</li>
<li>Change the 1<sup>st</sup> constraint: <code>|1 + &sum; &chi;<sub>k</sub> - &chi;<sub>C</sub> - &micro;<sub>ri</sub>| &le; &epsilon;</code>.</li>
<li>Again, try first with higher allowed deviation, then reduce &epsilon; step by step.</li>
<li>Last, check your solution in a diagram. If you are satisfied, you have found a good guess for the parameters.</li>
</ul>
<p><strong>Note</strong>: It is possible to neglect the potential decline of the relative permeabilty near the origin and keep <code>&chi;<sub>C</sub> = 0</code>.</p>
</html>"));
end ParameterFit;
