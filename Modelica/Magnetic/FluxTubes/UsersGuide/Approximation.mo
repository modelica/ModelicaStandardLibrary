within Modelica.Magnetic.FluxTubes.UsersGuide;
model Approximation "Approximation formulae"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<p>
In literature a lot of functions have been discussed for approximation of magnetization characteristics: 
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Fischer1956] Fischer and Moser</a><br> 
In the FluxTubes library it is possible to choose between different approximation functions.<br>
Originally, the formula of <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Ro00] Roschke</a> has been implemented:
</p>
<pre><code>
            &micro;<sub>ri</sub> - 1 + c<sub>a</sub>&sdot;B<sub>N</sub>
&micro;<sub>r</sub>(B) = 1 + ---------------
            1 + c<sub>b</sub>&sdot;B<sub>N</sub> + B<sub>N</sub><sup>n</sup>
     |B|
B<sub>N</sub> = -----
     B<sub>&micro;Max</sub>
</code></pre>
<p>
<code>B<sub>&micro;Max</sub></code> is the flux density where the maximum of <code>&micro;<sub>r</sub></code> appears.<br>
<code>&micro;<sub>ri</sub></code> is the relative permeability at the origin.<br>
The other parameters <code>c<sub>a</sub>, c<sub>b</sub>, n</code> have to be determined to achieve a best fit of given data.<br>
Note, this formula takes into account the rise of the relative permeability <code>&micro;<sub>r</sub></code> to a maximum at B<sub>&micro;Max</sub>.
</p>
<p>
Additionally, an approximation using SSEE <a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[deBoor2001] Smoothing Splines </a> with 
<a href=\"modelica://Modelica.Magnetic.FluxTubes.UsersGuide.Literature\">[Rao2015] Exponential Extrapolation </a> has been implemented:
</p>
<p>
For evaluating cubic splines, the interval <code>k</code> where the desired magnetic field strength <code>H</code> is enclosed has to be searched.
</p>
<pre><code>
J(H) = sign(H)&sdot;(JD<sub>k</sub> + c<sub>1k</sub>&dot;(|H| - HD<sub>k</sub>) + c<sub>2k</sub>&dot;(|H| - HD<sub>k</sub>)<sup>2</sup> + c<sub>3k</sub>&dot;(|H| - HD<sub>k</sub>)<sup>3</sup>
</code></pre>
<p>
Exponential Extrapolation is defined by the following formula:
</P>
<pre><code>
J(H) = sign(H)&sdot;JD<sub>k0</sub> + (J<sub>sat</sub> - JD<sub>k0</sub>)&sdot;(1 - exp(-(|H| - HD<sub>k0</sub>)/HD<sub>par</sub>))
</code></pre>
<p>
<code>k0</code> is the index in the array of raw data nodes from whoch on the exponential extrapolation is fitted. 
<code>H<sub>k0</sub>&asymp;2000 A/m</code> is a good start. 
</p>
<p>
In both cases, the derivatives with respect to <code>H</code> and therefore the relative differential permeability <code>&micro;<sub>rd</sub></code> can be calculated easily.
</p>
<p>
Since extrapolation based on splines often provides only poor results, a soft switch-over from Smoothing Splines to Exponential Extrapolation according to a 
linear formula between <code>hH<sub>1</sub>=5000 A/m</code> and <code>hH<sub>2</sub>=20000 A/m</code> is used.
</p>
<p>
Additonally, it is possible to implement an interpolation based on raw data stored in the <a href=\"modelica://Modelica.Magnetic.FluxTubes.Material.SoftMagnetic.SSEE\">data records for SSEE</a> instead of using approximation functions.
Be careful regarding the interpolation method, it could reveal undesired curvature between the nodes.
</p>
</html>"));
end Approximation;
